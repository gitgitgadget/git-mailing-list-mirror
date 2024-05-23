Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5620148846
	for <git@vger.kernel.org>; Thu, 23 May 2024 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467179; cv=none; b=KJMZVf7DFcH5y5uNjmlQOUUtBMH3r0GB0oRVKwZyqV4JfcIbZpnYuhgFMSNCpkCQuFcejtj6UhXZDB2dzQuioTn2WwmVgRR+Eh+f3VQaRBwBnUCzTWgzXXpw5eaYoN0Ky8MuynF5qTx4etM3rquSw+kixjjKwGU8bHS2WWP0TK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467179; c=relaxed/simple;
	bh=rQGGt6iuKtRgz6C5QgNerlFggQdov9Ll6Vkc4vocf6A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6frhE2z5toLogulZEz/hkNH1lLSf8RuSk8BiNrmKk1sxHQ3k+vTZO4firlQXaSnrUVKmxFYMhpspwZxn47jccWX8Y4rIa/W77Xx6/nUD/zYC+kmEhQ583HbS1V8qefnt999jnQoAjxjfbNgZmHErs9pxGVnSl9oruaOlQV4icE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=axsStw0n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AMgOTM8X; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="axsStw0n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AMgOTM8X"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 40BC31C0011F
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:26:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 23 May 2024 08:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716467176; x=1716553576; bh=xnqlPhbPg7
	/iaoCQU5/6b9mnkW6JsEVZrtzODc4KKz4=; b=axsStw0nUP4Ze03NkR5bFXILO1
	gDo0lRvJjVzlA147yaDhjAwIX/bDelDyH2J1QsqgE1cSu1x9efGLI/02KEBxAOCx
	yFKdnchCqVszvt3RIGgq69Qd3QMxc3DfGsK8HQHAG8EfklORAvcnrnIVP5Z53lks
	9HP73wnxRcJfwQNOQ9GY57W/9BHOH9FMjT8XI3QLCumfdP1qrA0s5gPFcnqxdA5J
	fvDiqMvSEtbUC8L0t3a+6tv65wJBuD2HxZar1Y/hcMhEgZ0MwCEaJfnAp5AqvQgb
	ImvbA9G5u2MxTLiRd50rlqatQSbPCkJjhDTSNO5mNP2YfkqtINUSBX3+JQmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716467176; x=1716553576; bh=xnqlPhbPg7/iaoCQU5/6b9mnkW6J
	sEVZrtzODc4KKz4=; b=AMgOTM8Xa0Jgpkj4hDPOt4ySDPkziyf5MwEmpIhyGbn9
	1Ak8ujk+8ssEG+BAyRsfHRLBmCGnlh3tJay3w9NTs8N+nVy0C/VtMcCbIAt70NXa
	E+urm7BKfV5uqvb99/WG25Pvw8iunjFVihquXx4lNREHVZT5RhXBNx3R2xLNAcE2
	8mZYthOSAGk6rfll4ltUcLTSooL7psuBIY49FFfOCTxaPNEb9WV2Uav9Zq1/XfdJ
	zQRvCziQEsYBld2h6d4f/QnY6i60IhUqPT0UTQXj3mYtP3q2RyWkZ6/ADBQqZR1O
	dLruDaLH1LV+YYRIKmfShBH0H5xPnsVcXQYeJo9J6g==
X-ME-Sender: <xms:6DVPZt_O7nFGJouqT7X3YjyTLK8mRdG1XV9OUS1rIiJCOQhZHcMheQ>
    <xme:6DVPZhuLFHB51dXrtL15kFdmr4-EeTKGixOO3zs_V9bc1wTSihSv7d83W4sWB4-bW
    bwpQzmM866cDaHIzA>
X-ME-Received: <xmr:6DVPZrDU_csg4K4KHdxdQ2NeM5QUhHz9lSSCcTrSuliatY6WcAomUm9Ot7MhCnIM7P9Qo2ehwX63Sc4w_1RYu9e_M7SEBsSDlIt0-5KBiKSR8njETw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:6DVPZhcbTd9TTudJP_QerExLSYYPqA6fpt_3R5qqAiIA3XOjx47ymw>
    <xmx:6DVPZiP3ooE2kIOCWZrkGaOXYkddLXibFfR5TxJQV4u5yttfQlsBRA>
    <xmx:6DVPZjlIl0vUK4apP5a5XyRx4Zko7rv2csruEI_IN_H7BL2snhLKcQ>
    <xmx:6DVPZsuHdo_esaEODR-zyNpt8-sAuK-9dkM0dPkfBKC6BrpInefixg>
    <xmx:6DVPZk3SbfsIkP1qGPw3BSmNeumJAOp0coKvdn3_9yuDZiorYXUQScYg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 08:26:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2d9d3a74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 12:26:09 +0000 (UTC)
Date: Thu, 23 May 2024 14:26:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 13/20] builtin/credential: clear credential before exit
Message-ID: <23e2cf98b7865f134cb60acc27b750184d3f86fe.1716465556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MHg0M+cz4dDhOuIV"
Content-Disposition: inline
In-Reply-To: <cover.1716465556.git.ps@pks.im>


--MHg0M+cz4dDhOuIV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We never release memory associated with `struct credential`. Fix this
and mark the corresponding test as leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/credential.c   | 2 ++
 t/t0300-credentials.sh | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/builtin/credential.c b/builtin/credential.c
index 5100d441f2..b72e76dd9a 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -39,5 +39,7 @@ int cmd_credential(int argc, const char **argv, const cha=
r *prefix UNUSED)
 	} else {
 		usage(usage_msg);
 	}
+
+	credential_clear(&c);
 	return 0;
 }
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 432f029d48..6a76b7fdbd 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'basic credential helper tests'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
=20
--=20
2.45.1.216.g4365c6fcf9.dirty


--MHg0M+cz4dDhOuIV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZPNeQACgkQVbJhu7ck
PpRayA//Sd9Hf7qAO16PGDpB2EUsLPLFN0puQIjF8pZhg+LjJQ5OqJH1wcpEMn/I
tSnNcoMwhzCc0i8WHOtYUw4X5vlDlc3OrJ9WSuCImv01MD0ZS9pQjMuciKOd1sUW
gTb5AyM5v4J7JRo7IHHtI94eJEieneeXzZVIU5AMWYx4wTmodEbZtGD8wqMmBkAF
ikt9nUJZblua6867CbRDAlq2ShEOJ2d41e2ybKFMnF5OoS/qRzrBM04cEQG4P2ZA
Hk1sIpeYuzBq9J9N5j+QqveAZr5Z6pXOT0hA/tzjzQBokDuHCUMRY0mo5hNZwoS6
tG/AcGhC+yMoVSaXQkFb5RoAaIeaNQVXwMiARqHPG/iJ0G3KoVh7+ezqsZ5kElOx
dq4FCQdGK3frL7olhIUOz09eUA1SOptDKH/JAYB+M/iSV3s224K8jSRzxyVAUByc
wSAG5RlkB+d9UNYyFips+4F3pLGk7IV9GJCk37XkgAkTEGdifQ3bqEEe4aG/F1jp
+N7NVldzOPRt0yKbAFQGtSCipZkg6WlMFD9Dj1E1duVNrMc23zWjcTE8r6nShk86
irVpq+Mj7KuSIiJFysc5NwwxPGXPsewBkg2n/h7BcQ+TjI/DpWtu25Em4jAfnUcQ
Icf+EsZ47WGF9pUEsyrJoxLKHQgZ0c27qQWpt2lqxQKVvQbdGow=
=QRwK
-----END PGP SIGNATURE-----

--MHg0M+cz4dDhOuIV--
