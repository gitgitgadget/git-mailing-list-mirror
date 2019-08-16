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
	by dcvr.yhbt.net (Postfix) with ESMTP id CCDD51F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 22:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfHPWJc (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 18:09:32 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39018 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbfHPWJc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 18:09:32 -0400
Received: by mail-vs1-f68.google.com with SMTP id u3so4659569vsh.6
        for <git@vger.kernel.org>; Fri, 16 Aug 2019 15:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EiUQah1DtjxCBFjkAaXRqdnJbB/SumQpZAj3TE3AwfY=;
        b=F0MdQcvklRBaFFgepcGBlr6/F4ymLWTD4hrejH7Vn2DjX9UgyPkkLmQiizqFlu4l6y
         Oca7Zzb02umSkVR0ewpLqmzocL2vA69VFbWUO5NTQ+ZQAV9xMCE6t/arKzwoYr134p+K
         3sBKN2WUlpx5PN3CCMO6S7VXk+mzV181nwpAXtUKKysPbBBwWhXewtuQeewONiANsv9I
         v8p1xMZknSd7T/HT1apLEE0nZVy8EccjKm+uAU8VsCGKykdyDhjoiKmC0u8kFd/OdX4W
         uqZWDQ5qFtN+Jfny99QSRrrq0jP4xYEII/swQJgD+M4lNk5HxCP4lzg1GYdw8lGMeUjx
         24vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EiUQah1DtjxCBFjkAaXRqdnJbB/SumQpZAj3TE3AwfY=;
        b=BP0k0Cc9Kj5PvfBos/xJF7lhAXbhPzWu1xsmq8/pwh768t4fEOpZ0q5oe0sKpR47La
         ddTeSFclohHabLl/Ze0RcQoeQRW10kI2V73HYWfoc947Szszaqly/G2UFUs9ltD+Lg7j
         rbxDrG5Z+tjKeYP5xAb2i9c1CHfTq+zQJ811JRAjq1O63Ki/GB9ZcaO6fKBIyiZiNfwW
         f3ZKxFvnZ9lpEtapl629nXwzAb7KrEqhSn73WOrUQGu8bTs5cDVEQKYpr2MoGj/beo4O
         dfJdR23dLDcMyatFx6xsOT2xWMz5wO9KRPbUe1sOyGi9nelFz7X+Kkisoog5/1z5DA9x
         8KRw==
X-Gm-Message-State: APjAAAXQpBjSy5p0/h5qRFYZWB2rCsCP26V4/63EWl9SPjeFPwjEKKTv
        iba++7+0STB7lUTY9IX53nBOkqKCCTp1vaBLjMc=
X-Google-Smtp-Source: APXvYqw16wqPqaUiXOaCEOqLEthcxdWOBcQavAK2hyM2ifZHJt+KbEQsQQ+eOlhuTpqOZV9kOMTNQ2anLD61Q7apTkk=
X-Received: by 2002:a67:fd13:: with SMTP id f19mr7593675vsr.53.1565993371628;
 Fri, 16 Aug 2019 15:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190726155258.28561-1-newren@gmail.com> <20190815214053.16594-1-newren@gmail.com>
 <20190815214053.16594-24-newren@gmail.com> <xmqq8srs286r.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8srs286r.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 16 Aug 2019 15:09:20 -0700
Message-ID: <CABPp-BGb32Vc+TC5f-30Rh6-1QCan4DP84_XkX6YLD63So-s4Q@mail.gmail.com>
Subject: Re: [PATCH v3 23/24] merge-recursive: add sanity checks for relevant merge_options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 16, 2019 at 12:59 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index 647b1f25c3..bc0da608c4 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -3620,6 +3620,29 @@ static int merge_start(struct merge_options *opt, struct tree *head)
> >  ...
> > +     assert(opt->buffer_output >= 0 && opt->buffer_output <= 2);
>
> The field is unsigned, so >=0 side triggers "-Werror=type-limits" warning.
>
> Material for squashing I have collected so far...
<snip>

Thanks, will include all of this in my next round.
