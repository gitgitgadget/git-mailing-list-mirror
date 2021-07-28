Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40BEC432BE
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 07:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 838F560FC2
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 07:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhG1Hiw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 03:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbhG1Hiv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 03:38:51 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FF6C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 00:38:49 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id d10so1789472ils.7
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 00:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0TISbtsf9qcNtlF1F/gdtR79uyjwmK1zC4W1XE7jsGU=;
        b=o2wJRlBEf21jZopPB46esgDtbWzfDj0jbwnXWJxOV7hxesLyQS5v42nMQS9vwDsNmk
         EOCrZXj2iOoOf2gbkE8Lko8DuVYCGdH0VT41sLOf6t42huuxgD2MmPC9MnDUaNxzADyJ
         BXcg8Tg4K674cICKsCoM3lzu7Ci+jOBBr0B0Dmql0blmwLeheklzYIajw6iqSf2tlCUD
         KrT4E94obbp9xRzvPen+5vopnVNH/U7KdLWuCIe6X3qVR+KYQyd0XdSrOyqGzzeV0MsD
         ki5ad44ftl8zKSrm719S3MkCXdhpm0chmKX7mXXaDcb6YEMBl7NZSqarOfj2IhBDAkjH
         QVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0TISbtsf9qcNtlF1F/gdtR79uyjwmK1zC4W1XE7jsGU=;
        b=mR2BZkrk3PGShR0fItTLpsM4OtlIYWkq1n5GjdsHlu/66ITJteAMIVotoMr5SDUxI2
         36e11JSSQBXtWGIzAAkiK4n5LP5IJEkw/Tq2NVFCwYaKKGq0ZbEDSIyU4x6q29DR3VAG
         FSsXw8eALX+hII0YgngrKFqlKEYv2nTtHEMesME1R4/21pFmTwHk4TNZbsmddRPu1mZ/
         XA0hVuQMs3MUYwkWnr6u6Fs4wTf6vgH0j9sODpqvdEkS+IAUHbGZPmcFIguVnqByZ2z2
         SPuJ3AzFDs+eDL6bJz64hRaepJOejUDQ2ylGzQcf54ex+MX2nM0LhBwcAU9yCSZDfk19
         T8OQ==
X-Gm-Message-State: AOAM531FfOj4duwI3hLV5Y1qSBxSVxcQAATpC6w/0VBuwzb3HIXMlAOS
        uF3d8l/LFwXriNvQcCic3/Ir3VTZYRKP0UIUtaQ=
X-Google-Smtp-Source: ABdhPJzBdO/GUy4evIBN0ZHEBFjo4T2rqxNErv2y+tEJgvmZhqX4YsWmuInQ44CCnBVj+VQ8jsnKXFUoZzWOPwLj9/Q=
X-Received: by 2002:a92:ab0a:: with SMTP id v10mr19527637ilh.17.1627457929403;
 Wed, 28 Jul 2021 00:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1001.git.1626962763373.gitgitgadget@gmail.com>
 <pull.1001.v2.git.1627135281887.gitgitgadget@gmail.com> <a8b260be-dae5-e717-d4cb-3ee123f93620@gmail.com>
In-Reply-To: <a8b260be-dae5-e717-d4cb-3ee123f93620@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 28 Jul 2021 15:39:22 +0800
Message-ID: <CAOLTT8T9Fu4-r5-2PhNmopW751TBN1LRrwBU70HuKZ48JD1X5Q@mail.gmail.com>
Subject: Re: [PATCH v2] [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=883:43=E5=86=99=E9=81=93=EF=BC=
=9A
>
> > diff --git a/builtin/revert.c b/builtin/revert.c
> > index 237f2f18d4c..ec0abe7db73 100644
> > --- a/builtin/revert.c
> > +++ b/builtin/revert.c
> > @@ -245,6 +245,7 @@ int cmd_cherry_pick(int argc, const char **argv, co=
nst char *prefix)
> >
> >       opts.action =3D REPLAY_PICK;
> >       sequencer_init_config(&opts);
> > +     unsetenv("GIT_CHERRY_PICK_HELP");
>
> This will break git-rebase--preserve-merges.sh which uses
> GIT_CHERRY_PICK_HELP to set the help and ensure CHERRY_PICK_HEAD is
> removed when picking commits. I'm a bit confused as to what the problem

Yeah, I thought it would call some rebase-related code before, I
didn=E2=80=99t expect it to
call cherry-pick. On the other hand, I passed all tests, so I ignore
it, there should be
a test for it.

> is - how is 'git cherry-pick' being run with GIT_CHERRY_PICK_HELP set in
> the environment outside of a rebase (your explanation in [1] does not
> mention how GIT_CHERRY_PICK_HELP is set)? As far as I can see 'git
> rebase -i' does not set it so the only case I can think of is
> cherry-picking from an exec command  while running 'git rebase -p'
>

Ah, because I want to find a way to suppress its advice messages about
"git commit",
and I don=E2=80=99t think anyone else is using this "feature".

> Best Wishes
>
> Phillip
>
> [1]
> https://lore.kernel.org/git/CAOLTT8Ty47fyY7T3d68CYPKh9k+HAHsnCLJ=3DF0KaLm=
+0gp3+EQ@mail.gmail.com/
>

Thanks.
--
ZheNing Hu
