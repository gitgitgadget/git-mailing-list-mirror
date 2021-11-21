Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485AAC433EF
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 07:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhKUHYy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 02:24:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53233 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhKUHYy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 02:24:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DEAFFD339;
        Sun, 21 Nov 2021 02:21:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=N/kt7RARUvgR
        75ixjk6kiFiDQZt7iHtlllCN/7ntRTI=; b=EoBeXjamuDEqprqjXtXC6Rglt7i2
        aqbl6f1f/0ti5Ok1OEIGcCDZJXae1oG8WNvxXtk8x5VYyWNDW3eIlgyBoSK2eMpC
        3vNaIrlkBC7Hh2bo2Gcci2emthM6BZvlAzkWsEFm+p0w4w83BCFpkvgW724IGrUo
        Rbumjn/MpTcq754=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 553D4FD337;
        Sun, 21 Nov 2021 02:21:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 77B78FD336;
        Sun, 21 Nov 2021 02:21:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v3 4/5] CI: use "$runs_on_pool", not "$jobname" to
 select packages & config
References: <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
        <cover-v3-0.5-00000000000-20211120T115414Z-avarab@gmail.com>
        <patch-v3-4.5-54913e775c1-20211120T115414Z-avarab@gmail.com>
Date:   Sat, 20 Nov 2021 23:21:47 -0800
In-Reply-To: <patch-v3-4.5-54913e775c1-20211120T115414Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 20 Nov
 2021 13:10:10
        +0100")
Message-ID: <xmqq1r3anfck.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B09CCE6A-4A9B-11EC-B93B-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -case "$jobname" in
> -linux-clang|linux-gcc|linux-leaks)
> +case "$runs_on_pool" in
> +ubuntu-latest)
>  	sudo apt-get -q update
> ...
>  	;;
> -osx-clang|osx-gcc)
> +macos-latest)
>  	export HOMEBREW_NO_AUTO_UPDATE=3D1 HOMEBREW_NO_INSTALL_CLEANUP=3D1

Indeed this is nice improvement in maintainability.
