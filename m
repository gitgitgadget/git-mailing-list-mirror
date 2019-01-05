Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB31F1F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 01:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfAEBJQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 20:09:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53597 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfAEBJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 20:09:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so2571588wmb.3
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 17:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Buw/YctgraZqzpBP55zgd3jnQup2IswoigMU28cMzQY=;
        b=jnp/eS0VLGvmwRfYfhn2A7CJG+oKy1F8otwUzV/aKMAi8VpwbMrQ8vxx32U7Csh8aa
         js+JUwwTwo6T29D2f4EnOazwbbbkaFYmsiBELHDZhX13NHNZuLk57EwjR3Iiw8nVCYOD
         bCJSWPEkwGt2pvY7VndQLcMGf222EvLcH5pbKWIoGFlPtA/HxPVTU6vV8aPX7oavOrIt
         9fbJjVtaXUBuxiRkU7LtBFn+eYx33ogh4i9Cwk0x5xvmP8IOgIYa4sleaxNZSqtLf+98
         Ei7zznU8eOQzQg1VjoTkxZFPl6FBHo3rdpE9htgg7ao2oGdt3mH3jYhMFBYg1/nojZ5i
         RO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Buw/YctgraZqzpBP55zgd3jnQup2IswoigMU28cMzQY=;
        b=IdksOG30cZqNuxaAlpRyQzVnfc5PI4qcH5aXILiZOH1v2ZmhsJTk30IjMcuFaTg+IK
         veqDbKDDvIw4gn4mGRpVqnoCzC77iJqk2F7RGBXFKOt4Mo6FGF3qBpmtIWvw5CQTfa6t
         21VL2wOdZfihIADbZ12HFGZ5l4ZAQutrBf4Osk9//yKoaH/GoMAWmqAkqzukF9jwF+3F
         ThMOIHdj3aomxuPmYZx2ZDeD8MMqjIHlf5A0SvbXzI0vIypWiNGKAz7tKHu2WVmeVojz
         VwlS9m5BPLWEJg2YexgQ/PwSCtOly8DijmryMaMFaTWbEKwgUY9j52Q6zdcTfB781I8i
         fQvQ==
X-Gm-Message-State: AJcUukdNu/qqJf2GYRNqCC2IMXq7AhrFENbevsw7WWYEKp1sAW2NMJFJ
        28AiL6NMs+idld7x/VnMEzg=
X-Google-Smtp-Source: ALg8bN53yRoy67QmmZnESOVC5FTZSfbBPuw1EoTiQz56uLmnmFKqMfGxrtbwXYJitlvDfyCBAGKQLw==
X-Received: by 2002:a1c:2501:: with SMTP id l1mr2960577wml.102.1546650553310;
        Fri, 04 Jan 2019 17:09:13 -0800 (PST)
Received: from localhost.localdomain (94-21-23-250.pool.digikabel.hu. [94.21.23.250])
        by smtp.gmail.com with ESMTPSA id c15sm1851353wml.27.2019.01.04.17.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jan 2019 17:09:12 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 0/8] test-lib: add the '--stress' option to help reproduce occasional failures in flaky tests
Date:   Sat,  5 Jan 2019 02:08:51 +0100
Message-Id: <20190105010859.11031-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20181230191629.3232-1-szeder.dev@gmail.com>
References: <20181230191629.3232-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To recap: this patch series tries to make reproducing rare failures in
flaky tests easier: it adds the '--stress' option to our test library
to run the test script repeatedly in multiple parallel jobs, in the
hope that the increased load creates enough variance in the timing of
the test's commands that such a failure is eventually triggered.

There is an issue with v3: by parsing all command line options before
re-executing the test script for '--tee' or '--verbose-log', we not
only parse the options twice (which is harmless), but check the
shell's version for untraceable test scripts twice as well.
Consequently, the warning about ignoring '-x' are issued twice:

  $ ./t1510-repo-setup.sh -x --tee
  warning: ignoring -x; './t1510-repo-setup.sh' is untraceable without BASH_XTRACEFD
  warning: ignoring -x; './t1510-repo-setup.sh' is untraceable without BASH_XTRACEFD
  ok 1 - #0: nonbare repo, no explicit configuration
  <...>

Furthermore, when TEST_SHELL_PATH is not /bin/sh but is set to Bash
v4.1 or later, then the above command issues one warning as it's run
with /bin/sh from the shebang line, but then re-execs itself with Bash
and does print the '-x' tracing output as well.

This version of the patch series fixes the above issue by checking the
shell's version after '--tee' and '--verbose-log' re-execue the test
script.  To do so it makes more sense to move the 'test-lib: extract
Bash version check for '-x' tracing' patch to the beginning of the
series.  This move, however, made the range-diff quite noisy, hence
the interdiff below, as it describes the changes since v3 much better.

It's based on 'sg/test-bash-version-fix'.


SZEDER Gábor (8):
  test-lib: translate SIGTERM and SIGHUP to an exit
  test-lib: extract Bash version check for '-x' tracing
  test-lib: parse options in a for loop to keep $@ intact
  test-lib: parse command line options earlier
  test-lib: consolidate naming of test-results paths
  test-lib: set $TRASH_DIRECTORY earlier
  test-lib-functions: introduce the 'test_set_port' helper function
  test-lib: add the '--stress' option to run a test repeatedly under
    load

 t/README                 |  19 +-
 t/lib-git-daemon.sh      |   2 +-
 t/lib-git-p4.sh          |   9 +-
 t/lib-git-svn.sh         |   2 +-
 t/lib-httpd.sh           |   2 +-
 t/t0410-partial-clone.sh |   1 -
 t/t5512-ls-remote.sh     |   2 +-
 t/test-lib-functions.sh  |  39 +++++
 t/test-lib.sh            | 365 ++++++++++++++++++++++++++-------------
 9 files changed, 308 insertions(+), 133 deletions(-)

Interdiff:
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3f0b0c07df..a1abb1177a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -180,29 +180,6 @@ then
 	immediate=t
 fi
 
-if test -n "$trace" && test -n "$test_untraceable"
-then
-	# '-x' tracing requested, but this test script can't be reliably
-	# traced, unless it is run with a Bash version supporting
-	# BASH_XTRACEFD (introduced in Bash v4.1).
-	if test -n "$BASH_VERSION" && eval '
-	     test ${BASH_VERSINFO[0]} -gt 4 || {
-	       test ${BASH_VERSINFO[0]} -eq 4 &&
-	       test ${BASH_VERSINFO[1]} -ge 1
-	     }
-	   '
-	then
-		: Executed by a Bash version supporting BASH_XTRACEFD.  Good.
-	else
-		echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
-		trace=
-	fi
-fi
-if test -n "$trace" && test -z "$verbose_log"
-then
-	verbose=t
-fi
-
 TEST_STRESS_JOB_SFX="${GIT_TEST_STRESS_JOB_NR:+.stress-$GIT_TEST_STRESS_JOB_NR}"
 TEST_NAME="$(basename "$0" .sh)"
 TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
@@ -322,6 +299,34 @@ then
 	exit
 fi
 
+if test -n "$trace" && test -n "$test_untraceable"
+then
+	# '-x' tracing requested, but this test script can't be reliably
+	# traced, unless it is run with a Bash version supporting
+	# BASH_XTRACEFD (introduced in Bash v4.1).
+	#
+	# Perform this version check _after_ the test script was
+	# potentially re-executed with $TEST_SHELL_PATH for '--tee' or
+	# '--verbose-log', so the right shell is checked and the
+	# warning is issued only once.
+	if test -n "$BASH_VERSION" && eval '
+	     test ${BASH_VERSINFO[0]} -gt 4 || {
+	       test ${BASH_VERSINFO[0]} -eq 4 &&
+	       test ${BASH_VERSINFO[1]} -ge 1
+	     }
+	   '
+	then
+		: Executed by a Bash version supporting BASH_XTRACEFD.  Good.
+	else
+		echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
+		trace=
+	fi
+fi
+if test -n "$trace" && test -z "$verbose_log"
+then
+	verbose=t
+fi
+
 # For repeatability, reset the environment to known value.
 # TERM is sanitized below, after saving color control sequences.
 LANG=C
-- 
2.20.1.151.gec613c4b75

