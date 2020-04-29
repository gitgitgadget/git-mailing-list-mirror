Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1545EC83001
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 02:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B623B20737
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 02:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (768-bit key) header.d=mad-scientist.us header.i=@mad-scientist.us header.b="ZtxzFogQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgD2Cdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 22:33:43 -0400
Received: from gateway20.websitewelcome.com ([192.185.64.36]:32571 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726345AbgD2Cdn (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 22:33:43 -0400
X-Greylist: delayed 1501 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Apr 2020 22:33:42 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 3025A400C3A64
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 19:29:29 -0500 (CDT)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with SMTP
        id TboTj6DYFAGTXTboTjOmrk; Tue, 28 Apr 2020 20:47:01 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3QmUBFxU/FKTPJZvuDRwLPZeoZGt9TSKC1JzjcGF/9M=; b=ZtxzFogQYoWBZB3c8gB4lFZLpu
        ++oKgJozSwEdOSPn2NZGSmn5Oun/iA+2FJf87SaFSzn9IuGOEqaf2AkOgMtt1TYBFawXg8R928VcR
        pxsa+D0UXAgE54kprv/cDFeop;
Received: from pool-98-118-0-140.bstnma.fios.verizon.net ([98.118.0.140]:49498 helo=pdslaptop.home)
        by box5922.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <paul@mad-scientist.net>)
        id 1jTboT-0014kI-Fv; Tue, 28 Apr 2020 19:47:01 -0600
Message-ID: <16bdb22d9085876f30735a25c1edc2302e008e60.camel@mad-scientist.net>
Subject: Re: Git configure with static curl is failing
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Date:   Tue, 28 Apr 2020 21:47:00 -0400
In-Reply-To: <20200426231410.GA1702090@coredump.intra.peff.net>
References: <9d9fe8376e47a9f5330cd644c76d96987fc67c57.camel@mad-scientist.net>
         <20200426194729.GD6421@camp.crustytoothpaste.net>
         <20200426231410.GA1702090@coredump.intra.peff.net>
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5922.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 98.118.0.140
X-Source-L: No
X-Exim-ID: 1jTboT-0014kI-Fv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-98-118-0-140.bstnma.fios.verizon.net (pdslaptop.home) [98.118.0.140]:49498
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 2
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2020-04-26 at 19:14 -0400, Jeff King wrote:
> Usually, yes, though it doesn't use `curl-config --cflags` properly.
> See the series at [1].

Heh.  Some aspects of that thread look familiar :).

Yes, adding 'NO_CURL= CURLDIR=/path/to/curl' to the make line to force
it did fix the problem in my environment.


FWIW, not only is the version of GNU make shipped with MacOS very old
and apparently never to be updated, but it has been reported that there
are bugs in it that don't appear even in the vanilla version of GNU
make 3.81.  There may come a point where continuing to support that
older version won't be worth it...

