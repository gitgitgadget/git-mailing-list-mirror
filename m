Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16203C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 16:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDBAD6124C
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 16:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhKKQWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 11:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhKKQWm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 11:22:42 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8853FC061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 08:19:53 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f4so26195734edx.12
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 08:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q+06t2ijJP5QiJXU9LrRlkpRUy9ML7nM/tb9pTU7K2k=;
        b=hUmVm0GwPksmDjvjCJsRS/tqPnrump1PCPMsUHHlTXtsI5fCHxU6xUI41mLW5qDgmC
         4Hg5uy+GqUPEx9R8LFCEOE5bCeFio+qMFhEsoBD1cM1Kn65kbFbqDeGCg/QrfBwoUigL
         ykf2cgo+DELQ30qeJB9nEFgBH1nfwhmxqSlcCNY1psmQJtuP2duWhH4bhGFYsmmIFbNV
         OiF7c2+q+VA4BzoSa146JTbxweNEkvJ1wPwk6Mie+QXwPc9r2J0y9mqyXfkQ3PCflr7X
         b6rpsH9rTHtWgEtYfIRSf4X2zELZP1gSDQq46lBPb02hgPy9TXMXpYtncI3ysn6zsV81
         EZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q+06t2ijJP5QiJXU9LrRlkpRUy9ML7nM/tb9pTU7K2k=;
        b=x7BHjlFmUyeO4wEMaKKV4bCSuMSuVEaRz3HTp3p3vv3scOME6CAzGyla5xPDBNqD4O
         4GRGV+pQ/dHnAD4KXN/ZUzjA5UK+sEYJAq99h1tVO3FcrOWmVaF1XBVSalS9OsTurFpB
         +ZMLijrudKaozIJbvYbC7Zvx8ebHVk5omKXFXlksHqvtp4lN9p65vGM3RHNYGWpoefSK
         6vB6NSh/gI4h6Ij+6APVoiIGFKVfuQ6SR//d+fmj4P1YjoQRtIXo2SlXfqyvsdZY1Vnb
         lQAFpg9UtvDbfqURGdxukLPDmKGulReJCdQcv6GBGMcgtZ5/kHgdZlkfNQtNuHbkztYR
         DzxQ==
X-Gm-Message-State: AOAM532825IQXrWcbBNvz6cIR6zGcRWJ0ccgStb80gDycBJz+lThTnSB
        f2njouaoKo1DeuCWMo3nTv1GEXZgMRa3KfHx2o1F7vDb
X-Google-Smtp-Source: ABdhPJyg3/HN/ff0giKWSNmgeQinw2dDYjOwwHM+0aFvLitVccX6MC/zNHEGDTD4qGEWXHaqd3APpiz46/F96Um/bdY=
X-Received: by 2002:a05:6402:361:: with SMTP id s1mr3303802edw.56.1636647591880;
 Thu, 11 Nov 2021 08:19:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
 <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com> <7214fa73fdd13418744903f6c769fdb77c9512ce.1609272328.git.gitgitgadget@gmail.com>
 <CAPNYHkm5Qp8HQGU5_6DXc7xpCrdGgEin0WYAxbRNOkKW0j2ERQ@mail.gmail.com>
 <CABPp-BFqZj4qYXbPGLyX=4RM4OdLNL=VbYyhbLakU-RrvU+wfw@mail.gmail.com> <CAPNYHkn5aHW1e_G5BKcaHWnrTSR+=VKOnKPdDPLJ5bH9DedKTA@mail.gmail.com>
In-Reply-To: <CAPNYHkn5aHW1e_G5BKcaHWnrTSR+=VKOnKPdDPLJ5bH9DedKTA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 11 Nov 2021 08:19:40 -0800
Message-ID: <CABPp-BEGH7reoVXx4TkJKkv7fr=BVOPCTuMBFbEGGDp5nS3bVg@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] diffcore-rename: simplify limit check
To:     =?UTF-8?B?QmHFn2FyIFXEn3Vy?= <basarugur@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 11, 2021 at 1:03 AM Ba=C5=9Far U=C4=9Fur <basarugur@gmail.com> =
wrote:
>
> On Wed, Nov 10, 2021 at 9:06 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Tue, Nov 9, 2021 at 1:15 PM Ba=C5=9Far U=C4=9Fur <basarugur@gmail.co=
m> wrote:
> > >
> > > Hi all,
> > >
> > > First post on Git mailing list, to provide a comment on a patch. Hope
> > > this works.
> > >
> > > In cases where the `rename_limit` is already greater than 65535, the
> > > `st_mult(rename_limit, rename_limit)` multiplication overflows and
> > > process halts.
> >
> > Out of curiosity, what system are you on?  And how many renames do you
> > actually have?
>
> I am on a 64-bit Windows 10; but following up on your question, it
> became obvious that these limits have something to do with 'which git
> executable' I was dealing with. This problem surfaced when I was
> working on Visual Studio 2019, and was trying to rename not more than
> 10 files. My config had 999999 as the renameLimit, and VS2019 showed
> the 'fatal error' in its git output. However, git bash was all fine
> with listing the renamed files. And the difference between these
> scenarios turned out to be, yes, different git executables. VS2019 has
> its own copy of git which is 32-bit, and it hits this 999999 * 999999
> overflow; whereas *my* copy of git used in bash is 64-bit which does
> not have that overflow problem.

Ah, thanks for the extra info.

> >
> > We used to clamp to 32767, but one specific repository needed values
> > larger than that, in the range of ~50000.  However, due to a number of
> > rename detection related optimizations added since then, the git of
> > today can handle that same particular repository and support full
> > rename detection with a rename limit under 1000 for merge/cherry-pick
> > (sorry, forgot the exact numbers), and probably less than 10000 for
> > diff (just guestimating; I don't want to go and check).
> >
> > Anyway, all that aside, I don't see any such overflow for rename_limit
> > being 2**16; we can push it much farther:
> >
> >     size_t a =3D 4294967295;   /*  2**32 -1  */
> >     size_t b =3D a;
> >     size_t c =3D st_mult(a, b);
> >     printf("%"PRIuMAX" =3D %"PRIuMAX" * %"PRIuMAX"\n", c, a, b);
> >
> > Output:
> >
> >     18446744065119617025 =3D 4294967295 * 4294967295
> >
> > Adding one to the value of a results in:
> >
> >     fatal: size_t overflow: 4294967296 * 4294967296
> >
> > > But I don't think an 'overflow error' is very helpful
> > > for the users in understanding what is wrong with their configuration=
;
> > > i.e. `diff.renameLimit` documentation says nothing about a 'maximum
> > > allowed value'. I would either clamp it to a reasonable range, or
> > > inform the users about the limits, or maybe both.
> >
> > That sounds reasonable, but I'm not sure it's worth the effort in
> > practice.  2**32 - 1 is so impractically large for a rename_limit that
> > I don't see why anyone would need a value even remotely close to that
> > level (and I wouldn't at all be surprised if other things in git
> > scaling broke before we even got to that point).
> >
> > Perhaps you're dealing with a 32-bit system?  Even then, the
> > repository that hit this was about 6.5GB packed .git history; and you
> > might need to be a lot larger than that given the optimization since
> > then in order to hit this.  Can 32-bit systems even handle that size
> > of repository without dying in several other ways?
>
> Good point, but the system aside, 2**16 - 1 =3D 65535 would remain to be
> the limit for the 32-bit git executables, wherever they are used.
> Therefore, maybe there is a point to curb it, or mention this
> somewhere, as I have said before.

Fair enough.  If someone wants to contribute a patch to either provide
a nicer error message if the value is set too high, or to clamp it
with a warning, and in either case to make sure the too-large check is
specific to 32-bit systems (or uses appropriately different limits on
32-bit and 64-bit systems), then that would be a welcome contribution.
