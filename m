Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932F16D4D6
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336981; cv=none; b=Cm9Tb/Q/UrQWc2RlSVmz9AmCckSlevtmOs4gOfV1HmQGp3mzac0SupX3OGUwUuYYKzFDoo9RZwvkcCtjnVKxYw/W7jKWmKKPlFwo1YTQjdNBuv4jffRd828FPsYdtjuchnT7DOxnLLE7XV+o2wzfgRfZ5i5WZZzXIoLiGwCJFi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336981; c=relaxed/simple;
	bh=bTdvNkhNt1Dd7R0p9HaQQbZdFDtQm/dZCQoz4i4yAsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSYeNMgmVDwfvJf7zlStlm8XaoGkB0UQ+c7rQ3aGPWp3+q391sMLJwquuphymMXX0/TsEEVc9odqjRCPHJ1OTV7r8yjeUZnOzezEa37OXUGvL5+VnNI2iyVxRCzdRS0T2i/TxfQY7XbBmdr5x/79amaUHHwcYV0S3Mpu8CX1T3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vBVIFC2m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xul7QzvC; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vBVIFC2m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xul7QzvC"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id EDFFB180008D;
	Fri, 10 May 2024 06:29:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 10 May 2024 06:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715336978; x=1715423378; bh=f4lcxOJ8s7
	yfqr9ikE6inqnuBR2tNzMVz4kWzHwA7Z8=; b=vBVIFC2miCbv0QVYfpiF2tbJV0
	mY3zhNUl8ScYn9hOpaGYrZU/LwolS2DJDuX/MU3CfT3zeh2XIuW5u84tgUC9sWzl
	iAkf4F0LQdNKe4w3gPt4JiFG1BHGvsGyJZAofsB0ZXQi7XUW13O0/4RSpYqZEz1n
	YsDSeCwCnElUthkCMcywSQc12q+P7XnqUkMVm6Fp/b9b7M8LeAz+1w4e6Sss9btY
	ojTcsj7BhMqv/lwthAQVaVAWju/X2sj/C3gdzgQB57W5w06Z3XsPyk+1ADiRWt6c
	o+9Rcfm5PsInOpR9JRTXkNX2tU7NWze/Brqh67LgTcUqd/SJfa5SIUfLV0qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715336978; x=1715423378; bh=f4lcxOJ8s7yfqr9ikE6inqnuBR2t
	NzMVz4kWzHwA7Z8=; b=Xul7QzvC19xPfpJsNJq51u6YAxH5X/3/aeGIY2qNkj3+
	n1HBkZsKZVMhQXXM5oOd8om8UbE7pK5IVG3/b5Bb8yCtMRbCxyQfGXOxJkPrBENe
	nIDhVco+wEa1PTtreS4VrQZRWhNkozf9DltCDaRmIXdfY9pceFnlB4FWTYb6UKPI
	3CPL6iYxm+HMXncbKOWLnvouKP1P8BNseIU/ijpkc84HrCuOpY9CW/3dvi0fvNHR
	wxD1aJAQz+j3NDckF37Wg/mXy1ei6czHsBsgy2giXKGvJLDhOg9C9zlludVkLvpV
	thnchfoutrAAdHHM5l56gRlWZWb8KWDwtYKCCjJbIQ==
X-ME-Sender: <xms:Evc9ZsgX5Tu7a4TABYi1M_CjouyvEAwsABPUDdduzl5xNBFHs3L9ig>
    <xme:Evc9ZlDsPvh44I009dRKofrTQnVDQ35c5jZJxF8ncL-xXL6yuZe49f9N9onGDwNtP
    T5409DAYwDrMEfxWQ>
X-ME-Received: <xmr:Evc9ZkHWOmxIBAWnW1m-3_BNcPoBt6o5ZqY7LmBRq_Ms77uh6f9MInOeqOf-DYRWw7Qyes9pFfEKzJvLmBiYGebwKC8mp5GOXFn6iFjXgV7rU0pDIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Evc9ZtQLWxgFjtGPtWmjkyin-uu9NRoKkaS410VtUdyPAXRp-9l5lg>
    <xmx:Evc9ZpxFGCd735DCBS7-TDd--O3r9s2K9lm62Ox_6rwg7f84AYlAyA>
    <xmx:Evc9Zr5nlmjxx4Ci9d--DxFGYYPrL-DYgi8lIWTL9Pct8lB2NrHlGw>
    <xmx:Evc9ZmxxBIOZdHpHmapmUG8cJnzBdUSCKXdAx8rVku9OoEpEX376Tg>
    <xmx:Evc9Zh_H8MtHim6mUVQEh3M7WtjqSHUOYhyhdT0-SxB6Y4oKUnu8zxV3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 06:29:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 652b5fa0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 10:29:25 +0000 (UTC)
Date: Fri, 10 May 2024 12:29:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 04/11] reftable/writer: improve error when passed an
 invalid block size
Message-ID: <5e7cbb7b193c578f7c946a5077a79421b0ac57f2.1715336798.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715336797.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2MDlxsCANLTH6yno"
Content-Disposition: inline
In-Reply-To: <cover.1715336797.git.ps@pks.im>


--2MDlxsCANLTH6yno
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reftable format only supports block sizes up to 16MB. When the
writer is being passed a value bigger than that it simply calls
abort(3P), which isn't all that helpful due to the lack of a proper
error message.

Improve this by calling `BUG()` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 7df6e53699..374b7d15ed 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -125,10 +125,8 @@ reftable_new_writer(ssize_t (*writer_func)(void *, con=
st void *, size_t),
 	struct reftable_writer *wp =3D reftable_calloc(1, sizeof(*wp));
=20
 	options_set_defaults(&opts);
-	if (opts.block_size >=3D (1 << 24)) {
-		/* TODO - error return? */
-		abort();
-	}
+	if (opts.block_size >=3D (1 << 24))
+		BUG("configured block size exceeds 16MB");
=20
 	strbuf_init(&wp->block_writer_data.last_key, 0);
 	strbuf_init(&wp->last_key, 0);
--=20
2.45.0


--2MDlxsCANLTH6yno
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY99w4ACgkQVbJhu7ck
PpQwdxAAj/qFLueOeQH9sMxCTNywzD89NmN8hPEGAOagNwfV2HmePVAze78YVGU3
OL33FTa+U0ej+R5//8/QzkV/qShQrkpATSIKWS/vSymevgUhFQquxQLm3M78hT0F
fWMllawdT3xWLL+WNu+IMhs9gEtMGFHlkLf34EAzsfnkK4QuUun9auXOSa3cy5s/
UdzdQPo5Mxq9ONErUmbh6YbFX44xRQe17AZRWksRNaMCh36itHq+p52hdOv8Kwpf
yy+1HI1EC3QyFiBvOMh6dS/emNe7TMPSy+EFcc4UVMYOQKxPqvbQe1zVgy0qIyPg
EkQX10ZBKoPUV2Jc/4/aimUoPqPFx4JSZ9B6zzWu94qBtNXqtH8bBojaE3vlkbH1
lIAZP5kekcEcGqRyCC2uDHYJMYGw14/8vGwik7xBH8MmD+ZjsMKJSQyF6NZrySY8
eIMa34pyghXcEpPNgtXlFp05CP4pFbXjlk6i97F5ELZjNGwfX1ujxBArRkye0hjV
jzFLX/d12oSUeO1UnKqjrP8dBfM/ivPo4WTrs4MlmG+R+k7luL57Z9loDMOyOJtW
smflczziBQch9qls58Y+39FrDnaC6W4CXHYF6mVZCJfffDCraTdaj9D8M4cacWXe
2sQm9SodHIJLB1v4Y2iaQBGOPUXMCSc0kYNACmia2KEbDyuLVr0=
=tj4/
-----END PGP SIGNATURE-----

--2MDlxsCANLTH6yno--
