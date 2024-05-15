Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6CE405CC
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755834; cv=none; b=H9UuxkI3lQxw5jhacH/KxvbQV04lzrj1fD52fymbxRwKsH914OSCc2B60OJ8/66lb3FIx84hHQvxxDovxhv9KQUWfja7shXpe0NJs7ej8oBW87pIYPRlnQNorHpthTmxIIot368CTQQR11BM/uJIB4ilSAIVbJrwUyFGPXYkANs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755834; c=relaxed/simple;
	bh=PDH3KUHSdkG0Zf+8pH+I/sabZDTqT9teo8GzRqyWk6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaGbFnS4LcuZx8jEVQB1KrfzAY1Z8xNkL0nknFKK4PL1T6B73hxzJmPoog5TMuyw2qT1xnXgLL+d5Tm71u6e+9jeesAYhqFIc8TcsL0MrflohS8llmmhMvKuQf+0HQJ5QbFyvwENeL5zYHvLOK6F+/y9YZGklCpJogk6C8hLBgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GPn6EWA1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TxArxiQF; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GPn6EWA1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TxArxiQF"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id A5644138118A;
	Wed, 15 May 2024 02:50:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 15 May 2024 02:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755831; x=1715842231; bh=SYDfW7qJZL
	YpZL6GFM8/uKPLfzyoD/KlgMDByNgEN6c=; b=GPn6EWA1MY86bPs0lYaCvY6IYL
	f4c7o8liwoS92DuQr9xvBPZWS8PfGdlq7X/g6Qkt7g/s34zzAHaFFyg92qawtCEX
	wld5m4S9LO2cu3qnWuQvYP+U9xRgT5cs0PNiEuNK0jxwUQbLvIQ1A+Hk9CVChzdO
	QwEod1uTGszi1CzQSnf340yumayIoKNfFeJABmZ5nSUwPAomky+71e3nItmc4/Lf
	6R8hQM7eZXflokrof/Zw96tHX6xVoK1/S1nhIBetK9QKHmju8iBfQ9DpxkAY8I/y
	tC84+0el91kAwO5wTtKnTD0BabfxrlQYTdJ1xeDgc5HduWkDvvHeVird4fyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755831; x=1715842231; bh=SYDfW7qJZLYpZL6GFM8/uKPLfzyo
	D/KlgMDByNgEN6c=; b=TxArxiQFDcLZzoN/M8SgwaOvm/y7FyTPOKh3W3IEl3p2
	yFpZlg9FixKwOJvJ8INB+NU3J+upUuedjcYPs4cadTEG+F7LSIBWdybJ345xHSTx
	uhCleLvlS9p9krXYAoDTZvmXuaFyi6Fq1n9FGvGxttlgJQKcMxxBK8gyucFmzHfw
	t0ysVoe1oY1S24/kWvVEBkNUk8Uaxj0q3jqBhhe/UCPQJh5eJqWq93TJxOy8e8QR
	uIg5HmHMo1wA59mKcCSgdDjQLar/Fe7GDzByqGuaWqn4XC1N803IL0SfgVT9zIvi
	AJ5AmfeTH5H1YN2oVp5muQ6WeYrcREGq8CzazcWzEg==
X-ME-Sender: <xms:N1tEZrPz_IXDowNw3E1ZeQDzzA7gZLxL4dwlnGmc1HSp9QtxsnkXTA>
    <xme:N1tEZl-xoHr0f8ozegFgKVzvZ5A2IUjDik9-YmdaJhlt3TPE1MlU6YBYopLCD-1mk
    B16wOYcYR2KKzx94w>
X-ME-Received: <xmr:N1tEZqQ3u3K4j0pwT9W2whKwnDmnSGtYBtRDgo0EXqwzAFPHAuiWb1V78FoMDgqMNPmhOUxeMtr9GI847HC6Kj85Hmh12ObnNPIt8mZ24ph9TJsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:N1tEZvt0x9XlI6r54Z-H3BpXw31a5313JwaqZ6EWaTeTuEqQi6_msQ>
    <xmx:N1tEZjcVrvbI6Q94ZKH6DDr33bBuvLonm39kK_Z0Y3xNQTfNsCRbmg>
    <xmx:N1tEZr0OyTCpT3-vGpMZXmJ6hhT2Bfwvay1w6_RbnePzuQDkIRq69A>
    <xmx:N1tEZv-lsle1e8qNXUUrih8us7ZImL7CLC1dW1OPij4IqI-tWIGg7g>
    <xmx:N1tEZixR94XNBLiiVTZqaG4DTIFy1RR8sxVbIj1PnET_C357P85NLEPw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:50:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3dc9372e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:50:08 +0000 (UTC)
Date: Wed, 15 May 2024 08:50:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v5 01/10] Documentation/glossary: redefine pseudorefs as
 special refs
Message-ID: <1f2445b95b32e70696e07a6e9445b63ce45a85c0.1715755591.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715755591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U3jns3g9agWzRMjM"
Content-Disposition: inline
In-Reply-To: <cover.1715755591.git.ps@pks.im>


--U3jns3g9agWzRMjM
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
ref. And we really only have two of these nowadays, namely "MERGE_HEAD"
and "FETCH_HEAD". Those files are never written via the ref backends,
but are instead written by git-fetch(1), git-pull(1) and git-merge(1).
They contain additional metadata that highlights where a ref has been
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

Refs that live in the root of the ref hierarchy but which are not
pseudorefs will be further defined in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/glossary-content.txt | 40 +++++++++---------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-co=
ntent.txt
index d71b199955..e686c83026 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -497,20 +497,18 @@ exclude;;
 	unusual refs.
=20
 [[def_pseudoref]]pseudoref::
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
+	A ref that has different semantics than normal refs. These refs can be
+	accessed via normal Git commands but may not behave the same as a
+	normal ref in some cases.
++
+The following pseudorefs are known to Git:
+
+ - `FETCH_HEAD` is written by linkgit:git-fetch[1] or linkgit:git-pull[1].=
 It
+   may refer to multiple object IDs. Each object ID is annotated with meta=
data
+   indicating where it was fetched from and its fetch status.
+
+ - `MERGE_HEAD` is written by linkgit:git-merge[1] when resolving merge
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
2.45.GIT


--U3jns3g9agWzRMjM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWzMACgkQVbJhu7ck
PpRg7g/4vyS6eYWLEyyFvNUdBdi+1Vdi79cKnpETXe6FDoAK69OfXkVAeF8RkJCD
XSYlwL4vryP0uV6rf6VZ5cX56dzbMo4FNoBVD72PokTQuK28EY4KXAPGKcAmq3jw
ht/lTw45bsyPQfqHDnT3L5zP3+sDV4890KSLqUnm0I5/PeVBW8lXNe3aK1Ti07HV
rRA4vuhgjIrcAqro5AdLnwuf52fw3QuNON8tX37DyrQFzMqYlWhRqUe3AAOE82BL
B7VbibnImUHIoKdUFyGxcHsR6b4yhSI2Dr3v6D2dBjYTEHDoj6e6rFFkdCa73VeV
QT9J5sh8qaKDlVx9VfiOp3LQXyD/uBQgRe8aH0IpL82JQnDo1Kok5IeiPWi7RCUG
ImOM44Q1ST+NroCitZ5422jkd3mTm2Ab+lcG7q1yuRveLbEnYaCXbrxVx2Hn8qp+
cf8Fa12kI9TPrih79feoLKnY+ybsRRPB1u7fJDlMd/7tbMtn6fmAx0b0grN+uzL+
9i+V8KuGcGE4MWbrQX2mHOK1ZjVJIi7Hv4Jfs/Dm/BsVuD7mwBgVXryVxpJZm2wS
njPrEfn7FwhEAHVA9W81OPQV4ZJhPVFEplylYNtd8HHuCP+MjQHG3iF7VszW14V+
qkR3TsolFB4uN/x9CBCOOhyyqEqBUl5TIk059JpJRIaJViyDlA==
=8tjL
-----END PGP SIGNATURE-----

--U3jns3g9agWzRMjM--
