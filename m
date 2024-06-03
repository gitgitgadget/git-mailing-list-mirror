Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7587FBA3
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408095; cv=none; b=jcYvsDfTeGfgIQ3EBMO664/QJhCqLeoCdMpDf3pfMUbVsxojaV7DNHeNCcq//YDUO2WtbqL88eNq4fjRwO8GnOF9RhOhbkBWWcy9ngios3vh2LcAF2g8kAc9GQfStvBHvFNWn8AyySEA50WYKSWeY9wxE7W3CbEr/vd5zgZ3kOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408095; c=relaxed/simple;
	bh=3GOwOs6FoibbIM27seXLEmoESPd5wbmyTEW4Tq/Da+E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4q9ObA3foamfojgjZJ2GV852lZTWw7HLvxXfFjNClkLaoZsSjGxfnSiJo5I3oJIObGBcRRNCbKHX/2VixgmrkOyDT7O/WqQZKMNFk6RKtT98iwLuTw6g5ckfNMG7xAijR5exCkXeI989vH/VBJN6TF5u7ufd6kUWPKlwps8SDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QqcHt9RS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bpkacHzJ; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QqcHt9RS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bpkacHzJ"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id A94ED1800083
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:48:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Jun 2024 05:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408093; x=1717494493; bh=vMmiBb+TU9
	B7ebpTsckjgdVqOfdo7oJZjf8xsLuY9xY=; b=QqcHt9RS2/IRe60yiv4qaht4b2
	r9dD4nv6SxqV9ANzgdg9R5RwqGxdiWuWrrHjfIy2N7YPP6aSyGdyGxG0CxV0bWAb
	h6lGyJpSvg2t8x1GymdafX0g8Q7pNtj2dYV5jnSEwu/FS1SiwDixMwtQY0jPErPF
	2PsyH+G0ZZvPe5UiqcEFJpufxj2cqbjU1fCqU7zOd72+cXqXQuSto4ZX70Ud41op
	Pf6NSddSCvOg+2BX8tBRJ/MaHw/5nUxrPDxrujCBEw7OqPAwdLUZy7agf4QPo1qM
	w+PwtE370ghpMQ6zdwpmVxauC2tXPt+O5V33vaH10EfOjXNQ3ngobuh1msjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408093; x=1717494493; bh=vMmiBb+TU9B7ebpTsckjgdVqOfdo
	7oJZjf8xsLuY9xY=; b=bpkacHzJiMurCMxwJ8KC/V39SlENxJyXtaguSBTaiSO+
	h6fAIl5gSACj+rWJtKmCFClbgztx0lGFL7jvSRub4bGj0/1GsZhy6160WnhzimVF
	6k6yqt4l/xiqWVTL8Mr2m3A2Zp+ZQ3G8oGp2mshL9eczXruD/e3/A5c475qjfgw9
	aL9kpM0sVVpm5N4rspEMDSyxyKXc+NCTJvkYEkjFikza0IzKtGH0TotO0kEG6zMM
	pBDRhLnV7k9Nw4lXEVbBSrTTw+lIgo4+r6pI38Wq1X7jmlnY313kwTrAJccdA2fR
	kruRDF3uxDj9gOmiNCvE7KHN3XM2Ybmjo62PTQUdMA==
X-ME-Sender: <xms:XZFdZg8dSmDj77t475_oqbzD4sTiNmvjhRv9EqPyFd_j5owlWuqeKA>
    <xme:XZFdZov1c6nTFxRSNEpD99ld8Vt_3iRBWwvShFKVyo8rIsh22O_OzqtqHcJP-ZF6V
    Fs3InsH8I3VWtMSiA>
X-ME-Received: <xmr:XZFdZmDGfjINN3le8GlF4yY6fjxljQKUSt7khLFaowAUsc7Q26PS9_0NYijQ-BTNLLo-KNOQtTFVYTEc8eX07eH4FSqy-50ovvxiwsNpnr4cxnpU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepgeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:XZFdZgcjmMs3RX-rVK0qGss_4VM-DtPiZabQiFMq3jyzP9wzsWox-g>
    <xmx:XZFdZlP49vf0IwPHqjyUzGPQUFEPcEYXJL5FK_k7hGyr4wLJ1IfNVA>
    <xmx:XZFdZqnprN5JH0HE2gWwWB3IxQHooJEDmvjZrhpyZyPwtxg0n8M5Nw>
    <xmx:XZFdZnvk9pHbzbKnCldajS1ElLtscWgNa3og6L0U8KtxgKJEdOImdA>
    <xmx:XZFdZj3ot0CxNpaXPx3t-LBoTGiyeFvX3WbQJDLm7RcM_EzmthDqn8wz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:48:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 21024b39 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:47:48 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:48:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 22/29] builtin/clone: plug leaking HEAD ref in
 `wanted_peer_refs()`
Message-ID: <4f4ae5ea96e023e264322a7adf1f1080b478a1e2.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bbUdeqoBsuseegU4"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--bbUdeqoBsuseegU4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `wanted_peer_refs()` we first create a copy of the "HEAD" ref. This
copy may not actually be passed back to the caller, but is not getting
freed in this case. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c          | 3 ++-
 t/t5300-pack-object.sh   | 4 ++--
 t/t5305-include-tag.sh   | 1 +
 t/t5612-clone-refspec.sh | 1 +
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 730b3efae6..ae9863ed47 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -530,7 +530,8 @@ static struct ref *wanted_peer_refs(const struct ref *r=
efs,
 		if (!option_branch)
 			remote_head =3D guess_remote_head(head, refs, 0);
 		else {
-			local_refs =3D NULL;
+			free_one_ref(head);
+			local_refs =3D head =3D NULL;
 			tail =3D &local_refs;
 			remote_head =3D copy_ref(find_remote_branch(refs, option_branch));
 		}
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 61e2be2903..4ad023c846 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -3,9 +3,9 @@
 # Copyright (c) 2005 Junio C Hamano
 #
=20
-test_description=3D'git pack-object
+test_description=3D'git pack-object'
=20
-'
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
diff --git a/t/t5305-include-tag.sh b/t/t5305-include-tag.sh
index 44bd9ef45f..dc8fe55c82 100755
--- a/t/t5305-include-tag.sh
+++ b/t/t5305-include-tag.sh
@@ -4,6 +4,7 @@ test_description=3D'git pack-object --include-tag'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 TRASH=3D$(pwd)
diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index 3126cfd7e9..72762de977 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -4,6 +4,7 @@ test_description=3D'test refspec written by clone-command'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.45.1.410.g58bac47f8e.dirty


--bbUdeqoBsuseegU4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkVkACgkQVbJhu7ck
PpTdEw/+N8Nws2xdIimteXJoc1h4k2wVLI/YS/p5NzhY2FX/W6CpPsIGl9vl8J4H
MGCueXjRgTXGCu6+kOql/Lv+Lxjrk8KRurJp+uNPmXfuRDfWSnA3YhIAoO22AhZk
wU+/+A9+hkT1Cfv6t7YnAWomemFSVcq7vxNsS3AT5n531KSfSSylGh1hefIuHHBe
lm0nYzc7pb8V4ZO1JbZW8jNrgOThxNZFXGrKSMn+WR2Px03WRc+rIyLnHMI3q8/s
YHSwUPbkJ9I+3obbIrBw+J0+ALbtbuSmzclm6L8Yu6j9aONMNjFdRTfuh+XjJfDY
9jcyrtVksCRVcZ6v2RCNksfX9XhFbN0wxJuCHIrLiMRmibSAM2VARb17gcqgdap1
gehrVfVtE1UcObeGmI/fCj+Bs5/9hLIIonZVGNzq92JDnXLuK11mKlEtPakTLC/b
fwO9pR3f8iCtVyRnbbmDp4OU9TsWF64H2ydEVEfRXRQ0ZZ12tzYK94bIIL8A6qUD
GJ3ZHpcptDIudUoOVWuFFMcDLN8OTuHqCXfszE07W7m1dbxKUPJubZSZQpuhEvt5
W836rGrOkTZCU4fdAlOxnJ8R5Q76d9JwitfBTJYdNn2cDMYnfonB5uvoNht4HTDw
V4dFh7R0GGLg5KAdIVuylQtAQsvuOMApkqMfGGohlY+87QqM28Q=
=z8bj
-----END PGP SIGNATURE-----

--bbUdeqoBsuseegU4--
