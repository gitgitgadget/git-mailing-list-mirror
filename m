Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D0CC43219
	for <git@archiver.kernel.org>; Sat,  1 Oct 2022 16:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiJAQyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Oct 2022 12:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJAQxw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2022 12:53:52 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AD5111A
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 09:53:50 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3D7A143EAD;
        Sat,  1 Oct 2022 12:53:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+yhcbpxgZi5c
        /RhYubNp/axm5CDc6VRSjWy/hwWxzVs=; b=DmpyYnSq/NarFpEgIyR775q9z7Ur
        sAj4lqJ9zrCYY2k8oN6fnPUf6uDzSy4RuEcBzdTGmZOVoRJCZzjVSSe8KURaC/zR
        jKFiPnVuUHiAK3+E44dMOLK8lwEoiWlnc0l6X2vHc/Gb0FzjxSfxncKTcI3CX71W
        aaU38YDfcvcqEE4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBB3F143EAC;
        Sat,  1 Oct 2022 12:53:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 61BFF143EAB;
        Sat,  1 Oct 2022 12:53:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/6] rebase --update-refs: smooth out some rough edges
References: <20220930140948.80367-1-szeder.dev@gmail.com>
        <05c5076b-eb78-5381-4eba-863a84190755@github.com>
        <20221001163105.GA7659@szeder.dev>
Date:   Sat, 01 Oct 2022 09:53:48 -0700
In-Reply-To: <20221001163105.GA7659@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Sat, 1 Oct 2022 18:31:05 +0200")
Message-ID: <xmqqsfk75vtv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9F2D1DB4-41A9-11ED-AE97-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Fri, Sep 30, 2022 at 01:29:58PM -0400, Derrick Stolee wrote:
>> On 9/30/2022 10:09 AM, SZEDER G=C3=A1bor wrote:
>> > A couple of cleanups and fixes to a new 'git rebase --update-refs' f=
eature
>> > introduced in the current release cycle.
>
>> Junio: I don't think any of this needs to rush into v2.38.0, since
>> they are mostly cosmetic changes and helping users get out of bad
>> situations.
>
> I do think that we shouldn't have a release where an 'update-ref'
> instruction can update anything outside the refs/ hierarchy, so we
> don't have to worry about potential backwards incompatibility when we
> restrict it later or add DWIMery.
The thing is, the changes we did relative to v2.37 in order to have
the update-refs feature had some time to cook to show to those who
use pre-release versions that even with these changes, the other
parts of the system, especially "rebase", weren't negatively
affected with unintended bugs, at least in the use cases they have.
This 6-patch series right off the press that are _intended_ to touch
only the update-refs feature had none.  It simply is too late in the
cycle.

So I doubt that it is safer to ship the release with them than
without.  They could be in the zero-th batch in the next cycle,
though.

Thanks.
