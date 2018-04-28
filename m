Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB6871F428
	for <e@80x24.org>; Sat, 28 Apr 2018 22:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbeD1WfR (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 18:35:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35716 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbeD1WfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 18:35:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id o78so8613520wmg.0
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 15:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vECdhFFqNhHplpuMbLsjPvFHlVpICNJLQfQOSFPQhzU=;
        b=eTg6vE+83ka7Bw5sjaOjGSE6vAFtQkb0OHp7u/vZ8jTILEeCbIc92eZqmSjuV1FICd
         q+J3NyacpbCRAVuHLKXalczzakksX7meNWCnk7s0rL5QtZGjQjuZlqq+s4hL1DipUXzX
         C2JiO1hRYwBUPVZnQ6MbDPwGi6N+64gcnXC6J2FnVYjFaUByCNaDRSdeSuCwrBT9WZM0
         dw1sFHkuAQ+88qV33u6uUJITrNcaChx7L8yX/2B2zThRjGq0NWjCHbZtWNp16qbWLAuI
         VgpbiNPeoOgfV8hTJLOygRhIicf4U1Bx/+3IyZ9pTaW/Bg3rJc1NGpsVdeGsjzVSZAR4
         9GfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=vECdhFFqNhHplpuMbLsjPvFHlVpICNJLQfQOSFPQhzU=;
        b=BvAE2WcXj3EfGS68k72HX7tIRQHQOQ4rJL4Q5d684ND80uQlbJQta/l6vQ8QVSLyCR
         aQv7m1a7cD+v1AFnHTNojQTr4H1hzJfyGpsLExea0P4B7sil3j/b5oRZLH93Zj69uG2o
         gVa1eCEAr/nHzCnS2LgBJwm864oJB9ztyrd+qezCGOnu6ssmfUgAIakFXvRxSF2oipTR
         rpOns7XnDmrs89fIqOGYOY2U3IirR8oiwLKVjbGiGrEu3eZFc/9JSHr9muu6zfAG0fkq
         Z/9JbZdrhE3brKbIRMFWkjvtad70Q6kEWnuUiDmDhOEAeVWlX3nA8uaRwLKSEYIGUc2W
         gl3A==
X-Gm-Message-State: ALQs6tCQzCgQh2hdRiqciu9BoVirUxwRXFKB0aqV5OOsbdWnbQXhCdbB
        pA0C5uyL4v00mX3SNPRqras=
X-Google-Smtp-Source: AB8JxZr9uz3FdZ9Gp/yPO0lIB/wOZY+pDKHbDM5TC2mZ73TENJSDRpdLSq+rlPfoRZnV/Qryj2PbRw==
X-Received: by 10.28.51.201 with SMTP id z192mr3470037wmz.147.1524954915492;
        Sat, 28 Apr 2018 15:35:15 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abps22.neoplus.adsl.tpnet.pl. [83.8.60.22])
        by smtp.gmail.com with ESMTPSA id 80sm7026360wml.44.2018.04.28.15.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Apr 2018 15:35:14 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 02/10] commit: add generation number to struct commmit
References: <20180417170001.138464-1-dstolee@microsoft.com>
        <20180425143735.240183-1-dstolee@microsoft.com>
        <20180425143735.240183-3-dstolee@microsoft.com>
Date:   Sun, 29 Apr 2018 00:35:12 +0200
In-Reply-To: <20180425143735.240183-3-dstolee@microsoft.com> (Derrick Stolee's
        message of "Wed, 25 Apr 2018 14:37:55 +0000")
Message-ID: <86604bj6xr.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The generation number of a commit is defined recursively as follows:
>
> * If a commit A has no parents, then the generation number of A is one.
> * If a commit A has parents, then the generation number of A is one
>   more than the maximum generation number among the parents of A.

Very minor nitpick: it would be more readable wrapped differently:

  * If a commit A has parents, then the generation number of A is
    one more than the maximum generation number among parents of A.

Very minor nitpick: possibly "parents", not "the parents", but I am
not native English speaker.

>
> Add a uint32_t generation field to struct commit so we can pass this
> information to revision walks. We use three special values to signal
> the generation number is invalid:
>
> GENERATION_NUMBER_INFINITY 0xFFFFFFFF
> GENERATION_NUMBER_MAX 0x3FFFFFFF
> GENERATION_NUMBER_ZERO 0
>
> The first (_INFINITY) means the generation number has not been loaded or
> computed. The second (_MAX) means the generation number is too large to
> store in the commit-graph file. The third (_ZERO) means the generation
> number was loaded from a commit graph file that was written by a version
> of git that did not support generation numbers.

Good explanation; I wonder if we want to have it in some shortened form
also in comments, and not only in the commit message.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  alloc.c        | 1 +
>  commit-graph.c | 2 ++
>  commit.h       | 4 ++++
>  3 files changed, 7 insertions(+)

I have reordered patches to make it easier to review.

> diff --git a/commit.h b/commit.h
> index 23a3f364ed..aac3b8c56f 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -10,6 +10,9 @@
>  #include "pretty.h"
>  
>  #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
> +#define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
> +#define GENERATION_NUMBER_MAX 0x3FFFFFFF
> +#define GENERATION_NUMBER_ZERO 0

I wonder if it wouldn't be good to have some short in-line comments
explaining those constants, or a block comment above them.

>  
>  struct commit_list {
>  	struct commit *item;
> @@ -30,6 +33,7 @@ struct commit {
>  	 */
>  	struct tree *maybe_tree;
>  	uint32_t graph_pos;
> +	uint32_t generation;
>  };
>  
>  extern int save_commit_buffer;

All right, simple addition of the new field.  Nothing to go wrong here.

Sidenote: With 0x7FFFFFFF being (if I am not wrong) maximum graph_pos
and maximum number of nodes in commit graph, we won't hit 0x3FFFFFFF
generation number limit for all except very, very linear histories.

>
> diff --git a/alloc.c b/alloc.c
> index cf4f8b61e1..e8ab14f4a1 100644
> --- a/alloc.c
> +++ b/alloc.c
> @@ -94,6 +94,7 @@ void *alloc_commit_node(void)
>  	c->object.type = OBJ_COMMIT;
>  	c->index = alloc_commit_index();
>  	c->graph_pos = COMMIT_NOT_FROM_GRAPH;
> +	c->generation = GENERATION_NUMBER_INFINITY;
>  	return c;
>  }

All right, start with initializing it with "not from commit-graph" value
after allocation.

>  
> diff --git a/commit-graph.c b/commit-graph.c
> index 70fa1b25fd..9ad21c3ffb 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -262,6 +262,8 @@ static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uin
>  	date_low = get_be32(commit_data + g->hash_len + 12);
>  	item->date = (timestamp_t)((date_high << 32) | date_low);
>  
> +	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
> +

I guess we should not worry about these "magical constants" sprinkled
here, like "+ 8" above.

Let's examine how it goes, taking a look at commit-graph-format.txt
in Documentation/technical/commit-graph-format.txt

 * The first H (g->hash_len) bytes are for the OID of the root tree.
 * The next 8 bytes are for the positions of the first two parents [...]

So 'commit_data + g->hash_len + 8' is our offset from the start of
commit data.  All right.

  * The next 8 bytes store the generation number of the commit and
    the commit time in seconds since EPOCH.  The generation number
    uses the higher 30 bits of the first 4 bytes. [...]

The higher 30 bits of the 4 bytes, which is 32 bits, means that we need
to shift 32-bit value 2 bits right, so that we get lower 30 bits of
32-bit value.  All right.

  All 4-byte numbers are in network order.

Shouldn't it be ntohl() to convert from network order to host order, and
not get_be32()?  I guess they are the same (network order is big-endian
order), and get_be32() is what rest of git uses...

Looks all right.

>  	pptr = &item->parents;
>  
>  	edge_value = get_be32(commit_data + g->hash_len);
