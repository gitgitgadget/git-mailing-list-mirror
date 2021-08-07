Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637A7C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 03:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47BB961167
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 03:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhHGDHV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 23:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhHGDHV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 23:07:21 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806F2C0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 20:07:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b6so5436567lff.10
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 20:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CRj2v2W7L1hi7cmaL1t313nO4PQCRJL9m+i8tTrcGu4=;
        b=wDGDZXJM+WYvkMbnGp+Rs6LWIH2LdZtxHkCJd4FndQBiBaTocv186xK58vxpHXLvqe
         IHIaFdA/siKO4j/P4Hbc6bGG/tV1s6PuUfUSZ0DOOqiYHGT5/QZqQb6OotsD94zFjT2J
         cRPAfTIfB2NHkkdnoJlwZWLYagsvMWC4eIrpXjFx2p9TqCCnDxCjU+E/k+FkoWlPiMNJ
         DgyztVakwfJJ8autzYLawPP1+56UPO4wYwqXQdAgPZUTobhU5lpA89p8WTF9AZM/B4Gr
         2sMuABpe3Xa6tBHIuuuQ1xObnr8LiORT0H3PX56GBJx/jTfznmdpqosgiFN3//YD9oCR
         dX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CRj2v2W7L1hi7cmaL1t313nO4PQCRJL9m+i8tTrcGu4=;
        b=Rn2vXeCyKva/cSPkbdHuMYbeQo4HARq+VZ+GOlasirHAfFCYYT3NNAtjyDrDZdV/vb
         lpJn349xKxHUYokZ7YqDzlDIU6UPhEDRxKYFQvcumjHfBmicRcatazmL0GuZiz8wlsRI
         TIXpwHmxCGgZpFizkXB08u5sEudJGLYi5r6Itfswdq/Mx5aqoT0iRuclsYNZWe6LQh9+
         39Z9iTc2sESN0QgSbG/RA5h7uKds2+8Z10dtCUkYfbso1DIa5E5R9UWHbW+mMdGouuCY
         dnb1dfZBmpaGrUfzTFws9RyOidlZV5w4Sha/uD0ojnvzKrrlCeDYNzZqgsnd8dpTQeF0
         fPoA==
X-Gm-Message-State: AOAM530C7cGrhEteS2a+YshGPk6RAoPIBxqNCkdUENgfsk8aJ2RTSDKT
        N/3gmtxm6Cx++pW5HqVxHYWI0d7TPt0jIzymLs5OyQ==
X-Google-Smtp-Source: ABdhPJyUUzSOvhY8hrUy6Ot8yxfkNBtw7jYu+cvULZ+sl5yj3ZP/d3PYod5BIv54jU1bs3piutX0UKhzPqfRAhj/YC4=
X-Received: by 2002:a05:6512:ba6:: with SMTP id b38mr7738707lfv.220.1628305620424;
 Fri, 06 Aug 2021 20:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1006.v2.git.1627943914.gitgitgadget@gmail.com>
 <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com> <fea3d6d72b63c06138d8eeb61e45edb30abbd79d.1627946590.git.gitgitgadget@gmail.com>
 <e1bec4f1-d68f-2342-f759-8d0dc0de5eb4@gmail.com>
In-Reply-To: <e1bec4f1-d68f-2342-f759-8d0dc0de5eb4@gmail.com>
From:   Mahi Kolla <mahikolla@google.com>
Date:   Fri, 6 Aug 2021 20:06:49 -0700
Message-ID: <CAN3QUFabO1PsW8te5zqwNRrHc99q4jO=6-pPc8cEv43Zevux4A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] clone: update submodule.recurse in config when
 using --recurse-submodule
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Philippe for the feedback! As a first time contributor, I
definitely struggled a bit with understanding how to submit patches
and how to amend commits versus stacking changes across commits. Thank
you for your patience! :)

On Mon, Aug 2, 2021 at 8:20 PM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
>
>
> Le 2021-08-02 =C3=A0 19:23, Mahi Kolla via GitGitGadget a =C3=A9crit :
> > From: Mahi Kolla <mahikolla@google.com>
> >
> > When running 'git clone --recurse-submodules', developers expect variou=
s other commands such as 'pull' and 'checkout' to also run recursively into=
 submodules.
>
> missing space after period here. Also, maybe I would say "some developers=
"
> or "developers might expect", or something like that.
>

That makes sense, will update.

> The submitted code updates the 'submodule.recurse' config value to true w=
hen 'git clone' is run with the '--recurse-submodules' option.
>
> We usually use the imperative form for commit messages, like if giving an=
 order to the code base
> to improve itself. So you might word this simply as:
>
> Set 'submodule.recurse' to true when 'git clone' is run with '--recurse-s=
ubmodules'.
>

Got it, will update.

> >
> > Signed-off-by: Mahi Kolla <mahikolla@google.com>
> > ---
> >   builtin/clone.c          | 1 +
> >   t/t5606-clone-options.sh | 7 +++++++
> >   2 files changed, 8 insertions(+)
> >
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 66fe66679c8..f41fd1afb66 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -1130,6 +1130,7 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
> >                                          strbuf_detach(&sb, NULL));
> >               }
> >
> > +                string_list_append(&option_config, "submodule.recurse=
=3Dtrue");
> >               if (option_required_reference.nr &&
> >                   option_optional_reference.nr)
> >                       die(_("clone --recursive is not compatible with "
>
> I think that this change is a big enough behaviour change to warrant that
> an "advice" message be shown to the user, informing them that 'submodule.=
recurse'
> has been set to true, and maybe point users to 'gitsubmodules(7) to learn=
 what this
> configuration entails.
>

I will definitely update the 'git-clone' man page to include some
documentation on this change. Should the "advice" to the user show up
in the output message once the clone command is run?

> > diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> > index 3a595c0f82c..3daef8c941f 100755
> > --- a/t/t5606-clone-options.sh
> > +++ b/t/t5606-clone-options.sh
> > @@ -16,6 +16,13 @@ test_expect_success 'setup' '
> >
> >   '
> >
> > +test_expect_success 'clone --recurse-submodules sets submodule.recurse=
=3Dtrue' '
> > +
> > +        git clone --recurse-submodules parent clone-rec-submodule &&
> > +        test_config_global submodule.recurse true
>
> This should be 'test_cmp_config', which checks that a specific config var=
iable has
> the expected value. 'test_config' is used to set a config for the duratio=
n of the test,
> which is not what you want to do here. I see you've changed it in a follo=
wing
> patch, but not to the right thing. As I wrote in my response to your cove=
r letter,
> this series should be as a single patch.
>
> Thanks for working on this!
>
> Philippe.

Ah, thank you for pointing me to the right testing function.
Definitely, agree with the single patch. I'll update the corresponding
files and submit them all as one V2 patch.

Thank you so much!
