Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B38C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F952087D
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRpEchu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgHNMhf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgHNMhe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 08:37:34 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3776DC061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:37:34 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b79so8124510qkg.9
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ckoLnhktbchiuchFrb236jg/WQw5qiFHgWoBuwRi2sE=;
        b=KRpEchu2ztq8X/Dqk1XBJncA29LNhHQIg76QDyezry8NQ81Zl88jyfaR5ybwPxZV4t
         spjPwM5PM3VpZfw/FTblw1kNKfPB69T86MtQ3Vl0/nkb0kyc8FeqYbIuABUd8mhSwACw
         Jh6Qgmv/+uSPtdnVgczdfJDgM9ht89TSHqs+5UdHBiK0jzkJ5ghrnMamH8E1rLs/e5cg
         VKbu+HY+vcQPcbb2YCxoPLfanLmifrpTa9vttWGj3wmSAFN1BhWvg4NivrVpc+Npnp95
         uCIU7K0YLwiHNKWBEqjymhxJ1/EUKuD4kLWT6FlQhf2M59jcfH5xQEd0ZkSZgzVy/YU7
         E1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ckoLnhktbchiuchFrb236jg/WQw5qiFHgWoBuwRi2sE=;
        b=I62zu2IZO+Mh1BX4UXPp3BvjHZoJ3oVec/Goiyyv7glN6bhmL8VbkXk0zILfyBZv8i
         MrmEhGCzUyJu8fHSz41e3kbvgZz9dhf3Fzd2fxhbl+MPZW8EuuAqS6c3R6krpPO/eu/P
         2EYLiOGKz5kj0LPh5kTVmiRQZOqEk/X84JLROS1fZ8KJvLNT8yBmJ9b4zYhUn2OO/w9H
         VVVa41tr6goOHr64iyAwsmXvQ7NIsnEPK7sywZAlMn8HMLRXFSaqW0yzYYT+vBfXbQzu
         fIm4g6tSFlhO1RHOclQQbEXRVX4H3vGUzi+Upgq2NIaNbOIHtyxULcLZhFRZ+M1p0DY/
         tIUA==
X-Gm-Message-State: AOAM533cHSM7OH8kJI49JCdJ6Jm2sfI2lg5axTu/Iw1rimH7CYi1vlkK
        PQs9NGJp/te9uJaCyF39FbY=
X-Google-Smtp-Source: ABdhPJwBJ6iEjLa3uIFzBkooEmIa48aYypATN/nHae8fLUZDK5FJrWBblpiARpcnpaF+omi41tq8UA==
X-Received: by 2002:a37:a292:: with SMTP id l140mr1659630qke.79.1597408653313;
        Fri, 14 Aug 2020 05:37:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:4116:add4:1500:aeb7? ([2600:1700:e72:80a0:4116:add4:1500:aeb7])
        by smtp.gmail.com with ESMTPSA id 205sm8408999qkj.19.2020.08.14.05.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 05:37:32 -0700 (PDT)
Subject: Re: [PATCH 5/5] commit-graph-format.txt: fix "Hash Version"
 description
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
 <cover.1597406877.git.martin.agren@gmail.com>
 <bbcd97db8a2c94343950bb0cf8cbd5c9c01b4577.1597406877.git.martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e216492c-d11a-6733-db64-720d027d3d42@gmail.com>
Date:   Fri, 14 Aug 2020 08:37:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <bbcd97db8a2c94343950bb0cf8cbd5c9c01b4577.1597406877.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/14/2020 8:21 AM, Martin Ågren wrote:
> We say that value 1 means "SHA-1", but in fact, it means "whatever
> the_hash_algo is", see commit c166599862 ("commit-graph: convert to
> using the_hash_algo", 2018-11-14).
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  If we want to be more fine-grained in the future, we'll need to say,
>  e.g., "2 means SHA-1, 3 means SHA-256" or, perhaps preferrably, bump the
>  version number.
> 
>  I wonder: Should we instead say "1 means SHA-1, 2 means SHA-256"? It
>  could be implemented as "easily" as "if (value_from_header !=
>  value_from_the_hash_algo) die(...);" for now. Might that pay off in the
>  long run?
> 
>  This relates to Stolee's "in a vacuum" comment [1] ... so maybe we're
>  fine.

I think that was the intention of the byte, but that is not what ended
up happening. If we want that to be the case, then we should do that
work as part of the 2.29 cycle before we release with the ability to
create SHA-256 repos (which will lock the commit-graph format for these
repos).

(By "we" I mean that I would try to do this work in a way that minimizes
conflicts with the current commit-graph work in flight [1] [2].)

[1] https://lore.kernel.org/git/pull.676.v2.git.1596941624.gitgitgadget@gmail.com/

[2] https://lore.kernel.org/git/cover.1597178914.git.me@ttaylorr.com/

>  [1] https://lore.kernel.org/git/da077fb0-14bb-b84f-c526-d759ebc9f5eb@gmail.com/
> 
>  Documentation/technical/commit-graph-format.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
> index 440541045d..3535426d32 100644
> --- a/Documentation/technical/commit-graph-format.txt
> +++ b/Documentation/technical/commit-graph-format.txt
> @@ -42,8 +42,8 @@ HEADER:
>    1-byte version number:
>        Currently, the only valid version is 1.
>  
> -  1-byte Hash Version (1 = SHA-1)
> -      We infer the hash length (H) from this value.
> +  1-byte Hash Version (1 = SHA-1 in SHA-1 repo, SHA-256 in SHA-256 repo)
> +      We infer the hash length (H) from the hash algo derived from this value.

If we are _not_ changing the format to have a meaningful value in
this byte, then this documentation should be updated to state that
this byte must always have value 1, as it does not provide any
information.

Thanks,
-Stolee
