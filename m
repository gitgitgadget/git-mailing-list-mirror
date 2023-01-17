Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5360C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 20:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjAQU5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 15:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbjAQUoi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 15:44:38 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5210E4609F
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:24:38 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso7277725pjg.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6DRotc/zzV2NQlDUWEjG1q0xbId4UjS+hHsMHOXVtEY=;
        b=eM26cF04TBG8q4SmpH/THCyJVqWpNlKgA6RrLglpVy0pbbC26O8R1gzXfOYuIT6Myv
         t9OV9t+P3Of7NOq6dOsgWpfNuA9mhAoBocJMQthDsKO6jW90dxzlPL3U0E8HllfeLKQv
         R4Aw0azLEiphp/i0o5Lr1KCKwW/HNWdicBtWND4pR/eNaPHiUYVi1StmyZ5P33jLll1m
         Mff682txikvZ7FF4AprF7ROZwlTggHE711ZV3J4NTnRbTXYgaC7xFfEWz43ofuMVTHBC
         mclZwxUHI4/qbBIcj/vABVMrYXiqF4eBvBn1EGEBK+/njtgcQY5Lt4I2BojEzY1jWYUC
         t9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DRotc/zzV2NQlDUWEjG1q0xbId4UjS+hHsMHOXVtEY=;
        b=JickGKYjBvBfAiAVhytV99SRVuEgWoeOgyoHCLKrrTZGMAMZoQkIopvDPWajA+/zn4
         JoC6bU1InxrAL+KCPvK+SpmF8nlAapvebrTmPkSdzpuzLQel4MGmvV5IzjlpuYImeJ3i
         jHO0tCkNo4OdBhInHQzBuoXH3hxNQ38VZszL1blbDAXc+hxsES8z6PuS3cb6cQF2B6gZ
         8AFuZ+TYbTeLK+ppensQTqPeYqxMQ1uYbJsr5E7+mKSqMi+s2Tp3WgJob4wT/6w7kdk0
         yCZRYmkA16+WX6088J9WcZg/kecRBaYiPS1cmy/kQkO/0Fh1MJsMxN7JMy36sodV3xxt
         +xxw==
X-Gm-Message-State: AFqh2kq2EfDTci8JVkKvOyO0lHAoBX78mxmKF3sGpIAvzHOgb8EUX+1Z
        6EnZ+5gEtWYRDQVIxg22u3Rvn+8Y7whAofs=
X-Google-Smtp-Source: AMrXdXtDtRdlk2Z5g8CDj1Xp1bVxLtHJ21RzM2ECqdsjWZsveqmvLHkPRRRtlsa180fCn6LKLwC8pQ==
X-Received: by 2002:a17:90b:1211:b0:229:2964:53ad with SMTP id gl17-20020a17090b121100b00229296453admr17840509pjb.1.1673983474941;
        Tue, 17 Jan 2023 11:24:34 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id t23-20020a17090ae51700b00226d4009505sm18883736pjy.3.2023.01.17.11.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 11:24:34 -0800 (PST)
Message-ID: <d9ef2037-0365-dbe3-c5d6-04d7e96fc7c9@github.com>
Date:   Tue, 17 Jan 2023 11:24:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 3/8] bundle-uri: parse bundle.<id>.creationToken values
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <a1808f0b10cfb519613bc292e30b884962a83275.1673037405.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <a1808f0b10cfb519613bc292e30b884962a83275.1673037405.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The previous change taught Git to parse the bundle.heuristic value,
> especially when its value is "creationToken". Now, teach Git to parse
> the bundle.<id>.creationToken values on each bundle in a bundle list.
> 
> Before implementing any logic based on creationToken values for the
> creationToken heuristic, parse and print these values for testing
> purposes.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  bundle-uri.c                | 10 ++++++++++
>  bundle-uri.h                |  6 ++++++
>  t/t5750-bundle-uri-parse.sh | 18 ++++++++++++++++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/bundle-uri.c b/bundle-uri.c
> index 56c94595c2a..63e2cc21057 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -80,6 +80,9 @@ static int summarize_bundle(struct remote_bundle_info *info, void *data)
>  	FILE *fp = data;
>  	fprintf(fp, "[bundle \"%s\"]\n", info->id);
>  	fprintf(fp, "\turi = %s\n", info->uri);
> +
> +	if (info->creationToken)
> +		fprintf(fp, "\tcreationToken = %"PRIu64"\n", info->creationToken);
>  	return 0;
>  }
>  
> @@ -190,6 +193,13 @@ static int bundle_list_update(const char *key, const char *value,
>  		return 0;
>  	}
>  
> +	if (!strcmp(subkey, "creationtoken")) {
> +		if (sscanf(value, "%"PRIu64, &bundle->creationToken) != 1)
> +			warning(_("could not parse bundle list key %s with value '%s'"),
> +				"creationToken", value);
> +		return 0;
> +	}

Like the 'heuristic' key in the last patch, the parsing of 'creationToken'
is pretty straightforward.

> diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
> index 6fc92a9c0d4..81bdf58b944 100755
> --- a/t/t5750-bundle-uri-parse.sh
> +++ b/t/t5750-bundle-uri-parse.sh
> @@ -258,10 +258,13 @@ test_expect_success 'parse config format: creationToken heuristic' '
>  		heuristic = creationToken
>  	[bundle "one"]
>  		uri = http://example.com/bundle.bdl
> +		creationToken = 123456
>  	[bundle "two"]
>  		uri = https://example.com/bundle.bdl
> +		creationToken = 12345678901234567890
>  	[bundle "three"]
>  		uri = file:///usr/share/git/bundle.bdl
> +		creationToken = 1
>  	EOF
>  
>  	test-tool bundle-uri parse-config expect >actual 2>err &&
> @@ -269,4 +272,19 @@ test_expect_success 'parse config format: creationToken heuristic' '
>  	test_cmp_config_output expect actual
>  '
>  
> +test_expect_success 'parse config format edge cases: creationToken heuristic' '
> +	cat >expect <<-\EOF &&
> +	[bundle]
> +		version = 1
> +		mode = all
> +		heuristic = creationToken
> +	[bundle "one"]
> +		uri = http://example.com/bundle.bdl
> +		creationToken = bogus
> +	EOF
> +
> +	test-tool bundle-uri parse-config expect >actual 2>err &&
> +	grep "could not parse bundle list key creationToken with value '\''bogus'\''" err
> +'

And the tests cover both valid and invalid cases nicely.

> +
>  test_done

