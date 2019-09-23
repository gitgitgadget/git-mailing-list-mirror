Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717A81F463
	for <e@80x24.org>; Mon, 23 Sep 2019 08:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbfIWIh2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 04:37:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37313 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbfIWIh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 04:37:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id i1so12889455wro.4
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 01:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0V2lK5EbjwysN0Idvw3CJJr7Siq4OfP8/TeHHu0vosk=;
        b=EW/SRZT+wv2ZaC215hNW/wwZKlY2nJtKdtB2oPB9/RyLPsv6vxjhECkoSKpBL+1OeG
         /1b4oruJyXOWrLwMPP1j1LTSWr8aSEXHrfqXQ7f96LbcJpm351TwYw+wFEWnXDzopFcs
         aVX5XF1SMsZqCHUT8d8Zcep4m0ypW06iXKDgsHSF0pc/VrpXJVHFLp8ZXw6cGlkMGtMw
         6gBMIKU7EdskKjbqHR+pqEBJbaNxJs2yLz//fKfJ7YNuam4frqmalVQniWBhIBbquHUi
         hFpwnJBd155XnQOVOa6YV1/+tWnS7bduFTdKOvz5F//Olnes3bro1iNfkPWrIHC9/k6f
         DzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0V2lK5EbjwysN0Idvw3CJJr7Siq4OfP8/TeHHu0vosk=;
        b=fHh5PjiXaAvl9I4rTRYFPwZ/71okHvAsYnuxCXBPHO+I0tLkEy7S9df8teMZthy8xI
         E9R5repTbIhZ+qvwSBMVpyHksxXxu2jMdmCYrcFggEdSaym3nR7dQBkwGtba5TVcRTZ6
         mO4Af5bsJg2/B+ymjtbw3nud8hIIMhFVafajvCx5T6MeHnA+BZl1qmAD5wC0Chyl7WOW
         JnQTmebZ/4ujrEO6wUJ2Xd2ZEae9X625GaVIKAIjc0hztxRM5tgYDMpKaBMhvcXsTN5c
         kNl+Q1xEbVq9DEWqq7gMMu5Ae9JFb6V2dQPuqvx6bhibOm6/MPbpD8G8PprDeR7pIYsq
         AgSw==
X-Gm-Message-State: APjAAAWnVcixpqKLiZrsWEvsx/Jou7cgYZiU6dbvZHByKIQGinqxGWDc
        iV27j/nzr/Pj2UbmYxuTy4k=
X-Google-Smtp-Source: APXvYqx6lG2IEwUeRWZ0wi8DA4sb5aj62o5t2dP8CwgS2K+ImAclmytQVJc2GebtSAD6b0ZRueGbOQ==
X-Received: by 2002:a5d:6a09:: with SMTP id m9mr8675529wru.12.1569227846416;
        Mon, 23 Sep 2019 01:37:26 -0700 (PDT)
Received: from szeder.dev (x4db53381.dyn.telefonica.de. [77.181.51.129])
        by smtp.gmail.com with ESMTPSA id p85sm19812114wme.23.2019.09.23.01.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 01:37:25 -0700 (PDT)
Date:   Mon, 23 Sep 2019 10:37:23 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] name-rev: avoid cutoff timestamp underflow
Message-ID: <20190923083723.GD10866@szeder.dev>
References: <20190922180143.25026-1-szeder.dev@gmail.com>
 <5692e751-ae5b-e1c8-e5f7-79f0b43e20c0@gmail.com>
 <20190922195312.GC10866@szeder.dev>
 <8e7617ef-85d0-df3f-4418-5a2502b8e726@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e7617ef-85d0-df3f-4418-5a2502b8e726@kdbg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 22, 2019 at 11:01:26PM +0200, Johannes Sixt wrote:
> Am 22.09.19 um 21:53 schrieb SZEDER Gábor:
> > On Sun, Sep 22, 2019 at 07:57:36PM +0100, Phillip Wood wrote:
> >> On 22/09/2019 19:01, SZEDER Gábor wrote:
> >>> +/*
> >>> + * One day.  See the 'name a rev close to epoch' test in t6120 when
> >>> + * changing this value
> >>> + */
> >>> +#define CUTOFF_DATE_SLOP 86400
> >>>  typedef struct rev_name {
> >>>  	const char *tip_name;
> >>> @@ -481,8 +485,13 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
> >>>  		add_object_array(object, *argv, &revs);
> >>>  	}
> >>> -	if (cutoff)
> >>> -		cutoff = cutoff - CUTOFF_DATE_SLOP;
> >>> +	if (cutoff) {
> >>> +		/* check for undeflow */
> >>> +		if (cutoff - CUTOFF_DATE_SLOP < cutoff)
> >>
> >> Nice catch but wouldn't this be clearer as
> >>   if (cutoff > CUTOFF_DATE_SLOP) ?
> > 
> > It would only be clearer now, with an unsigned 'timestamp_t'.  I
> > tried to future-proof for a signed 'timestamp_t' and a cutoff date
> > before the UNIX epoch.
> 
> Huh? For signed cutoff and positive CUTOFF_DATE_SLOP,
> cutoff - CUTOFF_DATE_SLOP < cutoff is ALWAYS true. Signed interger
> underflow is undefined behavior and signed integer arithmetic does not
> wrap around!
> 
> IOW, the new condition makes only sense today, because cutoff is an
> unsigned type, but breaks down should we switch to a signed type.

Yeah, that's what I meant with worrying about signed underflow in the
commit message.  As long as the cutoff is at least a day later than
the minimum value of our future signed 'timestamp_t', the condition
does the right thing.  And considering that oldest time a signed 64
bit timestamp can represent far exceeds the age of the universe, and
the oldest value of even a signed 32 bit timestamp is almost half the
age of the Earth, I wasn't too worried.

> You need this on top:
> 
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index a4d8d312ab..2d83c2b172 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -487,10 +487,10 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
>  
>  	if (cutoff) {
>  		/* check for undeflow */
> -		if (cutoff - CUTOFF_DATE_SLOP < cutoff)
> +		if (cutoff > TIME_MIN + CUTOFF_DATE_SLOP)
>  			cutoff = cutoff - CUTOFF_DATE_SLOP;
>  		else
> -			cutoff = 0;
> +			cutoff = TIME_MIN;
>  	}
>  	for_each_ref(name_ref, &data);
>  
> diff --git a/git-compat-util.h b/git-compat-util.h
> index c68c61d07c..1bdc21a069 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -344,6 +344,7 @@ typedef uintmax_t timestamp_t;
>  #define PRItime PRIuMAX
>  #define parse_timestamp strtoumax
>  #define TIME_MAX UINTMAX_MAX
> +#define TIME_MIN 0
>  
>  #ifndef PATH_SEP
>  #define PATH_SEP ':'
