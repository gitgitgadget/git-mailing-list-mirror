Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB9614F9DB
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742381; cv=none; b=fK5GDEJl2D3TvIPqC0lbqnTPZT05ojTnBrwV28Eycsp/uayhB2YmIUq7lWzZ6kLTcKuONvB6GlyzA2KGj3lPJ9hEkKginQCq7trwRLQa6RSYsHp9ER+0ST16Pi9rchKlWsLHpjFmPTEZueKNFg6EiOihTXw0bB+2Xuk55ZLb9jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742381; c=relaxed/simple;
	bh=05Rty5B+iUkbe17PW1iJaqVaUh3JXFXkx6dJb5+R5QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOE7Nogn9lRzrEqocPdWPAYBnqWuN7J1R5r322pVlER8+mzA842zfFwM2rr9yBB8fFyU30SFh3WthfrJEGVrpN7JJN5+G+2JU9pxgELGiQSjqLGQ+et420zXV/lKfSJzR8CJAjpPvhWWQY5lrN3QwQqCCKjgw0ESvN2o8qefZuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=enN7cZs+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UoCbouwL; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="enN7cZs+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UoCbouwL"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2E98011401EA;
	Fri,  7 Jun 2024 02:39:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 07 Jun 2024 02:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742379; x=1717828779; bh=QDkijaEgNL
	W05IAn6FQF0vbWPZ6NwGTcBUVFn7ION2E=; b=enN7cZs+NEfCNJs1JPH3hQv6a7
	PC5jFMS/TAybtp/yig+5/Mpp7p4WBb4/cH3UKyjlL5B/QHlF0ynFElhWb3aOuoEX
	WANiLSPtpiQ+eoN10H/xg7mPsA8lgzPtoB+NobDGbudRFujqrS/EMhcrmAp4zQPA
	ceXMEl25vF33k6d4VhQXTV2F5ddBOA55d9j5WdWmsSwo8HDuJ2sqgaPy3p16f0jz
	CJIjKHKlPXTaR8PjSUr9gNSdI5Osqt7aHjEXwKKas1h9De2koPnS7hmDonj1rl9y
	8dwIpGXInVYU3LkQha68DsiyOSjlR3BSoycpN7FQDfXEBrs0VvVj8X80IFow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742379; x=1717828779; bh=QDkijaEgNLW05IAn6FQF0vbWPZ6N
	wGTcBUVFn7ION2E=; b=UoCbouwLHwR3d7PBjDDnbm2dslKQeAZ3hmWMsoDzZW2k
	u/lLgfcScJCUhNM64g+f7njf4pG9Krj9CyV6bL9oEun998LHLq5uqRVQ+1cRgh/J
	jSFsT3iUDI3RU4PHF/s5P15e/H0YhY4Cn1OcwT3/WQ6ZQGUEkPLXA6f8Udu2QeJY
	E6Q87Oopf41RoljmtizKtfx5CSGalULTF7TQ5bpT8tMnC+YtzQHAWkWgRgp0KrYJ
	D9AKkycRfSyQ7ichR6wrPie3YvdRXfuQgqR3jNLt8O3CxNMMILkA0Fl12SmGFtKd
	fumular9UzqOJXYxdzHfmAduk8ZudmjxGou+IKiaGA==
X-ME-Sender: <xms:KqtiZtpsMG7Y9M3E9c5bA5dazlj-bqs2_3wFsV7Eg1sIY2NFJbN_0g>
    <xme:KqtiZvpQWBm4TvjUGpiyUfuFDk0O5eq7RJcQc1Sh_jPEUL0tw06hLjmwqPy6np58N
    R0Yv_p5dE98RK9yRw>
X-ME-Received: <xmr:KqtiZqNuM43EuAq7NjPBbq9SoOVfVG5vlBM-FmONoR3X6TgDG-yiMeYpEAmO2WhwtVTaoozIqSCWhqWuw21u-G_Zp6EjcysWVRaDLyiWoOIb58Ym>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:K6tiZo75c_FdkpaM_1bxW0a3G2F8kCdc4UPQW_sE2XKHkrlBSvDUNA>
    <xmx:K6tiZs6Zwm-YSQvtjRcfKJE4LyoZ1pIj96I09kF6GMjvtJteILl_yg>
    <xmx:K6tiZggt2Vo9qUOm3bFvlyLehAW6uURZ9iOvCYB2u7gE6aLh8VlrzA>
    <xmx:K6tiZu7t6rI13HrVg9pa9uPNZOmDz5J8HnAZ2o8PpIiBG2KYt_dlGg>
    <xmx:K6tiZn0MZ4QcuuzSBIUfZxNDuAs6yQq4H8yNbBCTadwbxuvTemtgy8ps>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:39:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fe59e56c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:39:37 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:39:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 26/27] builtin/merge: always store allocated strings in
 `pull_twohead`
Message-ID: <d5dc1453f21a98650180f7df13ec9e14606478e2.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qBhGdnDk3gH55nKp"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--qBhGdnDk3gH55nKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `pull_twohead` configuration may sometimes contain an allocated
string, and sometimes it may contain a string constant. Refactor this to
instead always store an allocated string such that we can release its
resources without risk.

While at it, manage the lifetime of other config strings, as well. Note
that we explicitly don't free `cleanup_arg` here. This is because the
variable may be assigned a string constant via command line options.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/merge.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index daed2d4e1e..fb3eb15b89 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -611,17 +611,19 @@ static int git_merge_config(const char *k, const char=
 *v,
 		return 0;
 	}
=20
-	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
+	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat")) {
 		show_diffstat =3D git_config_bool(k, v);
-	else if (!strcmp(k, "merge.verifysignatures"))
+	} else if (!strcmp(k, "merge.verifysignatures")) {
 		verify_signatures =3D git_config_bool(k, v);
-	else if (!strcmp(k, "pull.twohead"))
+	} else if (!strcmp(k, "pull.twohead")) {
+		FREE_AND_NULL(pull_twohead);
 		return git_config_string(&pull_twohead, k, v);
-	else if (!strcmp(k, "pull.octopus"))
+	} else if (!strcmp(k, "pull.octopus")) {
+		FREE_AND_NULL(pull_octopus);
 		return git_config_string(&pull_octopus, k, v);
-	else if (!strcmp(k, "commit.cleanup"))
+	} else if (!strcmp(k, "commit.cleanup")) {
 		return git_config_string(&cleanup_arg, k, v);
-	else if (!strcmp(k, "merge.ff")) {
+	} else if (!strcmp(k, "merge.ff")) {
 		int boolval =3D git_parse_maybe_bool(v);
 		if (0 <=3D boolval) {
 			fast_forward =3D boolval ? FF_ALLOW : FF_NO;
@@ -1294,7 +1296,7 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 	if (!pull_twohead) {
 		char *default_strategy =3D getenv("GIT_TEST_MERGE_ALGORITHM");
 		if (default_strategy && !strcmp(default_strategy, "ort"))
-			pull_twohead =3D "ort";
+			pull_twohead =3D xstrdup("ort");
 	}
=20
 	init_diff_ui_defaults();
@@ -1793,6 +1795,8 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 	}
 	strbuf_release(&buf);
 	free(branch_to_free);
+	free(pull_twohead);
+	free(pull_octopus);
 	discard_index(the_repository->index);
 	return ret;
 }
--=20
2.45.2.436.gcd77e87115.dirty


--qBhGdnDk3gH55nKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqyYACgkQVbJhu7ck
PpSU8RAAi86Wp7/v8LthVKA7jdaa9nrRDCTsA1KxNFJ5af6UZjo/OMgtd4oDZiEO
2AGqiNMZvIvQP9occsNygGqfxN04hM01qK6xJI0hWbQTElj1NKfskEgq0RwNOgUH
qyQLtrXfmmgirFWV8614A67+4SgZR8evs6asaiwuo/Z9ovwZVO6HCysXS4ziVCvN
AgH26V+1VjM3L1vBgBjejRjwvwVElZbfTQCVIJeGbDy7Ub1XfRcb4CThqU5ktY/d
XIOQCJiUQPHOWrMbjXuKRyZ2X62dLx2SPDaYmgUljWDUYbKdRD8+gcaHKFCOTHHw
oPF4bg7h2yyRRtmFpoVxG0vnwsbKAkBKauTiSvV4qFKZyiLl0TF5y2Ww39KhiArL
OU5WYQBKG61jrmx3r1Y/xUro7WhAQsqGMJkjywSZ5MHia7GZE5/gcYQxnWE7olpG
aqMCbjmOD5uUSlkg5veEzCtqYCVohAmMDtot2Eug4tC40ItCCp6YRz0h5jKGUQQk
gW2fCF4GiMa228XqQswvCyJfzpBggXeOVTn+tsVIsAatJ03hNmn7yPsfOYKr6aBa
d4vHSbx0iDuVtrXflC2OfAsiYPnhtQ70mMp6MbUSewVJJDVi1lXxm1kzDFlpQco0
pTs1ZNGGJW4JVGxYXZ/bjjRHuExmvnjpD5xKKtKRZsQXqM0XQYw=
=PPAj
-----END PGP SIGNATURE-----

--qBhGdnDk3gH55nKp--
