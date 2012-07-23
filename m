From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] mergetool: support --tool-help option like difftool does
Date: Mon, 23 Jul 2012 20:58:35 +0200
Message-ID: <500D9EDB.90603@gmail.com>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com> <500CFAE1.3070304@gmail.com> <7vr4s2mnir.fsf@alter.siamese.dyndns.org> <7vipdemm0a.fsf_-_@alter.siamese.dyndns.org> <500D9E5A.2000204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Jul 23 20:58:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StNqB-0008MX-6Y
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 20:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529Ab2GWS6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 14:58:42 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34700 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828Ab2GWS6l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 14:58:41 -0400
Received: by wibhq12 with SMTP id hq12so2758736wib.1
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 11:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=/guhd3TYtaxQgoyGOA1vK2rbnus523hqBdAvmfhWzWg=;
        b=n7R6/AywrOKbxx5Rmw2nvZLmEfQiCshY2gYbhCCflV4uC1DTuUINy1AsQE3Dk2T18i
         53fZmxiShPpCAOfSj2f0PDCOcTagp8wwOcdXWy/StfJAUaLldLRPsm+ISwbo3S0lfBef
         +pkrfouE0tM/p/9/AzPU57J7jVZTj5gQJf7QA/Fm9mHqrVG0fhRk7zX0XtnoWHhrhnY0
         iK+WTSR72G4E6gt1rEJufmw0DLxVulnVL3/OQ4YX+4w/8NooTKkuxA0+zwanJ+/z8xmO
         HWT1u4LfyQJjBSnc6zux+Qt14dN+jpap4FqzjvSfjduilkpDNwCx5vrTxSDRPevCJOX1
         2BdA==
Received: by 10.217.2.133 with SMTP id p5mr8859647wes.143.1343069920254;
        Mon, 23 Jul 2012 11:58:40 -0700 (PDT)
Received: from [192.168.178.22] (p5DDB0653.dip0.t-ipconnect.de. [93.219.6.83])
        by mx.google.com with ESMTPS id l5sm131657wix.5.2012.07.23.11.58.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 11:58:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <500D9E5A.2000204@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201962>

This way we do not have to risk the list of tools go out of sync
between the implementation and the documentation. Adjust the documentation
accordingly to not explicitly list the tools but refer to --tool-help.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/git-difftool.txt  |  7 ++++---
 Documentation/git-mergetool.txt |  8 ++++----
 git-mergetool--lib.sh           | 11 ++++++++++-
 git-mergetool.sh                | 42 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 31fc2e3..0bdfe35 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -36,9 +36,10 @@ OPTIONS
 
 -t <tool>::
 --tool=<tool>::
-	Use the diff tool specified by <tool>.  Valid values include
-	emerge, kompare, meld, and vimdiff. Run `git difftool --tool-help`
-	for the list of valid <tool> settings.
+	Use the diff tool specified by <tool>.
+
+--tool-help::
+	List all supported values for <tool>.
 +
 If a diff tool is not specified, 'git difftool'
 will use the configuration variable `diff.tool`.  If the
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 2a49de7..99e53b1 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -26,10 +26,10 @@ OPTIONS
 -------
 -t <tool>::
 --tool=<tool>::
-	Use the merge resolution program specified by <tool>.
-	Valid merge tools are:
-	araxis, bc3, diffuse, ecmerge, emerge, gvimdiff, kdiff3,
-	meld, opendiff, p4merge, tkdiff, tortoisemerge, vimdiff and xxdiff.
+	Use the merge tool specified by <tool>.
+
+--tool-help::
+	List all supported values for <tool>.
 +
 If a merge resolution program is not specified, 'git mergetool'
 will use the configuration variable `merge.tool`.  If the
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index ed630b2..f0865d4 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -111,15 +111,18 @@ run_merge_tool () {
 	return $status
 }
 
-guess_merge_tool () {
+list_merge_tool_candidates () {
+	# Add tools that can either do merging or diffing, but not both.
 	if merge_mode
 	then
 		tools="tortoisemerge"
 	else
 		tools="kompare"
 	fi
+
 	if test -n "$DISPLAY"
 	then
+		# Prefer GTK-based tools under Gnome.
 		if test -n "$GNOME_DESKTOP_SESSION_ID"
 		then
 			tools="meld opendiff kdiff3 tkdiff xxdiff $tools"
@@ -128,6 +131,8 @@ guess_merge_tool () {
 		fi
 		tools="$tools gvimdiff diffuse ecmerge p4merge araxis bc3"
 	fi
+
+	# Prefer vimdiff if vim is the default editor.
 	case "${VISUAL:-$EDITOR}" in
 	*vim*)
 		tools="$tools vimdiff emerge"
@@ -136,6 +141,10 @@ guess_merge_tool () {
 		tools="$tools emerge vimdiff"
 		;;
 	esac
+}
+
+guess_merge_tool () {
+	list_merge_tool_candidates
 	echo >&2 "merge tool candidates: $tools"
 
 	# Loop over each candidate and stop when a valid merge tool is found.
diff --git a/git-mergetool.sh b/git-mergetool.sh
index a9f23f7..0db0c44 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -8,7 +8,7 @@
 # at the discretion of Junio C Hamano.
 #
 
-USAGE='[--tool=tool] [-y|--no-prompt|--prompt] [file to merge] ...'
+USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 TOOL_MODE=merge
@@ -284,11 +284,51 @@ merge_file () {
     return 0
 }
 
+show_tool_help () {
+	TOOL_MODE=merge
+	list_merge_tool_candidates
+	unavailable= available= LF='
+'
+	for i in $tools
+	do
+		merge_tool_path=$(translate_merge_tool_path "$i")
+		if type "$merge_tool_path" >/dev/null 2>&1
+		then
+			available="$available$i$LF"
+		else
+			unavailable="$unavailable$i$LF"
+		fi
+	done
+	if test -n "$available"
+	then
+		echo "'git mergetool --tool=<tool>' may be set to one of the following:"
+		echo "$available" | sort | sed -e 's/^/	/'
+	else
+		echo "No suitable tool for 'git mergetool --tool=<tool>' found."
+	fi
+	if test -n "$unavailable"
+	then
+		echo
+		echo 'The following tools are valid, but not currently available:'
+		echo "$unavailable" | sort | sed -e 's/^/	/'
+	fi
+	if test -n "$unavailable$available"
+	then
+		echo
+		echo "Some of the tools listed above only work in a windowed"
+		echo "environment. If run in a terminal-only session, they will fail."
+	fi
+	exit 0
+}
+
 prompt=$(git config --bool mergetool.prompt || echo true)
 
 while test $# != 0
 do
     case "$1" in
+	--tool-help)
+		show_tool_help
+		;;
 	-t|--tool*)
 	    case "$#,$1" in
 		*,*=*)
-- 
1.7.11.msysgit.2
