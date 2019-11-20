Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4A1C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 03:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F3D2245D
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 03:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wsQB0WhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfKTDCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 22:02:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58715 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfKTDCT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 22:02:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 00D3F22AEB;
        Tue, 19 Nov 2019 22:02:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Xixm9VSksz1v
        gCL+ryAGyzHcaFY=; b=wsQB0WhEUleV1u2HGMpoVpDJ/dO5F3WGdR24gnDR26/G
        iN8Qyg2MwVBfz55VMv30SsCKyo95FszI/TvbWXRo/oZns3wiQBueYJEnnUlhv5Gm
        T1X6dbP5DXWHQLMir00Ud48zj4iJP8A5cfgfIb2Q5LRqtYcnmBqpfiaI/eh1Xb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hXCVbb
        5CkuQkDquEDz8UuZw+t+F0GN6RhW/R80RK9cT+3+Ekpz/RPWf2cga7w3qyp09VvM
        pRceqzLFcWwJRo75s784WQrT+ptqF5csW6v3qjfeZqqRiY5m/V1f0dXrYhO1+O/w
        TLMoD47HsQ6rQZAHPy1MFLEZxMGKR69SXY4xo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB58422AE9;
        Tue, 19 Nov 2019 22:02:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5A2EC22AE7;
        Tue, 19 Nov 2019 22:02:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2019, #03; Tue, 19)
References: <xmqqftikxs4z.fsf@gitster-ct.c.googlers.com>
        <20191119175850.GL23183@szeder.dev>
Date:   Wed, 20 Nov 2019 12:02:16 +0900
In-Reply-To: <20191119175850.GL23183@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Tue, 19 Nov 2019 18:58:50 +0100")
Message-ID: <xmqqzhgrcksn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 291EEE0E-0B42-11EA-BC99-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Tue, Nov 19, 2019 at 04:05:48PM +0900, Junio C Hamano wrote:
>> * ds/commit-graph-delay-gen-progress (2019-11-07) 1 commit
>>   (merged to 'next' on 2019-11-19 at afa7c921be)
>>  + commit-graph: use start_delayed_progress()
>
> This commit is incomplete:

Ah, this is also just 2/2 of a two-patch pair; I guess I was extra
sloppy on that day.

It seems that 1/2 was also incomplete, so let me discard this and
expect both of them to resurface later.

>> * ds/sparse-cone (2019-10-23) 17 commits
>>   (merged to 'next' on 2019-11-19 at 1eb4b3a012)
>>  + sparse-checkout: cone mode should not interact with .gitignore
>>  + sparse-checkout: write using lockfile
>>  + sparse-checkout: update working directory in-process
>>  + sparse-checkout: sanitize for nested folders
>>  + read-tree: show progress by default
>
> This commit changed the default behaviour of a plumbing command, and
> the resulting discussion concluded that such a change is not
> desirable:

OK.  I had an impression that it was something relatively easily
patched to restore the plumbing behaviour without taking the
remainder of the series with a follow-on work.  If it is not the
case, perhaps I should revert the merge to 'next' and kick it back
to 'pu'.

Thanks for stopping me.
