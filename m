Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D7128802
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707202890; cv=none; b=f5Tsd3vL4ML48S3y+3jB+gRpvE7bmjy8twJJA30pmu2OY4KGJsR+M4jLdOWxzsZsBw9OT5O89SdU0/gS7lUakHaKGNQg21wQLVgJXlB8Q6B2Kdn7b3FVCaRQURFK7SSNf36uDUt50d6a9rZwky7QpxFeAoGs30RWPZCH1wgcDvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707202890; c=relaxed/simple;
	bh=zToCcZoY1mhgGZ22ItHWHTl/oWccJke0Ux5zujW9DLo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVjOEWMNwd/2WbenbopcbcKZm2T9q7GAyQbUSTfyuVvnVcpBL0JcORW8ZOhs41qesEeQZSxpfxtRr3LBu6OXzbvDVTi+867iFb+6q9IWBjR2vfSEeJ050F7FOZdg7fXdQVeCVgV+NBVtjp0efYiBacBFuieMsYJ6XOy8qvux26A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=euCbr7mG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JpqUc12b; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="euCbr7mG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JpqUc12b"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 3639B3200AF2;
	Tue,  6 Feb 2024 02:01:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 06 Feb 2024 02:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707202887; x=1707289287; bh=ANwdh7TZvM
	djBVter+I5/PpluHX8SCTCsf2uQ85ummo=; b=euCbr7mGxOmPoGebjBgV5+Qa9K
	IEjVcKoEe4AJOWvy9RFvzx2I773iFpGUH3q5mCCAiChnYgKoD7WxQ4pv0AFhFi15
	0ZL7R4etM2sQfcDNrqkPSB8bGa5Oa/Q7iDkI9xM+OnSCVbyvp1NBhGPJtBFLXqwD
	IpvoXsWdLIRiGTpBdYd/XRMmXw56uNd/MChxcpPag0CF7/w9a0AnlDgke4BfdAZD
	l2FkxeCYplRGOCo6J2ULw1ZmBShoykM65j3Fqi4tLWBQ6D030B8eBvEGR10dD37a
	bnnqKsGGZ0u/PAC6dI0Y8zXKKnrQdR57tpGMVNQSVhIpOxxd2eHB+hiA6VfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707202887; x=1707289287; bh=ANwdh7TZvMdjBVter+I5/PpluHX8
	SCTCsf2uQ85ummo=; b=JpqUc12bihvoBFGXF36loYLFFHX0HvvcUlw+w8/7h6IV
	A2RWpRj7xqiWNFH0+22u0U8lS5drusLQhlSsqCRI800a8lHYFv/eHSAc7R1JY9mh
	CXzsV4HkSvX+NWONMktuhy77PgOvvvLEwJkAXepPItUlZLt1JFfY125CqtBMEk/Y
	yNoDK5quno4qbTZvL9wtCbn5kPMSUmaKxDwQbvPZf/obX71pcG5k0D/1/bTX7Bwm
	eQ4N1uif7xMhI6Lo/B3EgeOw3Y6oOhT0C41IUniSRAlQfMTvlQRjq1V9xu0uvWv4
	zC6ebioHyMYR2vHAObo0wVYLC6dRTxm/hWW/50sK9A==
X-ME-Sender: <xms:R9nBZTGG9ItDLe9FDqNoX86QYgub2wdJWO5Ah-7gylcTnl2W6WaNMQ>
    <xme:R9nBZQVFz8LFe_V_7aopCYkhx8sw19nOVtsFb92CCWQkgIdykJLob8hTLYspm4UCU
    CjV85ZKt-_A-LtmkA>
X-ME-Received: <xmr:R9nBZVI5PxjXabMsz7S4ZPlioYYTtQtw8iljiMAKOpe_hBWXnZeJtf-HVb1ngDZkJs89xmdfep4KuDQ1SGY7pWSwWww4L7yrXgE3Qm8rJrht-w7h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:R9nBZRGA5lhJibhU_9CY1nVAoXMSa6fYLLZ2fKs1NsrHhjbTaDPbfQ>
    <xmx:R9nBZZWRI_vLchuk09yrarlf96Rc_P54HPmNjsdbMh6p6ovwNqhTIw>
    <xmx:R9nBZcN2M89-jhIjM5mz6oT2SSYHf2-kje27ov9NHxGQ2twkueSrDQ>
    <xmx:R9nBZcTRPNmiYeu1UhnBaU2GBZm0lx8zlhjIO4f7kEH22VPmGcNcZQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 02:01:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f8228cd6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 06:57:55 +0000 (UTC)
Date: Tue, 6 Feb 2024 08:01:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2 4/5] reftable/writer: fix writing multi-level indices
Message-ID: <ZcHZQoqa74aUpbQl@tanuki>
References: <cover.1706263918.git.ps@pks.im>
 <cover.1706773842.git.ps@pks.im>
 <89a88cf83eeb50542d3878c5c6e56e46f2bc3e73.1706773842.git.ps@pks.im>
 <g5wshgzfv7x6om5zglsiv4bzsmhwcihwrqkmq4ebppiljqbreu@ml5eyr6zhkgu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hqFaLP+xJKGl+SjT"
Content-Disposition: inline
In-Reply-To: <g5wshgzfv7x6om5zglsiv4bzsmhwcihwrqkmq4ebppiljqbreu@ml5eyr6zhkgu>


--hqFaLP+xJKGl+SjT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 05:56:11PM -0600, jltobler wrote:
> On 24/02/01 08:52AM, Patrick Steinhardt wrote:
> > When finishing a section we will potentially write an index that makes
> > it more efficient to look up relevant blocks. The index records written
> > will encode, for each block of the indexed section, what the offset of
> > that block is as well as the last key of that block. Thus, the reader
> > would iterate through the index records to find the first key larger or
> > equal to the wanted key and then use the encoded offset to look up the
> > desired block.
> >=20
> > When there are a lot of blocks to index though we may end up writing
> > multiple index blocks, too. To not require a linear search across all
> > index blocks we instead end up writing a multi-level index. Instead of
> > referring to the block we are after, an index record may point to
> > another index block. The reader will then access the highest-level index
> > and follow down the chain of index blocks until it hits the sought-after
> > block.
> >=20
> > It has been observed though that it is impossible to seek ref records of
> > the last ref block when using a multi-level index. While the multi-level
> > index exists and looks fine for most of the part, the highest-level
> > index was missing an index record pointing to the last block of the next
> > index. Thus, every additional level made more refs become unseekable at
> > the end of the ref section.
>=20
> Just to clarify, is only the highest-level index not recording the last
> block when multi-level indexes are being used? Or are the indexes at all
> levels leaving the last block unreachable?

Every level N+1 looses the last block of level N. So the latter.

Patrick

> >=20
> > The root cause is that we are not flushing the last block of the current
> > level once done writing the level. Consequently, it wasn't recorded in
> > the blocks that need to be indexed by the next-higher level and thus we
> > forgot about it.
> >=20
> > Fix this bug by flushing blocks after we have written all index records.
>=20
>  -Justin

--hqFaLP+xJKGl+SjT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXB2UEACgkQVbJhu7ck
PpSWiQ//arRFml+2/5nkjLKw01NmCDXctPG5rrIcz17r4i2JNoeEqeGIo7XpP0W9
+ADRvpUn42HZ2/jP7dBdpJMjcoZgeG0WwTGjFokvI63FGRvRdao8TD5/VShvb4zU
uH7p1jE7kLr7sgshdfdjg55WQKZUlYBg5+vPt44DI3ANBeDD30GF91BDX5TyVqyq
f00dyU1ZRl25dh0cBQjJn2+E3H+XdFJlVv5ELQwZsjaDevH/kkK0sA3ZEY14ba8w
QrhMyD1Cfc8fJP8D8RMaazbWE3aE/vn7KCM1sExA/5HosrjQUa5pcuyfA382UKi4
iyYY6OGAz3j7oeN/m/RuppSz+P2yJmxiGFwcmgB57y/mSzfFMKg/RGnPa5f8jVBg
W7p3drDTY4ovub+nZBtWr3q84stHPAZiWk0CRWe1d/xg6LBQ9bG6EuTojv55Reti
WvpW7AFuc4dVaRLcaeXA7VPQ4VbH0/sGdZJxUX5a6nKK9UdzDlq5//ekspcM0GSf
v6f/yHwpWTFkhQUOw9vNypjAFXlXZqFlik8GytLzFJR8G+etGrtEu/YiUEdVPO+I
W4E7q2o1dAVDn6igeqWRSbn6Twa5t2NqkmBSQvujrJzaIaS/il+qCv3lA3hqD3gR
sHJsHQIS8TDBYn/DG9iKBxyHxGG0ncsYPGkv1CeO3kuULO4BIuU=
=FEjn
-----END PGP SIGNATURE-----

--hqFaLP+xJKGl+SjT--
