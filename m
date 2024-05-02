Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4AD41C60
	for <git@vger.kernel.org>; Thu,  2 May 2024 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714653506; cv=none; b=rQbx25X1rObtXz0xn2Rp2ieZ5JHMrPzZaB4Z6z9ToPjp3Cf6FRUFA/bdCpGo3jZalKBPBGW2wtdgcISgbLQLBVofiMC2e42bzGfxqeu7iEnPfpMgMfOpybycNJhhsDg+Ls86utWPBjFSLSJxn4H4wQxycpTuXjwOqMGs6TfmNCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714653506; c=relaxed/simple;
	bh=w+bTcXqPgs4UbpiCDF6JIMj9TfYQeUtLXokjlb7wgus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIX6yhfAgMRWQyrObJ5MzvfZRM748Ii1pVNDxCsRXgQr+NFCC+KY4uHy9PyJ8dcNT7tcoII7pHjLtIVeen+PoJZVmgUvZxUUqjJg7Nvj9+YNhkEInB01WkxUeL9rX41tWh/7QBepRVcuQUUjRhHvoSyvyVDSARWTOy93ywm/seM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aAACBHRj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G0AilDdV; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aAACBHRj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G0AilDdV"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 11F4D114010E;
	Thu,  2 May 2024 08:38:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 02 May 2024 08:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714653502; x=1714739902; bh=w+bTcXqPgs
	4UbpiCDF6JIMj9TfYQeUtLXokjlb7wgus=; b=aAACBHRjM4Wlozs4LnkaOG4EQn
	6uZDKr9PGeHXcrZ9zR49gQ3NpxmPWcestAc+wJ8wrfo1WHoMQtKIlgqaG1ya/2/v
	6lncYPWTcWDriYdsHp3hge87N1nSc19hocd81T/QPYVJSXN60SFW0ibC9vNc8EJh
	lzeetNtI804NQjusbKWGqpmUz6cvYbFMEWQKJadd2k4yh79Piyn3JHtJYWPNp5m5
	5SJG+2j2e3b/mFD1cmoiyxvUMwip5VOOBv+u6aNQTVS/JxXV04eXDGmMB4wmM45q
	zyKYUh9l30WIqvKg4HxKBYBXNZu20uELXdXKDmxWGD7AIuldyQ1URP0tKmGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714653502; x=1714739902; bh=w+bTcXqPgs4UbpiCDF6JIMj9TfYQ
	eUtLXokjlb7wgus=; b=G0AilDdVyZ8YSs+bRx4PlO+EDsWIzC88zEtIZoY0WuUz
	knp60SwQ0g+pXeQHcvbP2/dXqKzfuTKIo3DjD2PlHBjo2QoC1RTFD1pia5QD4Q4V
	CKijKnO6ub5QVPoPkHUcpYTeTHR+X6uB3cLSiZJ5Kvf88OvkNG4FgGOQ8IMImWs5
	lewB/gdJSNSdUGkUX/V2uVUsdKnfkJrsqJO1JV/2/LapG0nQiUQQtBTeyLmyxVyy
	XrSQxweIKfm9SZlByKJcsF9l+q9rospQ1BqJmdIGMnExro5eBimJ/U+vuQfd+P0a
	c/0dOht+K61QWUgbdbtdH9PGgqGyzkK9EfsA3QM9cA==
X-ME-Sender: <xms:PYkzZkUOqytQIm5ZBIUpUfWwnTT2es6fKTxoAtfdbM3QHxcBIlNfpA>
    <xme:PYkzZoktOYz7bzBdKk5f7LOaMktAScS0AirtHI2u0qnjNw8PCqktZiGwD5wxUyUZ4
    jIHOvNW_xf_EjhoMw>
X-ME-Received: <xmr:PYkzZobR7dL39x4c6-0Gem3piSrFzIP7GVlkefGJjVP7nqYxg6kS0c6aAz-HdG3AAbq2vqOGC7q_0yRmrrL-QULTKMy81W8vs_k3jauhKaPzrDI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:PYkzZjUG7BmDCc7ig7mymsN8EkkUZEkebuJWh3dPKjTWf89QKmHrdA>
    <xmx:PYkzZukGMgJ4-b1v7JyiugriuHLhrekW0OBJIB-SY9hv14CIot9j5g>
    <xmx:PYkzZofjNM8MvY10olga1eI76kn-fWua1yqHeI8qJuSjooscgHvp6w>
    <xmx:PYkzZgG8AQOuZAttLdDKl7Tnlp5MM2XR7UUOnqWO6GVPMqYlwuN_-g>
    <xmx:PokzZgiTTTC1j8B7dmwr_kurVPmgxcLE3FMqdf3JNtP4gj14qBtZYrLF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 08:38:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5c14d448 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 12:37:53 +0000 (UTC)
Date: Thu, 2 May 2024 14:38:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ivan Tse via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ivan Tse <ivan.tse1@gmail.com>
Subject: Re: [PATCH] refs: return conflict error when checking packed refs
Message-ID: <ZjOJONdlaINfN_i_@tanuki>
References: <pull.1716.git.git.1714488648294.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1oHhrL+GCHd4ZVJt"
Content-Disposition: inline
In-Reply-To: <pull.1716.git.git.1714488648294.gitgitgadget@gmail.com>


--1oHhrL+GCHd4ZVJt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 02:50:47PM +0000, Ivan Tse via GitGitGadget wrote:
> From: Ivan Tse <ivan.tse1@gmail.com>
>=20
> The TRANSACTION_NAME_CONFLICT error code refers to a failure to create a
> ref due to a name conflict with another ref. An example of this is a
> directory/file conflict such as ref names A/B and A.
>=20
> "git fetch" uses this error code to more accurately describe the error
> by recommending to the user that they try running "git remote prune" to
> remove any old refs that are deleted by the remote which would clear up
> any directory/file conflicts.
>=20
> This helpful error message is not displayed when the conflicted ref is
> stored in packed refs. This change fixes this by ensuring error return
> code consistency in `lock_raw_ref`.

The change itself makes sense to me. But I'd like to see a test that
demonstrates the new behaviour so that we don't regress this in the
future.

Thanks!

Patrick

--1oHhrL+GCHd4ZVJt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYziTgACgkQVbJhu7ck
PpT9YRAAoRLwsSrV3JQXlmvB1lVxkybmO6XPSTZfInmGcXFJ/zZmt7lYxrVUBY+v
h88amusfLdR0nf1LWHWayMe+iJd6CKfdxPmiFL3LWPNJSDFhY8s8SfeTF32K3k+i
teMceZeYVxpSBLdBc0Fmi16IWXSPdyMDjn+p9QpiTPZzp+1ydwqO3pI9p6OnZ3mT
XEYryxGPfND9SQDJVf+BTqEEGUNqLAqyHVNyoRGeJllPwPV9goQLB7AhQSlZT8VO
oOMpjj+L5mhRyCT87NqjJR2DdYVfVMymNBtLs2crBnZwXkhcjqVPr21EsPbzzZDJ
Aa6UY1WlTeMy2cm5BOyygMkbYRwKb+JSrNWhEWf0m7oDUIRrF11MzRvWLbz9UcIn
fRL725s7PCWnaR562ncXYC/aaSASAsaLyXVQo9IqPHY1g5si8X55jJoErAQwieoE
RTd+kiY+c0C+kzOxaWbUcXhwGBRGQsFgt9ZbNFFjXftr4usvoHxdCyCv8E81PUbk
R36eLurJF4Sw7dTW2XmXyB2y2Dfj5PivQvtp2PuNe3Bx8i8Wl3udkHcDLkq26aAU
/HbHEjwnYutb8pzq+AywMhFzUtNzJiTy+C+TCMnvapfZzMDUAjbxIRgqmYQ1N+n3
lUrk0+DCfd1B0LRibN0flkWseQwE9QLyPQmuJO4rd3tJC/0tAOw=
=QCTy
-----END PGP SIGNATURE-----

--1oHhrL+GCHd4ZVJt--
