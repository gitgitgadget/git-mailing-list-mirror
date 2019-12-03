Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62361C432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 17:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24582073B
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 17:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="Ye8fl9ex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfLCRd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 12:33:57 -0500
Received: from aibo.runbox.com ([91.220.196.211]:38702 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfLCRd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 12:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
         s=rbselector1; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date; bh=Ov/2djCzkFFAn8RS/fybfkL2TQ33QuUQmtvZVm+ZRTI=; b=
        Ye8fl9expjw3vyO4thtFJW9ZX8h4E/yX5CE1zrRqnEvkl1/DMKxTegv9coulCBL/oU86SEBeZKnXa
        qKKi51LxTlXgPp4sbirW894qawVw+n9Lj4KY+5KUJaWUucrBHWAQgt0KRvhChVeYYGmKSLnhdSV+4
        Sl4KKL/hVJO0Q6Dp5PZr8JPzZn8TzffrX5eV+LWadNTqsy6kxSgWOIIN4zHpTAHVYSrIWB4An5jjt
        pZZwUqrdKSddEuWjQzXrb9jiYx6jtbDA2tOla2UoBzVhGtNrW8F1N2/wKJEpg7lQhFO+fPrAynwSG
        2S2EUoKY2cq2oY4u/AGBZy+dFUX7T7UqeA==;
Received: from [10.9.9.203] (helo=mailfront21.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <cstolley@runbox.com>)
        id 1icC3c-0008I6-8W; Tue, 03 Dec 2019 18:33:52 +0100
Received: by mailfront21.runbox with esmtpsa  [Authenticated alias (602527)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1icC3N-00022d-TI; Tue, 03 Dec 2019 18:33:38 +0100
Date:   Tue, 3 Dec 2019 11:33:34 -0600
From:   Colin Stolley <cstolley@runbox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] packfile.c: speed up loading lots of packfiles.
Message-ID: <20191203173334.GA20027@owl.colinstolley.com>
References: <20191127222453.GA3765@owl.colinstolley.com>
 <20191202174035.GJ23183@szeder.dev>
 <20191202194231.GA10707@sigill.intra.peff.net>
 <xmqq7e3d75vk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7e3d75vk.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> Let me locally squash your fix in and credit you with helped-by
> footer in the amended log message.  Strictly speaking, this may

I'm also happy to provide a khash version if that is still desired,
perhaps as a separate patch.

Thanks for spotting that bug and providing a fix.
