Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBD241F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 02:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfHOCe1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 22:34:27 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:38242 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfHOCe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 22:34:27 -0400
Received: by mail-qt1-f202.google.com with SMTP id i13so1232816qtq.5
        for <git@vger.kernel.org>; Wed, 14 Aug 2019 19:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=L66NPUVMIqEC81YBvyx3zFmCoZGdG81BJdkS7NMm0U8=;
        b=h4rFuhDckvyEaI4ukmPLMwn7ciQ2+eaW4xSY6AhVbQNx7+Pysyiuzt6uHTKqNeBED0
         iy9IE9alkssLzquwF8NAr1tONWLUc+wGdhCcxzjsUFYp+yhHm6IX9vOdUPS57UIWdGuA
         J9D7uEN1kML1Cs6WPGk6sqD5peWB+OsOnwQxe6+BcuP96hmpNEuyWVD7BDPoixJzWIY/
         rwWphtixF2BY4h02nMljrsFIGSPCfje7w2zRpjHu6eFRY1g3QRiTDL5HxE2kgk3Iz2ZV
         gpsiZMGmoVJd3mxzKZer0pJ8ty9npynOwFc09HB0K+5BtqShfF3Erm/P6QC8U+QESzp+
         xA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=L66NPUVMIqEC81YBvyx3zFmCoZGdG81BJdkS7NMm0U8=;
        b=WuXOk0742FVUQelUo7Ro/2UzKPhQ3TwaJp6VJ2DgyWPuH1ZxYQxLqJBKPUYlElwAEF
         9j67zFou2KlQprCoqohwVy5rqkWUfvqzYrfZV/FqqJU6ZLoV/GCwkhhhEgXJ9bio911a
         7sb2E3L1KhHSzNp1hj1nj3UJM3a70CKWY4qsO7rO3tP3bUgwFSdwH5YAhro9Y5yQDZgY
         kt8d7M/7i5amYJrAqJIsOez8P0NeXJqumUM0P9QLTtZl1cMj4MOvVQk859Ol4Z80AzXj
         WAXieK0Qn2Cq+hXBv1LFFgyBA6bEfRvoHICCg85Hk388fAh9S7fjtDW/M00At9F77yAQ
         ECow==
X-Gm-Message-State: APjAAAWEDV5B+RaU+sMGGUfQpJ0Fvg5HQayqoGi385MVCDJU9eb6qNgj
        0AD1YzXFmzODso0lwu560YsGByLHvMreLZoScjKf9eiS0XA46K0E4QTHxXcn2sRGm+IHPR+MLRi
        726DkpP8PjO4beXOQ9wkaCKGAV9PfKlgM800s42alSOUqYNI+hDwz97qA7C5H6bj7OdPbw1TthA
        ==
X-Google-Smtp-Source: APXvYqxwzn1+nxmIKA9G8NDabU5hyndyDIF6D7rGoX7O0pcWGNSuafPM80ImUqmLXUUDd7mnjwm6QMWxQ/z9fhm5ucU=
X-Received: by 2002:ae9:e845:: with SMTP id a66mr2118282qkg.451.1565836465805;
 Wed, 14 Aug 2019 19:34:25 -0700 (PDT)
Date:   Wed, 14 Aug 2019 19:34:18 -0700
Message-Id: <20190815023418.33407-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH] bugreport: add tool to generate debugging info
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make it easier for users who encounter a bug to send a report by
collecting some state information, intended to be viewed by humans
familiar with Git.

Teach Git how to prompt the user for a good bug report: reproduction
steps, expected behavior, and actual behavior. Also, teach Git to write
down its own version, the version of some of its dependencies, the
operating system information, the effective gitconfig, the configured
hooks, and the contents of $GIT_DIR/logs. Finally, make sure Git asks
the user to review the contents of the report after it's generated.

If users can send us a well-written bug report complete with system
information, a remote we may be able to clone, and a reflog showing us
where the problem occurred, we can reduce the number of questions and
answers which must travel between the reporter and the Git contributor.

Users may also wish to send a report like this to their local "Git
expert" if they have put their repository into a state they are confused
by.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
There are some things I'm not certain about from this patch, I'd
appreciate feedback.

 - Do we want to advertise the Git mailing list for bug reports?
 - Which config options should we filter to avoid accidentally receiving
   credentials?
 - At the moment, the test is trying to check "everything we thought we
   would populate got populated" - that seemed to me like it would hold
   up best to changes to the set of information being collected. But
   maybe there's something more robust we can do.

And of course, if there are suggestions for other things to include in
the report I'm interested in adding.

An example of the output can be found here:
https://gist.github.com/nasamuffin/2e320892f5c2147e829cbcf5bd0759a2

Thanks.
 - Emily

 .gitignore                      |  1 +
 Documentation/git-bugreport.txt | 48 ++++++++++++++++++
 Makefile                        |  1 +
 command-list.txt                |  1 +
 git-bugreport.sh                | 86 +++++++++++++++++++++++++++++++++
 t/t0091-bugreport.sh            | 41 ++++++++++++++++
 6 files changed, 178 insertions(+)
 create mode 100644 Documentation/git-bugreport.txt
 create mode 100755 git-bugreport.sh
 create mode 100755 t/t0091-bugreport.sh

diff --git a/.gitignore b/.gitignore
index 521d8f4fb4..b4f5433084 100644
--- a/.gitignore
+++ b/.gitignore
@@ -25,6 +25,7 @@
 /git-bisect--helper
 /git-blame
 /git-branch
+/git-bugreport
 /git-bundle
 /git-cat-file
 /git-check-attr
diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
new file mode 100644
index 0000000000..c5f45bbee8
--- /dev/null
+++ b/Documentation/git-bugreport.txt
@@ -0,0 +1,48 @@
+git-bugreport(1)
+================
+
+NAME
+----
+git-bugreport - Collect information for user to file a bug report
+
+SYNOPSIS
+--------
+[verse]
+'git bugreport' [-o | --output <path>]
+
+DESCRIPTION
+-----------
+Captures information about the user's machine, Git client, and repository state,
+as well as a form requesting information about the behavior the user observed,
+into a single text file which the user can then share, for example to the Git
+mailing list, in order to report an observed bug.
+
+The following information is requested from the user:
+
+ - Reproduction steps
+ - Expected behavior
+ - Actual behavior
+
+The following information is captured automatically:
+
+ - Git version (`git version --build-options`)
+ - Machine information (`uname -a`)
+ - Versions of various dependencies
+ - Git config contents (`git config --show-origin --list`)
+ - The contents of all configured git-hooks in `.git/hooks/`
+ - The contents of `.git/logs`
+
+OPTIONS
+-------
+-o [<path>]::
+--output [<path>]::
+	Place the resulting bug report file in <path> instead of the root of the
+	Git repository.
+
+NOTE
+----
+Bug reports can be sent to git@vger.kernel.org.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index f9255344ae..69801a1c45 100644
--- a/Makefile
+++ b/Makefile
@@ -606,6 +606,7 @@ TEST_PROGRAMS_NEED_X =
 unexport CDPATH
 
 SCRIPT_SH += git-bisect.sh
+SCRIPT_SH += git-bugreport.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-merge-octopus.sh
diff --git a/command-list.txt b/command-list.txt
index a9ac72bef4..be5a605047 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -54,6 +54,7 @@ git-archive                             mainporcelain
 git-bisect                              mainporcelain           info
 git-blame                               ancillaryinterrogators          complete
 git-branch                              mainporcelain           history
+git-bugreport                           ancillaryinterrogators
 git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-check-attr                          purehelpers
diff --git a/git-bugreport.sh b/git-bugreport.sh
new file mode 100755
index 0000000000..2200703a51
--- /dev/null
+++ b/git-bugreport.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+
+print_filenames_and_content() {
+while read -r line; do
+	echo "$line";
+	echo "========";
+	cat "$line";
+	echo;
+done
+}
+
+generate_report_text() {
+
+	# Generate a form for the user to fill out with their issue.
+	gettextln "Thank you for filling out a Git bug report!"
+	gettextln "Please answer the following questions to help us understand your issue."
+	echo
+	gettextln "What did you do before the bug happened? (Steps to reproduce your issue)"
+	echo
+	gettextln "What did you expect to happen? (Expected behavior)"
+	echo
+	gettextln "What happened instead? (Actual behavior)"
+	echo
+	gettextln "Anything else you want to add:"
+	echo
+	gettextln "Please review the rest of the bug report below."
+	gettextln "You can delete any lines you don't wish to send."
+	echo
+
+	echo "[System Information]"
+	git version --build-options
+	uname -a
+	curl-config --version
+	ldd --version
+	echo
+
+	echo "[Git Config]"
+	# TODO: Pass this through grep -v to avoid users sending us their credentials.
+	git config --show-origin --list
+	echo
+
+	echo "[Configured Hooks]"
+	find "$GIT_DIR/hooks/" -type f | grep -v "\.sample$" | print_filenames_and_content
+	echo
+
+	echo "[Git Logs]"
+	find "$GIT_DIR/logs" -type f | print_filenames_and_content
+	echo
+
+}
+
+USAGE="[-o | --output <path>]"
+
+SUBDIRECTORY_OK=t
+OPTIONS_SPEC=
+. git-sh-setup
+. git-sh-i18n
+
+basedir="$PWD"
+while :
+do
+	case "$1" in
+	-o|--output)
+		shift
+		basedir="$1"
+		shift
+		continue
+		;;
+	"")
+		break
+		;;
+	*)
+		usage
+		;;
+	esac
+done
+
+
+# Create bugreport file
+BUGREPORT_FILE="$basedir/git-bugreport-$(whoami)-$(hostname)-$(date -Iminutes)"
+
+generate_report_text >$BUGREPORT_FILE
+
+git_editor $BUGREPORT_FILE
+
+eval_gettextln "Your new bug report is in \$BUGREPORT_FILE."
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
new file mode 100755
index 0000000000..6eb2ee4f66
--- /dev/null
+++ b/t/t0091-bugreport.sh
@@ -0,0 +1,41 @@
+#!/bin/bash
+
+test_description='git bugreport'
+
+. ./test-lib.sh
+
+# Headers "[System Info]" will be followed by a non-empty line if we put some
+# information there; we can make sure all our headers were followed by some
+# information to check if the command was successful.
+HEADER_PATTERN="^\[.*\]$"
+check_all_headers_populated() {
+	while read -r line; do
+		if [$(grep $HEADER_PATTERN $line)]; then
+			read -r nextline
+			if [-z $nextline]; then
+				return 1;
+			fi
+		fi
+	done
+}
+
+test_expect_success 'creates a report with content in the right places' '
+	git bugreport &&
+	check_all_headers_populated <git-bugreport-* &&
+	rm git-bugreport-*
+'
+
+test_expect_success '--output puts the report in the provided dir' '
+	mkdir foo/ &&
+	git bugreport -o foo/ &&
+	test -f foo/git-bugreport-* &&
+	rm -fr foo/
+'
+
+test_expect_success 'incorrect arguments abort with usage' '
+	test_must_fail git bugreport --false 2>output &&
+	grep usage output &&
+	test ! -f git-bugreport-*
+'
+
+test_done
-- 
2.23.0.rc1.153.gdeed80330f-goog

