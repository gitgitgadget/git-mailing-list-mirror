Return-Path: <SRS0=Ralj=CP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6D2C43461
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 19:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F0BD208B3
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 19:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="f1CoPAdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgIFTDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 15:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgIFTDq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 15:03:46 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E25DC061573
        for <git@vger.kernel.org>; Sun,  6 Sep 2020 12:03:46 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cv8so5521599qvb.12
        for <git@vger.kernel.org>; Sun, 06 Sep 2020 12:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=T2EU5A+W0QbZIMqHh3ZPNqkTAC/2QhLv/g+rGVTiAAM=;
        b=f1CoPAdSr21pF/qw2d8xmQ11HkPY+ll1IDx+AtWIuGNfoy1Hu3sCXuneD6P5/bHchm
         OAQCK+oghP3403FFp0STlQl5sR6Ff+zjv4sVSZvrbaHeAF7NhybqiRksoTmdjOuDtVkQ
         roy5ov+j9RPwR6T3uVrucuP/NQuc8A9/8N8mwx0lvkMKmooFibXk4aMx9myYVP6vd1n6
         Bsd/NMSVnZJuCEIxoYd4cyNE4l0R0NP5j+5TAeiDHjRsxu7XIC6IDqyW6/tKVV5m1gwa
         5ttIW7UNnfcT+Cowg9lakDHX9gmeCXC+rF6sNns092ssamHx/NGkLEFWUVc0TSG35+wt
         FcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T2EU5A+W0QbZIMqHh3ZPNqkTAC/2QhLv/g+rGVTiAAM=;
        b=KSFJ+Ip/N9liW9GYttQdF1BldiDlyoTfnd4EJJ8VW12gGiaZOcK5T8DICHVXa4NnrY
         AnWTGyKP0P22KFYzEniD/ggfl0qo2USFo1CZs2fqRmovqwoTAsYL5jNlNFqtvAEEEAxe
         /MJr7iFQVpOxw9wGwgeL4Jrm2pj2Sdq8s8Bua2nn45u+LmPoK9Dx8TWEKv9b0w6gjmpM
         N08uPTAU+bGw++BhmHnknLGBEJHoWKub6XNIXWBUD5NQdpnu06N0r7kydscVKf8EirDK
         m/diVC9SZjBjSCYZqwOI3aiSEegud2dWXi6Flx/HENHNdpnJhRZtMNP+/0E42bMsRG+g
         lgAg==
X-Gm-Message-State: AOAM531hA4QJMgQg+r9BnHKtDFDOSO33RpkBGR92c+DDByejYzQM3gTo
        I4a3bRF3OKznZ6XOZ91v7Lm+dw==
X-Google-Smtp-Source: ABdhPJyTfW2ZKk5t2mrq0W9P8ITih9va0bTx0iJn7qwFAT9DDzN+ZquFpdlYjJRyLc1s8kPZjyzV3A==
X-Received: by 2002:a05:6214:805:: with SMTP id df5mr17029740qvb.78.1599419024463;
        Sun, 06 Sep 2020 12:03:44 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2928:8cf2:b0f6:adfd])
        by smtp.gmail.com with ESMTPSA id s17sm9806785qte.50.2020.09.06.12.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 12:03:43 -0700 (PDT)
Date:   Sun, 6 Sep 2020 15:03:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] midx: use hashwrite_u8() in write_midx_header()
Message-ID: <20200906190340.GB6146@nand.local>
References: <ae03833d-d597-f902-38d5-9e67bd768d93@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae03833d-d597-f902-38d5-9e67bd768d93@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 06, 2020 at 10:59:02AM +0200, René Scharfe wrote:
> Emit byte-sized values using hashwrite_u8() instead of buffering them
> locally first.  The hashwrite functions already do their own buffering,
> so this double-buffering does not reduce the number of system calls.
> Getting rid of it shortens and simplifies the code a bit.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>

Looks great.

  Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
