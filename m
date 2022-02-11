Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FDDC433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 15:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351337AbiBKPTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 10:19:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243391AbiBKPTf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 10:19:35 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB90CE0
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 07:19:33 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h6so15787023wrb.9
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 07:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+mDqTd/LKxaMxp1X3r7mlTN47RB8NaRa/Pze87wiMFo=;
        b=WGYU+R/MjNk942q8reyS+F460afdtOvppUoL655kuYR9f5hqxuRB9DuiQziJKyzqKu
         FF7w5XsPuNC/UJfdJr8No8s1UVCB6xr8oaNUqhbfTUVu7rNqlsI+p2FjkkhgoM67UPfb
         N/4Pj7QUW9ScMt0qVzwI8xFFzsFqO10sO4fO3hOVWtoI8sxh7hUPj3Ynr9Acl5ydsWCf
         l6ytrzprgJRcGlILxUP+EBQldloIL1RWe7LFtlQiqas9IREWIQhcRYdzWz+12cKUvQvY
         e9bVU1Anja8huWEHVHr5JdWRHBc3esISJ2wK8W2nkm/NWDkBVnSF4hEUHCwn8O4cCjk1
         Uebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+mDqTd/LKxaMxp1X3r7mlTN47RB8NaRa/Pze87wiMFo=;
        b=Y+pagsjV2NjgELPBtWpfOH//Frt//cRDSLlEB6DS/hzyl2LNADvl+/4/D045HPof4v
         mEk3IaHh5Y3rNJ4b3xNa03/LDeRaxXcENM0E0ydoLZG6HIzy7U5OIHGAzI/0g9tmYzBz
         2J56wneNX0m7Z6vMQNtCU78F/hm7umEMatoLQIBgl1QRUfqzAE29V0OELg8A9DvydUBb
         kwwrBjz370fgSDDeyI5RezvZ2jSWJA1r1VFXSWfPu4g6I5H4WGbIAwzq03fdvlxYANQ0
         hf8YBFkb/SP2VlZerQc6NR2jvoe7632LL0eCu5ZETAecCAp9Gb0pUQWUhiRBvb5mdDF/
         NjqQ==
X-Gm-Message-State: AOAM530R7WnODz8w9cjmGRBVkZWkUulCDOJwlwWG4D7pg3hX6cx2PmFN
        4RNr0l8iUMmgKE7vs1wwMVI=
X-Google-Smtp-Source: ABdhPJyZG5nfuX8YKD6Y3/WXN1mP8RIY4Dj7fX+etjEd8A9tCZ6jPQ1sY5fSRRehqH8V2H47ctIGYQ==
X-Received: by 2002:a5d:4528:: with SMTP id j8mr1763131wra.544.1644592771772;
        Fri, 11 Feb 2022 07:19:31 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id a18sm18436959wrg.13.2022.02.11.07.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 07:19:31 -0800 (PST)
Message-ID: <9c5b3acb-aabc-3a0d-f4e7-e10cec410dbe@gmail.com>
Date:   Fri, 11 Feb 2022 15:19:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] xdiff: refactor a function
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
 <8655bb0348d7344ae85c8d521fb1ec7a5f4188d2.1644404356.git.gitgitgadget@gmail.com>
 <xmqqmtiz9aro.fsf@gitster.g> <xmqq8rujxmkf.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq8rujxmkf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 10/02/2022 06:28, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>>>   int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
>>>   		xmparam_t const *xmp, mmbuffer_t *result)
>>>   {
>>> -	xdchange_t *xscr1, *xscr2;
>>> -	xdfenv_t xe1, xe2;
>>> -	int status;
>>> +	xdchange_t *xscr1 = NULL, *xscr2 = NULL;
>>> +	xdfenv_t xe1 = { 0 }, xe2 = { 0 };
>>> +	int status = -1;
>>>   	xpparam_t const *xpp = &xmp->xpp;
>>>   
>>>   	result->ptr = NULL;
>>>   	result->size = 0;
>>>   
>>> -	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0) {
>>> -		return -1;
>>> -	}
>>> -	if (xdl_do_diff(orig, mf2, xpp, &xe2) < 0) {
>>> -		xdl_free_env(&xe1);
>>> -		return -1;
>>> -	}
>>
>> OK, xdl_do_diff() calls xdl_free_env(xe) before an error return (I
>> didn't check if patience and histogram also do so correctly), so the
>> original was not leaking xe1 or xe2.
> 
> After I wrote the above, I took a brief look at patience and histogram,
> and it does not seem to release resources held by "env" when it signals
> a failure by returning a negative value.  So it seems that the original
> used with patience or histogram were leaking env when it failed, and
> this patch plugs that small leak.
> 
> If that is indeed the case, please note it in the proposed log
> message.

Oh well spotted, xdl_do_diff() only frees "env" if the myers algorithm 
has an error, if the patience or histogram algorithms have an error then 
they do not free "env" and it is not freed by xdl_do_diff(). This patch 
inadvertently fixes that leak when merging but not when calling 
xdl_do_diff() to compact conflicts in zealous mode or when doing a plain 
diff. I think the simplest fix is to have xdl_do_diff() free "env" when 
there is an error what ever algorithm is used.

I'll try to put a patch together to fix the other cases. If we fix this 
leak in xdl_do_diff() then maybe we should go back to returning -1 in 
the hunk above and explain in the log message why that is ok.

Best Wishes

Phillip

> Thanks.
