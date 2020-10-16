Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A79C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 23:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A87212CC
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 23:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl+aMKPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411398AbgJPXZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 19:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410982AbgJPXZp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 19:25:45 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A282DC061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 16:26:00 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a3so5601131ejy.11
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 16:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yNtxsaN8IqRsJ+DiQvo+8hXUv6k2gReFiL21Oj8j+fY=;
        b=Wl+aMKPhZ0mg60Jwqgru2g/o0yDIqOE3dUPK97aH6kYyevzCvgkoKVBz2iWzmdcNkF
         uE1oG5SreFtMaI0sLSKyWfaaRXOJ9ybJhSfxojgNS2IQ3nldQoBB+u5xijf8bf/XtplW
         mwkgrxMdIrPoyXQibEAdUMn0ruX08ROiQv2MTAz9mCcHC7+qWHXITyKpZEj5Ees9ixXS
         xL3RijxTQTdqpNdXE7RAaDY8V3sno4b8CZqUttgRJpojhD2O5867TEWRswqL5NNbkA1c
         7mHLsSlEN8BzU0P4qpKBtvs1uiNzTqXpUai3c0WRIDDTe1+OrK4viQPwRfNoeyUIXNZh
         lDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yNtxsaN8IqRsJ+DiQvo+8hXUv6k2gReFiL21Oj8j+fY=;
        b=DAkj+pbfCL7lFm/+120l+ldZtd8ad5oEEMXXfS7qd798m7cX0rQdAkTp5j+7w6s2U6
         /ZIWLmz702n/ry6OmTXgsCNC5+Y8YcR0rE+CzJEQycoWxx/6omLjFXuGh2mfVFriVKjE
         lIfMYoFSpxZeVig2KG/L+fdh+pF+GG0C+z4EJT0JwUrch3cXoEGsHbebN5s3+/qgTGjT
         a//2NPKk4isfXVf8m6gDvNypD+kXrjlC6/IoB4af33ayqo6O0dJOwMZP3PcAhRbie3TD
         IU3noecT9BSBsjGIUlZHzwEIKdSJL1pwzwPh4amdyNr4ZozjDUXHzM73ZesBqAi0d2nT
         7cgw==
X-Gm-Message-State: AOAM531mWwGSQtdCOKAfAkEWxMWb7U0iv+1IBh5Playe9k/N6JAZ2yYO
        Qtb9oAf9pXN3mNbw8gN7goY=
X-Google-Smtp-Source: ABdhPJxdiG4JW7Y1PxKe4orPQpOsfJxWJRS2xUiLncMziRlflHiIABRn7FdIGAIdc4Vi7d/Q71LWEw==
X-Received: by 2002:a17:906:814:: with SMTP id e20mr6498125ejd.367.1602890759339;
        Fri, 16 Oct 2020 16:25:59 -0700 (PDT)
Received: from ?IPv6:2001:a61:2564:4101:c0b9:cdea:ccc4:8ee5? ([2001:a61:2564:4101:c0b9:cdea:ccc4:8ee5])
        by smtp.gmail.com with ESMTPSA id k23sm3098034ejs.100.2020.10.16.16.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 16:25:58 -0700 (PDT)
Subject: Re: [PATCH v5 1/3] test-lib: allow selecting tests by substring/glob
 with --run
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.878.v4.git.git.1602876532.gitgitgadget@gmail.com>
 <pull.878.v5.git.git.1602888652.gitgitgadget@gmail.com>
 <389c2c171a07b156fe956ac535033a8b67af51a9.1602888652.git.gitgitgadget@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <89279674-a1b5-930a-e682-b47aafeb11b7@gmail.com>
Date:   Sat, 17 Oct 2020 01:25:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <389c2c171a07b156fe956ac535033a8b67af51a9.1602888652.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-10-17 00:50, Elijah Newren via GitGitGadget wrote:

[trim]

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index ef31f40037..debfd73fd6 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -769,6 +769,8 @@ match_pattern_list () {
>  }
>  
>  match_test_selector_list () {
> +	operation="$1"
> +	shift
>  	title="$1"
>  	shift
>  	arg="$1"
> @@ -777,7 +779,7 @@ match_test_selector_list () {
>  
>  	# Both commas and whitespace are accepted as separators.

This comment becomes outdated with the change below.

>  	OLDIFS=$IFS
> -	IFS=' 	,'
> +	IFS=','
>  	set -- $1
>  	IFS=$OLDIFS
>  
> @@ -805,13 +807,13 @@ match_test_selector_list () {

