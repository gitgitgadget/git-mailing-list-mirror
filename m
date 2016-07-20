Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C16D1F744
	for <e@80x24.org>; Wed, 20 Jul 2016 19:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628AbcGTTWF (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 15:22:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753626AbcGTTWE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 15:22:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C31412D90C;
	Wed, 20 Jul 2016 15:21:56 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XVveT6JL4jsYLG+waLd+13AM3iI=; b=ns7MPQ
	ZSjs/WwKTVDgE2gGOE2ppFSaGZV3Y66gopUtq0U0mG7GbtAiyGocLYLea7xa8e5t
	RPzy57Bw1Twd4kFaSqP/VCJcACJr8nrNKCYnb75lf2OTpXnW0stDjIxPqBhDXcKZ
	Y4v8cQNMbp86arZJT61+Xf8euthzTrL423q48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T9tLUh6nxsUI1Lw3GyBgha392HsQ17bg
	X0d1zBObvyjYEpmlakIfenw167uuqxYHbUWXzyze6hBQNev07OdT3FMXMsMmic6l
	7xC6dJgYFlV8VUWwwmKMTflwEe9b/851sbprWDQEQnDNOBKWUA7+Jlqr3xKw+umd
	9Jd8Z55VNOo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BBC7E2D907;
	Wed, 20 Jul 2016 15:21:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 457A22D903;
	Wed, 20 Jul 2016 15:21:56 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Parker Moore <parkrmoore@gmail.com>
Cc:	Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>,
	git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
Subject: Re: [PATCH] contrib/persistent-https: update ldflags syntax for Go 1.7+
References: <CAOiOGAcqsdMD0j_ZUdvvGiA9Bd6bUmfvxziN06Rw81f_pO7cgg@mail.gmail.com>
	<20160716051800.GA2845@sigill.intra.peff.net>
	<xmqqfur6isyr.fsf@gitster.mtv.corp.google.com>
	<CAOiOGAfysmjBxcK-VwscLWBdun4rNsRs85p=foBxETvQw0J1Jw@mail.gmail.com>
	<CAJo=hJviMd3tWe_HUmh0M0Y2TOCwwrZX14hdyivPSYQ1ck052w@mail.gmail.com>
	<xmqqoa5th84d.fsf@gitster.mtv.corp.google.com>
	<CAOiOGAdhMvMfDquviuZSJr12UXK-0Fjc8xWeNJc=Wgp1jYmS2w@mail.gmail.com>
Date:	Wed, 20 Jul 2016 12:21:54 -0700
In-Reply-To: <CAOiOGAdhMvMfDquviuZSJr12UXK-0Fjc8xWeNJc=Wgp1jYmS2w@mail.gmail.com>
	(Parker Moore's message of "Tue, 19 Jul 2016 17:32:48 -0600")
Message-ID: <xmqq60s0dsj1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38FB05D6-4EAF-11E6-BBFB-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Parker Moore <parkrmoore@gmail.com> writes:

>> the logical place to pull that information from would be ../../GIT-VERSION-FILE,
>
> I agree. It would make more sense to build this to a specific version
> or git revision rather
> than a time. Perhaps that would be a different patch?

It would definitely be a separate (and optional) patch and must come
after "do we use = in between or send var/val as two separate
arguments?" patch.  That was what I meant to say with "... would be
version file, but the mechanism to embed it would be the same as
today".

>> So unless the "dynamic lookup in the Makefile" turns out to be too
>> gross, we would want to keep the mechanism and just make it usable
>> for versions before 1.5 and also after 1.7, I would guess.
>
> A dynamic lookup of the go version would look for go 1.0, 1.1, 1.2,
> 1.3, 1.4 and 1.5.0.
> These versions would be incompatible with the `X var=val` syntax. I am
> not too familiar
> with Makefile syntax for numerical comparison, but I believe this
> would be fairly simple.

$ go version
go version go1.3.3 linux/amd64

is what I seem to be locally getting, so I'd imagine it would be
something like this perhaps?

git-remote-persistent-https:
	case $$(go version) in \
	"go version go"1.[0-5].*) EQ=" " ;; *) EQ="=" ;; esac && \
	go build -o git-remote-persistent-https \
		-ldflags "-X main._BUILD_EMBED_LABEL$${EQ}$(BUILD_LABEL)"

> Would you like me to whip up a patch for it?

Surely, and thanks.
