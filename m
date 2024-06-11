Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92286171070
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095331; cv=none; b=J2uF70mt7QkSWwCyTGZe5TcfRzjDhEOcWh+R2iG8QetO1qaGAiII45nJbRD5bNMribJzxLG2yCcy1jd3LCpinHSSraV9KrvPlP7tU2aFtbVXje5OofHUJ2k0rHkaiZMpJb4nm1iz0nYvNdYVwlqSvtBUHa6fmXIG+4NdnyEVPPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095331; c=relaxed/simple;
	bh=3ZEu7G5NdE1m9YBF4obp0p2aMPYVOt5h5/ZwUcLS3sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGtdr33ECvOipUx2GpkIMOHwJJiNlnc+uTQRijacTppmsx4plw85ARr/VHHnudKmEDUY3SP6C1UqEms8R4bme0ztGIfPTuZnVrHRkRC+PQpLZEEG6pnmRABQtLQ4AqmtwWSB2iyVxlQaQCnDzwRGZG+ShsDp2D2/CaXDa/zLie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ctO+8Hza; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jF0lI+zJ; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ctO+8Hza";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jF0lI+zJ"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8FBCD180007D;
	Tue, 11 Jun 2024 04:42:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 11 Jun 2024 04:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718095328; x=1718181728; bh=y1mfApt72V
	aqyIubDPQjJ/rifJHHyJ+xh15rwWyWugs=; b=ctO+8HzaxTNTzUa8dSy3LEjU+6
	p7J7b6g9GerrDuMar90+IkLfmQPH4F40fFa11BE3fntpQWTsL+vlhk+P5LSZcLEF
	xQMc099VteD1/7pro3+6tZvjzLqRaw/SJWUW4JlqJKUDb7puKfzwhb5rO+TaHqSs
	JUnB+nzagkoMC50DZHz1SFY6S2/v8WnH/izVzeBJ5VRcqEnU8rVhZ5bWkA9gH/41
	tC6gBpk4OyzGRC8A5MXYhtw9Ovcgb2OsCMOwq+e5b0e8CBPIb1ahAP4n8mlWl09E
	myzZPQEjBMpLBe//pcPXfYIXFeG731qHOLe86VI8xXZhRCU+ooOsBUU0iNCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718095328; x=1718181728; bh=y1mfApt72VaqyIubDPQjJ/rifJHH
	yJ+xh15rwWyWugs=; b=jF0lI+zJCigBu3VOWl9uOJuD6rrH6NwuTwyqwy4giCG6
	wZ6GsyVlEwoBC3AvLcggSLgsmp0l/D0mA5lXBWamAy1A3kkgEszzTSNFMA2hnncz
	jNJzVLdt/5qwzCf8elUn4RwmuFt3SswI1YpcqeG/YqFgx5RLB+t7eb+H20afuEhd
	KKb2ISg+5drEuzuD8yiD2ZgrkdDiuTUXt3JNg94CIvLvhUuqKIN6gGYZDyPRJrTR
	fc6hNlDhZ0PVmOdZKE4pk41YJMVBuFANhhsaC4jQOxnN+CLkb5oRcHoAgOqxEByg
	/7PNnpC5C8j7QFrj4fZ8No25/hag/B0J5LFLBzzpXQ==
X-ME-Sender: <xms:4A1oZrjyCEgU3istqLtk1Hfq3FWmh9c8nybIo3Pa1h6Jvs_YI-g4GA>
    <xme:4A1oZoDEdk8ONoJNL03Cal2oCbb7tB4oP6xMFGyRJvE09mSAiUMRx04lHtWro-NVN
    c4wfMmGAz1UPuZzHQ>
X-ME-Received: <xmr:4A1oZrECfafrYB5PvOcIYPLFAKmfSIoFgtva8E1bAXXjnHmxOfzL5AJTtJduBJj-H0uLGLSrLhceVpQDNG0m3Q8PK823UaoVx-gyIKdkXdIxfFEEcBV6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:4A1oZoSXtN6o3FVR9LPIELPD9md753Ukhxibq1USeyZAtCZi8j2MwA>
    <xmx:4A1oZozf-HTNHBSBPhBThmho6hYcNHdJDe1FO_mpIcSLhBkhNMkihw>
    <xmx:4A1oZu6SxWRNijyZexdI-6hKOhxEWdjmglkyIevoDZqeDommvdgFZQ>
    <xmx:4A1oZtz0JrRfRtu_PMBatIjyWdTQkRKdx3VZ2y53gXnOyaFxf4NRyA>
    <xmx:4A1oZk8oyKcaEeTeyYBeI_HiaKWLVOcbc-0LrRyLCNzatJljB0aWa7O8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 04:42:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cbd2bcb0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 08:41:56 +0000 (UTC)
Date: Tue, 11 Jun 2024 10:42:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kyle Lippincott <spectral@google.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] config: fix segfault when parsing "core.abbrev" without
 repo
Message-ID: <7ded51bbce1b23cf4110e3bf0abb7579efd4d344.1718095090.git.ps@pks.im>
References: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w9feC+VZ9OOY350U"
Content-Disposition: inline
In-Reply-To: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>


--w9feC+VZ9OOY350U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The "core.abbrev" config allows the user to specify the minimum length
when abbreviating object hashes. Next to the values "auto" and "no",
this config also accepts a concrete length that needs to be bigger or
equal to the minimum length and smaller or equal to the hash algorithm's
hex length. While the former condition is trivial, the latter depends on
the object format used by the current repository. It is thus a variable
upper boundary that may either be 40 (SHA-1) or 64 (SHA-256).

This has two major downsides. First, the user that specifies this config
must be aware of the object hashes that its repository use. If they want
to configure the value globally, then they cannot pick any value in the
range `[41, 64]` if they have any repository that uses SHA-1. If they
did, Git would error out when parsing the config.

Second, and more importantly, parsing "core.abbrev" crashes when outside
of a Git repository because we dereference `the_hash_algo` to figure out
its hex length. Starting with c8aed5e8da (repository: stop setting SHA1
as the default object hash, 2024-05-07) though, we stopped initializing
`the_hash_algo` outside of Git repositories.

Fix both of these issues by not making it an error anymore when the
given length exceeds the hash length. Instead, if we have a repository,
then we truncate the length to the maximum length of `the_hash_algo`.
Otherwise, we simply leave the abbreviated length intact and store it
as-is. This is equivalent to the logic in `parse_opt_abbrev_cb()` and is
handled just fine by `repo_find_unique_abbrev_r()`. In practice, we
should never even end up using `default_abbrev` without a repository
anyway given that abbreviating object IDs to unique prefixes requires us
to have access to an object database.

Reported-by: Kyle Lippincott <spectral@google.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c         | 7 +++++--
 t/t4202-log.sh   | 6 ++++++
 t/t5601-clone.sh | 7 +++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index abce05b774..ab2844d9e1 100644
--- a/config.c
+++ b/config.c
@@ -1460,11 +1460,14 @@ static int git_default_core_config(const char *var,=
 const char *value,
 		if (!strcasecmp(value, "auto"))
 			default_abbrev =3D -1;
 		else if (!git_parse_maybe_bool_text(value))
-			default_abbrev =3D the_hash_algo->hexsz;
+			default_abbrev =3D startup_info->have_repository ?
+				the_hash_algo->hexsz : GIT_MAX_HEXSZ;
 		else {
 			int abbrev =3D git_config_int(var, value, ctx->kvi);
-			if (abbrev < minimum_abbrev || abbrev > the_hash_algo->hexsz)
+			if (abbrev < minimum_abbrev)
 				return error(_("abbrev length out of range: %d"), abbrev);
+			else if (startup_info->have_repository && abbrev > the_hash_algo->hexsz)
+				abbrev =3D the_hash_algo->hexsz;
 			default_abbrev =3D abbrev;
 		}
 		return 0;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 86c695eb0a..99c063e4cd 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1237,6 +1237,12 @@ test_expect_success 'log.abbrevCommit configuration'=
 '
 	test_cmp expect.whatchanged.full actual
 '
=20
+test_expect_success 'log.abbrevCommit with --abbrev=3D9000' '
+	git log --no-abbrev >expect &&
+	git log --abbrev-commit --abbrev=3D9000 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'show added path under "--follow -M"' '
 	# This tests for a regression introduced in v1.7.2-rc0~103^2~2
 	test_create_repo regression &&
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index cc0b953f14..5d7ea147f1 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -46,6 +46,13 @@ test_expect_success 'output from clone' '
 	test $(grep Clon output | wc -l) =3D 1
 '
=20
+test_expect_success 'output from clone with core.abbrev does not crash' '
+	rm -fr dst &&
+	echo "Cloning into ${SQ}dst${SQ}..." >expect &&
+	git -c core.abbrev=3D12 clone -n "file://$(pwd)/src" dst >actual 2>&1 &&
+	test_cmp expect actual
+'
+
 test_expect_success 'clone does not keep pack' '
=20
 	rm -fr dst &&
--=20
2.45.2.436.gcd77e87115.dirty


--w9feC+VZ9OOY350U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoDdoACgkQVbJhu7ck
PpSHxA/9E9sHjugAZNJoXawV6zkCYyMpLh5xdDM9tPLnF2hk3m4Dmf3gxIGoMYX1
8qC+JdxnNVm11xiK/tgkG9tJIDCs2AzT5MUsj56ks4HViT9mIFzHNnkbdPGmNGs5
kTzFj9uidjlWrEeo8ONfotfCZGL71iSNYtKJ9uYZjhx8C05GQkHgWDjGVRVLtJNF
QFNPi++tUomZ33US8t+bkiieY4i/Zu9aXqUCAdx5VtijS0r/7F38dxJ5svgfrWI5
c0TPr0nSiNU5LhT4xihG2zdIpaglPjeXLkw1r5F+ytX8YsqEOdALETyshrWpWB87
Nf0KFAIpqqv0Q+dBoClo9u9NnRAEgt/SIpWKHq9US6SAQHJUTHx27koDryGy8+0k
hMx+ir/zHnlCe9k74plXciqCC3dzqdZaqyCuJBk1GJFRMr4JwXPuGaqUOQ3AYBdD
aAhU4j65SdV7E0ho58Tub0kbgLVcfLmCqZY9BlU8xOWrQMuLV1JrFrsDZUf+GtMz
oNuM2CnG0dI4hoR8INO6isnviGXzcygrr83NVzY7ZHUIiQ6+sPzze6L6CQGW/9/N
/zk6LBNGmbbGRIsKnnsTD6+Blqi/d7CAxmix/WwSpDKBDDxFH3i71DX9EpmtlC10
HFEqnBvgKsbwENCNJlYfFaRKvJm9yaK4X6qMYVp8fell0JSKhsM=
=let3
-----END PGP SIGNATURE-----

--w9feC+VZ9OOY350U--
