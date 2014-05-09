From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 07/25] contrib: remove 'git-jump'
Date: Thu,  8 May 2014 19:58:18 -0500
Message-ID: <1399597116-1851-8-git-send-email-felipe.contreras@gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 03:10:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiZKR-0000Bn-Ku
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 03:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756061AbaEIBKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 21:10:05 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:47219 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756013AbaEIBJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 21:09:59 -0400
Received: by mail-yh0-f51.google.com with SMTP id f10so3141775yha.10
        for <git@vger.kernel.org>; Thu, 08 May 2014 18:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nP4RwoFe92hyaVM7+iiAWbE7EBleXG1dHxzR85BSWa0=;
        b=l+AAJH/IjIOB5QLdeXfNlzmtAA8iecwxMUKFNad9cbgoaOOUimHnS6snaBaKf2uzZx
         MH0kT/v+WY/HzL3l5mxQQunTBalSPct2s2867Nwyn8QJaBHqlYU0J53gKQRQtXRHVn/y
         D7DcCorF3oFtvqYfzeUMqEkEoJ3QVwaCSdcuZcd/avFGbbAA6ZjUBmq8sLqw1v9RybLs
         6WieYsUpoSlHbM3IsKUtR4AD9l2tuYqdhY5wL/JQupDx8mpfa8nIlkCLfEUCq0Qh7es8
         gkCcULA5pItJvMVrF5G65dm2IzDHHTkEEMRvzquhBcRsKBezbR6R7MGrD6zk/Q26BjpB
         vFNA==
X-Received: by 10.236.93.194 with SMTP id l42mr10380582yhf.17.1399597799348;
        Thu, 08 May 2014 18:09:59 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id l67sm3904911yha.52.2014.05.08.18.09.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 18:09:57 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.27.gbce2056
In-Reply-To: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248473>

No activity, no tests.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/git-jump/README   | 92 -----------------------------------------------
 contrib/git-jump/git-jump | 69 -----------------------------------
 2 files changed, 161 deletions(-)
 delete mode 100644 contrib/git-jump/README
 delete mode 100755 contrib/git-jump/git-jump

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
deleted file mode 100644
index 1cebc32..0000000
--- a/contrib/git-jump/README
+++ /dev/null
@@ -1,92 +0,0 @@
-git-jump
-========
-
-Git-jump is a script for helping you jump to "interesting" parts of your
-project in your editor. It works by outputting a set of interesting
-spots in the "quickfix" format, which editors like vim can use as a
-queue of places to visit (this feature is usually used to jump to errors
-produced by a compiler). For example, given a diff like this:
-
-------------------------------------
-diff --git a/foo.c b/foo.c
-index a655540..5a59044 100644
---- a/foo.c
-+++ b/foo.c
-@@ -1,3 +1,3 @@
- int main(void) {
--  printf("hello word!\n");
-+  printf("hello world!\n");
- }
------------------------------------
-
-git-jump will feed this to the editor:
-
------------------------------------
-foo.c:2: printf("hello word!\n");
------------------------------------
-
-Obviously this trivial case isn't that interesting; you could just open
-`foo.c` yourself. But when you have many changes scattered across a
-project, you can use the editor's support to "jump" from point to point.
-
-Git-jump can generate three types of interesting lists:
-
-  1. The beginning of any diff hunks.
-
-  2. The beginning of any merge conflict markers.
-
-  3. Any grep matches.
-
-
-Using git-jump
---------------
-
-To use it, just drop git-jump in your PATH, and then invoke it like
-this:
-
---------------------------------------------------
-# jump to changes not yet staged for commit
-git jump diff
-
-# jump to changes that are staged for commit; you can give
-# arbitrary diff options
-git jump diff --cached
-
-# jump to merge conflicts
-git jump merge
-
-# jump to all instances of foo_bar
-git jump grep foo_bar
-
-# same as above, but case-insensitive; you can give
-# arbitrary grep options
-git jump grep -i foo_bar
---------------------------------------------------
-
-
-Related Programs
-----------------
-
-You can accomplish some of the same things with individual tools. For
-example, you can use `git mergetool` to start vimdiff on each unmerged
-file. `git jump merge` is for the vim-wielding luddite who just wants to
-jump straight to the conflict text with no fanfare.
-
-As of git v1.7.2, `git grep` knows the `--open-files-in-pager` option,
-which does something similar to `git jump grep`. However, it is limited
-to positioning the cursor to the correct line in only the first file,
-leaving you to locate subsequent hits in that file or other files using
-the editor or pager. By contrast, git-jump provides the editor with a
-complete list of files and line numbers for each match.
-
-
-Limitations
------------
-
-This scripts was written and tested with vim. Given that the quickfix
-format is the same as what gcc produces, I expect emacs users have a
-similar feature for iterating through the list, but I know nothing about
-how to activate it.
-
-The shell snippets to generate the quickfix lines will almost certainly
-choke on filenames with exotic characters (like newlines).
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
deleted file mode 100755
index dc90cd6..0000000
--- a/contrib/git-jump/git-jump
+++ /dev/null
@@ -1,69 +0,0 @@
-#!/bin/sh
-
-usage() {
-	cat <<\EOF
-usage: git jump <mode> [<args>]
-
-Jump to interesting elements in an editor.
-The <mode> parameter is one of:
-
-diff: elements are diff hunks. Arguments are given to diff.
-
-merge: elements are merge conflicts. Arguments are ignored.
-
-grep: elements are grep hits. Arguments are given to grep.
-EOF
-}
-
-open_editor() {
-	editor=`git var GIT_EDITOR`
-	eval "$editor -q \$1"
-}
-
-mode_diff() {
-	git diff --no-prefix --relative "$@" |
-	perl -ne '
-	if (m{^\+\+\+ (.*)}) { $file = $1; next }
-	defined($file) or next;
-	if (m/^@@ .*\+(\d+)/) { $line = $1; next }
-	defined($line) or next;
-	if (/^ /) { $line++; next }
-	if (/^[-+]\s*(.*)/) {
-		print "$file:$line: $1\n";
-		$line = undef;
-	}
-	'
-}
-
-mode_merge() {
-	git ls-files -u |
-	perl -pe 's/^.*?\t//' |
-	sort -u |
-	while IFS= read fn; do
-		grep -Hn '^<<<<<<<' "$fn"
-	done
-}
-
-# Grep -n generates nice quickfix-looking lines by itself,
-# but let's clean up extra whitespace, so they look better if the
-# editor shows them to us in the status bar.
-mode_grep() {
-	git grep -n "$@" |
-	perl -pe '
-	s/[ \t]+/ /g;
-	s/^ *//;
-	'
-}
-
-if test $# -lt 1; then
-	usage >&2
-	exit 1
-fi
-mode=$1; shift
-
-trap 'rm -f "$tmp"' 0 1 2 3 15
-tmp=`mktemp -t git-jump.XXXXXX` || exit 1
-type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
-"mode_$mode" "$@" >"$tmp"
-test -s "$tmp" || exit 0
-open_editor "$tmp"
-- 
1.9.2+fc1.27.gbce2056
