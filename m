Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2CAC433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 17:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0085363429
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 17:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbhKOR5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 12:57:34 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50960 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239245AbhKOR4S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 12:56:18 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F3C7E156B88;
        Mon, 15 Nov 2021 12:53:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=B3uEDNw1U9kO
        Rhtkdteqj+/oNr+rk4j5m6VvMRvMLyo=; b=oEiaMgf3iWckH93afQLXNDanccs9
        RxkoC+6gxu/PGl6hF9kj6Mpk0Z0UTnIEmxclZIj1PaYJFmpMhQs1CpDBxz3rRLPG
        1BbJv/wFxvtxQRsgA0StpTgKxBWJpGwCAaCeNdx/zjlxZnxBASnDTBngIaB8p3qk
        wd6l85QIB9IwF+8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EBFAB156B87;
        Mon, 15 Nov 2021 12:53:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5D063156B85;
        Mon, 15 Nov 2021 12:53:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, git@vger.kernel.org,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] test-lib: show missing prereq summary
References: <20211115160750.1208940-1-fs@gigacodes.de>
        <20211115160750.1208940-2-fs@gigacodes.de>
        <211115.865ysts45o.gmgdl@evledraar.gmail.com>
Date:   Mon, 15 Nov 2021 09:53:10 -0800
In-Reply-To: <211115.865ysts45o.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 15 Nov 2021 18:44:14 +0100")
Message-ID: <xmqq8rxpfgqh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E6183F42-463C-11EC-8A04-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> +if test -n "$missing_prereq"
>> +then
>> +	unique_missing_prereq=3D$(
>> +		echo $missing_prereq |
>> +		tr -s "," "\n" |
>> +		grep -v '^$' |
>> +		sort -u |
>> +		paste -s -d ',')
>
> What is paste? Some out-of-tree debugging utility?

https://pubs.opengroup.org/onlinepubs/9699919799/utilities/paste.html

Don't feel bad for not knowing it.  I usually do not use cut or paste
myself and I had to look it up the other day while reviewing the RFC
phase of this series.

I am not sure '\n' is a good idea from portability perspective.  I
thought I wrote '\012' in the illustration in my review?
