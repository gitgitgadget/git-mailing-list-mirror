Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B783E49E
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057577; cv=none; b=Eel6j3FyYxN6UrCYLHPfaszQGP9S3YjpaMnGwzEsGkZV2IBASMQ4fFb+HKnIr8STkx+h4z5Gyof26wfRx98XaHCtOoekLJFEUvXg2lrWuaBM8ZUGHz5YlP3Q+lRJ4Cyv6iU+eiadcFCaVkJ4ya3S274unL5qbiQ9vaBlGcpv0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057577; c=relaxed/simple;
	bh=2iX0R8V+7SjkklOvd6v0WL1HoB7jCJFOJ/waVp1uvHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nl8ibxCGIY0GcvIrqHi6++HqgjZYbyitizA446cjXekm6oolvkwJLdaTN0JFRcR2CcXK46qJQxX4kN+UDFgTs/R+1xfwTNURwr35djV0vMc6By+AQZXO5mKfKN4MSmvcpKjO0jOjHL6vjUeJh7FkzkTk8H6UL7YV2pGULNN/5zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NuTBwNry; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DiktOUEC; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NuTBwNry";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DiktOUEC"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4AB1D11400BC;
	Tue,  7 May 2024 00:52:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 07 May 2024 00:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715057571; x=1715143971; bh=28rnY4ksjL
	r9Tipqbp3U4BLZo66prUjPCLYu1D45Bgg=; b=NuTBwNry++TshMjuM7qrwCvfZe
	y8DmTHm09kQakbnF5suGC2+Psnp1Ma3JHROh/OI+UIZBYu69J7DywJBpHE9NiYmd
	RLq8f/dPiY8eadM+CE8uOPHiC5sGl+Qr7TTmRjtpO5eTT108DeWZ8EQY429yaH4P
	lH8g9vqS7TJo1lsm9OPy54XZpiVaeojxF8RFvqCk9C0zqN4uBbi6RA2TpIPeCnkx
	/dnYRK4F+bBW3q1U1zcyLqr2CiaeND1LSDFQubKlD5tfz3U7vOplo3DWACZ32R4v
	IOzJZKaUVprJ3SuGMYx1/tc5NuZ0jKfdL5DFo3n/eWQbwQFqjAumwpo5IkNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715057571; x=1715143971; bh=28rnY4ksjLr9Tipqbp3U4BLZo66p
	rUjPCLYu1D45Bgg=; b=DiktOUECEoSH58Aci0SkpDtKLwkf/wUCdVCifRTDq7pk
	Xz6I6x5GgJhSlb3x6/djf4Sq7SMWPsZtPj17aeFljjf8DDymJP5DUFQXatYz/Lni
	a2SKVkmRfuHnU/+TlklsZVdEhkvpKGvRxRIsy+26kIaefh9PrRPrkjNQIT2M2sYO
	gN9pAWmXp0tzdnnWM3DPC5Oqq8lSIE7f1+Ty2iK2lRFuLLuGKPidi1GP3Ai8wgxk
	sgB6BZRqWrqYNpHLp+voS9zA1/jMHxpvmx2+5zR9g3VURhDfncTL9cDrFFc237rR
	vGG8oxUicAAohL1YF05FFGz42hC2cWbKaBVMR2RS9g==
X-ME-Sender: <xms:orM5ZuzhVJsj_HX3a0637RDHucT0uEn4cWRvhsvuXGpLJwFLVyhk0A>
    <xme:orM5ZqRVpJtrnslgozOsnFLNIzCS_3JtQeoh-pwpxR2m3X_b7U5CD6tsLoHeeZX0o
    zqh0jVb7d3X4lXa5g>
X-ME-Received: <xmr:orM5ZgUnegzAHP72iQS0ZWKjUszNYrcVx89jmUDURhP3-L4BpKb05IZYh8tYXq5LPwcre-vhG3fOBVQf137G3oFnIureBSg_yrMUora9uxr0oe852Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:orM5ZkiHkKKk1gijuk67ezw-PafdEFtR_dHE3qgFOhDYrO0SSyd8sw>
    <xmx:orM5ZgAOuHOqIcOxBR3Hj7SkC6cG2tDPXRgow0Am3SvWjI8xjLHxLQ>
    <xmx:orM5ZlKS2ArbqXO1oUwRtIIBLGChtsGO32NmFD1bwul0OV6JXgPxVw>
    <xmx:orM5ZnCK4aOqpFxqdswvEHc56zNZstrB2RSFeFKtwMH_lyGBggtMtA>
    <xmx:o7M5Zj_3Lxxq43HHJ7n-BFVN30MohZq_5lImzCjQaCNNKTv5o2kuZv4o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:52:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 63435f76 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:52:42 +0000 (UTC)
Date: Tue, 7 May 2024 06:52:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 01/13] path: harden validation of HEAD with non-standard
 hashes
Message-ID: <5ee372c2d8f98b8cd8c0b51bda15ad5449339776.1715057362.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1715057362.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WXfMVAWd4tjGgC5Z"
Content-Disposition: inline
In-Reply-To: <cover.1715057362.git.ps@pks.im>


--WXfMVAWd4tjGgC5Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `validate_headref()` function takes a path to a supposed "HEAD" file
and checks whether its format is something that we understand. It is
used as part of our repository discovery to check whether a specific
directory is a Git directory or not.

Part of the validation is a check for a detached HEAD that contains a
plain object ID. To do this validation we use `get_oid_hex()`, which
relies on `the_hash_algo`. At this point in time the hash algo cannot
yet be initialized though because we didn't yet read the Git config.
Consequently, it will always be the SHA1 hash algorithm.

In practice this works alright because `get_oid_hex()` only ends up
checking whether the prefix of the buffer is a valid object ID. And
because SHA1 is shorter than SHA256, the function will successfully
parse SHA256 object IDs, as well.

It is somewhat fragile though and not really the intent to only check
for SHA1. With this in mind, harden the code to use `get_oid_hex_any()`
to check whether the "HEAD" file parses as any known hash.

One might be hard pressed to tighten the check even further and fully
validate the file contents, not only the prefix. In practice though that
wouldn't make a lot of sense as it could be that the repository uses a
hash function that produces longer hashes than SHA256, but which the
current version of Git doesn't understand yet. We'd still want to detect
the repository as proper Git repository in that case, and we will fail
eventually with a proper error message that the hash isn't understood
when trying to set up the repository format.

It follows that we could just leave the current code intact, as in
practice the code change doesn't have any user visible impact. But it
also prepares us for `the_hash_algo` being unset when there is no
repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.c b/path.c
index 67229edb9c..cc02165530 100644
--- a/path.c
+++ b/path.c
@@ -692,9 +692,9 @@ int validate_headref(const char *path)
=20
 	/*
 	 * Is this a detached HEAD?
 	 */
-	if (!get_oid_hex(buffer, &oid))
+	if (get_oid_hex_any(buffer, &oid) !=3D GIT_HASH_UNKNOWN)
 		return 0;
=20
 	return -1;
 }
--=20
2.45.0


--WXfMVAWd4tjGgC5Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5s54ACgkQVbJhu7ck
PpTYZQ//XU2zjEX7WqNDkFDsoBRqEPesBiTtehfVjPQ6M37gzw+qTYe1q9468MyF
83GctLDSsSTE0L7Ox7dY2p4TXj+I2WXK0Zscj4CVhzlh7VfSQd9FswsqgLUbCe1f
G21dO34zgrUKyKv1GVQiSUvVxylf4dd+8YNPcgaLYpdl6T9vqgkgmMFI85E2u7mA
u+0CcS/jwscAAVg3JYuQOG/GAd34DFZNbYgx/wvq4KNco2TIhXaCCTQeeyvV75wk
URcYTjDuTl7b2suC73KavDwBZxHLeA325NlbLKw2nJjZc5vjvtcohBTyuYQ2v/Xh
u4D/HOMwNsNhtIGVvR+QjUs20N1+Oy6VWXPOs2egSoeLYOFjaffAiFOyhSPE+3bP
xG9s2VeWhad2u6XaOLMKUGTTtazW0AfolJvRodfxkDeQqHgU3LRtFKa5jETzp7cm
0profeuiNVMta/oonKwpcnf6NtT9QYnugLSUxhJJ4KS+fMUk4bdOHz1DEJchJYGl
WrZsfnlXlLQR30hqbd37SmCSYZ0iBmDLckl5X1QmkCjMW9V8+8BPm7JYZbVPvayC
99zP3RYYbZtw5GqA4LI8ODO7lH+CVn9MedaflPIM3n3Rw+hFbXpmg4f27Wq/9e5v
VZLJ02yxe7yxtCouM9so9cIYtlh628sBlIKdrocnrjAiVm/+5Jw=
=WSCf
-----END PGP SIGNATURE-----

--WXfMVAWd4tjGgC5Z--
