Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE3224B4A
	for <git@vger.kernel.org>; Thu,  2 May 2024 06:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632737; cv=none; b=EkTUYttnw58yTCPX91TJV6O3cG4R59+ObphluF0dPAnwS7I6xwNPbdrCXQtdEPLWv7hHTp2OA+MCs1LlcszbtstT6m52Z6M8bMuUQqGwOWPCk1abd/54HvC7PqRR/p7KhX3m7aO/ttoybNWLEo6KWBUYRB1ICrMeqhmzP5Y/3po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632737; c=relaxed/simple;
	bh=fAu8sGz/ZCUJVNwjWebgHdh3OPwETVUBVl6Vx4yRqLc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VG3/WI0bUGsvM/3T4YZ/07aRQDLdidRFdBrhZsgCffIzKSuWOwCdU1nohtfhTUYRxHtzD2rPY1miYo75q4pEsDTPCRvPhkAVUztZ2BTYyVT6Tcf5mo3i101qlNkNkJYTTfvnBGi9zkcROEMM9pji20zrWNYgHlmUdjMVSJHCgnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ruh+AE2b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XbHUFS6i; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ruh+AE2b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XbHUFS6i"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 51C721380395
	for <git@vger.kernel.org>; Thu,  2 May 2024 02:52:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 02 May 2024 02:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714632735; x=1714719135; bh=ZLgk95HqTM
	v7VUrDl5/sSfpraZJMJHGJZsnLD/9A75E=; b=ruh+AE2bY9LRGJSkr3GGnJb9+X
	LKYcjuXgzkum0205CKhizKL00oAE3sqmt+4f7G6LSf0OriP44UyjFz7Sdmb3l2Cd
	tEYy8bfTkneLiD2uWN0ZAtddUCZDgLDN65TcIMOUo11pvipOkYU626cWybKbxdIz
	iRMHyinY8bhcaUnZL2hCBIV3JN0LWi1xoUcC576ViKgHZonicQdxB0hA8zhO4umm
	souIDOuiPDYXdlUlDzJ0IAG+62A7IXYLOrHK6ELxhGqC15PaIg7iT+yb4ab3cdPT
	IVjykcuKiT/TOaDnwv4jcL2rI6v9BA8gbL956mEB0pbTBHSJl1YWGE0RfBaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714632735; x=1714719135; bh=ZLgk95HqTMv7VUrDl5/sSfpraZJM
	JHGJZsnLD/9A75E=; b=XbHUFS6il8T8GR36MqP5GPVoBXji7uLdYi+PwcsBdf8x
	LY5Pb9Vnul9vniV0k4np9qlEVFK72lkoIXDtgMf6nHi7yI5MbffRum/YCQII3ZbC
	PqATe1HoEzwf3U3VM8/WU0dCvI08bmrqsgfDoXuceCs6H1o1LyL4hTIt7irsvu+w
	4ZBRETBgdEiPCjhLS5HXToI7GH4tdk7kN8Pm/W36ECrSJRXV9kvFg0hWXNuRj3an
	nfLgiHDpvv2kgtfpwtYGqqZz1VMMck7h3xUlvyr+gZ9Pjk/kr31+4VsNWCEnx/sC
	pD2FKzDKktuhyBwO3vsWvNALfMf8Sez86vUmsWOWHw==
X-ME-Sender: <xms:HzgzZjTKA3CeauFTA1Xcz9l39nnTVbTRPbq4N9m0BL9YwLOBCobekQ>
    <xme:HzgzZkzsLeG5LmzlhUqa-H8KfhFDl5Dqn5CETXrGvwI4A0cSRKeE7rM30PIKLskK7
    GsLnYFPQkEmqbItJQ>
X-ME-Received: <xmr:HzgzZo08Sti_6DVjBmtjANlv5bMxo0UJy8WmUh1BreCQswh9N7BE5kq0lUDKro976Zy6hQZazhs20dkpFzsdrFJsBEmwYvOfD3xEmFzd7_lqUeU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeelleegheeuueehveehkefhffegteevie
    dtkedtleekvddugeeukeelveejtefftdenucffohhmrghinheprghllhhofigrnhihshhh
    rgduihhnfigrnhhtrdhithenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:HzgzZjDi4SYBHUtsVu4MxASEIqkSODhqlvLvkWFC0zAuCCsD_rgz0A>
    <xmx:HzgzZsgy6N-4BsjUkXlwcUG1tXwmSz_3JivjIAa-bRMQcPZl4pU_cA>
    <xmx:HzgzZnrrw7QHywcmJ0Fo12nWkPVbqvIE4Oq8zxaEOAFMjguV5IAMQQ>
    <xmx:HzgzZnhwEFDnwQ8oGu4qCVDa-izeBM0K6VfwNpFo9FZzd7Yxj_k5qw>
    <xmx:HzgzZoYD4erejVD1bX6UsOC-w7rRBYeb8xeJZvhC_i5gne7WDAN7BjWZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 2 May 2024 02:52:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4e9c3f53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 2 May 2024 06:51:48 +0000 (UTC)
Date: Thu, 2 May 2024 08:52:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/11] refs/reftable: allow disabling writing the object index
Message-ID: <6f2c481acce1ba7728a9a559fbf01fff331153a0.1714630191.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5+1xUE4xJB352hzx"
Content-Disposition: inline
In-Reply-To: <cover.1714630191.git.ps@pks.im>


--5+1xUE4xJB352hzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Besides the expected "ref" and "log" records, the reftable library also
writes "obj" records. These are basically a reverse mapping of object
IDs to their respective ref records so that it becomes efficient to
figure out which references point to a specific object. The motivation
for this data structure is the "uploadpack.allowTipSHA1InWant" config,
which allows a client to fetch any object by its hash that has a ref
pointing to it.

This reverse index is not used by Git at all though, and the expectation
is that most hosters nowadays use "uploadpack.allowAnySHA1InWant". It
may thus be preferable for many users to disable writing these optional
object indices altogether to safe some precious disk space.

Add a new config "reftable.indexObjects" that allows the user to disable
the object index altogether.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/reftable.txt |  6 +++
 refs/reftable-backend.c           |  3 ++
 t/t0613-reftable-write-options.sh | 69 +++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/Documentation/config/reftable.txt b/Documentation/config/refta=
ble.txt
index 16b915c75e..6e4466f3c5 100644
--- a/Documentation/config/reftable.txt
+++ b/Documentation/config/reftable.txt
@@ -31,3 +31,9 @@ A maximum of `65535` restart points per block is supporte=
d.
 +
 The default value is to create restart points every 16 records. A value of=
 `0`
 will use the default value.
+
+reftable.indexObjects::
+	Whether the reftable backend shall write object blocks. Object blocks
+	are a reverse mapping of object ID to the references pointing to them.
++
+The default value is `true`.
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index a786143de2..5298fcef6e 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -249,6 +249,9 @@ static int reftable_be_config(const char *var, const ch=
ar *value,
 			die("reftable block size cannot exceed %u", (unsigned)UINT16_MAX);
 		opts->restart_interval =3D restart_interval;
 		return 0;
+	} else if (!strcmp(var, "reftable.indexobjects")) {
+		opts->skip_index_objects =3D !git_config_bool(var, value);
+		return 0;
 	}
=20
 	return 0;
diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-opt=
ions.sh
index e0a5b26f58..e2708e11d5 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -214,4 +214,73 @@ test_expect_success 'restart interval exceeding maximu=
m supported interval' '
 	)
 '
=20
+test_expect_success 'object index gets written by default with ref index' '
+	test_config_global core.logAllRefUpdates false &&
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		for i in $(test_seq 5)
+		do
+			printf "update refs/heads/branch-%d HEAD\n" "$i" ||
+			return 1
+		done >input &&
+		git update-ref --stdin <input &&
+		git -c reftable.blockSize=3D100 pack-refs &&
+
+		cat >expect <<-EOF &&
+		header:
+		  block_size: 100
+		ref:
+		  - length: 53
+		    restarts: 1
+		  - length: 95
+		    restarts: 1
+		  - length: 71
+		    restarts: 1
+		  - length: 80
+		    restarts: 1
+		obj:
+		  - length: 11
+		    restarts: 1
+		EOF
+		test-tool dump-reftable -b .git/reftable/*.ref >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'object index can be disabled' '
+	test_config_global core.logAllRefUpdates false &&
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		for i in $(test_seq 5)
+		do
+			printf "update refs/heads/branch-%d HEAD\n" "$i" ||
+			return 1
+		done >input &&
+		git update-ref --stdin <input &&
+		git -c reftable.blockSize=3D100 -c reftable.indexObjects=3Dfalse pack-re=
fs &&
+
+		cat >expect <<-EOF &&
+		header:
+		  block_size: 100
+		ref:
+		  - length: 53
+		    restarts: 1
+		  - length: 95
+		    restarts: 1
+		  - length: 71
+		    restarts: 1
+		  - length: 80
+		    restarts: 1
+		EOF
+		test-tool dump-reftable -b .git/reftable/*.ref >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
--=20
2.45.0


--5+1xUE4xJB352hzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzOBsACgkQVbJhu7ck
PpTEFBAAotWJOtczkPdxsEZU+x/eG5G4p79M9sMDQFnoFJrf1fRTPg1oeNo8N1EM
6MSkCN/M2XoHaXj5K3sT82G+y957oSctsOJpBohDcZz7d2ww5CIVlAdVC0jP4Esi
YsckeMEwe3O0ZT8iZcb3zAF4xEvziCyoEtAghYzp7agxVA0XdPnNyVV9XbpZzmfe
aeN2oByvifTrGHebyYgX1M9NhxInd0DKs+42VUyYid67HyraqsyqTm8i9QSOvaWC
DxpsJxqD2/2WdawblmCtxjfNGLDfDXQM72SkdQg9bZ3tqREnoLTEmsjVMx//gzod
B8eLG/9a5i6vbOxs4Pe3mbAqPzUZ1UJdROEhJCfX9qWfuv9//p0t5ywRSsw1obde
N0rAKBapNSThIw0yu5i/8HhMIVDqtzmonb4Ceb06omqZieAfI+cBhWdZKue7wKjv
Dkg3mp2W3KVmjSt74CiQs34b+EMJdraW7H+FObtDbnBNHMXG1SFKV/yWTguN4Umn
/iA8JVuOitiwJPYVyeaDtNABHf1rwv9ngK3HylhQMW5zkcgvzBfw7N1WOsW37q/l
sQVCMLCwnE2zqvG6hhGpl7+LDZpDIfbznNmR5Cf1GKGmACB0HYUQv1FRaSN6HQ3a
snL7z52ChWmVvVrO903yCky4WXEjlz33ytie5l/LxLvuz0FnQus=
=S/gn
-----END PGP SIGNATURE-----

--5+1xUE4xJB352hzx--
