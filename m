Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0344A84A54
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408121; cv=none; b=KOh11geQqyOFwrUB7oIOkB14oMaJHrVFpFqYCCyir+jr/Lo2v9uVfz1EPEHDAlDpBYJuiheH9V1ZSxoVcF6uiXnxsIPTSPBCai9EpWnfp4fErjC0UpUH9ai1oIYMhpFzH6QfWAHmY6QveZaGJ6gm/AVQ2c73UJnf6qTFhjOfgJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408121; c=relaxed/simple;
	bh=gkZWYEEuOhsdV7wiLEwYkJu1tZ1t5p3mwPcG8GXAWIo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kc8kc5GZTXD+LXnAq9qPFhH9fHIi0V6H+NjjJ12rZU8HtiaIeqtG+gtns2iU0VdTj0zZ9OFy5WY+egslrbZK1CacBrCtZVy+cLlsf8vmnvnjGrsycqD+6DKAfpZVQWj4nGhJCW6jhhn1kDcejDhKLpPJJ2Y7bgTo+arhfZ6qftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mH+C68jF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bJmY5GQQ; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mH+C68jF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bJmY5GQQ"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 3960C1C000EF
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:48:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Jun 2024 05:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408118; x=1717494518; bh=Av6sjyD0Wl
	l8OEnSDLNMLG+L8j+mwZtNZTwlnpcHl1A=; b=mH+C68jF6oAfEvJ33m5aF7qPMe
	6dfh/dmg+y84HDCkUQu/bwGNWka9XCS2qq6OteuBRrDoW80XOYgDFi4Kt7H5xGgu
	iyQLqfQ+m/AXJbZMF0fbCGpRvjVGBXRv6jpypf8UEyVHV9R6xUi6d7RHMoCZPVRW
	ikiy2cVBFgOT7S7SXkRwsmDfY/QLHq3/568DIlOaVVtxF41J2hDfWglqZUjxHyPq
	F4n9cX8KCYfznNGiAkaJz9YluL8F4tEMRZ/0uB4UrEdmWEFf+PXyF0lbkQRKCQAX
	qdreYiZPpHux1E2zCoRLiRHP8ZpYpDQeQJFd1l37fEGD3OhlWqw/TCst1rqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408118; x=1717494518; bh=Av6sjyD0Wll8OEnSDLNMLG+L8j+m
	wZtNZTwlnpcHl1A=; b=bJmY5GQQEf9hjGfe03t2eaU++GhqZxEKhTAd09fteCKu
	DuGpWSNvu3kaA0J3BXepEairwsvFRptdonKNtSAGBFjqCIBfi+iQ7jgNBfTJadO/
	fTEf9VqZcUb7js/BGC6FSo0v7w95KSPBp9DqbDCkCvapSuHJ1P5blVR08p5x0YgH
	Gvy0FtpLWsj5VbI4a6P6yUoQBdnwnyu63caLo8norvTEGHGLbHDAfQMxNk69oy/Y
	Fhuyy6vD1xl+WEl0wBUphhX9sP2BoeBHtJN8DOSOGdN0eeQCpw4cY5c88D9TzO/j
	vRrr9BOb7zVduFXB53/UlfFCxUcvoLiK89793RVaFQ==
X-ME-Sender: <xms:dpFdZmw91KCpMpcjV3_EByPwndwN7DRLCc2VZEwbIgvqnK7li-oUbg>
    <xme:dpFdZiRLE7mZ9HeA2TNL0s4LxXsr6lIs8NLzpDO754SOdx1LDfx_Oy9lo61PH1KeT
    GmlQJSHaB8RF5nJhw>
X-ME-Received: <xmr:dpFdZoWuSZfqlfsZSuJJS4Rmf-x3JlkPaPlXUHe1dr_WWXFG-NXwTYRirHPeGRYSjVXtc4Q24fPRqXtmAikt85rvGlqRkELzvyYAGBQnrjkLpEOC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepheenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:dpFdZsg4qhqrf9dlNamto6zbEpfAk4xqsSYwyr9E1B2CT6orEdgLcQ>
    <xmx:dpFdZoChIU7OJ8MALg20rGgDVjeQVPdG-bUYomEUh4GI0cStthcmlw>
    <xmx:dpFdZtJfUd5voOJSG_n4jwUETIPRU7018emfm5e42pTzizfHW_oi1Q>
    <xmx:dpFdZvAJ8qh1yYjOmRD89BGbOenVuy3ZSES1OM0ojkHPxbLT4ifkeA>
    <xmx:dpFdZh6VdLEfpF2JiMPDV60xmK6KWnflWiUAk58ftgZ_GU1AI0ZZo_MH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:48:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d1bf7408 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:48:13 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:48:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 27/29] blame: fix leaking data for blame scoreboards
Message-ID: <5f2b0adc5621f741442ff41a916caf9e1424afbf.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sTShn8pSrY/QinbL"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--sTShn8pSrY/QinbL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are some memory leaks when cleaning up blame scoreboards. Fix
those.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 blame.c                           | 4 ++++
 t/t4061-diff-indent.sh            | 1 +
 t/t8002-blame.sh                  | 1 +
 t/t8004-blame-with-conflicts.sh   | 1 +
 t/t8006-blame-textconv.sh         | 2 ++
 t/t8009-blame-vs-topicbranches.sh | 2 ++
 t/t8011-blame-split-file.sh       | 2 ++
 t/t8012-blame-colors.sh           | 1 +
 t/t8014-blame-ignore-fuzzy.sh     | 2 ++
 9 files changed, 16 insertions(+)

diff --git a/blame.c b/blame.c
index 33586b9777..f97d0e9e1a 100644
--- a/blame.c
+++ b/blame.c
@@ -2928,6 +2928,10 @@ void setup_blame_bloom_data(struct blame_scoreboard =
*sb)
=20
 void cleanup_scoreboard(struct blame_scoreboard *sb)
 {
+	free(sb->lineno);
+	clear_prio_queue(&sb->commits);
+	oidset_clear(&sb->ignore_list);
+
 	if (sb->bloom_data) {
 		int i;
 		for (i =3D 0; i < sb->bloom_data->nr; i++) {
diff --git a/t/t4061-diff-indent.sh b/t/t4061-diff-indent.sh
index 7750b87ca1..2942e5d9b9 100755
--- a/t/t4061-diff-indent.sh
+++ b/t/t4061-diff-indent.sh
@@ -6,6 +6,7 @@ test_description=3D'Test diff indent heuristic.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
=20
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index 0147de304b..3596634039 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -5,6 +5,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
 TEST_CREATE_REPO_NO_TEMPLATE=3D1
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 PROG=3D'git blame -c'
diff --git a/t/t8004-blame-with-conflicts.sh b/t/t8004-blame-with-conflicts=
=2Esh
index 35414a5336..2c2a0b33f9 100755
--- a/t/t8004-blame-with-conflicts.sh
+++ b/t/t8004-blame-with-conflicts.sh
@@ -6,6 +6,7 @@ test_description=3D'git blame on conflicted files'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup first case' '
diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index 7683515155..42f8be25a3 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'git blame textconv support'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 find_blame() {
diff --git a/t/t8009-blame-vs-topicbranches.sh b/t/t8009-blame-vs-topicbran=
ches.sh
index 72596e38b2..30331713b9 100755
--- a/t/t8009-blame-vs-topicbranches.sh
+++ b/t/t8009-blame-vs-topicbranches.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'blaming trough history with topic branches'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Creates the history shown below. '*'s mark the first parent in the merge=
s.
diff --git a/t/t8011-blame-split-file.sh b/t/t8011-blame-split-file.sh
index bdda0c03fe..da1801f4d2 100755
--- a/t/t8011-blame-split-file.sh
+++ b/t/t8011-blame-split-file.sh
@@ -10,6 +10,8 @@ Note that we need to use "blame -C" to find the commit fo=
r all lines. We will
 not bother testing that the non-C case fails to find it. That is how blame
 behaves now, but it is not a property we want to make sure is retained.
 '
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # help avoid typing and reading long strings of similar lines
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
index c3a5f6d01f..9a79c109f2 100755
--- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -5,6 +5,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
 TEST_CREATE_REPO_NO_TEMPLATE=3D1
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 PROG=3D'git blame -c'
diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
index 0bd0341301..933222cea1 100755
--- a/t/t8014-blame-ignore-fuzzy.sh
+++ b/t/t8014-blame-ignore-fuzzy.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'git blame ignore fuzzy heuristic'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 pick_author=3D's/^[0-9a-f^]* *(\([^ ]*\) .*/\1/'
--=20
2.45.1.410.g58bac47f8e.dirty


--sTShn8pSrY/QinbL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkXIACgkQVbJhu7ck
PpSUZQ//YSW2RseGwOTymfyhOesFf1LNedAjqHMujEf50KwN1+zlToT5JhrNyWUC
7NHtRExPoT7PurHLsTRddihjXLSFjKgOhqMHWqPALokObo+UewSY5BKHbpIjVVEx
CyTnoHHj8e7/b23d8i5+ATXbpj1vY5tEx0wmMTpYkOHVZtmZKU1EYxNQD3xiBZ/A
h2DBpuza1t7Zey0rxv/ihsTl+e970VDJuSxKZnX0NGVeYilrE3h5A0kv7vfWsl4w
EWATSErXBf5DwPDXgptWrbyATE0YlB0bh/A4vPKnb7b/IrnD3Du3xd9Fhryp1Gh8
daxZE3Gms9aprkAIVzCrJCiqNHSBDC/R96wklYIu+arUOn00wZEO6LkJ4vlDMl48
tijr8KciZM7VrX2tLbprjzowvpvVUlYHVJ8Iw2cPJq6pCOkkxREjW/u5xuVvbrzw
kw/za4nWuXrbsXodGM0g+s3/G8pOtqOygOBZ/qJdctw6BDRS1ZaSRwQuZx9MM4e4
Lp7JNuIje6RUj2KVXCmf3DxHZfqPDuA/55dTTMJq/6j1HgGO//+dYPBUGyXJ6hme
/nK0TEFK+Xis6GhIjiMRd/iK8CtTFGy7wVaDwchp5Eylx77aJyWGP/3lTYbscNLS
6b37uJE939FcATshV71MbzZvQr5XUFLfJ8G6JrCoY+XT/UUHcko=
=ITFf
-----END PGP SIGNATURE-----

--sTShn8pSrY/QinbL--
