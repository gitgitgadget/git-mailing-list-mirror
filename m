Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22B8D1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 02:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389005AbeKGLg5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 06:36:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37843 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388888AbeKGLg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 06:36:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id p2-v6so14177456wmc.2
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 18:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=h7ySAIOTP2iSlOjLdMbMFO7KuLw0QZQ2udHvf8RlVMo=;
        b=DbhWgPYXfIhUfof6jzb2CcvEDh2nPHtk71OEMIHSPqfdeHHkGgZ2QIMCBv7FK5zHf+
         ay6MkZsJ7aDbsbYaRkF0g/9PV1ZnTyg1sHiH+Z2IX2awQqohR9D0Op5aiHXrvk12XuE2
         Hlb7MBTskgQi0AdlWXec94mbNuuj9sS3Sqgfak/QjLkoUp6Oa3ch4PptaqUdH1v6W9+X
         8x9vpeuHquha70+/nLxL2i63ABEjf9a7es7Pepl5P+/1Y9OcsAcQxUJ44fUwIfvAKOsV
         pv+ZwQJ/D45NiuEPom6FxE7RRQcldcGSBdHwB05iuQBNGgI+2VRg43rCR4qyT8I3MxkA
         cfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=h7ySAIOTP2iSlOjLdMbMFO7KuLw0QZQ2udHvf8RlVMo=;
        b=UqE7AAmqfzKWS+NSoX8dgYlUt2obMc4IwxSXv2o/zxDBCQBEJKxUxobg4pqJ8C6JSV
         ZQ7mKEeyt2pF1vdIdDGRYjcaMUULbYkkcY4fMt9qEEimUtOzMAlD89yPm4Xg2ZgsR5vQ
         gvzEy0J5s5Xu0WnI2egPmXP1JcnCL0qfnWeoT+KtLSuR7UnUl+HEVHw0OQilru3Arx0N
         2fAc8mICb8bs0kfJ9CN3s+J6zNrSZ7zsin3pxK+wD2qX39QFsuORKbm2Ic8nSItOoIRy
         m4dmonQ03XgFtjLqSG0Htt0y+KIwcFZUVI98UYU4e6/Kcrq3PMUxym9AWK7vlCx+rdoQ
         Iy7Q==
X-Gm-Message-State: AGRZ1gKWlwHyjlGLovvQBYI8u/oLFtWgLzqeTbW8KrbRDksufFec3DdK
        577b5m8L1RWg2k1XV8FZzzA=
X-Google-Smtp-Source: AJdET5fvkgApJbvgICqFp3osYkQ91meFZ0p8olNriliurwmPd4TCZjIvkiCWzDUQuKi1GYrgQStCMg==
X-Received: by 2002:a1c:6754:: with SMTP id b81-v6mr278236wmc.104.1541556520430;
        Tue, 06 Nov 2018 18:08:40 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z7-v6sm14640601wrv.21.2018.11.06.18.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 18:08:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] approxidate: handle pending number for "specials"
References: <20181102052239.GA19162@sigill.intra.peff.net>
        <20181102052309.GB19234@sigill.intra.peff.net>
        <CAPUEspi12TtKxKGr=tutfLPNPWhaZmGCh7q4D1LRJ9LFTWwKNA@mail.gmail.com>
        <20181107011253.GA18276@sigill.intra.peff.net>
Date:   Wed, 07 Nov 2018 11:08:38 +0900
In-Reply-To: <20181107011253.GA18276@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 6 Nov 2018 20:12:53 -0500")
Message-ID: <xmqqbm71d4gp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Nov 06, 2018 at 04:48:28PM -0800, Carlo Arenas wrote:
>
> I think date_yesterday() is the only one of those special functions that
> gets called like this. Here's what I think we should do to fix it (this
> can go right on top of jk/misc-unused-fixes, which is already in next).

Thanks, both.  I think the patch makes sense.

> -- >8 --
> Subject: [PATCH] approxidate: fix NULL dereference in date_time()
>
> When we see a time like "noon", we pass "12" to our date_time() helper,
> which sets the hour to 12pm. If the current time is before noon, then we
> wrap around to yesterday using date_yesterday(). But unlike the normal
> calls to date_yesterday() from approxidate_alpha(), we pass a NULL "num"
> parameter. Since c27cc94fad (approxidate: handle pending number for
> "specials", 2018-11-02), that causes a segfault.
>
> One way to fix this is by checking for NULL. But arguably date_time() is
> abusing our helper by passing NULL in the first place (and this is the
> only case where one of these "special" parsers is used this way). So
> instead, let's have it just do the 1-day subtraction itself. It's still
> just a one-liner due to our update_tm() helper.
>
> Note that the test added here is a little funny, as we say "10am noon",
> which makes the "10am" seem pointless.  But this bug can only be
> triggered when it the currently-parsed hour is before the special time.
> The latest special time is "tea" at 1700, but t0006 uses a hard-coded
> TEST_DATE_NOW of 1900. We could reset TEST_DATE_NOW, but that may lead
> to confusion in other tests. Just saying "10am noon" makes this test
> self-contained.
>
> Reported-by: Carlo Arenas <carenas@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  date.c          | 2 +-
>  t/t0006-date.sh | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/date.c b/date.c
> index 7adce327a3..9bc15df6f9 100644
> --- a/date.c
> +++ b/date.c
> @@ -929,7 +929,7 @@ static void date_yesterday(struct tm *tm, struct tm *now, int *num)
>  static void date_time(struct tm *tm, struct tm *now, int hour)
>  {
>  	if (tm->tm_hour < hour)
> -		date_yesterday(tm, now, NULL);
> +		update_tm(tm, now, 24*60*60);
>  	tm->tm_hour = hour;
>  	tm->tm_min = 0;
>  	tm->tm_sec = 0;
> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index b7ea5fbc36..ffb2975e48 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -114,6 +114,7 @@ check_approxidate '15:00' '2009-08-30 15:00:00'
>  check_approxidate 'noon today' '2009-08-30 12:00:00'
>  check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
>  check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
> +check_approxidate '10am noon' '2009-08-29 12:00:00'
>  
>  check_approxidate 'last tuesday' '2009-08-25 19:20:00'
>  check_approxidate 'July 5th' '2009-07-05 19:20:00'
