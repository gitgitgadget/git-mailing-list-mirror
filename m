Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A44C433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 21:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245503AbiD3VmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 17:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbiD3VmT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 17:42:19 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E648355AC
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 14:38:54 -0700 (PDT)
Received: from [84.13.159.41] (helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nkunl-0009Wq-3W;
        Sat, 30 Apr 2022 22:38:53 +0100
Message-ID: <a3e06290-052e-af36-4170-301e567d561d@iee.email>
Date:   Sat, 30 Apr 2022 22:38:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 01/23] contrib/coccinnelle: add equals-null.cocci
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
References: <20220430041406.164719-1-gitter.spiros@gmail.com>
 <20220430041406.164719-2-gitter.spiros@gmail.com>
 <6e8cd958-b749-0a55-d8ae-ff249f06bd2f@iee.email> <xmqqpmky70jb.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqpmky70jb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/04/2022 21:56, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> On 30/04/2022 05:13, Elia Pinto wrote:
>>> Add a coccinelle semantic patch necessary to reinforce the git coding style
>>> guideline:
>>>
>>> "Do not explicitly compute an integral value with constant 0 or '\ 0', or a
>> s/compute/compare/
>>> pointer value with constant NULL."
>> If this gets re-rolled, perhaps include a simple example for those who
>> don't immediately understand that quoted sentence. It will also help
>> decode the coccinelle script
>>
>> so:     `if (ptr == NULL)` becomes `if (!ptr)`  etc.
> That is certainly a good suggestion, but I am wondering if we want
> to also emphasize another more generally applicable rule that
> appears much earlier in the guideline document:
>
>  - Fixing style violations while working on a real change as a
>    preparatory clean-up step is good, but otherwise avoid useless code
>    churn for the sake of conforming to the style.
>
>    "Once it _is_ in the tree, it's not really worth the patch noise to
>    go and fix it up."
>    Cf. http://lkml.iu.edu/hypermail/linux/kernel/1001.3/01069.html

I think it goes both ways when the 'bad' style can be cargo-cult copied
too easily, negating the value of the guidance.

That said, having 22 patches to renormalise the codebase does end up as
being excessive. And it's not clear if the first cocci patch ends up as
part of the regular lint checking (I'm not a user of cocci..).

I suspect that all the renormalising fixes were the result of a single
cocci check, so having a single patch that makes the codebase clean
would be better, if accepted.
--
Philip

