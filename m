Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9775814F13B
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742372; cv=none; b=B8lBIC/ukbqTCfkEP0a72wCoPUrj/BHFKHfuH3ij1oVz4yK25VHU4a8fvRiodgZMDItJ9kFpnqIEaMRsYKa8HDLStzU34E40jyi4nnlEcyw70FGk/vBMtzfTYJN8X0kuOYBEPBoMmz37o4r3/5BU7BvZa9MS72cVfqz14/1ljcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742372; c=relaxed/simple;
	bh=HrySaTa3lpsXCYFMNeBbevuLghDw0N9T00VgrqOAEYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeZ6t/rE9fyV909sjoQbPKWY/m2PFTvHwHQ646zxvZnGUTWSuJYW5dxpvAgLLKVMMPBD7RhQQG6oFEIzuZS1wN8b6UgcIij8zoQgKkB3l0uBFOOIu8tbs5HbjssgEyc1Q1sqSoF+2czEjsu0vqqgjdA4kz0MaLbCkfqk7G2u894=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HfxSPYXt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BOqy5f0N; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HfxSPYXt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BOqy5f0N"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9FE0711401EA;
	Fri,  7 Jun 2024 02:39:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 07 Jun 2024 02:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742369; x=1717828769; bh=DQtESg44cZ
	6tgI5CAaW0aflAJpd40dgOC+lproDaLQo=; b=HfxSPYXtkVuqUpru8Y4ZYX3iTN
	36rx7vO1biNevg3xL6phOqkTbsCm0ZqtQqPBM6E0vpwscd362be9vL0VUyRY2qzN
	1fokx/Aktiq9zlsyXe+laqTIS9tO+Iw3SOMqgc/GaU+aSC1ObMktAoiQFEn2/SR5
	Yux4Fxhus3+H1raFoAUHA/bJFRrtHuj3mHhVeBhwwsmJGCiCDrprsq0iUZo7fq5b
	QVISqFH43XV3TeAbQW6cYWGZQPmut3UJ0/tDWVuDudkUqPtrizjUuvpIbJSvgq7O
	U2IfoUr786MvuzoYLcsaiCzo0EAHm+nYhFzJ/QonMzdMH7Lyj6ta/U7SefUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742369; x=1717828769; bh=DQtESg44cZ6tgI5CAaW0aflAJpd4
	0dgOC+lproDaLQo=; b=BOqy5f0NQRTC+EYP8VE/cKhdrtzbepJ8uTmXyfth29rT
	gjXH0vhkswCoBOeYUBWJzEtE+jufrn6k3owE6wZeFFuxdzxqE7XJ/DvY/bsouUfY
	fr/JqZRl69uPYZAKEWoqa7Hamng12A0u/9zmrrOi5l5tEyKVCEdVN/3k09DooftT
	L0qiPAjbE6jBRIf+9EYnf+Y1boH/9mJ30imZehbMJWWNB3UWJrQcqNCHpsnepDEQ
	5/GMR+lNkGMxlOJMNa6XSFEjQ8Zag5GLt68cXs7NoTdRQmJM3Cgmcvtubi4p7omC
	d2al2xdeHzwKJ2Iswz68codOeG5pHSvGI1f7glPc8A==
X-ME-Sender: <xms:IatiZjBEwytlVEwCjWuTbnsW9nb9YU4EXJbSSXvIeJIprKigAO6OFA>
    <xme:IatiZphEndV6q3cHP4c409Kwb8GHpmxb26NmBZ61iDX9LSmG80JY476C-8ee_QYz7
    lXIEOVoIqeGq1TNPw>
X-ME-Received: <xmr:IatiZukcF0PorS9N_rXywkhmZfQkC9y5q27w3GXMvetIM-Qig7zBM3os5B6fHeX6_k3W0J4JjwBRDFgNgFsraSM9d7hJUgN05jw-1hZ1G9frlwVV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:IatiZlwRgE5xfJw7-7VEiNWLQFVRh9pV0wFdKYa5QTAbnhxE7tZgYg>
    <xmx:IatiZoTQM4FX39dXClf5AYH2emWu1I1hjM3OQkwSCh20k5BbWaI0yQ>
    <xmx:IatiZob8_MK1PelvH2d8kvsVnrtStWrIJNkPaAYy6NrvnCtIXc1Mgw>
    <xmx:IatiZpR6vcJPFipZDCm8Bxbf46Ba7qoRECAmP2xi1APdeVcM4SPsCQ>
    <xmx:IatiZuNH5MHwZ69Qo0PJPwgPt8BLheNzm1DrKB2bgCW-w4GILGV9PsJH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:39:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d1a20c12 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:39:27 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:39:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 24/27] builtin/rebase: do not assign default backend to
 non-constant field
Message-ID: <b2b4a01a2e71bf09c85014da05f74c226596f0f7.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I355eoJ/Q1X9DpEd"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--I355eoJ/Q1X9DpEd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `struct rebase_options::default_backend` field is a non-constant
string, but is being assigned a constant via `REBASE_OPTIONS_INIT`.
Fix this by using `xstrdup()` to assign the variable and introduce a new
function `rebase_options_release()` that releases memory held by the
structure, including the newly-allocated variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rebase.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 14d4f0a5e6..adc990b55e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -135,7 +135,7 @@ struct rebase_options {
 		.type =3D REBASE_UNSPECIFIED,	  	\
 		.empty =3D EMPTY_UNSPECIFIED,	  	\
 		.keep_empty =3D 1,			\
-		.default_backend =3D "merge",	  	\
+		.default_backend =3D xstrdup("merge"),  	\
 		.flags =3D REBASE_NO_QUIET, 		\
 		.git_am_opts =3D STRVEC_INIT,		\
 		.exec =3D STRING_LIST_INIT_NODUP,		\
@@ -151,6 +151,19 @@ struct rebase_options {
 		.strategy_opts =3D STRING_LIST_INIT_NODUP,\
 	}
=20
+static void rebase_options_release(struct rebase_options *opts)
+{
+	free(opts->default_backend);
+	free(opts->reflog_action);
+	free(opts->head_name);
+	strvec_clear(&opts->git_am_opts);
+	free(opts->gpg_sign_opt);
+	string_list_clear(&opts->exec, 0);
+	free(opts->strategy);
+	string_list_clear(&opts->strategy_opts, 0);
+	strbuf_release(&opts->git_format_patch_opt);
+}
+
 static struct replay_opts get_replay_opts(const struct rebase_options *opt=
s)
 {
 	struct replay_opts replay =3D REPLAY_OPTS_INIT;
@@ -796,6 +809,7 @@ static int rebase_config(const char *var, const char *v=
alue,
 	}
=20
 	if (!strcmp(var, "rebase.backend")) {
+		FREE_AND_NULL(opts->default_backend);
 		return git_config_string(&opts->default_backend, var, value);
 	}
=20
@@ -1833,14 +1847,7 @@ int cmd_rebase(int argc, const char **argv, const ch=
ar *prefix)
 cleanup:
 	strbuf_release(&buf);
 	strbuf_release(&revisions);
-	free(options.reflog_action);
-	free(options.head_name);
-	strvec_clear(&options.git_am_opts);
-	free(options.gpg_sign_opt);
-	string_list_clear(&options.exec, 0);
-	free(options.strategy);
-	string_list_clear(&options.strategy_opts, 0);
-	strbuf_release(&options.git_format_patch_opt);
+	rebase_options_release(&options);
 	free(squash_onto_name);
 	free(keep_base_onto_name);
 	return !!ret;
--=20
2.45.2.436.gcd77e87115.dirty


--I355eoJ/Q1X9DpEd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqx0ACgkQVbJhu7ck
PpQNqA//VHNsfrc6l90oKQZIUcCBOqSeNWPIEVCZv2C7k4iA0RosVoyRwl0PJu9K
9RUKN91EjW49BKn7go+tmdbZrIKN0gkkXUiuaGL2IrJGx3CZcFZIzyTB649MXJqG
Kve4/zF9KeqCEAjmOSeNe/J2gMPfn1Z+Ri5XQlnqraZ8eeMnG6vDWADfI0OTiPmz
PZ7i2fT13cDZ6MXF1WpFlCfbkOXn2gfz1MFsy06gM990dFVm9IJWtZrCqpLdJY3G
MRKy/nE6ZWRVXaQse3X1O1bx8yvqlJ9jVIlW0dhAwh/rPeZaqcgN3QGjDPr2pS+S
+MVHSlmZ6jXJ4XxnQ0cpIaCQZd2fRspJcL8cjFjAtmmi5VzbZ9pOMe07p/Jm2rDo
I0lIMFoipqfbc+Adf6dAvurUt+gQg/VKK9a01WUZTCSkKKDMJ1OJTMZlDlM6qf0C
PgGGnNcKKaHIz0xI4ayGtSbMalUf7EyZstbwf2Ze13OAq4ItFxWkoIlcstnSMOvj
GKB8NGLuKAjNzTIhkXVhgF6L7h3cAtg4A6Ek1CbhAAkQijckKKcDXHINfK3HxTKQ
SHZTgsf7kp07U/kN6Vfsl0dD2FZdDRurunklZyFK5h3mc+thaRV3xHsz/cdv4/1a
xBp+ZWqjl483/qjhFdjvt0s57Nhc0w+CmlIYRXDOI3yBxEubgLg=
=rNem
-----END PGP SIGNATURE-----

--I355eoJ/Q1X9DpEd--
