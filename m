Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3BCC433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 16:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344122AbiFCQyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 12:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344119AbiFCQyl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 12:54:41 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3654E386
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 09:54:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 913AB19832B;
        Fri,  3 Jun 2022 12:54:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uxfI8dm8Vtyf
        pKdxWiUJ8azLVt2q31X9E7/QcP7mLUM=; b=oGgo3Bsa5qauj6juDYOCM/Q5eBvE
        bm8RV581hnzBFn/0Oq3+EKeLheG639Q7S7XWX+5EflQ5HkWE0K6pLjyDHyXcdHqJ
        Ddai5XcXm4P71hy5eW1E1bykJ/0IGTBOZb6MyHIv/NKkQiA4UmSDEeINUvdG4SFc
        ufLmKOvQGXFI4Qc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8934319832A;
        Fri,  3 Jun 2022 12:54:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 35DA8198329;
        Fri,  3 Jun 2022 12:54:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, bagasdotme@gmail.com,
        johannes.Schindelin@gmx.de, Guy Maurel <guy.j@maurel.de>,
        Randall Becker <rsbecker@nexbridge.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 2/4] git-compat-util: avoid failing dir ownership
 checks if running privileged
References: <20220510174616.18629-1-carenas@gmail.com>
        <20220513010020.55361-1-carenas@gmail.com>
        <20220513010020.55361-3-carenas@gmail.com>
        <20220603110507.GA1749@szeder.dev>
Date:   Fri, 03 Jun 2022 09:54:34 -0700
In-Reply-To: <20220603110507.GA1749@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Fri, 3 Jun 2022 13:05:07 +0200")
Message-ID: <xmqqtu91helx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D8EAC9B6-E35D-11EC-800E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Unfortunately, I haven't been able to follow the discussion on this
> patch series at all, but by a cursory look now I didn't notice any
> discussion about what should happen if someone were to use 'sudo' to
> access a repository owned by root.  I think it should work, and it did
> in fact work in the past, even after bdc77d1d685, but this patch
> broke it.

I thought 4/4 of the series was meant to discuss that?  Right now it
is split out as Carlo was hesitant to push the step forward?

https://lore.kernel.org/git/20220519152344.ktrifm3pc42bjruh@Carlos-MacBoo=
k-Pro-2.local/

