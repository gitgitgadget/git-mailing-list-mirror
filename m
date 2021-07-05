Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C68C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 19:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D868261426
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 19:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhGETvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 15:51:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60710 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhGETvL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 15:51:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E6E9813F098;
        Mon,  5 Jul 2021 15:48:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oxwv7SccX4EN
        D0QT1Pg7ZOcjiOxU034TGacktAU3um4=; b=tuvHtiYcjjJdv7I+a0LFBLUBvRMo
        edN4uIWVMbmjUujWET3tmU8AwDzfdIrEhVGGHtjNV59RGX5IxYJ1VVzsfJeu4gyX
        Fp2Q42EYIsDM4lnf29hYhxFkkpseEUC9MNQ22H+6siiAF+p7hazW16gYMETu9/ui
        nFEz4Duy/1OXf48=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E025813F097;
        Mon,  5 Jul 2021 15:48:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6325813F096;
        Mon,  5 Jul 2021 15:48:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH] Documentation/Makefile: don't re-build on 'git version'
 changes
References: <874kdn1j6i.fsf@evledraar.gmail.com>
        <patch-1.1-911881ce19f-20210702T115617Z-avarab@gmail.com>
        <xmqqmtr4pv9r.fsf@gitster.g> <87pmvz8v1u.fsf@evledraar.gmail.com>
Date:   Mon, 05 Jul 2021 12:48:29 -0700
In-Reply-To: <87pmvz8v1u.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 03 Jul 2021 13:58:55 +0200")
Message-ID: <xmqqczrwmtiq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F9CFC784-DDC9-11EB-A70D-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think nobody's doing such a "chained" build when building the docs fo=
r
> a "real" release, and having mixed versions might be confusing, but for
> the "local build" case from a development checkout it's arguably more
> useful.

Well, when I prepare a cascade of maintenance releases for CVE, what
do you think is done?  Yes, I do have "make distclean" in the loop
that iterates over the maint-$version branches, just to be extra
careful, but I shouldn't have to.
