Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2AA2E85B
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759166; cv=none; b=mNANFmbC5VFnBDYo6szxzGAcINV8Z9mLlx5Q5otE3dsRGjteP7Wr/KFs9YEjTUIQBkUEVQLvS9BbOQTmn9pfRpD/JEqaT/zfhxMisb32GieaTljcnfvmR3ai5TPn8Zc59BOyho+vM3Th7gzr3CXHi4zpenA+8AxHwPbj1uWSCfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759166; c=relaxed/simple;
	bh=/zANBXOsq1/YbLMV4okvUK9/rDoFGNQifq5BK0uRDWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2yVglDltysNmTHVSk6lWWDEn3HR9Z8ERRIkqNawjjSIe/eb4sGu6dnbIjij1WXATNUvNAv48H5gzxf2xcl9bxlDgkczbNIunzUpbdmebOhoXFpiiWi0K/wrNyewWbFWvkujjHukqo6H5oztx0o1q7Vhtg7mQyC55ssztbn5Xbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GPneP7t6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QkwiEbjC; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GPneP7t6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QkwiEbjC"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8A3AB114006D;
	Mon, 18 Mar 2024 06:52:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 18 Mar 2024 06:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710759163; x=1710845563; bh=WZxBzlPduq
	nIBmJ6tAanerF0snzTazF0bsa5FuWVCJE=; b=GPneP7t6lUshkyTNPs0XwzbhLt
	DUCmkcQ2ypYSW6XXQBd5iFc74fnqnQPlEoTd7Co+RgG0Y168zJKpWO3K9XojaA6z
	5S6Pa/ctKhTkL7dG8vFnULB4sEfvwLoiZR0iX3pGkj1MSVIpEj2v7QcFPqZ4l17K
	AnpsZRq0ZoVF/vAXspbig5tdzjONRsMPyit6vOlDkDm2fouqQFrqW0RoZxwnt1oe
	ptvEW9pfB3Xys7a2eC4ads9ow4diWVxRii4oIzBPl375dXFEiEZ+L2quQqhTpkw/
	c20zU0bBw4yx8QCrj0yr2Lp5CjS1/KJy2vbUkZVclQIQ7AsXTLRKwci0l0xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710759163; x=1710845563; bh=WZxBzlPduqnIBmJ6tAanerF0snzT
	azF0bsa5FuWVCJE=; b=QkwiEbjCmG5A9SNB+oUU7ZUJwIvX1QD3DlTZsmzDOupV
	o8fB5/hGN5di3lj4H/JNsE0C/fa3DRiwrTlFVxXaq9osFsi9md50OFRv7JRio6Gp
	GW/JPwymOOytcUBxbwlAH/oNu/Cyz836m3CM1szYJwXVQ4OeDbEfFrs1ZGpjuBTY
	0r9v6adaYqozfz/649D6F9vX+ZFwZn6uqJZ/yulFYeo2X6DS67bDqy918RI4kH2C
	6Ln+DGDZYmjOUEAlhNikMDwMPphvDGjQJR4D7C9xFIid6VC3+k2wzZe3UchrM7GL
	X3qIhnJb2zgXEcGGSmkNRZdCRdHCHdLw+pXOgsU4Zg==
X-ME-Sender: <xms:-xz4Zfg02SDuAECpuCah_4pEyQSy31uRyyLhBrGKHjX6V6v5yPeZuw>
    <xme:-xz4ZcB5qE5gJFJTU4sjLMBoP5hPXl9kStg4Wio1zhCoJwDtwL8JqD3DiaM-gwm0N
    H45yAHM8ZGMGXDYUQ>
X-ME-Received: <xmr:-xz4ZfGufo_sVz5gIQipqMJT6GIpDBhCD7ZwUG9lXLoUua0MjxRA_PhgZAcSHCImhRvPQydH97VkgiETyD5esXqewH0pPRawwcR2C-pDAYuJHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:-xz4ZcRuLHNTJoZm6IY3KU6U7w5m6Pv_4SaMW7Amqnu0OJaN2_NBvg>
    <xmx:-xz4ZcwFY0Z0OQafZ7dCZhgb80UpYONS0-hN3Nxt_tlcFhI98jiVKw>
    <xmx:-xz4ZS5cVbDzpnAXa-pbWXVlo8URI_C8p26-40JdMMSa8nOj3OsYFQ>
    <xmx:-xz4ZRwlLxYd_da15s5V_pROPV-zuw4EE8h4p6vJ7_rtgZAge_TVfA>
    <xmx:-xz4ZY_Zj4l1s39sCXJQ8CqiDGVc2vl86hhE6tRh-CB7QJB68nEkHA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 06:52:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 57c14de8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Mar 2024 10:47:51 +0000 (UTC)
Date: Mon, 18 Mar 2024 11:52:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 04/15] reftable/stack: gracefully handle failed
 auto-compaction due to locks
Message-ID: <37a18b91ca998ca5ad27d17e86d286040b6e6ee1.1710706118.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wMNDMZCw7qudgGVt"
Content-Disposition: inline
In-Reply-To: <cover.1710706118.git.ps@pks.im>


--wMNDMZCw7qudgGVt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Whenever we commit a new table to the reftable stack we will end up
invoking auto-compaction of the stack to keep the total number of tables
at bay. This auto-compaction may fail though in case at least one of the
tables which we are about to compact is locked. This is indicated by the
compaction function returning a positive value. We do not handle this
case though, and thus bubble that return value up the calling chain,
which will ultimately cause a failure.

Fix this bug by handling positive return values.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c           | 13 ++++++++++++-
 t/t0610-reftable-basics.sh | 20 ++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index ba15c48ddd..dd5160d751 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -680,8 +680,19 @@ int reftable_addition_commit(struct reftable_addition =
*add)
 	if (err)
 		goto done;
=20
-	if (!add->stack->disable_auto_compact)
+	if (!add->stack->disable_auto_compact) {
+		/*
+		 * Auto-compact the stack to keep the number of tables in
+		 * control. Note that we explicitly ignore locking issues which
+		 * may indicate that a concurrent process is already trying to
+		 * compact tables. This is fine, so we simply ignore that error
+		 * condition.
+		 */
 		err =3D reftable_stack_auto_compact(add->stack);
+		if (err < 0 && err !=3D REFTABLE_LOCK_ERROR)
+			goto done;
+		err =3D 0;
+	}
=20
 done:
 	reftable_addition_close(add);
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 686781192e..5f2f9baa9b 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -340,6 +340,26 @@ test_expect_success 'ref transaction: empty transactio=
n in empty repo' '
 	EOF
 '
=20
+test_expect_success 'ref transaction: fails gracefully when auto compactio=
n fails' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit A &&
+		for i in $(test_seq 10)
+		do
+			git branch branch-$i &&
+			for table in .git/reftable/*.ref
+			do
+				touch "$table.lock" || exit 1
+			done ||
+			exit 1
+		done &&
+		test_line_count =3D 13 .git/reftable/tables.list
+	)
+'
+
 test_expect_success 'pack-refs: compacts tables' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
--=20
2.44.0


--wMNDMZCw7qudgGVt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX4HPcACgkQVbJhu7ck
PpRGjQ//c0fPegzc3PEo0SqabREvfwFp9DWKg0BMuS046rmtId42eRALyJjx76y8
RD9SdygpMWynUmMyl67YPVWkSxKY3PpVlKsUDUMLsFZw6YO+qgfuH3hqA+ah5L3x
UgY5wGOJkhZ5lQdudk+ZCn32Ti492N/fN0xfgFydKFJ5C7Y2bE+LqX6Is6+F9ORD
3VPxh+zCIHeLFVmoZtnwCFqQhKJ2o9tZ7TF37L2F7TJ6oJ8rZRNT+pE25uZsKOuG
Rgei1OIHW4pU2Kex35CP2nKurjvEOaAzWZUIi50S5uzoEL5skGsrVpFjEFm/SIOv
5GJwtgYjTy7RbmbBJJ5Znl+pk2s05BmvSDnhhXBMY8UmJQQxrAQml0lz2WBBP4Is
4LaH6zwonGPL3Fn8HYJhgXaZTTf+Q1DUFNNgMtCQXsulWbTQMv8ML43addIS4O89
d9sRnkHdd1hn0xpKqdetFTIrfxk0bbrdyaagERbdsXTOdsqNrtK0xEuaeNzVQJso
NG+VzyRdpuWB1Niim21h6lOAgo37jJB8LhB6vyyHMyKdBqQ8kuH8BP5RemRm+2QZ
2iLn9HQswQSwES0GHHq9xcJSpA4dqk0mYvSoqihCtEFFQghes1L+oE+YDmcoDo+B
l0/MfwUcrMFf/+jZUpkf4hw7GSyt9ilq6cIyrElb+SUzqSa0lUA=
=Q7jY
-----END PGP SIGNATURE-----

--wMNDMZCw7qudgGVt--
