Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E83C433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 23:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B9423A5B
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 23:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbhAUXqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 18:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbhAUXqW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 18:46:22 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DF4C06174A
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 15:45:42 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id n7so2449546pgg.2
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 15:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HIFv87bVjmPYaaQ7St85XeWEEOEjRWeC5ubdO0yvIzE=;
        b=eU/YUtCIgf8cmJ/a9kDozvk4u0TcmVHOKJsl1Fh06Q8kBQrNkrbGyyoiORnzvCC5CH
         DFuAoFp1aqddPtehEYN7qVvILj5vkNuBVTaWFq0VyvezMx4E4qZvNd4SdUKs9lCNVEBE
         wcN2BinSzgImL2LXoN0u20DHhwbWPrD1ARX1MpPe5EgtYMDTaUe4yeNQqMdQJK4Va0u4
         JZ1VlyBHVq7Ak1e5rgAJoDlITOMxHoYI57bmSxuO0dgwGDIzoEgHzqS2IqJigt2aLEen
         OLe50mrNDzk0a1qFc5Ew+maV9TVVqG9exCTHWn63shZxG1csxZsHt1R5QiOGFFm+2F9S
         CAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HIFv87bVjmPYaaQ7St85XeWEEOEjRWeC5ubdO0yvIzE=;
        b=aQoRgdk5TxKZ5zw3N/KxomhmMGrTH+o8hg4jhOnOb/bfYyVhqWkLGNzwf7xckH0gNs
         /PpcHwNKzX74HMz9VHtoRhac7h/bloAYNe6mAMtdnjYj3xOMXhxIPI59UYKPljmYv5L3
         AZ3+Tgi7zg1h+316s23a/1UmljsAc/hUKb1seyI2hvUe9K6aDpkQDTwQ57rKweBKMx7r
         B+E47zuvj4P+QxjbBYTIkhum7QCRVIF/Jzt2yx8o6Fz+vPj3w6bJbs0WhJeAb20yWsEN
         GfC7V4qMFQN0Y5OlLTnVJqkMDB6H5uxBN5gmme8lmg1KKt8FNFJEWvbBk/YZIK4Rvd4T
         ECOA==
X-Gm-Message-State: AOAM531kx9DLzcXAkRGvD2bPEjHFCwB8IDabg8Nqxl5e/P8P5KsDMoSt
        ndlwx/sh7OXt8V/mFoz6tSI=
X-Google-Smtp-Source: ABdhPJxEGpIHTH47AULpBHOKgyI7ZIw02Yt+n4CmvoNYnIgcX3k8rXrfF79NYFwVSr7yy3rwaLGnGQ==
X-Received: by 2002:a63:db54:: with SMTP id x20mr1796786pgi.200.1611272741798;
        Thu, 21 Jan 2021 15:45:41 -0800 (PST)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id c85sm6516998pfb.37.2021.01.21.15.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 15:45:40 -0800 (PST)
Date:   Thu, 21 Jan 2021 15:45:38 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] rebase: add a config option for --no-fork-point
Message-ID: <YAoSIkCecZU98QD2@generichostname>
References: <20210120044435.53509-1-alexhenrie24@gmail.com>
 <xmqqturbdxi2.fsf@gitster.c.googlers.com>
 <CAMMLpeQM7JCP0=TMqf0DxDCVJvkCGDEPSKN6vYTU_xc7+QaA1Q@mail.gmail.com>
 <xmqqo8hiaptn.fsf@gitster.c.googlers.com>
 <CAMMLpeQ5ga_e5-YeVuArYBrui+ps7HWzNjWNQgeJK3sEjo2zhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMMLpeQ5ga_e5-YeVuArYBrui+ps7HWzNjWNQgeJK3sEjo2zhA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Thu, Jan 21, 2021 at 04:25:25PM -0700, Alex Henrie wrote:
> I didn't see any fork-point tests in the current codebase, but I can
> work on adding some. Do you want them in a separate patch (that would
> make the most sense to me), or squashed into the rebase.forkPoint
> patch?

The fork-point tests should be in t3431.

-Denton
