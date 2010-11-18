From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 2/3] mergetool--lib: Add Beyond Compare 3 as a tool
Date: Thu, 18 Nov 2010 11:43:57 +0100
Message-ID: <4CE5036D.5040507@gmail.com>
References: <4CE50290.90600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Nov 18 11:44:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ1yL-00063z-IW
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 11:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292Ab0KRKoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 05:44:03 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64235 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529Ab0KRKoB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 05:44:01 -0500
Received: by ewy8 with SMTP id 8so1836766ewy.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 02:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=j+cu+gWQf1HzU8j9mv97wb1J+d9C8pOzx9zQNihPC4k=;
        b=fJrQ7/JVV435fjonX/5bZ6a/BzkN3bBdYj2cT69MUG27JOdEWQugEKvC14uB7nCh7w
         gTbkTOb7MwvhQgWmC12kdRBVOUr+QQlRcqftU79TNqmcrgBpgGIsXkJN13n6eFrk3TmX
         qr36ErMKxM79mpm02HsCuj/Kxuo7b6fhWWOIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=xrNm7DfhTfnRBtH+jh24iN1QCp3GZFt3JVk4ax3IHuijXfc3YF9f5JGeSfgCy589jk
         tWFrk4auX6/WA1pr0MXWqXpu0TCVyhKNUm8XVa4QRrcU2KqqWtHab9wYYqq0y1/bpvFO
         gHSvZufncMf/SQtTBj62APq4tPHn2V7t1DVjk=
Received: by 10.213.8.194 with SMTP id i2mr365163ebi.29.1290077040016;
        Thu, 18 Nov 2010 02:44:00 -0800 (PST)
Received: from [130.73.68.143] (berry.zib.de [130.73.68.143])
        by mx.google.com with ESMTPS id b52sm271459eei.13.2010.11.18.02.43.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 02:43:59 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4CE50290.90600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161661>



Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/git-difftool.txt         |    2 +-
 Documentation/git-mergetool.txt        |    2 +-
 Documentation/merge-config.txt         |    2 +-
 contrib/completion/git-completion.bash |    2 +-
 git-gui/lib/mergetool.tcl              |    7 +++++++
 git-mergetool--lib.sh                  |   22 ++++++++++++++++++++--
 6 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index a54fbf1..005e481 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -30,7 +30,7 @@ OPTIONS
 --tool=<tool>::
 	Use the diff tool specified by <tool>.
 	Valid merge tools are:
-	araxis, diffuse, emerge, ecmerge, gvimdiff, kdiff3,
+	araxis, bc3, diffuse, emerge, ecmerge, gvimdiff, kdiff3,
 	kompare, meld, opendiff, p4merge, tkdiff, vimdiff and xxdiff.
 +
 If a diff tool is not specified, 'git difftool'
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 4987245..740b3f1 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -26,7 +26,7 @@ OPTIONS
 --tool=<tool>::
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
-	araxis, diffuse, ecmerge, emerge, gvimdiff, kdiff3,
+	araxis, bc3, diffuse, ecmerge, emerge, gvimdiff, kdiff3,
 	meld, opendiff, p4merge, tkdiff, tortoisemerge, vimdiff and xxdiff.
 +
 If a merge resolution program is not specified, 'git mergetool'
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 2c4ca09..ca8fb2c 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -32,7 +32,7 @@ merge.stat::
 merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "araxis",
-	"diffuse", "ecmerge", "emerge", "gvimdiff", "kdiff3", "meld",
+	"bc3", "diffuse", "ecmerge", "emerge", "gvimdiff", "kdiff3", "meld",
 	"opendiff", "p4merge", "tkdiff", "tortoisemerge", "vimdiff"
 	and "xxdiff".  Any other value is treated is custom merge tool
 	and there must be a corresponding mergetool.<tool>.cmd option.
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f83f019..6507a4c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1135,7 +1135,7 @@ _git_diff ()
 }
 
 __git_mergetools_common="diffuse ecmerge emerge kdiff3 meld opendiff
-			tkdiff vimdiff gvimdiff xxdiff araxis p4merge
+			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc3
 "
 
 _git_difftool ()
diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
index 249e0cf..3c8e73b 100644
--- a/git-gui/lib/mergetool.tcl
+++ b/git-gui/lib/mergetool.tcl
@@ -187,6 +187,13 @@ proc merge_resolve_tool2 {} {
 				 "$LOCAL" "$REMOTE" "$MERGED"]
 		}
 	}
+	bc3 {
+		if {$base_stage ne {}} {
+			set cmdline [list "$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" -mergeoutput="$MERGED"]
+		} else {
+			set cmdline [list "$merge_tool_path" "$LOCAL" "$REMOTE" -mergeoutput="$MERGED"]
+		}
+	}
 	ecmerge {
 		if {$base_stage ne {}} {
 			set cmdline [list "$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" --default --mode=merge3 --to="$MERGED"]
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index aebb070..47049a6 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -13,6 +13,9 @@ translate_merge_tool_path () {
 	araxis)
 		echo compare
 		;;
+	bc3)
+		echo BCompare
+		;;
 	emerge)
 		echo emacs
 		;;
@@ -46,7 +49,7 @@ check_unchanged () {
 
 valid_tool () {
 	case "$1" in
-	araxis | diffuse | ecmerge | emerge | gvimdiff | \
+	araxis | bc3 | diffuse | ecmerge | emerge | gvimdiff | \
 	kdiff3 | meld | opendiff | p4merge | tkdiff | vimdiff | xxdiff)
 		;; # happy
 	kompare)
@@ -106,6 +109,21 @@ run_merge_tool () {
 				>/dev/null 2>&1
 		fi
 		;;
+	bc3)
+		if merge_mode; then
+			touch "$BACKUP"
+			if $base_present; then
+				"$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" \
+					-mergeoutput="$MERGED"
+			else
+				"$merge_tool_path" "$LOCAL" "$REMOTE" \
+					-mergeoutput="$MERGED"
+			fi
+			check_unchanged
+		else
+			"$merge_tool_path" "$LOCAL" "$REMOTE"
+		fi
+		;;
 	diffuse)
 		if merge_mode; then
 			touch "$BACKUP"
@@ -337,7 +355,7 @@ guess_merge_tool () {
 		else
 			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
 		fi
-		tools="$tools gvimdiff diffuse ecmerge p4merge araxis"
+		tools="$tools gvimdiff diffuse ecmerge p4merge araxis bc3"
 	fi
 	case "${VISUAL:-$EDITOR}" in
 	*vim*)
-- 
1.7.3.2.msysgit.11
