From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 3/3] git-gui: learn more type change states
Date: Thu,  9 Dec 2010 21:46:23 +0100
Message-ID: <ae3adad905c1d55d111dcdc3f231b1d85dca26d5.1291927374.git.bert.wesarg@googlemail.com>
References: <c373e73fb114ebc580c36bc494dc62f80a19ece9.1291927374.git.bert.wesarg@googlemail.com>
 <ab91f8f7447c20f518554c57c4f85483cab4ee2f.1291927374.git.bert.wesarg@googlemail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Gustaf Hendeby <hendeby@isy.liu.se>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Dec 09 21:46:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQnO6-0002Ww-R5
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 21:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756766Ab0LIUqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 15:46:35 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:41154 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756655Ab0LIUqe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 15:46:34 -0500
Received: by mail-fx0-f43.google.com with SMTP id 18so2914425fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 12:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=pCTyvjbYH17oHDh+cSsSrDJzn8qsJBKrtWBaQmKFktU=;
        b=kPRRtah8JtSzljyLQulW3oxb2Vw5rugpFC35gRlTCVCW+kDc/GX6/acL8CjhC6YxZ0
         sZNAE/kDo1DnZFL/V7YVO9siSG6FIpXiEDdE7HjyA+rl/HKLjkutQ2Sw+aARbvI6pQr2
         XrVguHDw4i4eaGQVauOWFtmNgCIPyBYCMMb58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=itwKjGtCdqHzrADWxOLShdxEySPUsrZsiI+EtWzq8HKJ1rAuZf6fxNvibjvBv/O7yB
         XmLiYLSaF7gx7cP5vm2KACezR0y5J8GMLfoXtQmbLkjJacgtG/MaSY8+lFTBXEB4a5v/
         u4KsZWjxo4txsqGz6dZ2QqCP/h4Fv7uLDAu+o=
Received: by 10.223.120.193 with SMTP id e1mr71377far.106.1291927593795;
        Thu, 09 Dec 2010 12:46:33 -0800 (PST)
Received: from localhost (p3E990761.dip.t-dialin.net [62.153.7.97])
        by mx.google.com with ESMTPS id w12sm692199fah.18.2010.12.09.12.46.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 12:46:32 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1200.ge4bf6
In-Reply-To: <ab91f8f7447c20f518554c57c4f85483cab4ee2f.1291927374.git.bert.wesarg@googlemail.com>
In-Reply-To: <c373e73fb114ebc580c36bc494dc62f80a19ece9.1291927374.git.bert.wesarg@googlemail.com>
References: <c373e73fb114ebc580c36bc494dc62f80a19ece9.1291927374.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163312>

Support the following states with type change in git-gui: AT, MT, TD, TM

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

Cc: Gustaf Hendeby <hendeby@isy.liu.se>
---
 git-gui.sh     |    8 ++++++--
 lib/commit.tcl |    6 +++++-
 lib/index.tcl  |   10 ++++++++--
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 3ef9129..f50a5fc 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1993,7 +1993,11 @@ foreach i {
 		{MD {mc "Staged for commit, missing"}}
 
 		{_T {mc "File type changed, not staged"}}
+		{MT {mc "File type changed, old type staged for commit"}}
+		{AT {mc "File type changed, old type staged for commit"}}
 		{T_ {mc "File type changed, staged"}}
+		{TM {mc "File type change staged, modification not staged"}}
+		{TD {mc "File type change staged, file missing"}}
 
 		{_O {mc "Untracked, not staged"}}
 		{A_ {mc "Staged for commit"}}
@@ -3535,8 +3539,8 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
 			|| $current_diff_path eq {}
 			|| {__} eq $state
 			|| {_O} eq $state
-			|| {_T} eq $state
-			|| {T_} eq $state
+			|| [string match {?T} $state]
+			|| [string match {T?} $state]
 			|| [has_textconv $current_diff_path]} {
 			set s disabled
 		} else {
diff --git a/lib/commit.tcl b/lib/commit.tcl
index 83b3d9d..5ce4687 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -166,7 +166,7 @@ The rescan will be automatically started now.
 		_? {continue}
 		A? -
 		D? -
-		T_ -
+		T? -
 		M? {set files_ready 1}
 		_U -
 		U? {
@@ -453,7 +453,11 @@ A rescan will be automatically started now.
 		}
 		AM -
 		AD -
+		AT -
+		TM -
+		TD -
 		MM -
+		MT -
 		MD {
 			set file_states($path) [list \
 				_[string index $m 1] \
diff --git a/lib/index.tcl b/lib/index.tcl
index e9db0c4..5d7bbf2 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -103,8 +103,11 @@ proc write_update_indexinfo {fd pathList totalCnt batch after} {
 		set s $file_states($path)
 		switch -glob -- [lindex $s 0] {
 		A? {set new _O}
-		M? {set new _M}
+		MT -
+		TM -
 		T_ {set new _T}
+		M? {set new _M}
+		TD -
 		D_ {set new _D}
 		D? {set new _?}
 		?? {continue}
@@ -167,7 +170,10 @@ proc write_update_index {fd pathList totalCnt batch after} {
 		AD {set new __}
 		?D {set new D_}
 		_O -
+		AT -
 		AM {set new A_}
+		TM -
+		MT -
 		_T {set new T_}
 		_U -
 		U? {
@@ -261,7 +267,7 @@ proc unstage_helper {txt paths} {
 		switch -glob -- [lindex $file_states($path) 0] {
 		A? -
 		M? -
-		T_ -
+		T? -
 		D? {
 			lappend pathList $path
 			if {$path eq $current_diff_path} {
-- 
1.7.3.2.1200.ge4bf6
