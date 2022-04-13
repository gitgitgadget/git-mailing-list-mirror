Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C5FC433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 21:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiDMVLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiDMVLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 17:11:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AD64BBA7
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 14:08:53 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ACDDB19C464;
        Wed, 13 Apr 2022 17:08:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0BbUZ+2CkmBw
        iojBpp7r87816jy0qH8uOAinObXBj8s=; b=rE17DuCRG+KUVN0imBJcZkWYiYBZ
        wwxhhuyGxxKOSLndCS++FF14m6VkE2A/Vgx3+Qd1t5KT8OklxhLurlbzxSvOhHcI
        HLWbzOVfjnWcm3DJzCpjZ2o4+0paa4E6nFvSFlIzquKIgChxjj8SujRQw7gy0Urd
        6D9/Luca/k740Fk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A472419C463;
        Wed, 13 Apr 2022 17:08:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 026AB19C460;
        Wed, 13 Apr 2022 17:08:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 00/29] CI: run "make" in CI "steps", improve UX
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
        <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
Date:   Wed, 13 Apr 2022 14:08:48 -0700
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 13 Apr
 2022 21:51:13
        +0200")
Message-ID: <xmqqh76w7ktb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EA69BA34-BB6D-11EC-9B73-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  * The rather minor in code but rather big in UX terms is that I've
>    added 29/29, which explicitly documents and shows examples of using
>    the CI tooling in a way where you can locally run a CI target as if
>    though it were a given $jobname, e.g.:

Yay.

>    Likewise the ci/print-test-failures.sh script can now be run
>    locally without any extra mock-ups, e.g.:

Double yay.

>     @@ ci/lib.sh
>      +# Starting assertions
>      +if test -z "$jobname"
>      +then
>     -+	echo "must set a CI jobname" >&2
>     ++	echo "must set a CI jobname in the environment" >&2
>      +	exit 1
>      +fi

OK.  In the truely-automated-machine-initiated run, this should not
matter, but once we start allowing end-user to interact with the
guts of the CI machinery, being as helpful as possible matters.
