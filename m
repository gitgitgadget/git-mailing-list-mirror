Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BAEF1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 17:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388652AbeGWSFv (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 14:05:51 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41886 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388357AbeGWSFv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 14:05:51 -0400
Received: by mail-io0-f195.google.com with SMTP id q9-v6so1134928ioj.8
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pt6mUKIjbvTIM0OZOywIMJn5VcAi4nGFmg19bHFIefI=;
        b=j7k79HCWtg5hMyOqmOH9tr1zXadsrCtGZR+NnKcG/bv/QvUd9qqErQuWty+Q9ona/n
         8ooVWjler02Y03wcKjNWXu9cRKT9jIqv7q72sKa74o9krj6Wf1h5u0In9+8VQzYX06JC
         Yiv0NTXx6NXmDGDYM+5tY8rp8xvLk1aS/LgDHGcSc1gdhru67ti+Iu+CmhDo+zAq/1vo
         eX4fCYN4iQte7iXa5u787/VhZel4PA+G1qmHnzS1fJ0qOZzhN4uap8hMUehrWaqIc8tX
         03s4Mwm3iWVJ6maWcbNIod5zSlE2SyC+Zn6q94aKmngVA/6L7iAGGNBvDhpVXUW2UipI
         dZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pt6mUKIjbvTIM0OZOywIMJn5VcAi4nGFmg19bHFIefI=;
        b=kwGeisHB96Vz8V/V43N6IKO5kGHzMHyFPPpZxIBrULlpZBUYp34WikFC1u9YIl/XPa
         RrDMXaop1/eJ91zlNIAfuThQReSB+drjm8dzM33UZ8dS788vdogHFMJ5HG7vE4VOF5H3
         3WZWcKdGEP/A4Q9BPZ+/zTInACTSx7X5gcyesnSk/AERiqRy28Zl92OydaEDqJ1cefyd
         Fza64oC0FJf4dPxS0z9A9h1xgzRMIo/0bNQHPIeRvdy5fbWHVozFWgfWSnxLjUWkAeKh
         XcEXJGVqlGkAfX3BdR9KsBsA1Q9J2LG5gZ0JSkJMOyYf2En6PIlfYW+J8Z6NSxv7xOEv
         JKqg==
X-Gm-Message-State: AOUpUlHpvz6y5tM8+g6LZZ2xIDJe0SwCmFaCgOHqnawqAsTcXqoBjqPj
        Q1rL9qkPfaj55Sl4vI447kXKfrLeM8m7L6pZYUA=
X-Google-Smtp-Source: AAOMgpfEQJKxMVRnj3cKy5HQKmWDbjl4oI8fb3auKUN+uQlJ2BaBb101dpxjPMVe9140YyuJgnHi/z8+VlH5OirpRqw=
X-Received: by 2002:a6b:825e:: with SMTP id e91-v6mr10552674iod.118.1532365422594;
 Mon, 23 Jul 2018 10:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180718204458.20936-1-benpeart@microsoft.com>
 <20180718213420.GA17291@sigill.intra.peff.net> <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
In-Reply-To: <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 23 Jul 2018 19:03:16 +0200
Message-ID: <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase, etc)
To:     Ben Peart <peartben@gmail.com>
Cc:     Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 5:50 PM Ben Peart <peartben@gmail.com> wrote:
> > Anyway, on to the actual discussion:
> >
> >> Here is a checkout command with tracing turned on to demonstrate where=
 the
> >> time is spent.  Note, this is somewhat of a =EF=BF=BDbest case=EF=BF=
=BD as I=EF=BF=BDm simply
> >> checking out the current commit:
> >>
> >> benpeart@gvfs-perf MINGW64 /f/os/src (official/rs_es_debug_dev)
> >> $ /usr/src/git/git.exe checkout
> >> 12:31:50.419016 read-cache.c:2006       performance: 1.180966800 s: re=
ad cache .git/index
> >> 12:31:51.184636 name-hash.c:605         performance: 0.664575200 s: in=
itialize name hash
> >> 12:31:51.200280 preload-index.c:111     performance: 0.019811600 s: pr=
eload index
> >> 12:31:51.294012 read-cache.c:1543       performance: 0.094515600 s: re=
fresh index
> >> 12:32:29.731344 unpack-trees.c:1358     performance: 33.889840200 s: t=
raverse_trees
> >> 12:32:37.512555 read-cache.c:2541       performance: 1.564438300 s: wr=
ite index, changed mask =3D 28
> >> 12:32:44.918730 unpack-trees.c:1358     performance: 7.243155600 s: tr=
averse_trees
> >> 12:32:44.965611 diff-lib.c:527          performance: 7.374729200 s: di=
ff-index
> >> Waiting for GVFS to parse index and update placeholder files...Succeed=
ed
> >> 12:32:46.824986 trace.c:420             performance: 57.715656000 s: g=
it command: 'C:\git-sdk-64\usr\src\git\git.exe' checkout
> >
> > What's the current state of the index before this checkout?
>
> This was after running "git checkout" multiple times so there was really
> nothing for git to do.

Hmm.. this means cache-tree is fully valid, unless you have changes in
index. We're quite aggressive in repairing cache-tree since aecf567cbf
(cache-tree: create/update cache-tree on checkout - 2014-07-05). If we
have very good cache-tree records and still spend 33s on
traverse_trees, maybe there's something else.

> >> ODB cache
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> Since traverse_trees() hits the ODB for each tree object (of which the=
re are
> >> over 500K in this repo) I wrote and tested having an in-memory ODB cac=
he
> >> that cached all tree objects.  This resulted in a > 50% hit ratio (lar=
gely
> >> due to the fact we traverse the tree twice during checkout) but result=
ed in
> >> only a minimal savings (1.3 seconds).
> >
> > In my experience, one major cost of object access is decompression, bot=
h
> > delta and zlib. Trees in particular tend to delta very well across
> > versions. We have a cache to try to reuse intermediate delta results,
> > but the default size is probably woefully undersized for your repositor=
y
> > (I know from past tests it's undersized a bit even for the linux
> > kernel).
> >
> > Try bumping core.deltaBaseCacheLimit to see if that has any impact. It'=
s
> > 96MB by default.
> >
> > There may also be some possible work in making it more aggressive about
> > storing the intermediate results. I seem to recall from past
> > explorations that it doesn't keep everything, and I don't know if its
> > heuristics have ever been proven sane.

Could we be a bit more flexible about cache size? Say if we know
there's 8 GB memory still available, we should be able to use like 1
GB at least (and that's done automatically without tinkering with
config).
--=20
Duy
