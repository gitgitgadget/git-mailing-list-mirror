Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85286146A6D
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504368; cv=none; b=t/IslT4XWg52tLMVIMl/TqnaLWhh4jwlGVRr2XFgutGen5JRvTY/pOLusUMhxTyg8EgvImRQwqdICi8IUZiRPPJjMWqLYeiDKldqk7jMJQyl/IcEbRMUHj8a1QdsjnOndSYxv4IOCpDeo/kMvpgtGaJBFLQcVGy+mlpMebiV5cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504368; c=relaxed/simple;
	bh=1/V2RTBJfTTc7fsba8euc1KWsYM4aYxLdRNpqdmH6+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va7hIjMJVHH0piXPLnWOeTo3or9CU+jnhj3gpNr6AphCuSscPh8/rYhUK8bvWBK2njGtNaMiYMLCOjo+cYb1jxtt3zaLwm92D0Ls+JsEVWxqf0CvCwnsnKzccyD/5pCqaj0sYY0OxjSh+ZYPEcQgZX7JN1WYztJVM8iSvToHRd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E64jCCce; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nwlz81F4; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E64jCCce";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nwlz81F4"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A531C114010D;
	Tue,  4 Jun 2024 08:32:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 04 Jun 2024 08:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504365; x=1717590765; bh=eXWENe1ih3
	3E1cgthZURE6UrEzmR5927U+DnD6rxTMw=; b=E64jCCcemGvM7jhUle7Fi1Uk5L
	oIOohuKOLZMLP9QEhzqWIJkW6alWzYIDCZHkVPldP2Yr2zj1+ReWTtL7WJUp3O1W
	GWHvLBLwKUT0DbuGDBaWUlj8YJ6Ct/xQDm6IvPWjzL1THyb8QVOuLqN9QbXmj3QL
	I/h0T27Iiox3Qz9snNHhaTjHvCqMGSkbnbCYFgf5UScO25Mdx2LGhEXUBnpVjtlb
	0TGC46VaMxI8tV6oNBMWVKw7fg2YzW46sKEpwitAxaaacxFwswVEZN7WyQXCWBjF
	xud0EpikK2DjAK5xv9gp+grnzOhe8JIwx+zA+FY8+Yf86fW0rNvsbDKvxKHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504365; x=1717590765; bh=eXWENe1ih33E1cgthZURE6UrEzmR
	5927U+DnD6rxTMw=; b=Nwlz81F4VWrRe5MfhE64axpuBv2LEP74F2RrF2MEzJKM
	qffTR9lBTauo3ntctiZbZY09ChcbGjuP1/Y46d+HJHdX2Jmrdd+4VJsez2pkl+HX
	MQOd2ZyswPkIwIC8Lva6kimm570UfIWlVllGlrm697NloxiFDsG+ZYL9BctMI0jc
	7+USPy6BoRGAUFdNlwKLSWA7F4QpSdoZ95yHK7mortML6r+3U/KqZKjKKBeIRDlk
	iscFvT5FlujKfhpPY1pDNpHGql9Rt3+fKP39QOAsqVroicdCaLmfRHto6QnJxRIe
	WjQLe5rbTVHeqbgxiV5sDyWupAmcgczINlgQJV3OKQ==
X-ME-Sender: <xms:bQlfZh0h1TEWPvOgtBHLZZ6otuWkgiu2zOqIvrFEGYlyJBmhMRRc7w>
    <xme:bQlfZoFDMai2mkc-KN7DtlxOR-xJ5v0rfJrCycr1Cm2KI43VZ0mtCAJYQ952KrvgU
    ZCH_Ri3s2-D9sZQ6Q>
X-ME-Received: <xmr:bQlfZh786-8eRNobApFsoX81tfWerlT6mwrVp48RpNHtOC5OqD6FRkCcrmjHkf0nrliM1AHT9uiuVadq9hD9AvYhMHcYGvlju5SlenU6M8aY7vsk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:bQlfZu24iOAicK0ekAMtBZbVPK9eLaiSzvx_HbmXQ4BIPSRW3OlHDQ>
    <xmx:bQlfZkFvG61TE2aXIdoyEX-PYwvCFnVas4WN0OgeXon9L3je6ZQcmg>
    <xmx:bQlfZv9gdcmH76oA6xkkarvhqqKPUFcnrbWWHNiS2UupUoiocMTxjg>
    <xmx:bQlfZhn40DtEZ4XYeNllcSYTXsbYGz6TWpGcqOzP-uJsbQdC6Erzyw>
    <xmx:bQlfZiYoKng4SNqJoryKxju3gw1m-O3-zzCCPyeR7sj5JLxwz1CHivxS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:32:43 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 99b0a7a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:32:17 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:32:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v6 2/4] BreakingChanges: document upcoming change from "sha1"
 to "sha256"
Message-ID: <f7c6a66f7180a4d469fa269b1be3991b98f36c66.1717504292.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717504292.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aP3+feWwyAyRgZNH"
Content-Disposition: inline
In-Reply-To: <cover.1717504292.git.ps@pks.im>


--aP3+feWwyAyRgZNH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Starting with 8e42eb0e9a (doc: sha256 is no longer experimental,
2023-07-31), the "sha256" object format is no longer considered to be
experimental. Furthermore, the SHA-1 hash function is actively
recommended against by for example NIST and FIPS 140-2, and attacks
against it are becoming more practical both due to new weaknesses
(SHAppening, SHAttered, Shambles) and due to the ever-increasing
computing power. It is only a matter of time before it can be considered
to be broken completely.

Let's plan for this event by being active instead of waiting for it to
happend and announce that the default object format is going to change
=66rom "sha1" to "sha256" with Git 3.0.

All major Git implementations (libgit2, JGit, go-git) support the
"sha256" object format and are thus prepared for this change. The most
important missing piece in the puzzle is support in forges. But while
GitLab recently gained experimental support for the "sha256" object
format though, to the best of my knowledge GitHub doesn't support it
yet. Ideally, announcing this upcoming change will encourage forges to
start building that support.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.txt | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChan=
ges.txt
index 36327b13b8..5d7e80aebb 100644
--- a/Documentation/BreakingChanges.txt
+++ b/Documentation/BreakingChanges.txt
@@ -64,6 +64,36 @@ be changed to or replaced in case the alternative was im=
plemented already.
=20
 =3D=3D=3D Changes
=20
+* The default hash function for new repositories will be changed from "sha=
1"
+  to "sha256". SHA-1 has been deprecated by NIST in 2011 and is nowadays
+  recommended against in FIPS 140-2 and similar certifications. Furthermor=
e,
+  there are practical attacks on SHA-1 that weaken its cryptographic prope=
rties:
++
+  ** The SHAppening (2015). The first demonstration of a practical attack
+     against SHA-1 with 2^57 operations.
+  ** SHAttered (2017). Generation of two valid PDF files with 2^63 operati=
ons.
+  ** Birthday-Near-Collision (2019). This attack allows for chosen prefix
+     attacks with 2^68 operations.
+  ** Shambles (2020). This attack allows for chosen prefix attacks with 2^=
63
+     operations.
++
+While we have protections in place against known attacks, it is expected
+that more attacks against SHA-1 will be found by future research. Paired
+with the ever-growing capability of hardware, it is only a matter of time
+before SHA-1 will be considered broken completely. We want to be prepared
+and will thus change the default hash algorithm to "sha256" for newly
+initialized repositories.
++
+An important requirement for this change is that the ecosystem is ready to
+support the "sha256" object format. This includes popular Git libraries,
+applications and forges.
++
+There is no plan to deprecate the "sha1" object format at this point in ti=
me.
++
+Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
+<20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
+<CA+EOSBncr=3D4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
+
 =3D=3D=3D Removals
=20
 =3D=3D Superseded features that will not be deprecated
--=20
2.45.1.410.g58bac47f8e.dirty


--aP3+feWwyAyRgZNH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCWgACgkQVbJhu7ck
PpRFPw/+IBzs8b6YkfcaYa0w/v/Euv+7HQ05j+EK5Slz47iBLlrV8aEXN3iqTuFo
tuwkhkuqfTtqcvqNNyZanJr1Ek76r69dKq8Ss5QNBahz6LQzF/3n1ePwMZdWKux2
OUe6N5Ovpm7/JErH4MZIPVzemwGdxLmtJ80qjqXwnnGrO8E8afZBYCMbmJbfeawz
s5jBeYaf60wIhTwfKEqv9vzIH3P/OcNhv22PjAEOTstm4XjXY7Y8BG4IwrLRlQHA
YrK9A1UnI+s7XmUxdIdkP3m/FHNr2dAc2nXY6F7aHk1hxonMaRxAklH3WyUyOZxF
lpx/Jy30y9M2YzvmAuQZxQOz7GJ5CQolTmwhErVi4ERgRaQxNFUYplMyqd0Mziet
LERcR+10oKJERoeynJ0Oz+FjD63KCTqZBeGQgp81dSWxCN+to1Ch3WcJUB/TEMiM
4diTg5bcfC8h3t/xnCLqVoBEFIca6klJsG0NhwzHIwc4CIz6vzQicsKU305YizQn
N65LWWY2q1tb79ee2XsZ6qFimAUOPACUMzZjuvNLGgqhIHjkAtFHIYqs6MAuFZVE
M4bJg+WLXnWQgcXIJBjm9sux73k+DwxerupjlmPqJykO6xehEVJxFgs7nSxsnJGA
V2OF4r3MwHMcpSph0mfa3Vfchk/6gdGXgJFFn1CUSK6KRuYGA78=
=drsx
-----END PGP SIGNATURE-----

--aP3+feWwyAyRgZNH--
