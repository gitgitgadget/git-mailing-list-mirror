Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023D74EB5F
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 05:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209723; cv=none; b=KE4WCzJU2FNiXXVsMhArbFPNka1b39Nkl3bfviZXge7Ou8bpXQtt/vnoBHYXdS+sFJ6vU2dVGiqIOkP/InBNU0aPECceVxnuV4KkaOggf5cc0JttKZlvSQttT7I9qk6tD44YNfZVOw2zqOeLxCUpD1V0JzMQ8DDNrwfC5bv622A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209723; c=relaxed/simple;
	bh=Z7ZfIwJERiY3rswyef9vlh0Y16kHKT6WGl5WLYGolYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrhTTEffes9b6tJyeutMMg+QlriWyyZVFdw89MYiqdrEfl5y8MXiJBPzaZqp/LO+ni2XsxvY2gysgybUpWUBnL7U8elLVGEeoX3lJI0xrman5qW+fMao5jtmpCJtJKxA2Ntry01+TA7UviRIJTRpT3gfUEZZHKsFMqrVdWvqZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cm6sqxgT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pP1r7+RR; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cm6sqxgT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pP1r7+RR"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 331DD114011D;
	Thu,  4 Apr 2024 01:48:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 04 Apr 2024 01:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712209721; x=1712296121; bh=NmMZ9hMIRV
	vexRSFJm5bUkxs7LZ3PYV5G9Q3+MeF3pw=; b=cm6sqxgTs3JX/xKifaDAViuBmI
	6hvzcZTyeaXV27h7FJQ08m77Gw8TaSntwEGWw1M82ek8HhFbYWkvXhIDYFAawHqj
	vtaAbQ3l3Pp0gZYfATIahjL/XQ1AkbETHCjVj5nJQUIu16mqG28BNs8/4H4WT+yK
	a73jpzvz6sGLIhDeC/wr7GQtNXYab/6LEvkH57hW+Km7WCz0x/yvBhfW+PIZCBe8
	UQjvdZVx8iJSQPrTYOjrtFWex3b9060IvF6mVvsLkWvXMl4Kz9oY7naGQ6/eDPdQ
	MkDPIjAWBeGXosWLgFPfTmDEWfqAFo0RfKJUZjV7QABjcCZCIyJbUHZjJO9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712209721; x=1712296121; bh=NmMZ9hMIRVvexRSFJm5bUkxs7LZ3
	PYV5G9Q3+MeF3pw=; b=pP1r7+RRFvSgYpH5rEA4TlW7b4C2lrPuWEBA8Cdyha+z
	XF7/SscDQUowJ9JRsJGvnklNaiHqAq5YPLv+jsqrS8K4HwB7eIpbWXGkHZH3C+a6
	NftJspaLx9o4XU/ToXGRRlVyosXG/MSTFn3KgbQfzeDa2uPL9KjXoTQouMb8+rkI
	u9VSZuzjQvXayC+ksiT63rmTlBaRHxv4UeHVNFjgophp+liRoUCtSpfzHSeNCMI8
	NaO1yq0nhfNWZJrU6saP1KWcxAtKtrw1Gu7I8azSpys9WU7jcHFNtgoFAj5jrzQu
	wSeSOn/zhqLIA8oVx7CgZWEmX5Id5vr7nKONjVPEIA==
X-ME-Sender: <xms:OD8OZvJkHS2NxWTqY7-gv3JglpHAr2yCP-huG0H8ayt2b59BtCCEYA>
    <xme:OD8OZjKDQ9HEOHCWnfVcWePFXdRxkqiKxgvQStm7rhsAxqmQCCGVvjXMxz9THK_zA
    lpAFaCntj0n9pFvHA>
X-ME-Received: <xmr:OD8OZnsgFgc8suEZ4oJRWy3U6wASLvhaf5GbdgoKIUpf6e4PB5bWzC43aK7vj1EqCXz9vTygvux1QzCZ_4qXzw9cXBpp6IG1uwRszOuNtFGwlIPO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:OD8OZobC4cXQGWZm2-DSYKK71PaI1J86DeYjljYdUmwS8onABN9x8g>
    <xmx:OD8OZmb7r9l-K5mLtxq_ylCpHaWjW8umhdspAbifDKX2rosclKCZbg>
    <xmx:OD8OZsBKuoJhJAUE_oOSE_KpSaWnGuqV2Aceokx4GeTyDkwqzwaxSA>
    <xmx:OD8OZkblF-RPKcXyiTAdrce2K1nZe8sXYNzEJBUUSNNL_f4T_f2KDg>
    <xmx:OT8OZtWWijDQvIh0EBNswpab0KvGAC1gi0q5r3Iqe-syTGrcOcz5DTm6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 01:48:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8d382d63 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 05:48:37 +0000 (UTC)
Date: Thu, 4 Apr 2024 07:48:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v2 08/11] reftable/writer: unify releasing memory
Message-ID: <41db7414e17201f85b476af5e0183e72de450310.1712209149.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712209149.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wfv3f0vkxvRKd7oh"
Content-Disposition: inline
In-Reply-To: <cover.1712209149.git.ps@pks.im>


--Wfv3f0vkxvRKd7oh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are two code paths which release memory of the reftable writer:

  - `reftable_writer_close()` releases internal state after it has
    written data.

  - `reftable_writer_free()` releases the block that was written to and
    the writer itself.

Both code paths free different parts of the writer, and consequently the
caller must make sure to call both. And while callers mostly do this
already, this falls apart when a write failure causes the caller to skip
calling `reftable_write_close()`.

Introduce a new function `reftable_writer_release()` that releases all
internal state and call it from both paths. Like this it is fine for the
caller to not call `reftable_writer_close()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index d347ec4cc6..7b70c9b666 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -149,11 +149,21 @@ void reftable_writer_set_limits(struct reftable_write=
r *w, uint64_t min,
 	w->max_update_index =3D max;
 }
=20
+static void reftable_writer_release(struct reftable_writer *w)
+{
+	if (w) {
+		reftable_free(w->block);
+		w->block =3D NULL;
+		block_writer_release(&w->block_writer_data);
+		w->block_writer =3D NULL;
+		writer_clear_index(w);
+		strbuf_release(&w->last_key);
+	}
+}
+
 void reftable_writer_free(struct reftable_writer *w)
 {
-	if (!w)
-		return;
-	reftable_free(w->block);
+	reftable_writer_release(w);
 	reftable_free(w);
 }
=20
@@ -643,16 +653,13 @@ int reftable_writer_close(struct reftable_writer *w)
 	}
=20
 done:
-	/* free up memory. */
-	block_writer_release(&w->block_writer_data);
-	writer_clear_index(w);
-	strbuf_release(&w->last_key);
+	reftable_writer_release(w);
 	return err;
 }
=20
 static void writer_clear_index(struct reftable_writer *w)
 {
-	for (size_t i =3D 0; i < w->index_len; i++)
+	for (size_t i =3D 0; w->index && i < w->index_len; i++)
 		strbuf_release(&w->index[i].last_key);
 	FREE_AND_NULL(w->index);
 	w->index_len =3D 0;
--=20
2.44.GIT


--Wfv3f0vkxvRKd7oh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOPzUACgkQVbJhu7ck
PpS3oQ/+K33mWcN3nukH1zSLGpCg9jxBRCkKEdsIj7pTMFjgvMx/5OGRgRhtj/En
5K0HUo6gUO84FlNfjAEfymPci4KCgH2P931vIJDYyOPDLJN0nAGA0bAmKXlaZ2xR
Agym/NOYgUJeF5nN+QZlQmr+cbLgGGvnSAfqM526UIjA1jvFboT17ll+zU8wbs/z
EMlKZL6yiogSRz9RDsk5M5rBywMoZAqXNgZckPmrOrIGTOQs2KkD1yqxLNtEP+su
hA/jjfA9A/X7dI6H+8HQS/tKNqRB5cfZoflMVxpQ4deaFYSw8mvoZbCT8auTUoyV
RZZ8UbHAocPPCgGdS2BuVA5a0qKzp5u7oD5dct20FOzLEExf/puMMgxPgb2Xp5Qv
v9j/YcSIfAd7r/KCh8LpItP8aFmui1yPSFF+37KzC/CrkHRnE/TXAxWEsnerg1ti
pBSmoY10baCGUgX3n/b4fss53s4TclDenKcjWXG3xIbpL6qug8YqL/RidxKjgcxn
ASEjjPLf69tqaT7r2WzLVPFB0DExurJzq4Fr7/zSUFWtfonSEj8KgDD0t2wNbbg7
48APAldyjFqiZFzuMLoqjaZVzZNPUkrDYEhmaCdTLw9bUkim4LdWajViBjO3ZJJ0
/5JTCI043rJ/wVyv57FWnu2kMgB8NWqXEqXhYLJJvXyhcOE+cEk=
=e24u
-----END PGP SIGNATURE-----

--Wfv3f0vkxvRKd7oh--
