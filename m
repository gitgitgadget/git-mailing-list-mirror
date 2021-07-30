Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA55C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 19:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 899676052B
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 19:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhG3TDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 15:03:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51902 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhG3TDw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 15:03:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5622DC42D4;
        Fri, 30 Jul 2021 15:03:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LBatzsjjq4bl
        zCHG8/wruCHEgsY+vfyXGeeZAHdd3RM=; b=EU6jXYk8LuPsPHOU2oSbPKt17Iu9
        of1DrTRCeZlDzqFTODCledVwFkgptdPt121erDmpQkUsX+wRERTSPMsWvK6ikT30
        +3R2U6w+enu9FHqREUpwJ2jNYV5fyaiTxCow91gRT0j+YRFbOhrz3m2JsbwUzyX8
        nvARYdpNeNbbatk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C34DC42D3;
        Fri, 30 Jul 2021 15:03:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3B85C42D2;
        Fri, 30 Jul 2021 15:03:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v4 0/5] drop support for ancient curl
References: <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
        <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
Date:   Fri, 30 Jul 2021 12:03:39 -0700
In-Reply-To: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Jul
 2021 19:59:41
        +0200")
Message-ID: <xmqq7dh71v5g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D9D13BFE-F168-11EB-B2F0-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Per the feature creep feedback on v3 this v4 ejects the two new
> changes new in v3. The below range-diff is against v2, not v3.
>
> I dug into the 7.16.4 v.s. 7.17.0 documentation issue and found that
> it's bug in curl's docs, for which I submitted a patch.
>
> I considered keeping
> <patch-v3-5.7-b857a9ef7b1-20210730T092843Z-avarab@gmail.com>, but
> sequencing it in made the range diff quite a bit larger, so per the
> feature creep feedback I ejected it too. Junio: Perhaps you'd like to
> cherry-pick it on top too, or it can be dug up post-release.

Either is fine; it is absolutely correct but "who cares" low impact
patch in the shorter term.  We'd eventually want to have it (and
something in the spirit of "have a central place we know what the
current state of our cURL dependency is", too) for the longer-term,
but they are not in urgent need anyway.

Thanks for working on it.

>     +    The documentation[2] currently claims that it was introduced i=
n
>     +    7.16.4, but the symbols-in-versions file correctly states
>     +    7.17.0[3].
>     +
>     +    I've submitted an upstream
>     +    patch (<patch-1.1-953bab490-20210730T170510Z-avarab@gmail.com>=
) to the
>     +    curl-library mailing list fix the documentation.

I am not sure how to get to the patch, but I suspect you might be
misreading "up to X", which is different from "before X".  Once cURL
mailing list confirms my suspicion, we would need to come back and
update this patch again.

>          1. https://curl.se/libcurl/c/CURLOPT_HTTPAUTH.html
>          2. https://curl.se/libcurl/c/CURLOPT_USE_SSL.html
>     +    3. https://github.com/curl/curl/blob/master/docs/libcurl/symbo=
ls-in-versions
>     =20
>          Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@=
gmail.com>
>     =20
> 5:  64e510b4a6b =3D 5:  e34ab1d1f65 http: rename CURLOPT_FILE to CURLOP=
T_WRITEDATA
