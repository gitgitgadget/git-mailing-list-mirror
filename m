Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCCB3CF56
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705660809; cv=none; b=PGJVVISvRWMOm7fnVPowBkAdcSJQ+Ahu8uEDNtf2sbHznL5drF/6ITHZ1JtYnK3LVsA1QVzaX8Sm7UXxXQkqEYoUR8RgcevTaFIyngUoRZ2MSoA4u6u4KqS+YdQGxOx9Svwifl+xTGeaOBcOJ4I9z2QClN3hz1OoRGctEak0gY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705660809; c=relaxed/simple;
	bh=JvHRuT1NVqtb8swrTafZVI8Lo38/S1lndzK/knruJK0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEUNwgQqqS+uXlki9pkgS6bzOntl/tsY+1ucruj35hTR4DcYu0pjUzHaKmlKdGHYGabDJv9ExozNq6olexX2t2zgjcPiUUKIqPdofLcUWkaMCLOTd8IjLIysodIjYnIw/JdqlDv47z+D0RyQKcpw5rnqW4uyPWyIkskK7G3RzmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XhVIJwhv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j4iE06S8; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XhVIJwhv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j4iE06S8"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 678AF3200AC4
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 05:40:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 19 Jan 2024 05:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705660806; x=1705747206; bh=wtAtQHCvJL
	/tOo0ids7vS9rdkRLHeAdap/677fyeVwk=; b=XhVIJwhv/nOxslmJG6LLwxPjN8
	KeBg6H/Gm9hBCHXDvUvkMJ9L5Ueyef/Lk3Tq7S292/Gakb4BvZmo/83iLquhDcu9
	DWnJ1IgVD+szllZIkvoUYv2hjMuHmhaDcpu+bfp60L/VFnbIDihm8Rak+SNgF33a
	UG3ha0d+ocaihwMfaMYf240WzCV4HsprMlH/LFQMVax0dEQ2x97yEJtvFOV4L9dF
	EFgCrwTGsI9ag+rC9Gj4+FRxWkVakWb2GxsRR7w2g5lZpfAtCvH9w74b2ZYRf1L0
	R3D4i1Z/Ef9nhiAYbsfyyKiCehQfFZb+Ge7t42hZsoi5h/qBz114dY+5K6VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705660806; x=1705747206; bh=wtAtQHCvJL/tOo0ids7vS9rdkRLH
	eAdap/677fyeVwk=; b=j4iE06S81svmvpk0lYwEd2nq13Y1KZ8D2Y7gDNEzQqNZ
	92Ay4Gme/5g2xe/3PVd8JOPPX2wu5hVMUAUC5g2yBepj7s6EU7fngAaq7hezCgfs
	DampBAvCEG8rMJaGynT/7UyqYrtfcCU2MzJGb/qLphMhk6mLu0mNWa65Y5w6MxR0
	qqbfbzC4XdpWCrfYDy2LtqNLveVyCpBpZHNFG5TyBKj45deTHRVIBq4zJw4cqJIW
	23yGA6IAZPo4FWCcPwiWKgJWQT4EiF7+WuXkGFnp262vBok6vWspU+yH4e4J9LtR
	cKNwM7AqYtTGh889XmFqaZM4UdfqN7dH0PCgXnkLOA==
X-ME-Sender: <xms:hlGqZWA2OD6iSHKP7G8mv_NvEJNoLBOi_IhYdc6ofzsChgW3Ne2oUw>
    <xme:hlGqZQiDP6fKWNCRRJEUb1fHyENzPbrS82mm_kjyc8ngRXvIXImbP_4r9EZ-jvgdm
    oZEp-oMpjt4vQxs-w>
X-ME-Received: <xmr:hlGqZZlShPhdOwHmWrVskk851cDC1C6byy3kt1TbClTtxWqhN79CdIR9eoeXT4nRlEjj1MOtsYKGOeGuZtMLdnF7B1v4jVdhqL87MoLpeNWu3L7d_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdektddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:hlGqZUwNfMrTlZ5VPOWQ_hqVAsWFrSZAJTFcjl-k67FVx3_f5FxzIA>
    <xmx:hlGqZbS1FxFccpmmlkT5s7k1s2zeV9C664avyos2efuHwHG0tAMCCg>
    <xmx:hlGqZfaxLq-uOxiv60iRxbQA7gJ7xC-uu6EMJSgwaEu8fma25RdyuQ>
    <xmx:hlGqZeMOfllOuxeMdmRiWFNWxzgBVkR0bvgJ6kNFT70yCmEAZmy9Aw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Jan 2024 05:40:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e33d7c62 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Jan 2024 10:37:08 +0000 (UTC)
Date: Fri, 19 Jan 2024 11:40:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/7] sequencer: delete REBASE_HEAD in correct repo when
 picking commits
Message-ID: <6f827be3c20a9b06b933509f9b5e0c498a7c3dc9.1705659748.git.ps@pks.im>
References: <cover.1705659748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F1ItYgLabrIpODkM"
Content-Disposition: inline
In-Reply-To: <cover.1705659748.git.ps@pks.im>


--F1ItYgLabrIpODkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When picking commits, we delete some state before executing the next
sequencer action on interactive rebases. But while we use the correct
repository to calculate paths to state files that need deletion, we use
the repo-less `delete_ref()` function to delete REBASE_HEAD. Thus, if
the sequencer ran in a different repository than `the_repository`, we
would end up deleting the ref in the wrong repository.

Fix this by using `refs_delete_ref()` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index b9cbc290ea..6f620f5717 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4767,7 +4767,8 @@ static int pick_commits(struct repository *r,
 			unlink(rebase_path_author_script());
 			unlink(git_path_merge_head(r));
 			unlink(git_path_auto_merge(r));
-			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
+			refs_delete_ref(get_main_ref_store(r), "", "REBASE_HEAD",
+					NULL, REF_NO_DEREF);
=20
 			if (item->command =3D=3D TODO_BREAK) {
 				if (!opts->verbose)
--=20
2.43.GIT


--F1ItYgLabrIpODkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqUYMACgkQVbJhu7ck
PpQ2vw/+JkFZvxAgKlln5eKuoAUe8E67MRlgWcW99NTKVeapQc4SSgiDLc4E8r9N
bsS1G6/D1EN6yJIJqxEpmB+1npxiBGkHs/bZGyzVLWnrgmp3vsMhmAPA46AIwqXc
uzw0JZt3Q3yxfzaMvDKPpPgaSv2B/lQnK/iUk17f6cN1x4lcTwPsHfkr1Ch4SLZx
e3TGCcaVQW5WMWvr6335G8mzOwcqQHQ7uaaYMtBm0HIFlUIcqYFFBF5atpYl+ec6
vFMmvKtFDfxw0oP/ohTQPmcdkPj1Rr9LSHlBje1cSlENDqRdBdBM22Jp+xlfzjy8
BKrccGhaZ2YX9ZmmfGAGmxLU80KHcjtnmoOG7jeAub2+DpvJ+TXGiY9vmHdoc8QT
TewYVgMCn0Dki7vQAsGQz1VuZkjk6cZjphduYhp5Y0CP+OZYlsWGSA04SOd3c2CX
xwFgnaEcl8eWdiFZQtmM7wzLDeNWbyDm5sza3R16JYBCYFp6AxsbmIDB+ng4mggp
kT0FCR+KRU4qOiQCCf9e+pRwV5ezL/95sKQok6lGkopEaDk0H0EuhzH+o/K521zj
QogqoPsosAxNrNFg2txMS+xJjZKam7gsBkWdbgbjQHpyuiJ9YVC4J+IWVALSjFWu
FOIG31ze6yFeWqmy58QKotLFLB6OMrsgn2l19JZ9oQhN7DxMK1A=
=W5Np
-----END PGP SIGNATURE-----

--F1ItYgLabrIpODkM--
