Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6C21944F
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSEX5I9B"
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B12D53
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 09:00:41 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40859dee28cso39014185e9.0
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 09:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699894839; x=1700499639; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=blYNeRoFocrDZy9JuXwHxAHgRhjwCAt8CtMEb5MoFIQ=;
        b=WSEX5I9BN7+bUJh1CQfAgeJ6jGBppAkzNaumMuvfqvri/EJbHpGRh1O2Hvp0TBkMMY
         4LW28Exna14bUZMbyVuQZuC1nRrVzZ4JvhxjOcAWAYYSU8efRjUxHsXVJmf9IwZ6q7fu
         lzGhtvllrSMr2TL9Zdk7MLDhcj0mGBezZzlqqUbTUw7JvuN1H9QxLBg/kKxLlaYvtpto
         CchWzSiBNHey3PYNxidrSUqvNpJdWwMJh1CMaceSEs4Ub8Gy+4xWa8N2pUKlNUJSLnZz
         AyDwD/vdW7G0kvLQR6oh+QH9ZnNcbwAlfxBVt4LRRVdA8rKICpLNQ5LVGREkn6hH97+A
         z+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699894839; x=1700499639;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blYNeRoFocrDZy9JuXwHxAHgRhjwCAt8CtMEb5MoFIQ=;
        b=T0W9SdR39rTLhEWUSg5H72NGeEoU/+7r1r3zZT9Jsj08hfinL5aNsblEqvz8p840Hu
         eiwuhow7Xqo4polDPfqfWCsxhUFtu6XrjdBVQA9FnPRZ/V/CU4R190mL99C6bP89Accu
         9sofpFPEWqTljzodTBdIaF7vKsa7WnPPpr87/6DEWnYAhUvd6O+XlA676ruPuAjqsjBa
         vQHd6y3PIylzvyXCZDRHtNKfF5GWPjcBGxkzC42Z82aD4m/lWnzTjCLbxle0YoNC5Oop
         Ti3/tOZGsN7c//TnXDtCRA6F/RkI2ne6LC8yyxa0uoQZxIuo0m3CdQJF9NDguFYjUd8p
         SE8w==
X-Gm-Message-State: AOJu0YwrEZ1cm3OT/oRbx5iuYe2m8TYRRQgDrZnXEdA0oSti/huRVlJ7
	pb+BHYqwv6erJycI8Rfqwdmd82JZdws=
X-Google-Smtp-Source: AGHT+IGqjSoXyXRIS41f6k502aX1If5LSHe0eJW+PxA04FMIfgjs3Cn5cv64u7XO03VK1TPeKkG3Jg==
X-Received: by 2002:a05:600c:1990:b0:408:4475:8cc1 with SMTP id t16-20020a05600c199000b0040844758cc1mr5640190wmq.35.1699894838945;
        Mon, 13 Nov 2023 09:00:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6-20020a05600c218600b00405c7591b09sm8536591wme.35.2023.11.13.09.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 09:00:38 -0800 (PST)
Message-ID: <pull.1613.git.1699894837844.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Nov 2023 17:00:37 +0000
Subject: [PATCH] ci: avoid running the test suite _twice_
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is a late amendment of 19ec39aab54 (ci: stop linking the `prove`
cache, 2022-07-10), fixing a bug that had been hidden so far.

The bug is that the `.prove` cache stores information about previous
`prove` runs (`save`) and uses them (`slow`, to run the tests in the
order from longer-running to shorter ones).

This bug can cause some surprising behavior: when the Prove cache
contains a reference to a test script, subsequent `prove` runs (with
`--state=slow`) will run the same test script again even if said script
is not specified on the `prove` command-line!

So far, this bug did not matter. Right until d8f416bbb87c (ci: run unit
tests in CI, 2023-11-09) it did not matter.

But starting with that commit, we run `prove` _twice_ in CI, and with
completely different sets of tests to run. Due to the bug, the second
invocation re-runs all of the tests that were already run as part of the
first invocation. This not only wastes build minutes, it also frequently
causes the `osx-*` jobs to fail because they already take a long time
and now are likely to run into a timeout.

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1613%2Fdscho%2Favoid-running-test-suite-twice-in-ci-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1613/dscho/avoid-running-test-suite-twice-in-ci-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1613

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
