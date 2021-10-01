Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9F3C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 22:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0351961AA9
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 22:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355294AbhJAWmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 18:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhJAWmf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 18:42:35 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6B1C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 15:40:50 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 5so849959iov.9
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 15:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J+C+gKTBr3E4E9vMDZnlYJVLHwy4+hpo2duN9UIitcQ=;
        b=SE1oUUKbIBZ+KHcYd60DTAwB/h0Ln+h21qBtOL6SsBlLPK1ygiUiEGDSMHSexQb8kQ
         LmcqhWqZX/lCdGiE9v1I630yuTBsts3eGHrXhrdpe2+ypXyKSVpGlMyAI4kWScdKP9wc
         WFGK/n7x1sUkGem1Ox0yTz+0FWM9lftrG5fw06UlJa5aFrfyl5I9ZYC76/42MdGtWcWO
         +8DizpCzy53trOFTjmItQTP8yAj+JFXMplvKIeUodMUEqZrOp65+HBlZC8PXk2lqZ67Y
         bqhMN7ZcxuB+rkIvUZK5bzLKWGFrdQBtyGB/+uT1QVb9Z2sjqdHJYYWo0lZi5PAwdGEh
         Zpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J+C+gKTBr3E4E9vMDZnlYJVLHwy4+hpo2duN9UIitcQ=;
        b=3Q/+67XsrNyRzIw2b3Sepk/rOxqPcC1vhtD55satMYpLArmV1HQdlyJEzytBEHm2s7
         puK2pKrOMZt/TG0nXWEKSTH9DlCACKni7KFT3cCbs0xkbS0Q+l40QZvjat7ZRMdlmzyP
         qQeXH+jf/+3g6ZR9MrrW49beHhiBdnEk7Qx0FhBQKzSqr7ezf5fiFe1qcxmWYadcsjkv
         W/TO7p1/DUbxgV+S+n+M27aahbOCkwAY6jWJ6XWfq8pfNNLieqL/Uoa9KPXtg0aU8vFp
         PDLzuuvf+ui81j/nHunoc9HrITCiXOIVoTk23T8Fx+Tooge7l+YZicaJF0MrL/lNl1P3
         nv/g==
X-Gm-Message-State: AOAM5310B+KiH26BIz09WQGNQOuxDMV1d7QAdqfpgYpwnP5E8PLhFKal
        BkwPwbG3qZQSkQ6rx29xHh4UVQ==
X-Google-Smtp-Source: ABdhPJwfzKlfmQTwD1AYdFea72phe4HOh7Z/nGp7YXWR6GnMXvCYCyssT4/ZJjbmTEbVghf8L/yNmA==
X-Received: by 2002:a02:19c8:: with SMTP id b191mr420637jab.10.1633128049890;
        Fri, 01 Oct 2021 15:40:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v17sm4356124ilh.67.2021.10.01.15.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 15:40:49 -0700 (PDT)
Date:   Fri, 1 Oct 2021 18:40:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        gitster@pobox.com, steadmon@google.com
Subject: Re: [PATCH v3 0/9] repack: introduce `--write-midx`
Message-ID: <YVeOcL7/kPxt5XVu@nand.local>
References: <cover.1632880469.git.me@ttaylorr.com>
 <20211001200135.215855-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211001200135.215855-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 01, 2021 at 01:01:35PM -0700, Jonathan Tan wrote:
> > Here is another small reroll of my series to implement the final component of
> > multi-pack reachability bitamps, which is to be able to write them from `git
> > repack`.
>
> I see that all my comments up to patch 6 (of v2) have been addressed.
> There is one outstanding one involving a potentially uninitialized
> variable [1] from patch 8 (of v2) that you (Taylor) might have missed
> since I sent it after I reviewed the first 6.

Thanks! I must have missed your review of v2 when I sent v3 (indeed, my
reroll came 5 days after you sent [1], so I missed it).

I sent a replacement patch here:

    https://lore.kernel.org/git/YVeN0mXqYvTHtNB+@nand.local/

which Junio can take instead of [v3 8/8]. But I'm happy to reroll the
whole series, too, whatever is easier.

> Reviewed-by: Jonathan Tan <jonathantanmy@google.com> (conditional on
> that being resolved)

Thanks again :-).

> [1] https://lore.kernel.org/git/20210924182247.2922561-1-jonathantanmy@google.com/

Thanks,
Taylor
