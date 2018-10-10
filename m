Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_ABUSE_SURBL shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7F8B1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 13:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJJUwM (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 16:52:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39040 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeJJUwM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 16:52:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id d15-v6so4921081edq.6
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D8xhuL29P/clTVB0saP2+DYz5xJCRME2UG1IMPGwpck=;
        b=E67OxLv2/lQhOB8/Igtq/NFNrf76AJxuetrLE5+T4zuEYXE+CvrsAc6jK1AsilZufA
         nEEVqHS0WxWFrYQUIzleLWLFKIKaCJA1gJb+Zfu8zLYyd3eLFzaXOOW/NaRMAKAnM8QU
         akTs/ex31qPApTaVxxwh3fnbxUlK/Iw0oeisQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D8xhuL29P/clTVB0saP2+DYz5xJCRME2UG1IMPGwpck=;
        b=G0HaR7JOY0WoMug+GhJ+Ww1Hd3atGkSbVg6XYGwJrrxWt8a+bNeWqiNs3ln/9dnGzA
         61UgOdbQ09oJTNaX1+krd0I76RZMnhjKE+JM0M7dGetraVSGk8kJ08Z9nfthDuxPrz83
         j4t7q8OaZ8xa6NEpz8RRpfYYuZvxkCxwpmfO44bL40rKmBa6WKcuFI2gp/rZcE2M1aTv
         1HpVHog7jRCWrm0x1BnUSXxuRADDJB3Pa6ooo3wUS72KTL0Bq6OekEQ6D1Do53+gYYeI
         xxXgyJQ9bw1k/tNY6z0hfiVN1sVsc2I8hRMnR5vsq5xd7Jz5DOcuqkqt1Sy4Uedh3Plz
         96ow==
X-Gm-Message-State: ABuFfoh5roeUl+XfKs1xZ+qL46y6BZQ2cEh5lpfyQ2NRTZHgKnu8S7jl
        U7hRHlbUEOspOKKsvy9l5GJ1ftuR/sg=
X-Google-Smtp-Source: ACcGV60Z6Z20LuwNW1ul+hLHmHBM0/dEFhpxn0WEpOEdkz+iHTxjX+RDFgiDreGiIFmIZPL/RWCRFQ==
X-Received: by 2002:a17:906:4d47:: with SMTP id b7-v6mr32725998ejv.76.1539178198972;
        Wed, 10 Oct 2018 06:29:58 -0700 (PDT)
Received: from [172.26.255.55] ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id y13-v6sm4150128ejw.26.2018.10.10.06.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 06:29:58 -0700 (PDT)
Subject: Re: [PATCH 2/3] send-email: only consider lines containing @ or <>
 for automatic Cc'ing
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
 <20181010111351.5045-3-rv@rasmusvillemoes.dk>
 <871s8yez74.fsf@evledraar.gmail.com>
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Message-ID: <7b03da07-4301-1b42-b8a2-a29e4e1f80d0@rasmusvillemoes.dk>
Date:   Wed, 10 Oct 2018 15:29:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <871s8yez74.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-10-10 14:57, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Oct 10 2018, Rasmus Villemoes wrote:
> 
>> +			if ($c !~ /.+@.+|<.+>/) {
>> +				printf("(body) Ignoring %s from line '%s'\n",
>> +					$what, $_) unless $quiet;
>> +				next;
>> +			}
>>  			push @cc, $c;
>>  			printf(__("(body) Adding cc: %s from line '%s'\n"),
>>  				$c, $_) unless $quiet;
> 
> There's a extract_valid_address() function in git-send-email already,
> shouldn't this be:
> 
>     if (!extract_valid_address($c)) {
>     [...]
> 
> Or is there a good reason not to use that function in this case?
> 

I considered that (and also had a version where I simply insisted on a @
being present), but that means the user no longer would get prompted
about the cases where the address was just slightly obfuscated, e.g. the

Cc: John Doe <john at doe.com>

cases, which would be a regression, I guess. So I do want to pass such
cases through, and have them be dealt with when process_address_list
gets called.

So this is just a rather minimal and simple heuristic, which should
still be able to handle the vast majority of cases correctly, and at
least almost never exclude anything that might have a chance of becoming
a real address.

Rasmus
