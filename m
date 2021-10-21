Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290C4C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB5D6128E
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhJUXFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 19:05:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62375 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhJUXFv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 19:05:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0838A163BC6;
        Thu, 21 Oct 2021 19:03:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=btscss8Rg2MX
        Al6Mzzsu0LMKDx71/8y7juq/OKCoGEo=; b=lTohxxH6++SPJWaFBD0yTtQoPu/V
        tVbuvO4ntWc6M0S/OD0J7d5Rh/NLx9JthtNjk5Kk3hcnX88h0WWpLyEi2LmztJhv
        Etgx74oWS32lMzwQ4InR7cdV3IcK2FmCgXe4asM+rMd5v6fk71c+a83zYxyUHSJs
        j74mvYvA0fCLs/A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 01A39163BC5;
        Thu, 21 Oct 2021 19:03:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 61EF4163BC4;
        Thu, 21 Oct 2021 19:03:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
Subject: Re: changing the experimental 'git switch'
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2110211150290.56@tvgsbejvaqbjf.bet>
        <211021.86wnm6l1ip.gmgdl@evledraar.gmail.com>
Date:   Thu, 21 Oct 2021 16:03:31 -0700
In-Reply-To: <211021.86wnm6l1ip.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 21 Oct 2021 18:45:44 +0200")
Message-ID: <xmqq7de6htfg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1CC27270-32C3-11EC-BF41-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>     | Switch with --merge       | git switch -m branch   | git switch -=
-merge branch |
>     | Create                    | git switch -c new      | git switch -=
n new         |
>     | Create from existing      | N/A                    | git switch -=
c new [<old>] |

I agree that adding a way to "clone", which is missing from
"checkout/switch/branch", is a good idea.  I do not necessarily
think it is a good idea to say "-n" is "new" or "-c" is not "create"
but is "clone/copy".  As you said yourself in a later paragraph,
"-n" sometimes is "--dry-run", and as we can see here "-c" in the
context of a command that can create and clone (with two verbs
behaving differently) is ambiguous.

Starting with a spelled out --copy vs --create without muddying the
water with -n may be a sensible way forward.
