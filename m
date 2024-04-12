Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA9718EA2
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 04:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897104; cv=none; b=ho0ztqZrXYztMq8JDglo/BJQCrS7zSF3I0bfpSOSHpVk6FcX9JduoivCTp3CI2h3+OBxfOM9ZmuLy7QMmt2G2/rq2B+4RFaA0ES3gSph/4rOVWyfBQcCcF0L79RRT+bzHRuVk3y5R6uMQtgreaTYwC/KIt+VEFtI17y7JkEmPTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897104; c=relaxed/simple;
	bh=lSqZf9aAteGN24eAYu57TtyLvkF99VDzp1D9yg6dPAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1qTQozfJHueN0haZ2fdYAEKo01gcPcJItAAiDQMekCHomMqp4M8IP6Zy67f3KPdKiuZgr/udBL06dhT5Q8m7nMUxp5BDIyVOEFd1flxPIjSb1N37czFsvbLeQ5whym0bmALBbMSKoiGEHURbgOOMGIoyiPomQaxmLfhEtztkeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pXu8rmcE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HQxZD0o4; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pXu8rmcE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HQxZD0o4"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7EDFC11401DA;
	Fri, 12 Apr 2024 00:45:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 12 Apr 2024 00:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712897102; x=1712983502; bh=H6+tF51ceJ
	weVHaz1C6GUTRMhy2yYczLBWou38X9bcE=; b=pXu8rmcELYTTTOjXXvwKJfLOmF
	dcS2zaaogTsoSqq8wEnB5k3iN0FJi3qKtwB8JJ3LDp9aZSMwzV4TaDXP8VY+o9Sr
	mm1537x/s+41kHLVPbJwVVjVxVwO9tGYt+Kxt1d7qjehsKRljJdj7KReBQxtIAn+
	2jPP0fGJE+a5SPV1/JtXSGrrkMBhAEEu+T9X1Z4Fs9XoWRXV5HUl3OWuud6EmDEp
	aNuFe2efQVgZywX/M4FZbusJy558eAPFJ+JAmLAhL7MlyMCHOb1uD8IDoP8CDvRK
	jggHwoCVQ+O/Vk5XxJW56btLemC+ZmBnelI4d3VCnvMwVQNOR8vrd0raTG4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712897102; x=1712983502; bh=H6+tF51ceJweVHaz1C6GUTRMhy2y
	YczLBWou38X9bcE=; b=HQxZD0o4UmvAMk/hXjYj7+3NVEp1YnSq9XiSXPK3LsWk
	SULKuoFyPIiD83dRbhxMvnX5n6K1GjK8tyc2VqGuxF2tMzZFIig8cS4jLx7dXCO1
	I7ZHjKJpDZ2ZrNVv5gf62pk0Y0xq0SkQjdpWaE5tI7wy85gOMYUyPEPq6RypzqqI
	zDA2ahAquMhGmAk6yTgrwbk6uf6FXEEr+rrwYIbLFOoq9GIVikttDzVuf63Uqnf3
	HLxpespa/2P0SD5H29P6ti6XPa02BIcdWyYoVorqHhFOuaWKNBlmjIimawiUfy0R
	j55RRNB0NhxiAx2iP8U4Z2DLSiLyvA/oqXiSmlmheA==
X-ME-Sender: <xms:TrwYZmiF7qyEvGzOUCR_pMBs03RxEEDu_jDvqxRRyaMCil3XtUauQA>
    <xme:TrwYZnBZQGF0HMWokRVuU2kDM_lP-iZxH3RrZ6Lc4evaqw5WVMRz7oRgxnxtiPEo9
    7T87JL9GhCRcqm7XA>
X-ME-Received: <xmr:TrwYZuEMYcMY7jydt7Ybs-nVx6CEGFiJnOJMfiQzmVmcc7q3FTd6U33Lochn3VMtFjrddO2mGCRx8VWn8_GCtGnTcNgM48Jqus0TU7EaIELjl9TCiKE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeitddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:TrwYZvQNNKRRiGTiCXstKeiySmTw9LopJR_DZP03R6vuzrSOThEuUg>
    <xmx:TrwYZjzt5l8t94UjgY2PlITxgAJzA2x1ydsWRPajAeofr_hNiWMqNw>
    <xmx:TrwYZt6GrYqmDTXYVc7ZItXiHsbbie0zY37lKY456jxbbeukkXsp4w>
    <xmx:TrwYZgxyUz4qVjqreewRZROnYJ14st6oPiVERYnfURUHCa8ctwFEiA>
    <xmx:TrwYZqwfM6v59xjkEJ6hXCQXLndSlm_CvJQPA0-vcs7UwWjwR5fcYLsS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 00:45:00 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d5230237 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Apr 2024 04:44:47 +0000 (UTC)
Date: Fri, 12 Apr 2024 06:44:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 13/13] t0612: add tests to exercise Git/JGit reftable
 compatibility
Message-ID: <218c694d2e1230b7b4f231e83feafc945820a26c.1712896869.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MTBP//NvGLAecIEp"
Content-Disposition: inline
In-Reply-To: <cover.1712896868.git.ps@pks.im>


--MTBP//NvGLAecIEp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While the reftable format is a recent introduction in Git, JGit already
knows to read and write reftables since 2017. Given the complexity of
the format there is a very real risk of incompatibilities between those
two implementations, which is something that we really want to avoid.

Add some basic tests that verify that reftables written by Git and JGit
can be read by the respective other implementation. For now this test
suite is rather small, only covering basic functionality. But it serves
as a good starting point and can be extended over time.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0612-reftable-jgit-compatibility.sh | 132 +++++++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100755 t/t0612-reftable-jgit-compatibility.sh

diff --git a/t/t0612-reftable-jgit-compatibility.sh b/t/t0612-reftable-jgit=
-compatibility.sh
new file mode 100755
index 0000000000..d0d7e80b49
--- /dev/null
+++ b/t/t0612-reftable-jgit-compatibility.sh
@@ -0,0 +1,132 @@
+#!/bin/sh
+
+test_description=3D'reftables are compatible with JGit'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_REF_FORMAT=3Dreftable
+export GIT_TEST_DEFAULT_REF_FORMAT
+
+# JGit does not support the 'link' DIRC extension.
+GIT_TEST_SPLIT_INDEX=3D0
+export GIT_TEST_SPLIT_INDEX
+
+. ./test-lib.sh
+
+if ! test_have_prereq JGIT
+then
+	skip_all=3D'skipping reftable JGit tests; JGit is not present in PATH'
+	test_done
+fi
+
+if ! test_have_prereq SHA1
+then
+	skip_all=3D'skipping reftable JGit tests; JGit does not support SHA256 re=
ftables'
+	test_done
+fi
+
+test_commit_jgit () {
+	touch "$1" &&
+	jgit add "$1" &&
+	jgit commit -m "$1"
+}
+
+test_same_refs () {
+	git show-ref --head >cgit.actual &&
+	jgit show-ref >jgit-tabs.actual &&
+	tr "\t" " " <jgit-tabs.actual >jgit.actual &&
+	test_cmp cgit.actual jgit.actual
+}
+
+test_same_ref () {
+	git rev-parse "$1" >cgit.actual &&
+	jgit rev-parse "$1" >jgit.actual &&
+	test_cmp cgit.actual jgit.actual
+}
+
+test_same_reflog () {
+	git reflog "$*" >cgit.actual &&
+	jgit reflog "$*" >jgit-newline.actual &&
+	sed '/^$/d' <jgit-newline.actual >jgit.actual &&
+	test_cmp cgit.actual jgit.actual
+}
+
+test_expect_success 'CGit repository can be read by JGit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_same_refs &&
+		test_same_ref HEAD &&
+		test_same_reflog HEAD
+	)
+'
+
+test_expect_success 'JGit repository can be read by CGit' '
+	test_when_finished "rm -rf repo" &&
+	jgit init repo &&
+	(
+		cd repo &&
+
+		touch file &&
+		jgit add file &&
+		jgit commit -m "initial commit" &&
+
+		# Note that we must convert the ref storage after we have
+		# written the default branch. Otherwise JGit will end up with
+		# no HEAD at all.
+		jgit convert-ref-storage --format=3Dreftable &&
+
+		test_same_refs &&
+		test_same_ref HEAD &&
+		# Interestingly, JGit cannot read its own reflog here. CGit can
+		# though.
+		printf "%s HEAD@{0}: commit (initial): initial commit" "$(git rev-parse =
--short HEAD)" >expect &&
+		git reflog HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'mixed writes from JGit and CGit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit A &&
+		test_commit_jgit B &&
+		test_commit C &&
+		test_commit_jgit D &&
+
+		test_same_refs &&
+		test_same_ref HEAD &&
+		test_same_reflog HEAD
+	)
+'
+
+test_expect_success 'JGit can read multi-level index' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit A &&
+		awk "
+		    BEGIN {
+			print \"start\";
+			for (i =3D 0; i < 10000; i++)
+			    printf \"create refs/heads/branch-%d HEAD\n\", i;
+			print \"commit\";
+		    }
+		" >input &&
+		git update-ref --stdin <input &&
+
+		test_same_refs &&
+		test_same_ref refs/heads/branch-1 &&
+		test_same_ref refs/heads/branch-5738 &&
+		test_same_ref refs/heads/branch-9999
+	)
+'
+
+test_done
--=20
2.44.GIT


--MTBP//NvGLAecIEp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYYvEkACgkQVbJhu7ck
PpRiMBAAiY4pWsLqlag5L33k7ReXRl7XpPqs/814wjdNhd9inHvFiIvrOA45Qyrl
nSYBVhRxjZ9mk8yX7bnqQcpLjaRLt5cmpfW5OUONNQi3DzP6epri2HaDZhQMSEX2
WWYwaJSJZmna59Su/IfEGV7O1+dFSjAzunmd6IlxCh7CRyQK1Av/d5S4IHbxubll
xO/2VPVtSxAk13UW2F2nuUsITepNWdEzqaOrR6er0uqRS1n+ufuifVQ/X/OMDVsQ
YASvraOSQoJdtJ9sTQ43YwM7wmez4uuInt8awVs1In54xhMVMgKQK1kQIxUaaUiQ
2C2/H+AnM8o9VAtcFUcY8wwnO0AYwMj9fhwybfurp+SYzwFUTbCFH6/wMGW/MFoX
WD32Ak7xRtjs1yJOTLLMnuOrUGvrn9hiA+LQCzR1ma8ZYneRhf3TvYzhBpp6w5rZ
Vk+rtoHrkuB1a+a2qbPd2uny5TVfzO15o7XKGg16ZMDU7bcq6GKLU80ZaY7zSRzA
VJct0Mq0W5KhEtDetjN1BwJdHOybKudzfEh0TUirI3ubNCfRbE0lOAak6Qqt1Wxz
BvIDR36f0UCOPc+THFGN5MbetyeAttbh9jnnuTbqQp5ZYv5bTg+emmOclpb6tzIn
ul3spCpTJvVrsoIOGVDTfuTmx0c0iocgqtvWxSkKG/XwAUoM9fI=
=CIrD
-----END PGP SIGNATURE-----

--MTBP//NvGLAecIEp--
