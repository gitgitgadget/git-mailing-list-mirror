Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54884C2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 23:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 548252225E
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 23:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=schrab.com header.i=@schrab.com header.b="b5LH2KfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgKBXOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 18:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgKBXOD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 18:14:03 -0500
X-Greylist: delayed 530 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 Nov 2020 15:14:03 PST
Received: from pug.qqx.org (pug.qqx.org [IPv6:2600:3c02:e000:5::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC6CC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 15:14:03 -0800 (PST)
Received: by pug.qqx.org (Postfix, from userid 1000)
        id 5B39E1F218; Mon,  2 Nov 2020 18:05:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schrab.com; s=mail;
        t=1604358309; bh=DHBu5y1CtooeLjzYUeydYi54+TPe+TD/ougg6/ICO9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b5LH2KfSRvQvUGrbRfkcQzEMN+aFkCcSfBdv6pAKBLOIxe/UN10AFknjOMgpeZBzs
         kWgZRcLaWWzS2EkYGmAo/918DvY3ITKF5l/04pR5MXGf61rSiHUK9Jbb0/nAmvJQnZ
         PtO4N6olImUtJiTZf+B34J2pGFlipdZP4DP7hWPWbZZurC26DbRw6+ULMPB0dO707n
         96BXDaMnRb8CcrpJeZkiLbwer0BDz7Q76PXbe37Hy1luWwd8E0+hQoX9vpc3rwOmeX
         yJiuARkOrafsle0wfokm+o4sHaYqvkzSMYOABNaHENHpB3q1hkXKB23O7Cyf8PzFXd
         kB8YvwPFKQm0w==
Date:   Mon, 2 Nov 2020 18:05:09 -0500
From:   Aaron Schrab <aaron@schrab.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Git <git@vger.kernel.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
Message-ID: <X6CQpfuhRkAwmMou@pug.qqx.org>
Mail-Followup-To: Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>, Git <git@vger.kernel.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
References: <xmqqk0vbbep5.fsf@gitster.c.googlers.com>
 <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
 <xmqqr1pj9rf0.fsf@gitster.c.googlers.com>
 <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
 <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de>
 <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
 <xmqqeelh7y23.fsf@gitster.c.googlers.com>
 <010c6222-4365-7446-a666-333ac7b4d415@haller-berlin.de>
 <xmqqh7qb3a3r.fsf@gitster.c.googlers.com>
 <CAMP44s3Tx1DdzD3fAOA+_3fLMK6Ew9GQAJWiRoA2KR156jiZBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMP44s3Tx1DdzD3fAOA+_3fLMK6Ew9GQAJWiRoA2KR156jiZBg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 14:29 -0600 02 Nov 2020, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>So the two options are:
>
>1. Use the script in contrib/ (or git-completion)
>2. Use Oh-My-Zsh and enable the "gitfast" plugin
>
>In my opinion to use the Zsh default completion is not an option.
>
>Which is why I think distributions should package the Git Zsh
>completion by default (like Hombrew does), which will happen more
>easily if Git graduated those scripts and installed them by default.

The option that you consider to be invalid is definitely *my* preferred 
option. That Homebrew's git package installs the completion in a way 
that overrides that from the zsh package was a source of continual 
annoyance for me until I put in a long-term workaround for that (I had 
just been removing the symlink every time I noticed that it had been 
created by a new install of the git package).

While the completion provided by git.git may be faster, the one from zsh 
is fast enough on the repositories that I generally work with.  At least 
with my configuration and the completion code currently shipped by 
Homobrew's git package there are at least a couple of things that seem 
to be quite broken.

The one that generally caused me to notice that the wrong completion 
code was being used is that it doesn't provide completion for creating 
local branches to based off of remote ones; I'd previously thought that 
was just a missing feature, but looking into it a bit more now it looks 
like that **should** happen as long as I don't set 
GIT_COMPLETION_CHECKOUT_NO_GUESS=1.

The other thing that seems to not work with the completion from git.git 
is completion of single-dash options. Although that may be more of a 
missing feature rather than something that's broken. Since there isn't 
any description for long options, I'd guess there wouldn't be for short 
options either; in which case there isn't really any point to trying to 
offer completion for those. But, having additional descriptions for 
options is one of my favorite features of zsh completion.
