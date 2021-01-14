Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B0AC433E9
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 16:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7E723B4B
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 16:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbhANQyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 11:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbhANQyX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 11:54:23 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688B8C061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 08:53:43 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id b64so8854940qkc.12
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 08:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dh3nJLcrkCiKQiZog75byYg7AyxYxK+LnMw4gcb7Wtc=;
        b=IW5FU3lm47tnmD6LLcoPvmoV1TRxpMI/M1KVwUFFXhu2mvh9wgHA7VzI0xKDi/KsBK
         EhbHc7jkC1TcrLJEpx8Vx4Ue1OrgBc0RXLipntP9oWOnCXhpkHeatgJ/N648jh+6CcYG
         79i6RFL3iHjpHvgkGUrdse/FmMPLV54yp3QhSJRXTi3pkSbCqYJi1mVwB7nh3zh03vx9
         AHVjr3cFxDYIKIF8rHcKcqCnv17mc32gKPnkcsL4VgdsfJ5WTMo7l9ZoW19YBmLSEcGC
         /g5RZNdGpXQG8AGW0oQj8/JcnjZwcE7p/gBo8ouhYt7ZY4QTxXnQjOdVH9njC/maNonu
         La7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dh3nJLcrkCiKQiZog75byYg7AyxYxK+LnMw4gcb7Wtc=;
        b=nf9jZ8qUDrZtRmw6dHStn9uADaAZ0WXEFGELgOgij2Xra2w/tXfvsbfR7jct+Bn0vu
         I/EyB/mHCd0oSgmTaZbEuKP3v/Q3b00QHRpb7aswbBzO8XW1WT3IijlOmDqkIzMWmg/0
         gqVwWor7kHuf4xmpob1ysZKMANIXFf2Ql/5jPdYh/bwgfZersTazvrmkLvaQnHFdPZSs
         GYcVN8owDTWd0XcjpVlrqubB3OSe3HG5Us3DzCXY2qtEICAtjg+34AqmciBC0iYyqdhW
         rIddVluSDTJHTWI/E0LR+ysVOv/LCncDgM7Hqv+ChjqkZEBimEW91uS0e1JQuIMYj1og
         +lpg==
X-Gm-Message-State: AOAM533rwL0ilZVGWoUo8gy/MNXCA8fnluXZqrlroxlG3wuyWyL98Rnh
        Jux34GodmVLGObo8cyhzz2UGCg==
X-Google-Smtp-Source: ABdhPJyvsa+PXCFfyfa1d5xqXzKLo3JU6S261SCH7VeAaFSMZUe3ngnNz2m1/zvIwJboDskdTw2BiQ==
X-Received: by 2002:a37:a941:: with SMTP id s62mr8017301qke.49.1610643222664;
        Thu, 14 Jan 2021 08:53:42 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id d1sm3334220qkf.102.2021.01.14.08.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 08:53:41 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:53:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jrnieder@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 16/20] builtin/gc.c: guess the size of the revindex
Message-ID: <YAB3E6lgOQdNgGOr@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
 <a500311e33a2f7e11a539dd0718ed946f4bd6bc8.1610576604.git.me@ttaylorr.com>
 <xmqqwnwgyqn6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwnwgyqn6.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 10:33:01PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > 'estimate_repack_memory()' takes into account the amount of memory
> > required to load the reverse index in memory by multiplying the assumed
> > number of objects by the size of the 'revindex_entry' struct.
> >
> > Prepare for hiding the definition of 'struct revindex_entry' by removing
> > a 'sizeof()' of that type from outside of pack-revindex.c. Instead,
> > guess that one off_t and one uint32_t are required per object. Strictly
> > speaking, this is a worse guess than asking for 'sizeof(struct
> > revindex_entry)' directly, since the true size of this struct is 16
> > bytes with padding on the end of the struct in order to align the offset
> > field.
>
> Meaning that we under-estimate by 25%?

In this area, yes. I'm skeptical that this estimate is all that
important, since it doesn't seem to take into account the memory
required to select delta/base candidates [1].

Thanks,
Taylor

[1]: https://lore.kernel.org/git/X%2F1roycRbYPjnI3l@coredump.intra.peff.net/
