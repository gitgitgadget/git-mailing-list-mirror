Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB4CC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 20:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F8E61175
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 20:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhKRUMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 15:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhKRUMC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 15:12:02 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC36C061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 12:09:01 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id n12so31905050lfe.1
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 12:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nNzad4xfQnVKzNB89qOQcqPp8Uu9WLyro+tEC68vZtQ=;
        b=glzOy29XZEF8y5hVevPPAvXx2xc03Eu5tQnMB+KvYSgQED7bhx5YkgTN1WK3HZnd/f
         1DhwxldejsxDghVcxt6b5rVADKwi3LHhC+KXyhxcYNSNp5gC4R/lSEdHOFTRKchMLDRh
         ggBjs/hNjWo4G6caiDtuKHvzI7kh1AB5Ap3gW9duqQ+5Ld69h+uoaFJKqJ2SxclxFKuk
         QA6Ym6/SW74HbeuyTOLsjPQLPU2SW/gxl/UuV6lIngLGEeOlAapbeV37KOU+e2oJ/RVw
         MMbcZJZM18Oc86IEFfFY8/EtTkk+2jtLOaMCGPJPLwtMHkzhRkEtZMlqm5EG6xd0e6Vf
         yKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNzad4xfQnVKzNB89qOQcqPp8Uu9WLyro+tEC68vZtQ=;
        b=49GumPw+/cbne1m0M4qQYicR8AFHWyjTJwHulXS4pE7fFleyrBeUURab1vHN8aCQnW
         oOY8JUZD1qEEU6Jomc06geGMs8mksSgUWHLqZLxV1XDA5UJSFzCMw5v668BbikIEW9v4
         ixauo7CJayCjbYPXRK2pYAEYz96sC1etquIG+yiP8PswGTKlASHmPDTGJzAFCqYxuDQD
         Rtr9Vz94tUYfgsYHc5HvDCmcp++gd6krjeh1YKN/M1WPe3O95iDue5R6HXkHfkXCI2ow
         33OLOHeKc3WHKh2S9vTQmM6eIzETKtsb2p2tFl2cor1IncfiVVGQANCU8yOXgqWCwP5I
         QDIw==
X-Gm-Message-State: AOAM532tNsCcRE9ZXvOrulMYDfq7r5FFm8xnwPzQaKhZEyf/Qhh4TvMC
        4YlaLXHLB9SMefS8N55Z+6hGmfZEb59WLXSnwm8=
X-Google-Smtp-Source: ABdhPJzY2OputAJqqIfXJmGGQkFlo40FN1Pz9jNmXHh/i7MzN0DoV7xSKUup+fqGTNsSx94qkHC+86UhAukx+oCc9ZM=
X-Received: by 2002:a05:6512:2295:: with SMTP id f21mr27870848lfu.259.1637266140079;
 Thu, 18 Nov 2021 12:09:00 -0800 (PST)
MIME-Version: 1.0
References: <20211118164940.8818-1-jack@suse.cz> <20211118164940.8818-2-jack@suse.cz>
In-Reply-To: <20211118164940.8818-2-jack@suse.cz>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 18 Nov 2021 12:08:48 -0800
Message-ID: <CAPx1GvdKuBmxN0XM3PKJO+0V=P3OoyB4VDzmqshv7N+3vFF8gw@mail.gmail.com>
Subject: Re: [PATCH 01/27] bisect: Fixup test rev-list-bisect/02
To:     Jan Kara <jack@suse.cz>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 10:38 AM Jan Kara <jack@suse.cz> wrote:
> diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
> index b95a0212adff..48db52447fd3 100755
> --- a/t/t6002-rev-list-bisect.sh
> +++ b/t/t6002-rev-list-bisect.sh
> @@ -247,8 +247,9 @@ test_expect_success 'set up fake --bisect refs' '
>  test_expect_success 'rev-list --bisect can default to good/bad refs' '
>         # the only thing between c3 and c1 is c2
>         git rev-parse c2 >expect &&
> -       git rev-list --bisect >actual &&
> -       test_cmp expect actual
> +       git rev-parse b2 >>expect &&
> +       actual=$(git rev-list --bisect) &&
> +       grep &>/dev/null $actual expect

`&>` is a bashism; you need `>/dev/null 2>&1` here for general portability.

Chris

ref: https://unix.stackexchange.com/questions/581507/redirecting-stdout-and-stderr-together-vs-redirecting-stdout-and-then-stderr-to/
