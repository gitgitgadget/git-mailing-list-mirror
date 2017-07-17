Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B53AA20357
	for <e@80x24.org>; Mon, 17 Jul 2017 18:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbdGQSGI (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 14:06:08 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34969 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbdGQSGH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 14:06:07 -0400
Received: by mail-pg0-f54.google.com with SMTP id v190so25638336pgv.2
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 11:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+8SNYuAC/ghMGIuFoBU4ag3+qHB0z0440rAdLqRJYwc=;
        b=t5YHmtZR+ZjSz6QIO8yDOmUo10qlOwtlXbT0j34aNwLii0KfeiR3CdqwGoAh2ybznd
         DKcirJdwR1EJeihyeAoZogzE1N3LQDSdUzkwsSY/Tu2LSNq2X24KD/Sjd2QAO9Bw2E9r
         nbQu2EgC6zpgYlwPacfY+rDUREsqxRAbXv2UEGBohnNoSGsVzzUMxtXymiNLpj45RI7i
         e7vE699C/y4AiF65xe9dXYQXaQj/fkYiEl5SG7aPregRyn62e6zZ88IMzI1p9FMsTbuB
         DMX5J4Kr/QdI/Y7gRZDKZ/r/HY7E+mrscDb012z4XZsMQ4Orn55mYg4geu3fGlBC99RG
         zAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+8SNYuAC/ghMGIuFoBU4ag3+qHB0z0440rAdLqRJYwc=;
        b=DqwxhoJBoV3IWPwTc70qEx1LSFlXHFnc8xy/pig5S5qfsLuL/qHBx0txSR/vGWtoCL
         Sb+Uk+6mDxvdWaDj01YC/TzbT7FCz8kGV1gB/Hs5iaDRqiAQszcxiszZn/P9xPs4XC1m
         EL209X0YU2XqImCcbv2K30qsF16grUg8OYquLq4EJHu9X+yFGDRzVrtlqg0/q1uHpu2q
         UIA8Yccxghlpk6l6YmylzXJJfZ7JBlAp19mYxuLZf1H8LyXxEKLcA5F01IwcqeL4KQeD
         rILG107M3zZjBjs1uq9nB5hJzQqiSkUwxSMimP6n2ncHJTt6Tt75w78Y8xVC0yqu+GXj
         WYTA==
X-Gm-Message-State: AIVw113sy1G/DMMrLrRAXi1Jrz64eTnicCXBgd7BIbgILeM+D9i1VIPW
        gJ8FNWMFFuUmHFbc
X-Received: by 10.84.169.36 with SMTP id g33mr32417202plb.52.1500314767131;
        Mon, 17 Jul 2017 11:06:07 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:4537:6747:cb98:8004])
        by smtp.gmail.com with ESMTPSA id 68sm41890911pfi.69.2017.07.17.11.06.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 11:06:06 -0700 (PDT)
Date:   Mon, 17 Jul 2017 11:06:02 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        pclouds@gmail.com, christian.couder@gmail.com,
        git@jeffhostetler.com
Subject: Re: [PATCH v2 1/1] sha1_file: Add support for downloading blobs on
 demand
Message-ID: <20170717110602.6fac89ea@twelve2.svl.corp.google.com>
In-Reply-To: <20170714132651.170708-2-benpeart@microsoft.com>
References: <20170714132651.170708-1-benpeart@microsoft.com>
        <20170714132651.170708-2-benpeart@microsoft.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

About the difference between this patch and my patch set [1], besides
the fact that this patch does not spawn separate processes for each
missing object, which does seem like an improvement to me, this patch
(i) does not use a list of promised objects (but instead communicates
with the hook for each missing object), and (ii) provides backwards
compatibility with other Git code (that does not know about promised
objects) in a different way.

The costs and benefits of (i) are being discussed here [2]. As for (ii),
I still think that my approach is better - I have commented more about
this below.

Maybe the best approach is a combination of both our approaches.

[1] https://public-inbox.org/git/34efd9e9936fdab331655f5a33a098a72dc134f4.1499800530.git.jonathantanmy@google.com/

[2] https://public-inbox.org/git/20170713123951.5cab1adc@twelve2.svl.corp.google.com/

On Fri, 14 Jul 2017 09:26:51 -0400
Ben Peart <peartben@gmail.com> wrote:

> +------------------------
> +packet: git> command=get
> +packet: git> sha1=0a214a649e1b3d5011e14a3dc227753f2bd2be05
> +packet: git> 0000
> +------------------------

It would be useful to have this command support more than one SHA-1, so
that hooks that know how to batch can do so.

> +static int subprocess_map_initialized;
> +static struct hashmap subprocess_map;

The documentation of "tablesize" in "struct hashmap" states that it can
be used to check if the hashmap is initialized, so
subprocess_map_initialized is probably unnecessary.

>  static int check_and_freshen(const unsigned char *sha1, int freshen)
>  {
> -	return check_and_freshen_local(sha1, freshen) ||
> -	       check_and_freshen_nonlocal(sha1, freshen);
> +	int ret;
> +	int already_retried = 0;
> +
> +retry:
> +	ret = check_and_freshen_local(sha1, freshen) ||
> +		check_and_freshen_nonlocal(sha1, freshen);
> +	if (!ret && core_virtualize_objects && !already_retried) {
> +		already_retried = 1;
> +		if (!read_object_process(sha1))
> +			goto retry;
> +	}
> +
> +	return ret;
>  }

Is this change meant to ensure that Git code that operates on loose
objects directly (bypassing storage-agnostic functions such as
sha1_object_info_extended() and has_sha1_file()) still work? If yes,
this patch appears incomplete (for example, read_loose_object() needs to
be changed too), and this seems like a difficult task - in my patch set
[1], I ended up deciding to create a separate type of storage and
instead looked at the code that operates on *packed* objects directly
(because there were fewer such methods) to ensure that they would work
correctly in the presence of a separate type of storage.

[1] https://public-inbox.org/git/34efd9e9936fdab331655f5a33a098a72dc134f4.1499800530.git.jonathantanmy@google.com/
