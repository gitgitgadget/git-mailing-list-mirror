Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 805081F859
	for <e@80x24.org>; Wed, 17 Aug 2016 06:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408AbcHQGFU (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 02:05:20 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:29634 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753071AbcHQGFS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 02:05:18 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3sDdxR661Jz5tlZ;
	Wed, 17 Aug 2016 08:05:15 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 4CB32303C;
	Wed, 17 Aug 2016 08:05:15 +0200 (CEST)
Subject: Re: git-mergetool reverse file ordering
To:	David Aguilar <davvid@gmail.com>
References: <CAD8hE_yzNZDPkxRy8s4Fy2_dZN5ppWzLM_2xc01C-VAdR1Pj_g@mail.gmail.com>
 <20160814034221.GB21057@gmail.com>
 <20160814103801.tpixnskdsf5ycj66@john.keeping.me.uk>
 <CAD8hE_xR2mB3=_oot9cWxmFy7z4oBhjABNOo3aJKN=bOw5ybzQ@mail.gmail.com>
 <20160817012554.GA12991@gmail.com>
Cc:	Luis Gutierrez <luisgutz@gmail.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <18a1ef52-1c5b-4f0a-5da2-777e816a1e3e@kdbg.org>
Date:	Wed, 17 Aug 2016 08:05:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <20160817012554.GA12991@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 17.08.2016 um 03:25 schrieb David Aguilar:
> Hmm, I do like the idea of reusing the diff orderFile, but a
> mechanism for sorting arbitrary inputs based on the orderFile
> isn't currently exposed in a way that mergetool could use it.

Instead of using 'git ls-files -u | sed ... | sort -u' you could use

   git diff-files --name-status -O... | sed -ne '/^U/s/^..//p'

> But, that sort is honestly kinda crude.  It can't implement the
> interesting case where we want bar.h to sort before bar.c but
> not foo.h.
>
> If we did the sort option, we could have both.

I don't think that we need a new filter when the diff machinery is 
capable of re-ordering files. We should enhance the diff machinery instead.

-- Hannes

