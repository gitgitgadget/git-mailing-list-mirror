Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B828DC3
	for <git@vger.kernel.org>; Thu,  2 May 2024 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632713; cv=none; b=nBqR1Jd/kGbL9pPaq1D/bTQAEZ48WOjSsXUCrN9E/FuxgLps2zF9Lf2206PIfp9TvJztuHzke6RghMAUgRJsrfPN3oNMxPX4ATQax3umTGwncWzMQWfaWdhFlpThOJS4v0C7NhvmZJkzQGYgfGAsvTnsrAtQQ10RqnJgzB+IUko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632713; c=relaxed/simple;
	bh=Zsi3P/Ka3OntghPbCcI74VWsQsYecX9nG5snxyHfOJM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWZ95hnGfU93vZ8ZD9rSgsSdH13ipvjmQ6caWofTnQ7Ct0mhwzqCkMV8OrBmwcJOrqLoxCdA6HhQDSO4kY/1tFw87Dk4b7iFIjEORaOlrQejPt8bwcgJMmbQAqM0JUfXi/qbaTk7yJ0W2jh4UjyP3DdEqeyv7dpObOUo2IrjA10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I7dzE6lu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UOd5XHw2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I7dzE6lu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UOd5XHw2"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id B1DAB1380394
	for <git@vger.kernel.org>; Thu,  2 May 2024 02:51:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 May 2024 02:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714632710; x=1714719110; bh=UGjiQj9FCH
	ZDK9/bLNveM9hY036D08Xx3Kn/ywiZv7I=; b=I7dzE6lu5LXxur0Vb0OsmlJPI+
	iysofW7IobIQhwgRIsMorK2WYmQguu5TNGHeqSWs9Qj/excelV2VEIfP2Mg4rRtr
	GpWapI6R0Wu/MShE3IFk3MIYpoPU8TVP89iUpHTqm933b3cX/w51ZW7fEzlJRMEN
	mnIt8FiSWgc9Vs/DW7dfAdstGgPzf/OtXAGvs9Ha1kSo1kRdQWjplAb/r5KEUm4c
	Szi+uCSRP6EbEstU/3uMxJrC5Y2ZLXKomJy4mGdYX+TwwkKBm2mNoYM+bCYvxn80
	UIwhGWqeV887D2tjskW+V1ZhSFpPVIZ7Xs4fze5pJ58CwyUz3pPlcErqv8Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714632710; x=1714719110; bh=UGjiQj9FCHZDK9/bLNveM9hY036D
	08Xx3Kn/ywiZv7I=; b=UOd5XHw2g+MUWPTtYVBk+YBbQwY5u+3FjjvAWBur2h/q
	c1kJwFtrwHQpOjB+7F/KiHfuOR4YdraeFTUvQVqMzWWjPs10rJvfkYNXgXO8Wz7P
	MTtMlZe6UWYssEPnMv7DXBlmTtK/n3GHcdBtOriPj0Jqf+FaBHTtid4rI+Mm7EPc
	/2LDJMQfrHvIAoWu9Yo9rhWeDihDWn4DKztsC64H51mWglDLMmp3l6nFY3fr/Y8C
	oDpQhBHcl3tVqNyCMxKxUnbfMvVCvDcgIsLqBlfmLYfYxYmzNjSN6b+HWLwI6KtB
	KSVjtE4mq4+rNFBjaDCdXtXtZL4Eo3Ye4zecwqF9TA==
X-ME-Sender: <xms:BjgzZs0d3pN0-4cukTZuYY3jGIOA_mjm1ec5Kx3gBbC4Y1V5CVbrag>
    <xme:BjgzZnH6Sguo-Q8QOWCOf7VM-y53JROPeSHwFlRfey5M-w2J1bga_SKp9rGK8WaRM
    4IKwaJiQAPEyOVyEQ>
X-ME-Received: <xmr:BjgzZk6AegH4mQTZahWUw0PEf47Ib-x5O1zeWooBTSOXxCX-9sooLqjNsvv6cwKaIZRxxLG4w4Drth8W5edISnOa8-K-Vp2aMqTMYjsZxnFESwE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:BjgzZl0hOuHhuaPT9U3jE6rwu5FvwkU6K6IVFPmYMUs_u1k8THOnEg>
    <xmx:BjgzZvGGucPlTyQacfIAXNoxXNgUXqcJIh9HtbTar7lOoSLXkol4UQ>
    <xmx:BjgzZu-WTeolpptC-1m6dvoEZRoUupG9MkLxtzEkZnTkHxZ3xPf1bg>
    <xmx:BjgzZkmPlVHbPJyjnDxnUVTbW-0RBmbZfMYWuIIXnRKyMTF-6osBqg>
    <xmx:BjgzZlMb_9MSJM2-4qvXKnCHAaxGef-R9f4NqFH9nctwor9w0UmxSRkN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 2 May 2024 02:51:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bddd43f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 2 May 2024 06:51:24 +0000 (UTC)
Date: Thu, 2 May 2024 08:51:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/11] reftable/writer: improve error when passed an invalid
 block size
Message-ID: <ef79bb1b7be05303278232a9e4dc1ab100a53fab.1714630191.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ajU7fE2GdII2v/TK"
Content-Disposition: inline
In-Reply-To: <cover.1714630191.git.ps@pks.im>


--ajU7fE2GdII2v/TK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reftable format only supports block sizes up to 16MB. When the
writer is being passed a value bigger than that it simply calls
abort(3P), which isn't all that helpful due to the lack of a proper
error message.

Improve this by calling `BUG()` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 7df6e53699..374b7d15ed 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -125,10 +125,8 @@ reftable_new_writer(ssize_t (*writer_func)(void *, con=
st void *, size_t),
 	struct reftable_writer *wp =3D reftable_calloc(1, sizeof(*wp));
=20
 	options_set_defaults(&opts);
-	if (opts.block_size >=3D (1 << 24)) {
-		/* TODO - error return? */
-		abort();
-	}
+	if (opts.block_size >=3D (1 << 24))
+		BUG("configured block size exceeds 16MB");
=20
 	strbuf_init(&wp->block_writer_data.last_key, 0);
 	strbuf_init(&wp->last_key, 0);
--=20
2.45.0


--ajU7fE2GdII2v/TK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzOAIACgkQVbJhu7ck
PpRzBg//RKspMmHB9jeT9CTWU54kKaQGj0iEFFwmy9Cx9Y0oXQVPA0R26VmoQT5/
Wfd+UpjYbzDOWIYy/l+0OTwXVYFJf1ySobOUhNNT/sHopVEtEKb4tte26hsUAeoh
b0pJ00Rb5Hv9ranKtUJs7BXvLoWKHgqwSnBVFpqTPlrmLbxp6JtZqg6TCzyu4cjK
ViLan3vJpdu4MAjKnhdMnakuzx9RxvS8MFsb3jB+noCZu42TqtbYM8Ul+6gFJYal
2Z0TFSeoaxTFJjRi/0II6kfKPQ8qeADE9+NI1f7QzE47gP4VfmhppsOl+KhEUahf
wC4PsKHJMZ0rKR0yFuwdlUdS10rEh9xOlfDht275o1Le5a9g8Nw9tUXfwGz5ewxa
zjcqKFRX8I3+1r1va20p5+BKsns8ThGUhtxq8gCLaGI+LbjW+CT07osSThhY1kwi
2zFQoTZsOdqc9DWFXuNt8T4c7etMDfT07HwbUGiAic8W6xX9ptgSxxLHL/sz01Zi
WPCwaAdUfFSCyYqLsyjMgto/FXTK9HUEDNWc0sWmTVNigx623jDXsJc4XaYPyIZR
F25uDEKl1iRTRNQLbZIjqobA0r8+SXKi7SfW+WQFKp97WM6yRNGMyCEatU41dmXK
/n8duuJ8aHHnapTVSIaoLZetw5VjjUV1lFedmj9FWNopgIv1cJ8=
=Jd44
-----END PGP SIGNATURE-----

--ajU7fE2GdII2v/TK--
