Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F998C433E0
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF6E2075D
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594672474;
	bh=6LJ2Ode5qgEO+7Iog2rA45n75wLITvvBfvVD0dPIVTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cSdByIAh0pGzDIJtcjOXljvkBGYOHZkj+D1Dmm5c2v1hA//NiuWYCVY3mnFQXhXjx
	 5VLlV61bgLWOJCeuvs8jvvUubmU9JdTTtyihoryB5PKJYQGBQQwwEG1ZYusB8e6JiM
	 fYv+b4MpSQIMLE7S/k3cVJf6izWHtFEthaqBSyMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgGMUed (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgGMUec (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 16:34:32 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26F5C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 13:34:32 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id m9so6445616qvx.5
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 13:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Em7dZjC8dZEdi5l2Fe5w8XXsd69fmverUCf0ODGIB8=;
        b=byRMJhD0AxCr1rrLTcuTo06hZ/V5bfwhuMVb0SbUfkHF6huMAmNOGc7IZ4ubwdkM7L
         mleq3fYr57zy0+uLr8N3y7oEull70od88tPQEkUTpnGfghMG8OEQwhMEHTBznzkupUxb
         2fURKDpGtF534xFUMreW9quLA+MUq+vSh0gm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9Em7dZjC8dZEdi5l2Fe5w8XXsd69fmverUCf0ODGIB8=;
        b=qBxwuCYcFrUwudVtDWiBEeHuUJ9CTSXt/H2x/CLCdzmylRqb+rGZwMm3slwOfOWU2/
         rJV4Ck5Wabf4fbaNSooD1A965CRoOper/86uYFYtaczlj7ifmFqeyfNHZoROD+ZtS1CX
         Bf3Hrkg6AlEIo2Wl95pRZ2f2Kpv3s+FVAC/x3CLAQh4MG25VMNFiUWEqjaD5wM0IHLJW
         jz0b3UUJ+qrNhfolFgIMyvXwMT5EvWuvMac0tdVlSk/qMwAyZCEgIokfloFEoClH1rnM
         /Enb7wOIhrbdWglXtQwSP3xCuyncdQDKylNNwjMeQ5IcEZ0BExUK6VIpayz84IwwNnus
         07Tg==
X-Gm-Message-State: AOAM5305jBJ4oUEEq8xa7r1VcsPpbGK0aPVHlbdmsegBdkfPli5Hqk6n
        u+8qPtMe4R10YOqLL7fTnyzLpQ==
X-Google-Smtp-Source: ABdhPJzNHEEgslEDKw+qOsAgp04tek3ZTJwDRPn6hdXQURwpLoSBqSCVW8iXe3HQmgBp6SqlW8zTBw==
X-Received: by 2002:ad4:434c:: with SMTP id q12mr1221197qvs.203.1594672471319;
        Mon, 13 Jul 2020 13:34:31 -0700 (PDT)
Received: from chatter.i7.local ([87.101.92.156])
        by smtp.gmail.com with ESMTPSA id o5sm20955371qtb.26.2020.07.13.13.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 13:34:30 -0700 (PDT)
Date:   Mon, 13 Jul 2020 16:34:27 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org
Subject: Re: FETCH_HEAD files and mirrored repos
Message-ID: <20200713203427.apajagayqx4gpadf@chatter.i7.local>
Mail-Followup-To: Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org
References: <xmqqimetrcay.fsf@gitster.c.googlers.com>
 <20200711211915.h5bdgmbkisyc23m3@chatter.i7.local>
 <xmqqblkkr63u.fsf@gitster.c.googlers.com>
 <20200712202502.x4p2c7rf6ctflt5g@chatter.i7.local>
 <xmqqr1tgpibi.fsf@gitster.c.googlers.com>
 <79a56e7b-3c31-80c0-6a8b-807dcb4d5af3@kdbg.org>
 <xmqqk0z7nxs7.fsf@gitster.c.googlers.com>
 <20200713200049.6a22nek4xckwtpt6@chatter.i7.local>
 <xmqqtuybmba1.fsf@gitster.c.googlers.com>
 <20200713202211.GA2355588@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200713202211.GA2355588@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 13, 2020 at 04:22:11PM -0400, Jeff King wrote:
> I occasionally use FETCH_HEAD for such things. If we were to stop
> writing it automatically, I think the key thing to notice is whether the
> result was actually stored anywhere else. Or more accurately, whether
> the user asked for any refspecs on the command line (since we'd still
> update tracking refs in some cases).
> 
> If I do:
> 
>   git fetch
> 
> or:
> 
>   git fetch origin refs/heads/foo:refs/heads/foo
> 
> then I probably don't care about FETCH_HEAD. But if I do:
> 
>   git fetch origin refs/heads/foo
> 
> then I'm probably interested in picking the result out of FETCH_HEAD.

I think adding all this logic is not worth the effort. For vast numbers 
of people who aren't running Android mirrors, FETCH_HEAD is only going 
to be a few KB in size, so they won't benefit from this change at all.

I'm happy with just an option that I have to enable to turn off writing 
FETCH_HEAD.

-K
