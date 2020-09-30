Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66868C4727E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 14:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E92602076B
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 14:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="f3BVlq3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgI3OCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 10:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730107AbgI3OCS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 10:02:18 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E003C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 07:02:16 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y4so1682615ljk.8
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TW5VgHVZ2o/BSfbGElSs9iejpQqC9+hF+TDUDJJA47s=;
        b=f3BVlq3IlY67UXi4znpPeXVtE2seoeGgK8iHZVnmzDt81cENNLJ2G4UK1+PGzL4V/c
         IZroafIXseI6av8EnNCY+3RO2SEhnAfVhRB0oHFGgq+lRsAWLQwWpW1LDZTzhir5rgEJ
         2WEbho6egYbUNWxVbSMR6rQFNpcmgqFjX+BhVeyOFCCxk5q4OzrDM35QdLylXtUDafIE
         1nK5/ahIhROLuH5QsAovD+soghJvwF4j2JA2ldnZpv9fC4McCJQ4tOpCzfZx+79jSq0d
         9NPvYX2s2GSxRIPrb/u6r7x14rtW+OAJ2v7+INgEICuxh9Lc8WsMNJoPFyS3vuf46/d1
         Dhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TW5VgHVZ2o/BSfbGElSs9iejpQqC9+hF+TDUDJJA47s=;
        b=tdlh7DA2TYNbEq0bgmR1bq9JOFPVo2oAETR1CX9pfF9lwYjMDDUWHkr9F8qwg7REgX
         3xxAi/ikBOB4PQr2WRDXTId0PaIh58ryVc0rP6b+PdwlB0BlsZCoUrEVyszAgF7BGwU2
         z+1Yv9pD/pevZd1cSCsFQdOOEsHJqkVA8OLEZiJaDlwpmz/NuO8w6FFsFZA8Qd068UNW
         AlmqHcd8ItJABuItuTMziiHrkd7WSfcSxv7D3FAHDq5Wx9YfkvGegV0aPaDgoK7Sq1jI
         W9YOLXArpLIdEv2hGL1+utabc/MtmbozWoW9hLSDKyIACDvEJIUEzoPhlGtz5CQH5oAP
         44Uw==
X-Gm-Message-State: AOAM532XoxuJOkYX2cS9Xw0IL6y82puXDMvGMwwFzF+t7jsZdVrI6NYK
        tPL5a3mUVomDL0fctQkjdF7lbyxKHTUdZRi1sP5XYg==
X-Google-Smtp-Source: ABdhPJyW1mthoE4w5xPz07c2zsrrNa63SDiv1GA7tnv6sbkaKWd/wBDYQ7GdLW46IWcDuqp62UZMxnknrcWQK0ScrGI=
X-Received: by 2002:a2e:b80a:: with SMTP id u10mr983572ljo.22.1601474534539;
 Wed, 30 Sep 2020 07:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600814153.git.matheus.bernardino@usp.br>
 <991169488b17e492c6d2c2f212267a66693aa7ec.1600814153.git.matheus.bernardino@usp.br>
 <CAN0heSoJvkZ+gvQwZMPW5Q0HqB0mOUnVqXiOqnPk48cDxMzAqw@mail.gmail.com>
In-Reply-To: <CAN0heSoJvkZ+gvQwZMPW5Q0HqB0mOUnVqXiOqnPk48cDxMzAqw@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 30 Sep 2020 11:02:02 -0300
Message-ID: <CAHd-oW7ErMKqeeoF40Mq418SusbVhkL2R7W73=4mbXUiamY1mA@mail.gmail.com>
Subject: Re: [PATCH v2 11/19] parallel-checkout: make it truly parallel
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Martin

On Tue, Sep 29, 2020 at 4:52 PM Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
>
> Hi Matheus,
>
> On Wed, 23 Sep 2020 at 00:53, Matheus Tavares <matheus.bernardino@usp.br>=
 wrote:
> > --- a/Documentation/config/checkout.txt
> > +++ b/Documentation/config/checkout.txt
> > @@ -16,3 +16,24 @@ will checkout the '<something>' branch on another re=
mote,
> >  and by linkgit:git-worktree[1] when 'git worktree add' refers to a
> >  remote branch. This setting might be used for other checkout-like
> >  commands or functionality in the future.
> > +
> > +checkout.workers::
> > +       The number of parallel workers to use when updating the working=
 tree.
> > +       The default is one, i.e. sequential execution. If set to a valu=
e less
> > +       than one, Git will use as many workers as the number of logical=
 cores
> > +       available. This setting and checkout.thresholdForParallelism af=
fect all
>
> If you end up rerolling this patch series for other reasons, you might
> want to consider using `backticks` around
> `checkout.thresholdForParallelism` so that it gets typeset as monospace.

Sure, thanks!

> > +       commands that perform checkout. E.g. checkout, switch, clone, r=
eset,
> > +       sparse-checkout, read-tree, etc.
>
> Similarly here. Or perhaps go for "linkgit:git-checkout[1],
> linkgit:git-switch[1]" etc.
>
> BTW, as far as ".e.g.," goes, this list looks quite long. :) I almost
> get the feeling you've made it fairly exhaustive and added the "e.g.,"
> more as future proofing than anything else. I don't think anyone would
> complain if you left out, say, the plumbing `git read-tree` from the list=
.

Yeah, I might have gotten a little too carried away there hehe :)

> > +Note: parallel checkout usually delivers better performance for reposi=
tories
> > +located on SSDs or over NFS. For repositories on spinning disks and/or=
 machines
> > +with a small number of cores, the default sequential checkout often pe=
rforms
> > +better. The size and compression level of a repository might also infl=
uence how
> > +well the parallel version performs.
> > +
> > +checkout.thresholdForParallelism::
>
> Sorry if this has already been discussed, but this "For" looks somewhat
> odd. Basically every config knob is "somethingForSomething". ;-) Could
> this be `checkout.parallelismThreshold`?

Thanks for the suggestion. TBH, I spent more time than I'd like to
admit trying to come up with a name for this setting... But
`checkout.parallelismThreshold` does sound better.
