Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31842C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 04:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF93020898
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 04:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E/Jq+QGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfKUEyz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 23:54:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60482 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKUEyz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 23:54:55 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E4ABACE4A;
        Wed, 20 Nov 2019 23:54:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WnOKGWfhIJbv
        A2asfXKDgZDM1pg=; b=E/Jq+QGzFud0ffRrK/Bj0YfvOslWxIizrZrljxDRcmly
        jnrdvl72AGRLIuG3YdyEWM4f27VrP9k96qlAUmTRxmW+6b96+lcKWOJYkydGbZFi
        SrqW0z1yezRppZ8Ja3+zlOPjU1SMCPjAZelP/SPjYHsqyKE4jx+D01/dW6OI2u0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IZOsJf
        hC+/qei6UNu4k/CTkYOr15TAcf9pxkCLsxVAvcnTLdkAdJ5MEBaActiqTL8g0DXz
        nyuNMakzI7DnssV8Jc1x0YVibGVNDhEVxqMbKq5Jl1NRC5Qq4MBgTfzMYtTW/I5a
        AcmcLW2eFmnCY2EvnsrRQuguIKpbt+jahX3MQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95C2BACE49;
        Wed, 20 Nov 2019 23:54:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B702AACE47;
        Wed, 20 Nov 2019 23:54:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/8] t1300: modernize part of script
References: <cover.1573670565.git.martin.agren@gmail.com>
        <37e2b121d5946cfacb3fc4d2721770e496f7b752.1573670565.git.martin.agren@gmail.com>
Date:   Thu, 21 Nov 2019 13:54:46 +0900
In-Reply-To: <37e2b121d5946cfacb3fc4d2721770e496f7b752.1573670565.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 13 Nov 2019 19:55:01
 +0100")
Message-ID: <xmqq8so9akx5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0CDC75AC-0C1B-11EA-8902-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Create `.git/config` and `expect` files inside `test_expect_success`,
> either inside the one existing test that uses the file, or in a new
> "setup" step before several tests that use it.
>
> Redirect using `>output` rather than `> output`. Use `<<-\EOF" with
> heredocs rather than just `<< EOF` and use `q_to_tab` to create properl=
y
> indented input and output files.
>
> This commit does not modernize the whole script, but just some of it,
> around the point where a later commit will add new content.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  t/t1300-config.sh | 138 ++++++++++++++++++++++------------------------
>  1 file changed, 65 insertions(+), 73 deletions(-)

Thanks.  All conversions looked OK.

