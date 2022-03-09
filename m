Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E51C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 19:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiCITUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbiCITU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 14:20:26 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769A7C2E4A
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 11:19:27 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id c7so2594902qka.7
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 11:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=X1oicCuC9jV7J576FuQi4kEzQw2L5knBtT47tMVi4Lw=;
        b=O9Jbf2mlCppejwrgxpLMMHh0EShv/RpgQgxX09hjfwWyMjkIgl5bDPv7cWcbAWZYK0
         iDwWRjbvkhpyo6vNMvUa2fzWV1vcRvT0I4RfFAHz0hPFraTju2m76MKEXHiWX8K0+ud/
         +1kVAIP/86NvMYigwOI+Genjoz17wjraj2Uc6YJEOlz5gCH/agK0Z9xp/S53NZleocBn
         JuCKJEFcfgtQmxu08Qny1YpPPLXcFMtumAQJxCdJ8DXFPZBM2Um7b9rNz90njcWKTtq2
         yyKCnEcNPZp9G+EdMgaEECP2Lc1RjrBWeOgMzG/gDrcaVI7u2qn2ZzskisTBpqmf0bQ9
         CG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X1oicCuC9jV7J576FuQi4kEzQw2L5knBtT47tMVi4Lw=;
        b=Xg/8GFpBKvhSnW4Sf7FJZwwzZqiaobMXXuZqgTqCvSPNUmQE/0s3ghXmi6u3S/V15x
         U7gwO3qXqzsOnpfBckhla9RFxv8zYsjHPD+subGHRX7O2HDmMRdQuJ9bbqv+yZcyJTXA
         tO/r83OEMaYBVY3dXBS3zKIuFa7I7bxf9jKNn9GE0Zsbawdq3bnhvkwIMYHMCuSwrDHr
         qu+wTrUaDyys00OiOWNOsr1clcRDa+SZ0JzR6nr5sG+hBXxoSlBLB38kY/0X2RD3j+9V
         /tSnMmRCnUohhuhB3Gou3g3uMBxAJUHeyQ4wiYncSZC7Q6JoxbtrnLi2N/CyHFiL5Djg
         lZcw==
X-Gm-Message-State: AOAM5329533UexiGR0Sz2WpTIPTx//bX8p+R08G3zCam1hIka/niW92p
        D2JBDjlZIufDgmusmFwtGYDZ
X-Google-Smtp-Source: ABdhPJwBUohh86HR9KUuDrLz4LUuZE/4YFga4Ju5dwSexCQHfXtFh+u3GdpohAR0jjy2wPmbRREx/w==
X-Received: by 2002:a05:620a:430b:b0:67b:7f7:48ff with SMTP id u11-20020a05620a430b00b0067b07f748ffmr830033qko.266.1646853566604;
        Wed, 09 Mar 2022 11:19:26 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id k8-20020a05620a138800b00679fc7566fcsm1254555qki.18.2022.03.09.11.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 11:19:26 -0800 (PST)
Message-ID: <4e564691-0ef6-a867-647e-c26064b0bb36@github.com>
Date:   Wed, 9 Mar 2022 14:19:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 17/24] revisions API: have release_revisions() release
 "cmdline"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <patch-17.24-b5687ed1355-20220309T123321Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-17.24-b5687ed1355-20220309T123321Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2022 8:16 AM, Ævar Arnfjörð Bjarmason wrote:
> Extend the the release_revisions() function so that it frees the
> "cmdline" in the "struct ref_info". This in combination with a
> preceding change to free "commits" and "mailmap" means that we can
> whitelist another test under "TEST_PASSES_SANITIZE_LEAK=true".

Could you consider changing your vocabulary to use "allowlist"
(with the opposite term being "denylist")?

Thanks,
-Stolee
