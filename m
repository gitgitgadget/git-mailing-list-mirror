Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B74824A4
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407585; cv=none; b=ZuWkC/qbcBVt1cH51+X/VfVM3pH1meGcPRo4SzyAz6SSmeI7O/nx8e9qerYx+5NSd5gerFTwpU9iSCZln4N7Ljn6qAo3WRzC6LnD7Gm5J1eizuiGRRJUhlg2BnAbPJZyPnqXmQd20vt1YbdjMERLTdSYPYfPgxUKN1PZieairzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407585; c=relaxed/simple;
	bh=ELgg0ATW7II/mIC5XeaiDtZolt5ogbofcLpdXpo1XYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7RYDkjBfQqizSl4THuJq7ufduaVZlV+aqwRAFoe1gc7oDta90Z3AJSuv9arEJhU/WEn7cyykoL5mpeIomt/bnRJrTDL+SPRizfLx+3kvpdvtSmMtz/mInA+hKg+GweniTpplWA8lgACnfrUOODSd53XuXoNDEJcewtLmzHDZ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eID7er26; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kbHhJvdJ; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eID7er26";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kbHhJvdJ"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id D4C141C0008D;
	Mon,  3 Jun 2024 05:39:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 03 Jun 2024 05:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407582; x=1717493982; bh=Ut7iIkqFzV
	fPGJvR99bdDyV37gp+WfELv7CJaAJbMXI=; b=eID7er26uOeLX72keet/xODXw0
	eCT9ODFHPvZvD8PoPcTYgyCuBsv0u80nb6e9Btr0713o88L1mfV5pjGxMHRpHxVw
	1S1ZR9gCj6++xTZLnOM0UApF1dtDrTK/OB2yi+ZFdft1n0aA/1d+W/j4305v8jq6
	3Q/YMvI7PzjMWKC9XZ3IzLFlAkhKc3s+GFt65/TtzPS1T6MptB83eLeC2IhwhQhv
	kvjGlavSwQNwe9JUhF/80L7c714+myV414SOudCB5MVC1uaUB6qB+/dBQo/I+JYz
	R9yowocvhg2KklbKrcqjhs03TEY5t64+3VNgvWX6m3fTdTvyfxsyZzlKQETA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407582; x=1717493982; bh=Ut7iIkqFzVfPGJvR99bdDyV37gp+
	WfELv7CJaAJbMXI=; b=kbHhJvdJBhfw0t9HOyD4IuzH1dBphCnBWnwF3pGavJb/
	udGzNBluS2fLhPtT6KLTnLRos0c1yssfvi2rM42OZBf7IKsxN+HO/v6NVmZ4AkfZ
	C//r2ily0VUX1IUNP6+Zn8FELBDtC5YAv5eoQiMKk+RZWOXfTb/0+18wv9s5z5nQ
	h34wBHqb5PUY7PfAHSOBHrjdDDp1t098MCg3YTDC4w2amctykFwfCmkYO3BCEbfX
	eaa9NOZi3bEda/GFYoX88g0mmO5J246MTERB9My2MdJSu+paq39m6SxjmRxZNSWh
	HJ8Hp9FXHQ3ODhU2Ss5nYHNOsVLDHYuCZzCY41waNg==
X-ME-Sender: <xms:Xo9dZkxliOghpD3YUxGDwDmwsCvGamLEq0hqFgPYFUzDPwX_A43NPA>
    <xme:Xo9dZoSFGx_avY7oUNyqpCL_kpONM96tXygUR-_anGrlIgGAVAd6WVkmdK9HoLqeW
    EoFDqFmGjSpOci0rw>
X-ME-Received: <xmr:Xo9dZmXJvH33LwxZvsZdIU-c7_JQBz_AC9t6SUrl8re_7qvRGhgvYWF8pQGs7iQbkIMw90KUrUS8s_SsZKGLkjJuPZWYkd1XgBOWwJhnwx1KLJbK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Xo9dZijqUapefjfx1aG7G5Go7pdQwhevM1e5ItHIC3QyG29f04dleQ>
    <xmx:Xo9dZmBnZOaD9w3fi_IdZVwgY1QRrtophiNhR1PBk9UbitQoPMRPDg>
    <xmx:Xo9dZjLgBlvcVMsKdV6bcmv6kNa46qjkmiFJSf6Iq5CpLdZbwQxD7A>
    <xmx:Xo9dZtDyD2wDpGqBCTzxO-fJnUc4gufOilnSXM_ZrApySDaV5sQ5eQ>
    <xmx:Xo9dZhNaBFxPoWQra2BDJz5cVsYcI4JGJ7a-hRAilswAfW7R_A1oqIL8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:39:41 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 413c301b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:39:16 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:39:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/27] line-log: always allocate the output prefix
Message-ID: <03dbdd235b880e65012018a5f6418d23d02f697f.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aYkb5QdgLb8NHlJG"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--aYkb5QdgLb8NHlJG
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
2.45.1.410.g58bac47f8e.dirty


--aYkb5QdgLb8NHlJG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj1kACgkQVbJhu7ck
PpRJWQ/9GiZTCd7IhiaXSJgKGAI4o0ZP83pHv4T/n0Q2M2cb29XFuRLpWA8JiZj9
jU2jR+inrDZRExCMYVFMAc/nfY6lizo49801qjr8j98tp0dNH2/yM7JWlRAANfOY
M3wG4sBcttpPg/5R2WI3diIs3kIPI7LpapW+f5KU/tdVZfLNBJPF0p79L6xpixjG
HPhJ7xu+cEAtxC6K1Uv0uthz0E6YMaM9gKOMrgd2Hyou0HjKQfpksRixUul9sCXF
Xd4y+bRdTPt7SKnWxn9oj8hvqCGN5IwVxYJJpsR0MVBSi3T7b9CHzgiqBbfh13Zt
mWaWWEOAVeewH6mWSt9bj093pYZWkmZlM2YbZU3nb8sPTsnIBa2J3PWgUwoS+Ji5
fGH8HpodopDW7qgYQ7FZ3IjEqrBGDcV3oAUHK/OYiHWGIjO5mnd4+1NUupNSTtTA
yGRh5D6rVPU2qIaq86FWRBei6rU2+K/lDZV0dJjlzRJuf+CG43IlzfnJTy4r3V15
1NNLs1MKcqtoQ7BJR4UOOTliU1BQbQExsl+GQO0AyPCI/+VvZunsqTXoTCr0X+eH
bx+/g2BkFn67WmQQRd1urkiJ7HEDV3VV5YNxEu4VKysHGH4z9p/jpFXATsE1pbMl
YpomT4APqEbBYQxd/OE1pCqjfJFCmdTlHEFmkyXuDUQWXc8R/90=
=3e9O
-----END PGP SIGNATURE-----

--aYkb5QdgLb8NHlJG--
