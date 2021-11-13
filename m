Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766C7C433F5
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 00:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52BD461073
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 00:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhKMATi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 19:19:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65203 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhKMATi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 19:19:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67D0BEDD95;
        Fri, 12 Nov 2021 19:16:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v8Hs31OoIwkSgNRC/3kKr7iaEAeKNhblATGi2y
        T81SU=; b=Hd1H1sL8rELFX8jgKA/aAIWQ1hTx0m0tLIUAKewRkn6C2DEOLH0zmD
        X4iVy20mzYb5ViWsSbTxkDZAZyO1CbbSjrevMXgi8hCvd0a7qi99OLcmim+APlMa
        HEyRO3YBkSF0RXdnrlw0Q6pYoMQgY+6xdndzNksR8MSOTyL5mYuwE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E2A3EDD94;
        Fri, 12 Nov 2021 19:16:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BC5CEEDD93;
        Fri, 12 Nov 2021 19:16:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, git@vger.kernel.org, fs@gigacodes.de
Subject: Re: [PATCH] RelNotes: mention known crasher when ssh signing with
 OpenSSH 8.7
References: <YYtgD8VT/0vuIHRX@coredump.intra.peff.net>
        <20211110093912.4382-1-carenas@gmail.com> <xmqqczn7y9kh.fsf@gitster.g>
        <xmqqmtmbwtim.fsf@gitster.g>
        <YYzfhKt7SRT9p8Df@coredump.intra.peff.net>
        <YY7/peK1EOHtATEI@camp.crustytoothpaste.net>
Date:   Fri, 12 Nov 2021 16:16:44 -0800
In-Reply-To: <YY7/peK1EOHtATEI@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Fri, 12 Nov 2021 23:58:29 +0000")
Message-ID: <xmqqh7cgoqoj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC80CEAC-4416-11EC-9E8A-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2021-11-11 at 09:16:52, Jeff King wrote:
>> On Wed, Nov 10, 2021 at 02:11:29PM -0800, Junio C Hamano wrote:
>>  ....
>> > + * In addition to GnuPG, ssh public crypto can be used for object and
>> > +   push-cert signing.  Note that this feature cannot be used with
>> > +   ssh-keygen from OpenSSH 8.7, whose support for it is broken.  Avoid
>> > +   using it unless you update to OpenSSH 8.8.
>> 
>> Attaching to the existing gpg-ssh release note like this makes perfect
>> sense to me. Thanks for tying this one up.
>
> Since this now affects running the testsuite on Debian unstable, we
> probably need to also fix the testsuite such that the GPGSSH
> prerequisite fails if we're using OpenSSH 8.7 so that developers and
> distros aren't negatively affected.

Yes, I think YYtgD8VT/0vuIHRX@coredump.intra.peff.net is a good
thing to have, which is ca7a5bf4 (t/lib-gpg: avoid broken versions
of ssh-keygen, 2021-11-10) that was merged a few days ago.

Thanks for being extra careful.



