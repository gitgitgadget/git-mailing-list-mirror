Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA9791F404
	for <e@80x24.org>; Wed, 21 Feb 2018 20:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750988AbeBUULT (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 15:11:19 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39007 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeBUULS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 15:11:18 -0500
Received: by mail-wr0-f196.google.com with SMTP id w77so7940004wrc.6
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 12:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BdA1/Y9UDHHWUiue593t0AV+2T/G6fAODyLgSP9DDtg=;
        b=AM+cfju17Zs9U6kI+gyNxy91DGHTpRpI/vh+vf7L4Pe5UPg0X+jJFXjfC+4Ufs+nZq
         8e2BHSiyZs1hKFAmtTxcjxFi5baW5KomiPMSqqlTCP5g+cg+ePZZXYdvaAl+tkpmkiWC
         W32LO3HvY1Yafzf0DS709jFSjz+0w70nLBVw5o8wRhMod38cbKJx+Yoq8VdD1utsQ+bj
         R+se16vOGlsZdo9qVBaKkhOJ4GQscU9SW172Xv276dD4J3m0KuzSjU9rk21RacGxDnoX
         FU3njDlC+768aIdQ8NQW7o2Y+mOK7ix8z1wmN/txYi9g2ztHcvQkEHx/9F1P8f9MwGWV
         +JEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BdA1/Y9UDHHWUiue593t0AV+2T/G6fAODyLgSP9DDtg=;
        b=qClmJ/34cQO8AqJTs5ymN0yPVZpR0cRrVi+cqKsz6WsVIMfuLIz4JX3zD8nBuGJTr2
         KID1ZH+UEEyUJp66TuAvlHkX8VYOClD2t6qQqwqk/5Ho9b+LOkIHrVHpOryetciB5Zjo
         h35w36/nyWhLM/eS7+lZs6A6aykmO0QOrjjrPA0kravCgBPEf/P660RO0crCjolu6Ob5
         WeSVPvNld4nEjaxk69kMucyS7xkyIFtSfjxkYq1IwktGij19h6xJGEJO0x+bLOoFPalB
         uinc1McIsoplp1uZDNTvuMZCwteWtA1N50d13aejFoGWjAjCWSv2nhHRLcoRMPBuOIag
         58YA==
X-Gm-Message-State: APf1xPAHdhju2cZWZCCnDbmq2+cDgYVHYpshIvwxXBOvFMp69wDMCNQb
        MyqYyWKjzd66KUIx3gwSz9Q=
X-Google-Smtp-Source: AH8x225J6Ram/uU1T8QO4THn5MNrjMw44z/q36+lzVIhDeg5yXuupQrtk9r78rmk/llwjzAMQeafiw==
X-Received: by 10.223.160.100 with SMTP id l33mr3999214wrl.51.1519243875877;
        Wed, 21 Feb 2018 12:11:15 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k2sm566716wrc.30.2018.02.21.12.11.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 12:11:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 06/13] commit-graph: implement git commit-graph read
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        <1519066406-81663-7-git-send-email-dstolee@microsoft.com>
Date:   Wed, 21 Feb 2018 12:11:14 -0800
In-Reply-To: <1519066406-81663-7-git-send-email-dstolee@microsoft.com>
        (Derrick Stolee's message of "Mon, 19 Feb 2018 13:53:19 -0500")
Message-ID: <xmqq371uyufx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> +'read'::
> +
> +Read a graph file given by the graph-head file and output basic
> +details about the graph file.
> ++
> +With `--file=<name>` option, consider the graph stored in the file at
> +the path  <object-dir>/info/<name>.
> +

A sample reader confusion after reading the above twice:

    What is "the graph-head file" and how does the user specify it?  Is
    it given by  the value for the "--file=<name>" command line option?

Another sample reader reaction after reading the above:

    What are the kind of "basic details" we can learn from this
    command is unclear, but perhaps there is an example to help me
    decide if this command is worth studying.

> @@ -44,6 +53,12 @@ EXAMPLES
>  $ git commit-graph write
>  ------------------------------------------------
>  
> +* Read basic information from a graph file.
> ++
> +------------------------------------------------
> +$ git commit-graph read --file=<name>
> +------------------------------------------------
> +

And the sample reader is utterly disappointed at this point.

> +static int graph_read(int argc, const char **argv)
> +{
> +	struct commit_graph *graph = 0;
> +	struct strbuf full_path = STRBUF_INIT;
> +
> +	static struct option builtin_commit_graph_read_options[] = {
> +		{ OPTION_STRING, 'o', "object-dir", &opts.obj_dir,
> +			N_("dir"),
> +			N_("The object directory to store the graph") },
> +		{ OPTION_STRING, 'H', "file", &opts.graph_file,
> +			N_("file"),
> +			N_("The filename for a specific commit graph file in the object directory."),
> +			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> +		OPT_END(),
> +	};

The same comment as all the previous ones apply, wrt short options
and non-use of OPT_STRING().

Also, I suspect that these two would want to use OPT_FILENAME
instead, if we anticipate that the command might want to be
sometimes run from a subdirectory.  Otherwise wouldn't

	cd t && git commit-graph read --file=../.git/object/info/$whatever

end up referring to a wrong place because the code that uses the
value obtained from OPTION_STRING does not do the equivalent of
parse-options.c::fix_filename()?  The same applies to object-dir
handling.

> +	argc = parse_options(argc, argv, NULL,
> +			     builtin_commit_graph_read_options,
> +			     builtin_commit_graph_read_usage, 0);
> +
> +	if (!opts.obj_dir)
> +		opts.obj_dir = get_object_directory();
> +
> +	if (!opts.graph_file)
> +		die("no graph hash specified");
> +
> +	strbuf_addf(&full_path, "%s/info/%s", opts.obj_dir, opts.graph_file);

Ahh, I was fooled by a misnamed option.  --file does *not* name the
file.  It is a filename in a fixed place that is determined by other
things.

So it would be a mistake to use OPT_FILENAME() in the parser for
that misnamed "--file" option.  The parser for --object-dir still
would want to be OPT_FILENAME(), but quite honestly, I do not see
the point of having --object-dir option in the first place.  The
graph file is not relative to it but is forced to have /info/ in
between that directory and the filename, so it is not like the user
gets useful flexibility out of being able to specify two different
places using --object-dir= option and $GIT_OBJECT_DIRECTORY
environment (iow, a caller that wants to work on a specific object
directory can use the environment, which is how it would tell any
other Git subcommand which object store it wants to work with).

But stepping back a bit, I think the way --file argument is defined
is halfway off from two possible more useful ways to define it.  If
it were just "path to the file" (iow, what OPT_FILENAME() is suited
for parsing it), then a user could say "I have this graph file that
I created for testing, it is not installed in its usual place in
$GIT_OBJECT_DIRECTORY/info/ at all, but I want you to read it
because I am debugging".  That is one possible useful extreme.  The
other possibility would be to allow *only* the hash part to be
specified, iow, not just forcing /info/ relative to object
directory, you would force the "graph-" prefix and ".graph" suffix.
That would be the other extreme that is useful (less typing and less
error prone).

For a low-level command line this, my gut feeling is that it would
be better to allow paths to the object directory and the graph file
to be totally independently specified.

> +	if (graph_signature != GRAPH_SIGNATURE) {
> +		munmap(graph_map, graph_size);
> +		close(fd);
> +		die("graph signature %X does not match signature %X",
> +			graph_signature, GRAPH_SIGNATURE);
> +	}
> +
> +	graph_version = *(unsigned char*)(data + 4);
> +	if (graph_version != GRAPH_VERSION) {
> +		munmap(graph_map, graph_size);
> +		close(fd);
> +		die("graph version %X does not match version %X",
> +			graph_version, GRAPH_VERSION);
> +	}
> +
> +	hash_version = *(unsigned char*)(data + 5);
> +	if (hash_version != GRAPH_OID_VERSION) {
> +		munmap(graph_map, graph_size);
> +		close(fd);
> +		die("hash version %X does not match version %X",
> +			hash_version, GRAPH_OID_VERSION);

It becomes a bit tiring to see munmap/close/die pattern repreated
over and over again, doesn't it?  Can we make it simpler, perhaps by
letting die() take care of the clean-up?  After all, if the very
next step dies because alloc_commit_graph() got NULL in xmalloc(),
we are letting die() there take care of the clean-up anyway already,
and die() in the chunk parsing look has no such cleanup, either.

Of course, when we later want to libify this part of the code, then
we wouldn't be calling die() from this codepath, but the change
required to do so will not be just s/die/error/; it would be more
like

	if (x_version != X_VERSION) {
		error("X version %X does not match",...);
		goto cleanup_fail;
	}

with munmap/close done at the jumped-to label.

> +	}
> +
> +	graph = alloc_commit_graph();
> +
> +	graph->hash_len = GRAPH_OID_LEN;
> + ...
> +		if (chunk_offset > graph_size - GIT_MAX_RAWSZ)
> +			die("improper chunk offset %08x%08x", (uint32_t)(chunk_offset >> 32),
> +			    (uint32_t)chunk_offset);
> +
> +		switch (chunk_id) {
> +			case GRAPH_CHUNKID_OIDFANOUT:
> +				graph->chunk_oid_fanout = (uint32_t*)(data + chunk_offset);
> +				break;

This is over-indented from our point of view.  In our codebase, case
arms aling with switch, i.e.

		switch (chunk_id) {
		case GRAPH_CHUNKID_OIDFANOUT:
			graph->chunk_oid_fanout = ...;
			break;

When the input file has GRAPH_CHUNKID_OIDFANOUT twice, I think it
should be flagged as a corrupt/malformed input file, causing the
reader to reject it.  It is plausible that you wanted to make it
"the last one wins", but even if that is the case, I think the user
should at least get a warning, as (I'd imagine) it is an unusual
condition.

The same applies to multiple instances of any currently-defined
chunk types.

> +graph_read_expect() {
> +	OPTIONAL=""
> +	NUM_CHUNKS=3
> +	if [ ! -z $2 ]

We use "test" and do not use "[ ... ]" or "[[ ... ]]".

I'll stop here.

