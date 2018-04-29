Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFF681F428
	for <e@80x24.org>; Sun, 29 Apr 2018 22:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754163AbeD2WPG (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 18:15:06 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38524 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752210AbeD2WPF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 18:15:05 -0400
Received: by mail-wr0-f194.google.com with SMTP id 94-v6so5070427wrf.5
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 15:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=iIgI9RzTXqsi3Y/RmTw+ASEBqj1iFefurz3Zcga8N+s=;
        b=ZKGjMdBEzgAq1YuM041n1E93e05AITfAoTcCgv2wzRXRFu0lkGGwzypMMGhY8O91Bb
         DYW4kli2f+dZvb/RZTr9HTtkEyGq7M6LPqyTqIdHtNlthIF95kQuDOurqd2KPCQV3vCf
         nOpACiwGU/7bg8f1/Bf8xnBD5UbTe2zL1GnJN92uOym5TooXewCvCs7vDCTQaCFlOSVm
         nxv7NG2BypAVFOXTpmcanUOOiPg3B8C1rzSX83l0FMkWis9bOtC78EMYaS6WnSj8zqbu
         gbW7kxwxeGJDYhlhWPvJ1BwnbOSDX6Zi8+UuzpMbTRObpZ9e7OjFb9xQag82KdGZA1fA
         2j3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=iIgI9RzTXqsi3Y/RmTw+ASEBqj1iFefurz3Zcga8N+s=;
        b=bpnG2cXIR3EYb6+U+kcTZGtEudJRufDGJugmAVshQYTFuPr0Nw+dyWIrgibZN6Ztpr
         +5EI/EKC//SKhR+qASAFkMXBRbsNd8YKuWm+hfu7EwMkmGhJCGZMZ3kkvCUMVSObOi4e
         cprR9emwPqPoZ1wsDOztSL8t0DcRSpX4m743XgOzr4xBwzmec0Msn6CmOlKazNYUgxEi
         eUYgUowGeHtHAG9XDOwBQLZdJzQE180N7weTSWpQi5yQP80ZcimBns16lcSSox0H2G/C
         JzXZoZvr6wi5nDjS31yThJiKuuY/+k4jzI1O0E3LWPhTFjyOuF2Yx8XsCYxUl7Jxfd5T
         GKKQ==
X-Gm-Message-State: ALQs6tCPuUwuFkE+lWw/WVALQdVvQLp51b0yR9iItp9iO+u91l7xkZHy
        C7r4tZqzgFRyuwdf/cOuThk=
X-Google-Smtp-Source: AB8JxZpHc7DUkDKtEWZXgnNorF8GxEnxpoDJqxfSYmh3LUSAmlKjArYJXKfMB4IjUboTnxFyO4XuiA==
X-Received: by 2002:adf:93e5:: with SMTP id 92-v6mr1920180wrp.230.1525040103970;
        Sun, 29 Apr 2018 15:15:03 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abps22.neoplus.adsl.tpnet.pl. [83.8.60.22])
        by smtp.gmail.com with ESMTPSA id n73-v6sm6427392wrb.18.2018.04.29.15.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Apr 2018 15:15:02 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 05/10] commit-graph: always load commit-graph information
References: <20180417170001.138464-1-dstolee@microsoft.com>
        <20180425143735.240183-1-dstolee@microsoft.com>
        <20180425143735.240183-6-dstolee@microsoft.com>
Date:   Mon, 30 Apr 2018 00:14:58 +0200
In-Reply-To: <20180425143735.240183-6-dstolee@microsoft.com> (Derrick Stolee's
        message of "Wed, 25 Apr 2018 14:37:58 +0000")
Message-ID: <866049irrx.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> Most code paths load commits using lookup_commit() and then
> parse_commit().

And this automatically loads commit graph if needed, thanks to changes
in parse_commit_gently(), which parse_commit() uses.

>                 In some cases, including some branch lookups, the commit
> is parsed using parse_object_buffer() which side-steps parse_commit() in
> favor of parse_commit_buffer().

I guess the problem is that we cannot just add parse_commit_in_graph()=20
like we did in parse_commit_gently(), for some reason?  Like for example
that parse_commit_gently() uses parse_commit_buffer() - which could have
been handled by moving parse_commit_in_graph() down the call chain from
parse_commit_gently() to parse_commit_buffer()... if not the fact that
check_commit() also uses parse_commit_buffer(), but it does not want to
load commit graph.  Am I right?

>
> With generation numbers in the commit-graph, we need to ensure that any
> commit that exists in the commit-graph file has its generation number
> loaded.

Is it generation number, or generation number and position in commit
graph?

>
> Create new load_commit_graph_info() method to fill in the information
> for a commit that exists only in the commit-graph file. Call it from
> parse_commit_buffer() after loading the other commit information from
> the given buffer. Only fill this information when specified by the
> 'check_graph' parameter.

I think this commit would be easier to review if it was split into pure
refactoring part (extracting fill_commit_graph_info() and
find_commit_in_graph()).  On the other hand the refactoring was needed
to reduce code duplication betweem existing parse_commit_in_graph() and
new load_commit_graph_info() functions.

I guess that the difference between parse_commit_in_graph() and
load_commit_graph_info() is that the former cares only about having just
enough information that is needed for parse_commit_gently() - and does
not load graph data if commit is parsed, while the latter is about
loading commit-graph data like generation numbers.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 45 ++++++++++++++++++++++++++++++---------------
>  commit-graph.h |  8 ++++++++
>  commit.c       |  7 +++++--
>  commit.h       |  2 +-
>  object.c       |  2 +-
>  sha1_file.c    |  2 +-
>  6 files changed, 46 insertions(+), 20 deletions(-)

I wonder if it would be possible to add tests for this feature, for
example that commit-graph is read when it should (including those branch
lookups), and is not read when the feature should be disabled.

But the only way to test it I can think of is a stupid one: create
invalid commit graph, and check that git fails as expected (trying to
read said malformed file), and does not fail if commit graph feature is
disabled.

>

Let me reorder files (BTW, is there a way for Git to put *.h files
before *.c files in diff?) for easier review:

> diff --git a/commit-graph.h b/commit-graph.h
> index 260a468e73..96cccb10f3 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -17,6 +17,14 @@ char *get_commit_graph_filename(const char *obj_dir);
>   */
>  int parse_commit_in_graph(struct commit *item);
>=20=20
> +/*
> + * It is possible that we loaded commit contents from the commit buffer,
> + * but we also want to ensure the commit-graph content is correctly
> + * checked and filled. Fill the graph_pos and generation members of
> + * the given commit.
> + */
> +void load_commit_graph_info(struct commit *item);
> +
>  struct tree *get_commit_tree_in_graph(const struct commit *c);
>=20=20
>  struct commit_graph {
> diff --git a/commit-graph.c b/commit-graph.c
> index 047fa9fca5..aebd242def 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -245,6 +245,12 @@ static struct commit_list **insert_parent_or_die(str=
uct commit_graph *g,
>  	return &commit_list_insert(c, pptr)->next;
>  }
>=20=20
> +static void fill_commit_graph_info(struct commit *item, struct commit_gr=
aph *g, uint32_t pos)
> +{
> +	const unsigned char *commit_data =3D g->chunk_commit_data + GRAPH_DATA_=
WIDTH * pos;
> +	item->generation =3D get_be32(commit_data + g->hash_len + 8) >> 2;
> +}

The comment in the header file commit-graph.h talks about filling
graph_pos and generation members of the given commit, but I don't see
filling graph_pos member here.

Sidenote: it is a tiny little bit strange to see symbolic constants like
GRAPH_DATA_WIDTH near using magic values such as 8 and 2.

> +
>  static int fill_commit_in_graph(struct commit *item, struct commit_graph=
 *g, uint32_t pos)
>  {
>  	uint32_t edge_value;
> @@ -292,31 +298,40 @@ static int fill_commit_in_graph(struct commit *item=
, struct commit_graph *g, uin
>  	return 1;
>  }
>=20=20
> +static int find_commit_in_graph(struct commit *item, struct commit_graph=
 *g, uint32_t *pos)
> +{
> +	if (item->graph_pos !=3D COMMIT_NOT_FROM_GRAPH) {
> +		*pos =3D item->graph_pos;
> +		return 1;
> +	} else {
> +		return bsearch_graph(g, &(item->object.oid), pos);
> +	}
> +}

Nice refactoring here.

> +
>  int parse_commit_in_graph(struct commit *item)
>  {
> +	uint32_t pos;
> +
>  	if (!core_commit_graph)
>  		return 0;
>  	if (item->object.parsed)
>  		return 1;
> -
>  	prepare_commit_graph();
> -	if (commit_graph) {
> -		uint32_t pos;
> -		int found;
> -		if (item->graph_pos !=3D COMMIT_NOT_FROM_GRAPH) {
> -			pos =3D item->graph_pos;
> -			found =3D 1;
> -		} else {
> -			found =3D bsearch_graph(commit_graph, &(item->object.oid), &pos);
> -		}
> -
> -		if (found)
> -			return fill_commit_in_graph(item, commit_graph, pos);
> -	}
> -
> +	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
> +		return fill_commit_in_graph(item, commit_graph, pos);
>  	return 0;
>  }
>=20=20
> +void load_commit_graph_info(struct commit *item)
> +{
> +	uint32_t pos;
> +	if (!core_commit_graph)
> +		return;
> +	prepare_commit_graph();
> +	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
> +		fill_commit_graph_info(item, commit_graph, pos);
> +}

Similar functions, different goals (as the names imply).

> +
>  static struct tree *load_tree_for_commit(struct commit_graph *g, struct =
commit *c)
>  {
>  	struct object_id oid;
> diff --git a/commit.c b/commit.c
> index 4d00b0a1d6..39a3749abd 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -331,7 +331,7 @@ const void *detach_commit_buffer(struct commit *commi=
t, unsigned long *sizep)
>  	return ret;
>  }
>=20=20
> -int parse_commit_buffer(struct commit *item, const void *buffer, unsigne=
d long size)
> +int parse_commit_buffer(struct commit *item, const void *buffer, unsigne=
d long size, int check_graph)
>  {
>  	const char *tail =3D buffer;
>  	const char *bufptr =3D buffer;
> @@ -386,6 +386,9 @@ int parse_commit_buffer(struct commit *item, const vo=
id *buffer, unsigned long s
>  	}
>  	item->date =3D parse_commit_date(bufptr, tail);
>=20=20
> +	if (check_graph)
> +		load_commit_graph_info(item);
> +

All right, read commit-graph specific data after parsing commit itself.
It is at the end because commit object needs to be parsed sequentially,
and it includes more info that is contained in commit-graph CDAT+EDGE
data.

>  	return 0;
>  }
>=20=20
> @@ -412,7 +415,7 @@ int parse_commit_gently(struct commit *item, int quie=
t_on_missing)
>  		return error("Object %s not a commit",
>  			     oid_to_hex(&item->object.oid));
>  	}
> -	ret =3D parse_commit_buffer(item, buffer, size);
> +	ret =3D parse_commit_buffer(item, buffer, size, 0);

The parse_commit_gently() contract is that it provides only bare minimum
of information, from commit-graph if possible, and does read object from
disk and parses it only when it could not avoid it.  If it needs to
parse it, it doesn't need to fill commit-graph specific data again.

All right.

>  	if (save_commit_buffer && !ret) {
>  		set_commit_buffer(item, buffer, size);
>  		return 0;
> diff --git a/commit.h b/commit.h
> index 64436ff44e..b5afde1ae9 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -72,7 +72,7 @@ struct commit *lookup_commit_reference_by_name(const ch=
ar *name);
>   */
>  struct commit *lookup_commit_or_die(const struct object_id *oid, const c=
har *ref_name);
>=20=20
> -int parse_commit_buffer(struct commit *item, const void *buffer, unsigne=
d long size);
> +int parse_commit_buffer(struct commit *item, const void *buffer, unsigne=
d long size, int check_graph);
>  int parse_commit_gently(struct commit *item, int quiet_on_missing);
>  static inline int parse_commit(struct commit *item)
>  {
> diff --git a/object.c b/object.c
> index e6ad3f61f0..efe4871325 100644
> --- a/object.c
> +++ b/object.c
> @@ -207,7 +207,7 @@ struct object *parse_object_buffer(const struct objec=
t_id *oid, enum object_type
>  	} else if (type =3D=3D OBJ_COMMIT) {
>  		struct commit *commit =3D lookup_commit(oid);
>  		if (commit) {
> -			if (parse_commit_buffer(commit, buffer, size))
> +			if (parse_commit_buffer(commit, buffer, size, 1))

All that rigamarole was needed because of

DS>                 In some cases, including some branch lookups, the commit
DS> is parsed using parse_object_buffer() which side-steps parse_commit() in
DS> favor of parse_commit_buffer().

Here we want parse_object_buffer() to get also commit-graph specific
data, if available.  All right.

>  				return NULL;
>  			if (!get_cached_commit_buffer(commit, NULL)) {
>  				set_commit_buffer(commit, buffer, size);
> diff --git a/sha1_file.c b/sha1_file.c
> index 1b94f39c4c..0fd4f0b8b6 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1755,7 +1755,7 @@ static void check_commit(const void *buf, size_t si=
ze)
>  {
>  	struct commit c;
>  	memset(&c, 0, sizeof(c));
> -	if (parse_commit_buffer(&c, buf, size))
> +	if (parse_commit_buffer(&c, buf, size, 0))

For check we don't need commit graph data.  Looks all right.

>  		die("corrupt commit");
>  }

Best,
--=20
Jakub Nar=C4=99bski
