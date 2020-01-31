Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F027C33CB7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 19:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576532082E
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 19:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDTs3gvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgAaT1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 14:27:40 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36323 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgAaT1k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 14:27:40 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so3980767pgc.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 11:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q33n6R4deWLcs27IpVVRdt66ICa/D0x2b50s2J0JKqM=;
        b=lDTs3gvhU7/bSAhP9Z6jQQK2nDkwhwobk4/RVyD2IPfIM5O+jBOVfGei0banJUJi5H
         KcWYW101B2fBToMHNBLn2QU/VU43We9e3id9bNxXrmhjAJ3ORe0V+JhbCJsEu3keOb9e
         9MDQFWMZ2qFxvI6GeBCUuC7qT1bpA+NkElWSyDaOQvezwNNAQFi2MYzD/qNuQ3h8gwRC
         wsFuGbvQG70f16JLlj1AcdVxAO6TnEt+OBh5eBoQv57M1e+As9zshlg4T7LGVguhhgG/
         LA56NxGN/2qukDup9aLD1Z59oD9aJi8MFq+KCaZpopRrHCZBzi2JlmeIw34z7A5WP8Wq
         hygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q33n6R4deWLcs27IpVVRdt66ICa/D0x2b50s2J0JKqM=;
        b=k393hPqSldARjk5wb+5AiFMIkp9TYQ3XSa/5c///rS6XyIEy+kb2Amx4Ma8vRPgyQw
         dKs3f2g0xYiTeSTrTC4BjueFJZq0XzK9FnZ2t1pT+FO2ZBD8L93mciDAZZ/ELJwzY8f/
         2YVQlVFTOeNHAWyA5MD00kWbU021YugB8ZCQZWT8VZyJw+cONRAoHpn+ihTadyEgYFYC
         I1Qwv5eUM0spoawDJLChPptFJxqw+GpfDDIVEY5+ngKWa3UlQ9Y0xbOMm8Caqu5uEU9/
         /b1XAGj5jblzKAgdb/TCurLrjieB+N6Q0tlP1R1tU76F3coDRp/7pLlmCpOeMZK02jcQ
         JxEQ==
X-Gm-Message-State: APjAAAUK1u4gnKMD0zcNnyHP2Bjk+HZWmte5NagmvDlQvq2fz/ISegGO
        8PbGHzNIPDd9kpGZQ+ljOA9hMWo5wm4JkffQWuk=
X-Google-Smtp-Source: APXvYqzpBKrK6rtNJhgArjnuB1dZ8lT/v2z/1KAKjYDO/pTobqy/oIY01A4rCWM+5eTz5bHoA4z6n01z4cASHc6RUL0=
X-Received: by 2002:aa7:8654:: with SMTP id a20mr11944241pfo.88.1580498859198;
 Fri, 31 Jan 2020 11:27:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580430057.git.me@ttaylorr.com> <4f5bc19903f8a1f5b153b5665de378e743e12744.1580430057.git.me@ttaylorr.com>
In-Reply-To: <4f5bc19903f8a1f5b153b5665de378e743e12744.1580430057.git.me@ttaylorr.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 31 Jan 2020 20:27:27 +0100
Message-ID: <CAN0heSo29+sf1352EfGv=qFsir-e=Ompja445bh5z3vpOfkaJA@mail.gmail.com>
Subject: Re: [PATCH 1/3] builtin/commit-graph.c: support '--split[=<strategy>]'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 31 Jan 2020 at 01:29, Taylor Blau <me@ttaylorr.com> wrote:
> With '--split', the commit-graph machinery writes new commits in another
> incremental commit-graph which is part of the existing chain, and
> optionally decides to condense the chain into a single commit-graph.
> This is done to ensure that the aysmptotic behavior of looking up a

asymptotic

> commit in an incremental chain is dominated by the number of
> incrementals in that chain. It can be controlled by the '--max-commits'
> and '--size-multiple' options.
>
> On occasion, callers may want to ensure that 'git commit-graph write
> --split' always writes an incremental, and never spends effort
> condensing the incremental chain [1]. Previously, this was possible by
> passing '--size-multiple=0', but this no longer the case following
> 63020f175f (commit-graph: prefer default size_mult when given zero,
> 2020-01-02).
>
> Reintroduce a less-magical variant of the above with a new pair of
> arguments to '--split': '--split=no-merge' and '--split=merge-all'. When
> '--split=no-merge' is given, the commit-graph machinery will never
> condense an existing chain and will always write a new incremental.
> Conversely, if '--split=merge-all' is given, any invocation including it
> will always condense a chain if one exists.  If '--split' is given with
> no arguments, it behaves as before and defers to '--size-multiple', and
> so on.

I understand your motivation for doing this -- it all seems quite sound
to me. Not being too familiar with this commit-graph splitting and
merging, I had a hard time groking this terminology though. From what I
understand, before this patch, `--split` means "write the commit-graph
using the 'split' file-format / in a split fashion". Ok, that makes
sense.

From seeing `--split=no-merge`, I have no idea how to even parse that.
Of course I don't want to merge, I want to split! Well not split, but
write split files.

I think it would help me (and others like me) if we could somehow
separate "I want to use 'split' files" from "and here's how I want you
to decide on the merging". That is, which "strategy" to use. Obviously,
talking about a "merge strategy" would be stupid and "split strategy"
also seems a bit odd. "Coalescing strategy"? "Joining strategy"?

Or can you convince me otherwise? From which angle should I look at
this?

> -With the `--split` option, write the commit-graph as a chain of multiple
> -commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
> -not already in the commit-graph are added in a new "tip" file. This file
> -is merged with the existing file if the following merge conditions are
> -met:
> +With the `--split[=<strategy>]` option, write the commit-graph as a
> +chain of multiple commit-graph files stored in
> +`<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
> +strategy and other splitting options. The new commits not already in the
> +commit-graph are added in a new "tip" file. This file is merged with the
> +existing file if the following merge conditions are met:
> +* If `--split=merge-always` is specified, then a merge is always
> +conducted, and the remaining options are ignored. Conversely, if
> +`--split=no-merge` is specified, a merge is never performed, and the
> +remaining options are ignored. A bare `--split` defers to the remaining
> +options. (Note that merging a chain of commit graphs replaces the
> +existing chain with a length-1 chain where the first and only
> +incremental holds the entire graph).

To better understand the background for this patch, I read the manpage
as it stands today. From the section on `--split`, I got this
impression: Let's say that `--max-commits` is huge, so all that matters
is the `--size-multiple`. Let's say it's two. If the current tip
contains three commits and we're about to write one with two, then 2*2 >
3 so we will merge, i.e., write a tip file with five commits. Unless of
course *that* is more than half the size of the file before. And so on.
We might just merge once, or maybe "many" files in an avalanche effect.
Every now and then, such avalanches will go all the way back to the
first file.

Now this says something different, namely that once we decide to merge,
we do it all the way back, no matter what.

The commit message of 1771be90c8 ("commit-graph: merge commit-graph
chains", 2019-06-18) seems to support my original understanding, at
least for `--size-multiple`, but not `--max-commits`, curiously enough.

Can you clarify?

> -               OPT_BOOL(0, "split", &opts.split,
> -                       N_("allow writing an incremental commit-graph file")),
> +               OPT_CALLBACK_F(0, "split", &split_opts.flags, NULL,
> +                       N_("allow writing an incremental commit-graph file"),

This still sounds very boolean. Cramming in the "strategy" might be hard
-- is this an argument in favor of having two separate options? ;-)

> +enum commit_graph_split_flags {
> +       COMMIT_GRAPH_SPLIT_UNSPECIFIED      = 0,
> +       COMMIT_GRAPH_SPLIT_MERGE_REQUIRED   = 1,
> +       COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED = 2
> +};

I wonder if this should be "MERGE_AUTO" rather than "UNSPECIFIED". This
is related to Stolee's comment, I think.


Martin
