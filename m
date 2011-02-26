From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 2/3] mergetool--lib: Add Beyond Compare 3 as a tool
Date: Sat, 26 Feb 2011 11:52:17 +0100
Message-ID: <4D68DB61.4070607@gmail.com>
References: <4D68DAC4.9060100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, charles@hashpling.org, judge.packham@gmail.com
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Feb 26 11:52:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtHlF-0007tg-SS
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 11:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837Ab1BZKwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 05:52:25 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55794 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab1BZKwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 05:52:25 -0500
Received: by bwz15 with SMTP id 15so2590906bwz.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 02:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=LKQ2liMWwp45X9cpfw9IT9V4mpFqpW9ocvCMwhZ9s+Y=;
        b=TOEXtgnWL5m2/0IireK6BMkQe0V1gPpN2P/mDLCDRfZjbrsWuRCm6k8V9vlcC27kmC
         MU6jwSnHdVOLt3XLIoJxY18hcetsQweoEjZankROvXU1kuz420PT5uD/nZRIKzZO3bqx
         ioOoD6HR02imaolR0pU5OvjhtUTTA93zwckA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=XMyXLjCAOsLyCxng89s+UY1RSD1syg9R5sqfy3BXrrYLHTNlApGaLUmIUxuaB08wwi
         IZG69UtchjcsC8O0nmcO4ib7YPC5uKDld9007ZJRdmRkeiRNO5cQaGt23+JmXYHsHfFq
         rpU8uyWseOz3CCd7SpLXgY2gSgMaJEfMu8HEk=
Received: by 10.204.121.73 with SMTP id g9mr2961357bkr.37.1298717543769;
        Sat, 26 Feb 2011 02:52:23 -0800 (PST)
Received: from [192.168.178.23] (p5DDB01ED.dip0.t-ipconnect.de [93.219.1.237])
        by mx.google.com with ESMTPS id b16sm1041443bkw.14.2011.02.26.02.52.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Feb 2011 02:52:23 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4D68DAC4.9060100@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167976>

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
index 4c8825d..f087eff 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -31,7 +31,7 @@ OPTIONS
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
index 90587db..33bf74c 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -34,7 +34,7 @@ merge.stat::
 merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "araxis",
-	"diffuse", "ecmerge", "emerge", "gvimdiff", "kdiff3", "meld",
+	"bc3", "diffuse", "ecmerge", "emerge", "gvimdiff", "kdiff3", "meld",
 	"opendiff", "p4merge", "tkdiff", "tortoisemerge", "vimdiff"
 	and "xxdiff".  Any other value is treated is custom merge tool
 	and there must be a corresponding mergetool.<tool>.cmd option.
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 893b771..058c2a9 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1358,7 +1358,7 @@ _git_diff ()
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
index 9fb82e5..3ac6231 100644
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
-	araxis | diffuse | ecmerge | emerge | gvimdiff | gvimdiff2 | \
+	araxis | bc3 | diffuse | ecmerge | emerge | gvimdiff | gvimdiff2 | \
 	kdiff3 | meld | opendiff | p4merge | tkdiff | vimdiff | vimdiff2 | xxdiff)
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
@@ -342,7 +360,7 @@ guess_merge_tool () {
 		else
 			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
 		fi
-		tools="$tools gvimdiff diffuse ecmerge p4merge araxis"
+		tools="$tools gvimdiff diffuse ecmerge p4merge araxis bc3"
 	fi
 	case "${VISUAL:-$EDITOR}" in
 	*vim*)
-- 
1.7.3.2.msysgit.6.dirty
