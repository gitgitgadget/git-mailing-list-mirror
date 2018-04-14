Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 077271F404
	for <e@80x24.org>; Sat, 14 Apr 2018 22:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeDNWPQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 18:15:16 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34360 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbeDNWPP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 18:15:15 -0400
Received: by mail-wr0-f194.google.com with SMTP id d19so16373700wre.1
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 15:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=V8TuuPJSwCAr9jpshFKZOGDQc0Ki6hqB3CEPY0C9rr4=;
        b=Wk8IinsbIml+yHAnnDLLvmMfHWMDl86FeC0+PhU76EVb0Ch5ifE5ubYzMhO5u6dr9F
         aEmxPnANbJVJ17Su7fD4Qweqed3taXxMeYF5xRYZ93Qz+bp3R9lSzyK2+aEHSDLvZc46
         sak/drkskZ/DhUzdOHnHp2bxF/HtXEfhYmAnY1VaadOE7w+4HyFrJlDeiuPOFTCYnkt7
         9g8OpjLPngSq+Cao5uJ3Sj5BRMFOrMymmb3T9rZBYG9hyIvVev1pc6ocizHDsFJb8qkK
         YLI62ir9Nskl7rdxt6PP+o5FN4uW84E3YFuxq6l7/bzQ/PkqvgoadGfGQBvU0X27Ew7a
         1aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=V8TuuPJSwCAr9jpshFKZOGDQc0Ki6hqB3CEPY0C9rr4=;
        b=auHPjcmOS4g8MAXo4xba+/gNMffetGLu3/nYhgop1IxpZP3dWmN25p0LVWQy6LkpMw
         32cxhtln5HeFbG6LfXtSbZE7NSlBqPTi/kJ9QQjbu3v3EZoeIqKkzazWVkuGoJdy3uEL
         vkq3LO8pFWqMVaNQ3sGH5OxBRrB8kC+8CwwRRBZj+4a7F3MaAE81RMfe9IZFvq0obl18
         F2jePNPAZ6R9QnOx0hPz2XZ0/lR2Vri5kWmukQrn9yH1Sp824X5AT4AZNqQRbwjOzL9Y
         GuZprmNX5ph90FSwvovlwcNuf9tJh/UBnkz2L7qbivQCvW78YQfKGD/iBpkYQoTYQLl6
         +IZw==
X-Gm-Message-State: ALQs6tCvYs63BYtV2/VHzJ+A/o3Sq7UkXWwBASFqphlemzRqLn2lLsa5
        YYGlFotOn6mgR029R4unZgQ=
X-Google-Smtp-Source: AIpwx4+F8rZjUndlBsWb9OU1HmTevCitglF0SzlDyf98QRSHo90a5EwA43XeqdiSatB9YOR4p8a9UA==
X-Received: by 10.223.161.79 with SMTP id r15mr6493420wrr.271.1523744113240;
        Sat, 14 Apr 2018 15:15:13 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egm16.neoplus.adsl.tpnet.pl. [83.21.76.16])
        by smtp.gmail.com with ESMTPSA id m35sm10809067wrm.59.2018.04.14.15.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Apr 2018 15:15:11 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, sbeller@google.com,
        szeder.dev@gmail.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v8 08/14] commit-graph: implement git commit-graph read
References: <20180402203427.170177-1-dstolee@microsoft.com>
        <20180410125608.39443-1-dstolee@microsoft.com>
        <20180410125608.39443-9-dstolee@microsoft.com>
Date:   Sun, 15 Apr 2018 00:15:07 +0200
In-Reply-To: <20180410125608.39443-9-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 10 Apr 2018 08:56:02 -0400")
Message-ID: <868t9pl9jo.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
> Subject: [PATCH v8 08/14] commit-graph: implement git commit-graph read

Minor nit: this is one commit message [subject] among all others that
uses "git commit-graph" instead of "git-commit-graph" in the
description.

Also, perhaps this (and similarly titled commits in this series) would
read better with quotes, that is as:

  commit-graph: implement "git commit-graph read"

Though that might be a matter of personal taste.

>
> Teach git-commit-graph to read commit graph files and summarize their con=
tents.
>
> Use the read subcommand to verify the contents of a commit graph file in =
the
> tests.

Better would be, in my opinion

  Use the 'read' subcommand

or

  Use the "read" subcommand

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-commit-graph.txt |  12 +++
>  builtin/commit-graph.c             |  56 ++++++++++++
>  commit-graph.c                     | 137 ++++++++++++++++++++++++++++-
>  commit-graph.h                     |  23 +++++
>  t/t5318-commit-graph.sh            |  32 +++++--
>  5 files changed, 254 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commi=
t-graph.txt
> index 47996e8f89..8aad8303f5 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -9,6 +9,7 @@ git-commit-graph - Write and verify Git commit graph files
>  SYNOPSIS
>  --------
>  [verse]
> +'git commit-graph read' [--object-dir <dir>]
>  'git commit-graph write' <options> [--object-dir <dir>]

Why do you need this '[--object-dir <dir>]' parameter?  Anyway, because
Git has the GIT_OBJECT_DIRECTORY environment variable support, I would
expect '--object-dir' to be parameter to the 'git' wrapper/command, like
'--git-dir' is, not to the 'git commit-graph' command, or even only its
selected individual subcommands.

>=20=20
>=20=20
> @@ -35,6 +36,11 @@ COMMANDS
>  Write a commit graph file based on the commits found in packfiles.
>  Includes all commits from the existing commit graph file.
>=20=20
> +'read'::
> +
> +Read a graph file given by the commit-graph file

The above part of sentence reads very strange, as a truism.

>                                                   and output basic
> +details about the graph file. Used for debugging purposes.

I would say that it is 'used' for testing, and is 'useful' (or 'can be
used') for debugging purposes.

> +
>=20=20
>  EXAMPLES
>  --------
> @@ -45,6 +51,12 @@ EXAMPLES
>  $ git commit-graph write
>  ------------------------------------------------
>=20=20
> +* Read basic information from the commit-graph file.
> ++
> +------------------------------------------------
> +$ git commit-graph read
> +------------------------------------------------

I would personally prefer to have example output together with example
calling convention.

> +
>=20=20
>  GIT
>  ---
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 26b6360289..efd39331d7 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -7,10 +7,16 @@
>=20=20
>  static char const * const builtin_commit_graph_usage[] =3D {
>  	N_("git commit-graph [--object-dir <objdir>]"),
> +	N_("git commit-graph read [--object-dir <objdir>]"),
>  	N_("git commit-graph write [--object-dir <objdir>]"),
>  	NULL
>  };
>=20=20
> +static const char * const builtin_commit_graph_read_usage[] =3D {
> +	N_("git commit-graph read [--object-dir <objdir>]"),
> +	NULL
> +};
> +
>  static const char * const builtin_commit_graph_write_usage[] =3D {
>  	N_("git commit-graph write [--object-dir <objdir>]"),
>  	NULL
> @@ -20,6 +26,54 @@ static struct opts_commit_graph {
>  	const char *obj_dir;
>  } opts;
>=20=20
> +static int graph_read(int argc, const char **argv)
> +{
> +	struct commit_graph *graph =3D NULL;
> +	char *graph_name;
> +
> +	static struct option builtin_commit_graph_read_options[] =3D {
> +		OPT_STRING(0, "object-dir", &opts.obj_dir,
> +			N_("dir"),
> +			N_("The object directory to store the graph")),

Actually it is not the object directory to store the graph, but it is
the object directory to read the commit-graph file from.

> +		OPT_END(),
> +	};
> +
> +	argc =3D parse_options(argc, argv, NULL,
> +			     builtin_commit_graph_read_options,
> +			     builtin_commit_graph_read_usage, 0);
> +
> +	if (!opts.obj_dir)
> +		opts.obj_dir =3D get_object_directory();
> +
> +	graph_name =3D get_commit_graph_filename(opts.obj_dir);
> +	graph =3D load_commit_graph_one(graph_name);
> +
> +	if (!graph)
> +		die("graph file %s does not exist", graph_name);

It might be better to use single quotes around '%s'; this is absolute
pathname (if I understand it correctly), and it may contain spaces in
it.

> +	FREE_AND_NULL(graph_name);
> +
> +	printf("header: %08x %d %d %d %d\n",

Wouldn't it be better to print signature charactes (FourCC-like), that
is 'CGPH'?  And maybe name each part of header?

  +	printf("header: %c%c%c%c ver=3D%d hash=3D%d chunks=3D%d reserved=3D%d\n=
",

Would it make using the command in tests harder, maybe?

> +		ntohl(*(uint32_t*)graph->data),
> +		*(unsigned char*)(graph->data + 4),
> +		*(unsigned char*)(graph->data + 5),
> +		*(unsigned char*)(graph->data + 6),
> +		*(unsigned char*)(graph->data + 7));
> +	printf("num_commits: %u\n", graph->num_commits);

All right.

> +	printf("chunks:");
> +
> +	if (graph->chunk_oid_fanout)
> +		printf(" oid_fanout");
> +	if (graph->chunk_oid_lookup)
> +		printf(" oid_lookup");
> +	if (graph->chunk_commit_data)
> +		printf(" commit_metadata");
> +	if (graph->chunk_large_edges)
> +		printf(" large_edges");
> +	printf("\n");

This means that there is no support for unknown chunks (perhaps created
by newer version of Git - that does not exist yet), including unknown
optional chunks.  But I guess that is acceptable at this stage.

Note that for unknown chunks you would be able to only print their
signatures, because we do not know their full names.

> +
> +	return 0;
> +}
> +

No unmap, no closing file descriptor; I guess we can rely on operating
system doing this cleanup for us on exit.


[...]
> +static struct commit_graph *alloc_commit_graph(void)
> +{
> +	struct commit_graph *g =3D xcalloc(1, sizeof(*g));

All right, that is the standard idiom used by git code.

> +	g->graph_fd =3D -1;
> +
> +	return g;
> +}

Would we need some safe way of deallocating graph data?  Who owns
graph_fd, and is responsible for closing the file (well, except system
when program exits - but what about libgit2 then)?

> +
> +struct commit_graph *load_commit_graph_one(const char *graph_file)
> +{
> +	void *graph_map;
> +	const unsigned char *data, *chunk_lookup;
> +	size_t graph_size;
> +	struct stat st;
> +	uint32_t i;
> +	struct commit_graph *graph;
> +	int fd =3D git_open(graph_file);
> +	uint64_t last_chunk_offset;
> +	uint32_t last_chunk_id;
> +	uint32_t graph_signature;
> +	unsigned char graph_version, hash_version;
> +
> +	if (fd < 0)
> +		return NULL;
> +	if (fstat(fd, &st)) {
> +		close(fd);
> +		return NULL;
> +	}
> +	graph_size =3D xsize_t(st.st_size);
> +
> +	if (graph_size < GRAPH_MIN_SIZE) {
> +		close(fd);
> +		die("graph file %s is too small", graph_file);

Should we print its expected minimal size, too?
Shouldn't error messages be marked for localization?

> +	}
> +	graph_map =3D xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +	data =3D (const unsigned char *)graph_map;

All right, speed is important, so let's (x)mmap the file.

> +
> +	graph_signature =3D get_be32(data);
> +	if (graph_signature !=3D GRAPH_SIGNATURE) {
> +		error("graph signature %X does not match signature %X",
> +		      graph_signature, GRAPH_SIGNATURE);
> +		goto cleanup_fail;
> +	}

All right, we check the signature of the file.

> +
> +	graph_version =3D *(unsigned char*)(data + 4);

I wonder if those numbers should not be replaced by preprocessor
constants.  I guess it wouldn't actually improve readability.

> +	if (graph_version !=3D GRAPH_VERSION) {
> +		error("graph version %X does not match version %X",
> +		      graph_version, GRAPH_VERSION);
> +		goto cleanup_fail;
> +	}

Does this mean that the command is not forward-compatibile, in that it
would fail on "commit-graph" files created in newer version of Git, then
accessed with older version?

> +
> +	hash_version =3D *(unsigned char*)(data + 5);
> +	if (hash_version !=3D GRAPH_OID_VERSION) {
> +		error("hash version %X does not match version %X",
> +		      hash_version, GRAPH_OID_VERSION);
> +		goto cleanup_fail;
> +	}

All right, there is no support for NewHash yet, so there is nothing to
do but fail.

> +
> +	graph =3D alloc_commit_graph();
> +
> +	graph->hash_len =3D GRAPH_OID_LEN;
> +	graph->num_chunks =3D *(unsigned char*)(data + 6);
> +	graph->graph_fd =3D fd;
> +	graph->data =3D graph_map;
> +	graph->data_len =3D graph_size;
> +
> +	last_chunk_id =3D 0;
> +	last_chunk_offset =3D 8;
> +	chunk_lookup =3D data + 8;
> +	for (i =3D 0; i < graph->num_chunks; i++) {
> +		uint32_t chunk_id =3D get_be32(chunk_lookup + 0);
> +		uint64_t chunk_offset =3D get_be64(chunk_lookup + 4);
> +		int chunk_repeated =3D 0;
> +
> +		chunk_lookup +=3D GRAPH_CHUNKLOOKUP_WIDTH;

All right, here we use preprocessor constant (I would guess: 4 + 8).

> +
> +		if (chunk_offset > graph_size - GIT_MAX_RAWSZ) {

All right, there must be place for final H-byte HASH-checksum of all of
contents.

> +			error("improper chunk offset %08x%08x", (uint32_t)(chunk_offset >> 32=
),

And by "improper" you mean "too large" here.

Why the strange formatting of uint64_t / off64_t values?  Is it
compatibility reasons?

> +			      (uint32_t)chunk_offset);
> +			goto cleanup_fail;
> +		}
> +
> +		switch (chunk_id) {
> +		case GRAPH_CHUNKID_OIDFANOUT:
> +			if (graph->chunk_oid_fanout)
> +				chunk_repeated =3D 1;
> +			else
> +				graph->chunk_oid_fanout =3D (uint32_t*)(data + chunk_offset);

All right, this is the only currently defined chunk where the element is
a simple type, it would be always the same simple type, and we know this
type.  Not so for the rest of chunks: either the element is composite
type, or the size of element can change in the future (like hash size).

Sidenote: for verification one would probably have to check that:
  - the size of oid_fanout chunk is 256 * 4 bytes
  - that 0 <=3D F[0] <=3D F[1] <=3D ... <=3D F[255] =3D num_commits

> +			break;
> +
> +		case GRAPH_CHUNKID_OIDLOOKUP:
> +			if (graph->chunk_oid_lookup)
> +				chunk_repeated =3D 1;
> +			else
> +				graph->chunk_oid_lookup =3D data + chunk_offset;
> +			break;

Sidenote: for verification one would probably have to check that:
 - the size of oid_lookup is N * H bytes, where N =3D num_commits
 - the OIDs are sorted in ascending lexicographical order
 - that each objects with given OID exists, and is a commit object

Though the problem is that we may not know num_commits with this way of
reading at this time.

> +
> +		case GRAPH_CHUNKID_DATA:
> +			if (graph->chunk_commit_data)
> +				chunk_repeated =3D 1;
> +			else
> +				graph->chunk_commit_data =3D data + chunk_offset;
> +			break;

Sidenote: for verification one would probably have to check that:
 - the size of oid_lookup is N * (H + 16) bytes, where N =3D num_commits
 - that data in here agrees with data from the ODB

> +
> +		case GRAPH_CHUNKID_LARGEEDGES:
> +			if (graph->chunk_large_edges)
> +				chunk_repeated =3D 1;
> +			else
> +				graph->chunk_large_edges =3D data + chunk_offset;
> +			break;
> +		}

Sidenote: verification of this would be even more involved.

> +
> +		if (chunk_repeated) {
> +			error("chunk id %08x appears multiple times", chunk_id);

Wouldn't it be better to print signature, and not raw chunk_id in hex?

> +			goto cleanup_fail;
> +		}

All right, we fail on first repeated non-repeatable chunk.

> +
> +		if (last_chunk_id =3D=3D GRAPH_CHUNKID_OIDLOOKUP)
> +		{
> +			graph->num_commits =3D (chunk_offset - last_chunk_offset)
> +					     / graph->hash_len;
> +		}

All right, looks good to me.

Sidenote: one should probably verify that (chunk_offset - last_chunk_offset)
here is evenly divisible into hash_len.

> +
> +		last_chunk_id =3D chunk_id;
> +		last_chunk_offset =3D chunk_offset;
> +	}

Sidenote: the verification should check that final checksum is correct.

> +
> +	return graph;
> +
> +cleanup_fail:
> +	munmap(graph_map, graph_size);
> +	close(fd);
> +	exit(1);
> +}
> +
>  static void write_graph_chunk_fanout(struct hashfile *f,
>  				     struct commit **commits,
>  				     int nr_commits)
> diff --git a/commit-graph.h b/commit-graph.h
> index 16fea993ab..2528478f06 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -1,6 +1,29 @@
>  #ifndef COMMIT_GRAPH_H
>  #define COMMIT_GRAPH_H
>=20=20
> +#include "git-compat-util.h"
> +
> +char *get_commit_graph_filename(const char *obj_dir);
> +
> +struct commit_graph {
> +	int graph_fd;
> +
> +	const unsigned char *data;
> +	size_t data_len;

All right, this is "raw data".

> +
> +	unsigned char hash_len;
> +	unsigned char num_chunks;
> +	uint32_t num_commits;

All right.

> +	struct object_id oid;

What is this for?

> +
> +	const uint32_t *chunk_oid_fanout;
> +	const unsigned char *chunk_oid_lookup;
> +	const unsigned char *chunk_commit_data;
> +	const unsigned char *chunk_large_edges;

All right, individual chunks (or NULL if chunks does not exist - for
optional ones).

> +};
> +
> +struct commit_graph *load_commit_graph_one(const char *graph_file);
> +
>  void write_commit_graph(const char *obj_dir);
>=20=20
>  #endif
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index d7b635bd68..2f44f91193 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -26,10 +26,28 @@ test_expect_success 'create commits and repack' '
>  	git repack
>  '
>=20=20
> +graph_read_expect() {

All right, I see that we have unstated convention of not documenting
local shell functions in tests.

This should have space before parentheses, like this:

  +graph_read_expect () {

                    ^
                    \-- here

> +	OPTIONAL=3D""
> +	NUM_CHUNKS=3D3
> +	if test ! -z $2
> +	then
> +		OPTIONAL=3D" $2"
> +		NUM_CHUNKS=3D$((3 + $(echo "$2" | wc -w)))
> +	fi

I don't know if it is possible to do the above in a portable shell
without using external 'wc' command.  Also, isn't $(( ... )) bashism?

Perhaps better solution would be to pass each expected extra chunk as
separate parameter, and simply compose OPTIONAL from those subsequent
parameters: we know that the separator is space.

Also, currently this is overengineered a bit... or just
forward-thinking, as we will have at most single-word 2nd parameter,
namely "large_edges".

> +	cat >expect <<- EOF
> +	header: 43475048 1 1 $NUM_CHUNKS 0
> +	num_commits: $1
> +	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
> +	EOF
> +	git commit-graph read >output &&
> +	test_cmp expect output
> +}
> +
>  test_expect_success 'write graph' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	graph1=3D$(git commit-graph write) &&

Why do you use command substitution here?  'graph1' variable is not used
anywhere I can see, and in all other examples below you simply run
"git commit-graph write" without command substitution.

> -	test_path_is_file $objdir/info/commit-graph
> +	test_path_is_file $objdir/info/commit-graph &&
> +	graph_read_expect "3"
>  '
>=20=20
>  test_expect_success 'Add more commits' '
> @@ -72,7 +90,8 @@ test_expect_success 'Add more commits' '
>  test_expect_success 'write graph with merges' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	git commit-graph write &&
> -	test_path_is_file $objdir/info/commit-graph
> +	test_path_is_file $objdir/info/commit-graph &&
> +	graph_read_expect "10" "large_edges"
>  '
>=20=20
>  test_expect_success 'Add one more commit' '
[...]

Thank you for your patient work on this feature,
--=20
Jakub Nar=C4=99bski
