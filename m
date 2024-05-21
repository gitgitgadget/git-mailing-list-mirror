Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5E120EB
	for <git@vger.kernel.org>; Tue, 21 May 2024 05:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716271099; cv=none; b=QHghbGtF6PwT2IEGfUUy9gg/T0VnB3h2ZFuO/arlrRTDherPfYTHz9mpYocRz4VJN4XsFdtKjWSnLpkftVMnb6hspQUdIFodIhmQBN+8OG/XRJD2Mfc1BtBJqY3vupYYMjOaCaMjiwzsTrZ0aQKFZ+2NJTrf8QWkfyzCs0fVRzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716271099; c=relaxed/simple;
	bh=IU10WtQQuwr/DTiKbVWHnyrCF0+ui5Ze0refKyw9iGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNxnEX0w6VV6Evn7l6eZWMvks9AoUifCrqFngRtmvHeZMk795n4LL4Cech0oe9rsJi0UMzKLbcos2SUhGG39L2r0c4DagREL9LVySxPqzqXl6pdKl7OTbSpcwPzMlxP6Eow5JBt/4f4RDb4wMY5RmdVqlWm0OHBnEBxKKYyiKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IwryTgJV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qw2yzRzy; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IwryTgJV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qw2yzRzy"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 29BB71C00189;
	Tue, 21 May 2024 01:58:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 21 May 2024 01:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716271096; x=1716357496; bh=u8NrMZta+r
	/MgqcLiPgpd7dkCCwM/MCdhBcaCz9N4QM=; b=IwryTgJVjcegXM+T4qCIYd+Cpv
	wzIbASy255gsokpgyOchRkKlqhfmZAzL6c165MSLSkWtm2Q9JwlsvfHhqNMrBO3F
	54W5En3Zj654PcY2mlh370NXWOfPvy9iFtovQdupghU9G8gay4z6I2t/4OV+9/A7
	dhgSmJIxMwZROIsgZaZ6d56CgElAleFYXJSdmxCZn9LyYXvBgjOX5X70RTxnpqOd
	w9uf4r1ko15GL7sj5p0M7flSVI7j+J05ZrUoizR01lYRrtaSLW+WSTRu1Z8dyd/T
	Vd3ufTGJuadf/iW40S4dFtLHQ7x3HnWkkBYI05vg4A6tj5/2+StOIT8S0KOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716271096; x=1716357496; bh=u8NrMZta+r/MgqcLiPgpd7dkCCwM
	/MCdhBcaCz9N4QM=; b=qw2yzRzyRh/VT4Z45YqdjLUCTauC/2GSgdByAXdyvjaj
	9RLA80sV2XF7TIDrio/KpziM3R/9XKCNeaHezIUiWJqVHZkyfPVDHY0SSWokiGuD
	gpaMbwAG4ClN5HH7bnrZfw+7mVlTIwX1/J7pZJAKQvPcHJhL2+OINNb1nUqEXaeL
	QjUWB3Hb1Q3BLos9ZclQZ7Y3r5qPrpqEwS6r+1DsUugeBlDgQTB2Wu9EE7M7oSA4
	P6cNbz33iwThFDCdhzRxRtVgRPyedaFAtq8OuZBbUc1eVdZn/9gnjDEKBq2qq1L8
	FSvkHPSjnieN/QX4ZeZH5g0/4/M8ucHnR36RmtnLUQ==
X-ME-Sender: <xms:-DdMZpdP4ctz56xSmYWdBqmggOwsGjakkOjL8HzmaWwNFtsyYwS3MA>
    <xme:-DdMZnOpmtW5WCGe2Jec9Hot6rB_st4v7kPozgqVbNOzftMBP8gG3xlCMgn148jqQ
    5HQGPuYyA2Trp47Mg>
X-ME-Received: <xmr:-DdMZijQe87cJvjsV4gdPTfP-QIsmJeEdSkxqrj2DN_eyShZ1dlNlrW_IUHtcQA9gTpiogcND34-8u1UPgadepGdglOtODHmQ76QFj3O8AnFoBlR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiuddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:-DdMZi_9fgE_zvMXmT0PzVADD18rgsF1Ai6SAVGdFlHV3_8uHgToBA>
    <xmx:-DdMZlvLISBde54pInTj0DmC2_GOMY8VfsRfoNwptca7YOnLFfJeBA>
    <xmx:-DdMZhH04e00X2yn8zl-5t37MPmpNOHfG4LEFWWNjz0yXbUrL7koZA>
    <xmx:-DdMZsPCxXpiTm_94ixoB7e2KFZU9XO0fc35DLfoYyMgWL4PQ04GFA>
    <xmx:-DdMZpjIreLfPFuDqUpp2nVlbUrVOS7kkUa4aAAWpnbe_mLykngFpKen>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 May 2024 01:58:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0d5b3483 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 May 2024 05:58:13 +0000 (UTC)
Date: Tue, 21 May 2024 07:58:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	karthik.188@gmail.com, emrass@google.com, nasamuffin@google.com
Subject: Re: [PATCH v4] doc: describe the project's decision-making process
Message-ID: <Zkw39J_anOIk-zp1@tanuki>
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
 <10f217915600eda3ebec886e4f020f87c22e318a.1715978031.git.steadmon@google.com>
 <xmqqa5kof5ql.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Eth8eFJNyJ8TnHxh"
Content-Disposition: inline
In-Reply-To: <xmqqa5kof5ql.fsf@gitster.g>


--Eth8eFJNyJ8TnHxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 03:12:02PM -0700, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
>=20
> > The Git project currently operates according to an informal
> > consensus-building process, which is currently described in the
> > SubmittingPatches document. However, that focuses on small/medium-scale
> > patch series. For larger-scale decisions, the process is not as well
> > described. Document what to expect so that we have something concrete to
> > help inform newcomers to the project.
> >
> > This document explicitly does not aim to impose a formal process to
> > decision-making, nor to change pre-existing norms. Its only aim is to
> > describe how the project currently operates today.
> >
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >
> > Changes in V4:
> > * Minor wording cleanups to be more emphatic and to clarify "other
> >   specific implementation" phrase.
>=20
> Thanks for an update.  I am myself undecided on the "explicit
> recommendation?" question Patrick posed, but other than that this
> iteration looked reasonable.
>=20
> Queued.  Thanks.

I think the current version is good enough, we can still iterate on it
as needed. Thanks!

Patrick

--Eth8eFJNyJ8TnHxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZMN/MACgkQVbJhu7ck
PpQwchAAlkayObNhaL+i8uML7D1I3y/sGITDU5PZBcXW9nSkWCqjUcM8T428XW+b
sdeFkx1rqgs5Ovvm/+GOWfmqks/OTrabYOyOo2hy+EIRHj37Ah5ATM4cU9e/z92/
2b3kOPCHNkonjPWpA5chTQaxP+xYdtzR7MJ3efUSJWbMJVvVg9+2Mk1GJpTJ3xb5
WKmJydJu1dsOiwLBxoKZ6VNnPR469zruJs4HDXiFzYcmlS6f7umWfTlIsgYicf5S
J6rukFhmrxZc5JTeb9sbTNl2jxAj14Lrd+CsbH4ybsrR79S02oLUn671qiunVev6
ki80WNsgD97rjuToYP328hG8dVFQmo4DkIFrKn2M5kVWdc5RPDya0QzwM94g26np
WI9YqhP+hsz+qcxfo1bM1ha8HJB9PbMMyHN21LA3hUc7kucGWRVm0DxBMZw97cZR
a0kHg3aqoZT8xH01lRPz6Lx4X0NI/fHZh7OJgu0zQ2Jk42QYwxF2JPJDNAd+/IdF
2wGvo47tfIz5peff+LjOFCNrGIyjZB1Wq8D8swvF2Lsf5ujfL/Jftd/G/Rur0/fP
CnzqLo6MwoyYaTTRFJ4ZboORK8+kexla+6tpPbdzsug6ds77Geqf+NWGoQhKI4gH
2Ibubb28sNHoa71ErXiEfBo/0MP8cZYxi5uI794OCEa1+XvTS5M=
=VK95
-----END PGP SIGNATURE-----

--Eth8eFJNyJ8TnHxh--
