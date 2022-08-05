Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2D0C3F6B0
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 17:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241476AbiHER7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241570AbiHER7V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 13:59:21 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDFF796A1
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 10:59:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l22so4044572wrz.7
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=flNOUpFpQNk5mfo8GE8lZF5pNYZBrO+OeLGye5bTl1g=;
        b=Cb1FRpMBZXfWMtiuwm1IOfB3d7m4MyL3QMqN0m6ETrXzlNXqq7KSKC+InDr5yN/S/O
         cfXDa5xqqxosnsjRKiwJ4U9ZE84SdQ6UP8SjMwJtvein1kx7N4pGkGlnW9aIJXZS2ZyA
         haitvAJSjZvr94vYPw3Usvag4LDJtS9tE3MxQ0DD1WHrgUAMTKNnwnSZFMe5QCIL8KWQ
         DsDtAt2rxkbHQerdMQjS6FdxaYXq+saTEGnEiVtHcVFrG0qw8yaJXArlDTA73vc5hHQn
         pQBCFFfbaBqlQg6Z60nP0w66sdKmH7HbxQy2KM56zObLo3b5Qllea0wJihIUOmqAZQr0
         HZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=flNOUpFpQNk5mfo8GE8lZF5pNYZBrO+OeLGye5bTl1g=;
        b=dyCo41Ts1xj1FR3QUU2I60Xe5VoHNghw1wdAsNLLZ59OB0YN5DEjkMSRNYvNAynkxm
         j7/KopS7sc771EoWoE975LPz5yj/y1vcN3XHQeoNiznCPO8zSl1OVjpg1SeOb1TxlzvE
         Ien2YTqRrr+R0fMb1W88EwY/40ePiOnatb77GchvGMnzdqs2J9KMVVr21aAXgKMgE5xN
         pbGje5uQmmbt2cPz3Jsj/iHYcqzVB8oqL5z48DnvP6jYJwyGMfo4UrS8u+aTURtZM9Ze
         DDFe7S1ddlfWyaoVlfiBWT3ETuOmSB5xSzwEgEoqyBQcT904LhB+QQsUB+e6u67QVDoG
         4F4g==
X-Gm-Message-State: ACgBeo0/GPp/+rvM7BCNRAPYsrV7MP9juUKSqyPv8SwSgcGjyWRVKPt1
        uA3WCvFyUBLnUPpka1ViZp7S9kO6DRQ=
X-Google-Smtp-Source: AA6agR7QBG9MwK7554yJLjg8T0GXNEs+RchfOBgZ4kJaD/HM+eONK+aewC9kJSW4xL3gPfd3k1HN0Q==
X-Received: by 2002:a05:6000:1883:b0:205:c0cb:33c6 with SMTP id a3-20020a056000188300b00205c0cb33c6mr5302728wri.39.1659722345232;
        Fri, 05 Aug 2022 10:59:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c4f4d00b003a3200bc788sm10334644wmq.33.2022.08.05.10.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:59:04 -0700 (PDT)
Message-Id: <1f4d9bc4b3feb0d95a24c4ffb900070f7c9c7e1b.1659722324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
References: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Aug 2022 17:58:42 +0000
Subject: [PATCH v3 10/11] maintenance: stop writing log.excludeDecoration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This reverts commit 96eaffebbf3d0 (maintenance: set
log.excludeDecoration durin prefetch, 2021-01-19).

The previous change created a default decoration filter that does not
include refs/prefetch/, so this modification of the config is no longer
needed.

One issue that can happen from this point on is that users who ran the
prefetch task on previous versions of Git will still have a
log.excludeDecoration value and that will prevent the new default
decoration filter from being active. Thus, when we add the refs/bundle/
namespace as part of the bundle URI feature, those users will see
refs/bundle/ decorations.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/gc.c           |  6 ------
 t/t7900-maintenance.sh | 21 ---------------------
 2 files changed, 27 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index eeff2b760e0..6c222052177 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -910,12 +910,6 @@ static int fetch_remote(struct remote *remote, void *cbdata)
 
 static int maintenance_task_prefetch(struct maintenance_run_opts *opts)
 {
-	git_config_set_multivar_gently("log.excludedecoration",
-					"refs/prefetch/",
-					"refs/prefetch/",
-					CONFIG_FLAGS_FIXED_VALUE |
-					CONFIG_FLAGS_MULTI_REPLACE);
-
 	if (for_each_remote(fetch_remote, opts)) {
 		error(_("failed to prefetch remotes"));
 		return 1;
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 74aa6384755..62ed694a404 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -162,7 +162,6 @@ test_expect_success 'prefetch multiple remotes' '
 	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remotes/remote1/one &&
 	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remotes/remote2/two &&
 
-	test_cmp_config refs/prefetch/ log.excludedecoration &&
 	git log --oneline --decorate --all >log &&
 	! grep "prefetch" log &&
 
@@ -173,26 +172,6 @@ test_expect_success 'prefetch multiple remotes' '
 	test_subcommand git fetch remote2 $fetchargs <skip-remote1.txt
 '
 
-test_expect_success 'prefetch and existing log.excludeDecoration values' '
-	git config --unset-all log.excludeDecoration &&
-	git config log.excludeDecoration refs/remotes/remote1/ &&
-	git maintenance run --task=prefetch &&
-
-	git config --get-all log.excludeDecoration >out &&
-	grep refs/remotes/remote1/ out &&
-	grep refs/prefetch/ out &&
-
-	git log --oneline --decorate --all >log &&
-	! grep "prefetch" log &&
-	! grep "remote1" log &&
-	grep "remote2" log &&
-
-	# a second run does not change the config
-	git maintenance run --task=prefetch &&
-	git log --oneline --decorate --all >log2 &&
-	test_cmp log log2
-'
-
 test_expect_success 'loose-objects task' '
 	# Repack everything so we know the state of the object dir
 	git repack -adk &&
-- 
gitgitgadget

