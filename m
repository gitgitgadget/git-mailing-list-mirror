Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9190FC433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 01:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59766227BF
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 01:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbhAYBgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 20:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbhAYBfy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 20:35:54 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481E0C061573
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 17:35:14 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id q9so10811960qkn.2
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 17:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aNOLT/956tRAw6G1TgYODFjkp0dEJRoBWMbri6ObUs0=;
        b=FF5Drc9Ao1LL4Qw53rJ/FoGd0DU+FvAcOA0vMwXgU7LynujDd03QxWYeh9r8vHifUP
         WQ1To9Ew/OzKc8gfrxjo3tC405lSi8rFpHc5Nf+vHECvUzRlwUyEwSvrNKfBF07a/kyp
         9Sn087GPwbARMXjfX4vTIM/I7iAqpRE0E8xNupSQf3Rx4NWwPcw8JwLoIGNtC7PNp7FM
         yrdyH9pxhouFhEk/3DKnabtks+5zeboFwEbNlZ2pMNBsjFgyeZD+IyKtsfo3Zfe6BAds
         Y6jwEglwIiO9tfkXTV6n9YSLY/R4myz7Si9t2KUyGmWdzo7bvFJtkBxCxUhho3aH63t2
         WOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aNOLT/956tRAw6G1TgYODFjkp0dEJRoBWMbri6ObUs0=;
        b=MvqW1TTD2OwRQQ+lETnZdIoa54udPiLQUeV8zJvthCutlOnSVb7aX4SGRkQcPuzs2A
         HLYKhRMRU7IYikDy25QyWDtA98v0RuvN0MTR3NsGsN/sEpv2in24CcKr1ALYkmqLcDIq
         4AZZDrnU0mzQ4wbDmt8/HQkCkIiaHjt5sxb7hhn25AP5Jea98UVd2rckup/+jrdI/S61
         DRTBgaRWWOIV0tziQAGR+ojusJPY67YHGxlsNY9Uh9Sf1S+aMN23wo5zTo6Cek8jXMTE
         a8GpRP8XgyLaAtHarpsn0/C5EzaO+WInCzKjEGlETN+P/QaQcO8C173ETKS1WiqeITog
         hk8w==
X-Gm-Message-State: AOAM531iOuPimm/YNKIvFDgw6MCnLD0Y8xK/2w2Cjp8VMsBTDizDtXyB
        I8LQ44mzvRb7B6btXaKIK24mFw==
X-Google-Smtp-Source: ABdhPJzU2h0ed3q9ve6TJEfpZpnnqjf0Oqjih6HvJeQGOrsLxMGz3X6dOaKKYzCMPKGn63yCf6tN+w==
X-Received: by 2002:a37:9e04:: with SMTP id h4mr1139560qke.258.1611538512334;
        Sun, 24 Jan 2021 17:35:12 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d8ad:42c:f23b:d0ef])
        by smtp.gmail.com with ESMTPSA id n24sm6811032qtv.26.2021.01.24.17.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 17:35:11 -0800 (PST)
Date:   Sun, 24 Jan 2021 20:35:09 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jacob@gitlab.com, peff@peff.net
Subject: Re: [PATCH v2 1/3] refs: expose 'for_each_fullref_in_prefixes'
Message-ID: <YA4gTWgMVnQyVT/I@nand.local>
References: <cover.1611080326.git.me@ttaylorr.com>
 <cover.1611158549.git.me@ttaylorr.com>
 <bda314fe7ae1629ba068a0c4ada9b6adc20576eb.1611158549.git.me@ttaylorr.com>
 <xmqqczxw5pf1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqczxw5pf1.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 22, 2021 at 06:59:30PM -0800, Junio C Hamano wrote:
> Caught by
>
> https://github.com/git/git/runs/1752536671?check_suite_focus=true#step:4:63
>
> I'll apply the fix suggested by Coccinelle on my end, so there is no
> need to send an updated version just for this one.

Oof. How embarrassing. I'm well aware of the existence of
strbuf_addstr() -- there's even a caller just below the line I changed!
-- but clearly wasn't thinking when I wrote this patch.

Thanks for cleaning it up.

Thanks,
Taylor
