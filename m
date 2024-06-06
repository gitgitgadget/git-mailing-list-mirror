Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA067194C8D
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669791; cv=none; b=QfSkgQildRBX+SLLhynr/dbb8ZEs6PRh8t0lgM1qW8wukfpYkpL96BjWCIlcSDS6y7tRAhk7v6GTgJKz0rLVhDVa82FB5Q7qeBPpRx1U1qTxOzTGaxQM4Xvjec22krkIxTkZ2B16kBbnMcB3xXJ5WUc1Mp6IXIf+/1Apo7hU7k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669791; c=relaxed/simple;
	bh=JvqsNVlQ6XOk6mydVYvrV4kAmuD/y3FVClNGVqMFnYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJ7goaPPAmq/DjoePXPiYZdIq6KIPR4s6Y1YZXgjIN2F6Us1wlakoXGd8BS0IhAbiLjk6Y+YCG/soQF9bLbjvhgsnUjleiTaV9xp7epuD83CWIhnMQ38ko+u8adnmbRTZFSYjY1bY0PX9ySvBKQPYni639l9HCcUpVirlJVs0VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TLQTlu5N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PHrOBWgU; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TLQTlu5N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PHrOBWgU"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3743D13800ED;
	Thu,  6 Jun 2024 06:29:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 06 Jun 2024 06:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669789; x=1717756189; bh=5guQbolLuJ
	XFL3BZCLaWyaGx7Uw8X2YN25QsOyYEfmU=; b=TLQTlu5N4kUwpiGMUZQGeDdlMn
	WVP9Ol22JnNP0SeJbQJ9yo/ev7+oV46UW4xXZbcwAxAShEuOdEth2KN2A33yUpXp
	ZkOQYEf50zIkNynLoQ8en2ktBqTvDZYUZ8OB78UbaK7J4eXLS8oQuhha99CMktnm
	ivMNSyuG8HjIwQzv0ixf+/c67pZwCLp6qdvnc+pmr5H81n/ovYiT4B9a5QgzzPyT
	Z2vo3yWR3+0EU/5DLFR7JPqcHXFqcS41unXRnSMKapHhDANZZWMn2xu0SQbVXCGH
	X0WPK8as2JvQQJKi89RMMfGlcZwhXc/6ihSg6VPBmZP/FXspMSKEYFbkOSUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669789; x=1717756189; bh=5guQbolLuJXFL3BZCLaWyaGx7Uw8
	X2YN25QsOyYEfmU=; b=PHrOBWgUIl8rzg0Z16/q798NrxictAwllELDc9ayK0uu
	31dh7XBJsQlnBpn6f4348UWt8p1IAbXJsq9uak5uPv9Lu5xnp5jaJY11QiDeYswi
	7lqJpTy5on0pnEYLqz7E/vqGk5T7MRqGC2rVpAUAN+D65NcGXSL8GDaty4E4OHHG
	PksoJxoa9UwctXplX6XDsv7DwQSd3Hvnh9fD3g5tGgEa6ZHF9bQ9jBvptBRKhaHk
	26C1m/l7G2xdpJJFrFkc85Zi6jTI2kr3dmGJDtqda64K6kD1NcuVWQJyxmgloAwV
	I7Xzc0OwXJLDSWbq4u+X1j8q68AOpbiviSmzw8+Ipg==
X-ME-Sender: <xms:nY9hZoXWe2Jp_JhbOX5VcFpX_mx0jP008OCmb2d9bvX1qW-jAOj5AQ>
    <xme:nY9hZsnwB5KY0OCji2pPik3OJcRCHWHyycBr_Jx44JM16RPeyqK66OnBaos2cqs43
    9lG3t8o6LgLZ4G1tg>
X-ME-Received: <xmr:nY9hZsZzYo4E7Y2we-jVaE6oBamxwy5Oa5goG-B7hIi3JATy7WqG301uEuZmu2WNx7cbzTwP0Xwu-gWrhyqm5H9TcEKmBBrKKIyQoB4i5AXh_7Ss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:nY9hZnWbWseFeq6t9G9cKpm5286xTLptC3XDy3D7Rsh8_fQxKW1fRA>
    <xmx:nY9hZikTX0sEqe1KJaCl6RkZfI-Vma2O4G8sQtDaAqGrBBsuYjVF1A>
    <xmx:nY9hZseaZDvR9jSzRHijXwmXnPeg_DNdGRmtBfwIa0u_INWNroKZsw>
    <xmx:nY9hZkFC9mDdK3nFasjb2m7XeHW47NZ3Kl06yJzUOChjZCMc9sHgXQ>
    <xmx:nY9hZjB4O7oyqaQg5JJmmZCCUCfQ2gXVmitu85rr-kWqoZokWOMzFYhr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:29:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2a88264d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:29:17 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:29:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 26/27] builtin/merge: always store allocated strings in
 `pull_twohead`
Message-ID: <a1d2149429db608e42cd71870ba1b6f0337d34fd.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ZI1Ff1NuSPCg4gE"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--6ZI1Ff1NuSPCg4gE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `pull_twohead` configuration may sometimes contain an allocated
string, and sometimes it may contain a string constant. Refactor this to
instead always store an allocated string such that we can release its
resources without risk.

While at it, manage the lifetime of other config strings, as well. Note
that we explicitly don't free `cleanup_arg` here. This is because the
variable may be assigned a string constant via command line options.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/merge.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index daed2d4e1e..fb3eb15b89 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -611,17 +611,19 @@ static int git_merge_config(const char *k, const char=
 *v,
 		return 0;
 	}
=20
-	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
+	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat")) {
 		show_diffstat =3D git_config_bool(k, v);
-	else if (!strcmp(k, "merge.verifysignatures"))
+	} else if (!strcmp(k, "merge.verifysignatures")) {
 		verify_signatures =3D git_config_bool(k, v);
-	else if (!strcmp(k, "pull.twohead"))
+	} else if (!strcmp(k, "pull.twohead")) {
+		FREE_AND_NULL(pull_twohead);
 		return git_config_string(&pull_twohead, k, v);
-	else if (!strcmp(k, "pull.octopus"))
+	} else if (!strcmp(k, "pull.octopus")) {
+		FREE_AND_NULL(pull_octopus);
 		return git_config_string(&pull_octopus, k, v);
-	else if (!strcmp(k, "commit.cleanup"))
+	} else if (!strcmp(k, "commit.cleanup")) {
 		return git_config_string(&cleanup_arg, k, v);
-	else if (!strcmp(k, "merge.ff")) {
+	} else if (!strcmp(k, "merge.ff")) {
 		int boolval =3D git_parse_maybe_bool(v);
 		if (0 <=3D boolval) {
 			fast_forward =3D boolval ? FF_ALLOW : FF_NO;
@@ -1294,7 +1296,7 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 	if (!pull_twohead) {
 		char *default_strategy =3D getenv("GIT_TEST_MERGE_ALGORITHM");
 		if (default_strategy && !strcmp(default_strategy, "ort"))
-			pull_twohead =3D "ort";
+			pull_twohead =3D xstrdup("ort");
 	}
=20
 	init_diff_ui_defaults();
@@ -1793,6 +1795,8 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 	}
 	strbuf_release(&buf);
 	free(branch_to_free);
+	free(pull_twohead);
+	free(pull_octopus);
 	discard_index(the_repository->index);
 	return ret;
 }
--=20
2.45.2.409.g7b0defb391.dirty


--6ZI1Ff1NuSPCg4gE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj5kACgkQVbJhu7ck
PpRGMg/6Ag2ausEcquU89s0KjW3Qp5bwwtk7fN1UWllpiobpmVBQjTVsfUSdOEZI
EGckKXtPRXg9YEpPoutBT2Sg9FNyFSbjyJPGqEawUafc4VdmSpFQ/y13gzaZs4R5
EAOLmUTk7S8KeRRnNvIYnLHSHm3FQrTZVqQk2Ba5bhCPF0U108QfNvHTNOaQTl+d
WAHk2Uw7wW2QUGqgZZux2w7I2HFgJUrKyx86wEcBNOC5uuATp6RFw1u1iN3yeLCr
mBDOLmrlDtjRt1We49tK35DsxMZJ5+BDEFzSK/ZTNQfU61h2xfrYD374+A1GEjC1
zxrNaGgOdp8hu3x1Ixvy+rhhoqDLe+D5g6+gRjlm32y1Wg9K4HCrNmI0Ko8yh5UF
wmFpCrLqb7aKXPZ/m4QmUL0YC7C3+uQMQwqGjITPoai2qFZX6YNtMVf/Tl6qRR17
wx5rmDuykALkdhEa+lCBIJX7k0PxXF6D1j+IEUgIGwC4PQE4UHEvVE11asSPp7LT
5HffhSlGMuz/0LFSl+cb+zXnmD5uVKCbp8Yselj2H7yUPULE9zmx1BOltQnXEG89
Qt+y0LvkE3FlbHbaO0URs7tYeHlZv+btYtTGeIR66xYULX3uajKPZFSZEnf1KrBH
rOrfB7GnaFt1lc6uJgyaSnD9EbiujOAzfSqCB7fVc7wJH0qw8U0=
=VIhT
-----END PGP SIGNATURE-----

--6ZI1Ff1NuSPCg4gE--
