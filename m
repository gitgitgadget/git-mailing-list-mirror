From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] git-gui wording suggestions
Date: Thu, 26 Jul 2007 11:19:02 +0200
Message-ID: <20070726111902.xqkxcdlsbo8w4c8k@webmail.tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 11:19:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDzV5-000057-PM
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 11:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758164AbXGZJTM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 05:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757566AbXGZJTL
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 05:19:11 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:57573 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754649AbXGZJTJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2007 05:19:09 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6Q9J2l4006144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 26 Jul 2007 11:19:03 +0200
Received: from webmail.tu-harburg.de (ocs3.rz.tu-harburg.de [134.28.202.66])
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6Q9J2qr009035;
	Thu, 26 Jul 2007 11:19:02 +0200
Received: by webmail.tu-harburg.de (Postfix, from userid 1001)
	id A2879E50349; Thu, 26 Jul 2007 11:19:02 +0200 (CEST)
Received: from hansjoerg.sick.de (hansjoerg.sick.de [62.180.123.245]) by
	webmail.tu-harburg.de (Horde MIME library) with HTTP; Thu, 26 Jul 2007
	11:19:02 +0200
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53812>

Unifiy wording to say "to stage" instead of "to add" always.

Currently, there is a mixup of saying "staged changes" vs. "added  
changes" in the git-gui program. You obviously decided to say "staging  
area" instead of "index", hence "add to staging area"/"stage" instead  
of "add to index".  I think this change is very good. Talking about  
the "staging area" explains the nature of this thingy much better and  
much more unambiguous than "index".  Actually only after reading the  
wording "staging area" I eventually understood what this "index" thing  
is about... (Also, your chosen wording helps for creating a nice and  
consistent translation of that, but that's only an added bonus.)

With this patch I'd propose to talk every only about "stage" instead  
of "add". IMHO that's just the logical conclusion of the above wording  
decision. What do you think?

---
  git-gui.sh          |    6 +++---
  lib/checkout_op.tcl |    2 +-
  lib/commit.tcl      |    4 ++--
  lib/index.tcl       |    2 +-
  lib/merge.tcl       |    2 +-
  5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 3536d38..fd8b4b4 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1824,12 +1824,12 @@ if {[is_enabled multicommit] || [is_enabled  
singlecommit]} {
  	lappend disable_on_lock \
  		[list .mbar.commit entryconf [.mbar.commit index last] -state]

-	.mbar.commit add command -label [mc "Add To Commit"] \
+	.mbar.commit add command -label [mc "Stage To Commit"] \
  		-command do_add_selection
  	lappend disable_on_lock \
  		[list .mbar.commit entryconf [.mbar.commit index last] -state]

-	.mbar.commit add command -label [mc "Add Existing To Commit"] \
+	.mbar.commit add command -label [mc "Stage Changed Files To Commit"] \
  		-command do_add_all \
  		-accelerator $M1T-I
  	lappend disable_on_lock \
@@ -2180,7 +2180,7 @@ pack .vpane.lower.commarea.buttons.rescan -side  
top -fill x
  lappend disable_on_lock \
  	{.vpane.lower.commarea.buttons.rescan conf -state}

-button .vpane.lower.commarea.buttons.incall -text [mc "Add Existing"] \
+button .vpane.lower.commarea.buttons.incall -text [mc "Stage Changed"] \
  	-command do_add_all
  pack .vpane.lower.commarea.buttons.incall -side top -fill x
  lappend disable_on_lock \
diff --git a/lib/checkout_op.tcl b/lib/checkout_op.tcl
index 25bf9cf..a2f2509 100644
--- a/lib/checkout_op.tcl
+++ b/lib/checkout_op.tcl
@@ -247,7 +247,7 @@ method _checkout {} {
  	if {[lock_index checkout_op]} {
  		after idle [cb _start_checkout]
  	} else {
-		_error $this [mc "Index is already locked."]
+		_error $this [mc "Staging area (index) is already locked."]
  		delete_this
  	}
  }
diff --git a/lib/commit.tcl b/lib/commit.tcl
index f60b11e..aa9110d 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -153,7 +153,7 @@ The rescan will be automatically started now.
  		U? {
  			error_popup [mc "Unmerged files cannot be committed.

-File %s has merge conflicts.  You must resolve them and add the file  
before committing.
+File %s has merge conflicts.  You must resolve them and stage the  
file before committing.
  " [short_path $path]]
  			unlock_index
  			return
@@ -169,7 +169,7 @@ File %s cannot be committed by this program.
  	if {!$files_ready && ![string match *merge $curType]} {
  		info_popup [mc "No changes to commit.

-You must add at least 1 file before you can commit.
+You must stage at least 1 file before you can commit.
  "]
  		unlock_index
  		return
diff --git a/lib/index.tcl b/lib/index.tcl
index 38aa6ee..e91b864 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -367,7 +367,7 @@ proc revert_helper {txt paths} {
  		"[appname] ([reponame])" \
  		[mc "%s

-Any unadded changes will be permanently lost by the revert." $query] \
+Any unstaged changes will be permanently lost by the revert." $query] \
  		question \
  		1 \
  		[mc "Do Nothing"] \
diff --git a/lib/merge.tcl b/lib/merge.tcl
index 40e82a9..a6e8cc9 100644
--- a/lib/merge.tcl
+++ b/lib/merge.tcl
@@ -46,7 +46,7 @@ The rescan will be automatically started now.

  File %s has merge conflicts.

-You must resolve them, add the file, and commit to complete the  
current merge.  Only then can you begin another merge.
+You must resolve them, stage the file, and commit to complete the  
current merge.  Only then can you begin another merge.
  " [short_path $path]]
  			unlock_index
  			return 0
-- 
1.5.3.rc2.12.gbc280
