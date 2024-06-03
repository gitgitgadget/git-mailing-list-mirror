Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC9E80C14
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407557; cv=none; b=eWWiMPwHXX3+aCvTPtbtRNtm6EL3fqse3jQIk1T+65EYTd2uQzAhjOTRRR7i0uGuBgdGxxis0qxayNe4oKOSHD573o460G1jBNhjJGC7LGsN13EHxNopYobpyf0/2XNECZypQd5bK93nU05X437F/3yQ/wLsRzctUTyqMU3MBeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407557; c=relaxed/simple;
	bh=94iHo71nf+9jkMm9ixTbbeLZI1M1CJKDQrYchixcwHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnYFQNCV8C2QsaSrxm5yTFSeFjx9iWcRQK81N7Qy9QFpw1NIPblTbl8F6BTp+0uaTcYwmmijebrZ67LdqShGIqFVrTE6PXdrUZg5TxbA4LuYyWtJ8mEZCfrLvRZM7bOx1gVsgboxSinXzxPxvj0RDMensr+O+uBp0hxs0hM3SiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NplOTfDI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C8bjADF9; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NplOTfDI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C8bjADF9"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id BFE4418000E5;
	Mon,  3 Jun 2024 05:39:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Jun 2024 05:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407554; x=1717493954; bh=uk6w5uTKYL
	w26VPirmIjnAh5gVF/vjNXsU928ozxrEQ=; b=NplOTfDIfLUcTnpCTItAu2AtAK
	ZkR3+OLZJR732uXSCI1516zcWpqu/6CAqVTDhIfHQIrSPw98j+dFOOuP6PsQaD5r
	xAz5wbcLnyIWYLyHcEfwj6r1rlsS5MPH/8PpoiYvJ6EZtW7zBB4mtuu88femczje
	EnGoUeXQIvuC1AgjBr8iwDjrHovN65NQwudhYqkD8XvulD0i9T25AC2w+txnHu0r
	56sb6ox/L+G4jjY5C0KYazYoM3OLK7in8WjAL1cVQdTUUz7JQv06/DndqwkoFwQQ
	vTfOAWPTZDnXOatXqJMZQj3eS8QLAtHH6xRmtTXNVp5nubLSVAwQUGsrdL7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407554; x=1717493954; bh=uk6w5uTKYLw26VPirmIjnAh5gVF/
	vjNXsU928ozxrEQ=; b=C8bjADF996r7smzUp5wI2/GiTWf8jNdWLNjeBr4xD6/3
	8LRP9NLm1MFypcJt6uLLSdGKRyv0ObHl5Fe+Oq3wgXEqzb923I696QtY9UEwjFDY
	03Yv7OWmAhFEGWnvLojcg3jhQyvYrSPy1r/6O0wRaMJUPwRHzIdkJYQHXIYW8imJ
	4Dm+z03DzAzRqNI5uAKuUUkFLCNC26jRLSedYVzaehXLEUc9E9JqTt+INmFkJLqW
	IDZl5pch58V6NMa51CjmZAmCF3vRzOuGYGA5BfRC8lFfLlmEZ4ZJWXaJAg2CBceM
	/F4hQvuMm8krWlFDwprGYdvSL+MEymL8NCHK3tDntg==
X-ME-Sender: <xms:Qo9dZuNYhFiq1hA6VN4jtb89TRxQ_LtIhcmqX-qBFMH7F6uSJBLNhw>
    <xme:Qo9dZs_mb6t2wSoWI4TjXpBeF4X73h9YQsLJ1COYaTh9g3Ai1LvdrKK0OSwYw-M8d
    IGToFthCtFhivEYsg>
X-ME-Received: <xmr:Qo9dZlSYN8jlOp77qoctPNaSN-EXVI9D1XstZ3fWiuvqFbkNByhae0kqMO5wSBvmj3RefQxVYC89oW7mAp2_X5XXIVSdtJocNxGl0JokqUg4GV_M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpefgffetfeeguddvkeeftdehffegfeetue
    egjeeihfekueektddtfefguddvtdehueenucffohhmrghinhepuhhpuggrthgvrdhnrghm
    vgdpuhhpuggrthgvrdgvmhgrihhlnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Qo9dZuu_2rz15FvRdnu9v96BIHbZU-wE4LIHYwnCyDFLXPjA2rdKHw>
    <xmx:Qo9dZmedeORt64nimusWMywDBKXgL6CTfbrOycDSTrHOdm4cgL2UiQ>
    <xmx:Qo9dZi0roJIB_GEDV1e1ysOJP7QNycbIuCmiY7TShWVeBcZzelqLjg>
    <xmx:Qo9dZq9hFpuPfXIMIQ5rYWOYpWCxq9GIf31nPXZuoIbchSMGAY5CPw>
    <xmx:Qo9dZm7pn3edXBPKCdfCUWE_PfHOtO26mB5firgHvX35pDooZ1Kn7t3m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:39:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ad4e072c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:38:48 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:39:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 03/27] refs/reftable: stop micro-optimizing refname
 allocations on copy
Message-ID: <085d90c8b63e937e3d76637ce2422320b5801ebb.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XGgG50NgiMAkIDwB"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--XGgG50NgiMAkIDwB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When copying refs, we execute `write_copy_table()` to write the new
table. As the names arge given to use via `arg->newname` and
`arg->oldname`, respectively, we optimize away some allocations by
assigning those fields to the reftable records we are about to write.
This requires us to cast the input to `char *` pointers as they are in
fact constant strings. Later on, we then unset the refname for all of
the records before calling `reftable_log_record_release()` on them.

We also do this when assigning the "HEAD" constant, but here we do not
cast because its type is `char[]` by default. It's about to be turned
into `const char *` though once we enable `-Wwrite-strings` and will
thus cause another warning.

It's quite dubious whether this micro-optimization really helps. We're
about to write to disk anyway, which is going to be way slower than a
small handful of allocations. Let's drop the optimization altogther and
instead copy arguments to simplify the code and avoid the future warning
with `-Wwrite-strings`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 1af86bbdec..e77faa2b9d 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1340,10 +1340,10 @@ static int write_copy_table(struct reftable_writer =
*writer, void *cb_data)
 	 * old reference.
 	 */
 	refs[0] =3D old_ref;
-	refs[0].refname =3D (char *)arg->newname;
+	refs[0].refname =3D xstrdup(arg->newname);
 	refs[0].update_index =3D creation_ts;
 	if (arg->delete_old) {
-		refs[1].refname =3D (char *)arg->oldname;
+		refs[1].refname =3D xstrdup(arg->oldname);
 		refs[1].value_type =3D REFTABLE_REF_DELETION;
 		refs[1].update_index =3D deletion_ts;
 	}
@@ -1366,7 +1366,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 		memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
 		fill_reftable_log_record(&logs[logs_nr], &committer_ident);
-		logs[logs_nr].refname =3D (char *)arg->newname;
+		logs[logs_nr].refname =3D xstrdup(arg->newname);
 		logs[logs_nr].update_index =3D deletion_ts;
 		logs[logs_nr].value.update.message =3D
 			xstrndup(arg->logmsg, arg->refs->write_options.block_size / 2);
@@ -1387,7 +1387,13 @@ static int write_copy_table(struct reftable_writer *=
writer, void *cb_data)
 		if (append_head_reflog) {
 			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 			logs[logs_nr] =3D logs[logs_nr - 1];
-			logs[logs_nr].refname =3D "HEAD";
+			logs[logs_nr].refname =3D xstrdup("HEAD");
+			logs[logs_nr].value.update.name =3D
+				xstrdup(logs[logs_nr].value.update.name);
+			logs[logs_nr].value.update.email =3D
+				xstrdup(logs[logs_nr].value.update.email);
+			logs[logs_nr].value.update.message =3D
+				xstrdup(logs[logs_nr].value.update.message);
 			logs_nr++;
 		}
 	}
@@ -1398,7 +1404,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 	ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 	memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
 	fill_reftable_log_record(&logs[logs_nr], &committer_ident);
-	logs[logs_nr].refname =3D (char *)arg->newname;
+	logs[logs_nr].refname =3D xstrdup(arg->newname);
 	logs[logs_nr].update_index =3D creation_ts;
 	logs[logs_nr].value.update.message =3D
 		xstrndup(arg->logmsg, arg->refs->write_options.block_size / 2);
@@ -1430,7 +1436,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 		 */
 		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 		logs[logs_nr] =3D old_log;
-		logs[logs_nr].refname =3D (char *)arg->newname;
+		logs[logs_nr].refname =3D xstrdup(arg->newname);
 		logs_nr++;
=20
 		/*
@@ -1439,7 +1445,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 		if (arg->delete_old) {
 			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 			memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
-			logs[logs_nr].refname =3D (char *)arg->oldname;
+			logs[logs_nr].refname =3D xstrdup(arg->oldname);
 			logs[logs_nr].value_type =3D REFTABLE_LOG_DELETION;
 			logs[logs_nr].update_index =3D old_log.update_index;
 			logs_nr++;
@@ -1462,13 +1468,11 @@ static int write_copy_table(struct reftable_writer =
*writer, void *cb_data)
 	reftable_iterator_destroy(&it);
 	string_list_clear(&skip, 0);
 	strbuf_release(&errbuf);
-	for (i =3D 0; i < logs_nr; i++) {
-		if (!strcmp(logs[i].refname, "HEAD"))
-			continue;
-		logs[i].refname =3D NULL;
+	for (i =3D 0; i < logs_nr; i++)
 		reftable_log_record_release(&logs[i]);
-	}
 	free(logs);
+	for (i =3D 0; i < ARRAY_SIZE(refs); i++)
+		reftable_ref_record_release(&refs[i]);
 	reftable_ref_record_release(&old_ref);
 	reftable_log_record_release(&old_log);
 	return ret;
--=20
2.45.1.410.g58bac47f8e.dirty


--XGgG50NgiMAkIDwB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjz4ACgkQVbJhu7ck
PpQZAQ//Z6W7AUyOY/kmaR73gT2LYMOLioUaCbK4tb0XfjtCfT+qxQJAfYiQbcK4
XefxwUxI5Uio0PuUpWRxGkPNZQTD1pBXpWkZYvRvfLR0uBWaqN9Q6OsmOmntpn25
LJVNQF1ctPSHUObLHcMq4BhYtGKemi624UWUBddy4KJ1Wg+WnZooTAj1USFJI/kV
H0VREE4kIo2bhZIcxoNitVLBvZ+uXB618KpdD7Ra9MWcQKH4P3xGv9Bdy69B/GLh
j+nbrfCLB7+xGEankpyd0Pvr4U58AvfXwzDfPjevGputzdsOCxNRknXCGnfYMfH5
EM/XuKZIhH4XL0AZ3Wm02SFu3ypx32ouXI5l6hvh/d6jkY08nohI69iMx012VClt
7zIBdIg24gLmy5u5izP1/GHRvn3LdIGPbRhIbdR3EewyZ6t0vbIzvTK9K4TWsRKx
kZg5KNc1915qVLCPp8o9lhIOaUC2quge4t6pondi2ZdPUcQ0yoMVr1lf3E5fNcYk
kEt3OC7dMhRnx7TA+CrcLHvO/rZCNwZt6q34LQYEvHGCOD5dZNC/HCsuOi1EHK4a
o0oVR98ypW/PRgSEhLBX9pkfAx+BgZ+Wd+NQT6Q9PHzo3NyI1aTbfFBih/6lABRh
+bbcpgFyvrB9e0+e3TOOFbVeY88tIoJGK1jWS+gLj0DSrrhgAtg=
=+1vI
-----END PGP SIGNATURE-----

--XGgG50NgiMAkIDwB--
