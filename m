Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98F691F623
	for <e@80x24.org>; Thu, 29 Jun 2017 19:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753095AbdF2TZQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 15:25:16 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33797 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752966AbdF2TZP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 15:25:15 -0400
Received: by mail-pg0-f53.google.com with SMTP id t186so52662911pgb.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 12:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pAnvmz4nqYGIu5ALgTQpIYWzvlrKb3AcqMiTTMF6dTs=;
        b=da7VOKsLraCnm7zzl8SoibLJf1sG6XMTR6EPhzzO5MCP8VRriEw3yQDWOSz7BDjFim
         nzIcA2LembtCimN8yPA+XkJHLy0/glqX4GBM8CsbuG/MKp+5q2n4FAFCA0RFS9JklQIQ
         5QyyAa79Pb9NWHOt2sE/rLOp9f73m2ZnhLaS51CcVA+Z+TRo75LcIodbxP6ZtaPvvrxs
         5srOLYxsDk1Ljz9iby978WnXLvl4IcCTYlOxmkMceYH7uJopErQoeyBEiDAcjb8gPEk6
         6jgHYKuy9eJ5jtk6QxyRwbzAUUrgpEO9+uKgxfAWjREhbeWMtBE6uzK50ZRFizsrKwOA
         XJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pAnvmz4nqYGIu5ALgTQpIYWzvlrKb3AcqMiTTMF6dTs=;
        b=Gsnd1ACdkx+KKG59qGeJXU6t52a6jE5x0pbrUhPZQZqbe/0rsQFeuglalazkBGVDgK
         Jk40G17H1svVYxC0PyOxavdGjzQUudbzQHldTZdKSjPUJ9yvlbBtbYp/GBaPMTc50eth
         wf8NQjCPrLaDCBtKwWeoEHP8k5MBO4mONsBdo9PxfQul7mA+1n58U6bkVLLqbUrhPLiC
         OgfZPI0BD8AXdP6Ba4DSxXo/OrvDlTKw5pn/l7ZPNoE/nbGynZeUxQcrwQ9Wb5FXvJf2
         HxCBDKUri9SvQF7EmsWqbk36UFG0r+Lq709v9P9RCa03C+o9jLGZxEbL3+eT1p6SC4AV
         uWQQ==
X-Gm-Message-State: AKS2vOw5hetYrlzCvzNV0LC0pbpJR/Y0DZhgrI3SKDujfSi3vqBEQbKo
        kvMLFN+ZDyAEIw==
X-Received: by 10.84.224.11 with SMTP id r11mr20206036plj.267.1498764314715;
        Thu, 29 Jun 2017 12:25:14 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:38f0:2d30:90af:519d])
        by smtp.gmail.com with ESMTPSA id v9sm9051310pge.26.2017.06.29.12.25.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 12:25:13 -0700 (PDT)
Date:   Thu, 29 Jun 2017 12:24:41 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: RFC: Missing blob hook might be invoked infinitely recursively
Message-ID: <20170629192441.GA68015@aiede.mtv.corp.google.com>
References: <20170629114830.39dc2161@twelve2.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170629114830.39dc2161@twelve2.svl.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> Suppose you have missing blob AB12 and CD34 that you now need, so
> fetch-blob is invoked. It sends the literals AB12 and CD34 to a new
> server endpoint and obtains a packfile, which it then pipes through "git
> index-pack". The issue is that "git index-pack" wants to try to access
> AB12 and CD34 in the local repo in order to do a SHA-1 collision check,
> and therefore fetch-blob is invoked once again, creating infinite
> recursion.
[...]
> 2. Add support for an environment variable to Git that suppresses access
> to the missing blob manifest, in effect, suppressing invocation of the
> hook. This allows anyone (the person configuring Git or the hook writer)
> to suppress this access, although they might need in-depth knowledge to
> know whether the hook is meant to be run with such access suppressed or
> required.

Small tweak: what if Git itself sets that environment variable when
invoking the hook?  A fetch-blob hook author can then explicitly unset
the environment variable to request recursion if they need it.

I should credit Shawn Pearce for saying this a little more clearly
offline a moment ago.

Thanks,
Jonathan
