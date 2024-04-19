Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C06B80020
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520313; cv=none; b=oqFyVfZiybfrd3N3lu1dGS8alfOTpX5pN3STXI0JAXd1h8dOIUkEmdSfExUgC7kXEw5ggVXp4q7tqwF25dARjijaxrDGnxJtQjxImfIYrUP864tY//AN7VF2KoWxICYMXOpqaRDcMygEfqBLaBhK6Ezi7/VerftTzXyAxwCSIbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520313; c=relaxed/simple;
	bh=5pWIr8ZAVZBb3u5AI/noPd7aL7JD1V4atl6Au/vVspI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1dauAHA/wjasWy9vVtSFwFaW+cj4Qt859copUb/VKED3bS4jNRPZOC5t+FwjQ0fwLIVnfTb8hGY9RoSopeJIm/P+iVtocv3DYP0k7cd2bVQbDboDDw1YeIOLlaZtcvmEOLLsI2B5ZDbKjTZvtXjlQiuXy5eGbQtEUNbkRn6j6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aGvKy020; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ALGcu+H0; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aGvKy020";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ALGcu+H0"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id ABD0A1800095
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 19 Apr 2024 05:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713520311; x=1713606711; bh=bHmmacWlTO
	bewMKDDGwrn3Qz46ifsBO7sBiNKa+/Fbk=; b=aGvKy0200WzsAtxWNfGxsgFmWS
	XRt1Tz8cIR7qdKMxGljiw+oIJNH8YtONTPp/tpiwGpHx3s8Ydgv9ZgihO+VwdGNi
	e+MOGPYjJVNrXcfP9qAOs5eFqYw01nwHomv2XbzFYDYskYPKdQy9DZJlKf0SzVtc
	l4ya6Bk0XC1ePYYPx5jl4EhTfGkmrFUWsTIA85sLCFzDvgvZB7FmYsuSvwRcHgWO
	ULpIJVWtpN4lw458aa5jlNXB0Cbr3Xke77PrVsG0nlG48tNx60ttyTiJ8Pv6Rluz
	WYrO2l2ApLUlE2xWfZZEAkHkBTyu50F88WMl7m8ap1O9OadBNgP8ToJTus1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713520311; x=1713606711; bh=bHmmacWlTObewMKDDGwrn3Qz46if
	sBO7sBiNKa+/Fbk=; b=ALGcu+H0FWiKk0CZwfFkVdYNsUbQ2YTplMJnqrmM3tyl
	uaS7vSFYCDL7OfJB1ILY2wKQOQB/7LsMjkb7k7lzlU0v3LZfDjDronGvju1RmQzb
	QsSFb38FCbi7x6uweMmg0KQMlZBx8E7RmIVTVxpo36sw0KX8fdcIT5OxrG/mLPK7
	T90t9WNQwVa7dZunhsMDhd6xbKvqzcEFG0qDsGD7csCtLVFLZuR/jBmIgSB9BCmq
	O96UBf3PjmhnV+VilSvn5/Ibeap6JK9L/2QBS9UyopILUrbCIBx2aLHH4XTqNtUs
	l61JBs6qIfvBaCu9BCJ+dpmInqVp/QhfoD691Gssdg==
X-ME-Sender: <xms:tz4iZiyncT89JiNr19wHUFDZtj1eGnLmR-oY0vEDP3d_Mt61Ld6iQw>
    <xme:tz4iZuTRG6xeHmKZ30Ig15TfMjFhJUw7OSa_xXi60ISlBE9-APmwU-vMQZEI7uWc9
    CaZu1V2ghzqOIaNqg>
X-ME-Received: <xmr:tz4iZkWO-3NPppW3z73ajXaHvOxzl3KmlmUG1Fwd16yDr2ld-Tbcgp1-ES0ykKc13zDstoLv-ldL6jzMi3ogCGa5yDU99KaOiOOBJ4TDmHkI0Jjkvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:tz4iZoj9bKYsCO5KlGRxS_EPcgehrAEpKvWvUD6_zOnVRSO2jNZNqg>
    <xmx:tz4iZkDn061CFv9b2lo0MxLWlmUg2mpqz1E3LQsigsbcl3BekY1W7g>
    <xmx:tz4iZpKS45Qbl_p9chWgsFrmQxLwo9tZHhbsF8ie83soHLDilOzOOg>
    <xmx:tz4iZrAlygdGw3rQVRWZRf4OexVQTstsGULHIsGOqk9V51TJOKTR0g>
    <xmx:tz4iZt4xg12Wq9OWtvR-Vr0GVVZLFJNNX6rUU1eT3w6ZMEoSRCBKf2CY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 718e3080 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Apr 2024 09:51:23 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:51:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/11] builtin/diff: explicitly set hash algo when there is
 no repo
Message-ID: <39e56dab621a2a1e0cbaf67f8de44614c354dcb1.1713519789.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="25UX+3zkS/88Yy/z"
Content-Disposition: inline
In-Reply-To: <cover.1713519789.git.ps@pks.im>


--25UX+3zkS/88Yy/z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-diff(1) command can be used outside repositories to diff two
files with each other. But even if there is no repository we will end up
hashing the files that we are diffing so that we can print the "index"
line:

```
diff --git a/a b/b
index 7898192..6178079 100644
--- a/a
+++ b/b
@@ -1 +1 @@
-a
+b
```

We implicitly use SHA1 to calculate the hash here, which is because
`the_repository` gets initialized with SHA1 during the startup routine.
We are about to stop doing this though such that `the_repository` only
ever has a hash function when it was properly initialized via a repo's
configuration.

To give full control to our users, we would ideally add a new switch to
git-diff(1) that allows them to specify the hash function when executed
outside of a repository. But for now, we only convert the code to make
this explicit such that we can stop setting the default hash algorithm
for `the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/diff.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/diff.c b/builtin/diff.c
index 6e196e0c7d..58ec7e5da2 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -465,6 +465,15 @@ int cmd_diff(int argc, const char **argv, const char *=
prefix)
 			no_index =3D DIFF_NO_INDEX_IMPLICIT;
 	}
=20
+	/*
+	 * When operating outside of a Git repository we need to have a hash
+	 * algorithm at hand so that we can generate the blob hashes. We
+	 * default to SHA1 here, but may eventually want to change this to be
+	 * configurable via a command line option.
+	 */
+	if (nongit)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	init_diff_ui_defaults();
 	git_config(git_diff_ui_config, NULL);
 	prefix =3D precompose_argv_prefix(argc, argv, prefix);
--=20
2.44.GIT


--25UX+3zkS/88Yy/z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYiPrMACgkQVbJhu7ck
PpT/JA/7BFl0zxXu5XHuBM2FWlSGb2XKYnJ0m7bY+MKmuWmKVHlb5Lo/rq+oxEar
pJrq6N9J/cBpK3V8ihjimlZH1c8yA14K8sPpjMqZ17WtrWjdj4xcdX7eFn6ArzUS
KtPlkbKK+Zgl5ziTSjqnNcz24LXdaMx7w+INujbaWqkjz6xLshiLt3fkI8xE2sTn
0UDC96RlHDPsLyN1dN01BhEms/qa/Bi3rE+VnXrxrhEhEKkWkyHlxquxom8DgWDO
ScAfUivxGVwXP5oqOFZvJnJjdvCN2qWOt88sH3V25D4AegeFYC98BSfcKTZQ87Gn
fRrAk28mYUhMWze7cql5OLznObzuiR4Fzy6kZ/+K0XQrkqR7FB7qBz/3tGQ58sbT
ZwfX7KPavIUVXywXu9c0kj6CWgCJR2zdc6RnTFtCaXL0e96UYjlM7bWZQnerMsWL
Yr5OjmhEhKJjOzlbNzOnZC5FdymLxPJ3m/rmS5Y6Lpn3ljcOiHdffCq2GoJq1TiB
RwgmzamtYiKEMw6Zh/tuflXhyQjHJlTu8xckl2K5WIS89B9XYcmPce5p2T+H40yX
LdYsxf1NLzvqWLXyRfplqE2Lm/wkPKb6DZbwmk6BfAAq+FCZxcg8RwNuFoaVP5Wf
UF/6NSykHaKbiVjGLtAqP8i/kohES26LWpusxDibeXXlVxOQFtc=
=gdyH
-----END PGP SIGNATURE-----

--25UX+3zkS/88Yy/z--
