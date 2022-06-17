Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06188C43334
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 02:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbiFQCPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 22:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiFQCPe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 22:15:34 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C7A64BFA
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 19:15:33 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id bo5so3001065pfb.4
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 19:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Li0nnFoHCPYJmDvL4gZ/jHLis9QPFhhvz/R7zmPX7lA=;
        b=X5ZIWzxgNceyNGloPP8oDYkQCAaYKkYFR+nIt6C8I7Onf9+qW+6YpNa6zTuxZ+fF3x
         szbE1OPot1EgGIKCQLyw5Kcb7PBMDrMzj5fgKC/473i7Dxyo6dpzNL7pEGW1AtZP90ej
         qZvMSjBL+8ZpP9qUm8YOCfMHagt9YUBlXPhGzDY5ZOjDVguk//NekdIztQQHaP+I35m/
         8Ih1EkqVbGV72OOrTtg7Fr5yXhfA/z7LdGRfjFj0ztHdj785gsHDXnOLwuGpLP75vYQH
         SbWLEtjFV9l+BhumC4qj9iCFu4LZ4uYYYudfEKmlwPLAijJ5m+20EG7T91hQUjuFiogD
         LSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Li0nnFoHCPYJmDvL4gZ/jHLis9QPFhhvz/R7zmPX7lA=;
        b=1CDVUdw9ekQ3jJ5/SyY/V4QUEY+LzYfH0tC6BULyiLNVsIAdyXGBZIQD8kOYioDrdW
         vf97ZMR4Z9rcyasKwHyMQLiYOjfj3JOSpyOqXIsLYemva2c7JR1eHt46QnCZV7FRT2Mh
         eUX3y2HzFFmvFfXfB+hfSK8S8q386yLA5JCh+LJ0Vg0NASg4e+pFlqruUVan5mk1pxtM
         X9WEfbMu3HJTP8ljDUTNRoYonKwDB8n2Z+vQ6EYloGFUZRuuqQx+AIKtLOulYG4Dzy/Y
         kYe8wqXqIavTRRSM3Y6kfk1M+pJ87fAN38uHmMENbeOkbadIbLwM8yhKCM4JXCNARvJr
         tlEQ==
X-Gm-Message-State: AJIora+zwPAWzFtFbpTKnuCfxvp7Ul2pVl3cDSwnzuxhah+HQCHR9DLc
        RpLPDn4BTkUnvvts3APG8XpkcqVkZeAi3mUoPH4=
X-Google-Smtp-Source: AGRyM1vnPvM02iMAzduIHegr8zb5bk6ZtUBOOMO/P5CcTIk2oGGVV/7PXo8fRjxSIW8p0pmBf68p7qkmvG0nvByXyFI=
X-Received: by 2002:a05:6a00:b42:b0:51c:79bd:4226 with SMTP id
 p2-20020a056a000b4200b0051c79bd4226mr7878007pfo.70.1655432132778; Thu, 16 Jun
 2022 19:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com> <20220527100804.209890-6-shaoxuan.yuan02@gmail.com>
 <077a0579-903e-32ad-029c-48572d471c84@github.com> <xmqq8rqm3fxa.fsf@gitster.g>
 <d0ac1bea-6d98-140c-0e46-d7569e80b29d@github.com> <CAJyCBOQGAL9aGW+Gxv8sZH9T_tB6_pdeLNwmNgqPhz7cMdZrbA@mail.gmail.com>
 <6375c172-82cb-dffc-875f-e5e742d5e49e@github.com>
In-Reply-To: <6375c172-82cb-dffc-875f-e5e742d5e49e@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Fri, 17 Jun 2022 10:15:20 +0800
Message-ID: <CAJyCBOS3AKPT43ERsfLetSHRP_tciNvok-MSg5d=buStKPMxYA@mail.gmail.com>
Subject: Re: [WIP v2 5/5] mv: use update_sparsity() after touching sparse contents
To:     Victoria Dye <vdye@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        derrickstolee@github.com, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 17, 2022 at 12:42 AM Victoria Dye <vdye@github.com> wrote:
*Truncated messages*
> > For me, the alternative provides a less frustrating experience.
> >
> > Since it is more explicit (giving a message and directly saying NO).
> >> Also, the `sparse-checkout` users should expect the moved file to be
> > missing in the working tree, as opposed to being present.
> >
>
> Good point, since the sparseness of the destination file would be different
> depending on whether it had local modifications or not (with no indication
> from 'mv' of the different treatment).
>
> If you're interested, maybe there's a middle-ground option? Suppose you want
> to move a file 'file1' to an out-of-cone location:
>
> 1. If 'file1' is clean, regardless of use of '--force', move the file & make
>    it sparse.
> 2. If 'file1' is *not* clean and '--force' is *not* used, refuse to move the
>    file (with a "Path 'file1' not uptodate; will not move. Use '--force' to
>    override." type of error).
> 3. If 'file1' is *not* clean and '--force' is used, move the file but do not
>    make it sparse.
>
> That way, '--force' really does force the move to happen, but users are
> generally warned against it. I'm still not sure what the "right" approach
> is, but to your point I think it should err on the side of not surprising
> the user.

I generally think this middle-ground option is good. Though I think the sort
of options that "messing with sparse contents" should be handled by
'--sparse', instead
of '--force', since the latter is used to "force move/rename even if
target exists".
Mixing the usage may cause syntax confusion?

> > And the tweaked rule suggested by Junio [1] might need an extra
> >  `git sparse-checkout reapply` to re-sparsify the file that moved out-of-cone
> > after staging its change?
> >
>
> Just so I understand correctly, do you mean 'git sparse-checkout reapply'
> *as part of* the 'mv' operation? Or are you thinking that a user might want
> to manually run 'git sparse-checkout reapply' after running 'mv'?
>
> If it's the former (internally calling 'git sparse-checkout reapply' in
> 'mv'), then no, you wouldn't want to do that. In Junio's suggestion, he said
> (emphasis mine):
>
> > When a dirty path is moved out of cone, we would trigger the
> > "SKIP_WORKTREE automatically disabled" behaviour" *and that would be a
> > good thing, I imagine?*
>
> We don't want the file moved out-of-cone to be sparse again because it has
> local (on-disk) modifications that would disappear (since a file needs to be
> removed from disk to be "sparse" in the eyes of 'sparse-checkout'). It's
> *completely valid* behavior to have an out-of-cone file become non-sparse if
> a user does something to cause that; it doesn't cause any bugs/corruption
> with the repo. And, even if you did want to make the file sparse, it should
> be done by manually setting 'SKIP_WORKTREE' and individually removing the
> file from disk (for all the reasons I mentioned in my upthread comment [1]).
>
> On the other hand, if you're talking about a user manually running 'git
> sparse-checkout reapply' after the fact, that wouldn't work either - they'd
> get an error:
> warning: The following paths are not up to date and were left despite sparse patterns:
>         <out-of-cone modified file>

This is what I meant, a user manually running `git sparse-checkout reapply`.
Though I did say users should only do this "after staging its change".

I propose this solution which sounds good to me:

1. If 'file1' is clean, iff with the use of '--sparse', move the file & make
    it sparse.
2. If 'file1' is dirty, iff with the use of '--sparse', move the file
& *do not* make
    it sparse, instead advise something like
    "file1 is not up to date, keep it non-sparse.
    Stage file1 then run `git sparse-checkout reapply` to re-sparsify it."

> [1] https://lore.kernel.org/git/077a0579-903e-32ad-029c-48572d471c84@github.com/
>
> > [1] https://lore.kernel.org/git/xmqq8rqm3fxa.fsf@gitster.g/
> >
-- 
Thanks & Regards,
Shaoxuan
