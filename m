Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC4C2233A
	for <git@vger.kernel.org>; Wed, 22 May 2024 07:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716362638; cv=none; b=b9sl2dDXDwI5RDyC3myP5AXFw94U1NEELhWvXC77Q7dX+dtNG/x0I8Rle7xFlYeM08EVw3SO2MVSD/In+VaJVTusQWVd+pxRq9EiRLdqQppBUJ2nceiWoTc3wnoSvwhS5DnFFo4Jcwf1BM9Jdz73y3+xFh7uVfvc4vRbRQ7Lo60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716362638; c=relaxed/simple;
	bh=YU46YjNlJAtYsPMO6f/2S0dBwHdLy3wfDpR07aVlxLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsAtugo6dk8ltufMAxdsy+SKw9oSb87cC4VCCV7g/UrNm0hFXd1o/JsPjlaJnqW7nTrTOU5yVUEpAGef9+7J5/J9vW9t4EH9TiiTOniE1mKdDz/poK71wlZMIxrrCHxX22+p0omtRnOkKxCzMppRkx2RdXCJoYnDfPCcLvF3nw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G2Fe5cmU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jy/U0yYM; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G2Fe5cmU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jy/U0yYM"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7CC311140085;
	Wed, 22 May 2024 03:23:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 22 May 2024 03:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716362636; x=1716449036; bh=X2CC880PfM
	nxPuA5L49cFcSwPdSdXJDB7+D0+NO8aZU=; b=G2Fe5cmUxgRo0WmL7j+h8928fP
	Z7dkDf9Qc0hilKR5fSbojLNPpW7x4uTaffNIPJjEx9c7ogqZJ5wubLsGaNq2O3m0
	tR8B0ZpmOwJoZhZTmtgSE1v1NG4zehh+gdVHW5sOfeADv2RFSGzlMVGlYwPZQDfW
	WGvtJUvcYVvZvZg4CFuBMa9AbXgu16j30p46RQ+6K1ZhnIec8ZZF7aGG/kHr6cgX
	YoAmNe3MuRcyQXvKaXx90pbV3p+SK8RrpEdB8rbGl1zDgjMAiNZzinGht+yIWCZ1
	Gru/4Nm4j5INoeYjoqdCeuhZOkF4L99K4ORTYgTA82dC8MbtLYDUpbYwJCvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716362636; x=1716449036; bh=X2CC880PfMnxPuA5L49cFcSwPdSd
	XJDB7+D0+NO8aZU=; b=jy/U0yYM97aByqH6mjO1H5u35VN1QVl44QuktFowQz6U
	7r6gVFliTyrlXZ1SUbvwMx7whRvwM3oCIno+Uy5Oq7jgEPbANXWGqMEg1b11jc/h
	x6WpAkvSaDB0irjidtuFkPacYsGNSQFtXdj3uqMTtkJKgXHTr5P9BLYScYyhjk0P
	kY4iczsdADfjSp9qkxMdd2yK0tFMkO/v6WzDKkBe1F3YREq06I9mfBlEKBlfdGB1
	cJqBzK+ijn2+1+GFd156aX6i/BX4LGfMbMwpmA6tXEkQWG5XBNimsLXrlq16Nzle
	6+UIC0Bhi9RvQlG+YMdwczZUcmOfM/q7y46n+AHvEw==
X-ME-Sender: <xms:jJ1NZisMhOnNk5eOC81UNX_C5kIBR4kT_HBavlfpOoDCfVzLdn4biw>
    <xme:jJ1NZnfswdnNv-CexpDXIRFReayRC_Y92KR6GHGEoidICBS79m_eO0iAg-06G396A
    lCtShWkTQR_YFpDlA>
X-ME-Received: <xmr:jJ1NZtzwGBlYsHB7XuumOKllzN98-FaQtTHD0M2r-IKgoV9GRNf559VGBslt_P-DEtu1ejSd-h3CTQis6CL8XfzWYlm80V0DoxtOR3LQBcwYD2OY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeifedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:jJ1NZtOhty9fjsg-VJPO5KSX47CVWMbGpy3BLTCF0_HZtwdxEnPnLQ>
    <xmx:jJ1NZi89W7HN66Cla30V-uq9NiPBu-2dUoxe7UYActpMQJHN1K5qYw>
    <xmx:jJ1NZlXjCyd4K1kLTD5Xzxx2XcpLWcPqKvnbpZy6zP7Z-0XDm5irbQ>
    <xmx:jJ1NZre6RwlGNL1TyNK3q5senvztHbe6Y16NPU7zO22wGO9sOkhxew>
    <xmx:jJ1NZmZJm7mVK1Mn-z20c3smUPwbZUKTI8FklqufUHqM6UjHt_l2pO6P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 03:23:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2209023f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 May 2024 07:23:50 +0000 (UTC)
Date: Wed, 22 May 2024 09:23:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/13] reftable: prepare for re-seekable iterators
Message-ID: <Zk2dh9-E8Sa8kzJd@tanuki>
References: <cover.1715166175.git.ps@pks.im>
 <cover.1715589670.git.ps@pks.im>
 <CAOLa=ZQPS_gVAf-f3cW_=C18B4C7i-gh=bYMWW2X03S4nYK3Aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rBm1kn+fug+mfyox"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQPS_gVAf-f3cW_=C18B4C7i-gh=bYMWW2X03S4nYK3Aw@mail.gmail.com>


--rBm1kn+fug+mfyox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 03:31:15PM +0000, Karthik Nayak wrote:
> Hello,
>=20
> Patrick Steinhardt <ps@pks.im> writes:
> > Hi,
> >
> > this is the second version of my patch series that prepares the reftable
> > iterators to become re-seekable. These refactorings will eventually
> > allow us to reuse data structures by iterators and optimize for certain
> > cases.
> >
> > Changes compared to v1:
> >
> >   - Various fixes to commit messages.
> >
> >   - Fixed a copy & pasted comment to refer to logs instead of refs.
> >
> > The series continues to build on top of ps/reftable-write-optim. There
> > is a merge conflict with the in-flight ps/reftable-write-options, but
> > given that this series has not yet been merged to next and because Junio
> > has already resolved the conflict in "seen" I decided to not pull it in
> > as an additional dependency.
> >
> > Thanks!
> >
> > Patrick
>=20
> I didn't review the earlier version. I did go through the patches in
> this version, I only have a nit in the first patch, not worth a reroll.
> Thanks for the series, I have nothing more to add.

Thanks!

Patrick

--rBm1kn+fug+mfyox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZNnYYACgkQVbJhu7ck
PpT/Bg//Xp3iyOWdIhho/Xjapacct9qSRQLUw8TFzA7NCcLTxtQZODmjsI3htCbE
qBh2E2kVIO1tI2BJEyyMmUiT1XpuHB4aPMLpbo/74I6ubz7crn9wiyayy7U4hQ/4
cfkW+ajY4QPiFkwOwC4T+mXBN2kVznDFzM2V62GCY3di4hf9NVu8CUQNkj2zNWIh
ZKGCCyQ8SEOxXwTSHj4zHDGsJ+5Sx1r+dDT82kS92A+TQHv5sZdlEpcBS/nwamjq
glKfkTj1OanBoy6Vky5xce5OvaTgCsYSLRzRMSxw6WMWa21nD7xFPHKobs5J4hCi
Y2qHDHq2zRFI+h1J9Pi5ll1syucFFfv6lLzCH9iJwnH0zeo6S5Ua95fTDrGzEI8X
k0lb5tFUMxOzg5JcWj5swKarHF/JQRiOr77MGVXnyyAeP1/VRjM4VH0J/P+KE2pD
tWTYMLRFw9cHpGnEBAPFFaz7eBsZNAitvYtFKiG33SjRAHAEvjn8IiBTC40R9wSt
2mX+reGKQ+nW56z1INIvxk1MjFc2ko5nAvz5CY1YpTIGbwedzCa0tOmHXmmMNbmr
HXEkXi75UlicoFnOIhzxT7qLdsb203X6dAh3ehOGc/7LxLvuV2tYsZ7i+BbHqvHd
4VvdMokIQpyHA87/niyDWvchFUi0DoCQFp4qV/wVnVMLph4rrys=
=Ghrh
-----END PGP SIGNATURE-----

--rBm1kn+fug+mfyox--
