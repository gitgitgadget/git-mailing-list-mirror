Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DEC20B07
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705573371; cv=none; b=FLDdQOmysuLSpdFCcaKMjER8UDZ6Ya0NGtM5Vf80xJjdK+hSeWQzsQfX4TztTw4XBXH8TWbkToMbXNUXTxD9faBYvf0SA2H3ymOyUtIPJW5Nez5zhvkGvXyheF2qVUqqt0srZI5KiOar3yWo+UWyJyf+j5KDvGK8k+iFFk7XjSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705573371; c=relaxed/simple;
	bh=wK+2+gUpfNjkJQ05f5iGjLgPRKag1IBF39hdMTwn7Ek=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=LzJsPw6t1xUQCt11/NR0plfFCHr8CvbT08CbLAigP96yqrOR1kFwONXdDhos8BgmmA4OSFlBdZEWf9ZX2NYkca8cwaruHBU7vSsE0Mhcz0uCsrzZJoyxYki3War2R6tpEwPMNc4nWSOYMbufOpv01ayycArjPELGJqDfiV+DKhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YUtP/5TW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BsCvcOqU; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YUtP/5TW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BsCvcOqU"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 9C7733200BD7;
	Thu, 18 Jan 2024 05:22:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 18 Jan 2024 05:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705573368; x=1705659768; bh=+iAyRC6/ik
	4QrHHjYSEp6uy2a7XDNxSQv9CFh7KHCcg=; b=YUtP/5TWxvXi7DyDmikjg94y4b
	1xRqSHIoEMfyhmafAGsMal8qVuTkNwBCnj+2oY0auNvzMTCZ3ySTAlKknz2QcgJ6
	49Tt8b6SllbaVwAcc+k3uMvBWtlcWbKjOZmplBxrR7vJiV47N9Aijz5LBp1ivgTC
	p8jf6yacLCOaUKzKBc2jEwzk6aHnrvE90StslG26L53UWiwj2CumyY7Fk1gCZOAY
	1D0oXjKu6cB9OJeQorxcEygrs3QnkSWfhc4sHKJlz3+F7ilbXt5Esdl2ZBuwpMf/
	d02E4nxkUOvq0fez02BdHib967BvIgzWkYCVxjMgOcri0y3xW/IRUgXEzD+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705573368; x=1705659768; bh=+iAyRC6/ik4QrHHjYSEp6uy2a7XD
	NxSQv9CFh7KHCcg=; b=BsCvcOqUadEYQvgu/QW/PoVk2Y/6Z61F1rZQ/IHv4oiU
	JDh1mfiLFG3vMDyrr+ruOAsw9zRC5DxRJc84YVD0fZlTcsJA0UL8zB1hZZQIBXg3
	RkwaBK7FmBjaVzjgRsHEJw6bFCEqdOXehH33QjTbfb8apcGHRt8Q5CuQzzI90zao
	7FF90S4JRsywMlV7nd4AyqUsxIToo8+SaTK2VMDHTHZeyNjaxYj7PgKxX6VVOxfC
	rbCx38E6tiNa984mooC5Z2JOOFmlGSERo/moF+DRMAv8rTE459ia01/p5ITqe+hk
	bECNXVDnrvQHte/A7fz+ReyBgBonbidWnWp7uOd6ZQ==
X-ME-Sender: <xms:9_uoZYlljYkrN4IZ0I4edFiAuDA-kNMWZgQSR1tbJwCR1i6ROYtnWQ>
    <xme:9_uoZX1tr0pP690i3vKPbso1eW4cSDpzFo7-yGSkeK6utn1T2yM5CxUYUYf8u2hFi
    0dPJjNeQsWiLLERYA>
X-ME-Received: <xmr:9_uoZWpErLX22RTD_wx31AwZXgkdgDL53F1YW8HPwHdHxOgudpDCMDSxUVtPq4VUA6MEPL6AZfHX1LwvVBa3MlAyTan1l6YRTe353H7BH0H0mVE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejjedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:-PuoZUnJa2JDddZfv4LIP9KhFhVs3xW9qO1MX-if4tM7qQJi1G6_9Q>
    <xmx:-PuoZW0OTNjfeR8i6QfZ3z1wRZTZ1jh4oxR4qwBxO9iqJ6h9e8Fuug>
    <xmx:-PuoZbuuusDPZZbvVGdQ2mEvvhwG6ky_PdpXIjlg6a6uwW-cNbioBg>
    <xmx:-PuoZb9UzStCaZcW8ysqbnj9igtxyctxju5gKi-uEqiyu5ulP6lg2Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 05:22:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cb9f778c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jan 2024 10:19:52 +0000 (UTC)
Date: Thu, 18 Jan 2024 11:22:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Matthias =?iso-8859-1?Q?A=DFhauer?= <mha1993@live.de>
Subject: [PATCH v2 1/5] t7527: decrease likelihood of racing with fsmonitor
 daemon
Message-ID: <554b1c85463306809a3503622ec6927165e2f4c2.1705573336.git.ps@pks.im>
References: <cover.1705318985.git.ps@pks.im>
 <cover.1705573336.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aIzQYFezaZUTpjlm"
Content-Disposition: inline
In-Reply-To: <cover.1705573336.git.ps@pks.im>


--aIzQYFezaZUTpjlm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t7527, we test that the builtin fsmonitor daemon works well in
various edge cases. One of these tests is frequently failing because
events reported by the fsmonitor--daemon are missing an expected event.
This failure is essentially a race condition: we do not wait for the
daemon to flush out all events before we ask it to quit. Consequently,
it can happen that we miss some expected events.

In other testcases we counteract this race by sending a simple query to
the daemon. Quoting a comment:

  We run a simple query after modifying the filesystem just to introduce
  a bit of a delay so that the trace logging from the daemon has time to
  get flushed to disk.

Now this workaround is not a "proper" fix as we do not wait for all
events to have been synchronized in a deterministic way. But this fix
seems to be sufficient for all the other tests to pass, so it must not
be all that bad.

Convert the failing test to do the same. While the test was previously
failing in about 50% of the test runs, I couldn't reproduce the failure
after the change anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7527-builtin-fsmonitor.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 78503158fd..363f9dc0e4 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -978,7 +978,7 @@ test_expect_success !UNICODE_COMPOSITION_SENSITIVE 'Uni=
code nfc/nfd' '
 	mkdir test_unicode/nfd &&
 	mkdir test_unicode/nfd/d_${utf8_nfd} &&
=20
-	git -C test_unicode fsmonitor--daemon stop &&
+	test-tool -C test_unicode fsmonitor-client query --token 0 &&
=20
 	if test_have_prereq UNICODE_NFC_PRESERVED
 	then
--=20
2.43.GIT


--aIzQYFezaZUTpjlm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWo+/QACgkQVbJhu7ck
PpTSrQ/+JPsU7M1SVmwemld9NmZvJwCM9BLAHQ8Z0ztp5aghrsf7L/UpMIagrTme
fJlg8VOuJOcj1g4dLeI9biDAL7e2hr85i3brdyY710eLR79OKdXWP3yETLccD4zc
F7Anp/vXJQ8WzML4/wPLk+t6n0Dp3GifP78xpthm9chIi6YlMRytxipq7KXfeSM0
sS62nL0cxrD5lJORQOS4rtKgJ8F1rrsjfwYnwFK4HlDx6bHAW5WDVlQ3fB6tuq7l
WE/bPaXr5CQutbn1u9Yo+PsF/WE9/PQJCLzKomCFdIjAiCVCUjHp5t44XQUcU/1v
5Hj7+NbEo+7JQXyjmLZKHfZT6ML0wIgbjWlkYfzqwTaKdlzmXQR3tRgv/VuWGzZw
LwJZ7Q7gQMZSSmov38sv8/ZeuwkpTp/IkNVfpPTWov8iM7fnUbgCvCGM6lUmVe8/
kkC6EYdpI305joLKELAelT8ep8/nZkG2N3TpDeopg8HyWaViZEl6QjJPq3yEzRDI
5KHiZb/YYQDNVaKklOwE7+bMvLAgtNjq73HgsycBizjw3b54CYbXQiaOsOuO7oSK
AlcUkLY6MzsqTNSyEHOS7mgseDKZ/xSB/Z/7CVLvrr/Ufijt606IVVO1wUEn+E3y
Nd9qGF2FG2bhAJjeG5QKBXkaefHXT7q3H5kDJOXo+sWlD7TbxVM=
=I/S7
-----END PGP SIGNATURE-----

--aIzQYFezaZUTpjlm--
