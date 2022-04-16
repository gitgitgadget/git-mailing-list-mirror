Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C52C433F5
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 00:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiDPAWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 20:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiDPAW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 20:22:26 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13029D762C
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 17:19:54 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 878EA18CB93;
        Fri, 15 Apr 2022 20:19:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=p0SMq+u5hnXN
        UUI7mRip/CrrcXC3vEsq47GpF+MePYg=; b=Bpkr8zEGYUEC2Eej5hnYLwfBwCVr
        45Hpdz/o9LGbczG4WpkzJ7TDRR5ky2sVrzzs9Tk1yJXeQSt/cj0oI658+6W0x0Ea
        f0JK4BloN8Vh9UsvmejDKuPUJMHWGufYSp8eZf7nB5srlYqJxIxypXCn8T7cvoyd
        4XQKVoY69Y2bDbY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8008718CB92;
        Fri, 15 Apr 2022 20:19:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0BA3018CB91;
        Fri, 15 Apr 2022 20:19:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, phillip.wood@talktalk.net
Subject: Re: [PATCH 1/2] config.mak.dev: workaround gcc 12 bug affecting
 "pedantic" CI job
References: <20220415123922.30926-1-carenas@gmail.com>
        <20220415231342.35980-1-carenas@gmail.com>
        <20220415231342.35980-2-carenas@gmail.com>
        <220416.8635idc3mk.gmgdl@evledraar.gmail.com>
Date:   Fri, 15 Apr 2022 17:19:49 -0700
In-Reply-To: <220416.8635idc3mk.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 16 Apr 2022 01:41:27 +0200")
Message-ID: <xmqq35idanh6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EE8CA578-BD1A-11EC-B470-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> What I meant with "just set -Wno-error=3Dstringop-overread on gcc12 for
> dir.(o|s|sp)?" was that you can set this per-file:
>
> 	dir.sp dir.s dir.o: EXTRA_CPPFLAGS +=3D -Wno-error=3Dstringop-overread
>
> Ditto for the warning suppression in 2/2, we don't currently have any
> other warnings like this, but we can suppress them more narrowly.

While it is certainly attractive if we can loosen the warning
settings in a more pointed way, is it easy to arrange something like
the above ONLY for gcc12 and no other compilers? =20

Do we know -Wno-error=3Di-have-no-idea-what-that-error-is safely gets
ignored by all compilers we care about, which may not even be a GCC?
