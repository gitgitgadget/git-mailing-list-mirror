Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD98C433EF
	for <git@archiver.kernel.org>; Sun,  8 May 2022 14:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbiEHORZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 May 2022 10:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbiEHORW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 May 2022 10:17:22 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC092BE2E
        for <git@vger.kernel.org>; Sun,  8 May 2022 07:13:31 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id y11so7724483ilp.4
        for <git@vger.kernel.org>; Sun, 08 May 2022 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x+fT1r8amPRv6/u/BNR3IkMlnIO/wNaH4Rkh4b00UO0=;
        b=YR72YVUcefWaiiovSw7W37Di9RfoY6qson6lCfR3ESuceCqSqtirghUH97t74NQ6Cj
         fQblCc8vpdhYos2jjxHnvjT2jJZTQz5CYrKkIRQNtBfa+hmIl92DHk0/6QPeQ5rZk3jR
         MVkSXxHyHYj0rn+wSIphNw9VFTYaAp3yEcKawiq6K4znd6DaFH3LpzkD2QxIOFEJhFeg
         1dqWVjqc886p8/pP2e6puOHRiBueEqpxdj4PGZa3a/e+X0V3xvvne27ImYw+W7l9JfYR
         mhSK8r20CbVbWSpinbjUSQWGwa1K49kXKOURHzGT+sJK+cP1FpZmZgCZ+nOCoEOO6/gy
         2E4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x+fT1r8amPRv6/u/BNR3IkMlnIO/wNaH4Rkh4b00UO0=;
        b=q13e8miHuf8EM51V9qepg0+nMAe1M/NfPHTUuqRa0vKyoSbpGU5R1+eV5uI4b7ei5Z
         +MoeUdC5zNZgb3uJIVELPv9YWfwOJhMmkXfmnCBeWOrDN132QJQbQ/2jUJazXiA1oEPH
         iTbeFHJoYaf9FEuHj/EKxZ3ixQqnwdhHOklXhaRa0qUf8BRXhak+oweFkQHPuTwSfcuM
         qESr9G6Pve8BxNWibvSsl5vqaV0ZYEAzqenmWCl59U2EG9CdlP74c3yVxiISelyG4+ss
         V4ijuUWQylaCoyzhLOiV22DA/mH9BcvwhqD9uTewg/XmE6sICzPEY2BmYQRI4WsVuYBN
         qsIQ==
X-Gm-Message-State: AOAM530MQyRHv0MtNr5rqTjnMtCB9PTvkOn70sxQJ0p22MeoCkx7Op8f
        HOEMyrzbExppAmPgmwuz0AmgawnWUev6u9M9UzM=
X-Google-Smtp-Source: ABdhPJxwkKk78aghL7bYgpYWgz1oDEy0h8sZwafBpDEh3yfarNLrys/+8MwZ3AFut3XnL95PGfr3UTPf7MfpWrXNnNE=
X-Received: by 2002:a05:6e02:1348:b0:2ca:b398:1144 with SMTP id
 k8-20020a056e02134800b002cab3981144mr5190289ilr.163.1652019211200; Sun, 08
 May 2022 07:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8S8rh+VYcuaqBeNtmphiRqw7HropLFpkxfnTJq6BngGXw@mail.gmail.com>
 <CAP8UFD2p+Evqv_MBAgv23zooppsNWjOw6ZU2GLqAq_skZoJPOw@mail.gmail.com>
In-Reply-To: <CAP8UFD2p+Evqv_MBAgv23zooppsNWjOw6ZU2GLqAq_skZoJPOw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 8 May 2022 22:13:20 +0800
Message-ID: <CAOLTT8RscqL_05tg0cwBBQ50HmpsoqGYXpcWPTT9nzL2LueqxA@mail.gmail.com>
Subject: Re: Question about pre-merge and git merge octopus strategy
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        vascomalmeida@sapo.pt, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=
=887=E6=97=A5=E5=91=A8=E5=85=AD 01:24=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Fri, May 6, 2022 at 10:15 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
>
> > I am thinking about if git can "pre-merge" multiple branches, which
> > can check if merge
> > will have conflict, but not to merge them actually, like a option `--in=
tend`.
> >
> > I find "git merge-tree" can output merge result in stdout, which meets
> > my needs, but it can only
> > support two branches' merge.
>
> Elijah (added in Cc) has been working on "git merge-tree" improvements
> based on the new "ort" merge he developed. It supports merging 2
> branches, but maybe there are ways to make it support more than 2.
>

OK. As he said, there is not such option :(

> > So I find git merge with more than two branches can use octopus strateg=
y.
> > What about git merge --no-commit? Which will not commit automatically,
> > so we can check if they have
> > confilct, and abort merge.
>
> Yeah, I think that's what you want.
>
> > I think it's not useful for git merge-octopus, because if we meet a
> > merge conflict, we can't find
> > MERGE_HEAD at all! How can we abort this conflict merge?
>
> I don't know octopus merges much, but I think you should be able to
> abort using "git reset" (maybe with "--hard"). If the merge was
> performed using --no-commit or if there was a conflict, then I think
> it should be expected that there is no MERGE_HEAD as no commit would
> be created so MERGE_HEAD would have nothing to point to.

Yes, git reset --hard HEAD is the way get out of merging conflicts. But why
git merge --abort doesn't work? I think it may confuse users...
