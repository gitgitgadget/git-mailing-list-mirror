Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 228511F463
	for <e@80x24.org>; Thu, 12 Sep 2019 02:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfILCHw (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 22:07:52 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45126 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfILCHw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 22:07:52 -0400
Received: by mail-qk1-f193.google.com with SMTP id z67so22876303qkb.12
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 19:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qi748lb+j56K+4FTweLZfZh9lolhl7HjzA2GxlSQQbY=;
        b=mt+6EwyEf9qoQxSlhoQ3IZWe+ghcCuO0Yz+Z2yAf6wLWHxoeZnY49W9EQ87cLp8Nv6
         cJwAFoQdWRZ6ZWvK9DppstKzJdliOwSqBx+SeAq19t4VJVgMSCB50U4RVhYYcz56GZxX
         L0o+yVUGlT+4HOu3onA6TavVnZr4ixrItaBjqKbgfQglBOG92x8OekXDLRHD5yD8fgXB
         VyrTRyhFQ+zPT2P4gj/f+KrmNVb5WqWWlK2M+ihZ4+kkF0QvRnFCW3lCsBBtiqpA5Kos
         +WNBJYlD5B7L/rbtYnrpqpHfH+OryZzZAlTiLygKfPHWMEt3pCczoYifDbY8dplQVRSN
         Q+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qi748lb+j56K+4FTweLZfZh9lolhl7HjzA2GxlSQQbY=;
        b=aTAd0QIgV8GgP+p7OZAjZAfwqCZEsyplRvJATcwrENKygQ/wPM6XcuwRtIvjbo/ARp
         LfFSwPpWqDrympPtfoe+MgKOA9Qu50BIA31rrvI4ycNyW2vQn35ox6eYoK2cNw+311mD
         gVoESHLEuouGQG7AeHJT/vxquaTYh+zXdu6+jeuqUNS/yF56dpVC4dpDo1TwhAEYM7Cn
         SWA4awD4hSeBSP6048usFkaddNXbZyBYhjX0KgBkWJ7bCz/ZthvNnl5Q0Kceys+CLBJP
         PQkZWVz0kEUfQTpfe0oTjlMMXRWnTdSNz0YTXE7dUqtaSxwrfDo1knyJvIMJb8K2p4NG
         htvA==
X-Gm-Message-State: APjAAAWyEBC07RnSKGWnM1XROwHMouaPsGgKzTcbHee2cDB3uqrB9t4U
        Vp3dxDYFIqusMPJz55HZqrxTFg==
X-Google-Smtp-Source: APXvYqy4/cO0LWMNrW6PTC/JdENL0UX8vsYPxdSYNytcfjMJg591CpR3lhH7Ty7MHTAC7S+LprkNKw==
X-Received: by 2002:a37:6005:: with SMTP id u5mr15545882qkb.79.1568254070123;
        Wed, 11 Sep 2019 19:07:50 -0700 (PDT)
Received: from localhost ([2605:9480:205:dfe1:501f:b6cb:9c99:ccf3])
        by smtp.gmail.com with ESMTPSA id x144sm762995qka.76.2019.09.11.19.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 19:07:49 -0700 (PDT)
Date:   Wed, 11 Sep 2019 22:07:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] upload-pack: disable commit graph more gently for
 shallow traversal
Message-ID: <20190912020748.GA76228@syl.lan>
References: <20190912000414.GA31334@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190912000414.GA31334@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

Thanks in advance for digging into all of this. I feel guilty for having
found the issue myself, and then gotten a headache for just long enough
to have you completely fix the issue by the time that I got back. So,
thanks :-).

On Wed, Sep 11, 2019 at 08:04:15PM -0400, Jeff King wrote:
> When the client has asked for certain shallow options like
> "deepen-since", we do a custom rev-list walk that pretends to be
> shallow. Before doing so, we have to disable the commit-graph, since it
> is not compatible with the shallow view of the repository. That's
> handled by 829a321569 (commit-graph: close_commit_graph before shallow
> walk, 2018-08-20). That commit literally closes and frees our
> repo->objects->commit_graph struct.
>
> That creates an interesting problem for commits that have _already_ been
> parsed using the commit graph. Their commit->object.parsed flag is set,
> their commit->graph_pos is set, but their commit->maybe_tree may still
> be NULL. When somebody later calls repo_get_commit_tree(), we see that
> we haven't loaded the tree oid yet and try to get it from the commit
> graph. But since it has been freed, we segfault!
>
> So the root of the issue is a data dependency between the commit's
> lazy-load of the tree oid and the fact that the commit graph can go
> away mid-process. How can we resolve it?
>
> There are a couple of general approaches:
>
>   1. The obvious answer is to avoid loading the tree from the graph when
>      we see that it's NULL. But then what do we return for the tree oid?
>      If we return NULL, our caller in do_traverse() will rightly
>      complain that we have no tree. We'd have to fallback to loading the
>      actual commit object and re-parsing it. That requires teaching
>      parse_commit_buffer() to understand re-parsing (i.e., not starting
>      from a clean slate and not leaking any allocated bits like parent
>      list pointers).
>
>   2. When we close the commit graph, walk through the set of in-memory
>      objects and clear any graph_pos pointers. But this means we also
>      have to "unparse" any such commits so that we know they still need
>      to open the commit object to fill in their trees. So it's no less
>      complicated than (1), and is more expensive (since we clear objects
>      we might not later need).
>
>   3. Stop freeing the commit-graph struct. Continue to let it be used
>      for lazy-loads of tree oids, but let upload-pack specify that it
>      shouldn't be used for further commit parsing.
>
>   4. Push the whole shallow rev-list out to its own sub-process, with
>      the commit-graph disabled from the start, giving it a clean memory
>      space to work from.
>
> I've chosen (3) here. Options (1) and (2) would work, but are
> non-trivial to implement. Option (4) is more expensive, and I'm not sure
> how complicated it is (shelling out for the actual rev-list part is
> easy, but we do then parse the resulting commits internally, and I'm not
> clear which parts need to be handling shallow-ness).

Option (3) make the most sense to me, too. When I started hacking on a
similar patch, I implemented roughly what you describe in (1), which is
to say that I added an extra:

  && r->objects->commit_graph

To ensure that the 'commit_graph' about to cause a segfault was
non-NULL after calling 'close_commit_graph'. But, as you pointed out:
what are we to return after that? NULL, since we expected it to be in
the commit-graph, but we don't have a commit-graph to check anymore? I
don't think that that makes much sense, and what you implemented here is
clearly better.

> The new test in t5500 triggers this segfault, but see the comments there
> for how horribly intimate it has to be with how both upload-pack and
> commit graphs work.

Thanks for the comment, too. I agree that protocol-level hacking is
somewhat smelly, at least as far as t5500 is concerned, but for this
particular case it seems the only sensible option.

I'm still left scratching my (sore) head about how someone triggered
this in production, but maybe that's a riddle for another day.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  commit-graph.c        | 10 ++++++++++
>  commit-graph.h        |  6 ++++++
>  t/t5500-fetch-pack.sh | 38 ++++++++++++++++++++++++++++++++++++++
>  upload-pack.c         |  2 +-
>  4 files changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 9b02d2c426..bc5dd5913f 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -41,6 +41,8 @@
>  #define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
>  			+ GRAPH_FANOUT_SIZE + the_hash_algo->rawsz)
>
> +static int commit_graph_disabled;
> +
>  char *get_commit_graph_filename(const char *obj_dir)
>  {
>  	char *filename = xstrfmt("%s/info/commit-graph", obj_dir);
> @@ -472,6 +474,9 @@ static int prepare_commit_graph(struct repository *r)
>  		die("dying as requested by the '%s' variable on commit-graph load!",
>  		    GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD);
>
> +	if (commit_graph_disabled)
> +		return 0;
> +
>  	if (r->objects->commit_graph_attempted)
>  		return !!r->objects->commit_graph;
>  	r->objects->commit_graph_attempted = 1;
> @@ -2101,3 +2106,8 @@ void free_commit_graph(struct commit_graph *g)
>  	free(g->filename);
>  	free(g);
>  }
> +
> +void disable_commit_graph(void)
> +{
> +	commit_graph_disabled = 1;
> +}
> diff --git a/commit-graph.h b/commit-graph.h
> index 486e64e591..42d6e7c289 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -107,4 +107,10 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
>  void close_commit_graph(struct raw_object_store *);
>  void free_commit_graph(struct commit_graph *);
>
> +/*
> + * Disable further use of the commit graph in this process when parsing a
> + * "struct commit".
> + */
> +void disable_commit_graph(void);
> +
>  #endif
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 8210f63d41..7601664b74 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -783,6 +783,44 @@ test_expect_success 'clone shallow since selects no commits' '
>  	)
>  '
>
> +# A few subtle things about the request in this test:
> +#
> +#  - the server must have commit-graphs present and enabled

I think "enabled" may be somewhat redundant, at least since some recent
changes to enable this by default. (As an aside, I tried to dig up the
patches that Stolee sent to actually enable this and back up my claim,
but I couldn't find them on 'master'. I'm not sure if that's my poor use
of 'git log', or misremembering the fact that these were enabled by
default.)

> +#
> +#  - the history is such that our want/have share a common ancestor ("base"
> +#    here)
> +#
> +#  - we send only a single have, which is fewer than a normal client would
> +#    send. This ensures that we don't parse "base" up front with
> +#    parse_object(), but rather traverse to it as a parent while deciding if we
> +#    can stop the "have" negotiation, and call parse_commit(). The former
> +#    sees the actual object data and so always loads the three oid, whereas the
> +#    latter will try to lod it lazily.

s/lod/load

> +#
> +#  - we must use protocol v2, because it handles the "have" negotiation before
> +#    processing the shallow direectives
> +#
> +test_expect_success 'shallow since with commit graph and already-seen commit' '
> +	test_create_repo shallow-since-graph &&
> +	(

I'm not sure if this same-level indentation is common, or you're missing
an extra tab here. Either way.

> +	cd shallow-since-graph &&
> +	test_commit base &&
> +	test_commit master &&
> +	git checkout -b other HEAD^ &&
> +	test_commit other &&
> +	git commit-graph write --reachable &&
> +	git config core.commitGraph true &&

Another nit, but do you have any thoughts about using 'test_config' here
instead of a pure 'git config'? I don't think that it really would
matter much (since none of the other tests hopefully have anything to do
with commit-graph, and doubly so if it is enabled by default, _and_
since you're using your own repository), but anyway.
> +
> +	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
> +	0012command=fetch
> +	00010013deepen-since 1
> +	0032want $(git rev-parse other)
> +	0032have $(git rev-parse master)
> +	0000
> +	EOF
> +	)
> +'
> +

Aside from my nit-picking above, the protocol exchange here looks
correct, and your rationale backs it up. Likewise, this causes a
segfault for me on the tip of 'master', and applying the later part of
your patch fixes it for me. Thanks.

>  test_expect_success 'shallow clone exclude tag two' '
>  	test_create_repo shallow-exclude &&
>  	(
> diff --git a/upload-pack.c b/upload-pack.c
> index 222cd3ad89..a260b6b50d 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -722,7 +722,7 @@ static void deepen_by_rev_list(struct packet_writer *writer, int ac,
>  {
>  	struct commit_list *result;
>
> -	close_commit_graph(the_repository->objects);
> +	disable_commit_graph();

This line made me think to check if we could remove 'close_commit_graph'
all together, but there is a remaining callsite in packfile.c, and
closing the commit-graph _is_ the right thing to do there, so I think we
ought to keep it around.

>  	result = get_shallow_commits_by_rev_list(ac, av, SHALLOW, NOT_SHALLOW);
>  	send_shallow(writer, result);
>  	free_commit_list(result);
> --
> 2.23.0.663.gbe3d117559

Thanks,
Taylor
