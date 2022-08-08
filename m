Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3BFC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 23:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244422AbiHHXlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 19:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiHHXlv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 19:41:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3756A1AF3D
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 16:41:51 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 17so559063pli.0
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 16:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=obH24Je0Px+ADrndFFwVcBYrmjyu8ZkbbbZchXBmIac=;
        b=evSttwzZt3Yg5HxkvPiqb2bhEyzqqT1fwxxEL6JXL+OwOIA/BJU4SklUCwA3FBdQt7
         oQXuYtmn7NMctMwq/0RB8cJ3pA5u2suebSGvXPBF3eAJAdFswsGsFqzbNe2ZIzGZqCE9
         LQ5WJdbe6hyOwykmnY4qhvYGIAfqxr32EB0z/iSERAzJaiWITegV/TT4Nh8gFukJwtEK
         1CHH9xRu+B96ZmfNY1IQD54k3UbuRSljWKyNIqFhVNfw0dkLxktdLqw4VekIvkZrWUPG
         TLQUGY1ftrj8L6wzUkm2jNzyPJP9QIEDexSy1a6lsplhoMr4tGe1+E9/j8+afyWSTQpI
         4w/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=obH24Je0Px+ADrndFFwVcBYrmjyu8ZkbbbZchXBmIac=;
        b=0//Ptxs2iVguO7Xoe3FrFClFZlykGO8rcDiOca+cjW58xHLcaMwW54OZ0+j6I+Gmxc
         fqdqLpwnpxp4YVkRq4RUb/ItmkCoZU9RB3swrrtmGWdOQchP879xzlR9gJucxQILsJzI
         BOmplbEqG2G77MebirskGssAmhmEOgU/kjyWRtc806R5VjmiiC1iwCduVENAgUWmsvDs
         rUMSNeH9BUISDsq1HSPp6KJwakmTIx0LFGtBRWOwgsNU454yH4tOiJAhCjanbK3WPaKD
         /PgZl2DThrWIltZPhx5GV1HtThTX2WCuwIguq3CUY4xVdRa/AtMq1+eknahBuCKDQ6Px
         yaBA==
X-Gm-Message-State: ACgBeo1W1Uef7vhmTTn5Wufx721PR6g90i6CkcAX8UX2qKqy8v+KYgeI
        2Xyuo0muGqOV7ynwzpDA4lFO+H7pW5Hk
X-Google-Smtp-Source: AA6agR6CcH7zcgBHnXVaxdCbZSw3YCrZN8Rkt7e6eSBCnQMFG9z9wDuQ7bTcWemMFc3dXjTHg/+EKQ==
X-Received: by 2002:a17:903:1245:b0:16d:c6fb:2de9 with SMTP id u5-20020a170903124500b0016dc6fb2de9mr20995872plh.116.1660002110761;
        Mon, 08 Aug 2022 16:41:50 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id z22-20020aa79496000000b0052df34124b4sm9193244pfk.84.2022.08.08.16.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 16:41:50 -0700 (PDT)
Message-ID: <69039db2-e7b2-f006-63da-e699d302c8ce@github.com>
Date:   Mon, 8 Aug 2022 16:41:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2 3/9] mv: free the *with_slash in check_dir_in_index()
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-4-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220805030528.1535376-4-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> *with_slash may be a malloc'd pointer, and when it is, free it.

Super-nit: technically, `with_slash` (no `*`) is how you'd refer to the
pointer. `*` is the dereference operator [1], so `*with_slash` has type
`const char` and refers to the first character in the `with_slash` string.

[1] https://en.wikipedia.org/wiki/Dereference_operator

> 
> Helped-by: Derrick Stolee <derrickstolee@github.com>
> Helped-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  builtin/mv.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 7c11b8f995..0a999640c9 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -133,6 +133,7 @@ static int index_range_of_same_dir(const char *src, int length,
>   */
>  static int empty_dir_has_sparse_contents(const char *name)
>  {
> +	int ret = 0;
>  	const char *with_slash = add_slash(name);
>  	int length = strlen(with_slash);
>  
> @@ -142,14 +143,18 @@ static int empty_dir_has_sparse_contents(const char *name)
>  	if (pos < 0) {
>  		pos = -pos - 1;
>  		if (pos >= the_index.cache_nr)
> -			return 0;
> +			goto free_return;
>  		ce = active_cache[pos];
>  		if (strncmp(with_slash, ce->name, length))
> -			return 0;
> +			goto free_return;
>  		if (ce_skip_worktree(ce))
> -			return 1;
> +			ret = 1;
>  	}
> -	return 0;
> +
> +free_return:
> +	if (with_slash != name)
> +		free((char *)with_slash);
> +	return ret;
>  }
>  
>  int cmd_mv(int argc, const char **argv, const char *prefix)

The rest of this looks good, nice catch on the potential memory leak.
