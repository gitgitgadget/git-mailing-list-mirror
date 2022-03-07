Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4A0C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 15:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbiCGPyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiCGPya (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 10:54:30 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7765266603
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 07:53:36 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id a6so15592841oid.9
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 07:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s89XB0013j52uaOmSDPEUraeEJogykz27RKH3O9O56k=;
        b=ipQfkwnGBW4h9PotQ9LbC0ksAImb4jKoFpMKNw972X9g5HkwrgA8Lu65623JF+orws
         G7mKALvdadYjtfxhImPHEJIXeqwbkGhPiKKYEQNVNGoI1As8C/83qJ+YGVTXySIwDzXk
         NBfQ8ZqTMTBel/6LFnW+esmnwKupK038m1MOQhVTJEvgAHXl7p/FVjYjXXdLFasEw0j2
         B+NkSB7OnpwH5uTWXL6biMY4zNOGctSCOELUKqULLSyU8GtCYyMMfwEQBHA5zcW0fdRk
         9Pb16q1radHA3gXTmZAztg7qnGTtO3DnETzVUzkw5DEE834CuClqUXA1UxqST+3sP6lj
         yldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s89XB0013j52uaOmSDPEUraeEJogykz27RKH3O9O56k=;
        b=baeeBlQ4qnB0DFTvCJ156q1wFk3XywOgP0FsE2tUdYhYMw4nrKCQroPrhLPG8J/sdv
         WjhozLRZiIgMNG1fP4UUCh8bDTVjcVhfvjiVBKUcDy2XmKG6YyVuxKtqK9v6z9wPjfxu
         weXHkWN5iLVpx56LqMIlVqxenL1Y3uqNZ8B4URlt2Zn8H/TVlHR9+10cQ1jzgX49jdQM
         K9nfN0XsUXU2EiDXAv8MojXTKdZv/2ti0Rk0KNfGv7YGr+ZkPxe1OGh4bJ+etoiJxR8h
         QyN8JUEKmU7/fjAO75TBa8uH+IjTDro9aYtmOG3hdIs49Y61Ben7ZJFFnXvC+iftPFBn
         k4wQ==
X-Gm-Message-State: AOAM530M5a3LV/u3bHD1sMf0zs7iNg0fYuQPwJ0Ws4GRDBbvt8LJP5iv
        Rk5S7psi0jAo4lnfyZsAaT3cTHtks1wP
X-Google-Smtp-Source: ABdhPJy/CsifcMHu0VQVZOxrCHcdYO/WHbnR4xKTGr02gulWJ4KPlr/ege2avoJ+Oxn+Bu9lewLiRQ==
X-Received: by 2002:a05:6808:2013:b0:2d9:dbed:6999 with SMTP id q19-20020a056808201300b002d9dbed6999mr2736417oiw.30.1646668415732;
        Mon, 07 Mar 2022 07:53:35 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d9-20020a9d51c9000000b005b2466cd7b3sm399769oth.36.2022.03.07.07.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 07:53:35 -0800 (PST)
Message-ID: <03f493f2-aa94-ef9e-8b05-88a895015c80@github.com>
Date:   Mon, 7 Mar 2022 10:53:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/2] gettext API users: correct use of casts for Q_()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
References: <cover-0.2-00000000000-20220307T113707Z-avarab@gmail.com>
 <patch-1.2-83659fbc459-20220307T113707Z-avarab@gmail.com>
 <a34c37c0-b6fd-9f4f-e990-9869f375937e@github.com>
 <220307.86wnh5zwe0.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220307.86wnh5zwe0.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2022 8:54 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Mar 07 2022, Derrick Stolee wrote:
> 
>> On 3/7/2022 6:38 AM, Ævar Arnfjörð Bjarmason wrote:
>>> Change users of the inline gettext.h Q_() function to cast its
>>> argument to "unsigned long" instead of "int" or "unsigned int".
>>>
>>> The ngettext() function (which Q_() resolves to) takes an "unsigned
>>> long int", and so does our Q_() wrapper for it, see 0c9ea33b90f (i18n:
>>> add stub Q_() wrapper for ngettext, 2011-03-09).
>>>
>>> In a subsequent commit we'll be making more use of this pattern of:
>>>
>>>     func(Q_(..%"PRIuMAX..., (unsigned long)x), (uintmax_t)x);
>>>
>>> By making this change we ensure that this case isn't the odd one out
>>> in that post-image.
>>
>>
>>>  	if (!res)
>>> -		printf(Q_("updated %d path\n",
>>> -			  "updated %d paths\n", count), (int)count);
>>> +		printf(Q_("updated %"PRIuMAX" path\n",
>>> +			  "updated %"PRIuMAX" paths\n", (unsigned long)count),
>>> +		       (uintmax_t)count);
>>
>> Why are we adding more uses of "unsigned long" which is not consistent
>> in its size across 64-bit Linux and 64-bit Windows? Specifically, on
>> Windows "unsigned long" is _not_ uintmax_t. Shouldn't we be using
>> uintmax_t everywhere instead?
> 
> Whatever we do with "unsigned long" v.s. "size_t" or "uintmax_t" here
> we'll need to call the ngettext() function, which takes "unsigned long".
> 
> Since you're quoting the part of the commit message that's explaining
> that I'm not sure if you're meaning this as a suggestion that the
> explanation should be clearer/more explicit, or just missed that
> ngettext() isn't ours...

Mostly missed which parts we had control over or not.

> I did wonder if we should just skip the casts here and instead do:
> 	
> 	diff --git a/gettext.h b/gettext.h
> 	index d209911ebb8..095bf6b0e5e 100644
> 	--- a/gettext.h
> 	+++ b/gettext.h
> 	@@ -49,8 +49,10 @@ static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
> 	 }
> 	 
> 	 static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
> 	-const char *Q_(const char *msgid, const char *plu, unsigned long n)
> 	+const char *Q_(const char *msgid, const char *plu, size_t n)
> 	 {
> 	+	if (n > ULONG_MAX)
> 	+		n = ULONG_MAX;
> 	 	return ngettext(msgid, plu, n);
> 	 }
> 
> Which I suppose would be more correct than a cast, but the edge case
> where we'd need that ULONG_MAX is so obscure that I don't think it's
> worth worrying about it.
> 
> I think for this series it probably makes more sense to drop the casts
> for the "n" argument entirely, what do you think?

I agree that this is a better approach. It avoids polluting all of
the callers with down-casts and instead puts it here. The only
difference is that we will truncate at ULONG_MAX instead of blindly
ignoring the significant bits, which is probably better.

Thanks,
-Stolee
