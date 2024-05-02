Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8983F3219F
	for <git@vger.kernel.org>; Thu,  2 May 2024 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637849; cv=none; b=VsKtmQ+46Y17KqmyXnsniLeRZZlzZgPfOKPyR/OvF1qjirz11mT9tV1DrWe1SZj6LqdGo7majd91T3/rUwdRvMjrBMMHTnE2sR4UglsHGRJpkkUQUu+tyINMXXB9XZn2JWcJ3zW70vvoKLuhpTNu7Wju5edR2hVTFbyFa/eN1Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637849; c=relaxed/simple;
	bh=RonLS48SSZtjpGEkLBiYee+bvKSEIKkNF7dYon1g4Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/rL0gEvy77fGnw3vWIbbo6GCcqVeZ2Lc4FMKJPuIIwh5pwb1Kx8DtBIYBiu7AbwmNq2zZtvBP+iv/hZ6bkkBvZexcpJ51/gvet2fdREkWtI0xaQoJC7fo0FFkN2gG2Ul4NAr5fHGaTo+WKBUSEA+Uxnies8ICAiKCOKlKBLAxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=voggLHWm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RGHLtQTf; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="voggLHWm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RGHLtQTf"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 93D1613805A3;
	Thu,  2 May 2024 04:17:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 02 May 2024 04:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714637846; x=1714724246; bh=0119PLtSYI
	aLAg1hqdVX8y+M++1Mg7bgMYNr0PwD6wU=; b=voggLHWmJyTMa90eD31RuQRvlj
	p2wBaH4FmwKvsfDb3ODZ0g+l/uKi6D06HxOmeQr2W0f6XPSmBI41nPjgrtQdKQhS
	rj9hrz1fRkAaKrtcuTHOtXLfO6xp1/bl8yz4DgUy4UuRpdbNPFzyAD+iYsi9ClrW
	5kdXzj48R619wy9SpwqPy0WvkFqP6zQ7QKnt1TzvqTiJKHDqlQGxINn9w255C4Tr
	5dvqYiH/3P4YIXFaxpIhQZRY5LXRLnZWml1jrGiUOpK6zeAgqp8p4Z8IDV09KVaS
	QsQWfGumDVBTzYmOZelX4vujpfbUmQppL6waIXQihxMvksMyctLNDYgUWxvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714637846; x=1714724246; bh=0119PLtSYIaLAg1hqdVX8y+M++1M
	g7bgMYNr0PwD6wU=; b=RGHLtQTfG5iP45D4/ZuouZ311NaQfyOvFV5iGzxukWoP
	3e0qnVwitnqGt6KahMr7SpyODT9udvAov4YCkMTeyEXX5x6GSAYq82Px8F0iP7WO
	b+FqrQ8ThyUL/fy5QzFmcXZCJGG6RLcjVl5shly4nOYkUUF5PjPYsg+l5YMWUl+q
	xYf5PolZaRFasWYOiGb2/FK+45FooXzZWutJoJCKSuiO6jqpkurjjvx9ewc8u5bt
	tCfPIkOOUttJzc7kxI9NRQnIJrzIMEUsEkTSfTW2H9mUVnUTAuv/q9dCUhtdZo7s
	LLMRSwZj0QlIkrqGAXOLbjINYBMj9wOy+AFxbJHlNQ==
X-ME-Sender: <xms:FkwzZi109Xot6AnY8EmmnF9URQ09hluN7GLV3ETGzDYCVASfruJqIQ>
    <xme:FkwzZlEBVUhigcvMklWDmQNQTLN1q96zEGlpzsCIRKDQit4tCpJIbc9_k5pbdSS6M
    pJ2ZRkdkmlXWrtFiQ>
X-ME-Received: <xmr:FkwzZq6tbJc2DRe0GZqLJ9oiL7eSPL0cekCm6BZzwW5X5sLHE66ddqsTGg3t0gg70gyeG41u6AhyCdc6TwkleNyAPi5d75MbH87JaOBFN48kSKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:FkwzZj2zm2Lax5-mXZzhD7FwML4_cdlVXyXAeZGI8Zh-KzPiAm400Q>
    <xmx:FkwzZlHj0z0dEvm8bRzwKB6WQGBFMyrgeDhJ0Amto1umhUINN1sOxg>
    <xmx:FkwzZs8rBf8UdpV-jLkUQalY80A5dCYL_NBh5plYRP7mbRD-UiH01A>
    <xmx:FkwzZqkyAZIR5sYgj9czHE-kUfYjl0EOWElYQM7yD_E5WB3ekXTQ9w>
    <xmx:FkwzZs2BtfJVJfeLAcJ67aAcMKoqltsKXSEboYOgX12h7cZBYs0wx9Eg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 04:17:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id da26fcbe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 08:16:59 +0000 (UTC)
Date: Thu, 2 May 2024 10:17:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 03/10] Documentation/glossary: define root refs as refs
Message-ID: <243d616101350c03b1b536f9e26d05ca749d08d5.1714637671.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714637671.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vcRHRynvmB/dj8rG"
Content-Disposition: inline
In-Reply-To: <cover.1714637671.git.ps@pks.im>


--vcRHRynvmB/dj8rG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Except for the pseudorefs MERGE_HEAD and FETCH_HEAD, all refs that live
in the root of the ref hierarchy behave the exact same as normal refs.
They can be symbolic refs or direct refs and can be read, iterated over
and written via normal tooling. All of these refs are stored in the ref
backends, which further demonstrates that they are just normal refs.

Extend the definition of "ref" to also cover such root refs. The only
additional restriction for root refs is that they must conform to a
specific naming schema.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/glossary-content.txt | 32 +++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-co=
ntent.txt
index b464b926d5..d6cf907a19 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -550,20 +550,38 @@ The following pseudorefs are known to Git:
 	to the result.
=20
 [[def_ref]]ref::
-	A name that begins with `refs/` (e.g. `refs/heads/master`)
-	that points to an <<def_object_name,object name>> or another
-	ref (the latter is called a <<def_symref,symbolic ref>>).
+	A name that that points to an <<def_object_name,object name>> or
+	another ref (the latter is called a <<def_symref,symbolic ref>>).
 	For convenience, a ref can sometimes be abbreviated when used
 	as an argument to a Git command; see linkgit:gitrevisions[7]
 	for details.
 	Refs are stored in the <<def_repository,repository>>.
 +
 The ref namespace is hierarchical.
-Different subhierarchies are used for different purposes (e.g. the
-`refs/heads/` hierarchy is used to represent local branches).
+Ref names must either start with `refs/` or be located in the root of
+the hierarchy. For the latter, their name must follow these rules:
 +
-There are a few special-purpose refs that do not begin with `refs/`.
-The most notable example is `HEAD`.
+ - The name consists of only upper-case characters or underscores.
+
+ - The name ends with "`_HEAD`" or is equal to "`HEAD`".
++
+There are some irregular refs in the root of the hierarchy that do not
+match these rules. The following list is exhaustive and shall not be
+extended in the future:
++
+ - AUTO_MERGE
+
+ - BISECT_EXPECTED_REV
+
+ - NOTES_MERGE_PARTIAL
+
+ - NOTES_MERGE_REF
+
+ - MERGE_AUTOSTASH
++
+Different subhierarchies are used for different purposes. For example,
+the `refs/heads/` hierarchy is used to represent local branches whereas
+the `refs/tags/` hierarchy is used to represent local tags..
=20
 [[def_reflog]]reflog::
 	A reflog shows the local "history" of a ref.  In other words,
--=20
2.45.0


--vcRHRynvmB/dj8rG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzTBEACgkQVbJhu7ck
PpTtwxAAg3nI9etOtihDTKt9OBYl+7UJweij5pyhmWIpQP6RUiH2yIjaoBA3rndD
d6+PgH6ISm1eLRl4xkwZNsdbkCGZfAM7qFxr8BFokKRDtTQyE+n8btNHh7TUxSPa
RbwDOxoJVaykJdHR5ghgNyufmCKd8up4fmw2mMWkpnZrIKiNotlHQCMwulWpTcQR
/F5O9GP8T+aazDv6+5UCihrzTYqpeCo5lNf2FlQLKR631R8hbVsxAyxmlLhxozfm
w/4d99RAmmqd6rcYk/8tLVvwq+l1OUO1TeGywnhKDq/Nu4T28Xn0tiAYuzD0YYND
JESbBPupf+7vFpKYtpsWcwMGFFgFziQnTH3D8uvWriF7MxiWGPBQxnJ8oABlwYvN
/O93mA4PAXH9kHbG4UbzdVZkSOq0EinANZc02OblQaBlRpFLzwvnGpFrC+OBezyw
/MRLP+0cbVtEx+QW/WBCDtnHsclLN7cjHQqx6t7TGPDBT6RJjNJ+NllFojaHkgLa
bNKpZKTGosiDfibUss+gt0W3uBBFzN66eJI/Dm9C96OmhwkDwqWz1HDoEJTaZ6mq
QtJRTlbUFDAmhUzPIXeJND+Dk4SOCjXa2NVdzm3uKska/kXC394tWtDoeFHtZWOS
mX067ph/vGoqzHXvjyoJpR+fkdMAV/GOtczveI04nsAA0Xi2blw=
=sJIf
-----END PGP SIGNATURE-----

--vcRHRynvmB/dj8rG--
