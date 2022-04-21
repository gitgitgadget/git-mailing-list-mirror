Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B0AC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 20:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392251AbiDUUPH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392227AbiDUUPG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 16:15:06 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67A64DF44
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:12:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AC2441953B1;
        Thu, 21 Apr 2022 16:12:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JIJfpOM/xSo/
        VfLdu23wugeeKAPiHRPZXokcrb0mhqI=; b=pBzxJa7HcgED3I/8bV7zIbWgVj3w
        AFReekiwRgbyXrZTNlBXvKyoNbYPP7w3s+kzSQG2RsSmMuoUpBdInS3SG9zxyY06
        8DUkM/+EZQziSha2ehHghpu+gYAfOgQ+wocSfjPDO1j/B6pHGRAmqtVDAud+u/Fg
        fcuuWEvFWvvqQUo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A413F1953B0;
        Thu, 21 Apr 2022 16:12:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 317241953AF;
        Thu, 21 Apr 2022 16:12:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 30/31] CI: have osx-gcc use gcc, not clang
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
        <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
        <patch-v4-30.31-94abb826627-20220418T132809Z-avarab@gmail.com>
        <55271bbe-7b6e-7c92-7337-2439a2f5be26@talktalk.net>
        <xmqqh76orx3v.fsf@gitster.g>
        <52382f7c-5b6a-63b6-2eb2-26c12f31f529@gmail.com>
        <xmqqr15rpp9b.fsf@gitster.g>
        <220421.8635i66wq6.gmgdl@evledraar.gmail.com>
Date:   Thu, 21 Apr 2022 13:12:10 -0700
In-Reply-To: <220421.8635i66wq6.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 21 Apr 2022 21:24:12 +0200")
Message-ID: <xmqq35i6gpr9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 53DEE740-C1AF-11EC-A747-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> First. I see you re-queued a the v2 of Johannes's patches. I had some
> outstanding fixes for my series [2] + the derived version of his on top
> [3] which I thought I'd submit regardless.

I do not mind flip-flopping on alternate days for a week or so.

Quite honestly I do not care which ones come first all that much.
All I care about is (1) we keep CI functional and (2) we do not
butcher Makefile too badly in the process.  Part of "functional" is
"not unusably slow".

Making the CI process less locked into a particular vendor and
allowing the build/test with a configuration as similar as what is
run on CI locally are nice to have that can come at the same time,
but I wouldn't shed tears if we defer them to later, as long as they
eventually materialize.

If you can fix Dscho's series by adding a series on top, that sounds
like one approach of lessor resistance.
