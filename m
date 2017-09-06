Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B44B6209AB
	for <e@80x24.org>; Wed,  6 Sep 2017 06:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750917AbdIFG20 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 02:28:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54153 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750819AbdIFG20 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 02:28:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E223A98D18;
        Wed,  6 Sep 2017 02:28:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CPNtQNs1vaJ2N+pKw7RqOO2kDbM=; b=SL8fIE
        FHNEvivBe3FlxW6/26kSSUN1O27eYQw2CH/azxW/NKctNfr+ekfx5fYq2ohTigsB
        EHB4qPhePu/LticN7G2q5wH6ehb8ShuBNYF80rYXpj8Bt/1ok0SzJCLLY+YouGPT
        dB4uYCU2qU7q1FCrqT1D9zeOw6mu/eppjsxRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rhqyRzOgLTXvTdkbf8/Crp5rtYgVQwgV
        e6Pz6I74OCwZhUUyojZC4+pkenXDqwtT6S7zfx/uZAc412ynFF7McO83KI5iwL/r
        dQ0tBgkzRjisdEcFudKKxVYFWY+L/S7Yt/XKhAcfB4tis7POhQ+wiz2d3xpFlBV/
        KVx8m80Zjqg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D705098D17;
        Wed,  6 Sep 2017 02:28:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 377E098D15;
        Wed,  6 Sep 2017 02:28:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        jonathantanmy@google.com, Jeff King <peff@peff.net>,
        David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
        <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
        <20170307001709.GC26789@aiede.mtv.corp.google.com>
Date:   Wed, 06 Sep 2017 15:28:23 +0900
In-Reply-To: <20170307001709.GC26789@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Mon, 6 Mar 2017 16:17:09 -0800")
Message-ID: <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95D92B86-92CC-11E7-A022-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Linus Torvalds wrote:
>> On Fri, Mar 3, 2017 at 5:12 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>>> This document is still in flux but I thought it best to send it out
>>> early to start getting feedback.
>>
>> This actually looks very reasonable if you can implement it cleanly
>> enough.
>
> Thanks for the kind words on what had quite a few flaws still.  Here's
> a new draft.  I think the next version will be a patch against
> Documentation/technical/.

Can we reboot the discussion and advance this to v4 state?

> As before, comments welcome, both here and inline at
>
>   https://goo.gl/gh2Mzc

I think what you have over there looks pretty-much ready as the
final outline.

One thing I still do not know how I feel about after re-reading the
thread, and I didn't find the above doc, is Linus's suggestion to
use the objects themselves as NewHash-to-SHA-1 mapper [*1*].  

It does not help the reverse mapping that is needed while pushing
things out (the SHA-1 receiver tells us what they have in terms of
SHA-1 names; we need to figure out where we stop sending based on
that).  While it does help maintaining itself (while constructing
SHA3-content, we'd be required to find out its SHA1 name but the
SHA3 objects that we refer to all know their SHA-1 names), if it is
not useful otherwise, then that does not count as a plus.  Also
having to bake corresponding SHA-1 name in the object would mean
mistakes can easily propagate and cannot be corrected without
rewriting the history, which would be a huge downside.  So perhaps
we are better off without it, I guess.


[Reference]

*1* <CA+55aFxj7Vtwac64RfAz_u=U4tob4Xg+2pDBDFNpJdmgaTCmxA@mail.gmail.com>


