Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 234091F453
	for <e@80x24.org>; Mon,  4 Feb 2019 21:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfBDVNR (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 16:13:17 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:30632 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbfBDVNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 16:13:16 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43tgRG47Hhz5tlC;
        Mon,  4 Feb 2019 22:13:14 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C66D430F;
        Mon,  4 Feb 2019 22:13:13 +0100 (CET)
Subject: Re: [PATCH ps/stash-in-c] strbuf_vinsertf: provide the correct buffer
 size to vsnprintf
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <896ae9dd-7ac3-182e-6692-c09bc4864de0@kdbg.org>
 <5d521649-0b21-04e3-3182-e8714fcbfeac@kdbg.org>
 <nycvar.QRO.7.76.6.1902041135320.41@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ea7b1875-1a23-e4e8-e30e-5b769d282323@kdbg.org>
Date:   Mon, 4 Feb 2019 22:13:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1902041135320.41@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.02.19 um 11:38 schrieb Johannes Schindelin:
> On Mon, 4 Feb 2019, Johannes Sixt wrote:
> 
>> Am 03.02.19 um 17:51 schrieb Johannes Sixt:
>>> strbuf_vinsertf inserts a formatted string in the middle of an existing
>>> strbuf value.
>>
>> Quite frankly, this is a really unusual operation, and I'd prefer to get
>> rid of it. There is only one call, and it looks like it only wants to be
>> lazy and save one strbuf variable.
> 
> The only reason why there are not more callers is that I did not convert
> any of the appropriate places. We have quite a few places where we
> allocate a new strbuf for the sole purpose of formatting something that is
> then inserted into an already existing strbuf (possibly extending the
> buffer, which might require a move of the buffer just because that
> temporary strbuf is in the way).
> 
> It does not sound like good practice to me to allocate things left and
> right, only to reallocate something that was just allocated anyway and to
> copy things into that and then release things left and right.

I prefer separation of concerns at the expense of a bit of resource
consumption that is not measurable. But that is the only argument that I
have.

-- Hannes
