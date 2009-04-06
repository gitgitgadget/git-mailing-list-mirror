From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 03/14] git-mergetool: add new merge tool TortoiseMerge
Date: Mon,  6 Apr 2009 01:31:18 -0700
Message-ID: <1239006689-14695-4-git-send-email-davvid@gmail.com>
References: <1239006689-14695-1-git-send-email-davvid@gmail.com>
 <1239006689-14695-2-git-send-email-davvid@gmail.com>
 <1239006689-14695-3-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 06 10:35:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqkIE-0002l9-NH
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 10:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547AbZDFIbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 04:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754368AbZDFIby
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 04:31:54 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:18484 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114AbZDFIbw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 04:31:52 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1642088wah.21
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 01:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=S4VTSCTMyj6I3/u4wM4qqQ6BXP8gqAu3DivdOEKe9ys=;
        b=b/AfXi1ThhyKZ7vP778zQgIftp/hHYrH2rz/uFLU7SgHhgvv8GyY7XAbG6njELH7mh
         gyb037grqFUx26Oci08BaXoVx09+NjiXCG2dAvvAqDcukb98i5wN4HQwFBbbp5TcaKP3
         hzMKsW6uXjFHGbARxcwnLdVdACWMfFqqXxAsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QNXlWUL8VO9OPuYPN2U5CQfhl7+cBhgk0inlyioz4KYyOy2ZKrkymaadHPIzADOAZa
         UrwsIcoHsMB5pgtX5QFAjC5BPjt3QAp5JAoe0F4Bx2PnbWbFA4Nr5O13tn3yooxV3Wff
         14DFcb1A0odtaGm0tqrV+30eIWHi34LeOlN7w=
Received: by 10.114.153.18 with SMTP id a18mr2142376wae.200.1239006710000;
        Mon, 06 Apr 2009 01:31:50 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l30sm5178139waf.34.2009.04.06.01.31.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Apr 2009 01:31:49 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.414.g81aa9
In-Reply-To: <1239006689-14695-3-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115786>

From: Markus Heidelberg <markus.heidelberg@web.de>

TortoiseMerge comes with TortoiseSVN or TortoiseGit for Windows. It can
only be used as a merge tool with an existing base file. It cannot be
used without a base nor as a diff tool.

The documentation only mentions the slash '/' as command line option
prefix, which refused to work, but the parser also accepts the dash '-'

See http://code.google.com/p/msysgit/issues/detail?id=226

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 Documentation/git-mergetool.txt |    3 ++-
 Documentation/merge-config.txt  |    2 +-
 git-mergetool.sh                |   16 +++++++++++++---
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 5d3c632..5edac4d 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -26,7 +26,8 @@ OPTIONS
 --tool=<tool>::
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
-	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge, and opendiff
+	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge,
+	tortoisemerge and opendiff
 +
 If a merge resolution program is not specified, 'git-mergetool'
 will use the configuration variable `merge.tool`.  If the
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 9c44af8..8c10f66 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -23,7 +23,7 @@ merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
 	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff",
-	"ecmerge" and
+	"ecmerge", tortoisemerge and
 	"opendiff".  Any other value is treated is custom merge tool
 	and there must be a corresponding mergetool.<tool>.cmd option.
 
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 6e611e9..be9717a 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -265,6 +265,16 @@ merge_file () {
 	    fi
 	    status=$?
 	    ;;
+	tortoisemerge)
+	    if base_present ; then
+		touch "$BACKUP"
+		"$merge_tool_path" -base:"$BASE" -mine:"$LOCAL" -theirs:"$REMOTE" -merged:"$MERGED"
+		check_unchanged
+	    else
+		echo "TortoiseMerge cannot be used without a base" 1>&2
+		status=1
+	    fi
+	    ;;
 	*)
 	    if test -n "$merge_tool_cmd"; then
 		if test "$merge_tool_trust_exit_code" = "false"; then
@@ -345,7 +355,7 @@ valid_custom_tool()
 
 valid_tool() {
 	case "$1" in
-		kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
+		kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge | tortoisemerge)
 			;; # happy
 		*)
 			if ! valid_custom_tool "$1"; then
@@ -404,9 +414,9 @@ fi
 if test -z "$merge_tool" ; then
     if test -n "$DISPLAY"; then
         if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
-            merge_tool_candidates="meld kdiff3 tkdiff xxdiff gvimdiff"
+            merge_tool_candidates="meld kdiff3 tkdiff xxdiff tortoisemerge gvimdiff"
         else
-            merge_tool_candidates="kdiff3 tkdiff xxdiff meld gvimdiff"
+            merge_tool_candidates="kdiff3 tkdiff xxdiff meld tortoisemerge gvimdiff"
         fi
     fi
     if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
-- 
1.6.2.2.414.g81aa9
