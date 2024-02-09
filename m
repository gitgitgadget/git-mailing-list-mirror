Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6025730C
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707460075; cv=none; b=f9rLPQXC/Vp9eytL0xooASKZy2NWyg2xGrq2ft21nH689k/PbGZa0NFquQQxtqkLUUKg0mNGEXs8OOZcoLEAdh8ienkJRrVeGNByTu15nVCx8sZkbjxV7yLKke6h6DWsAcTV5SR/Z1I6e/Hrf5UR71E9Rc3E8tBGSUtvPY8l62A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707460075; c=relaxed/simple;
	bh=9Q1lnV2HsBpncLAGVD35XCquibSoUfUkowOxs7LBa0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cE6rsFLzS80LNMQcb94ALoyFGA7LUqrdsLn6XggYDh9TUnGebQ2ppW5h4jOmP3dDdZ1SxgmLgKhJd9Y3hw5ZhRwX4sbvE+/QNrI2mXqaRidtwPzb/+GFcteeId+hOrdNFbuudFBz2bJHR3bfXZ+Vauo1j+UwOSfF1+zAe2YZRQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GSFkJd/9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cpf9saqd; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GSFkJd/9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cpf9saqd"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id B4BE13200A94;
	Fri,  9 Feb 2024 01:27:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 09 Feb 2024 01:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707460070; x=1707546470; bh=qagmxXWZLG
	JgPB9lxKSlKQ6KyxoLYD/sP7EnIlQf6rQ=; b=GSFkJd/9F3yvaLR35ocrbwu8Yt
	3OMEcsydMFKZ+fAH1+tNJO0kMKrbtbiY6aR9j74P9YMPx9K52zbe9HfjUdQ0E2sO
	Q8HxPxcnQ3MN0DTii+ImRaKY28nFEcsR3liGqskrLD1XdjeoK2PfoTMZgoKCEmQq
	W/ysG2n7E83pQbGkTNaZg1AwU6A65NfsNpSFK8zJX3gvIppgqpjYW/Aezy8esMY/
	urMnB4vPrUjukcQtLrzh2aeqaD68lTHF9zl7X1ENM66f9FGFk+SFqd1GWiq1ycff
	UeqBUQnV9x/21OTB5mme0LoSU+hMneL0K6OqLcsHdeKmnC+wd2NhvpVLrLgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707460070; x=1707546470; bh=qagmxXWZLGJgPB9lxKSlKQ6KyxoL
	YD/sP7EnIlQf6rQ=; b=Cpf9saqdJr7fhLqRW0VCFtytHctpEaParMu1bT+oEFDu
	O6iSllFyZHdN47ooTtR0SY6sI4dlOZBbnH0MLyyIMZVRo4E+29/RTfNbpyxAyRNw
	wpVWdjKJNP7vUH4Un+EdksDRcRoA6+wSt71L4WmjBUe7tNyHLSGD1GhhU++wJBCc
	+CzJO5EVscEnlEYi8VU4YfP0Xv3jqDQL8PYlOSi/usGKIsFCHOew3d4H5CTGi3E/
	vi3UvX6mXf9B6D7g04VkCNM1lcbJYQz28gBz69soTGsXbI9qQkW9Kcby+9f8R35l
	dHw7Qu4UVNoX74e7l9sKuwr/4bkpTbt2wGOi273MWA==
X-ME-Sender: <xms:5cXFZdgLrvxZTGhhDXuwBemL62fzI-lqW4H0-iRjqUHzsdfxaM5e5g>
    <xme:5cXFZSA31XfNXSeu9o1dWWUzc1XDFpDx1at741BNmB9B-B8x949VxAuNwjv8pQSul
    M6Qhl6Spp_XQzQc3g>
X-ME-Received: <xmr:5cXFZdGQLx5OZnLxc5hodHDAx3IO1X0UYcFGWuEV7EyyW3KJ8Z8TnnXJBcIULYc79xzjzBqyjSpxdp9KrG1os-amWUu_l0-ia3tMu1AAjWv-0ME>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdehgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfhfgggtuggj
    sehgtderredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoe
    hpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedtfeelvdekleeufeevffejieej
    feehieejkeeftdeljefhteevudfgfeejgfejheenucffohhmrghinhepghhithhhuhgsrd
    hiohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhm
X-ME-Proxy: <xmx:5cXFZSTb65n3Qgkx9gkLdO1_HJDiqdywcUNMqLOo0dbfg4LS8PMpeQ>
    <xmx:5cXFZaxqwukiRH41NRnMJz-zjPtb5-p_15dE8S9umPwK6hlZgtilSg>
    <xmx:5cXFZY6PFDOLZo3qb5kHXzz5fYGPe2vuc7r4hmiOEra4KTL2tYhUtQ>
    <xmx:5sXFZRkXlo1zLGmO3dEzITGyx6Z0kEwYp10o22-udMnVo5ij5-USNA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 01:27:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 576ce915 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Feb 2024 06:24:10 +0000 (UTC)
Date: Fri, 9 Feb 2024 07:27:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Victoria Dye <vdye@github.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] Add ideas for GSoC 2024
Message-ID: <ZcXF30FFOo5cWeFT@tanuki>
References: <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
 <106b8e7be9ddc2d24670b01d54347dfcf9aef196.1707122040.git.ps@pks.im>
 <CAP8UFD3F95TzytdpKO=LLf6Y_ejxwh9QtgAxRNKgMXW-72hjgQ@mail.gmail.com>
 <e1c04f67-5981-4393-8a8e-a28cc53858eb@gmail.com>
 <ZcHIxcrKbgyhdyWn@tanuki>
 <CAP8UFD2yFr1uOjKOnMjznjR6BEzGqq=R7K85z2Jz4i=sG0CLJA@mail.gmail.com>
 <F2684AB9-C4F3-43C3-91F2-A6D7D71F4927@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PqMYRLE0J6e8APWp"
Content-Disposition: inline
In-Reply-To: <F2684AB9-C4F3-43C3-91F2-A6D7D71F4927@gmail.com>


--PqMYRLE0J6e8APWp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 07:32:50PM +0530, Kaartic Sivaraam wrote:
> Hi Patrick amd Christian,
>=20
>=20
> On 6 February 2024 1:43:02 pm IST, Christian Couder <christian.couder@gma=
il.com> wrote:
> >On Tue, Feb 6, 2024 at 6:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> >> On Tue, Feb 06, 2024 at 12:25:31AM +0530, Kaartic Sivaraam wrote:
> >
> >> I don't quite mind either way. I think overall we have enough tests th=
at
> >> can be converted even if both projects got picked up separately. And t=
he
> >> reftable unit tests are a bit more involved than the other tests given
> >> that their coding style doesn't fit at all into the Git project. So it=
's
> >> not like they can just be copied over, they definitely need some speci=
al
> >> care.
> >>
> >> Also, the technical complexity of the "reftable" backend is rather hig=
h,
> >> which is another hurdle to take.
> >>
> >> Which overall makes me lean more towards keeping this as a separate
> >> project now that I think about it.
>=20
> Makes sense.  I suppose we need to capture the distinction more
> clearly in the ideas page.
>=20
> I've tweaked the doc for the same. Do check it out and feel free to
> suggest any corrections.
>=20
> Ideas page: https://git.github.io/SoC-2024-Ideas/

Yeah, the clarification looks good to me. Thanks!

Patrick

--PqMYRLE0J6e8APWp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXFxdoACgkQVbJhu7ck
PpQBshAAmN29Gl/og9vqX5O7tuySShhb435jdkva9Vmuo6LrV2j/gPtxVn43HMpR
M3ZaXSWdPbrKHfVDlEuIETr3CEFabHxHt7FdE2SQ7EfMBUEhVvTZP8A/8rsnEQWp
plmzgqZCJq1Pk88XEfd7/GHEjwIqqgp4i90gInJNQQocCdKlFZe2yZ6fffzOBKrs
MnNml7fl5zwG83i6iFYzdteJe+svQQjSFP/EKRxSbnDUi7cNNH5/vS718LYvCRW0
pr19lXN/1IqwDeQgD68bMh0BGiTvTaUl4K38Xr2+lsH3HHYWOrI5lNegobpwOJDz
4bLru43NI9AbhtFuIdZiyui10lsUZ4nRy228yG/pUY3IGnRgwzl41HUU+wUzrsEJ
Zq86Fi6qnAlK0uzqg27OZx/VbQ7GbPXM4bHKg9rKCa2oqriNUC//Ew5l9bTlclqS
BGytF2Z6h6L29GfxFjjOUVzM/eEihIz/yKfeRoGyVAcmYY1G9KDdbNcRZ6/hoGzd
dCeuq41f6KAOYnI7QGZGX8pDZX4szvR0v/nsJGGwKp+mDEfM8Rkuh4XyJwhZVwGB
fp+p55/9IAi8VLIwhLSsrWFTiaYF3dQle5gm6o5bflBsRiAKKfiVjJpYR66ztDhJ
4y0OKwSjQa8kHM6ery6LMjy/CT30yVfwbJJjgi/83+d6XEFAkdE=
=z4m7
-----END PGP SIGNATURE-----

--PqMYRLE0J6e8APWp--
