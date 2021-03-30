Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EA1C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D69619CD
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhC3XON (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:14:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55285 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbhC3XOL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 19:14:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 020B0B0897;
        Tue, 30 Mar 2021 19:14:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3AtGU9obqGbx
        KjfnsyTRm8FNLRs=; b=GKlBD7mBOLTui1YWuIRGXd/Wsi7W8zU6Hl3ndOIYO/9y
        u3iVmCfrwHZv4tqVAQlDcD+kGopt+p4pRrzO7E/FDInq92OELfaUzb0UtZo2ur/i
        ZD/rnbN9S+H+M79V3vx5Wqi0F8VitQFwekjXDr5bXouOENAWK6xLrGwq89KU9f4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CyYcqZ
        PymUcQOmZufIkyNwpe8b5gDDYqTXAF6R4IBumnWvRJVuSLnysJ2swnwWuqJ/yhJr
        9UuLvSiAU2UK4fsTkuQZc3mTezw0SFUnGEMSuJBE3x/EmYN9qiqniK8twKiP/tQg
        FxreL31LBVjXVjQh5zQAVdoki4btwNkpIH7tc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC85BB0896;
        Tue, 30 Mar 2021 19:14:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2021DB0895;
        Tue, 30 Mar 2021 19:14:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 02/22] test-lib-functions: document and test
 test_commit --no-tag
References: <20210203032811.14979-1-avarab@gmail.com>
        <20210216115801.4773-3-avarab@gmail.com>
Date:   Tue, 30 Mar 2021 16:14:09 -0700
In-Reply-To: <20210216115801.4773-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Feb 2021 12:57:41 +0100")
Message-ID: <xmqqa6qkb5fi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A238BD90-91AD-11EB-9648-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> @@ -242,7 +245,10 @@ test_commit () {
>  	git ${indir:+ -C "$indir"} commit \
>  	    ${author:+ --author "$author"} \
>  	    $signoff -m "$1" &&
> -	if test -z "$no_tag"
> +	if test -n "$no_tag" -a $# -eq 4

Let's spell it

	test -n "$no_tag" && test $# =3D 4

to avoid clueless newbie from cargo-culting the use of '-o' and '-a'
with test in an unsafe context, even though the way you used it here
is perfectly safe.

> +	then
> +		BUG "expect no <tag> parameter with --no-tag"
> +	elif test -z "$no_tag"
>  	then
>  		git ${indir:+ -C "$indir"} tag "${4:-$1}"
>  	fi
