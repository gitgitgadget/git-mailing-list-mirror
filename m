Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C554C636D3
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 20:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjBHUvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 15:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjBHUvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 15:51:09 -0500
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7075A2B2BD
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 12:51:06 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4PBsbT6TjXz5tl9;
        Wed,  8 Feb 2023 21:51:01 +0100 (CET)
Message-ID: <e16e4190-9db0-1519-0114-858118882d5d@kdbg.org>
Date:   Wed, 8 Feb 2023 21:51:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 0/3] userdiff: Java updates
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Jeff King <peff@peff.net>, Paolo Bonzini <pbonzini@redhat.com>,
        Tassilo Horn <tsdh@gnu.org>, git@vger.kernel.org
References: <64601c4b-9ced-672f-a5fd-9a9b3b65859d@kdbg.org>
 <20230207234259.452141-1-rybak.a.v@gmail.com>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20230207234259.452141-1-rybak.a.v@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.02.23 um 00:42 schrieb Andrei Rybak:
> On 2023-02-05T22:33 Johannes Sixt wrote:
>> Having seen all these examples, I think the following truncated
>> expression might do the right thing for all cases that are valid Java:
>>
>> "^[ \t]*(([a-z-]+[ \t]+)*(class|enum|interface|record)[ \t].*)$"
> 
> Only the '\n' is missing at the end, but otherwise I concur, so here's a v3.
> 
>> i.e., we recognize a whitespace in order to identify the keyword, and
>> then capture anything that follows without being specific. My reasoning
>> is that "class", "enum", "interface", and "record" cannot occur in any
>> other context than the beginning of a class definition. (But please do
>> correct me; I know next to nothing about Java syntax.)
> 
> The word "class" can also occur as part of a class literal, for example:
> 
>     Class<String> c = String.class;
> 
> but valid uses of class literals won't interfere with our regex, unless some
> wild formatting is applied.  This is technically valid Java:
> 
>     Class<String> c = String.
>     class 
>     ;
> 
> and with a space after lowercase "class", the v3 regex will trip.

Yeah, let's assume that nobody writes code like this.

This iteration is all good!

Reviewed-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes

