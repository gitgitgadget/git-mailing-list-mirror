Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BA217F4FC
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073483; cv=none; b=BbbiS0Mk+65F+UXRQCA+9cULUaa7AnbAQmsa3CxN9K2nBibqS8pR/8Z+T/ZdZbntyMfK3jWW1E+KNVncGRyWkAFSs6zYYBMgNJOwS9fGFx2/wWAONQsGaVrPR5Scv45AIm044Svs5p9BIgaG0rF9tFGpJd2FsmLqqRKnYtUOg7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073483; c=relaxed/simple;
	bh=DZrcfUqJSheDrhj5ActQRzM+Qjuv0RmAYS6wjEVBM88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdDt8KUKvIZMJHP7Bpsq/XvwZbaYkCBx/4NGTJE/Fu5d4MUXK2s/JFgMg3FTlSNRlANbQthsLdvzWF5h2j5Bfs4mGwUpWKhl8FLMXDqQJAg5oUyN2nHxBfgfndmsnZVRgx5Il4uuVA79lMoDkFWb7VHbndi9HMLmAki1TltbV+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XDQyXAak; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eJBYWJoA; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XDQyXAak";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eJBYWJoA"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 65ADD1140155;
	Thu, 30 May 2024 08:51:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 30 May 2024 08:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717073481; x=1717159881; bh=bt2Z2vX5di
	0hb/f9bDaPnJujrm1IXMrejzyTkHmw5lM=; b=XDQyXAak9aPKmEgRo9oqGKM5HG
	MPE/CQybm1SvKQ63l+K+iU7oDGjXdmuEiDxHVo2YYiZm25YguChbqhOHNz/KFCaw
	xLgL+ebIC6LdUaoAy1gLQ2sTmyJkTLJDz2qN1ioNgjLH5HIgquacbSUsycx+fym0
	tcjVOU4iXgCI+CMK0bLPokwpMOphPzs5DzMRR5PUPq8GVLpTUd+BHRiy5U7shvPC
	mQVJ4wZElSzi9SEUPca9v3rVtaH66UlTbC/xWFfVnWFo82tyN09u4xDzOVINWQkY
	FxlwUK9u6faTUVTo170ohqX2DtiAYGVCqjVZTr4R7W8QIHWXuA/qIPCImSfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717073481; x=1717159881; bh=bt2Z2vX5di0hb/f9bDaPnJujrm1I
	XMrejzyTkHmw5lM=; b=eJBYWJoAkfv02yHow0I5rfwFxWVHW4qFb09+q9IuRnq1
	bkQL5/ba6f1NwpW/Qcth6ZB24fQtE+H0dxl2syNw/Twpjw7sNz1EDIO/GxXEHiQB
	ntIAX6NLGYu6N858zXbn6Uqb77N32m1GiOckg+wSv+GRqzC/vvoepclsAOSB3zEd
	l/5KFXYaQwBdjnoqD6EqsVHymcyxRBBb1nG1Ns1zGN4Exro3zDGQBVXoFHqY199b
	clqLgY1ktawwNTTndmFQtqIbLobUg0upnZ6pHryP8SP96GUFXLm/pYHbMDiT4CcT
	OZT4FcvTyt4LIqOeTojuq7g9tiuitlQmYdifP/TlUQ==
X-ME-Sender: <xms:SXZYZr-7x9d18Ob_xZiYFQ8XBkUHsN56BoEIgIuHV5uTFd87DqMFaQ>
    <xme:SXZYZnumwlDV34I-u_zPIjijK_Z3hbC8To9ViZk1FcqXu3FzZAkVS6Ec7oaktlH5_
    TcAYCbaoEL2x-Ok5Q>
X-ME-Received: <xmr:SXZYZpC8N19gzGqjBlcOUnqbJfX3CewX1obTybXnSfs_lCB-L73Wnk1YKkesi3wSwBmhpwln2v0rLAOfMNMJz4YtyxFQTeggFFPCGaIz5MRqTEH5SA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeefnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:SXZYZncVyJdSSpdsn_iJwufDQ4cfqP6GkR66KE9pZepv7ersEYLq0w>
    <xmx:SXZYZgPScZt4UaSgaVziGdh3pW9uG0SV1f-PKHRQno3PqO0Fy9wXCg>
    <xmx:SXZYZpm5zycUY_m8YyghxRwezP_uKbUWRMnhqP46wG8KTxggTM4eBw>
    <xmx:SXZYZqsN282H-ofk6Sa3H5Q7l4Esh2Qg05PONoKtJTjj57dSPKfIeQ>
    <xmx:SXZYZlpZ0uV5CXc_n145_nMQSLFSs9z61Y-WlXeSjNxGU32wuoVUSGUp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:51:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b327cbef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:51:04 +0000 (UTC)
Date: Thu, 30 May 2024 14:51:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/19] send-pack: always allocate receive status
Message-ID: <462502127d8bdfc77f9e4b8ba975f41fb12b3476.1717073346.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717073346.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M55ZdbjwbsLaYxzK"
Content-Disposition: inline
In-Reply-To: <cover.1717073346.git.ps@pks.im>


--M55ZdbjwbsLaYxzK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `receive_status()`, we record the reason why ref updates have been
rejected by the remote via the `remote_status`. But while we allocate
the assigned string when a reason was given, we assign a string constant
when no reason was given.

This has been working fine so far due to two reasons:

  - We don't ever free the refs in git-send-pack(1)'

  - Remotes always give a reason, at least as implemented by Git proper.

Adapt the code to always allocate the receive status string and free the
refs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/send-pack.c | 2 ++
 send-pack.c         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 3df9eaad09..17cae6bbbd 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -336,5 +336,7 @@ int cmd_send_pack(int argc, const char **argv, const ch=
ar *prefix)
 		/* stable plumbing output; do not modify or localize */
 		fprintf(stderr, "Everything up-to-date\n");
=20
+	free_refs(remote_refs);
+	free_refs(local_refs);
 	return ret;
 }
diff --git a/send-pack.c b/send-pack.c
index 37f59d4f66..88e96d000b 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -259,7 +259,7 @@ static int receive_status(struct packet_reader *reader,=
 struct ref *refs)
 			if (p)
 				hint->remote_status =3D xstrdup(p);
 			else
-				hint->remote_status =3D "failed";
+				hint->remote_status =3D xstrdup("failed");
 		} else {
 			hint->status =3D REF_STATUS_OK;
 			hint->remote_status =3D xstrdup_or_null(p);
--=20
2.45.1.313.g3a57aa566a.dirty


--M55ZdbjwbsLaYxzK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYdkUACgkQVbJhu7ck
PpRT7g//YBKRHP12+EukcROFpKp4e5CHFpCeZN9TiLcxoE/IVFVtWMajj34C4CKb
cEeK3yzWhUtB2ufVJZUHm0UAH1uMWg6Ta2BAt+68mQYZtuY/JJFoc5yUXLl8S1Qh
43ukVqWYSAoVV34PodqwcRhJvVu0OOeVE4aSv0RZ0Q9x+JM/qZErr5J3/1R/LfpZ
prSNk1igbSPP1UZUq/F8k0nybTj8GfZSygu8d2h2k9fCT50UjqBRZ+dQylld3Vo/
gEbzOwE936gJkvuYW/vSlYP3bMkQE/V5m4vAeJjbJz52BMu6SGRg+zRhK9OXOvTt
VWJAIsbffwvz5idl9DsW7Tjn3GZOhVga3rb53G81os6QsLWOtAoq4z6iQzqOFq0D
EJdCyb7cJCEKmzl1S9doQhfhc9nQ5WadqCpF+Cqj5wWySDS/gDK3/pR6nsB5Vv/Q
7so5fz0QeOw31Qwzli2qOzSwHRRlpOt3Ur3iwBE448+UB7nCquAR2q8Er/C9uL4M
fR7SLQJhAoVNNCiL0pinlZPNVf5qkHNVY6+xVLu9WBfpUpXJoiTK+nV0UDnP75LH
0S+qx2F2QIITGVPTvVXUsyjwu6URXg13ltTEcdVbY+AMkZbT4V3ry2yIpfu7Nz2F
X/vBvKoqH/GhI5qvVzK2bDkDUGHmzHSkPP0Kn0AQCOvagxLBH3U=
=12Bv
-----END PGP SIGNATURE-----

--M55ZdbjwbsLaYxzK--
