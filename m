Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90951F461
	for <e@80x24.org>; Wed,  3 Jul 2019 16:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfGCQ61 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 12:58:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63515 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCQ61 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 12:58:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2390115A92E;
        Wed,  3 Jul 2019 12:58:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FmT8XeuLefDL
        s3EUsfw5hmOufTU=; b=x4/5BfvgKtjJEHao0LwXSWuhYZV5uFYx0wfwaCYB2myT
        LFFpa6Uw15Ov8oabKzUgJcNt7i65g0kxK2P/QwjH+6M3Dr5QqbYWv1oDY2xcnDr6
        Tt5UN19sANvtZ4Mq16U/i6Bky0SWzFweboaoeRDrkSmHduPIsqgS38DtMWh8hi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Lia1n0
        gMkTFiR8Ki+FugyxjgluSt1af6oLPDp9UrmvcymiXI4PGKrTppgH2K0vlIGOOM8J
        x14dua9Ei/hpwAAUSNu9Q2PLQSLxEDkLsKpDYVYIFkxQoKY7ZzX8unsd39WN2zpQ
        N/UuX8+qXfxnDC/0/wG/pq4EiAJX8pcBJFr6k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A72B15A92D;
        Wed,  3 Jul 2019 12:58:22 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 81F7A15A92C;
        Wed,  3 Jul 2019 12:58:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] ci: disable Homebrew's auto cleanup
References: <20190629170108.GF21574@szeder.dev>
        <20190703104748.32533-1-szeder.dev@gmail.com>
        <20190703104748.32533-2-szeder.dev@gmail.com>
        <1d10ed33-5c33-8028-c375-d859ef6826dc@virtuell-zuhause.de>
        <20190703130434.GR21574@szeder.dev>
Date:   Wed, 03 Jul 2019 09:58:20 -0700
In-Reply-To: <20190703130434.GR21574@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Wed, 3 Jul 2019 15:04:34 +0200")
Message-ID: <xmqq1rz72gyb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C37676FE-9DB3-11E9-9B01-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Wed, Jul 03, 2019 at 02:26:21PM +0200, Thomas Braun wrote:
>> Am 03.07.2019 um 12:47 schrieb SZEDER G=C3=A1bor:
>> > Lately Homebrew learned to automagically clean up information about
>> > outdated packages during other 'brew' commands, which might be usefu=
l
>> > for the avarage user, but is a waste of time in CI build jobs, becau=
se
>> > the next build jobs will start from the exact same image containing
>> > the same outdated packages anyway.
>> >=20
>> > Export HOMEBREW_NO_AUTO_UPDATE=3D1 to disable this auto cleanup feat=
ure,
>>=20
>> The patch below adds HOMEBREW_NO_INSTALL_CLEANUP so maybe you meant
>> HOMEBREW_NO_INSTALL_CLEANUP here as well?
>
> Thanks, good catch.  Apparently copy-pasted the wrong env var from the
> patch to the commit message...

Applied an obvious rewording manually while queuing.

Thanks.

commit af8ed04778781f2013d26cc450173190fb5876d6
Author: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Date:   Wed Jul 3 12:47:48 2019 +0200

    ci: disable Homebrew's auto cleanup
   =20
    Lately Homebrew learned to automagically clean up information about
    outdated packages during other 'brew' commands, which might be useful
    for the avarage user, but is a waste of time in CI build jobs, becaus=
e
    the next build jobs will start from the exact same image containing
    the same outdated packages anyway.
   =20
    Export HOMEBREW_NO_INSTALL_CLEANUP=3D1 to disable this auto cleanup f=
eature,
    shaving off about 20-30s from the time needed to install dependencies
    in our macOS build jobs on Travis CI.
   =20
    Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
