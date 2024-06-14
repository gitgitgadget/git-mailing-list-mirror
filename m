Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D6C1482FC
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347866; cv=none; b=sueJ9X9urofNMhC0wtCW6ypLC541kFNdFgGuqeOw2f3dFhbrPxSK/inswg7kDbe16boY5CSz/qXN7Zxxbh+5GUJCnhq8JRIHRRUw8vVfVkt5uKRfFhuTZyFMGbkr6rAYA9LTXttllKiok6hluXz2Yd+ltbI9WTafIegawj8Ckds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347866; c=relaxed/simple;
	bh=08/sbMEW31pfjlOcktoBMb0CkR5MSumCbpzjMi2rkvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezYP3oIcQp037lHkW1YDVlR4/lAjYKL0cyBf2Jj/oYlltqioNtiARVSsHhlUrScxlMhvsgJM3rKzCHhhP+DQPZD+R7MrI/oGWxVvG4ly8ZQHY3zqxTemvTV/CQ9VXK0n5XSXiNc1ADvAfSmFbJgFC2xxlcSMuD4BaHW/hVfiN9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dHxE9GQa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fWhRH7W2; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dHxE9GQa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fWhRH7W2"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7778C13803F0;
	Fri, 14 Jun 2024 02:51:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 14 Jun 2024 02:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347864; x=1718434264; bh=l1+EftfLK4
	nrra8cSlhhcYZN7oM9WYzDwBcw19uecBI=; b=dHxE9GQalfThNpFNgLykxquiVd
	cjDu8F9/wq7m1BaPTVDhXdy53awnBL+bjHbn5kdE9jWmXkVXihZcNLWs1Y5C7BPH
	UGeKuzvqtj6ERJeFT/JIgN9xuUpDMJhKTMeHaeh7Cb1JHpac27L3drDUtHdNB0nV
	A4zeFEQLIYIxhaopys4dX/f/kXksTfWET4dTcFew9iCQvVn22owbHg7O9pkIN72a
	woI5vFmFElvIVrN987phD6YPsCaFJ3wse2YkgOJZdNbm67kxAumpIl/4mjTdcEKX
	HH/oTzUKXw/olRV23CWJmbxqKTb1P9gjv/CQDlgbzldkgwJ5OEKJ6Au9RHBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347864; x=1718434264; bh=l1+EftfLK4nrra8cSlhhcYZN7oM9
	WYzDwBcw19uecBI=; b=fWhRH7W2PdRNqbv2qqPpkV+K8oVkqHJw2zIJFuzTIMTc
	NQ/s6Y4D4X1R0dMMyq9IeGhiT+aadpHrMHdnY+mzsI9PCJYBjWqde/YanJNpU+e8
	9VqjOUUpvC4N0rouibo2oBcxARdNTHLuhQeBPLu/Re8gglRcZfm2cZ/AWcH7+ok1
	fqwvNCQD89QL0ksiUKuEKjILw20ZWD3fL9sJr9c8EUmjCYIIBqe6jdeiCvaj2fs3
	GuoVqsXgJFUBFWXDy88hPlYmFd5t8cAp9YqJGaj9+V5nA7PohojIX2sv91ZB5IqR
	9nfFdoT2nACSzVN8cVr1NJSjWmjNFMLxj3595BH+wg==
X-ME-Sender: <xms:WOhrZoB0KzEyS0cuXkUAQZV2isH0r8rHWg422trEXvRLCZXukhcU4w>
    <xme:WOhrZqi2IajmasMpQXqMJmwvre0Y-UvbHjnrRwhpaOZXB8GP-07cWIswDs35t2xq4
    o2mvtSBW95AzM7yYA>
X-ME-Received: <xmr:WOhrZrkNturUHnaZbrEIlZmlT8Op4SAzrpJ4ATl-qwxkDN5FU1dALl3Ppar6PDfDMp4WYrMLgaW1_mK04ylkrXYmAoRnf1AZXDBIJjDu5OJyzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:WOhrZux5R9ll6WEyremE_AtSdhwrdunnw4wNy4tQgWzZOgrh45wGMw>
    <xmx:WOhrZtS1zATwkwjAE4LWkt3QGtOidJPdJf4JJMS3PWMo5pWAjP5DGQ>
    <xmx:WOhrZpZ_3O5gs2vb1nrocJEx0sVqh15ZwuqpClh5oMEfL0FzGzgSMQ>
    <xmx:WOhrZmSoaPPFheE40tx0LmZfeT_yETUQIF5D-lv6k1AsXBqHIXJWLQ>
    <xmx:WOhrZmKH9e5v-AD-ZAAWuaMcRDnFFlywPsI9QZttQPYN7goolnaaZfoO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:51:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0796c796 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:50:48 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:51:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 17/20] t/helper: use correct object hash in partial-clone
 helper
Message-ID: <ad83b17ad0d01beec98ee76bf36857d416ea6e21.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cD7VQ2ZLtmSCZdTF"
Content-Disposition: inline
In-Reply-To: <cover.1718347699.git.ps@pks.im>


--cD7VQ2ZLtmSCZdTF
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
2.45.2.457.g8d94cfb545.dirty


--cD7VQ2ZLtmSCZdTF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr6FQACgkQVbJhu7ck
PpSGQg/+Md6NxIAxfsFtjZxvo43asfW16bhY4BBgJWj4oOUt8DrEl7srk7rDSFke
bWSRu7oh+HbfwdUGYGFzHA8hnk9s7wyEqPcubkiCodPzLnfm5l/KgTWVlUrqcXSJ
jNtK3c2J6eN9uilzFmy6UWcB7+VOToj0KMxvCGbju6r0GiOp1W77L1pBaKLljX09
0bvAGNcTFzwoo9E56IdBzjailKnyrBVGBTmHPMlzjPb3hm34vUh5bP+CMFLvIesY
DhVJ8Q5SQMBToxFyZqaIK/rt7WfrOSVl8/TmiU8x/rZDRtZJa1VPk5srEM1osKzy
1w1iaHAAvaEwmfuhy1p0O1dAj7Gw4Wl4DZz0f+VGCMICivfE3uQmqWgVWWxedsrP
7M+8Bmb1ocb0xLNpXtEoM2hMzz+0dG9wYQWVvHMXPjkyVmZYGSH+sK3upLWGgkBq
9w2A4oWhWLYkxtz1nLB3GSd3oT0q+5Vl496vHdorZt0hQfwQxovD9U+gytf2yRi1
P1CInhSaqHJq8Dg8fYuJFfth4mvTR1X2eYZQrgfjW8dzplMn72fCVBov+DRGzSM4
zMIMsthak94KG8vVmcjd0wqgQ9VdkuZA64KbX4+sOy+ZOQoFwIcJhWzC9QFQ+Kpl
xVhHJeHp5N6JoxSQN4o8Yv0RMqkddXLJXGEzSlidZPSORuSZ/uI=
=Qdpf
-----END PGP SIGNATURE-----

--cD7VQ2ZLtmSCZdTF--
