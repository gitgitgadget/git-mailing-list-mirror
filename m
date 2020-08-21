Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8499C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 10:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B3F9207DA
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 10:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evEibZtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgHUKD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgHUKD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 06:03:26 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AAEC061385
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 03:03:25 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id a6so223619oog.9
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 03:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SJ3W24NIZD8uW2NdpaDKtLItHTx2tSUgSI2uyegG6Rc=;
        b=evEibZtGQyNM8wJWw62XWmZ2m2+qq8FpyQwL+Bhk48xEe9rzWBz7XFmkgflgtNIGBy
         7S0UL/CmMjuWbYy4Ufp4k2UzXItKCYjsRK0ldc2BlU33Zl4aEUPE/MCpn3y1ngnzstRC
         9dr2mlHCuRp2L6jZLcmTGBETblREKXQRkZaFuCqmIfkvF7SZqDnNy7BblCUnE86gu8Rl
         WIt7MqRwTZquu/OkfYSdq3FLu9CklbwXSlOpuDCEGS1QAuxaKBYnD0w9HZ1hH5nQdRYA
         TR+iH0kcd7SHT9ZUSXFfu1wLkPYQnLfExKxeNWezGi4J4TiCCFiQBy7ZPIyAKwpFN59r
         td2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJ3W24NIZD8uW2NdpaDKtLItHTx2tSUgSI2uyegG6Rc=;
        b=N1Nfgk+QyfaSOlQtYXfd9iuIuXwQcfmw2om16t2nBRa1Es22MODL4KMvjSuAMiwkv4
         GV6oti9qDfa9ZVYIaspAZhCP7zEckZ/GZKL0YB+eiWP9pe4Mx16Fwxq5RRfUXcQfIpl+
         MEza2td2FW65WDdd+f2FlFBGwHg69WaV4G0N1BYM8km68aykgb0/6w1eTitdIQEETb7h
         7hwyT0f9Me0WEODm9CAErPHKLPoJqAyxppJSU0QByLqlfY2w/MDFgfZQPuy8qRj1sk7M
         kK5iwb62sqStqajFHSbaOeAo6qhD6Xz76AFmmlvBJ8ys735jgNeDx+ZQzafw0oUd0KmH
         Q+AA==
X-Gm-Message-State: AOAM5336ld3SiUKwPDSdxj4ncBW2hO6mpA6OR4rr4Kg/75HJqmZa91j+
        x5B+O520637+BJ+jtlelDoYMQTTbbIR/Fo0znmvGEkCLCo/PzwjP
X-Google-Smtp-Source: ABdhPJz1uTuRLzLURKc7YibiCsjQoZXASgMOeNIAdjg+QT1ilA0IugGlHgB6N9w9kch3ACtXtfzEOvOXgJNF0+CNVqk=
X-Received: by 2002:a4a:98ed:: with SMTP id b42mr1559205ooj.32.1598004204872;
 Fri, 21 Aug 2020 03:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
 <bd0bb8d0ef0936866c2a957e5391424a7481a33c.1597841551.git.gitgitgadget@gmail.com>
 <xmqq1rk2v8y5.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rk2v8y5.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Fri, 21 Aug 2020 15:33:13 +0530
Message-ID: <CA+CkUQ_z8RL=g32aWm5bx6+-W8SHBUxaOd8tWfxa7wfEWiNQJA@mail.gmail.com>
Subject: Re: [PATCH 1/2] t6300: unify %(trailers) and %(contents:trailers) tests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Aug 19, 2020 at 11:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > @@ -839,14 +818,7 @@ test_expect_success '%(trailers) rejects unknown trailers arguments' '
> >       fatal: unknown %(trailers) argument: unsupported
> >       EOF
> >       test_must_fail git for-each-ref --format="%(trailers:unsupported)" 2>actual &&
> > -     test_i18ncmp expect actual
> > -'
> > -
> > -test_expect_success '%(contents:trailers) rejects unknown trailers arguments' '
> > -     # error message cannot be checked under i18n
> > -     cat >expect <<-EOF &&
> > -     fatal: unknown %(trailers) argument: unsupported
> > -     EOF
> > +     test_i18ncmp expect actual &&
> >       test_must_fail git for-each-ref --format="%(contents:trailers:unsupported)" 2>actual &&
> >       test_i18ncmp expect actual
> >  '
>
> Doesn't this highlight a small bug, where an end-user request for an
> unknown %(contents:trailers:unsupported) is flagged as an error
> about %(trailers)?  Is it OK because we expect that users who use
> the longer %(contents:trailers) to know that it is a synonym for
> %(trailers) and the latter is the official way to write it?

Maybe.

Another way of thinking is...
'trailers' is an argument to 'contents', likewise here 'unsupported'
is an argument to trailers.
Technically, the error message is correct.

Again, I think views on this are highly subjective.

Thanks,
Hariom
