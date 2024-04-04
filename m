Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B47F482D7
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209025; cv=none; b=Gi/yz/xaB45DtfzMpqHK+X6qOzI3dunOp5S31wuP4Ax9TXR7I2YBWjeWBcHQ5Aa3rVxGHBPgUdWypT3KwPdG0MufJUZLbMtfNh3Zmoh8ZPR9S8TwN0rdv07sovD5j2PelS2jsAGhccPj21LorXHt+4UCZB4/sFT9PI2JYpyMe/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209025; c=relaxed/simple;
	bh=Dyw4Puq//KwJGL1Peu7CbuPQxmRgJn2fboXnqKS9bgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIHEMAJO7ixQ3GEjBIIZld+gokLrhV013299pgmrAfYcbq7N1CuSlqMCGr7qtnmZh8ukUQaoeZWe2rbuhtwlcwa9yEGm42JarpkNCyHPyExpVo4tFzY1YUCN20O+88XQakotv4dxlFKHNq+m7H/Da0ILmJiXc6tYX75vVPSpyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q29XfjBR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g7UvwGju; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q29XfjBR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g7UvwGju"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2DA7B114010C;
	Thu,  4 Apr 2024 01:37:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 04 Apr 2024 01:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712209022; x=1712295422; bh=C0oMl04yKK
	vmOGSDyb7j7ADSbnUSFw+B86//zikPstU=; b=Q29XfjBRkLKiYGO4aJjwak+PPR
	kIquJTmZKsCB3cZ0idXP9ru9YPfx/lXfqDOJfwV7A8j1yKgfCNXhbx6XQxlPMfn5
	pmjbkETcqaemvJ65BBe2eFmP9ybYxS3mtO0QIheAFDkc7iGthWA+9NEFI+XzIf87
	bcQxXZ21pNeckeG6mYI4d5gUJr3EvR0JOBXDcnd4NJISWe/ifR9OJHP2bzxsMcMM
	peeIcusxyTrnE2gHCZckW7WTqUm46KR8Vs2WEPw0LnRDiWRnOEE5lQaSk52vVEMV
	CjddLuDo0u34mPNmpqmctg5zReaQ71EIMlCdOyOJ3NuOilawREJrqXUPmclw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712209022; x=1712295422; bh=C0oMl04yKKvmOGSDyb7j7ADSbnUS
	Fw+B86//zikPstU=; b=g7UvwGjuVvimUn8BLtAAglQhtbXE+FTE+R/jignp/VeQ
	8nUgxnxjlN2Qy+gz+Ikeo6LZ8UvBlJKXVDqMlf33FRZBuNb4Nuo/7pdbon3RmCUz
	5FUKN0Pp5QFrKt+I5qeCaNLmpGxkvstDddLi/5lGdg/7y/R5hLLoM/Yq4dDnkvJi
	l+jHLqkDe5vNmVKmUXB+OElz0+SgyEnKAMGQ1orsJ6ISNy/AnnD5jEY7LxBLu7af
	fRb2a78t2trHQHP15GS5hCEZuodFZG204IO/U8fek6tYRTa1S4ukmWraa3Nop5x0
	aSLluI1792v3cPPIGw5gEZyUcJxWap1TvqhIuE4YFw==
X-ME-Sender: <xms:fTwOZuv79k3MI0B38R3fP05M9uJovrwJeZeBqxjOU6HkYTIJ4OHobg>
    <xme:fTwOZjeBGGdr9xc7jCzEhL0Ek6c-PicUv4u-uUyU7GsyFay3zQDze9509G_qHAsiV
    fBUWPEYfwTF5mXyNA>
X-ME-Received: <xmr:fTwOZpzGmrHMehdtsLz6B2xoPSEGHAwHEm_vtrLDeJ__vfNeuJaWl8NuaQ8d7gOP-9A6eFUs-_DEXfg7c8lVLxGsiw-iMpYy0hGL8hXeMJCrSkSL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:fTwOZpMkClKF3T6P2fNz_OvUblSkya9rd0uAcfZSxzHOv0YrFZ_Rpg>
    <xmx:fjwOZu9o9Xjofo967QktxAuUs1Ef7z-35AYv1TUAbXxaG4TNg3P-vw>
    <xmx:fjwOZhUE_3t4qgQ_zRWH5ikAtRoOu90SgQ455W7DtpytgPbf7kOJnQ>
    <xmx:fjwOZncsOVXR1ixVvQ_IUOdIuobgIow8GqhNHNyEwRNk33ZNjR1JvQ>
    <xmx:fjwOZlb3Ged_hI-nqAuh8CwasBOkQtrh22taxKQPC_YWzp2BVHmdBt3R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 01:37:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 32acae8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 05:36:58 +0000 (UTC)
Date: Thu, 4 Apr 2024 07:36:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/9] reftable/block: reuse zstream when writing log blocks
Message-ID: <Zg48ersnCJqsk-Ey@tanuki>
References: <cover.1712078736.git.ps@pks.im>
 <86dab54dfe4501dfa5e50e5a01513c890b62bb4d.1712078736.git.ps@pks.im>
 <xmqqplv65jet.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yhXOK3G2u4BIcXYn"
Content-Disposition: inline
In-Reply-To: <xmqqplv65jet.fsf@gitster.g>


--yhXOK3G2u4BIcXYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 12:35:22PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > @@ -139,39 +143,60 @@ int block_writer_finish(struct block_writer *w)
> >  	w->next +=3D 2;
> >  	put_be24(w->buf + 1 + w->header_off, w->next);
> > =20
> > +	/*
> > +	 * Log records are stored zlib-compressed. Note that the compression
> > +	 * also spans over the restart points we have just written.
> > +	 */
> >  	if (block_writer_type(w) =3D=3D BLOCK_TYPE_LOG) {
> >  		int block_header_skip =3D 4 + w->header_off;
> > +		uLongf src_len =3D w->next - block_header_skip, compressed_len;
> > +		unsigned char *compressed;
> > +		int ret;
> > +
> > +		ret =3D deflateReset(w->zstream);
> > +		if (ret !=3D Z_OK)
> > +			return REFTABLE_ZLIB_ERROR;
> > +
> > +		/*
> > +		 * Precompute the upper bound of how many bytes the compressed
> > +		 * data may end up with. Combined with `Z_FINISH`, `deflate()`
> > +		 * is guaranteed to return `Z_STREAM_END`.
> > +		 */
> > +		compressed_len =3D deflateBound(w->zstream, src_len);
> > +		REFTABLE_ALLOC_ARRAY(compressed, compressed_len);
>=20
> OK.
>=20
> > +		w->zstream->next_out =3D compressed;
> > +		w->zstream->avail_out =3D compressed_len;
> > +		w->zstream->next_in =3D w->buf + block_header_skip;
> > +		w->zstream->avail_in =3D src_len;
> > +
> > +		/*
> > +		 * We want to perform all decompression in a single
> > +		 * step, which is why we can pass Z_FINISH here. Note
> > +		 * that both `Z_OK` and `Z_BUF_ERROR` indicate that we
> > +		 * need to retry according to documentation.
> > +		 *
> > +		 * If the call fails we retry with a bigger output
> > +		 * buffer.
> > +		 */
>=20
> I am not sure where the retry is happening, though.
>=20
> block_writer_finish() is called by writer_flush_nonempty_block()
> which returns a negative return to its caller, which is
> writer_flush_block().  writer_flush_block() in turn returns a
> negative return to its callers from writer_add_record(),
> write_finish_section(), and write_object_record().  Nobody seems to
> react to REFTABLE_ZLIB_ERROR (other than the reftable/error.c that
> stringifies the error for messages).
>=20
> But we have asked deflateBound() so if we did not get Z_STREAM_END,
> wouldn't it mean some data corruption that retrying would not help?

Yeha, this comment is stale from a previous iteration.

> > +		ret =3D deflate(w->zstream, Z_FINISH);
> > +		if (ret !=3D Z_STREAM_END) {
> >  			reftable_free(compressed);
> > -			break;
> > +			return REFTABLE_ZLIB_ERROR;
> >  		}
> > +
> > +		/*
> > +		 * Overwrite the uncompressed data we have already written and
> > +		 * adjust the `next` pointer to point right after the
> > +		 * compressed data.
> > +		 */
> > +		memcpy(w->buf + block_header_skip, compressed,
> > +		       w->zstream->total_out);
> > +		w->next =3D w->zstream->total_out + block_header_skip;
> > +
> > +		reftable_free(compressed);
> >  	}
> > +
> >  	return w->next;
> >  }
>=20
> OK.
>=20
> > @@ -425,6 +450,8 @@ int block_reader_seek(struct block_reader *br, stru=
ct block_iter *it,
> > =20
> >  void block_writer_release(struct block_writer *bw)
> >  {
> > +	deflateEnd(bw->zstream);
> > +	FREE_AND_NULL(bw->zstream);
> >  	FREE_AND_NULL(bw->restarts);
> >  	strbuf_release(&bw->last_key);
> >  	/* the block is not owned. */
> > diff --git a/reftable/block.h b/reftable/block.h
> > index 47acc62c0a..1375957fc8 100644
> > --- a/reftable/block.h
> > +++ b/reftable/block.h
> > @@ -18,6 +18,7 @@ license that can be found in the LICENSE file or at
> >   * allocation overhead.
> >   */
> >  struct block_writer {
> > +	z_stream *zstream;
> >  	uint8_t *buf;
> >  	uint32_t block_size;
> > =20
> > diff --git a/reftable/writer.c b/reftable/writer.c
> > index d347ec4cc6..51e663bb19 100644
> > --- a/reftable/writer.c
> > +++ b/reftable/writer.c
> > @@ -153,6 +153,10 @@ void reftable_writer_free(struct reftable_writer *=
w)
> >  {
> >  	if (!w)
> >  		return;
> > +	if (w->block_writer) {
> > +		block_writer_release(w->block_writer);
> > +		w->block_writer =3D NULL;
> > +	}
>=20
> This smells like an orthogonal fix to an unrelated resource leakage?

True. The memory leak simply never occurred before this change, but in
theory it could have happened. Will move into a separate commit.

Patrick

> >  	reftable_free(w->block);
> >  	reftable_free(w);
> >  }
>=20
> Thanks.

--yhXOK3G2u4BIcXYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOPHkACgkQVbJhu7ck
PpSH3g/+L8zJ/yt8ehFkulwW//Vyw4vd2w+AqNSgqETPbN67TxPBVsbHDf+3eism
Nk60fCndeke1Tnve9K834ZUu3/RjbeG+vdBcaRoVigErmRDgMtlKFyAYFi9Qre7a
U/DfJ5sPYdklbz5cDjRZywomoby+OiYsU5YSCqkirHA6KkBNAMYgoz4rkwNuni9k
qKJei9Aka8LmtXpoZjgJ1/a6KN1hYluvaLfzch/JOKqsKF/01F8Kxo2kCh/tSTk6
QwYMIepyt8M3D1uIP42ghhmWEReCqyCl1aYadBbCiuzEOLAYEXF7opWDm6eSf/Le
qvzRY5ciA/kstck2XIi0d4VaxVXbG4GEngwsxpgddgCpOhIrwuq0M+97VdDhAqPK
sqNpXPdPa41rWIpywfzJznX0WVRkOxPPDob0fAkW7O18Rhlh3SKN+EKmP3QX6mOy
eSRdJeEHhEhhAcHbsw49P9m73dsQHodWQ/K0sWgI5l33k/Xpgl01R+hwt9bN9j53
yjjV/vjm9Rp0UaYEdRiq4amOHz8oAcVYBd2lINUhsQGF1CZc/wKyucTD7luxRiPQ
DS3rf7rBeBBoBqnv1xpYhhLzpgwRmN1NaruGJF6BQPpQKOigNt50eGMkreHG9jVZ
sUdtkUDPLcurhnpTGQju5VQAJZXlBdekMBXB8AcWlI5YvUocRuc=
=MGJC
-----END PGP SIGNATURE-----

--yhXOK3G2u4BIcXYn--
