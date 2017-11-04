Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C14B20281
	for <e@80x24.org>; Sat,  4 Nov 2017 07:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbdKDHds (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 03:33:48 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:46187 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751614AbdKDHdr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 03:33:47 -0400
Received: by mail-wm0-f47.google.com with SMTP id r68so5156168wmr.1
        for <git@vger.kernel.org>; Sat, 04 Nov 2017 00:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tCz3ozHHO3q1Femh/DWAyW99NXLim3VWc3/AvxiEAbY=;
        b=mpf2KCbqPZ2mzxnkCBqzD8jN4qATA/8SIeYgwAFKE7CnrbsEGcdjQrExMA00yPxG/v
         62pMzo8EA18ojPL8nWpcphS709t+eZDCXBudfIZdnUPtp1Xqtme4stFmTEGDJfKlKNrx
         uH6rW8S3tyjVwuKwaW5DN+REeOoAIa0wYlLSfRF3Dc9g6jgEXPDSyNHzOSOvz+TRxn65
         pO74riDwVcZJ33FiXiuHOwrvnENPpBCuQNIvOzjwWh1AiJ3jPewifrPk8CcNBVdki4BA
         1fP5As6mx3OE5rKMg5X2eE/CkIQPaQPSXMwE8jMbER1UA5DNKajMPq5qeDbjZQHlrxFk
         CjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tCz3ozHHO3q1Femh/DWAyW99NXLim3VWc3/AvxiEAbY=;
        b=fA3c5WT5VJYMZE70xUEwgbfnzxt972gYhiAzpmLQL33k6ORaSKcRFSXN8MVVW3y0JL
         P9/wkGtn9vZ5jY0Ttr7Vv14Rgu28O8pFNMc6xhBy0hLXLhz+pLxT00QEg31JrncHVM3S
         4ix1nVdLDbXZ6qIcrL+SJHkNFkOnT9g4TM7eEmz9QOPcWvhg8G7DyV/vi0fKdpicOafT
         KETGuS+9ZxxBa2159UmMFMyyChG9tzQSAG326oOfG0In5FQhLPBk0BEAHm/wOLMFiIIY
         faDaP2g2AWvR4ps9AxCGxYVaTF8WVo7xle/QT35R6LYMYYyoeGMoqwl0MWna38qaqPyz
         VbXA==
X-Gm-Message-State: AMCzsaUEt1ClSKqBNxP1okQzwMgrAOXpAJfKphei4U+ZeZtUYxO68Ag3
        uNRBZoWpn/G6bdjKyymMmU0=
X-Google-Smtp-Source: ABhQp+TQEEYJ1r91HLEHAWY3MLxNGj8+0+waxaC7NM5/9/uTDFVq79kJ7YqXewfqM3BTzE6+KmDhyg==
X-Received: by 10.80.179.246 with SMTP id t51mr11788879edd.176.1509780826380;
        Sat, 04 Nov 2017 00:33:46 -0700 (PDT)
Received: from [192.168.1.22] (101.154.108.93.rev.vodafone.pt. [93.108.154.101])
        by smtp.gmail.com with ESMTPSA id c34sm8149824ede.84.2017.11.04.00.33.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Nov 2017 00:33:45 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] refs: extract function to normalize partial refs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, me@ikke.info, hjemli@gmail.com,
        mhagger@alum.mit.edu, pclouds@gmail.com,
        ilari.liusvaara@elisanet.fi
References: <20171104004144.5975-1-rafa.almas@gmail.com>
 <20171104004144.5975-2-rafa.almas@gmail.com>
 <xmqqo9oiok10.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Rafael_Ascens=c3=a3o?= <rafa.almas@gmail.com>
Message-ID: <1e2e8f85-e13d-47f9-6661-1e685250c775@gmail.com>
Date:   Sat, 4 Nov 2017 07:33:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqo9oiok10.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11/17 02:27, Junio C Hamano wrote:
> Rafael Ascensão <rafa.almas@gmail.com> writes:
> 
>> Signed-off-by: Kevin Daudt <me@ikke.info>
>> Signed-off-by: Rafael Ascensão <rafa.almas@gmail.com>
> 
> Could you explain Kevin's sign-off we see above?  It is a bit
> unusual (I am not yet saying it is wrong---I cannot judge until I
> find out why it is there) to see a patch from person X with sign off
> from person Y and then person X in that order.  It is normal for a
> patch authored by person X to have sign-off by X and then Y if X
> wrote it, signed it off and passed to Y, and then Y resent it after
> signing it off (while preserving the authorship of X by adding an
> in-body From: header), but I do not think that is what we have here.
> 
> It could be that you did pretty much all the work on this patch
> and Kevin helped you to polish this patch off-list, in which case
> the usual thing to do is to use "Helped-by: Kevin" instead.

That's more or less what happened. I wouldn't say I did "pretty much all 
the work". Yes, I wrote the code but with great help of Kevin. The 
intention of the dual Signed-off-by was to equally attribute authorship 
of the patch. But if that creates ambiguity I will change it to 
"Helped-by" as suggested.

> It is better to use "unsigned" for a single word "flags" used as a
> collection of bits.  In older parts of the codebase, we have
> codepaths that pass signed int as a flags word, simply because we
> didn't know better, but we do not have to spread that practice to
> new code.

I noticed this, but chose to "mimic" the code around me. I'll correct it.
On a related note is there a guideline for defining flags or are
`#define FLAG (1u << 0)`, `#define FLAG (1 << 0)`
`#define FLAG 1` and `#define FLAG 0x1` equally accepted?

>>   {
>> -	struct strbuf real_pattern = STRBUF_INIT;
>> -	struct ref_filter filter;
>> -	int ret;
>> -
>>   	if (!prefix && !starts_with(pattern, "refs/"))
>> -		strbuf_addstr(&real_pattern, "refs/");
>> +		strbuf_addstr(normalized_pattern, "refs/");
>>   	else if (prefix)
>> -		strbuf_addstr(&real_pattern, prefix);
>> -	strbuf_addstr(&real_pattern, pattern);
>> +		strbuf_addstr(normalized_pattern, prefix);
>> +	strbuf_addstr(normalized_pattern, pattern);
>>   
>> -	if (!has_glob_specials(pattern)) {
>> +	if (!has_glob_specials(pattern) && (flags & ENSURE_GLOB)) {
>>   		/* Append implied '/' '*' if not present. */
>> -		strbuf_complete(&real_pattern, '/');
>> +		strbuf_complete(normalized_pattern, '/');
>>   		/* No need to check for '*', there is none. */
>> -		strbuf_addch(&real_pattern, '*');
>> +		strbuf_addch(normalized_pattern, '*');
>>   	}
>> +}
> 
> The above looks like a pure and regression-free code movement (plus
> a small new feature) that is faithful to the original, which is good.
> 
> I however notice that addition of /* to the tail is trying to be
> careful by using strbuf_complete('/'), but prefixing with "refs/"
> does not and we would end up with a double-slash if pattern begins
> with a slash.  The contract between the caller of this function (or
> its original, which is for_each_glob_ref_in()) and the callee is
> that prefix must not begin with '/', so it may be OK, but we might
> want to add "if (*pattern == '/') BUG(...)" at the beginning.
> 
> I dunno.  In any case, that is totally outside the scope of this two
> patch series.

I guess it doesn't hurt adding that safety net.

> Thanks.  Other than the above minor points, looks good to me.
I'll fix the mentioned issues. Thanks.
