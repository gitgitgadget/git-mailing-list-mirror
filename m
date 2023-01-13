Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF44FC54EBE
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 17:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjAMRAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 12:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjAMQ70 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 11:59:26 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624B878263
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:59:25 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id v19so17203134ybv.1
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOJ4qjsP2G+n13nudP4l6f+KAE/rKc2v62BN8PuNqe0=;
        b=ZTeoWVGLplh7l8q5jhLLzX+WqC36eksCrytyKxBbWrvfLaZHIRTgYd4Z3xNn7S+s8V
         bCpNeFPqPWh5KtwgnGbPUypDziw3zQv9VOK6BlwWWLXu7AnWikrr54MIGHriPxX52sRa
         p3NnjYWlTjd08mwLIP+lH6nscAckmuhi6xQQNLrjnhjkC+zy3SeXHKIHqjENMHDrFWF2
         enxAURv3sOdHE4xUnTCY01dLBibuq7QeIjGGx0aVvDScqiaqJtfLnC9ZrL9ZF+he9Q1u
         oSUYqiT4pkh5VOySNNlEzLx32QtFowGuuFPK6HlWH+V+9mkQ/uzB0tGetRHb/VL27p72
         2s9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOJ4qjsP2G+n13nudP4l6f+KAE/rKc2v62BN8PuNqe0=;
        b=FMWSXKURZ5y0EpUnz5ZIf1mDzeB+JI0Fayf1awrEFwBfkcl6s2mZqEsSZMX66BomdX
         LT/vrSkeBc8nqwQkbGpMghL+NQWsRZpeN5dqtVPgAwEOpfpBEn6zmmIr86NYd3R1HjLD
         5vk0MIotDBs4eu/eXj1U7jc1RDGd7ivaOQVbmn4bl/iE/xUA20sH8GOErfUwCxmTwsuN
         4xveNixYLoR9KGdcYtStdHQwm/ADXI4Yhosw1/JIW/v8fCErpdAYo89PFxQnR9xY+9dJ
         4J9zFJGcGyRwZus4vnEvcQonGGAtzdjFxTQb9kM6+YN5GKejUL0tNIIkIg7cF7eyajrN
         i8mA==
X-Gm-Message-State: AFqh2krATjWxy8x3bMPGOwPNJdOe/IOcm2ita8B6U9Tyb/Nm4nvKiqQj
        OP81Au1nP8Pkr66R05/AACKMeygZU82ujvtiIw4=
X-Google-Smtp-Source: AMrXdXtNu1PYy/zMid+f+ChKqZyJIBgyeNT/cH1KVbKqAzu2GOz35r2jfaVpjS1vNXW2NuTlI1L+WmOkP0hDQEo+9O4=
X-Received: by 2002:a25:11c6:0:b0:706:f408:5c63 with SMTP id
 189-20020a2511c6000000b00706f4085c63mr7159294ybr.221.1673629164472; Fri, 13
 Jan 2023 08:59:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com> <230112.86tu0w12kc.gmgdl@evledraar.gmail.com>
In-Reply-To: <230112.86tu0w12kc.gmgdl@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 14 Jan 2023 00:59:13 +0800
Message-ID: <CAOLTT8SEBG+cgVsX5n2Vww=M0PCOwH0JxWY3dG9_nsRnRf6+fA@mail.gmail.com>
Subject: Re: [PATCH] ls-files: add %(skipworktree) atom to format option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2023=E5=
=B9=B41=E6=9C=8812=E6=97=A5=E5=91=A8=E5=9B=9B 18:15=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
> On Wed, Jan 11 2023, ZheNing Hu via GitGitGadget wrote:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Because sometimes we want to check if the files in the
> > index match the sparse specification by using
> > `git ls-files -t`, but `-t` option have semi-deprecated,
> >
> > So introduce "%(skipworktree)" atom to git ls-files
> > `--format` option. When we use this option, if the file
> > match the sparse specification and removed from working
> > tree, it will output "yes", othewise, output "no".
>
> Your code says "true" and "false", not "yes" or "no". Which is it ?:)
>

true/false. This is a typo.


> More generally it's unfortanute that we don't support the ref-filter.c
> formats more generally, then we could just make this 1 or the empty
> string, and you'd do:
>
>         %(if)%(skipworktree)%(then)true%(else)false%(end)
>
> Now, I don't think your change needs to be blocked by generalizing that
> if/else stuff in ref-filter, that would probably be some thousand-line
> series if we're lucky, even though it's a good eventual goal.
>

Aha, if we were to introduce %(if) %(else) in the ref-filter I'm sure that
would be a very complicated situation.

> But I feel strongly that you should not pick "true", or "false", or
> "yes" or "no", but rather "1" or "", here, as doing so will be
> future-proof when it comes to this format being compatible with using
> the ref-filter.c conditional support.
> >

Good point.

> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     ls-files: add %(skipworktree) atom to format option
> >
> >     git ls-files -t is semi-deprecated, but in face we need to use -t o=
ption
> >     to check if a file in the index match the sparse specification.
> >
> >     So I think this feature can be migrated to git ls-files --format, a=
dd a
> >     %(skipworktree) atom to indicate whether the file in the index matc=
h the
> >     sparse specification and is removed from the working tree.
> >
> >     v1: add %(skipworktree) atom to git ls-files format option.
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1458%=
2Fadlternative%2Fzh%2Fls-file-format-skipworktree-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1458/adl=
ternative/zh/ls-file-format-skipworktree-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1458
> >
> >  Documentation/git-ls-files.txt |  6 ++++++
> >  builtin/ls-files.c             |  3 +++
> >  t/t3013-ls-files-format.sh     | 22 ++++++++++++++++++++++
> >  3 files changed, 31 insertions(+)
> >
> > diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
> > index 440043cdb8e..0e50307121d 100644
> > --- a/Documentation/git-ls-files.txt
> > +++ b/Documentation/git-ls-files.txt
> > @@ -260,6 +260,12 @@ eolattr::
> >       that applies to the path.
> >  path::
> >       The pathname of the file which is recorded in the index.
> > +skipworktree::
> > +     If the file in the index marked with SKIP_WORKTREE bit.
> > +     It means the file do not match the sparse specification
> > +     and removed from working tree.
> > +     See link:technical/sparse-checkout.txt[sparse-checkout]
> > +     for more information.
>
> I likewise think this won't need to be blocked, but this is a sign that
> we should probably move these to the main doc namespace. See 1e2320161d2
> (docs: move http-protocol docs to man section 5, 2022-08-04) (and
> commits before that) for prior art.
>
> But what we should fix here is that this ling is wrong, as you can see
> in that commit we need to link to the HTML docs for these (confusing as
> that is).
>
> Or (and I didn't check) if we never generate the *.html either for this
> particular one this link will always be broken. I.e. we won't install
> this, nor the HTML docs.

Yeah, you should be right: there may be a problem with the link here,
maybe this needs a patch to migrate technical/sparse-checkout.txt.

Thanks,
ZheNing Hu
