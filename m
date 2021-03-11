Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FA9C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 22:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A2F364D9A
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 22:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhCKW0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 17:26:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54850 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhCKW0O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 17:26:14 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3B36BDDEE;
        Thu, 11 Mar 2021 17:26:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=fKKhxOEGR6E3Pgr4VJ8lwm/xt
        K0=; b=FEbAZAoCzmQ7/u0XTmRILgtJBx2ygSmyw38NddpQ/YyKlXuYg/lTE8bYT
        AtR05hWAFy2m0Cr/7Kg/5LrXF019uS9EUARSToHccjbaHqgt0gVtbtLDORDA+o6/
        MgUnD/rN9YEq6AYtmdoSyCbpPIVkEDuPL88IjdmzhgnH2+c6WQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=C1dO8wrRIG8Q27iB2Qo
        tJxuKPs0cp15eq0pzX5zDta4VwASAoMqmkqRuIb0wVVB+6p0RF0Y61tVZlsHHOtQ
        hdoe+BAH0Qp4MpnU97QzQAbVG83eIzmE+rVXAMriqvms9cnP+8r++f4CQQ4Vaj2z
        alJ+fzRmG/RI6WKH//eLxTQE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9684CBDDED;
        Thu, 11 Mar 2021 17:26:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A18F2BDDEC;
        Thu, 11 Mar 2021 17:26:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6?= =?utf-8?Q?r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v8 00/37] config-based hooks
References: <20210311021037.3001235-1-emilyshaffer@google.com>
Date:   Thu, 11 Mar 2021 14:26:10 -0800
Message-ID: <xmqqim5xba4d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C8AAA9E2-82B8-11EB-A31E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Since v7:
> - Addressed Jonathan Tan's review of part I
> - Addressed Junio's review of part I and II
> - Combined parts I and II
>
> I think the updates to patch 1 between the rest of the work I've been
> doing probably have covered =C3=86var's comments.
>
> More details about per-patch changes found in the notes on each mail (I
> hope).
>
> I know that Junio was talking about merging v7 after Josh Steadmon's
> review and I asked him not to - this reroll has those changes from
> Jonathan Tan's review that I was wanting to wait for.

I picked it up and replaced, not necessarily because it is an urgent
thing to do during the pre-release period, but primarily because I
wanted to be prepared for any nasty surprises by unmanageable
conflicts I may have to face once the current cycle is over.

It turns out that it was a bit painful to merge to 'seen' as there
are in-flight topics that touch the hooks documentation, and the
changes they make must be carried forward to the new file.

But it was not too bad. =20

The merge into 'seen' is 3cdeaeab (Merge branch 'es/config-hooks'
into seen, 2021-03-11) as of this writing, and the output of

    $ git diff 3cdeaeab3a^:Documentation/githooks.txt \
               3cdeaeab3a:Documentation/native-hooks.txt

    (i.e. the version of the file before the merge, where your topic
    being merged took material to edit to produce the new "native-hooks"
    document, is compared with the result)

looks reasonable to me, but please double check.

Thanks.
