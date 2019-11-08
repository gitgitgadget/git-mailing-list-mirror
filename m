Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CF571F454
	for <e@80x24.org>; Fri,  8 Nov 2019 21:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732937AbfKHVTN (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 16:19:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33114 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732900AbfKHVTN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 16:19:13 -0500
Received: by mail-pf1-f195.google.com with SMTP id c184so5534695pfb.0
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 13:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NnrMqqM1WTHzulbJEuqFNZTqPMTbY6FvGBvkkWPM1p8=;
        b=V4WDesouCjpXr9++OpVj5ahX9ooTwsxX258xgHpIfQwmhbSDYUQHbUbJGsabkQJrfb
         AJ2Y8For+FWlngGg8Zc1y2q7cErufjkkgCu/5uGm7N7ppJm31ONwyMGLkp45OjZwcLtE
         6TJdOSZ/BiUwKD/ByIHgU7m196KsWuX2Q4CIoZgLVwCW6OYy1rxZIqsvZLhTaPdlKbWU
         gxXOkYvfk+hXXPUkLaFfHpqFmj5sr6kItRUm3XgGQQNtRo6LVWusuqlwOQO6rA02GyIl
         JQw1f9Ur5Guaw5n5VMorDiDawvEppKTGmFy7ZRKsO6T3jJu0Z7P7fbYgMuBVpioRGbpA
         Xmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NnrMqqM1WTHzulbJEuqFNZTqPMTbY6FvGBvkkWPM1p8=;
        b=TUDUeu4ryl6m9zy3Explc8N1TuUwrkcqLShirlIcQ4hWGH/4pn8yolseKXAmxU5niB
         C5oZU//axyw7EzsDSzuIIPZtfhG58A85xcyUHww9RKRcuYayxGYEUI61TYoBHhT4HpBU
         RONZGo9CeNyn04SWb5X41Tcs9RM2G30Nn3anpFe8xy8GYImHr9BymnATadR68LA2VSWa
         zo+IccKDt3hRyRSCljVejLA+hSfzwCquOVzRxTWG44R4sFuGOd7HpLXGnArGWj4lUrsd
         Z+/a6/fgEL/AZtBThuSxg6ysJCcoL+PCdj6a911Tcw6/hD31GeFSayX74x0dm95zN0+8
         nHcw==
X-Gm-Message-State: APjAAAW5sqh1IskLM0knuDTc4L7jBqcEJr2eMx1Q/mBfLDXaQK/q2EJ4
        JMIk8wtHTyl9GabumsUABWXw7qW2
X-Google-Smtp-Source: APXvYqxPMxYAburaaIOf+YOv37lXB/c4bvQ04a1U881GjmTFIsP5JDFIRdO41jAMld069xd8vZjXIA==
X-Received: by 2002:a62:ee07:: with SMTP id e7mr391688pfi.52.1573247952541;
        Fri, 08 Nov 2019 13:19:12 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id a12sm2795220pfk.188.2019.11.08.13.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 13:19:11 -0800 (PST)
Date:   Fri, 8 Nov 2019 13:19:09 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 01/14] t: teach test_cmp_rev to accept ! for not-equals
Message-ID: <20191108211909.GA80210@generichostname>
References: <cover.1571739459.git.liu.denton@gmail.com>
 <cover.1573152598.git.liu.denton@gmail.com>
 <0d0696f310a6f8e13ed480b1a1e91cdc2debaa20.1573152599.git.liu.denton@gmail.com>
 <xmqqpni3nj8j.fsf@gitster-ct.c.googlers.com>
 <20191108082310.GA2497@generichostname>
 <xmqqa796mt35.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa796mt35.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, Nov 08, 2019 at 09:49:02PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
>
> >> >  		local r1 r2
> >> >  		r1=$(git rev-parse --verify "$1") &&
> >> >  		r2=$(git rev-parse --verify "$2") &&
> >>
> >> If either of the calls fail, the assignment itself would fail, and
> >> the &&-cascade would stop without executing the if statment below.
> >>
> >> I see the "!" feature, but where is the promised "fix" for
> >> segfaulting rev-parse?
> >>
> >> Puzzled.
> >
> > I suppose your puzzlement comes from my badly worded commit message
> > above. I meant to say that in the _hypothetical_ case that
> > `git rev-parse` segfaults, it wouldn't be caught because we're
> > blanket-ignoring failures if we do `! test_cmp_rev`.
> >
> > But I suppose I focused too much on segfaults. I guess I didn't realise
> > that the problem is more general than that; any failure of
> > `git rev-parse` should be reported.
>
> But if that is the case, shouldn't the part that runs two rev-parse
> read more like this?
>
> 	r1=$(git rev-parse --verify "$1") ||
> 		error "'$1' does not name a valid object"
> 	r2=$(git rev-parse --verify "$2") ||
> 		error "'$2' does not name a valid object"
> 	if ! test "$r1" $op "$r2"
> 	then
> 		... they do not compare the same ...
> 	fi

With your suggestion, we actually introduce subtle undesired behaviour.
The `error` calls don't actually exit the function early. To make it
work, we need to add && to the end of the `error` calls.

I'm wondering why we want to do this, though. rev-parse should already
output an error message on stderr in the case where the rev-parse fails.
I guess the error message of "fatal: Needed a single revision" could
probably be improved but that feels like an improvement that should be
targeted to rev-parse.

>
> Offhand I do not know if the current callers depend on being able to
> pass a string that is not an object name in either $1 or $2 and a
> valid object name in the other one, and relying on the helper
> function to say "$1 and $2 are different!"  If such callers exist, a
> defensive change like the above that requires the caller to always
> pass valid object names would need to be accompanied with changes to
> these callers, too.  Overall, I think that would give us a better
> end result, but it might be a bit more work.

This patch changes all instances of `! test_cmp_rev` to
`test_cmp_rev !`. Since nothing failed after applying the patch, I
believe that all callers already pass in valid object names.

Thanks,

Denton

>
> Thanks.
