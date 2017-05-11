Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F76F20188
	for <e@80x24.org>; Thu, 11 May 2017 03:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754647AbdEKDqc (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 23:46:32 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33284 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754611AbdEKDqa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 23:46:30 -0400
Received: by mail-pg0-f67.google.com with SMTP id s62so1877580pgc.0
        for <git@vger.kernel.org>; Wed, 10 May 2017 20:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DcjM8z4HDOwweaJNhyoC0g/wDXXZRwqyvIhPHNccicY=;
        b=S+6i5/tmKux/+vIYFF0S7RIku+2rqgQio4k0d5cQ3u1SSP6bVEIG27hJtcssxShCDr
         vWhyIMX9/5RK7nQhv2ztpdbm/IfeIxzeylAifr/ngblcEk7o09/2JFF47/hyu9T9fakn
         fhVc5Pu14ezsC3FZ+42enxmOAFYa+ZG+6pqCEaw4zxtC4eqZaOMm6+qRsB/zdDYQwuOT
         Ov6qlflsLtY50JMLed08A3brqFZX0uWapPpF/1FykT55NX9uStSeMNMkQPzzM5e3gXiw
         NgQz1i40HTaEV7Qp1IBRVi9raWXYjZr6BOQCOBcXbIz+aUV4fl8/fm/zYe2E6P8KVi5X
         gQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DcjM8z4HDOwweaJNhyoC0g/wDXXZRwqyvIhPHNccicY=;
        b=qLiSsTc9BgcdGwH2pgorf6Kk+XvxR/1IDLVoi0xfdQMcDJ/xUW47zB0IPd+zHEo4O2
         jEyeBQdvv0+OKIpTTzmhBJSLy+hak24z/nZ2h/8slz+nr/oLmpxgssQZ4J02JkrxFctF
         b2vQQiKybeAEM5HNoMfCdymbTWaDjqTXtocf5ewDKi/9fGgEsQcQaPlKNA2tMJcEYeX5
         nfl6mPx9bRw/PgVGMX/xsve5hfTONW+Gv0uSObxhSDOlPUDXcpfAO1x+CgU3y4ZTSqhq
         8dRgAztc+kNyf5ZO1hVEizzpBorb/HjHICsH1fEHnbRD3/w8HwYGCaK+suQ6ZTbTBVJt
         QpiQ==
X-Gm-Message-State: AODbwcAMsqfNz3tGf5G2homGIkjDjT6BeZEQFFFisrM9PNFcKfUB9YOD
        7qMJuU7ks20j9Q==
X-Received: by 10.99.95.143 with SMTP id t137mr9927303pgb.127.1494474389653;
        Wed, 10 May 2017 20:46:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4994:7ba7:e883:c475])
        by smtp.gmail.com with ESMTPSA id g10sm638331pgn.35.2017.05.10.20.46.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 20:46:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org, rashmipai36@gmail.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/3] read-tree -m: make error message for merging 0 trees less smart aleck
References: <20170503162931.30721-1-jn.avila@free.fr>
        <20170503210726.24121-1-jn.avila@free.fr>
        <20170503210726.24121-2-jn.avila@free.fr>
Date:   Wed, 10 May 2017 20:46:28 -0700
In-Reply-To: <20170503210726.24121-2-jn.avila@free.fr> (Jean-Noel Avila's
        message of "Wed, 3 May 2017 23:07:25 +0200")
Message-ID: <xmqq60h8cay3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noel Avila <jn.avila@free.fr> writes:

> "git read-tree -m" requires a tree argument to name the tree to be
> merged in.  Git uses a cutesy error message to say so and why:
>
>     $ git read-tree -m
>     warning: read-tree: emptying the index with no arguments is
>     deprecated; use --empty
>     fatal: just how do you expect me to merge 0 trees?
>     $ git read-tree -m --empty
>     fatal: just how do you expect me to merge 0 trees?

This shows another issue.  The "emptying ... is deprecated" message
shouldn't be given when -m is present.

I am not saying that that needs to be fixed by you and/or as a part
of this patch.  Just something I noticed while reviewing the patch.

>  Merging
>  -------
> -If `-m` is specified, 'git read-tree' can perform 3 kinds of
> -merge, a single tree merge if only 1 tree is given, a
> -fast-forward merge with 2 trees, or a 3-way merge if 3 trees are
> -provided.
> +If `-m` is specified, at least one tree must be given on the command
> +line. 'git read-tree' can perform 3 kinds of merge, a single tree
> +merge if only 1 tree is given, a fast-forward merge with 2 trees, or a
> +3-way merge if 3 trees are provided.

It may not incorrect per-se, but the existing enumeration already
say 1, 2 and 3 are the valid choices, so "at least one" may be
redundant.

One incorrectness that needs to be changed is "if 3 trees are
provided"; it is "if 3 or more trees".  Again, not the topic of your
change, but this one you may want to address while you are at it.

>  	if (opts.merge) {
> -		if (stage < 2)
> -			die("just how do you expect me to merge %d trees?", stage-1);
>  		switch (stage - 1) {
> +		case 0:

Could "stage" be 0 (or negative) when we come here?  If so, this rewrite
may no longer diagnose the error correctly in such a case.

	... goes and looks ...

I think it begins with either 0 or 1 and then only counts up, so we
should be safe.  Rolling it in the switch() like this patch does
makes it easier to follow what is going on, I think.

> +			die("you must specify at least one tree to merge");
> +			break;
>  		case 1:
>  			opts.fn = opts.prefix ? bind_merge : oneway_merge;
>  			break;

Thanks.

