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
	by dcvr.yhbt.net (Postfix) with ESMTP id 925631F463
	for <e@80x24.org>; Sun, 22 Sep 2019 19:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404765AbfIVTNY (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Sep 2019 15:13:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42209 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389810AbfIVS5l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Sep 2019 14:57:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so11567814wrw.9
        for <git@vger.kernel.org>; Sun, 22 Sep 2019 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P+2gI1S0zm7ZT2b6cKvjECJ4oZb/96Ks34FQVVQ3R8s=;
        b=usr2eb3oJ70LjLK2SAhkmMXaIUdwJ7svk7R6nbuq/jovKWDNhyKxAaUNexmna1OU1x
         qiNjr6f5i/vbJKPKXVsJc1YOaKMlPMs29xgXFytjHOH43Y4vxrtdumkyBx78Vr0e8qGH
         wrva0ji0sPMoHTX1Ter3KxzfhoCdkq386qKcpCROoUQf+3F1r2vvTO5UCMCH/FuiiMKC
         IRItIFaCaS9c1AC1T9bvv0p94nc3/SfxsvgcwFViMVhHch85HvgYOvj/qfWsTS+3nLfq
         uHbAGd20deD6vGCW6m/cybF1oWqnG21sXYU5tFGuVhuqftjkfu+8ObT+pXpi8WJHupIH
         JT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=P+2gI1S0zm7ZT2b6cKvjECJ4oZb/96Ks34FQVVQ3R8s=;
        b=KxuoUPMyFWuOPQYiqkRchtdzQDEFa6zey+KZtQ7elQp+SbMj9eCyNeXNiPjTQQlgjE
         jbgJC6Gl/Dxnxwbox7x3RlUknZmw76vWtA0nW9zM18iRkYdzptwG5CXewkxTJW5VLUBg
         ziRzCPu4/VtiC4iT19BOEEcvNyLWVsEF8nlqR8zfe0apE0OwLXE4NhlmePB97FCoz8bA
         B2s1yun+Ju1mOCLPJvPn1QSFGG++wgb9RfYXVPeQED1uKUdI48JfvN4lHHc8fZ6+pJAi
         dQvUXACK+Ckwa+U4MqcIMBFDvaGWw7Jdn8JMyMCPPiK/6W0HDYuafqUvKV7l2FbyJIRe
         98NQ==
X-Gm-Message-State: APjAAAU6V2K95TWP8wo3wtUL6hTTytkUwAsp8gNYU89fKBAxv3L/SsDJ
        yUn0HoKhWS+Qq0y/EBtgQL4no+eU
X-Google-Smtp-Source: APXvYqzqqoRW5aey/ckrA6vm/Szlusm+oNY9f+Wx94OHt+kovyZFncaEvgTe3hKBVrpo81yF6JpkMQ==
X-Received: by 2002:a5d:6885:: with SMTP id h5mr19493126wru.92.1569178658090;
        Sun, 22 Sep 2019 11:57:38 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-10-31.as13285.net. [92.22.10.31])
        by smtp.gmail.com with ESMTPSA id f10sm4684356wml.4.2019.09.22.11.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2019 11:57:37 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] name-rev: avoid cutoff timestamp underflow
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20190922180143.25026-1-szeder.dev@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <5692e751-ae5b-e1c8-e5f7-79f0b43e20c0@gmail.com>
Date:   Sun, 22 Sep 2019 19:57:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190922180143.25026-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Gábor

On 22/09/2019 19:01, SZEDER Gábor wrote:
> When 'git name-rev' is invoked with commit-ish parameters, it tries to
> save some work, and doesn't visit commits older than the committer
> date of the oldest given commit minus a one day worth of slop.  Since
> our 'timestamp_t' is an unsigned type, this leads to a timestamp
> underflow when the committer date of the oldest given commit is within
> a day of the UNIX epoch.  As a result the cutoff timestamp ends up
> far-far in the future, and 'git name-rev' doesn't visit any commits,
> and names each given commit as 'undefined'.
> 
> Check whether substacting the slop from the oldest committer date
> would lead to an underflow, and use a 0 as cutoff in that case.  This
> way it will handle commits shortly after the epoch even if we were to
> switch to a signed 'timestamp_t' (but then we'll have to worry about
> signed underflow for very old commits).
> 
> Note that the type of the cutoff timestamp variable used to be signed
> before 5589e87fd8 (name-rev: change a "long" variable to timestamp_t,
> 2017-05-20).  The behavior was still the same even back then, but the
> underflow didn't happen when substracting the slop from the oldest
> committer date, but when comparing the signed cutoff timestamp with
> unsigned committer dates in name_rev().  IOW, this underflow bug is as
> old as 'git name-rev' itself.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
> 
> This patch adds a test at the end of 't6120-describe.sh', so it will
> conflict with my non-recursive name-rev patch series, which adds a
> test there as well, but the conflict should be wasy to resolve.
> 
>    https://public-inbox.org/git/20190919214712.7348-7-szeder.dev@gmail.com/
> 
>   builtin/name-rev.c  | 15 ++++++++++++---
>   t/t6120-describe.sh | 15 +++++++++++++++
>   2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index c785fe16ba..a4d8d312ab 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -9,7 +9,11 @@
>   #include "sha1-lookup.h"
>   #include "commit-slab.h"
>   
> -#define CUTOFF_DATE_SLOP 86400 /* one day */
> +/*
> + * One day.  See the 'name a rev close to epoch' test in t6120 when
> + * changing this value
> + */
> +#define CUTOFF_DATE_SLOP 86400
>   
>   typedef struct rev_name {
>   	const char *tip_name;
> @@ -481,8 +485,13 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
>   		add_object_array(object, *argv, &revs);
>   	}
>   
> -	if (cutoff)
> -		cutoff = cutoff - CUTOFF_DATE_SLOP;
> +	if (cutoff) {
> +		/* check for undeflow */
> +		if (cutoff - CUTOFF_DATE_SLOP < cutoff)

Nice catch but wouldn't this be clearer as
   if (cutoff > CUTOFF_DATE_SLOP) ?

Best Wishes

Phillip
> +			cutoff = cutoff - CUTOFF_DATE_SLOP;
> +		else
> +			cutoff = 0;
> +	}
>   	for_each_ref(name_ref, &data);
>   
>   	if (transform_stdin) {
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 2b883d8174..965e633c32 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -424,4 +424,19 @@ test_expect_success 'describe complains about missing object' '
>   	test_must_fail git describe $ZERO_OID
>   '
>   
> +test_expect_success 'name-rev a rev shortly after epoch' '
> +	test_when_finished "git checkout master" &&
> +
> +	git checkout --orphan no-timestamp-underflow &&
> +	# Any date closer to epoch than the CUTOFF_DATE_SLOP constant
> +	# in builtin/name-rev.c.
> +	GIT_COMMITTER_DATE="@1234 +0000" \
> +	git commit -m "committer date shortly after epoch" &&
> +	near_commit_oid=$(git rev-parse HEAD) &&
> +
> +	echo "$near_commit_oid no-timestamp-underflow" >expect &&
> +	git name-rev $near_commit_oid >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_done
> 
