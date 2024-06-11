Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D86E17D889
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107137; cv=none; b=kEZTyrj8/DZC/e3KaDuH5/xr1pG6+bldHiIOlgEw8lEnuJ1Bcv0EjOo8/17yb5+w/25o3OhflHnRp1n19TPJEpCIeR/qcH3lYj331KjilTVZFyzNTUgABAghJmXQZ3sjUgzEJh2kDkbwqGTTUo6PcOi6BO/eUEtIhfOb3M68WNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107137; c=relaxed/simple;
	bh=tX2vZ+c4ezE0VGsnDYOybfa/eEQci6DfUzPQC/boCGg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzbDnXqwXSi+qcQhkxpFLcVMENVvcOKkEfFvkqgp++eZBhg6wS6FWg4wWNYMXAX/WM5udu9p/SgAfP3SL/cuLGh6Rm++NF0nJRaaz4IUNANRLY0immk7rqsb6/kA3C9MLTKoMFXDM7XJQg1pcHdi/zi/WwXN4t3f33Iy5qjTDdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CcsJj4PU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DV973H6C; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CcsJj4PU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DV973H6C"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 151BD1800060
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 11 Jun 2024 07:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718107135; x=1718193535; bh=juXcTt1UvI
	1XEVkb2x1AX6LFALmtl+GpDIFDuSt7s2g=; b=CcsJj4PUoxRzC4T7k5rofveTi9
	Pmyzpt7SuK+s65EfmVAnnJuiotqNkbbjRoLmyFVWRu3l+UFvQV8QHJpiY7IXSqjl
	BYemTlEB3XsrKMbdkbxC7I7q3q5Qx3zbw5B7dLvMF59wG2QyV7LO6/cv3A5ZFjEY
	sl2X5xIQiHCC/1Ki2ggi3lI/ytqPWknei+uyRFRQK5KB+sMMryam039md6+7nO82
	GXBvxZYz2Fq2zkRKSeodP2FEucPsejlMCYS1X/J7VicSCaglDOPLL4PIH7hLoUah
	Icbm/SqY/nsgPu1QWPkd0psuhuxDV/+RsbTMYijhjuqVk7jKQfEtflqLDkJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718107135; x=1718193535; bh=juXcTt1UvI1XEVkb2x1AX6LFALmt
	l+GpDIFDuSt7s2g=; b=DV973H6CCoOMnidXsGdTw6IEhu/KHczaOohW0NtnjORO
	OaEDVouuQ+kV2PHi0u/7bj3nHGvvE83521TVyqbq07fqcQ3vllHZgDYkGcoM7sJG
	8vEbiqbByl3P1906IEbZlMPFIpxSJr+P0IpM2Yd8LB9w5GaPMCF9ISVRgyKFDyGc
	NGhNgMWwKs2RDSMTRrB/FxIgNEyAU7or608qVsT3l2iyMtgKkXHK/7Qkv0cXG5Ya
	CrxE41/4Smd7FKs9VSwqf2frv7DU02vImUd8w/yHKAl7rtmqy++Jc9MmGG1Fy4pi
	fYLmGQOrFPqdnjf8jM+IvDhtCZ2bmTAhzHbGy2epyA==
X-ME-Sender: <xms:_ztoZnlh6T1-XD6kGSUeg6sM0QWcKS-NXFGLklO6WewgHcSP9datoA>
    <xme:_ztoZq1Scxsk5P7sBG22K8otdt78n-wo4-B96vpD6Kc9YbVHgH9qYXW37flK8lBXG
    qxKJYu6D2TOnR_jNA>
X-ME-Received: <xmr:_ztoZtr5PYFzYmW4L5peLTEpNrmQ2qUSzuzK-jXFvVBEQrfNTglMvX5T2R59YeJqPZJ5lQYJS8HLdYfl-JwAQmKCIo3z_zGEVw1jfnmIHp-f5EP9wc8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_ztoZvmpuFv-Opd8WykErcQv4OUxZJ7kYC6ZEilM-26havI3afCTxA>
    <xmx:_ztoZl3ZJdJd7XLUacpQxjcZ-xJXwELcIbhVSZGMd4yzBzHAUKKwcA>
    <xmx:_ztoZuu2CQS24WeHTvT3m26HTV_-SPlkegZsIifW9gNeznjcQ-efMQ>
    <xmx:_ztoZpWVu0_TsgZ1bTXZCUulZ021wvCTfkKLuaDHgPGc09tMlK9zDA>
    <xmx:_ztoZm-bs9ceN5LuA9rLp4IQQ9E0gKbAjvbyzsdgvP-GbAiTQu9cM1xw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5f1ed894 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 11 Jun 2024 11:58:45 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:58:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 17/21] t/helper: use correct object hash in partial-clone
 helper
Message-ID: <5310883469e3366a82dd22d4a552715d3bc580e7.1718106285.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GPRu3o6Jd7hMTIC/"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>


--GPRu3o6Jd7hMTIC/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `object_info()` function of the partial-clone helper is responsible
for checking the object ID of a repository other than `the_repository`.
We use `parse_oid_hex()` in this function though, which means that we
still depend on `the_repository->hash_algo`.

Fix this by using the object hash of the function-local repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-partial-clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
index 910a128614..0ead529167 100644
--- a/t/helper/test-partial-clone.c
+++ b/t/helper/test-partial-clone.c
@@ -21,7 +21,7 @@ static void object_info(const char *gitdir, const char *o=
id_hex)
=20
 	if (repo_init(&r, gitdir, NULL))
 		die("could not init repo");
-	if (parse_oid_hex(oid_hex, &oid, &p))
+	if (parse_oid_hex_algop(oid_hex, &oid, &p, r.hash_algo))
 		die("could not parse oid");
 	if (oid_object_info_extended(&r, &oid, &oi, 0))
 		die("could not obtain object info");
--=20
2.45.2.436.gcd77e87115.dirty


--GPRu3o6Jd7hMTIC/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoO/sACgkQVbJhu7ck
PpRcFA/+L/Zt3crF86880B/IUqSXDxhC8RolX7be3laUmfgcSZYcWO8Ancq/fPpH
HyN68WykkdAR3Oyy5RKog4CidkY6SwLYOJfQFd74NxF3R0NTr295OlV7H6LzvgDY
D9HOVKRVhfHNydE9/ZX82Coe3q9IvBSfaSso1LXkz3oPNs2GEznZwWFXKdI8vBjL
O1ZV784g6LCGE8uTp63iiNxevM0WVVl+Gmz4RzMMHo+ZKVzGQkJ0/SuCHr4xdOiI
ldSlcgBs5qTkDl8gcF7agGGmPJb7Bbz3j98SV9nZ3KSc0dIjof1lnsctvGcd5BFN
oW5rculxTXWzDLTCALUvLcSZpaDAQCn0vnO8Htw91IN5u+K0DNEmH9TeEq37rEzh
8LN2i8GnpARX8M1zNFnu3aRBb6hn5gEgJaEgZTsxEv09ASWqqQSmd9WBZiqOODKP
fAe3T2Pr+76XqRmt0hEGq3ncb+oUCA7GWyzs4TD8JWJ1FqBcw31cengNDEZx2iAH
oTDL4VnBL2NQCgkfms86CY6vG4URFXqWiQrtrqIqyJFalNCSl6icbSaiA7P0TUMn
uXXzINmErpvBNIExJNSjj9qI/v80t9+lj03WoNS3hY35zqSbjo9/ES2pKz8+XMS0
7AMR3CrlruJYJ8We8+gPupK68LyF10o755maaRcLB83R0qvvJ6A=
=1TfS
-----END PGP SIGNATURE-----

--GPRu3o6Jd7hMTIC/--
