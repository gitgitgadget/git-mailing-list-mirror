Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E7CC433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 13:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiGFNOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 09:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbiGFNOr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 09:14:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B334863CD
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 06:14:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h17so8874886wrx.0
        for <git@vger.kernel.org>; Wed, 06 Jul 2022 06:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:reply-to:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=m0UPpRe3n500kOGqxnj5OHFUI2zNWz0z1g4kmLL1LSY=;
        b=Bi3EspbyAS5CnUfmPd/aCZjDmGpVHOJsAzRCnF6XIzivRFsfNsJKUEDByw86i+KRSA
         eZ/t9gsc1IjDmWq+zJuFouGFmYvtbsRhgcJqYJre1HjVdnF+FdwY1lyKl0X5Z255vrju
         fYWpr0VOBsnnEVqrq3azQjLBHFYSy5X7BLN7smsRvSiyYwUq5vcurekpWv+F16ngAhiF
         HGEwN+wY4z1Lm6ptjzbyz4VGVmDrUiba4Ra0k14zPffj+t1gPcXlQPDXx0KFALD//9ks
         saE9JXOqER0TqJKeL61xBk0ngf+TEpO1jUJyR3D/OyQ0Y44h7LcisQohKo8/20pTgh42
         7BcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:reply-to:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=m0UPpRe3n500kOGqxnj5OHFUI2zNWz0z1g4kmLL1LSY=;
        b=tENnqd+PaWdh8BQHXN8yUSfvoKmPw6w8VyDjt/A1/VoDTRDny9FrEr9iRRqwsIItho
         w9SmcDcF/099/3RADHfDVOt9QEnllTfEEscuvRvPhcshC7cYfnG5Wqou2zabvI31lQ9u
         lSVnmHF3pdLAFV/jKszQp+P2JnuJZeXeXw6n+6FMXaaoxbtpoDE3Munc+f06TnBOAWuT
         jfvz0U76vW1g5eTJs399Hg4Y5UuY5k8gxZa+0Z86A6kXTUOqUAnru1CiRHHSNWOG7g/s
         bj1n38d6YNUt1Syoy3EpqJw2XHiM+urPuZHzbxzvzahbNkwD4UYc9g7pvceEBiO9ZVJr
         oI8g==
X-Gm-Message-State: AJIora9ylQ43mF84vK7ae++qhGIP3UcvOAW/L8MQ7wVqp/6xLrBlpekq
        DAP3mv/3o4rFvl2PZaodHJ0=
X-Google-Smtp-Source: AGRyM1slz0XVsz9wrJ5Q23GAJUUdAAKgXkSU3VbqQcdDLAxdLiCuu5AZzLgR5jBgzwm5VjBtT/s6dQ==
X-Received: by 2002:adf:cc8b:0:b0:21d:70a8:777f with SMTP id p11-20020adfcc8b000000b0021d70a8777fmr9374213wrj.539.1657113285149;
        Wed, 06 Jul 2022 06:14:45 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id p41-20020a05600c1da900b003a0231af43csm12092919wms.48.2022.07.06.06.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 06:14:43 -0700 (PDT)
Message-ID: <d58292b6-dad6-78d4-2846-18ddc3e30ca5@gmail.com>
Date:   Wed, 6 Jul 2022 14:14:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 3/3] xdiff: introduce XDL_ALLOC_GROW()
Reply-To: phillip.wood@dunelm.org.uk
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
 <da996677f0730ec7a50d399524fb58c44dad468a.1656516334.git.gitgitgadget@gmail.com>
 <xmqqtu82dmu2.fsf@gitster.g>
Content-Language: en-GB-large
In-Reply-To: <xmqqtu82dmu2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 30/06/2022 19:32, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +/*
>> + * Ensure array p can accommodate at least nr elements, growing the
>> + * array and updating alloc (which is the number of allocated
>> + * elements) as necessary. Frees p and returns -1 on failure, returns
>> + * 0 on success
>> + */
>> +#define XDL_ALLOC_GROW(p, nr, alloc)	\
>> +	(-!((nr) <= (alloc) ||		\
>> +	    ((p) = xdl_alloc_grow_helper((p), (nr), &(alloc), sizeof(*(p))))))
>> + ...
>> +
>> +void* xdl_alloc_grow_helper(void *p, long nr, long *alloc, size_t size)
>> +{
>> +	void *tmp = NULL;
>> +	size_t n = ((LONG_MAX - 16) / 2 >= *alloc) ? 2 * *alloc + 16 : LONG_MAX;
> 
> Not counting in size_t but in long?

Yes, that's to match the existing code.

> I assume that 16 mimics the ALLOW_GROW(), but ALLOW_GROW() grows by
> 1.5, not by 2, so these two are not exactly compatible.
> 
> The computation of 'n' tries to avoid arithmetic in "long"
> overflowing, but does it ensure that we actually grow if we truncate
> at LONG_MAX?  After *alloc grew to LONG_MAX by calling this helper
> once, if we need to grow again and call this helper, 'n' will again
> get LONG_MAX and we end up not growing at all, no?

Right but the caller can only request up to LONG_MAX items in nr. If we 
were to grow beyond that alloc would be truncated when we returned it to 
the caller.

The code here is written to fit in with xdiff using long where it would 
be better using size_t (changing that would be a fairly major undertaking).

Best Wishes

Phillip

>> +	if (nr > n)
>> +		n = nr;
>> +	if (SIZE_MAX / size >= n)
>> +		tmp = xdl_realloc(p, n * size);
>> +	if (tmp) {
>> +		*alloc = n;
>> +	} else {
>> +		xdl_free(p);
>> +		*alloc = 0;
>> +	}
>> +	return tmp;
>> +}
> 
> 
