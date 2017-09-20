Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0936B20A2C
	for <e@80x24.org>; Wed, 20 Sep 2017 16:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbdITQ25 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 12:28:57 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:37400 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751821AbdITQ25 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 12:28:57 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3xy4tt3gQvz1qwwf;
        Wed, 20 Sep 2017 18:28:54 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3xy4tt1qjLz1r0ws;
        Wed, 20 Sep 2017 18:28:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id gIzIvnzb49DP; Wed, 20 Sep 2017 18:28:53 +0200 (CEST)
X-Auth-Info: xbXjzXsJ3sF2aC/CIhaVizCt5FSE18RSJvScUrDRzC1kSEy2y21WCR8Tf88pG+rX
Received: from igel.home (ppp-88-217-17-201.dynamic.mnet-online.de [88.217.17.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 20 Sep 2017 18:28:53 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 1A7D72C451B; Wed, 20 Sep 2017 18:28:53 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] for_each_string_list_item: avoid undefined behavior for empty list
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
        <20170915184323.GU27425@aiede.mtv.corp.google.com>
        <b8951886-feab-a87a-9683-3c155cfa98a8@alum.mit.edu>
        <b03c7b09-853f-a2ed-f73e-7d946c90cedb@gmail.com>
        <20170920023008.GB126984@aiede.mtv.corp.google.com>
        <xmqqd16mowig.fsf@gitster.mtv.corp.google.com>
        <20170920052705.GC126984@aiede.mtv.corp.google.com>
X-Yow:  Do you guys know we just passed thru a BLACK HOLE in space?
Date:   Wed, 20 Sep 2017 18:28:53 +0200
In-Reply-To: <20170920052705.GC126984@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 19 Sep 2017 22:27:05 -0700")
Message-ID: <87vakd2v22.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sep 19 2017, Jonathan Nieder <jrnieder@gmail.com> wrote:

> B. #define for_each_string_list_item(item, list) \
> 	if (list->items) \
> 		for (item = ...; ...; ... )
>
>    This breaks a caller like
> 	if (foo)
> 		for_each_string_list_item(item, list)
> 			...
> 	else
> 		...
>
>    making it a non-starter.

That can be fixed with a dangling else.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
