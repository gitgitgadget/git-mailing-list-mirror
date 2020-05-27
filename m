Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B8CC433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 02:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA69207CB
	for <git@archiver.kernel.org>; Wed, 27 May 2020 02:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I43pA2f6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgE0CVq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 22:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgE0CVp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 22:21:45 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BEFC061A0F
        for <git@vger.kernel.org>; Tue, 26 May 2020 19:21:45 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k22so9489081pls.10
        for <git@vger.kernel.org>; Tue, 26 May 2020 19:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5RSYrZiyDNDwpuh6CFhN+3fpjFARTpzTKshvPAb4r3s=;
        b=I43pA2f63zZi3uWDh89waz22obYh2CXqzHm+I7p3fhglGnU2LJh0mpxLm9hpqXpMo3
         ZRtMqby0puQMzvHqQ8v+wdqd5GA2+O458D0fg6iiT4h3/UOOfGb20uW9hLGpiikJXbyM
         yUfBfimhyqQqJlVu7S8z1M0pu1rmk3w8KlxAaPPogUm4N2Xro032wHGekrl88ZSOxgoE
         48/ogJ+p0yPiMzZ0JWcLoZENCVSo9tIw4gnovxMMV4EbNM7sjGNOZ345bqVq7BRx1bKB
         +kvm4vanp7Iyt7emiUnru+sIX9lmPj7P9skuex4e9WVgznk7kX60S5/M/tugp5UT+bUa
         18kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5RSYrZiyDNDwpuh6CFhN+3fpjFARTpzTKshvPAb4r3s=;
        b=pSEEiyndRJ/dEI9ypP1qlLrqGvyZiORwlndf7nz4ZiC2yviQKUD27iA7qDmfcQwv/E
         P/D/ikBf4E38zbeblg4lvulsF/34t6usRnUWo/oLu/QEPF8tVLBLU5/4LLS/FQIo4xY6
         b5Jvruc/ckpCpkXm+xElx5IsysgYJLw5Uv8Sqo5JlQ0Aovg/hLGhS8ApLIUGJwh1oVvX
         EIOxliYe7jyL8koN9dBx1FFublZaXy0G7L9a6/zdZqP6Jjg/nC6e+Z+Bisx6YB8nVVgf
         uwch+2jNqyNRWF+rAmNvGP/lPKDxM7YmQm5Yn7fw1hn9wUEDtousLr5TNWjEqfcvzU6n
         iMSA==
X-Gm-Message-State: AOAM531eRyhDZiJAuP9Ev0OCfolBeU1E18QTki5UWiGBoj2oDbG3+RUm
        9sx8hRfZ+1FpY4Wgvn89Ye5bq30L
X-Google-Smtp-Source: ABdhPJzGGxG1iULtGDEQS5En30yhb70Eov7789PzNJ+Ld1lY9xoZnmTu9MGdV7BEfqCsDedDNFfKYA==
X-Received: by 2002:a17:902:c082:: with SMTP id j2mr3946641pld.268.1590546105019;
        Tue, 26 May 2020 19:21:45 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id m12sm744792pgj.46.2020.05.26.19.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 19:21:44 -0700 (PDT)
Date:   Tue, 26 May 2020 19:21:42 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, hanwen@google.com
Subject: Re: [PATCH] reftable: technical documentation link fixes
Message-ID: <20200527022142.GB172669@google.com>
References: <20200525210232.87550-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200525210232.87550-1-carenas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Belón wrote:

> Subject: reftable: technical documentation link fixes

For next time, try to make the subject line summarize what specific
improvement the patch makes.  For example:

	reftable doc: use link: and urlencode to avoid dead links

> Showing as broken links in the html version (when using asciidoc 8.6.10)
> because some of the characters in the url need encoding.
>
> Change them to use a explicit "link" and URL encode the problematic
> charecters (ex: +, =, @).  While at it, change the base URL to use
> lore.kernel.org as has been suggested since 56e6c16394 (Merge branch
> 'dl/lore-is-the-archive', 2019-12-06)
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  Documentation/technical/reftable.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
