Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD6A155389
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863272; cv=none; b=FGK2C0YkahE8vvG05Drw2LtQZwIb5lzWpLiAtYYuzT7Ci28bYEqC6+wuQMxld7ACQWjWPX5gS6ccnuCsd70CGgfxTAeaGaQdg7gMDN5ipD32//5XgpA+Ov3y8pA6fqQRnDW9ZjxXSwmZe8Mi3GIWgRnvMd4k1pZiQ4oayYQnMTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863272; c=relaxed/simple;
	bh=qX/IKyWt4Lv5Yq2nDekfd8V2Byd0s/DJpfYdVYDT8Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEe1FuCVyYg7b3B5WPKKsVl9OQSbUBFiqHzoPOlarQfvQuvVbJujcnXRsLiKW8Fq9ESCtwJh1JlIWgBjJ/2N4xOHZDEZIHqWhPzV2LsEs51WbgwN7XODy8/7isfdCX2zH8Tzg3QPccgjFjaKtxM9O0SJsfIJAkznHHwaKdjDtAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N+CMLSLY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ABZAMkUa; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N+CMLSLY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ABZAMkUa"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6D5B1138FC79;
	Mon,  5 Aug 2024 09:07:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Mon, 05 Aug 2024 09:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722863270; x=1722949670; bh=4zs+Q2H/od
	s5lCCBD1XSTAQPJda7d+/oYBUpxcU5X30=; b=N+CMLSLYtOkyg4C2NLuomP6h8N
	gwSfBR9jNNGZUd8pNb9HJi77PK1S9XSM+B01UxHwQ6HOq33Mns1ORYSmXPAstdZp
	GS2IkXSLGW6v+9caT/Ei5Jl6jajmXqi5GRG9GRTa2kTQ2XIePDgYN6o1AbX9Gg81
	/dqzU/fpLvLK0trrXspC0iznxZQHYuEBmqLH9IZVbmPCMDxi0pt0/wnaEDKHGQOc
	yRGP2jiTh28XlsWPX/bPS5Y2xfhreYbVU8sZnUdXks9Km81pGwJo9vIko6/WhRjJ
	wos9+GhnbBLF/a+l5xVonZU0k9IhDAAnik2gCCwykzJReBZxSUbP1ZT4lL+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722863270; x=1722949670; bh=4zs+Q2H/ods5lCCBD1XSTAQPJda7
	d+/oYBUpxcU5X30=; b=ABZAMkUaG0QPlfqrEBUZm4niB75IvvasmVTgshm2GmlN
	Zztl7XKBJ6Wern0TSioY/rCdYf0b16bTDCYjVUJxzT2IcmbNJ9UUJ9Qt+wLC27hk
	CHlmX9SqLwwX/wjZii5JOad0UsNkBg98kD+JAibDLQFtkAiRqHCBhHfbXi3rvy5V
	amx3oX1my7MxzCsp9PWOhXfEUHNdlqv0kHpGi2j+FkW9IhRKhwjbvEdbc0ZyXTHh
	/23tn+piyx7wdqLWj2ShgUfnzuTbh3iWc4blQIpidnUClbalwj+xpOezEK2VzCLb
	ilLRgN1sQQQUQvgzeo4Llc/qdoNMsqmj9CBc+82P0Q==
X-ME-Sender: <xms:ps6wZnU1e0s6nW9QA17CSC_2Gc6IBua85QR8E0onCnBvS-Y0EV37Nw>
    <xme:ps6wZvn8TttYtLJT0nbDCq8o3fqGbk5aZH6PgykqEgfU8BBJ4qjlWTp8z344ktz3-
    UJxzZl9fQhTYeLtDA>
X-ME-Received: <xmr:ps6wZjbE1XJvPQMFHylSoIxUGIEojcjL_gLcTq5OVf1Wmt_JMc3xrOnomPScpjT7tDf6GtzMhVpq4jyPUSmY_smQX71TU56wIu3v2QPgWJBmwAwZXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:ps6wZiV7-O3INIiPr08JpDlrkpN4I8WoePkHOOlvON0YYEVF-MvaZQ>
    <xmx:ps6wZhlxz2nnK0vWbaALRWFR3Hjg1IK0GIn70X20oaRRGVybicoYsw>
    <xmx:ps6wZvc54t57fsbGmNTBE_Sol8bkyrRU-kU7vHl4U4S4n3Kqo_BpPw>
    <xmx:ps6wZrEpuDpIeEXFo8mKSIH6fxOku0-9leQ3Of6rv3sSZ5OSD-pi2w>
    <xmx:ps6wZnhHheylXeoldW0ToeiFAMwGwdemc30fkcqeresYEYIdo7iXmifE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 09:07:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 66ff5cb9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 13:07:48 +0000 (UTC)
Date: Mon, 5 Aug 2024 15:07:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/9] reftable/stack: refactor function to gather table
 sizes
Message-ID: <6d2b54ba8e448eaa2584976e1fe73c798842833f.1722862822.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1722862822.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TTy34bwMCSsplzL+"
Content-Disposition: inline
In-Reply-To: <cover.1722862822.git.ps@pks.im>


--TTy34bwMCSsplzL+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor the function that gathers table sizes to be more idiomatic. For
one, use `REFTABLE_CALLOC_ARRAY()` instead of `reftable_calloc()`.
Second, avoid using an integer to iterate through the tables in the
reftable stack given that `stack_len` itself is using a `size_t`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 737591125e..ba8234b486 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1305,14 +1305,15 @@ struct segment suggest_compaction_segment(uint64_t =
*sizes, size_t n,
=20
 static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *s=
t)
 {
-	uint64_t *sizes =3D
-		reftable_calloc(st->merged->stack_len, sizeof(*sizes));
 	int version =3D (st->opts.hash_id =3D=3D GIT_SHA1_FORMAT_ID) ? 1 : 2;
 	int overhead =3D header_size(version) - 1;
-	int i =3D 0;
-	for (i =3D 0; i < st->merged->stack_len; i++) {
+	uint64_t *sizes;
+
+	REFTABLE_CALLOC_ARRAY(sizes, st->merged->stack_len);
+
+	for (size_t i =3D 0; i < st->merged->stack_len; i++)
 		sizes[i] =3D st->readers[i]->size - overhead;
-	}
+
 	return sizes;
 }
=20
--=20
2.46.0.dirty


--TTy34bwMCSsplzL+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawzqIACgkQVbJhu7ck
PpQ18Q/+KKgmQw90Zw3uOL0fPFw2U9CbtZXTbAA/7xUD0TqAZcG2OS/45ZIg6Uxc
ArFKu4p+Jan2w+okyg6s/fEoQ5zunI6khb2DMiCRCu+oIFZC53N6+XjtDB1FrUMe
jkV/xxmarCedDYQdNY0OAfwfU1+ZpLN2rGQVOBgJN4vtrFGT7StRtmFL0TO5ilXG
HE61jU/RXAme7miDl5mgfbc8xDTYbd53kfxDpNavBv2VMoJdqLO218UxbgiopCCg
R9n7nfUHoDdmyFNSKxy0BlqMX5HXkctDdGSkBIAK0IZpzpkyCZPa2X0G7hUVwjxH
S+O5l6Lf/sJoLtPYwgC/JUTEP52RfF+Fi8Hvit12rbuQmyn5SbNREcOSZVo8rLEe
jFSd98eX7XLwg8Sb8+FosxhihgyjTlqfOSBVz2KxyNGaNI3cfSjxjHbZ7Jvz1nb/
C3STdsdk9cToK/DY8+7TKFyI4frhCGNCV7odeGkcW38wFZCzA1Hz3dwtiEKmu1Dp
ebdIL5e+5monmJVadmeDE5oS0DPAxudARUeorNlLUHrsKL8LNb6Q0gzcpKg6uG2H
DpsNAyhH52fSwF4gMQNwSTBsOdT9LiN99HgjMlRbctlcdFD+oMyqD/OmS92A5Wvp
IhBpYN7Gd2IIdsJcyLRSGFm4fg0V0n849Dwk5CAH0ehlG9D7f/0=
=x+Kv
-----END PGP SIGNATURE-----

--TTy34bwMCSsplzL+--
