Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE85B1BF305
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934845; cv=none; b=I+q48Gax50zRnjif63ril7fQf0antJn8opXdw3atF4ek4Q2lCbt0Zac0GxJlsKbn5CeVHFJ1ND/PR3W4h9hkZUt7bOWzv7zbxu9UX3r1IZaRAvPkvG6StxaZM5cQVaNMdw+7G4FIyu7eGciSX/hCK5zQuMEY2Y/YbWhhfK1GRYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934845; c=relaxed/simple;
	bh=ak2R/qyznL2jU9m543xsmPd9GUWv0m8JbKoezK1ueqk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujBal5s9OI0PqLhU7M7qF/Gmo5fVB5qVGSg2VVjl8QWrItYQg07EfoSEWOmf0t1a68OYTByGqrfgJEH2hHe/2Lxm5E03NVO+BexOLTe4di5/MxDalahyuSMzdYOnqC3QXLQ/AecA2sZ/6ocGJ4h38Py/meNfTAyvqrlxvnd1NSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RxdvvHHH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WRp5QnHF; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RxdvvHHH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WRp5QnHF"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id 294AF138FCB9
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:00:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Tue, 06 Aug 2024 05:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934843; x=1723021243; bh=QNJ1ZBJn8v
	n+qGL9nXmsoWfnYR49HOpLLRz1pw5XMfs=; b=RxdvvHHH+T7/iIfUmLGACjVv7w
	b4qyQgcwohJR06SqJG3WGWhxSLA7VQh3qskX8Y0/DxsEZVBZoLj46ZYsPLCteVfp
	61KZrxtFU6/Bb4oMpvz5RIh6SPmhbb6ZwFcvY4aIU1LvWr7prh8Qw4HcNcV5X73Q
	WC6GtmUCit6GJyKhfbT1xszlO0pek94SzBuHQWatrB3hkyJ+DyBeppLLyakFwGEK
	MVUnnhXM+lYKKexkgQKZpYSFRZW/82ky04OR8YXw0b42GDqPfMPq/Ysm50IQK737
	u7wZj93fQIhz/sGr21d0x47arc7ykIP+DVpcWwZ7TUFBYjRgKq7teQEsQv4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934843; x=1723021243; bh=QNJ1ZBJn8vn+qGL9nXmsoWfnYR49
	HOpLLRz1pw5XMfs=; b=WRp5QnHFRZ99b6fJ0V7CtEfytjZA7mKgF80cN+hK+Vlz
	uF/AvK0aeY4VntgC0fGZjCpS7j/YBWJFCKahtyCc24iBGkbSOSYJg/FgIlBnxiKF
	Bo7iSk+ybDP8LfO2p7xJKrXgvyMdKZ03fR42iZcqViB+OzW4Z6E5BCHj1rApySRa
	MhJPmf4cz4BknhTM8DlRvbC06qkIySktb767J6pM5fVYJbQB0semj0iqYH7uF4Ha
	oZZBb8ahmsAqSYgeRK7dXeDsYTwtQr88o1SPtc4NdPvtRTHvOqCBKTzpqHFtgJxe
	rC+EyAImwhJ/0B7FYZRgFumK+geXz3psOdYPvzCJVQ==
X-ME-Sender: <xms:OuaxZp-6WWr3U3YQfcZSqPU3S8glTPyL3ulVyMRVOz23Ug_Y639rcQ>
    <xme:OuaxZttraRpciT7XO9UQgeRYzS1C-ZHOGbwHr8vqVsb6oudYJ5rVOzDHWP9QJc3ZR
    z886Ozzy5feU77s6w>
X-ME-Received: <xmr:OuaxZnAGDkVgF1PbSSzzMYW15k98KGedAbJyxpyvH_zle0_roYva1wXVlQn8RTtatQx00H_WIjEKao3qtj8V3PhTs2c8XJLz1IuKyzo2sPDc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:O-axZtfJ5FSTbEkYk6oVxExzNyldsNGlFJ4WP7IpDjfbJC1eBsX1qw>
    <xmx:O-axZuPeOHORXRrnGkaV4qSftmIlFTr4o4BpAKk4WFU8Wxo7vMG6kw>
    <xmx:O-axZvl0oftIQ4ggyIVV1xRtUX6_ea0p-WXIR8Dy-U1ANt5LP-xp5g>
    <xmx:O-axZosVAGkoLjPJ2CnRhkcVZDg7qH9AZPnk0fA1aGaRb7Ob2zQtwg>
    <xmx:O-axZg2ZRNvuqX44feNXgR58Xdud7FTsymzAOjphpCEHpalewzA5m7-I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 05:00:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 72718d15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 09:00:40 +0000 (UTC)
Date: Tue, 6 Aug 2024 11:00:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 14/22] merge-ort: unconditionally release attributes index
Message-ID: <b12015b3c309b177b6a14bc519561daabb321a72.1722933642.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BA4+ZTOkoEAKAp65"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--BA4+ZTOkoEAKAp65
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We conditionally release the index used for reading gitattributes in
merge-ort based on whether or the index has been populated. This check
uses `cache_nr` as a condition. This isn't sufficient though, as the
variable may be zero even when some other parts of the index have been
populated. This leads to memory leaks when sparse checkouts are in use,
as we may not end up releasing the sparse checkout patterns.

Fix this issue by unconditionally releasing the index.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 merge-ort.c                       | 3 +--
 t/t3507-cherry-pick-conflict.sh   | 1 +
 t/t6421-merge-partial-clone.sh    | 1 +
 t/t6428-merge-conflicts-sparse.sh | 1 +
 t/t7817-grep-sparse-checkout.sh   | 1 +
 5 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index e9d01ac7f7..3752c7e595 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -689,8 +689,7 @@ static void clear_or_reinit_internal_opts(struct merge_=
options_internal *opti,
 	 */
 	strmap_clear_func(&opti->conflicted, 0);
=20
-	if (opti->attr_index.cache_nr) /* true iff opt->renormalize */
-		discard_index(&opti->attr_index);
+	discard_index(&opti->attr_index);
=20
 	/* Free memory used by various renames maps */
 	for (i =3D MERGE_SIDE1; i <=3D MERGE_SIDE2; ++i) {
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict=
=2Esh
index f3947b400a..10e9c91dbb 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -13,6 +13,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
 TEST_CREATE_REPO_NO_TEMPLATE=3D1
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 pristine_detach () {
diff --git a/t/t6421-merge-partial-clone.sh b/t/t6421-merge-partial-clone.sh
index 711b709e75..020375c805 100755
--- a/t/t6421-merge-partial-clone.sh
+++ b/t/t6421-merge-partial-clone.sh
@@ -26,6 +26,7 @@ test_description=3D"limiting blob downloads when merging =
with partial clones"
 #                     underscore notation is to differentiate different
 #                     files that might be renamed into each other's paths.)
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
=20
diff --git a/t/t6428-merge-conflicts-sparse.sh b/t/t6428-merge-conflicts-sp=
arse.sh
index 9919c3fa7c..8a79bc2e92 100755
--- a/t/t6428-merge-conflicts-sparse.sh
+++ b/t/t6428-merge-conflicts-sparse.sh
@@ -22,6 +22,7 @@ test_description=3D"merge cases"
 #                     underscore notation is to differentiate different
 #                     files that might be renamed into each other's paths.)
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
=20
diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout=
=2Esh
index eb59564565..0ba7817fb7 100755
--- a/t/t7817-grep-sparse-checkout.sh
+++ b/t/t7817-grep-sparse-checkout.sh
@@ -33,6 +33,7 @@ should leave the following structure in the working tree:
 But note that sub2 should have the SKIP_WORKTREE bit set.
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.46.0.dirty


--BA4+ZTOkoEAKAp65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5jcACgkQVbJhu7ck
PpTHaQ/+JrwBmBLyyJdq+FjHvFyz8EEkowyJXpI7Fj1yeZFl3pFakLX3E2vKyjQi
fIHq9KCV4mDp7+MrMccO2wH015vnSH7IlHa04FCNoV9Vts9wWJvK6atvHxqYPSiG
9VOPrNIqttAoapx9RkXcWEZZVG1qdmGeS9sIv5djOIsfjQLtJ3sSYA6QMR7Bs8TA
HcSLiY60VoFAT7ZxztjHRNZxf4eotkhHWuohHLReSwAdZrG0cNzxbTd4oMqHg/t+
omRg8eECjMFuTi2j/LeY7jgkwLkURqjfinQXf58ItNJ/Cf8wfNgx9DUfZQaeBkBW
BXHiBNcf5D58gdEo3E3ZXZHGK7BUEre9P6qtkSImiF2hyOai32KlDSMIQJYSwssF
TRBKz5VHlbIOpi2KFeRcl75P7vKamf4IReaMD4BgDyp3MjlbqO+u+0KpEbYcJI7i
QyRPcsZnWmZGw7uYtnOc+EXMfC8kNa+7jU1Ow+qcbUVM14jjFiYDZXJyDRQ/WK15
oSX6k/an7SKvhHltApm2arPyTvphxTJak7sTtAqOE86Iumb2WTiwECNunW8gYgg/
lxLfKPn4TBELEVaeT/buyJLhZJWwJt/iGCdx5oE/BIhPRi8huaqb89U46bqJMyGw
G47JsBNiqWRkI4AwkGBmVD9/cLa2wTYlK7HMuunpsEf0N0er3tg=
=gZVj
-----END PGP SIGNATURE-----

--BA4+ZTOkoEAKAp65--
