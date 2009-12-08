From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] mergetool--lib: add diffmerge as a pre-configured mergetool option
Date: Tue,  8 Dec 2009 12:01:17 -0800
Message-ID: <1260302477-49412-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 21:01:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI6Ff-0002PF-HH
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 21:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965928AbZLHUB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 15:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965890AbZLHUB1
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 15:01:27 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:47207 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266AbZLHUB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 15:01:26 -0500
Received: by yxe17 with SMTP id 17so5238044yxe.33
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 12:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=rBGtzXqPjWh5I1uWkmLF2fi5c0SiJ06YUlSEmJ8MmUM=;
        b=w+gnahKqWJ8MW5oMfHp5mfaYllGJWPbGyfaMCx6AyxqJwGrS4r0wG0o3g0DiYWG1+9
         Pp9hpErNwMr1a6KyPDvHZY5CcX5ma+tJ7NZBmeamSENId6Kjp+wsc6Ru3vPwsZe1qoEu
         n60W/g1a2vdO8HVOhqv/MURAl3SrPUmZQSS/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ZSSjR4cHv7awvhlKm12dnTYQngNHWbTeZX4a+j5HVuPH1ZjdcNxb9NyNtf/mCigcVI
         v7gVENj8g8BNtPvPvk/kHdTaFCaRMe0mP9+g2kMRP7ByHnwUsJEaK8Ng56TNfYBg36FG
         svDmqgpPO0Dq49vn5lamgDa4LYBaDmREYglLo=
Received: by 10.101.163.1 with SMTP id q1mr661733ano.67.1260302492439;
        Tue, 08 Dec 2009 12:01:32 -0800 (PST)
Received: from localhost (173-13-134-217-sfba.hfc.comcastbusiness.net [173.13.134.217])
        by mx.google.com with ESMTPS id 34sm3148884yxf.29.2009.12.08.12.01.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Dec 2009 12:01:31 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc1.296.ge77fc.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134906>

Add SourceGear DiffMerge to the set of built-in diff/merge tools, and update
bash completion and documentation.
---
 Documentation/git-difftool.txt         |    2 +-
 Documentation/git-mergetool.txt        |    2 +-
 Documentation/merge-config.txt         |    4 ++--
 contrib/completion/git-completion.bash |    2 +-
 git-mergetool--lib.sh                  |   22 ++++++++++++++++++++--
 5 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 8e9aed6..28178da 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -31,7 +31,7 @@ OPTIONS
 	Use the diff tool specified by <tool>.
 	Valid merge tools are:
 	kdiff3, kompare, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff,
-	ecmerge, diffuse, opendiff, p4merge and araxis.
+	ecmerge, diffuse, opendiff, p4merge, araxis and diffmerge.
 +
 If a diff tool is not specified, 'git-difftool'
 will use the configuration variable `diff.tool`.  If the
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 4a6f7f3..7f00269 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -27,7 +27,7 @@ OPTIONS
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
 	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge,
-	diffuse, tortoisemerge, opendiff, p4merge and araxis.
+	diffuse, tortoisemerge, opendiff, p4merge, araxis and diffmerge.
 +
 If a merge resolution program is not specified, 'git-mergetool'
 will use the configuration variable `merge.tool`.  If the
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index a403155..a68a205 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -23,8 +23,8 @@ merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
 	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff",
-	"diffuse", "ecmerge", "tortoisemerge", "p4merge", "araxis" and
-	"opendiff".  Any other value is treated is custom merge tool
+	"diffuse", "ecmerge", "tortoisemerge", "p4merge", "araxis", "opendiff"
+	and "diffmerge".  Any other value is treated is custom merge tool
 	and there must be a corresponding mergetool.<tool>.cmd option.
 
 merge.verbosity::
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7c18b0c..5cc5ee7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -975,7 +975,7 @@ _git_diff ()
 }
 
 __git_mergetools_common="diffuse ecmerge emerge kdiff3 meld opendiff
-			tkdiff vimdiff gvimdiff xxdiff araxis p4merge
+			tkdiff vimdiff gvimdiff xxdiff araxis p4merge diffmerge
 "
 
 _git_difftool ()
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 5b62785..5b29fef 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -46,7 +46,8 @@ check_unchanged () {
 valid_tool () {
 	case "$1" in
 	kdiff3 | tkdiff | xxdiff | meld | opendiff | \
-	emerge | vimdiff | gvimdiff | ecmerge | diffuse | araxis | p4merge)
+	emerge | vimdiff | gvimdiff | ecmerge | diffuse | araxis | p4merge | \
+	diffmerge)
 		;; # happy
 	tortoisemerge)
 		if ! merge_mode; then
@@ -297,6 +298,23 @@ run_merge_tool () {
 				>/dev/null 2>&1
 		fi
 		;;
+	diffmerge)
+		if merge_mode; then
+			if $base_present; then
+				"$merge_tool_path" -nosplash -merge -result="$MERGED" \
+					"$LOCAL" "$BASE" "$REMOTE"
+					>/dev/null 2>&1
+			else
+				"$merge_tool_path" -nosplash -merge \
+					"$LOCAL" "$MERGED" "$REMOTE"
+					>/dev/null 2>&1
+			fi
+			status=$?
+		else
+			"$merge_tool_path" -nosplash "$LOCAL" "$REMOTE" \
+				>/dev/null 2>&1
+		fi
+		;;
 	*)
 		merge_tool_cmd="$(get_merge_tool_cmd "$1")"
 		if test -z "$merge_tool_cmd"; then
@@ -336,7 +354,7 @@ guess_merge_tool () {
 		else
 			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
 		fi
-		tools="$tools gvimdiff diffuse ecmerge p4merge araxis"
+		tools="$tools gvimdiff diffuse ecmerge p4merge araxis diffmerge"
 	fi
 	case "${VISUAL:-$EDITOR}" in
 	*vim*)
-- 
1.6.6.rc1.296.ge77fc.dirty
