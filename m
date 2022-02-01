Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C17C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 17:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiBARAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 12:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiBARAb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 12:00:31 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D37C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 09:00:31 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso2057972wms.4
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 09:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8xxK3oUztkD1MpAUQ3OHQmNmApNl8HTWXaUt1AciwKE=;
        b=JIzSxYqoGKNrbb1dtTUwB5/TmE0qaZL8xFRAKcknj3rvonP6XvyvlbkUedAkRbQv20
         NwoGdhQZst8tZFMagM/xKh47ZcpYcvIHrqOx2o0syLFOpPuLL7C33rxhu96JE6D44Qwj
         tfKnHft5V6WNR5L2G5ReEY3PWcXfw4mD+V2AowxzJbzOLcsWBO+SFZ5yKxnHFGnrXp/0
         x3FpQAAdWlyr3z244ts92lUkLfm7IvxQeN1izx+QDDLkwYTRtHiaDmxDDMQd9eZ+WXx/
         UVy/9p7GKeK6FI2rfurmM2KeIHb8pI9f8hbEO/GWSatnf28qMXo9a8S8hycvBRzqlw2M
         l7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8xxK3oUztkD1MpAUQ3OHQmNmApNl8HTWXaUt1AciwKE=;
        b=az9qUatsvB0twsThKHDD8jhtalB91kyqNoHttrGskkIztJ/zoOMRE3Vf9k2+XBHJnU
         WSHxJvu1HrbC14G1J/mBQihFhrcqB57TqPZ0AoDLaaUBg8WIxZ/mPa17v2K0IxNSVPzo
         aVvuMl0Y4JDWU9f6IlSdh/UhOgER790EfgbXU+X1uXP2JOIJquKHqHnFtiGu3NKPIk53
         CJPaPy+sb2gJnyPAULXEz/7uiZi2GzYAvj+WkhVGt0KrfbxXckyyQ6FO6GkBY9xAJYad
         Erluyai2cU8ehLipSBhy7jXMwTJhd0dtFxrq3ElOHsKNthCpNmVtw9Yj27m9B8ZJvlG1
         WiVQ==
X-Gm-Message-State: AOAM530VKYs+EPJO7vViiHFZPjWe2zWzxhrLlJjH8rCX1ZC87wTM2Z+n
        5LEd5PnJjkbgVCBtXNaC3s4ukPYswRk=
X-Google-Smtp-Source: ABdhPJzhU10UcDCW8lZISv/H99fgHH2D8mtWZHEmiVcciLamhcYjTN3zR66MPlgGVtrJGbAV8TAzQQ==
X-Received: by 2002:a1c:f210:: with SMTP id s16mr2597869wmc.99.1643734829467;
        Tue, 01 Feb 2022 09:00:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14sm2843156wmq.41.2022.02.01.09.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:00:28 -0800 (PST)
Message-Id: <pull.1131.v3.git.1643734828.gitgitgadget@gmail.com>
In-Reply-To: <pull.1131.v2.git.1643478692337.gitgitgadget@gmail.com>
References: <pull.1131.v2.git.1643478692337.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 17:00:25 +0000
Subject: [PATCH v3 0/3] repo-settings: fix checking for fetch.negotiationAlgorithm=default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This regression is not new in v2.35; it first appeared in v2.34. So, not
urgent.

Changes since v2:

 * Also fix the fact that fetch.negotationAlgorithm=$BOGUS_VALUE no longer
   errors out (yet another regression, this one dating back to v2.24.0), and
   add a test to make sure we don't regress it again.
 * Add 'consecutive' as a synonym for 'default', and remove 'default' from
   the documentation to guide people towards using 'consecutive' when they
   want the classic behavior.

Changes since v1:

 * Put the common code in two testcases into a function, and then just
   invoked it from each

Elijah Newren (3):
  repo-settings: fix checking for fetch.negotiationAlgorithm=default
  repo-settings: fix error handling for unknown values
  repo-settings: name the default fetch.negotiationAlgorithm
    'consecutive'

 Documentation/config/fetch.txt | 21 ++++++++++-----------
 fetch-negotiator.c             |  2 +-
 repo-settings.c                |  7 ++++++-
 repository.h                   |  2 +-
 t/t5500-fetch-pack.sh          | 24 +++++++++++++++++++++---
 5 files changed, 39 insertions(+), 17 deletions(-)


base-commit: 89bece5c8c96f0b962cfc89e63f82d603fd60bed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1131%2Fnewren%2Ffix-fetch-negotiation-algorithm-equals-default-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1131/newren/fix-fetch-negotiation-algorithm-equals-default-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1131

Range-diff vs v2:

 1:  633c873b513 ! 1:  df0ec5ffe98 repo-settings: fix checking for fetch.negotiationAlgorithm=default
     @@ t/t5500-fetch-pack.sh: test_expect_success 'use ref advertisement to prune "have
      +test_expect_success 'same as last but with config overrides' '
      +	test_negotiation_algorithm_default \
      +		-c feature.experimental=true \
     -+		-c fetch.negotiationAlgorithm=default \
     ++		-c fetch.negotiationAlgorithm=default
       '
       
       test_expect_success 'filtering by size' '
 -:  ----------- > 2:  23f692b81be repo-settings: fix error handling for unknown values
 -:  ----------- > 3:  7b28c527a90 repo-settings: name the default fetch.negotiationAlgorithm 'consecutive'

-- 
gitgitgadget
