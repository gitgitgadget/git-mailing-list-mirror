Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACBBC433DF
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 911F620775
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA4qRGoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgGQKmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQKmh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 06:42:37 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24CEC061755
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:42:37 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id b4so8272566qkn.11
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4qBHklh/Y1IQTTFiPA+t18EknP7s8W9Eb+0iE/hZ4VA=;
        b=EA4qRGoJdGJ8fLdUwaumAtHbQuRFI4lpgfU2bAxlmN7gvLLWqiuWoD3U1OR5dTK2lI
         lntvwmI+WQR36KNyjNxjqjx9RLsMriggc6BaYw7W5KT6vpe3YyxLXFGU/FStdx2n8xe3
         7V2FSn/wS/57gV0fsvVZ24z50i6YMXzoSTo92dl7X6qebwzFTV7296DCEVAbQEi4F/JQ
         ZiTLGTl5LbrXIdBHcPrQ1vU2VjgtSy3Q8KmGEkYCnHdpGmxNyeHvlEvHH+b7/j/N0SAA
         4Hhkaa4ftTvKITyoQMJtjI1AhVROVo1/829Gko0J775RNZpJnoTrlBeGhfog5KxBN5cJ
         J5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4qBHklh/Y1IQTTFiPA+t18EknP7s8W9Eb+0iE/hZ4VA=;
        b=dAIDKuuE9Jg58j9lpLS8l7RlmGPoXyeRBGY4EBBRxLP5Zz+sGsHwo8FaRhHhARH26w
         Ratgl319n4iqI2aO52d5Srvij/4Rc4+FL2M5c9B5n6bCH+vhHP8dEDutB42riqn1sEcw
         3fkQARr/cMcpZbR9Z/rLVKSRW7Wk/cnN0xGqwDJ0YgRYOfn7dvoapBb3Ilusp01pg2du
         SYuMcwSWNLlYSrV9ba1IdWaSJVEBbVGP4HoZdjmmXyTENgIGsLFEtzKm3BPLrO4zXPKL
         uumzMDWhrSyETp1+jsWxQY9YuVxRQpZZKDRpZtUTdrJP+wxbevCnqwCjuId6dsmy7KTS
         GIZw==
X-Gm-Message-State: AOAM530t+wbvbSkNp0y+9UTL14K9t89ZcUxco8gxaOsrPcHJShX0/1S2
        d5xNBrN6ZXK4m/76ZJGKC8k5t6sf0yGLS7TxQbA=
X-Google-Smtp-Source: ABdhPJyld3PyIOyt4g4qFCRRWqq06f3IsddhMd/ZaNtXFygclFYxBeCUw6iMUuFRUnV1P5L73JEIrrlV/OE+BpX3fB0=
X-Received: by 2002:a37:6886:: with SMTP id d128mr8370291qkc.12.1594982556803;
 Fri, 17 Jul 2020 03:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvDm6Z2HcQkyinCD4hKTnqGR3gcXodhoo0YKSnbB-vDJcn3MQ@mail.gmail.com>
 <CAPUEspg=4HJL8iiNrNp9Wr9sVj5Gw_PciSezHV5iJ1w-ymdzdw@mail.gmail.com>
 <CAAvDm6avvkXrU-Q8zu7C5WFqfCbf0DN=6cPMU-rOxgmdAh1Ebw@mail.gmail.com>
 <20200716153159.GA1061124@coredump.intra.peff.net> <CAAvDm6Z6SA8rYYHaFT=APBSx0tM+5rHseP+fRLufgDxvEthsww@mail.gmail.com>
 <20200717063324.GB1179001@coredump.intra.peff.net>
In-Reply-To: <20200717063324.GB1179001@coredump.intra.peff.net>
From:   =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date:   Fri, 17 Jul 2020 18:42:23 +0800
Message-ID: <CAAvDm6YExMWVywx8H7pqSPFZ+=oi4n8QqgJcR5rErqbyD2q2+Q@mail.gmail.com>
Subject: Re: How can I search git log with ceratin keyword but without the
 other keyword?
To:     Jeff King <peff@peff.net>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Peff

Thank you for your help.

>I think this is the thing I was mentioning earlier. That negative
>lookahead means the second one wouldn't match "comments", but it would
>still match "2020.04.12" or "ng". So it won't do what you want.
You have good foresight. :)

>The natural thing to me would be the equivalent of:
>  git grep -e 12 --and --not -e comments
Yes, I intend to achieve this goal. Sorry for misleading you.

>I can't think of a way to do what you want just a regex, but maybe
>somebody more clever than me can.
>But none of that is exposed via the command-line of "git log". I think
>it would be possible to do so, but I'm not sure how tricky it would be
>(certainly one complication is that "--not" already means something else
>there, but presumably we could have "--grep-and", "--grep-not", etc).
Thank you for your patience.
Thanks to your help, I have a better understanding of this matter.

Best Regards
sunshilong

On Fri, Jul 17, 2020 at 2:33 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Jul 17, 2020 at 09:45:26AM +0800, =E5=AD=99=E4=B8=96=E9=BE=99 sun=
shilong wrote:
>
> > I wonder why this command doesn't work well.
> > I intend to find the comment with the keyword "12" but without "comment=
s"
> > whereas the output is something like this:
> >
> > git log --perl-regexp --all-match --grep=3D12 --grep '\b(?!comments\b)\=
w+'
> > commit f5b6c3e33bd2559d6976b1d589071a5928992601
> > Author: sunshilong <sunshilong369@gmail.com>
> > Date:   2020-04-12 23:00:29 +0800
> >
> >     comments 2020.04.12 ng
>
> I think this is the thing I was mentioning earlier. That negative
> lookahead means the second one wouldn't match "comments", but it would
> still match "2020.04.12" or "ng". So it won't do what you want.
>
> I can't think of a way to do what you want just a regex, but maybe
> somebody more clever than me can.
>
> The natural thing to me would be the equivalent of:
>
>   git grep -e 12 --and --not -e comments
>
> The underlying grep machinery in Git understands how to compose multiple
> patterns like this, and the command above really does work (though of
> course it is searching for lines in a file and not commit messages).
>
> But none of that is exposed via the command-line of "git log". I think
> it would be possible to do so, but I'm not sure how tricky it would be
> (certainly one complication is that "--not" already means something else
> there, but presumably we could have "--grep-and", "--grep-not", etc).
>
> -Peff
