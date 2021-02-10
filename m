Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479DDC433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 16:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 074D460C3F
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 16:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhBJQ2P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:28:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59798 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbhBJQ2I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 11:28:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD644A0960;
        Wed, 10 Feb 2021 11:27:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7VDDLTZYMJMd
        k4Y9LSjuQJxc2HI=; b=X/dwKuq158vxCL8URDqehB56Id7E2rFpBsWFireFAFFk
        Qthji3ZaXfAlxcqAuqNZsux6qGmA/z2XVZ0IsmRnwMpqt7Qirx5TAlPC50UiNgNi
        PNBcJpIJKWlKk4JCCK8s//pitvv1c/7u6y7SqMlpOzyXvr0FpyT4FWtqJohnKq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=cbMPmw
        uKYfI7qfgrJk1ZXoMNTDDvvbms11bQMr/W8nTNCXmEaWATI3JVQBfUTxweirVIVb
        c7tRP4T0sFIRyyfSWNGX+vIQ3fdZhI9j7rFal2cFyam49eJAEnNrQf2EbvPhRDbE
        8wnjUHwnYkcXbhKUfatdylpqfr3zA+x8Mfkwk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C48DFA095F;
        Wed, 10 Feb 2021 11:27:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4BBA7A0958;
        Wed, 10 Feb 2021 11:27:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     lilinchao@oschina.cn
Cc:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, "Derrick Stolee" <stolee@gmail.com>,
        dscho <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] builtin/clone.c: add --reject-shallow option
References: <pull.865.v2.git.1612773119.gitgitgadget@gmail.com>
        <pull.865.v3.git.1612793576910.gitgitgadget@gmail.com>
        <026bd8966b1611eb975aa4badb2c2b1190694@pobox.com>
        <5c4295e46b7f11eb8acc0024e87935e7@oschina.cn>
Date:   Wed, 10 Feb 2021 08:27:20 -0800
In-Reply-To: <5c4295e46b7f11eb8acc0024e87935e7@oschina.cn>
        (lilinchao@oschina.cn's message of "Wed, 10 Feb 2021 17:07:08 +0800")
Message-ID: <xmqq5z2z51nb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DA2B70D8-6BBC-11EB-822A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"lilinchao@oschina.cn" <lilinchao@oschina.cn> writes:

> Sorry, you may forget there is a re-read git-config under these lines

Ahhhh, thanks.  You're right that "clone" is "special" in that way
and requires unusual order---I forgot about that.

>>This is only for cloning from a local repository, no?=C2=A0 IOW, path a=
t
>>this point may even be "git://github.com/git/git/" and checking with
>>access() does not make sense.
>>
>>Ah, it is even worse.=C2=A0 get_repo_path() can return NULL, so mkpath(=
)
>>will crash in such a case.=C2=A0 This must be at least
>>
>>	if (path && !access(mkpath("%s/shallow", path), F_OK))
>>	is_shallow =3D 1;
>> ...
>>
>>So, I think the above two hunks are making the code worse.=C2=A0 If we
>>are to detect and reject cloning from the shallow repository when
>>going through the transport layer (i.e. "--no-local" or cloning from
>>"git://github.com/git/git", or "https://github.com/git/git", if it
>>were a shallow repository), that must be handled separately.
>>=20
> Sorry, I made the question simple. Reject cloning a shallow repository
> should apply to all four type transport protocols. There still a bunch =
of
> work to be done.

Sorry, but I didn't realize that this is just a work-in-progress
that shows an early "only local transport is covered" preview.  I
think, modulo that the access(mkpath()) thing should be in the "if
(is_local)" block, the patch covers the case of local transport well
enough.  I think by "four types of transport" you mean ssh://, git://
https:// etc., but they all go through the same transport API, so
hopefully once one of them, say, git://, is covered, that would take
us a long way.

Thanks.
