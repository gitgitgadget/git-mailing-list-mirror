Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 055DA1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 20:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732621AbeGKUzm (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 16:55:42 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36992 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbeGKUzm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 16:55:42 -0400
Received: by mail-io0-f196.google.com with SMTP id z19-v6so25630272ioh.4
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 13:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ql0C7DBljrLdb0NwArKgFQ8PTpYPWm6zgpXFDO32nGk=;
        b=eITPkvJQ4IBEXfJChXe8PZ6lxpKnkFv+XgRAQGrCMhfjfCMzmgwsUwsgW3lOmQzkt8
         U0HQhy9YqjdDcu97/YI7b7GOHVAOw3AoEfea+g5MVo9GDc265Xsi4HwPdyJr03Z1BW5s
         gRCUlEMfhMJbY5jx3jtG7PXwIN4aYYgVinFpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ql0C7DBljrLdb0NwArKgFQ8PTpYPWm6zgpXFDO32nGk=;
        b=nI1AbI1YCIkKuB5JKckck6FCeZ9e8zdNTwydW2ZYmvVbC+7AahtGMfRSX9Oe04DDha
         kbINEO5acx3WZSsuCKWe0KGgt2kChWltTh7oCSAb7jogtqAqvI6didP/PtXjvBqPolUh
         9l5YkYnb/kwYg3yQCi5fRjwu1gqE5K2IL/0fbK10VJ9TbYwfZFBC89wGR8WO+r0+XQXg
         IrrbECjLkOIIYYJMpXy7kho1QGP55Zq3Daj1xzDUWa1b2G42r44t8by3QPAUC0kBGG/+
         wtr+H0Ql+WX5LM0SIsqkvQ/SbcD4j7xBWwB1600ukd8X1GFmzq778qhrWrRCIhwMkKAn
         6t9Q==
X-Gm-Message-State: AOUpUlGCxttus+Yy2ROQSAvqqYD1+Vat4rDxkCJUXLwqNpb6bAdLMc74
        Zp8Kcs7VjMLHx/Py6i5wsiR9VfLptmVGgjliQ4Y=
X-Google-Smtp-Source: AAOMgpdde7Rz9ATeJ0dW3CjNW4BZ51LyEKVaqO0Mp8JxJgrF9jld+ro/z7dkxfxUO5TSdYzC9YopdMRJrFFdwU3fQyU=
X-Received: by 2002:a6b:380b:: with SMTP id f11-v6mr580039ioa.560.1531342174915;
 Wed, 11 Jul 2018 13:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.999.1807071238410.18818@i7.lan>
 <alpine.LFD.2.21.999.1807071502260.18818@i7.lan> <CACayv=ifE5BQVtxXCVEhS3uO7iz1z+ZPrF3J_n=e-uoYOpwNtA@mail.gmail.com>
In-Reply-To: <CACayv=ifE5BQVtxXCVEhS3uO7iz1z+ZPrF3J_n=e-uoYOpwNtA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Jul 2018 13:49:24 -0700
Message-ID: <CA+55aFym5aSudSHiVA=VmvoY=WFytUqficLQCE4Sd_urjwKqPw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] Add 'human' date format
To:     rybak.a.v@gmail.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 1:34 PM Andrei Rybak <rybak.a.v@gmail.com> wrote:
>
> > +     int human_tz = -1;
>
> Is -1 an OK initial value for timezone if local_time_tzoffset returns
> negative values as well? It looks like it doesn't matter for from functional

The value was intentionally picked to *not* be a valid timezone value,
so that the comparison of "human_tz == tz" would always fail if
DATE_HUMAN is not selected.

But it could be anything else invalid, of course. It could be MAX_INT
or something like that.

By picking something that isn't possibly a real timezone value, late
code can do things like

        hide.tz = local || tz == human_tz;

without worrying about whther it's really DATE_HUMAN or not.

The clearing of "human_tm" is done for a similar reason: the code does

        hide.year = tm->tm_year == human_tm->tm_year;

(and then later just checks "if (human_tm->tm_year)") knowing that a
non-zero tm_year will only ever happen for human_tz (and that 1900 is
not a valid git date, even though I guess in theory you could do it).

               Linus
