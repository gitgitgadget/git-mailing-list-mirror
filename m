Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 458D51F437
	for <e@80x24.org>; Thu, 26 Jan 2017 06:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbdAZGj7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 01:39:59 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:50079 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751605AbdAZGj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 01:39:59 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3v8C2h2s9Gz5tlj;
        Thu, 26 Jan 2017 07:39:56 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 8CFDC1D0D;
        Thu, 26 Jan 2017 07:39:55 +0100 (CET)
Subject: Re: Fixing the warning about warning(""); was: Re: [PATCH]
 difftool.c: mark a file-local symbol with static
To:     Jeff King <peff@peff.net>
References: <20161201040234.3rnuttitneweedn5@sigill.intra.peff.net>
 <xmqq60n3bjel.fsf@gitster.mtv.corp.google.com>
 <20161201185056.eso5rhec7izlbywa@sigill.intra.peff.net>
 <20170122052608.tpr5pihfgafhoynj@gmail.com>
 <20170124142346.u3d7l6772mtkgpcf@sigill.intra.peff.net>
 <xmqqlgu0ceia.fsf@gitster.mtv.corp.google.com>
 <20170124230500.h3fasbvutjkkke5h@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701251135090.3469@virtualbox>
 <20170125183542.pe5qolexqqx6jhsi@sigill.intra.peff.net>
 <xmqq7f5iakxw.fsf@gitster.mtv.corp.google.com>
 <20170125220101.et67ebkumsqosaku@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <546179e0-1d6e-86f7-00cf-e13218b76de1@kdbg.org>
Date:   Thu, 26 Jan 2017 07:39:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170125220101.et67ebkumsqosaku@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.01.2017 um 23:01 schrieb Jeff King:
> +#pragma GCC diagnostic ignored "-Wformat-zero-length"

Last time I used #pragma GCC in a cross-platform project, it triggered 
an "unknown pragma" warning for MSVC. (It was the C++ compiler, I don't 
know if the C compiler would also warn.) It would have to be spelled 
like this:

#pragma warning(disable: 4068)   /* MSVC: unknown pragma */
#pragma GCC diagnostic ignored "-Wformat-zero-length"

Dscho mentioned that he's compiling with MSVC. It would do him a favor.

-- Hannes

