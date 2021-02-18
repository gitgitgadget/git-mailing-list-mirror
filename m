Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B5CC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825AD64EB7
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhBRWTt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 17:19:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59963 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhBRWTq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 17:19:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 552909A9C1;
        Thu, 18 Feb 2021 17:19:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=r3qxYsjy3eL1
        8W2jHMhgXDix/NA=; b=VxMoYCdLxKS5N/vVkYqsDEF5VhBjkrnOyo/go4ShYaG5
        UI6RyCPUevS7TpBBqvS4p44oUUDcmg0H3rf1EwX0Iu9sbWLb823lgBhMrtxOJOkC
        W+y6I3EAGKaaOmVWu+6JI1wq/QYzTEvcJv6Qmfs1fD/hFI0csViOXTOMpSd2fQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ySwEhr
        gYBBYuhcv8vsaf5ti0Y+PHkvW2PiijrARpRVIg1MmL/yaCgfsBl+bh9OpVJlL3q6
        9aAl/dJKKZ30pT71G1zOJDzMER+r0lQ5khVOaZntn+EHTR2xI4F8oXCXVmQXIsKJ
        KPT+hOszpWpJojgNMwg+1krtXsXMRDj47Vxh8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 459B49A9C0;
        Thu, 18 Feb 2021 17:19:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 83C809A9BE;
        Thu, 18 Feb 2021 17:19:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 00/10] fsck: API improvements (no conflicts with 'seen')
References: <20210217194246.25342-1-avarab@gmail.com>
        <20210218105840.11989-1-avarab@gmail.com>
Date:   Thu, 18 Feb 2021 14:19:02 -0800
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 18 Feb 2021 11:58:30 +0100")
Message-ID: <xmqq7dn5dnop.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4ED162DC-7237-11EB-AA33-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> As suggested in
> https://lore.kernel.org/git/87zh028ctp.fsf@evledraar.gmail.com/ a
> version of this that doesn't conflict with other in-flight topics. I
> can submit the rest later.

And a bystander does not have a clue what this thing is about,
beyond that it tweaks fsck API, how urgent it would be, what benefit
it brings to us?

That kind of things are expected to be described here.

The cover letter of v1 does not do much better job, either, but is
it fair to understand that this primarily is about allowing the
callback functions (which handle various problems fsck machinery
finds) to learn what error it encountered, so that things like
"enumerate missing .gitmodules blobs" 384c9d1c (fetch-pack: print
and use dangling .gitmodules, 2021-01-23) wants to do does not have
to be written by inserting a very narrow custom code into the
general error reporting codepath, but by customizing the error
reporting function?

If so, can we at least say something a bit more specific and
focused, than the overly broad "API improvements"?

THanks.
