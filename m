Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A12C433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 15:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2E723382
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 15:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbhAMP0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 10:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbhAMP0K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 10:26:10 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14704C061575
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 07:25:30 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id j26so1292754qtq.8
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 07:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QGOSLBNsGxIaUVcgfr4kS+crytpTZpCEPPAOc4kVz1I=;
        b=CrvF5yXQXTFeYQbB9wG9b6y7w9ipTQqL0k3HfhSYBKXWzHeAMJXBXACBkEwzioHaHf
         V8rG8gNQxR4JHD4gUpCxwrueembfalGchyBh2VM0EGEDhn977WALR+44+gDulZJzYNG5
         UQdRGikm/aaatcDp1uBQLb4d/vcJ59sHCvGOsedEromwEOMkW5Y67vW+0BCwGpJ6EFIN
         3GpUIrWa7YtBMmfuk9gYiZ2gthxURKynqn0TTpb9KTXnRWKg8i8WhEwhTamyqcetJx/c
         PR6Q9Ns69e2uvG8N91kmweWwUW3Hddai7rwbKUL45Pm2qBLld/y+s9q1feeHhoTf6Lgh
         afuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QGOSLBNsGxIaUVcgfr4kS+crytpTZpCEPPAOc4kVz1I=;
        b=ha8G8BHUQlClpu0yGSWsCJbz7lGi6Jlw/84nwVHLYfY2qi3GHYrb18nukxiQrto+H8
         Z39vA3m2YGKi8pzntbiTxysTZR0TA+21Fa1IFYXAYHKksTgP36rWObHBpQeKXdKZ7Coa
         vSTKmNo831m8kmUUiKk5sEvro+b/rMOG7rXOwAFgTkVkExMgcCwJ9dFS/FHBKNUEXG00
         PNMwH5LotrQphSIaYr9yocPcrOKvXcLCAR2DK0iWZO1tcXmIQNLglVz+2KRTbNvECcq1
         YqOyb8ESxJ35SS7Zrjvv1tYOCTgbaTW0zP9eqGI8VOpJ10MhWQRoOI9sFQZMp2zIqJf6
         sLFQ==
X-Gm-Message-State: AOAM533ioToaFDeUXcGnKgKdoiy/qs3ThP/AReNxXL8g8k9IEKlQ8w1n
        Ax5eYH9WVilco7dmjQjuXKM6G2f4yymb0Q==
X-Google-Smtp-Source: ABdhPJxade2ppMHMx+poVKz2tzpJ2wwERVrq9xU87+8RJGaSPJIAhc9FW1mGYUDKPX6SlqSalSBtNQ==
X-Received: by 2002:ac8:5509:: with SMTP id j9mr2673524qtq.284.1610551529355;
        Wed, 13 Jan 2021 07:25:29 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f17c:3911:cace:ed91])
        by smtp.gmail.com with ESMTPSA id d46sm1092108qtc.76.2021.01.13.07.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 07:25:28 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:25:25 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] CoC: update to version 2.0 + local changes
Message-ID: <X/8Q5azhkyr1G+dz@nand.local>
References: <xmqqzh1dxmlo.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzh1dxmlo.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 12:33:23AM -0800, Junio C Hamano wrote:
> Here is to remind those of you who may want to add your Acked-by to
> Ævar's proposed update to show your support.  I've collected ones on
> the list I saw in replies to the original proposal [*1*] but in case
> I missed yours...

Acked-by: Taylor Blau <me@ttaylor.com>

Thanks,
Taylor
