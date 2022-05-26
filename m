Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC14BC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 18:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbiEZSKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 14:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiEZSKG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 14:10:06 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF7AAF338
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:10:06 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id p74so2346666iod.8
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pAB0ralthJDpWsDug0knn+H8sfDu5loQZYGLL2pPNeA=;
        b=vNDGbuadY1w4ba2sJBC2G2XJA0zqE2NO52bTq1oA2JVM2iVILK+E4WKtvJiH2jjFZs
         zY4cH/PmzOKP3ar9vsr/YyOfNnNt4DG7MFZAd62po29LKly1D/dvQp3Bxxe99lXXWmPq
         Mfz5KdsysX/kAcePQi2iC7dIH7ZWnrR8iHcbqUyzVPfhNvvloZjGRFkZNmA2SUXKBYFf
         6MhaagBmuP2ipcAI0UjmE9ITCDn1UyhLndmj/R13ifqco3lNch6GR/hatfRYA8FJsGGQ
         lKFxH00cSxc17edt/3RNruURWXZvCWy0pgobbmIWDaXn1Q2CNllhAJK7Tq0lKKizq3kJ
         ZCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pAB0ralthJDpWsDug0knn+H8sfDu5loQZYGLL2pPNeA=;
        b=LLEsSNl7JuildWumzfp907pbTy5R8vlur8JWu84sC7rFEMSM6uMNsIt/FB52JbBC8N
         riUVG0VtFcu6hGqv5q8dbDaSK8Wmgk3v26pbK/CiZV+NdotYEZk1l6Gl8VBKPIxBZN8g
         0Pzo7L0Dg+uhHEXcJHUwXZbSvGzz7p0cY3m4SVsUWkS919P9Vq+3hmxIVFTfmKpJQ2Ny
         n8S7nr7UDf+z9t55qNTVu+jBRBWrDSBpR8XGGTRn9iwjxnerC4CZI1y7hCbIjlebA1af
         b4TJQvcfanYz5aJeruvoivKMNiite3iNpqH/7TZT8vHoCKE4IVciZZ1nsns3J333SH9p
         EF7A==
X-Gm-Message-State: AOAM5318fTWKzS2bt62uohf4niE4M2mx2UTTF6EKqo+m6P16pVu0DCe2
        9vVjNDuZbYVW8++EkRsvI4lzpFKUgxQ9ZA==
X-Google-Smtp-Source: ABdhPJwcjpvEiY9h1lZCd/9PkimCdUDNtTngU3pn7OCuq0Ygx+wJ26nj4f8uogGhZIWLlNn0/1d0Pw==
X-Received: by 2002:a05:6638:266:b0:32e:84b5:6643 with SMTP id x6-20020a056638026600b0032e84b56643mr19819182jaq.288.1653588605120;
        Thu, 26 May 2022 11:10:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n11-20020a92dd0b000000b002d1c26586c9sm690033ilm.10.2022.05.26.11.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:10:04 -0700 (PDT)
Date:   Thu, 26 May 2022 14:10:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2022, #07; Wed, 25)
Message-ID: <Yo/CeyqsOe7CPY0v@nand.local>
References: <xmqqzgj41ya2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgj41ya2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 26, 2022 at 01:41:25AM -0700, Junio C Hamano wrote:
> * tb/geom-repack-with-keep-and-max (2022-05-20) 3 commits
>  - builtin/repack.c: ensure that `names` is sorted
>  - t7703: demonstrate object corruption with pack.packSizeLimit
>  - repack: respect --keep-pack with geometric repack
>
>  source: <cover.1653073280.git.me@ttaylorr.com>

Stolee took a look at this and left a positive review. Victoria and I
wrote these patches together, so I assume/hope she's on board, too ;).

I think these are both ready to merge.

Thanks,
Taylor
