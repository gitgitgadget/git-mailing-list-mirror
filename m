Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66AF1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 18:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbcLESBa (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 13:01:30 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53023 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752185AbcLESB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 13:01:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8591D54A9F;
        Mon,  5 Dec 2016 13:01:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f4YTITD53jVxXCq3mIzdPdL2gyA=; b=sQ+SJv
        xos1S5J/FOH+GXgmZy3G9yZdu7fUtBvlZA1faMzfnEB2WLz+Cx+6Ts4CDMhqXojY
        EA55r0R35/JLSHCBj5ryNUmyM1Q6ixzSWArjQumc9lj2atn3V8Q3jXotxU4TAp+7
        FOsbAw64U7x4mPX6aokcMhvgtXnl8AXrW80C8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DM29d2njaySzev/M40216yK0he9jw4Ur
        pVf2XCMfillDyMb7Tg+eO4AmeI2ZQpKk2zFyNLETuNKrq7eKlThRG1YUwra4EoHk
        yHe8I31GjiBrT5PuOiJfpnxSjg6KOTVTaM5APGKunmt7a5YD3Wv8/wV1jQdXjs6K
        1BLAu/AFJnY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79A4A54A9E;
        Mon,  5 Dec 2016 13:01:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8C61554A9C;
        Mon,  5 Dec 2016 13:01:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [RFC PATCH] GIT-VERSION-GEN: set --abbrev=9 to match auto-scaling
References: <22e9dfa0-47fb-d6fd-caf4-c2d87f63f707@ramsayjones.plus.com>
        <20161205053258.jtnqq64gp5n7vtni@sigill.intra.peff.net>
Date:   Mon, 05 Dec 2016 10:01:19 -0800
In-Reply-To: <20161205053258.jtnqq64gp5n7vtni@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 5 Dec 2016 00:32:58 -0500")
Message-ID: <xmqqbmwq5k7k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3A4FE44-BB14-11E6-9C93-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Dec 04, 2016 at 08:45:59PM +0000, Ramsay Jones wrote:
>
>> 
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>> 
>> Hi Junio,
>> 
>> I recently noticed that:
>> 
>>     $ make >pout 2>&1
>>     $ ./git version
>>     git version 2.11.0.286.g109e8a9
>>     $ git describe
>>     v2.11.0-286-g109e8a99d
>>     $
>> 
>> ... for non-release builds, the commit part of the version
>> string was still using an --abbrev=7.
>
> It seems like this kind of discussion ought to go in the commit message.
> :)
>
> That said, I think the right patch may be to just drop --abbrev
> entirely.
> ...
> I think at that point it was a noop, as 7 should have been the default.
> And now we probably ought to drop it, so that we can use the
> auto-scaling default.

Yeah, I agree.

It does mean that snapshot binaries built out of the same commit in
the same repository before and after a repack have higher chances of
getting named differently, which may surprise people, but that
already is possible with a fixed length if the repacking involves
pruning (albeit with lower probabilities), and I do not think it is
a problem.
