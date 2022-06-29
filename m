Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C3BC43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 20:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiF2UL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 16:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiF2ULz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 16:11:55 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E56E1D304
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:11:54 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 2so11629021qvc.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qkWUzTR+SivCaS1uTezGLO5mqKsz9Fv73PfLXMhPTh8=;
        b=nPOuUD9vnU3ZGSFSwP0QmXhgVu0vpGxZmKSXPNo+Tr9cG2nxcQ19GNpnwyhUfWPBvR
         OQBtFXg9WdQn51oNx3iz5W5DPRfobvuVn2yY9gcu6Ml4GLTmh4ettLP/AbAuM8ucqhU0
         F8Ab8j+kJCGnqS0ZCZQLMEK3nOfukEHAC2PQ20xJwbC01yIdQhAyZA30Hahg6yMi4Y79
         uuuNc5dex3PJUwkzYKhQexSICqlUQRP2xSvXuJcvFUM7g6CPUEniTCvfZiqGIGvvGWwf
         6LzE/H77KInQwP8veOaP/pMpTzkLh3rs7FpvjLYNgm7aE7wNqnwPPK76fH7OFRmCcMCh
         W/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qkWUzTR+SivCaS1uTezGLO5mqKsz9Fv73PfLXMhPTh8=;
        b=op9WIOtgk0FcRzlL7pgYVUeHlMhjOkcyDqIRlFPZJZ+8LnaU9P/7B3Ygp2+ZUppPQ3
         76Eglp7dWa8dryeRkj3uSg1RfhLo42DSkj5GIXAzBuuckkDV6tzZIUDdAXoCwfd0sogi
         B03b8I1hy5bj/p05aJa+56HfAy5xp+oDIwixuVF9aO9OXNb+TlHbKIDRLnGv83i53C+w
         /xQAbgrsdmaMp6rcizQ229+0QNsrXb2DpBdY4TjHkvXcqcVfMCO3+85wtgLe2CHdOJb7
         Nk7g2d3vm0LJ+0h8hSYZ0fS6MVyP090UAwgwg1eIbcB3chXb2BfiYE7iga0dYDEPXx85
         A6Uw==
X-Gm-Message-State: AJIora89U6wCoVBUj2iy/Jikk2svCooJ0uixKX3Fx722G17GIhJB7OZL
        rz96fMY3maKwaGuLZ3eYhRZBzfjwDoPCRw==
X-Google-Smtp-Source: AGRyM1tp3MIymQTQ8LLtRJpln87azAnJmBJ5n88z4c3E83pM+ooaXa+t25PMPyLh/OupiOZ+56+Xow==
X-Received: by 2002:a0c:b441:0:b0:470:2e6d:cad with SMTP id e1-20020a0cb441000000b004702e6d0cadmr9300407qvf.27.1656533513513;
        Wed, 29 Jun 2022 13:11:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l6-20020a37bb06000000b006a981a2c483sm13380870qkf.39.2022.06.29.13.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 13:11:53 -0700 (PDT)
Date:   Wed, 29 Jun 2022 16:11:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 3/6] pack-bitmap-write: learn
 pack.writeBitmapLookupTable and add tests
Message-ID: <YryyCGSvR2Om3UpH@nand.local>
References: <YrntSpG5asIPNdZz@nand.local>
 <20220627183924.16369-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220627183924.16369-1-chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 28, 2022 at 12:09:23AM +0530, Abhradeep Chakraborty wrote:
> Taylor Blau <me@ttaylorr.com> wrote:
>
> > Probably both of them should take into account their separate
> > configuration values, but cleaning up the hashcache one can be done
> > separately outside of this series.
>
> Actually, it does respect the `pack.writebitmaplookuptable` config.
> As pack.writebitmaplookuptable is by default true (for this patch
> Series), this line enables it by default. If `pack.writebitmaplookuptable`
> Set to false, the proposed change in the `git_multi_pack_index_write_config`
> function disables this flag.

Aha, you're absolutely right. I missed the earlier hunk. Thanks for
pointing it out, this part looks fine to me.

Thanks,
Taylor
