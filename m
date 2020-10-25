Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFADEC388F7
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 10:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C47D223B0
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 10:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a47WZhNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415276AbgJYKwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 06:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405705AbgJYKwq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 06:52:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09E2C0613CE
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 03:52:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 23so6611477ljv.7
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 03:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-transfer-encoding;
        bh=eUQ0LJHQV5hJHyEohR6GCwVt03gcTDWj1/lhDFOelUs=;
        b=a47WZhNUYJdan/WeUYL+nE7JzwMBt235t94oTvXrXDAFmygAX/bX+WsB5YbJX0bQ/f
         tEitTx2zJs3UqhfRhENSXKHJ3bb1F2VIxo7PDLqQqB4ccdAYOHx1xVgdOcKe1cpUtRXD
         0c0/kwcfgHStiCNm4H5M2yRlLmXnQ0s5Fz2kjOqSSDUrZn7SLwvvxlhj/eKOZOu7UPcD
         zW7YPaBLBYU/JA1sL8nt0/MwIek9Yvlw7GxzcxiSAIQLsjBdxOZd4EkNUkPivdvKn2KQ
         BnGykYdDFV1mt38XLtAt2KzSOrIPS02p+zEJglaFTd79ElBUsGvoGRIEwm+HdeUHTDFF
         pebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-transfer-encoding;
        bh=eUQ0LJHQV5hJHyEohR6GCwVt03gcTDWj1/lhDFOelUs=;
        b=frhqubLJW66PkrflgK5k7bt1qJHvcZ5VaZF4ueb6zk/srxel0egkI2e/EA+fOhxpfI
         GTE7W3DomjzkEKa4J3vFrLLCmaPhhf7qTMe9tgh801MHcFCSj9JOJDVfvkRU6Ymjluik
         1rAW3Ub2kD2CCPX3qing0EYaXucEoV3UO7RK2/vFv6PZsQXUnXUMG6ImC3LN0nrRFZXG
         u2+SMo8y1qe3CLvOPXMTknqbWiZPas4v8JVmXXP8YXpOIBLWp8CZE5rBXqwWh/PXhy9U
         MrJ2JUW6WXGQvjebrbTua3F3ooKcmHr/5p5PogM2bleqa0a7FK9247pT3x2U9KmAVoWr
         sSkg==
X-Gm-Message-State: AOAM532R05g6fNmeUURM5exR9MSvlqTS8t6uaMHCZAiN01hLCjJPxvwy
        IrB9XxrB1Ug17bMlwTnUZ+k=
X-Google-Smtp-Source: ABdhPJxo6cr0Y0nEorfxq4W4LzwwQbvHz/E1uGeQQ/govhlgbZPS10eYfJWgW+etg/vDosNE5oudiw==
X-Received: by 2002:a2e:3016:: with SMTP id w22mr3724438ljw.248.1603623164238;
        Sun, 25 Oct 2020 03:52:44 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id s17sm695691lfp.292.2020.10.25.03.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 03:52:43 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH v4 03/10] commit-graph: consolidate fill_commit_graph_info
In-Reply-To: <18bb3318a12c859c21c8e95285d551c48d31b54b.1602079786.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Wed, 07 Oct 2020 14:09:38
        +0000")
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <18bb3318a12c859c21c8e95285d551c48d31b54b.1602079786.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
Date:   Sun, 25 Oct 2020 11:52:42 +0100
Message-ID: <85blgq4lxh.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhishek,

In short: everything is all right, except for the now duplicated test
names in t5000 after this commit.

"Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> Both fill_commit_graph_info() and fill_commit_in_graph() parse
> information present in commit data chunk. Let's simplify the
> implementation by calling fill_commit_graph_info() within
> fill_commit_in_graph().
>
> fill_commit_graph_info() used to not load committer data from commit data
> chunk. However, with the corrected committer date, we have to load
> committer date to calculate generation number value.

Nice writeup, however the last sentence would in my opinion read better
in the future tense: we don't use generation number v2 yet.  For
example:

  However, with upcoming switch to using corrected committer date as
  generation number v2, we will have to load committer date to compute
  generation number value anyway.

Or something like that - notice the minor addition and changes.

The following is slightly unrelated change, but we agreed that it would
be better to not separate them; the need for change to the t5000 test is
caused by the change described above.

>
> e51217e15 (t5000: test tar files that overflow ustar headers,
> 30-06-2016) introduced a test 'generate tar with future mtime' that
> creates a commit with committer date of (2 ^ 36 + 1) seconds since
> EPOCH. The CDAT chunk provides 34-bits for storing committer date, thus
> committer time overflows into generation number (within CDAT chunk) and
> has undefined behavior.
>
> The test used to pass as fill_commit_graph_info() would not set struct
> member `date` of struct commit and loads committer date from the object
> database, generating a tar file with the expected mtime.

I think it should be s/loads/load/, as in "would load", but I am not a
native English speaker.

>
> However, with corrected commit date, we will load the committer date
> from CDAT chunk (truncated to lower 34-bits to populate the generation
> number. Thus, Git sets date and generates tar file with the truncated
> mtime.
>
> The ustar format (the header format used by most modern tar programs)
> only has room for 11 (or 12, depending om some implementations) octal
> digits for the size and mtime of each files.
>
> Thus, setting a timestamp of 2 ^ 33 + 1 would overflow the 11-octal
> digit implementations while still fitting into commit data chunk.
>
> Since we want to test 12-octal digit implementations of ustar as well,
> let's modify the existing test to no longer use commit-graph file.

The description above is for me does not make it entirely clear that we
add new test for handling possible 11-octal digit overflow nearly
identical to the existing one, and turn off use of commit-graph file for
test that checks handling 12-octal digit overflow.

> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c      | 27 ++++++++++-----------------
>  t/t5000-tar-tree.sh | 20 +++++++++++++++++++-
>  2 files changed, 29 insertions(+), 18 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 94503e584b..e8362e144e 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -749,15 +749,24 @@ static void fill_commit_graph_info(struct commit *i=
tem, struct commit_graph *g,
>  	const unsigned char *commit_data;
>  	struct commit_graph_data *graph_data;
>  	uint32_t lex_index;
> +	uint64_t date_high, date_low;
>=20=20
>  	while (pos < g->num_commits_in_base)
>  		g =3D g->base_graph;
>=20=20
> +	if (pos >=3D g->num_commits + g->num_commits_in_base)
> +		die(_("invalid commit position. commit-graph is likely corrupt"));
> +
>  	lex_index =3D pos - g->num_commits_in_base;
>  	commit_data =3D g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
>=20=20
>  	graph_data =3D commit_graph_data_at(item);
>  	graph_data->graph_pos =3D pos;
> +
> +	date_high =3D get_be32(commit_data + g->hash_len + 8) & 0x3;
> +	date_low =3D get_be32(commit_data + g->hash_len + 12);
> +	item->date =3D (timestamp_t)((date_high << 32) | date_low);
> +
>  	graph_data->generation =3D get_be32(commit_data + g->hash_len + 8) >> 2;
>  }
>=20=20
> @@ -772,38 +781,22 @@ static int fill_commit_in_graph(struct repository *=
r,
>  {
>  	uint32_t edge_value;
>  	uint32_t *parent_data_ptr;
> -	uint64_t date_low, date_high;
>  	struct commit_list **pptr;
> -	struct commit_graph_data *graph_data;
>  	const unsigned char *commit_data;
>  	uint32_t lex_index;
>=20=20
>  	while (pos < g->num_commits_in_base)
>  		g =3D g->base_graph;
>=20=20
> -	if (pos >=3D g->num_commits + g->num_commits_in_base)
> -		die(_("invalid commit position. commit-graph is likely corrupt"));
> +	fill_commit_graph_info(item, g, pos);
>=20=20
> -	/*
> -	 * Store the "full" position, but then use the
> -	 * "local" position for the rest of the calculation.
> -	 */
> -	graph_data =3D commit_graph_data_at(item);
> -	graph_data->graph_pos =3D pos;
>  	lex_index =3D pos - g->num_commits_in_base;
> -
>  	commit_data =3D g->chunk_commit_data + (g->hash_len + 16) * lex_index;
>=20=20
>  	item->object.parsed =3D 1;
>=20=20
>  	set_commit_tree(item, NULL);
>=20=20
> -	date_high =3D get_be32(commit_data + g->hash_len + 8) & 0x3;
> -	date_low =3D get_be32(commit_data + g->hash_len + 12);
> -	item->date =3D (timestamp_t)((date_high << 32) | date_low);
> -
> -	graph_data->generation =3D get_be32(commit_data + g->hash_len + 8) >> 2;
> -
>  	pptr =3D &item->parents;
>=20=20
>  	edge_value =3D get_be32(commit_data + g->hash_len);

All right, looks good for me.

Here second change begins.

> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 3ebb0d3b65..8f41cdc509 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -431,11 +431,29 @@ test_expect_success TAR_HUGE,LONG_IS_64BIT 'system =
tar can read our huge size' '
>  	test_cmp expect actual
>  '
>=20=20
> +test_expect_success TIME_IS_64BIT 'set up repository with far-future com=
mit' '
> +	rm -f .git/index &&
> +	echo foo >file &&
> +	git add file &&
> +	GIT_COMMITTER_DATE=3D"@17179869183 +0000" \
> +		git commit -m "tempori parendum"
> +'
> +
> +test_expect_success TIME_IS_64BIT 'generate tar with future mtime' '
> +	git archive HEAD >future.tar
> +'
> +
> +test_expect_success TAR_HUGE,TIME_IS_64BIT,TIME_T_IS_64BIT 'system tar c=
an read our future mtime' '
> +	echo 2514 >expect &&
> +	tar_info future.tar | cut -d" " -f2 >actual &&
> +	test_cmp expect actual
> +'
> +

Everything is all right, except we now have duplicated test names.

Perhaps in the three following tests we should use 'far-far-future
commit' and 'far future mtime' in place of current 'far-future commit'
and 'future mtime' for tests checking handling 12-digital ditgits
overflow, or add description how far the future is, for example
'far-future commit (2^11 + 1)', etc.

>  test_expect_success TIME_IS_64BIT 'set up repository with far-future com=
mit' '
>  	rm -f .git/index &&
>  	echo content >file &&
>  	git add file &&
> -	GIT_COMMITTER_DATE=3D"@68719476737 +0000" \
> +	GIT_TEST_COMMIT_GRAPH=3D0 GIT_COMMITTER_DATE=3D"@68719476737 +0000" \
>  		git commit -m "tempori parendum"
>  '

Best,
--=20
Jakub Nar=C4=99bski
