Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3F3C433EF
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 18:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350791AbiD1SP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 14:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350792AbiD1SPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 14:15:25 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF21BAB95
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 11:12:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D50713EAED;
        Thu, 28 Apr 2022 14:12:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DPfKtBSM5aWc
        VwlXbaBfZCpQ/jhuUzlrfJ760pHGK1s=; b=gHtIC1eu0be/NmELdJ0C722DQKBM
        4AvTDsxt63AaeanfVtNWzxFRMZHbGW/xbZWwkCNnyiCJGnbnfBJGq2+tcWNFx69T
        +xLdsVRGl0H5HQNxRl2vXOP31NSoqfYQeoHm5GyaHLdCwNt+J8lpu5651bRSdC5A
        XM4d6QedTtwqKmQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12EFF13EAEC;
        Thu, 28 Apr 2022 14:12:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 083E213EAEB;
        Thu, 28 Apr 2022 14:12:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t: add tests for safe.directory when running
 with sudo
References: <20220428033544.68188-1-carenas@gmail.com>
        <20220428105852.94449-1-carenas@gmail.com>
        <20220428105852.94449-4-carenas@gmail.com>
        <xmqq7d79du6c.fsf@gitster.g>
        <5493b2f1-e59d-d91d-ac21-47c93d2996f2@gmail.com>
Date:   Thu, 28 Apr 2022 11:12:05 -0700
In-Reply-To: <5493b2f1-e59d-d91d-ac21-47c93d2996f2@gmail.com> (Phillip Wood's
        message of "Thu, 28 Apr 2022 19:08:46 +0100")
Message-ID: <xmqq7d79gjre.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B7641898-C71E-11EC-99E5-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 28/04/2022 17:55, Junio C Hamano wrote:
>> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>>=20
>>> +test_description=3D'verify safe.directory checks while running as ro=
ot'
>>> +
>>> +. ./test-lib.sh
>>> +
>>> +if [ "$IKNOWWHATIAMDOING" !=3D "YES" ]; then
>> Style.
>> 	if test "$IKNOWWHATIAMDOING" !=3D "YES"
>> 	then
>
> Also naming - we normally prefix test environment variables with
> GIT_TEST_. IKNOWWHATIAMDOING does not tell us what we are allowing by=20
> setting the variable. Something like GIT_TEST_ALLOW_SUDO would tell us
> what we're letting ourselves in for by setting it.

If this weren't "let's reuse the same mechanism as already used in
1509", I would have had the same reaction.  Renaming would be better
done outside the topic, I would think.

Thanks.
