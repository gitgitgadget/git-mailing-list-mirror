From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] Fix translation of strings in foreach lists.
Date: Tue, 24 Jul 2007 11:27:01 +0200
Message-ID: <20070724112701.ndpm5fxaocks804s@webmail.tu-harburg.de>
References: <1282.25717.qm@web38901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 8BIT
To: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 11:27:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDGfl-0002CQ-EZ
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 11:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762560AbXGXJ1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 05:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762374AbXGXJ1N
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 05:27:13 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:43452 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760621AbXGXJ1M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 05:27:12 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6O9R26b010568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 24 Jul 2007 11:27:02 +0200
Received: from webmail.tu-harburg.de (ocs3.rz.tu-harburg.de [134.28.202.66])
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6O9R2NU014186;
	Tue, 24 Jul 2007 11:27:02 +0200
Received: by webmail.tu-harburg.de (Postfix, from userid 1001)
	id 0DB3DE50349; Tue, 24 Jul 2007 11:27:01 +0200 (CEST)
Received: from hansjoerg.sick.de (hansjoerg.sick.de [62.180.123.245]) by
	webmail.tu-harburg.de (Horde MIME library) with HTTP; Tue, 24 Jul 2007
	11:27:01 +0200
In-Reply-To: <1282.25717.qm@web38901.mail.mud.yahoo.com>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53544>

Fix translation of strings in foreach lists.

Signed-off-by: Christian Stimming <stimming@tuhh.de>
---
Quoting Brett Schwarz <brett_schwarz@yahoo.com>:
> I not sure if it's worth changing, but you don't necessarily need   
> those [append]'s in there.

Thanks for the info. It is basically up to Shawn to decide which style  
he likes more.

This patch is already necessary because I accidentally messed up the  
foreach argument lists. With this patch those will work again and will  
additionally be translated as well. (Unfortunately, I can't commit to  
git-gui-i18n ATM due to a http-only-firewall connection. Johannes...?  
Thanks.)

  lib/database.tcl |   16 ++++++++--------
  lib/option.tcl   |   26 +++++++++++++-------------
  2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/lib/database.tcl b/lib/database.tcl
index 8dda9af..118b1b2 100644
--- a/lib/database.tcl
+++ b/lib/database.tcl
@@ -40,16 +40,16 @@ proc do_stats {} {

  	frame $w.stat -borderwidth 1 -relief solid
  	foreach s {
-		{count           [mc "Number of loose objects"]}
-		{size            [mc "Disk space used by loose objects"] { KiB}}
-		{in-pack         [mc "Number of packed objects"]}
-		{packs           [mc "Number of packs"]}
-		{size-pack       [mc "Disk space used by packed objects"] { KiB}}
-		{prune-packable  [mc "Packed objects waiting for pruning"]}
-		{garbage         [mc "Garbage files"]}
+		{count           {mc "Number of loose objects"}}
+		{size            {mc "Disk space used by loose objects"} { KiB}}
+		{in-pack         {mc "Number of packed objects"}}
+		{packs           {mc "Number of packs"}}
+		{size-pack       {mc "Disk space used by packed objects"} { KiB}}
+		{prune-packable  {mc "Packed objects waiting for pruning"}}
+		{garbage         {mc "Garbage files"}}
  		} {
  		set name [lindex $s 0]
-		set label [lindex $s 1]
+		set label [eval [lindex $s 1]]
  		if {[catch {set value $stats($name)}]} continue
  		if {[llength $s] > 2} {
  			set value "$value[lindex $s 2]"
diff --git a/lib/option.tcl b/lib/option.tcl
index 6c4d7ae..8d9e09d 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -183,22 +183,22 @@ proc do_options {} {

  	set optid 0
  	foreach option {
-		{t user.name [mc "User Name"]}
-		{t user.email [mc "Email Address"]}
-
-		{b merge.summary [mc "Summarize Merge Commits"]}
-		{i-1..5 merge.verbosity [mc "Merge Verbosity"]}
-		{b merge.diffstat [mc "Show Diffstat After Merge"]}
-
-		{b gui.trustmtime  [mc "Trust File Modification Timestamps"]}
-		{b gui.pruneduringfetch [mc "Prune Tracking Branches During Fetch"]}
-		{b gui.matchtrackingbranch [mc "Match Tracking Branches"]}
-		{i-0..99 gui.diffcontext [mc "Number of Diff Context Lines"]}
-		{t gui.newbranchtemplate [mc "New Branch Name Template"]}
+		{t user.name {mc "User Name"}}
+		{t user.email {mc "Email Address"}}
+
+		{b merge.summary {mc "Summarize Merge Commits"}}
+		{i-1..5 merge.verbosity {mc "Merge Verbosity"}}
+		{b merge.diffstat {mc "Show Diffstat After Merge"}}
+
+		{b gui.trustmtime  {mc "Trust File Modification Timestamps"}}
+		{b gui.pruneduringfetch {mc "Prune Tracking Branches During Fetch"}}
+		{b gui.matchtrackingbranch {mc "Match Tracking Branches"}}
+		{i-0..99 gui.diffcontext {mc "Number of Diff Context Lines"}}
+		{t gui.newbranchtemplate {mc "New Branch Name Template"}}
  		} {
  		set type [lindex $option 0]
  		set name [lindex $option 1]
-		set text [lindex $option 2]
+		set text [eval [lindex $option 2]]
  		incr optid
  		foreach f {repo global} {
  			switch -glob -- $type {
-- 
1.5.3.rc2.12.gbc280
