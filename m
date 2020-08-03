Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF67C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 16:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A9720738
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 16:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="aIDX7ZW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgHCQLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCQLG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 12:11:06 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD91C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 09:11:06 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l6so35600223qkc.6
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 09:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kc9UthZfII/0zlXsfq/WpoBjqWLfQ+Rv98z4omPQZVI=;
        b=aIDX7ZW0OHn3DsVgGTQRmvZsNBNiD+Z2IAWnALkMXifz0QhTvdDyKCcx+EwBtkv4Hj
         5XCANsxM0HTzDzBRsMk1CpmoJ+z/ms5wuflHZucc7rXb0wFMaVKd4DDUkRhCpj1sE9bz
         Iqr8GbBTdblnyESTLl7KS4FlfD51wQ3FJr1XMR5gKViwrcw6P73GGqwBmhuKT9GxxbXP
         TV/2MIatsw5ebCqYrH23UGJhVbbdqkCimAJayuBzO//t83xK+GjMmo4NI1hZ1kJ5ZfHa
         yv7CS+Pdlm3yc4OWEkfS2+LT54BKhh5wt5kDSFVXh/H4rt9U8cOCFeJ7lSoAuaBnnQzw
         l9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kc9UthZfII/0zlXsfq/WpoBjqWLfQ+Rv98z4omPQZVI=;
        b=UFw6Chp6mPd3gmfPNuRvCOz1638BsrkbbKB89Bnt0hR/fVkbJCeCr32dHkC6mJnq+q
         MQsqEGKAl2qAa8cvBgZ4sLkv5fZq1JuOIgXaSbfAhrtYBlpQ9OxLPpuAGhmMXLghhQCd
         2dq+gqypf4kcEGn8Dip0WvHPVqtK4YmfxyAMpBCsKUEoCsPPJECif3hgQdVhZoiRVvTF
         zm92utN8FwDqiDTBMF7gEWZcf7XMIOfws6GSjZcs4kW4VuNxRK6SEELo3TxYJYpTnGdA
         LalW8HgCUKCpYMXV0wK0E7ERJ+7gEAlc1Vr4SMEbFbkqEmpr+5p+8aWWfRuVC3Fw4Jx7
         srMA==
X-Gm-Message-State: AOAM533DQEtvnmL+rhyBrpiBk+6h3TTXUGxsHUzVnmTTHzuuz14Ze9n3
        gJjy1J7n/vdu5Yl7ahYebNxLfg==
X-Google-Smtp-Source: ABdhPJyw/yxQ6JE9YvI9zc0r9xpG0fBMPlQ+hwyBgV69kxtPJhU8OKdRDpIJ0+WwLItwIN1B6EHhUA==
X-Received: by 2002:a05:620a:2230:: with SMTP id n16mr17463463qkh.268.1596471064517;
        Mon, 03 Aug 2020 09:11:04 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id c42sm15368268qte.5.2020.08.03.09.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 09:11:03 -0700 (PDT)
Date:   Mon, 3 Aug 2020 12:11:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/4] git-worktree documentation cleanups
Message-ID: <20200803161102.GB50799@syl.lan>
References: <20200803053612.50095-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200803053612.50095-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, Aug 03, 2020 at 01:36:08AM -0400, Eric Sunshine wrote:
> This series fixes some problems I ran across in the git-worktree
> documentation while working on another worktree-related topic. Since
> these fixes are distinct from that topic, I'm submitting them
> separately.
>
> Eric Sunshine (4):
>   git-worktree.txt: employ fixed-width typeface consistently
>   git-worktree.txt: consistently use term "working tree"
>   git-worktree.txt: fix minor grammatical issues
>   git-worktree.txt: make start of new sentence more obvious
>
>  Documentation/git-worktree.txt | 96 +++++++++++++++++-----------------
>  1 file changed, 48 insertions(+), 48 deletions(-)

All looks good to me. Thanks.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

> --
> 2.28.0.236.gb10cc79966

Thanks,
Taylor
