Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4576A2018E
	for <e@80x24.org>; Tue, 30 Aug 2016 05:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbcH3Fd1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 01:33:27 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:44796 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751865AbcH3Fd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 01:33:27 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3sNcch11xpz5tlC;
        Tue, 30 Aug 2016 07:33:24 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 749395264;
        Tue, 30 Aug 2016 07:33:23 +0200 (CEST)
Subject: Re: [PATCH 05/22] sequencer: allow the sequencer to take custody of
 malloc()ed data
To:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <e4e7eab3d0610faa9d3173a585902e50128d8e15.1472457609.git.johannes.schindelin@gmx.de>
 <733a899a-470b-79b3-b059-b38313a7057d@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e0a00df7-d4e7-3809-ae93-b29b1f1c7ea4@kdbg.org>
Date:   Tue, 30 Aug 2016 07:33:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <733a899a-470b-79b3-b059-b38313a7057d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.08.2016 um 23:59 schrieb Jakub Narębski:
> W dniu 29.08.2016 o 10:04, Johannes Schindelin pisze:
>> -#define REPLAY_OPTS_INIT { -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, 0, NULL }
>> +#define REPLAY_OPTS_INIT { -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, 0 }
>
> Nb. it is a pity that we cannot use named initializers for structs,
> so called designated inits.  It would make this macro more readable.

It is actually pointless to add the 0's and NULL's here. This should  be 
sufficient:

#define REPLAY_OPTS_INIT { -1, -1 }

because initialization with 0 (or NULL) is the default for any omitted 
members.

-- Hannes

