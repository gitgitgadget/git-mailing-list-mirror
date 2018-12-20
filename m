Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 691751F405
	for <e@80x24.org>; Thu, 20 Dec 2018 16:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbeLTQZW (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 11:25:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39915 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731218AbeLTQZW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 11:25:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id f81so2842899wmd.4
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 08:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dFDIFLkMiDElyR2pPLkx2eii0ABonagn/3/EjmMoERw=;
        b=cxW7M55kyeqZq+0B5u1JQ4fNOL49Ejnb1Exw5BnG9vR7UnIzUXNEk7nu7uR8mwtaM4
         ivg8ArQmsv2pcq7nWnDUS8Ga5RJhLH9o6921TNQxgOliKR2xAgcomm2z+iQGeFhJZ8rK
         WpPfr+ooSjKIqazbChHlemIbqIJ8YoNWEq7AClK5rthteYGx5LRczD+xAiZDtPAvAQAw
         Awf+OpbmDmJRrwDg3lAmjP2ti1z68nyzmj8b5cNnHFPH5EEfXiBA02C3Ppp90kYjYbhO
         gzYab+TpXpddvHLe79flefgR/BL5jWghzKV5988izCDegY22zE+ZdxZRRtmu3qrMMZga
         yP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dFDIFLkMiDElyR2pPLkx2eii0ABonagn/3/EjmMoERw=;
        b=DsmK+RVcRZ6Xg1uUBidexffdtpGs6ty0NiGChjCbS0QHJcXfAlrYA7OQ9CXT55bpzn
         taybwV8Q76W5wKKCxbj1ovYe7gUTnMLuINMWd4UgcaXUSBJEa2OZjQNdWQygL2aTlAs5
         mDS0uvF8zgKq3JqmXOqRD3a2/SzDL95PSuk//ojXATtExndwdY/i/m5FLczQ2JAa+Pf0
         Qjub5D3Qf4F14/Ru+EyHOETqwdUR/KzBHuIxhbqiyzM29fMJWesDzbGVjq/UPXaHQQCi
         VhCBsvYMoke+f2S+wCfx+07aawJc6Wi0O3e3lzBhLFltD1SiqTNLZFmJ0JAfnQSadawV
         WFpw==
X-Gm-Message-State: AA+aEWa9oVWnAprRqd+dWjvHnuhfRhJiz+iJcTsBHtA48WwlEwppU0Wt
        FvfWT6bngL2fU4VAU4dziGw=
X-Google-Smtp-Source: AFSGD/WNxJs0k31lJ7RwtQpPZsroZuDgtDB7knGOePqMnRe1D/3O+hS1uZZSeAXor5cH7eveQ7qzjg==
X-Received: by 2002:a1c:5a42:: with SMTP id o63mr1903171wmb.88.1545323120153;
        Thu, 20 Dec 2018 08:25:20 -0800 (PST)
Received: from localhost.localdomain (x4db1e5de.dyn.telefonica.de. [77.177.229.222])
        by smtp.gmail.com with ESMTPSA id 200sm8980566wmw.31.2018.12.20.08.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 08:25:19 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/5] travis-ci: don't be '--quiet' when running the tests
Date:   Thu, 20 Dec 2018 17:24:50 +0100
Message-Id: <20181220162452.17732-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20181220162452.17732-1-szeder.dev@gmail.com>
References: <20181220162452.17732-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All Travis CI build jobs run the test suite with 'make --quiet test'.

On one hand, being quiet doesn't save us from much clutter in the
output:

  $ make test |wc -l
  861
  $ make --quiet test |wc -l
  848

It only spares 13 lines, mostly the output of entering the 't/'
directory and the pre- and post-cleanup commands, which is negligible
compared to the ~700 lines printed while building Git and the ~850
lines of 'prove' output.

On the other hand, it's asking for trouble.  In our CI build scripts
we build Git and run the test suite in two separate 'make'
invocations.  In a prelimiary version of one of the later patches in
this series, to explicitly specify which compiler to use, I changed
them to basically run:

  make CC=$CC
  make --quiet test

naively thinking that it should Just Work...  but then that 'make
--quiet test' got all clever on me, noticed the changed build flags,
and then proceeded to rebuild everything with the default 'cc'.  And
because of that '--quiet' option, it did so, well, quietly, only
saying "* new build flags", and it was by mere luck that I happened to
notice that something is amiss.

Let's just drop that '--quiet' option when running the test suite in
all build scripts.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/run-build-and-tests.sh | 4 ++--
 ci/run-linux32-build.sh   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index cda170d5c2..84431c097e 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -8,7 +8,7 @@
 ln -s "$cache_dir/.prove" t/.prove
 
 make --jobs=2
-make --quiet test
+make test
 if test "$jobname" = "linux-gcc"
 then
 	export GIT_TEST_SPLIT_INDEX=yes
@@ -17,7 +17,7 @@ then
 	export GIT_TEST_OE_DELTA_SIZE=5
 	export GIT_TEST_COMMIT_GRAPH=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
-	make --quiet test
+	make test
 fi
 
 check_unignored_build_artifacts
diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index 2c60d2e70a..26c168a016 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -56,5 +56,5 @@ linux32 --32bit i386 su -m -l $CI_USER -c '
 	cd /usr/src/git
 	test -n "$cache_dir" && ln -s "$cache_dir/.prove" t/.prove
 	make --jobs=2
-	make --quiet test
+	make test
 '
-- 
2.20.1.151.gec613c4b75

