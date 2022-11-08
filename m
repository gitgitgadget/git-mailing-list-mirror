Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B41EC433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 08:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiKHIRC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 03:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbiKHIQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 03:16:58 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F7E25C76
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 00:16:56 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F9845C0036;
        Tue,  8 Nov 2022 03:16:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 08 Nov 2022 03:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1667895416; x=1667981816; bh=zIxnzQGHN/
        /BfMFSfrSTUMX4tru9+rkGfw9iVpjuEOw=; b=JPeq+4+nvFMTCjrYjs5qZH2xhY
        Zks1OM289riuunrvU9+bC2nhRGhlhAIIjTAe2I0lwbEQm4QjMOg/sqAyNrlEDPCv
        cVImqySh46wIH57k8AXrYH9q1yRlj4c4eJj7mWvh092dOLmHGsJ9pFV+ANuwXXa2
        UKwoXIXxk2gmIq7BKxpfuK3pwC1tm82HF+DBiuQXs4z7Jcs9Nh7uKKt811bYDVkL
        99D/BgojhOhGnq4CPCTDP438SHw3Exq8AJOEtjqKLrUGj6E9KK086pnpg9XgQy9L
        N5wUpntC3gs884vGyPgR0qkh1ccgFFmqfAt2RXkmJW9xR2/hLldYUtHIvx8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667895416; x=1667981816; bh=zIxnzQGHN//BfMFSfrSTUMX4tru9
        +rkGfw9iVpjuEOw=; b=ndKRBvZgHMNwyHhfZxlEd2n38IEUQqRqvrIQ3WbKwKy4
        zlZE7KnwUf0tRhVgusDL5NsfiVCtHgiyhxjh0mbp5yMWdkx8JZlIBR8WGyv517om
        3ncZ612VUgt9ZsAimfOhryMNZqHdeZHZR1kabgAbCCP+j+Q/eHfFjZIy+ftnWa+p
        sibNB8jgZ/CWOROCdObvviGfZ3oNntP1rKtoGrnl2Bc0YEn0pYs9/ia6GsANjL3v
        VYLMOFZ0mfWSHawqCBT48FedmEf6peAVMVoYSJ+HTVawClyO2p/3WstOeMN6x7mv
        TlGGckssX1i89H5Nm07AmYIW7vaw5r2P3mY9L6PXJQ==
X-ME-Sender: <xms:dxBqYweTBhGoZjfynRFFzeuzkuIG6wChOH1OgCqgKkXnWtWX8EdGkQ>
    <xme:dxBqYyMATwyjXy-PEYY9BHSWvpqUcAfoLKebtVYAl604d1eaUHjklCNJ94lODJgzx
    UBz-qce157WGK5Jfg>
X-ME-Received: <xmr:dxBqYxjZZqkYIq0mJaCK2inejsjpnF1AqHw3XBhMkzYfxI4bDN63MuzlBD6371ch_aQUoovhkAvrqTYIRJFhp1opH9XUyUfSK34Jef-0mN-->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdelgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:dxBqY19r2b4nbrfC1tujp8R1v9cktiAGg_Jc-39RUOnPfxCfcoVTBQ>
    <xmx:dxBqY8vV4TLM_0qyXzWzWam4yzFGJIAa6pNTnFfBFQYCuvWS95PiJg>
    <xmx:dxBqY8EFRzJmNbQdgkbF4GzMkoBFRouQmtTzuHYfDrlEuEMIowoxsg>
    <xmx:eBBqY4ICSDEO4udaQGb_AFqehjdvqfCpbnEjE8MaQu_iHZHhiyWXkQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Nov 2022 03:16:54 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 6ec07237 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 8 Nov 2022 08:16:43 +0000 (UTC)
Date:   Tue, 8 Nov 2022 09:16:47 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/6] revision: add new parameter to exclude hidden refs
Message-ID: <Y2oQb12WwEh0bpxW@ncase>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667823042.git.ps@pks.im>
 <de7c1aa210c2df9bdbbb6c19f44f72c37f56c5da.1667823042.git.ps@pks.im>
 <Y2mpefFJspp4QnAz@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PIcvsXzVTOgGPIJ/"
Content-Disposition: inline
In-Reply-To: <Y2mpefFJspp4QnAz@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PIcvsXzVTOgGPIJ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2022 at 07:57:29PM -0500, Taylor Blau wrote:
> On Mon, Nov 07, 2022 at 01:16:35PM +0100, Patrick Steinhardt wrote:
> > @@ -195,6 +195,13 @@ respectively, and they must begin with `refs/` whe=
n applied to `--glob`
> >  or `--all`. If a trailing '/{asterisk}' is intended, it must be given
> >  explicitly.
> >
> > +--exclude-hidden=3D[transfer|receive|uploadpack]::
> > +	Do not include refs that have been hidden via either one of
> > +	`transfer.hideRefs`, `receive.hideRefs` or `uploadpack.hideRefs` that
> > +	the next `--all`, `--branches`, `--tags`, `--remotes` or `--glob` wou=
ld
> > +	otherwise consider.  This option is cleared when seeing one of these
> > +	pseudo-refs.
> > +
>=20
> Hmm. I thought that part of the motivation behind this round was to drop
> the 'transfer' group, since it's implied by '--exclude-hidden=3Dreceive
> --exclude-hidden-uploadpack', no?
>=20
> Thanks,
> Taylor

I didn't quite see the point in not providing the `transfer` group so
that users can ask for only the set of refs that are hidden by both
`uploadpack` and `receive`. But given that you're the second person
asking for it to be dropped now and given that I don't really have a
plausible usecase for this I'll drop it in the next version.

Patrick

--PIcvsXzVTOgGPIJ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNqEG4ACgkQVbJhu7ck
PpRdsg//SuFNuYmj8T6IwhyPw/LnqH6GiAmMW3DmVmSi2tSDRMyCiAe5Di6ZwTop
vLHO4pmEN7UYqlYeerN1wSl3V5TvC/zIp/kgxncCudQGlQXPb6teWMiArLxUE4ZV
ctuPxVVofd8lcL+JbYePPL6PeOc+jc21sBajWngo9raP+LHoHWtzp5HkOnoqbTzf
rpv7vVBHWp6vcZHoGuxeGTfXytK/zRtbuorj7dm1gN+2Z+hdp6W9q9kGGHSgQgyJ
ipgeZxfB1CyDZQsY+jNIA1x7OEYEj7BpfQok9iqyoQklYdtsVaIfxB7bPflONotV
Fmo4YyD8bsGCazZyUQrw4uX3GKUg4VfMO99Qkz/x1amva5u/3FKd61aTARZVC5vH
n5++DRSvgzzbFSjrjPz5Cw74MAXuKI4iRRXYc1SQiJVqeLsaGOPMM6rHfICb7Qcp
41GupqxOiEPR6qQRlrJEeCF2uMGwQun8VRf3Bwe0UG2YOiWnDab0qg+Liyu2rmbU
RU8uY50e/pDrzCpoRIBINDEZGPXmTeIKz2qN97NUaBc6yjuvKJ+J0Ro/zsRsVX7Y
PRH/F5yL/SzZXS0r/97WF/67+eViweymajibi0euGyOo2owjwHBkqBrHuvyEtL4W
H4bcwVBr7+R1oeLRQXgJ/D3lzxgpwXI1bZ+7FaQZMPglcNAmhfI=
=z9rK
-----END PGP SIGNATURE-----

--PIcvsXzVTOgGPIJ/--
