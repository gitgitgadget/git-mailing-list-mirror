Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B81C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 23:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354230AbhLCXnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 18:43:09 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:43923 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354205AbhLCXnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 18:43:09 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4J5TnV4Krnz5tlC;
        Sat,  4 Dec 2021 00:39:42 +0100 (CET)
Subject: Re: [PATCH 00/10] Factorization of messages with similar meaning
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
 <YaqSXvp6ZxOFqeuk@coredump.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d687f69b-efdc-6b1c-c63c-8544ff37d1c2@kdbg.org>
Date:   Sat, 4 Dec 2021 00:39:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YaqSXvp6ZxOFqeuk@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.12.21 um 22:55 schrieb Jeff King:
> On Fri, Dec 03, 2021 at 07:01:39AM +0000, Jean-Noël Avila via GitGitGadget wrote:
> 
>> This series is a meager attempt at rationalizing a small fraction of the
>> internationalized messages. Sorry in advance for the dull task of reviewing
>> these insipide patches.
>>
>> Doing so has some positive effects:
>>
>>  * non-translatable constant strings are kept out of the way for translators
>>  * messages with identical meaning are built identically
>>  * the total number of messages to translate is decreased.
>>
>> I'm inclined to even go a step further and turn these messages into #define
>> or const strings. This would have the added benefits:
>>
>>  * make sure that the messages to translate are identical
>>  * create a library of message skeletons to be picked up when new messages
>>    are needed
>>
>> What do you think?
> 
> One slight negative of this approach is that it makes messages a bit
> harder to grep for. It sometimes really nice to "git jump grep" for
> specific messages you got to see where they're coming from.

This can be mitigated by using, for example,

  git grep -e --stdin --and -e mutually

as long as the rewrite keeps the arguments on the same line with the
format strings, which it does.

Another aspect is that translators lose context. For example, "%s and %s
are mutally exclusive" may have to be translated differently depending
on what kind of text is substituted for %s. In this example it's
probably always command line options (I haven't checked), so not an
immediate problem. But something to keep in mind.

-- Hannes
