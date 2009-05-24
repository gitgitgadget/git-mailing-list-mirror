From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] mergetool--lib: add support for araxis merge
Date: Sun, 24 May 2009 00:24:41 +0000 (UTC)
Message-ID: <1243272220-40471-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, markus.heidelberg@web.de, snowcoder@gmail.com,
	spearce@spearce.org, Johannes.Schindelin@gmx.de,
	charles@hashpling.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun May 24 02:24:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M81Vw-0007yR-QW
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 02:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890AbZEXAYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 20:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753605AbZEXAYV
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 20:24:21 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:56530 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582AbZEXAYU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 20:24:20 -0400
Received: by pxi1 with SMTP id 1so1957418pxi.33
        for <git@vger.kernel.org>; Sat, 23 May 2009 17:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=TuXw/SMgpacArlRvAEHKZUq0t+MXCBLKzfoB7b5Q+44=;
        b=oVOde1FvLVOMCeAmK/0fepEh1m7ZLkzoPIxmTQNaY/JPCprfS/QYsGS0e35nB9MOIV
         RaXO0wqCtvstEPdGKyg5hD8pjVSYnmacbfbQOfTjeRiF6Fi6e8ZAxO0WcSkdxLw2vYYb
         S6jo2LJbVpy1AlBZ//ysIWvV1W2hGY3rtrJIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=rolOhEpKgbb6mJcMCzZ0jE18SoK9ykyPUybsOcmG+g1VvXvr9eRxy6eI1x3BleARl4
         OHJWu4xMmgGRDfxlyKCZ7x0SgV0fAc7XGzSKymiyEciw8xJxHkbz+p4MNk2y3agnXJOq
         1s2Jst68Fgif09EKUE562VBzBkUTy3+lH0wLY=
Received: by 10.114.157.11 with SMTP id f11mr11352553wae.75.1243124661365;
        Sat, 23 May 2009 17:24:21 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m28sm4039087waf.2.2009.05.23.17.24.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 May 2009 17:24:21 -0700 (PDT)
Date: Mon, 25 May 2009 10:23:40 -0700
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119806>

Araxis merge is now a built-in diff/merge tool.
This adds araxis to git-completion and updates
the documentation to mention araxis.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

Markus noticed that we forgot to touch "$BACKUP" so this is v2.

 Documentation/git-difftool.txt         |    2 +-
 Documentation/git-mergetool.txt        |    2 +-
 Documentation/merge-config.txt         |    2 +-
 contrib/completion/git-completion.bash |    2 +-
 git-mergetool--lib.sh                  |   25 +++++++++++++++++++++++--
 5 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 15b247b..96a6c51 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -31,7 +31,7 @@ OPTIONS
 	Use the diff tool specified by <tool>.
 	Valid merge tools are:
 	kdiff3, kompare, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff,
-	ecmerge, diffuse and opendiff
+	ecmerge, diffuse, opendiff and araxis.
 +
 If a diff tool is not specified, 'git-difftool'
 will use the configuration variable `diff.tool`.  If the
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index ff9700d..68ed6c0 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -27,7 +27,7 @@ OPTIONS
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
 	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge,
-	diffuse, tortoisemerge and opendiff
+	diffuse, tortoisemerge, opendiff and araxis.
 +
 If a merge resolution program is not specified, 'git-mergetool'
 will use the configuration variable `merge.tool`.  If the
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 4832bc7..c0f96e7 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -23,7 +23,7 @@ merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
 	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff",
-	"diffuse", "ecmerge", "tortoisemerge", and
+	"diffuse", "ecmerge", "tortoisemerge", "araxis", and
 	"opendiff".  Any other value is treated is custom merge tool
 	and there must be a corresponding mergetool.<tool>.cmd option.
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1683e6d..ead530d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -911,7 +911,7 @@ _git_diff ()
 }
 
 __git_mergetools_common="diffuse ecmerge emerge kdiff3 meld opendiff
-			tkdiff vimdiff gvimdiff xxdiff
+			tkdiff vimdiff gvimdiff xxdiff araxis
 "
 
 _git_difftool ()
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 8b5e6a8..bfb01f7 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -18,6 +18,9 @@ translate_merge_tool_path () {
 	emerge)
 		echo emacs
 		;;
+	araxis)
+		echo compare
+		;;
 	*)
 		echo "$1"
 		;;
@@ -43,7 +46,7 @@ check_unchanged () {
 valid_tool () {
 	case "$1" in
 	kdiff3 | tkdiff | xxdiff | meld | opendiff | \
-	emerge | vimdiff | gvimdiff | ecmerge | diffuse)
+	emerge | vimdiff | gvimdiff | ecmerge | diffuse | araxis)
 		;; # happy
 	tortoisemerge)
 		if ! merge_mode; then
@@ -263,6 +266,24 @@ run_merge_tool () {
 			status=1
 		fi
 		;;
+	araxis)
+		if merge_mode; then
+			touch "$BACKUP"
+			if $base_present; then
+				"$merge_tool_path" -wait -merge -3 -a1 \
+					"$BASE" "$LOCAL" "$REMOTE" "$MERGED" \
+					>/dev/null 2>&1
+			else
+				"$merge_tool_path" -wait -2 \
+					"$LOCAL" "$REMOTE" "$MERGED" \
+					>/dev/null 2>&1
+			fi
+			check_unchanged
+		else
+			"$merge_tool_path" -wait -2 "$LOCAL" "$REMOTE" \
+				>/dev/null 2>&1
+		fi
+		;;
 	*)
 		merge_tool_cmd="$(get_merge_tool_cmd "$1")"
 		if test -z "$merge_tool_cmd"; then
@@ -302,7 +323,7 @@ guess_merge_tool () {
 		else
 			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
 		fi
-		tools="$tools gvimdiff diffuse ecmerge"
+		tools="$tools gvimdiff diffuse ecmerge araxis"
 	fi
 	if echo "${VISUAL:-$EDITOR}" | grep emacs > /dev/null 2>&1; then
 		# $EDITOR is emacs so add emerge as a candidate
-- 
1.6.3.1.145.gb74d77
