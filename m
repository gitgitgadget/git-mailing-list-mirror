From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 08/14] difftool/mergetool: add diffuse as merge and diff tool
Date: Mon,  6 Apr 2009 01:31:23 -0700
Message-ID: <1239006689-14695-9-git-send-email-davvid@gmail.com>
References: <1239006689-14695-1-git-send-email-davvid@gmail.com>
 <1239006689-14695-2-git-send-email-davvid@gmail.com>
 <1239006689-14695-3-git-send-email-davvid@gmail.com>
 <1239006689-14695-4-git-send-email-davvid@gmail.com>
 <1239006689-14695-5-git-send-email-davvid@gmail.com>
 <1239006689-14695-6-git-send-email-davvid@gmail.com>
 <1239006689-14695-7-git-send-email-davvid@gmail.com>
 <1239006689-14695-8-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de,
	Sebastian Pipping <sebastian@pipping.org>,
	David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 06 10:35:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqkIH-0002l9-OE
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 10:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbZDFIcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 04:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754646AbZDFIcF
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 04:32:05 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:12597 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884AbZDFIcA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 04:32:00 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1642070wah.21
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 01:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fxjP3Sqxd+U5S7GnuLcgNjiVap8qoTbb9WqlLEW2bng=;
        b=IHVFCaO42M3N4KBJqQE69KJR/g6eSvL2TR3pj0SK0vgpPT1rgnekbPnZWID1nwQx4m
         1zTi8XuuqIcrxlXbqwrlBZjg6LUy8bmRosrPXg7sRr4z8a3sx0IZer+U+eeyOEj4CxS/
         Weal9niZEFzJhJIDlKqWFOdXHDMeTTOWXckLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=M/Scr9nstZO0qeV3vq5h4sGIQhY+hRoKMVwH8E6ySiLEoFJ4p0P+TAZ+CM+Py8YFzU
         EyT/HuplwiEnOUkn+PE9/6O1NOUttePTey3+W8nuRF5SJi9azuTRB1y0SeMOmE9xydFH
         gLFekFPcm07W76MMIpnbGBf9Wx9B5f/gMTp0M=
Received: by 10.115.33.1 with SMTP id l1mr2148002waj.168.1239006719314;
        Mon, 06 Apr 2009 01:31:59 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m30sm5181132wag.47.2009.04.06.01.31.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Apr 2009 01:31:58 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.414.g81aa9
In-Reply-To: <1239006689-14695-8-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115788>

From: Sebastian Pipping <sebastian@pipping.org>

This adds diffuse as a built-in merge tool.

Signed-off-by: Sebastian Pipping <sebastian@pipping.org>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/git-mergetool.txt        |    2 +-
 Documentation/merge-config.txt         |    2 +-
 contrib/completion/git-completion.bash |    3 ++-
 contrib/difftool/git-difftool-helper   |   10 ++++++----
 contrib/difftool/git-difftool.txt      |    4 ++--
 git-mergetool.sh                       |    4 ++--
 6 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 5edac4d..ff9700d 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -27,7 +27,7 @@ OPTIONS
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
 	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge,
-	tortoisemerge and opendiff
+	diffuse, tortoisemerge and opendiff
 +
 If a merge resolution program is not specified, 'git-mergetool'
 will use the configuration variable `merge.tool`.  If the
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 8c10f66..4832bc7 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -23,7 +23,7 @@ merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
 	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff",
-	"ecmerge", tortoisemerge and
+	"diffuse", "ecmerge", "tortoisemerge", and
 	"opendiff".  Any other value is treated is custom merge tool
 	and there must be a corresponding mergetool.<tool>.cmd option.
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e72ce24..4fcd77a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1173,7 +1173,8 @@ _git_mergetool ()
 	--tool=*)
 		__gitcomp "
 			kdiff3 tkdiff meld xxdiff emerge
-			vimdiff gvimdiff ecmerge opendiff
+			vimdiff gvimdiff ecmerge diffuse
+			opendiff
 			" "" "${cur##--tool=}"
 		return
 		;;
diff --git a/contrib/difftool/git-difftool-helper b/contrib/difftool/git-difftool-helper
index e74a274..4b0daec 100755
--- a/contrib/difftool/git-difftool-helper
+++ b/contrib/difftool/git-difftool-helper
@@ -1,7 +1,5 @@
 #!/bin/sh
 # git-difftool-helper is a GIT_EXTERNAL_DIFF-compatible diff tool launcher.
-# It supports kdiff3, kompare, tkdiff, xxdiff, meld, opendiff,
-# emerge, ecmerge, vimdiff, gvimdiff, and custom user-configurable tools.
 # This script is typically launched by using the 'git difftool'
 # convenience command.
 #
@@ -55,6 +53,10 @@ launch_merge_tool () {
 		"$merge_tool_path" "$LOCAL" "$REMOTE"
 		;;
 
+	diffuse)
+		"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
+		;;
+
 	vimdiff)
 		"$merge_tool_path" -d -c "wincmd l" "$LOCAL" "$REMOTE"
 		;;
@@ -164,9 +166,9 @@ if test -z "$merge_tool"; then
 	if test -n "$DISPLAY"; then
 		# If gnome then prefer meld, otherwise, prefer kdiff3 or kompare
 		if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
-			merge_tool_candidates="meld kdiff3 kompare tkdiff xxdiff gvimdiff"
+			merge_tool_candidates="meld kdiff3 kompare tkdiff xxdiff gvimdiff diffuse"
 		else
-			merge_tool_candidates="kdiff3 kompare tkdiff xxdiff meld gvimdiff"
+			merge_tool_candidates="kdiff3 kompare tkdiff xxdiff meld gvimdiff diffuse"
 		fi
 	fi
 	if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
diff --git a/contrib/difftool/git-difftool.txt b/contrib/difftool/git-difftool.txt
index 4dff529..a2fa474 100644
--- a/contrib/difftool/git-difftool.txt
+++ b/contrib/difftool/git-difftool.txt
@@ -25,8 +25,8 @@ OPTIONS
 --tool=<tool>::
 	Use the diff tool specified by <tool>.
 	Valid merge tools are:
-	kdiff3, kompare, tkdiff, meld, xxdiff, emerge,
-	vimdiff, gvimdiff, ecmerge, and opendiff
+	kdiff3, kompare, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff,
+	ecmerge, diffuse and opendiff
 +
 If a diff tool is not specified, 'git-difftool'
 will use the configuration variable `diff.tool`.  If the
diff --git a/git-mergetool.sh b/git-mergetool.sh
index be9717a..b4d2432 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -414,9 +414,9 @@ fi
 if test -z "$merge_tool" ; then
     if test -n "$DISPLAY"; then
         if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
-            merge_tool_candidates="meld kdiff3 tkdiff xxdiff tortoisemerge gvimdiff"
+            merge_tool_candidates="meld kdiff3 tkdiff xxdiff tortoisemerge gvimdiff diffuse"
         else
-            merge_tool_candidates="kdiff3 tkdiff xxdiff meld tortoisemerge gvimdiff"
+            merge_tool_candidates="kdiff3 tkdiff xxdiff meld tortoisemerge gvimdiff diffuse"
         fi
     fi
     if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
-- 
1.6.2.2.414.g81aa9
