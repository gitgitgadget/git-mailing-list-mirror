Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE1FC20899
	for <e@80x24.org>; Wed,  9 Aug 2017 05:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751536AbdHIF3j (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 01:29:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59218 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750830AbdHIF3i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 01:29:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8C51A0354;
        Wed,  9 Aug 2017 01:29:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iMW/Y2BFwqdY
        4EjHTjPYswY0yW8=; b=HOc9o4+7sQ0vaUl4/6Y5fMu3AcYaegP8TYgnMxL7e3j2
        dOTPvZP54uJA0Jgu5yGRdi9G4S8hK6VK2OcNDTrd48JGiOyt1YkUJN2D7NO43Roe
        5IhclwMx1VqSp6phBJnZfRKC0uf9v8unWDzBlKjDPY1h9VGGgqyCpKpIpByZLU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tiDEpX
        18jjl3DVzyfRasZvfoKI86G+rhN3rk7P80X6CghfcqJ9iSrVRqouMBlsieQqXfBQ
        8AqiFMknku10ZsL0YbwbdYHphIhs1nJFERNEmGTL25C+m0XyEn7U9s14fw25e6V/
        vTvl3m6zxwiaXIymXOGm2hRYtb9C15fns8TP4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1133A0353;
        Wed,  9 Aug 2017 01:29:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1DCC7A0352;
        Wed,  9 Aug 2017 01:29:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        David Coppa <dcoppa@openbsd.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] t4062: stop using repetition in regex
References: <861dc875-7300-fe5a-1360-0ed546c8c2bb@web.de>
        <alpine.DEB.2.21.1.1708081648130.11175@virtualbox>
        <1e7ed028-77fe-195a-4acf-6c80d1704463@web.de>
        <xmqqinhxaf0i.fsf@gitster.mtv.corp.google.com>
        <xmqq7eydae7r.fsf@gitster.mtv.corp.google.com>
        <cd60d779-fe38-4f0e-4d36-2c40b2afec7d@web.de>
Date:   Tue, 08 Aug 2017 22:29:33 -0700
In-Reply-To: <cd60d779-fe38-4f0e-4d36-2c40b2afec7d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 9 Aug 2017 00:34:30 +0200")
Message-ID: <xmqqtw1h8g1u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BABB22A2-7CC3-11E7-8E04-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 09.08.2017 um 00:26 schrieb Junio C Hamano:
>> ... but in the meantime, I think replacing the test with "0$" to
>> force the scanner to find either the end of line or the end of the
>> buffer may be a good workaround.  We do not have to care how many of
>> random bytes are in front of the last "0" in order to ensure that
>> the regexec_buf() does not overstep to 4097th byte, while seeing
>> that regexec() that does not know how long the haystack is has to do
>> so, no?
>
> Our regexec() calls strlen() (see my other reply).
>
> Using "0$" looks like the best option to me.

Yeah, it seems that way.  If we want to be close/faithful to the
original, we could do "^0*$", but the part that is essential to
trigger the old bug is not the "we have many zeroes" (or "we have
4096 zeroes") part, but "zero is at the end of the string" part, so
"0$" would be the minimal pattern that also would work for OBSD.

Dscho?
