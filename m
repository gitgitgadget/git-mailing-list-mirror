Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB1586ADC
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237153; cv=none; b=ZbuZHE4PIaNCS1/GB+T39ExTZJnlJpHqOwaYvemvShflQz/E1jSRbkiQFVTIFwNH/JTWA9aUwRmadiCJN7wp/ZOTlE4udfBO8c3NQO+Zp6RNN4mYWs+/j1NLz48tSKVwgcPClr1wyUwca2l68A/sbiTojKaBSEvSriw+Wm6hp/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237153; c=relaxed/simple;
	bh=bVgrNXKDRsYSg3TbOpib5PsPjn9oPGFbqM2qXSUYxPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tlia0pjwR5pqnWX4MktA+l7ZP6mrduSM0LxKVoZ5ButCpnmtBvid9VQS1361apt++D/0oowrq+qv/HZY6ICKLhiIKv+9yhoKuGOl0tWkgIujjdCwpI0Ddawyv9fSBiDyLqcT32cC3mx4TFmR6CtVq67LI50n6obcOlKXp9WNeC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=alIDsxsf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t98lxuXv; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="alIDsxsf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t98lxuXv"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8F0BA13800F9;
	Thu,  4 Apr 2024 09:25:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 09:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712237151; x=1712323551; bh=kfdMJfpvnR
	ftA9IvEQ9vBe2vVgc8viYGYq1iqknUEXU=; b=alIDsxsfMrGHsqVODekS4dlk6Z
	n5HbXQcfZ0Vdrw6H35os/HQPymoo1jMs7bo8UwtpB084ptUz4RgUgToj6oa0wpAI
	yDl39v8MMarSQkEUg8wJbf4VZIDqd6oGg47F3hJSRdI3WnmuMVki0iHL8+7ww/ib
	Tht3ONdGOjKuLDyIJMJXQ2HltrYHfe7p1Ygn1mNHoFybr4gOdQtG8fT1+xJT1PiC
	ZdK+cn3uL9OlWZyLvI/02ExWjcuuu/pwrDF5oBWSv51srpdRamuzSgdJhA8JC4P+
	t0KqFBq6CxtrOlkUtRKvZsbk/kGZVtRbbxshbtG2nFA/bAJcjnwx0jSZ+SDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712237151; x=1712323551; bh=kfdMJfpvnRftA9IvEQ9vBe2vVgc8
	viYGYq1iqknUEXU=; b=t98lxuXvZWkL03LjAAMDrGq1LPfcIJt6niW4P9uRvdAT
	RXz16ElzQcypSKpvTtXexkzYdgwN80nNntdefOhyuErtcD3NqN3caT9GjMcnuEM+
	tlFGeVo0Dm3YiHwlAfidwkm7YSAuNO4vmGImXEXK/xFTXdRKKXXV7juhhxOTs1jm
	be7WIITwhoKz3hvo9E5RK8KGmMocqtnDUWbNXaGZqaSc5h3oyultOVycEbq5oqYq
	pmoHdpaWeIPPgdmtk7Oc029+Pp+yaEsiMjTfjA1xoL3pFrnQtzZw0Jz1lXaNBAzC
	HYvJkVkgJXYqAqe2YqQSx8KCYtnj4Eqasx7j9/tuUw==
X-ME-Sender: <xms:X6oOZgtrmxPCJv10aggvWjYC7N3P3TUH1oc1zp7uUcrFGSIbp3apaA>
    <xme:X6oOZteRcnvqs67iOb2Qcb1v4LrYkeGYN3tTgk_I_WJ3Fq0nPBia1k3bPS5Ua9HuW
    NABPd3YDVjaSD16ig>
X-ME-Received: <xmr:X6oOZryaY1owoUQteremsiqZOz6QmOS_IlZR8G_ETpIirmlUpf9KMXJUkVbfAx6YijsPflSGQSpxMPLtPhOsKYEJ7czIQv6q37v8ogTH4bRTBfAL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:X6oOZjM2oeuLMccTWOv_aRcKJDUUEUzyzsIDUnl-zG5xQyIZWzDfTQ>
    <xmx:X6oOZg-qnZc8WDzeelXNnGVeJxT5r7-_iS56ii7fJxLJQlnDwWRBGg>
    <xmx:X6oOZrV-pX3kBQ8uhxiCQm2xbIQ5-JaXERxC63nlWB5MQb-MFAmMGA>
    <xmx:X6oOZpcix2ZUDGhRkpgq7XEEwlnAkGz8MOiGZIfrLJENnKJGMzh2iA>
    <xmx:X6oOZgyptX3xjJgLqWN7p3AEojjoqZ8JwjjgycM4jkZ-iI_3NM2l5KQm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 09:25:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3f645332 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 13:25:46 +0000 (UTC)
Date: Thu, 4 Apr 2024 15:25:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: [PATCH 11/12] t0610: fix non-portable variable assignment
Message-ID: <c2c2747ff57f68ccad8b509af037e1fc4a524fa1.1712235356.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZppbhPfm+47YpE9E"
Content-Disposition: inline
In-Reply-To: <cover.1712235356.git.ps@pks.im>


--ZppbhPfm+47YpE9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `test_expect_perms()` we assign the output of a command to a variable
declared via `local`. To assert that the command is actually successful
we also chain it with `&&`. This construct is seemingly not portable and
may fail with "local: 1: bad variable name".

Split up the variable declaration and assignment to fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0610-reftable-basics.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index aa9282007c..3b1aa99e7c 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -80,8 +80,9 @@ test_expect_success 'init: reinitializing reftable with f=
iles backend fails' '
 test_expect_perms () {
 	local perms=3D"$1"
 	local file=3D"$2"
-	local actual=3D$(ls -l "$file") &&
+	local actual
=20
+	actual=3D$(ls -l "$file") &&
 	case "$actual" in
 	$perms*)
 		: happy
--=20
2.44.GIT


--ZppbhPfm+47YpE9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOqlsACgkQVbJhu7ck
PpTsxw/9EkiBQft5CG7ykMYN35T02RS6gmu80p/PdlhjIXJcYI5uE3mwgu5acbzQ
easO58XhXVoAeJl8+VahNxXUscUquAyNT++OSQbDoj6tGtINux/1tk4e28dlpNDb
+JecfNMkKoJk+/XlyjDrwsERq7JCPy5qlrq+zUca/vWap8AaxsR4q6LP2aXFBtJJ
AFlWNBIw4SzFUPM0keTFvjhllx3NiIXxsIDo28hMRfkac7CnAIR9iZ6H+x3BfSCz
aZIf65MlAS8LMhZpsdKR6d5DiOiIiRtO8V/GHA8JDRi8d1+jLunvbbBu1b2fBu9V
MQMfTUCNm/is7gf6YOXtrlQFTbixiFiP2D8l1MpYZ0Pe7VXCJxGfOD8aE8P/9b+n
D/B3prGD5IwsP9ruomin8CMpibLQkKt3iahzUGw1ioFW4sNUzBQqlvoq/qDtKkVP
MoZDd+Kd3nd5g55hjOD2J0hxyzSDBwISCCE8/44dW3vfePpWSk5KWh9E3LZXPy1Q
JbLbWe8eqJYfO4lLqrbJBrFrGDVVM5DklQauNJ50DC9lOlbGXPMXgv82Fxp12Z/Z
mhCuTPtp6jXlN87qa8KoIjQqZBCBDNXqDEoggakGUiTAs2av6HPTzBk8oVlRSfLX
vaD+HRCowGVkVtDvnnzYbz5q36PBfexiI50wGEMzfSDvp1MRli0=
=Dp2x
-----END PGP SIGNATURE-----

--ZppbhPfm+47YpE9E--
