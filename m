Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFDA6A8D2
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579071; cv=none; b=mN2OIMV2WnQwAJQ8haaf7rY8Jk1FW2tWuIpHbIXOfNbrFBdNTWQn5yR4qmlCy+vZ+vgSLf26BVq8+LEFIg7z0pDh9/sWgI7qQGrjIECgQ8lne0qiKTFABfTOsonvy3pI+5NDwq4IM5lZlPt6kwWhrIaxCHDf9zy4kgv9I54V1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579071; c=relaxed/simple;
	bh=BiBspI9+mrc6TFPaES0CgNKrmc+90BP7R/kgywU2R+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgByTIXoo0shis1xEhVLwdq3WSbYsKSwIuENPzCGkaOTG1RbHpSrY/zLqcGDdLST5b5HMPU2+hNvfSrlxTntHxClZv6mkRYa1nycoYMfjFFhAwnITAQjjcgfMVFuz/OwmlErPbSVC042V9Ho2RXSqVCWoGpARH7qWVX2Ni+bBkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ojkj3VHZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nWlLplmp; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ojkj3VHZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nWlLplmp"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EE374114011E;
	Mon,  8 Apr 2024 08:24:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 08 Apr 2024 08:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712579068; x=1712665468; bh=27ye/T69+A
	69LkuZbKou1uiTrdEOlDCBWBk9lXGjAiA=; b=Ojkj3VHZuM4ZznINKhiQ/nD5Kk
	YjAbdW/XGNVfNCWrJtLVy7OWtkMCuDzwGtxRNcVb8kwz1ORq7RzO8maK1bC+AIua
	1t7JoEw1Irojbw5aJtmTLt0WMmoznH71NlgE33zVmftnlC9BcRnlj1z16JyRghyT
	TX5qL0+8mQHXwRzSGeiXN4jYzm1hZQVwCmluy+StUnkAyqBc9gbLBAKT8q6Q3oVQ
	QmRbIMByxUfFvcapTAZK/OLqGahv/KjVu0QYNc4UoDo3vryYxNIBXJOOW2+VJium
	srAwy7SajU6Q/pG29fGwXMiex5AGrP7R8M7HW6j1gHWt2YtEPPSDQZAz1M7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712579068; x=1712665468; bh=27ye/T69+A69LkuZbKou1uiTrdEO
	lDCBWBk9lXGjAiA=; b=nWlLplmprMTeuHdh+8Fu5eYnpr/akjBVenU3i78Ip711
	K08xpMue9iV2Xlp9xdeli/uRsEyT5BOZrmgBsSbje9YL3GrQw2H7EN5nPjvF0acr
	1bQQljLD0uyTl3q2cIl9WI++aLLtN741gYD7KYl6DCoGJHF+VduhZ7cmdQ7a3HNl
	n0WtFkioibHEJkPJBJJF7ze5b2ySjaCiOCDk6/uKms9N3bxHUpJ7CG2PMnTD+fBs
	HZcJZsFoaKXWYPe+B4GOvu/Ra/vVQ2inL3P83Bfc7LAPdsfn8zNNJUQH1zE9AjzB
	PED1RC7R6VvH6jtlctCIuuVR/LHz5sTpiA5gwltKIw==
X-ME-Sender: <xms:_OETZh6sbnSWkt9jWC0Fz1hdPSmKxtvJI1Q2yvSE-uzmNBNKz7URGQ>
    <xme:_OETZu5YYPntbDTDIQZ2OTa-tgZS0o6rnZtsr4knd3qfjq_ETGXMU5uih2N-uN8PU
    6Xauuh3IDqrwH0qPg>
X-ME-Received: <xmr:_OETZocJtBT9bVgVSswVIijpjxjHbMafzrIHufuYjKDESOoeJR5fXcMeiqCqcVCdhIilHPDcB59TkpMgxWjrbr3ShH0RqgmGvrfbZ2DQ5NT6x8EnoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:_OETZqLEjrBg75P2V3jJJqMSJO8gg1zMBG3yJP3a-Fop_QX11M015w>
    <xmx:_OETZlIJD2_WrzqSkhQCkF-UB6Flv2u2d-GdOag26_UyXhKM5mLFmg>
    <xmx:_OETZjxARQAeCQQFpAADEonaXF87ff6SNNDGPXuqB9J73DLk7Q_CUQ>
    <xmx:_OETZhLTHwdzHGj-FmP2MJ3rG238pa8pAHbLKqB-JaLZdB2YRsEMjQ>
    <xmx:_OETZl3xJn4hggYBpZDMJNZwccnsZ5wvl9buplyMUJlL3ypByqIEgXxC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:24:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 77064373 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:24:21 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:24:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v3 08/11] reftable/writer: unify releasing memory
Message-ID: <76d4a1f73b10c0a62707abea80f38fe18f4b8e7b.1712578837.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712578837.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GSOMjuTpvlNMRTn+"
Content-Disposition: inline
In-Reply-To: <cover.1712578837.git.ps@pks.im>


--GSOMjuTpvlNMRTn+
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
index d347ec4cc6..4eeb736445 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -149,11 +149,21 @@ void reftable_writer_set_limits(struct reftable_write=
r *w, uint64_t min,
 	w->max_update_index =3D max;
 }
=20
+static void writer_release(struct reftable_writer *w)
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
+	writer_release(w);
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
+	writer_release(w);
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


--GSOMjuTpvlNMRTn+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4fgACgkQVbJhu7ck
PpRWDg//YLLu0BDEPsJwGjLpiUT6BN1GcEYSmdmVzxYwPJvGM9Ftd+riWYpzYkvp
Gn/IG5z9nfIuAGUaa5gragPkOavTjPE5WHTKI0GcKospSU4BLFNmgtQd7WC9zMb+
4OBKF8AvimctIHgnUOK/+s08zIn0VcSPoAZmEYh92utOSTCfctMASYQ1ICsS0MWK
4ONCTJcyUn6Kn7BUQ6o3eBwIbnNwUItcP+XnAUOasJRERK+rxn7Zb+anuaa9BVgE
JjNFVz2BvPvvggzXCWQ3Z7fve+nUrsUUDgxsF8w3iuwTqJNddVGpS7rvzbkZd5Dw
LCHiLVPEZDggECvJfK4HZdw6Bre+Phjn2J7jP753RNuui71s0cHQMI3TKy45LwsH
ZG2g8JLltDM/J7uB65AviDJcNsYDCdHaG4YhGXBsAwmbjmVMcD6jM1pJUZBaN0XF
kRArTul6UzBbykZ5CSSeRUWa1EPXsHCOVh8MoOlj5qUUiF/PGz8HR94hwRGTmOQ7
+wheGFqmnptLMhgP1SNRynnUNAIAycuhqsGRc9JeTlnLOmLy6YqBx11pTXxO+cO7
KGMRjx6WrXPOqWxMMUIo7zW/xX8RFIejdAaM7LioOHeO5eVFVTwQz87FNoxRGQ3r
ef+luTyEkqjMKFHnT1uiK8RfVoDIlUROrnFh/wK2QiPlZBfHnbI=
=Dpa9
-----END PGP SIGNATURE-----

--GSOMjuTpvlNMRTn+--
