Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DDAC54EBE
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 20:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240626AbjALU6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 15:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240887AbjALUz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 15:55:57 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0C3395C1
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 12:41:07 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id o17so13464380qvn.4
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 12:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jFO0S88z8x3KDPLPwCFSCTQXWBddCBb+1UEnBt7xqE0=;
        b=JtMSs3EeQQcn70sgT6O2wh6XCzCXYSt2nXLsXqkV6CGVq+xXpcgme/jgKFGDbWKt9k
         Hlb4HJ19qZIYaBwnZQAFOVJ1UysldI4g1j75D3Z/8OcWQ/Ptdr4tfVWTD/tab+PWMys8
         tK2vKPqI8dCiuiLeJ7r4opwPF+p3guVHU6D8oRy3KALgRQyYopqu5p9uQzZbc0lMoi8c
         74xXS7QF6s1JgToI1bQM2s+cgghI67xszTsxljuVxYbY2QsQpz3R6FdFgc1Z5EkeZWb0
         fENJA0K8XRoyvWSlY+SYuIYL8LW60GM0d+mGSPusuIQzwuysP8zoh7oOwNL0Gy26bQwh
         PBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFO0S88z8x3KDPLPwCFSCTQXWBddCBb+1UEnBt7xqE0=;
        b=w4ArlViPzdROddj+JCYv0k9cNqlJ3sqglg64+F9bk+2M497kzCWGP4V/sx5R6XIXFl
         1Y5tGGdUMQLuSys4f7XcFGywHQB3f0NTndWoN7UNNFmm8FU1QToWNdUd9ilhLxbI9agg
         cNFgYpLISDJ9mx/P9Ol4oaF7P2eE6EP6sJB+is6Uz46XBJD5MVEGzCcg/mzd1aobiojM
         Dddune4kMghF5iiSKAfa8EDp3CvBO3SpAbI0J4YLM3ndK7UAGC5NYM5G3upQsqUMwFv+
         DaY+ykog5u+1PRp9agaz64r5xaFDNaerwrY3cmdcnUyg9AqQNIiDSC1j2HFXNiyTfEdH
         G0ww==
X-Gm-Message-State: AFqh2kolybSLpUnwlBo50MrotldOtizyNeIJe2D66p0T8YdzYplZ6Pbe
        NvJU7m6ABTqPJBNadEdk+huldMHbv2PVpyc=
X-Google-Smtp-Source: AMrXdXuM8hguNzdHB4gm8wd5VLRv0i9EH440xPRQUQ1qK1vDCJQo7uB2GTpYkm/2Y3ZJbiWwwwiMqg==
X-Received: by 2002:a05:6214:3909:b0:532:d34:5aa3 with SMTP id nh9-20020a056214390900b005320d345aa3mr43594129qvb.34.1673556066757;
        Thu, 12 Jan 2023 12:41:06 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:58df:ae78:2cd7:f615? ([2600:1700:e72:80a0:58df:ae78:2cd7:f615])
        by smtp.gmail.com with ESMTPSA id j9-20020a05620a288900b006f9f714cb6asm11175973qkp.50.2023.01.12.12.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 12:41:06 -0800 (PST)
Message-ID: <98940e93-c4c5-01ec-54b2-b6015f488ad0@github.com>
Date:   Thu, 12 Jan 2023 15:41:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 10/10] credential: add WWW-Authenticate header to cred
 requests
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <af66d2d2ede2a502f32d74c86f302598c68d1476.1673475190.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <af66d2d2ede2a502f32d74c86f302598c68d1476.1673475190.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/11/2023 5:13 PM, Matthew John Cheetham via GitGitGadget wrote:

> +static void credential_write_strvec(FILE *fp, const char *key,
> +				    const struct strvec *vec)
> +{
> +	int i = 0;
> +	const char *full_key = xstrfmt("%s[]", key);
> +	for (; i < vec->nr; i++) {

style nit: use "int i;" and "for (i = 0; ..."

>  test_expect_success 'http auth anonymous no challenge' '
>  	test_when_finished "per_test_cleanup" &&
> -	start_http_server &&
> +
> +	cat >auth.config <<-EOF &&
> +	[auth]
> +	    allowAnonymous = true
> +	EOF
> +
> +	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&

I see that you added auth.allowAnonymous and --auth-config options
in Patch 6, so perhaps this test change could move to that patch.

Thanks,
-Stolee
