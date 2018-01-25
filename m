Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9DDD1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 21:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbeAYVOt (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 16:14:49 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41689 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeAYVOr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 16:14:47 -0500
Received: by mail-pf0-f196.google.com with SMTP id c6so6714025pfi.8
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 13:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=I6ny+wEaWN1HIZYI69gvkkgmGrn32SPs/AI6nyx79vQ=;
        b=GXF+vLNlGhh/hcDw5L5P+xSxHNweBv5hI3fBKlI770B0SaiMUMnti2kn35+Rs/UeEj
         rjTLqVpOTGLQ2dV5Pb426NIwT/o3WZe3AQ6xv8jgiSNX/3mV93M6dIN57OuUx2hjuVmI
         5bD9psvWrRV2JnDzhsu8KzTNlPWk4/xg7o7Ryj5elGnke+gci4/CzaEK4WKD0WtL63hy
         SiuYf5c/xx4fekN5JHk6xNpjPUt3tplhDgQBCfsCDDhnhhaNz4hFHhK0eMV9hqARBul2
         FtWIyZgWO0pEdbJu/f93+iEH0y8G/z27yQKeIQRqtGU6QV6w33fHm6u2i3apTXET5YFY
         wN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=I6ny+wEaWN1HIZYI69gvkkgmGrn32SPs/AI6nyx79vQ=;
        b=mOIUGiFDVajHUW7yOzr58ZBFE/ka6GoNnHi10TCZrsCIGktkeq0wuGuH/CAVi5Y3cm
         VFis4ScSiXAu0AQVSlFtN5WTJ6UtECGc9Hp4fa7loCQYlglNF04HFqG+k5RK1Bn+Ckj7
         MMEBi5Vz6EEpdMGB4MvciGgpRnmwTzCpeu1KVBa85lgdVX0S5J014ldk0ehSyyHADoPN
         tgBGhC3NxSYmhhyCBhFzC2p2bKYaNRMjcn0BHzIjPkSWyDh502tb0AOPy6ghFCunad/Q
         MaPzWDeXvUPgcAZ9SYxNqS09qgzlrb6ATFiAdO7KNvZLRn0b2O3XND3uqgzSQIYW6xS4
         bdcA==
X-Gm-Message-State: AKwxytdHvahi9SsoD+SW0QbO2NWcL+RXMHBQljWf8wdN0ixtAM+aLaC2
        T/N7LSHHgjYpY5UqDQ7sWyei1rtZ
X-Google-Smtp-Source: AH8x226PCXo2ugtf+lyIOMTYykMr+N+VYgOVRJwRHH2QGHU8UDdSqCgAvEKBO04bPMWriFxBspbgcg==
X-Received: by 2002:a17:902:900b:: with SMTP id a11-v6mr12263418plp.249.1516914886872;
        Thu, 25 Jan 2018 13:14:46 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f924:a479:e3c:a7cc])
        by smtp.gmail.com with ESMTPSA id x14sm5710088pgq.43.2018.01.25.13.14.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 13:14:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH 01/14] graph: add packed graph design document
References: <20180125140231.65604-1-dstolee@microsoft.com>
        <20180125140231.65604-2-dstolee@microsoft.com>
Date:   Thu, 25 Jan 2018 13:14:44 -0800
In-Reply-To: <20180125140231.65604-2-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 25 Jan 2018 09:02:18 -0500")
Message-ID: <xmqqzi518wu3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Add Documentation/technical/packed-graph.txt with details of the planned
> packed graph feature, including future plans.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/packed-graph.txt | 185 +++++++++++++++++++++++++++++++
>  1 file changed, 185 insertions(+)
>  create mode 100644 Documentation/technical/packed-graph.txt

I really wanted to like having this patch at the beginning, but
unfortunatelly I didn't see the actual file format description,
which was a bit disappointing.  An example of the things that I was
curious about was how the "integer ID" is used to access into the
file.  If we could somehow use "integer ID" as an index into an
array of fixed size elements, it would be ideal to gain "fast
lookups", but because of the "list of parents" thing, it needs some
trickery to do so, and that was among the things that I wanted to
see how much thought went into the design, for example.

> diff --git a/Documentation/technical/packed-graph.txt b/Documentation/technical/packed-graph.txt
> new file mode 100644
> index 0000000000..fcc0c83874
> --- /dev/null
> +++ b/Documentation/technical/packed-graph.txt
> @@ -0,0 +1,185 @@
> +Git Packed Graph Design Notes
> +=============================
> +
> +Git walks the commit graph for many reasons, including:
> +
> +1. Listing and filtering commit history.
> +2. Computing merge bases.
> +
> +These operations can become slow as the commit count grows above 100K.
> +The merge base calculation shows up in many user-facing commands, such
> +as 'status' and 'fetch' and can take minutes to compute depending on
> +data shape. There are two main costs here:

s/data shape/history shape/ may make it even clearer.

> +1. The commit OID.
> +2. The list of parents.
> +3. The commit date.
> +4. The root tree OID.
> +5. An integer ID for fast lookups in the graph.
> +6. The generation number (see definition below).
> +
> +Values 1-4 satisfy the requirements of parse_commit_gently().
> +
> +By providing an integer ID we can avoid lookups in the graph as we walk
> +commits. Specifically, we need to provide the integer ID of the parent
> +commits so we navigate directly to their information on request.

Commits created after a packed graph file is built may of course not
appear in a packed graph file, but that is OK because they never need
to be listed as parents of commits in the file.  So "list of parents"
can always refer to the parents using the "integer ID for fast lookup".

Makes sense.  Item 2. might want to say "The list of parents, using
the fast lookup integer ID (see 5.) as reference instead of OID",
though.

> +Define the "generation number" of a commit recursively as follows:
> + * A commit with no parents (a root commit) has generation number 1.
> + * A commit with at least one parent has generation number 1 more than
> +   the largest generation number among its parents.
> +Equivalently, the generation number is one more than the length of a
> +longest path from the commit to a root commit.

When a commit A can reach roots X and Y, and Y is further than X,
the distance between Y and A becomes A's generation number.  "One
more than the length of the path from the commit to the furthest
root commit it can reach", in other words.

> +The recursive definition
> +is easier to use for computation and the following property:
> +
> +    If A and B are commits with generation numbers N and M, respectively,
> +    and N <= M, then A cannot reach B. That is, we know without searching
> +    that B is not an ancestor of A because it is further from a root commit
> +    than A.
> +
> +    Conversely, when checking if A is an ancestor of B, then we only need
> +    to walk commits until all commits on the walk boundary have generation
> +    number at most N. If we walk commits using a priority queue seeded by
> +    generation numbers, then we always expand the boundary commit with highest
> +    generation number and can easily detect the stopping condition.

These are both true.  It would be nice if an optimized walker
algorithm can also deal with history with recent commits for which
we do not yet know the generation numbers (i.e. you first traverse
and assign generation numbers and record in packed graph, then
history grows but we haven't added the new commits to the packed
graph yet).

> +- A graph file is stored in a file named 'graph-<oid>.graph' in the pack
> +  directory. This could be stored in an alternate.

Is that <oid> really an object name?  The <hash> that appears in the
name of a packfile pack-<hash>.pack is *not* an <oid>, and I somehow
suspect that you are doing a similar "use hash of (some) contents to
make it uniquely identify the content", not "information about a
single object that is identified by the <oid>".

> +- The graph file is only a supplemental structure. If a user downgrades
> +  or disables the 'core.graph' config setting, then the existing ODB is
> +  sufficient.

OK, that is exactly what I meant to say in a few paragraphs above
that I wanted to see.

> +Current Limitations
> +-------------------
> +
> +- Only one graph file is used at one time. This allows the integer ID to
> +  seek into the single graph file. It is possible to extend the model
> +  for multiple graph files, but that is currently not part of the design.
> +
> +- .graph files are managed only by the 'graph' builtin. These are not
> +  updated automatically during clone or fetch.

In addition to "clone or fetch", I presume operations that locally
create commits do not automatically create them, right?

> +- After computing and storing generation numbers, we must make graph
> +  walks aware of generation numbers to gain performance benefits. This
> +  will mostly be accomplished by swapping a commit-date-ordered priority
> +  queue with one ordered by generation number. The following operations
> +  are important candidates:
> +
> +    - paint_down_to_common()
> +    - 'log --topo-order'

Do you mean that this round only writes "graph" without any actualy
consumers?  It is somewhat hard to assess the value of what is
stored in the new file without the consumers.

Anyway, thanks for starting this.  Let's read on.

