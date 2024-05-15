Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EEE55C3B
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755370; cv=none; b=DsYC7o/S5CcjALfTxNEYCp591LWu9EE0+9HohgPqFBqyifi/ScmhR98j+hQxft9NTPC3wIFotyBwfzwOwmpbm/sNQcvoTxQVw75Ud+MH/e85flw1yOsM0pIKLbZbQRqlPzaifpaSYm3+ICyL03/qsKyEc8LF7uX2rp96eWHRBB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755370; c=relaxed/simple;
	bh=zv0FlD7oM1OCX7SfQuqI4X4f1ZcodI9uxoJHsGdYV2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nppcpAG1cGm3OvDym6dgaagAeT53yVag8ve6bT/Ol7wlF1DUjYqk0djCW4jtFHvjlZFsWO4dmWPoGB2Jhhq9NbcE0D5BUM44GiBjA+g2vtUR1WaABadcw39NJTlMjN4eLm0KJilNdptVOulGQpjeF5SxeWNRwYNYz5PmUDjyYQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TSypiw2G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fd0LxPjE; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TSypiw2G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fd0LxPjE"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4E6711380259;
	Wed, 15 May 2024 02:42:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 15 May 2024 02:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755368; x=1715841768; bh=6VW1c3Hmwh
	2zYDlJs7SCC7hvamWHieIHho9H1vAYVtM=; b=TSypiw2GzXCxxrZfXjWJCyzC3m
	EfajrM92JV1j/vflfEh3jS9cq8RVrfk3wXeh7eIf8D/1Z10cY1T2Xk8vlN3nipH/
	6DzIERGMdnBvWlaigTbjpsFg7IFH9HRHtyxyNSbwMhhscFp0WW7jDX6bm/OD2a6O
	u8ALfasZvyLhvAeFS82HGepu7toQWHu49xqcb5ZBn3vdbgoiO2PrrWKWJ9HnAmBF
	kFR1VTVXJuCsirYInzBGkpa2UrIjIwEdPBU73uTLoK4R0djH8AMAGF0v52yaLrEb
	JAkOU750/z/QP3rstwTresfiu7BXdAZRc7n9z5S0RVpaKgxoSw+csdQNUn7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755368; x=1715841768; bh=6VW1c3Hmwh2zYDlJs7SCC7hvamWH
	ieIHho9H1vAYVtM=; b=Fd0LxPjEMqGuZc7OwW6N2cRzoa4rv95KIWuB9Bbj6k5A
	X/1D5mdLz6BISI/Q3zTnfrTotmm6I0QQ9aXMQtAjw+PuK/A0VBnU0u6bvGJB+W0F
	/EOJR5vPSK7B9fVbjE9OB3VwjH1TAeTQoeRhKWDVvtndiVOXo9JlLNTuqYENIkdJ
	Asq5OOK1x6CLadhd6JtVn+kr8k6Z4tcvwFSNt7Xsxv88FhlCWm+apdhb7HL39Wxn
	Zbx7rpZBH8vYcPGWIqzettCr7U4THrEmfraldkSP+K74BZ4TpeO9O94PsAe7TG2H
	1PoLnaOA86MUhMiREMHwWaPmXugumK46E2EouwCivA==
X-ME-Sender: <xms:aFlEZqtKzgosZgEK_kaYm_FpztLVNQvcOs8TeSmWITUvh5rSBY2VnQ>
    <xme:aFlEZveIhVjQP9tl1Xj849O7fNUXrHTIWq-mhvnnF3z3-AKlTL3pe1JauMf25afe_
    SydnLOiZVXMOnpQKQ>
X-ME-Received: <xmr:aFlEZlyT_RbnShWTZgulhw_Zg6Ltdq9tnm6LImkVn2wf3BZVptx6IHf4USTyMeNtqOc3julPNjeeEs1l1v7kc-VoPEQ6r7rInsIMnsvgIL3mCY_i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:aFlEZlPSD4LMxSq_GzinGe6GuHh4_ePv2-F7GUKAtDn3uDWt6IKurw>
    <xmx:aFlEZq_jerJDhzKvmd_qbRb8beFLG1MpkYaYVbjNLYlEb7ASGGNXUg>
    <xmx:aFlEZtXHHI-Cz0woohD88pnyX87fy_FsJGoT6iOpQyWfLHNWcASLBQ>
    <xmx:aFlEZjcFxCuWndV9bI9HSKRMDZNH826klslYn_blVMOKDnhqTYPRmA>
    <xmx:aFlEZuZjZqLhsM2IJaX6DuT_iPefcF0ixVlw9Y3mAv67i5MJdD7sIolx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:42:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id af947207 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:42:24 +0000 (UTC)
Date: Wed, 15 May 2024 08:42:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 15/21] builtin/config: convert `value_pattern` to a local
 variable
Message-ID: <821bc68212a8c2a1dea4c72b2d1df5de63471177.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715755055.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+Hnl6x7+AHvxPRSP"
Content-Disposition: inline
In-Reply-To: <cover.1715755055.git.ps@pks.im>


--+Hnl6x7+AHvxPRSP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `value_pattern` variable is used by the `format_config()` callback
when `CONFIG_FLAGS_FIXED_VALUE` is used. It is only ever set up by its
only caller, `collect_config()` and can thus easily be moved into the
`collect_config_data` structure.

Do so to remove our reliance on global state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index bc80fd293a..aac5f7b976 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -125,7 +125,6 @@ struct config_display_options {
=20
 static char *key;
 static regex_t *key_regexp;
-static const char *value_pattern;
 static regex_t *regexp;
 static int use_key_regexp;
 static int do_all;
@@ -327,6 +326,7 @@ static int format_config(const struct config_display_op=
tions *opts,
 struct collect_config_data {
 	const struct config_display_options *display_opts;
 	struct strbuf_list *values;
+	const char *value_pattern;
 	int do_not_match;
 };
=20
@@ -341,7 +341,7 @@ static int collect_config(const char *key_, const char =
*value_,
 		return 0;
 	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
 		return 0;
-	if (fixed_value && strcmp(value_pattern, (value_?value_:"")))
+	if (fixed_value && strcmp(data->value_pattern, (value_?value_:"")))
 		return 0;
 	if (regexp !=3D NULL &&
 	    (data->do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, =
0)))
@@ -398,7 +398,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
 	}
=20
 	if (regex_ && (flags & CONFIG_FLAGS_FIXED_VALUE))
-		value_pattern =3D regex_;
+		data.value_pattern =3D regex_;
 	else if (regex_) {
 		if (regex_[0] =3D=3D '!') {
 			data.do_not_match =3D 1;
--=20
2.45.GIT


--+Hnl6x7+AHvxPRSP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWWMACgkQVbJhu7ck
PpSxsw/+MQset2xSMDdGJTzNGzAMGMku1qK9rM7Mj33wEGhyWM9vBD7b+q9MO0Ii
5Tbw6oVTPL5fdujPhAZlItMD1cQXsd2F0c03OLEbByhXXPxmO2Sc4xJlQcmc9Yv5
Ct7pisXia/pj1l1wH2lTqma/120jceIt6HCS+AEIroHq78nH6RXo1sdeuLP2nY7i
kPI6+JizGKx+Pm32aUB9a8Om3Jd8UI+2H3akEMMTGbZVtmCaZJvrl2KFXovcZYG1
fxFadCuo6N/mHHxbI+LTYOxOHw6/v0LGcrGxnVSMTxCb096Zdj756J5d2fs1UVpe
Dqju2/IgT2UtfWXjrIqzRpReDoXoel/qjN7p/KDbRW+HplFenqkfJbSWUp/W++yo
PSW9TALjlIz0jCA6oFPRjrzf+2jULpis24kSIrNocq4eUiVGYIxMPrJ1y4mv+38Q
E9cJ7Dg3YMUumVpTW/ONFZG6jX3XjedVd3z7VDjjv+Mx4iMKsoV03OCimC1Cddn4
ri7l+97HLrm0wk4PJpQbJ6Ovri4CYACTRU51aYUIeot3C2H5wRhM4rMBKLKGqEBG
47Eff38OqiFYnZ77KooKLLmDppl/UFVdk3fDTZ2gmoa0y6VUI3YnXRfkCcy13a2a
4T5VOueSRYqERVrzEPtR+XwGLTgMyEyUozXLZtBO7bduyWcTHpE=
=JinP
-----END PGP SIGNATURE-----

--+Hnl6x7+AHvxPRSP--
