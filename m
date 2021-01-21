Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691E4C433E9
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 15:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FC73238EC
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 15:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732870AbhAUPWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 10:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732769AbhAUPWL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 10:22:11 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D003C0613ED
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 07:21:29 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id r12so3109733ejb.9
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 07:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5YPrxtkIPN69K2oNRaW/qUCjvrf3UbsVsqG1/8meAHQ=;
        b=J4jn9ebEL0lyTMbHIv084ZY8h18Cd/PuEMFUAzf+hlATt+MCKKdrBGY8mhSCTySFLS
         9ofXMQRGsni+SKoIB/B5dM692mZ3xG1QqXt2TeSIDo2HWSaXDRfXPvuZnVJbkrZTidyZ
         rOXH181hqy3InXdomowwv+DIwkZrn+Sgrvy7NATRRRSxFoNP7DDLkHx66DPXFkMZNmK/
         AsgipNFXD0lubUuuqNAQQ1aKLJyAMxF6SkDz1boI8Tg17SY1lAA7H/82mK7OFfDYGo/n
         tWSASagdVeve/pWt8e+OrfP9bNkRgUNXRheu/sk3VRu2fmeS9emXMxpLCyDsJmfa1LNL
         xH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YPrxtkIPN69K2oNRaW/qUCjvrf3UbsVsqG1/8meAHQ=;
        b=BafmeKtydH9NK3UdjOYp3HOYpUGebw98NQyws0MrsBGBEpfRvXYn4wkBPWj7CANN8A
         4c68KsqFWSjTcLQlebB6+ow7Iw+1DZio0skheupu+tZzm38acL1U6K2p1WNqo84PKSsK
         h54Jbco8oP3Tduj9g6rbqEg5myaR59BJP584Hm0Z86OYCrU4pZ1L0SXzZ+/baoimVKY9
         OEPRJ43v3uFAjADzLN1t52UCEV4PFT7g7sEkqZ9CLUMOMmsDwORlshAGTK+AhpyqaE6m
         x6e5llAV+OLlMIsJj0Tw2wMcwT+3JLjEi5XuY+GeUzQFV9H062GRXa/zKqwHTBGRrZDh
         H0eA==
X-Gm-Message-State: AOAM531vIIGeSgBghTZA79KfGuc9zD/8OxePeKsg3CtmqoTewvY5sux8
        D9+EcTXljTprpaVSJ8axiYjXdQaQB1CM7Iyxvso=
X-Google-Smtp-Source: ABdhPJwSMGSYqXZF1Peu5TZTKsqzjN5/sFIlVSkp8vttDLipWB3QscwioNNPUU9wX9V53CtgcXqdzS+fl7Q8od+B+bk=
X-Received: by 2002:a17:906:d209:: with SMTP id w9mr9329211ejz.211.1611242488108;
 Thu, 21 Jan 2021 07:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210119074102.21598-4-charvi077@gmail.com>
 <xmqqmtx3dq83.fsf@gitster.c.googlers.com> <CAPSFM5cxTrvAq6j3yhzidWdr8P8-sYmd1-9tmsK4iXMKrC7TNA@mail.gmail.com>
In-Reply-To: <CAPSFM5cxTrvAq6j3yhzidWdr8P8-sYmd1-9tmsK4iXMKrC7TNA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 21 Jan 2021 16:21:16 +0100
Message-ID: <CAP8UFD3PRaiCiSfSMaX0FDrEcOz2xv3992meum7qnKve1rK6nw@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] rebase -i: comment out squash!/fixup! subjects
 from squash message
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 21, 2021 at 3:02 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
>
> Hi Junio,
>
> On Thu, 21 Jan 2021 at 07:08, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Charvi Mendiratta <charvi077@gmail.com> writes:
> >
> > > +static size_t subject_length(const char *body)
> > > +{
> > > +     size_t i, len = 0;
> > > +     char c;
> > > +     int blank_line = 1;
> > > +     for (i = 0, c = body[i]; c; c = body[++i]) {
> > > +             if (c == '\n') {
> > > +                     if (blank_line)
> > > +                             return len;
> > > +                     len = i + 1;
> > > +                     blank_line = 1;
> > > +             } else if (!isspace(c)) {
> > > +                     blank_line = 0;
> > > +             }
> > > +     }
> > > +     return blank_line ? len : i;
> > > +}
> >
> > I cannot quite tell what this loop is trying to compute at the first
> > glance.
> >
>
> Oops, I think Phillip and Christian also pointed in the last revision
> to look for alternatives to make it easy. I mistook that point and
> forgot to look at it.

Yes, please take a look at find_commit_subject() in "commit.c".

> > > +     grep "extra para" commit >actual &&
> >
> > I can tell that you want the "extra para" to still remain, but how
> > does the grep that is not anchored guarantee that?
>
> .. but now I think to remove this `grep -v "squash" commit` as also
> discussed with Phillip earlier that in this test script we are not
> checking for the commented commit message.
>
> > Perhaps look for
> >
> >         grep "^extra para" commit
> >
> > to ensure that you are not seeing a commented out but somehow failed
> > to get stripspaced out?
> >
> I am not sure, what does failing to get stripspaced mean?

I think this refers to:

https://git-scm.com/docs/git-stripspace

Best,
Christian.
