Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E591CABF
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742301; cv=none; b=baGEUIdkgjTPAgNreYXaS63Y3MuUcFHCU5xCTo7QUN8VbE+Kz5qO4HIsWGK5qyIMkC+H3NZi6O1dEKoSUTsUmWJm14o3+fUZnShKoejse/ERk/by0yVrWd8rVTF4kGFjPPNoooe2sk+DSKoX+xwH/PLpr4zGRLqqDnqqne/ARN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742301; c=relaxed/simple;
	bh=vlqPJ+XdaqHaCDIISIJ0mBWPGiYi3W8/mPnC/D/VmmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtLsM5nMh1kNfIIFNX3Kisqc0Wu6B7bTS7iQrawEo9lr+wnU0JjalCgaOoj6rJjgwOOqNGwgELaIUlP37/jCuaFVSjCudByV3hBHP+s5658GBYyHwQiN6GaDXDLCLkjjgEeueCcn6rm2vUojH7SJ0LvW1/zlRkMdSs8ANWvI0Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ftzv/JYN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qI2lUnuG; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ftzv/JYN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qI2lUnuG"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5311811401EA;
	Fri,  7 Jun 2024 02:38:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 07 Jun 2024 02:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742299; x=1717828699; bh=ZWK9T2+pvY
	bzQOs1KjWk6mt9zVhEL5kLNjdhJdroOzw=; b=ftzv/JYN/0t/isoZBg2YFHrI9j
	XsKYibWBEoHB9lCt3t3Pvj1X2AgGwO55+7icE3cChRLc9hXfQ6WSlztRxHPuVpOn
	0PKSlChbCyVCawn/vZhzYohsl7OR/CIA3f0/d55Kcibp+U3Q2Ux+F5XqN2JBRjxE
	VmRhvRnlTo8+PyzEJyWnMaz04fEngMamkbfZoGDu36k0vWR8Hf/qHcysVnSTCu6m
	MOlcsuiy3uAv0PgIlb/TojM+UPNqID+01Yn2uZE/WLJMdcUay96AQYKLvbpYIDjf
	nOu+FkAF4aGjHvaj0dnUcSUQL1ZiJgU/pAKVo/M2NmcizvWnsLy59HsiXPwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742299; x=1717828699; bh=ZWK9T2+pvYbzQOs1KjWk6mt9zVhE
	L5kLNjdhJdroOzw=; b=qI2lUnuGSFiyzGikhq0FmSmAn/uBB9sIWbZlpq3TRzyn
	j94KrCchYwqxB4gEysDYy3AMxdE9Hz/lHkugiZpM4MR4XsRIlSMe7tZuH3mfT2wU
	9rUt75QcVH6jvAm/i3tbGVNMscXrzMieX8UjFzkX7XhwA77H9mWUlsWYT7D70J1a
	8NZPmz0XH8OystZ2opJXSTXaNm10p5pMfe4nL8aK4ZNMIVJ2fXQ22+yrHJJO5J1I
	yl/Dm/Um3LRmRzlnt4kTYH8CFG3K87i71hWiS0+l7+CjbtfOCRXw3jQXRni9WbWO
	r8RZqlMcLyT7WRhVhCfJVctySKzMYH0Ia4m80VLkog==
X-ME-Sender: <xms:26piZllbgqWEBw0MKJjxsbMyYsFkCA6MhY5jXBISzXNA1c5yQggAOQ>
    <xme:26piZg33lEIzY9hcGYVIJCxeXRLDZjjEJjA6Tul6t0Uaaq3bs11qREwTlVq6nbBMv
    FohSmFGj_W9UKUXdA>
X-ME-Received: <xmr:26piZro2vyydOuRNdWFodj9wGoN-GgowLyNPMMdS-cI3PaMt5Av3pIvxHOES2FfBHEeLYBDsbXqbJOzvAgKM7THvRhZHuki_Yv5VEhQTSv7BzTK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:26piZlnV8NyueA5Edc021vI85hEBiTnIkhLST9xReLh5EChFztDySA>
    <xmx:26piZj2RiIosba2dJrwEzHepLFc500GRZ6xQiwx8fQKm9a_AdJZTwg>
    <xmx:26piZktBxfm69ifkeUTLBMNHNgO7HPAaWu-Cjnz4jlbgtmiyWVMqrg>
    <xmx:26piZnXAZz9xwryLs2AFutftmOiH_iSM91mrk9myfxcScc8M_lhjrQ>
    <xmx:26piZuQIw20YTZwNjCENCkXObSu97MwTlaWc33IeEXNb_JVADl4PucjU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:38:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8c3cf6cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:38:17 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:38:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 09/27] line-log: always allocate the output prefix
Message-ID: <527533540ebabc91b8b484d5caa3099511c4b7aa.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ri/3xOIm8koEtdum"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--ri/3xOIm8koEtdum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The returned string by `output_prefix()` is sometimes a string constant
and sometimes an allocated string. This has been fine until now because
we always leak the allocated strings, and thus we never tried to free
the string constant.

Fix the code to always return an allocated string and free the returned
value at all callsites.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 line-log.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/line-log.c b/line-log.c
index bd3e663c24..67c80b39a0 100644
--- a/line-log.c
+++ b/line-log.c
@@ -899,14 +899,12 @@ static void print_line(const char *prefix, char first,
=20
 static char *output_prefix(struct diff_options *opt)
 {
-	char *prefix =3D "";
-
 	if (opt->output_prefix) {
 		struct strbuf *sb =3D opt->output_prefix(opt, opt->output_prefix_data);
-		prefix =3D sb->buf;
+		return sb->buf;
+	} else {
+		return xstrdup("");
 	}
-
-	return prefix;
 }
=20
 static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data=
 *range)
@@ -927,7 +925,7 @@ static void dump_diff_hacky_one(struct rev_info *rev, s=
truct line_log_data *rang
 	const char *c_context =3D diff_get_color(opt->use_color, DIFF_CONTEXT);
=20
 	if (!pair || !diff)
-		return;
+		goto out;
=20
 	if (pair->one->oid_valid)
 		fill_line_ends(rev->diffopt.repo, pair->one, &p_lines, &p_ends);
@@ -1002,8 +1000,10 @@ static void dump_diff_hacky_one(struct rev_info *rev=
, struct line_log_data *rang
 				   c_context, c_reset, opt->file);
 	}
=20
+out:
 	free(p_ends);
 	free(t_ends);
+	free(prefix);
 }
=20
 /*
@@ -1012,7 +1012,11 @@ static void dump_diff_hacky_one(struct rev_info *rev=
, struct line_log_data *rang
  */
 static void dump_diff_hacky(struct rev_info *rev, struct line_log_data *ra=
nge)
 {
-	fprintf(rev->diffopt.file, "%s\n", output_prefix(&rev->diffopt));
+	char *prefix =3D output_prefix(&rev->diffopt);
+
+	fprintf(rev->diffopt.file, "%s\n", prefix);
+	free(prefix);
+
 	while (range) {
 		dump_diff_hacky_one(rev, range);
 		range =3D range->next;
--=20
2.45.2.436.gcd77e87115.dirty


--ri/3xOIm8koEtdum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqtcACgkQVbJhu7ck
PpQfBQ/6A9CL6LTSY4DvbqbD3S7X9iXk3JwSWvECRyYYOx+EuhYaO4yfvM0UYl14
dpgAWgoPCuji6w7zzasFdPp7JYSkMGfNHutlJNZcsNhl2LlH6WQX4/kdILk73wwZ
OsCGaVcPMzgfOT5XT2sQUvzxcuVpCqxPy3FGxJR8ZfSDoQ7ySyjr5ZT1bCFL7opF
fIXSNTpqaTOT499l22N4aor3r0CpQ/xoXusRupz8Smlw+emxp+cg3A5iUzRtFh+4
aQ0j3qBvX/LkqOatBHMQZHKKSiWjfoqLUGGwcBm/D6kxI7++y5sOHgU54iQ+hbUh
9kwqk/6TpF4Xu+8+fw0b/qGW5OOIiQBRoW8lalAvb4naFXiZSh0XZDrMajxBbRWx
Pnrxe+TIIm0Nkq/HBoP86IbLbuT3Zto3vNiarVjUvXAA0OKZXSuChdQu6jSO3asp
Us6BIEF2lU0UFOrKsqpoNmr+S8Pwzj4o8ulpouJI4ti8lkO3lE92jiesr4bFOtsp
TbKWsdmkwFBAvkOGKt0Qb9Ph9Ge30eDC9yK8AgP1ibbt8njAd6EGZhiOZFgldor8
cewG8R2TTyivXziOdLyY0cURZDp+Y5mnkpj68f4bKCt6M55RtwnpY6em8uBBhw7h
CBAIXMZCBWZtLcbeqEKQyjbTSXEe/qt1zFwwVUcqhHxAyeUJ9ik=
=/Gq5
-----END PGP SIGNATURE-----

--ri/3xOIm8koEtdum--
