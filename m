Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457B71474C4
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347376; cv=none; b=ofZouXJIubcIqR3bIkQmTH+pZeTj8HYEjR6xcW6znYaApG13MMPYLH5TSEDQQNIBJofTlOtfBQ1uOvoYY3f8LkESGIryA6XzgXG4puRmltXKu0qmMbrqP+OMyDEKOfSSwami4eSVi1dQGIkbqMYHu61IvakWQqvrbIsWIS/RvAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347376; c=relaxed/simple;
	bh=E3dr8hn0At9nAgLD6263B/5rIVxvFsIMENDtyVJG/TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDd5rfnVEajyF/rh3eXUN2Sjm+kXG991tiUcQnAX4KVyjgUcM1k12rGSW4ztIl87Uvq+UXA9zm2r7oQv7pYfk6f+zDdXfBSPGHTSTtAuC59iaVCO7NTp1OxID12Bfdn5gHj1DZsyeI0/Sq/2hU08z3SxWjBtlLa9TT/lz/HLL/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kxbjZPr/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ae8vGCIo; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kxbjZPr/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ae8vGCIo"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3E9041380232;
	Fri, 14 Jun 2024 02:42:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 14 Jun 2024 02:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347373; x=1718433773; bh=y6vwfFDcsR
	8/Ws8PJc5KuaNK0Yel1ifREMMUfqf85Rw=; b=kxbjZPr/b8gWByAkIaFvWnxxot
	WbhyCY0Lf3cFsS6uFNvTAuzxvAfC5anZglPiKJSS48O+dmvraGDTLlV3aBJpaL1/
	L/L1R5OQq89XAvXBbZexql0w4xbOY0RcmWYEUH0xdPtCl8swb8i5oK7cqmvCQFYn
	Pi+4wSRPlcKt5Of5/VGLZD/zESbtP1ocYn2ij/O0v6AfkHtxdhbfpD2AsYQ7nBsg
	J4tlsUXsCHeMqmobVBL7mi7igAQH6VzmKwDtA6g2QFbgozWophmkvGlSGVEzgaMm
	q0HpStYhrwxrQjRJ1qnNWgmy7uZQgL5t2G3xXgYk6b+/mSDgouaSFK5N8HaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347373; x=1718433773; bh=y6vwfFDcsR8/Ws8PJc5KuaNK0Yel
	1ifREMMUfqf85Rw=; b=Ae8vGCIoR3RmOLk9QK1JtBuOoLQjghLrqp3IERtbORQ0
	2diNqm63jQV2orQb/TwWxASvF40yN80i5h3fRYqModtAn2NSZdF/UMa+M0UMmm5H
	/xLi4vf9QDrJbJn6c7zXNKjnr2omsejfNvKOJBWoKdiVA5SvFjJMONfL23i5SMv0
	RmOO/tMLwI4yH6f9aWJG4sjXZpsb/BZJjusrNFEN7wgZgQzJ1PpYH0bmhuLEJa1l
	9Ozha25lFuipJywdwc/gBWh46VSzqPVTLHAIQdqeQguXuFAo3dMWp/Io4pCmfw8Z
	v/gjALEu/DpPO/vHX9TwS3YQgy4xrlHY6vrKaaUJhw==
X-ME-Sender: <xms:beZrZiNrsvx_OuL9o-_4BOiqr4dSu1czcy_1Uh0bMX5zVvjwXgLweA>
    <xme:beZrZg8sc0p4SVX2_pIZZVWUXWdiANJ0zd2cLlvktJrFCx53e7nDft4bau_M232o6
    njRxbPoyTLzTbssdw>
X-ME-Received: <xmr:beZrZpSU08O1W_woLL5hAB66lYjQjyaLz6eJ21fJ3xBId6YUYski8eMlrIS3JFPtvMBPKmH8dzQenQUPh-bbi7v3Ea8Ck2P7CGeFWCoTIaPFVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:beZrZiun5g3ZhKo6f7vUDQZV6Z0Rtc8jPbRWdYF3FFaEX0Pe7Mx8Jw>
    <xmx:beZrZqeTTccW5EvWYulk20WMvOViphLTUwpiBm3r17PgVXgVnWAKOg>
    <xmx:beZrZm2Eiv_DXJeqhbJBbx1ACo4I1NQXkxO4nQCvES48Y0HxIBzYkg>
    <xmx:beZrZu_hDU7w7gK6hvfJcIbhcmcewdRcmkE3gEtwe-JjJwDsju0qNw>
    <xmx:beZrZhzKoGozDiFerln3f24BAOq_9KtnWf__OhS1q8XrvqUUKnUSDgeD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:42:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 96aa9638 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:42:36 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:42:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v7 4/4] BreakingChanges: document that we do not plan to
 deprecate git-checkout
Message-ID: <25b20bb0ca84e6c97d27688f5e7a5f28c7ad5d1b.1718345026.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1718345026.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zgk7U7LrF0mOJJ+V"
Content-Disposition: inline
In-Reply-To: <cover.1718345026.git.ps@pks.im>


--Zgk7U7LrF0mOJJ+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-checkout(1) command is seen by many as hard to understand
because it connects two somewhat unrelated features: switching between
branches and restoring worktree files from arbitrary revisions. In 2019,
we thus implemented two new commands git-switch(1) and git-restore(1) to
split out these separate concerns into standalone functions.

This "replacement" of git-checkout(1) has repeatedly triggered concerns
for our userbase that git-checkout(1) will eventually go away. This is
not the case though: the use of that command is still widespread, and it
is not expected that this will change anytime soon.

Document that all three commands will remain for the foreseeable future.
This decision may be revisited in case we ever figure out that most
everyone has given up on any of the commands.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChan=
ges.txt
index 62695ec2e1..ba86c0224d 100644
--- a/Documentation/BreakingChanges.txt
+++ b/Documentation/BreakingChanges.txt
@@ -121,3 +121,15 @@ Some features have gained newer replacements that aim =
to improve the design in
 certain ways. The fact that there is a replacement does not automatically =
mean
 that the old way of doing things will eventually be removed. This section =
tracks
 those features with newer alternatives.
+
+* The features git-checkout(1) offers are covered by the pair of commands
+  git-restore(1) and git-switch(1). Because the use of git-checkout(1) is =
still
+  widespread, and it is not expected that this will change anytime soon, a=
ll
+  three commands will stay.
++
+This decision may get revisited in case we ever figure out that there are
+almost no users of any of the commands anymore.
++
+Cf. <xmqqttjazwwa.fsf@gitster.g>,
+<xmqqleeubork.fsf@gitster.g>,
+<112b6568912a6de6672bf5592c3a718e@manjaro.org>.
--=20
2.45.2.457.g8d94cfb545.dirty


--Zgk7U7LrF0mOJJ+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr5mcACgkQVbJhu7ck
PpQgZw//axfW4C/rXRFpXu/7ozzj1f8ELyu29EeL2+a0mnn2Ib55ynaRQqDidcOd
OGZTaIdJp7hr4PmY0x5bpTzGqvPuP79whgAGw/gFI2eTQqleisaPD+4lHKpu51Hf
KAxqoXRki64UN7QvNkoLQsRvYJntvttTlYsoS/gdvyXbTtQmaTfTOCIhP8Tx3DWA
zHEBU/MVaWIj2E58QdkvP1a4/zF7t4eBNeR8lpX/x+kRaAAhXaoE/wZRqWgI9px4
mBD5a30K9PxOYHsZqooSgymMytEaBRlSdltf0yAqT9+0+CBWNttDYuGONDRX7iLT
TFkDTJKXLHHkBMj9vlinHVqgzpMPXrxyeQLzHsMR2J7ySCCKhkAWmjsHryJb19Xy
HT7KsP2y6J9VJti2puVp174iogc0awx7LNdcqKrvmSt7XtRRAmFHx8p7H7fWLpOv
lA9q1ahHLsihHWVGoHR4CVTlG0sM+INossaZAyoJc2WA6scC6DXObsuCHyAd6cbP
Ym6FaM+zEJvaMOHzvnbvaQYa8WMwGoeHX6ydmuBrXGIFk2v3MV/f3S7JpUzp6eGA
UlHtEsBqkvE9D2TzWfzTeAXFPAwG7AIrTbrU9Bzam+OIHTf/dB6UOfz/jlow8KAY
i9TkYBAjn0LOtAfz5Fw9cWW7ZQGIEt65w8UZ5+llSnTy20uPsds=
=1AH8
-----END PGP SIGNATURE-----

--Zgk7U7LrF0mOJJ+V--
