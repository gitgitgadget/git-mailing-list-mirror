Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DA94DA00
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509406; cv=none; b=BTHaY14G9mVNCn3lPZD+/5HqfsGkGq7KxgKQHQDEel/99OhgIGoGncCzeDixcbiCI9BUa/gwyAIo76KnRQ5IhysFzUo66KgQLNnFyuHfpkpgqwGCjBjoCFThjDKUVpGTv5iP4Zc4y/SfrzW/gQE/GxKx6dTB/r7qTa8ofzx0abc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509406; c=relaxed/simple;
	bh=uyXHDKGg8uSihdM3Ef62Q+R8rBSb+i6/T7fp9kpv0uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfmBLr8pwxL6xzKvbaGf757Amd2RvxcBkjrk/R8djqkBi2+nqj/M1fwWsORv1ynDVEcsUlLB/4exWAtIVJCHPIHjdNt2sFOmB4kXFeVz+TB4tM1CwKruNX8zvYVruqOJo+jbTKrKOxhTmm3XZx4wyExasfQuFel0o7P/J2ttFUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EztQ6pPf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q2/tujoQ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EztQ6pPf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q2/tujoQ"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C6F1411400C4;
	Wed, 21 Feb 2024 04:56:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 21 Feb 2024 04:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708509403; x=1708595803; bh=Oxs1QW0C2h
	14dEbCMFWqNdLi8ExBe1E+d/JcqAbnaZg=; b=EztQ6pPfz6GD7lfx90LLffs87n
	8QwkWeIa5q39CC5HPlaucDtM3mgVlKFBVG9B4k6BqjJ0HkHU7SFGfgVJ9WLD/4wy
	PMLx7rxM5oVQt2RTAXLKipdBUqU6dCcxQ6KwT28shpoHtzmox6/boZQRgiTAoYiP
	0u/D25ewrANxmf0Uu9mEz9qCqrAh9aWveIL8s4bCpeZW3T4sw7LJwY19Fk6UO8kf
	OvyHd+hTweBGo8rTQ+R6dyI3ypyewNwc3ov9ntlnwwHXEMJfwAaCDcaa9vMeo+6O
	8gWMgYxAW42XZGcQ/W5JE9SkjTcWxBo/JoN+GBEfhZqLrRncLyA3pYuJsghA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708509403; x=1708595803; bh=Oxs1QW0C2h14dEbCMFWqNdLi8ExB
	e1E+d/JcqAbnaZg=; b=Q2/tujoQBh2in3bv4j47IthbFty8x/EdLqa6X2K24KGp
	/CJ6eaKqdi8z5zZb7TxmjCOrjeLFjJWs4PxgzZKLF6HaoGS8u2SY3is+cSOVFHDk
	g+skjH0d+b1cl7qADLsiVaEcEoHvGQw4Q1En/h8KVxqXfyXuqMWTR+3WfJXSSsc2
	2TW81YvBGf6vDZueT79Gaidh30p9D7VtFqDhvCXS2AjIVBdlAQHZOqY6Lp9A+19w
	q014395Sx6kRubypgWaUrYwmGCbgQmrYHZYKyLF6zbs7Ngx1mcXKLcDe/mVwlyuZ
	ZJJTHHDAD/F1AYscZ4QVRcrrj6IRlGfWd+0c1ULfUw==
X-ME-Sender: <xms:28jVZYb9VpxoXT0vz8v0i3zpzvXc_hoqw-JArbC21ij07BXaDigY1g>
    <xme:28jVZTZyTuzZaMtrUt3LrInm-eecxL903TqTAuDT3YC7YEaIVHjHkc-OetIY3FeWp
    kv6F5I2dBQtOd-dGg>
X-ME-Received: <xmr:28jVZS99Ky1SMiyfL1PFTz4I7EAmJZit6oOxjQ6NYUqpxvJDoQ6gzUHHLKLO8KjrNTnR7cxhicxhRchKIPzVbMqlM-39s9vo0KHBsB-XanMH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:28jVZSrzM7xKlEYDpePNXGwKH_B9ELJUXBK8neeJXBoRSkKeYgtwiQ>
    <xmx:28jVZToJkqF16Cm32vs5gAsh8-yEkTYo2FuLjx8Tn18Fl7EAq1ZRpg>
    <xmx:28jVZQSm1k3KfQL6TgqBZPW7sfkmGV0g4ObbHHze2JWLHzwtYSZFZA>
    <xmx:28jVZa1Du59hav9SmCCACVuht4FIwkAc5AFNJcdlnvINqyVFtG1bUg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 04:56:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 38f7da90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 09:52:38 +0000 (UTC)
Date: Wed, 21 Feb 2024 10:56:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Yasushi SHOJI <yasushi.shoji@gmail.com>
Subject: [PATCH 2/2] builtin/show-branch: detect empty reflogs
Message-ID: <6107efeffa3a9e87ed95f4fe592d9b480887c510.1708509190.git.ps@pks.im>
References: <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>
 <cover.1708509190.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1g3Jih2Ele67T/VU"
Content-Disposition: inline
In-Reply-To: <cover.1708509190.git.ps@pks.im>


--1g3Jih2Ele67T/VU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `--reflog=3Dn` option for git-show-branch(1) allows the user to list
the reflog of a specific branch, where `n` specifies how many reflog
entries to show. When there are less than `n` entries we handle this
gracefully and simply report less entries.

There is a special case though when the ref either has no reflog or when
its reflog is empty. In this case, we end up printing nothing at all
while returning successfully. This is rather confusing as there is no
indicator why we didn't print anything.

Adapt the behaviour so that we die instead of leaving no user visible
traces. This change in behaviour should be fine given that this case
used to segfault before the preceding commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-branch.c  |  2 ++
 t/t3202-show-branch.sh | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index b01ec761d2..8837415031 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -785,6 +785,8 @@ int cmd_show_branch(int ac, const char **av, const char=
 *prefix)
 			if (read_ref_at(get_main_ref_store(the_repository),
 					ref, flags, 0, base + i, &oid, &logmsg,
 					&timestamp, &tz, NULL)) {
+				if (!i)
+					die(_("log for %s is empty"), ref);
 				reflog =3D i;
 				break;
 			}
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index 6a98b2df76..e5b74cc55f 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -264,4 +264,29 @@ test_expect_success 'error descriptions on orphan bran=
ch' '
 	test_branch_op_in_wt -c new-branch
 '
=20
+test_expect_success 'show-branch --reflog with empty reflog' '
+	git checkout -B empty-reflog &&
+	git reflog expire --expire=3Dnow refs/heads/empty-reflog &&
+
+	cat >expect <<-EOF &&
+	fatal: log for refs/heads/empty-reflog is empty
+	EOF
+	test_must_fail git show-branch --reflog=3D1 empty-reflog 2>err &&
+	test_cmp expect err &&
+	test_must_fail git show-branch --reflog empty-reflog 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success 'show-branch --reflog with missing reflog' '
+	git -c core.logAllRefUpdates=3Dfalse checkout -B missing-reflog &&
+
+	cat >expect <<-EOF &&
+	fatal: log for refs/heads/missing-reflog is empty
+	EOF
+	test_must_fail git show-branch --reflog=3D1 missing-reflog 2>err &&
+	test_cmp expect err &&
+	test_must_fail git show-branch --reflog missing-reflog 2>err &&
+	test_cmp expect err
+'
+
 test_done
--=20
2.44.0-rc1


--1g3Jih2Ele67T/VU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXVyNcACgkQVbJhu7ck
PpQ9yRAAgXlHKrWuF4HhbY52feWwLg/eOxJ0aIN6duUU/UsF8J5sPQcRcOwGTvEa
1SkxOyb0iiLDpChMDw+CX1BJhRUBWsJj9jzB8yJvLeXnHYMTJylZ4YPQC8cXNBz+
sxa/P4igrxHMs6pLSxb8KjXIdjvDSD8Zq1H2tKLt22GGbWhqbpNAJSnOHpsYHSup
Z2hkghAQt77xwWfepQgQxAeTqUGu9gTYxLLZsfQCq99yfKAu4Osi+uB9digdriev
8sX8capdEoJYyP0XyWb8vpYUsGWLjeNoX93ABZq2BRPWGBXz50hYx3oXN3u0nePg
cfroyKws6zOGUDp2L8QUqx0n5Z3ilG13L2Xcj0d1YlHki8zkgFwtZ840ZkQx4ImR
rZ3zJrqo2cjC1Fa8+AeU/qr+8xRqwjeDNM7Pw29+Y+6gIfvaAiCh+OLF3GILWYPh
68m3nlwP8Oo+akTw6F2zjhW+EWrq01zHK4fPYgjFQieZxMbriD3Urczzt9ypxL3f
h5vfdRkuyqik4Am52fWEKPHZfWaZFCV0K1+DrilKuFbKVWE5yGjbz9x0YhX6dzMJ
V0RGB6aW2Z3fd3smJKwnVJNEfOUp11/XQ82INL6OIOwn8Aw1173FORkHKa/AxqvF
8rzuiK1q4tTfGDmLm8kOZsFrwRIh29FnuxBiTEQCNg0kLMXHrFQ=
=Bae9
-----END PGP SIGNATURE-----

--1g3Jih2Ele67T/VU--
