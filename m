Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6809AC47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 18:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E68E20735
	for <git@archiver.kernel.org>; Tue,  5 May 2020 18:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lCGUueZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgEEStP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 14:49:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60270 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgEEStO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 14:49:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A246F5656E;
        Tue,  5 May 2020 14:49:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Us5c8IsZvNWX
        jA+3sjZ0RxNfVAQ=; b=lCGUueZrSyOh7Hqq7anV0zIvYZdsc3mRio8Jt7NAdpbq
        VDRz3BUk1jVsNemUkdT4T7kWdvVWwCM/tNmLWsYSTV++xKKuOcbfcYrqIyyL/Od3
        1aHmDF09WhJ0nBoz6wJlA4jAqudNSaPDZ2SCPS/4RVi902KgQjJiRijiMizG6D4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=HG0evJ
        2cMxlsNvwDX57LUjs+fpxOzGWAZxeLmGxk+t3fSNn2GN7rvizJyUrLqIY8378ncA
        cQILy4UZhpW+b99ysQYRHV4iUVJA2ca2vf6Eb7QgygN394m9rEPKY8WSHR9KMjLN
        A4LVkLQf5/z6/P0Wot4g6Y3z2eu5Sb2haSOX0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A4F55656D;
        Tue,  5 May 2020 14:49:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 297115656C;
        Tue,  5 May 2020 14:49:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/3] CI: limit GitHub Actions to designated branches
References: <cover.1588607262.git.congdanhqx@gmail.com>
        <cover.1588695295.git.congdanhqx@gmail.com>
        <a4c6f687c0a8ce55863a19a1c4048438f02803b5.1588695295.git.congdanhqx@gmail.com>
Date:   Tue, 05 May 2020 11:49:11 -0700
In-Reply-To: <a4c6f687c0a8ce55863a19a1c4048438f02803b5.1588695295.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Tue, 5 May
 2020 23:26:40 +0700")
Message-ID: <xmqq4ksub4k8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1C5E202A-8F01-11EA-BBEE-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Git's maintainer usually don't have enough time to debug the failure of
> invidual feature branch, they usually want to look at intergration
> branches only.

Please please please do not make this thing about me.  I do not have
Actions enabled at https://github.com/gitster/git/ repository anyway.

Instead, please focus on making the end result useful for general
contributors.

> Contributors now can have GitHub Actions as an opt-in option,
> should they want to check their code, they will push into designated
> branch.

OK, so this is an opt-in approach as you outlined in the cover
letter.

> +  pull_request:
> +  push:
> +    branches:
> +      - maint
> +      - master
> +      - next
> +      - jch
> +      - pu
> +      - 'for-ci**'
> +    tags:
> +      - '**'
> +      - '!**wip**'

I agree with the agreement you and Peff reached about for-ci plus
for-ci/** patterns and building only v[0-9] tags in your discussion
downthread.

Thaks.
