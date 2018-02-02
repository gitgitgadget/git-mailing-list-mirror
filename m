Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D2871F404
	for <e@80x24.org>; Fri,  2 Feb 2018 00:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeBBACm (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 19:02:42 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33789 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeBBACk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 19:02:40 -0500
Received: by mail-wr0-f195.google.com with SMTP id s5so20891760wra.0
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 16:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZ6w5JhN7tqSDGBKsh19uglThiGChDfelSlO8EMMphY=;
        b=JtmcYwYrHuBsmJqqas/VZ8HKljF1LBuMFU0vJCc1MzF0b8TuEnH2QtLzdy+bsvdF8a
         pl08kCUPF/JyNKDZ5XAAuIWu8K3pzt7DeRKBQzt0Eu9Nk2ujvfPUjEK9dqZM72Fic0aI
         xnazn0lh7/1UI/cKKn/w2K0VlSRTrzgUg4Oe5+bMdxDiKlXHQ4ECxY75AAS+brVFu+gt
         wF7d4J7H0saD38Fgo8HpUPjXWLl8yMGUG/DNK8eMZBjrKJzl/j0wj9+Dv2fdLCF7XHca
         Ecgv62IaB2jXA7z8shTwaiUHG+QnldnsYDhl2Hbzq2klQgFHRVNe9XLhwrl2SUFsmeWJ
         D3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZ6w5JhN7tqSDGBKsh19uglThiGChDfelSlO8EMMphY=;
        b=QbRKu0NOIzgp8Fuc25AmfA+t17U/w6J6duuLbLNYN3gAt8qW4IOfgJEN0lsZK5RvEH
         opQQC/qIsUn5IFTQ01s1DnKUpglPxJeQDKfAj60fdMdpaZSHDfSXwbM9y73YTQeiWOj/
         w4drU9ZOYlSvOIXyoM41Hr1505IWSpyf3neVts77Hsn6MP+cmaYoTi7VH304LmP9h8d2
         tCfmEQEXucnVWwR++D5+auWZILI/QjcOvDD4aB2QWzmxtOO73McSO5Ykh3hVoThNPmTN
         NAVTizJwu5XKbRlue8CiaHamDYzAydO6IUSgleqOlgthmAlE1Vpx60Qk/+YwViBkDmkD
         0Tzw==
X-Gm-Message-State: AKwxyte1bPtrzgRdFAVJ6lli+TspBZOAgdAMUBlCsCDWdfDFlRa5xtny
        4fS6gFImiN+JYllaGQLmW1Q=
X-Google-Smtp-Source: AH8x226lCZIQDoy55H1WXx1QoHJf1Lb+hmqzlMAmc3RTHScHvmdEU8vNFi8TI3UKZwRzKnzrM9k83g==
X-Received: by 10.223.161.27 with SMTP id o27mr17718776wro.97.1517529759483;
        Thu, 01 Feb 2018 16:02:39 -0800 (PST)
Received: from localhost.localdomain (x4db049fc.dyn.telefonica.de. [77.176.73.252])
        by smtp.gmail.com with ESMTPSA id 74sm337017wmf.38.2018.02.01.16.02.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 16:02:39 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH v2 06/14] commit-graph: implement git-commit-graph --read
Date:   Fri,  2 Feb 2018 01:02:25 +0100
Message-Id: <20180202000225.9648-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <1517348383-112294-7-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com> <1517348383-112294-7-git-send-email-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Teach git-commit-graph to read commit graph files and summarize their contents.
> 
> Use the --read option to verify the contents of a commit graph file in the
> tests.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-commit-graph.txt |   7 ++
>  builtin/commit-graph.c             |  55 +++++++++++++++
>  commit-graph.c                     | 138 ++++++++++++++++++++++++++++++++++++-
>  commit-graph.h                     |  25 +++++++
>  t/t5318-commit-graph.sh            |  28 ++++++--
>  5 files changed, 247 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index 3f3790d9a8..09aeaf6c82 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -10,6 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git commit-graph' --write <options> [--pack-dir <pack_dir>]
> +'git commit-graph' --read <options> [--pack-dir <pack_dir>]

Again, what does this option do?

>  EXAMPLES
>  --------
> @@ -20,6 +21,12 @@ EXAMPLES
>  $ git commit-graph --write
>  ------------------------------------------------
>  
> +* Read basic information from a graph file.
> ++
> +------------------------------------------------
> +$ git commit-graph --read --graph-hash=<hash>
> +------------------------------------------------
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 7affd512f1..218740b1f8 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c

> +int close_commit_graph(struct commit_graph *g)

static, perhaps?  I see it's declared as extern in the headeer file
below, but I don't see it called outside of this source file by the
end of the patch series.

> +{
> +	if (g->graph_fd < 0)
> +		return 0;
> +
> +	munmap((void *)g->data, g->data_len);
> +	g->data = 0;
> +
> +	close(g->graph_fd);
> +	g->graph_fd = -1;
> +
> +	return 1;
> +}
> +
> +static void free_commit_graph(struct commit_graph **g)
> +{
> +	if (!g || !*g)
> +		return;
> +
> +	close_commit_graph(*g);
> +
> +	free(*g);
> +	*g = NULL;
> +}
> +
> +struct commit_graph *load_commit_graph_one(const char *graph_file, const char *pack_dir)
> +{
> +	void *graph_map;
> +	const unsigned char *data;
> +	struct commit_graph_header *hdr;
> +	size_t graph_size;
> +	struct stat st;
> +	uint32_t i;
> +	struct commit_graph *graph;
> +	int fd = git_open(graph_file);
> +	uint64_t last_chunk_offset;
> +	uint32_t last_chunk_id;
> +
> +	if (fd < 0)
> +		return 0;
> +	if (fstat(fd, &st)) {
> +		close(fd);
> +		return 0;
> +	}
> +	graph_size = xsize_t(st.st_size);
> +
> +	if (graph_size < GRAPH_MIN_SIZE) {
> +		close(fd);
> +		die("graph file %s is too small", graph_file);
> +	}
> +	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +	data = (const unsigned char *)graph_map;
> +
> +	hdr = graph_map;
> +	if (ntohl(hdr->graph_signature) != GRAPH_SIGNATURE) {
> +		uint32_t signature = ntohl(hdr->graph_signature);
> +		munmap(graph_map, graph_size);
> +		close(fd);
> +		die("graph signature %X does not match signature %X",
> +			signature, GRAPH_SIGNATURE);
> +	}
> +	if (hdr->graph_version != GRAPH_VERSION) {
> +		unsigned char version = hdr->graph_version;
> +		munmap(graph_map, graph_size);
> +		close(fd);
> +		die("graph version %X does not match version %X",
> +			version, GRAPH_VERSION);
> +	}
> +
> +	graph = alloc_commit_graph(strlen(pack_dir) + 1);
> +
> +	graph->hdr = hdr;
> +	graph->graph_fd = fd;
> +	graph->data = graph_map;
> +	graph->data_len = graph_size;
> +
> +	last_chunk_id = 0;
> +	last_chunk_offset = (uint64_t)sizeof(*hdr);
> +	for (i = 0; i < hdr->num_chunks; i++) {
> +		uint32_t chunk_id = ntohl(*(uint32_t*)(data + sizeof(*hdr) + 12 * i));
> +		uint64_t chunk_offset1 = ntohl(*(uint32_t*)(data + sizeof(*hdr) + 12 * i + 4));
> +		uint32_t chunk_offset2 = ntohl(*(uint32_t*)(data + sizeof(*hdr) + 12 * i + 8));

There are a lot of magic number in these three lines, but at least
they are all multiples of 4.

> +		uint64_t chunk_offset = (chunk_offset1 << 32) | chunk_offset2;
> +
> +		if (chunk_offset > graph_size - GIT_MAX_RAWSZ)
> +			die("improper chunk offset %08x%08x", (uint32_t)(chunk_offset >> 32),
> +			    (uint32_t)chunk_offset);
> +
> +		switch (chunk_id) {
> +			case GRAPH_CHUNKID_OIDFANOUT:
> +				graph->chunk_oid_fanout = data + chunk_offset;
> +				break;
> +
> +			case GRAPH_CHUNKID_OIDLOOKUP:
> +				graph->chunk_oid_lookup = data + chunk_offset;
> +				break;
> +
> +			case GRAPH_CHUNKID_DATA:
> +				graph->chunk_commit_data = data + chunk_offset;
> +				break;
> +
> +			case GRAPH_CHUNKID_LARGEEDGES:
> +				graph->chunk_large_edges = data + chunk_offset;
> +				break;
> +
> +			case 0:
> +				break;
> +
> +			default:
> +				free_commit_graph(&graph);
> +				die("unrecognized graph chunk id: %08x", chunk_id);
> +		}
> +
> +		if (last_chunk_id == GRAPH_CHUNKID_OIDLOOKUP)
> +		{
> +			graph->num_commits = (chunk_offset - last_chunk_offset)
> +					     / hdr->hash_len;
> +		}
> +
> +		last_chunk_id = chunk_id;
> +		last_chunk_offset = chunk_offset;
> +	}
> +
> +	strcpy(graph->pack_dir, pack_dir);
> +	return graph;
> +}
> +
>  static void write_graph_chunk_fanout(struct sha1file *f,
>  				     struct commit **commits,
>  				     int nr_commits)
> @@ -361,7 +497,7 @@ struct object_id *construct_commit_graph(const char *pack_dir)
>  	sha1close(f, final_hash, CSUM_CLOSE | CSUM_FSYNC);
>  
>  	f_hash = (struct object_id *)malloc(sizeof(struct object_id));
> -	memcpy(f_hash->hash, final_hash, GIT_MAX_RAWSZ);
> +	hashcpy(f_hash->hash, final_hash);

Oh, look, I told you it's hashcpy()! ;)

>  	fname = get_commit_graph_filename_hash(pack_dir, f_hash);
>  
>  	if (rename(graph_name, fname))
> diff --git a/commit-graph.h b/commit-graph.h
> index 7b3469a7df..e046ae575c 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -15,6 +15,31 @@ struct commit_graph_header {
>  	unsigned char num_chunks;
>  };
>  
> +extern struct commit_graph {
> +	int graph_fd;
> +
> +	const unsigned char *data;
> +	size_t data_len;
> +
> +	const struct commit_graph_header *hdr;
> +
> +	struct object_id oid;
> +
> +	uint32_t num_commits;
> +
> +	const unsigned char *chunk_oid_fanout;
> +	const unsigned char *chunk_oid_lookup;
> +	const unsigned char *chunk_commit_data;
> +	const unsigned char *chunk_large_edges;
> +
> +	/* something like ".git/objects/pack" */
> +	char pack_dir[FLEX_ARRAY]; /* more */
> +} *commit_graph;
> +
> +extern int close_commit_graph(struct commit_graph *g);
> +
> +extern struct commit_graph *load_commit_graph_one(const char *graph_file, const char *pack_dir);
> +
>  extern struct object_id *construct_commit_graph(const char *pack_dir);
>  
>  #endif
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 6bcd1cc264..da565624e3 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -25,11 +25,23 @@ test_expect_success 'create commits and repack' \
>       done &&
>       git repack'
>  
> +_graph_read_expect() {
> +    cat >expect <<- EOF
> +header: 43475048 01 01 14 04
> +num_commits: $1
> +chunks: oid_fanout oid_lookup commit_metadata large_edges
> +pack_dir: $2
> +EOF
> +}

Style nit: since you are already using the '<<-' operator for the
here-doc, you could indent it with tabs.

> +
>  test_expect_success 'write graph' \
>      'graph1=$(git commit-graph --write) &&
> -     test_path_is_file ${packdir}/graph-${graph1}.graph'
> +     test_path_is_file ${packdir}/graph-${graph1}.graph &&
> +     git commit-graph --read --graph-hash=${graph1} >output &&
> +     _graph_read_expect "5" "${packdir}" &&
> +     cmp expect output'

Please use the 'test_cmp' helper throughout the tests instead.
If the two files don't match, 'cmp' will only tell you where they
start to differ, whereas 'test_cmp' will actually show the difference.

> -t_expect_success 'Add more commits' \
> +test_expect_success 'Add more commits' \

This should be squashed into the earlier commit.

>      'git reset --hard commits/3 &&
>       for i in $(test_seq 6 10)
>       do
> @@ -79,7 +91,10 @@ t_expect_success 'Add more commits' \
>  
>  test_expect_success 'write graph with merges' \
>      'graph2=$(git commit-graph --write) &&
> -     test_path_is_file ${packdir}/graph-${graph2}.graph'
> +     test_path_is_file ${packdir}/graph-${graph2}.graph &&
> +     git commit-graph --read --graph-hash=${graph2} >output &&
> +     _graph_read_expect "18" "${packdir}" &&
> +     cmp expect output'
>  
>  test_expect_success 'setup bare repo' \
>      'cd .. &&
> @@ -87,10 +102,13 @@ test_expect_success 'setup bare repo' \
>       cd bare &&
>       git config core.graph true &&
>       git config pack.threads 1 &&
> -     baredir="objects/pack"'
> +     baredir="./objects/pack"'

Is this change really necessary?  If it is, then perhaps it should
have been written this way upon its introduction.

>  test_expect_success 'write graph in bare repo' \
>      'graphbare=$(git commit-graph --write) &&
> -     test_path_is_file ${baredir}/graph-${graphbare}.graph'
> +     test_path_is_file ${baredir}/graph-${graphbare}.graph &&
> +     git commit-graph --read --graph-hash=${graphbare} >output &&
> +     _graph_read_expect "18" "${baredir}" &&
> +     cmp expect output'
>  
>  test_done
> -- 
> 2.16.0.15.g9c3cf44.dirty


