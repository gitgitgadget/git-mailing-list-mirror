Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4BCC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 18:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbiCIS64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 13:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbiCIS6y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 13:58:54 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39CA46158
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 10:57:55 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E59510BDD5;
        Wed,  9 Mar 2022 13:57:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1slgof3GgSAO
        cIo7h2WarbsK1VvZDFYP5Jlnoo5xQrg=; b=H8J5cBSPms6b8yZxfDozf/SX6+wz
        CHa6Sb8UHf6FA5zCM76rDbuE18rxnklHEOHYz1So0GGbVZys7oTrvGNz6KexM+Ow
        LxmSXIX7yKQlMz71/dXS3iTcOizEIpYZqMOzwnedO8Y0ajgfhWkucZsDtbdf1UjF
        3z5J6T60zY/vuv0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AF8310BDD4;
        Wed,  9 Mar 2022 13:57:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4DD1B10BDD2;
        Wed,  9 Mar 2022 13:57:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 16/30] compat/fsmonitor/fsm-listen-darwin: add MacOS
 header files for FSEvent
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <cdef9730b3f93a6f0f98d68ffb81bcb89d6e698e.1646160212.git.gitgitgadget@gmail.com>
        <220307.86h78a2gcn.gmgdl@evledraar.gmail.com>
        <1a060357-3296-81d5-bf23-a55263ef6d10@jeffhostetler.com>
Date:   Wed, 09 Mar 2022 10:57:52 -0800
In-Reply-To: <1a060357-3296-81d5-bf23-a55263ef6d10@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 9 Mar 2022 08:37:41 -0500")
Message-ID: <xmqqk0d3kl73.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D3036F56-9FDA-11EC-BD23-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 3/7/22 5:37 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:
>>=20
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>> [...]
> [...]
>
> =C3=86var sent feedback (thanks!) on 8 commits in the V6 version
> on March 7.  I started responding to each as I got to them
> in my inbox yesterday, but I'd like to take a break from
> responding individually to each of them inside of Part 2.
>
> Since most of the feedback is for "general cleanup" and since
> Part 2 V6 is already in "next", I'd like to revisit these
> issues with a few "cleanup" commits on top of Part 3 (which
> is still in active review), rather than re-rolling or
> appending "fixup" commits onto Part 2.

Sounds good.  Prepending "preliminary clean-up" before part 3 would
be even cleaner, I would suspect.

In any case, let's consider part 2 "more or less done" unless we see
a glaring mistake that requires us to revert and redo it from
scratch.

Thanks.
