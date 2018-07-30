Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EB011F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbeG3R1M (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:27:12 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:55937 "EHLO
        mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbeG3R1M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:27:12 -0400
Received: from [192.168.1.3] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
        by mail.gooeysoftware.com (Postfix) with ESMTPSA id 37B3D18A025C;
        Mon, 30 Jul 2018 10:52:40 -0500 (CDT)
Message-ID: <5B5F3405.9070902@game-point.net>
Date:   Mon, 30 Jul 2018 16:51:33 +0100
From:   Jeremy Morton <admin@game-point.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Jeff King <peff@peff.net>
CC:     git@vger.kernel.org
Subject: Re: Strange bug with "git log" - pdftotext?
References: <5B5F096A.7030404@game-point.net> <20180730153731.GA25797@sigill.intra.peff.net>
In-Reply-To: <20180730153731.GA25797@sigill.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I discovered it was an issue with the version of Git for Windows I was 
using.  Upgraded to the latest version and it works now.

-- 
Best regards,
Jeremy Morton (Jez)

On 30/07/2018 16:37, Jeff King wrote:
> On Mon, Jul 30, 2018 at 01:49:46PM +0100, Jeremy Morton wrote:
>
>> I'm trying to search my git log history for a particular term -
>> "unobtrusive" - so I run this command:
>>
>> git log -S unobtrusive --oneline
>>
>> When I do this, this is displayed and I'm in an interactive less terminal or
>> something:
>>
>> pdftotext version 4.00
>> [...]
>
> That's definitely weird.
>
> My guess is that the repository has some .gitattributes set up to diff
> pdf files in a particular way, and you have some matching config that
> tries to call pdftotext.
>
> What does:
>
>    git config --list | grep ^diff
>
> say? I'd expect to see an external or textconv option there running
> pdftotext.
>
> Another option is that your pager is somehow set up to call pdftotext,
> but that seems much more nonsensical to use the tool there (but try "git
> var GIT_PAGER" and "git config pager.log" to check).
>
> -Peff
>
