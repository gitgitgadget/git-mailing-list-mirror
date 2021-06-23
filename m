Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE20C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED9B611AD
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFWR0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWR0y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:26:54 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3A6C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:24:36 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id n99-20020a9d206c0000b029045d4f996e62so2712174ota.4
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=9VceHjcnT51PMdC9idFzb2Y44oNT5sAdFEdRxjuVPoM=;
        b=ahxCfL+M03hTgnBR3Vvudtw5C64eIqhxd+QS6mUOBL/YsoHkikuwfDc3blFWKTXGLp
         Fcz+k5nS9EPyrOETqVL5DtLld15jSK3uMRFRxwvjEROpKEwJ194V+QCEMlwmXwYZjLEf
         Tak4HbhxdnZXcPaEtmjyrGFHDMlxVtaBb+ZFr+zDW3D/Q0tb4a4NvYHYvZOJgqJSkyL2
         03sO3EYSEWoE24uthX+inUoqqq64pPgg86VweB0MtxRothWVAWoXbO++wQiGjae/B66k
         GDOtDYU6Cx1OeKASYJZCUGYoaofZCDtbAImHt+DuDSB3j//aa7StMFgpej8MZbREGgs9
         NhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=9VceHjcnT51PMdC9idFzb2Y44oNT5sAdFEdRxjuVPoM=;
        b=UUKZQ4N7R3JkLxdtYlpsAY9fjp5fkalTmxlYPBljQ3lOiiOyEu17ItvgR5JrNoxKsD
         J9Im19C8qsnzb4x7CGMI+6JqvZIjW1U9Ldb9Xc5qR+D+iDwgruXzS3s+lKXYGv75Gmve
         EjsrfG2kVHdS0oui9fWcJ2/WvwaGc67GlXmswBe2YKWiS00Oni6+Rt148ap6LWJoeEPA
         HYi36ioOJtP28eiu4PSwK+58ZRJMwrFhRzc6ouTQnAjanCm12PGJ5VbFjsIPUsXzR2kR
         HQcku6Txqp+qBHihPNWTvtP2eYUXsfyCkO5KjPhF9/rXtQ81t9DhcAiIqvMrGKbcXJFu
         cIuw==
X-Gm-Message-State: AOAM530GYrMls8WvMMueuM6VZaKoAEN5Kap+m/OQ13ETvoLMqI7Utu8e
        1yI08fI8ZzXvffvoYSGbq/M=
X-Google-Smtp-Source: ABdhPJxmkE651yKA38Y57Ui7dPKYphkjOa9JGH0ZEPl/vNBxE6CvCGKNMmbe8pjHk8yqi77JYzLQVA==
X-Received: by 2002:a9d:7558:: with SMTP id b24mr917587otl.60.1624469076279;
        Wed, 23 Jun 2021 10:24:36 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id a78sm72644oii.42.2021.06.23.10.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:24:35 -0700 (PDT)
Date:   Wed, 23 Jun 2021 12:24:34 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Message-ID: <60d36e5268fce_3787208fa@natae.notmuch>
In-Reply-To: <CABPp-BEPgUAe-efyk-Y5AVXRe64uUtz0XUJ-fPzKi8eSfnEquA@mail.gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-3-felipe.contreras@gmail.com>
 <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
 <60d0df99d91e1_108e902085e@natae.notmuch>
 <CAMMLpeRnUC+nOek=Kz6bj0_R6EUaDr=7ObKF01V641_ByOmk6A@mail.gmail.com>
 <60d10ebd99d86_113139208cd@natae.notmuch>
 <CAMMLpeRa3atkZxEtV--YD6-JSf0Bp9xRw9kS5wSWerxpsGrvrw@mail.gmail.com>
 <CABPp-BF1noWhiJadHzjJmnGo8hdZj6Fk7XnZ=u6BVVSGfHE7og@mail.gmail.com>
 <CAMMLpeTmYcJHf1t7VpOBakMZ_vtk+9bmLRTMA9ueghG6WwCRtA@mail.gmail.com>
 <CABPp-BEnPrg_tsqLtmj7Ag6JnR6ku_K3Uv65rdRu-j9_qMYhmA@mail.gmail.com>
 <60d2b5ffc23af_1b53208aa@natae.notmuch>
 <CABPp-BEPgUAe-efyk-Y5AVXRe64uUtz0XUJ-fPzKi8eSfnEquA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pull: improve default warning
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Tue, Jun 22, 2021 at 9:18 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Elijah Newren wrote:
> > > On Tue, Jun 22, 2021 at 2:22 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
> > > >
> ....
> > > > Thanks for the link, and sorry for not having followed this
> > > > conversation closely enough to have seen your previous replies. While
> > >
> > > No worries, you were trying to be a good citizen by reviewing patches,
> > > and the patches didn't come with links to the old threads
> >
> > That's not true. This patch series [1] came with a link to the previous
> > patch series [2].
> >
> > I didn't, cannot, and shouldn't contain hundreds of links to the hundres
> > of responses to this topic over the past 10 years.
> 
> Sorry for being unclear; by links I meant either direct or indirect
> ones.  Your series came with a link to the previous series.  The
> previous series, however, only contained a link to a series you were
> basing upon rather than to a series which contained the changes you
> were resubmitting.  Thus, following the links in each submission would
> not get you back to the old discussions (I double checked).

That's true, but there's no combination of links that would get you all
the discussions.

There were 4 different approaches attempted, each one with their own
thread. Also, since other people didn't follow the threads correctly I
had to send different versions of those threads.

> Also, this particular point was not meant as a critique of your
> current submission.  I don't even think it's all that big a deal for
> the previous submission either (it's an easy oversight to make given
> that Junio submitted a portion of one of your old series).  My point
> was simply that Alex didn't need to feel bad for not having been aware
> of all the old discussions; even if he had tried to dive deep by
> recursively following all the links, he wouldn't find it.

He was aware of the old discussions, as he was part of them, but he
chose to disengage from them [1].

Either way I don't see why would anyone should feel bad about not being
aware of all the hundreds of responses over dozens of threads over
several years.

All we can ask from contributors giving their feedback for free is their
attempt to do their best, nothing more.

Cheers.

[1] http://lore.kernel.org/git/CAMMLpeQA7VW_C4yw_8n6j_SCoGr8k4VUOUaEp98UxUAMR6-MVw@mail.gmail.com

-- 
Felipe Contreras
