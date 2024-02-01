Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBA01586E6
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783128; cv=none; b=gZwBL3gXk7leClxq7g72yxVouL61kjnX2RDCcU0xpM7DbB7hvXOk9kRDgOI+Di6b6/3U3k9mbbIsCPisA+lqxF7sGXQkO357XFFaIwYiUUhHaUbpSQ28WIfx30SHsszwe7yUtqdG3784V4K0MWuo8QdBwKY4sa2ydZtLZci0XWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783128; c=relaxed/simple;
	bh=7V6A1twzfvQCyEKkX3cj7OvUNn0Kj0MyZjVGcC0L3/E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tea11465HjLOgvYHxOR+x3hjHxEAzAy0Y9Fa7dXAFi03YkSqtm+Y7NpHohDB+Geew8kZPkqDguzfMv8NBoXQhDsAERmmUoFbK/hXUcxiVrZZiyPOuMsjWh7w/YZKWb6XeTPZIdRWFuN1J6sDpb1C5zJqvQcDWk7qZFi0RgtPG/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A8dufSI9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pyVezRWN; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A8dufSI9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pyVezRWN"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 073013200B76
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 05:25:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 01 Feb 2024 05:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706783124; x=1706869524; bh=Vp5hTAHxFp
	J4LH+lE0B3pWwZeTpdMqvzxwvdZOkkwPc=; b=A8dufSI9R+eAQQtVy9RSLoHL/d
	BxDsOFGC1cWpbRRHteupQt6pP+U+W3s9gvTsJxhpTETmTKhV6/wk8L2g/Rp3N0Mf
	T+GThywBlCt4Yc4615NiX8oIVHxJOwolVlBJ4hXO+EGIdf2AyAmA26BL9M2JMOes
	+6BgJWQ/UuT5nRn8w0W0MJJt94tu2kikUV1J6CUQDrwLeGsV0/EJmL1ezRq2t//0
	5myKK+y36YvQY+MCmVSaHLAnVZ+AZRUS1JHSrnBpbcXdDQIUCqAJgqopMsH7YDpc
	eLGZf4BeiQAyWiWdxwQx+ADaFAnbvHgbkNnQw15+MU5+d6sN1GXtMhYskEzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706783124; x=1706869524; bh=Vp5hTAHxFpJ4LH+lE0B3pWwZeTpd
	MqvzxwvdZOkkwPc=; b=pyVezRWNt4cU5UH8lavdZE3VzL+7M26rDe8TE59GB3Ff
	Jl0CyKyxM8lXvzQSTbMJlXbu9QFNozKbLhMYLumBYSJqKcH9BHwivMOYqYt6FNeL
	y0iJ94m7n/pEqS3qBZUVN/YMkWMeRYp6CqIDsnyuibmyiqtIWEGCOp+k6zTWhK9U
	MsDKJVA9xRDEoLEsDbgPMzPCVBjwT5a7ISLF+BVZ/LYpvIG+UXCVGrpPjChUzrk4
	nFNalHLfQjoFtn3YHQFOgOW9qzHA8lyIQNkotQmKMhp9xdYdpFhonVFt2lf5n3vW
	cI1n/hWlSH73CZ87GR+MEa1e75CnkLAfpcsUa7Ya/Q==
X-ME-Sender: <xms:lHG7ZbYWyebZiDYCrgr7WMyqOrWfbgX5rqpU5KFUHpVJYvEXeGIG0A>
    <xme:lHG7ZaZLxPkyUynzb60utPPAxZmKErgGXm5FsbpiLWY4gB-rtt3gJ385BSMshQiYJ
    PZlcu_FN3oP1ZnC2Q>
X-ME-Received: <xmr:lHG7Zd-x81xIAydUq1xDfxi9mURPqeh5PgY5UqKyTYKrUO9O8AR4BdGCBdmwq8vJXIixuiBksyDyo7LTfdC7qScOnB9hcDcGCwNoI_eygNiR5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:lHG7ZRqCCCYBG5QUPg20xGZuSA8XClG1Jxmi4CaIioJRNEwzVa94TA>
    <xmx:lHG7ZWqFvo7jP4dqfUfr1SPwg74ncItI2mdCE7KYoFD1YrN3gMhhHw>
    <xmx:lHG7ZXSmml1L_tB2Rn6feKGXrpPzzevHJI5UdRbHiw96fWB22ppijg>
    <xmx:lHG7ZdSLa7VrX9LayPAokGxihnYynOqFi4A8eGW2ImU82Og6UvaTCw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 1 Feb 2024 05:25:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id af856a86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 1 Feb 2024 10:22:01 +0000 (UTC)
Date: Thu, 1 Feb 2024 11:25:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 7/7] reftable/reader: add comments to `table_iter_next()`
Message-ID: <2f1f1dd95e1cc360bde3547bd18e227a9c326e13.1706782841.git.ps@pks.im>
References: <cover.1706782841.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pxcd3/tq9LlF0NPd"
Content-Disposition: inline
In-Reply-To: <cover.1706782841.git.ps@pks.im>


--pxcd3/tq9LlF0NPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While working on the optimizations in the preceding patches I stumbled
upon `table_iter_next()` multiple times. It is quite easy to miss the
fact that we don't call `table_iter_next_in_block()` twice, but that the
second call is in fact `table_iter_next_block()`.

Add comments to explain what exactly is going on here to make things
more obvious. While at it, touch up the code to conform to our code
style better.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index 64dc366fb1..add7d57f0b 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -357,24 +357,32 @@ static int table_iter_next(struct table_iter *ti, str=
uct reftable_record *rec)
=20
 	while (1) {
 		struct table_iter next =3D TABLE_ITER_INIT;
-		int err =3D 0;
-		if (ti->is_finished) {
+		int err;
+
+		if (ti->is_finished)
 			return 1;
-		}
=20
+		/*
+		 * Check whether the current block still has more records. If
+		 * so, return it. If the iterator returns positive then the
+		 * current block has been exhausted.
+		 */
 		err =3D table_iter_next_in_block(ti, rec);
-		if (err <=3D 0) {
+		if (err <=3D 0)
 			return err;
-		}
=20
+		/*
+		 * Otherwise, we need to continue to the next block in the
+		 * table and retry. If there are no more blocks then the
+		 * iterator is drained.
+		 */
 		err =3D table_iter_next_block(&next, ti);
-		if (err !=3D 0) {
-			ti->is_finished =3D 1;
-		}
 		table_iter_block_done(ti);
-		if (err !=3D 0) {
+		if (err) {
+			ti->is_finished =3D 1;
 			return err;
 		}
+
 		table_iter_copy_from(ti, &next);
 		block_iter_close(&next.bi);
 	}
--=20
2.43.GIT


--pxcd3/tq9LlF0NPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7cZEACgkQVbJhu7ck
PpQetBAAg+lGpx2FyvcLBmVhOV/KYcGyvxlV05S9EakB4Cb2N6t64DPzuZ9YvC+m
MyVvEDBCHIE1d2gssA+z8v/0w+4mObltq9fTQ5pt9QxYEyRUV0pgR0+hH9WdFv3h
viS0jOaGri/PBAc2lq2iNPi00JqPkzLCVjYFqnuZvkYt0zWLaUSmrn48Fj3647SR
q/S2FCrNBoahx4+kfD4k6bHKtgzFbKMXoySz/MqQJsB06mdcWdy6hAwvBp2OXobL
MypEX8WmkTQpmqYPC+sa6m1fWR9U7OfcfAb2lr5dXALcUSPJZDyYG/2PzeSJDjc4
3v3FoqRhYyd2qgm3W7alHe0+dqRwxupTJmSCrovuvZWut0bgu9QcM5Xfnt0M4S6j
nEPoSmq5Ju3MwUh4WMO0kdTaXMO21PBiHpmx2uuU4JeJeGulXbU5nItXAr7S/fuP
fIfcAF+4Um7aXlUacF2tTV1HQzSllOxjgc+WtD5IGnFYOaXmNmgtgfcbOkGATr6s
c/qAVZLtMsp2BEY1/0Ux2NQUpfNaJQ7pFSxwxZWueoUpVWjQf2SF+T6NcC4vIGAl
qw82e9sp3e5JoPf+ycmdkN1eSpnJ8kEKLQ8aQB6I+ax/Slo0PjrECdulzzyBfW0+
eH8vdmoj8vtmyd2Roj6IAV4rO8xmcdC+FMnaHNXAWJwb3RwVrlc=
=UAPR
-----END PGP SIGNATURE-----

--pxcd3/tq9LlF0NPd--
