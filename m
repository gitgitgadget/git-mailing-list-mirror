Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DD4C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 16:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356036AbiDORCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 13:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356033AbiDORCU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 13:02:20 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B401EEF2
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 09:59:51 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB5FB193D8C;
        Fri, 15 Apr 2022 12:59:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aO5FPfd5mhyq
        9MDRO0C+6ABRoTsQNG6WHzlBYQExhpU=; b=AE1IxrITsOiB0ZHUknnNQk81R8b+
        zBd2iR7Ssol0lIoyxmsVv6JjeK8FkT4Wnl9wfBPPkZUaXWmFuvQGDtfJYeVdRbRw
        bQwJgsrVOmo9IbnCYw4eg0qB3tVM01kysCRf0o881/cR6Sxu/B5BmAdRIy1ILwHZ
        5w0TgQcmC7IfNLc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D2808193D8B;
        Fri, 15 Apr 2022 12:59:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5D255193D86;
        Fri, 15 Apr 2022 12:59:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 25/29] CI: set CC in MAKEFLAGS directly, don't add it
 to the environment
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
        <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
        <patch-v3-25.29-1268792233f-20220413T194847Z-avarab@gmail.com>
        <CAPUEspjT23rqBwkgARf90me1n0dd4pjS4i+ya=Vo=xCBCTjp4g@mail.gmail.com>
        <220415.86k0bqbgin.gmgdl@evledraar.gmail.com>
Date:   Fri, 15 Apr 2022 09:59:46 -0700
In-Reply-To: <220415.86k0bqbgin.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 15 Apr 2022 15:47:22 +0200")
Message-ID: <xmqqmtgme0zh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 74BD3420-BCDD-11EC-A83E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I'll fix that as along with any small follow-ups after this series,
> sound good?

Without any small follow-ups would be much much more preferrrable,
and leave the follow-up to a separate series.

A series doing too many things at once can mix bad apples slip in by
overwhelming the reviewer bandwidth, and I am afraid that it may be
what happened in the original "bunch of Makefile updates" that the
bug originated from.  I am guessing that Carlo meant the same when
he said "since there were too many refactorings around this code".

Thanks.
