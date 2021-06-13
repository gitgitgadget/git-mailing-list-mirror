Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6BCC48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 02:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E804A61105
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 02:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhFMCYx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 22:24:53 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:39619 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFMCYw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 22:24:52 -0400
Received: by mail-pf1-f174.google.com with SMTP id k15so7760590pfp.6
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 19:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mX6IzoWbqPxsZ7P/qjh7F5tFoBvVzUipIzVt8QBvdH4=;
        b=Bjx+GP2CLfyNNm06/2dVjSAbXb9s1WJ1/g/4xh5G7Hpqxq8rTpG/da3popG4wLE2q+
         DANlCQ1j8CG+s9Vjn2+h8Ac/kRN/tbxgjpYtdGb5i7NGOIRjYYGF0hYrr7RC+F1CoYE2
         irfa+Lh0tBjgFu5OkVElxCWzAb6hBEYwXRntzVhSy9HDRkKlT/doppwCnao7fW/C/vs9
         aoF7PHJwMrVkl+4D39YHKnDEJq36/8AY13tZY/0hvIUaMevxehT4kNECyvswuFO+S/2y
         49AmPotbVdtyZig4c3t2D7hIMS82XcKbxgeYoDZdy/0V/kFWTx/+ROwqycOu+/+6Um9U
         vKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mX6IzoWbqPxsZ7P/qjh7F5tFoBvVzUipIzVt8QBvdH4=;
        b=bnxFScSU/L6TBycDY9OKFDAVXacRf+a/VRFKXNzmG7TOvFAY45Bg6vvUs6E4zHiIfC
         WsU3df0dqJ1eJ/jnhA75/yusE1N7yNXZuiKlVdwHtk0ZL2ShSCpnY19BnrJ7a6MSJkNg
         iIqDia2pMTkEZ2EY3c2/DepUI2xW9Wb9CZkGXpZqjc4zK82x8zfqANH/hl1Dp4bn5W7Y
         DEyVHEA29dv/AhWAS7ZssTq+vJnpDnbUsSlqQZweVhsOftuBfJd+pY/7/yeNi0XR5fUk
         E0Iofhwgi6aSOqYiYDQhi/gGX0GJ7QU/ud9y/TWpr8Y2NRYPzzYZI2+jhFcgPUPNK0ZZ
         xL3Q==
X-Gm-Message-State: AOAM533Ymz8gGx8ykVI1nBhCMyUdb+IIfqMszDV8x/rurpTcpgvQS7pj
        u3CN1+sUVKjxX6EtDtjwetJuNJ3w9n3bTA==
X-Google-Smtp-Source: ABdhPJxgG2thm0tX2PWE73ZlZPzHs9jmp+3L6UwekoSqSH88JE6EHeqrWa0qaDuZ0Z01PX8P++zQ3A==
X-Received: by 2002:a65:47ca:: with SMTP id f10mr2894266pgs.94.1623550896812;
        Sat, 12 Jun 2021 19:21:36 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-75.three.co.id. [180.214.232.75])
        by smtp.gmail.com with ESMTPSA id p11sm8459031pjo.19.2021.06.12.19.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jun 2021 19:21:36 -0700 (PDT)
Subject: Re: [PATCH resend] graph: improve grammar of "invalid color" error
 message
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
References: <20210612184144.6894-1-alexhenrie24@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <21c43663-9d2a-0173-bd5c-4e2c9f95bc05@gmail.com>
Date:   Sun, 13 Jun 2021 09:21:33 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210612184144.6894-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 13/06/21 01.41, Alex Henrie wrote:
> Without the "d", it sounds like a command, not an error, and is liable
> to be translated incorrectly.
> 

s/liable/prone/

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
> Resending to make sure that this patch isn't forgotten.
> ---
>   graph.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/graph.c b/graph.c
> index c128ad0cce..e3828eb8f2 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -95,7 +95,7 @@ static void parse_graph_colors_config(struct strvec *colors, const char *string)
>   		if (!color_parse_mem(start, comma - start, color))
>   			strvec_push(colors, color);
>   		else
> -			warning(_("ignore invalid color '%.*s' in log.graphColors"),
> +			warning(_("ignored invalid color '%.*s' in log.graphColors"),
>   				(int)(comma - start), start);
>   		start = comma + 1;
>   	}
> 

Why did you resend the patch?

-- 
An old man doll... just what I always wanted! - Clara
