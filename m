Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74255C6FA82
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 15:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiIUPmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 11:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiIUPm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 11:42:29 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6EFBDE
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 08:42:27 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id n81so5363233iod.6
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=WH2esOvHdFCUIDYozkXrBmh6U0oVzcA7s4g3gYJziUk=;
        b=MuOC30VfOFS+Ujnltet4XitEvwiKO+7wOaV01VCRKj7I36Sbk3GckYZyHSan19iE+g
         g6sfIWptZ/y+4vV+reV0+6d+CnXXW58jgDkrRL2bAk1xmGQ/8v29cNDneAPFIEZ1flG+
         nHD6wt4uobN6RIChADiycsBuM6s68o2Rr1SQ5lPx4HxB4b5kIUWrdOljQwnh7WTAPnQ9
         qLbA/Mo3CBFO2/4UKUnem9c5K5CFiKQrfAvopME02rdCV6y143DWxgpbBy8zcn4iNFUw
         jaKECmxE8eRjVG7taNtMquxOSymldwcGxLwWrSwiBIKkl6nFjE0E+BoiRiWiltn3Pbzb
         jKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WH2esOvHdFCUIDYozkXrBmh6U0oVzcA7s4g3gYJziUk=;
        b=mrBiC2Zjz4WA3zBt1DxJKuQXMH4wdyzUO0W1LBT0qAXxRb9RSkmT772NbOjKdEov1X
         PlOqEilPqpPIXE+SoykobZRGq4CCiN5GnYNz3rtsreaBtRUhME/r4Waprvp76JI2Gs/d
         MmwhZIC1ZKT01iW+XI3vFWcg8XlKgUH+yiE2+qGa3Nrmf3W1xnc1mib6Kh3VhTHyY0So
         zz50AQQItYC9c/87r8lfhXYN/H9BLH+UoCkoN3hRu/BTt/wK3reOcUaBIjOtNbitIq+k
         9rbg/tMv9OUUeBMx7dvt/96sIIWTnwmoGR8V7TfWAwEXceYyKw3xx5qY8B2cdp+xIRka
         AjYA==
X-Gm-Message-State: ACgBeo2AeScySfOgpZxgBjFpqjciNZcdRhdwXAa73DUepSkg+vEx6/t7
        h5AmPz2yWz2eZDuTUvv5nvP0LUwN9l1qlihEo8M=
X-Google-Smtp-Source: AMsMyM5d+gCJofPdq/QXA3f8SZpDodidVgQ34q/gIDXDpwDIKDMiV9nuRLorzsPhVpIHmBfwlRIoee/Ra5crmGnt8G4=
X-Received: by 2002:a05:6638:1683:b0:35a:4772:edc2 with SMTP id
 f3-20020a056638168300b0035a4772edc2mr13347991jat.128.1663774947316; Wed, 21
 Sep 2022 08:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com>
 <CABPp-BHFw_Qw3d=j3awFtm2OD8WFVHSRFqYzm5Z0WQNHf-ECpA@mail.gmail.com>
In-Reply-To: <CABPp-BHFw_Qw3d=j3awFtm2OD8WFVHSRFqYzm5Z0WQNHf-ECpA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 21 Sep 2022 23:42:15 +0800
Message-ID: <CAOLTT8Txre2htohUzdp6+XySkyK3-ovDx=MAbjZxjdOSPBi3Zw@mail.gmail.com>
Subject: Re: Question relate to collaboration on git monorepo
To:     Elijah Newren <newren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=8821=E6=97=
=A5=E5=91=A8=E4=B8=89 09:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Sep 20, 2022 at 5:42 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > Hey, guys,
> >
> > If two users of git monorepo are working on different sub project
> > /project1 and /project2 by partial-clone and sparse-checkout ,
> > if user one push first, then user two want to push too, he must
> > pull some blob which pushed by user one.
>
> This is not true.  While user two must pull the new commit and any new
> trees pushed by user one (which will mean knowing the hashes of the
> new files), there is no need to download the actual content of the new
> files unless and until some git command is run that attempts to view
> the file's contents.
>

Yeah, now I understand that git fetch will not download blobs out of
the sparse-checkout pattern, but git merge will. So git pull will
download some missing blobs here.

> > The large number of interruptions in git push may be another
> > problem, if thousands of probjects are in one monorepo, and
> > no one else has any code that would conflict with me in any way,
> > but I need pull everytime? Is there a way to make improvements
> > here?
>
> No, you only need to pull when attempting to push back to the server.
>
> Further, if you're worried that the second push will fail, you could
> easily script it and put "pull --rebase && push" in a loop until it
> succeeds (I mean, you did say no one would have any conflicts).  In
> fact, you could just make that a common script distributed to your
> users and tell them to run that instead of "git push" if they don't
> want to worry about manually updating.
>

Ah, This method looks a little funny, but it maybe can work. This
issue may also apply to some Code Review tools, maybe need
a "pull --rebase && git cr" loop.

> Now, if you have thousands of nearly fully independent subprojects and
> lots of developers for each subproject and they all commit & push
> *very* frequently, I guess you might be able to eventually get to the
> scale where you are worried there will be so much contention that the
> script will take too long.  I'd be surprised if you got that far, but
> even if you did, you could easily adopt a lieutenant-like workflow
> (somewhat like the linux kernel, but even simpler given the
> independence of your projects).  In such a workflow, you'd let people
> in subprojects push to their subproject fork (instead of to the "main"
> or "central" repository), and the lieutenants of the subprojects then
> periodically push work from that subproject to the main project in
> batches.
>

Make sense. When this mono-repo really has this kind of scale,
splitting the workflow might be the right thing to do.

> I don't really see much need here for improvements, myself.
>
> > Here's an example of how two users constrain each other when git push.
>
> Did you pay attention to warnings you got along the way?  In particular..=
.
>
> > git clone --bare mono-repo
>
> You missed the following command right after your clone:
>
>    git -C mono-repo.git config uploadpack.allowFilter true
>
> > # user1
> > rm -rf m1
> > git clone --filter=3D"blob:none" --no-checkout --no-local ./mono-repo.g=
it m1
>
> Since you forgot to set the important config I mentioned above, your
> command here generates the following line of output, among others:
>
>     warning: filtering not recognized by server, ignoring
>
> This warning means you weren't testing partial clones, but regular
> full clones.  Perhaps that was the cause of your confusion?

Oh, sorry for forget record this, I have config them globally:

uploadpack.allowanysha1inwant=3Dtrue
uploadpack.allowfilter=3Dtrue

Thanks for the answer,
ZheNing Hu
