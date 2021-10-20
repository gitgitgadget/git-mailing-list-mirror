Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CDEC433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 12:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFFAE61374
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 12:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhJTMmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhJTMmb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 08:42:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8157C061770
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 05:40:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id b189-20020a1c1bc6000000b0030da052dd4fso9913815wmb.3
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 05:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sp1MxgRZb5aGo8K8VYnpfut+viu2ZKD7nJCPV9t6iFo=;
        b=HbahMrKvKN3zUg1mmfOfAlL7EOTukXO9AcibrWFZwdzpoGHBiENm243ZnI3O/YprOQ
         ie6kxfmNcluqgkzZKyOPyK3jdfZLHKHxaU3T9lGbRj6vML5B4vWuTeTocMgKJBPmgBrx
         bHV4gF9sKA39pZkZg3ZiuITPdI/HiEs4dSsX02pLtgp+5Ecvq4sS+817KB2ZT88/tg2Q
         rYxWtIgAVhrR8AROoACx+rTihn08+NGWMAJLtmMoZegUVYZFSsOp3RCpoBEa8tPjv4W2
         fcsIF38bu5kwH1c18iBqmwwoGpqYtAmq0ySife2Bty+ZACFXspZBLakfMOTkeI/UH6tz
         91Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sp1MxgRZb5aGo8K8VYnpfut+viu2ZKD7nJCPV9t6iFo=;
        b=ySTFUgBQysVTvjCXBOTg1zle0taZb3Js5sUNksTkKXzE0AtjAQlXysdsbPmprC2Vuj
         CJbVcBe1Ec8tEBMXKlVh4HsmfN+/t3xwxzGWQ+YmKJQslJGaSZfCE7hdSggazB3MpcEO
         c9ZTr8FOCn/1h0ln/+E9XyCWPV2vAu83aGPvlIIxnaBkjYF7t+KaaUKr/qfywdw48/Zl
         N2pCocP/1AyrrtUXrItZM6IPSXOv8ewuAGHBbZKHuFHF5yViMWrFzQlb5JhD+EgyWFe6
         EXrnMIUJg06UfGPP5JgtbkxSlLDIEac4nFntEJuZmCfe5arMczTniEDOLKY78WUY9Kt7
         j5EQ==
X-Gm-Message-State: AOAM533//NGw0TLTIt81D8195KzmqbxUVHZF7rZIL/fqq801+fvqAil5
        BtxKEuVamKTWZxHhea0Wp06lSxq39w==
X-Google-Smtp-Source: ABdhPJzYhusBFjpYhunhlRYR+Ucn6/vsZugobOOK8qwrpdlHmWMDSxIWxiE8QGUfAeBDDkw1YxbJZQ==
X-Received: by 2002:a05:600c:22c3:: with SMTP id 3mr13431150wmg.170.1634733612474;
        Wed, 20 Oct 2021 05:40:12 -0700 (PDT)
Received: from [192.168.0.13] (dau94-2-82-66-65-160.fbx.proxad.net. [82.66.65.160])
        by smtp.gmail.com with ESMTPSA id c185sm1930527wma.8.2021.10.20.05.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 05:40:11 -0700 (PDT)
Subject: Re: Questions, improvements
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <9ad3d241-5441-9fbd-76a4-7c47c6a1b70e@gmail.com>
 <YW85Gs8aU9rrBDOv@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2110201340370.56@tvgsbejvaqbjf.bet>
From:   =?UTF-8?B?QkFSRE9UIErDqXLDtG1l?= <bardot.jerome@gmail.com>
Message-ID: <9009a3af-9d21-cad1-6a4c-e1a81ece6f83@gmail.com>
Date:   Wed, 20 Oct 2021 14:40:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2110201340370.56@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/10/2021 13:42, Johannes Schindelin wrote:
> Hi,
>
> On Tue, 19 Oct 2021, Jeff King wrote:
>
>> On Tue, Oct 19, 2021 at 07:38:16PM +0200, BARDOT Jérôme wrote:
>>
>>> 2)
>>>
>>> I need a domain name / uri / ip base way to choose auth information.
>>> i find some examples in past but not as smart as what i want. (Maybe i
>>> miss something)
>>>
>>> 3)
>>>
>>> For auth client side can we use tools like Pass and or identity manager.
>> I'm not entirely sure I understand your questions here, but I think
>> you're looking for credential helpers? Try "git help credentials" for an
>> overview.
>>
>> There are helpers which interact with common OS secure storage systems
>> (like osxkeychain, libsecret, etc). But you can also write your own
>> little scripts, and restrict them based on URLs.
>>
>> So for instance I use this config to pull a GitHub PAT out of the "pass"
>> tool:
>>
>>   [credential "https://github.com"]
>>   username = peff
>>   helper = "!f() { test $1 = get && echo password=`pass github/token`; }; f"
> A quite complete, cross-platform credential helper (included in Git for
> Windows and enabled by default, but it also works on macOS and on Linux)
> is Git Credential Manager:
> https://github.com/microsoft/Git-Credential-Manager-Core/

We only use GNU\Linux for our work, i see there is .deb, are they
integrated in official debian repositories (stable) ?

We avoid tools not Libre and not package by default in debian. (with few
exeptions) 

And for what i see it's using C# and Microsoft not really play
integration by putting stuff on their side instead of working with the
GNU community (but it's just my opinion).

> It comes with backends for some major Git hosters and is pretty
> hassle-free, once configured.
Pretty sure it is.
> Ciao,
> Johannes

Thx for the information by the way


