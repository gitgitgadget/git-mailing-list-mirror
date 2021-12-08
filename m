Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278EAC433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 15:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbhLHPYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbhLHPYL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 10:24:11 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B66C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 07:20:39 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id be32so4483132oib.11
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 07:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=PPDrKdMXqG+yfVl4haCFmBr3mRsYp7W5LJi0vnEuF2M=;
        b=ZlxcBKCXt4FK9+L/aterbh5aVX19unABZI75rjogXinfOYegpqbiiittJonDjxmFYt
         /Bhx3kb1XAAU14aW1lcvmEtqqzXaKdjzvkNx7EWVOqABErgZySeWGonAB1+6ENiiWScq
         KT/KZ369U46c042xPDpxK6/L9Dus7pjbr1wFUjet9D8ekFijogydube7P8zC4zm2I8/+
         8yV4ve2rVFbW+URtY0Az9IM39g2TQ1gvwrnPcLrG9bRiBmDvPcgadsEMQYHuYkKqAbvb
         LTsNGy+zMupka6mR2KHgjJwlLxp5AcUPbQv+NrRkb1bJ7/ED2IQaZwIHebLm2hZWFsXi
         U9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=PPDrKdMXqG+yfVl4haCFmBr3mRsYp7W5LJi0vnEuF2M=;
        b=Z8TZPtVO6WdXpKqh+Ok3OpJHbz8t+ON2BEPs9L4fhs+llFFHUi8aU4FiYa3Cxu5Z88
         7ulAC77Lnpgk2pHpbszwxfk60q+/ROp45jzMPxFaNZg1QEGIrMezMTL9Wp4Xgju7GPXU
         iTHO2GvZ0kQhZn1NAq4x4Sm49q1+u0jUY0TxHEnad/1ABs0tw0Kl5oB9cBEI+I34RhlT
         IV4wZSdJVRrWXnX9U3yb4M1lYlHyq5rwKHz0a2XB0+G/4zLh5FRkyNHmD8mJ/rNYJhGU
         OEKD7TkxCh3QPidVrXsm4kbgmdu6x/DlN9a+zM1nSUtE4v+RqRfObkQMPYOgJ8kxyoPY
         E8BA==
X-Gm-Message-State: AOAM531ZXwQ4DfR8ZKEi7YZE/+sGQAFZ4+uCcJSdlwjYrBMFEc6ABOL9
        Veec/6PCoN9hzxBUyehzalc=
X-Google-Smtp-Source: ABdhPJxfJaV6MlTh7qzL8zUTiOtXuMiPkTZNpBSPCzNcHhTfJuiBXWeBTEDmOamTVAX3yk8h+dPrew==
X-Received: by 2002:a05:6808:2217:: with SMTP id bd23mr160022oib.11.1638976839187;
        Wed, 08 Dec 2021 07:20:39 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:5056:be20:f10c:bfd5? ([2600:1700:e72:80a0:5056:be20:f10c:bfd5])
        by smtp.gmail.com with ESMTPSA id u6sm756124oiu.34.2021.12.08.07.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 07:20:38 -0800 (PST)
Message-ID: <7dac5ebc-fe01-4041-4f1c-0641edc3776c@gmail.com>
Date:   Wed, 8 Dec 2021 10:20:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] ls-files: add --sparse option
Content-Language: en-US
From:   Derrick Stolee <stolee@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        vdye@github.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
 <e42c0feec94de0e4869cda1fc6b28bd7055774e3.1637077083.git.gitgitgadget@gmail.com>
 <211123.86h7c3wrg2.gmgdl@evledraar.gmail.com>
 <03a642fc-6310-1ea4-083e-9fe4530cf761@gmail.com>
In-Reply-To: <03a642fc-6310-1ea4-083e-9fe4530cf761@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/8/2021 10:14 AM, Derrick Stolee wrote:

> Taking your idea and applying it to 'ls-files' (without --stage to
> avoid OIDs which would change depending on the hash algorithm), the
> start of the test looks like this:
> 
> test_expect_success 'ls-files' '
> 	init_repos &&
> 
> 	# Behavior agrees by default. Sparse index is expanded.
> 	test_all_match git ls-files &&
> 
> 	# With --sparse, the sparse index data changes behavior.
> 	git -C sparse-index ls-files --stage >out &&
> 	git -C sparse-index ls-files --stage --sparse >sparse &&

Of course, I had a stale version here... "--stage" should not be here.
 
Thanks,
-Stolee
