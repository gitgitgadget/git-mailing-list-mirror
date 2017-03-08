Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2910620135
	for <e@80x24.org>; Wed,  8 Mar 2017 22:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932126AbdCHWIx (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 17:08:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57305 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932123AbdCHWIw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 17:08:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6FE16DB1F;
        Wed,  8 Mar 2017 15:54:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hhp+B2u+mJOnmFxqiQCtqfGH8aI=; b=rDrKh7
        aeYbekwJ+g1Emqizuf6yYXDoQ16UkJdJXbFPw5vniEJnfSR+XNhMs6y05wbX3xop
        foMB5Yy8MPqYoJnq/2LZg5+MaS/GnBVe5oNY5v4QIlr0h4OifpYdGd0AMob9aUJB
        qULnNdFDi49nUjbB4W5FKXzFoGeU8pQChwS5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KMMumK+LHVOGm1ZLpA0vZhJGikUvolcC
        OhxtLb/c9YP7dmXeDYoGM8t49Smvj8hIFTDrkx/dBzG/YA5k5msvd6f2iU1QSbtv
        mLSwY/bBiFTaQPJYktyLOHuKYvA/6vbqL5wGRjn/dnKWlQ24HN40BQJ7pkOP89ZU
        65fFw9btUFA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE82A6DB1E;
        Wed,  8 Mar 2017 15:54:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 39EC46DB1D;
        Wed,  8 Mar 2017 15:54:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: diff.ignoreSubmoudles config setting broken?
References: <5e5b1b92-f7c6-2987-356e-1aab2bff557e@gmail.com>
        <20170308133348.2ovfsi44vq2rpgom@sigill.intra.peff.net>
        <CAHGBnuM3iM-kHdxdox_1i56uLbv7gQ5ZUY9Xqf4BG7G_kTf+jQ@mail.gmail.com>
        <20170308140110.wgdedquqwm75zws2@sigill.intra.peff.net>
        <CAHGBnuPGPcWwbrZX_92XDJu47bpH=kj2PZ7yWHK=MRfZ_RHXrQ@mail.gmail.com>
        <CAGZ79kbwMhL-ZnL-iYwPH=tWa8cNQbEGOYYQBw6OzFCMhOWE-w@mail.gmail.com>
Date:   Wed, 08 Mar 2017 12:54:10 -0800
In-Reply-To: <CAGZ79kbwMhL-ZnL-iYwPH=tWa8cNQbEGOYYQBw6OzFCMhOWE-w@mail.gmail.com>
        (Stefan Beller's message of "Wed, 8 Mar 2017 11:04:07 -0800")
Message-ID: <xmqq8tof32x9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 617E09C0-0441-11E7-AC02-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Mar 8, 2017 at 7:07 AM, Sebastian Schuberth
> <sschuberth@gmail.com> wrote:
>>
>> + Jens
>>
>
> + Jacob Keller, who touched submodule diff display code last.
> (I am thinking of fd47ae6a, diff: teach diff to display submodule
> difference with an inline diff, 2016-08-31), which is first release as
> part of v2.11.0 (that would fit your observance)

Between these two:

	git -c diff.ignoresubmodules=all diff
	git diff --ignore-submodules=all

one difference is that the latter disables reading extra config from
.gitmodules (!) while the former makes the command honor it.

This comes from aee9c7d6 ("Submodules: Add the new "ignore" config
option for diff and status", 2010-08-06), which is ancient and
predates even v2.0, so if you see problems with v2.12 or v2.11 but
not with older ones, that would rule out this theory.
