Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A998DC433E3
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 10:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3AB61976
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 10:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhC1KcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 06:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhC1Kbh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 06:31:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DCAC061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 03:31:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id e14so14949221ejz.11
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 03:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/4BswdG/c2e090IcQHJ2ULQ/1qVEPOMLjjzUp+qoqpo=;
        b=aAKicoJRPW2EUE2M7ws+Bc3UgL1q+i/ICub9nfqbLLaulPGsPRdXZ0wNqUpiuL23Bx
         8VOqNjNE0Z7SWt4G2VPQnxuwi0PlX7AHbn5rG/8DE78iNOaGZZ87FBtWkcnd3BDoCKmw
         sjVhP4n9BsY8js33h04aGpjqJFGz5CxPJSrUufXvOPQeEkC1WmQHtzCwg0OgIPxC7eCK
         cR5RwcIwie7qgPQhwXhDghb7XghM9QoLG4En7Hva5bOjtW7ZuQdCRdxSI3VhXjq0w02B
         KzNoFl1RYq36aknXJMJy+eBkBF5JY8IUgv+c59X94cYm1BidPO7hhxZ5PVBrUZQF4Q9U
         ZEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/4BswdG/c2e090IcQHJ2ULQ/1qVEPOMLjjzUp+qoqpo=;
        b=QrPlPKtHH4XTXl7DNjTg8sJ9S0blWAOJgcri+jMxN9jffd9V1bzXvAE32vd+s606IP
         odZP9+4CyBktRUNh1grZad9Epne/3kbB8Yzkfq2qhgxE2C8OfTtB9rx9bNuCClI5jtC7
         gyN62KvRX2LM2QEd6WqsoA83JR/9+8lq+yCDGoLgF1kJ0WAi5j4PF4CTftX/ZK659xGh
         4frUOf9+MLkbl0ut0Uv1c7dSji8VCdBVViyf088rwpbSBZ+358kzA7QiNB1MweaDjhVH
         HwnWSvdIqsjsxkqS+b7NobMdxYr6mnEMnubG2T6PcDkhcAyCnxQWF2oh0D41rwys+sl8
         naiQ==
X-Gm-Message-State: AOAM532HPFYpldMUJi7sMQKznGhUXFtFDvFeeKkD+2mQt0CuR4zF5JMm
        IOLyamq32/8PBmyJBgxvdCY=
X-Google-Smtp-Source: ABdhPJz0gr/VZVayM4kUMUa/s+EuAbEKshh0zMKApDWBn2sxo3CjrOghpmPReKLLIcK3Aw1TsexXGw==
X-Received: by 2002:a17:906:e84:: with SMTP id p4mr23626450ejf.248.1616927496300;
        Sun, 28 Mar 2021 03:31:36 -0700 (PDT)
Received: from szeder.dev (84-236-109-92.pool.digikabel.hu. [84.236.109.92])
        by smtp.gmail.com with ESMTPSA id gj26sm6350754ejb.67.2021.03.28.03.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 03:31:36 -0700 (PDT)
Date:   Sun, 28 Mar 2021 12:31:34 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] git-completion.bash: pass $__git_subcommand_idx
 from __git_main()
Message-ID: <20210328103134.GF2271@szeder.dev>
References: <cover.1615855962.git.liu.denton@gmail.com>
 <cover.1616574955.git.liu.denton@gmail.com>
 <e4aa3e8cd7f64512ce0d72906f4d15f1f0dc0a60.1616574955.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4aa3e8cd7f64512ce0d72906f4d15f1f0dc0a60.1616574955.git.liu.denton@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 24, 2021 at 01:36:27AM -0700, Denton Liu wrote:
> @@ -3412,7 +3411,7 @@ __git_main ()
>  			__git_C_args[C_args_count++]="${words[c]}"
>  			;;
>  		-*) ;;
> -		*) command="$i"; break ;;
> +		*) command="$i"; __git_subcommand_idx="$c"; break ;;

Please put each of these statements on separate lines.

>  		esac
>  		((c++))
>  	done
> -- 
> 2.31.0.rc2.261.g7f71774620
> 
