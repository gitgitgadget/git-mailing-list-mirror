Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD52AC433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 20:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B543A20675
	for <git@archiver.kernel.org>; Thu, 14 May 2020 20:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589488412;
	bh=f3dXUm1Pq2DFF0OoZwt1HxfbsJffxdOnz69dAHOsMHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V4FtF5pokO0yuwLXVIpTbWODieVNUjupu8eJ6jJ0LNFYQjWsBcd2LhhgMNoDjSmfT
	 k6eO25hDVAMm5h0zzgzifRfqW+Do8IUsutbZUyHibQ8dDDMmOdcVko/imXXCxvIrLi
	 348ujTmP4E/sQDLpo2sR72d5PFMbrd3tjMwKdnsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgENUdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 16:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725975AbgENUdb (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 May 2020 16:33:31 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A785C061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 13:33:31 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id ee19so2360737qvb.11
        for <git@vger.kernel.org>; Thu, 14 May 2020 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=yx2sv5xLVrWSUFSuMMSVHi4nPp1y1hqvcxOPu4K1twk=;
        b=GuENKMbvrErh+z1kYDXpfyZvLCHngVsZHnRgIwyBarZEmy2mrAS0+sfPif2h25fOgQ
         ubqtkYdfNespmh26WaQm2qyq12AGgqf33qJ/fOQ05NvhhhR8OK00iulrQlD/+WilbBvj
         5z0fAwW4ozvgtBJz/C4IKC46b+/9JY3E7vFiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=yx2sv5xLVrWSUFSuMMSVHi4nPp1y1hqvcxOPu4K1twk=;
        b=pB1XlQVuKf0MkNhDfNpPqfyHS4wLuPIE8S6xIei4IJxeC8U79jZ4kk3whz8LcPROmp
         sy20qo1pjiF+FFrJ+H943ANnSVJ6Hw/IiBoVB5YTxWOx0dTDil+tTkGTAiMsvxgtZNSJ
         0XLKzfCqzGBUPEBsc/H4+VQcncdaEZ/HMf7sx8wJ+42+0TWwbi6JTtXa/q7oYr65QZJa
         yOyOvWkO/SeZDRmuQzqAaLQTgVNNjFw4azscp4E+YQlpqTRtqC3H6xialOzT28iO4CHZ
         RQ9FBWf0g7vFFpVGeaFOtCQ2yDVPZNl67E4+ef1+f2cFawoBEIwi22c5zZ6wM2+vgJml
         uIxQ==
X-Gm-Message-State: AOAM5327qO258D+6mLg5aRIESKE9uaExK6gkukYbywXZJGzPjKWkaOHI
        O4Qwn7MMILHZvv4i64nSYky/bpzvX5PKWQ==
X-Google-Smtp-Source: ABdhPJyjiFBecsrOh4UhQBUR9aNu3lc+1E7uyTCbRG4+yy39l89EH+ZWdUEB+Vy07WeyBzQLpAncCw==
X-Received: by 2002:a05:6214:18f3:: with SMTP id ep19mr272106qvb.45.1589488410203;
        Thu, 14 May 2020 13:33:30 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id c38sm200214qtk.26.2020.05.14.13.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 13:33:28 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Thu, 14 May 2020 16:33:26 -0400
Date:   Thu, 14 May 2020 16:33:26 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Caleb Gray <hey@calebgray.com>
Cc:     git@vger.kernel.org
Subject: Re: Add a "Flattened Cache" to `git --clone`?
Message-ID: <20200514203326.2aqxolq5u75jx64q@chatter.i7.local>
Mail-Followup-To: Caleb Gray <hey@calebgray.com>, git@vger.kernel.org
References: <CAGjfG9a-MSg7v6+wynR1gL0zoe+Kv8HZfR8oxe+a3r59cGhEeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGjfG9a-MSg7v6+wynR1gL0zoe+Kv8HZfR8oxe+a3r59cGhEeg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 07:34:08AM -0700, Caleb Gray wrote:
> I've done some searching around the Internet, mailing lists, and
> reached out in IRC a couple of days ago... and haven't found anyone
> else asking about a long-brewed contribution idea that I'd finally
> like to implement. First I wanted to run it by you guys, though, since
> this is my first time reaching out.
> 
> Assuming my idea doesn't contradict other best practices or standards
> already in place,  I'd like to transform the typical `git clone` flow
> from:
> 
>  Cloning into 'linux'...
>  remote: Enumerating objects: 4154, done.
>  remote: Counting objects: 100% (4154/4154), done.
>  remote: Compressing objects: 100% (2535/2535), done.
>  remote: Total 7344127 (delta 2564), reused 2167 (delta 1612),
> pack-reused 7339973
>  Receiving objects: 100% (7344127/7344127), 1.22 GiB | 8.51 MiB/s, done.
>  Resolving deltas: 100% (6180880/6180880), done.
> 
> To subsequent clones (until cache invalidated) using the "flattened
> cache" version (presumably built while fulfilling the first clone
> request above):
> 
>  Cloning into 'linux'...
>  Receiving cache: 100% (7344127/7344127), 1.22 GiB | 8.51 MiB/s, done.

I don't think it's a common workflow for someone to repeatedly clone 
linux.git. Automated processes like CI would be doing it, but they tend 
to blow away the local disk between jobs, so they are unlikely to 
benefit from any native git local cache for something like this (in 
fact, we recommend that people use clone.bundle files for their CI 
needs, as described here: 
https://www.kernel.org/best-way-to-do-linux-clones-for-your-ci.html).

I believe there's quite a bit of work being done by Gitlab folks to make 
it possible to offload more object fetching to lookaside-caches like 
CDN. Perhaps one of them can provide an update on how that is going.

-K
