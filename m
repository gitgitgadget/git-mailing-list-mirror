Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9DFC433F5
	for <git@archiver.kernel.org>; Sun,  8 May 2022 14:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbiEHOsq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 May 2022 10:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiEHOsp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 May 2022 10:48:45 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2A6E0E9
        for <git@vger.kernel.org>; Sun,  8 May 2022 07:44:55 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r27so12853160iot.1
        for <git@vger.kernel.org>; Sun, 08 May 2022 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IFmbCFu1M4ifFN+l1tmZuJ2EICN713b2oYD5Qf0GHBU=;
        b=bOBd30N8ahkobMf01W9fn+ppBMPFVIuLTlfCUZ+JnqwB7LxhCaoHIZpMlhnFqsWhPq
         pf7DXeyOUONdbUGayYCseRLhdTwduwKkXV6QVTbkWgE45vv8XIhgqvh3hGbqhWbHSPfx
         qhU/QMGECIpC6KRTDx+oUJvNS4j4RMxLLa3Sr3WAoeyVEV9MBVLcg7mIIJMjwFJ5ECZL
         0Gmt5C/CyYHCym0PvcnlPZvFgBptvN6b2ZE0E92Kfm4mUPMSiDUWckY6wwtP3DAX1mkj
         TFvsdJKz0K67etVpL7JAE5n3YlLzvt6bGS035VuMdZrlY7DuT4B1Ab7DYv3WKB/e2Jfv
         AqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IFmbCFu1M4ifFN+l1tmZuJ2EICN713b2oYD5Qf0GHBU=;
        b=F5B82vp2Fn/cJwSAcZHT3u2fGsqNtw4qPwtqVVGxR4bNaPqNb45SOP+28vsFdCt4EF
         5A5Z+mNQxSW+cfPd36pmcoMDBy5xIm/6O1WI77b1zf3yDrCG2WTcYOnObv8ZsuKhZ3kW
         SW7FDHCGLDycTdKuPblLSZaPXaWfJBCwX5EZiHVA73uYirZKUuuknnUgXnY8y4RZCQHw
         GiFUZLyv/CwNHMVACE+HvAkxie82P7idFsBStYFMTzIH+ajl+HjRcqUGX7NLjE54FSuK
         StAGrfXrOVcU2/nUEcu2iCdeEKDcqxQ1tWHhIjb8LiWebkVyXXPwwl4YyFTL1x8fHKA0
         zS7g==
X-Gm-Message-State: AOAM533zn8irvT8i6Kpi4GexkLvMz16YbU7enl1FWPO6uoE3M/rLJeRA
        +zQP279x8H3qv4tFXgw2jwJYD4o1DOsknCQkVaTtN8I0vLvKWTc/
X-Google-Smtp-Source: ABdhPJxwqbHG650A0EqPVzlCOjBQnhMhFJwa1MON9tqn4J9nbQVv1D2mlZiWDWmBta32ZYaNmt0YgIvQv0URqFzYaHA=
X-Received: by 2002:a02:1904:0:b0:32b:7e1e:aafa with SMTP id
 b4-20020a021904000000b0032b7e1eaafamr5688358jab.67.1652021094519; Sun, 08 May
 2022 07:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8S8rh+VYcuaqBeNtmphiRqw7HropLFpkxfnTJq6BngGXw@mail.gmail.com>
 <CAP8UFD2p+Evqv_MBAgv23zooppsNWjOw6ZU2GLqAq_skZoJPOw@mail.gmail.com> <CABPp-BGD3AZvXwmSHfQQ_xh_UqevH23kdBYijAWUk8GHu1q0Qw@mail.gmail.com>
In-Reply-To: <CABPp-BGD3AZvXwmSHfQQ_xh_UqevH23kdBYijAWUk8GHu1q0Qw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 8 May 2022 22:44:43 +0800
Message-ID: <CAOLTT8STRfqq4bfobCK8Q5uvtXzgNYY0x0wNh4HNyAhv0Mc07A@mail.gmail.com>
Subject: Re: Question about pre-merge and git merge octopus strategy
To:     Elijah Newren <newren@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, vascomalmeida@sapo.pt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=887=E6=97=A5=
=E5=91=A8=E5=85=AD 12:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, May 6, 2022 at 10:24 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > Hi,
> >
> > On Fri, May 6, 2022 at 10:15 AM ZheNing Hu <adlternative@gmail.com> wro=
te:
> >
> > > I am thinking about if git can "pre-merge" multiple branches, which
> > > can check if merge
> > > will have conflict, but not to merge them actually, like a option `--=
intend`.
> > >
> > > I find "git merge-tree" can output merge result in stdout, which meet=
s
> > > my needs, but it can only
> > > support two branches' merge.
> >
> > Elijah (added in Cc) has been working on "git merge-tree" improvements
> > based on the new "ort" merge he developed. It supports merging 2
> > branches, but maybe there are ways to make it support more than 2.
>
> The primary issue with in-core octopus merges is that there are lots
> of questions about how to handle conflicts; possibly even more so than
> git merge-tree --write-tree brings up, and that took us months of
> discussion.  In particular, with octopii, do iterate merging one
> branch in at a time and stop with any conflicts (thus potentially
> stopping N-1 times when merging N branches), do you attempt to just
> run all N-1 merges and have conflicts that can't readily be expressed
> in the index (especially for non-textual multi-way conflicts, but even
> nested conflict markers for text files could be painful), do you
> attempt to handle the multi-way textual conflicts a new way with code
> replacing xdiff/ in order to avoid nested conflicts?  I wasn't sure
> what to do, so never implemented that in "ort".
>

I have see the code of git-merge-octopus.sh, it run merge-base,
read-tree, write-tree every loop.

Now I get you about it's hard to do multiple tree merge because it's hard t=
o
express in index.

> Of course, people could roll their own by just serially merging pairs
> of commits, and then rewriting the history to replace the string of
> merges with an octopus.  Or perhaps just use "git merge --no-commit"
> serially, though that only works if the branches touch disjoint files
> (otherwise one of the merges will complain you have changes that could
> be overwritten by the next merge).  And yes, if you don't want to mess
> with the working tree/index, you could serially use the "git
> merge-tree --write-tree" once I finish it, but it's not ready yet.
> (Sorry about that; I've got a bunch of nearly complete changes from a
> while ago but just didn't have much Git time.  I'll try to get to it
> soon.)
>

I'll be looking forward to this feature!

> However, I think Junio said that octopus merge only handles trivial
> cases anyway, in which case an iterated "git merge --write-tree" would
> actually be a sufficient solution here and we could sidestep the more
> convoluted cases.  But, sadly for ZheNing, that option doesn't exist
> yet -- It's still under development.
>
> > > So I find git merge with more than two branches can use octopus strat=
egy.
> > > What about git merge --no-commit? Which will not commit automatically=
,
> > > so we can check if they have
> > > confilct, and abort merge.
> >
> > Yeah, I think that's what you want.
> >
> > > I think it's not useful for git merge-octopus, because if we meet a
> > > merge conflict, we can't find
> > > MERGE_HEAD at all! How can we abort this conflict merge?
>
> MERGE_HEAD doesn't have anything to do with aborting the conflict
> resolution step.  When you need to abort, the thing you want to go
> back to is HEAD (which represents the commit you had checked out and
> were merging the other stuff into), not MERGE_HEAD (which represents
> the branch or branches you were merging into HEAD).
>

Thanks for clarifying. As I reply to Christian, when I just use "git
merge A B C" happily,
and there is a conflict, so I try "git merge --abort" as usual, but it
can not work... git tell me:

fatal: There is no merge to abort (MERGE_HEAD missing).

> > I don't know octopus merges much, but I think you should be able to
> > abort using "git reset" (maybe with "--hard").  If the merge was
> > performed using --no-commit or if there was a conflict, then I think
> > it should be expected that there is no MERGE_HEAD as no commit would
> > be created so MERGE_HEAD would have nothing to point to.
>
> MERGE_HEAD isn't something created during a merge, it's something that
> existed before it -- namely, the tip of the other branch we are
> merging.  For an octopus merge, you'd thus expect it to have N commits
> rather than just 1.
>
> AUTO_MERGE, new to ort, is something that is created during a merge
> and when the merge interrupts due to conflicts to ask the user to
> resolve the conflicts, AUTO_MERGE represents the tree checked out in
> the working copy (thus it is a tree that likely has files with
> conflict markers in them).

I think this AUTO_MERGE maybe a good thing for checking merge conflicts,
maybe it will help git merge-octopus.

Thanks.
