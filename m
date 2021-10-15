Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B0AC433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 10:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AEDF60F23
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 10:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhJOKGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 06:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237807AbhJOKFe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 06:05:34 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E06C061769
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 03:03:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u8-20020a05600c440800b0030d90076dabso1320158wmn.1
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 03:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NOaOovkwb8qkCYt87D4CK6A/czaJ87skyyOeQtHwtjY=;
        b=G1MnyjMNZrwnhwMOriP8dk29CngTEfWWXxvA1Y+sn8XmOYTD7gdMaa2wEUxDYhySKw
         FqJ1i0aRJGf0uhFctalwseW7TV7gIc+MXMo1FZANe9zOPVHTr/0MCIXZ2CCDVTv4Gszs
         U+7EMs3NfhbggAaFpRxww/1X8vT4wX8Jfu+9rELP2SXtU62PPd+LXuCjyb9y6MsDB9hS
         GqDx1maAADCOKjyUxdDEp12uf/4XtEtVIKPebbz5M0vicZwfwuH3iDwIYSkBPXwQdaPa
         whvgykTpuzyFxGP/pDT9iatiIsgaRg105CLLyu4xfCoChmJs5IV6GXX8hAjxHWfNPI6T
         J/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NOaOovkwb8qkCYt87D4CK6A/czaJ87skyyOeQtHwtjY=;
        b=gDmxa/8yL8j2FaUlUv5EMM1M5hNUHiQj1dlBN/qRLLQmVy6G7TCI8ogaMqP8G+X81K
         3WSOZKgFbV08a5zkNt2lsaT5AFDNeTyEuzhMNEOL02p5qFq2PFeeQgE0kSyo9T78KsRG
         SVhTnnN8ogvwPyAvyBSQmXJZv3JJHJ916m2vQP8iUfzbki0+urj2rresqN4oDqdqa6XM
         oeTcye8qklZtp/xDQtK52mV4zMyVijzXsrEyppy1Lxl+QUXXLrFUzWKFG83K/4IsAvQ3
         kpZfHnGH/pHv1ZKYLBTzGEcQxTipmbgRg9cY4m/WfYlsJnwkTYCjanCdy8chm2dlTqwS
         SKiw==
X-Gm-Message-State: AOAM530/+9TmtaI3lHZ0SOrmpK0nzckp/tr58JFGOGYl0ektW/FCzZvY
        o4T3GFdCkpWPlPcEVJLuGN/UdrnRanU=
X-Google-Smtp-Source: ABdhPJzvoVGohuaWr57rmGTU3aXjHgqQGtLaW/55zARTJBmkKFuXm9XWsAArJV7GFSc6mEC5tzWcXA==
X-Received: by 2002:a1c:c908:: with SMTP id f8mr25392389wmb.142.1634292206208;
        Fri, 15 Oct 2021 03:03:26 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id 1sm10695622wmb.24.2021.10.15.03.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 03:03:25 -0700 (PDT)
Message-ID: <5868076d-69cf-9b77-fa5c-5bb229333bd9@gmail.com>
Date:   Fri, 15 Oct 2021 11:03:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: To "const char *" and cast on free(), or "char *" and no cast...
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Eric Wong <e@80x24.org>
References: <patch-1.1-9b17170b794-20211014T000949Z-avarab@gmail.com>
 <8f87cdb9-b52b-8d1a-545d-ed3055c536c0@gmail.com>
 <87mtnbfk0g.fsf@evledraar.gmail.com> <xmqqlf2vbbl8.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqlf2vbbl8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 14/10/2021 21:22, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
>>> It's great to see these leaks being fixed. I wonder though if it would
>>> be better to change the structure definition so that 'name' and 'path'
>>> are no longer 'const'. That would be a better reflection of the new
>>> regime.[...]
>>
>> I think this is the right thing to do, but I'm not quite sure. There was
>> a thread at it here:
>>
>>      https://lore.kernel.org/git/YUZG0D5ayEWd7MLP@carlos-mbp.lan/
>>
>> Where I chimed in and suggested exactly what you're saying here, but the
>> consensus seemed to go the other way, and if you grep:
>>
>>      git grep -F 'free((char *)'
>>
>> You can see that we use this pattern pretty widely.
> 
> Unfortunately, we probably need to make a trade-off and cannot eat
> the cake and have it at the same time.
> 
> If we leave the .members non-const, the destructor may have to cast
> the constness away.  If it is marked const * const, then we also
> need to let the constructor do the same.

It's not just in the destructor though, there are several other places 
where we cast the value to free it suggesting it is not actually const. 
I'd rather pass a "const struct branch_info*" around to all the callers 
that are not mutating the struct (we already do that in some places but 
not all) and change the structure definition to avoid the casts where it 
is mutated.

> By marking the .members const, we can be sure that the users of the
> API will not muck with the values once the structure is instanciated
> and given to them, but the destructor need to cast the constness
> away.  It may be lessor of two evils, as the need to cast is isolated
> in the _implementation_ of the API, and casts in the _users_ of the API
> would stand out more.

If it was just the destructor that was free()'ing the values I'd agree 
but the struct gets mutated in other places as well.

Best Wishes

Phillip
