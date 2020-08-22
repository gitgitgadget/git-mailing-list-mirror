Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35D3C433DF
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 19:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7751E2075E
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 19:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5cF/qqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgHVTJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 15:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbgHVTJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Aug 2020 15:09:25 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D06C061573
        for <git@vger.kernel.org>; Sat, 22 Aug 2020 12:09:25 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g6so5350871ljn.11
        for <git@vger.kernel.org>; Sat, 22 Aug 2020 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=gU9Lmi9AgwOxm9jSUAk3LG7Be+j0mUqShNHSslrBkCw=;
        b=C5cF/qqWbi9LE1H5QA+ZChyDD2V3MOwGQTbYtoY4CoUT0xUapJq1RLo5VbfU82lUBv
         V6ejYm2q4zCOKCZZQkSjFTx0CUjq17JmO+A6rz6HuCt5z80GdS6isV0nVYBn6Nmx8aH0
         ceIGR0eidYujdF86fsysg02RhlhG4F2UUufq/AQoPGatwWFfMQHVKr7vB8QpsB8ihG55
         kgwKQ2J68UR96JIrMgc7dgQzcqZfA5zLprTbif4J8FQmqzksj2YR2O4IBjMop5ZDcOkE
         tb5Y31CaOPr0S2QQ+1NTci0Bo8xn7YVLazQ5ar1OQB5ZLx4mFIQF8t7ZLzJ6P5ijjqZT
         2a2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=gU9Lmi9AgwOxm9jSUAk3LG7Be+j0mUqShNHSslrBkCw=;
        b=Qw8UX/v7HIVqcihe4NY5Owr8+ex30QWuTLfW7C0juF1ZXeoGa9MM3CmN2qCnDRwAEE
         L9VffM1Q148ElzkggIeCN5P6fhpvUeyzuPLkmMW7w8eg/8vQoPLvtgtSVoJjBexsV567
         aH8s8lv0kyuo99ll4XxmgziogPpduGKQbDzL5L9yZ0+Ra73h5CDFA/MSRkdJGnHTc7zO
         sL8KjwCsp6ZJz/4mXuW8kLZnPQaQF8upmIzaEVVIrj1O5ZtnjYKWmZt+mT16ZZXjo1yp
         h6Gr5xFxTGozyvRD5a9RNnjU0mcZhtDcbEFg4ZUJVL6IPmijayPg3El2p0w2oMdhHCC5
         CLIQ==
X-Gm-Message-State: AOAM531ZqUdqmtsR97pkgXE3m0gDDC7dGvWu6z/6Uq9OPmLwB2+P9XXE
        wEcdKljbIpe/OHzbtq1/k40=
X-Google-Smtp-Source: ABdhPJyPYYEUTCcT428dKRuLQ1Z5rRMY41jhdjDq8eL/VGkWX0wHkkXsHx4hPNsEIuBGZjOkXFFYng==
X-Received: by 2002:a2e:9a15:: with SMTP id o21mr4138161lji.419.1598123363386;
        Sat, 22 Aug 2020 12:09:23 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id x17sm1176406ljm.0.2020.08.22.12.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 12:09:22 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 10/11] commit-reach: use corrected commit dates in paint_down_to_common()
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <439adc1718d6cc37f18c1eaeafd605f5c2961733.1597509583.git.gitgitgadget@gmail.com>
Date:   Sat, 22 Aug 2020 21:09:21 +0200
In-Reply-To: <439adc1718d6cc37f18c1eaeafd605f5c2961733.1597509583.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Sat, 15 Aug 2020 16:39:42
        +0000")
Message-ID: <85imdah50e.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Abhishek,

"Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> With corrected commit dates implemented, we no longer have to rely on
> commit date as a heuristic in paint_down_to_common().

All right, but it would be nice to have some benchmark data: what were
performance when using topological levels, what was performance when
using commit date heuristics (before this patch), what is performace now
when using corrected commit date.

>
> t6024-recursive-merge setups a unique repository where all commits have
> the same committer date without well-defined merge-base. As this has
> already caused problems (as noted in 859fdc0 (commit-graph: define
> GIT_TEST_COMMIT_GRAPH, 2018-08-29)), we disable commit graph within the
> test script.

OK?

>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c             | 14 ++++++++++++++
>  commit-graph.h             |  6 ++++++
>  commit-reach.c             |  2 +-
>  t/t6024-recursive-merge.sh |  4 +++-
>  4 files changed, 24 insertions(+), 2 deletions(-)
>

I have reorderd files for easier review.

> diff --git a/commit-graph.h b/commit-graph.h
> index 3cf89d895d..e22ec1e626 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -91,6 +91,12 @@ struct commit_graph *parse_commit_graph(void *graph_ma=
p, size_t graph_size);
>   */
>  int generation_numbers_enabled(struct repository *r);
>
> +/*
> + * Return 1 if and only if the repository has a commit-graph
> + * file and generation data chunk has been written for the file.
> + */
> +int corrected_commit_dates_enabled(struct repository *r);
> +
>  enum commit_graph_write_flags {
>  	COMMIT_GRAPH_WRITE_APPEND     =3D (1 << 0),
>  	COMMIT_GRAPH_WRITE_PROGRESS   =3D (1 << 1),

All right.

> diff --git a/commit-graph.c b/commit-graph.c
> index c1292f8e08..6411068411 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -703,6 +703,20 @@ int generation_numbers_enabled(struct repository *r)
>  	return !!first_generation;
>  }
>
> +int corrected_commit_dates_enabled(struct repository *r)
> +{
> +	struct commit_graph *g;
> +	if (!prepare_commit_graph(r))
> +		return 0;
> +
> +	g =3D r->objects->commit_graph;
> +
> +	if (!g->num_commits)
> +		return 0;
> +
> +	return !!g->chunk_generation_data;
> +}

The previous commit introduced validate_mixed_generation_chain(), which
walked whole split commit-graph chain, and set `read_generation_data`
field in `struct commit_graph` for all layers in the chain.

This function examines only the top layer, so it follows the assumption
that Git would behave in such way that oly topmost layers in the chai
can be GDAT-less.

Why the difference?  Couldn't validate_mixed_generation_chain() simply
call corrected_commit_dates_enabled()?

> +
>  static void close_commit_graph_one(struct commit_graph *g)
>  {
>  	if (!g)
> diff --git a/commit-reach.c b/commit-reach.c
> index 470bc80139..3a1b925274 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -39,7 +39,7 @@ static struct commit_list *paint_down_to_common(struct =
repository *r,
>  	int i;
>  	timestamp_t last_gen =3D GENERATION_NUMBER_INFINITY;
>
> -	if (!min_generation)

This check was added in 091f4cf (commit: don't use generation numbers if
not needed, 2018-08-30) by Derrick Stolee, and its commit message
includes benchmark results for running 'git merge-base v4.8 v4.9' in
Linux kernel repository:

      v2.18.0: 0.122s    167,468 walked
  v2.19.0-rc1: 0.547s    635,579 walked
         HEAD: 0.127s

> +	if (!min_generation && !corrected_commit_dates_enabled(r))
>  		queue.compare =3D compare_commits_by_commit_date;

It would be nice to have similar benchmark for this change... unless of
course there is no change in performance, but I think then it needs to
be stated explicitly.  I think.

>
>  	one->object.flags |=3D PARENT1;
> diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
> index 332cfc53fd..d3def66e7d 100755
> --- a/t/t6024-recursive-merge.sh
> +++ b/t/t6024-recursive-merge.sh
> @@ -15,6 +15,8 @@ GIT_COMMITTER_DATE=3D"2006-12-12 23:28:00 +0100"
>  export GIT_COMMITTER_DATE
>
>  test_expect_success 'setup tests' '
> +	GIT_TEST_COMMIT_GRAPH=3D0 &&
> +	export GIT_TEST_COMMIT_GRAPH &&
>  	echo 1 >a1 &&
>  	git add a1 &&
>  	GIT_AUTHOR_DATE=3D"2006-12-12 23:00:00" git commit -m 1 a1 &&
> @@ -66,7 +68,7 @@ test_expect_success 'setup tests' '
>  '
>
>  test_expect_success 'combined merge conflicts' '
> -	test_must_fail env GIT_TEST_COMMIT_GRAPH=3D0 git merge -m final G
> +	test_must_fail git merge -m final G
>  '
>
>  test_expect_success 'result contains a conflict' '

OK, so instead of disabling commit-graph for this test, now we disable
it for the whole script.

Maybe this change should be in a separate patch?

Best,
--=20
Jakub Nar=C4=99bski
