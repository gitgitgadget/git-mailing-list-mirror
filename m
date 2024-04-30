Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CD813F43D
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479990; cv=none; b=MUuC0UCD0f07weKm932R8EuFr9J9chGc5s5z9tyurVeT2AVx9MoLY6QiaHWTJF7q8reQApx76evyd6vLB+6hPAKXVrp6OeNljWcxgY/v9cqaZms+ApyngRVtRcls0MZ/EHvX5sxtORoppjBXgfct88aqMxhn+de0DaL/U+FR8U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479990; c=relaxed/simple;
	bh=CWSKQIf2v7UZybUTHUAT2+iVr94BemLrQ4Shqr7iFHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mz/U40Q5pNj6ykc4VtUIUtTmbrwcnxSPExL/ga2OK+e12ZBc/E/Gecp/atebDHD7cel13+Vi95wmVO3tzd3xZL28/5vwHJL326pc7wZGEeeQr9ra2nO3U93LunzUeYI7rMRI1rAOiUyBDKRkDq17Q5L8/aD7FcWec3UubEe1G58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rWBHrC0a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z5jf5xPV; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rWBHrC0a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z5jf5xPV"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 6DA581C00115;
	Tue, 30 Apr 2024 08:26:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 Apr 2024 08:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714479987; x=1714566387; bh=SPKyjNyw6X
	d1lKhd53SB3ejBicA2wId3znggYuENP5c=; b=rWBHrC0aFTYZzPXciGiN3xcygE
	N46u94454q9OCHkd8mM283fwYbSbmsWHkCptLqsXvJYdmFyhW9j/NgaRTAzZ7RcN
	5BtzjiY1XedcFiGPoIJrupz+oCghH6xG0nWk5YGTRoPb0rIUXHrC+0rVNE1/aB0K
	dJ4eYhzmFSZ+LVCbD+NssCcB2VIkPcNHR5zRJZFA0/2gNAOXNQwDEtFQzWZcpwcn
	GT8wOUYZqk8/wCA0I6eqiaPoMgROdett6mPCAyfMD3ihcMTMoQzaj63UEmkme4oh
	wWOsoYGH5kla3eTy0jzo6wUTc99iasHhp0EmVML0dF/+BL+7UvNDLnJ+5ZqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714479987; x=1714566387; bh=SPKyjNyw6Xd1lKhd53SB3ejBicA2
	wId3znggYuENP5c=; b=Z5jf5xPV4MKTYWGOAV2qgkrc9MrYOE9mmksk+7V9/eD6
	G/LKyV7PN18vmWuMpmr3qLQC5Ha1UJBGRnMC3hBCFr+aWzwsh0nXHAsQWYshMwaj
	qHHR7lIwy5zUq1QmvoHqj+IL/TXZf+aNaQ5rd5AeQhNwsaCxUhaRljAbxdqaUeRO
	cz7bz26Lx1hGRj4xb//fC0PzFnG9UOJL2QDQWQc06YE+Thxy3dC5OhuciaglVsqJ
	rgFNr+Ljgyo1CcZBUbnjyxj35k0CKAxXUZQ7yWUSCpN34eiaLRvrZVf/sa7r3CiY
	tj7AaqfyOqxryI8ZLe3jVN+CqKg5/KRprE4sRNU8XA==
X-ME-Sender: <xms:cuMwZsYIC7I4hevTSM8O-U7Jq-1amQyqgyE6TgTFBsVa3ZAvJLEAaA>
    <xme:cuMwZna8EsvkSKlkIYAJ38uLchawm022MYqSrfDnU8YkZCKUr7KpekiQU3MIDIB9V
    yNyCn7dmOpiK30UsQ>
X-ME-Received: <xmr:cuMwZm-adFRW0UkVEnc7fVsC6JeyhUf49eUOpkDPfkdG3chYa4Cp21TTaJNL9AQ8f4HNeoyIfbRuqWE_L4mzO5Rp-otqFEqZZ8lG2Et1PTreC_D-EyM0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:cuMwZmrnnJ3r2lnsLtOoYQCiXlY3D7V2TaKQEDipKJFTu1zvKOPbYQ>
    <xmx:cuMwZnqIs5G9_O0yors_vLwH_XiQ9psFf7dDmBMasZDg2llgMt0ZeA>
    <xmx:cuMwZkRUbXOFl7MbZEeOkDimPojclBXG7J3v48w6nPGFO2tUbGTeag>
    <xmx:cuMwZnqKj3iiIAjWPaZWA8nkFmlnPLuaR_xdn-2waiBiHIHWWImHww>
    <xmx:c-MwZocrBDD5eKpI-IxnfbMphGHjtA-po2b5pxk1-93_j8y8kzBP2cze>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 08:26:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 88ead617 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 12:26:04 +0000 (UTC)
Date: Tue, 30 Apr 2024 14:26:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 01/10] Documentation/glossary: redefine pseudorefs as
 special refs
Message-ID: <2489bb558543d66592fb0f3eb4d4696ba8e31fea.1714479928.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714479928.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DisauadHBbq1HwDO"
Content-Disposition: inline
In-Reply-To: <cover.1714479928.git.ps@pks.im>


--DisauadHBbq1HwDO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nowadays, Git knows about three different kinds of refs. As defined in
gitglossary(7):

  - Regular refs that start with "refs/", like "refs/heads/main".

  - Pseudorefs, which live in the root directory. These must have
    all-caps names and must be a file that start with an object hash.
    Consequently, symbolic refs are not pseudorefs because they do not
    start with an object hash.

  - Special refs, of which we only have "FETCH_HEAD" and "MERGE_HEAD".

This state is extremely confusing, and I would claim that most folks
don't fully understand what is what here. The current definitions also
have several problems:

  - Where does "HEAD" fit in? It's not a pseudoref because it can be
    a symbolic ref. It's not a regular ref because it does not start
    with "refs/". And it's not a special ref, either.

  - There is a strong overlap between pseudorefs and special refs. The
    pseudoref section for example mentions "MERGE_HEAD", even though it
    is a special ref. Is it thus both a pseudoref and a special ref?

  - Why do we even need to distinguish refs that live in the root from
    other refs when they behave just like a regular ref anyway?

In other words, the current state is quite a mess and leads to wild
inconsistencies without much of a good reason.

The original reason why pseudorefs were introduced is that there are
some refs that sometimes behave like a ref, even though they aren't a
ref. And we really only have two of these nowadads, namely "MERGE_HEAD"
and "FETCH_HEAD". Those files are never written via the ref backends,
but are instead written by git-fetch(1), git-pull(1) and git-merge(1).
They contain additional metadata that hihlights where a ref has been
fetched from or the list of commits that have been merged.

This original intent in fact matches the definition of special refs that
we have recently introduced in 8df4c5d205 (Documentation: add "special
refs" to the glossary, 2024-01-19). Due to the introduction of the new
reftable backend we were forced to distinguish those refs more clearly
such that we don't ever try to read or write them via the reftable
backend. In the same series, we also addressed all the other cases where
we used to write those special refs via the filesystem directly, thus
circumventing the ref backend, to instead write them via the backends.
Consequently, there are no other refs left anymore which are special.

Let's address this mess and return the pseudoref terminology back to its
original intent: a ref that sometimes behave like a ref, but which isn't
really a ref because it gets written to the filesystem directly. Or in
other words, let's redefine pseudorefs to match the current definition
of special refs. As special refs and pseudorefs are now the same per
definition, we can drop the "special refs" term again. It's not exposed
to our users and thus they wouldn't ever encounter that term anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/glossary-content.txt | 42 +++++++++---------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-co=
ntent.txt
index d71b199955..f5c0f49150 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -496,21 +496,19 @@ exclude;;
 	that start with `refs/bisect/`, but might later include other
 	unusual refs.
=20
-[[def_pseudoref]]pseudoref::
-	Pseudorefs are a class of files under `$GIT_DIR` which behave
-	like refs for the purposes of rev-parse, but which are treated
-	specially by git.  Pseudorefs both have names that are all-caps,
-	and always start with a line consisting of a
-	<<def_SHA1,SHA-1>> followed by whitespace.  So, HEAD is not a
-	pseudoref, because it is sometimes a symbolic ref.  They might
-	optionally contain some additional data.  `MERGE_HEAD` and
-	`CHERRY_PICK_HEAD` are examples.  Unlike
-	<<def_per_worktree_ref,per-worktree refs>>, these files cannot
-	be symbolic refs, and never have reflogs.  They also cannot be
-	updated through the normal ref update machinery.  Instead,
-	they are updated by directly writing to the files.  However,
-	they can be read as if they were refs, so `git rev-parse
-	MERGE_HEAD` will work.
+[[def_pseudoref]]pseudoref ref::
+	A ref that has different semantics than normal refs. These refs can be
+	accessed via normal Git commands but may not behave the same as a
+	normal ref in some cases.
++
+The following pseudorefs are known to Git:
+
+ - "`FETCH_HEAD`" is written by linkgit:git-fetch[1] or linkgit:git-pull[1=
]. It
+   may refer to multiple object IDs. Each object ID is annotated with meta=
data
+   indicating where it was fetched from and its fetch status.
+
+ - "`MERGE_HEAD`" is written by linkgit:git-merge[1] when resolving merge
+   conflicts. It contains all commit IDs which are being merged.
=20
 [[def_pull]]pull::
 	Pulling a <<def_branch,branch>> means to <<def_fetch,fetch>> it and
@@ -638,20 +636,6 @@ The most notable example is `HEAD`.
 	An <<def_object,object>> used to temporarily store the contents of a
 	<<def_dirty,dirty>> working directory and the index for future reuse.
=20
-[[def_special_ref]]special ref::
-	A ref that has different semantics than normal refs. These refs can be
-	accessed via normal Git commands but may not behave the same as a
-	normal ref in some cases.
-+
-The following special refs are known to Git:
-
- - "`FETCH_HEAD`" is written by linkgit:git-fetch[1] or linkgit:git-pull[1=
]. It
-   may refer to multiple object IDs. Each object ID is annotated with meta=
data
-   indicating where it was fetched from and its fetch status.
-
- - "`MERGE_HEAD`" is written by linkgit:git-merge[1] when resolving merge
-   conflicts. It contains all commit IDs which are being merged.
-
 [[def_submodule]]submodule::
 	A <<def_repository,repository>> that holds the history of a
 	separate project inside another repository (the latter of
--=20
2.45.0


--DisauadHBbq1HwDO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYw424ACgkQVbJhu7ck
PpQvHhAApu1eduZ+aICepdsVNSyvnw8RxPAyqa3PGFRBdnz5hcap92hBtcPAEyTS
pdFE7DZ6P0R5LddP8hN9sqLVy7q/h68/f9+dx7fh5VBZHUcw6nEdecrDA846K2fc
8hcOZ3n0Gn0pujFUccjh99tVdo8im8Zh+OT4HUrWXWmyVseOPwdAeBc6NWHz8AUu
1RB8ExScJaTlA1/O/vhoBEqvTnFiBQeg+MoD3YBAc7NFgO6zfti6Orak+3nz7CRp
7Vjff/GugGEaxrEW9JBtpe+K3vrIi0bBEQJZLm8s+KBQIgIvEQnTzGa11bsi8v8X
WF4V38/oOrDBeAHcMrmzruUr3LWSHdKPTGZkKIwHnZNoDIEQXx2q6dBtZ+HLCcCo
Bc7zeUym1pVgvgojTARSGmXusY9L56IDAZ74I/tYOGNEhv/SW9EB3G5/ewsvtInK
VISXJ5jJACk8mTYDRIP08M6P9DHi9/enJiLnELj+xL9IyOLGmqIW9wWfNFejVQ7e
wtkDkEDQsLvke/wDPQDmRuYE+TRmVlSysYIM5PSwIitQa7cS37W4p26+XTd6Z/kK
8jVBa/jJ1bWGaQ/cRbnYK5C1fazbxA5NMsdEEFyLL2Q6rYDbuZzf4NNfwEk9+i8a
A3dCXRIlJba/sHhrEf9t2ZlPFwa65E4sEt8aixz2UGXlx5dMTwg=
=qOyd
-----END PGP SIGNATURE-----

--DisauadHBbq1HwDO--
