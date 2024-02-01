Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAEA15B966
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783101; cv=none; b=ppRMhoziLu3ksfMxeUDagbSGGbUa3N9JF9UU7AlO+x8MiAA6/gy1TwmldDHvabXkZsi+j430nQzHjcgYd4Mfk2KOwWmI6kQDDcLV0AUwIVergYXTp/POuBslmIM2mCJjzVLmh1y7V3e7N76swUDHKQSBbhYScoYP2NBqPam7gpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783101; c=relaxed/simple;
	bh=y1hzHKkgSseN40p6V/GJ0InOJN0jnQdEIWn+H6T2FZs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R+9taKoLMvWYNhpCZZasWXpLexLuqC+kL9Zhfyg3pl5YBDRwyMk3Z/o+t3EUxGL8HyT5JjKkGWR2I+4ES5d/UW6GoB5Gn78sUoy8+3p3CPbBI6/KCfTQu7PSkA9UQ/Jss1HCiVJVgnBAI743YxQuEu48OMv7sWxKtXdJrD8Pg+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mNj+3fwg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OyueEJSD; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mNj+3fwg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OyueEJSD"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 83E271C0007E
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 05:24:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 01 Feb 2024 05:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1706783097; x=1706869497; bh=vybtnCOkSQQoj5S7EDJmPJ9r1EidNSih
	tnPwVBKytdM=; b=mNj+3fwgoo0JkGhr6vh+s2WOpRsr1KgHidTtOCGqgF1R6Z/1
	w6MwpNWPNOBpTP2sjzBJOXzlNaMdTdMHMzlhs6odH8tKWXkR5bNJNiJXb5eXP/gn
	2cNnzUU/EZ6jTCMijcbXj1o8+Ger1pq57AVmb3/pmvcj1mMpRPmYxdPy2lNcB7SV
	gxX3PLNW9IX9Xq+xw/o2Q3grETphlWipXzgh0oQrmibUoO9RDuGparOG7HItwTui
	4i1bHHbG9xNw+kb186Eo5TCyCIm8LmKnXs0fTDe3xdvd4RtfnrR4hXetwjuysqOh
	I8Z4fm2n4NZtyiMpNwZDu1Fj2/Muo7DGqgsbpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1706783097; x=1706869497; bh=vybtnCOkSQQoj5S7EDJmPJ9r1EidNSihtnP
	wVBKytdM=; b=OyueEJSD1agfuPOAfiHn7vWhpNTOdVfvI+vmlSIchp/R48pl0+k
	PUrqKSlGLYKFBeca4aM1EDwsLMQjnn5X19ByOR4MROFkeNg6AutKmoyR9+w5RILv
	rQ2wuyFXYy52MUfbl+Omdl+m3aahHsWZaESeUotcfwEcj2gplq2LC97/a6qbJ+0I
	QLfeJnBoQ9gJDWFfDQdhP9Iihvbwhw7OoKXEdzZvX0AxDsocohh/4xgKkb8/vfGN
	1NwMtP27Cv1wfuLDViEYnSJr/sezYsnru+26Mk12ej8BQkvySpdT7EEe/slSOJcL
	aLlPygpcK8S1laNqmyJzFsaOmjJtkh1c4Iw==
X-ME-Sender: <xms:eXG7ZTzekcojK_cq2CGEXTDM8EBGC5lwthxCKdflSk8YAk_4Q3BgEQ>
    <xme:eXG7ZbSjC31cd0z4noO6hDJ-T26m-ovxs3qK1kD4KU01QvHGySaSEFjJo5rfesovk
    LtP9vXU_7q6QTnXYg>
X-ME-Received: <xmr:eXG7ZdXDWKygBekOImqB_I04ej26JVfpR3d3f6YucHVMBYOatB355rf-P6S0UEDqLn4BTMoycKI0yvBEyP4TBfnxIzhXGPdTP4jKi-0RgFMFGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:eXG7Zdgr_KSAVDiioiDCkrJO3NlKC49PE2Jlrc0INgsOJCS1ilzuIg>
    <xmx:eXG7ZVB_JsbDAbUglzDgnYdoVroIBhTZMyqLQL5soXiEu4_nk5k8XQ>
    <xmx:eXG7ZWKxbDO5w7fgyABTmvCJhfxKYTXs2DxJX1Y9qDtvY9nOUTkD8A>
    <xmx:eXG7ZS7aS32N3SMdU_pO9dpUy_Xxl9KBDCKGmRGG9LCmF1y-xUgJzZLCZ-g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 1 Feb 2024 05:24:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f16aaa91 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 1 Feb 2024 10:21:33 +0000 (UTC)
Date: Thu, 1 Feb 2024 11:24:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/7] reftable: improve ref iteration performance
Message-ID: <cover.1706782841.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L5jabr7oXOs4aMax"
Content-Disposition: inline


--L5jabr7oXOs4aMax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series aims to improve performance when iterating over many
refs with the reftable backend. It mostly does so by trying to reduce
the number of allocations and avoiding useless copying of memory where
possible.

I've been careful to avoid conflicts with any in-flight topics, so it
should be fine for all of the topics to go in indepentently of each
other. The benchmarks have all been done with ps/reftable-backend at
066dced0b1 (ci: add jobs to test with the reftable backend, 2024-01-30).

Patrick

Patrick Steinhardt (7):
  reftable/record: introduce function to compare records by key
  reftable/merged: allocation-less dropping of shadowed records
  reftable/merged: skip comparison for records of the same subiter
  reftable/pq: allocation-less comparison of entry keys
  reftable/block: swap buffers instead of copying
  reftable/record: don't try to reallocate ref record name
  reftable/reader: add comments to `table_iter_next()`

 reftable/block.c  |  3 +--
 reftable/merged.c | 19 +++++++-------
 reftable/merged.h |  2 --
 reftable/pq.c     | 13 +--------
 reftable/reader.c | 26 +++++++++++-------
 reftable/record.c | 67 ++++++++++++++++++++++++++++++++++++++++++++---
 reftable/record.h |  7 +++++
 7 files changed, 100 insertions(+), 37 deletions(-)

--=20
2.43.GIT


--L5jabr7oXOs4aMax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7cXUACgkQVbJhu7ck
PpTNIA//W6ks7fxydp9YBNl2860e/G9uu7UIHzJtVNKyp0237IODXJhD5A9A2V+d
ucfmCtVOnxjFQMaJQrCpbiDTJa96NJZNbHczEEK9KcjaNSRd+qTHrRmIMakVGIJz
pSofaabd9ZELrN6Z8bwzbfP3/YZSk5ikpuhny/XGfWtMF7FCoRYsSd+aHUehhazp
cXMp2/a5D16rP8Vyhg89ghKTmbpHXa2+bRioNu+PDK2hPJTLEJX/Cwc+hZeGo/kr
M/R8h2Hy7RAv6VRFxquvFTadQC18xL3n7HMvT4SxUxvEenHrqFqR9zmiChfmWAin
sufYvFQB/uC5IeeO2t4TUnp7am6GmPEFaiOvMFSkIpQrTZd0zFezDGTPtdsC1kYJ
67DmAXZzVVPGMNNYhH+teQxuLH/i70UgglxpAcZemS7URTU8MlpgwaBRrvtCyvSo
3g7QtKYNqQvZMQRDHo571q7KJ5/TaOat1RXPhhvtydmauG0K3+/sSQw/LHRcuzi3
2Cj/hBAYvQwZSgZbsB8NzO2WyTcbfYXDDp6+9C3yQm0QWO89pxeniLAZ2LtS5EYs
7srD+UkDkoPC0l+Luz7nQb3iOy+Z2c+mwOoxPwj+lQsHoM8jhK8LbARKKJBRxtsp
iq8lFwjdEnolc5GpjpLXMl/fdr73nxmQJ+gzAUXCnD86OnApU7U=
=7cPV
-----END PGP SIGNATURE-----

--L5jabr7oXOs4aMax--
