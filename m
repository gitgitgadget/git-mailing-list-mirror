Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF52BC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 22:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbiCIWMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 17:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbiCIWMq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 17:12:46 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A52120E94
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 14:11:47 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id lp2-20020a17090b4a8200b001bc449ecbceso4506177pjb.8
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 14:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AzGWVSHdKUM50sRGCsPPqX3vDOG9oYN5G4XIv0Qfl+M=;
        b=dln+qqXVRf2+wTtQk+rO8BtfP7mG/URdSG7soziY3iWCxISAghNL4nGxqJ4PpiaQFp
         VB8LVlJq54epl7Xq5lyfC60hRFaVwTz4t6KzlOysSYvTZg93elp2xJb3khhEMBTbA0wm
         bAkFMNus1zhaUZkQRHvClxmLCixtNNt+wmuIbusYII1VzucYu2hyJujfkalLwZ0arV5k
         pTCnGHLnzwWaAifdasesej5f4nkrBkSv7MLlZUULg57FfeNwsV2hVtBReJOzPOOwgXZx
         k2LLmHNVFX2bzd0397GIqfLaI44iHlwqctn8In5kbQwbcj59l8ySeirp5G24fGFwyPeb
         dJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AzGWVSHdKUM50sRGCsPPqX3vDOG9oYN5G4XIv0Qfl+M=;
        b=WC+RGrpFoLRXjjZhKdJobNEVVpxmnOeIC2VQiAtz/rG/9+gQ5r/rCqwznB7lpm441t
         pXeZanUGVr69ArAfd2HMj/CY4GeZZh5jNGYeQu+J7qqr/bd8SD1SqXsiLhseMXGbr/Zp
         LyhIpzDqqmQ/Ddw5WMETtda7e4ISwbehOS+uvdCvup8lY6WjE9+M+9WNrnvRX2VVqHyN
         EcxL86kJh+t843Va3jf4p/pxMwJ7LzNyowkY7lfDRa3STpjbQEJ96vzvYJAhgIETYOER
         Gtc63pVT7v5PaeT2ZMLXxH7Snkxy+XSAZ4iGZlfJm2xstakZTi/MAkZXBHII3f+XSCZT
         jAqg==
X-Gm-Message-State: AOAM531TOUZg7iLLyjTuQXRgl+2ZmJp2S3l+vxLVwLuz1DZrXGRgKeHg
        LBNJvyqPIR0eXvkQ9yoC/PPWsd792TZwwQ==
X-Google-Smtp-Source: ABdhPJz8RGkgCQ1YNDjFmqvqaGT2l8b8+YsJ8PDtpN7NGTkR/eZyZgHtsumGLklg3sRKmGPNplbjeKfMjtudsw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1954:b0:4e1:f25:ce41 with SMTP
 id s20-20020a056a00195400b004e10f25ce41mr1867843pfk.44.1646863906674; Wed, 09
 Mar 2022 14:11:46 -0800 (PST)
Date:   Wed, 09 Mar 2022 14:11:44 -0800
In-Reply-To: <xmqq4k46nae4.fsf@gitster.g>
Message-Id: <kl6lzgly4vz3.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220304005757.70107-1-chooglen@google.com> <20220308001433.94995-1-chooglen@google.com>
 <xmqqr17dp8s9.fsf@gitster.g> <kl6lh7885mm3.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqfsnrkkhd.fsf@gitster.g> <kl6l5yom6h4j.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq4k46nae4.fsf@gitster.g>
Subject: Re: [PATCH v5 00/10] fetch --recurse-submodules: fetch unpopulated submodules
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> To clarify, does this opinion of "don't use config values that aren't
>> copied into .git/config" extend to in-tree .gitmodules? Prior to this
>> series, we always read the in-tree .gitmodules to get the config - the
>> user does not need to copy the settings to .git/config, but we don't
>> pick a commit to read .gitmodules from.
>
> I think we do, but I also think it was a huge mistake to allow
> repository data to directly affect the behaviour of local checkout.

I'm inclined to agree.

> Fixing that is most likely outside the scope of this series, though.

Agree. Thanks!
