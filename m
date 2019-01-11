Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEF12211B5
	for <e@80x24.org>; Fri, 11 Jan 2019 19:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388874AbfAKTna (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 14:43:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36602 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732097AbfAKTn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 14:43:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so16445497wrp.3
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 11:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LiH3UkdIdhRdsLP/2Iee6qCvQmXInmFNuxVkhqEmEjY=;
        b=Gj6lmkUpwIVTgaksHa4c1KTH2RZkvtwH4n/enEXnENV08w36vT00iMN6bXtpmX5iHL
         F5dOimYT+YDGo4irmiXuPqPM3SihQrHguThYpjcsmCUUPuorJhVfDZPhcUQVsbLlbW5O
         fVMYk9Yt0q2R75PnoVDQd3CV5a+/1YuEkoNXrDClNvmhCJLX6XdslJqdVM0GMHWzzBvJ
         dYCPCf+9fvmvEVva73shPAAZ5k6uJntWOROJHJsujvpn7WAk4t0oseb3PQ1vv4JfbKnK
         Az01jM8BsAy732kap3M3vXlyAcVt3AJAb8qEgGfKKL9jXRtr1SlOKRHaVkWgGzWKnQDe
         OGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LiH3UkdIdhRdsLP/2Iee6qCvQmXInmFNuxVkhqEmEjY=;
        b=bYNH2DJSWvnuB5gNBkXOHHwxPVZTbFZ7nPiTP3/YNne/dg52LmX1LDaB8A4ry2NQEd
         PSOJi3cCidUhtIaiSI7bIgnDRN/Ak7lSSGDdE0MlJz+viXiXCTsxHnyviI7s9ZNSH8S2
         7qn501fwdTvcjJp1oyn9U+eK0sE5mbZW/fU1iu3mzPLqaWtaiN93az5z5VYy6D+jrxo2
         ToWtacNJHwMI8t+PmYxK6BPS9igaDaNRM8u48EJlV6FpA+EWAOOfO8t3XmevUEFOfhMU
         +VD1iQaxGWMNymV1pfE8tghimdrf4uMedVqd7PnlsLi/005W0SkUTG0ZuZFfmGBQGdLN
         ChYA==
X-Gm-Message-State: AJcUukdo5CfelNE9V+9ASdc2aISu5hfC8TDbhSph+6kVIhKchDFTLpE0
        nGM0zpXcw6ObctZiiSgHxxA=
X-Google-Smtp-Source: ALg8bN4k7E7U8PgYBpMnFXqps+cTWnb68X7rpK0S7K0Gxg2zIO0BVsSG/M9qRxHR9SuYRQjUrXIuDQ==
X-Received: by 2002:adf:a50c:: with SMTP id i12mr14118859wrb.220.1547235807513;
        Fri, 11 Jan 2019 11:43:27 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h62sm17452090wmf.11.2019.01.11.11.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 11:43:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 1/6] revision: add mark_tree_uninteresting_sparse
References: <pull.89.v3.git.gitgitgadget@gmail.com>
        <pull.89.v4.git.gitgitgadget@gmail.com>
        <817e30a287e12ce8e94ce41fcb969dd8ae53b9ce.1544822533.git.gitgitgadget@gmail.com>
Date:   Fri, 11 Jan 2019 11:43:25 -0800
In-Reply-To: <817e30a287e12ce8e94ce41fcb969dd8ae53b9ce.1544822533.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 14 Dec 2018
        13:22:17 -0800 (PST)")
Message-ID: <xmqqzhs7x9nm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> In preparation for a new algorithm that walks fewer trees when
> creating a pack from a set of revisions, create a method that
> takes an oidset of tree oids and marks reachable objects as
> UNINTERESTING.
>
> The current implementation uses the existing
> mark_tree_uninteresting to recursively walk the trees and blobs.
> This will walk the same number of trees as the old mechanism.
>
> There is one new assumption in this approach: we are also given
> the oids of the interesting trees. This implementation does not
> use those trees at the moment, but we will use them in a later
> rewrite of this method.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  revision.c | 25 +++++++++++++++++++++++++
>  revision.h |  2 ++
>  2 files changed, 27 insertions(+)
>
> diff --git a/revision.c b/revision.c
> index 13e0519c02..f9eb6400f1 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -99,6 +99,31 @@ void mark_tree_uninteresting(struct repository *r, struct tree *tree)
>  	mark_tree_contents_uninteresting(r, tree);
>  }
>  
> +void mark_trees_uninteresting_sparse(struct repository *r,
> +				     struct oidset *set)
> +{
> +	struct object_id *oid;
> +	struct oidset_iter iter;
> +
> +	oidset_iter_init(set, &iter);
> +	while ((oid = oidset_iter_next(&iter))) {
> +		struct tree *tree = lookup_tree(r, oid);
> +
> +		if (!tree)
> +			continue;
> +
> +		if (tree->object.flags & UNINTERESTING) {
> +			/*
> +			 * Remove the flag so the next call
> +			 * is not a no-op. The flag is added
> +			 * in mark_tree_unintersting().
> +			 */
> +			tree->object.flags ^= UNINTERESTING;
> +			mark_tree_uninteresting(r, tree);
> +		}

The proposed log message claims that the method takes an oidset and
marks reachable objects as uninteresting, but the implementation
only marks those that are reachable from already uninteresting
trees.  Either one of them must be wrong.

Did you mean to have this instead?

		if (!tree)
			continue;
		/*
		 * Force traversal of the tree, even if it has been
		 * already marked as UNINTERESTING.
		 */
		tree->object.flags &= ~UNINTERESTING;
		mark_tree_uninteresting(r, tree);

By the way, one of the bigger reasons why I have to ask, instead of
making an educated guess, is because "struct oidset *set" parameter
does not give any useful information with the variable name to the
readers.  We know it is a set because its type is oidset; readers
need to know what meaning the 'set' has, what it is used for, why
the caller wants to (or decides not to) place a tree object in the
set when it calls it.  None of that can be read from its name.
