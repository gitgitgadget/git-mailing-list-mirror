Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E202061FE8
	for <git@vger.kernel.org>; Tue, 28 May 2024 06:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877914; cv=none; b=ide4qkDmGe/4o/sjRLD2Ith/CEeymftYYi8gZFQQ4P0BhgorWp6kuyULvUcyUIo0i/3ODPqYFOsbk3xrjUuq/FxDfh6nEJQ2ezo5WJrNWbRU/T0+7X2i3fsDDw7TSZEUT6FVmllf5ldq8fiYUiWu4L4A7tMgXI2If2qzKBWnr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877914; c=relaxed/simple;
	bh=LRI1dHBLKmgxfkkpF5Mo/Q7pnJZmfIq4Ew3kPsExY/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nO3v66shMceBrokx1StoFeRtTSb+AMmdBzewyCdWsmFmGjOYHnJoEQdrreMN83qhZVYIylKgdIr9ti+FLR+DeJTnYQ8LMgjzxucl6l70rK0ldkcqm+LwW3JAhItUAAZ2peuPLJo0SN2iHaoE3oLRRHrcfWH1HGx2OAoI6yRudG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aR5WhfzW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=isMhRNrv; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aR5WhfzW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="isMhRNrv"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 04B5413800A5;
	Tue, 28 May 2024 02:31:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 28 May 2024 02:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716877912; x=1716964312; bh=167YRLpudP
	Fy8Wnmw43oFng2aVUg+Qzo1OsDMCm+no8=; b=aR5WhfzWk131ubAvrBK/i7PxG7
	oGRvJaC+FnHN9az59wAioOJXIsJMpe9p8AdQGIJeR0gJPgGYX85g2O3HisCgwLF1
	/j5S5LzCL2wmRSCm4YYK/W3whlDV0v/W4rtE2sTQGsI8vUiO+3cd7bPgvZHPJDsd
	D08pzKb0f3kgYc5IEKFMazkN0VTfpFmuRAOfC9s7NW4oJCD2PdwkqfqJoyUHAGX1
	2X2tQgAEuAgqQWxx0Jmmhd6ADsuWyBJ0YJU4ShbpCm5PdMZ5idweeH+sjwdWWvYm
	4LBAt/424VRklP+rMG4dt7O+7o+Q2CXJeierqquDV591yHP8rKgR5sQlYfPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716877912; x=1716964312; bh=167YRLpudPFy8Wnmw43oFng2aVUg
	+Qzo1OsDMCm+no8=; b=isMhRNrvkCW1HYOR6gW2Li+IK8YtKdnGnn8o8VAx3q7O
	oJ4ccm01ogsh19lJqExUNNZ1u4OUT1S1XHzSj89wA3s7OW41VPlcAqAfDUAuN1f/
	e/a5O/0HGsLOZqBSIe8i7VUmOGfKrB7fpI+93e9uUvEloXYn2TglAEHBm/xZPCG/
	8g7fIITrhZF51AgcMvuE24Xtr/DeqTQkiN7owXCjf6b6rIoTeHoFAeVDs3OMYkFf
	FnVMNjFe9/3vwbSOLpLe3CKoiERa2LWnV9GHUaP3OLljS1c6kU9TGhrS77qQBtmB
	t96E0TCjDNceDMZSnPqZ3rmyClIZcMl70k0R9oP71Q==
X-ME-Sender: <xms:V3pVZtjzy4C154vF9zKIkt69nNV1IBZh684YyMQRKthh7JFWzYtpHw>
    <xme:V3pVZiD_AHc_aosubmdc7-xoddTZYwcWR2a70oh8f99og2FmaJDSiEtTH5xqdHAU-
    g92BEk52OjfF0xoxg>
X-ME-Received: <xmr:V3pVZtG4g3ndav0Mx-ag9rTRUhhBKIUw1irYxd41UZn7bQwQxw6vHN_nDFuQoIiicdxoixIaW7kCtC0CAZkVslrUK7-Y066GzerOKfdE14ffML-O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:V3pVZiTjsPjBmOQBkFCQzAyL_14BEFG3IdtO-FKzdAzom83nth2NpQ>
    <xmx:V3pVZqzS1qgTjahsmSwzgG7B8ZP1yBb4y70cVJ4GP8gb9c2_Dp5hQw>
    <xmx:V3pVZo7XNMTF2eOZuzFISWCgk_uADdv2xOLurhNzPnBWs-mvrTC0lw>
    <xmx:V3pVZvzsrlGERl9WjIGLtdWOwaXNfiP4v-Fnd1q7P-rSgOPX0xf_4A>
    <xmx:V3pVZhor4Nu3tktwnnh6D4mB868Qhb_l0nrkNF1HpxcWqmHWRsweLNjG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 02:31:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4add8acb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 06:31:39 +0000 (UTC)
Date: Tue, 28 May 2024 08:31:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 08/12] reftable: inline `merged_table_release()`
Message-ID: <c7e8ab40b5191d9721cacadb7257aded3dd90db7.1716877224.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716877224.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Rw9jTTDSOOvXkQNE"
Content-Disposition: inline
In-Reply-To: <cover.1716877224.git.ps@pks.im>


--Rw9jTTDSOOvXkQNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `merged_table_release()` releases a merged table, whereas
`reftable_merged_table_free()` releases a merged table and then also
free's its pointer. But all callsites of `merged_table_release()` are in
fact followed by `reftable_merged_table_free()`, which is redundant.

Inline `merged_table_release()` into `reftable_merged_table_free()` to
get rid of this redundance.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 12 ++----------
 reftable/merged.h |  2 --
 reftable/stack.c  |  8 ++------
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index f85a24c678..804fdc0de0 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -207,19 +207,11 @@ int reftable_new_merged_table(struct reftable_merged_=
table **dest,
 	return 0;
 }
=20
-/* clears the list of subtable, without affecting the readers themselves. =
*/
-void merged_table_release(struct reftable_merged_table *mt)
-{
-	FREE_AND_NULL(mt->stack);
-	mt->stack_len =3D 0;
-}
-
 void reftable_merged_table_free(struct reftable_merged_table *mt)
 {
-	if (!mt) {
+	if (!mt)
 		return;
-	}
-	merged_table_release(mt);
+	FREE_AND_NULL(mt->stack);
 	reftable_free(mt);
 }
=20
diff --git a/reftable/merged.h b/reftable/merged.h
index a2571dbc99..9db45c3196 100644
--- a/reftable/merged.h
+++ b/reftable/merged.h
@@ -24,6 +24,4 @@ struct reftable_merged_table {
 	uint64_t max;
 };
=20
-void merged_table_release(struct reftable_merged_table *mt);
-
 #endif
diff --git a/reftable/stack.c b/reftable/stack.c
index a59ebe038d..984fd866d0 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -261,10 +261,8 @@ static int reftable_stack_reload_once(struct reftable_=
stack *st, char **names,
=20
 	new_tables =3D NULL;
 	st->readers_len =3D new_readers_len;
-	if (st->merged) {
-		merged_table_release(st->merged);
+	if (st->merged)
 		reftable_merged_table_free(st->merged);
-	}
 	if (st->readers) {
 		reftable_free(st->readers);
 	}
@@ -968,10 +966,8 @@ static int stack_write_compact(struct reftable_stack *=
st,
=20
 done:
 	reftable_iterator_destroy(&it);
-	if (mt) {
-		merged_table_release(mt);
+	if (mt)
 		reftable_merged_table_free(mt);
-	}
 	reftable_ref_record_release(&ref);
 	reftable_log_record_release(&log);
 	st->stats.entries_written +=3D entries;
--=20
2.45.1.246.gb9cfe4845c.dirty


--Rw9jTTDSOOvXkQNE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVelMACgkQVbJhu7ck
PpQBVw//Xa8tuICcv8Pj71ANmEDLomjpvw/a93vNoH1mVKUGhT2b3Jb0RGWML/ra
UBsGUD0L/7hH97fajdf8EvlVo2+BSvCVRCxjP3fFRT0K+DVDvF5uarPDemkXa+xq
71pMQVRJ//RY+qn0gHWuC9qc0SnSZGZk3aZCvtXaNKW2mmB6yERWxvc3eb0BYs66
9COyh0kd/c87NuQs57av706PSxozeP7nsXDA8Ke/1YsaI2RinQHpBrkt/1v+g2oz
IVY2oR0AWhoiDQ7jsK0dufFx0wp3mOrvC+nd51se3TMxdqqZ83NbO/aUFKqH/VYv
Z2o7A+ItRzjum0jo0+UZkYYnwTRsTXdHkED+WW5J66RPJYoBv+6rGYRUXxt8IVg1
h3jQRJDlVv8WnF3j2MZcF/BHzg9RY3BWnE+b+kYmQVOejFirvGnWfGRqLTOYHP7o
TG3WDWyURDoKV1ZN38NqKeGV+WOVD/8lxGtriH5nl6Rwkg4O59dit9sLTvMu3Hda
85lHYEgAHb12yTr9ARZflEuZgGSNGJJHq0AclxYmtAUnTLqhLn8nSO6C0RRofwZW
yQdkLYjWfa8DGzInclHpToS+CKYDjWQ69H9nXOqficnevM1snEFQIviGoVVF2ioh
n3vvKx4yr3NBG6ty2Gm3tWw7MQftCQXknFVB2TY83kRuyk7cLwQ=
=+BUC
-----END PGP SIGNATURE-----

--Rw9jTTDSOOvXkQNE--
