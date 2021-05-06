Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09F4C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 02:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA5D613B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 02:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhEFCuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 22:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhEFCuf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 22:50:35 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E55C061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 19:49:37 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id d10so3676528pgf.12
        for <git@vger.kernel.org>; Wed, 05 May 2021 19:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d1nRCWNvqpUZ666agZnx+p0lr6O5PFK2h0+PVK1v9no=;
        b=iSwAUfsbxlw4DYcuocnWH7t6hOLPHq1xDlpIKYsqGa+ioygVtOni7Dm6z37EW1Bw7P
         k385UCuyn+QBEIuzGt8E0lxJJjA641MeqlNM2g84M+jFxlNico2jjzjU+E98jtigXDJ6
         TkNt484lr0GgWE97DmmT1h+3cVTzP9/zxfFFe3mSopssKxAR1Lp4AT3KIFP1SltB0UQ1
         OkuGSsNcIh79q7DJuWK6k3L6kylTZRFK92n3RJa2DBO2KnsBBC39zNmHp7com6R8fsW8
         VsNSG712M9SVsbc29dl0NnTPKhV0aY5JKlv+avEp3eoiKCQcyomz+Om2Ugn5s7ukIpAH
         gufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d1nRCWNvqpUZ666agZnx+p0lr6O5PFK2h0+PVK1v9no=;
        b=U2jX4QHe8oRdPuS64myApNQ6HY4GWSi8cXRK9TMoQjY40TbqKiRQq6DKyHbJSaVLWL
         ZV4ia9mIctSKAadJQQaKqD66rEittg6CZWVG+O1qZEwb+dRh/LHbGzaIFdi64HzYNBvN
         WgTUg2Gw+qp81ZQjGbq+FAEnAAPolB0kbqA1uVCblMYfe0LDBQINJXNeUEirXKb7ZDKq
         UNwmxA/CbntVE6Ao2ZI2jzli8wG1jM1GBVjDNEDO2CkWr+o1Ik3g5USFH4f0N7XM1YUr
         q30qiB8bmpz5sMdr3tptnJUmGFwm7bIXun/UYJUvgc2kd7MBI3/MtwTDya9o+NdvdxKT
         9MaQ==
X-Gm-Message-State: AOAM532sklZ9qgKtKvfw8KfnSz7/7iv6VrD7UdwehX04/8NQ7UordzJk
        TkMZ2Rj61r9UzMti/RZiIdQQQuKyqFSaTnJz7DA=
X-Google-Smtp-Source: ABdhPJymfpIZ8cVVNG0/oSBTL0qV3iM5hZVzNlKnXnC5tu0hu1MsNXtYfb7s2LaFInoAjhgNCWjTrzioAGM7snu+8Io=
X-Received: by 2002:aa7:9244:0:b029:28b:df74:b67b with SMTP id
 4-20020aa792440000b029028bdf74b67bmr2169752pfp.32.1620269377140; Wed, 05 May
 2021 19:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
 <20200429093811.8475-3-shouryashukla.oo@gmail.com> <xmqq7dxyxlpj.fsf@gitster.c.googlers.com>
 <20200502061355.GB5582@konoha> <xmqqzhanhehd.fsf@gitster.c.googlers.com> <7e11d316-f8d6-3921-f1a6-026584d9291d@gmail.com>
In-Reply-To: <7e11d316-f8d6-3921-f1a6-026584d9291d@gmail.com>
From:   dyrone teng <dyroneteng@gmail.com>
Date:   Thu, 6 May 2021 10:49:25 +0800
Message-ID: <CADMgQSSvU1vM_moe_cdjr_FzY_-kAM8LZ+T-pQMio=NpunZy6A@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] gitfaq: shallow cloning a repository
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        git@vger.kernel.org, newren@gmail.com,
        sandals@crustytoothpaste.net, christian.couder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, I was taking attention on other place and totally forgot that.

I will restart to look into the patch again today

Derrick Stolee <stolee@gmail.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=885=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=888:26=E5=86=99=E9=81=93=EF=BC=9A
>
> On 5/4/2020 12:06 PM, Junio C Hamano wrote:
> > Shourya Shukla <shouryashukla.oo@gmail.com> writes:
> >
> >> On 29/04 10:09, Junio C Hamano wrote:
> >>>> ---
> >>>> I wanted to ask why is there no mention of partial cloning in
> >>>> the 'git-clone' documentation? Is it because it is an experimental
> >>>> feature?
> >>>
> >>> If the folks that have been pushing the feature haven't bothered to
> >>> document it fully, by definition, it must be a work in progress that
> >>> is not ready for the prime time ;-)
> >>>
> >>> Jokes aside, the --filter=3D<filter-spec> option is mentioned in the
> >>> documentation and it says "...is used for the partial clone filter",
> >>> without even defining what a "partial clone filter" really is.
> >>>
> >>> The topic deserves its own subsection, between the "Git URLs" and
> >>> the "Examples" sections, in git-clone(1).
> >>
> >> May I try to add it? If yes then are there any points to be kept in mi=
nd
> >> while writing this part (for eg., length of the subsection, writing
> >> style, what all is to be written etc.)?
> >
> > I am much less qualified to answer these questions than others on
> > the CC: list.
> >
> > Who added the mention to --filter and "used for the partial clone filte=
r"
> > to the page anyway?  Did you run "git blame" to find out?
> >
> >     ... goes and looks ...
> >
> > It was added by 4a465443 (clone: document --filter options, 2020-03-22)=
.
> >
> > Derrick, perhaps you can help Shourya to find a good place to give
> > a birds-eye description for the partial-clone feature and figure out
> > what points about the feature are worth covering there?
>
> Yes, in the series that added those options I requested help in
> documenting the partial clone. This was started in [1] but seems
> to have gone stale.
>
> CC'ing Dyrone to see where they are with this.
>
> Shourya: would you be willing to help the patch [1] get finished?
> You could probably incorporate it into this series (adding your
> sign-off). Let's see if Dyrone gets back to us.
>
> Thanks,
> -Stolee
>
> [1] https://lore.kernel.org/git/c1a44a35095e7d681c312ecaa07c46e49f2fae67.=
1586791560.git.gitgitgadget@gmail.com/
