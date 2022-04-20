Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E448C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 08:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376606AbiDTIQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 04:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbiDTIQN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 04:16:13 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064A6B864
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 01:13:26 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5147313674A;
        Wed, 20 Apr 2022 04:13:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=gdtxNBbd1QeN0QIYwjWLqQbTp
        LK5gzKJ6gtcxZNuy5Q=; b=Sg0gYkbStuDLLCTSnEf8qnHme6qFWdz+p5q27i7DR
        x9/iFkz58XvMlqWfD/lrx/Cyl2ZU4Jk9DgpO6CErmlIvutCnQrzrXjpS+SDG1jaB
        Rb98MC2nUhOETWpa//goERpacyVBk4jwbfvAUYm3zXIObpli3mzFNAaod/V1y3N8
        pY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4770D136749;
        Wed, 20 Apr 2022 04:13:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A220C136748;
        Wed, 20 Apr 2022 04:13:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 30/31] CI: have osx-gcc use gcc, not clang
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
        <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
        <patch-v4-30.31-94abb826627-20220418T132809Z-avarab@gmail.com>
        <55271bbe-7b6e-7c92-7337-2439a2f5be26@talktalk.net>
Date:   Wed, 20 Apr 2022 01:13:24 -0700
Message-ID: <xmqqh76orx3v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C0A390D0-C081-11EC-B356-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> On 18/04/2022 17:29, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Fix a regression in 707d2f2fe86 (CI: use "$runs_on_pool", not
>> "$jobname" to select packages & config, 2021-11-23). In that commit I
>> changed CC=3Dgcc from CC=3Dgcc-9, but on OSX the "gcc" in $PATH points=
 to
>> clang, we need to use gcc-9 instead.
>
> As this is fixing a bug in master, perhaps it would be better as a
> separate patch that can be merged before this series (this series
> could be rebased on to the fix)

Yeah, that sounds quite sensible.

Or perhaps start from 'master', merge this (and other fixes, if
there are, in this series), merge Dscho's CI updates and then use
that as an updated base?


