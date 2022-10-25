Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD0BC38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 10:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiJYKBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 06:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiJYJ7t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 05:59:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48E4BBF24
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 02:54:27 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g12so7100012wrs.10
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 02:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2zQ3aCYrWpCSDXCvexSOCtBHE6Wyo+gLuJexUzuyfAo=;
        b=cznlHZVis1vDAuu5YW2B81CRI+YJWWQs/Q+96ZA4VXem4mYlTgniP0NxXwRWtxc9HP
         OyYKGWdrJjKMeR/99qi6Q7SiAzR+xGqf1yXXtSYrtguNyfwRgaaRkXd5x6NDKqoKL6e5
         esp+kjazfzNMmkjeBggem7+qtUsw+AUQ7zlwRlGjpz/Uol0Oi3OODYZkl9dbzoVPclsN
         MI7WQFg8UGNO8+Z+qfW/OfEIxEh5YpYP7ilPYuNgo7N1lt9px1ZHrVEAQcIGHUWzBkcd
         slY7MMZxb3RkbwQMKjxxSVi05UVaC6q2P9QMYmig2s81FeGc95DUQZKG+6IBbZd3/Vix
         6CpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zQ3aCYrWpCSDXCvexSOCtBHE6Wyo+gLuJexUzuyfAo=;
        b=JtKcJdBS5D+vUAjcUmmfGdpX6YTZ5o/qftHTfPfKnEbHdWeRWB2TioHu6KALtHj8lL
         OrAoRyl8EPybeQV0RhI1h/fB8kzYD42SIJkOTLD3+fIT7l5oD3n+FqfMnrk9/PcB5RVy
         HgwSQHQ6EvvIl0CnDP/yTots/mx4ywaen1pi0nn72YA2kBBVzrcz1SyaAKbX6ZF57Pt4
         E6jCs/XyfzkHqY4qDcVj6piU+nGpmVK5fuHN3DX8o0OmifRIADin37lNNOChcHXOaIID
         3jIK8D1MUnEWKT+N7CaU5+C9qe6qkTLJ/czfjbuJaVTXqHJudpS8HeedQWrH3WFtkY5N
         PDxQ==
X-Gm-Message-State: ACrzQf3W2ZltaoNiDKxL3fhJH+Y8MzO3fYhhswtgVdZGX6rNCau4lcri
        uQXskbTyHd1ABrnL4qbyTrY=
X-Google-Smtp-Source: AMsMyM4FPvSmEi3paQXZvtZHGV8bV2MhErJWO+KWpXGZ5dpsEE7FpItzSeCSrY7ZCOxg+u1ibUeBgg==
X-Received: by 2002:a5d:5a8c:0:b0:22c:bc97:6fe2 with SMTP id bp12-20020a5d5a8c000000b0022cbc976fe2mr24133832wrb.640.1666691666051;
        Tue, 25 Oct 2022 02:54:26 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id j12-20020a05600c410c00b003c83465ccbfsm10284599wmi.35.2022.10.25.02.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 02:54:25 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <cb034574-8753-d641-c166-ae2c34b1c589@dunelm.org.uk>
Date:   Tue, 25 Oct 2022 10:54:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] config: require at least one digit when parsing
 numbers
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
 <cd753602e48a2faa0d59edca2f6fab0fe753f0f6.1666359915.git.gitgitgadget@gmail.com>
 <xmqqwn8tjazb.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqwn8tjazb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 21/10/2022 19:19, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> @@ -1167,6 +1167,10 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
>>   		val = strtoimax(value, &end, 0);
>>   		if (errno == ERANGE)
>>   			return 0;
>> +		if (end == value) {
>> +			errno = EINVAL;
>> +			return 0;
>> +		}
> 
> This means well, but doesn't strto*() family of functions silently
> ignore leading blanks, e.g.
> 
>      l = strtol("  432k", &end, 0);
> 	... l == 432, *end = k ...
> 
> If you really want to reject a string with no number before the
> optional unit, end at this point may not match value.  With " k" as
> input, value would point at the space at the beginning, and end
> would point at 'k'.

It only skips the space if it sees a digit, if it does not find anything 
to convert it sets *end = start. Using peff's trick for testing this 
patch we can see there is no change in behavior if there is leading 
whitespace

$ bin-wrappers/git config --int --default " m" some.key
fatal: bad numeric config value ' m' for 'some.key': invalid unit

$ git config --int --default " m" some.key
fatal: bad numeric config value ' m' for 'some.key': invalid unit

> It does not look _too_ bad if we just let such an empty string
> through and interpreted it as zero.  Is that a problem?  Who are we
> trying to help?

My reasoning was that a single units factor is likely to be the result 
of some kind of bad edit and defaulting to zero when the user thought 
they set a large value is not likely to be helpful. Having said that I'm 
not that wedded to this patch if you feel it would be better to drop it.

Best Wishes

Phillip
