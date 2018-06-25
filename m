Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 475851F516
	for <e@80x24.org>; Mon, 25 Jun 2018 20:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965026AbeFYU6E (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 16:58:04 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36063 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964876AbeFYU6D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 16:58:03 -0400
Received: by mail-wr0-f196.google.com with SMTP id f16-v6so15034271wrm.3
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 13:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+Z0kT8lAl9Xt6hQHA3zm1/DoMIYU3OtR22EbDpVtziU=;
        b=pmDJy9SCgaV4U1Bf57vnxS3Zxe2sDjI5A7OMbbvM700GQesbLXee61pgwh8QJY+iMy
         ixNaY7dWxkPQuJgxZ/5EzR5EJs48LLWZ9ksZqHKYYais6LgBVf7EhajQizEvrKF1c4oe
         HJRKzOyZnTfIVdyWxMmHP0dqZL0wnhBo+shlbI3I71AeteQJBYW9ovirVsNv0UmI0206
         Jo9Xibtu43s+pxnbxQIio/BR04DIlvhdh6wHOgaqvrq/gU7rFflSivY6/2JkM+BtN/vQ
         UfxBTfsODefBDZpiq9IW4praMJdzKjwEM1ZY39asq9UPT9SwfLnjEh3OhFZws+Jty6De
         V8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+Z0kT8lAl9Xt6hQHA3zm1/DoMIYU3OtR22EbDpVtziU=;
        b=j+tp/rQoP2Tz6wKHc7yRGCfYUfiQgws9cjHWNgEY9yJoFAi/qKEaM/On9SiNlCPwB7
         WwHhMi01LHmjhecS5ArxRIEVqBEiAAJqgN0V/fBXfd1Cmi60dPj40fg6LnXvHW4PzgDk
         vMX36i7SExjO+m12EnC1Cj7KLqO0F6eVjHasTpey9EhyDKv3q8RdYaOAdsb/X6Ob3I30
         C4xzAPN4DQpTyeI3BDaZXsTSil/lXhLKVvZxt07MzfctFYi7w7De2tgsz0YGAZ0MBGXS
         h2BNNOcQoURUdwpGvRkPCfjI3IJKpQKju2XuOQSx3LjSt965sqTSsyHWIC9lWVW1IfPN
         /D9A==
X-Gm-Message-State: APt69E1D0vHEH2eW9RiigFpI15mu7oYg6kjM5JsY4qn9c8/ieH99ff/L
        DNY2PuVks6ZbNgrSjhlyk5Y=
X-Google-Smtp-Source: AAOMgpeFBzjCzY98FkNqB6Kv9L/ijFP8pMhgCP/G2+pfk1vNoJuXflaKHYRSm+JiiGksWGysNqyyiw==
X-Received: by 2002:adf:8062:: with SMTP id 89-v6mr7461298wrk.221.1529960282402;
        Mon, 25 Jun 2018 13:58:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h3-v6sm2050330wro.87.2018.06.25.13.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 13:58:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 4/5] commit-graph: store graph in struct object_store
References: <cover.1529616356.git.jonathantanmy@google.com>
        <3410494e3505a7b1b895869c3702dbba0f0cf5a6.1529616356.git.jonathantanmy@google.com>
Date:   Mon, 25 Jun 2018 13:57:59 -0700
In-Reply-To: <3410494e3505a7b1b895869c3702dbba0f0cf5a6.1529616356.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Thu, 21 Jun 2018 14:29:24 -0700")
Message-ID: <xmqqwoummvmw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Instead of storing commit graphs in static variables, store them in
> struct object_store. There are no changes to the signatures of existing
> functions - they all still only support the_repository, and support for
> other instances of struct repository will be added in a subsequent
> commit.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  commit-graph.c | 34 ++++++++++++++++++----------------
>  object-store.h |  3 +++
>  object.c       |  5 +++++
>  3 files changed, 26 insertions(+), 16 deletions(-)
> ...
> @@ -293,7 +290,9 @@ int parse_commit_in_graph(struct commit *item)
>  		return 1;
>  
>  	prepare_commit_graph();
> -	if (commit_graph) {
> +	if (the_repository->objects->commit_graph) {
> +		struct commit_graph *commit_graph =
> +			the_repository->objects->commit_graph;
>  		uint32_t pos;
>  		int found;
>  		if (item->graph_pos != COMMIT_NOT_FROM_GRAPH) {
> @@ -329,7 +328,8 @@ struct tree *get_commit_tree_in_graph(const struct commit *c)
>  	if (c->graph_pos == COMMIT_NOT_FROM_GRAPH)
>  		BUG("get_commit_tree_in_graph called from non-commit-graph commit");
>  
> -	return load_tree_for_commit(commit_graph, (struct commit *)c);
> +	return load_tree_for_commit(the_repository->objects->commit_graph,
> +				    (struct commit *)c);
>  }

I was looking at semantic merge conflicts between this and your
e2838d85 ("commit-graph: always load commit-graph information",
2018-05-01), the latter of which I planned to merge to 'master' as a
part of the first batch in this cycle, and noticed that there are
two very similar functions, without enough document the callers
would not know which one is the correct one to call.  Needless to
say, such a code duplication would mean the work required for
resolving semantic conflict doubles needlessly X-<.


int parse_commit_in_graph(struct commit *item)
{
	uint32_t pos;

	if (!core_commit_graph)
		return 0;
	if (item->object.parsed)
		return 1;
	prepare_commit_graph();
	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
		return fill_commit_in_graph(item, commit_graph, pos);
	return 0;
}

void load_commit_graph_info(struct commit *item)
{
	uint32_t pos;
	if (!core_commit_graph)
		return;
	prepare_commit_graph();
	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
		fill_commit_graph_info(item, commit_graph, pos);
}
