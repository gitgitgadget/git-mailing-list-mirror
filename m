Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F0D134DE
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372479; cv=none; b=tbdXEgUR648A0UE6FhpXuPvPWioy+V9Hv/K4OQd4dUq8qJmK1Q8wp0nlXcgCIuU9+x4EEVgYJ8OF0kfV1G+t9mqynu7BbJl9a4Okse+zQposTGGMUi0e0WLhcunHwmCtfgRfTghTT8ZEwbp4fql+e1ZjqqcENoVox4Bn0nvAzaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372479; c=relaxed/simple;
	bh=LCYBPCEuIcOLsRNAv6zwSCrz3FM5VFSfpjHuU93jskQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWdwrN5OwPMfv0jj+J0VINTQ3kFXoeSH/i4K0zo9imZOomvJ6TDYaNV3esni+TOxuyJ2IMb4aPrH2B0nW93TsfPQGKduSSkIXOhAbVplURmH8yCF+PtEhhymE8L/LATyys7KyPlleVu8YZhJEZ+S37BMC2jw+4pDsV2emPRpA7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TCiRIIdj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G8fcxaH4; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TCiRIIdj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G8fcxaH4"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id BD4CF1380385;
	Mon, 29 Apr 2024 02:34:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 29 Apr 2024 02:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714372476; x=1714458876; bh=4tP9kvEHKU
	BWIkdRMPa4vtycJ6BmA1wWOTWn7xK7oRQ=; b=TCiRIIdjNsk4kdFfLIKQBKo16D
	aUuGGS7QDffyuGJxbhxFewuvcsKlwEMIEvjiYacvlvu7Ta/sy69/icoA88/RGvNO
	U2id1C+KrtLcRieNpQ3K6qlT27gKau5UW1RxF/einyoUa8G1s67ekS5J805q5E6n
	rSxXVk3gwk5uEBhQBdXzu5umdGLj8LEBSKx+5viGUC8WCjavk4g3NMSnTlT8tjp8
	V0JauTEBQFXsVQCnhOVh+yCh72S/Gtka58bwCofbrm7zZgquGg4Up9gCQoDkaUGT
	wcxhjlaFHUSdvaLpKjdX5Y9k+SyktjzIH1L8wUX23S+wtdBQGj+22JkdTf/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714372476; x=1714458876; bh=4tP9kvEHKUBWIkdRMPa4vtycJ6Bm
	A1wWOTWn7xK7oRQ=; b=G8fcxaH4oFCRFe46A5oglwe/QtZ01/D52ULYK0P+bb+z
	I++VoJqrdF7nwvz77yzPSI2O7dfxt7NvEYV8EpzdZZZY++UxuEsWYDHszwRdmjWJ
	bROoKqTCdzf3rYajcevFSorbakYkwXUhUDno+AKr1540umnXN3sbumC/kkw36gpv
	DdP6fvuMrj3PbAcNxBlvfDMmsFTDnLgStzQ7zpr1pCh8ktNJhQXkCeTixovZfKnn
	bnkwka4w2PIKakVDKAzpRvg/nRLEO2jMtppSdMmSOExm4GU27MJZ6t64uZt7ZfDv
	1dL/ZyH4HQ1NEtPDgF4kwae4KqyxBzp3FQjM/VLR9Q==
X-ME-Sender: <xms:fD8vZgIndPV4ya54BLXzexHjiHAi4cflAxvFOf7LoTPYwEXAU9j2hg>
    <xme:fD8vZgKETtfd3qpX5u81LXYHnSuRn7PsD3O3niPjZuVUcoM_JEOaff6t1_C5_-FPL
    bS58FdYBfdePX-ajA>
X-ME-Received: <xmr:fD8vZgtZQJytMReHpJbFvFJtd3cFfX5TkwS6gqN9L1Xy2e_8bKsqbaZzlEMQJfFZXxusFfUm545bYbXQxwgVvPIuDUHHaeZ4srpdgL0QVNolZ3qF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddutddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:fD8vZtY3bTwZv6N7M-moOeyz68pUeiBifr9Bo40saY-kiKBQfSUzaA>
    <xmx:fD8vZnbONiT8UlqqvCpCzZwT7UbIIHoFg5wZ6bcY1ywcd2K2EFK3GA>
    <xmx:fD8vZpCIgtKpoxHMjr_LSR8IdGgUnGd-2Og1SNvm9zYMclhsDIuvmQ>
    <xmx:fD8vZtYWox9ly0Usg576NBrA2cipl8Qi6lMrqrDMxIskZS8701awmQ>
    <xmx:fD8vZmVqFOvGOowxZMqnlUCBX7x5AUxciUcXrRnpn-PpOrR93i2lZbuW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 02:34:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0fadaa66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 06:34:16 +0000 (UTC)
Date: Mon, 29 Apr 2024 08:34:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 05/13] attr: fix BUG() when parsing attrs outside of repo
Message-ID: <8f20aec1ee046ca5d21fe4ce2b19e24869545a42.1714371422.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1714371422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h8A1ej97UDFxTkEN"
Content-Disposition: inline
In-Reply-To: <cover.1714371422.git.ps@pks.im>


--h8A1ej97UDFxTkEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If either the `--attr-source` option or the `GIT_ATTR_SOURCE` envvar are
set, then `compute_default_attr_source()` will try to look up the value
as a treeish. It is possible to hit that function while outside of a Git
repository though, for example when using `git grep --no-index`. In that
case, Git will hit a bug because we try to look up the main ref store
outside of a repository.

Handle the case gracefully and detect when we try to look up an attr
source without a repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 attr.c                |  6 ++++++
 t/t0003-attributes.sh | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/attr.c b/attr.c
index 9d911aeb31..4bd09bcb4b 100644
--- a/attr.c
+++ b/attr.c
@@ -1234,6 +1234,12 @@ static int compute_default_attr_source(struct object=
_id *attr_source)
 	if (!default_attr_source_tree_object_name)
 		return 0;
=20
+	if (!startup_info->have_repository) {
+		if (!ignore_bad_attr_tree)
+			die(_("cannot use --attr-source or GIT_ATTR_SOURCE without repo"));
+		return 0;
+	}
+
 	if (repo_get_oid_treeish(the_repository,
 				 default_attr_source_tree_object_name,
 				 attr_source)) {
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 774b52c298..3efdec54dd 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -428,6 +428,21 @@ test_expect_success 'precedence of --attr-source, GIT_=
ATTR_SOURCE, then attr.tre
 	)
 '
=20
+test_expect_success 'diff without repository with attr source' '
+	mkdir -p "$TRASH_DIRECTORY/outside/nongit" &&
+	(
+		cd "$TRASH_DIRECTORY/outside/nongit" &&
+		GIT_CEILING_DIRECTORIES=3D"$TRASH_DIRECTORY/outside" &&
+		export GIT_CEILING_DIRECTORIES &&
+		touch file &&
+		cat >expect <<-EOF &&
+		fatal: cannot use --attr-source or GIT_ATTR_SOURCE without repo
+		EOF
+		test_must_fail env GIT_ATTR_SOURCE=3DHEAD git grep --no-index foo file 2=
>err &&
+		test_cmp expect err
+	)
+'
+
 test_expect_success 'bare repository: with --source' '
 	(
 		cd bare.git &&
--=20
2.45.0-rc1


--h8A1ej97UDFxTkEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvP3gACgkQVbJhu7ck
PpTyHQ//WEq+mgyib+rlKCAR2Q9JJg17rlUCjaY1l8VjNTp9USoUwjPt/VfNezbj
+6a3ZKnXqzABUySgaGFOvdFdVkGZw34Gb4kPZtkwYYVhMqnfm1Rht4UGgC9sc+1m
4ks44to87OtOSKQT0htxVwXR3X/giQbegFRbXgw7w3lGkberiJwuiDULZQQQt7bb
t+M/UZnBwZ7xwuevxU9+ZZIX+z9PNXyMd1KkPyhJmkuZ8HcEo9Wek0NVDsdxtp1T
g46/ycCi7Qbl7baLG7Gi2HruVjT4MFp8xhYkg7kGk+FIXb/nIsU2sBz8Pk/JKfZN
tPScZXshF8kGGYub0OEIEqn5NM8chwSzRG7X/h8T7PtAGvCE9IH2LiidxtsrtALw
iuKoUYi0bTVOl4c/W4gYpl/5y6J6Pvo+ODCBfjfxuKvlnmmKvt90padxEmn8hnxl
/8/8QnETQhCecQ0H8ai4J8CxG1IWuaafXgk9E2uQSAh5mTy94M3UqLZIJdQ3GY/1
WcKglIYp0y+y7GL2ujm8sCom8oZB4EnNi+6crOWorNKhsZSFpgiyTBLMH+6Eq2vh
1iWbcP2j9LlTeBzYXTRZc9IyDL11EmfKDmZKGj6LhmIj5v4y1U7M7cqBcbrilxOI
4M7FvoZNRYeqg0dzBspAqhLV11qqhYH8iaFb2s3GJ/k+75X3HpE=
=wByY
-----END PGP SIGNATURE-----

--h8A1ej97UDFxTkEN--
