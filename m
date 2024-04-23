Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE001200C7
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 05:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848902; cv=none; b=CT42n5TCEEr7Ko4jysmYtOOXhCgYM7fjMheKp2lC4KsyrA+mU105bK0uZgVEjrTx0XUT486t6YR96Sik7fdCO0mavUWv4tp6aiJcOQTbUMxn3RaZ8gm5BC7NI8nMSdoHVeQgSLUlsVmF7iMUkRkpF7kvqsNlbJuquDtkdgYW0VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848902; c=relaxed/simple;
	bh=F10c1hZSNcdvG2NM7sfuQxD29spwvx5z6HbxagdqOSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EL7HoLEXkAv1BIGmNOGCQdi3+gPAMhQULoNAyWQlSAprnfY7pXnu7O16GqMpWNOD3eFWtr34tbwL9uSIZ20GWMN1kF1zHfv5Dv8cW19a8GNpLZfLvpfYOWrj/CWZkCmh7kabH/DKorai4JMNuqIRFwA+3M4Do0/wu2dyt9nH1ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rwN7LOaX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LLTVx9aM; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rwN7LOaX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LLTVx9aM"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0E62B114017D;
	Tue, 23 Apr 2024 01:08:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 23 Apr 2024 01:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713848900; x=1713935300; bh=ZOyGw/y0N1
	7fnEeFwIGyUar8sVv57Tqsl8yY7lgEt8c=; b=rwN7LOaXgz9Vw4quJDHrrMdbSL
	jBxIljMGLb80rW7ghvmqW3SiQJKNN165bZDinGOD4CWpsu56Dz3oMdnD1B4JB+o6
	3t+/cGDAuvFS4LX3gbdTbV0BYr7dg8ykztFJUSc8/SHSsji/1dSLRDgQiyK539oT
	J0K98iIgf6CxzGJ5mByPysMyDRqvLwPJMtK9KTXEVhDn2J36bhR7OHqDqUT8T8Nx
	6TJOmVIRMPISKeoaPM75tw5m6zzoNKLjtAPGVouKG/ZuqxPcfSyGFOc2PSJ+csEX
	waEMhzHMmgOqK102KC1d36jrWsVRIc8U9IqLMkFRXWD8cnIU+0M17dc+60ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713848900; x=1713935300; bh=ZOyGw/y0N17fnEeFwIGyUar8sVv5
	7Tqsl8yY7lgEt8c=; b=LLTVx9aMMvEmYa6cBjN6kYbcWWkMdu3kCg4ZrqrqrwWG
	rvD2ITIMsA4iNzEoTCYlyBy+MqVv2kWi1TeHouJTy7z7RrERla8gi5ldQ3FM7u13
	70jgcVUQohqhcOXGi97LCxJc5whHmxy4i7f6TwPGBUFnDPROleozacMTsg78AL0n
	4H6PIGgSp/kqvmbyurHC9oOa//Jru0mCp1D95GxD0gKYjSCJvV1Q3hDfY4ysVmaF
	9p2oQx51tSrpSMZeVTmt4tXLQtKC3QH1ElQjBpUKMdUA6h/8u2ZZqBkd5hbZtVTZ
	BoIh0jTIl84wTEp1tg5smfd0oyHES1p400yqvRycjw==
X-ME-Sender: <xms:Q0InZixXxuuzyCGCKHNJv2IjtIpoQ1nxBabu0GylAO31YU4csm9v4w>
    <xme:Q0InZuTBSmK-PZ9vC2UK1DVJjmaVUMY_NHAUdNdPkMah35h6LAxoT8LCs1BU3blWI
    oYmQF0tNqApLNyUXg>
X-ME-Received: <xmr:Q0InZkW-l3GGCIjErnM6KYdNWpEC9ARxJsOMmitxgAvZX3v2wj6_hRh5aHtDuiPGQpVqzfKMVu7H3VpUX85_VAoIIUbAh0PrBS2NbYlj7yph_aMJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Q0InZohtDTUuZ7eds9k-Ex6wHHM0xKhS8t4rw_gOT830AYyCXdb7ow>
    <xmx:Q0InZkCXw8xNnnVhNzRvKZxxj4vYCeV8-MhHKPVvK47vEOYq3M0mOQ>
    <xmx:Q0InZpKCEVkq7zxvOqTzr5gHYrfxuX0pga-Y2GKhRUr6P_jORd1IlA>
    <xmx:Q0InZrBV-RS9IEWQpL0k33i0jLNpPBH0lPTTDigiKFt9ZyUn54LajQ>
    <xmx:REInZn_qvZfdqDttXvIj3KRuBht0TVmdSdx5od9dUUMfzyaJZagd6p4x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 01:08:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 86b9790f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Apr 2024 05:08:12 +0000 (UTC)
Date: Tue, 23 Apr 2024 07:08:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 11/12] builtin/shortlog: don't set up revisions without
 repo
Message-ID: <51bcddbc3154addac208ba15866ff70becf90480.1713848619.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1713848619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nto0l2WfWH8Q//Fw"
Content-Disposition: inline
In-Reply-To: <cover.1713848619.git.ps@pks.im>


--nto0l2WfWH8Q//Fw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It is possible to run git-shortlog(1) outside of a repository by passing
it output from git-log(1) via standard input. Obviously, as there is no
repository in that context, it is thus unsupported to pass any revisions
as arguments.

Regardless of that we still end up calling `setup_revisions()`. While
that works alright, it is somewhat strange. Furthermore, this is about
to cause problems when we unset the default object hash.

Refactor the code to only call `setup_revisions()` when we have a
repository. This is safe to do as we already verify that there are no
arguments when running outside of a repository anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/shortlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 3c7cd2d6ef..d4daf31e22 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -435,7 +435,7 @@ int cmd_shortlog(int argc, const char **argv, const cha=
r *prefix)
 		usage_with_options(shortlog_usage, options);
 	}
=20
-	if (setup_revisions(argc, argv, &rev, NULL) !=3D 1) {
+	if (!nongit && setup_revisions(argc, argv, &rev, NULL) !=3D 1) {
 		error(_("unrecognized argument: %s"), argv[1]);
 		usage_with_options(shortlog_usage, options);
 	}
--=20
2.45.0-rc0


--nto0l2WfWH8Q//Fw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYnQj8ACgkQVbJhu7ck
PpS+pxAAmEt519LetkhjR827nEW1nWAOWpyu9dkEQa/ttvroZAku3uIXbzcVAvF1
ih4e2y69V65urOsEFadyBG6U5xin3tvHb0ES5Peo116+Z4zLJEjuavSd/nKBovXy
v8/sb5go8dKqquI1/5PQ/lBdkbFyUK9OI/YXrr6vptlKts2q/IFwZ0WdbtomaKgV
JZAW2D/6XAqQLuh0wc000tcUruYuswSmbAscnExFZ5NTTobIFWGg2QoRKyVpIMfs
mAbSUkfB1yoJyZNa3szfkiooHZF5UXcOHZGvGJyBIYKFDkhzULZv+x4qO39JuDEG
SFQ8VhMQ5GHKzdxT1ul752tiPi6DWx7jjn47D1Vzf41F314ODM6Eh1Z7/9VhmSzO
GRBcaL1W8bTDH+NjqEefuYkvGMfGnhRfnO9IaW52DIeIng+hq4tSs60hWp8h7u0K
T3rz61M4a8XFKd3Le5Jm/l7olZQIUx3ceZSXIgF741okKZ2oOAN6Dkz2JUWn3toO
ZGkTieynxSPzEu4OiSvAIv4mrJdZvwr2fPSaB1ke8oAehqnlSdv6Tes6VAKT+O0a
tMc5D0ytxVqQlFhAv3hSjVS6QmtCN2+Ax4a0fflP50HXylAncM8oA+/5BVuQJXTo
oXkI1a/a0R/SdLQgaPv0842xtr2jUElgzgnGjWzcbV3UcfLD5/Q=
=kSia
-----END PGP SIGNATURE-----

--nto0l2WfWH8Q//Fw--
