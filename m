Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCB4C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 01:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA9B8223C7
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 01:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm6jOW8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgKDBhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 20:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgKDBho (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 20:37:44 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E38C061A4D
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 17:37:44 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id f9so24957174lfq.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 17:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=cdz3MvqpZmVU/r5msIpTecKoUCpqKrT+651PoqK0VLM=;
        b=jm6jOW8bGKtXuQ+j8g+Vtx7325eKsE+3GMH6oHR2buBCyLQuganfUqVY/fdpKCelTP
         AmDC/m6Xw+0RNmsiDEdRWneXmedY8bauBcekcOj3UkEloeJfHhn4u6d3WgWIdsUKzS2N
         m13sogmZ/RtUacfhoOrqce6FpdprJEIhPhBzaFSIFqz0R4LWUbW3Aqo2S3EnupRy6Tic
         f2DL8/sCxVchn7vEvIh0vXnsUyezdM/4CuScsSMYRxmJ5e+h0Ep329uRZI6mq2bBbAOI
         /y5VJqxR3F0gDhBA1CapfR1BYDDzTNx+n3v6H06NGUvMNWcyX149pfAwdsO+Y6AMqKqK
         NJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=cdz3MvqpZmVU/r5msIpTecKoUCpqKrT+651PoqK0VLM=;
        b=l2UuW1Cy8qU0CZ/UufFkpUGFHlPn9mBdcdl+fEw1JRuXTXW1pKNnCQ+NEx8vNI+MuV
         epwGf6I96D7QbrR9im7kkEqOUpIgrbYTLO7xXI/tSgY9kjnXdA92GTzmsT6kZhRDYjL4
         kSYdq1KLa/J3d/LRZKUNs+7mns1ZCKo0KDG/6JZnUeVz/zVyAgw45CqNNr9WH7t7hNLU
         9iURKA0JcSgCPec6lip87SBQylSEFxdoLueSJtt9c2QD0A2gtf4NVsC8863+Fy+6pJvi
         UJYaFD0Qxkdm64n2UjHOt7l1aJaf1eUhmxTPOFxHJVm83f39PPk6xfGnMvaK5znf16QF
         TxSg==
X-Gm-Message-State: AOAM531I1VL9PSe3i+YyZC69bs4lt5EsBZfN6aQaXKpHrCcN2HSpYLPO
        mtv/yqoPdu4dXxNHSN+ZLSw=
X-Google-Smtp-Source: ABdhPJxVoau5fkjCLzSBBUQ/t+99FCi2r1WihHFRBBetX94b+LN/X9KOLX8SFUJQbrwoPZ/u3KoWtA==
X-Received: by 2002:a19:7f8e:: with SMTP id a136mr722462lfd.524.1604453862531;
        Tue, 03 Nov 2020 17:37:42 -0800 (PST)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id m132sm145874lfa.34.2020.11.03.17.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 17:37:41 -0800 (PST)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH v4 10/10] doc: add corrected commit date info
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <9ada43967d29a3ec717b6a8db0de5b09e6d916b1.1602079786.git.gitgitgadget@gmail.com>
Date:   Wed, 04 Nov 2020 02:37:41 +0100
In-Reply-To: <9ada43967d29a3ec717b6a8db0de5b09e6d916b1.1602079786.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Wed, 07 Oct 2020 14:09:45
        +0000")
Message-ID: <85tuu5q4uy.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> With generation data chunk and corrected commit dates implemented, let's
> update the technical documentation for commit-graph.
>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>

Nice.

> ---
>  .../technical/commit-graph-format.txt         | 21 +++++--
>  Documentation/technical/commit-graph.txt      | 62 ++++++++++++++++---
>  2 files changed, 69 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/technical/commit-graph-format.txt b/Documentat=
ion/technical/commit-graph-format.txt
> index b3b58880b9..08d9026ad4 100644
> --- a/Documentation/technical/commit-graph-format.txt
> +++ b/Documentation/technical/commit-graph-format.txt
> @@ -4,11 +4,7 @@ Git commit graph format
>  The Git commit graph stores a list of commit OIDs and some associated
>  metadata, including:
>=20=20
> -- The generation number of the commit. Commits with no parents have
> -  generation number 1; commits with parents have generation number
> -  one more than the maximum generation number of its parents. We
> -  reserve zero as special, and can be used to mark a generation
> -  number invalid or as "not computed".
> +- The generation number of the commit.

All right, because we could store both generation number v1 and
generation number v2 in the commit-graph file, and we need to describe
both, the description is now consolidated and in only one place.

>=20=20
>  - The root tree OID.
>=20=20
> @@ -86,13 +82,26 @@ CHUNK DATA:
>        position. If there are more than two parents, the second value
>        has its most-significant bit on and the other bits store an array
>        position into the Extra Edge List chunk.
> -    * The next 8 bytes store the generation number of the commit and
> +    * The next 8 bytes store the topological level (generation number v1)
> +      of the commit and

All right, this is updated information about CDAT chunk.

>        the commit time in seconds since EPOCH. The generation number
>        uses the higher 30 bits of the first 4 bytes, while the commit
>        time uses the 32 bits of the second 4 bytes, along with the lowest
>        2 bits of the lowest byte, storing the 33rd and 34th bit of the
>        commit time.
>=20=20
> +  Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes)

Should we mark this chunk as "[Optional]"?  Its absence is not an error.

> +    * This list of 4-byte values store corrected commit date offsets for=
 the
> +      commits, arranged in the same order as commit data chunk.
> +    * If the corrected commit date offset cannot be stored within 31 bit=
s,
> +      the value has its most-significant bit on and the other bits store
> +      the position of corrected commit date into the Generation Data Ove=
rflow
> +      chunk.

All right.

> +
> +  Generation Data Overflow (ID: {'G', 'D', 'O', 'V' }) [Optional]
> +    * This list of 8-byte values stores the corrected commit dates for c=
ommits
> +      with corrected commit date offsets that cannot be stored within 31=
 bits.

A question: do we store 8-byte / 64-bit corrected commit date *directly*,
or do we store corrected commit date *offset* as 8-byte / 64-bit value?

Perhaps we should add the information that [like the EDGE chunk] it is
present only when necessary, and that it is present only when GDAT chunk
is present (it might be obvious, but it could be better to state
this explicitly).

> +

All right, this is the information about two new chunks (with the
mentioned above caveat about the clarity of the description of
overflow-handling chunk).

>    Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
>        This list of 4-byte values store the second through nth parents for
>        all octopus merges. The second parent value in the commit data sto=
res
> diff --git a/Documentation/technical/commit-graph.txt b/Documentation/tec=
hnical/commit-graph.txt
> index f14a7659aa..75f71c4c7b 100644
> --- a/Documentation/technical/commit-graph.txt
> +++ b/Documentation/technical/commit-graph.txt
> @@ -38,14 +38,31 @@ A consumer may load the following info for a commit f=
rom the graph:
>=20=20
>  Values 1-4 satisfy the requirements of parse_commit_gently().
>=20=20
> -Define the "generation number" of a commit recursively as follows:
> +There are two definitions of generation number:
> +1. Corrected committer dates (generation number v2)
> +2. Topological levels (generation nummber v1)

All right.

>=20=20
> - * A commit with no parents (a root commit) has generation number one.
> +Define "corrected committer date" of a commit recursively as follows:
>=20=20
> - * A commit with at least one parent has generation number one more than
> -   the largest generation number among its parents.
> +  * A commit with no parents (a root commit) has corrected committer date
> +    equal to its committer date.

Minor nitpick: the above point has been accidentally indented one space
more than necessary, and than is indented in other places.  Or maybe
that fixes / unifies the formatting... I am not sure.

>=20=20
> -Equivalently, the generation number of a commit A is one more than the
> +  * A commit with at least one parent has corrected committer date equal=
 to
> +    the maximum of its commiter date and one more than the largest corre=
cted
> +    committer date among its parents.
> +
> +  * As a special case, a root commit with timestamp zero has corrected c=
ommit
> +    date of 1, to be able to distinguish it from GENERATION_NUMBER_ZERO
> +    (that is, an uncomputed corrected commit date).

All right.  Looks good.

> +
> +Define the "topological level" of a commit recursively as follows:
> +
> + * A commit with no parents (a root commit) has topological level of one.
> +
> + * A commit with at least one parent has topological level one more than
> +   the largest topological level among its parents.
> +

All right, this just repeats what was written before, or in other words
move existing contents lower/later, just with 'generation number'
replaced by 'topological level' (though it might be not obvious from the
patch because of the latter change).

> +Equivalently, the topological level of a commit A is one more than the
>  length of a longest path from A to a root commit. The recursive definiti=
on
>  is easier to use for computation and observing the following property:
>=20=20
> @@ -60,6 +77,9 @@ is easier to use for computation and observing the foll=
owing property:
>      generation numbers, then we always expand the boundary commit with h=
ighest
>      generation number and can easily detect the stopping condition.
>=20=20
> +The properties applies to both versions of generation number, that is bo=
th
> +corrected committer dates and topological levels.
> +

I think it should be "This property" or "The property", not "The
properties"; it is a single property, a single condition.

We can alternatively say "This condition is fulfilled by both versions...",
or "This condition is true for both versions...".

>  This property can be used to significantly reduce the time it takes to
>  walk commits and determine topological relationships. Without generation
>  numbers, the general heuristic is the following:
> @@ -67,7 +87,9 @@ numbers, the general heuristic is the following:
>      If A and B are commits with commit time X and Y, respectively, and
>      X < Y, then A _probably_ cannot reach B.
>=20=20
> -This heuristic is currently used whenever the computation is allowed to
> +In absence of corrected commit dates (for example, old versions of Git or
> +mixed generation graph chains),
> +this heuristic is currently used whenever the computation is allowed to
>  violate topological relationships due to clock skew (such as "git log"
>  with default order), but is not used when the topological order is
>  required (such as merge base calculations, "git log --graph").

All right, this explains when commit date heuristics is used (which is
less often than before).

> @@ -77,7 +99,7 @@ in the commit graph. We can treat these commits as havi=
ng "infinite"
>  generation number and walk until reaching commits with known generation
>  number.
>=20=20
> -We use the macro GENERATION_NUMBER_INFINITY =3D 0xFFFFFFFF to mark commi=
ts not
> +We use the macro GENERATION_NUMBER_INFINITY to mark commits not

All right, 64-bit GENERATION_NUMBER_INFINITY =3D 0xFFFFFFFFFFFFFFFF is a
bit unwieldy...

>  in the commit-graph file. If a commit-graph file was written by a version
>  of Git that did not compute generation numbers, then those commits will
>  have generation number represented by the macro GENERATION_NUMBER_ZERO =
=3D 0.
> @@ -93,7 +115,7 @@ fully-computed generation numbers. Using strict inequa=
lity may result in
>  walking a few extra commits, but the simplicity in dealing with commits
>  with generation number *_INFINITY or *_ZERO is valuable.
>=20=20
> -We use the macro GENERATION_NUMBER_MAX =3D 0x3FFFFFFF to for commits who=
se
> +We use the macro GENERATION_NUMBER_MAX for commits whose

This should be

  +We use the macro GENERATION_NUMBER_V1_MAX =3D 0x3FFFFFFF to for commits =
whose
  +topological levels (generation number v1) are computed to be at least th=
is value. We limit at
   this value since it is the largest value that can be stored in the
  +commit-graph file using the 30 bits available to topological levels. This

We need to use "topological levels" or "generation numbers v1" thorough
the rest of this section.

>  generation numbers are computed to be at least this value. We limit at
>  this value since it is the largest value that can be stored in the
>  commit-graph file using the 30 bits available to generation numbers. This
> @@ -267,6 +289,30 @@ The merge strategy values (2 for the size multiple, =
64,000 for the maximum
>  number of commits) could be extracted into config settings for full
>  flexibility.
>

All right, I agree that we don't need to write about overflow handling
for storing corrected committer dates (generation number v2) as offsets;
this is something format-specific, and this documentation is more about
using commit-graph data.  What is present in commit-graph-format.txt
should be enough information.

Sidenote: I wonder if other Git implementations such as JGit, Dulwich,
Gitoxide (gix), go-git have support for the commit-graph file...

> +## Handling Mixed Generation Number Chains
> +
> +With the introduction of generation number v2 and generation data chunk,=
 the
> +following scenario is possible:
> +
> +1. "New" Git writes a commit-graph with the corrected commit dates.
> +2. "Old" Git writes a split commit-graph on top without corrected commit=
 dates.
> +
> +A naive approach of using the newest available generation number from
> +each layer would lead to violated expectations: the lower layer would
> +use corrected commit dates which are much larger than the topological
> +levels of the higher layer. For this reason, Git inspects each layer to
> +see if any layer is missing corrected commit dates. In such a case, Git
> +only uses topological level

This should end in full stop:

  +only uses topological levels.

Or maybe we should expand the last sentence a bit:

  +only uses topological levels for generation numbers.

Sidenote: it is a good explanation, even if Git can make use of the
property described below that only topmost layers might be missing
corrected commit graph by the construction (so it needs to check only
the top layer).

> +
> +When writing a new layer in split commit-graph, we write corrected commit
> +dates if the topmost layer has corrected commit dates written. This
> +guarantees that if a layer has corrected commit dates, all lower layers
> +must have corrected commit dates as well.
> +
> +When merging layers, we do not consider whether the merged layers had co=
rrected
> +commit dates. Instead, the new layer will have corrected commit dates if=
 and
> +only if all existing layers below the new layer have corrected commit da=
tes.
> +

Perhaps we should explicitly say that when rewriting split commit-graph
as a single file (`--split=3Dreplace`) then the newly created single layer
would store corrected commit dates.

>  ## Deleting graph-{hash} files
>=20=20
>  After a new tip file is written, some `graph-{hash}` files may no longer

Best,
--=20
Jakub Nar=C4=99bski
