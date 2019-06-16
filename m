Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9881D1F462
	for <e@80x24.org>; Sun, 16 Jun 2019 20:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfFPUgK (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 16:36:10 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41841 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfFPUgK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 16:36:10 -0400
Received: by mail-qk1-f196.google.com with SMTP id c11so4995994qkk.8
        for <git@vger.kernel.org>; Sun, 16 Jun 2019 13:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platin-gs.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aKnG4GvNzM7r6acIR9SWUpV2Ij9HN0s4RO7zV6AbUUQ=;
        b=WJhbJBUSzc/EFWGscKaxOit9vahTG75py9lITxnAU8vtCZyY/WWKyudrPUMsLMVWyL
         bZNafK86mysMwxpcFlurVw9fWVY0qKaZsLSalWOqKB/h07Yfv4o48nupBDIbtlvINg0t
         GTbxXsxWwUC3AuBXHaRkmD8D7QyKuLPt0ZWGlh/zmAVRT6VfWblAcWfz8FlQIcPk4usb
         nPUz5Uew+dFUWIzdMK4hdYO6sPgB07TDmalaRv8GS7G8C1UNUrLEckRvuJIRfBsPeMly
         jymGR8ld+pFD0aDmcgzewSPaKw5ZlZiT2RX3luwi8h4bmE5TOWhE8p6kb6ZwM3wqxABV
         neTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKnG4GvNzM7r6acIR9SWUpV2Ij9HN0s4RO7zV6AbUUQ=;
        b=EdpAREa3JjUTKAclkpyh/hFTwDX+r4aZuPQ+t142on65V7EmBtOM4dv8T9ZnqeJubS
         8TV/b4mxS2CZAoaU23XxNrd8Z1OC+Aw2HEHgFsqiLguXb+KXjXJuLGf7vUF8JTvb4/r6
         I2i7scJ3rgBxFEHOVVr4hCY34jRhyVdHVovzBgyQB1vYb6rfVVjvdZ+9HjIL0D4Dyxwz
         QvBwpVzQh+6eaAErfDuLzfaWnWHY/ZS4pU8JQ23FdxaqQcbaF6I6a8oEDWBrcarmalPp
         x3b61GnxVgq5J6jcPnLKT+DHDM9UHTlPYeFsWmXGkSWXyI8CKXo5HgsJpGQUXJeexM9V
         GVmA==
X-Gm-Message-State: APjAAAWYZNavyKJQ2qN9U6+JnA1zrbJDqo3FpBjhaHsXep2nse/iRVEX
        gGoR5TLAXlMda8JRHyUO5GjbiZx4j2eNLJbH3Pw=
X-Google-Smtp-Source: APXvYqzywHDxxdiDp9MS1/7/wzU6E/RIIZsZGYhyKeSGv0DLZZB3N1qGtqJwzzPTB6TVDKV6lKNOznkJQSk3yd+7vbE=
X-Received: by 2002:a37:a9c9:: with SMTP id s192mr85524126qke.335.1560717369242;
 Sun, 16 Jun 2019 13:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190615184039.3711-1-michael@platin.gs> <20190616190202.GA15262@archbookpro.localdomain>
In-Reply-To: <20190616190202.GA15262@archbookpro.localdomain>
From:   Michael Platings <michael@platin.gs>
Date:   Sun, 16 Jun 2019 21:35:58 +0100
Message-ID: <CAJDYR9SEoUMfB8iZ=CpaPz=YYRALvN-24Ws8LgOh4FAhLUq2zA@mail.gmail.com>
Subject: Re: [PATCH] Use an intermediate file between between git blame and
 sed to avoid git blame's exit code being hidden.
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,
Thanks for the review. The patch was supposed to be in response to
https://public-inbox.org/git/20190613151756.GA31952@szeder.dev/ but
apparently I didn't use --in-reply-to correctly. I'll resubmit with
the requested changes.
-Michael

On Sun, 16 Jun 2019 at 20:02, Denton Liu <liu.denton@gmail.com> wrote:
>
> Thanks for the patch, Michael!
>
> On Sat, Jun 15, 2019 at 07:40:39PM +0100, michael@platin.gs wrote:
> > Subject: [PATCH] Use an intermediate file between between git blame and sed to avoid git blame's exit code being hidden.
>
> For your commit message, the usual convention is to first specify the
> area you're working on followed by a colon and a brief summary.
> Typically, the subject starts with a lowercase character and also
> doesn't end with any punctuation. See [[describe-changes]] under
> Documentation/SubmittingPatches for more details.
>
> For yours, I would reword your commit message to something like
>
>         t8014: avoid git command in upstream pipe
>
>         Use an intermediate file between between git blame and sed to avoid
>         git blame's exit code being hidden.
>
> In addition, your commit message is missing a sign-off line. You can add
> one by passing `-s` to git commit but you should read about what it
> means in [[sign-off]] in SubmittingPatches.
>
> > From: Michael Platings <michael@platin.gs>
> >
> > ---
> >  t/t8014-blame-ignore-fuzzy.sh | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
> > index 1ff59624e9..13f3313710 100755
> > --- a/t/t8014-blame-ignore-fuzzy.sh
> > +++ b/t/t8014-blame-ignore-fuzzy.sh
> > @@ -332,7 +332,9 @@ test_expect_success setup '
> >  for i in $(test_seq 2 $last_test); do
> >       eval title="\$title$i"
> >       test_expect_success "$title" \
> > -     "git blame -M9 --ignore-rev $IGNOREME $i | sed -e \"$pick_author\" >actual && test_cmp expected$i actual"
> > +     "git blame -M9 --ignore-rev $IGNOREME $i >output &&
> > +     sed -e \"$pick_author\" <output >actual &&
>
> We should take advantage of the fact that sed can open its own input
> here. So we should drop the `<` and just pass the filename to sed. Same
> applies to the below.
>
> Thanks,
>
> Denton
>
> > +     test_cmp expected$i actual"
> >  done
> >
> >  # This invoked a null pointer dereference when the chunk callback was called
> > @@ -357,7 +359,8 @@ test_expect_success 'Diff chunks with no suspects' '
> >
> >       test_write_lines 1 1 >expected &&
> >
> > -     git blame --ignore-rev $REV_2 --ignore-rev $REV_3 file | sed -e "$pick_author" >actual &&
> > +     git blame --ignore-rev $REV_2 --ignore-rev $REV_3 file >output &&
> > +     sed -e "$pick_author" <output >actual &&
> >
> >       test_cmp expected actual
> >       '
> > @@ -387,7 +390,8 @@ test_expect_success 'position matching' '
> >
> >       test_write_lines 1 1 2 2 >expected &&
> >
> > -     git blame --ignore-rev $REV_3 --ignore-rev $REV_4 file2 | sed -e "$pick_author" >actual &&
> > +     git blame --ignore-rev $REV_3 --ignore-rev $REV_4 file2 >output &&
> > +     sed -e "$pick_author" <output >actual &&
> >
> >       test_cmp expected actual
> >       '
> > @@ -424,7 +428,8 @@ test_expect_success 'preserve order' '
> >
> >       test_write_lines 1 2 3 >expected &&
> >
> > -     git blame --ignore-rev $REV_4 --ignore-rev $REV_5 file3 | sed -e "$pick_author" >actual &&
> > +     git blame --ignore-rev $REV_4 --ignore-rev $REV_5 file3 >output &&
> > +     sed -e "$pick_author" <output >actual &&
> >
> >       test_cmp expected actual
> >       '
> > --
> > 2.21.0
> >
