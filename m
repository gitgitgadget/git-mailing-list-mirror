Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95568C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 19:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3545B2168B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 19:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sp3r82ai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbgLATID (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 14:08:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51472 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbgLATIC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 14:08:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F3499FE91;
        Tue,  1 Dec 2020 14:07:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AZy7DWQKIPc/
        BfTmmp8wC14iEzk=; b=Sp3r82aiqCpe7+2HLRFXgYRNmzeUgjnb4V8qEMm1d80F
        1sPkAwMJ8l3SXax1L6mbP6fDghTckbvmKNUB3S29Z/teCgQkCl/LrTElbiydTzKg
        +ymzOU/f3chAiugVV3/iNnJF+4mMWaGKOqE3iuMME+zAsw1xX6NwPurFMTF64SM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jjNzde
        10STG6jjyj5cfaaAINBhgjMJqZy+6cW5eywFejiYYzb2tFh8/aTkHIUMFHsfS3aD
        uVJB/u4MAO+bZMXwRCKmvLgfQmZTd5wmi6mA0z+OydK88bHGAe2f/Q+7K5hY+m6B
        6BPqChl3u4tlK5a6qFYqPbmBxWovQbVBTFH64=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0147E9FE90;
        Tue,  1 Dec 2020 14:07:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A73D9FE8F;
        Tue,  1 Dec 2020 14:07:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] MaintNotes: use https:// instead of git:// when possible
References: <20201201094623.4290-1-avarab@gmail.com>
        <20201201095815.12850-1-avarab@gmail.com>
        <X8Yu5CephK3uvMeV@coredump.intra.peff.net>
Date:   Tue, 01 Dec 2020 11:07:17 -0800
In-Reply-To: <X8Yu5CephK3uvMeV@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 1 Dec 2020 06:54:12 -0500")
Message-ID: <xmqq360pqra2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6E9EDC06-3408-11EB-A9B4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Dec 01, 2020 at 10:58:15AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> Change advertised git:// links to https://. These all work as
>> arguments to "git clone", but in addition they also have friendly web
>> interfaces.
>
> This is a good idea, I think. Not only for that reason, but because
> https:// is more secure. You can verify tags from the maintainer's
> signature, of course, but if you are just fetching some refs, you are
> relying on the remote server not to lie to you. With https://, you at
> least have some assurance that it is the remote server you intended to
> talk to, and not a man-in-the-middle over the totally unauthenticated
> git:// protocol.
>
>> This leaves just git://ozlabs.org/~paulus/gitk as the only git://
>> URL. As far as I can tell there's no web interface for it. There is
>> e.g. https://git.ozlabs.org/?p=3Dppp.git which is a frontend for
>> git://git.ozlabs.org/~paulus/ppp.git, but even though cloning the repo
>> at git://git.ozlabs.org/~paulus/gitk.git works (not the "git" subdomai=
n)
>
> s/not/note/ in this last line?

With or without the tweak, I couldn't figure out what the paragraph
wanted to say.  On the other hand, I didn't quite get why "friendly
web interfaces" matters until trying to read the paragraph again to
realize that it was talking about repository browser like gitweb and
cgit.

I'd probably rephrase the entire proposed commit log message to
something like:

	Most git:// URLs listed for the copies of the Git repository
	have working corresponding https:// URLs that can be given
	to a browser to browse the repository interactively.  List
	https:// URL instead of git:// URL for such repositories.
	The former is also more secure, even though it may be more
	expensive.

without mentioning ozlabs at all.

Thanks.
