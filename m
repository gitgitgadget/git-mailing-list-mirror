Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A527E1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 01:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeBBBvz (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 20:51:55 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41931 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeBBBvx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 20:51:53 -0500
Received: by mail-pf0-f195.google.com with SMTP id c6so16458825pfi.8
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 17:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ozve1ZrfRdpx+awT2PgxXqHJRMfxCwzk/NMO94txNus=;
        b=PUPRbnrIKM/j2uZuJg7YcdfK+RPy6f67lFGKNzi6OoaB97iYWZjhb8+2GJhzZ+RfOu
         VcnCJeRcV9iHuQ2IplEreI6tJf00028AdyiFy1jN9oqyZIby6GkcizQFAUl2PRtP1cij
         /sWy8qC89NiZzcp0jQ9bcIuT892Hv1lkLgDRRPWjP/AYAeG/OfHV79JlQZ1XKg2O3wwa
         5hQQqt6FJ+21/G/OWtqNEPhfGYV5o7h8e9L4bIr09lH9JGq29sU8mPG3eDhXcldqvoJr
         Z5erOTSXA7ThhAEZALcsGSLqwlHjWJo9fqyjMYiRyIIm/6QPEAaYTXgy/Xuqc//DQUvr
         yxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ozve1ZrfRdpx+awT2PgxXqHJRMfxCwzk/NMO94txNus=;
        b=JIr/jEpW6xmlg5+4/zc3b0gKJbgGhqe+ugGGXlWTWiXRAgOmxp7JV1lPVZCLIZ0WLz
         fB+/xyOsCIohOUsSbdzDiZIPG3p+p+u0bS1cV1USjON7Y+X/Poz3LlCDngw2Enuv+xh3
         ujeAGexH8B/z9HJD8Mt96etla1E1So4Ny0cAOW1Njfrs8lXeEvknNGyZAdy5ftAhdU9M
         Mw9mjlSNq0h4/FZnDt+E3Jjh9LPo0nU5O84z8DDyWgKHyQo1Tzcl31S1//QBQWouprj+
         U6nKDN4YdUAoZvB9XwVXyU/qQuqGtgXUMMrs2aHw1UrPuNWT357fYYdNbBK28FEfHhro
         +mkg==
X-Gm-Message-State: AKwxytdv0bduXTZzFGdmZ9UUQtkltfLwk2E9NzbmVez11O+QS+30ETE5
        9sb0ScRbNEGWTbyS/oGgcePqzw==
X-Google-Smtp-Source: AH8x226VE5HD7wr73SRJTPIub9jlQN2oF9X/1OFh1b1kTpgaIsPtIsE8+c6ffqb3nfobO/hzjFZ1ww==
X-Received: by 10.101.65.71 with SMTP id x7mr30167224pgp.379.1517536312892;
        Thu, 01 Feb 2018 17:51:52 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id d5sm919746pfg.137.2018.02.01.17.51.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Feb 2018 17:51:52 -0800 (PST)
Date:   Thu, 1 Feb 2018 17:51:51 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH v2 11/14] commit: integrate commit graph with commit
 parsing
Message-Id: <20180201175151.89555950582a2e6c5279849a@google.com>
In-Reply-To: <1517348383-112294-12-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1517348383-112294-12-git-send-email-dstolee@microsoft.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 30 Jan 2018 16:39:40 -0500
Derrick Stolee <stolee@gmail.com> wrote:

> +/* global storage */
> +struct commit_graph *commit_graph = 0;

NULL, not 0.

> +static int bsearch_graph(struct commit_graph *g, struct object_id *oid, uint32_t *pos)
> +{
> +	uint32_t last, first = 0;
> +
> +	if (oid->hash[0])
> +		first = ntohl(*(uint32_t*)(g->chunk_oid_fanout + 4 * (oid->hash[0] - 1)));
> +	last = ntohl(*(uint32_t*)(g->chunk_oid_fanout + 4 * oid->hash[0]));
> +
> +	while (first < last) {
> +		uint32_t mid = first + (last - first) / 2;
> +		const unsigned char *current;
> +		int cmp;
> +
> +		current = g->chunk_oid_lookup + g->hdr->hash_len * mid;
> +		cmp = hashcmp(oid->hash, current);
> +		if (!cmp) {
> +			*pos = mid;
> +			return 1;
> +		}
> +		if (cmp > 0) {
> +			first = mid + 1;
> +			continue;
> +		}
> +		last = mid;
> +	}
> +
> +	*pos = first;
> +	return 0;
> +}

This would be better in sha1-lookup.c, something like the reverse of commit
f1068efefe6d ("sha1_file: drop experimental GIT_USE_LOOKUP search",
2017-08-09), except that it can be done using a simple binary search.

> +static int full_parse_commit(struct commit *item, struct commit_graph *g,
> +			     uint32_t pos, const unsigned char *commit_data)
> +{
> +	struct object_id oid;
> +	struct commit *new_parent;
> +	uint32_t new_parent_pos;
> +	uint32_t *parent_data_ptr;
> +	uint64_t date_low, date_high;
> +	struct commit_list **pptr;
> +
> +	item->object.parsed = 1;
> +	item->graph_pos = pos;
> +
> +	hashcpy(oid.hash, commit_data);
> +	item->tree = lookup_tree(&oid);
> +
> +	date_high = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len + 8)) & 0x3;
> +	date_low = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len + 12));
> +	item->date = (timestamp_t)((date_high << 32) | date_low);
> +
> +	pptr = &item->parents;
> +
> +	new_parent_pos = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len));
> +	if (new_parent_pos == GRAPH_PARENT_NONE)
> +		return 1;
> +	get_nth_commit_oid(g, new_parent_pos, &oid);
> +	new_parent = lookup_commit(&oid);
> +	if (new_parent) {
> +		new_parent->graph_pos = new_parent_pos;
> +		pptr = &commit_list_insert(new_parent, pptr)->next;
> +	} else {
> +		die("could not find commit %s", oid_to_hex(&oid));
> +	}
> +
> +	new_parent_pos = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len + 4));
> +	if (new_parent_pos == GRAPH_PARENT_NONE)
> +		return 1;
> +	if (!(new_parent_pos & GRAPH_LARGE_EDGES_NEEDED)) {
> +		get_nth_commit_oid(g, new_parent_pos, &oid);
> +		new_parent = lookup_commit(&oid);
> +		if (new_parent) {
> +			new_parent->graph_pos = new_parent_pos;
> +			pptr = &commit_list_insert(new_parent, pptr)->next;
> +		} else
> +			die("could not find commit %s", oid_to_hex(&oid));
> +		return 1;
> +	}
> +
> +	parent_data_ptr = (uint32_t*)(g->chunk_large_edges + 4 * (new_parent_pos ^ GRAPH_LARGE_EDGES_NEEDED));
> +	do {
> +		new_parent_pos = ntohl(*parent_data_ptr);
> +
> +		get_nth_commit_oid(g, new_parent_pos & GRAPH_EDGE_LAST_MASK, &oid);
> +		new_parent = lookup_commit(&oid);
> +		if (new_parent) {
> +			new_parent->graph_pos = new_parent_pos & GRAPH_EDGE_LAST_MASK;
> +			pptr = &commit_list_insert(new_parent, pptr)->next;
> +		} else
> +			die("could not find commit %s", oid_to_hex(&oid));
> +		parent_data_ptr++;
> +	} while (!(new_parent_pos & GRAPH_LAST_EDGE));
> +
> +	return 1;
> +}

The part that converts <pointer to parent data> into <struct commit *>
seems to be duplicated 3 times. Refactor into a function?

> +/**
> + * Fill 'item' to contain all information that would be parsed by parse_commit_buffer.
> + */
> +static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uint32_t pos)
> +{
> +	uint32_t new_parent_pos;
> +	uint32_t *parent_data_ptr;
> +	const unsigned char *commit_data = g->chunk_commit_data + (g->hdr->hash_len + 16) * pos;
> +
> +	new_parent_pos = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len));
> +
> +	if (new_parent_pos == GRAPH_PARENT_MISSING)
> +		return 0;
> +
> +	if (new_parent_pos == GRAPH_PARENT_NONE)
> +		return full_parse_commit(item, g, pos, commit_data);
> +
> +	new_parent_pos = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len + 4));
> +
> +	if (new_parent_pos == GRAPH_PARENT_MISSING)
> +		return 0;
> +	if (!(new_parent_pos & GRAPH_LARGE_EDGES_NEEDED))
> +		return full_parse_commit(item, g, pos, commit_data);
> +
> +	new_parent_pos = new_parent_pos ^ GRAPH_LARGE_EDGES_NEEDED;
> +
> +	if (new_parent_pos == GRAPH_PARENT_MISSING)
> +		return 0;
> +
> +	parent_data_ptr = (uint32_t*)(g->chunk_large_edges + 4 * new_parent_pos);
> +	do {
> +		new_parent_pos = ntohl(*parent_data_ptr);
> +
> +		if ((new_parent_pos & GRAPH_EDGE_LAST_MASK) == GRAPH_PARENT_MISSING)
> +			return 0;
> +
> +		parent_data_ptr++;
> +	} while (!(new_parent_pos & GRAPH_LAST_EDGE));
> +
> +	return full_parse_commit(item, g, pos, commit_data);
> +}

This function seems to just check for GRAPH_PARENT_MISSING - could that
check be folded into full_parse_commit() instead? (Then
full_parse_commit can be renamed to fill_commit_in_graph.)

> @@ -439,9 +656,24 @@ struct object_id *construct_commit_graph(const char *pack_dir)
>  	char *fname;
>  	struct commit_list *parent;
>  
> +	prepare_commit_graph();
> +
>  	oids.num = 0;
>  	oids.size = 1024;
> +
> +	if (commit_graph && oids.size < commit_graph->num_commits)
> +		oids.size = commit_graph->num_commits;
> +
>  	ALLOC_ARRAY(oids.list, oids.size);
> +
> +	if (commit_graph) {
> +		for (i = 0; i < commit_graph->num_commits; i++) {
> +			oids.list[i] = malloc(sizeof(struct object_id));
> +			get_nth_commit_oid(commit_graph, i, oids.list[i]);
> +		}
> +		oids.num = commit_graph->num_commits;
> +	}
> +
>  	for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
>  	QSORT(oids.list, oids.num, commit_compare);
>  
> @@ -525,6 +757,11 @@ struct object_id *construct_commit_graph(const char *pack_dir)
>  	hashcpy(f_hash->hash, final_hash);
>  	fname = get_commit_graph_filename_hash(pack_dir, f_hash);
>  
> +	if (commit_graph) {
> +		close_commit_graph(commit_graph);
> +		FREE_AND_NULL(commit_graph);
> +	}
> +
>  	if (rename(graph_name, fname))
>  		die("failed to rename %s to %s", graph_name, fname);

What is the relation of these changes to construct_commit_graph() to the
rest of the patch?

> diff --git a/commit-graph.h b/commit-graph.h
> index 43eb0aec84..05ddbbe165 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -4,6 +4,18 @@
>  #include "git-compat-util.h"
>  #include "commit.h"
>  
> +/**
> + * Given a commit struct, try to fill the commit struct info, including:
> + *  1. tree object
> + *  2. date
> + *  3. parents.
> + *
> + * Returns 1 if and only if the commit was found in the packed graph.
> + *
> + * See parse_commit_buffer() for the fallback after this call.
> + */
> +extern int parse_commit_in_graph(struct commit *item);
> +
>  extern struct object_id *get_graph_head_hash(const char *pack_dir,
>  					     struct object_id *hash);
>  extern char* get_commit_graph_filename_hash(const char *pack_dir,
> @@ -40,7 +52,13 @@ extern struct commit_graph {
>  
>  extern int close_commit_graph(struct commit_graph *g);
>  
> -extern struct commit_graph *load_commit_graph_one(const char *graph_file, const char *pack_dir);
> +extern struct commit_graph *load_commit_graph_one(const char *graph_file,
> +						  const char *pack_dir);
> +extern void prepare_commit_graph(void);
> +
> +extern struct object_id *get_nth_commit_oid(struct commit_graph *g,
> +					    uint32_t n,
> +					    struct object_id *oid);
>  
>  extern struct object_id *construct_commit_graph(const char *pack_dir);

This header file now contains functions for reading the commit graph,
and functions for writing one. It seems to me that those are (and should
be) quite disjoint, so it might be better to separate them into two.

> -int parse_commit_gently(struct commit *item, int quiet_on_missing)
> +int parse_commit_internal(struct commit *item, int quiet_on_missing, int check_packed)
>  {
>  	enum object_type type;
>  	void *buffer;
> @@ -385,6 +386,8 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
>  		return -1;
>  	if (item->object.parsed)
>  		return 0;
> +	if (check_packed && parse_commit_in_graph(item))
> +		return 0;
>  	buffer = read_sha1_file(item->object.oid.hash, &type, &size);
>  	if (!buffer)
>  		return quiet_on_missing ? -1 :
> @@ -404,6 +407,11 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
>  	return ret;
>  }
>  
> +int parse_commit_gently(struct commit *item, int quiet_on_missing)
> +{
> +	return parse_commit_internal(item, quiet_on_missing, 1);
> +}

Are you planning to use parse_commit_internal() from elsewhere? (It
doesn't seem to be the case, at least from this patch series.)

> diff --git a/log-tree.c b/log-tree.c
> index fca29d4799..156aed4541 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -659,8 +659,7 @@ void show_log(struct rev_info *opt)
>  		show_mergetag(opt, commit);
>  	}
>  
> -	if (!get_cached_commit_buffer(commit, NULL))
> -		return;
> +	get_commit_buffer(commit, NULL);

This undoes an optimization that I discuss in my e-mail message here
[1]. If we decide to do this, it should at least be called out in the
commit message.

[1] https://public-inbox.org/git/b88725476d9f13ba4381d85e5fe049f6ef93f621.1506714999.git.jonathantanmy@google.com/

> +_graph_git_two_modes() {

No need for the name to start with an underscore, I think.

> +    git -c core.commitgraph=true $1 >output
> +    git -c core.commitgraph=false $1 >expect
> +    cmp output expect

Use test_cmp.

> +}
> +
> +_graph_git_behavior() {
> +    BRANCH=$1
> +    COMPARE=$2
> +    test_expect_success 'check normal git operations' \
> +        '_graph_git_two_modes "log --oneline ${BRANCH}" &&
> +         _graph_git_two_modes "log --topo-order ${BRANCH}" &&
> +         _graph_git_two_modes "branch -vv" &&
> +         _graph_git_two_modes "merge-base -a ${BRANCH} ${COMPARE}"'
> +}

This makes it difficult to debug failing tests, since they're all named
the same. Better to just run the commands inline, and wrap the
invocations of _graph_git_behavior in an appropriately named
test_expect_success.
