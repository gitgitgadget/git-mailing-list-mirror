Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E7AC433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 22:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347137AbiFOWzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 18:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347441AbiFOWzS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 18:55:18 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BB7295
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 15:55:16 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 43so10478347qvb.3
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 15:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BEEyaMzxGVUVjkYM+z/Q1CpUcBmLusl/TZkgJm+jBmg=;
        b=MoNvdmpKSpOgS51DCWk3HIe0NOxbw3XYX4hXtUt+J3WjRy7jf1Mw4cuc/QA9rXDpk1
         QCt2gjtGQpuxPeRPgrhOJf4x6P5y7Z0gAr70NaG+bOwggjUSSbR7/Yx52qbs+5u1FTX6
         e+rGB75J6Hdts7jILA6zbCckBAvhAxokGdlrO4lIiVSTp4kC6aomB1f+8DHBz+9KSHnd
         gBck4YcrUjKcx7Ap2/RcvbsDgWYARw6wk9/J4+/7Jn5yb+f7kgOoLI5YDuV25GXZIcF/
         Spbz5Snc645BwCEvCJBKIIN+7ri/A7lUCDD6fJ8RJt4D4qhb5pKM3YKhMUUYqcPQC9+j
         kIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BEEyaMzxGVUVjkYM+z/Q1CpUcBmLusl/TZkgJm+jBmg=;
        b=5J+fpGJzGQfuD7L1kFACSIlQ6tFTeAKN6bvsvRhQtZAZVF8+Nb71fR0YVkJ1wzkko+
         UTyPmE8O8nEOZz4t/j45FU1m1uLLyzscoTMNkq06qrEKqGqSCagakHV5ONi0Zhw5bmQ+
         SSatDpcxxRY/4Dk+uMREhQOCD0k9cNSysBbYdF8eGxC+UO8lXbG6hqzQg/9UlmLgWi2P
         obJ6coGcHawz5WJ7ozYZdCQ1n/pdKkkwVXksovyKdfLZXCzmTdMO+RBK6qKPwPm1VD19
         0vbZZvlnjtZfKXe1BuJeswJFp9grXDNo+wUf9nSIv6FUP6YouZAEqLad6w0i9RLmqnIQ
         ZDPA==
X-Gm-Message-State: AJIora9Kes9/Eo/ij93/e0EDpdh20IeaJcSKT/Fxt1loJW7CN7h92jtp
        +Ym6uQh0tg/6s2EkUwFoOvZeRA==
X-Google-Smtp-Source: AGRyM1tQ9UnIYTv+gZbqbyYqKYurs6ssZ/ZPVKogdyk+375WC/I8N575chAiTAa0bjseQNkMpCtHUQ==
X-Received: by 2002:a05:622a:19a6:b0:304:ec2c:ce2a with SMTP id u38-20020a05622a19a600b00304ec2cce2amr1730206qtc.472.1655333716016;
        Wed, 15 Jun 2022 15:55:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s6-20020a05622a018600b002fcb0d95f65sm358780qtw.90.2022.06.15.15.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:55:15 -0700 (PDT)
Date:   Wed, 15 Jun 2022 18:55:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH] pack-write.c: remove unused `mtimes_name` parameter
Message-ID: <YqpjUiT45Oy8a577@nand.local>
References: <f5bf68702d55b601ebd13bc4a6f1a34dc35abae5.1655253465.git.me@ttaylorr.com>
 <a7c81b77-651d-3374-6db8-f46ad01a8319@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7c81b77-651d-3374-6db8-f46ad01a8319@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 15, 2022 at 09:30:52AM -0400, Derrick Stolee wrote:
> On 6/14/22 8:37 PM, Taylor Blau wrote:
> > `write_mtimes_file()` takes an optional parameter `mtimes_name`, which
> > specifies where to write the mtimes file. If it is NULL, a location is
> > generated with `odb_mkstemp()`.
> >
> > This imitates the pattern in `write_idx_file()`, and `write_rev_file()`,
> > both of which have callers from the `index-pack` builtin which specify
> > an exact location instead of generating one.
>
> I have a nearly-identical patch [1], but I'm happy to take Taylor's
> instead. I'll plan on dropping that patch from my v2.

;-). Great minds think alike? Either that, or one of us (me) stopped
reading the rest of this series before sending their patch.

> [1] https://lore.kernel.org/git/b67e110bf60e820874de94c64ee8c32d69413877.1655242070.git.gitgitgadget@gmail.com/

Either version is fine with me. It's probably easier for the maintainer
to just drop my patch and take this series in one go, so I'd err on the
side of your version in [1].

Thanks,
Taylor
