Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB67FC433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 22:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C0C20758
	for <git@archiver.kernel.org>; Sun, 17 May 2020 22:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589753539;
	bh=Z8exrRijAnjbgBJC4DxhBeNfIrbhaeROY0o1GHd6ECQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A0XGWA5wpR4s5OgaIWgIhvDXIkmfeOl8wnuLwP8j+Dd8mzp/6hOdry3vg9craoamA
	 dG/YjrrsVPnfb/r4QuzakW566Lbiesve8rR537O5aO1IQu6yr67DuJ7TYAI4PRKhQL
	 F8scw6/Wlq5c5TvrUei8t+ZcR6mDEhvbR4MV2R/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgEQWMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 18:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgEQWMR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 18:12:17 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9402EC061A0C
        for <git@vger.kernel.org>; Sun, 17 May 2020 15:12:17 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l1so6620620qtp.6
        for <git@vger.kernel.org>; Sun, 17 May 2020 15:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=dV0EwgM0EANBcFfIFRyFuDZVzH2DxltzYw4LyyyM5rY=;
        b=f4F4+dgQQ4bjkIXA6EdUj9YKduRqE1SvHjZYVI66qWKh5OWTEbBsRuvHUge++G6DJn
         /aa8tr5iv9ini8e/UCaUA3njd78PPe+NSG1vIpLsHTZuBn/sSh4ZerAnXLC+9OamjEaN
         Rekpkqw6pityl0vRDQGSWyp6yGVYAZ9OcgFBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=dV0EwgM0EANBcFfIFRyFuDZVzH2DxltzYw4LyyyM5rY=;
        b=m4Qy6+GYGphK7C4ahaS7Zf0PoRiQnQATyfsf/LrUGAaxADc96E1TRv3FyAVikgRJxP
         DMx6SIMymiS2cR+jP59DxU0W+KQfb6dfGrhcyKvGOe4QZhTIpdF/ZcCo9RYh2xu/OaTm
         kNJG7ZsNoVvZiFtD1oDtaObdPXH5ed69AVvl+/KLHCVIaj1ydadw5fWBsPYe2U+Z5NAD
         NU8WOYU5IxW1tMA8/3YJ6DJfbOqk+IxG85l/K0SNWujC5PbY7Yvc38Ow65C2yvZ3qHIt
         Rf9GdvCuh8HMohnwqdM0J66lEgPrCRXmGQl4dfHZU66gxJIQfbAqyKWFTRDDAWG2SN6I
         Im7A==
X-Gm-Message-State: AOAM531vbloji9vVVUDkgbr4V+FSwuoSnzbq9r8RHn/MwcrRcf5oXU8k
        wawOc7EZK6w/26GH2eANELKDzA==
X-Google-Smtp-Source: ABdhPJyKU9s5fDNiYwEJIRvg/PPpillsGphL7Mw2hIxrFXYsknRK0L67Ip+iPJzGZgF+bdHlJHyi5A==
X-Received: by 2002:ac8:1af3:: with SMTP id h48mr13070608qtk.371.1589753536553;
        Sun, 17 May 2020 15:12:16 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id e26sm6762649qka.85.2020.05.17.15.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 15:12:15 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Sun, 17 May 2020 18:12:13 -0400
Date:   Sun, 17 May 2020 18:12:13 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Eric Wong <e@yhbt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Caleb Gray <hey@calebgray.com>,
        git@vger.kernel.org
Subject: Re: Add a "Flattened Cache" to `git --clone`?
Message-ID: <20200517221213.l3q2creiddpylbpm@chatter.i7.local>
Mail-Followup-To: Eric Wong <e@yhbt.net>,
        Junio C Hamano <gitster@pobox.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Caleb Gray <hey@calebgray.com>,
        git@vger.kernel.org
References: <CAGjfG9a-MSg7v6+wynR1gL0zoe+Kv8HZfR8oxe+a3r59cGhEeg@mail.gmail.com>
 <20200514203326.2aqxolq5u75jx64q@chatter.i7.local>
 <20200514210501.GY1596452@mit.edu>
 <20200514211040.a7hrirdzgkphx3la@chatter.i7.local>
 <xmqqr1vmp5wf.fsf@gitster.c.googlers.com>
 <20200514214404.bcbjskgi52bwedlh@chatter.i7.local>
 <20200515214257.GA21855@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515214257.GA21855@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 09:42:57PM +0000, Eric Wong wrote:
> That said, I'm not sure if any client-side caching proxies can
> MITM HTTPS and save bandwidth with HTTPS everywhere, nowadays.
> I seem to recall polipo being abandoned because of HTTPS.
> Maybe there's a caching HTTPS MITM proxy out there...

Right, this can't operate as a transparent proxy. However, it could work 
in combination with insteadOf on the client, e.g., if the repo URL is 
https://example.com/foo/bar.git, the CI builder could set a global 
insteadOf in /etc/gitconfig before kicking off the job:

[url http://local.proxy]
  insteadOf = https://example.com

This way CI job maintainers could continue to use canonical repo URLs, 
but actual requests would go out to the local proxy and be cached.

-K
