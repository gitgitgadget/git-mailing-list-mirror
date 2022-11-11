Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35412C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 22:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbiKKW0p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 17:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbiKKW0m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 17:26:42 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C0266CBF
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:26:41 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id 11so4588685iou.0
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i5+sORSiGbpJsfUWFTqw5hu020DHqH+Pqx2E/ci06B8=;
        b=MBAn8SJXyWmbLo/xIt23QgKbRbiY6h/f7ogI1PWS4afvBxFoN1cVHBcSVzSDHdGp6/
         eFrEh9OorMlZYQfyG9h0qPxolQtmJJoE0PEka4Qp8j0n70CeI8/mAYxJ9QsTDE7Ezx7P
         yHwDRaIcxb6AFTdmxMj9+cMzVyzimF8qH/Sv5/WA6arBIF3Aw+dU8nc3rkV0vKWgTx41
         XOC9cqqgnhZX069yiRIgyAsRDeYiwkeR2I2aAIBwNIsbdPcpihZ+UgEFF7G2lyCuVpP6
         wXx7V3AZlrK9tIUSpFMJ3j0EoaXYlWfw2EWHMUTvBDO3RpjuqlsWECgJk0IqX/voBnmW
         xbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5+sORSiGbpJsfUWFTqw5hu020DHqH+Pqx2E/ci06B8=;
        b=f+G4WopOXwbozK13O2ncJTwDK+Lja5LSS9AvWUWoR5OJEZBT45KLtMLh16tx6v7Ikg
         kpTdW69THEUKk7SZM6sLNUOnDls4fOI02ApPUdYJTE4+Fvv53U1lPQmB6aEpi6nNyaTs
         Fh963JlhNnM0GWBikAO+JI9Aw6BkyoRA3+uk5XGoy2sbtfivtv9m3j/ZuQEbiiolwX3O
         pRyrL2S862whEMHgNR2N4Tn9/zObFaUPMgSNdX2NOhJV9QBFF1Dgt9MQz+Ai6391uRrP
         c63hZD7kk7zp+WbdJ5Tn7+zxCnFTkG7FhsWWpiJ195ThzHscbnopLUC3Bl6Z2yo2aC1t
         oIzg==
X-Gm-Message-State: ANoB5plTECNsNf/SVDDeb4aT+DciYSpzGiADp2AjDcqnlXLoS/qG1t51
        rTfp9pNFmR0zwSmR7+276eC5tHg+5LZ+BA==
X-Google-Smtp-Source: AA0mqf4Oe2wz/+iLTfq9eE2W1VNris9Q84L/I98VuJMSCxN6ySRj7qaAzbo+ddzB3wLc6l7eD/+Gog==
X-Received: by 2002:a02:242a:0:b0:364:1001:370a with SMTP id f42-20020a02242a000000b003641001370amr1688191jaa.132.1668205600734;
        Fri, 11 Nov 2022 14:26:40 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i21-20020a056602135500b0069e1bcbddaesm1222466iov.16.2022.11.11.14.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:26:40 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:26:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 0/2] pack-bitmap.c: avoid exposing absolute paths
Message-ID: <Y27MH2LtfVzKEM65@nand.local>
References: <cover.1667470481.git.dyroneteng@gmail.com>
 <cover.1668063122.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1668063122.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 03:10:10PM +0800, Teng Long wrote:
> From: Teng Long <dyroneteng@gmail.com>
>
> Diff since v2:
>
> * remove unnecessary comments.
> * use "GIT_TRACE2_EVENT" instead of "GIT_TRACE_PERF".
> * improve commit message of [1/2].

Thanks, this version looks great. I'm very satisfied with where it ended
up, and I'm feeling comfortable with merging it down.

Thanks,
Taylor
