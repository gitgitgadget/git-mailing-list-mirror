Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D1CC43470
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8620761429
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbhELX3a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:29:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50932 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbhELXZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 19:25:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81F13CF530;
        Wed, 12 May 2021 19:24:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vmeiLlfA54go
        9w4rOUJLk0LXcVEhs0dOwWhalwP3mH8=; b=LkWNGTlpqJ19Gfw2DBDuk5pmQYhU
        pGRy8um8blLeFYF8cau3r3GEoo1OG/zDb5dRPcn4esLohDeCEkps5GsBKeC5LQK+
        jH7Tr8XaOYs9AfN938l5rxXMacWV1C/1yGaqtGJbwmU1LWGu9mSKbQsFEpY/egNy
        2TSDFjUPb9zm8Sg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 785D1CF52F;
        Wed, 12 May 2021 19:24:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F2B5BCF52E;
        Wed, 12 May 2021 19:24:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v6 00/11] test-lib.sh: new test_commit args,
 simplification & fixes
References: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
        <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
        <YJvH78MxAWy+Xg6e@danh.dev>
Date:   Thu, 13 May 2021 08:24:46 +0900
In-Reply-To: <YJvH78MxAWy+Xg6e@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Wed, 12 May 2021 19:19:59 +0700")
Message-ID: <xmqqbl9feds1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3D8FC1FC-B379-11EB-88FC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> On 2021-05-10 16:18:59+0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>> Changes since v5 only trivial commit message / comment fixes suggested
>> by =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh. Thanks! Link to v5:
>> http://lore.kernel.org/git/cover-00.11-00000000000-20210423T072006Z-av=
arab@gmail.com
>
> I skimmed over this series and I think it's in a good shape now.
> So, FWIW.
>
> Acked-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.=
com>

Thanks.
