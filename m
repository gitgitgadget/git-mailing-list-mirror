Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40A8A1FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 16:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753481AbdDFQdz (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 12:33:55 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:46752 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbdDFQdy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 12:33:54 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3vzSvh0ybjz5tlH;
        Thu,  6 Apr 2017 18:33:51 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 5007C42B6;
        Thu,  6 Apr 2017 18:33:51 +0200 (CEST)
Subject: Re: [PATCH v3 1/2] Fix nonnull errors reported by UBSAN with GCC 7.
To:     =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
References: <295981e7-d2e9-d3db-e32d-8dd80ca47136@suse.cz>
 <20170406083425.7psdmrploxar3h6v@sigill.intra.peff.net>
 <998bf391-7fc5-8329-db58-ef0f24517707@suse.cz>
 <33c63fb9-281c-8fd2-66e7-b85f62f4f447@web.de>
 <8555c61f-2617-eec8-6dbe-87c79c6ca302@suse.cz>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <587b0cb9-bd66-ddf7-5cca-023df3470883@kdbg.org>
Date:   Thu, 6 Apr 2017 18:33:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <8555c61f-2617-eec8-6dbe-87c79c6ca302@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.04.2017 um 17:42 schrieb Martin Liška:
> +static inline void *sane_memmove(void *dest, const void *src, size_t n)
> +{
> +	if (n > 0)
> +		return memmove(dest, src, n);
> +	else
> +		return dest;
> +}

Huh? memmove with n == 0 is well-defined. This wrapper is pointless.

-- Hannes

