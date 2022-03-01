Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141F5C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 17:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbiCARmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 12:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbiCARmq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 12:42:46 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B3D61A03
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 09:42:05 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id kt27so3907258ejb.0
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 09:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=sfBUa4BKh5KRSaqSsXlyFVNlwKy8ZFCfrTKCZu5/e7M=;
        b=TIoSrVPVfeg1Z2pIIoHZNPrGB7E7pewqvM741sOYjNfGNP6coO6KguRaIB0p3Vtv5t
         g2NWvZUYCyVIChceXNjtU9HAngI0D9sP3241hIDORwBq+JKNKhYFZKqCjub6cAxNbHBA
         B3g/WhIKiD1HQxouiGJQ0PjwQj9aSRhofb74achnyUmt+0flSikPMKdDV83T+TPv+iMw
         NflemehUIXLONRDnyBdk2Dz9pg94bs17I9ITrzQ6On/MnZ6HMAHhAL27GHy4rJnBgGQ6
         ALj+UZV0YugQhXKEnVwIEfSXogdBiVgSYKoAG1hUE98ymuTobtpaJNroJ9rWSp8th9pd
         jd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=sfBUa4BKh5KRSaqSsXlyFVNlwKy8ZFCfrTKCZu5/e7M=;
        b=wo8qzW+YbLnkdOeUpJlrRGV3aNjNuwUMiTELgJNLAo4XhVC2Ljs8napzPi/rwSDkrn
         8nq4LdbHMyOMZj0/GLKe0uuF6Nb03DuRVMdThcUo8HWcqo5iPXsBOET11nz9Y+yxsirk
         uo16fg8ocwjDKbKp+Jxx+o7VArQTZGtA1zGQ2npxXvWY3by9VSBTELiocuPW8UzkjF+V
         MiXm8Kqm4m54UOma5qFGC06A8UJyv6tAoctmMHWEMYbwOt7AhUhwvY5D6TZcI8lp3pgo
         eUD8B713Z9TAWaQD29noTOTi6JWDOYgCzY8/QndtYsSzTO2PWcNZkuvLNC/9HBPAs7JM
         w/XA==
X-Gm-Message-State: AOAM5329J4ae4aC9iHdPua7I9XXtHWnhgrz/0l9xZkLnJyBcOWAoxuca
        XJae9eiWdnys8ZkomDCmH55KACunnBc=
X-Google-Smtp-Source: ABdhPJyTYCZQ8NM4ME+EuC8KaOTW18BYbHH56oWgHr7CIP8ohmHbyUBwWzOxXia7WmKysjhpi/diVg==
X-Received: by 2002:a17:906:2f97:b0:6ce:3ef6:94be with SMTP id w23-20020a1709062f9700b006ce3ef694bemr20265202eji.136.1646156523101;
        Tue, 01 Mar 2022 09:42:03 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7c487000000b00413a99bf3a3sm4124686edq.56.2022.03.01.09.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 09:42:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nP6Vd-002Gbz-O4;
        Tue, 01 Mar 2022 18:42:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/4] Commit-graph: Generation Number v2 Fixes
Date:   Tue, 01 Mar 2022 18:23:43 +0100
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
Message-ID: <220301.86tuchzi1i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Derrick Stolee via GitGitGadget wrote:

> In particular, Git has been ignoring corrected commit dates since shortly
> after they were introduced. This is due to a bug I introduced when trying to
> make split commit-graphs safer with mixed generation number versions. I also
> noticed an issue with the offset overflows that I only noticed after writing
> generation number v3 using a smaller offset size, actually triggering the
> bug in the test suite.

I think sans existing small issues/fixes I noted this looks good.

Just a bit on the overall direction/design. And don't worry, not the
verison v.s. chunk all over again (except notes about how the two
versions eventually interact) :)

I.e. the post-state here looks good, but I wondered about the direction
of:

 * We have a commitGraph.readChangedPaths for *reading* BIDX/BDAT, on by default
 * We have a commitgraph.generationVersion which pre this series is 1, post-2.
 * >= 2 means look at the GDAT/GDOV chunk, and when splitting/rewriting etc.
   carry them forward.

So, I wonder:

A. Do we really need these "yes I'll read this thing in the file" settings at all?

   Isn't it sufficient to have core.commitGraph=false as an escape hatch, do we
   really need to be able to selectively ignore individual parts of the file on-disk?

B. For a "selective ignore" the commitGraph.readChangedPaths=BOOL makes sense, but
   given the follow-up series it seems odd to end up with a commitgraph.generationVersion=3
   which bumps the top-level version of the commit-graph.

I.e. commitgraph.generationVersion=2 *is* optional since the GDAT/GCOV
chunks can be ignored, but commitgraph.generationVersion=3 is *not* since
it'll also bump the format version to v2 (not v3!).

So yeah, like I said I'm being quiet about the top-level version
v.s. chunks here blah blah :)

But for the end-state you want (as I understand it) wouldn't this make
more sense:

1. Just say we have write settings + "core.commitGraph=false" escape
   hatch, no "selective read".

2. Make commitgraph.generationVersion=2 an alias for a more obviously named
   commitGraph.readGenerationData=true (optional). Maybe deprecate
   "commitGraph.readGenerationData" (say "error: just don't write it then")

3. Never have a commitgraph.generationVersion=3 setting, but instead
   add say a core.writeCommitGraphVersion=2.

   We'd thus not be conflating "commitgraph.generationVersion" which *is*
   optional and is on both the read *and* write side, with your WIP
   commitgraph.generationVersion=3 which also changes how writes happen,
   but is not at all optional for reads. You'll either support it or get a
   warning() when loading the graph.

I think this should all be OK, and I don't think it conflicts with your
stated preferences about the top-level version v.s. optional/redundant
chunks.

It makes things simpler since we'd always read data we find, with no
"maybe ignore it if it's there" settings.

And it avoids user confusion of e.g. getting an error about not
understanding a v2 graph after setting a commitgraph.generationVersion=3
setting (since one is 0-indexed...), and having "versions" in the same
config setting being first optionalon read/write, to very much not
optional.

