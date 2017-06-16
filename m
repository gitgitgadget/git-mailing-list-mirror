Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27EF01FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 22:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbdFPWry (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 18:47:54 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36824 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdFPWrw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 18:47:52 -0400
Received: by mail-pg0-f67.google.com with SMTP id v18so8045551pgb.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 15:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=I3xegdGO37ikXCFRm1ns/mTYE5e6A+L2oO+105BnNpA=;
        b=kp2kIArifmiaVSUvuSaaLnlZqwE1P1BLuaSZc1erKslAboWep1nZyd0KHASAk46mPZ
         /mxzsN5kij1YuBX8LpnTXazczbJHHFT56xcAGVJZF8TIyTRrQWwhZNojgA3qmEFiw5qD
         v2eIH5Ef6vEhF76N+3i7CHg9/2FFGd1prH73t0j1rxwQ3eP9TvSkI0gNY/uDcwSHX/1P
         3nJZsnbLrqgjSma0TznQ0XgjRILUOxot/5AlpAhVwTPlOzApGLuPlrDsKM04QpCxPO8t
         aXq3dOLkwdVrnj6chlCZkaTQJVZNcikkfeZPvl5IwuYnEr00vcc/lV/P4T8g2qdsmNDF
         0UhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=I3xegdGO37ikXCFRm1ns/mTYE5e6A+L2oO+105BnNpA=;
        b=JeLSGi0DEP1tCUGY7iqlM3FIKLOCpbtMrJ6JqQNQY6us4awSQpmXvwt7qGK8mUn6Ne
         TrUAWqdJfHjz50wuSJKfguQXfhsf/gqH89pdH0c1iwUK8jj4zBmyhk+NmuDMJvqCNTJr
         nXKnv/ER+Vz352lBGB/6ev60eI72PcwZgdzDTD3SUDHnlKY3o55V4URAt/7J8/L07Lot
         J38w6yKDB1N6BPUd9ZimCzdsRG08lAZJ+DskktpX/psdl35Rh/Bm5WP1EJ/RM1DGLREl
         8aufu7vui395Qs9Wm65NehtAQqdYQ8PJuFjODRf5zFM2jLzbKOtCnYuepHBY+e9NLVjs
         waKw==
X-Gm-Message-State: AKS2vOzJzexNBvzECItCFJHLhQsvJybPl1oiEXQUsKq8gsmwPwQpaGcW
        2cHzLv5HMmz/7A==
X-Received: by 10.84.217.138 with SMTP id p10mr10709539pli.66.1497653271747;
        Fri, 16 Jun 2017 15:47:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3047:3460:ee36:a98a])
        by smtp.gmail.com with ESMTPSA id z69sm7391231pff.0.2017.06.16.15.47.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 15:47:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 5/5] stash: implement builtin stash
References: <20170608005535.13080-1-joel@teichroeb.net>
        <20170608005535.13080-6-joel@teichroeb.net>
Date:   Fri, 16 Jun 2017 15:47:49 -0700
In-Reply-To: <20170608005535.13080-6-joel@teichroeb.net> (Joel Teichroeb's
        message of "Wed, 7 Jun 2017 17:55:35 -0700")
Message-ID: <xmqqvanvv9be.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Teichroeb <joel@teichroeb.net> writes:

> +static void stash_create_callback(struct diff_queue_struct *q,
> +				struct diff_options *opt, void *cbdata)
> +{
> +	int i;
> +
> +	for (i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p = q->queue[i];
> +		const char *path = p->one->path;
> +		struct stat st;

The order is somewhat ugly.  Move "struct stat st;" that does not
have any initialization at the beginning.

> +		remove_file_from_index(&the_index, path);
> +		if (!lstat(path, &st))
> +			add_to_index(&the_index, path, &st, 0);
> +	}
> +}

So this will be called with list of paths that are different from
the working tree and the index, and adds all the paths the index
knows about to the index from the working tree?  Sounds OK, but I am
not sure if that is "stash_create_callback()".  Surely it is _part_
of creating a stash, but it would be better to name it to reflect
which part of creating a stash this helper is about.  I think this
is about recording the working tree state, so I would have expected
"record" and/or "working_tree" in its name.

> +/*
> + * Untracked files are stored by themselves in a parentless commit, for
> + * ease of unpacking later.
> + */
> +static int save_untracked(struct stash_info *info, const char *message,
> +		int include_untracked, int include_ignored, const char **argv)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	struct object_id orig_tree;
> +	int ret;
> +	const char *index_file = get_index_file();
> +
> +	set_alternate_index_output(stash_index_path);
> +	untracked_files(&out, include_untracked, include_ignored, argv);
> +
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "update-index", "-z", "--add", "--remove",
> +		"--stdin", NULL);
> +	argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s", stash_index_path);
> +
> +	if (pipe_command(&cp, out.buf, out.len, NULL, 0, NULL, 0)) {
> +		strbuf_release(&out);
> +		return 1;
> +	}
> +

OK, that's a very straight-forward way of doing this, and as we do
not care too much about performance in this initial conversion to C,
it is even sensible.  In a later update after this patch lands, you
may want to use dir.c's fill_directory() API to find the untracked
files and add them yourself internally, without running ls-files (in
untracked_files()) or update-index (here) as subprocesses, but that
is in the future.  Let's get this round finished.

> +	strbuf_reset(&out);
> +
> +	discard_cache();
> +	read_cache_from(stash_index_path);
> +
> +	write_index_as_tree(orig_tree.hash, &the_index, stash_index_path, 0,NULL);

SP before "NULL".

> +	discard_cache();
> +
> +	read_cache_from(stash_index_path);

Hmph, what did anybody change in the on-disk stash_index (or
contents in the_index) since you read_cache_from()?

> +	write_cache_as_tree(info->u_tree.hash, 0, NULL);

Then you write exactly the same index contents again, this time to
info->u_tree here.  I am not sure why you need to do this twice, and
I do not see how orig_tree.hash you wrote earlier is used?

> +	strbuf_addf(&out, "untracked files on %s", message);
> +
> +	ret = commit_tree(out.buf, out.len, info->u_tree.hash, NULL,
> +			info->u_commit.hash, NULL, NULL);
> +	strbuf_release(&out);
> +	if (ret)
> +		return 1;
> +
> +	set_alternate_index_output(index_file);
> +	discard_cache();
> +	read_cache();
> +
> +	return 0;
> +}

OK, except for minor nits, this seems to correctly replicate what
u_commit=$(...) does in create_stash shell function in the original.

> +static int save_working_tree(struct stash_info *info, const char *prefix,
> +		const char **argv)
> +{
> +	struct object_id orig_tree;
> +	struct rev_info rev;
> +	int nr_trees = 1;
> +	struct tree_desc t[MAX_UNPACK_TREES];
> +	struct tree *tree;
> +	struct unpack_trees_options opts;
> +	struct object *obj;
> +
> +	discard_cache();
> +	tree = parse_tree_indirect(&info->i_tree);
> +	prime_cache_tree(&the_index, tree);
> +	write_index_as_tree(orig_tree.hash, &the_index, stash_index_path, 0, NULL);
> +	discard_cache();

Hmph, the caller of this function did read_cache(), refresh_index(),
and write_cache_as_tree(), and the result is in info->i_tree.
The above sequence discards, reads that tree into the index and
writes the same tree again.  Which seems like a huge no-op.  IIUC,
the write_cache_as_tree() the caller already did should have already 
primed the cache-tree structure, too.  These five lines are puzzling.

> +	read_cache_from(stash_index_path);

Hmph, it is unclear who wrote what state to this $TMPindex from this
codeflow.  Do you really want to read from there?  I am guessing
that this part corresponds to w_tree=$( ... ) in create_stash shell
function, which does "read-tree --index-output=$TMPindex -m $i_tree"
starting from the real $GIT_DIR/index and the call to unpack_tree()
that follows here is that "read-tree".

A one-way "read-tree -m" is purely a performance measure and the
resulting index will have the entries in $i_tree no matter what
index contents you start from, so you may not have seen an incorrect
result per-se, but I suspect that you do not want to be reading from
$TMPindex here.  Puzzled...

> +
> +	memset(&opts, 0, sizeof(opts));
> +
> +	parse_tree(tree);
> +
> +	opts.head_idx = 1;
> +	opts.src_index = &the_index;
> +	opts.dst_index = &the_index;
> +	opts.merge = 1;
> +	opts.fn = oneway_merge;
> +
> +	init_tree_desc(t, tree->buffer, tree->size);
> +
> +	if (unpack_trees(nr_trees, t, &opts))
> +		return 1;
> +
> +	init_revisions(&rev, prefix);
> +	setup_revisions(0, NULL, &rev, NULL);
> +	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
> +	rev.diffopt.format_callback = stash_create_callback;
> +	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
> +
> +	parse_pathspec(&rev.prune_data, 0, 0, prefix, argv);
> +
> +	diff_setup_done(&rev.diffopt);
> +	obj = parse_object(&info->b_commit);
> +	add_pending_object(&rev, obj, "");
> +	if (run_diff_index(&rev, 0))
> +		return 1;
> +
> +	if (write_cache_as_tree(info->w_tree.hash, 0, NULL))
> +		return 1;
> +
> +	discard_cache();
> +	read_cache();
> +
> +	return 0;
> +}

This part otherwise looks like a correct way to grab changes to the
working tree into w_tree.

Again, I need to stop here for now.  Will continue later.


