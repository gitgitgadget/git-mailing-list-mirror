Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41BDC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69D4613CA
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhGNW3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 18:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhGNW3B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 18:29:01 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACD6C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:26:08 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h3so3140849ilc.9
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HjKp1MLaeHkUpN9OIHP0YzhQdsQLSWdfGT3xD8w2eVQ=;
        b=Wpya8ODW2tDxa8lO3wOmS8drg2nYJ5fx1IGGlTSmz7Psxz/jv2sxyjKBYbYz1XgtY3
         vL0zPSHRhfn07rtFHo1u3f7MA00YElLAB064fMAqAEiLueowZZk6b+VsFs7xnriPnLpJ
         0Eqys39/j7RcHBeM9k/pDF3OwZPbtBqI9ce/6COXoBIA3hHPVctEtukozGw4tZ3JZz7W
         D2ImmyGn0LnMEOjjPniWv6YCCg0WiyLQqH9G8iTMXLOxjBxIy7Zz3AVidvmLh6foMzE9
         vlFYDyyHA48Z/szIHVOCbEEjoobxAJat+d95sv6xfKrhrjJwmZAFQzwcbEB8AS9HdgB/
         Ki6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HjKp1MLaeHkUpN9OIHP0YzhQdsQLSWdfGT3xD8w2eVQ=;
        b=NRoNhGpk76NEFTKuQUoZS0CnPS/8zx1xHWjGVYERSg+Nq+zaipMN8Xc2NUGygS/QMZ
         eYadvuz5H/NG/oyjWIQEz/uwZ7EoebHX+DbaAa1X7N1W+wR7MZKKq0ThnQ3e9nZk8L4A
         bdj6AqYW5BPLfwH7xMQs9pEjaqOW5H/BzsIEPvm8eBT4w8yUBpvEbKFYaUE9VBVcEa9W
         Sr2GXGtUYtWvb9OzQ65692DoSOW262YmVXfSmsxAwborkqR89iozapwHfp4BWL7qRS2f
         /kxVJjcNW/8bsd1fhLCd7ol571Oy24a4jde8C8MyeNOQtp6BUA5+ZO16d+TmVP+keMA6
         eizg==
X-Gm-Message-State: AOAM531P1bZgrag2nxsXhidoPw5dq+rr0YXyZrKFd7C1yTh9iOd0A5lh
        TJBuhDt7AuGLSExKcnsrh0oKmA==
X-Google-Smtp-Source: ABdhPJyWnKnp6WzTFztddWLeUzdoPHUDRhwxHwioMbYm7CvomUE/HgvR3ckM35cMoEY2ZIcDSdWIww==
X-Received: by 2002:a05:6e02:60c:: with SMTP id t12mr81126ils.121.1626301567175;
        Wed, 14 Jul 2021 15:26:07 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:3f15:e25d:cd63:d019])
        by smtp.gmail.com with ESMTPSA id h24sm319011ioj.32.2021.07.14.15.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:26:06 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:26:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        German Lashevich <german.lashevich@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] doc/git-config: explain --file instead of referring
 to GIT_CONFIG
Message-ID: <YO9kfhr3u/Xx1FQc@nand.local>
References: <YO9YyTZdU4WadYGg@coredump.intra.peff.net>
 <YO9ZGTX9f1fOpTkh@coredump.intra.peff.net>
 <YO9jLvGlIVj3aI/m@nand.local>
 <YO9j6hrJFFTSEd6j@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YO9j6hrJFFTSEd6j@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 06:23:38PM -0400, Jeff King wrote:
> On Wed, Jul 14, 2021 at 06:20:30PM -0400, Taylor Blau wrote:
> > Perhaps `.git/config` is clear enough; I definitely don't feel strongly
> > about it.
>
> Yes, I noticed that, too. This is copied verbatim from the other
> options, so if we were to do that, it should be done on top across the
> whole file.

I'm dubious that s,.git/config,$GIT_DIR/config,g would be an improvement
in clarity if done across the whole file, and I'd rather be consistent
than not. So I think that it's fine as is.

Thanks,
Taylor
