Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F135C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 18:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiK1S5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 13:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiK1S5J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 13:57:09 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B1E20189
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 10:57:08 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id t185so3068374vkb.7
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 10:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykpdHFTDEzueV4i7hk2JFyLn1iB7oQW6d1NWqTWKTk8=;
        b=ggSsJUIjjNCelQjycRJBMQyZku32cYnu8RVEehfryqH4CVtYwloQ2pqvmhFsO5q3Qd
         wA8zun+/lJwPO8H9IHDwMMy4N+Ndp9efH0w5u6uQF5YeO5rD8ILXDQJWTnWPq/O+H9a6
         yBJ6Wiy1ccjsrPUth3/kW3y8y5YX2MD4I6Vx2TX8hO4ndlvOh2QYoWmIkcs/IuSyE6gl
         nMvz24yAtcNCe/LdMjAgwELzEN8iViMzDdS8Wme6n0XRBBJbQJqcg+c/bLUpGdN2f23m
         /T42WBYUB4N7JlCVuMMrmlv2fDIRHlou2th8uFyPhfbG65AfTTLqIWUN+hBFfIyxN3L/
         I0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykpdHFTDEzueV4i7hk2JFyLn1iB7oQW6d1NWqTWKTk8=;
        b=5LzHTzSAf8o3Px54J68fnS7eyE0TmQA23s9fVyYtMynqz5cgDfk3f7na962xBnVPhI
         G/X9059rYq1f8e/lOST3Kx5uKeUfjLM6SfePCw473hy4t1Gs6AXXtG5Q1bcC8D+0wlE+
         VQBhEDVNdWlavQM66eSnEGkE2NLTvTSLD7Gad4KZ0XL/wDKigQHOhsyZVIo7oxwDttHf
         5HMCZ8818QZA+HdEelhnJdgCmIzV5M+kqR6sFABowVJT5RiD0NG2oybpWLkISmszJrrc
         g3n8zamxm5hjlnyLWsY1McbKu5DcC9Nh71jR7F/LtnIHXQKZ/md6JTrKJ9CpQ8gDAECV
         eu8A==
X-Gm-Message-State: ANoB5pmNCtofLTrJwkxKNNDyiPzVLY1YZnNN4ZdBfYsInBDq/2aH8kcX
        +wu6LcyHHlh75FQYzsv9A31ZkvZmHy3micRWPUzkTQ==
X-Google-Smtp-Source: AA0mqf4+yS4fbWEMgySEbfnvNBtHxGbIXIjdm/W/nkXF5k55SEJy6oCMWLi4JE4N8Dti3B2XB8IX9LACtzQg/txyUp0=
X-Received: by 2002:a1f:6e48:0:b0:3b6:87b6:b8d4 with SMTP id
 j69-20020a1f6e48000000b003b687b6b8d4mr21550238vkc.12.1669661827516; Mon, 28
 Nov 2022 10:57:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 28 Nov 2022 19:56:55 +0100
Message-ID: <CAFQ2z_MZd150kQNTcxaDRVvALpZcCUbRj_81pt-VBY8DRaoRNw@mail.gmail.com>
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2 file format
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 7, 2022 at 7:36 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
>
> Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I became interested in our packed-ref format based on the asymmetry betwe=
en
> ref updates and ref deletions: if we delete a packed ref, then the
> packed-refs file needs to be rewritten. Compared to writing a loose ref,
> this is an O(N) cost instead of O(1).
>
> In this way, I set out with some goals:
>
>  * (Primary) Make packed ref deletions be nearly as fast as loose ref
>    updates.
>  * (Secondary) Allow using a packed ref format for all refs, dropping loo=
se
>    refs and creating a clear way to snapshot all refs at a given point in
>    time.
>
> I also had one major non-goal to keep things focused:
>
>  * (Non-goal) Update the reflog format.
>
> After carefully considering several options, it seemed that there are two
> solutions that can solve this effectively:
>
>  1. Wait for reftable to be integrated into Git.
>  2. Update the packed-refs backend to have a stacked version.
>
> The reftable work seems currently dormant. The format is pretty complicat=
ed
> and I have a difficult time seeing a way forward for it to be fully
> integrated into Git.

The format is somewhat complicated, and I think it would have been
possible to design a block-oriented sorted-table approach that is
simpler, but the JGit implementation has set it in stone. But, to put
this in perspective, the amount of work for getting the format to
read/write correctly has been completely dwarfed by the effort needed
to make the refs API in git represent a true abstraction boundary.
Also, if you're introducing a new format, one might as well try to
optimize it a bit.

Here are some of the hard problems that I encountered

* Worktrees and the main repository have a separate view of the ref
namespace. This is not explicit in the ref backend API, and there is a
technical limitation that the packed-refs file cannot be in a
worktree. This means that worktrees will always continue to use
loose-ref storage if you only extend the packed-refs backend.

* Symrefs are refs too, but for some reason the packed-refs file
doesn't support them. Does packed-refs v2 support symrefs too?  If you
want to snapshot the state of refs, do you want to snapshot the value
of HEAD too?

* By not changing reflogs, you are making things simpler. (if a
transaction updates the branch that HEAD points to, the reflog for
HEAD has to be updated too. Because reftable updates the reflog
transactionally, this was some extra work)
Then again, I feel the current way that reflogs work are a bit messy,
because directory/file conflicts force reflogs to be deleted at times
that don't make sense from a user-perspective.

* There are a lot of commands that store SHA1s in files under .git/,
and access them as if they are a ref (for example: rebase-apply/ ,
CHERRY_PICK_HEAD etc.).

> In this RFC, I propose a different model that allows for more customizati=
on
> and incremental updates. The extensions.refFormat config key is multi-val=
ued
> and defaults to the list of files and packed. In the context of this RFC,
> the intention is to be able to add packed-v2 so the list of all three val=
ues
> would allow Git to write and read either file format version (v1 or v2). =
In
> the larger scheme, the extension could allow restricting to only loose re=
fs
> (just files) or only packed-refs (just packed) or even later when reftabl=
e
> is complete, files and reftable could mean that loose refs are the primar=
y
> ref storage, but the reftable format serves as a drop-in replacement for =
the
> packed-refs file. Not all combinations need to be understood by Git, but

I'm not sure how feasible this is. reftable also holds reflog data. A
setting {files,reftable} would either not work, or necessitate hairy
merging of data to get the reflogs working correctly.

> In order to optimize the write speed of the packed-refs v2 file format, w=
e
> want to write immediately to the file as we stream existing refs from the
> current refs. The current chunk-format API requires computing the chunk
> lengths in advance, which can slow down the write and take more memory th=
an

yes, this sounds sensible. reftable has the secondary indexes trailing the =
data.

> Between using raw OIDs and storing the depth-2 prefixes only once, this
> format compresses the file to ~60% of its v1 size. (The format allows not
> writing the prefix chunks, and the prefix chunks are implemented after th=
e
> basics of the ref chunks are complete.)
>
> The write times are reduced in a similar fraction to the size difference.
> Reads are sped up somewhat, and we have the potential to do a ref count b=
y

Do you mean 'enumerate refs' ? Why would you want to count refs by prefix?

> I mentioned earlier that I had considered using reftable as a way to achi=
eve
> the stated goals. With the current state of that work, I'm not confident
> that it is the right approach here.
>
> My main worry is that the reftable is more complicated than we need for a
> typical Git repository that is based on a typical filesystem. This makes
> testing the format very critical, and we seem to not be near reaching tha=
t
> approach.

I think the base code of reading and writing the reftable format is
exercised quite exhaustively tested in unit tests. You say 'seem', but
do you have anything concrete to say?

> As mentioned, the current extension plan [6] only allows reftable or file=
s
> and does not allow for a mix of both. This RFC introduces the possibility
> that both could co-exist. Using that multi-valued approach means that I'm
> able to test the v2 packed-refs file format almost as well as the v1 file
> format within this RFC. (More tests need to be added that are specific to
> this format, but I'm waiting for confirmation that this is an acceptable
> direction.) At the very least, this multi-valued approach could be used a=
s a
> way to allow using the reftable format as a drop-in replacement for the
> packed-refs file, as well as upgrading an existing repo to use reftable.

The multi-value approach creates more combinations of code of how
different pieces of code can interact, so I think it actually makes it
more error-prone.
Also,

> That might even help the integration process to allow the reftable format=
 to
> be tested at least by some subset of tests instead of waiting for a full
> test suite update.

I don't understand this comment. In the current state,
https://github.com/git/git/pull/1215 already passes 922 of the 968
test files if you set GIT_TEST_REFTABLE=3D1.

See https://github.com/git/git/pull/1215#issuecomment-1329579459 for
details. As you can see, for most test files, it's just a few
individual test cases that fail.

> I'm interested to hear from people more involved in the reftable work to =
see
> the status of that project and how it matches or differs from my
> perspective.

Overall, I found that the loose/packed ref code hard to understand and
full of arbitrary limitations (dir/file conflicts, deleting reflogs
when branches are deleted, locking across loose/packed refs etc.).
The way reftable stacks are setup (with both reflog and ref data
including symrefs in the same file) make it much easier to verify that
it behaves transactionally.

For deleting refs quickly, it seems that you only need to support
$ZEROID in packed-refs and then implement a ref database as a stack of
packed-ref files? If you're going for minimal effort and minimal
disruption wouldn't that be the place to start?

You're concerned about the reftable file format (and maybe rightly
so), but if you're changing the file format anyway and you're not
picking reftable, why not create a block-based, indexed format that
can support storing reflog entries at some point in the future too,
rather than build on (the limitations) of packed-refs? Or is
packed-refs v2 backward compatible with v1 (could an old git client
read v2 files? I think not, right?).

The reftable project has gotten into a slump because my work
responsibilities have increased over the last 1.5 year squeezing down
how much time I have for 'fun' projects. I chatted with John Cai, who
was trying to staff this project out of Gitlab resources. I don't know
where that stands, though.

> The one thing I can say is that if the reftable work had not already begu=
n,
> then this is RFC is how I would have approached a new ref format.
>
> I look forward to your feedback!

Hope this helps.


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
