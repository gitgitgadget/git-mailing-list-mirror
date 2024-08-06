Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01A91BE23B
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934821; cv=none; b=cdoPFsQSV7HPA5okaop9m1kTGQ6vD86gf0brX8V0kTpnEpadECuSFWoRd/3TVtaolJU7Bq02iQGDntl4m+DgCXP1jvPY0J3I6LgkdauLoT6Da9Aud8NrJnlxEx91HbWjGH4jb3DLRDWdTem00MtTk0qrDbQ8FCVeLLqtDHAx/LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934821; c=relaxed/simple;
	bh=RQRXrqpERnAif0kCcipd8LxXZj1eE1n1uzNB7UK5Eq8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4pQFhYyUvSRh5Uro9E96Tsw0U/puwjOmPUp7IwbtNaBkJ7rCAlSq+QZQ1z5ehW/kIzbVxQq9NxmDMUUqyKstToGTvtlPX+Xy86yNodx2QU06GTOLj3afC+x7wzikwuB3P1iRKbw7NM9qq1fKVeJsQUc4+jHUQ7RObOmosBRpD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ae0t0ZIo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ml466H41; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ae0t0ZIo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ml466H41"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E71141151B2B
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:00:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 06 Aug 2024 05:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934818; x=1723021218; bh=/PJWPFn/g6
	nEx0KDyCPtpwNhTmFlt4rK976wqaN6fd4=; b=Ae0t0ZIo4UKcye2mWsJYDY2SwU
	sZgANoZ98+AoOo5QTQ1+Vg9sS2J7n3KmyyKxKJwlezVQsTAU3xJdQ+SHYeOjTYzq
	E1QsnYeVpuhS+HlZEDjadUSzwkK0rpwzM9tm9ImIPXKgGDfSjhWTpqEhwXrkH2GA
	wAOY37OvK444brBjeaND0vX+NvpU3qwsvjb5AxDJeYCHI4j8Oq6qsyoFMSUZPfUu
	VRI0j3Bj1NMTT/7Ld+CbEK/M9hrS/ddZzkSgPqBB7Ar1ibAAVOTV5kvrB7By/cnr
	DoKZ3URxECOjCUFCPM6SQf47jNrx1JhzZlTWMv3Lg0b6KRbgCVCg8ewEeWIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934818; x=1723021218; bh=/PJWPFn/g6nEx0KDyCPtpwNhTmFl
	t4rK976wqaN6fd4=; b=ml466H41Iiye1w6dZwnHQC+3Vcky0xXeOsE5wd/vP+tO
	T8pu9To8kONrEWvATKIQDtp7cP5r8bY8ehNqXiMKsfjQugxREvLlmqC8n32ddM5O
	Bs/8dfW5qE//tl45qM6TLuXgxOS5yRuUoIwCgFi6YxMN73+JetImfOecL5Tgu+fy
	9fxZ7QaY8Yzh/vcTxynt5c3IjCXzZszOQaQokc21GQuLVJn51ChbhZbMAqhjjpdo
	DNMhhLaaJ9xoHA/h81fy633JMOrJj2bYbWfRmNJiH3tIu3CTw2RpeHW7OoCETThM
	0Kj9BoOwsNF2Bk4QC5b6kmyW8/VXyGBjWouGsSTyAg==
X-ME-Sender: <xms:IuaxZvv71W_uBGtrTyeb202I8H3YS005CaLyHBw7yIw3MHExZd2GuQ>
    <xme:IuaxZgfo2Ruwm4hmw1qRoYXEjUIeztRrVkocCaVT3i4di_yIIdMbN12FI7JLeWOxS
    jm_MTprsBMSr1UBng>
X-ME-Received: <xmr:IuaxZixtEpKOsDcxgpHi7Xetc1DNHdRX1cf31TnsR4fP1MJmJ9WLeVz6BqAKb0fGTqbc10D8_l3KAA-fM3nnY08NSPBrD14YyoBJmkR-aww8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:IuaxZuNvYdFf1RA2lJrz_ZWtsXWh_CVOBfGcbqBSV4iGyUH-pMoYnQ>
    <xmx:IuaxZv9ZiuzJcuYOKvvpt-A48vLV1JIMuJu39UkrOjWq7X27cpBfYA>
    <xmx:IuaxZuUHvp1kr6uWI265Urt01lCrOJWYxj1Xfhwy8dYsftxDTiRikw>
    <xmx:IuaxZgesujQBnpdsqFOfpa-CeyUinauHPNDj75Gy47iptGTA5RwxRA>
    <xmx:IuaxZpl0M8ZWfpFfwDqf50g6MkUyyClNsMQ5zbx52WuQl-SatILrrimH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 05:00:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f7cb2d13 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 09:00:16 +0000 (UTC)
Date: Tue, 6 Aug 2024 11:00:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/22] builtin/rebase: fix leaking `commit.gpgsign` value
Message-ID: <05290fc1f14cae8229c42f2d0aafe6619c069e3a.1722933642.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w/uZWw/nKb4Q+/VR"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--w/uZWw/nKb4Q+/VR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `get_replay_opts()`, we unconditionally override the `gpg_sign` field
that already got populated by `sequencer_init_config()` in case the user
has "commit.gpgsign" set in their config. It is kind of dubious whether
this is the correct thing to do or a bug. What is clear though is that
this creates a memory leak.

Let's mark this assignment with a TODO comment to figure out whether
this needs to be fixed or not. Meanwhile though, let's plug the memory
leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rebase.c              | 8 ++++++++
 sequencer.c                   | 1 +
 t/t3404-rebase-interactive.sh | 1 +
 t/t3435-rebase-gpg-sign.sh    | 1 +
 t/t7030-verify-tag.sh         | 1 +
 5 files changed, 12 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e3a8e74cfc..f65316a023 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -186,7 +186,15 @@ static struct replay_opts get_replay_opts(const struct=
 rebase_options *opts)
 	replay.committer_date_is_author_date =3D
 					opts->committer_date_is_author_date;
 	replay.ignore_date =3D opts->ignore_date;
+
+	/*
+	 * TODO: Is it really intentional that we unconditionally override
+	 * `replay.gpg_sign` even if it has already been initialized via the
+	 * configuration?
+	 */
+	free(replay.gpg_sign);
 	replay.gpg_sign =3D xstrdup_or_null(opts->gpg_sign_opt);
+
 	replay.reflog_action =3D xstrdup(opts->reflog_action);
 	if (opts->strategy)
 		replay.strategy =3D xstrdup_or_null(opts->strategy);
diff --git a/sequencer.c b/sequencer.c
index 0291920f0b..cade9b0ca8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -303,6 +303,7 @@ static int git_sequencer_config(const char *k, const ch=
ar *v,
 	}
=20
 	if (!strcmp(k, "commit.gpgsign")) {
+		free(opts->gpg_sign);
 		opts->gpg_sign =3D git_config_bool(k, v) ? xstrdup("") : NULL;
 		return 0;
 	}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f92baad138..f171af3061 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -26,6 +26,7 @@ Initial setup:
  touch file "conflict".
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
index 6aa2aeb628..6e329fea7c 100755
--- a/t/t3435-rebase-gpg-sign.sh
+++ b/t/t3435-rebase-gpg-sign.sh
@@ -8,6 +8,7 @@ test_description=3D'test rebase --[no-]gpg-sign'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-rebase.sh"
 . "$TEST_DIRECTORY/lib-gpg.sh"
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 6f526c37c2..effa826744 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -4,6 +4,7 @@ test_description=3D'signed tag tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
=20
--=20
2.46.0.dirty


--w/uZWw/nKb4Q+/VR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5h8ACgkQVbJhu7ck
PpRgPg/+I+XqN7el+a20iwYh2qrp/dRbeFX2/x37np5Ml/64LO0qk/hK0CXFxET9
RD3zeOiNb/TJWlevIlGIg6nsRtpx3Rv0AqWWk3VcA/BMjM5V6uIWcde5iYI9nZDX
w+E8W4E4hmXTWrvENeM0zkpjmapjuuYMF2qucYnzCMqKA1jeh2HPXRc/xnSF9evb
GoE6Qto9e4pPjrrWbN17KiWjBwpDEW0JmF8zP87Y8ZzhbsAN3KcvweVoyvMvjUU7
b31EHe8pBcrF2eP/ksI8SZBUfa77O7SGgqtPrQthyuSo9moXzOU+HFyYa1LsoFPf
Via2l8Xa4pVZIgeTOKCgJaE3K0LHXXlpW/KQxFW18PniUbto38j6xFx6532wxaDf
vS88vLVmKvVPgztiupVVZbJAEvSYSdM7swSDjGPeiGmRWeg9De6cqYEoBmbB5VVv
Q+entVImu+5/MbVMuMsabi8fLM7yl2QlPBeazbmE0PUKc1qteXzM4/XUg3pqFtCM
LUIrNI+NQrrFjDwKFe1l9jmO6INRV5DKTPKPfhboGpGHLixax79W9zB4qbnwKLPZ
C53+XnoLOqlfcSwHzA3cPsuFLaaKj3VtfI/l1q5xz+uDj5quo6HKyJYVW5LhJT7C
cEKgAttKh9lDjLkE+ss6Tsz2kpXM38wmvcjrxoi/WXmKH5oSnrs=
=jR7w
-----END PGP SIGNATURE-----

--w/uZWw/nKb4Q+/VR--
