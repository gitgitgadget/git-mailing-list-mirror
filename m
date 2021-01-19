Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15659C433E9
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED23522D08
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbhASWlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 17:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403817AbhASObl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 09:31:41 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8E5C061574
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 06:30:59 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id c12so8214337qtv.5
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 06:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Vf1TQ+LJdeLuh5H7C7RXwWlMrJWvbqAD3tub2zB7T1s=;
        b=At+16Nc0s1dksQ+gy80Km+wrYgTAuqGpvebTPDEbslMOYWcbZUJ9FGZcESRIgnIrUz
         beEN5Jtx6V7yQg6vl38vdoBEgsy7K0zGMyC9v/68ddsexTfB7wUjBBTpov4nvXC6wP8k
         jjFIGmnp0lN5aGD+rA82C88Y7QF4dlTv8UjQJqbZPpq4sVazsXTyEB4gbOXaboQz5Udr
         RbqoLjXak+aGeVcV34DJHOo3kt54ElOWhslvgrAe/g5ZnmkFEgEMzfDuanzd0hyR+1Bs
         1cdctLpqJQkRXy4WzDkrrsC1BuL3EkFQei3nzdOpeoKSa55S8Hk0Lh9rHiZEevhg2SE+
         Uidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Vf1TQ+LJdeLuh5H7C7RXwWlMrJWvbqAD3tub2zB7T1s=;
        b=fsCER6BLYBG857w2VgxRKLQLTiVFgrWp3Ycf4AzFk9sJifyX1/ubdmmBhViGQ8SKpt
         jAafRR9ZLin/LFodOBeoMRiBjOTkMWdTEpwgtWdhB/W+plOKNLCJUP4NZnQHsL7YK00N
         mNYIsOhBwOZpInTauwgK7Nu9NBXKki9Mf/YjXYb1AEMvu/vl7g8qynkOmtRqp/20hNjq
         C0pZ88UyUELUUKD4PSf+VX+AkiKgxApYy507tWCS0RBEFnuHD/9sa59SEQ5YIPslUBRr
         lDic60vzSR/fedIeTEcavPDR5djFvaMvVuphifN5EonvzSDLQWtXSG1B8Jmeh9sEDgog
         Ky7A==
X-Gm-Message-State: AOAM530zV0HNgz/1vqhg+AJBPyGHSNCUisg+Y+XR5dCvVonhY6fryhkS
        BdNstZus63nfx+Erf4uHsqZw7g==
X-Google-Smtp-Source: ABdhPJw6ESMgar1jrpbQboZnXguXdQBSaimZY4ZftKLIJHK9abEIIRo6BFusfrEgY8A0VCsbBEDing==
X-Received: by 2002:a05:622a:303:: with SMTP id q3mr4272231qtw.235.1611066658294;
        Tue, 19 Jan 2021 06:30:58 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:626b:1275:5dba:df42])
        by smtp.gmail.com with ESMTPSA id n36sm12264294qte.71.2021.01.19.06.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 06:30:57 -0800 (PST)
Date:   Tue, 19 Jan 2021 09:30:55 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Greaves <david@dgreaves.com>, Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] fsck doc: remove ancient out-of-date diagnostics
Message-ID: <YAbtH5hSiRTwulGv@nand.local>
References: <4269557C.1050606@dgreaves.com>
 <20210116171500.20092-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210116171500.20092-1-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 16, 2021 at 06:15:00PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Remove diagnostics that haven't been emitted by "fsck" or its
> predecessors for around 15 years. This documentation was added in
> c64b9b88605 (Reference documentation for the core git commands.,
> 2005-05-05), but was out-of-date quickly after that.
>
> Notes on individual diagnostics:
>
>  - "expect dangling commits": Added in bcee6fd8e71 (Make 'fsck' able
>    to[...], 2005-04-13), documented in c64b9b88605. Not emitted since
>    1024932f019 (fsck-cache: walk the 'refs' directory[...],
>    2005-05-18).
>
>  - "missing sha1 directory": Added in 20222118ae4 (Add first cut at
>    "fsck-cache"[...], 2005-04-08), documented in c64b9b88605. Not
>    emitted since 230f13225df (Create object subdirectories on demand,
>    2005-10-08).

Thanks for digging on both of these. I checked independently and came to
the same conclusion that you did, so I agree that these can be safely
removed.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
