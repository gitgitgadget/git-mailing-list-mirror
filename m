Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AA85B5D0
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526937; cv=none; b=ahyvx4WSyeSCYd6VbWS21PpbyTRW4WeelVeshkb1Go43lTyq32Fxr8IwAhz5elWB2cgB5G39BKY9gTpNaI69PKUUn5npBFVmEQ1bfS5ApNHFskaUoghHWA4Ln1azUd6ZYn0x6YlP13hS3dFI2K8H22NtGL4LXRp63PjN3Ef7HMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526937; c=relaxed/simple;
	bh=8PHl0g6mWY4p9uwH2Qx7/kFjWFPq+gsgdUC292GEDeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ufg8Ly6x+lPAkL9PcnPPYf4WYEBMPxJMwJuM4zl/QGQ4VzPmbbBR9aKqNlcAoWUarrQWvCps0o3CSUpxZt4cNrbw/adoHir83CpLBU40Ys4h/7ky1iZuHwvpQfDRXknk3hHLmLEEnFboPcTZXNb4BpcphopPtzSYcezZCO2F56k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J1ZOghxz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PE1Rv5sy; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J1ZOghxz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PE1Rv5sy"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 0F4115C00BC;
	Mon, 29 Jan 2024 06:15:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 29 Jan 2024 06:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706526935; x=1706613335; bh=BCRUGWxWaW
	KjBDiUfU9I6D3hFaB5Tjrz4KRAWz+BEsY=; b=J1ZOghxz7fM3EgERKiMBl6336w
	GRbU02DbFIjRCUXchiyC+PD/b7KDnJ7/67p47FN/mox2FKQovpASnEwe11JvL5rm
	71Uza2mek3fbwf6zcwDk0poC9+gm5j+alfiG8wsNVTXV8QwB3GoibDj05BO/E+e8
	/uryT+fo9V5dc6sriucX66ZUcjsVaedQFHacEY9dCEYBu4JaqZ1DJE4wwYvkf9Ao
	M2VUHzkwsZ5wRnE/lsxrzbsB5tLklzO0ceLwkiwjeQNYPpk6nYi2ytpZT9WO/0yT
	ydly/iu4mhJrJDj9A/piWXy7i4zSFf0cf2mlreew5Ny1BrPId5CYmaOYLoCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706526935; x=1706613335; bh=BCRUGWxWaWKjBDiUfU9I6D3hFaB5
	Tjrz4KRAWz+BEsY=; b=PE1Rv5syRoJOpGnEwIx0TuZKzcJntdz0Ml5i/Ku/IGYi
	vEvo6RaSZ+Js5Bgn+lPUYEm9FbOyxcJSTf/7d13n17Yf0tvWlNcbT344BMq1L0pj
	HW9aC3TulXoGkowB26Hyp4HoDv85LyfwNXh+Bx39F8+oKiV74FjslMa3WgdCiPpD
	4QDw6jl+3GlUJYNo9HUyL2GxGt7dBomIdNWgQA7j4KFKF9lHIONyKF5OHNJGChLU
	tpiKG+YS1m7VulsdzWw+MhZmePp7Rv0+EPL3MBu99g3CkX6tDz5FSOq/HyFzGriU
	gKttAgbRLOlBfcO53cPIZqVrlmqY1QE1XrYNhtakjg==
X-ME-Sender: <xms:1oi3ZVAp4T-5VyqQiUXNQwWzCyLFED5ru_9OdwxO9LAXoESZRGry2A>
    <xme:1oi3ZTiTsjtY8I2QvULwi_NerBvdkJM7L8fIBJ2kdGKZozBc2DnTAx8586kyfimb6
    7iAWqlkwQUtdkW-3w>
X-ME-Received: <xmr:1oi3ZQlXTRphgNFn3w1p7Hly561WvI0t3WASxjwfEQS-TbArGPS6Wco2VTb_whFmUfTUkhC2rYXrm62l-z5Mx40-UtZl2_TMFFyfR3doqbjylpRFow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheplefgiedtffekvdetffegudeuvdfftdffheetfeelffevvdffhedvffegleeggeei
    necuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:1oi3ZfyQT_7i2oqJvgDizx1XCMHPBgWVZKqjmWrFxbUqzyBYuH4-1g>
    <xmx:1oi3ZaTntjATy2WWVyB4_A5GoyOx8kCSLAbAc6npC3tmWi2mKv9FyQ>
    <xmx:1oi3ZSaVFFZpvZHmv2B7XppIm8ftxSvWsvW17s33MgC2ikW44B2yPg>
    <xmx:14i3ZQNof7m3pIr9SkBuPhA2-5qtZFoGlPeQOtdRq76JvvFp7Zu17g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 06:15:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f8d801fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jan 2024 11:12:15 +0000 (UTC)
Date: Mon, 29 Jan 2024 12:15:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: John Cai <johncai86@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai via GitGitGadget <gitgitgadget@gmail.com>,
	Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] index-pack: fsck honor checks
Message-ID: <ZbeI0ksoUQEkbt90@tanuki>
References: <pull.1658.v2.git.git.1706289180.gitgitgadget@gmail.com>
 <pull.1658.v3.git.git.1706302749.gitgitgadget@gmail.com>
 <xmqqfryjn686.fsf@gitster.g>
 <BF772E83-2BFE-4652-A742-67FADF3D8FE2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ah9x98asocmLBMv2"
Content-Disposition: inline
In-Reply-To: <BF772E83-2BFE-4652-A742-67FADF3D8FE2@gmail.com>


--Ah9x98asocmLBMv2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 05:11:14PM -0500, John Cai wrote:
> Hi Junio,
>=20
> On 26 Jan 2024, at 16:18, Junio C Hamano wrote:
>=20
> > "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >>  1:  b3b3e8bd0bf ! 1:  cdf7fc7fe8a index-pack: test and document --str=
ict=3D<msg>
> >>      @@ Metadata
> >>       Author: John Cai <johncai86@gmail.com>
> >>
> >>        ## Commit message ##
> >>      -    index-pack: test and document --strict=3D<msg>
> >>      +    index-pack: test and document --strict=3D<msg-id>=3D<severit=
y>...
> >
> > Ah, I missed this one.  Nice spotting.
> >
> >>           5d477a334a (fsck (receive-pack): allow demoting errors to wa=
rnings,
> >>           2015-06-22) allowed a list of fsck msg to downgrade to be pa=
ssed to
> >>      @@ Commit message
> >>           directly, (nor use index-pack for that matter) it is still u=
seful to
> >>           document and test this feature.
> >>
> >>      +    Reviewed-by: Christian Couder <christian.couder@gmail.com>
> >>           Signed-off-by: John Cai <johncai86@gmail.com>
> >
> > I haven't seen Christian involved (by getting Cc'ed these patches,
> > sending out review comments, or giving his Reviewed-by:) during
> > these three rounds of this topic.  I'll wait until I hear from him
> > before queuing this, just to be safe.
>=20
> Christian was involved on an off-list review of this patch series. You ca=
n see
> it in [1].
>=20
> 1. https://gitlab.com/gitlab-org/git/-/merge_requests/88

I'm always a bit hesitant to add trailers referring to off-list reviews
to commits. It's impossible for a future reader to discover how that
trailer came to be by just using the mailing list archive, and expecting
them to use third-party services to verify them feels wrong to me.

It's part of the reason why I'm pushing more into the direction of
on-list reviews at GitLab. It makes it a lot more obvious how such a
Reviewed-by came to be and keeps things self-contained on the mailing
list. It also grows new contributors who are becoming more familiar with
how the Git mailing list works. If such a review already happened
internally due to whatever reason then I think it ought to be fine for
that reviewer to chime in saying that they have already reviewed the
patch series and that things look good to them.

Patrick

--Ah9x98asocmLBMv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW3iNEACgkQVbJhu7ck
PpTUBA//WBl/rEKFVwJmFHZzVyXfxYDuEMaO7ry77bq0sseHAzoB4QMCJubWxX2L
m5XgAD8A/8aHxbBQZyRZ58Y5IfQQSQFhuRuMgNlSMIhdN2XO8DiHRr2eNBTNED+4
wxMAUmqpSViN96WKWzSItsP6MreqwjlG2x8lcsbznwiWJhDzWslAe8jLEJ0BkcrP
a8adE2wT2BPOEEhDAe24fRXEgO8C7EvX+C20uZAc1jIyDJvZnlzveMnsLPkqu48c
n6U3HqtB4gsLKMA/mw1tTdRr125rYAZTzOmaQHXEtUQ6sflCHB1J7GvHGp6MyN9M
Ytwmi9ND1Xnu8U+/v8O/cV4w9uj9ZV1ISp7AG4C0ySGRvQgbUQYzr7Md5peRJl8G
fpCxxGt49JODO0w8owaWYUfWIqkaypntkd/AWTRg5G+tcWsSi1QFe64JTfyttTyQ
B1x4nwNX1rt+0+CQt4PzXb1XHtB/wMHhuIK8OiYFAZGLWayw+yWUXZVtzynbV7iQ
W1VqCuQkErDI0zaO+nnKP3LcX7yLSAWCe8p0MEW2GWaQvm6TQIsxZEEtUVArTuU9
6WRR/yoQT3YOBWlIcYHtI02WNCu4b4p2+XrVL9QT9Ylo3Is53lWajsrybSWc3MZx
JLHcr+fABagwKJabE/qikQrc8UGCh5Mrm79atcHXdGHIw6fu/l8=
=QXcZ
-----END PGP SIGNATURE-----

--Ah9x98asocmLBMv2--
