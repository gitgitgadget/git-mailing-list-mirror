Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17900C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 22:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EADFC20776
	for <git@archiver.kernel.org>; Mon, 25 May 2020 22:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgrIg73p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbgEYWBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 18:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbgEYWBB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 18:01:01 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA61C061A0E
        for <git@vger.kernel.org>; Mon, 25 May 2020 15:01:01 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x13so9231888pfn.11
        for <git@vger.kernel.org>; Mon, 25 May 2020 15:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jJ6xJim91JX0vQbwSy24KGMZozfFBSNxlddX2vLLfkk=;
        b=UgrIg73pnOm0dIT8BovXAGlYJ0G7Cn1XMY7UfmTJc9FAqHxMTmm4KyO7NFu5StZzEV
         PU+Z/JqKLDboQax1cgyZH5AI3P+32DPtearmOdce4Ubl8/WyXsGHBwlODFpE+tzmHJ75
         yTFNmRAcmcELdhdPYk9BtIstUJHbyeA8hL3Zg+WmRxFtMmJQGyNWWt9U081V376y9x5b
         n1XGlsU3GEXEcKlosPnPGJrKbeGcGoGtYnEmqWW0+bk86fTF61lz0yaN9pv5NtH0W/d/
         chqKVR/hf5ZjaFXYORIuz3ZsDA7b8HhbtXM2faqZRmac0IYWp6dSl8h6Tuh6cJiK51lJ
         wgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jJ6xJim91JX0vQbwSy24KGMZozfFBSNxlddX2vLLfkk=;
        b=T0xResSIwRq2goP4FfYU9qp8vG43vu1WeI3ND7UbrppLkaR4F87knt6k62SN1SsA7m
         hqtv9WLU4pa6Yu0VU6w7m6NauuX/FdnfrskkUz6Tl8eyxetsebCIwygUfF3P8WphclxA
         LAQ3yJTJ+DZTQpMM6hYYuspc0PxosKnPUrfESukO6wy5Z8rMBTkNzFBC1UO7Kx/zs7va
         5WFHyvRZDOq4Ft6SCMdEAK2jc2iFMk4Bxj7idQmypIpYZ3Y+ePAb6k5VfH0WOK+4GWXi
         z6QPzl2nMiyPcmb9s+l6ZEQcJTI9lAQNfYui1APSD/I+bgO0O4MIMwAG5zp/F2uFRDdW
         tIEw==
X-Gm-Message-State: AOAM533YeBQdFzBIPZzauh5LBBfAr4jk1FGpI7N7QdJ2S8YKgjs7Inbz
        WB2ZPv1B2HtG4hMYB6NOIiExIstc
X-Google-Smtp-Source: ABdhPJxmzttNvahsPTeNnYoQII62nfXcrUvQUZqZg0HJSCKpuBihoTnSfVuQ82Gb5TfFoBIJnhD6wA==
X-Received: by 2002:a63:fc1b:: with SMTP id j27mr29682107pgi.251.1590444060110;
        Mon, 25 May 2020 15:01:00 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id d15sm17188475pjc.0.2020.05.25.15.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 15:00:59 -0700 (PDT)
Date:   Mon, 25 May 2020 15:00:57 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com
Subject: Re: [PATCH] reftable: technical documentation link fixes
Message-ID: <20200525220057.GA69013@Carlos-MBP>
References: <20200525210232.87550-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525210232.87550-1-carenas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Forgot to mention, the third URL wasn't updated since it was somehow not
affected, while the first one wasn't affected when using Asciidoctor 2.0.10.

The middle one always breaks (even with Asciidoctor) because of the "="
character, so the "minimal" change needed will be to URL encode that as %3D
or use "link" as proposed in the patch.

Carlo
