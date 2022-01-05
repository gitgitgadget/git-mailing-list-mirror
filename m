Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE0BC433FE
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 16:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbiAEQyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 11:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242040AbiAEQyB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 11:54:01 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4386EC061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 08:54:01 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j6so164411265edw.12
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 08:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iBWXJUkkIMasZ4V24v3xx1t/hcOs7Je4ABaBEK7+BdE=;
        b=AVV4CHoSKE6Edv1ya/U5naak2nMD/mYClyGr4a5tgeM56UV2NcFPEZSDyukQM7ZzdK
         nenwuO16/s5Sa94B20uDurU9Fo1sUpYblkxIfXNqVDbzcvVvGm72SQpUM6j1SQMJu4xh
         qqTakzl+OGsta1Cq99/+FTYGDXq6mpZqIBTA1YeNAbL85BMmNvNFHo0+DKGnNTY+NYM5
         QkAUrCpf8At9K/+Ea8Wz7WzQBxjRZgqi+/RgNCxhup+xfxFM9cwhPa9gIFmjfbx31Z1K
         4Qt/F62c8A303VRemWR1bWUBuFs3vszFJaD7rH/r91CTHBZxPRzhmV/FIfHY1i97gdKS
         N3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iBWXJUkkIMasZ4V24v3xx1t/hcOs7Je4ABaBEK7+BdE=;
        b=Nf+P+1FufkOcED3hkl22Jdyk6USKS1wDI0XLj4p2ON7GSAKDS1ndmCvxQeyVuHDyd0
         RRJLy4I7fplwVWMU3HZPSz6LCDmBOGzyLXdMvxbQ0Uo6umzRLbqh8VFdt5H4ADZxSuHa
         4sje+lDytvmj5/1vO7FCYL7ehHFPrmg6R9ckgwBRDLyFP/QqECRyUdhFNuJF+4rwWcjn
         wfrrMrHD9vT0q4N5jM19sTdYHyv8xrN70jPttLiqbOp9H2FKvMtFaKsH0BCNDExmp1Bl
         Ffcg95CbhUY3VsaChih0EzzGqzRkpRzdLdmOqUyocjI1rHjA92+N67jJycrWWUAggHBr
         OjSA==
X-Gm-Message-State: AOAM533R5hYXcY9rSPBjRdOJiRlWFAEPWcqQZDRoRj8yRMiyx3bWFaMg
        5q5XUtmU3gQ8vyKV9BF0xEr/jrx1hnYX9ShEltI=
X-Google-Smtp-Source: ABdhPJx8/sG5WxAWYQZ/jELz129ZKWioS5FTRv8yyuCGn+44IffBAaaGtBIO9c2TQUnYhet0xD+EVYtSXY5TBTWA2gM=
X-Received: by 2002:a50:da48:: with SMTP id a8mr52330854edk.146.1641401639743;
 Wed, 05 Jan 2022 08:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20220105163324.73369-1-chriscool@tuxfamily.org>
In-Reply-To: <20220105163324.73369-1-chriscool@tuxfamily.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 5 Jan 2022 08:53:48 -0800
Message-ID: <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 5, 2022 at 8:33 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> During the 2nd Virtual Git Contributors=E2=80=99 Summit last October, and=
 even
> before, the subject of performing server side merges and rebases came
> up, as platforms like GitHub and GitLab would like to support many
> features and data formats that libgit2 doesn't support, like for
> example SHA256 hashes and partial clone.
>
> It's hard for them to get rid of libgit2 though, because Git itself
> doesn't have a good way to support server side merges and rebases,
> while libgit2 has ways to perform them. Without server side merges and
> rebases, those platforms would have to launch some kind of checkout,
> which can be very expensive, before any merge or rebase.
>
> The latest discussions on this topic following the 2nd Virtual
> Summit[1] ended with some proposals around a `git merge-tree` on
> steroids that could be a good solution to this issue.
>
> The current `git merge-tree` command though seems to have a number of
> issues, especially:
>
>   - it's too much related to the old merge recursive strategy which is
>     not the default anymore since v2.34.0 and is likely to be
>     deprecated over time,
>
>   - it seems to output things in its own special format, which is not
>     easy to customize, and which needs special code and logic to parse

I agree we don't want those...but why would new merge-tree options
have to use the old merge strategy or the old output format?

> To move forward on this, this small RFC patch series introduces a new
> `git merge-tree-ort` command with the following design:

Slightly dislike the command name.  `ort` was meant as a temporary,
internal name.  I don't think it's very meaningful to users, so I was
hoping to just make `recursive` mean `ort` after we had enough
testing, and to delete merge-recursive.[ch] at that time.  Then `ort`
merely becomes a historical footnote (...and perhaps part of the name
of the file where the `recursive` algorithm is implemented).

>   - it uses merge-ort's API as is to perform the merge
>
>   - it gets back a tree oid and a cleanliness status from merge-ort's
>     API and prints them out first

Good so far.

>
>   - it uses diff's API as is to output changed paths and code
>
>   - the diff API, actually diff_tree_oid() is called 3 times: once for
>     the diff versus branch1 ("ours"), once for the diff versus branch2
>     ("theirs"), and once for the diff versus the base.

Why?  That seems to be a performance penalty for anyone that doesn't
want/need the diffs, and since we return a tree, a caller can go and
get whatever diffs they like.

> Therefore:
>
>   - its code is very simple and very easy to extend and customize, for
>     example by passing diff or merge-ort options that the code would
>     just pass on to the merge-ort and diff APIs respectively
>
>   - its output can easily be parsed using simple code

These points are good.

>     and existing diff parsers
>
> This of course means that merge-tree-ort's output is not backward
> compatible with merge-tree's output, but it doesn't seem that there is
> much value in keeping the same output anyway. On the contrary
> merge-tree's output is likely to hold us back already.
>
> The first patch in the series adds the new command without any test
> and documentation.
>
> The second patch in the series adds a few tests that let us see how
> the command's output looks like in different very simple cases.
>
> Of course if this approach is considered valuable, I plan to add some
> documentation, more tests and very likely a number of options before
> submitting the next iteration.

Was there something you didn't like about
https://lore.kernel.org/git/pull.1114.git.git.1640927044.gitgitgadget@gmail=
.com/?

> I am not sure that it's worth showing the 3 diffs (versus branch1,
> branch2 and base) by default. Maybe by default no diff at all should
> be shown and the command should have --branch1 (or --ours), --branch2
> (or --theirs) and --base options to ask for such output, but for an
> RFC patch I thought it would be better to output the 3 diffs so that
> people get a better idea of the approach this patch series is taking.

I think not showing, neither by default or at all would be better.
All three of these are things users could easily generate for
themselves with the tree we return.  I'm curious, though, what's the
usecase for wanting these specific diffs?

Two things you didn't return that users cannot get any other way: (1)
conflict and warning messages, (2) list of conflicted paths.

> [1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110211147490.56@tvgsbe=
jvaqbjf.bet/
>
>
> Christian Couder (2):
>   merge-ort: add new merge-tree-ort command
>   merge-ort: add t/t4310-merge-tree-ort.sh
>
>  .gitignore                |   1 +
>  Makefile                  |   1 +
>  builtin.h                 |   1 +
>  builtin/merge-tree-ort.c  |  93 ++++++++++++++++++++++
>  git.c                     |   1 +
>  t/t4310-merge-tree-ort.sh | 162 ++++++++++++++++++++++++++++++++++++++
>  6 files changed, 259 insertions(+)
>  create mode 100644 builtin/merge-tree-ort.c
>  create mode 100755 t/t4310-merge-tree-ort.sh
>
> --
> 2.34.1.433.g7bc349372a.dirty
