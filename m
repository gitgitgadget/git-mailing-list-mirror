Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95BBC433E1
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 22:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76A3206B5
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 22:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APfFGNrM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgHVWVG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 18:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgHVWVE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Aug 2020 18:21:04 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06CEC061573
        for <git@vger.kernel.org>; Sat, 22 Aug 2020 15:21:03 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v12so5616082ljc.10
        for <git@vger.kernel.org>; Sat, 22 Aug 2020 15:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2o6eMvrZCHt9NJ7Gx4T9g3WRfQdCwNl/h2EY9WsdMxE=;
        b=APfFGNrMUtC/SXQQTepaLoCbIfdYiAsRivvxm+Eo6F2clh1e9nVxu+XeBY2UWzDvEh
         zdLkDaw6fRvwXvfWpN8tucJjkOyvF9Dszh3RXm/2YPKoeXEoRdVhqSY2IiaEZBPayLhY
         9HtSzWL+DAnQWTcuVDj2x10TL4OCnU+pmuV3mV2WrHi4LlaDD/lAWi9qSz/PgTbEFYJP
         eDDzp3F4m/pA39/t9zYK4CxnxCZEvrWs1OXHYJlcWHf+rhZMTXpa87nyc38NviHzGq1y
         SLhCTiBdZdMzAbliWmIKL1RB9C3lROrvZHN1sfMgMnmzyoPQqx0GliKpADL3GyGuTx04
         Jm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=2o6eMvrZCHt9NJ7Gx4T9g3WRfQdCwNl/h2EY9WsdMxE=;
        b=ZXJHtVOfkeGlfn0SDuDzFGE/gesZu4dIITCU5XKZckw4Fk/Rhq9S0I50EKRcmHK7h3
         s73NHdY3g2kM1GHOBZsU2I7tlIs8wfsweBJke7QwySe3RHoS/7nI/46wbs6+6+/vJfBt
         f+2DLqrNWXmqBIrjxvPqq6kDY9hQPVU2lY2QA/3LFpe38EqqcZZFoB9hcrvw+B5Ia8Bn
         h5wCnXINgudac1BN18wZKUz7BBhUAs6fqbO3ifa8HfaHQ2TVyiEMyVZ+ngPZ+Tr5Af87
         /dJ6sXZHs869bPWJafCwFCxql95l+72XGhjTO+jGIgs01W9fKWqLZyYkbBunF8xWNzSA
         or7Q==
X-Gm-Message-State: AOAM533FetfzT5Z57EOt2WziarSvgmSRHw/anQIcaNM3t+Tcfareo2tz
        E/rEWuOXenKV3TWu0bl8LM3U9h90mAsd4N8R
X-Google-Smtp-Source: ABdhPJw8JpNs3vUG0VaVNIT6437k4YmQjfqOqvJBvjHwOTtdATRENM/jLz6Uf6o5ELiDsV/xS3hkiw==
X-Received: by 2002:a05:651c:513:: with SMTP id o19mr4562300ljp.379.1598134860002;
        Sat, 22 Aug 2020 15:21:00 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id r16sm1210441ljd.71.2020.08.22.15.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 15:20:58 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 11/11] doc: add corrected commit date info
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <f6f91af30587ec24e2eee052c89a536cbff42c4f.1597509583.git.gitgitgadget@gmail.com>
Date:   Sun, 23 Aug 2020 00:20:57 +0200
In-Reply-To: <f6f91af30587ec24e2eee052c89a536cbff42c4f.1597509583.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Sat, 15 Aug 2020 16:39:43
        +0000")
Message-ID: <85y2m6fhkm.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

"Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> With generation data chunk and corrected commit dates implemented, let's
> update the technical documentation for commit-graph.
>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>

All right.

> ---
>  .../technical/commit-graph-format.txt         | 12 ++---
>  Documentation/technical/commit-graph.txt      | 45 ++++++++++++-------
>  2 files changed, 36 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/technical/commit-graph-format.txt b/Documentat=
ion/technical/commit-graph-format.txt
> index 440541045d..71c43884ec 100644
> --- a/Documentation/technical/commit-graph-format.txt
> +++ b/Documentation/technical/commit-graph-format.txt
> @@ -4,11 +4,7 @@ Git commit graph format
>  The Git commit graph stores a list of commit OIDs and some associated
>  metadata, including:
>
> -- The generation number of the commit. Commits with no parents have
> -  generation number 1; commits with parents have generation number
> -  one more than the maximum generation number of its parents. We
> -  reserve zero as special, and can be used to mark a generation
> -  number invalid or as "not computed".
> +- The generation number of the commit.

All right, that was duplicated information.  Now that we need to talk
about two of them, it would not make sense to duplicate that.

>
>  - The root tree OID.
>
> @@ -88,6 +84,12 @@ CHUNK DATA:

Shouldn't we also replace 'generation number' occurences in description
of the Commit Data (CDAT) chunk with either 'topological level' or
'generation number v1'?

>        2 bits of the lowest byte, storing the 33rd and 34th bit of the
>        commit time.
>
> +  Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes) [Optional]

It is not exactly 'optional', as it implies that we need to turn it on
(or that we can turn it off).  It is more 'conditional', as it can be
not present due to outside influences (mixed-version environment).

> +    * This list of 4-byte values store corrected commit date offsets for=
 the
> +      commits, arranged in the same order as commit data chunk.

I have just realized purely theoretical, but possible, problem with
storing non-monotinic generation number related values like corrected
commit date offset in constrained space.  There are problems with
clamping them.

Say that somewhere in the ancestry chain there is a commit A with commit
date far in the future by mistake, for example 2120-08-22; it is
important for that date to be not able to be represented using uint32_t.
Say that a later descendant commit B is malformed, and has committer
date of 0, that is 1970-01-01. This means that the corrected commit date
for B must be larger than 2120-08-22 - which for this commit means that
corrected commit date offset do not fit in 32 bits, and must be clamped
(replaced) with GENERATION_NUMBER_V2_OFFSET_MAX.

Say that we have commit C that is child of B, and it has correct commit
date.  Because of mistake in commit A, it has corrected commit date of
more than 2120-08-22 (corrected commit date degenerated into topological
level plus constant).

Now C can reach B, and B can reach A.  However, if we recover corrected
commit date of B out of its date=3D0 and offset=3DGENERATION_NUMBER_V2_OFFS=
ET_MAX
we get a number that is smaller than correct corrected commit date.  We
will have

   gen(A) > date(B) + offset(B) < gen(C)

Which breaks reachability condition guarantee.

If instead we use GENERATION_NUMBER_V2_MAX for commits with clamped
corrected commit date, that is offset=3DGENERATION_NUMBER_V2_OFFSET_MAX,
we would get

  gen(A) < GENERATION_NUMBER_V2_MAX > gen(C)

And again reachability condition is broken.

This is a very contrived but possible example.  This shouldn't happen,
but ufortunately it can happen.


The question is how to deal with this issue.  Ignore it as unlikely?
Switch to storing corrected commit date, which is monotonic, so if there
is commit with GENERATION_NUMBER_V2_MAX, then subsequent descendant
commits will also have GENERATION_NUMBER_V2_MAX -- and pay with up to 7%
larger commit-graph file?

> +    * This list can be later modified to store future generation number =
related
> +      data.

How can it be later modified?  There is no header, no version number.
How would we add another generation number data?

> +
>    Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
>        This list of 4-byte values store the second through nth parents for
>        all octopus merges. The second parent value in the commit data sto=
res
> diff --git a/Documentation/technical/commit-graph.txt b/Documentation/tec=
hnical/commit-graph.txt
> index 808fa30b99..f27145328c 100644
> --- a/Documentation/technical/commit-graph.txt
> +++ b/Documentation/technical/commit-graph.txt
> @@ -38,14 +38,27 @@ A consumer may load the following info for a commit f=
rom the graph:
>
>  Values 1-4 satisfy the requirements of parse_commit_gently().
>
> -Define the "generation number" of a commit recursively as follows:
> +There are two definitions of generation number:
> +1. Corrected committer dates
> +2. Topological levels

Should we add versioning info, that is:

  +1. Corrected committer dates  (generation number v2)
  +2. Topological levels  (generation number v1)

> +
> +Define "corrected committer date" of a commit recursively as follows:
> +
> +  * A commit with no parents (a root commit) has corrected committer date
> +    equal to its committer date.
> +
> +  * A commit with at least one parent has corrected committer date equal=
 to
> +    the maximum of its commiter date and one more than the largest corre=
cted
> +    committer date among its parents.
> +
> +Define the "topological level" of a commit recursively as follows:
>
>   * A commit with no parents (a root commit) has generation number one.

Shouldn't this be

    * A commit with no parents (a root commit) has topological level of one.

>
> - * A commit with at least one parent has generation number one more than
> -   the largest generation number among its parents.
> + * A commit with at least one parent has topological level one more than
> +   the largest topological level among its parents.
>
> -Equivalently, the generation number of a commit A is one more than the
> +Equivalently, the topological level of a commit A is one more than the
>  length of a longest path from A to a root commit. The recursive definiti=
on
>  is easier to use for computation and observing the following property:

We should probably explicitly state that the property state applies to
both versions of generation number, not only to topological level.

>
> @@ -67,17 +80,12 @@ numbers, the general heuristic is the following:
>      If A and B are commits with commit time X and Y, respectively, and
>      X < Y, then A _probably_ cannot reach B.
>
> -This heuristic is currently used whenever the computation is allowed to
> -violate topological relationships due to clock skew (such as "git log"
> -with default order), but is not used when the topological order is
> -required (such as merge base calculations, "git log --graph").
> -

To be overly pedantic, this heuristic is still used, but now in much
more rare case.  In addition to what is stated above, at least one layer
in the split commit-graph chain must have been generated by "Old" Git,
for the date heuristic to be used.

But that might be unnecessary level of detail.

>  In practice, we expect some commits to be created recently and not stored
>  in the commit graph. We can treat these commits as having "infinite"
>  generation number and walk until reaching commits with known generation
>  number.
>
> -We use the macro GENERATION_NUMBER_INFINITY =3D 0xFFFFFFFF to mark commi=
ts not
> +We use the macro GENERATION_NUMBER_INFINITY to mark commits not

All right.

>  in the commit-graph file. If a commit-graph file was written by a version
>  of Git that did not compute generation numbers, then those commits will
>  have generation number represented by the macro GENERATION_NUMBER_ZERO =
=3D 0.
> @@ -93,12 +101,11 @@ fully-computed generation numbers. Using strict ineq=
uality may result in
>  walking a few extra commits, but the simplicity in dealing with commits
>  with generation number *_INFINITY or *_ZERO is valuable.
>
> -We use the macro GENERATION_NUMBER_MAX =3D 0x3FFFFFFF to for commits who=
se
> -generation numbers are computed to be at least this value. We limit at
> -this value since it is the largest value that can be stored in the
> -commit-graph file using the 30 bits available to generation numbers. This
> -presents another case where a commit can have generation number equal to
> -that of a parent.
> +We use the macro GENERATION_NUMBER_MAX for commits whose generation numb=
ers
> +are computed to be at least this value. We limit at this value since it =
is
> +the largest value that can be stored in the commit-graph file using the
> +available to generation numbers. This presents another case where a
> +commit can have generation number equal to that of a parent.

All right, though it could have been done without re-wrapping, so that
only first line would be marked as changed.

As I wrote, there is theoretical problem with this for offsets.

>
>  Design Details
>  --------------
> @@ -267,6 +274,12 @@ The merge strategy values (2 for the size multiple, =
64,000 for the maximum
>  number of commits) could be extracted into config settings for full
>  flexibility.
>
> +We also merge commit-graph chains when we try to write a commit graph wi=
th
> +two different generation number definitions as they cannot be compared d=
irectly.
> +We overwrite the existing chain and create a commit-graph with the newer=
 or more
> +efficient defintion. For example, overwriting topological levels commit =
graph
> +chain to create a corrected commit dates commit graph chain.
> +

This is more complicated than that.

I think we should explicitly state that Git ensures that in split
commit-graph chain, if there are layers without the GDAT chunk (that
force Git to use topological levels for generation numbers), then they
are top layers.  So if there is commit-graph file created by "Old" Git,
then when addig new layer it would also be GDAT-less.

Now how to write this...

>  ## Deleting graph-{hash} files
>
>  After a new tip file is written, some `graph-{hash}` files may no longer

Best,
--=20
Jakub Nar=C4=99bski
