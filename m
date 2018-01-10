Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79AA01F404
	for <e@80x24.org>; Wed, 10 Jan 2018 20:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752472AbeAJUnu (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 15:43:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58388 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752458AbeAJUns (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 15:43:48 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F5E5D218A;
        Wed, 10 Jan 2018 15:43:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=meOKFQ41MFaT
        L0FoCDdY6Ml/bkw=; b=qzjqTMtxVYxvhwo8PDl/eWkmPYbW7BZstOsceDGz4dW1
        RobtJrQ/tiUxlRHElK04GTIncDIDY3OCrIRVuyRhcDvUOHkF8x2evwyCqE2iYGpS
        MJONbcQLLBJpwb/3cNVC8/ljkoNeHTzwpCgvfMBH6Re9mhbvIQ3n+ffolB3j+D4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Ctwb0z
        2ffOnfCenT+hUuNvUA+8w/49/gqW5B/QsrddghFirykI/iY2J2DO+CckkUtMtyvR
        Wo+T3hv8k4lqWrGUbGG1R1W2n8ZiCSx5Nt55I86qruw9xOiO4B4srXMPmAL1Y+pO
        1ey16XVMT10g3661w09lPB0n4IDG/OWqDaaMY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 381AAD2189;
        Wed, 10 Jan 2018 15:43:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF979D2188;
        Wed, 10 Jan 2018 15:43:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/2] the cat-file -e option doesn't work as documented
References: <20180110125554.12582-1-avarab@gmail.com>
Date:   Wed, 10 Jan 2018 12:43:46 -0800
In-Reply-To: <20180110125554.12582-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 10 Jan 2018 12:55:52 +0000")
Message-ID: <xmqqbmi11m2l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F50A8D7E-F646-11E7-BE5D-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The -e option to cat-file will emit output, after promising not to.
>
> We should take either 1/2 or 2/2, but not both. I'm partial to just
> documenting the existing behavior and dropping 2/2, it's useful to
> know if you passed in something that didn't look like a SHA-1.
>
> But if others disagree we can drop 1/2 and take 2/2. Up to you.
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
>   cat-file doc: document that -e will return some output
>   cat-file: -e should not emit output on stderr
>
>  Documentation/git-cat-file.txt | 7 ++++---
>  builtin/cat-file.c             | 8 ++++++--
>  t/t1006-cat-file.sh            | 7 +++++++
>  3 files changed, 17 insertions(+), 5 deletions(-)

I am kind of confused. =20

When the doc there says "no output", I read it as "no output", and
no other restriction (like suppressing an error diagnosis, which is
not even sent to the standard output stream).

