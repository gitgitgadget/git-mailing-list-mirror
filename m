Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E2AC433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 20:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352878AbhLAUP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 15:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbhLAUPS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 15:15:18 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92FCC061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 12:11:55 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id s13so54924725wrb.3
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 12:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S0tvYf+nxi/4p34I+WjGo9TDdzPPI1ZrF8vOv1o+nJw=;
        b=nGVvg7rDtbVZLR75E2qvpKp1SIpfLH6hq0vEe9mcM2+4Dq+8KHOkI9MOG6rjyaH/RB
         UlYWIOb+3mXUPxC898TZ5m28QZD7YhwxHvD+dgWQmseBBAjwhoUfEnqycTLQuhuUDAfh
         HrCU1XAYOe2C8AZr0W7W/iT2+EcxjkVl90n6JiB15DN+FYumOJEgd9c1Or4kryT3/IWs
         Qu9jfjh58oh44n/OXtKrDo9G4D3veGwQ+OVck3Xbd0VblkEZ2912lh9ZFn9seu6o3+kk
         BtGdoC6LoUHSFfxaEJxGy+Havpi7b8jjSTJLCldKizD93GuPS0AV+F3m6+tFnzF6IWVv
         7ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S0tvYf+nxi/4p34I+WjGo9TDdzPPI1ZrF8vOv1o+nJw=;
        b=xryKx2BGTeeLld9rCjkcwRLn+Fviwia0YPeQTR0M8I2gk/eJGLtwOnItvXaFvObwss
         +Dz9LsBPIKwDsbQaN8TXXz4AIZM1jRNfg512n91tF2gbN7XqmE0ZdK7LsYZTWxCVuvJh
         pC+mi+TPcoEE9qrqIMhRsv0vT9h4W5Ldww18sxVzUZWfjogS8vvORm2MvRlZF/qq2Yf2
         7HKKsjr6V3E+gqas2yOZJfpjXvk9iV1FWdFJqfb0lskMJ8zbbwOwI9jPuGtMkEy9VmBD
         uoFfWieQuJRLC77DTStohGGt5yOk4Cw5aXfc3dnbmgbK5vdjRR8aS7nlCV71oXr3PtPp
         BpgQ==
X-Gm-Message-State: AOAM5324f1WQ8pz6Pejh+uuRLVQjJLjfqrDAg7HrK8/CV9FijXRV4lno
        Zrnj+VepCqvGNGrO7saDy7FePnpL03LU7A==
X-Google-Smtp-Source: ABdhPJwVuvIcFbJ7XRVPTLmZmx7QLznorIHBwqrCZyeHPqkGsWEjHtm56vALS10Bf47ash1z0l6EMQ==
X-Received: by 2002:a5d:4f12:: with SMTP id c18mr8993671wru.547.1638389514090;
        Wed, 01 Dec 2021 12:11:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l4sm660876wrv.94.2021.12.01.12.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:11:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] test-lib.sh: remove the now-unused "test_untraceable" facility
Date:   Wed,  1 Dec 2021 21:11:42 +0100
Message-Id: <patch-v2-2.2-867d18d14bd-20211201T200801Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.876.gdb91009a90c
In-Reply-To: <cover-v2-0.2-00000000000-20211201T200801Z-avarab@gmail.com>
References: <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com> <cover-v2-0.2-00000000000-20211201T200801Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit the use of "test_untraceable=UnfortunatelyYes"
was removed from "t1510-repo-setup.sh" in favor of more narrow
redirections of the output of specific commands (and not entire
sub-shells or functions).

This is in line with the fixes in the series that introduced the
"test_untraceable" facility. See 571e472dc43 (Merge branch
'sg/test-x', 2018-03-14) for the series as a whole, and
e.g. 91538d0cde9 (t5570-git-daemon: don't check the stderr of a
subshell, 2018-02-24) for a commit that's in line with the changes in
the preceding commit.

We've thus solved the TODO item noted when "test_untraceable" was
added to "t1510-repo-setup.sh" in 58275069288 (t1510-repo-setup: mark
as untraceable with '-x', 2018-02-24).

So let's remove the feature entirely. Not only is it currently unused,
but it actively encourages an anti-pattern in our tests. We should be
testing the output of specific commands, not entire subshells or
functions.

That the "-x" output had to be disabled as a result is only one
symptom, but even under bash those tests will be harder to debug as
the subsequent check of the redirected file will be far removed from
the command that emitted the output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README      |  3 ---
 t/test-lib.sh | 66 ++++++---------------------------------------------
 2 files changed, 7 insertions(+), 62 deletions(-)

diff --git a/t/README b/t/README
index 29f72354bf1..3d30bbff34a 100644
--- a/t/README
+++ b/t/README
@@ -86,9 +86,6 @@ appropriately before running "make". Short options can be bundled, i.e.
 -x::
 	Turn on shell tracing (i.e., `set -x`) during the tests
 	themselves. Implies `--verbose`.
-	Ignored in test scripts that set the variable 'test_untraceable'
-	to a non-empty value, unless it's run with a Bash version
-	supporting BASH_XTRACEFD, i.e. v4.1 or later.
 
 -d::
 --debug::
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 57efcc5e97a..b008716917b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -381,29 +381,6 @@ then
 	exit
 fi
 
-if test -n "$trace" && test -n "$test_untraceable"
-then
-	# '-x' tracing requested, but this test script can't be reliably
-	# traced, unless it is run with a Bash version supporting
-	# BASH_XTRACEFD (introduced in Bash v4.1).
-	#
-	# Perform this version check _after_ the test script was
-	# potentially re-executed with $TEST_SHELL_PATH for '--tee' or
-	# '--verbose-log', so the right shell is checked and the
-	# warning is issued only once.
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
 if test -n "$trace" && test -z "$verbose_log"
 then
 	verbose=t
@@ -650,19 +627,6 @@ else
 	exec 4>/dev/null 3>/dev/null
 fi
 
-# Send any "-x" output directly to stderr to avoid polluting tests
-# which capture stderr. We can do this unconditionally since it
-# has no effect if tracing isn't turned on.
-#
-# Note that this sets up the trace fd as soon as we assign the variable, so it
-# must come after the creation of descriptor 4 above. Likewise, we must never
-# unset this, as it has the side effect of closing descriptor 4, which we
-# use to show verbose tests to the user.
-#
-# Note also that we don't need or want to export it. The tracing is local to
-# this shell, and we would not want to influence any shells we exec.
-BASH_XTRACEFD=4
-
 test_failure=0
 test_count=0
 test_fixed=0
@@ -949,36 +913,20 @@ test_eval_ () {
 	# the shell from printing the "set +x" to turn it off (nor the saving
 	# of $? before that). But we can make sure that the output goes to
 	# /dev/null.
-	#
-	# There are a few subtleties here:
-	#
-	#   - we have to redirect descriptor 4 in addition to 2, to cover
-	#     BASH_XTRACEFD
-	#
-	#   - the actual eval has to come before the redirection block (since
-	#     it needs to see descriptor 4 to set up its stderr)
-	#
-	#   - likewise, any error message we print must be outside the block to
-	#     access descriptor 4
-	#
-	#   - checking $? has to come immediately after the eval, but it must
-	#     be _inside_ the block to avoid polluting the "set -x" output
-	#
-
-	test_eval_inner_ "$@" </dev/null >&3 2>&4
 	{
+		test_eval_inner_ "$@" </dev/null >&3 2>&4
 		test_eval_ret_=$?
 		if want_trace
 		then
 			test 1 = $trace_level_ && set +x
 			trace_level_=$(($trace_level_-1))
-		fi
-	} 2>/dev/null 4>&2
 
-	if test "$test_eval_ret_" != 0 && want_trace
-	then
-		say_color error >&4 "error: last command exited with \$?=$test_eval_ret_"
-	fi
+			if test "$test_eval_ret_" != 0
+			then
+				say_color error >&4 "error: last command exited with \$?=$test_eval_ret_"
+			fi
+		fi
+	} 2>/dev/null
 	return $test_eval_ret_
 }
 
-- 
2.34.1.876.gdb91009a90c

