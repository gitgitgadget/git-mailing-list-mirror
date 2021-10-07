Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A93C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 22:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5CBA61263
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 22:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhJGWhA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 18:37:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53782 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbhJGWhA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 18:37:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A88CF3C78;
        Thu,  7 Oct 2021 18:35:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7naO2Xtz1rna
        Jy5CeX7hPjm3tjDCN0YJGmX+ygihEBs=; b=eDXkiZrGZUxU9RdOgMfUZoVL32cg
        P0I4t6+J5tb8pGuvWNdGzrfvUk1+GJTamy248wkA+Pwr30viBq59hlsHHoyMjR3T
        wmCZxoTlanMCh1tXrFGkOpab1nivtXpM0VRtAMnz0TdazIi97yCPy0sEwaXt6aTM
        XtUt6uGnfEPpWVU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30861F3C77;
        Thu,  7 Oct 2021 18:35:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 092F0F3C76;
        Thu,  7 Oct 2021 18:35:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/10] leak tests: mark t0000-init.sh as passing with
 SANITIZE=leak
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
        <patch-03.10-3a7dd917d9f-20211006T094705Z-avarab@gmail.com>
Date:   Thu, 07 Oct 2021 15:35:02 -0700
In-Reply-To: <patch-03.10-3a7dd917d9f-20211006T094705Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 6 Oct
 2021 11:50:30
        +0200")
Message-ID: <xmqqr1cwo44p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D0B7D6C2-27BE-11EC-8532-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Mark "t000-init.sh" as passing when git is compiled with SANITIZE=3Dlea=
k.

"t0000-init.sh", I think.  Why should we have a separate one for
this script, rather than it being a part of [01/10]?

>
> It'll now be whitelisted as running under the
> "GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue" test mode (the "linux-leaks" CI
> target).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t0001-init.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index df544bb321f..7603ad2f82b 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -2,6 +2,7 @@
> =20
>  test_description=3D'git init'
> =20
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
> =20
>  check_config () {
