Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 952211F4C0
	for <e@80x24.org>; Sun, 20 Oct 2019 00:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfJTAUH (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 20:20:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56617 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfJTAUH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 20:20:07 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EBE1519939;
        Sat, 19 Oct 2019 20:20:04 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=n5t5TzHVHLHF4
        OzGLq7wRzx2qNo=; b=Y6a8C7TjiIyt18/owmBfrBbo2QAYo6wGKdcFCCpM/RCg9
        i4naJZ+w/KhlrCei1Jz9Q+25JwuI+/FhJjnYt4qAw+RmgS1DX4DCepVRz8bxrIvt
        19kD7TDuGaHlc7eTBQfg/S+K1YUyiMWCskx4AwhMLCxLQAyCr3dIBiBHnovTeg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=L2UsTYc
        MzPyCxDEg2EMEPe+mqO9amt1Lc0XK1q38pC4kX6A4Ls1Rf7/s2krOQvC0XQkLePi
        kQgzVXlMi9tfy5ZQNjmIm7JhlU/ToFn0TWpY/8hsO7qxS2lEfoFovrftw7mqh7l2
        5ZKkol92kvg9CtV9Posx22wmulPN4KY/487I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A927D19938;
        Sat, 19 Oct 2019 20:20:04 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5DFE819932;
        Sat, 19 Oct 2019 20:20:02 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Sat, 19 Oct 2019 20:19:59 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-progress: fix test failures on big-endian systems
Message-ID: <20191020001959.GY10893@pobox.com>
References: <b0bec82e-ad0a-32f6-e2e6-e1f0e6920639@physik.fu-berlin.de>
 <20190731071755.GF4545@pobox.com>
 <f1ce445e-6954-8e7b-2dca-3a566ce689a5@physik.fu-berlin.de>
 <20191019233706.GM29845@szeder.dev>
 <f0d216a8-95ee-bdec-4116-012906117aad@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f0d216a8-95ee-bdec-4116-012906117aad@physik.fu-berlin.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 5BD5BF84-F2CF-11E9-ADA4-C28CBED8090B-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

John Paul Adrian Glaubitz wrote:
> Hi G=E1bor!
>=20
> On 10/20/19 1:37 AM, SZEDER G=E1bor wrote:
>> On Sat, Oct 19, 2019 at 11:38:40PM +0200, John Paul Adrian Glaubitz wr=
ote:
>>> The testsuite is failing again on s390x and all other big-endian targ=
ets in
>>> Debian. For a full build log on s390x see [1].
>>=20
>> Gah, my progress display fixes strike again...
>>=20
>> I think the patch below should fix it, but I could only test it on
>> little-endian systems.  Could you please confirm that it indeed works
>> on big-endian as well?
[...]
> I can confirm that your patch fixes the testsuite for me on Debian
> unstable/ppc64 (big-endian).
>=20
> Tested-By: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Yep, that worked well on the Fedora s390x builders as well
(unsurprisingly).

Thanks!

--=20
Todd
