Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9236B1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 16:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeDTQrm (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 12:47:42 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:41012 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbeDTQrl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 12:47:41 -0400
Received: by mail-wr0-f174.google.com with SMTP id v24-v6so24598672wra.8
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 09:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4owNlLhzLaYhb3TmxPj23T7LZPFO2ITrEJWEoI7jZKU=;
        b=VY1ODBpXwOkftwg1zb3p4Jh3FFqoAbgHZs/M9MMJqzvvvFS2BHgR8bFc0mdfYFXTKT
         r3XrpWJzyxakjw7NeU24MSbonV3PQ01u7JcwRdtQa2Ce0wbRCshsV17Hi8kjJP+B5xQT
         4Y3bZ3sJ3dTY9tm9c5oMHnU39BmUvMQ6ssfXqgxzAnnnEUIVTkT4mYOdLeydCjFhrYWz
         8eCL4zvb4RIyZ51uuQ7AdybaiOmedHdFdbN7bRlKXT3CiBdsHZWBZcDdvIRpsFy5sEHA
         oGH/MvwOfwUkkMhnSfYbnypb4MC5HD0ITwL5Rnrgd/NGsGOpuYImnxyObv2HDKrnLJe4
         migA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=4owNlLhzLaYhb3TmxPj23T7LZPFO2ITrEJWEoI7jZKU=;
        b=MNuhYr+H6kmNEVYs6C7GiyQnHiOb51+SnwGTbx97LimbcIS9XdW5Gk2424xU9Sw9Il
         Vs+5dlZ3cI9OYsWuiaBWaOrZXovSinRa8TsllKojvI9Y/xCaBn+cCPnz4gmTKdSrEtAq
         zZdJHx2KCMtvtC1WjyevWgft9TArStGC+/mqosO1b9y3w2SEud8Re/6wbwf0x37/JMfd
         3/PtOJLRoU3fyrT1bfCo6NkjK8aceyJpFYR3WamXE/wwOFdJLgFEN0erLEsFGtn8l7mp
         MN7+KrrYWCSmYw4FkOG5ygVOyUpjJpqJU1qGRm/KAb3uawmBnIM69mQbWLOHGNQLORiM
         1f8g==
X-Gm-Message-State: ALQs6tD6cC9g0wS4qQvN94zTbi0T6yLuDo1ExAN4U1jEKzOEpAWEmUd8
        yqLT5HKatgV3RLtmf1SXmh0=
X-Google-Smtp-Source: AIpwx49k0N3vpnqGde9W8tQx62YkhQQ4uQ3e3rNy/0cOF+lTO6zwc8UcJtq97A78u9BaWVeYk5iN6A==
X-Received: by 10.28.41.133 with SMTP id p127mr2720933wmp.0.1524242860175;
        Fri, 20 Apr 2018 09:47:40 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id 44-v6sm5293271wrl.83.2018.04.20.09.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 09:47:38 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 08/12] commit-graph: verify commit contents against odb
References: <20180417181028.198397-1-dstolee@microsoft.com>
        <20180417181028.198397-9-dstolee@microsoft.com>
Date:   Fri, 20 Apr 2018 18:47:38 +0200
In-Reply-To: <20180417181028.198397-9-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 17 Apr 2018 18:10:43 +0000")
Message-ID: <86h8o5eset.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

One more check that could been done, and which do not require accessing
the object database, would be testing correctness of the Large Edge List
(EDGE) chunk.

For each commit in the commit-graph (in the Commit Data (CDAT) chunk),
check if it has more than two parents (if the value for second parent is
different from 0xffffffff but has the most significant bit set).  If
there is any such commit, then.

1. Check that EDGE chunk exists
2. For each octopus merge:
   - check that the index into EDGE array is less than number of its
     elements (sanity check the index)
   - for each parent in the EDGE list, check if the position is valid:
     is less than number of commits in the commit-graph
   - check that list of parents in EDGE terminates
3. If feasible, also check that
   - all entries in EDGE chunk are referenced directly or indirectly
   - number of parent list terminators (with most significant bit set)
     is equal to the number of octopus merges (no overlap of parent
     lists) -- if it is considered an error

> When running 'git commit-graph check', compare the contents of the
> commits that are loaded from the commit-graph file with commits that are
> loaded directly from the object database. This includes checking the
> root tree object ID, commit date, and parents.

All right, this part requires checking the object database.

>
> In addition, verify the generation number calculation is correct for all
> commits in the commit-graph file.

But if I understand the code correctly, this one does not require
accessing the object database.  This is entirely separate check, and in
my opinion it should be a separate commit (a separate patch).

Also, there might be a problem with handling GENERATION_NUMBER_MAX.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)

I guess testing for this would be hard - you would need to create
invalid commit-graph file...

>
> diff --git a/commit-graph.c b/commit-graph.c
> index 80a2ac2a6a..b5bce2bac4 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -899,5 +899,87 @@ int check_commit_graph(struct commit_graph *g)
>  				     graph_commit->graph_pos, i);
>  	}
>  
> +	for (i = 0; i < g->num_commits; i++) {
> +		struct commit *graph_commit, *odb_commit;
> +		struct commit_list *graph_parents, *odb_parents;
> +		int num_parents = 0;
> +
> +		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
> +
> +		graph_commit = lookup_commit(&cur_oid);
> +		odb_commit = (struct commit *)create_object(cur_oid.hash, alloc_commit_node());
> +		if (parse_commit_internal(odb_commit, 0, 0))
> +			graph_report(_("failed to parse %s from object database"), oid_to_hex(&cur_oid));

Is it an error to have commit in the commit-graph that is not present in
the object database?

It may happen (if commit-graph is not automatically updated on gc and
pruning), that since creating the commit-graph, the user have deleted
the branch and pruned object database -- then commit-graph can contain
objects that are not present in the object database.

> +
> +		if (oidcmp(&get_commit_tree_in_graph_one(g, graph_commit)->object.oid,
> +			   get_commit_tree_oid(odb_commit)))
> +			graph_report(_("root tree object ID for commit %s in commit-graph is %s != %s"),
> +				     oid_to_hex(&cur_oid),
> +				     oid_to_hex(get_commit_tree_oid(graph_commit)),
> +				     oid_to_hex(get_commit_tree_oid(odb_commit)));

Looks good to me, nicely detailed error message.

> +
> +		if (graph_commit->date != odb_commit->date)
> +			graph_report(_("commit date for commit %s in commit-graph is %"PRItime" != %"PRItime""),
> +				     oid_to_hex(&cur_oid),
> +				     graph_commit->date,
> +				     odb_commit->date);

Looks good to me, nicely detailed error message.
It is good to have the same format of the message.

> +
> +
> +		graph_parents = graph_commit->parents;
> +		odb_parents = odb_commit->parents;
> +
> +		while (graph_parents) {
> +			num_parents++;
> +
> +			if (odb_parents == NULL)
> +				graph_report(_("commit-graph parent list for commit %s is too long (%d)"),
> +					     oid_to_hex(&cur_oid),
> +					     num_parents);
> +
> +			if (oidcmp(&graph_parents->item->object.oid, &odb_parents->item->object.oid))
> +				graph_report(_("commit-graph parent for %s is %s != %s"),
> +					     oid_to_hex(&cur_oid),
> +					     oid_to_hex(&graph_parents->item->object.oid),
> +					     oid_to_hex(&odb_parents->item->object.oid));
> +
> +			graph_parents = graph_parents->next;
> +			odb_parents = odb_parents->next;
> +		}
> +
> +		if (odb_parents != NULL)
> +			graph_report(_("commit-graph parent list for commit %s terminates early"),
> +				     oid_to_hex(&cur_oid));

All right.  We check that there are no parents in odb that are not
present in the commit-graph, and vice-versa (that there are no parents
in commit-graph that are not present in odb), and we check that all
parents match.

Looks good to me, nicely detailed error message.
It is good to have the same format of the message.

> +
> +		if (graph_commit->generation) {

All right, here we know that the generation number for the commit is not
GENERATION_NUMBER_ZERO because we checked for it, and we know that it is
not GENERATION_NUMBER_INFINITY because the commit was in commit-graph.

> +			uint32_t max_generation = 0;
> +			graph_parents = graph_commit->parents;
> +
> +			while (graph_parents) {
> +				if (graph_parents->item->generation == GENERATION_NUMBER_ZERO ||
> +				    graph_parents->item->generation == GENERATION_NUMBER_INFINITY)
> +					graph_report(_("commit-graph has valid generation for %s but not its parent, %s"),

What about the case of GENERATION_NUMBER_MAX?  It is an error if parent
has GENERATION_NUMBER_MAX and the commit does not, but it would be
caught by the following check, if with the less helpful error message.

But if commit has GENERATION_NUMBER_MAX, then its parents can have also
GENERATION_NUMBER_MAX, and the following check would fail event if it is
valid, isn't it?

> +						     oid_to_hex(&cur_oid),
> +						     oid_to_hex(&graph_parents->item->object.oid));
> +				if (graph_parents->item->generation > max_generation)
> +					max_generation = graph_parents->item->generation;
> +				graph_parents = graph_parents->next;
> +			}
> +
> +			if (graph_commit->generation != max_generation + 1)
> +				graph_report(_("commit-graph has incorrect generation for %s"),
> +					     oid_to_hex(&cur_oid));

I wonder if we might have to treat the case of parent-less commits (root
commits) special, but I guess that would complicate the code for no
reason.

Though perhaps adding " (root commit)" suffix would be a good idea.
Still complicates code, though.

> +		} else {
> +			graph_parents = graph_commit->parents;
> +
> +			while (graph_parents) {
> +				if (graph_parents->item->generation)
> +					graph_report(_("commit-graph has generation ZERO for %s but not its parent, %s"),

Good check.

> +						     oid_to_hex(&cur_oid),
> +						     oid_to_hex(&graph_parents->item->object.oid));
> +				graph_parents = graph_parents->next;
> +			}
> +		}
> +	}
> +
>  	return check_commit_graph_error;
>  }
