Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0E301F404
	for <e@80x24.org>; Sun, 29 Apr 2018 09:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeD2JIU (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 05:08:20 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:53691 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeD2JIS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 05:08:18 -0400
Received: by mail-wm0-f41.google.com with SMTP id a67so1080778wmf.3
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 02:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=dEvIBNXNgnNBupZxjBFUxHrJWPLVfUqdtDKgWg4c5yo=;
        b=hR8wYsrIbfuWSgti1ufkXLQb4C2oEKIjlYkfPJK3bJP2sMXZ/i5hhSL3aTqnJ5u1Is
         BetlCwjNTxOnwLjjff37GMeivhDstJSWw+gtqePMDA9D+Ffu/TcXzB/m2x6nWEOM1mCk
         E2izXovMYMwh4/z8lUksJgJvxSmuP5SZtr4NApDhOOxKna0K6/8GtDy4na+5754UuPXr
         y5Y9gqiqzP+TeH35dkp0SKkykt0qfZMi/dgYrwEgtIFpT8IRNaL3E+JKOrRqgufWyFJV
         te/7CeK2auQOT4GgByMqD3piP5S0Z+Fl3ymty1ZISZQCJ9/0hNjmjVRAbLTjAs0SoPxZ
         8exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=dEvIBNXNgnNBupZxjBFUxHrJWPLVfUqdtDKgWg4c5yo=;
        b=MLzS2EGFSMTbOuwq1uHnTS99D8UslWuUsebbnLOcWLPUi18QJtqYIh9jp1CbYAxFTl
         j0RfupxAPKddB+rWkWqDZtQfDStI4ViZXokYTnx4JQ3ploj2WLPjDno2fcFS8Xl+DXkJ
         Z/J8JA5pmy+vyTqMaMHPmqzAdWzQuMrZEt0guykgGqfsgaesj0eVunxYDnE/VezbH5Fs
         TDOcKSY96aT+sp1ttVBrN3YdJSr8OtexbDf4Od7A0Ribpx1U2oOo4CBKSxXuV21U5ScH
         GkhHxYfHiddEnH/SCwDTZTMN26jR4muXa9B05GTAq8m/hHoiBEsbSDvmJ6v7Ra4GDWXx
         rIwA==
X-Gm-Message-State: ALQs6tDsaVG2Aj81Nm54lAl1u8hSxNoIM4B5efgA1qfVBpPiOu71saTg
        JQ8kRjL1Yl8oXTCoPL79ggwKKAv6
X-Google-Smtp-Source: AB8JxZqK7p3mpLxBHOYVeF/XD4p27vQB1rcjA+EtbxYUmpQYF5HXmvMNRRMTEoojRbieGHYn0JGYjA==
X-Received: by 10.28.149.131 with SMTP id x125mr5311957wmd.56.1524992897092;
        Sun, 29 Apr 2018 02:08:17 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abps22.neoplus.adsl.tpnet.pl. [83.8.60.22])
        by smtp.gmail.com with ESMTPSA id y101sm7278519wmh.10.2018.04.29.02.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Apr 2018 02:08:16 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "peff\@peff.net" <peff@peff.net>,
        "avarab\@gmail.com" <avarab@gmail.com>
Subject: Re: [PATCH v4 03/10] commit-graph: compute generation numbers
References: <20180417170001.138464-1-dstolee@microsoft.com>
        <20180425143735.240183-1-dstolee@microsoft.com>
        <20180425143735.240183-4-dstolee@microsoft.com>
Date:   Sun, 29 Apr 2018 11:08:13 +0200
In-Reply-To: <20180425143735.240183-4-dstolee@microsoft.com> (Derrick Stolee's
        message of "Wed, 25 Apr 2018 14:37:56 +0000")
Message-ID: <86r2myidmq.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> While preparing commits to be written into a commit-graph file, compute
> the generation numbers using a depth-first strategy.

Sidenote: for generation numbers it does not matter if we use
depth-first or breadth-first strategy, but it is more natural to use
depth-first search because generation numbers need post-order processing
(parents before child).

>
> The only commits that are walked in this depth-first search are those
> without a precomputed generation number. Thus, computation time will be
> relative to the number of new commits to the commit-graph file.

A question: what happens if the existing commit graph is from older
version of git and has _ZERO for generation numbers?

Answer: I see that we treat both _INFINITY (not in commit-graph) and
_ZERO (in commit graph but not computed) as not computed generation
numbers.  All right.

>
> If a computed generation number would exceed GENERATION_NUMBER_MAX, then
> use GENERATION_NUMBER_MAX instead.

All right, though I guess this would remain theoretical for a long
while.

We don't have any way of testing this, at least not without recompiling
Git with lower value of GENERATION_NUMBER_MAX -- which means not
automatically, isn't it?

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 9ad21c3ffb..047fa9fca5 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -439,6 +439,9 @@ static void write_graph_chunk_data(struct hashfile *f=
, int hash_len,
>  		else
>  			packedDate[0] =3D 0;
>=20=20
> +		if ((*list)->generation !=3D GENERATION_NUMBER_INFINITY)
> +			packedDate[0] |=3D htonl((*list)->generation << 2);
> +

If we stumble upon commit marked as "not in commit-graph" while writing
commit graph, it is a BUG(), isn't it?

(Problem noticed by Junio.)

It is a bit strange to me that the code uses get_be32 for reading, but
htonl for writing.  Is Git tested on non little-endian machines, like
big-endian ppc64 or s390x, or on mixed-endian machines (or
selectable-endian machines with data endianness set to non
little-endian, like ia64)?  If not, could we use for example openSUSE
Build Service (https://build.opensuse.org/) for this?

>  		packedDate[1] =3D htonl((*list)->date);
>  		hashwrite(f, packedDate, 8);
>=20=20
> @@ -571,6 +574,46 @@ static void close_reachable(struct packed_oid_list *=
oids)
>  	}
>  }
>=20=20
> +static void compute_generation_numbers(struct commit** commits,
> +				       int nr_commits)
> +{
> +	int i;
> +	struct commit_list *list =3D NULL;

All right, commit_list will work as stack.

> +
> +	for (i =3D 0; i < nr_commits; i++) {
> +		if (commits[i]->generation !=3D GENERATION_NUMBER_INFINITY &&
> +		    commits[i]->generation !=3D GENERATION_NUMBER_ZERO)
> +			continue;

All right, we consider _INFINITY and _SERO as not computed.  If
generation number is computed (by 'recursion' or from commit graph), we
(re)use it.  This means that generation number calculation is
incremental, as intended -- good.

> +
> +		commit_list_insert(commits[i], &list);

Start depth-first walks from commits given.

> +		while (list) {
> +			struct commit *current =3D list->item;
> +			struct commit_list *parent;
> +			int all_parents_computed =3D 1;

Here all_parents_computed is a boolean flag.  I see that it is easier to
start with assumption that all parents will have computed generation
numbers.

> +			uint32_t max_generation =3D 0;

The generation number value of 0 functions as sentinel; generation
numbers start from 1.  Not that it matters much, as lowest possible
generation number is 1, and we could have started from that value.

> +
> +			for (parent =3D current->parents; parent; parent =3D parent->next) {
> +				if (parent->item->generation =3D=3D GENERATION_NUMBER_INFINITY ||
> +				    parent->item->generation =3D=3D GENERATION_NUMBER_ZERO) {
> +					all_parents_computed =3D 0;
> +					commit_list_insert(parent->item, &list);
> +					break;

If some parent doesn't have generation number calculated, we add it to
stack (and break out of loop because it is depth-first walk), and mark
this situation.  All right.

> +				} else if (parent->item->generation > max_generation) {
> +					max_generation =3D parent->item->generation;

Otherwise, update max_generation.  All right.

> +				}
> +			}
> +
> +			if (all_parents_computed) {
> +				current->generation =3D max_generation + 1;
> +				pop_commit(&list);
> +			}
> +
> +			if (current->generation > GENERATION_NUMBER_MAX)
> +				current->generation =3D GENERATION_NUMBER_MAX;

This conditional should be inside all_parents_computed test, for example
like this:

  +			if (all_parents_computed) {
  +				current->generation =3D max_generation + 1;
  +				if (current->generation > GENERATION_NUMBER_MAX)
  +					current->generation =3D GENERATION_NUMBER_MAX;
  +
  +				pop_commit(&list);
  +			}

(Noticed by Junio.)

Sidenote: when we revisit the commit, returning from depth-first walk of
one of its parents, we calculate max_generation from scratch again.
This does not matter for performance, as it's just data access and
calculating maximum - any workaround to not restart those calculations
would take more time and memory.  And it's simple.

> +		}
> +	}
> +}
> +
>  void write_commit_graph(const char *obj_dir,
>  			const char **pack_indexes,
>  			int nr_packs,
> @@ -694,6 +737,8 @@ void write_commit_graph(const char *obj_dir,
>  	if (commits.nr >=3D GRAPH_PARENT_MISSING)
>  		die(_("too many commits to write graph"));
>=20=20
> +	compute_generation_numbers(commits.list, commits.nr);
> +

Nice and simple.  All right.

I guess that we do not pass "struct packed_commit_list commits" as
argument to compute_generation_numbers instead of "struct commit**
commits.list" and "int commits.nr" to compute_generation_numbers() to
keep the latter nice and generic?

>  	graph_name =3D get_commit_graph_filename(obj_dir);
>  	fd =3D hold_lock_file_for_update(&lk, graph_name, 0);

Best,
--=20
Jakub Nar=C4=99bski
