Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06880C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 15:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbiLBPi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 10:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiLBPiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 10:38:25 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBA69D2FD
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 07:38:22 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id y2so419425ily.5
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 07:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+F1pHa6xDLUdxYyHwoO8jO4euEarKxpbOFFbtYzL/4=;
        b=W4v7ypNexJls/dqyJ2Fyxnt6s+v1cxfrw6tEupMW7gbPfkfxlLf7wD2rYk031cga3o
         60c0YFdsaGy/1Y5IvVuBTVVMahZhykNDLiROi3wGoXagG0awv2Z2IMC8AAdhUqVc9Ttm
         jAKDxTr4HfEWMU4Bf08wE/XrLJRzIxIgY0fhQS8RiCko0CKC4srPIGRymM5jAuharWWF
         85HrobUs6XjsJfGum/jNSw3gnxcxohb+NGitR+EDU20AKM6k5S42rp102mVBH6KEfvDV
         tEnpjEt9rPk4mSZzUGX3CjFsoi0/60KJgMB1C3xk8HAg0w4ujjyqsr2U8rFhT8kJfCnK
         3Pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+F1pHa6xDLUdxYyHwoO8jO4euEarKxpbOFFbtYzL/4=;
        b=YFJLmnjvyMbpYiIkU+KON6VMxjNZ9QV0kCWRGXZD3zQbIEHW68CvQg+dlpAS6EMc4t
         2ZoAzucwBdDBUPzvigYRQGurV5qNHnVIoZcI+0CdEYYV8wcADEBTNPCg9uTrwFRD3Dak
         j0eXuoLIstdi3XDcGq6tyoysFdCPR2ve9Le2hEu9CDUfz//3u/IUf5vqGRDVmzSKj81G
         WuA1Uxmo2wPjEkZUCHuLudgDKtj56YZNAuhE0bDMXvJQ1jK/BH9pXGkrEopc6e3N6z/C
         ejr8fxxgbI6R/tblmggJ+LtP4dDatPc62LxWwaj+S6j7JhRSOldrx+1nDaawbrlXY3oj
         7emA==
X-Gm-Message-State: ANoB5pmriSCizPvf+lxLnz5V7lWDu/lrBcYTgJzGkMuS52MQeAgbO97n
        A+gwkc01F71H9F8+V8ljIotNlh2yCIdzEdo=
X-Google-Smtp-Source: AA0mqf68m9Kx3x31cCdJE+iRCsrl/0/tRnuuyQcDoXOIrc1zvB6WC3/8uTFa0d94Nz6kcUoqk9MjaA==
X-Received: by 2002:a92:b50c:0:b0:302:f954:e74 with SMTP id f12-20020a92b50c000000b00302f9540e74mr17488054ile.220.1669995502059;
        Fri, 02 Dec 2022 07:38:22 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:8051:a31f:2c93:87e9? ([2600:1700:e72:80a0:8051:a31f:2c93:87e9])
        by smtp.gmail.com with ESMTPSA id 67-20020a021146000000b00389cb050d1bsm2759921jaf.33.2022.12.02.07.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 07:38:21 -0800 (PST)
Message-ID: <7f94bda0-9f08-f179-3e7e-a791a607657e@github.com>
Date:   Fri, 2 Dec 2022 10:38:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 5/9] bundle-uri client: add boolean transfer.bundleURI
 setting
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        =?UTF-8?Q?=c3=86var_Arnfj=c3=b6r=c3=b0_Bjarmason_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com, dyroneteng@gmail.com
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <933974689312bbb130236c81550ee3467f295a43.1668628303.git.gitgitgadget@gmail.com>
 <4ec06afa-d804-16b1-f140-dfd9ebd912e5@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <4ec06afa-d804-16b1-f140-dfd9ebd912e5@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/28/2022 8:03 PM, Victoria Dye wrote:
> Ævar Arnfjörð Bjarmason via GitGitGadget wrote:
>> From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
>>  <avarab@gmail.com>
>>
>> The yet-to-be introduced client support for bundle-uri will always
>> fall back on a full clone, but we'd still like to be able to ignore a
>> server's bundle-uri advertisement entirely.
>>
>> The new transfer.bundleURI config option defaults to 'false', but a user
>> can set it to 'true' to enable checking for bundle URIs from the origin
>> Git server using protocol v2.
> 
> Thanks for adding this, an "opt-in" approach seems reasonable for
> introducing this feature.
> 
>>
>> To enable this setting by default in the correct tests, add a
>> GIT_TEST_BUNDLE_URI environment variable.
> 
> This makes sense. I'm less concerned with this environment variable than
> those in patch 2 [1], since it's in line with the test variables that
> enable/disable whole features ('GIT_TEST_SPLIT_INDEX',
> 'GIT_TEST_COMMIT_GRAPH', etc.). 
> 
> The only thing feedback I can think of would be that this patch could be
> moved to earlier in the series (that is, immediately after creating
> 'transport_get_remote_bundle_uri()'). That said, I don't feel strongly
> either way.

It was simple enough to reorder them, so I've done that.

Thanks,
-Stolee
