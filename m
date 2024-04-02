Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6A014C5B0
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078154; cv=none; b=HE18qPFx0W7q7NhkOtLT/gvRlRo6akb99cxoTqo/rJrMx+emhDANkfPviX29pICp43jlgZw/ISk8FArltgvDkJwKBbep4gu9tixTWvpqHaVfTwjYezFl7pZFOXJ6n3v9ima4YPI3uqBPFmuJY/4PvMUOQR/Apia84eDjhKaCjls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078154; c=relaxed/simple;
	bh=30qy1MZ2iF9MUReRNU/vmMZUjMCiLiXTxzP7zpozSME=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mY/w4tPjV3VA9/mbUuFcYK5xhBn6zGXNt8S34SKs8YD4477QgDpRDeGS3cUCy4tip/LzDRsqmpclLFqN3xOTlX2jyF5u+SDdpe3otxX+viqAoSZLaTKhtQBuR/WtFCBDmClUPiDGSPS7pZacjPTEA79i2tLgoz8JUtAQ/+qPDBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DG9yCKPd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=urd3OjcG; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DG9yCKPd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="urd3OjcG"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id B9E931C00074
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 13:15:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 02 Apr 2024 13:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712078151; x=1712164551; bh=uz3yVzb5GC
	kZoqE17BAKS3Zxukklm+tHl2P1Rpkb9oo=; b=DG9yCKPdEJtWDUiyN4Z16OMa76
	Jq2CKaeP1r+34FPp1I+BVfBMMHZwsPk3f2Afvy/eUKY5EviNmfg3CdHMDzA/xHCW
	irIGVUdMstMTNr4EUwZcxvCWItx0PuSBXOjoim0k6LUJlzZAsam9VYZVYM5eYpi1
	6EkNUGQmgLfgfmpfLt/+rf/EJzdtttltlfKr3q/OvL2GvFeKDo/62FnctmtlmCnW
	H1sx6HQMQ1GMwBgrr3P6s95yW2fcsiEjw04VR1SU0FUnV8t3Xm0ejGHpVjaLC4zK
	d0Q2EpBRe+K9X5BvYJJbN29jrh/te1+l7aB6GY8yqMm3L1he3gFmXJdyieVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712078151; x=1712164551; bh=uz3yVzb5GCkZoqE17BAKS3Zxukkl
	m+tHl2P1Rpkb9oo=; b=urd3OjcGNajzpXeVqDRyzDCr3pDqK0whW+00KplYtL0+
	q+R8+qbx0OGXJA57BwxNCSzFE7IhaX3p27WA/ffQ+0My0Xh4QUmirc+Sg7iIGJHn
	G6w5N/qs+woKrv6UiAvmEhkoiSa2+hEMc1jmOlkulV0sGalaKq4nSdXRogbmcCdj
	Wta50NOExJtbdnCan2hyEUeXM8YcDkwtnnJL5uR3FmRE/vQCe3CxV9ByOmUqhbpu
	DRDCJzjAbfeMxrF3ylp4MITAIIz2yBJ1Mp/oWLgpvZYRW1CFALaDOnOliJhHvqxX
	zI3vOwClycCQ4UT3Xk+Im66LRoUECtbPqW43Ea1a7w==
X-ME-Sender: <xms:Rz0MZgsJLcaS8c_HczPhe2imdBjJUhODDPieFQ5JHQEhLvPnXVzTGA>
    <xme:Rz0MZtfXZv-_ilrXeREF9k-9Zvt9PO4oGthHQQXLpMhib0ITovbUzWO7nYYcdf9LC
    Tp0KIjhuRWJxb4HLw>
X-ME-Received: <xmr:Rz0MZrxoSYiUQOU_YmrOMvEkbCsUYR3fK1umN5yNHT1IU-66BxmMfKZlpODv_9rb3Dyw3yn6FDqBui3ZStT3H0ndH1G5E9yPRJLkAOc7Jeslo9c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Rz0MZjPsjdWsqEw-KliOki3-0Hx-1YR6SDGfm02pn_x5yzINQPJBCg>
    <xmx:Rz0MZg8o66RaDI9E5z8Ut8HTQzWeBsRXjy1mPzxzI8Nv5vPiIhlsxw>
    <xmx:Rz0MZrUk2O6VegUzln13liQqupUTV-somVMGrvJKDP_jR0E225-a7w>
    <xmx:Rz0MZpfQeyJIfmsxe25vRLCLWw5EYFkqrZ074-LA22tZwiql0Y3jgw>
    <xmx:Rz0MZiKIJygitTt5K_pJQp5uW8QXrSgpa7K0p8mFZ1Zado86X3xQmQeo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 2 Apr 2024 13:15:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7f18546f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 2 Apr 2024 17:15:41 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:15:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH v2 7/7] reftable/block: avoid decoding keys when
 searching restart points
Message-ID: <Zgw9RByBo8sKpeRf@tanuki>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1711361340.git.ps@pks.im>
 <e751b3c536ace78f975b7d2553c22dbf6845a8d4.1711361340.git.ps@pks.im>
 <eiyd2nmwxjaetkux4prwm6adcx7z77ry3wc62art6gnfklvgmw@hox32vwuu5sj>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s1lAjbNgUC2XURh6"
Content-Disposition: inline
In-Reply-To: <eiyd2nmwxjaetkux4prwm6adcx7z77ry3wc62art6gnfklvgmw@hox32vwuu5sj>


--s1lAjbNgUC2XURh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 11:47:16AM -0500, Justin Tobler wrote:
> On 24/03/25 11:11AM, Patrick Steinhardt wrote:
> > When searching over restart points in a block we decode the key of each
> > of the records, which results in a memory allocation. This is quite
> > pointless though given that records it restart points will never use
> > prefix compression and thus store their keys verbatim in the block.
> >=20
> > Refactor the code so that we can avoid decoding the keys, which saves us
> > some allocations.
>=20
> Out of curiousity, do you have any benchmarks around this change and
> would that be something we would want to add to the commit message?

I don't have a benchmark. The problem is that the difference isn't
really measureable when doing a single seek, only, because seeks are
simply too fast. The only usecase where I know that there are a ton of
of record seeks are writes, but here the performance improvement is
getting drowned out by everything else.

You can try to measure allocations and indeed see a difference. But
again, this is getting drowned out by the noise for writes. With my
block reader refactorings (ps/reftable-block-iteration-optim) you can
see the difference when iterating through refs. Before:

  HEAP SUMMARY:
      in use at exit: 13,603 bytes in 125 blocks
    total heap usage: 314 allocs, 189 frees, 106,035 bytes allocated

After:

  HEAP SUMMARY:
      in use at exit: 13,603 bytes in 125 blocks
    total heap usage: 303 allocs, 178 frees, 105,763 bytes allocated

But yeah, it's nothing that'd make you go "Oh, wow!". As said, it will
add up when doing many seeks, but I didn't manage to find a proper
benchamrk yet that would be worthy to make it into the commit message.

Patrick

> -Justin
>=20
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  reftable/block.c | 29 +++++++++++++++++++----------
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/reftable/block.c b/reftable/block.c
> > index ca80a05e21..8bb4e43cec 100644
> > --- a/reftable/block.c
> > +++ b/reftable/block.c
> > @@ -287,23 +287,32 @@ static int restart_needle_less(size_t idx, void *=
_args)
> >  		.buf =3D args->reader->block.data + off,
> >  		.len =3D args->reader->block_len - off,
> >  	};
> > -	struct strbuf kth_restart_key =3D STRBUF_INIT;
> > -	uint8_t unused_extra;
> > -	int result, n;
> > +	uint64_t prefix_len, suffix_len;
> > +	uint8_t extra;
> > +	int n;
> > =20
> >  	/*
> > -	 * TODO: The restart key is verbatim in the block, so we can in theory
> > -	 * avoid decoding the key and thus save some allocations.
> > +	 * Records at restart points are stored without prefix compression, so
> > +	 * there is no need to fully decode the record key here. This removes
> > +	 * the need for allocating memory.
> >  	 */
> > -	n =3D reftable_decode_key(&kth_restart_key, &unused_extra, in);
> > -	if (n < 0) {
> > +	n =3D reftable_decode_keylen(in, &prefix_len, &suffix_len, &extra);
> > +	if (n < 0 || prefix_len) {
> >  		args->error =3D 1;
> >  		return -1;
> >  	}
> > =20
> > -	result =3D strbuf_cmp(&args->needle, &kth_restart_key);
> > -	strbuf_release(&kth_restart_key);
> > -	return result < 0;
> > +	string_view_consume(&in, n);
> > +	if (suffix_len > in.len) {
> > +		args->error =3D 1;
> > +		return -1;
> > +	}
> > +
> > +	n =3D memcmp(args->needle.buf, in.buf,
> > +		   args->needle.len < suffix_len ? args->needle.len : suffix_len);
> > +	if (n)
> > +		return n < 0;
> > +	return args->needle.len < suffix_len;
> >  }
> > =20
> >  void block_iter_copy_from(struct block_iter *dest, struct block_iter *=
src)
> > --=20
> > 2.44.GIT
> >=20
>=20
>=20

--s1lAjbNgUC2XURh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMPUMACgkQVbJhu7ck
PpSa7BAAhphC4KzCMueIk2oparQMbjUbNQe535qVyva2DsKgm9NOLtnOtN97WfgP
XTiqVM4/e5pfkpW4kO/HWQpUiO5KnR6emNyvmmsTeCiQc3JCJ8LD1c1O4b9IpB5Z
jeSF+wKnPQQQS8LG2LPP3I/1XKsJ8gGDfhV2jlbzF7a2knGyTAq5Nfg28KRXkRmM
7l7epNagOrcDD9hMD84YnwiPQUTIPvva6klMHohh2iTgp722fR+Bro3tUI2qEBoc
J3hmLTpqELl/+o4Zp/i+BTMRXGq9TNWEiewQ+7urGOtC6a2cPfMOzlniOHQPE4Md
Ty1ECb9w4UOy6HBOQhFxX3Tt7U95KnwWUnOyIvJfoH4jn9blAo60oWIDlpR8lRp0
k7wG4bqYlhkwIMmNXN+NALvgy+m9bE1nsdqbsGeEWOh59zG2fJXWQ2UbH109i0Jm
6UwAsGn/otFKKTiBcLDCno1jXg/+LaHXEG5mBf/sletM2gLIuuhZrdlZdGYmB0fz
bB0LUeUUUtV19iKsOnwPaAxKZ0fGu3ApUscAI5tcD/hqVpb8iUzWbjUMbw4AZkSt
vuf0ihWeWeIib5UukyNyATuWAwX7pta0m5a4evtZv6PcbC60MHMgT9dD3mE75o5L
BnZee+P/G5mXO4bK5OPgKunSZDj9okb4eHzYlx3NPhDLC+7Mt9Y=
=uTk8
-----END PGP SIGNATURE-----

--s1lAjbNgUC2XURh6--
