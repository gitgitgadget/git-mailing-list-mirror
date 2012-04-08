From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 12/12] completion: rename _git and _gitk
Date: Sun,  8 Apr 2012 06:07:59 +0300
Message-ID: <1333854479-23260-13-git-send-email-felipe.contreras@gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 08 05:09:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGiV9-0007HT-A3
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 05:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649Ab2DHDI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 23:08:58 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53218 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754377Ab2DHDIm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Apr 2012 23:08:42 -0400
Received: by mail-lpp01m010-f46.google.com with SMTP id j13so2813271lah.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 20:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ntRt8BWthz1qxzWsgO+BC1Xr1CanIlf+FG8JSjkr9HQ=;
        b=TUFO3aHViOFG3hUvFCzWoDAsUkmMl4JG33DQZC3aynL4W/6kTd2O6APfRJmAQJ7uaY
         S/NMTv8BdGPIGcxO6Q67K3ODChP9WRV/QloX2SRxBDe9TI5Zwr0qQj/bL+7eIqvA9G+q
         feZCX7ehEdarBhhOfImO6sJglhlBBjkJas82YXlKUfCew4ne9AUP0rIlLUeFIeTLkKKU
         07G4pg7Re6xtm5ajXfQyELWz1eaaiO2wF6CKzTG1Lf+V78OfDJllSUtl4tVCcWkm0zCR
         N+ab1Q5C6Do3x/CYg3WvI5iKt6OvTbiZgVgmfagz6Tml3t+EPf6U4i2bqAbOlfRv9H5n
         Hp0g==
Received: by 10.152.132.166 with SMTP id ov6mr4861721lab.35.1333854522098;
        Sat, 07 Apr 2012 20:08:42 -0700 (PDT)
Received: from localhost (84-231-195-184.elisa-mobile.fi. [84.231.195.184])
        by mx.google.com with ESMTPS id fe6sm5313550lbb.9.2012.04.07.20.08.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Apr 2012 20:08:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.3.g5a738d
In-Reply-To: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194962>

Would be helpful to reuse these for zsh completion; it uses _git, and it
cannot be changed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    8 ++++----
 t/t9902-completion.sh                  |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6cf1d98..7d663f7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2612,7 +2612,7 @@ _git_whatchanged ()
 	_git_log
 }
 
-_git ()
+_main_git ()
 {
 	local i c=1 cmd cmd_pos __git_dir
 
@@ -2666,7 +2666,7 @@ _git ()
 	fi
 }
 
-_gitk ()
+_main_gitk ()
 {
 	__git_has_doubledash && return
 
@@ -2710,7 +2710,7 @@ foo_wrap ()
 
 git_complete ()
 {
-	local name="${2-$1}"
+	local name="${2-main_$1}"
 	local cmd="${name#git_}"
 	eval "$(typeset -f foo_wrap | sed -e "s/foo_cmd/$cmd/" -e "s/foo/_$name/")"
 	complete -o bashdefault -o default -o nospace -F _${name}_wrap $1 2>/dev/null \
@@ -2725,5 +2725,5 @@ git_complete gitk
 # included the '.exe' suffix.
 #
 if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
-git_complete git.exe git
+git_complete git.exe main_git
 fi
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 6c61e7a..ef1323f 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -57,7 +57,7 @@ test_completion ()
 	local _cword wrap
 	_words=( $1 )
 	test $# -gt 1 && echo "$2" > expected
-	wrap="${3-_git_wrap}"
+	wrap="${3-_main_git_wrap}"
 	(( _cword = ${#_words[@]} - 1 ))
 	$wrap && print_comp &&
 	test_cmp expected out
-- 
1.7.10.3.g5a738d
