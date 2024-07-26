Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87483A3D
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996089; cv=none; b=r7TJcItxUXa9nARBdmhrNOsNFMBNf7uFqYt+FbRF8MW+tCqWbgAwtc39fbVrAVF4hQqc4Uks9FzoOdzsZct6P+oJOyifKowNkMJMP6juNlXG+4Qwz63o41ym0f6nYTSb0DLY4+HqB/NaJF4ErZmZXpPLUFgruFffjnLoTn4PF/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996089; c=relaxed/simple;
	bh=xW4OroKUNWqQB0XJvvPX8BCMHn228mjod+yCCtFOPBc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bahw/IOqDOX1ICwRHiW3Vvg/gDOTMW5s/bHNKCLOCpQuCA4fdSrrbJ+lv/cpD7ukCipUgWbGhw/s8INosw93oaqMoEphOMCI3Dw9mHc5tz9mqELkuqR1UU8nHGrdbOZqaLFf4nFua6N+mI24gYG/TAe+nIA9xvA4CbkOvepeArk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bMWAjoOE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CKzmr79f; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bMWAjoOE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CKzmr79f"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A62FC1140284
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:14:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Fri, 26 Jul 2024 08:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996086; x=1722082486; bh=L9X+j6oqlF
	0JPaeEfO1fRYTaDQdPNGkAmU8Y+aRPhFA=; b=bMWAjoOEZSAhX7NrEo6cjpgy/8
	TWUWXf0WojZvCzK2Es5VXZCpUVqedERoH5wFUV063/D8dLArX1LLFZ109biqp9Iz
	ZfysIPKLwaY3N7+Mt7dT2MCaVGmazLIsW2Ii1gfvNaT00EskxuMLSPRcCmUlXSNG
	IvLrxGk45YxAfWLuHJ6567VfY+EBW+fR8Vdjrs10wpGC/wdyan6BcE3wv7DtLdeI
	HNf8py+pfnvRwcp433dUggsXGzeNhAJlmJGdyksUadJaNhXjy7r/ZuGdqv7PnehP
	yS9T6sBw04yxey38dyR1si5c+u87ZfaYs1vzv7hhfjCIdOzmx5wLVR2CkjYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996086; x=1722082486; bh=L9X+j6oqlF0JPaeEfO1fRYTaDQdP
	NGkAmU8Y+aRPhFA=; b=CKzmr79f+/nsqKbIhV4Iq8+ejhGLEdVijV+1IwGqX/EY
	dMf8Swz9Gl/Rg09MpRYskN6bUo+bAe85ZCASOUM8tSB9Jvh+AFNnuQrqHIkS1OLs
	1qYYmeHs3teurcqK4J7lRk089PyiYsM1+AcxjFUne0IGhzUTr5soAhJU8xr95Nju
	lr2pCvP9c2aZ+blvmU/YCol3rCuVyDhKYVzwGXy1nJ0dpYi/e8eNgFTZKfwFmYkV
	92ekP2WTFIj7uryxLxHf/HyF6w7iOo5AsaEST1TQfyfov5rtiA2AF6EuV0uo1CU5
	ub8eueznqYT10uEA87YIar/+39ZsylgcouifUKaZGA==
X-ME-Sender: <xms:NpOjZneB6IL6HIiEbptQNl7vJoMZUtlzL8-jvuRsxgjSCxyu-LQJqA>
    <xme:NpOjZtMl-nTTcjW_5kYs0x1Goe3M3n7Jz0thtL96JtSjodCbADTte15TShJLWNheD
    rHMpVzOquwvmidzKA>
X-ME-Received: <xmr:NpOjZggFYlztMKkKFdEXlbFFxq6ML0s7VJCjBuYtGmFLiDEND0DKOi2m-tPLTATO2DcO-uafD4DGcXx0ad89nMEs2nSP0sPWQjXMCzjSIfZdvqKX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:NpOjZo_AhD7rxJ_gaIhpAMcaNyZACDgNgBbCRGJ0V_rti5qXCECEGA>
    <xmx:NpOjZjs7nqXEDCY7a3YWmvnMb8zFlTNlMIR31G1FQN1B1UtHe4GIag>
    <xmx:NpOjZnHW4PIvSAKK3GIbvNE0HgtwyZkHgtNsDNpMvSlyP850hg8ICQ>
    <xmx:NpOjZqNlLouZAyE_6Y1esEPhaLEuQnw2WaACMXHhcASQRNqdoLmNMw>
    <xmx:NpOjZsWut0P0rEOtdkzo2H6QY_NLvwPy_WwPr1KYQAhG7VF1QpR39qbg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:14:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f805cf68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:13:22 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:14:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/23] builtin/describe: fix leaking array when running
 diff-index
Message-ID: <e8d86c01cf1316fabcec7dfacad55e1dc98baa7d.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q6L4SGF9GOlxL2Zz"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--q6L4SGF9GOlxL2Zz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When running git-describe(1) with `--dirty`, we will set up a `struct
rev_info` with arguments for git-diff-index(1). The way we assmble the
arguments it causes two memory leaks though:

  - We never release the `struct strvec`.

  - `setup_revisions()` may end up removing some entries from the
    `strvec`, which we wouldn't free even if we released the struct.

While we could plug those leaks, this is ultimately unnecessary as the
arguments we pass are part of a static array anyway. So instead,
refactor the code to drop the `struct strvec` and just pass this static
array directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/describe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 4c0980c675..3b61aa1baa 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -695,7 +695,6 @@ int cmd_describe(int argc, const char **argv, const cha=
r *prefix)
 		} else if (dirty) {
 			struct lock_file index_lock =3D LOCK_INIT;
 			struct rev_info revs;
-			struct strvec args =3D STRVEC_INIT;
 			int fd;
=20
 			setup_work_tree();
@@ -710,8 +709,9 @@ int cmd_describe(int argc, const char **argv, const cha=
r *prefix)
 				repo_update_index_if_able(the_repository, &index_lock);
=20
 			repo_init_revisions(the_repository, &revs, prefix);
-			strvec_pushv(&args, diff_index_args);
-			if (setup_revisions(args.nr, args.v, &revs, NULL) !=3D 1)
+
+			if (setup_revisions(ARRAY_SIZE(diff_index_args) - 1,
+					    diff_index_args, &revs, NULL) !=3D 1)
 				BUG("malformed internal diff-index command line");
 			run_diff_index(&revs, 0);
=20
--=20
2.46.0.rc1.dirty


--q6L4SGF9GOlxL2Zz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajkygACgkQVbJhu7ck
PpT+4Q//RqaRdDO/iXYrpoGEVNvnEuAG6MsmljoGf4c1Y2i/XC2RjbGVw6EIdxIV
EHADdrqGlBsrgtO33yw4O8ydP73lxB2Jf2nHQBCQj1wxsV+r5+ue1Ae6JU2m/S9x
QEcIbM2W4czXln0DTAWJRUwDKZeh603VPokKZFsib/f1eOxCF35MlI6wge8AtMzY
Ams81jwraAptZek9wK4qDZlpNKWCL9zTPefz/OrU4AO5rJ0RanlVM+hdRWu7VGe+
CUHTfVy6KyvQxAmI1IloHoK9qX/5tGdc+y+n8XW8vjocZc+EUjmmCprCiJdjG3ri
R5k5AFgVpMT1fohKhZPj/Iy+RmOzhNkMVI5hS0BlHDxsycDd0SyySj1zseb+XGIv
jZP7EnuErjyJWLBBmm8dETio7ePNmJWzUHJ+px7y03z9YdMiiQGX4/tVnlLjtY/u
ZpB1qvn43LoKLX/C2FJJ9I/YyhUfjOq7CZmoDYXdNeFr5kurn/510BDiIaWWp9/J
XSQtKmxFlnDE6RTA01TjeGRTulIeyBorrxcnrPZt+comjThXa1NteDg5P4xPxQ0t
hGPOXeumAd/3iGs+wD0Sb9SIyYLVYkCNq4YyV5bzh4Fg30jDsZg3OyZKH5FfNo7G
RLcuhGyZ7ZR1AUZpXiyRlxv+d5QcCk34Rl6q/2pCWw4gdaTVrb0=
=nq1p
-----END PGP SIGNATURE-----

--q6L4SGF9GOlxL2Zz--
