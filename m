Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC41C83003
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 03:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D4162073E
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 03:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRlqx14l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgD3DNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726357AbgD3DNx (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 23:13:53 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8164C035494
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 20:13:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so2198283pfx.6
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 20:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6yYEl24wQvWOSZLj2UNOIkh23lfoAKhcEU7yQV4HYs4=;
        b=CRlqx14lEMz3Oou4OdaZoUS11NAafGH0iHMd4oGSGGgliEr21mQPqzCMwlAopFoEA4
         KAFbgk76sdUZHUUDpfE5tGMxHq3AhZk5SX+89WR4SePs4G1ymbPAuwlEsKTp7Hm4zL74
         iKO57NjhfK2AQi+5hGztkHeFhXx+p7ml1LwIMlggUHycnO3M6nSRn3FMF7a6SRPz5OJK
         mf7Q09gI05ft7ATqRcd8NOmUV8LNz11Wl4vaQ82PSWAlLZsVkSLkm9+OiGc9nhHZmwg6
         6LnY0s9GStPvdDiDRFvzQ62m3hBa5AhKu/YLihrcHe9C1IR7j/iCbH9Je71tPFLYKRk5
         PVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6yYEl24wQvWOSZLj2UNOIkh23lfoAKhcEU7yQV4HYs4=;
        b=RM1zhCtcBxuH91Yvfofs26hGgKfFRYlRGxakNlbr1ltMXh4E5KA7lXE9uKldMNYa5R
         MTHF7UB31tmpu+diHhMMTON3yrZOmU1LrKgdSCNb9tN7k4lGFnvknii5PJeZpMQcfvX+
         r2FVqwkl4rR5gXOUr/frjaDVibtLzUt8++/+KPTrVwM0f9Y3nw234NTemdNgHlAvex5O
         sn9mrdSpimtNipp9LFhmmhmna+6p+mR+FdY3L9BRLX5YSj91zMNnDcIV+INPjts4Ub+A
         VHMU3uDrBW4VRSVykG7P/AAipQWpDsMZ5XdVTuACggH93crxl/BVZ1L6kwEIL4IUMP0Y
         HINQ==
X-Gm-Message-State: AGi0PuYg0O3uw/iDn3SM/uGvcSpvGw92aJjE37v+Ro+sD4hFshFW98IA
        hlKv/RURzemQ7khmwl1gO4M=
X-Google-Smtp-Source: APiQypIsvvhX2gfJ2qLFGk5KLVbVh4LL/lwnlg5h3DTyEwCj119IzhbpsK4HFWSoT5Jr1VzyTiNevQ==
X-Received: by 2002:a63:6fce:: with SMTP id k197mr1280578pgc.431.1588216433407;
        Wed, 29 Apr 2020 20:13:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id i25sm2063698pfo.196.2020.04.29.20.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 20:13:52 -0700 (PDT)
Date:   Wed, 29 Apr 2020 20:13:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH 3/5] commit: move 'unregister_shallow' to 'shallow.h'
Message-ID: <20200430031350.GD115238@google.com>
References: <cover.1588199705.git.me@ttaylorr.com>
 <65ecfeaba56807926fbe532f94921c98298e50d5.1588199705.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65ecfeaba56807926fbe532f94921c98298e50d5.1588199705.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:

> In the last commit, we introduced a header for the functions defined in
> 'shallow.c'. There is one remaining shallow-related function in
> commit.c which should be moved, too. This patch moves that function.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  commit.c  | 13 -------------
>  shallow.c | 13 +++++++++++++
>  shallow.h |  1 +
>  3 files changed, 14 insertions(+), 13 deletions(-)

Yes, an obviously good thing to do.

Perhaps could be squashed with patch 1 (but also see my review of that
one).

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Should this take a "struct repository" parameter?
