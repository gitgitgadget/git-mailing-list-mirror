Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A3071F597
	for <e@80x24.org>; Thu,  2 Aug 2018 02:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbeHBEJ4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 00:09:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42385 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeHBEJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 00:09:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so493087wrs.9
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 19:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MsieUO3MEr0//19QHxqfQES17J2fyIp0Mt5rNwURe2c=;
        b=s51b8C0xaoUL+9kwplfYF9RmOxXeVKNLFoYo7zAAHI4IjUcRUkmwcU9PtaGZ6ROdet
         wJDh0zdjcFeNn1EPtfX84x/9Ig3BRtlxWFF1vfHYmYA1RnyKpYbK6o5Rt0bCne8Gaawb
         Pvj2uKhow+qtm0hM1+SgEzcKdquJzd/86FrBsNMIInIV4KOs1IUZ80FUw7vntZcT4M2A
         hV4t2tc89yCfOdNDM1RlDw4ySqqnghuYFCgVAuvZuSah6mPld5QD1hATUV19dLAXBkob
         +WCDNraJ7QZM0hSBbHf3G+Kw4Z3/T8a0Prdqe1vTrunjR6D8v9KOGNV0F/YiOfa8cH13
         HuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MsieUO3MEr0//19QHxqfQES17J2fyIp0Mt5rNwURe2c=;
        b=Iu8B2Ype85ctZDRKDHSKuVbDFuqXXtsC7EaFg8TE9Bk+E5EQFrQ8BkOA6r+lJP4k89
         0BzcDFUnrefb4hwJNaXe4HjM5NELukozCKguf66IlRf5kf8QlEUAkSNx3d4mzzIopmJw
         YUJG9l84R+1v9wg+5M/yTAs99qCb10N65nt/OHN/4HDQA1XyQRi22yvFXE+OrkvIeHRg
         c11Ha6emMbseRFVV/Ffb4vpWeHJwKpWGgSDwScxQsy2zMHIt0zqYq5yACNIx0FH1XuFM
         A9Dv/ofjMQP9hyaqLV121eWqcWd3LCWVFIxonMq3qf721j5e+11/WEdaf4hw0hzxwMLJ
         SEMg==
X-Gm-Message-State: AOUpUlEs25SEZCaBWrpTXAB3Hv2hQlbWyzm1jFxpdAv/30YJ5Tunx+7h
        91PIluxXr4VX1Eg+P6Cqobw=
X-Google-Smtp-Source: AAOMgpfpLr+Y0LzxlwzDcDfw/bTw3SHzA5MQF/GX9gGcDms6mMs8hG6BfIffIV8PJcVput8kVoJxsg==
X-Received: by 2002:adf:a151:: with SMTP id r17-v6mr91156wrr.169.1533176466967;
        Wed, 01 Aug 2018 19:21:06 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s16-v6sm362117wrq.20.2018.08.01.19.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 19:21:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2] remote: make refspec follow the same disambiguation rule as local refs
References: <xmqq8t5q821c.fsf@gitster-ct.c.googlers.com>
        <20180801230802.GC189024@aiede.svl.corp.google.com>
Date:   Wed, 01 Aug 2018 19:21:05 -0700
In-Reply-To: <20180801230802.GC189024@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Wed, 1 Aug 2018 16:08:02 -0700")
Message-ID: <xmqqo9el4ige.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> +	const int num_rules = ARRAY_SIZE(ref_rev_parse_rules) - 1;
>
> This is assuming ref_rev_parse_rules consists exactly of its items
> followed by a NULL terminator, which is potentially a bit subtle.  I
> wonder if we should put
>
> 	static const char *ref_rev_parse_rules[] = {
> 		"%.*s",
> 		"refs/%.*s",
> 		"refs/tags/%.*s",
> 		"refs/heads/%.*s",
> 		"refs/remotes/%.*s",
> 		"refs/remotes/%.*s/HEAD",
> 		NULL
> 	};
> 	#define NUM_REV_PARSE_RULES (ARRAY_SIZE(ref_rev_parse_rules) - 1)
>
> and then use something like
>
> 	const int num_rules = NUM_REV_PARSE_RULES;

Perhaps.  If we were to go that length, I'd rather first see if we
can lose the sentinel NULL, though.

> Alternatively, what would you think of using the simpler return
> convention
>
> 	return p - ref_rev_parse_rules + 1;
>
> ?  Or even
>
> 	return p - ref_rev_parse_rules;
>
> and -1 for "no match"?

Heh, that is what I did in the "how about this" patch, which made
the caller a bit more cumbersome by two comparisons, which in turn
was why I rejected the approach.

> Sensible and simple.  If we wanted to make items earlier in the list
> return a lower value from refname_match, then we'd need a !best_score
> test here, which might be what motivates that return value convention.

Exactly.  See the discussion between JTan and me on his original
patch.

> [...]
>> --- a/t/t5510-fetch.sh
>> +++ b/t/t5510-fetch.sh
>> @@ -535,6 +535,41 @@ test_expect_success "should be able to fetch with duplicate refspecs" '
>>  	)
>>  '
>>  
>> +test_expect_success 'LHS of refspec follows ref disambiguation rules' '
>
> Clearly illustrates the bug this fixes, in a way that makes it obvious
> that a user would prefer the new behavior.  Good.
>
> With or without the tweak of introducing NUM_REV_PARSE_RULES mentioned
> above,
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

One thing I forgot to mention.

When asking to fetch T, in order to be able to favor refs/tags/T
over refs/heads/T at the fetching end, you would have to be able to
*see* both, so all 6 variants "T", "refs/tags/T", "refs/heads/T",
"refs/remotes/T", "refs/remotes/T/HEAD" must be asked to be shown
when the ls-remote limiting is in effect.  Since the ls-remote
filtering is relatively new development, we may further find subtle
remaining bugs, if there still are some.

