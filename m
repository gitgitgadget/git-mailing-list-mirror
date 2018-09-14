Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 710361F404
	for <e@80x24.org>; Fri, 14 Sep 2018 17:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeINWik (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 18:38:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33172 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbeINWij (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 18:38:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id v90-v6so11384764wrc.0
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1mzEurV5biU+dtykjJB+UpIP40k66sDdGXASrV7SPao=;
        b=BOmqv4CRGItxdu+L8oeb+eG+2Fy27cKQi3Rq6KzNs7lfVrbSIyR6i0G2PH6g3A9h9b
         c/EQHhkrDqZf1LRkrRLbMeM1GYSAHV7HsZW5PapOolQ6B8WLdOYGmsSQL0VcTM5hKvVT
         I/hKzVa0cJQv3pqmMGZMfj7O1bSSDi62yzAwK382gdDUqgbYKuqoyN+UeTUYsPC/4RH+
         CF/Ecs4J/MQvjnMJJqoDb7uix5MNr9KvJRZTu5S5yu+JiV7nL1jn0uz5B0IYI7uWfpRl
         p4/l0kTEXSicc+6LbBp4S3eYQQDB+OiapIH6jPJUj3iWV4l+tqa/XCTyfXiEpgtyOjXb
         BcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1mzEurV5biU+dtykjJB+UpIP40k66sDdGXASrV7SPao=;
        b=MlDCP9pxIJdZ3MGbKyZGQDWx00UbkRZofbqKcQj2ZCPxdvWgqx8Hb+D7DqegPiVrW7
         QDJCxA9Dq7sBvoXTOk743PSjKVFYR0R3Sm3iMGXpSf5Q9mYvbEmxNm3/L4EP6jXZf1PM
         urppU8vInfklpmFC6Zvk7PUzv5ZSL+q0WXxq5FOOCvrxogHex6sLttekVcB1VZwouUhZ
         CwAi8l6XSTDieK0OwyXcl83gv2NG2WDpMrHo58RVm1qaoboOMf8l0b6VpjwTyPtEWQRs
         OW95CAsPhKFDGG921e+P6hXc+qJnEFAShnZzlpaQiJO/dIzNaJMQlod4NX28sgGRFGxt
         69bw==
X-Gm-Message-State: APzg51BnywqyMfgC21dxenojGEFglYoagjaHMZin6aIP99dsuDie//Qt
        E8GKc4nNfzAKaFTAnWr2fZ4=
X-Google-Smtp-Source: ANB0VdbrxxAR7LPbSgljxdZ4DB/2kdsRBs+JkgjId3OVt0YLiXvh1qeAnkP6sCOyJAUXF4yFy1f/+Q==
X-Received: by 2002:adf:ab0b:: with SMTP id q11-v6mr11136998wrc.239.1536945790957;
        Fri, 14 Sep 2018 10:23:10 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y5-v6sm8874993wrd.5.2018.09.14.10.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 10:23:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     sbeller@google.com, git@vger.kernel.org, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: Re: [PATCH v8 5/7] revision: mark non-user-given objects instead
References: <cover.1533854545.git.matvore@google.com>
        <cover.1536885967.git.matvore@google.com>
        <ca25f5914a98455cb6908a34146c10101d3529b0.1536885967.git.matvore@google.com>
Date:   Fri, 14 Sep 2018 10:23:09 -0700
In-Reply-To: <ca25f5914a98455cb6908a34146c10101d3529b0.1536885967.git.matvore@google.com>
        (Matthew DeVore's message of "Thu, 13 Sep 2018 17:55:25 -0700")
Message-ID: <xmqqzhwkat8i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> Currently, list-objects.c incorrectly treats all root trees of commits
> as USER_GIVEN. Also, it would be easier to mark objects that are
> non-user-given instead of user-given, since the places in the code
> where we access an object through a reference are more obvious than
> the places where we access an object that was given by the user.
>
> Resolve these two problems by introducing a flag NOT_USER_GIVEN that
> marks blobs and trees that are non-user-given, replacing USER_GIVEN.
> (Only blobs and trees are marked because this mark is only used when
> filtering objects, and filtering of other types of objects is not
> supported yet.)
>
> This fixes a bug in that git rev-list behaved differently from git
> pack-objects. pack-objects would *not* filter objects given explicitly
> on the command line and rev-list would filter. This was because the two
> commands used a different function to add objects to the rev_info
> struct. This seems to have been an oversight, and pack-objects has the
> correct behavior, so I added a test to make sure that rev-list now
> behaves properly.
>
> Signed-off-by: Matthew DeVore <matvore@google.com>
>
> fixup of 6defd70de

That's probably meant to go below "---".

> ---
>  list-objects.c                      | 31 +++++++++++++++++------------
>  revision.c                          |  1 -
>  revision.h                          | 11 ++++++++--
>  t/t6112-rev-list-filters-objects.sh | 10 ++++++++++
>  4 files changed, 37 insertions(+), 16 deletions(-)
>
> diff --git a/list-objects.c b/list-objects.c
> index 243192af5..7a1a0929d 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -53,7 +53,7 @@ static void process_blob(struct traversal_context *ctx,
>  
>  	pathlen = path->len;
>  	strbuf_addstr(path, name);
> -	if (!(obj->flags & USER_GIVEN) && ctx->filter_fn)
> +	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn)
>  		r = ctx->filter_fn(LOFS_BLOB, obj,
>  				   path->buf, &path->buf[pathlen],
>  				   ctx->filter_data);
> @@ -120,17 +120,19 @@ static void process_tree_contents(struct traversal_context *ctx,
>  				continue;
>  		}
>  
> -		if (S_ISDIR(entry.mode))
> -			process_tree(ctx,
> -				     lookup_tree(the_repository, entry.oid),
> -				     base, entry.path);
> +		if (S_ISDIR(entry.mode)) {
> +			struct tree *t = lookup_tree(the_repository, entry.oid);
> +			t->object.flags |= NOT_USER_GIVEN;
> +			process_tree(ctx, t, base, entry.path);
> +		}
>  		else if (S_ISGITLINK(entry.mode))
>  			process_gitlink(ctx, entry.oid->hash,
>  					base, entry.path);
> -		else
> -			process_blob(ctx,
> -				     lookup_blob(the_repository, entry.oid),
> -				     base, entry.path);
> +		else {
> +			struct blob *b = lookup_blob(the_repository, entry.oid);
> +			b->object.flags |= NOT_USER_GIVEN;
> +			process_blob(ctx, b, base, entry.path);
> +		}
>  	}
>  }
>  
> @@ -171,7 +173,7 @@ static void process_tree(struct traversal_context *ctx,
>  	}
>  
>  	strbuf_addstr(base, name);
> -	if (!(obj->flags & USER_GIVEN) && ctx->filter_fn)
> +	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn)
>  		r = ctx->filter_fn(LOFS_BEGIN_TREE, obj,
>  				   base->buf, &base->buf[baselen],
>  				   ctx->filter_data);
> @@ -185,7 +187,7 @@ static void process_tree(struct traversal_context *ctx,
>  	if (!failed_parse)
>  		process_tree_contents(ctx, tree, base);
>  
> -	if (!(obj->flags & USER_GIVEN) && ctx->filter_fn) {
> +	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn) {
>  		r = ctx->filter_fn(LOFS_END_TREE, obj,
>  				   base->buf, &base->buf[baselen],
>  				   ctx->filter_data);
> @@ -301,8 +303,11 @@ static void do_traverse(struct traversal_context *ctx)
>  		 * an uninteresting boundary commit may not have its tree
>  		 * parsed yet, but we are not going to show them anyway
>  		 */
> -		if (get_commit_tree(commit))
> -			add_pending_tree(ctx->revs, get_commit_tree(commit));
> +		if (get_commit_tree(commit)) {
> +			struct tree *tree = get_commit_tree(commit);
> +			tree->object.flags |= NOT_USER_GIVEN;
> +			add_pending_tree(ctx->revs, tree);
> +		}
>  		ctx->show_commit(commit, ctx->show_data);
>  
>  		if (ctx->revs->tree_blobs_in_commit_order)
> diff --git a/revision.c b/revision.c
> index de4dce600..72d48a17f 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -175,7 +175,6 @@ static void add_pending_object_with_path(struct rev_info *revs,
>  		strbuf_release(&buf);
>  		return; /* do not add the commit itself */
>  	}
> -	obj->flags |= USER_GIVEN;
>  	add_object_array_with_path(obj, name, &revs->pending, mode, path);
>  }
>  
> diff --git a/revision.h b/revision.h
> index 5910613cb..83e164039 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -21,9 +21,16 @@
>  #define SYMMETRIC_LEFT	(1u<<8)
>  #define PATCHSAME	(1u<<9)
>  #define BOTTOM		(1u<<10)
> -#define USER_GIVEN	(1u<<25) /* given directly by the user */
> +/*
> + * Indicates object was reached by traversal. i.e. not given by user on
> + * command-line or stdin.
> + * NEEDSWORK: NOT_USER_GIVEN doesn't apply to commits because we only support
> + * filtering trees and blobs, but it may be useful to support filtering commits
> + * in the future.
> + */
> +#define NOT_USER_GIVEN	(1u<<25)
>  #define TRACK_LINEAR	(1u<<26)
> -#define ALL_REV_FLAGS	(((1u<<11)-1) | USER_GIVEN | TRACK_LINEAR)
> +#define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR)
>  
>  #define DECORATE_SHORT_REFS	1
>  #define DECORATE_FULL_REFS	2
> diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
> index c662c97db..2e07dadf0 100755
> --- a/t/t6112-rev-list-filters-objects.sh
> +++ b/t/t6112-rev-list-filters-objects.sh
> @@ -30,6 +30,16 @@ test_expect_success 'verify blob:none omits all 5 blobs' '
>  	test_cmp observed expected
>  '
>  
> +test_expect_success 'specify blob explicitly prevents filtering' '
> +	file_3=$(git -C r1 ls-files -s file.3 \
> +		| awk -f print_2.awk) &&
> +	file_4=$(git -C r1 ls-files -s file.4 \
> +		| awk -f print_2.awk) &&
> +	git -C r1 rev-list HEAD --objects --filter=blob:none HEAD $file_3 >observed &&
> +	grep -q "$file_3" observed &&
> +	test_must_fail grep -q "$file_4" observed
> +'
> +
>  test_expect_success 'verify emitted+omitted == all' '
>  	git -C r1 rev-list HEAD --objects \
>  		| awk -f print_1.awk \
