Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB2EC433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 05:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9C9208B8
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 05:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vr0P6J2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbgJMFY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 01:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732408AbgJMFY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 01:24:28 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742DCC0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 22:24:28 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id p15so19031832ljj.8
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 22:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=0Txh5qvqGqTXdHxSCa/ltheRv3T7meV+/ZXsyEHrnXU=;
        b=Vr0P6J2jaIUBoh0VaFBPUPTyiPpDqnNOGjOnuGTP74CN+26Xi3xbWaTUq+vxW5Eh7z
         c8uL+jIy5yNoernOXbO4sxQlspRMjWrM109zCvHor8sFjFA1eygmJTGSW8HWQIPTpHZo
         aV8oa28s1vJpXHLxXWJ7O0QfAVopeOg/A1P5nGjkRq940WYi0i2cijt5Le6iJAsavlgb
         Q0N++aI+6lQOdN8Oxk2gj+S4STHquXUTV62K+X35KgBuEjcyuam7iM/zoLIspFpWu7Tp
         blPULTxvueop3XkbM9kGorxkdmG8BEzElGcfnPN4WWpNqYEc3T+OEYaVqRhtyDg34n3g
         8iWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=0Txh5qvqGqTXdHxSCa/ltheRv3T7meV+/ZXsyEHrnXU=;
        b=uoFmcN09hk41fvgYs3BCSQqS1+5cFD5DH5mm7yIc9uin9nOavmcHcFPI7tXsWtzkmM
         6fZg/LiN8ydw0OspPrFbGwklm+0ir4fdNPqFUD31PrG/IC+Tw5GhqZPeSGLF14NGZLh5
         4/pUlPpUEGcqzhNP9PX2kM1EjA6mZST8di6h4ff5/f7/nedYpznf6BF/Ut55MXYjyoJg
         An/v/7izZyBbUi5+L5WvV4muOJRLVW1O/YlHHQ4U4f7P2C2o6q/P6X8mTPojvi9OcHEz
         OeSCcLUax/JpJJFzHkgr+8ncrGDNv5NdG0CSOsSZyAm/PwG5/pVqdlPBpOmEWBN4F9km
         pTJQ==
X-Gm-Message-State: AOAM530ijkZKyHILDKPeEPBZp5jk3wx0WCODONuzqX+QDxuDTKsChYF5
        Bxg9+fGD0Dh/lk7kUV4wBoIxZgPmJTOn5GCSW+M=
X-Google-Smtp-Source: ABdhPJztEfspuwTgjJp1Xsc/HKrdT1a3SsJuSEKSTIQI44a1SZfzweWzn0pPHxrOsWlQ3WlLDUsGVtzPgfuMoixnC54=
X-Received: by 2002:a2e:a30a:: with SMTP id l10mr2710515lje.122.1602566666626;
 Mon, 12 Oct 2020 22:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <CABmmNJOGBdEO+AT0_8dSwmFxomFE7A5x354+YgfxiU5N+mOroA@mail.gmail.com>
 <xmqqsgajpcan.fsf@gitster.c.googlers.com> <CABmmNJOCJEpGwz3hxYsKO=xwx_rrVv5_QcZuS_=gUZH9bM0G2A@mail.gmail.com>
In-Reply-To: <CABmmNJOCJEpGwz3hxYsKO=xwx_rrVv5_QcZuS_=gUZH9bM0G2A@mail.gmail.com>
From:   Deepak Patankar <patankardeepak04@gmail.com>
Date:   Tue, 13 Oct 2020 10:54:15 +0530
Message-ID: <CABmmNJMzs=BOYEv_pUaA3NbNkn_HhyOj_VoYeWSKzz138OCZkQ@mail.gmail.com>
Subject: Re: How to Verify the Git Credentials supplied by the User
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

Thanks a lot for the help.

On Mon, 12 Oct 2020 at 23:16, Junio C Hamano <gitster@pobox.com> wrote:
>
> Deepak Patankar <patankardeepak04@gmail.com> writes:
>
> > I am writing an application in which we will support git integration.
> > The user will provide us with his/her git credentials so that we can
> > push some files on his git. The git credentials which user will supply
> > can be
> >
> > HTTP (Username and Password/ Kerberos)
> > SSH
> >
> > Before saving the user credentials I want to validate that the
> > credentials entered is valid.
>
> It obviously depends on the remote side, but a relatively safe thing
> to try is to run things like "ls-remote" or "push --dry-run" that
> will not cause any actual damage against the remote, and see if your
> authentication fail.
>
> But you might be asking a XY question.  I would expect that any
> reasonable application that manages authentication material for the
> user and drives "git fetch" and "git push" would act as a credential
> helper and uses the credential protocol to talk to Git, so it will
> learn an authentication failure upon the first use, at which point
> it has the chance to drop the authentication material it obtained
> earlier and ask the user for the corrected one---there is no need
> for the application to see if the authentication material is correct
> before the user does anything else.
>

My previous email was confusing. I will be doing the authentication
check the way you described above
i.e. it will be done only once and I won't do it again and again
before each operation.


I can use the "ls-remote", "push --dry-run" command you suggested, but
I have a use case which I don't know how to solve.
The above commands require a repository. In our application, the user
can give the following details

Git Details:
   Account URL:  https://github.com/OpenPrinting
   UserName: deepakpatankar
   password: ***********

In this case, we don't know the repo name. At this step, I just know
the account and the credentials of the user, later on
the user will provide me with the repo name to which he wants to sync his file.

Since I don't know the repository, I cannot do "git fetch" or "git
push --dry-run". Can I check this credentials with some
logic or git commands?


Thanks
Deepak Patankar

On Tue, 13 Oct 2020 at 10:25, Deepak Patankar
<patankardeepak04@gmail.com> wrote:
>
> Hey Junio,
>
> Thanks a lot for the help.
>
> On Mon, 12 Oct 2020 at 23:16, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Deepak Patankar <patankardeepak04@gmail.com> writes:
> >
> > > I am writing an application in which we will support git integration.
> > > The user will provide us with his/her git credentials so that we can
> > > push some files on his git. The git credentials which user will supply
> > > can be
> > >
> > > HTTP (Username and Password/ Kerberos)
> > > SSH
> > >
> > > Before saving the user credentials I want to validate that the
> > > credentials entered is valid.
> >
> > It obviously depends on the remote side, but a relatively safe thing
> > to try is to run things like "ls-remote" or "push --dry-run" that
> > will not cause any actual damage against the remote, and see if your
> > authentication fail.
> >
> > But you might be asking a XY question.  I would expect that any
> > reasonable application that manages authentication material for the
> > user and drives "git fetch" and "git push" would act as a credential
> > helper and uses the credential protocol to talk to Git, so it will
> > learn an authentication failure upon the first use, at which point
> > it has the chance to drop the authentication material it obtained
> > earlier and ask the user for the corrected one---there is no need
> > for the application to see if the authentication material is correct
> > before the user does anything else.
> >
>
> My previous email was confusing. I will be doing the authentication
> check the way you described above
> i.e. it will be done only once and I won't do it again and again
> before each operation.
>
>
> I can use the "ls-remote", "push --dry-run" command you suggested, but
> I have a use case which I don't know how to solve.
> The above commands require a repository. In our application, the user
> can give the following details
>
> Git Details:
>    Account URL:  https://github.com/OpenPrinting
>    UserName: deepakpatankar
>    password: ***********
>
> In this case, we don't know the repo name. At this step, I just know
> the account and the credentials of the user, later on
> the user will provide me with the repo name to which he wants to sync his file.
>
> Since I don't know the repository, I cannot do "git fetch" or "git
> push --dry-run". Can I check this credentials with some
> logic or git commands?
>
>
> Thanks
> Deepak Patankar
>
>
>
> >
> > > The user might be using GithHub/BitBucket/GitLab. I am trying to find
> > > some git command which I can use to validate the credentials. Can you
> > > please point me to some command/logic which I can try?
> > >
> > > What I have tried?
> > > I tried git ls-remote command, but it requires the repo name/url. In
> > > one of our use case, the user won't specify the repository name
> > > beforehand. Because of which I am not able to use this command.
> >
> > This assumes there always is a single authentication material
> > regardless of the URL, which is probably not a good security posture
> > to encourage the users to adopt.
