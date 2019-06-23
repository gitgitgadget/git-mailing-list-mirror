Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E447B1F461
	for <e@80x24.org>; Sun, 23 Jun 2019 20:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfFWUc3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 16:32:29 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:45529 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfFWUc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 16:32:29 -0400
Received: by mail-lj1-f180.google.com with SMTP id m23so10511166lje.12
        for <git@vger.kernel.org>; Sun, 23 Jun 2019 13:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0dPtWK4WbZzcd+tK0qxlhc7YAw/Y4FlIaeTvS6/T0WU=;
        b=npOPCoRJe8jdNSxrqtAg2Mzzj84jSuuZchUZdjEJUbg2FmKszyQxebvyitGffgacWZ
         yPwgAmY1kFg5h4vCgv2KUHJgGhBB9qcT1V95AhJlxINMMxTmJJg5Hfxw3xdeQ8jPUfvv
         GkFnq45mliQg6YL2Krr2cNeCEncv8NKAHZ5jYmm0tutm1x8AUGn1uLh/a95Q4H3oM30q
         LENPQd2rhTZB6oTEBqfj90k4YCxat9TXH5uRHquZHK7HfBZhFMfgHgA0bqrO1Ql56mcb
         EB8OcjFiWUgvQoPhx8dAbat6kb+DY98KqEO0XRxlgtdBdy2MgwihV4bCrfHo2F2mIkpD
         v01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0dPtWK4WbZzcd+tK0qxlhc7YAw/Y4FlIaeTvS6/T0WU=;
        b=UpW16JbKoEVtdQZ4f5+oNldDA+XFeQchH8HceGzQytVcTDU+y4umAzYZ7rg7QsdPtd
         +zev5e6bBjnLnJJaxJQ5iRV8+/MvUKbaidl+1nFNOAQ4yYbonmK720nApyJKmHVognHr
         x83Cj3z9bQKgL/z176seoyYeThCKB6jHES3hVDR6MJQXQBManIP/Udg+o4rpO79vKXCI
         mf2yqN3XbUAYwCOTA2cflV43a06/5q9kr+Ygzc4KY0W3MmazXZE2panBfqg66ttoOHXI
         Kg9JOxildXqiJsPpP4vMqTOpUWQGOCmz5N6+9OQoLEKNVqelkW7TQ+sOnnHZIHrroSgP
         5a0g==
X-Gm-Message-State: APjAAAU7Z5khmlBiw/ImRwJi/uqOvx83svNrtkBFO9SJdq903G4rLPjB
        J6+lo5nGC01YKn3DpXETICgIDKhHm0pN3SYva9hpMB/n8Ao=
X-Google-Smtp-Source: APXvYqwqG5a8f4uIES0s0UordsVaY7Vr6RgE46/3bBLnA/m8/tsXIcoO/OJ6ZJYWW5/pC8Aa4jK8H+8WgJxrLi0YeZ0=
X-Received: by 2002:a2e:5c6:: with SMTP id 189mr18536752ljf.22.1561321947017;
 Sun, 23 Jun 2019 13:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAC_CU1iWBCTt5jLQ0Zp2HoyA0oFgG3shDB2rLfOsmC+x67NdAw@mail.gmail.com>
 <xmqq5zp9wdjb.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zp9wdjb.fsf@gitster-ct.c.googlers.com>
From:   Pedro Larroy <pedro.larroy.lists@gmail.com>
Date:   Sun, 23 Jun 2019 13:32:16 -0700
Message-ID: <CAC_CU1hHK5n4GcETbWFLBeqT_Y9LV6N32Rv0F0+OCXH2G0qg8Q@mail.gmail.com>
Subject: Re: git bisect should return 1 when the first bad commit is found
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your answer.

I was expecting the HEAD to point to the first bad commit.

In mercurial, the exit status tells you information about the
bisection process:  https://www.mercurial-scm.org/repo/hg/help/bisect

Sure one can parse stdout, it's just more tedious than just checking
the return code and having the HEAD left to the original bad commit.

Pedro.

On Thu, Jun 13, 2019 at 11:22 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Pedro Larroy <pedro.larroy.lists@gmail.com> writes:
>
> > I'm using git bisect, and for complex reasons I can't use git bisect
> > run to drive the bisection. I don't think git bisect bad/good is
> > returning a different status code when the first bad commit is found
> > and this would be very useful to stop the driver of the bisection.
> >
> > What do you think?  Would such a change be acceptable?
>
> Probably not.
>
> A non-zero exit code would indicate that "git bisect" had trouble
> finding the next commit to check after being told 'good' (or 'bad'),
> which you wouldn't be able to tell from your "first bad one is
> found".
>
> The 'first bad one' is not necessarily the HEAD when the bisect
> procedure finds it, so you'd have to read and parse "x is the first
> such commit" message anyway, no?  And once you start parsing the
> message from 'git bisect', you should be able to tell between
> "please try this one, you have approximately 7 steps left" and "we
> found the first bad one, which is X", without relying on the exit
> status, no?
>
