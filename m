Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62B424A0A
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvg4+3kI"
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D898810CE
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 12:25:11 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4083f61322fso38015175e9.1
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 12:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699907109; x=1700511909; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oZeWSXfRB+Cds2vRcT/IHwdO90034fjc9arZYIwaQA=;
        b=bvg4+3kI0rRAIAjell4/8DqK2+/8VoKPKjzJG65Y/3k44nv7RuQs9uSIVxalxUirE1
         TlIleImn9vaQLRlL6TPqLONe19h0p1Pcun5ek46Z3VPSAeqbHynUSElCjbFLjDbsVma7
         qP3o1EEKNy+/VlvK+xh/mVXVOD07FaLRtZthDXDD5YG4pYYsDtmUa4UNnES1ZGklekCo
         4icFS7YMbWi5JG5Z7wbI1zdCvyHXqytTRhsOOBDCRmHeJC4bz25qhJmUeZ7yBroej0ZV
         aMnaiD56MA5AcvolDdYsul8qgnccpasFTG0F2RKR317EeonPxODXZri2begXNDygnT8N
         aOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699907109; x=1700511909;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oZeWSXfRB+Cds2vRcT/IHwdO90034fjc9arZYIwaQA=;
        b=LNkMjxTZ3eu0KRJwDKpDzSkZpBHyZ4+NYYlfDa037Mj4rGqM3r0Z0ArmcuaHwthd9l
         t/8+tFRxO1nr/vgclksUdNHzx/hSNJD13yHxCC5foh/hPugV+M7Ekt47lzjypk2bCs7r
         XztaL2o27wxsF0EdtP+4KSB50XYm09n1J9s0iR4t5Mp5Mp9TGLIe9xT8APiJm2uJVd2K
         ZGAn+AduMyhQ6MvZisv+1iTvm/z17wbDHLBADXhWyuA3iUrXC3u+VG+WcgEOQRdBypJc
         JGIokpFRNtbHl4cg+V8/0L/TwmFU12xFB/amcpBqG/mXs3BiQJW6BNXmQlx7BtwkXtP+
         /1VA==
X-Gm-Message-State: AOJu0YyTYAUQkcEKM2RoR678qg/qiyLxflFjxDIP9yPPjG+dmGUkdRNE
	w2fP3zpbnpWy7GpSgYAp3L1sj8hHCDs=
X-Google-Smtp-Source: AGHT+IFnDhhaj2XlYytAdkuvRBCi5UQ29Ti2ji0qvy4IIGcdRBNsismRwpTionp0WDH5s8O6PQ8PsA==
X-Received: by 2002:a1c:7502:0:b0:408:39d3:a26b with SMTP id o2-20020a1c7502000000b0040839d3a26bmr6434368wmc.40.1699907109411;
        Mon, 13 Nov 2023 12:25:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c231a00b004064741f855sm8967945wmo.47.2023.11.13.12.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:25:09 -0800 (PST)
Message-ID: <pull.1613.v2.git.1699907108371.gitgitgadget@gmail.com>
In-Reply-To: <pull.1613.git.1699894837844.gitgitgadget@gmail.com>
References: <pull.1613.git.1699894837844.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Nov 2023 20:25:08 +0000
Subject: [PATCH v2] ci: avoid running the test suite _twice_
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is a late amendment of 4a6e4b960263 (CI: remove Travis CI support,
2021-11-23), whereby the `.prove` file (being written by the `prove`
command that is used to run the test suite) is no longer retained
between CI builds: This feature was only ever used in the Travis CI
builds, we tried for a while to do the same in Azure Pipelines CI runs
(but I gave up on it after a while), and we never used that feature in
GitHub Actions (nor does the new GitLab CI code use it).

Retaining the Prove cache has been fragile from the start, even though
the idea seemed good at the time, the idea being that the `.prove` file
caches information about previous `prove` runs (`save`) and uses them
(`slow`) to run the tests in the order from longer-running to shorter
ones, making optimal use of the parallelism implied by `--jobs=<N>`.

However, using a Prove cache can cause some surprising behavior: When
the `prove` caches information about a test script it has run,
subsequent `prove` runs (with `--state=slow`) will run the same test
script again even if said script is not specified on the `prove`
command-line!

So far, this bug did not matter. Right until d8f416bbb87c (ci: run unit
tests in CI, 2023-11-09) did it not matter.

But starting with that commit, we invoke `prove` _twice_ in CI, once to
run the regular test suite of regression test scripts, and once to run
the unit tests. Due to the bug, the second invocation re-runs all of the
tests that were already run as part of the first invocation. This not
only wastes build minutes, it also frequently causes the `osx-*` jobs to
fail because they already take a long time and now are likely to run
into a timeout.

The worst part about it is that there is actually no benefit to keep
running with `--state=slow,save`, ever since we decided no longer to
try to reuse the Prove cache between CI runs.

So let's just drop that Prove option and live happily ever after.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci: avoid running the test suite twice
    
    This
    [https://github.com/git/git/actions/runs/6845537889/job/18614840166] is
    an example of a osx-* job that times out. Here
    [https://github.com/git/git/actions/runs/6845537889/job/18614840166#step:4:839],
    it is running t0013, and here
    [https://github.com/git/git/actions/runs/6845537889/job/18614840166#step:4:2765],
    it is run again (in the middle of the entire test suite, as part of make
    unit-tests).
    
    While this tries to fix a bug uncovered by js/doc-unit-tests, to avoid
    merge conflicts, this is based on ps/ci-gitlab.
    
    Changes since v1:
    
     * Reworded the commit message, specifically avoiding a reference to a
       patch that has not been upstreamed from Git for Windows yet.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1613%2Fdscho%2Favoid-running-test-suite-twice-in-ci-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1613/dscho/avoid-running-test-suite-twice-in-ci-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1613

Range-diff vs v1:

 1:  c74eda36246 ! 1:  880f2c19478 ci: avoid running the test suite _twice_
     @@ Metadata
       ## Commit message ##
          ci: avoid running the test suite _twice_
      
     -    This is a late amendment of 19ec39aab54 (ci: stop linking the `prove`
     -    cache, 2022-07-10), fixing a bug that had been hidden so far.
     -
     -    The bug is that the `.prove` cache stores information about previous
     -    `prove` runs (`save`) and uses them (`slow`, to run the tests in the
     -    order from longer-running to shorter ones).
     -
     -    This bug can cause some surprising behavior: when the Prove cache
     -    contains a reference to a test script, subsequent `prove` runs (with
     -    `--state=slow`) will run the same test script again even if said script
     -    is not specified on the `prove` command-line!
     +    This is a late amendment of 4a6e4b960263 (CI: remove Travis CI support,
     +    2021-11-23), whereby the `.prove` file (being written by the `prove`
     +    command that is used to run the test suite) is no longer retained
     +    between CI builds: This feature was only ever used in the Travis CI
     +    builds, we tried for a while to do the same in Azure Pipelines CI runs
     +    (but I gave up on it after a while), and we never used that feature in
     +    GitHub Actions (nor does the new GitLab CI code use it).
     +
     +    Retaining the Prove cache has been fragile from the start, even though
     +    the idea seemed good at the time, the idea being that the `.prove` file
     +    caches information about previous `prove` runs (`save`) and uses them
     +    (`slow`) to run the tests in the order from longer-running to shorter
     +    ones, making optimal use of the parallelism implied by `--jobs=<N>`.
     +
     +    However, using a Prove cache can cause some surprising behavior: When
     +    the `prove` caches information about a test script it has run,
     +    subsequent `prove` runs (with `--state=slow`) will run the same test
     +    script again even if said script is not specified on the `prove`
     +    command-line!
      
          So far, this bug did not matter. Right until d8f416bbb87c (ci: run unit
     -    tests in CI, 2023-11-09) it did not matter.
     -
     -    But starting with that commit, we run `prove` _twice_ in CI, and with
     -    completely different sets of tests to run. Due to the bug, the second
     -    invocation re-runs all of the tests that were already run as part of the
     -    first invocation. This not only wastes build minutes, it also frequently
     -    causes the `osx-*` jobs to fail because they already take a long time
     -    and now are likely to run into a timeout.
     +    tests in CI, 2023-11-09) did it not matter.
     +
     +    But starting with that commit, we invoke `prove` _twice_ in CI, once to
     +    run the regular test suite of regression test scripts, and once to run
     +    the unit tests. Due to the bug, the second invocation re-runs all of the
     +    tests that were already run as part of the first invocation. This not
     +    only wastes build minutes, it also frequently causes the `osx-*` jobs to
     +    fail because they already take a long time and now are likely to run
     +    into a timeout.
      
          The worst part about it is that there is actually no benefit to keep
          running with `--state=slow,save`, ever since we decided no longer to


 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 6dfc90d7f53..307a8df0b5a 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -281,7 +281,7 @@ else
 fi
 
 MAKEFLAGS="$MAKEFLAGS --jobs=$JOBS"
-GIT_PROVE_OPTS="--timer --jobs $JOBS --state=failed,slow,save"
+GIT_PROVE_OPTS="--timer --jobs $JOBS"
 
 GIT_TEST_OPTS="$GIT_TEST_OPTS --verbose-log -x"
 case "$CI_OS_NAME" in

base-commit: 0e3b67e2aa25edb7e1a5c999c87b52a7b3a7649a
-- 
gitgitgadget
