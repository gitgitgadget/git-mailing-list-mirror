Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3F3C433E6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CADFF233F6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbhATQUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731358AbhATQU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 11:20:26 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803F8C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:19:45 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id d14so25785405qkc.13
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SbZWUVvmFye4CTUEB9izRgQGhx/qk2+YYUTVedYAA+U=;
        b=rkal0Slyy4T6qQMTKeKHC1gCOXR11tyiMk0eRmCdIvL6jl+/pompsAV8Pljzpzcvnb
         DjIBqsZmkM812KfbAGs6S8/CDxgQ5JDwu8tsDP78ytmHEA0foxbanf22rnjWYGVtzCZo
         MFfs62zm+PVoe3uDS9HUYJqI8Zke2Vlmmbb00A2lODHfCACJugexbJ4bo12wvL7IdGpR
         cc+6NnhWA7RMj34BRwVSvOMf7EY2tGRYIAVUvmpidGKLy9rCcaTZAWD7dN/Evt9vAc5v
         uixO/uSN7CYqz80TfnJC8VVAF0NDJNnOH1pwkSK0rWOiUwz9A5oE0VhDKX0WvUIlPs+R
         xkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SbZWUVvmFye4CTUEB9izRgQGhx/qk2+YYUTVedYAA+U=;
        b=RTzcHKqNYJRMjJDib8vZFu2707RuTv2FGaU2UnMoiHruSimNK1/bCejSokPGvRhw0n
         YezjZMCe7KqeAhrYgjJSkUzmx1pRtbZrOKG9QjvJqTdAvmFcnn0BS5tkGqd+rC08eLkX
         2Vm5YTRuCclMhb7t+3LQ2OFYn0RNcwEVYAXi+N9U9w1k/xif4tRsbavKlasdIYqG3/iO
         9sBB2vIQ3ahS1d9KLAtKsPprhB8RsyyJHsqr5rLXceuIVs/NaTdGjZ/OiZkdVKfmW4Gl
         owOnigvkSFXAJK5HtW2G+wCq5X21jE96gLcneKxt6m60TZOezzGVuDGSjI0cWYKKzXso
         C6pw==
X-Gm-Message-State: AOAM532yQItFgmcdDZsWayl8OQuR3f0JYH3Hao1wY1PIHmvKeW+DK3Us
        MRzadL/4OSyWxdp8SB45B1IZm/aCqu0zQQ==
X-Google-Smtp-Source: ABdhPJyAWtnV1oXjKrumFUceXS2ZJfxbvBvsFJbCD1zsOEkqpf8lUa2iKbjuvG5bOAeRpdcAsTbMZA==
X-Received: by 2002:a37:9f14:: with SMTP id i20mr10292628qke.321.1611159584799;
        Wed, 20 Jan 2021 08:19:44 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id e5sm1427998qtp.86.2021.01.20.08.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:19:44 -0800 (PST)
Date:   Wed, 20 Jan 2021 11:19:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Jacob Vosmaer <jacob@gitlab.com>,
        git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH v2 1/1] builtin/pack-objects.c: avoid iterating all refs
Message-ID: <YAhYHUcdynbWyhwo@nand.local>
References: <20210120124514.49737-1-jacob@gitlab.com>
 <20210120124514.49737-2-jacob@gitlab.com>
 <YAhC8Gsp4H17e28n@nand.local>
 <YAhXw9Gvn5Pyvacq@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAhXw9Gvn5Pyvacq@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 11:18:11AM -0500, Jeff King wrote:
> So I think both the existing and the new calls using for_each_tag_ref()
> are OK here.

Indeed, I followed the same trail of calls as you did and reached the
same conclusion, but didn't write any of it down here since I thought it
wasn't worthwhile.

But, yes, I agree that both are safe.

Thanks,
Taylor
