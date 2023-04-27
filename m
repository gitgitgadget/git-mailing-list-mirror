Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40E9C77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 10:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243655AbjD0K7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 06:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243640AbjD0K7C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 06:59:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B3549C9
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 03:58:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D30B5C0228;
        Thu, 27 Apr 2023 06:58:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 27 Apr 2023 06:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682593133; x=1682679533; bh=H1
        gG2nM5TqFAd4UNfzt2p8dw438ToMJM/7coge99unw=; b=KB8zx88tQMGxD5qC5B
        gvW+a9uCWGLN60kcdMevZMlzKvxQr47sViRpGUemRRtkPAYwXMcIS9qw9dSLwoKK
        IpLA2dpw+jXuUlzZEPSItkx/k2J7K+Q++VCn8nqefcr0JqykQJBeDbFpu9d25X8t
        EBDbBL3unXQJjQrBvdpEh2E+KlAqzzXYGu+8AoJwN1/9fPw5FeWGvZETHG6kTvYf
        i+DZ434vnDCm7uiMUwCoK0qKu9r2GIuWcf3nX7qE7v/MKSFiUCgQkoV76kjTSRL1
        fBR33GNmkrNk4LT/NllgJGtg18VJftI9SHlHPFG7VeanEpkDqd0k40cj9Vq00A59
        COPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682593133; x=1682679533; bh=H1gG2nM5TqFAd
        4UNfzt2p8dw438ToMJM/7coge99unw=; b=PeNgAo5bp5T34a/f6oP2mnya5XoTE
        xG5yo6yo8lqDl7RlQFqt7EUripwTtHb0j2qDoA+ASEoTYh3azkzQpf3MYdSn2azt
        Lulx0i8Xza7oEySxK1pTf7chVV2V6J54Q9hDVy5leFBUuepUR7AqhRm5fdmnvKhJ
        J4JtYBE1ijNArrHrMh93zYyx8ISPlHuFj24NKgR37xf+C8GVkgnNJLAyktl3cPN3
        OOWcAhTgdLcfKThnxx5y4TkCneI8hcxpdc3AuvQB2Bqu9eXxpkWBWe0/J7wpFA+f
        OiaxmHpFt3KDRgpspHWfidXQUS1idYnUPSZ6qoXIAD1bxwVmvA+Mtw3Fg==
X-ME-Sender: <xms:bFVKZDzzo-ZM6OBGClmxrdlcySZ_Ovpa9zhqlorOYokZz1euGkwDBg>
    <xme:bFVKZLSUnAu4YJXALLid0MBvQZLqB2Bh-3d14CwypzVwqOaQTH82nxM42IRHnng74
    UPAGG6Yvlc8yJlYlQ>
X-ME-Received: <xmr:bFVKZNVglcTR0verWF0-FT6BRHy37vbEImEKsPXOTYuTCNHc9vjZ4f2tb1KPajIgolV-jrXgxFrBRgcJ-mI_-MJEw8nuw0kkQNhGmrrmXSdc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduiedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:bFVKZNgE2Se0kRL09e_2s0L9rGIp5ULofTOQ_gDJsplQotcO9yPnfQ>
    <xmx:bFVKZFDkJPV858YrXoEdO_fnuBgC3SKIp7cy4yztO0fnGoB61fA-ZQ>
    <xmx:bFVKZGKye-Dqca3gvat_LequWgTIWvrrCp0FV9YU-j94QTf09O9smQ>
    <xmx:bVVKZC7TiuPFXeYiAP8thdrPmDQlT2DvOx_fO0KW1jEpdMEM8-EnGA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Apr 2023 06:58:52 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 567c7cd9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 27 Apr 2023 10:58:23 +0000 (UTC)
Date:   Thu, 27 Apr 2023 12:58:50 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/8] fetch: introduce machine-parseable output
Message-ID: <ZEpVatqnhdUSMWYY@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <6446e3db4702d_cd6129452@chronos.notmuch>
 <ZEekRNuPmObU9Vsq@ncase>
 <b8225865-7eea-3dcb-247f-10cb22899b2a@intel.com>
 <xmqqildis89b.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+GDxTj78i705jKI2"
Content-Disposition: inline
In-Reply-To: <xmqqildis89b.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+GDxTj78i705jKI2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2023 at 01:23:12PM -0700, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>=20
> >> Yeah, I'd be perfectly happy to rename this to `--format=3Dporcelain`.
> >> I'll wait for the Review Club that discusses this patch set tomorrow a=
nd
> >> will send a new version with that change afterwards if nobody disagree=
s.
> >>=20
> >> Patrick
> >
> > We had some discussion during review club about this, where the idea of
> > using "--porcelain" came up because many commands use that when
> > switching into a machine readable format.
> >
> > In addition, this format not only changes the output but also moves it
> > from being on stderr to stdout, which is a hint that the intended usage
> > of the command is now a little different.
>=20
> A little different from what?  I do not think the answer would be
> "other program's --porcelain mode", as sending them to stdout would
> be one of the things that make the output easier for programs to
> parse, so it does sound like very much in the same spirit as "git
> status --porcelain" where its output format gets tweaked to be more
> machine friendly.
>=20
> The output with "--porcelain" option enabled tend to be less human
> friendly and the distinction between Porcelain (for humans) and
> plumbing (for scripts) is reversed in the use of the word there---it
> started as "this is the option for those who write Porcelain
> commands to use", but still it is not a very good name for the
> option.

Ah, thanks for explaining where this reversed meaning actually comes
=66rom. I really wondered why we use "porcelain" in preexisting code to
reflect machine-parseable interface, but that explanation does make
sense.

> I am perfectly OK if the plan is to uniformly use --output-format
> (or something equally more descriptive) and migrate and deprecate
> the "--porcelain" option away from existing commands.

I'm still not quite clear on where the consensus lies now. Personally, I
think that both `--format` and `--output-format` work well and are a bit
more descriptive than simply `--porcelain`, and wouldn't mind also
migrating other binaries to use either of them.

Furthermore, I think that `--[output-]format` has the advantage that you
don't need to handle priorities or mutual exclusion of different options
that all apply to the reference format. To a user, it is not immediately
obvious what `git fetch --format=3Dcompact --porcelain` would do, and
which of both options ultimately get respected. But that's likely only
true for future commands, because any migration would create the same
kind of ambiguity for preexisting commands.

If we were to also migrate preexisting code to use `--[output-]format`
then I'd argue that `--output-format` is likely the better name, mostly
because it is less likely to be ambiguous compared to `--format`. The
latter could e.g. easily confused with `--object-format`.

So I think I'll stick with `--output-format` for the time being.

Patrick

--+GDxTj78i705jKI2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRKVWkACgkQVbJhu7ck
PpRycQ//SzkWNkMcSUlszyDUh0PM+YORyczYciDhLCMboZB+t3GPfNmR4ohqbQiX
+JiVS6b7qoDrSoBnjcD6hKqyJDUS7tSe1Ns0tFZnhjo2KL7+2++SlbtJ/kxg0Qbr
yq+WwvMU1eR4D8nbkwF48VCrtTu/pzCqt/ulaHc23ZyxbtlPoMsFslnM9WzXMo4V
ngDRvAIZf4KBobDIJy7lLkburgTw06v5FXTljsSb09Geuuu7j8etIXklNUwlle9K
xd1ZW7XlBSj0cR9yZmPGWMbS0z11Ag5X4XpHOapSbkzoQyfioBKZHkMtmXMNu2ir
d11l5L0cb1/ot3bd/A3nBwy13WdPayvZdBcMMLemw+BoRCKP4wOuZpixKFJLPt/m
rOsITY5cFQ1FFr7Tm+OFo7f4WeTVCGItK6LKI2/u9x6oLrJd5reBG9TETw/4DTtn
N1dWpXPaKcUn4rmEmm5pDtqBsrVr0EPcecQEmwcA2HqLin1f7pcVhFRmNLIrDLhC
U9Y3Tebof00qht3dF6ba7Gfh1yvYlSu8CkUD+Io8p/zN6VwT2tbBdcRLpj8mw4EX
RZ39dZBX1FZrXFhNcxCd7YZOdNIRWSoj26MWtpPu/kDzF4mSS4O8d+1x5JMNzXTn
m3uVX6vhlv3/YP9Nl2CABZmgLSql97zTXqH4d5QXBFwyk1iPG+8=
=03ad
-----END PGP SIGNATURE-----

--+GDxTj78i705jKI2--
