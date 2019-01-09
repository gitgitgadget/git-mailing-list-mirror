Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD18D1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 23:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfAIX5z (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 18:57:55 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:36793 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfAIX5z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 18:57:55 -0500
Received: by mail-pf1-f171.google.com with SMTP id b85so4416066pfc.3
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 15:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vewd-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AB3rlr3dq1/VY9aJaj0SV2Vs8El1Gs4g5qrf80tm9CY=;
        b=d76kmgLZ299VG8hZPXzFvsWlxRnb3PbF1glCea49T7hViqWcwm53JyGGv3VTmhZeUQ
         Q6a520bOCwrT96yN06lfsFSHutfUSK6NFSf+qeqPDTv9upAkD2j4pGag/VF7Q+ERK1SZ
         5SaXqat8EOn5TyK5D7D9SouaPZptrsqoZQzcapksg3kcBApILRp3fm8nawuez2El/WUI
         iUh/XEnabIOw23qgqUMjnhURUdFSXO4FYVqfdJkNMMETdrPpuh1EJ1Fo1p/gFJ1U/slM
         J1wzFtOIpWBk9OgiGEyrdLcQoG43wETgFjzQ4Aixk1Xgl6dRN0hu5PKYPPhNEB85h76k
         UyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AB3rlr3dq1/VY9aJaj0SV2Vs8El1Gs4g5qrf80tm9CY=;
        b=FTsv+2RUcfoaTiuuV67jdtPY4aALZk9UOGTu833+QLpmeCwRziNq6+BAeyAsUoRsZl
         q1dUw6k8dhb/HyWVJwkewkoIN5K9WXjCKhYvHytzoixX2aDhgA888MRPO5qS9F6nWueX
         eyBhfcOMdb1jze4KmJMxjd8ADG2sxPozKXNTqLlj9Mp5ZbZRK+5k336fyf59hrE+clAM
         ywxn3Ap6fysCSewNwmDUMGzO77V+OlDkIzhJ9U48oC5wgzRbPWVK+SWLPgIt+CYW+jM8
         XEXuyTPFdx5mkJ7rYpQ60sIufYsTpI8pMoNutpmU4jQSi5fgkV1V80GTzc5mDWeViU+a
         uEhA==
X-Gm-Message-State: AJcUukfZLpFjo7lQBzvc4rwnTkYwlAXFV8iFhnd5k3ysG4xNCZFitcyb
        KcmrMxwuTJjcLVR0PCdK1nt1TJf8WWAj2+XaRieuog==
X-Google-Smtp-Source: ALg8bN69A/yiV/cL8sRbjNDWoQaufffwg/NTf+aWYrQr0Zew7o/0jsStnnJ4WywsbN/mbB4EJcxuL2i/FAj38Hh6lr0=
X-Received: by 2002:a62:ae04:: with SMTP id q4mr7965139pff.126.1547078273862;
 Wed, 09 Jan 2019 15:57:53 -0800 (PST)
MIME-Version: 1.0
References: <CAG0vfyQeA3Hm7AsYgYtP4v-Yg0=rKXW0YYfg_emAwEscZha4VA@mail.gmail.com>
 <CAGZ79kZBwocC=UzjW+DxodwJkQZ2mNMYNjsk6sL4SCqdhGoQ7w@mail.gmail.com>
In-Reply-To: <CAGZ79kZBwocC=UzjW+DxodwJkQZ2mNMYNjsk6sL4SCqdhGoQ7w@mail.gmail.com>
From:   =?UTF-8?Q?Tomasz_=C5=9Aniatowski?= <tsniatowski@vewd.com>
Date:   Thu, 10 Jan 2019 00:57:42 +0100
Message-ID: <CAG0vfyR3KnDDBrpyG-n-RFbu-xgCLFUa6HUXQ+dk8E4HutR+ow@mail.gmail.com>
Subject: Re: Regression: submodule worktrees can clobber core.worktree config
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 9 Jan 2019 at 18:42, Stefan Beller <sbeller@google.com> wrote:
>
> On Tue, Jan 8, 2019 at 2:16 PM Tomasz =C5=9Aniatowski <tsniatowski@vewd.c=
om> wrote:
> >
> > After upgrading to 2.20.1 I noticed in some submodule+worktree scenario=
s git
> > will break the submodule configuration. Reproducible with:
> >     git init a && (cd a; touch a; git add a; git commit -ma)
> >     git init b && (cd b; git submodule add ../a; git commit -mb)
> >     git -C b worktree add ../b2
> >     git -C b/a worktree add ../../b2/a
> >     git -C b status
> >     git -C b2 submodule update
> >     git -C b status
> >
> > The submodule update in the _worktree_ puts an invalid core.worktree va=
lue in
> > the _original_ repository submodule config (b/.git/modules/a/config), c=
ausing
> > the last git status to error out with:
> >     fatal: cannot chdir to '../../../../../../b2/a': No such file or di=
rectory
> >     fatal: 'git status --porcelain=3D2' failed in submodule a
> >
> > Looking at the config file itself, the submodule update operation appli=
es the
> > following change (the new path is invalid):
> >     -       worktree =3D ../../../a
> >     +       worktree =3D ../../../../../../b2/a
> >
> > This worked fine on 2.19.2 (no config change, no error), and was useful=
 to have
> > a worktree with (large) submodules that are also worktrees.
>
> Thanks for reporting the issue!
>
> >
> > Bisects down to:
> > 74d4731da1 submodule--helper: replace connect-gitdir-workingtree by
> > ensure-core-worktree
>
> So this would need to update the worktree config, not the generic config.
>
> We'd need to replace the line
>     cfg_file =3D repo_git_path(&subrepo, "config");
> in builtin/submodule--helper.c::ensure_core_worktree()
> to be a worktree specific call.
>
> Or the other way round we'd want to make repo_git_path to
> be worktree specific and introduce repo_common_path for
> the main working tree.
>
> Looking at Duys tree,
> https://gitlab.com/pclouds/git/commit/94751ada7c32eb6fb2c67dd7723161d1955=
a5683
> is pretty much what we need.
>
> Reverting that topic that introduced this (4d6d6e,
> Merge branch 'sb/submodule-update-in-c'), might be possible but
> that would conflict with another followup that fixes issues in
> that series
> (see sb/submodule-unset-core-worktree-when-worktree-is-lost
> https://github.com/gitster/git/commits/sb/submodule-unset-core-worktree-w=
hen-worktree-is-lost)
> so I'd rather just cherry-pick the commit from Duy.

I had a look at https://gitlab.com/pclouds/git/commits/submodules-in-worktr=
ees,
and it doesn't seem to be quite all okay.

The submodule update step of the repro (that breaks the config on 2.20) emi=
ts
an error message instead, and leaves the config unchanged:
   git -C b2 submodule update
   fatal: could not set 'core.worktree' to '../../../../../../b2/a'
It looks a bit like it's still trying to do the wrong thing, but errors out
during the attempt (repo_config_set_worktree_gently returns false).

Curiously, even though it says "fatal", it will then perform the actual
submodule update if it's required.

Same behavior on master with a subset of that branch cherry-picked, that is=
:
https://gitlab.com/pclouds/git/commit/94751ada7c32eb6fb2c67dd7723161d1955a5=
683
along with two others it needed to build:
https://gitlab.com/pclouds/git/commit/d26ab4c5013f6117814161be3e87c8d2b7356=
1a4
https://gitlab.com/pclouds/git/commit/b2e21eece6b35e00707ed3a8377a84a95da6b=
778

--
Tomasz =C5=9Aniatowski
