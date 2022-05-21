Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D29C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 22:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347184AbiEUWTQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 18:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347077AbiEUWTF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 18:19:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061164EF53
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w4so15875671wrg.12
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IALL0QMC0v8ysobvDm4KtZMwa6z5A/re01nuKPjfC2M=;
        b=SmCjqgVfXftHeCK7Ug1T6doqz7axxkZFem0AiCG7JV2ZTI/ts2JJzlWJ5e9uBJNaJR
         CQ+3XsR+VmK/SynE9qZ7ieu6NLZPgKyA4kZjH8U9dmt/Hi0lw7KdSGOhwyHEXfn0DiSq
         xYuOqCsLh/+wh83mA7GR5hUTF8E/1iHoc6nlwJLtJ0sMrjG7BXjeV5PalawVwpXJJUAb
         cBIrbtd+wJ0z1xDojqAfUpf8MSo/MVT6HhPXelb3pX1a9ySDl+pnxY/MUNiO4fdNzsv6
         ePwsWbngvwrqDA1ONfj+FU4UHhTwfz18G4lC7n6v/bAJUiupf3tL7zLMJ8v192+HZnD1
         RoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IALL0QMC0v8ysobvDm4KtZMwa6z5A/re01nuKPjfC2M=;
        b=irZRBr4yt+kX2WP0Uy6kLlSHe9S/fhfJ10rqpspHB0MYwh68nnyOXEcqpgJ4MUfAY7
         pmkJIV6JkL/7Gfg4RlqSILv4TVGu+tsMHsJhMvm3AQOAADSkJMtTKRryu27Raq3CXooq
         8eT/uh30JJX28cEbAbAzsKV5o39Vx7e1X0Mpe7YZ4nVTg0VEWyIiJAKydmzCQl3KcFX+
         hQUJe0Z8PgUb5p1lV2JyEUJ9sVU5mgCPT1DaLQl1NnJo7wBtrYaIjAGK9uhZVZ/Jpk6+
         t+8wkoGqJpdMxwAXYIMlryguOhDhQSSF3xmHo4sYdTwNRBvSQ+OEs/d35S8UQzuiGK+d
         fa/Q==
X-Gm-Message-State: AOAM5320M7gBQzN58B3EV0I2h3Fq04QyyUpONylmc2gjZ9cFud+Puat0
        3uGaiCE1fukGg7mmv4UZ6P2XEWiXj3E=
X-Google-Smtp-Source: ABdhPJwIVZd4ORzpGg/bdbaENaxOQFONEmrTNBZBNpmiB1po9DBKrS+Dysn5GD7rgsMvLgXIcBpJmA==
X-Received: by 2002:adf:f611:0:b0:20d:1317:5bae with SMTP id t17-20020adff611000000b0020d13175baemr13056841wrp.359.1653171542144;
        Sat, 21 May 2022 15:19:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g10-20020adfa58a000000b0020e60baffd1sm2702432wrc.52.2022.05.21.15.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 15:19:01 -0700 (PDT)
Message-Id: <8f5b112bd08dcaf63ea764be71a17942c184de0e.1653171536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
References: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
        <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 22:18:48 +0000
Subject: [PATCH v3 04/12] ci/run-build-and-tests: take a more high-level view
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the web UI of GitHub workflows, failed runs are presented with the
job step that failed auto-expanded. In the current setup, this is not
helpful at all because that shows only the output of `prove`, which says
which test failed, but not in what way.

What would help understand the reader what went wrong is the verbose
test output of the failed test.

The logs of the failed runs do contain that verbose test output, but it
is shown in the _next_ step (which is marked as succeeding, and is
therefore _not_ auto-expanded). Anyone not intimately familiar with this
would completely miss the verbose test output, being left mostly
puzzled with the test failures.

We are about to show the failed test cases' output in the _same_ step,
so that the user has a much easier time to figure out what was going
wrong.

But first, we must partially revert the change that tried to improve the
CI runs by combining the `Makefile` targets to build into a single
`make` invocation. That might have sounded like a good idea at the time,
but it does make it rather impossible for the CI script to determine
whether the _build_ failed, or the _tests_. If the tests were run at
all, that is.

So let's go back to calling `make` for the build, and call `make test`
separately so that we can easily detect that _that_ invocation failed,
and react appropriately.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/run-build-and-tests.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 280dda7d285..2818b3046ae 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -10,7 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
 *) ln -s "$cache_dir/.prove" t/.prove;;
 esac
 
-export MAKE_TARGETS="all test"
+run_tests=t
 
 case "$jobname" in
 linux-gcc)
@@ -41,14 +41,15 @@ pedantic)
 	# Don't run the tests; we only care about whether Git can be
 	# built.
 	export DEVOPTS=pedantic
-	export MAKE_TARGETS=all
+	run_tests=
 	;;
 esac
 
-# Any new "test" targets should not go after this "make", but should
-# adjust $MAKE_TARGETS. Otherwise compilation-only targets above will
-# start running tests.
-make $MAKE_TARGETS
+make
+if test -n "$run_tests"
+then
+	make test
+fi
 check_unignored_build_artifacts
 
 save_good_tree
-- 
gitgitgadget

