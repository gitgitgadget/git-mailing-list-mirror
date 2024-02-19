Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364621DDFC
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353324; cv=none; b=XGuX/KCBU/n6UqrpDnLg0FDcFrYa+9MxLKk019J7l31bY93vxe2jkOluDhz+88bQjkvYD1M8pjE88SZX8j8FuNKiW6fKXDRGbRSW0Jft/UtbK1J0s3+/hi772phInVhb6vSHrpvERKKhuJydZXesVFo+Q0T2loaefkSI3jhtK+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353324; c=relaxed/simple;
	bh=UNRe/zx1fAaRumLPXfkrRf/YM5IqNOu9nyotLnq5sNU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT8WJ3BS6hlzQJGBKNnJS131401AwDzwhDKMBbBbsoYFWa6wOtJmkZWCjS/H3wPicyj6nqfGrNRk6Rae9MZN80uTtpiPjV9tquLEC5lzBxjHdOGaGaZh3VMfDCkqxm+GqSaaykzGKYFfOKBViIvyfTz0Saf1H7Ipizc0y8iYmIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B0a/Qys+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gyB0zFAN; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B0a/Qys+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gyB0zFAN"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 049EA13800FF
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 09:35:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 19 Feb 2024 09:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708353321; x=1708439721; bh=tmiOGPU8yh
	CpJxadSC9XbdznkuWdligMpfHitkzGzZQ=; b=B0a/Qys+6Ol8TE6/Ylnb58qh9s
	AZRLwFaOOTVBn6XZL3IkY3BkaE6+vIkNmQnUmpAHrC8b1tcxSfV/xH1GpZjcpU3/
	2P5LWcDcAHgz1eQM/1LvJ0PC1hjMBEs295dUfu8U9qhQn/O7DpMOGLsszr1PGiav
	RH9QcM+I3HP5bt2cs0tvt5k/CTt1lyxhvirO3PGjcDoFGWuWOFi2Fq5Im/Vx95QZ
	7cT/syxapvFoiQHhIQ1yeQqB8SqZKqr92l38Kb0gxOZnBcJwI8tJUXXLgMpTElb5
	rTVoiAL5sKOCK4K0UnuFG0fWWKakQAgldey45kf2vniJLTu4dK4bfKzCCqmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708353321; x=1708439721; bh=tmiOGPU8yhCpJxadSC9XbdznkuWd
	ligMpfHitkzGzZQ=; b=gyB0zFANnicvFkenP85EKVP3UxscsYCOUZWiZ+cPQ/05
	ZcQopybyAbvJDdnnleuSclIjYpCGSEOsWm2aD0g4r+RAIwNNLjcy9rAn7m8VRUw7
	x+f94fima5bPqAfORNsyi5yfQpgiWR/kN0FVjVZzrTotcQOI9Ye1DWdPatC+Tdlw
	fK83hPUs5Nykq+NRqgvYvJzudEZHuO6ephHgUPW9yqRMYQvM22BVMErrQkV9yJ0H
	MbaeHECoOe+Pj42yaJfo3zgOwv/+HYHuCokaxIHsSmwN1uXUgwphyewq1XCsk68V
	+ZS/ocPxN45v4FMDs1c06oltG98wGp1guV2TaFSnOQ==
X-ME-Sender: <xms:KGfTZVRTR3n9e8OdyfHLJElXeGyIlaa4qJQHxmK38Ih88Pku5MoMaQ>
    <xme:KGfTZewOoqkfXe-Bp-jgj-LEOozk70iCrBdnkB3TiLzWITtzBYDfkTTWM5SRVqy3I
    HBLkwJoORvjK8O9YA>
X-ME-Received: <xmr:KGfTZa26WDQnwMSAhHPtOqpMXjJrKyilMFpzeDHDSfD918PMcvUHomgy1KiCan1p06XzUgrafnyZOoKCom7k2xSjkKgjUJiSmcqdUJgEmbM4wSZs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:KGfTZdBV3mM_8WgG4vgK5RQoEaTRbmWDkeOZqDIjIliodWKnZpBumg>
    <xmx:KGfTZegtx_65wM4dWDi98CvHgXvEfXQE9O67JcwlVH09vJ2DAzfu0A>
    <xmx:KGfTZRqY03C1hC5MxnrYBtHUig15FC3H7-FIPBAemu3xYMQPKNUjxA>
    <xmx:KWfTZSZLXKnd5od7bsYN2Td0Vyy1FSk095f_u1MZxSZERD5y6iablA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 19 Feb 2024 09:35:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1cd84c37 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 19 Feb 2024 14:31:19 +0000 (UTC)
Date: Mon, 19 Feb 2024 15:35:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/6] dir-iterator: pass name to `prepare_next_entry_data()`
 directly
Message-ID: <12de25dfe24d61ef54e0ccc0ebd4cc69d73da50c.1708353264.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JUcczE0EWRC72ft6"
Content-Disposition: inline
In-Reply-To: <cover.1708353264.git.ps@pks.im>


--JUcczE0EWRC72ft6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When adding the next directory entry for `struct dir_iterator` we pass
the complete `struct dirent *` to `prepare_next_entry_data()` even
though we only need the entry's name.

Refactor the code to pass in the name, only. This prepares for a
subsequent commit where we introduce the ability to iterate through
dir entries in an ordered manner.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 dir-iterator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index 278b04243a..f58a97e089 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -94,15 +94,15 @@ static int pop_level(struct dir_iterator_int *iter)
=20
 /*
  * Populate iter->base with the necessary information on the next iteration
- * entry, represented by the given dirent de. Return 0 on success and -1
+ * entry, represented by the given name. Return 0 on success and -1
  * otherwise, setting errno accordingly.
  */
 static int prepare_next_entry_data(struct dir_iterator_int *iter,
-				   struct dirent *de)
+				   const char *name)
 {
 	int err, saved_errno;
=20
-	strbuf_addstr(&iter->base.path, de->d_name);
+	strbuf_addstr(&iter->base.path, name);
 	/*
 	 * We have to reset these because the path strbuf might have
 	 * been realloc()ed at the previous strbuf_addstr().
@@ -159,7 +159,7 @@ int dir_iterator_advance(struct dir_iterator *dir_itera=
tor)
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
=20
-		if (prepare_next_entry_data(iter, de)) {
+		if (prepare_next_entry_data(iter, de->d_name)) {
 			if (errno !=3D ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
 				goto error_out;
 			continue;
--=20
2.44.0-rc1


--JUcczE0EWRC72ft6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXTZyUACgkQVbJhu7ck
PpSaUg/+NcjNKj5Xd1UUMZP7EEqBUjj82McfliTQX7ihlGljBtLHxlXwu7K54nQh
qF7Ga98evi+h30dMopAID1MY7GVrR8k/Si7FeJILZ10ipNNLNeJobTfLx6juwuVa
utX7+ClUESroe0sM/X+uh4ms5pGuQZ8o6GPePEOSv+/CfmRuD7ZUkrUhIxgJ8Y/K
T3L/vE/fwiahd+kYOxSxH8R6jyeJ3isMaf9FPQYUX/uD0LjYwpgcC47DevIC0Ifm
GsBdEHTKzjQ9zSE72UvcFZawoWNi0SVDLGkAnOHaL7yRZeCwe9vX78XVxkCGlgbk
WQNZmDN1DfU3ikQwimFR+7fm2HjxhoiGDaUkRpvr2tY+PxSHGxmz+pJ7KZr1qiCs
iN0WU9qJdBf5CrpMse/IemReHQ8i6UxxF9qRUM1fne45LQ7bexw4RPns3xPLnk6O
kVR54fgsTpKMAPeiG1q8J9lGU31hC3J3Sie+XCP9bOAkvwXMrgzoGE62weBzKRcU
O7JdqzCyGj4ZpiDYjwJcWtmU8zsHS1pylTKBhOf79TGrl5GdG9vdnfbLTqJbBroL
6qZgbhHqVCmEdfP9z7Sx7Fq9aK1XGBcushz+aV6u9QMFdUbutMhXycDXajzN2dXq
n15Q+7Dq8K1xmjX95C4kVZHDP8q1KyiArUd24RKVJP6ObecV6/I=
=5ddp
-----END PGP SIGNATURE-----

--JUcczE0EWRC72ft6--
