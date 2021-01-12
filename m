Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CEAC433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F17702311B
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404100AbhALQuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 11:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbhALQuW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 11:50:22 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E4AC061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:49:42 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id x13so2869608oto.8
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j+SpEGie0i3oizqbxNf1NRYuC3dYBFcED5pr13eC9ew=;
        b=eg3Jnox2WHndnBvu7aTHOV4brm3VX7f0rvEGwciXAYkFCdWH3MNWEK8iIbGDeOSK6n
         nI4P/3O3XCEEegEKfyW5V9OrIYKUYAWRDxxTzoFpurr7UCNY0zPpdqPvSGtKiEXeHbhJ
         Mts+wso+/OGzy8zs+IVcriZItBY04xdF4FtxTo0Lw9O5d9jbemMUqMtRMd67fzULjvlh
         8kENz2dQweFFvSyhxsj0qHX3RvOFRm3UCJgU97i1RKUEZQsQLmj+TAUhy7DLtQ2xmxuN
         9+WSBLizo9JA6LH+RL5XHUL668bTPYXRNLzVHzablY6ZJGVZ1n0rKnsuFwByyBMOfWgY
         NPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j+SpEGie0i3oizqbxNf1NRYuC3dYBFcED5pr13eC9ew=;
        b=W51wJ6sSnZ71YERgnPLXElQ8NdvBTZHsZpUI+TFIrhBFon6tCYaRny0i8Mp80PORRI
         3sM/Fou4JBlPDlLvxyU5M1dVMdrZZLvvES3pxCcbOm1Fy5Z1JEqLfVorXHKu4lQm0YIG
         nCFJt31bE4TqQCiZ/rXNL8RC/Yd+/Nythy2Nm1hPmuMWZXhAV9YNC5oVInyClFuaJO/J
         pvGv7K47OH5SymE9DinbtfWN5k/ObqJS0agXfcCI3MQEhmBU2/EHv01oETNRMiKgZIOB
         d1mE6Tm4RPtPXkbQfY5R2w+CL5k+8vE0dRwXtKBk/0yp1aKkeO4mbzoDdLehBdkbwHK3
         E0TA==
X-Gm-Message-State: AOAM532MinekoR2vwN28Kp74jQ825isJZVeSUsgsVtEzN4KCfIQG65tR
        FyKqEAK/QyCliOWeLRjeAyo=
X-Google-Smtp-Source: ABdhPJxcJ2xfosFxrC6ijU+fVlppTsU7LVYTnLHhY4slEi1r0f8F/atqxA0uMJmSwjjzC9u9R0JI3A==
X-Received: by 2002:a9d:220b:: with SMTP id o11mr200637ota.212.1610470181998;
        Tue, 12 Jan 2021 08:49:41 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id l5sm726345otj.57.2021.01.12.08.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 08:49:41 -0800 (PST)
Subject: Re: [PATCH 7/8] t: support GIT_TEST_WRITE_REV_INDEX
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
References: <cover.1610129989.git.me@ttaylorr.com>
 <3525c4d114c8655953aca44d8effa1652ccc93d3.1610129989.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9879225b-216a-574b-7bf8-a5f772732182@gmail.com>
Date:   Tue, 12 Jan 2021 11:49:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <3525c4d114c8655953aca44d8effa1652ccc93d3.1610129989.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/8/2021 1:20 PM, Taylor Blau wrote:
> Add a new option that unconditionally enables the pack.writeReverseIndex
> setting in order to run the whole test suite in a mode that generates
> on-disk reverse indexes.
> 
> Once on-disk reverse indexes are proven out over several releases, we
> can change the default value of that configuration to 'true', and drop
> this patch.

...

> +GIT_TEST_WRITE_REV_INDEX=<boolean>, when true enables the
> +'pack.writeReverseIndex' setting.
> +

Should this also be added to the second run of the test
suite with optional variables?

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 6c27b886b8f..d1cbf330a14 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -22,6 +22,7 @@ linux-gcc)
 	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
 	export GIT_TEST_ADD_I_USE_BUILTIN=1
+	export GIT_TEST_WRITE_REV_INDEX=1
 	make test
 	;;
 linux-clang)

Thanks,
-Stolee
