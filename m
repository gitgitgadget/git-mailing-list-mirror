Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DECC433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 20:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC5C2082F
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 20:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QmaDxOYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgGAU61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 16:58:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60941 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgGAU60 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 16:58:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D57A269C77;
        Wed,  1 Jul 2020 16:58:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bmp624EztE2qV05TeOAvOqGjKYs=; b=QmaDxO
        YDhT7iOwD+dWce9TJrjoRtrGrEIlJq94yX9ywt4CeDM+uM5LQ2J0ACc4ieMAwnLL
        vjMXUj2pLNbvhjQW8dWUncW5hv+Kb9URja98vHNYWhr80c19I2s+WIWojDUns+c2
        kTNN46OQ/W3myY4MAL9Hg2EOPN/1xDnSMBKPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fFtV2BqHnjdiltv3SRFKfNS28tQnAeec
        peKf5lMknjp7ivtNSSA9yrNjTK8c+fpjwZ0Qd0vs3L3F8HdtWNBxOr/jPskxhMPZ
        a1rmk0XVfNSF2YjBdFWLcGDcXGzVMAWckhUFTMAf7Vqo91af1a9W6mBZvZVmjLVA
        +MM37ceJl48=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CCEB569C76;
        Wed,  1 Jul 2020 16:58:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5451A69C75;
        Wed,  1 Jul 2020 16:58:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jun 2020, #06; Mon, 29)
References: <xmqqa70lfjvo.fsf@gitster.c.googlers.com>
        <CAHd-oW6A2aBHg80R9kyifvF7thwzam5EYYoN9d2TaBcHJrcKWw@mail.gmail.com>
Date:   Wed, 01 Jul 2020 13:58:22 -0700
In-Reply-To: <CAHd-oW6A2aBHg80R9kyifvF7thwzam5EYYoN9d2TaBcHJrcKWw@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Tue, 30 Jun 2020 16:14:52
        -0300")
Message-ID: <xmqqimf7c5qp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99F8DA30-BBDD-11EA-9166-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> On Mon, Jun 29, 2020 at 10:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * mt/hash-to-hex-thread-safety (2020-06-26) 2 commits
>>  - hex: make hash_to_hex_algop() and friends thread-safe
>>  - compat/win32/pthread: add pthread_once()
>>
>>  hash_to_hex() used a set of rotating static buffers, which was not
>>  safe to use in a threaded environment.  This has been made safer by
>>  using thread-local storage.
>>
>>  Will merge to 'next'.
>
> I'll send a re-roll of this series to address some changes recently
> suggested by Dscho [1].
>
> [1]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2006291646420.56@tvgsbejvaqbjf.bet/

Thanks.
