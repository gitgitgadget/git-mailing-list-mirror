Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABD4C43462
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C5A161166
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbhELRnK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 13:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245584AbhELQw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 12:52:58 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC4FC0611AE
        for <git@vger.kernel.org>; Wed, 12 May 2021 09:40:09 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w22so8933460oiw.9
        for <git@vger.kernel.org>; Wed, 12 May 2021 09:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=95wvQ1WfGBjaOijQZfOCrv6xpi1aK/641dhMa3g6I9w=;
        b=uVnmXikQMj0Furz7G+5HwL4tsKkeR45ChUWf8UR2jSXE8n8ns6nXvVuQORwErUEUKe
         EBifBA3KfHtT83mVjkvvlqP7WCsKGLUpvhXcwwI0bIOw14so8gdz8oMgtPcXqTIlfnPA
         SXtya3BveYVXeQM7b7EzSis1cBg/a1DPMcLDOY9xlRpWcTGrDgjQWfvC+FAwd/9iKOHQ
         mv/FL30DqGv5wpVFf6XhwABuHVQQdRZTmVbuCWh9wCUeOjkc1FZtG0nvqZDYakBEqp6i
         yEZL0qZk0+JKTYnaMmb490c6UIgaW/wr2lsfsH7TOBsbkXbam80TddEMvxgAJGlr4t/b
         r6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=95wvQ1WfGBjaOijQZfOCrv6xpi1aK/641dhMa3g6I9w=;
        b=Ls4RnjmkmglE9+k4Lb7vt0vzQcf5HmGyjUSXISPWNp3CbHP3fHEVerC1qbda/L+6E3
         bDaRyiDqT7JhiZ1AnzZ4RGoZS57xDfrInQOqpPowp5HUklKYvQy32GQbzIwIEbx8wFh5
         adwWg+fPzQd+FTPRHsRw16t5w7Y59RHchKSn1sJp8OVxakDfQFvfai5QoIKe3GFrEh63
         UzC4MI5NtNyKiUmmmVRMytMEP4nkdw4xHhkKxWya4xXpxXtBZUx/3xBhlgq2CXcgxTjF
         5Tdp3eLqLq4x4820/yxY7hFWOxE+jCmEw5ULiBNqnMnYqpsR8s+56Gtp3YYtoomo/fSU
         U53A==
X-Gm-Message-State: AOAM531r0DYvyV6NlOI/BiGwD1iAcf6cHQjSkp3GAI9nJvgXT0F4Z1Yq
        qBP4YgSyqw8EK5m0Un7dV1lsPO5u2wX2APtybHE=
X-Google-Smtp-Source: ABdhPJyx+Mu/wgjb4i+Q4IbNcibdQg4oF6II1I1pL6ThtnPg6MZjh6lXLsz1EigOEhEc25Mq5w6bbFkvU5QvdHe+fyM=
X-Received: by 2002:aca:c183:: with SMTP id r125mr12926976oif.147.1620837609350;
 Wed, 12 May 2021 09:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz> <609ad9473d535_6011e2082@natae.notmuch>
 <20210511195723.GL12700@kitsune.suse.cz> <609b47043a719_678ff208e@natae.notmuch>
 <20210512041138.GO12700@kitsune.suse.cz>
In-Reply-To: <20210512041138.GO12700@kitsune.suse.cz>
From:   Varun Varada <varuncvarada@gmail.com>
Date:   Wed, 12 May 2021 11:39:58 -0500
Message-ID: <CAD2i4DA80wWHLkH135=+pJ05+xAvH6UG9Pg-G2gv0mm=DDEskw@mail.gmail.com>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 11 May 2021 at 23:11, Michal Such=C3=A1nek <msuchanek@suse.de> wrot=
e:
>
> On Tue, May 11, 2021 at 10:09:56PM -0500, Felipe Contreras wrote:
> > Michal Such=C3=A1nek wrote:
> > > On Tue, May 11, 2021 at 02:21:43PM -0500, Felipe Contreras wrote:
> > > > Michal Such=C3=A1nek wrote:
> >
> > > > > If you are concerned about correctness and clarity of the documen=
tation please
> > > > > avoid spreading misinformation.
> > > >
> > > > Under certain definition of "jaron" Varun's statement would be
> > > > incorrect, but not under all definitions. If you use the definition
> > > > I stated above, "impact" can be considered jargon, because it's a b=
it
> > > > obscure language.
> > >
> > > Do you have any frequency data that supports your claim that the word
> > > 'impact' is obscure?
> >
> > This is not how logic works.
> >
> > If I don't have frequency data that supports $x, but you have no
> > frequency data that supports !$x, then we return to the default positio=
n;
> > we don't know if $x is true or not.
> >
> > Do **you** have any frequency data that supports the negative claim tha=
t
> > the word "impact" is not obscure?
>
> I don't need that data. You are proposing a change so it is your duty to
> support your claim that the change is worthwhile.
> Otherwise it's a change just for the sake of change.
>
> >
> > > The bar for change should be that the word as used is very unfitting =
or
> > > unintelligible.
> >
> > No. The bar is that **nobody** have any problem with "affect", and some
> > people have a problem with "impact".
>
> And that's established how, specifically?

By way of dictionaries and style guides which universally agree on the
meaning of "affect"/"effect", but do not on that of (and even
explicitly discourage) "impact".

>
> Thanks
>
> Michal
