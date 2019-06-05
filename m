Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C8561F609
	for <e@80x24.org>; Wed,  5 Jun 2019 17:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFERWU (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 13:22:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50409 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfFERWU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 13:22:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45867163A60;
        Wed,  5 Jun 2019 13:22:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3K0HIjTYAFoby2hAJAA3cW/QuYk=; b=BVS+Cv
        MwS6u/eQHEudiyFEER/yEfTJDWxvDPZtILnOANsLyMTU9GdJKVqayZJYVHVyu6yY
        74Bri2iFp5rNLkOXtwPbIeOA4WqtzrK4FjSO/UF1i5VCK7F/s3DYWK1QLjVML60O
        PNkDcb26dw+PSsjcRM7se78wGLA7tk6k7vt7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nKAo6i/VkOjZKSpfnE6KQGLeTSxiEeZQ
        RdSI8rhUnhzDx7sxMiICoBW3WzEf76uW0ZuXi+yZ5VVg4SE90h9Sfs+G+QkWMwn1
        oX3GojVtQy75nu1z+EutQTWcf67C01W02nTX/B9QQl0SRfF1tPT+abQ6yH3CHp1W
        24lBHXax3fQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DF03163A5F;
        Wed,  5 Jun 2019 13:22:18 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A009C163A5E;
        Wed,  5 Jun 2019 13:22:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        git@jeffhostetler.com, jrnieder@google.com, steadmon@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 01/14] commit-graph: document commit-graph chains
References: <pull.184.v2.git.gitgitgadget@gmail.com>
        <pull.184.v3.git.gitgitgadget@gmail.com>
        <b184919255bfc9e0d57e1a5ca12fb76957879c61.1559577826.git.gitgitgadget@gmail.com>
Date:   Wed, 05 Jun 2019 10:22:16 -0700
In-Reply-To: <b184919255bfc9e0d57e1a5ca12fb76957879c61.1559577826.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 03 Jun 2019
        09:03:48 -0700 (PDT)")
Message-ID: <xmqqmuiwrlpz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77E411F0-87B6-11E9-AF37-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Add a basic description of commit-graph chains. More details about the
> feature will be added as we add functionality. This introduction gives a
> high-level overview to the goals of the feature and the basic layout of
> commit-graph chains.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/commit-graph.txt | 59 ++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
> index fb53341d5e..1dca3bd8fe 100644
> --- a/Documentation/technical/commit-graph.txt
> +++ b/Documentation/technical/commit-graph.txt
> @@ -127,6 +127,65 @@ Design Details
>    helpful for these clones, anyway. The commit-graph will not be read or
>    written when shallow commits are present.
>  
> +Commit Graphs Chains
> +--------------------
> +
> +Typically, repos grow with near-constant velocity (commits per day). Over time,
> +the number of commits added by a fetch operation is much smaller than the
> +number of commits in the full history. By creating a "chain" of commit-graphs,
> +we enable fast writes of new commit data without rewriting the entire commit
> +history -- at least, most of the time.
> +
> +## File Layout
> +
> +A commit-graph chain uses multiple files, and we use a fixed naming convention
> +to organize these files. Each commit-graph file has a name
> +`$OBJDIR/info/commit-graphs/graph-{hash}.graph` where `{hash}` is the hex-
> +valued hash stored in the footer of that file (which is a hash of the file's
> +contents before that hash). For a chain of commit-graph files, a plain-text
> +file at `$OBJDIR/info/commit-graphs/commit-graph-chain` contains the
> +hashes for the files in order from "lowest" to "highest".
> +
> +For example, if the `commit-graph-chain` file contains the lines
> +
> +```
> +	{hash0}
> +	{hash1}
> +	{hash2}
> +```
> +
> +then the commit-graph chain looks like the following diagram:
> +
> + +-----------------------+
> + |  graph-{hash2}.graph  |
> + +-----------------------+
> +	  |
> + +-----------------------+
> + |                       |
> + |  graph-{hash1}.graph  |
> + |                       |
> + +-----------------------+
> +	  |
> + +-----------------------+
> + |                       |
> + |                       |
> + |                       |
> + |  graph-{hash0}.graph  |
> + |                       |
> + |                       |
> + |                       |
> + +-----------------------+
> +
> +Let X0 be the number of commits in `graph-{hash0}.graph`, X1 be the number of
> +commits in `graph-{hash1}.graph`, and X2 be the number of commits in
> +`graph-{hash2}.graph`. If a commit appears in position i in `graph-{hash2}.graph`,
> +then we interpret this as being the commit in position (X0 + X1 + i), and that
> +will be used as its "graph position". The commits in `graph-{hash2}.graph` use these
> +positions to refer to their parents, which may be in `graph-{hash1}.graph` or
> +`graph-{hash0}.graph`. We can navigate to an arbitrary commit in position j by checking
> +its containment in the intervals [0, X0), [X0, X0 + X1), [X0 + X1, X0 + X1 +
> +X2).

One thing that I fail to read from the above is what it means for
graphs to be inside a single chain.  What is the significance for a
graph file graph-{hash1}.graph to be between graph-{hash0}.graph and
graph-{hash2}.graph?   For example, is any of the following true?

 - For a commit in graph-{hash1}.graph file, if graph->{hash0}.graph
   or any other graph files lower in the position in the chain were
   unavailable, information on some ancestor of that commit may not
   be available.

 - Even if graph-{hash2}.graph or any other graph files higher in
   the position in the chain gets lost, information on a commit in
   graph-{hash1}.graph file or any of its ancestors is not affected.

Another thing I've assumed to be true but cannot read from the above
description is that the hashes in `commit-graph-chain` file, other
than the newest one, are merely redundant information, and each
graph file records the hash of its "previous" graph file (i.e. the
one that used to be the youngest before it got created).


   
