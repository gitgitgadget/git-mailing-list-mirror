Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30D1EEA9
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122279; cv=none; b=qcE8P5sUk8dW1QX8SXKhL0heIlPKLU2QUf84Y3wrE6CUwOlMb+0pldPaGqo9Rukxk6b/o9U5yHtTZIPEkmOy31TI0CiSveNbvBQIcYxgbStUhqBN1NS0+MIp9DqaM7P+T35T9eod26ZYNzcxlEqarTXliIFvhWP9PNlpc3gIhrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122279; c=relaxed/simple;
	bh=nZ2k70qk7pL/dOxkjCWxDY0lQ/YI5VrngLidMgr5/rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELOumSUPlFLPoq9k5ml+18Xs4bYb+imhYSH7v7LGrPfjKgdIlHeC7Ve1SDGj3qMFU67Bj2SwjAQZtIagoVAnqlCNR44ynnz6VTZ83P97vegKvXHM7xZ+IVjvQeAulzH/KD3yw88alxoVkMoOMWvOPFO3/2OcrJn+D/E4GrbvMxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W9SmGmBN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fS+HXjHK; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W9SmGmBN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fS+HXjHK"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C8CFF1147006;
	Thu,  8 Aug 2024 09:04:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 09:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122276; x=1723208676; bh=dAdaJLyQwG
	cv3dUF/xqfs36/jGKXp/uRyU3BYiwSMjk=; b=W9SmGmBNpkEagFwIrzkVhGynJ6
	7Y9D+6IjYU/AeOVawWN0KgRifn9RslogSUj3vy7Ly4XHhP4ZjxwlM6kFbYUVLgYw
	iOFY9TUeI4alvumewItJuHiE/Ndd8ROyWUHyp9Zz/38j6Brbrl7Y4TffAw9WCSDO
	wUpjyJzLNs6XEy8z2whgWESP4z7q1iCOh3Ib0Uf1lN0hWuj+tg5hWPPRbSwXUS4b
	vgs8V775pWzjRA95KtzhLzd4bj5D4hbVtvaNc8CJHTmQJxF5qS+QnggdaO2PqYXp
	xiGGhzmnvrxxw4q2yejaaf1AfIlO0TjrSUpvYo2JBEQh09YwQXzwrXPtKXyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122276; x=1723208676; bh=dAdaJLyQwGcv3dUF/xqfs36/jGKX
	p/uRyU3BYiwSMjk=; b=fS+HXjHKVipDDTKNykcLeC2s9scsUIvtkNoZg7NW7pbj
	/I6Y8dEeC6w4nTs4/nVeeQ7Mlkwy+MMGAJFu157gqft1RNJdecfORa4ibxyc9DzA
	X0uTFgV8LR6YflUu0Nee9SYdKibzogPNs1QjDkMTkliO0X/HifaiAWH5EGmQTQ9i
	LO2FM7Bf71WeG8Cf70ZqOeRh5LZ6QhwQJSB2Vuh4i1v3eq94sxqm+Z/tq9c1LpGK
	atLTgPnL6lOwvOxM3P6ymDLz7WT/LploaXMTQaVOnlDKUj73kw1PeAdyp5KxL8kl
	JWT4MBpkSmkhh1WxXuiyYx9FkENh8T3a0w1/Zvqkeg==
X-ME-Sender: <xms:ZMK0ZiqfUmpek2yy9ht97PLAVYgLnQyCh0geMXgisWHhmv6apMUudg>
    <xme:ZMK0Zgqd2-44qI02GQJiUFMFr03VpGr8_cc5g-x_W2xff-W1FPVGHg0d0fO_aZhmZ
    YBbgF73HizGXtJK9g>
X-ME-Received: <xmr:ZMK0ZnMxMWvdZPaBAMY-4FGk7Mxt48aone4u0B3w1QfXOaGRkjTd2ooV1ERBA9xXNbfhnqv0Qhukeikd1Oe_Q8uiDigfTgnD8oCMnez-CaTofcc_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZMK0Zh7MRms6pNn2IvKrcKgcme2vgHFHvHUBDYWl77b6ROePPOi00Q>
    <xmx:ZMK0Zh6hc7SzBp9YZ_4RJPG39A_A-Jv3j7848HOVIV3sgjaTl22nnw>
    <xmx:ZMK0Zhgqi8SP66gMeHO7Pl9lFPQZE6fOzr7a8tMSG5htYrxc-LeCnA>
    <xmx:ZMK0Zr4N0McFpnwFEhSwDayadm7G40bQrM_hj1h4EH9s66VRtWYq_w>
    <xmx:ZMK0Zrm6NahZ10yimNiZtG3az4ZiV2SuFkbm88hca7u0844M25G6i6Y_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:04:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id da99e260 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:04:28 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:04:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 01/22] remote: plug memory leak when aliasing URLs
Message-ID: <2afa51f9ffedfa6dab51c9515f695ddfe0a9a4f9.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TFbhqp8/3Unx1Hi9"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--TFbhqp8/3Unx1Hi9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When we have a `url.*.insteadOf` configuration, then we end up aliasing
URLs when populating remotes. One place where this happens is in
`alias_all_urls()`, where we loop through all remotes and then alias
each of their URLs. The actual aliasing logic is then contained in
`alias_url()`, which returns an allocated string that contains the new
URL. This URL replaces the old URL that we have in the strvec that
contanis all remote URLs.

We replace the remote URLs via `strvec_replace()`, which does not hand
over ownership of the new string to the vector. Still, we didn't free
the aliased URL and thus have a memory leak here. Fix it by freeing the
aliased string.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 remote.c                 | 2 ++
 t/t0210-trace2-normal.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index f43cf5e7a4..3b898edd23 100644
--- a/remote.c
+++ b/remote.c
@@ -499,6 +499,7 @@ static void alias_all_urls(struct remote_state *remote_=
state)
 			if (alias)
 				strvec_replace(&remote_state->remotes[i]->pushurl,
 					       j, alias);
+			free(alias);
 		}
 		add_pushurl_aliases =3D remote_state->remotes[i]->pushurl.nr =3D=3D 0;
 		for (j =3D 0; j < remote_state->remotes[i]->url.nr; j++) {
@@ -512,6 +513,7 @@ static void alias_all_urls(struct remote_state *remote_=
state)
 			if (alias)
 				strvec_replace(&remote_state->remotes[i]->url,
 					       j, alias);
+			free(alias);
 		}
 	}
 }
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index c312657a12..b9adc94aab 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -2,7 +2,7 @@
=20
 test_description=3D'test trace2 facility (normal target)'
=20
-TEST_PASSES_SANITIZE_LEAK=3Dfalse
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Turn off any inherited trace2 settings for this test.
--=20
2.46.0.46.g406f326d27.dirty


--TFbhqp8/3Unx1Hi9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wmAACgkQVbJhu7ck
PpSyeQ/+OrovYh7AxnDZo8G+J1mFjRz4wYXNtr0Gox5z24Jng/Y/hcN6IxtEy4dt
GQmWI5l8DtgsHuWpB058jtO95bV1ti8njzwO9BNfJg8GUp0HtKxA+NYAeAfm3wW8
4lmL9YhEvUoHNZmqbm5KZGw868XgvJIJNIhV2lb2ygth0j2Kb3oF6mtFKrCCD78P
1fIN5ljKmeN6Lop+xVTirv0JbZvHIT1Hw55jyOOHYdNVko2bWshHI0jYsN3HSShB
NGrQcuEOYNdjSAoPgebxtASHog0psGew3DTfIdk261EkX+s1K03v5zof8mLNt/gs
6tkE+eA/piunbtL1qgi/IOITLh94BmllN2ZHhm64BOLJza3Uqc+3G9H5DgZ/MQ7L
AUCfA6R4oWvoVNecNZf8K/QSFrSN3VeVzHmEpHO7McrGcHN3TZxgCJKq29EGmsgr
qOYt9YdhMcIm9eJH5e1FGCK3ZnEBCffglzwuSE+4LVdHWc5cDrYAGr/srj/7UtgB
TZH1wbnZ0phT6+yBBU+ukpRtEBhjmNO8kHluY8Sla8zddxKGJAu183Geh+9GF9+K
68AyK7plR3ckabSHUv7fu1qH2dIR/5utLxgIHvCKqUduoS17rjL7ls0eKLF2fjo5
qGc4G/Qtcmdpy7h588BpR7ssX882DJxFNJf6hCVVhTaQjmU+Bc0=
=GCJl
-----END PGP SIGNATURE-----

--TFbhqp8/3Unx1Hi9--
