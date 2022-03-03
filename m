Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805C6C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiCCA7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiCCA6v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:58:51 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F3A1520E4
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:58:07 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id t7-20020a634447000000b0036579648983so1904336pgk.3
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6LHfocVCl0x5QxdLkS1NpmZZntUa5PvWBsf0u+hjqLM=;
        b=TmoqsX9mCo1LMeEXDz2jWjpK2RaG2D6EE9CiYaEYlYhg1npeExKpZLyvV5M1XiZpA6
         IKBU2+sC6i7JH7grf33YrPh+W6YHWCjILYcTFuhaDf/pVj3MYVMkyBjbGpgizsZu6hQx
         R4WuScOoRDMsYTyqi+cX7SA/HxAkDA/n4fe13bmDzvnNiTLUmMg5xaeMK+o8FldnfgBl
         D8fxupK17xc/Bj7LcUIqNhglUJzdSTm0q/u8COKgeDciaA+EUEKOtsLXWUFrUGEvCjOJ
         AvPgc6ZpI3/giSpaWt4SiR4zZFfjpG0mR7DQUL+sPYj+R5Qi6rENegcaOWkQWwaaPReW
         P+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6LHfocVCl0x5QxdLkS1NpmZZntUa5PvWBsf0u+hjqLM=;
        b=RBJc+sIuCd1Wc6RiFnN0y437oAaAE8MHQ9rX/5+HeM69S4Plw5lRwc9ibxHR+ZdubI
         JOL3dMj6pWvO22Kn/69jqvmY9Zy1qXYx58GLHm2Gzc5nMhK5UzjUcnYdoEKI7t8WAc5x
         Fn7Oqp+66FxArNroB2GyB+FOfpZbXBEDuH/2xYJVjy7E4hGSioNdrJrq2qN5EuZeeUn5
         e8VK7F5NGuoDecJGmrKEaAVg9ebWYrQoh+DWLmGh4fySPPuxgOmCHtRHtaMu/Ebj/ej4
         gZd/4MDkhT/Mw20qTscY/5WKWuQYhRjQDZsZ7PuSwPqbVrrjUK/NtiuvdwAGpL4Ak3jM
         veKg==
X-Gm-Message-State: AOAM530tkNmFp7xr1Hv3Y0No6YtRwY/8QsYQQq+m/c/SjKzuEa4tJqN5
        KBE2iWeS2V07NFtPcqM4J/l9TfTY0HE2oM/++M5zIHM9Li2sgTIrj/VRSIHMbND1RX7C2vWTY2z
        wWYo/mlm+Y85nkzCHnCaMCoqvp0TN71RFzBdtWN3TMrIEzYgQgC0fSfLB9QE0Px8=
X-Google-Smtp-Source: ABdhPJxtNfer0NirTzhpBCI7ayjNNjTMwKakD94lw4tlNhuQG42rfRsGR6QxAwZm/80SVeTlPdjYgA3LhZ7AVQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:db0d:b0:14f:b047:8d22 with SMTP
 id m13-20020a170902db0d00b0014fb0478d22mr33417430plx.90.1646269086396; Wed,
 02 Mar 2022 16:58:06 -0800 (PST)
Date:   Wed,  2 Mar 2022 16:57:26 -0800
In-Reply-To: <20220303005727.69270-1-chooglen@google.com>
Message-Id: <20220303005727.69270-13-chooglen@google.com>
Mime-Version: 1.0
References: <20220301044132.39474-1-chooglen@google.com> <20220303005727.69270-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 12/13] submodule update: add tests for --filter
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test the "--filter" option to make sure we don't break anything while
refactoring "git submodule update".

Signed-off-by: Glen Choo <chooglen@google.com>
---
 t/t7406-submodule-update.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 7764c1c3cb..000e055811 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1071,4 +1071,16 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
 	)
 '
 
+test_expect_success 'submodule update --filter requires --init' '
+	test_expect_code 129 git -C super submodule update --filter blob:none
+'
+
+test_expect_success 'submodule update --filter sets partial clone settings' '
+	test_when_finished "rm -rf super-filter" &&
+	git clone cloned super-filter &&
+	git -C super-filter submodule update --init --filter blob:none &&
+	test_cmp_config -C super-filter/submodule true remote.origin.promisor &&
+	test_cmp_config -C super-filter/submodule blob:none remote.origin.partialclonefilter
+'
+
 test_done
-- 
2.33.GIT

