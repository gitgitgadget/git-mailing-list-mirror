Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECB0C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 11:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8348720738
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 11:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXxEN8qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHULFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgHULFW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 07:05:22 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1434EC061385
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 04:05:22 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 185so1380660ljj.7
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 04:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=H8yZNtz5AJ7z47i2IsisYOGCwSY8IlgWxFfoaRYzCEY=;
        b=aXxEN8qqXxBvPiyY6QMsIR5cK8qOMuCytOhuhRWq9HFEXMP8h9m4MUPU1mNOwPaMZh
         4Y2U6su8zC3YJqC3rSWk9NwQzkO1eVzv7ST818XQSqwI/qnVF9vcOvS1qJbOzwpATvb1
         PqRLzrVAxHKFeuftaDS2K5GHPK9siMBSqjEeAnBGKHaZ6+9B9LyeSBjR2xKSkw1bNBty
         DrgNrV+mn8MptKNimOHgq8RGHjqEG8XeoTSAQWCV5UmXC1EbwrXxxOQXZcfBI1UhQD6p
         QiVoSARArU4wIUNCjUKId9aU7bI8w1zlStUdRau6Z0ynF1PZ5OeEjEr88N9tASFC6qt+
         r0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=H8yZNtz5AJ7z47i2IsisYOGCwSY8IlgWxFfoaRYzCEY=;
        b=gLCDadqRfVf/z1DryBROqjLpOBqMDv5V9JgQDin0jM7WPr5lpbfsNVrwXI7vAZ0SBF
         x7vidVGRWoQKOsXOUSj7DP0CzB7qQ+8WyrQdx+Zku+zTeF6R5mkiH2LNS8dcZ7UhUDWn
         5of7uzLzzN9ydSJJ5zWx6CqMX4iFlA7PCu2rtcN6hPb/eoKajdb83Fh10bQL4+PsKH91
         78p1JiCmIDEh6XKHAYpTcSym1fOOqtvm0KNlUDquSYQMmT82yLJlfi8jZq0hDa4WQsdv
         F+V7rbKyXaPhMJVA0F88vsZew4U0KFeOWSPuPbAVrQVXE8f198b80U4oD2wr43Wawg3W
         X08Q==
X-Gm-Message-State: AOAM532YuobiqGR3OjO7E5KbEMKsdOdOwkm/oEBQLr1yx06UhzgX6+hG
        EhALq+M1N9o6/TAga/Qtnlxao1as2bmoQw==
X-Google-Smtp-Source: ABdhPJzM9PkYK2T8lVO2CbhpJfHeog0TUbnNdarAvuarKJfaEhJoxUeQu9qAogNbNL4ifyAVx5cySA==
X-Received: by 2002:a2e:9913:: with SMTP id v19mr1206780lji.292.1598007920298;
        Fri, 21 Aug 2020 04:05:20 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id a21sm311521ljh.114.2020.08.21.04.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 04:05:19 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 04/11] commit-graph: consolidate compare_commits_by_gen
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <6a0cde983d9ed20f043a4977313d714154602012.1597509583.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 13:05:19 +0200
In-Reply-To: <6a0cde983d9ed20f043a4977313d714154602012.1597509583.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Sat, 15 Aug 2020 16:39:36
        +0000")
Message-ID: <85sgcgmf80.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> Comparing commits by generation has been independently defined twice, in
> commit-reach and commit. Let's simplify the implementation by moving
> compare_commits_by_gen() to commit-graph.

All right, seems reasonable.

Though it might be not obvious that the second repetition of code
comparing commits by generation is part of commit.c's
compare_commits_by_gen_then_commit_date().

Is't it micro-pessimization though, or can the compiler inline function
across different files?  On the other hand it reduces code duplication...

>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> Reviewed-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c | 15 +++++++++++++++
>  commit-graph.h |  2 ++
>  commit-reach.c | 15 ---------------
>  commit.c       |  9 +++------
>  4 files changed, 20 insertions(+), 21 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index af8d9cc45e..fb6e2bf18f 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -112,6 +112,21 @@ uint32_t commit_graph_generation(const struct commit=
 *c)
>  	return data->generation;
>  }
>
> +int compare_commits_by_gen(const void *_a, const void *_b)
> +{
> +	const struct commit *a =3D _a, *b =3D _b;
> +	const uint32_t generation_a =3D commit_graph_generation(a);
> +	const uint32_t generation_b =3D commit_graph_generation(b);

All right, this function used protected access to generation number of a
commit, that is it correctly handles the case where commit '_a' and/or
'_b' are new enough to be not present in the commit graph.

That is why we cannot simply use commit_gen_cmp(), that is the function
used for sorting during `git commit-graph write --reachable --changed-paths=
`,
because after 1st patch it access the slab directly.

> +
> +	/* older commits first */

Nice!  Thanks for adding this comment.

Though it might be good idea to add this comment also to the header
file, commit-graph.h, because the fact that compare_commits_by_gen()
and compare_commits_by_gen_then_commit_date() sort in different
order is not something that we can see from their names.  Well,
they have slightly different sigatures...

> +	if (generation_a < generation_b)
> +		return -1;
> +	else if (generation_a > generation_b)
> +		return 1;
> +
> +	return 0;
> +}
> +
>  static struct commit_graph_data *commit_graph_data_at(const struct commi=
t *c)
>  {
>  	unsigned int i, nth_slab;
> diff --git a/commit-graph.h b/commit-graph.h
> index 09a97030dc..701e3d41aa 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -146,4 +146,6 @@ struct commit_graph_data {
>   */
>  uint32_t commit_graph_generation(const struct commit *);
>  uint32_t commit_graph_position(const struct commit *);
> +
> +int compare_commits_by_gen(const void *_a, const void *_b);

All right.

>  #endif
> diff --git a/commit-reach.c b/commit-reach.c
> index efd5925cbb..c83cc291e7 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -561,21 +561,6 @@ int commit_contains(struct ref_filter *filter, struc=
t commit *commit,
>  	return repo_is_descendant_of(the_repository, commit, list);
>  }
>
> -static int compare_commits_by_gen(const void *_a, const void *_b)
> -{
> -	const struct commit *a =3D *(const struct commit * const *)_a;
> -	const struct commit *b =3D *(const struct commit * const *)_b;
> -
> -	uint32_t generation_a =3D commit_graph_generation(a);
> -	uint32_t generation_b =3D commit_graph_generation(b);
> -
> -	if (generation_a < generation_b)
> -		return -1;
> -	if (generation_a > generation_b)
> -		return 1;
> -	return 0;
> -}

All right, commit-reach.c includes commit-graph.h, so now it simply uses
compare_commits_by_gen() that was copied to commit-graph.c.

> -
>  int can_all_from_reach_with_flag(struct object_array *from,
>  				 unsigned int with_flag,
>  				 unsigned int assign_flag,
> diff --git a/commit.c b/commit.c
> index 4ce8cb38d5..bd6d5e587f 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -731,14 +731,11 @@ int compare_commits_by_author_date(const void *a_, =
const void *b_,
>  int compare_commits_by_gen_then_commit_date(const void *a_, const void *=
b_, void *unused)
>  {
>  	const struct commit *a =3D a_, *b =3D b_;
> -	const uint32_t generation_a =3D commit_graph_generation(a),
> -		       generation_b =3D commit_graph_generation(b);
> +	int ret_val =3D compare_commits_by_gen(a_, b_);
>
>  	/* newer commits first */

Maybe this comment should be put in the header file, near this functionn
declaration?

> -	if (generation_a < generation_b)
> -		return 1;
> -	else if (generation_a > generation_b)
> -		return -1;
> +	if (ret_val)
> +		return -ret_val;

All right, this handles reversed sorting order of compare_commits_by_gen().

>
>  	/* use date as a heuristic when generations are equal */
>  	if (a->date < b->date)

Best,
--=20
Jakub Nar=C4=99bski
