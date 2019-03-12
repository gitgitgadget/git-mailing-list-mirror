Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D15520248
	for <e@80x24.org>; Tue, 12 Mar 2019 06:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfCLGpr (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 02:45:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44571 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfCLGpr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 02:45:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id w2so1327194wrt.11
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 23:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IN432n5xVwU03rnMWbZ7XMx+Oxsg8Y3PZHIp73mBurQ=;
        b=KlOXDwAlDETupvazcCSo+vqNn2/9+Hun2xgmWRJwm6TKNrNwfaweR8UtijuCJF4wy8
         yRfXreb0KSTv+pYzXKkFzMgEQYKiPuOXR6xywX13sEm1AtA5yMAG+3Sop/q6+SHyjuoQ
         LoZXrEWIvvhEE5NFZF5TQdlmzjd2mWApZvFlskQDeonUgxG3N7T9RUiWK5i7jFxJDG61
         OnOrdt7HSD2s30pTfvTvAtN5EtLtZjlL8hk54WrwA5GAwef+IAFtz/q3swsNH6xI0e4k
         Ej4Q7MiL+UrIMxZSMOIIQxX79DJLkMXf3OvKjI3rfB2FWUNfFxycJ1JNqnFrKmuvPvqD
         wi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IN432n5xVwU03rnMWbZ7XMx+Oxsg8Y3PZHIp73mBurQ=;
        b=PV+aNJEGt5NPLquy8bk2nsy8doycPtgyrQtWBVqvU1CUbLWVKY7EpozurafGGW3aPT
         AuCMspPl0SYUXWCx5zEjTA4YUsxVaJ1yil7myAAguzaN0ACoxvaSO4ZWPE0G0xWDr174
         mINkf48d1wHLJA6Zjtn3XUra37QDFcqMOdckyU/mYdTTMR0NMGaKwCqi1IBhasnW1wfn
         Dt6AUtdyhrkpMvaPdbIfJCT8pVN8B/4Z/60MEbYkLgO1wESOktARq8wk9J2SOHuaFPNm
         vBJurSKt8wOhHTjtNsV6H/kKR3PTebLL5Tw8V0XqQXK/1rzy+syer1m4Ppi519EertNp
         2TfQ==
X-Gm-Message-State: APjAAAUi0M2TnwKNE7tt90dRfppYMNhZHeEDwgeGWPhacaG0CeKRfzqY
        ctwBVXDPn/DBt6a1mwSVneg=
X-Google-Smtp-Source: APXvYqzVY323T8O572NBO02Ouzz5PBoUaJtIFY+xw+0XNmjW/KBs0W6EC4H3lVc9/4lEkTOd3DgevQ==
X-Received: by 2002:adf:f04f:: with SMTP id t15mr6617591wro.232.1552373144948;
        Mon, 11 Mar 2019 23:45:44 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x10sm5140663wrs.56.2019.03.11.23.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 23:45:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, hi-angel@yandex.ru, peff@peff.net,
        ramsay@ramsayjones.plus.com, sunshine@sunshineco.com
Subject: Re: [PATCH v5 1/1] worktree add: sanitize worktree names
References: <20190305120834.7284-1-pclouds@gmail.com>
        <20190308092834.12549-1-pclouds@gmail.com>
        <20190308092834.12549-2-pclouds@gmail.com>
        <nycvar.QRO.7.76.6.1903111401220.41@tvgsbejvaqbjf.bet>
Date:   Tue, 12 Mar 2019 15:45:43 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1903111401220.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 11 Mar 2019 14:05:32 +0100 (STD)")
Message-ID: <xmqqzhq0h9pk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +static int check_refname_component(const char *refname, int *flags,
>> +				   struct strbuf *sanitized)
>>  {
>>  	const char *cp;
>>  	char last = '\0';
>> +	size_t component_start;
>
> This variable is uninitialized. It is then...
>
>> +
>> +	if (sanitized)
>> +		component_start = sanitized->len;
>
> ... initialized only when `sanitized` is not `NULL`, and subsequently...
> ...
>> +	if (refname[0] == '.') { /* Component starts with '.'. */
>> +		if (sanitized)
>> +			sanitized->buf[component_start] = '-';
> ...
> ... used a loooooooong time after that, also only if `sanitized` is not
> `NULL`.
>
> Apparently for some GCC versions, this is too cute, and it complains that

It does require humans (well, at least it did to this one) to be
careful when reading the code to know that component_start is valid
when it is used.

There unfortunately is no good "default" value to initialize the
variable to.  When checking a later component in a series of
components, it would be looking at non-zero position, so even
initializing it to 0 in this function is *not* a more sensible
fallback default value than any other random garbage value (which
would squelch the compiler, but it would mislead the humans
nevertheless).

And that (i.e. the lack of any sensible default value when sanitized
is NULL) is the reason why the variable is left uninitialized by the
patch, I think.  I do not think the code is trying to be cute at
all.

I wonder if we make the caller pass a pointer to

	struct {
		struct strbuf result;
		size_t component_start;
	} sanitized;

	sanitized.component_start = sanitized.result.len
	check_refname_component(refname, flags, &sanitized);

and get rid of the assignment to component_start done by the callee,
it would appease compilers and makes the code easier to vet.  It does
introduce one more ad-hoc type, which is a certain downside.

I dunno.
