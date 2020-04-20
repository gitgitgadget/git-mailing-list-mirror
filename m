Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4192DC38A30
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 17:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1976920CC7
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 17:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587402190;
	bh=FEXfGxtN3+dIhInN8OhdBozonWrneflPtZlXV5e8mFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0iUQRHZ0uxipmRdvPMzzKi/elL4hqMWBrk8t7pNucu3I760S9sjP0DiQgVkl8tqhs
	 p2em3BTs0YjiqU0diNiVVUIN7DbEIPTk5oDgMpnSVaYtra4Wxu/faQgH4RcbvVC/c9
	 Gxz6XfC0aYG89COVSHo7XWiqjnLEq0pVrtKHF4qE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgDTRDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbgDTRDI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 13:03:08 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FDBC061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 10:03:08 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id w145so8600558lff.3
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 10:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=XlTK+o77jgDFynrQS34eXeRoq2mrIp1dBEojyKxA21s=;
        b=GqZjUqOpCn+Dw7sZr+WR57lDwh90TPIOVROgkRqDFF/+0G3pUXXLqgcrI1DB6pzOu2
         PJf3rtnu3UVwx53xJZ6baQdWeYdYftfaVG2obJ655EaERUzJyUsSCjddIztlwhtgzT4Y
         qRtiUT+BCqz1x+0o5wqljGx8jI6cffVhyqaWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=XlTK+o77jgDFynrQS34eXeRoq2mrIp1dBEojyKxA21s=;
        b=VnWazsnCeALBmZlvJWpwcasOvj0bseAn6Cxu6H+f6PgZ2BV+3D9bpQLNlZZ9QPmkJp
         D4/5RNxQkBoUOBjGUWVV21ANs4kzyDTbu5wcknYJicmg/nH35DXUJ/eQ0LHuGAavxNCA
         mIcWaZw6fgFt5VVlWmYnkkyFoDkRW2moL4Es2t3gx4Laj4358WomzSBKvEIHCoUkVNuz
         kyGPYIi5t9aPvA2OrnmB/X2MAtptBw/eMjjz/ROSHLB8Sf9ztWDiHAgE+Gpb/U5BtAxs
         sE/T1uF7BYEVQdZwrm3N6AT7mTdNofyIOHZIxfpfKufKwgcSzJzDBbJYUAaAczALxj4/
         egzw==
X-Gm-Message-State: AGi0PuYpuS/QiUVWEAhcfdvGdP8r2CSJ4DNcGQhtsz+d1wUKB4I2waa5
        lQXS5j4GkzpXxPzEyuUJVYwJxQ==
X-Google-Smtp-Source: APiQypK5b4jayFVsX0peNufDgKRLkmFvJHudRlT0kW/8yH9Eq9UUSuu7Op1oHbdwlErU5j4lwFHKxg==
X-Received: by 2002:a19:cb41:: with SMTP id b62mr11241037lfg.21.1587402186939;
        Mon, 20 Apr 2020 10:03:06 -0700 (PDT)
Received: from chatter.i7.local (tor-exit1-readme.dfri.se. [171.25.193.77])
        by smtp.gmail.com with ESMTPSA id j15sm38438lji.18.2020.04.20.10.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 10:03:05 -0700 (PDT)
Date:   Mon, 20 Apr 2020 13:03:01 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug in 2.26: git-fetch fetching too many objects?
Message-ID: <20200420170301.h65vkk36avnud7z3@chatter.i7.local>
Mail-Followup-To: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
        git@vger.kernel.org
References: <878siqxiu0.wl-ashutosh.dixit@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878siqxiu0.wl-ashutosh.dixit@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 20, 2020 at 08:44:39AM -0700, Dixit, Ashutosh wrote:
> I am seeing a strange behavior in git-fetch in 2.26. I frequently fetch
> from a couple of linux kernel remotes (so you will have an idea how big the
> repo is). I have a different system with 2.20 on which I never see a
> problem.
> 
> So let us say I fetch with 2.20 and it fetches say 20,000 objects. However
> with 2.26 it starts fetching millions of objects, objects which are already
> present locally. I don't know yet if this happens each time or only once in
> a while, I have seen it happen twice, will keep an eye out for this.
> 
> If you open a bug please let me know and I can update it with my
> findings. Unless it is a known issue, perhaps already fixed?

It's a known issue with protocol v2, but nobody's been able to properly 
reproduce it in order to debug. If you can reliably make it reoccur, 
then please make a copy of your local tree and share with this list, 
together with your gitconfig and the remote you're pulling.

Setting protocol.version=1 should fix it, but if you are willing to help 
troubleshoot it, a bunch of people will be super thankful to you for 
that, as it affects quite a number of kernel developers.

-K
