Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B7B51016
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452741; cv=none; b=bIbx5LXr77NZLZ6teTUGKLXIEMbt+63ix0Y3c50b/wY4Zzxe/JDNni+XMyGU4I5LA4g/yfoqJkVGQIRjBskU5v9fdALQ60mVyctR8WdRCBpEpLUHVX3zIZaPPv0mUMvgSYv8DvjlY3yf9+29Izt+J/xlkmECgAvOx1VEUAH+XUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452741; c=relaxed/simple;
	bh=yjnmWWzgJO+0SDU6bPjlJc+MLRFH/US2Oh08GHcEgiQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlArc22Hc0dtTInXFaRHgxxY+ZrvWp8IjMQsRizOehMDCxDa62ElHl42HUnt2mJI/igemBV0iyDwmQhgTBFn2AbR5T+W6CF8Pypqozai/w8XVGTUkbMi878ocUkkP+of4aR0xKE1zRHvm6F1+C2BcOcCtOWEG5VpVr10rwPkeUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YJF8Cz2Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lliDImXs; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YJF8Cz2Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lliDImXs"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 61F141C001BF
	for <git@vger.kernel.org>; Thu, 23 May 2024 04:25:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 23 May 2024 04:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716452738; x=1716539138; bh=cBKHorsgIP
	qLum/sJE/z+SFje0Z6oH2wG/xOJIj7wYk=; b=YJF8Cz2QkV/y8RPmw7FtxDe7LN
	33jvwwHi2z2Ox/jCjbFmS3oLyoDjj4ykCxA1UbzEDIE6z2E00l7sySlkwT9mtSgj
	ehVRhzKJv2Yq3PDQ5S2rBqijlgXjVtWsMc3ixKmQsDNEvGY4wLjN28VusrRLXvjt
	vYvjQw/w3bEmgFENHm8zitnNkGjut/IBsjAQtEW+OcrO+MNMbIdaX9JPPk2dlL50
	v3BqVhUZJx6seFdq1TEw6xXZ5NVHqkXm+nDFDaxGr7hTTR1huwRbKWau5iQ7Sflu
	xCyWIXdlvsyeCQSLNKw8IKiunBTI/x8O0ROWx6VVMo8E93H04VwfF3T1b7hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716452738; x=1716539138; bh=cBKHorsgIPqLum/sJE/z+SFje0Z6
	oH2wG/xOJIj7wYk=; b=lliDImXsMIS/XQHJ7qNjY2C0+VjYtZe4IogT9o6lTJak
	QfWzh6l/vFj4abQRllSF+uCC59X6KoL2edrowvZj12/aINNYmRZ7/9HecRcBOXUO
	zj6FhUtMjKWxhqXb0/l+yRj/bD8XTo3sQ4GMtg5jWR650PFMICstE1xM6wMauzfD
	WIz1MGY1HJ4mHvgVuuc5G2/Yit0+owUpVkUcHoEILTLAr5wLC3dvHw8SsxFu8rh4
	IJR+UInT7P5WLfUfNa5Yomr8GFmi+v0lAGoq11VgymY9lDI4bukmN0APikRjx7Uu
	mFzulR5NuJPRKdyg2JnGXQ23bMwlKFWoJwa4sxs0Xg==
X-ME-Sender: <xms:gv1OZlRLPxMkne2sL6UcH6z9-DXwDcc0_LelEuxCFvpAmCZQJDmwvw>
    <xme:gv1OZuymBqGwvafhkoUB7iiqBdR1tzVCPRtsaD1GuAgcqM8NQ7KmXE8x-jU8VIAgc
    AVPfCluax_SEmD1kA>
X-ME-Received: <xmr:gv1OZq1yvQr3B6Eg5irrSjS188xmx8-_u2oi8G1nTg5T8GeHYZ4QxfN6xBlCzT-jdIab84jL-pziBsLev4apPSbc8EQ0gi0LyP9tlwkVLC9ABLP5Eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:gv1OZtCtEMouskyFZrCLVRotefFef3R-BhuSUK-DvX6uXfSBUznrzw>
    <xmx:gv1OZuilRt2IdZZAKt9BIMJLZtXL19V3udVsHPBgIQHlSOscSH1UGQ>
    <xmx:gv1OZhqw6VITuN8uHzY-ucDtLJHQj8zgVKbh8EMGupS6Amob-mNluw>
    <xmx:gv1OZpjoTJgqJFtdOUzhEGZ8TnFCem9qL0zYNDRsEhu8h_IFQuEEqQ>
    <xmx:gv1OZiajgdKwQBWTUACn3eSzDurYCSPDkBklpbkTWNLC8q8zShB0oYbl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 04:25:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6503de7a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 08:25:32 +0000 (UTC)
Date: Thu, 23 May 2024 10:25:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/9] refs/files: refactor `add_pseudoref_and_head_entries()`
Message-ID: <71f31fe66ce8eb95fbbb8a646dad571ff57b8a72.1716451672.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xaStmVYuCLK7hYZ7"
Content-Disposition: inline
In-Reply-To: <cover.1716451672.git.ps@pks.im>


--xaStmVYuCLK7hYZ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `add_pseudoref_and_head_entries()` function accepts both the ref
store as well as a directory name as input. This is unnecessary though
as the ref store already uniquely identifies the root directory of the
ref store anyway.

Furthermore, the function is misnamed now that we have clarified the
meaning of pseudorefs as it doesn't add pseudorefs, but root refs.
Rename it accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bd0d63bcba..b4e5437ffe 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -324,16 +324,14 @@ static void loose_fill_ref_dir(struct ref_store *ref_=
store,
 }
=20
 /*
- * Add pseudorefs to the ref dir by parsing the directory for any files
- * which follow the pseudoref syntax.
+ * Add root refs to the ref dir by parsing the directory for any files whi=
ch
+ * follow the root ref syntax.
  */
-static void add_pseudoref_and_head_entries(struct ref_store *ref_store,
-					 struct ref_dir *dir,
-					 const char *dirname)
+static void add_root_refs(struct files_ref_store *refs,
+			  struct ref_dir *dir)
 {
-	struct files_ref_store *refs =3D
-		files_downcast(ref_store, REF_STORE_READ, "fill_ref_dir");
 	struct strbuf path =3D STRBUF_INIT, refname =3D STRBUF_INIT;
+	const char *dirname =3D refs->loose->root->name;
 	struct dirent *de;
 	size_t dirnamelen;
 	DIR *d;
@@ -388,8 +386,7 @@ static struct ref_cache *get_loose_ref_cache(struct fil=
es_ref_store *refs,
 		dir =3D get_ref_dir(refs->loose->root);
=20
 		if (flags & DO_FOR_EACH_INCLUDE_ROOT_REFS)
-			add_pseudoref_and_head_entries(dir->cache->ref_store, dir,
-						       refs->loose->root->name);
+			add_root_refs(refs, dir);
=20
 		/*
 		 * Add an incomplete entry for "refs/" (to be filled
--=20
2.45.1.216.g4365c6fcf9.dirty


--xaStmVYuCLK7hYZ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZO/X8ACgkQVbJhu7ck
PpQ6Eg//dcXb346nZ/hzcy/7fPvE6p8ioyHWLUkzTUEnKHhvFS4YowVLQqZ4+Ko1
meWzGjaobi8MNP0I2Qi4Bibn3n5bdQC6cRhclufvs5j5qaGXKGM/d4GNJRzoMQg/
N+l+t+pVEUSZPgcUrt29zJX0qG4WnS/PMVALA+7BWqJmKJn05iiHeZiNB3qjov7m
v0zfOKOhyhIe6RADTUeAaqOoTLOeeoA1qVUFayqaagzeE12eFZSHtN2sxOa2yidz
9fi0KXYvXQ77YMiimvgIHZ+SP5ybTXw11oTZRdrAhPJ1L3IiP/2iT19lixUV+rKm
w1ViUPic0ZhSwXSpwLLya7naz1dMKNSNqaXnjsp/m9oW1KKG49ihqwzQd7D9wZPH
HVeno03iX8hz1PBLX7VZm0R7Fz28Xi95e3Wn60m8nv9emFUaRyYQRhdlEKVMvN+f
Jq0hYdd40vlW/8LI//x1BOsqCGsvqyIblV5pcP8U57p2M6CTwKpvotgNNv5b07EC
ntlR/onRK5HrMnS08Vk7yK+w5crC8T0QO71I9525f3VxPbENefrwJmSCFU3GK6ZS
WQ/aZX76blPXprx9Aw6F0H/DC+5tFJ6LLjPLd76rAiPDFzsZ7th2TV3q7rgT++lP
tMmcU33Az6YJ3FkW/vMWJFuIVUFCefqaLbYOB/CKkOLLsST3zKA=
=gdo5
-----END PGP SIGNATURE-----

--xaStmVYuCLK7hYZ7--
