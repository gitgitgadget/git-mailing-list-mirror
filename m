Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B89DC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 23:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F8E22E00
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 23:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbhAEXH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 18:07:28 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63421 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbhAEXH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 18:07:27 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C9BD910A455;
        Tue,  5 Jan 2021 18:06:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=fieXXVF/c+Jj5LYKRXbcR4ASx
        jU=; b=j+UOzyS4aQ5UTRC1Hs3SgHT/cChg3uykw2I56QJuMGsXO6QO0VKj9FBdy
        ZD9s7Ohn247nJb93T1Vq93w0kvm4idKHa51jf/HTMk7pTXGnun5RSZV/OB02sICh
        cLvBOTBLis29IbGYUklMhcgR68hyLVUCCzL2V678FzpTNWlr3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=acPcSS7GZ//LbBnKtae
        RxKfeic7blK2s2ID8B3v952xImL6tBQ76WGZ90iUB222roHZKHjVcwEuB6GBshYW
        4ESQZITQ+fkk9iV1IbFYQWmQzF4Fj+RBbPZ0Hc7m9CUdQak95V7CHJa6RF6jazau
        9LkIYXD5n+23XwULvGi3Sufc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C2B4110A454;
        Tue,  5 Jan 2021 18:06:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 11B5910A453;
        Tue,  5 Jan 2021 18:06:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] shortlog: remove unused(?) "repo-abbrev" feature
References: <7vejrs54kp.fsf@assigned-by-dhcp.cox.net>
        <20210105130359.21139-1-avarab@gmail.com>
Date:   Tue, 05 Jan 2021 15:06:40 -0800
Message-ID: <xmqqlfd7x9tr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AC6E47AC-4FAA-11EB-9BE0-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove support for the magical "repo-abbrev" comment in .mailmap
> files. This was added to .mailmap parsing in [1], as a generalized
> feature of the git-shortlog Perl script added earlier in [2].
> ...
> I wondered what this repo-abbrev thing was while reading thorugh
> recent mailmap.c traffic. I was a bit on the fence about this being a
> RFC/PATCH, but I guess if people hate this & want to keep it that's
> fine, but if not this should be ready for inclusion.
>
> Surely has some conflicts with brian's recent submission, but I wanted
> to get it out of my queue sooner than later.

I'd expect that nobody would say anything until this change hits a
released version, and then after another release or two when it hits a
binary-packaged distro release, we may hear a regression report. =20

Or perhaps not.

In other words, we won't see a complaint (other than any obvious ones
we'd notice during review, like "shouldn't we be skipping comments?")
by cooking this in 'next', so I'd prefer to fast-track a topic like this
quickly to 'master' but make sure we can revert it anytime.  Which in
turn means that it would be nice to see it while the codepaths involved
is expected to be quiet for a while.  So, let's ignore this topic while
the other mailmap topic is in flight and then revisit it after it
graduates to 'master'.

Thanks.
