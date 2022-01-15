Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DA0C433EF
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 00:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiAOAbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 19:31:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59297 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiAOAbF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 19:31:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 851B716B20F;
        Fri, 14 Jan 2022 19:31:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GBU1ZMt6Oy8N
        58fYT6mXieafOJ5MAFIOF9phe/d3pDA=; b=krkQHwi3lk+oiqRvIUe2P9otPvhj
        clCQK5tvMjPKL9eh7d9HjLG4gyqLH9VGXhQcr65if2r/OwU3oYtoEpTjBvROAWLY
        frUG0atVaC2eamPso2qlDHaW0w+GPnQwh/As5cCAs4606EYJAodvDr90xSczaVdW
        1rJyEEHchK1+f6E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D7BF16B20E;
        Fri, 14 Jan 2022 19:31:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EA42916B20D;
        Fri, 14 Jan 2022 19:31:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: v2.35.0 DEVELOPER=1 regression
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
        <xmqqlf0w5bbc.fsf@gitster.g>
        <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
        <xmqq4k7j68eg.fsf@gitster.g>
        <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
        <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
        <YbMWNZCpy578Qu+l@coredump.intra.peff.net>
        <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
        <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net>
        <xmqqilumayfh.fsf@gitster.g> <xmqqzgny7xo7.fsf@gitster.g>
        <220115.86tue5rhlf.gmgdl@evledraar.gmail.com>
Date:   Fri, 14 Jan 2022 16:31:01 -0800
In-Reply-To: <220115.86tue5rhlf.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 15 Jan 2022 00:56:34 +0100")
Message-ID: <xmqqsftp7sca.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6B72AB5A-759A-11EC-BD7D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Wasn't the initial goal here to check whether we'd accidentally include
> C99? Just checking on GCC/Clang somewhere seems sufficient enough,

What do you mean by "accidentally include"?

The goal here is that developer build should give developer a set of
options that help the most---"not going beyond C99" is something we
want them to be checking, if able (and we have established that
users on FreeBSD are not capable).

Doesn't your "something like" limits the check to CI?  Developers
with compilers that _can_ help ensuring that we do not go beyond C99
should be able to do so by their local developer build.

> I.e. something like:
>    =20
>     diff --git a/ci/lib.sh b/ci/lib.sh
>     index 9d28ab50fb4..94d0d4127b9 100755
>     --- a/ci/lib.sh
>     +++ b/ci/lib.sh
>     @@ -209,6 +209,9 @@ linux-leaks)
>             export SANITIZE=3Dleak
>             export GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue
>             ;;
>     +linux-gcc|linux-clang)
>     +       MAKEFLAGS=3D"$MAKEFLAGS CFLAGS=3D-std=3Dgnu99"
>     +       ;;
>      esac
>     =20
>      MAKEFLAGS=3D"$MAKEFLAGS CC=3D${CC:-cc}"
>     diff --git a/config.mak.dev b/config.mak.dev
>     index d4afac6b51f..216f92493fc 100644
>     --- a/config.mak.dev
>     +++ b/config.mak.dev
>     @@ -20,10 +20,6 @@ endif
>      endif
>      endif
>     =20
>     -ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang7,$(=
COMPILER_FEATURES))),)
>     -DEVELOPER_CFLAGS +=3D -std=3Dgnu99
>     -endif
>     -
>      DEVELOPER_CFLAGS +=3D -Wdeclaration-after-statement
>      DEVELOPER_CFLAGS +=3D -Wformat-security
>      DEVELOPER_CFLAGS +=3D -Wold-style-definition
