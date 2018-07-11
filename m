Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7FDE1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 17:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733150AbeGKRbx (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 13:31:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35099 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732594AbeGKRbw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 13:31:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id p10-v6so14562734ljg.2
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 10:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sJKWTxDp5rTofH3bEyLT4lyTy0IyBcHu31izFTV6HqU=;
        b=F7P6ExdNGMW5IFoKDH4THPPINpdAotJQSGRC33aslQMsHoT2mI3PevH8uD6yv67shG
         qPnOQmvX8dAVvg70MqclJCqIzg50kOTzepEc8Nq2j7zFkUP59EjRJ80brbkNUidoyMiI
         Qsw8dw3MgAZNoKxLYhzFalKMCuG8meOA/GAfByPpzyXWkaUEL1WLIxGTUgqsYNpuMTcU
         7b5+R94piDweoR/8V02Zycr7GEKAjFQKLGowuVOahHLbVKSeV3vXh9isAQMjQdD6pnH8
         25lwCDx24xRvGbfgi/qJB0gpbtpOW45BrtVu/C6MfjTkTVmnbJJEmbIGhjTQupXcIER+
         RmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sJKWTxDp5rTofH3bEyLT4lyTy0IyBcHu31izFTV6HqU=;
        b=NY9c1QupT5EZVSkhtjk4jZ3mDwI42rgIGoJ3bYIuQXlg5HOGXwpYN+GIyaqqSQNJWl
         tKpdlsXP3cKhNTyfU2Svm+WPvgNI7wupygwAkgD7sjm0viswHt+INaCZdyZzKQiXj1k3
         gAqo4/qV7s7dfBi2vXOu6HM4neiV8VNabzifQSG0PhqxXP0zLIcHd6r2fpLorGw9CKH0
         iYdkV5uGP5E/S0b14trdZd+t1AK1J+GtYmlj7geOWEZqyWalM4oic0HhzqaqqyuinfrJ
         msFmjwh83F90XQnDf70R25SMdW3Hn8GOW0IpMHD1Fe3FSPDPHH24JjqFXAzqDenEuU8P
         nd8w==
X-Gm-Message-State: APt69E1kbszDPmFwt3X5JHZd5hOYjHBPJ+Zoz7JL0ks9tsr4Lkf8FMr2
        YMs9N9Ya9bdWLsfwWafXoL+iqdM28fa72kppVbA=
X-Google-Smtp-Source: AAOMgpfy+hAGu9lKJvAhpFejPyW1SBRP/bHzvl6hAOcJ3PD4Wiu0r3yePvdN5hVhUQh6yMfXiDxTepUtfTyXOv5/LBg=
X-Received: by 2002:a2e:9854:: with SMTP id e20-v6mr17669098ljj.143.1531329991986;
 Wed, 11 Jul 2018 10:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180614123107.11608-1-szeder.dev@gmail.com> <20180711125647.16512-1-szeder.dev@gmail.com>
 <20180711125647.16512-4-szeder.dev@gmail.com> <20180711145730.GB15269@sigill.intra.peff.net>
In-Reply-To: <20180711145730.GB15269@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 11 Jul 2018 19:26:19 +0200
Message-ID: <CAM0VKjm8V58w=2+Zx+ykrfmOmNDOtPY5HeuFy+mWm_H40UrF1A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] t/lib-httpd: avoid occasional failures when
 checking access.log
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 4:57 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jul 11, 2018 at 02:56:47PM +0200, SZEDER G=C3=A1bor wrote:
>
> > +# Requires one argument: the name of a file containing the expected st=
ripped
> > +# access log entries.
> > +check_access_log() {
> > +     sort "$1" >"$1".sorted &&
> > +     strip_access_log >access.log.stripped &&
> > +     sort access.log.stripped >access.log.sorted &&
> > +     if ! test_cmp "$1".sorted access.log.sorted
> > +     then
> > +             test_cmp "$1" access.log.stripped
> > +     fi
> > +}
>
> This will generate output showing both the unsorted and sorted
> differences. Do we want to suppress the sorted ones (e.g., by just using
> "cmp" directly)? I guess it doesn't matter unless there is an actual
> test failure, but I just wonder if it would be confusing to see both.

I have no opinion about this, at all.  I tried it both ways back then,
and didn't find one any better than the other, so I just chose the
simpler-shorter one, i.e. no 2>/dev/null redirection in the condition.

> > diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
> > index 6cd986797d..a481e3989a 100755
> > --- a/t/t5541-http-push-smart.sh
> > +++ b/t/t5541-http-push-smart.sh
> > @@ -43,15 +43,13 @@ test_expect_success 'no empty path components' '
> >       cd "$ROOT_PATH" &&
> >       git clone $HTTPD_URL/smart/test_repo.git/ test_repo_clone &&
> >
> > -     strip_access_log >act &&
> > +     check_access_log exp
> > +'
> >
> > +test_expect_success 'clear access log' '
> >       # Clear the log, so that it does not affect the "used receive-pac=
k
> >       # service" test which reads the log too.
> > -     #
> > -     # We do this before the actual comparison to ensure the log is cl=
eared.
> > -     >"$HTTPD_ROOT_PATH"/access.log &&
> > -
> > -     test_cmp exp act
> > +     >"$HTTPD_ROOT_PATH"/access.log
> >  '
>
> This took some head-scratching, mostly because of the original comment.
> I thought the "before" here was referring to a timing issue (maybe
> because we're talking about timing ;) ).

Heh, I had to do some head-scratching now as well...  That's what I
get for updating the patch, and then waiting almost a month to finish
it up and update the commit message.

> But it is really "make sure that a failed test here does not prevent us
> from doing this cleanup". So the original really should have just
> dropped that comment and added a test_when_finished. Bumping it into a
> separate test as you have here accomplishes the same thing.

After taking a step back, I think this would fit better into the first
patch, wouldn't it?
I will send v3 shortly.
