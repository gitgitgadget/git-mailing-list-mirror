Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE90C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 13:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbiCHNq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 08:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiCHNq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 08:46:56 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07D62E0B4
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 05:46:00 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id x26-20020a4a621a000000b00320d7d4af22so8872148ooc.4
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 05:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QsYfqinFdRx4eLWvmYSkdC4GO1qYgkEriasFRMJbeAg=;
        b=Zlg3BX/oIn7oUJ+XDD4pwIh1t2ij3w0lFiqXXuS+ky9J/nBzrT/1XYgjc3bO2rG3UL
         5p2o15Pf9kLxBjjBNs4QHpnL4OBjLk6E/MN5S4xOj+E0kuEaMLCIvF9Irx6GFZMDvEMf
         T+qI374x32wz3xOUB77FRqf0SAvEWtkg1wnqrEmaCKZhHcMJ6+pSmAXASe2aKujJPKYW
         7es/j+JhDN44jwpJcFAxctwwjXAgF3M7gJWaOupPnGkDgaS4Dz6nspSsAdShKX3Gm+S6
         fbu6dPMfspjE4q6MYXpNk36Dnpk0F7Luy6zgHxP9yNqbwUtqztJE5QrDLDVVDNFLBpbP
         Nnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QsYfqinFdRx4eLWvmYSkdC4GO1qYgkEriasFRMJbeAg=;
        b=ZC/oGp7mNadVO3rIWT4YoFfu4RFtrMp09imOlI3TNrHY6NRfwGXcZjrP8z4gLmtXjy
         Xf5ziqna6ELTHjkt24Yf3vJ1UUkZkwp5EVm6r1QAQm4syAsQNqucLIGdfWjT+UYeL1Cj
         TuN6FtrucDlX52rsvIZYUvb29whFj2qBK0hZ9x9JziKK2T9Ul+KrNc+I7a21mKBhumDC
         J96q2mJdThHyZHO1mibKgnI8AgBIdlU0HgxD/ubh7n/NLpdRky5VAAjpH00hMt7ncNbk
         gNR5CWeXkY/CzLBflgdaItuLOenp59FfX5AVfbJsVm6vY3M9j3q7rRMwAo2PYz52Gn9L
         poHQ==
X-Gm-Message-State: AOAM5338d7OnxT8zug34Oqdq3rJ/QHwFrbxVmOgr7WiUg84K1hcXE77O
        LNLzsplImSCdgYqwpTiaznMo
X-Google-Smtp-Source: ABdhPJzgGpU28vDLcXwXs9vDvO4DnNnjAYaUraPA/C/DPJIP/P2MpBlJSpR5i7nT3geWN1GaFRfaWA==
X-Received: by 2002:a05:6870:31c5:b0:d7:d5:5df with SMTP id x5-20020a05687031c500b000d700d505dfmr2378687oac.57.1646747159723;
        Tue, 08 Mar 2022 05:45:59 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id ej35-20020a056870f72300b000d75f1d9b8asm6925324oab.55.2022.03.08.05.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 05:45:59 -0800 (PST)
Message-ID: <ea7b6ac0-1212-6682-60cf-d79f5deb61e5@github.com>
Date:   Tue, 8 Mar 2022 08:45:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 07/12] bundle: safely handle --objects option
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
 <19694d5b255227f2314456118c2c7fc986ae52a0.1646689840.git.gitgitgadget@gmail.com>
 <220308.86h788ydm6.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220308.86h788ydm6.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/8/2022 4:37 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> Re this comment on v1: https://lore.kernel.org/git/220307.86fsntzsda.gmgdl@evledraar.gmail.com/
> Aside from whether that's a good idea, doesn't that at least point to
> missing test coverage here, see traverse_non_commits() and other paths
> in list-objects.c that'll call ctx->show_object().
> 
> I think an actually sensible patch for this is the below, i.e. the API
> is conflating "do show" with "should we show AND we have a callback?":
...
> I think that'll do what you want, and also seems to set us up for safer
> API use going forward, i.e. we have a couple of NULL-passing callers
> already.

Squashing this change into the commit makes most sense to attribute
authorship to you. May I forge your sign-off in that patch for v3?

Thanks,
-Stolee
