Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2E2C433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 23:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiAUXXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 18:23:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55488 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiAUXXT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 18:23:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A9220185E5E;
        Fri, 21 Jan 2022 18:23:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=an0NGi2GV4rY
        4j8/6jVtd0Ss2vrYFj2TXZ7qkYySloE=; b=m/LZ4klE/9Y4q2mMbUkBPzH0zNIm
        r7Gg6EzFnSg/OVOAL+Rq+ik15v+fxxCVAV6PCVTk9E8kw6CrbrSzCPVrfZzMFskE
        jJ109Gor0SUT2ze/BgR+Bj76GbOzlfCO8z25H7cztirmIzKky2svC/+WaIIVmaLm
        f6edTchqRGxIeE4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 94749185E5D;
        Fri, 21 Jan 2022 18:23:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F14D9185E5C;
        Fri, 21 Jan 2022 18:23:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3] cache.h: auto-detect if zlib has uncompress2()
References: <patch-v2-1.1-444eacf30be-20220119T094428Z-avarab@gmail.com>
        <patch-v3-1.1-e9cb8763fd4-20220120T011414Z-avarab@gmail.com>
Date:   Fri, 21 Jan 2022 15:23:14 -0800
In-Reply-To: <patch-v3-1.1-e9cb8763fd4-20220120T011414Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 20 Jan
 2022 02:16:03
        +0100")
Message-ID: <xmqqr190ekrh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1C3CD48A-7B11-11EC-9C13-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> As noted in the updated commit message this approach of having an
> object just for this fallback function comes at the cost of some
> complexity, but now the compat object lives neatly in its own object.

I do not see any change in this patch adding costly complexity, but
I notice lack of one possible trick that might become problem with
some compilers and linkers when their zlib has uncompress2()
function.  Let's have this graduate very early in the next cycle, to
see if anybody on a rarer system sees a complaint due to having to
deal with a totally empty object file.

Will queue.
