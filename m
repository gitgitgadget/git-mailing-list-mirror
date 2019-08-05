Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D95D61F731
	for <e@80x24.org>; Mon,  5 Aug 2019 13:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfHEN5X (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 09:57:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36581 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfHEN5W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 09:57:22 -0400
Received: by mail-qk1-f195.google.com with SMTP id g18so60112220qkl.3
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 06:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/4wL0Cc201P753zdE7HEdABxgWNgccpBfWCMFbF++zM=;
        b=m1Er5IwLK1WtSVSl7HK1KeDnu4hn2uDL1ab5W/E+l3rm3gPnX7I+A0n4jl2yx2QxPl
         +tt4vXPOwoz/1H96NvUHUFVyEbCbdF+0N93zY9Qt+j6oQrM+yM/6VnSDCFeU6TiOje7h
         XQoTTUxzXY3qa9WcDXEzOjvkoSh8ucGVYpLq9za/MyMgk0VLMbQu4ohMAh3Hhb8sOL/F
         CaaaV+cwFy09MkwxdvFrtKncFTSwYbkk1MH7MRWRhdYFlkP+eFkz+0V7c2AXyemS4UAU
         VR3gSii9B8jXphF/JOM9LPtBafI79FtpPbT2kRGFYCEsaxdZHfOFOaHRK+qhk3I8zPUH
         xxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/4wL0Cc201P753zdE7HEdABxgWNgccpBfWCMFbF++zM=;
        b=Ebkz83XXGZeLeMUISnsVRXep0M/4l7Ekz6XA3N+dwqJms0oRff+dT86FCvAmDVxVoh
         L37+9O4sDTOO/ljnl7dbA0qz6B05lQTew0SWudmEmWA3263fESTKfNulxhvK2sYTvQ08
         Wctvg8nR0o+LyxpQQ003Pt1w5dKuDmSjAMowGSocSgSLtlF3HEkNzyLlwvIyuWcAxAxq
         r1e0lfaER0FGEoE5Jgzvr6H2SCHpzhVhZrvHfn3/K533kKF191XSwM7WV3TI3pU1iD+l
         aGD3KZr3w1PSYnZMPbV/4oa27YbuiyQZ1aIGu/iEOMAGsW0vDJ4lgVoPLXY6jtXi1UYr
         XBMw==
X-Gm-Message-State: APjAAAX/jyueSXrlYrLf+shAR3U+Dzco3Ad3J/aJbjQh4C1uoFlXruwG
        Dhhrtr8BSyFuTT7/5WbPO5z2ORLYrfE=
X-Google-Smtp-Source: APXvYqyM749R10lGqVYJRaJUi+FVz4keCR8YRZ8rpNqAH393gvtwwg4YutDNE0DjFA3E3uZX3JGBrw==
X-Received: by 2002:a37:e30b:: with SMTP id y11mr106364787qki.100.1565013441272;
        Mon, 05 Aug 2019 06:57:21 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:80c4:823c:202:ca1a? ([2001:4898:a800:1012:31f8:823c:202:ca1a])
        by smtp.gmail.com with ESMTPSA id c5sm50883478qta.5.2019.08.05.06.57.19
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 06:57:20 -0700 (PDT)
Subject: Re: [PATCH 3/3] commit-graph: error out on invalid commit oids in
 'write --stdin-commits'
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
References: <20190805080240.30892-1-szeder.dev@gmail.com>
 <20190805080240.30892-4-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ecdd6c01-5ee2-6869-4eb3-1eb45f4c335c@gmail.com>
Date:   Mon, 5 Aug 2019 09:57:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190805080240.30892-4-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/5/2019 4:02 AM, SZEDER Gábor wrote:
> While 'git commit-graph write --stdin-commits' expects commit object
> ids as input, it accepts and silently skips over any invalid commit
> object ids, and still exits with success:
> 
>   # nonsense
>   $ echo not-a-commit-oid | git commit-graph write --stdin-commits
>   $ echo $?
>   0
>   # sometimes I forgot that refs are not good...
>   $ echo HEAD | git commit-graph write --stdin-commits
>   $ echo $?
>   0
>   # valid tree OID, but not a commit OID
>   $ git rev-parse HEAD^{tree} | git commit-graph write --stdin-commits
>   $ echo $?
>   0
>   $ ls -l .git/objects/info/commit-graph
>   ls: cannot access '.git/objects/info/commit-graph': No such file or directory
> 
> Check that all input records are indeed valid commit object ids and
> return with error otherwise, the same way '--stdin-packs' handles
> invalid input; see e103f7276f (commit-graph: return with errors during
> write, 2019-06-12).

Consistency is good. We should definitely make these modes match.

> Note that it should only return with error when encountering an
> invalid commit object id coming from standard input.  However,
> '--reachable' uses the same code path to process object ids pointed to
> by all refs, and that includes tag object ids as well, which should
> still be skipped over.  Therefore add a new flag to 'enum
> commit_graph_write_flags' and a corresponding field to 'struct
> write_commit_graph_context', so we can differentiate between those two
> cases.

Thank you for the care here.

[snip]
> @@ -1215,20 +1216,21 @@ static void fill_oids_from_commit_hex(struct write_commit_graph_context *ctx,
>  		struct commit *result;
>  
>  		display_progress(ctx->progress, i + 1);
> -		if (commit_hex->items[i].string &&
> -		    parse_oid_hex(commit_hex->items[i].string, &oid, &end))
> -			continue;
> -
> -		result = lookup_commit_reference_gently(ctx->r, &oid, 1);
> -
> -		if (result) {
> +		if (!parse_oid_hex(commit_hex->items[i].string, &oid, &end) &&
> +		    (result = lookup_commit_reference_gently(ctx->r, &oid, 1))) {
>  			ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
>  			oidcpy(&ctx->oids.list[ctx->oids.nr], &(result->object.oid));
>  			ctx->oids.nr++;
> +		} else if (ctx->check_oids) {
> +			error(_("invalid commit object id: %s"),
> +			    commit_hex->items[i].string);
> +			return -1;
>  		}
>  	}
>  	stop_progress(&ctx->progress);
>  	strbuf_release(&progress_title);
> +
> +	return 0;
>  }

This is the critical bit. I notice that you are not checking commit_hex->items[i].string
for NULL, but it should never be NULL here anyway.

> @@ -1775,6 +1777,7 @@ int write_commit_graph(const char *obj_dir,
>  	ctx->append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0;
>  	ctx->report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0;
>  	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
> +	ctx->check_oids = flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
>  	ctx->split_opts = split_opts;

Using the enum for the function and the bitfield for internal logic matches the
existing pattern. Thanks.

> @@ -1829,8 +1832,10 @@ int write_commit_graph(const char *obj_dir,
>  			goto cleanup;
>  	}
>  
> -	if (commit_hex)
> -		fill_oids_from_commit_hex(ctx, commit_hex);
> +	if (commit_hex) {
> +		if ((res = fill_oids_from_commit_hex(ctx, commit_hex)))
> +			goto cleanup;
> +	}

And this links the low-level error to a return code.

Thanks for this! The changes here look good and justify the two cleanup
patches.

-Stolee
