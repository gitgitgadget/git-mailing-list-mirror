Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F3AC433DF
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 09:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A25521741
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 09:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d/Z3YMbM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S7CMW9l9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHVJCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 05:02:37 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44117 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgHVJCg (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Aug 2020 05:02:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6BABB5C0090;
        Sat, 22 Aug 2020 05:02:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 22 Aug 2020 05:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=p2dm8UVbZSoFsary1xdb6Z67+rh
        6SPjyq2AxDs8CC1s=; b=d/Z3YMbMiZiCT9QBYWwW9z60IXP0DXocXUYxt4cW2Cr
        BYy8yYCtElTfIP2/6AWPVrlVZgg03sof7kbCzdHlwGhT+7sMwEp7ht6RJ3KFycjn
        poxkmvZOACl/RXtb6WAmUOS4Ovu3lDcr3O4/8/hwiEO/qeYSpqUzvnhWqazebWs2
        MM03+V+/Msjjryx2CEeHp8cTrloqXOZIimeOyGfLtHSUbi1NxpL7W0db9iaeiux3
        IFeJ0JA6XzmkmU7qwapgoG5sP81Qmo4Gyl0KFEuxI/oe/hFArFDR5pO1aWUBGuSd
        87euv/26OChC58C4OCGYt/LI8GtR22R1RkURsnI+qnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=p2dm8U
        VbZSoFsary1xdb6Z67+rh6SPjyq2AxDs8CC1s=; b=S7CMW9l9q0Ncjjo2W8alt6
        Mpp06Z8gjJrRueUNJ7N6bhkiMIUKBWSW6MnjVTkhWBP4ytzQWfTdP7DTDfeagwTH
        pEpGGdFkY4XNucxAB30WwyqdTD66sJs755TFKPDgfk8Ag/bpW0m4yzpUBbP401mA
        U2OqR4VQU/KivY6SuAiajd/CehfZWJrzFyv8TPbGwWf7/hYgGHLOWwvBgNw1wjbI
        EgylJhBcV8pcbC2fXgCivUG7VZ6lkdJKZxuILNYCf+F7MRWfH5720EsiQjRomXtb
        XUWZQlcnJ4n9u7dl2/nwGIV3leNWAngmDGpfzD4vRcit4GTCk2TRz6oXa7rkmxhg
        ==
X-ME-Sender: <xms:K99AX-Rq9ZMeES-VSDSxzYD3MjyzDgKCxCHMlg_ZILcXaDeetfaR1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddugedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeejjedrudekfedrhedtrddugedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:K99AXzx3rQc4IMPhWmR6-fMPnRrxFgtel58W9QZerO4Wxt-PH9rapw>
    <xmx:K99AX70ErAh_GSoAkY5y7AFg9MOMrsvF2IgaORUtsSFyoJf5MOekFQ>
    <xmx:K99AX6A-n8Zf_S84q2OQM3LdCtHMwu03eSHXINmd6VTTjisOvezgUw>
    <xmx:K99AX3IcvC8ErVCODuD3ERl7pW_KqDO16Go2P_31KgZWHve9byre0Q>
Received: from vm-mail.pks.im (x4db7328c.dyn.telefonica.de [77.183.50.140])
        by mail.messagingengine.com (Postfix) with ESMTPA id 56840306005F;
        Sat, 22 Aug 2020 05:02:34 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 6403b352 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 22 Aug 2020 09:02:33 +0000 (UTC)
Date:   Sat, 22 Aug 2020 11:02:34 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] refs: remove lookup cache for reference-transaction hook
Message-ID: <20200822090234.GC1069@ncase.pks.im>
References: <0db8ad8cdb69afb9d6453bf60a808e8b82382a4e.1597998473.git.ps@pks.im>
 <20200821143727.GA3241139@coredump.intra.peff.net>
 <xmqqeeo09chm.fsf@gitster.c.googlers.com>
 <20200821172137.GA3261095@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <20200821172137.GA3261095@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2020 at 01:21:37PM -0400, Jeff King wrote:
> On Fri, Aug 21, 2020 at 09:42:45AM -0700, Junio C Hamano wrote:
>=20
> > Jeff King <peff@peff.net> writes:
> >=20
> > > However, I wondered...
> > >
> > >> +test_perf "nonatomic push" '
> > >> +	git push ./target-repo.git branch-{1..1000} &&
> > >> +	git push --delete ./target-repo.git branch-{1..1000}
> > >> +'
> >=20
> > Is this a bash-and-ksh-only test?  At least, the above would not try
> > to push 1000 branches with the version of dash I have.

I didn't realize it's shell-specific behaviour, thanks for highlighting.

> Heh, I was so focused on the "push" part of it that I didn't even look
> carefully at the second half of the command-line. ;)
>=20
> I think pushing "refs/heads/branch-*" would work for pushing. For
> deletion, though, I don't think we allow wildcards in the refspecs.
> You could abuse pruning:
>=20
>   git push --prune ../dst.git refs/heads/does-not-exist/*:refs/heads/*
>=20
> It also may be OK to just omit that half of the test. I think the
> initial push exercises the case we care about. Though I guess we do run
> the test repeatedly, so we might have to do:
>=20
>   rm -rf dst.git &&
>   git init dst.git &&
>   git push dst.git refs/heads/branch-*

I'm not too keen to use `rm -rf && git init` as it muddies the subject
under test a bit. I'll try to come up with a non-shell-specific version
of this on Monday.

Patrick

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl9A3ykACgkQVbJhu7ck
PpS0BhAAoyRdT4A58DOG6cqbvCBo9fPaAPKSDB/rl6N+5dLvz7QkrBNorha+FgCZ
Qm/JQWyZfwO66KvCvhba51KA+/VHSxhqs4Ut43hWD5e+Orn8f2EGNqXrylTtO4/G
rXJm0bz8vUIdeNRgZXwTkL+Q9byu9R7F6EPo4H7uvVEj11rA4CoROB3J5nRE8QLD
z8bc5eoohPngwpKB9cCBqJQsLUWOg0pqgz4DR9XM/M85jD7gwoWi3hVgpiPo7UqO
O0UDyBYUK5bCJUGxaBdi9TurusHbdjd3oC2SoON6NmV0fu0TZN3+c8J8eoK8IDpW
HhBW5tCpQM2nw1QGjog5yeapfheNsqKmMQfITTlnUYa2IIyTPSYeQwYUYnYUllh8
r8lyQzYTK5UP9PVRWpIuGWAbo9LL3gAGXn7GK+gwB/g1LFAUcq5zx28To2A7Gn5+
GUjOW32xDGoqWIAAmLFXd5y8BZTJD1xw6RWr0cddVrnIDnye+b1trKilBU/uwCDK
+RXJmMSvgLar+3TD3EbIutAJNJAvEPWdQQAUwV70Y8L9mpLUaz7bRj0MEA9rlaQM
BZXUH+IwHOHjoGRpnOjyGU5iq2bPXXJhdruP8VwjyKVKM4c6L8d053t34TUUesfO
BMdQiyf2xrB18PNaek1a01f1z0hQfYukErMLeozyAkdsuIOoXy0=
=gabW
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
