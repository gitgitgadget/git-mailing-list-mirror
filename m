Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF08E1F991
	for <e@80x24.org>; Wed,  9 Aug 2017 18:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbdHISDM (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 14:03:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:57056 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751944AbdHISDL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 14:03:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06939AF01;
        Wed,  9 Aug 2017 18:03:10 +0000 (UTC)
Subject: Re: [PATCH 2/4] http: drop support for curl < 7.16.0
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <20170809120157.il4ktf75wscqoyic@sigill.intra.peff.net>
 <xmqq1sok7i82.fsf@gitster.mtv.corp.google.com>
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Message-ID: <38dfdc54-65ea-694a-4b72-fe0006a008cf@suse.de>
Date:   Wed, 9 Aug 2017 20:03:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0
MIME-Version: 1.0
In-Reply-To: <xmqq1sok7i82.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 09/08/2017 à 19:40, Junio C Hamano a écrit :
> Jeff King <peff@peff.net> writes:
>
>> -#if LIBCURL_VERSION_NUM >= 0x071700
>> -/* Use CURLOPT_KEYPASSWD as is */
>> -#elif LIBCURL_VERSION_NUM >= 0x070903
>> -#define CURLOPT_KEYPASSWD CURLOPT_SSLKEYPASSWD
>> -#else
>> -#define CURLOPT_KEYPASSWD CURLOPT_SSLCERTPASSWD
>> -#endif
>> -
> This part I am not sure.  Don't we still need to substitute
> CURLOPT_KEYPASSWD with CURLOPT_SSLKEYPASSWD for versions below
> 071700, e.g. 071000 which is 7.16.0?
According to the documentation:

https://curl.haxx.se/libcurl/c/CURLOPT_KEYPASSWD.html
This option was known as CURLOPT_SSLKEYPASSWD up to 7.16.4 and CURLOPT_SSLCERTPASSWD up to 7.9.2.


So the patch breaks things (broken for 7.16.[0-4]). But the series does not as the next patch ensure at least 7.19.4


