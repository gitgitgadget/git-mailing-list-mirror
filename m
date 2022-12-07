Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33720C4708E
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 15:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiLGPUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 10:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGPUP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 10:20:15 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3128D1DF37
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 07:20:14 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id q190so6839338iod.10
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 07:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HaWjBwNQ2EIPRxGaOLSvxCl2aS2WKsWaqonoMSZkU3c=;
        b=jDu9ChChQC8q4Ok/CrKIcmvS0oO4Dg2eZmcr9i0ra/ztlxvtpgXFYs8hIdTjKzQ1L2
         VXTXUQAwaZklZFIfh1BoMJMgFaJXuUUF2mLRL+n251cUsKXRgAVcth9MsU6G6fdJeX8D
         jMrOWFVs/3WWh5ILNZL08GDjUD8P9m6gMTqMO5vezp8TzEdNzysJwKmpn+r36y0kdAAy
         iVWuRHMXrTjFIULCeBQDXzHW9sGjKe95dt4Z205WDymzmmbWXShbTAOw0GgxXe9FPlWA
         yo4ScYrmI3si7JRXLvR9vwYSK39XE35tWckTzbntKODoZXttAJ4uQ0hORNxg4E3mgr7g
         +zMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HaWjBwNQ2EIPRxGaOLSvxCl2aS2WKsWaqonoMSZkU3c=;
        b=n0ABqptg09qgXR/kpARInkXoLVaLglGKK3lsO9VkIpA7J1QA04DsisIM3GkL0uUYdH
         N+ELhz6N0wsRI88VitpuArquYiy/AFeaZ05d+lCjwEZwDcaYouwVlmAO2nQP3mxv8udC
         wB76DCEo3vmaz77lA3H/1v1PLeP0ENwhPV6EHi4l/P7LsgnVnhPktc7z0We3AxoXkc/K
         hQqUs8ZGjuD3zJOl+0zMnmp2Bwp1ixX80EOtLfokqI+vyR0FvAUPm7lKgyuN4LSYOl8U
         e0PL7byKq5g5S65LEvhmf2Qt/MhoYWBtDumEs9ZvzlT+M1GJyyy28pP4Ud70Ag1VHgUe
         jnmw==
X-Gm-Message-State: ANoB5pk62/69FT/LX8DCKwnhBkDOUVUE1SQzrDp6wEm/ge7DZxxKn5xX
        9u7Hq28HuwU5VuDcC4aAv2wNYw7lqOLzmUs=
X-Google-Smtp-Source: AA0mqf4p19DdteaiQnRDO6cFr0v0kRF5j9cs7ad9/DVImw4ngUUuK9o/sZ3Lia7IYyWO4Ol9ZM9BgQ==
X-Received: by 2002:a05:6638:1311:b0:38a:4d0e:835d with SMTP id r17-20020a056638131100b0038a4d0e835dmr5867107jad.150.1670426413471;
        Wed, 07 Dec 2022 07:20:13 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:30a0:a841:72ac:2559? ([2600:1700:e72:80a0:30a0:a841:72ac:2559])
        by smtp.gmail.com with ESMTPSA id p6-20020a056e02104600b00302bb083c2bsm7096553ilj.21.2022.12.07.07.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 07:20:13 -0800 (PST)
Message-ID: <8d9d01eb-4c2a-cd25-05f7-e1452c253626@github.com>
Date:   Wed, 7 Dec 2022 10:20:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 04/11] bundle-uri client: add boolean
 transfer.bundleURI setting
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        =?UTF-8?Q?=c3=86var_Arnfj=c3=b6r=c3=b0_Bjarmason_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com, dyroneteng@gmail.com
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <e46118e60f7a59ef25edf5f1378b4ef0c007cce8.1670262639.git.gitgitgadget@gmail.com>
 <b7b98123-0e78-757e-404d-024e167bfe60@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <b7b98123-0e78-757e-404d-024e167bfe60@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/5/2022 6:32 PM, Victoria Dye wrote:
> Ævar Arnfjörð Bjarmason via GitGitGadget wrote:
>> +	# Client did not issue bundle-uri command
>> +	! grep "> command=bundle-uri" log &&
>> +
>> +	GIT_TRACE_PACKET="$PWD/log" \
>> +	git \
>> +		-c transfer.bundleURI=true \
>> +		-c protocol.version=2 \
>> +		clone "$BUNDLE_URI_REPO_URI" cloned2 \
>> +		>actual 2>err &&
>
> If 'GIT_TEST_BUNDLE_URI' is set to '1' in a more global scope (by a CI job
> or user running the tests), then the '-c transfer.bundleURI' config isn't
> actually what's enabling the behavior. To make this more directly comparable
> to the case earlier in this test, could you add 'GIT_TEST_BUNDLE_URI=0' here
> as well?

You're right that GIT_TEST_BUNDLE_URI is not needed if we can set
transfer.bundleURI globally earlier in the test. It doesn't make much sense
to run the entire test suite with it on, since the server side does not
advertise bundles unless explicitly configured to do so.

Thanks,
-Stolee
