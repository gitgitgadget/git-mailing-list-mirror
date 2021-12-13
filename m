Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAC8C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 01:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhLMBit (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 20:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhLMBin (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 20:38:43 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B80C0613FE
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 17:38:43 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso13044998wms.2
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 17:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=icnq0LFZX+syAiFU68gBcHPIEVil8Q90nFT6bEdGh6w=;
        b=KzDgDatLXSmL7of0zMRKbG0cKrao532Y7p9VqZ+wbrZYI+61GDgQYiwxuNs2E0hLyI
         7QqERGSQsqRtDOD5OvZplFxo8kvJzVzRDrvSP3+Qv1fiyvhMG+2ftdQ3u8zkpDkOEzQC
         JPrzSWw4puN8kk5CKfmDl3hMByhszqBuc7ceVDb+RmdbozRjBz7DEmh1EBbgducDPO2O
         E0tGZgLr/z/wu0E/RMYiTmNSX61Ryz9B4s5EC8/cAnTsjeW4oR16Ldb9Y7vwwO1BWL16
         cuAg+valwoKKdpITgf9gFpB+57M4E74LftuAJo81aAp5OeaDi1t116hE9Y9193uhfz3f
         Fcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=icnq0LFZX+syAiFU68gBcHPIEVil8Q90nFT6bEdGh6w=;
        b=pe+sIlUzqjlTl5ta3G7k1zytD71jDDRSzdT8LTNBfwalyJKVMhlrYayj49gubT6tbt
         3N+7vIEGKRPTXql0SWKdl98nuHrNq3R0ObiuQwFOWuwhEwP5BtibpXlqt4DetEnuZ+1j
         cAei/fuzDPHfMHXLkVyjETZQOeTEz2p0zw74YNaQzLWgRgwRWPLnYBuwOgv5hODMA2oe
         tGYCvMVPNYKZVYzIOLflZtZ4sWIHLnJpIZUImHeCUqIm4QAcn2RDi4hFAWYHGRv5LSdg
         1MnsV/2WiY5w8lgESalZ+YYL0cAtStPTAQT/O3npGQs9L4PKOABNH23LECXaVjOfFaJD
         J4Cg==
X-Gm-Message-State: AOAM5322WzY9jqtjAvuNeaObV8pydARITMVxgyZQCi0DGvyS20NfAhIu
        epSfbt5spa3o4TedYf/A/OmY/cJi97o/OA==
X-Google-Smtp-Source: ABdhPJz+oM+z6kFZpdiK8jPPiuWyBcANdnDW9+yTs6xQr63MnIOeyvLuJyMzkVabJPrk6LEHPP8C5Q==
X-Received: by 2002:a7b:ce01:: with SMTP id m1mr34997436wmc.187.1639359521332;
        Sun, 12 Dec 2021 17:38:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l5sm11571303wrs.59.2021.12.12.17.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 17:38:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/3] test-lib.sh: remove "BASH_XTRACEFD"
Date:   Mon, 13 Dec 2021 02:38:36 +0100
Message-Id: <patch-v4-3.3-8b5ae33376e-20211213T013559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1024.g573f2f4b767
In-Reply-To: <cover-v4-0.3-00000000000-20211213T013559Z-avarab@gmail.com>
References: <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com> <cover-v4-0.3-00000000000-20211213T013559Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop setting "BASH_XTRACEFD=4" to direct "-x" output to file
descriptor 4 under bash.

When it was added in d88785e424a (test-lib: set BASH_XTRACEFD
automatically, 2016-05-11) it was needed as a workaround for various
tests that didn't pass cleanly under "-x".

Most of those were later fixed in 71e472dc43 (Merge branch
'sg/test-x', 2018-03-14), and in the preceding commits we've fixed the
final remaining and removed the "test_untraceable" facility.

The reason we don't need this anymore is becomes clear from reading
the rationale in d88785e424a and applying those arguments to the
current state of the codebase. In particular it said (with "this" and
"it" referring to the problem of tests failing under "-x"):

    "there here isn't a portable or scalable solution to this [...] we
    can work around it by pointing the "set -x" output to our
    descriptor 4"

And finally that:

    "Automatic tests for our "-x" option may be a bit too meta"

Those tests are exactly what we've had since aedffe95250 (travis-ci:
run tests with '-x' tracing, 2018-02-24), so punting on fixing issues
with "-x" by using "BASH_XTRACEFD=4" isn't needed anymore, we're now
committing to maintaining the test suite in a way that won't break
under "-x".

We could retain "BASH_XTRACEFD=4" anyway, but doing so is bad because:

 1) Since we're caring about "-x" passing in CI under "dash" on Ubuntu
    using "BASH_XTRACEFD=4" will amount to hiding an error we'll run
    into eventually. Tests will pass locally with "bash", but fail in
    CI with "dash" (or under other non-"bash" shells).

 2) As the amended code in "test_eval_" shows (an amended revert to
    the pre-image of d88785e424a) it's simpler to not have to take
    this "bash" special-case into account.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 43 +++++++------------------------------------
 1 file changed, 7 insertions(+), 36 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index ddfa0567e9e..b008716917b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -627,19 +627,6 @@ else
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
@@ -926,36 +913,20 @@ test_eval_ () {
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
2.34.1.1024.g573f2f4b767

