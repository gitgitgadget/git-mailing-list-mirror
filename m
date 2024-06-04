Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839C5146595
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504739; cv=none; b=bSlytWMyoZ2hh8ETfJVqMqmZ4xJvCSdVHKnjjcBXip25yGKyBRzGZmmAHPSHkQw7eN7yttWGdiBXi0DjvGbA0k4x6znkPdk5yiczAH/3OIFGKyBBqazi3vR/CdJNJE3IjMkY8yztkCqIvOyVESct2V00iBrmCkcRcaKGMu/77Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504739; c=relaxed/simple;
	bh=4q++8O9Izb2yKhic5iPhuKaVeQPIlSS15dDCQDIvDrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAbrBqRB9GQ6lMQV+8Lq9YnfR5RP8B7dbaNzF3W+LZJuqhVT9AQZX7CdpA/EdyTDlqqelGSRXjj02jql6sj61s/9RqfExGtDQupAL61TesUKXH4jVmXBnsJW1vdYXynm0X5TsTPxuYOirwaYkOrX8YY2LflBccWr5HQV7IJqjqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hvnw7Zoj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hVid+tws; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hvnw7Zoj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hVid+tws"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CB0991140163;
	Tue,  4 Jun 2024 08:38:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 04 Jun 2024 08:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504737; x=1717591137; bh=9zcVGzTSAx
	9hVuWMdZdKZpIJaKpvP5Oj3c8IHSP8eYQ=; b=hvnw7Zojhc3HFiIdxhocbcp4oM
	7eOZ6QPS25/P88j9ER5HeJli+3AQPbFYacFh9K4sYSsaE/74aEeawoD3jRkH5xfa
	sCz0WF106HVIfLkD9lojXvXJm0SXqGwH/a7IQMgleyoYAPy9hpJSUgG4CMo3CAEF
	4CBxz1Rrp105CbS6a3NHC3u0BtbAqG2bO/PP/o1MQttZ48IA7mH5L0+N3TJmfG6v
	E8rPlcBqDkMDZ0m02Bxj6B3W4dEFflqaUCFapfwjIH2VlCT+ry7M8AIsa6k7G/Pd
	zZ5hv5tun1reN+meVkwoHXbC+fYHz7zt6qBgunTqpjI2DEQi3NJuWSi5607A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504737; x=1717591137; bh=9zcVGzTSAx9hVuWMdZdKZpIJaKpv
	P5Oj3c8IHSP8eYQ=; b=hVid+twsVytJzvh7uODsSxzf0h6GYDVDJA0acRPJVyt/
	klA1j+/1KVho80fS2EcCDDX4J4tWrf3OCXTaxhuSi6rdZ2a/HnwGEcSXupQV3457
	El7IWFdwllS0DqZdCTkpaU2SHqBaYEnXT8yZ+TZvpp6Duksa1u97O82pqb+amkS6
	oiCNMfZNNlVr8d0BC75hMbmCyjLeQFtgM2xo6ZePDq9NjkwV+5BQqZs+6yy9u4lH
	enkkrRsW4S8cchTqUAVxInpOqwIcCX5qJ7JJ/fjlMjZ/g1VXKU88fBa8vphEvXUV
	UHx9t2p5v0Gnw4+HPrfDkLMySJHvLJUf2jzefvIQsg==
X-ME-Sender: <xms:4QpfZs2ZhfHeobcbdMmBbehWQuVLKG1du1hlsx8ekcuRdKKovH_2YQ>
    <xme:4QpfZnHGArVceVcNIRK46cZCHGNwBSI_9zo2aetylg-kYRrdJV5Gd8JonknB99YtU
    JWY7NteabB44oE86Q>
X-ME-Received: <xmr:4QpfZk5cBHYf84spvbh581M2XltVaNeQ1kOeGir1QjeegKgfgUBb7X7jqYsjsRu6klwOayxvafi6-4_jyLM1Zh0nfeFTQNbtxTZwsrqwa-rNfPkh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepgfefvdefffefvdfffeduiedutdetgefgudeiuedvfeeitdejueefueeileeukeef
    necuffhomhgrihhnpehsthhrrghtvghghigpohhpthhsrdhnrhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:4QpfZl3NlCs-yUaUJCr6-e7JNyW6h1l1I03aWOoisuI4ljDocqVJPQ>
    <xmx:4QpfZvHC3HLw6yqcQa-s_9mA0o6AYHLhKj7aS0T-6USVlExypNtAqA>
    <xmx:4QpfZu8iNnRgqk4G0dhwL3zobeR_m8Eu4oxn1QOpW5RbkzTZPHOfEA>
    <xmx:4QpfZkkrYQfBPenbato4xLuRgr9i8otCVBveJXSlwoFz_lvCMPwE9A>
    <xmx:4QpfZjh65zoZnilgP3QPFRql7bAVmmeSjVNwF1bLGaAIndRo1OqVf-Ps>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:38:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1afaf989 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:38:30 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:38:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 25/27] builtin/rebase: always store allocated string in
 `options.strategy`
Message-ID: <f548241960d1f41e010516d68df9107528567514.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0CkCx/W0MPBak3Zl"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--0CkCx/W0MPBak3Zl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `struct rebase_options::strategy` field is a `char *`, but we do end
up assigning string constants to it in two cases:

  - When being passed a `--strategy=3D` option via the command line.

  - When being passed a strategy option via `--strategy-option=3D`, but
    not a strategy.

This will cause warnings once we enable `-Wwrite-strings`.

Ideally, we'd just convert the field to be a `const char *`. But we also
assign to this field via the GIT_TEST_MERGE_ALGORITHM envvar, which we
have to strdup(3P) into it.

Instead, refactor the code to make sure that we only ever assign
allocated strings to this field.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rebase.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 11f276012c..26068cf542 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1063,6 +1063,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 {
 	struct rebase_options options;
 	const char *branch_name;
+	const char *strategy_opt =3D NULL;
 	int ret, flags, total_argc, in_progress =3D 0;
 	int keep_base =3D 0;
 	int ok_to_skip_pre_rebase =3D 0;
@@ -1177,7 +1178,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 			PARSE_OPT_OPTARG, parse_opt_rebase_merges),
 		OPT_BOOL(0, "fork-point", &options.fork_point,
 			 N_("use 'merge-base --fork-point' to refine upstream")),
-		OPT_STRING('s', "strategy", &options.strategy,
+		OPT_STRING('s', "strategy", &strategy_opt,
 			   N_("strategy"), N_("use the given merge strategy")),
 		OPT_STRING_LIST('X', "strategy-option", &options.strategy_opts,
 				N_("option"),
@@ -1488,13 +1489,12 @@ int cmd_rebase(int argc, const char **argv, const c=
har *prefix)
 		}
 	}
=20
-	if (options.strategy_opts.nr && !options.strategy)
-		options.strategy =3D "ort";
-
-	if (options.strategy) {
-		options.strategy =3D xstrdup(options.strategy);
+	if (strategy_opt)
+		options.strategy =3D xstrdup(strategy_opt);
+	else if (options.strategy_opts.nr && !options.strategy)
+		options.strategy =3D xstrdup("ort");
+	if (options.strategy)
 		imply_merge(&options, "--strategy");
-	}
=20
 	if (options.root && !options.onto_name)
 		imply_merge(&options, "--root without --onto");
--=20
2.45.1.410.g58bac47f8e.dirty


--0CkCx/W0MPBak3Zl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCt0ACgkQVbJhu7ck
PpSmWg//RJ7AwA/ho2sVX/QQ9VALbmYuAt/EAA6qhB0afeXX66R4YzqC3HhWB52U
/TjD1yYVCxyeyxzLUpLcUXjnEaqbfRXoCan0KqEoL8lMNcwdqLe6eNmBqtyogw5F
Ac0df3BZD1+mdgQTfh3CJjG/VJ5+pPCzC0xXgn+du09TX62XxmbzHK67U6RsJ0fI
v4tfpbX56MPhX53KVmuv1qYixE28XI5Efy84QeGSKppKrfBs6BKmpp3dklFpIybB
n17Ny3cUayMUViR0MAhFgztwk7XjvS/F0j1CGcr7p8bmaZUAmOvCrlUFwocyOYWX
DWua8/8xnB0w/+7lyrlegJAvfs20uNSUs82Ov9paKDGufNJfI0eGW1VvyuialR/A
57IRvnL3+kDsyQ850VnKdqSjc+T2qhcVmb4RFFD/q7fPHTQLnoOJvq0q32vflexg
Fg+x/eKHxwSyCNrlkQo89gq6gJmMeegcs/1SMpAxG9UpFOKivhlq1Pfk68NMD+MH
+343Qs7EXDbEHaDTj08xZxVOgHDUVunP3sHTS4WPKU29k+nTE8JKKJ1r8/h04vPM
tDBCBMB+vCsxBkW4z5xuBK5bqpPB/vzKGm+ObMu1olKQELTJFmDlv3RF/ObaA2lI
WEssDjYSL9tjpJiC99Dqn66ZMiPpwA9rjf5oMWRxOCzsTBLW3+s=
=jgAl
-----END PGP SIGNATURE-----

--0CkCx/W0MPBak3Zl--
