Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A03CC6FA8E
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 15:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjCBPfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 10:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCBPfr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 10:35:47 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A692ED7B
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 07:35:46 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id f18so22666940lfa.3
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 07:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677771344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCBjZo+FrLeyhMeWMicUQfI2GzyzExY2zV5IJ8ZgVI0=;
        b=PaAidgzL8TOXLP/nXeaIJadeuPxhmUoEWbirFEFON18sc2DKv49IjK/KSDY4Ot1KaS
         CfKpLntJpWlYGpIBSJl0cemxERZS/LXnkS/vhLM2qoI30y2JijLUnztLmD4PLTkBLVKH
         xuwBPs5+kz8g9EmoBthx4tqIWE/fpdf+sZhYMx1o9bUjukj3edANWabAManedsrzfn9L
         i19z/fO2HBtQ8O8vhY/fJLCjyhZAA0fBjOz7qxWBpq2IHg2Q1kxtCH73pgC207gBmCNx
         PzzQtAMWfSlQWyDId6hzkHwUAOCqxBj4AUXG5e6xVxPf6yYIwB0y4XmVTwi3QXnQtsEO
         nIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677771344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCBjZo+FrLeyhMeWMicUQfI2GzyzExY2zV5IJ8ZgVI0=;
        b=Ukq9paI3RzICwIGUni2MwSZsCndszC6bnwL7Vy1Fr005BXGjITbolmeh1qXN6ggyRk
         XxzRem2it+8d1nG7xHJzPDZ7m1U+bC+tbhQA8QVhNCAH2D1i51c5bIC3o+VJmYl1wL2L
         sBUTb3XUzwGXdJzRdASrdDqrMn5pyai81GlR6yVrhxzkb5AAfXbcBc6+t9SlyFmYy9li
         mrbWq6Kmqs8wGRYEacXatF2MLn8YyGREwvV1gh+y7OO9bboNpK60Vm+sXLXoJioc810Q
         JsPI6pO8/IhJPkilRo8pMZw0HGBkQpNwKY0Yujm//AiRNoZghqXmiEwDkLOx7R1RGUn7
         wwyw==
X-Gm-Message-State: AO0yUKWhyw56s21GqkzSiMtGybWuUG3F2/Fy5elPAq6JX3Wp/ZALgJ44
        CYgiu3CrzF1q2w7JqOCxbsMBQDO2Tx116hxGWsA=
X-Google-Smtp-Source: AK7set9jCFCbzixjxg3foZvG/6Px0RvGfBhGiLNRLZwuKiJxudx2M4GGuWW3Pl137GpFQmwmwJfYFfSxylsAWBawoh0=
X-Received: by 2002:ac2:539a:0:b0:4d5:ca32:7bbb with SMTP id
 g26-20020ac2539a000000b004d5ca327bbbmr3113545lfh.2.1677771344307; Thu, 02 Mar
 2023 07:35:44 -0800 (PST)
MIME-Version: 1.0
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
 <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com> <887967c1f3fd6f03cf1d0bb3c19ed16819541092.1658391391.git.gitgitgadget@gmail.com>
 <xmqq35eul95b.fsf@gitster.g> <ZABNceY3cSWNb75u@F407C5W6RY.office.atlassian.com>
In-Reply-To: <ZABNceY3cSWNb75u@F407C5W6RY.office.atlassian.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 2 Mar 2023 07:35:30 -0800
Message-ID: <CABPp-BEJmnAB4QX_HMnNaZ9vEh_mKiqka_uZRm_E_LNuOBiFsg@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] merge: ensure we can actually restore pre-merge state
To:     Ben Humphreys <behumphreys@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Wed, Mar 1, 2023 at 11:17=E2=80=AFPM Ben Humphreys <behumphreys@atlassia=
n.com> wrote:
>
> Hi Junio / Elijah,
>
> On Thu, Jul 21, 2022 at 09:31:44AM -0700, Junio C Hamano wrote:
> > "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > diff --git a/builtin/merge.c b/builtin/merge.c
> > > index f807bf335bd..11bb4bab0a1 100644
> > > --- a/builtin/merge.c
> > > +++ b/builtin/merge.c
> > > @@ -1686,12 +1686,12 @@ int cmd_merge(int argc, const char **argv, co=
nst char *prefix)
> > >      * tree in the index -- this means that the index must be in
> > >      * sync with the head commit.  The strategies are responsible
> > >      * to ensure this.
> > > +    *
> > > +    * Stash away the local changes so that we can try more than one
> > > +    * and/or recover from merge strategies bailing while leaving the
> > > +    * index and working tree polluted.
> > >      */
> >
> > Makes sense.  We may want to special-case strategies that are known
> > not to have the buggy "leave contaminated tree when bailing out"
> > behaviour to avoid waste.  I expect that more than 99.99% of the
> > time people are feeding a single other commit to ort or recursive,
> > and if these are known to be safe, a lot will be saved by not saving
> > "just in case".  But that can be left for later, after the series
> > solidifies.
>
> This may stretch your memory a bit since the above was many months ago,
> but I'm wondering if you know of any effort since to build the above
> described optimisations?
>
> We've seen when Git 2.38.0 (which introduced this change) is used with
> Bitbucket Server it results in a severe performance regression due to an
> sharp increase in disk and CPU load. Our code that tests the mergeability
> of a pull request is one such affected codepath.
>
> If there isn't any existing efforts to build the optimisations you
> mention above I will have a shot at it.

I've got bad news for you and great news for you.

The bad news: there have not yet been any efforts to build these
optimizations mentioned above.

The great news: the fact that this affects you means you are using
non-bare clones in your mergeability checks, and being forced with
every merge to first checkout the appropriate branch, and pay for the
penalty of updating both the index and the working tree both in that
checkout and during the merge (and perhaps in doing a hard reset
afterwards) in your mergeability check, despite the fact that a
mergeability check really only needs a boolean: "does it merge
cleanly?".  Doing a full worktree-tied merge like this is really
expensive, and while the above Git changes may have made it even more
expensive for you, the real savings comes from switching to a bare
clone and not writing any working tree files or the index.  That's
available via running `git merge-tree`; see the documentation for the
--write-tree option in particular.  GitHub switched over to it last
year and GitLab should be switching soon (or may have already
completed it; I haven't checked in a bit).

You are, of course, more than welcome to build the optimizations Junio
alludes to.  It'd help out various end users.  But for improving
server side operations, I think switching to `git merge-tree` would
provide you _much_ bigger benefits.


Hope that helps,
Elijah
