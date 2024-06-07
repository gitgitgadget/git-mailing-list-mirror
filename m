Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D2414F9DB
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742377; cv=none; b=QypENuB6VF0QIgIFqBZznMRMtLhwAMatJd06+9b6MgzDdMesP0D/ap8O9dvsbbKPCzvxQCSslvB3+NhMxdG3fhxlzq93PXqhsK45aBjFFOksptBvAWP0byboQDUC5VOD04K95pNjYa+K0+kY/ot+DzflRr/a9Kkt1A0TUngEXNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742377; c=relaxed/simple;
	bh=9tkiO4rBJMEISFIduSj2ShVCHis4o2Q2IPNCg8w8CJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1ydXYT0wt4C9E1RZv2EvlvfuLejo4wmceGEgOB8s4ZfPVkHVsFxOey2MZI2zdN07qZvX+O+mRwNc+o/SDPG3019ybqHUv5Pe+RPQGEWXcU+IzONW1fJgoL05hP5xTrXSfT19g+PpH0cZ0J4l7imizkIqTLt3RPRmqNsrPuYI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=doC/9/+K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c9CKETpt; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="doC/9/+K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c9CKETpt"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id E68C513801DF;
	Fri,  7 Jun 2024 02:39:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 07 Jun 2024 02:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742374; x=1717828774; bh=N7WdQXhGAx
	X2bSk7YK9SXSl1MpO3Ji7RRTqVQwLtXrg=; b=doC/9/+KnN+vkvcpqIJj9OyWC1
	EkaT4rUgGvK3+r0QjsDvlJVjJKhIZnjb9+MMQLA0dycMEER40TUguK9U1028D0WG
	wldUzeOO3Jp812k9r27ppGOD0ZY/tI4V/q/EZqSUwx0VPJAFe0NjKROWWyllAWv2
	W2xUHya8OCZJ1szSRsNiXLBLIuCf+9HNyRV/qlr0SYb7mYgZzOiAxiEVd9I6Qzph
	BW9cLlpzGPD7kSLpPt2xgXXoVuq93CDiPxl9ViYOcmgIge3odq/lPvG3FTmn60jN
	bpHLXeKvxmlSVHSQGhn98QxRsG69sn/pUaBWlArSN82qGMxaa6gri1eiDk4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742374; x=1717828774; bh=N7WdQXhGAxX2bSk7YK9SXSl1MpO3
	Ji7RRTqVQwLtXrg=; b=c9CKETpt47BSj5Aoxf3ZS4Mjl2hf/8ICeg6bKmFxoZhB
	qbKj+ibd8d0hkOhettyTIQsyOnuNbZBQhnyOucZFayOBnn0DUMePwKqBXXpq04dg
	+0DACF68LIb8Oyxt5lOWu8iIkr7PhbUr7wG3qsAO23m3JEHW/Dr8EoUEkA1nVqe2
	u08mEoSgcqHA165gh/URA8wZqtDU4jwPQS1VbDT49Q40ZHwCtCiv1NP/aYvtJfgc
	Y2u0p9PGSwbYABmPVPT1h8+f+kwc3ucI2eeY9gNlqmCOfDUBXrC7YpEFnSR4QcFW
	px9aAeI7vJtGLBDHaxIM6Gfnwb8CY7GNdOUlUjgTgg==
X-ME-Sender: <xms:JqtiZhzIKSHZH03gGoC9v3O--hzRJhKt4ygbXoLTvRslr9tVog5Q5A>
    <xme:JqtiZhR4WbIbtWDCJCJu_Tbm6SS3XT_600zPVriDuW0ZqAPvmjZwfIQxNqywK3vU3
    7ruju3SU30efgEkdQ>
X-ME-Received: <xmr:JqtiZrVwylNxYhsz8KyeGuDmoTfjD7VAC43XJK5PGAenv1Ubt1Zm1Xl0fEVHcb2DO_pk4HPgOZYwUsGtSmaOURixAu9bmYiWxE_vr6IOr-ewTmw1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpefgfedvfefffedvffefudeiuddtteeggfduieeuvdefiedtjeeufeeuieelueek
    feenucffohhmrghinhepshhtrhgrthgvghihpghophhtshdrnhhrnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:JqtiZjgHNLBUGOuLG6CSo3EOqq2EwLhiXIyZC3S95BfEjxTq3KsbkA>
    <xmx:JqtiZjAnhzhnB8WHiDk1smIO4fzlyIVfjqxkp3mgzg2oqj9PcBJM6A>
    <xmx:JqtiZsJr57-7rFKh1E_WpToc41DiLpieZ8SxVLoOywq5wo4vCTpaSw>
    <xmx:JqtiZiC_zqVQdxSFLwpJUShf-Sa0_Sl22K9KW_2YkaDHqFOY5OGC0g>
    <xmx:JqtiZu8R7ZwEffCPSuzfZJeP8G6NG-_3gw7qIfwWkpVopHMGdoVWGE5g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:39:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6fda86ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:39:32 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:39:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 25/27] builtin/rebase: always store allocated string in
 `options.strategy`
Message-ID: <09980d211b125d05f15567d7f7348a064f14ce91.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="efITXa2XP+bnX21X"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--efITXa2XP+bnX21X
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
index adc990b55e..4506bae768 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1061,6 +1061,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 {
 	struct rebase_options options =3D REBASE_OPTIONS_INIT;
 	const char *branch_name;
+	const char *strategy_opt =3D NULL;
 	int ret, flags, total_argc, in_progress =3D 0;
 	int keep_base =3D 0;
 	int ok_to_skip_pre_rebase =3D 0;
@@ -1175,7 +1176,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 			PARSE_OPT_OPTARG, parse_opt_rebase_merges),
 		OPT_BOOL(0, "fork-point", &options.fork_point,
 			 N_("use 'merge-base --fork-point' to refine upstream")),
-		OPT_STRING('s', "strategy", &options.strategy,
+		OPT_STRING('s', "strategy", &strategy_opt,
 			   N_("strategy"), N_("use the given merge strategy")),
 		OPT_STRING_LIST('X', "strategy-option", &options.strategy_opts,
 				N_("option"),
@@ -1484,13 +1485,12 @@ int cmd_rebase(int argc, const char **argv, const c=
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
2.45.2.436.gcd77e87115.dirty


--efITXa2XP+bnX21X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqyIACgkQVbJhu7ck
PpSWlBAApbw8d0upymK2A0yMMYmNR5UyJ37IwqYTTmfnttbHlGGZLTgivf46XEkR
iEPkPe70gJffdKa8oRljqHP5Qi2f4GuRDO0CNeVeOSHE1SdxM8eIII3Z/zxxvbUE
8XptdyUw/ljoSVJWtStr+1gX/We03xCneBFmdb76YcazcadPg+TrotsXKJ3/21gj
FCyc1vNkKBz+p4V2PHZJ2b3Fz72oKF889mYiCpUuMOabHmj9OtONSOun7I5BWa00
FisW4gFCKy0oy0z9L/f3SL1mvEZAAn7VRy0Sx6wsgmeJyiV7HMoMR/izu1OxLuTp
d4n0u+Z+AceUq5TadZBCW7fGTxHSmIpn/+L0fZiIRSDOVoVYe2X/VgX82agyxG82
EbPrxTlOUEbvv1c2KuV6Xch5+nkSfuuycWX31mEC4EsFsx1lv+4KJMUb4HFNe2yN
96CYTmQk855PWDSxYbv5yBFzcUh2VQ0QyYqBWWx42nPpKE3NfKoHDXPLY0oUEWsD
hx7vRrk/564tOYCvuyiavWg04REoQ9kLfWz0aUFyCCxHOwTQSTB6UUJxR+m/LA1e
8u1cXJydF5vzAW3SnwNQYhLOarafBEHZkO3bO5KlIF56QakfZhVVPXtC+McBQNXI
zwMoMAd18oVMdasocWdoLytDi+dZiMb+GnSdER5AaFIJagSzWLs=
=Wy/4
-----END PGP SIGNATURE-----

--efITXa2XP+bnX21X--
