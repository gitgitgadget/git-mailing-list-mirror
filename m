Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12207C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 14:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9CDA61168
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 14:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241004AbhITOyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 10:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240848AbhITOyR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 10:54:17 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1304C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 07:52:50 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id m21so43278692qkm.13
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+a/uzk1G7EjcePz7qxzORBHak2b1YQiDpuE8TEppCyw=;
        b=jAOGynAI6h4Lz9JyYNJYf/BriEHsx8L4AUxANI81IXsgBL+R9oiw7PZBLI5PhXzHf0
         eKavHONn6Jdva9I2VXudAnlaayIkHV2kdfltwUjAFdqsb8tIbHaDOdazG2MAPzKucPJh
         kCTNDkZhAQS5qBN1P+DB7r9YJ2P/smwettY/zyOxKAruljxSam1KPdcduxFJUBKbz2nM
         HCUfyrdKoaqeMMjw+q1FwOrBTMuFQa3S8yP/1Qy48ICHUC9r9uuaSl8/bur0bBoq2mSC
         PxJBxnHkSE6qL6eL7Y4twZiGueVbaOqFmj1XeJ9tFOHdymaIoztHiBi1G+JNRN9xP3ao
         LmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+a/uzk1G7EjcePz7qxzORBHak2b1YQiDpuE8TEppCyw=;
        b=DH+tCWKyajDQjzbK+ZseliSnLWogE/7wlZru9IYTfDKnjR0jEr2fgBzE/+svexBnWT
         9bXJk/92hmf3pN96Aym1LrlqLa/St7VZ5ZQu0A9HCY6zTgWnzcTTHq+2GR6Dja9qhzH4
         GItr/Fu+giGSx/h0o5AMsv2CMG/Lt3o1a/bbqPAHIkecJgy223WDLQ11qLIfZXGAT48J
         F5z9yqiu1WrAwnJiiI1HXoRYZFU1uHB1pzyq7qTDewby60NITSsg1MMz035SbS36Wf9G
         4pme58np2QJtPzkUZnmxDa1FitHOavnYVADTTQJRIhbR+DLFYPNhsLmU+AjOceMauzuk
         pqag==
X-Gm-Message-State: AOAM530THzXEBUXsUxD9wq8ahitrHFp1KYBdaLEggC1bguB4CtddapwT
        AttFsXhuLapqGGwCFcXlKMP0dZ+BL5vpmhxm7vY=
X-Google-Smtp-Source: ABdhPJx+zDv+eg0rN1QXdU3P37X+BbQSnutKPLOpAYPRdYns94c+aW/zUJer5QBA8y0ZyUZxHqn9hP0D76EEe142ht4=
X-Received: by 2002:a25:b5ce:: with SMTP id d14mr31519085ybg.415.1632149569812;
 Mon, 20 Sep 2021 07:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <YTGLLQCvlnT17jo8@nand.local> <YUYPgF6tRQ5ERYWL@nand.local> <CAOLTT8SbS9-grLnn2TOL6XdR3yMkd=YrUnq=FLCo6r03Fqbg9A@mail.gmail.com>
In-Reply-To: <CAOLTT8SbS9-grLnn2TOL6XdR3yMkd=YrUnq=FLCo6r03Fqbg9A@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 20 Sep 2021 16:52:38 +0200
Message-ID: <CAP8UFD37tQdbcgsMJPYE7KaO1ajwznFRUrG=9=S1WNNM-YZsqw@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <ttaylorr@github.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 9:45 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Taylor Blau <me@ttaylorr.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8819=E6=97=A5=
=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=8812:10=E5=86=99=E9=81=93=EF=BC=9A
> >
> > [+everybody from upthread to cc]
> >
> > On Thu, Sep 02, 2021 at 10:40:45PM -0400, Taylor Blau wrote:
> > > Are we interested in participating in the December 2021 round of
> > > Outreachy? September 3rd (tomorrow at 4pm UTC) is the initial communi=
ty
> > > application deadline.
> >
> > The project deadline of September 23rd is fast approaching, and we do
> > not have any proposed projects or signed-up mentors.
> >
> > If you are interested in mentoring, the time to sign-up and propose a
> > project is definitely ASAP :-). You can do so by clicking "Submit a
> > project proposal" at:
> >
> >     https://www.outreachy.org/communities/cfp/git/
>
> I haven't thought of any good projects for the time being,
> Christian, any ideas?

I already suggested the following project upthread:

> > About project ideas, maybe continuing Hariom Verma's GSoC 2020 "Unify
> > ref-filter formats with other \-\-pretty formats" project could be and
> > idea, though maybe it could interact too much with ZheNing Hu
> > continuing his GSoC 2021 "Use ref-filter formats in `git cat-file`"
> > project.

and you replied:

> If the project idea is related to Hariom or my GSoC project, I think I ca=
n
> provide a lot of help. :)  I can help them as a mentor.

so I am ok to co-mentor this project with you.

If you are still ok, I will submit it.

I will also prepare soon a page with a few micro-projects. Of course
more micro-project and regular project ideas are very welcome!
