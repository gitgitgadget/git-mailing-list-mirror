Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A972FC433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 12:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9394C60ED4
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 12:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhJZM4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 08:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbhJZM4W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 08:56:22 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BEBC061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 05:53:58 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id d6so9421750qvb.3
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 05:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cHgXdjZ0ys49NHLD6QPCFj/myX2quthNz6wxoQDxHJY=;
        b=Z6AnDWGSKS/OOSEB0hk1MjlDgzLrXQ4OKHiG45MidxUL6Zsn0sgG2VXi/3aBjLih9v
         mgF9hHgHEcxsS8ssK+9LNTcE59e2XE+vvvjyDPOxWcTw1/MmqRpK6CU9fTkFOmDxBecr
         WK9nkmeYSdAcpIfrkeLMhZoKxLwZLBaaCl4363LfU2HxnQsM9/eVPNfJZyQLzHCy65yu
         ROsyOyAsQ1b1bsuzCkP2VoJhQfvvn2/IsxLYNxvzW/SGKxOPBgYnfL3xUEz/tYsANkgP
         x61Q/w6PTdISPg70sjVjf8bkvI0e3oRZrjCUDNVhSsBWexdEY+EVix7NhJvZ2/60HI31
         LO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cHgXdjZ0ys49NHLD6QPCFj/myX2quthNz6wxoQDxHJY=;
        b=296dAPoekb1zLBZ/72IAS/W2i0/5K5dNZhkZiBw1aABL9d6xfJnFsbOWxHUaC0j8og
         Iw6b47JcrvJUUfpliKoDAXDEyDPKw9y1rUdDfmvi+LMF+yfEqmJwnvD38ENEFj9Leyip
         5RAEmgNlm85awWkK/eG67DN+/4necltsYJ26Ndujo4wOxuSxLx4CfJtOOQOB4G+tx4wA
         YeN45tUNuzjYUEA+jf56lsiO53XudumiObx1kemnVMntG3bxp/aqGzwGtjYKhVZRsL2X
         s2MNIgx/ipbID3bxu5M/LYdq9ZZKogebtCbdLqDZlZ3QmPPgvzRu+MvDaaf9muuMZGK2
         iUYQ==
X-Gm-Message-State: AOAM533GVG0LCxrcH/9ozPCN/Vowh5oxyl4vGrIeLJgtzheW0W4Qnc0k
        OcpCS6weab99KIDCWP7li0c=
X-Google-Smtp-Source: ABdhPJwAy5MT2eD185Bqh+qKY7O1rfV/0BQfCKy54uFbqpQ1RTsB5n1Glw643aQXmj7cfWYiHtNrEA==
X-Received: by 2002:a0c:8e8e:: with SMTP id x14mr21834480qvb.67.1635252837696;
        Tue, 26 Oct 2021 05:53:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:86f:cede:45bc:10f6? ([2600:1700:e72:80a0:86f:cede:45bc:10f6])
        by smtp.gmail.com with ESMTPSA id m28sm10232407qkm.23.2021.10.26.05.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 05:53:57 -0700 (PDT)
Message-ID: <47aec8ed-5e54-6d13-8154-0202ef0fd747@gmail.com>
Date:   Tue, 26 Oct 2021 08:53:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] add, rm, mv: fix bug that prevents the update of
 non-sparse dirs
Content-Language: en-US
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, vdye@github.com,
        derrickstolee@github.com,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Sean Christopherson <seanjc@google.com>
References: <5e99c039db0b9644fb21f2ea72a464c67a74ff64.1635191000.git.matheus.bernardino@usp.br>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <5e99c039db0b9644fb21f2ea72a464c67a74ff64.1635191000.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/25/2021 5:07 PM, Matheus Tavares wrote:
> Changes since RFC/v1 [1]:
> 
> - Inverted the loop direction to start from the full path and go backwards in
>   the parent dirs. This way we can stop early when we find the first
>   non-UNDECIDED match result.

This loop direction change is a good idea.
 
> - Simplified the implementation by unifing the code path for cone mode and
>   full pattern mode. Since path_matches_pattern_list() never returns UNDECIDED
>   for cone mode, it will always execute only one iteration of the loop and then
>   find the final answer. There is no need to handle this case in a separate
>   block.

This was unexpected, but makes sense. While your commit message hints at the
fact that cone mode never returns UNDECIDED, it doesn't explicitly mention
that cone mode will exit the loop after a single iteration. It might be nice
to make that explicit either in the commit message or the block comment before
the loop.

> - Inside the loop, made sure to change dtype to DT_DIR when going to parent
>   directories. Without this, the pattern match would fail if we had a path
>   like "a/b/c" and the pattern "b/" (with trailing slash).

Very good. We typically need to detect the type for the first path given,
but we know that all parents are directories. I've used this trick elsewhere.

I see in the code that the first path is used as DT_REG. It's my fault, but
perhaps it should be made more clear that path_in_sparse_checkout() will
consider the given path as a file, not a directory. The current users of the
method are using it properly, but I'm suddenly worried about another caller
misinterpreting the generality of the problem.

Would a comment be sufficient? Or should we rename it to something like
file_path_patches_pattern_list()? (A rename can be done separately.)

> - Changed the tests to use trailing slash to make sure they cover the corner
>   case described above.

Good.

> - Improved commit message.
> 
> [1]: https://lore.kernel.org/git/80b5ba61861193daf7132aa64b65fc7dde90dacb.1634866698.git.matheus.bernardino@usp.br
> (The RFC was deep down another thread, so I separated v2 to help
> readers. Please, let me know if that is not a good approach and I will
> avoid it in the future.)

I appreciate that you split this out into its own thread!

> @@ -1504,8 +1504,9 @@ static int path_in_sparse_checkout_1(const char *path,
>  				     struct index_state *istate,
>  				     int require_cone_mode)
>  {
> -	const char *base;
>  	int dtype = DT_REG;

Here is where we assume a file to start.

> +	enum pattern_match_result match = UNDECIDED;
> +	const char *end, *slash;
>  
>  	/*
>  	 * We default to accepting a path if there are no patterns or
> @@ -1516,11 +1517,23 @@ static int path_in_sparse_checkout_1(const char *path,
>  	     !istate->sparse_checkout_patterns->use_cone_patterns))
>  		return 1;
>  
> -	base = strrchr(path, '/');
> -	return path_matches_pattern_list(path, strlen(path), base ? base + 1 : path,
> -					 &dtype,
> -					 istate->sparse_checkout_patterns,
> -					 istate) > 0;
> +	/*
> +	 * If UNDECIDED, use the match from the parent dir (recursively),
> +	 * or fall back to NOT_MATCHED at the topmost level.
> +	 */
> +	for (end = path + strlen(path); end > path && match == UNDECIDED; end = slash) {

nit: since this line is long and the sentinel is complicated, it might
be worth splitting the different parts into their own lines:

	for (end = path + strlen(path);
	     end > path && match == UNDECIDED;
	     end = slash) {

> +
> +		for (slash = end - 1; slash >= path && *slash != '/'; slash--)
> +			; /* do nothing */
> +
> +		match = path_matches_pattern_list(path, end - path,
> +				slash >= path ? slash + 1 : path, &dtype,
> +				istate->sparse_checkout_patterns, istate);
> +
> +		/* We are going to match the parent dir now */
> +		dtype = DT_DIR;
> +	}
> +	return match > 0;
>  }

This implementation looks good.

And I appreciate the robust tests you added.

Thanks,
-Stolee
