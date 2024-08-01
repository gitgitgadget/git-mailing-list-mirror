Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C492D170A17
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508985; cv=none; b=MTKoPI4ePTE7b8AqFjreNYVbDXSWI7kl+Aj+P2aJQwUCTWhlPg/1xiM4UW6ybDJN/M9dW0YuLkPOauL46QpOva6NceimXHPy+eHmVPmZwH1sLoTjmtNoKHJ1cgOJ574fTPB0FLJe7ehEdzhyBp9PuSlj9cKijIKWbsIyb2Rxix8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508985; c=relaxed/simple;
	bh=+PwiTOy7dbRZrIyY2q2oZWkRUgir+7qP3ftug/YI2/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kL+dTLmE1xiKIzADTMNGyBNhCy5eo0hqrnssN6PMfInYoHDrDLD26jMDvpR+jDZVAuHPsHoNG0bhsMM+GRFDpi+614nH2eviTQAe+hQrseL3NIrVurdKu/ZjcdAeaQa5tIqqdwx6sgOqSq/orAe2H6CSBwMxhHO7OQFo2ZMXNGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UdRlRby7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kN/HTev/; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UdRlRby7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kN/HTev/"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1F5C71148363;
	Thu,  1 Aug 2024 06:43:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 01 Aug 2024 06:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508983; x=1722595383; bh=OK4FPYT8UC
	bFpTMME0E4+XysFllslgBwOZlfBdpzp0E=; b=UdRlRby7fAG0f5fae41SCvURrZ
	Jr/HFtaY0PCdouk2nmuUWJCMj4a5jnoP0xXmRDjnjQxTZA0Dw7ItctQmAtUnav6+
	ey5dKd4HG2N+Ix0l23w0PX1cmz/7ZVp6GnV3LEdQykMv4IUcfX0gWfmQsSB9QY9l
	ix9Ya+H4CP4yEQpQowpiI7TVTxRQGjBGOmcj8kGAEODkVCSubRoQqKms5VoSpcV/
	F6alwJpgt4m85HIHYU8VijSVIdMLaVdlbfM+Bi+G1UDv/pwuR/76BvQxC7HjQGFH
	QccQfdHDdSS0gihT57DDnCmtZrir0NwIDX0A6+yjDEkoSXyX1YoxU1EheQ2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508983; x=1722595383; bh=OK4FPYT8UCbFpTMME0E4+XysFlls
	lgBwOZlfBdpzp0E=; b=kN/HTev/rxSXKCcxbNMuP/M70LM1SJr7gxn11PExNMfq
	gtbCBcKn3Af0kpAXra1xrhYIdv+hF3Bm7tPzTTrEe5mD4CQDWhy34oqe8TBd/cyg
	9dwvvXWlldGpuD9b7JzWHH+SURg0+ZfFflWHRgoQL6ahlYRLVzwApBv/XVmCUpYQ
	2aStTrCUrNqbTClWN4HeyE1jXbFa1EC0I+jFYcXWMIbdMaMRU4O9RMOgT9QO5Jsg
	npisQF+UnLvTxsXFmQt6DPaVE7OFQx30RmNPvOPX3/asI+2N0Ng8bMwAMzcHuydL
	VX0HCWIALYqIoDGKgdVOMoCLrDvMilvCjy/Du4rXLA==
X-ME-Sender: <xms:tmarZk8rIOVca71K1EI7Vb3gkuJsEMsso8ubXUTCJB85LaTkeqNaog>
    <xme:tmarZsuGZSwVhQ6J5hQ0jPPpgQIOlz-Xx3uZvoaAZSMsvQQRwe7GH_b3XlSUywHuz
    -SllAt4retTCks1cg>
X-ME-Received: <xmr:tmarZqAe2WJnFFFrmq9t_3mf8n2M5nhBFxq7RvGkDStyhvBoVRRdqqfrVHPzX3BCxBqTYrw3mzM0mCnEOI9Ighy_h6ytmiF4kjdiddU0Cjllzw0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:t2arZkc2WWgpoN0H4BXxclLf3WhoCJDgtfjCvp_Y8idfPExKNyCLQg>
    <xmx:t2arZpOqd2zf_stGIIyV9e-jbOEETNZyhFsYS_IpzzQugvF2nRVoog>
    <xmx:t2arZulOnuzRnbCiMsfc2pZuWy81bd90bsh_VvrCoesjbkk1QNjXYg>
    <xmx:t2arZruAtjna-qN4X6RhCj8Wb90sHFiJMoZKvaEYsb3v7H3Dsi46AA>
    <xmx:t2arZs2ETNZxAPiSuuv_In2EVmUnoWtXblZqxfh5S0As-p37gIwrQ7bu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:43:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a8fe73c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:41:29 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:42:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 07/24] builtin/submodule--helper: fix leaking clone depth
 parameter
Message-ID: <d3eb0372bd3aeb824d24114ed0e3f01b2fdc6adc.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BStovLP85p2NpJXA"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--BStovLP85p2NpJXA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The submodule helper supports a `--depth` parameter for both its "add"
and "clone" subcommands, which in both cases end up being forwarded to
git-clone(1). But while the former subcommand uses an `OPT_INTEGER()` to
parse the depth, the latter uses `OPT_STRING()`. Consequently, it is
possible to pass non-integer input to "--depth" when calling the "clone"
subcommand, where the value will then ultimately cause git-clone(1) to
bail out.

Besides the fact that the parameter verification should happen earlier,
the submodule helper infrastructure also internally tracks the depth via
a string. This requires us to convert the integer in the "add"
subcommand into an allocated string, and this string ultimately leaks.

Refactor the code to consistently track the clone depth as an integer.
This plugs the memory leak, simplifies the code and allows us to use
`OPT_INTEGER()` instead of `OPT_STRING()`, validating the input before
we shell out to git--clone(1).

Original-patch-by: Rub=C3=A9n Justo <rjusto@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/submodule--helper.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f1218a1995..863b01627c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1530,7 +1530,7 @@ struct module_clone_data {
 	const char *path;
 	const char *name;
 	const char *url;
-	const char *depth;
+	int depth;
 	struct list_objects_filter_options *filter_options;
 	unsigned int quiet: 1;
 	unsigned int progress: 1;
@@ -1729,8 +1729,8 @@ static int clone_submodule(const struct module_clone_=
data *clone_data,
 			strvec_push(&cp.args, "--quiet");
 		if (clone_data->progress)
 			strvec_push(&cp.args, "--progress");
-		if (clone_data->depth && *(clone_data->depth))
-			strvec_pushl(&cp.args, "--depth", clone_data->depth, NULL);
+		if (clone_data->depth > 0)
+			strvec_pushf(&cp.args, "--depth=3D%d", clone_data->depth);
 		if (reference->nr) {
 			struct string_list_item *item;
=20
@@ -1851,8 +1851,7 @@ static int module_clone(int argc, const char **argv, =
const char *prefix)
 			   N_("reference repository")),
 		OPT_BOOL(0, "dissociate", &dissociate,
 			   N_("use --reference only while cloning")),
-		OPT_STRING(0, "depth", &clone_data.depth,
-			   N_("string"),
+		OPT_INTEGER(0, "depth", &clone_data.depth,
 			   N_("depth for shallow clones")),
 		OPT__QUIET(&quiet, "suppress output for cloning a submodule"),
 		OPT_BOOL(0, "progress", &progress,
@@ -3200,7 +3199,7 @@ static int add_submodule(const struct add_data *add_d=
ata)
 		}
 		clone_data.dissociate =3D add_data->dissociate;
 		if (add_data->depth >=3D 0)
-			clone_data.depth =3D xstrfmt("%d", add_data->depth);
+			clone_data.depth =3D add_data->depth;
=20
 		if (clone_submodule(&clone_data, &reference))
 			goto cleanup;
--=20
2.46.0.dirty


--BStovLP85p2NpJXA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZrIACgkQVbJhu7ck
PpRavg//fjGCxYPXDTmixMbk5iCbt2Qr6cgy0jY4LLQKuDInO+2RW103R3vwFCMQ
j1hKoNXS8fLsmouQfIDsXd8WcARtJQ5nDunVx1QCsOfJZj8fLHIKtAyhmnfERWJR
P79GAxj60zKMArh7cf5eUS3BblxIqsFd1N32VS0CaG28H0iZ+eockNTkR70eUTN8
Xl1SfzXw0S8nHIx7w9mS2u57dFceo/kaztPij0yPIAcNMXWnk1Qk/fms9WbG19PQ
5wGvkRYBkZt7Nx4WgU89eQnY3ie/nwHYbkiOPmwOwTTwytcsImB14QqrobBJGhN6
L70zaASo2EzuZtM8YDE35qbz0X0chiz0zu50Z9Rqkw3BQZl+dyeoHr88s4ijjwOy
FMQ+a34cLUff6A0OtT8I0W1x0/CrPjQbpFcLBrm8pSKuV+csh/LubgeV1vOyXmsM
PtMetaS265UO0VVK8IHCZo9rOZILY6utKelEVVLxh/ux83ocHCxNf4bW0bT5IZCl
EAZuXSwD7nDwnpexkpz2SpeiIgBHN6L8iUBZCBrD0iSqaSH2RO/13Y/NWbImgzjQ
GOX4+maWfT8q2WB977uXMTABJNs764odhCzqQe6Ut5w3abyrk+lyX3w0dssj/M3H
mIg+YerJMnWPpG8Jk1xHMCVjw1J05ev2qjJG/RrljKoYSeWxYYY=
=8W7q
-----END PGP SIGNATURE-----

--BStovLP85p2NpJXA--
