Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065206F07E
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579076; cv=none; b=tQ/qmRd1EZzKu91xyhjHqQ8Wl/7gws6hAaSxKB0ffJ2RtCA6motxpPV/uqqGo/zsnyV+tKAD9S8c5qVknw5p4RsP7nGZMRp9ClpLnBecTWm1757CsJInM14hPdTf0cManqDT9vm2FSeYjLCk8IeFwIUnjbWSi05SrHMH0Hs8oW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579076; c=relaxed/simple;
	bh=AO5CrgfjljE4bryFD0f5JDpPpjfmEkyjdnqHtqfWWow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOAYSLMfWz+7UJlIxsP40K6B1WzdHDjBKjItyRMyfXheTZenB1T82EwCE3NbjBFZyo+90MEWulE78HEr46r++cHpyVfVApRyeTJ+EgraYg+smKO28JVQbBiHTv6AuBjQQ8I03yPqwwp1Kk7Nq2YMsKY84fjcuYOf530rNuzX7pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VCQXthNM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I1Yw12KQ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VCQXthNM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I1Yw12KQ"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1A4951380108;
	Mon,  8 Apr 2024 08:24:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 08:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712579074; x=1712665474; bh=NNdXD3mgba
	Vw2Y+KS7JZpW31ipNkI+XAR16SwSi+EDY=; b=VCQXthNMww1bcNk//XrEwmiHJ8
	+Mf184kI4HhPhf78Go7pAEKbdEkGkQTfUbt8bEmfi4W1NubG4rEJyKgwnlXqNHh4
	v8QK/ocwXYSh8De62TiAJo3+5i50x/6rVFWx0YAZlmAzfolOA3uzM5kcvpRG0kFZ
	Rt8kF5OBaHWPn78MuhHV+qdxtAfBNYUXYln1eRd1kijL3zSjQ/vIzIUQdIXlg/IJ
	DfPdLjr3MO76D9x+KKT3FztPcIFce5WPCrAzZQoz/oWMc0OfgqSntEWvvnMUs/OE
	nh0QDYPT3bS3X38aFfsul5RLala2YfLiMPlMgGJBPWol/drgqU6wcuQA/wmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712579074; x=1712665474; bh=NNdXD3mgbaVw2Y+KS7JZpW31ipNk
	I+XAR16SwSi+EDY=; b=I1Yw12KQqa/zcVgVBx7K/NCtMcPlDYv+EbLxZfo+rB08
	hR49IAgnaEC0r0KcRFk+W7dOcHZ0b6+N79IhSrUarVq6ai31bh4tQIXK1xHpiurC
	8a3XS83BDFPWMOxHYmiOW6I5opI5IrAur9UOPsWeuzX1kQG4IdY/KntLrmfwXjY1
	SxjbV839Fl9qoDPAGZZEPw8maJ4C7V2K+DwnDYrSXMp8m1AwzvuofX4nEkJCoVH6
	3cK6Z4dfMrzm2SFOCYHRvv8okPAyi35p21cfy6/kIcvcpGGLuIcrYxjbcGjecb4x
	DmRavHmGBC6epyxoRQKXDm+ZaVNHeF8xu1Nx3RGJsA==
X-ME-Sender: <xms:AeITZinpWGZjbpq0YrKDf2CvAzLSaOtj7pahFN0noC8AvvJonWPjmg>
    <xme:AeITZp04GD3vauhYqbZRwo6_s9gz9KvwkayILJs59hr2-LLMzQHP_yBrZM2SQ7ysi
    W429P7OPlJWuI-yGQ>
X-ME-Received: <xmr:AeITZgqBSRSO7hYiChcHgXMgaDiUkTiKw4bQuQUCk-aFg4Zfv5VdfM3LmLnWYxStrGI-5w-nP2fTNHBur9O45GIGldWSwYSncTL7Bu_hYZ3KSAuHtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:AeITZmlZVpP0CGsC0qvLqo5sLdBLfbevto0o650XZLWU1hI4Wh9_mQ>
    <xmx:AeITZg0sKAcGQse-9HvlvmOXxzGOoWk9Ign1VN-5zgrDe7373tMWOA>
    <xmx:AeITZtsLkYYqxmxCSlyrRe05u22bC4AmqH8RemHRi5BepBmUOTXaoQ>
    <xmx:AeITZsVf6uaSKP4nTevvvNKaW78Ixxsv4ivahQE1-Zn3UAkAIoLBmQ>
    <xmx:AuITZtzxXhBif0sm7ikMo3eDbMmj0KiZ9PGBL5sjxYikwZ1CZZxyw46t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:24:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id effdc585 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:24:26 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:24:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v3 09/11] reftable/writer: reset `last_key` instead of
 releasing it
Message-ID: <722ab0ee281060ad43882471d472e31fc066a339.1712578837.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712578837.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5jPFtwU4fQ8K/JAD"
Content-Disposition: inline
In-Reply-To: <cover.1712578837.git.ps@pks.im>


--5jPFtwU4fQ8K/JAD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reftable writer tracks the last key that it has written so that it
can properly compute the compressed prefix for the next record it is
about to write. This last key must be reset whenever we move on to write
the next block, which is done in `writer_reinit_block_writer()`. We do
this by calling `strbuf_release()` though, which needlessly deallocates
the underlying buffer.

Convert the code to use `strbuf_reset()` instead, which saves one
allocation per block we're about to write. This requires us to also
amend `reftable_writer_free()` to release the buffer's memory now as we
previously seemingly relied on `writer_reinit_block_writer()` to release
the memory for us. Releasing memory here is the right thing to do
anyway.

While at it, convert a callsite where we truncate the buffer by setting
its length to zero to instead use `strbuf_reset()`, too.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 4eeb736445..10eccaaa07 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -109,7 +109,7 @@ static void writer_reinit_block_writer(struct reftable_=
writer *w, uint8_t typ)
 		block_start =3D header_size(writer_version(w));
 	}
=20
-	strbuf_release(&w->last_key);
+	strbuf_reset(&w->last_key);
 	block_writer_init(&w->block_writer_data, typ, w->block,
 			  w->opts.block_size, block_start,
 			  hash_size(w->opts.hash_id));
@@ -478,7 +478,7 @@ static int writer_finish_section(struct reftable_writer=
 *w)
 	bstats->max_index_level =3D max_level;
=20
 	/* Reinit lastKey, as the next section can start with any key. */
-	w->last_key.len =3D 0;
+	strbuf_reset(&w->last_key);
=20
 	return 0;
 }
--=20
2.44.GIT


--5jPFtwU4fQ8K/JAD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4f0ACgkQVbJhu7ck
PpToPxAAi5TSSMtyxGssN4K8wdlDmF7CQfY436G9OB+FXdcV+TNdzFzva3tNQ81X
ikWdJdc2EuCkpygx88nhBDU7Y21qBtusb/nJOXZGStxSbo6a2GiZ2HA5FFydarAy
g5o+HzrHoPAzO+VJ/SHwTaN4nUyKu1ahYBmWNf/jqNfrXc61i9XsdFaeugfn5fmQ
U+rzcsbdvYAzmt1Acv9L+nxBjFegzfS7uMAUbQfRIaN1VUvX+85Q9i+kghyb1P5K
1Y4JGTc5GZWKxTGzTjLWcY+TZJw5kzv4KHbQoq+QCxH1KGGsN3lmTPIm2zWk0oc0
OTtRGkh/fNB6o/VHhgDo7N3yCnQhGVc5X56VAjdIiGdbAJPTIdeXAQc/BN3iq0yj
VOJkGF88PA6BMKqURirUhgsYA450XIajSrwuftCT4u21t+xg31dx2MBKNrfNOFfJ
6lAGfF248BaUJKQplhhmU6Ugz2UVA+3xjOHejc0SYLS64mt8syRJvDvhWj4/NgMm
AYOwobThNk+0/VMBTKmks3Y8AW2ZAPtJavLi03ZD+5Pq84ZEpl3sNnb+ONW6Nq5K
/gXneHu5Axki6RH8Uo6eq938qlBt9Lpq4+R7kSuX8UVMZoV4BdegGs0bLkzT12I3
sUijOPo0OOlZy29l0w4jUR0f0NWktioGJOrXPFR6U1GSOFLq8hw=
=xOQM
-----END PGP SIGNATURE-----

--5jPFtwU4fQ8K/JAD--
