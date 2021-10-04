Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAFDC433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CB56121F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbhJDN44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238333AbhJDN4l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 09:56:41 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C863C0619C1
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 06:46:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n2so11115286plk.12
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ghYlWORcIedKPVVvLx4sp49uLX2dH7jtY43pT1xEr3U=;
        b=D9iC7Id966YNAYh22hxpmu3uL03NDBjoR9zllTQPdheRknJYCzICKpIOrs6YnpW5XY
         oqY7G3GFTlTR98jxadDSh1tovgd8V1lNkCkuuydAng4KT+H0XQNCOG8GBx9I10vZDGXP
         xLQX7Ws0jJ8qG4AjkncfztncE8rzhHBBszDoBIfzxdttmU0SeWgUYW+8jgjvWgMOnT3Y
         7rGDcRschvvUHONGKdBZGx8Rl6MKE3C2cZjUcZl4YQXEfi652n1NXeeyAgUC0AndXGtN
         uJkc88t9q1PEKnv9BxA8FiJeM5tsLrKcCoPvfyAw1RgNNvUHpj3Ah4wbY19MaLn20SpG
         cZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ghYlWORcIedKPVVvLx4sp49uLX2dH7jtY43pT1xEr3U=;
        b=2n0RuguRy5+ErAnkLdRsWFrSTFVD3riNRF7MN5ctckO1T0d+aIPsZa7e9froaAu4jv
         DuZiSKfZJGax+sRYgpzfw2NIqt8v2Gnyl58UvNA3Dsqtrv9sVd6EinsFDw1CMsvyPhuK
         v7SSmtWQQugHnD/2yDJtYD1tb53QFxlscCzwhn7JjSRCKDAii6FHhTqcIdaDSbtcuGDR
         Y1qEgKYas91hSfh9NTWhK9QlSsPvVySXDqI/gaaBAMR8aRUH/3LBe+VVQIbHfa9nF3ZH
         mgnJzDxhGrP/UvAMiMmQJt9kgByid0cA2aeSeV/8GN6JwI1m1b/I4yePAIsX3g4bu3Mm
         bjZw==
X-Gm-Message-State: AOAM531YwRjCbzM5CUSMe3sdSe1BkykwAGiUoxUf8kWigRMhgaYPoD/6
        /TtTUUAcfbkH3IdTrJ1zsy85sQpbEDgQjagQ8zw9UIJH1UA=
X-Google-Smtp-Source: ABdhPJy92CYKDMQ1QPK3kmFmpTbt06HMhFJFOepA4aSyl7zsWcAsN6NR6XKkLHGkJ8XNgufzecqmemnpBqrmIKC53SE=
X-Received: by 2002:a17:902:9687:b0:13d:b848:479d with SMTP id
 n7-20020a170902968700b0013db848479dmr24516397plp.59.1633355195548; Mon, 04
 Oct 2021 06:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
 <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <f1a0700e598e52d6cdb507fe8a09c4fa9291c982.1632760428.git.gitgitgadget@gmail.com>
 <87ilyjviiy.fsf@evledraar.gmail.com> <CABPp-BEnGfxqKpqXGKopXFBBshY0tuimQLtwt58wKf9CJS8n5g@mail.gmail.com>
 <87ee97utaq.fsf@evledraar.gmail.com> <CABPp-BEEWPF6oBN69PH_GtmqqvAj1HMtDX5ipQxa2bLzyCCu0g@mail.gmail.com>
 <87lf3etaih.fsf@evledraar.gmail.com> <CABPp-BGi03JunRaMF_8SJKC00byOnq1kL3JyYhKWatz8-B4RsA@mail.gmail.com>
 <87k0ixrv23.fsf@evledraar.gmail.com> <CABPp-BE_aY4smj_b0+Zz=YrURKMniS=DmyMWVc=q2mVDL8zUOg@mail.gmail.com>
 <87k0ivpzfx.fsf@evledraar.gmail.com> <87sfxhohsj.fsf@evledraar.gmail.com>
In-Reply-To: <87sfxhohsj.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Oct 2021 06:45:00 -0700
Message-ID: <CABPp-BFSFN3WM6q7KzkD5mhrwsz--St_-ej5LbaY8Yr2sZzj=w@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] unpack-trees: introduce preserve_ignored to unpack_trees_options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 3, 2021 at 3:38 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Sat, Oct 02 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> > On Fri, Oct 01 2021, Elijah Newren wrote:
> >
> >> On Fri, Oct 1, 2021 at 1:47 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
> >>>
> >>> On Thu, Sep 30 2021, Elijah Newren wrote:
> >>>
> >>> > On Thu, Sep 30, 2021 at 7:15 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
> >>> > <avarab@gmail.com> wrote:
> >>> >>
> >>> >> On Wed, Sep 29 2021, Elijah Newren wrote:
> [...]
> >>> > I might be going on a tangent here, but looking at that patch, I'm
> >>> > worried that dir_init() was buggy and that you perpetuated that bug
> >>> > with DIR_INIT.  Note that dir_struct has a struct strbuf basebuf
> >>> > member, which neither dir_init() or DIR_INIT initialize properly
> >>> > (using either strbuf_init() or STRBUF_INIT).  As far as I can tell,
> >>> > dir.c relies on either strbuf_add() calls to just happen to work wi=
th
> >>> > this incorrectly initialized strbuf, or else use the strbuf_init()
> >>> > call in prep_exclude() to do so, using the following snippet:
> >>> >
> >>> >     if (!dir->basebuf.buf)
> >>> >         strbuf_init(&dir->basebuf, PATH_MAX);
> >>> >
> >>> > However, earlier in that same function we see
> >>> >
> >>> >     if (stk->baselen <=3D baselen &&
> >>> >         !strncmp(dir->basebuf.buf, base, stk->baselen))
> >>> >             break;
> >>> >
> >>> > So either that function can never have dir->basebuf.buf be NULL and
> >>> > the strbuf_init() is dead code, or else it's possible for us to
> >>> > trigger a segfault.  If it's the former, it may just be a ticking t=
ime
> >>> > bomb that will transform into the latter with some other change,
> >>> > because it's not at all obvious to me how dir->basebuf gets
> >>> > initialized appropriately to avoid that strncmp call.  Perhaps ther=
e
> >>> > is some invariant where exclude_stack is only set up by previous ca=
lls
> >>> > to prep_exclude() and those won't set up exclude_stack until first
> >>> > initializing basebuf.  But that really at least deserves a comment
> >>> > about how we're abusing basebuf, and would probably be cleaner if w=
e
> >>> > initialized basebuf to STRBUF_INIT.
> >>>
> >>> ...because yes, I forgot about that when sending you the diff-on-top,
> >>> sorry. Yes that's buggy with the diff-on-top I sent you.
> >>
> >> That bug didn't come from the diff-on-top you sent me, it came from
> >> the commit already merged to master -- ce93a4c6127  (dir.[ch]: replace
> >> dir_init() with DIR_INIT, 2021-07-01), merged as part of
> >> ab/struct-init on Jul 16.
> >
> > Ah, I misunderstood you there. I'll look at that / fix it. Sorry.
>
> Just to tie up this loose end: Yes this control flow suck, and I've got
> some patches to unpack-trees.[ch] & dir.[ch] I'm about to submit to fix
> it. But just to comment on the existing behavior of the code, i.e. your
> (above):
>
>     "So either that function can never have dir->basebuf.buf be NULL and
>     the strbuf_init() is dead code, or else it's possible for us to
>     trigger a segfault.".
>
> I hadn't had time to look into it when I said I'd fix it, but now that I
> have I found thath there's nothing to fix, and this code wasn't buggy
> either before or after my ce93a4c6127 (dir.[ch]: replace dir_init() with
> DIR_INIT, 2021-07-01). I.e. we do have the invariant you mentioned.
>
> The dir.[ch] API has always relied on the "struct dir_struct" being
> zero'd out. First with memset() before your eceba532141 (dir: fix
> problematic API to avoid memory leaks, 2020-08-18), and after my
> ce93a4c6127 with the DIR_INIT, which both amount to the same thing.
>
> We both missed a caller that used neither dir_init() nor uses DIR_INIT
> now, but it uses "{ 0 }", so it's always zero'd.
>
> Now, of course it being zero'd *would* segfault if you feed
> "dir->basebuf.buf" to strncmp() as you note above, but that code isn't
> reachable. The structure of that function is (pseudocode):
>
> void prep_exclude(...)
> {
>         struct exclude_stack *stk =3D NULL;
>         [...]
>
>         while ((stk =3D dir->exclude_stack) !=3D NULL)
>                 /* the strncmp() against "dir->basebuf.buf" is here */
>
>         /* maybe we'll early return here */
>
>         if (!dir->basebuf.buf)
>                 strbuf_init(&dir->basebuf, PATH_MAX);
>
>         /*
>          * Code that sets dir->exclude_stack to non-NULL for the first
>          * time follows...
>          */
> }
>
> I.e. dir->exclude_stack is *only* referenced in this function and
> dir_clear() (where we also check it for NULL first).
>
> It's state management between calls to prep_exclude(). So that that
> initial while-loop can only be entered the the >1th time prep_exclude()
> is called.
>
> We'll then either have reached that strbuf_init() already, or if we took
> an early return before the strbuf_init() we couldn't have set
> dir->exclude_stack either. So that "dir->basebuf.buf" dereference is
> safe in either case.

Thanks for digging into this.  I wonder if dir_struct could use some
separation of putting things inside an embedded internal struct as
well, similar to our discussions with unpack_trees_options.
