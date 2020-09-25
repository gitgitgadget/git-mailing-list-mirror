Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27172C4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C639E2086A
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7pIEpDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgIYUsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 16:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgIYUsP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 16:48:15 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F83DC0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 13:48:15 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id z18so2096760qvp.6
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 13:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hqMk/0YaZtGpbpR2YxZPDzyCNb3PIyq5+IiKhwRC9KQ=;
        b=D7pIEpDL+D2wostmT+6Kx7jKv1QU66pt6oSN2qACNUpRdJ3rff4oqmash0lr4hMyd0
         ZewnxPrpO+O0kblJkRoqoNz+CR6Ol7KdmHXWqQXI5LAxPZWmHbovVSl8mPSP8MXk7Q47
         FX76a+JAfmlUvfDZvl1WeWMVQ92PpiqRETTns4Vvzx60OwE66Wifb4/6CYo1j4kJUXmy
         uEevUD9Y69/DXNCs6tdIKq7mMjz6VupYGSppswG+PKsB9144s7Q3lwNL10Ub7sb1CBVf
         GTwL2y/GhIU3KoM9h/NrKklzSBojgcKp2bDCH2sK3D8IpAupoAF0EO6j4bt4Fm6HJaxN
         j+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hqMk/0YaZtGpbpR2YxZPDzyCNb3PIyq5+IiKhwRC9KQ=;
        b=eGQJLvcEhV5WZfsTBfW0ukYJm4pVHX2t7lfwDVKy2F+aUf9dZlAiNuOwTAs7UeiH5+
         3P759P6+ebHfji2aaWuhrcjGovJ9KrqqEzXuwLTUjD8H1gRqlic3CYymqks7sRDFxyXt
         6qMCSTH1b70XehMxkPUQ71ZxHi4Iy2XReRs2X/6qRkO4MVH6JTc24zpE6ohg0wrcX1ZP
         1c4VsiIdamiKdNN4EIasiFH+bJGE6wBPCUgZu5ky6lBEzXw+FINNtY/icradpQgJMLKz
         HCssc41HsggRxI2ALNYMIhHob5X54L2gSEYdrZmyGc/ufT0b2ddjWGHf0YfEtVFiAU/M
         tL3w==
X-Gm-Message-State: AOAM532lDNvzyVSo+3eGG7cMIIfAs2w0JImOIKrGEzDxD/m1auh/LjRU
        XctZdzPiGNIod3QnMGvCsGc7oFcUf2hncc7m
X-Google-Smtp-Source: ABdhPJzeswIf/lQG/fZiIAIixgJ/jczweEY3sirGaGdhgKG1kfdIYLTajfzVbBx+PJlKTq11QEn6jQ==
X-Received: by 2002:a0c:a990:: with SMTP id a16mr449965qvb.59.1601066894304;
        Fri, 25 Sep 2020 13:48:14 -0700 (PDT)
Received: from [192.168.67.200] (dsl-66-36-136-92.mtl.aei.ca. [66.36.136.92])
        by smtp.gmail.com with ESMTPSA id q35sm2719731qtd.75.2020.09.25.13.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 13:48:13 -0700 (PDT)
Subject: Re: [PATCH 1/2] bswap.h: drop unaligned loads
To:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Han-Wen Nienhuys <hanwen@google.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
References: <20200924191638.GA2528003@coredump.intra.peff.net>
 <20200924192111.GA2528225@coredump.intra.peff.net>
 <20200925011348.GA1392312@camp.crustytoothpaste.net>
 <CAPUEspjpUeaqCCuBJpQLSTv=C_P4f5h22HoTPm9+9rB7k0NkaQ@mail.gmail.com>
From:   Thomas Guyot <tguyot@gmail.com>
Autocrypt: addr=tguyot@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6d48c9ee-d8cc-1f22-80bb-f249c94f9767@gmail.com>
Date:   Fri, 25 Sep 2020 16:48:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspjpUeaqCCuBJpQLSTv=C_P4f5h22HoTPm9+9rB7k0NkaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-09-25 05:05, Carlo Arenas wrote:
> On Thu, Sep 24, 2020 at 6:15 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>> On 2020-09-24 at 19:21:11, Jeff King wrote:
>>>   [stock]
>>>   Benchmark #1: t/helper/test-tool sha1 <foo.rand
>>>     Time (mean ± σ):      6.638 s ±  0.081 s    [User: 6.269 s, System: 0.368 s]
>>>     Range (min … max):    6.550 s …  6.841 s    10 runs
> 
> slightly offtopic but what generates this nicely formatted output?

It turns out I may have finally reproduced my diff speed regression at
home - just today - and I read this :) I may use it to test, nice timing!

About my unrelated regression, TL;DR, have anyone benchmarked under a
VM? (more context below...)

>> I cannot speak for s390, since I have never owned one
> 
> I happen to be lucky enough to have access to one (RHEL 8.2/z15, gcc
> 8.3.1) and seems (third consecutive run):
> 
> stock: user: 7.555s, system: 1.191s
> -DNO_UNALIGNED_LOADS: user: 7.561s, system: 1.189s

So also somewhat offtopic too, but I've been trying lately to reproduce
a speed regression with "git diff --no-ext-diff --quiet" (used by git
prompt in contrib) on some large repos between 2.9.5 and 2.16.2. Overall
the diff was over 3x as slow where I tested, and I measured a couple
timings between mmap of the same two large files between the two
version, the delta was approx 10x! (no other syscalls so it's all
computing and - if my theory proves right - I guess a lot of pagefaults
or similar handling control back to the host).

I prepped a VM where I will do more testing (I ran one preliminary test
and there seemed to be a visible difference, but I didn't have a proper
repo to test with yet). The point being it might be worth comparing the
two on VM's as well.

Regards,

Thomas
