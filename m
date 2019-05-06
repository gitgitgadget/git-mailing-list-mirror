Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 664401F45F
	for <e@80x24.org>; Mon,  6 May 2019 19:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfEFTQ6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 15:16:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35360 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEFTQY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 15:16:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id w12so5285739wrp.2
        for <git@vger.kernel.org>; Mon, 06 May 2019 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oMAsUV2MEZUjegykoXrywirxQS3PcZNq/1/7DlLQ0v8=;
        b=Pe0nOGtE8PQogTon4JJQTfmsjciBdHEJi1tvkvsWGL34RrgMId6drR6tXxHB+3i19m
         mbH10Vx+u0BIeWzG+R7cSIbbfUAChj8zk1npRGRAbagHKuq1Zn60uSlSmvmLgUFMdBXN
         aPDiX6gS4hR+QyZc/jlQ2leNamLuRGvk5JAW3oMoTpZWrXp0pKKQPXQGmw35zWSgfq4T
         lHDf9YQWM76EMT80sbQWU8i8ALy0ej3rTk/rfRShZj2di4R3B7SdiyXhs30+W9tyKPsb
         ftvNjBGkH2D+mPCpVGfNmkUxh+D7OaZfC9f7jdYCxFNI1N2Lbn96BsMwywpHsZZs6S2X
         O4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oMAsUV2MEZUjegykoXrywirxQS3PcZNq/1/7DlLQ0v8=;
        b=SsLcjtCTU7yP0DHkS4Wa2Qg3jQS8lAM4/W2Fcn2wojmvvhsu8cEEr+hAl+VmrrsJly
         zzZyomQu1v25iDomzV+TZ2wNqxafDl9qhnppP4YN+JP4Q3/awu50L11bbS7Xx2RphaQt
         HtNI3xvpqdCy8FWFMq2ABFoTO+A4RAoOyNw87LFWVjNhloXbU7QeoR2DnR0l8o8PuHB3
         nayk+hur5DN5bLGSvz1GPj781KUKp2NRjPwgfhaORw7qDW8Ujl7CE/3B7qWaNCCilGxS
         JFY0AAYnT84d5OXPZU/87ml9wqgFpMprg+X1DqBXKnJMCLdWswqp8+KXDdRHbhFmKwcD
         2yBg==
X-Gm-Message-State: APjAAAUutOwokOI6yUIQ5KWt4Xf2h8JCb3P6x4T3D2fSQejbkjXmXHjf
        34Ep6Rkcjm5QmI8aesi9UXcBjpRWiyE=
X-Google-Smtp-Source: APXvYqyZndhvazSYR5koBP19E+qZntF/Mj+WS+8Qn6hdrUpaNW0LgbkBBMT5wfawVCBTC4v/MCikTw==
X-Received: by 2002:adf:80c3:: with SMTP id 61mr19980667wrl.123.1557170181571;
        Mon, 06 May 2019 12:16:21 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm15385870wmm.16.2019.05.06.12.16.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 12:16:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] perf-lib.sh: make "./run <revisions>" use the correct gits
Date:   Mon,  6 May 2019 21:16:11 +0200
Message-Id: <20190506191611.16770-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <20190502222409.GA15631@sigill.intra.peff.net>
References: <20190502222409.GA15631@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a really bad regression in 0baf78e7bc ("perf-lib.sh: rely on
test-lib.sh for --tee handling", 2019-03-15). Since that change all
runs of different <revisions> of git have used the git found in the
user's $PATH, e.g. /usr/bin/git instead of the <revision> we just
built and wanted to performance test.

The problem starts with GIT_TEST_INSTALLED not working like our
non-perf tests with the "run" script. I.e. you can't run performance
tests against a given installed git. Instead we expect to use it
ourselves to point GIT_TEST_INSTALLED to the <revision> we just built.

However, we had been relying on '$(cd "$GIT_TEST_INSTALLED" && pwd)'
to resolve that relative $GIT_TEST_INSTALLED to an absolute
path *before* test-lib.sh was loaded, in cases where it was
e.g. "build/<rev>/bin-wrappers" and we wanted "<abs_path>build/...".

Perhaps there's some better way to fix this, but it seems to me that
the best solution is to just make this behavior less magical. We know
in run_dirs_helper() that we're about to run performance tests on a
given <revision>, so let's just set GIT_TEST_INSTALLED to an absolute
path there, and then make getting logging target from a previously
relative path less magical, we'll just explicitly pass down the
relative path as a variable.

This makes e.g. these cases all work:

    ./run . $PWD/../../ origin/master origin/next HEAD -- <tests>

As well as just a plain one-off:

    ./run <tests>

And, since we're passing down the new GIT_PERF_DIR_MYDIR_REL we make
sure the bug relating to aggregate.perl not finding our files as
described in 0baf78e7bc doesn't happen again.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Fri, May 03 2019, Jeff King wrote:

> On Thu, May 02, 2019 at 05:45:09PM -0400, Jeff King wrote:
>
>> Here's what I came up with. Note that there's a bug in 'master' right
>> now which causes perf to produce nonsense results. It's due to my
>> 0baf78e7bc (perf-lib.sh: rely on test-lib.sh for --tee handling,
>> 2019-03-15). I'll fix that separately (the timing below is done with
>> that commit reverted).
>
> And here's the fix for that. It's rather subtle, so I hope I explained
> it sufficiently. I didn't notice it while working on the original
> because everything _appears_ to run fine, but you just get timings from
> the wrong version of Git. Which is only noticeable if you're literally
> testing two versions that you expect to differ.

I ran into this today and it took me an embarrasingly long time to
figure out why my code wasn't making things faster.

So I wrote this up before seeing your patch, since it wasn't queued in
"pu" and my naïve ML search didn't include inline patches (again,
*sigh*).

Anyway, I wonder if something closer to this patch, or some sort of
merge of the two (e.g. to still get rid of the
ABSOLUTE_GIT_TEST_INSTALLED variable) is better. I.e. why try to
magically detect all of this in perf-lib.sh itself, we know we're
going to invoke it like this in the "run" script, so we can just set
the appropriate variables there instead of this hard-to-explain magic
of $GIT_TEST_INSTALLED being one value the first time, but another one
the second time around.

 t/perf/perf-lib.sh | 4 ++++
 t/perf/run         | 8 ++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 169f92eae3..b15ee1d262 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -32,6 +32,10 @@ TEST_NO_MALLOC_CHECK=t
 if test -z "$GIT_TEST_INSTALLED"; then
 	perf_results_prefix=
 else
+	if test -n "$GIT_PERF_DIR_MYDIR_REL"
+	then
+		GIT_TEST_INSTALLED=$GIT_PERF_DIR_MYDIR_REL
+	fi
 	perf_results_prefix=$(printf "%s" "${GIT_TEST_INSTALLED%/bin-wrappers}" | tr -c "[a-zA-Z0-9]" "[_*]")"."
 	GIT_TEST_INSTALLED=$ABSOLUTE_GIT_TEST_INSTALLED
 fi
diff --git a/t/perf/run b/t/perf/run
index 9aaa733c77..0a7c8744ab 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -91,10 +91,14 @@ run_dirs_helper () {
 	if test "$mydir" = .; then
 		unset GIT_TEST_INSTALLED
 	else
-		GIT_TEST_INSTALLED="$mydir/bin-wrappers"
+		GIT_PERF_DIR_MYDIR_REL=$mydir
+		GIT_PERF_DIR_MYDIR_ABS=$(cd $mydir && pwd)
+		export GIT_PERF_DIR_MYDIR_REL GIT_PERF_DIR_MYDIR_ABS
+
+		GIT_TEST_INSTALLED="$GIT_PERF_DIR_MYDIR_ABS/bin-wrappers"
 		# Older versions of git lacked bin-wrappers; fallback to the
 		# files in the root.
-		test -d "$GIT_TEST_INSTALLED" || GIT_TEST_INSTALLED=$mydir
+		test -d "$GIT_TEST_INSTALLED" || GIT_TEST_INSTALLED=$GIT_PERF_DIR_MYDIR_ABS
 		export GIT_TEST_INSTALLED
 	fi
 	run_one_dir "$@"
-- 
2.21.0.593.g511ec345e18

