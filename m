Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D04C433E0
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 17:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5911620720
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 17:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEHpr7FT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgGBRGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgGBRGR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 13:06:17 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535FCC08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 10:06:17 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id f8so20891572ljc.2
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 10:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H+sU+DYL0bNZjXUIFVIM/pcHl06IUDdRMmY1X35NfdQ=;
        b=DEHpr7FTHUrwPIZKr2z2KWxFgRyhnuoMWwID+niaaTqNdGzqN0hSWEac3GUHF8v0oR
         57QTjop+aLO4XdcFTPzJNkcegrxwn4kCTmhOILvolHSCMywIZ5rHBfBsmib3Q4cZN+PJ
         UA9DIB7pMi7ZwyF0MqquPqm0mfjmkcEVZHZ8/+6JXwLZ6zhJzAQTtyOvuc2P3/BS13ML
         GGHzoX4MtOjMxInupCCZ8iFIVonzFhyemwwDegE54I15SnWHA+NeoKK3fHGqk4rkF70e
         WY/Kay5Oim/7z8echaeFWKMGITy7tSYrPe8m4/LRubrprCc5fbVNot1PCytGhZOPtHKl
         9+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H+sU+DYL0bNZjXUIFVIM/pcHl06IUDdRMmY1X35NfdQ=;
        b=ZceF3TWLUT3lOoJh148KXP8GHPXQeFfVMDfLELyYrfXhFbVnTx6ewHJ2alKJ5A/R/f
         /x8cW/bzeCKLF+GNm9VdzdbkixWymXI2EJrJpV8lP+kXRQ714A9RtdcpaQxVzCDDKpVM
         KYUdFlpSyMHVUP8ctzFBnBSCQsxQcXWJHxum+gN/UYiJL4ZUJvYAMtQLoRmMe2wvQkHN
         tOaLtXfmdlmOC25WHIRAKD5AbOZeLJaLHcGsdDHTKRHgBxX6QXxmXOr/eIeo8xWK2f/R
         Fc4wGrP8FHGwLCYfier0WkB9V9dZUiyaEig7pXAur9oMe71R+UMPb7lqpN9gi63T3399
         uYCA==
X-Gm-Message-State: AOAM533KncFMJoskv99N8tgvEGjSdfU+AgIjmMrNVqe8JysBqNV1GldI
        h6Y7Q3O/h3POtXZMrnxdeOpT//Y5/H8Oytg14DN9KqZp204=
X-Google-Smtp-Source: ABdhPJzJhakXYFZQj5Gu7xnAQhhhF2UJvLdMilXhdp6SBREWglkXjWYBmUcWPCp3k6YKY8f13J+FIlAbiZNfwArKAjI=
X-Received: by 2002:a2e:b4ce:: with SMTP id r14mr7884735ljm.88.1593709575557;
 Thu, 02 Jul 2020 10:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAAF2pWYNbZF5fqZVuakTmAguK7End3nFbRgfT=mRXFfmgD9LNA@mail.gmail.com>
 <0e9801d6508d$c1f55560$45e00020$@pdinc.us>
In-Reply-To: <0e9801d6508d$c1f55560$45e00020$@pdinc.us>
From:   Jakub Trzebiatowski <cubuspl42.1@gmail.com>
Date:   Thu, 2 Jul 2020 19:06:04 +0200
Message-ID: <CAAF2pWb8Namk1rpm4==PUrq4ft9fp4eD=t9WyMLv56dPZuGk2g@mail.gmail.com>
Subject: Re: Is git compliant with GDPR?
To:     Jason Pyeron <jpyeron@pdinc.us>
Cc:     git@vger.kernel.org, Matthew Horowitz <mhorowitz@pdinc.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

czw., 2 lip 2020 o 18:27 Jason Pyeron <jpyeron@pdinc.us> napisa=C5=82(a):
>
> > -----Original Message-----
> > From: Jakub Trzebiatowski
> > Sent: Thursday, July 2, 2020 11:58 AM
> >
> > Hello,
>
> First: I am not a lawyer, and even if I were, I (nor anyone else on this =
list) would not be your lawyer - get a lawyer.
I don't think I'm in need of a lawyer. I wanted to start a discussion
on a topic that in my opinion deserves being discussed, because I'm a
git user and I believe it's interesting.
>
> Second: This thread is likely borderline off topic because for Git and GP=
DR to meet, it would be in the context of SaaS or your internal organizatio=
n. There is almost nothing pure Git about these issues, see below. Discussi=
on for the sake of it follows.

I do agree that that sounds reasonable. But could I ask you why do you
assume that there needs to be a service (or Software as a Service) to
make software fall under GDPR? The GDPR definitions don't seem to
mention that.

> >
> > I've been using git for years, but I've never before taken part in the
> > discussion on the mailing list. I have a simple question, which
> > probably isn't easy to answer.
> >
> > Is git compliant with GDPR, the EU data protection law?
> >
> > Before I'm able to commit with git, I'm asked for my first and last
> > name. That is personal data.
> >
> > GDPR, Article 4, point (1):
> > =E2=80=98personal data=E2=80=99 means any information relating to an id=
entified or
> > identifiable natural person (=E2=80=98data subject=E2=80=99); [...]
> >
> > That data is handled by the git utility. It's sent to other parties
> > operating remote git servers (as a result of my commands, but as far
> > as I know that's not relevant). It sounds like it's being processed.
>
> Git is like a hard drive or database in your organization. It does not do=
 anything else than store the information.

Storing is processing. I'm not saying that git is evil or wrong, I'm
saying that it might be the case that it processes personal data (both
understood as in GDPR).

git is also a software created by people and used by people.

>
> Exception 1: IF you configure it to do so.

Sure, it doesn't change much. Processing data initiated by the user
isn't any kind of distinguished processing, as far as I know.

>
> Exception 2: You are using a SaaS provider (e.g. github.com, gitlab.com, =
etc.)
>
> Note: this is no different than any other SCM (e.g. CVS, Subversion, file=
 shares, etc.).

I'm totally aware. I know how git works, including some of the
internals, and I'm in general aware of standard solutions in the IT
industry. Probably if git would be considered non-compliant, then so
would be other SCMs.

>
> >
> > GDPR, Article 4, point (2):
> > =E2=80=98processing=E2=80=99 means any operation or set of operations w=
hich is
> > performed on personal data or on sets of personal data, whether or not
> > by automated means, such as collection, recording, organisation,
> > structuring, storage, adaptation or alteration, retrieval,
> > consultation, use, disclosure by transmission, dissemination or
> > otherwise making available, alignment or combination, restriction,
> > erasure or destruction;
> >
> > This data is processed with a compatible computer owned by the end
> > user for the purpose of identification of git commits. It's sent to
> > other parties only when specific commands are given. All this was
> > defined by git authors/contributors (from all around the world).
> >
>
> Again, like any database, you can query it for its contents. What you put=
 in it is what it has. If you put personal data in, then it is there.

It's not a general purpose database, it's a structured database and a
software that operates on that database. That database has a field for
personal data, and that data is processed by the software.

> Where can data reside in Git?
>
> 1. The blobs - e.g. your source code
>
> 2. The commit messages.
>
> #2 is your most likely candidate of GDPR related activities.
>
> Do you use the developers names and email addresses in the message? Almos=
t certainly.
>
> Note: this is no different than any other SCM (e.g. CVS, Subversion, file=
 shares, etc.).
>
> > GDPR, Article 4, point (7):
> > =E2=80=98controller=E2=80=99 means the natural or legal person, public =
authority,
> > agency or other body which, alone or jointly with others, determines
> > the purposes and means of the processing of personal data; [...]
> >
> > Git authors can be considered joint controllers.
> >
>
> The Git distributed model means that COPIES of all of the data are on eac=
h Git server and developer environment. You (and I mean your organization) =
must address this in your IT plans.
>
> Note: this is no different than many other SCMs although some others SCM =
technologies only have the most recent version locally..
>
> > If we'd assume the above interpretations, there would be many, many
> > consequences.
> >
> > I'm not a lawyer, and I have no idea if this interpretation is
> > reasonable. I don't even know if I'd like it to be. But here are some
> > facts: GDPR does focus on protecting the end user. Possibly, it's the
> > most strict data protection law in the world. It doesn't care how
> > difficult it is to adjust the organisation for compliance and it
> > doesn't care where the controller is located, as long as it processes
> > personal data of EU citizens (if I understand it correctly).
> >
> > Are there any lawyers in the git community? Could The Linux Foundation
> > help with legal support? It's a very non-trivial issue. It's non
> > obvious how local software relates to GDPR, and it's even more
> > difficult with Free/Open Source software with many, many authors. But
> > if the aforementioned interpretation was assumed, the git authors
> > could be held responsible for non-compliance.
>
>
> I have copied our Policy SME, maybe he will have opinions.
>
> -Jason
>

In general, I totally agree with everything you said.

But you said that git itself (as a software) doesn't fall under GDPR,
and that's the only thing I'm not sure about. I was wondering if
someone with a deeper understanding of GDPR would tell my _why_.
Because when interpreting the law literally, it sounds like it does.

Also, to clarify, I'm not seeking legal advice for myself or my organizatio=
n.
