Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14147C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 22:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343851AbhLAWwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 17:52:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52052 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbhLAWwc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 17:52:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7691FAC1B;
        Wed,  1 Dec 2021 17:49:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MyRPw+nIZypX
        sFSXKe6eWs/QV/TtgbVsSxuC8mk6pEE=; b=cAOs6F1oPCTYCX8Z22w7cHdO9c9t
        2f2eHRI2bmpZqHZ15pPtRlaOm9KfFXLsuuF+d92hcTIRbXmDxi98KtK657LZ7JuF
        mQgmw2TPDvN6oYefz8ahhHWnQLIxd8ETD+OhVadNjn+5iVCs/4vl1jbF6Fu8zLO0
        z/+YDkORUTvFN3E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A82B7FAC1A;
        Wed,  1 Dec 2021 17:49:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7AC5FAC19;
        Wed,  1 Dec 2021 17:49:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/3] Fix LLP64 `(size_t)1` compatibility VS C4334
 warnings
References: <20211201002902.1042-1-philipoakley@iee.email>
Date:   Wed, 01 Dec 2021 14:49:07 -0800
In-Reply-To: <20211201002902.1042-1-philipoakley@iee.email> (Philip Oakley's
        message of "Wed, 1 Dec 2021 00:28:59 +0000")
Message-ID: <xmqq5ys8ym8s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E4E2A9DC-52F8-11EC-93F9-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> Since V1 (gitster/po/size-t-for-vs)
> https://lore.kernel.org/git/20211126113614.709-1-philipoakley@iee.email=
/
>
> Former patch 1/4 was dropped as it was already in Junio's tree.
>
> Patch 1/3 corrects my spelling mistake.
>
> Patch 2/3 has added extra spacing around the << operator as suggested b=
y
> Stollee[1].
>
> Patch 3/3 removes the superceded commit message comment regarding
> backporting the patch onto maint.
>
> The Visual Studio MSVC compilation reports a number of C4334 "was 64-bi=
t
> shift intended" size mismatch warnings. In most of these cases a size_t
> is ANDed (masked) with a bit shift of 1, or 1U. On LLP64 systems the un=
ity
> value is 32 bits, while size_t is 64 bits.=20
>
> The fix is to upcast the unity value to size_t.  =20
>
> The first [dropped] patch had been reported [2] by Ren=C3=A9 Scharfe as=
 an extra patch
> to the rs/mergesort series.
>
> These fixes clear all the current C4334 warnings.

Thanks.  Will queue; let's have it in 'next'.
