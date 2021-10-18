Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CEBC433F5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 21:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C97A61027
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 21:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhJRVrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 17:47:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53074 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhJRVrF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 17:47:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C30E6147F7F;
        Mon, 18 Oct 2021 17:44:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=T7dSleelDx3i
        3zx6robwY+M3hizfYDJEwBYicQVt44E=; b=SgzKwxuwSTkqvkBFxybVMCSndIrH
        XmJtkLllC2O0T+U0fG9C2q/p+TNolUTN7/asxO2/YWwMQACauI5+9RPqRrWzRsob
        a3TUE/N9pxOYd2+7cKUIEhRlMMrs7ZI1JK79re7345hbgdbb+qPrw04F/tPwu1eY
        ALKm70c8CIxPjw8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB2AB147F7E;
        Mon, 18 Oct 2021 17:44:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 21B49147F74;
        Mon, 18 Oct 2021 17:44:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        emilyshaffer@google.com
Subject: Re: [PATCH v3] branch: add flags and config to inherit tracking
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
        <b9356d9837479914bcf9a265f52afe170be7e2e2.1634445482.git.steadmon@google.com>
        <87a6j6tbsv.fsf@gmgdl.gmail.com>
Date:   Mon, 18 Oct 2021 14:44:49 -0700
In-Reply-To: <87a6j6tbsv.fsf@gmgdl.gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZq?=
 =?utf-8?B?w7Zyw7A=?= Bjarmason"'s
        message of "Mon, 18 Oct 2021 20:31:58 +0200")
Message-ID: <xmqqk0iauhwu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9F6DBE5A-305C-11EC-9E4F-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sat, Oct 16 2021, Josh Steadmon wrote:
>
>> It can be helpful when creating a new branch to use the existing
>> tracking configuration from the branch point. However, there is
>> currently not a method to automatically do so.
>
> There's no method to get *only* that config, but this use-case is why
> the "-c" option (copy branch) was added.

Hmph, I doubt the claim about the original motivation behind "-c",
but it sure sounds like an interesting point of view.  The commit at
the tip, as well as configurations are copied, which is most of the
way there, but I suspect that the --track=3Dinherit is mostly to be
used in the context of "git checkout -b" and the mention of "branch"
is merely for simplicity of the description of this topic, no?  And
you cannot say "git checkout --clone-branch original" (yet).

But it is a very interesting way to twist the point of view.


