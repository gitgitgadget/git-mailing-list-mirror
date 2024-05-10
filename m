Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8614A0AD
	for <git@vger.kernel.org>; Fri, 10 May 2024 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330894; cv=none; b=mayUj4Ka86Oswly327TnF3BZwp0czYvY3bR0ji6uw72yWuqQwNp0Jbwgllovpxqcyl3Z2qDE0cFt/RrxiqWEff+oRWXF5HdHLwSP9Dw9QHj1/vf4xyyabLDRs7xiUjwxAR7brDZRQjRUyDsQG9svXCwyhI1CwUxwKyeZbuCLR7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330894; c=relaxed/simple;
	bh=TznbHIGVjzStsJIrVXfWsGKLdlsgYBZ1C392R9vJxxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wz+Ny/S+6x9LYo3M+00P0npld5IoEl5s7FxgPVY/Ll2KyzGoTWpaWGuNWUip/aeYhu+tB30f09tZwANq4xudejDBxeDFJVWwefiUvV1CdUE02qlnSwzRCCOxild6wEKh4ZAfFjW6LdlRHMX6p7z8X7n3YiOQcXowdtH3czzG4S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a64MS1t4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WoYA8pmZ; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a64MS1t4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WoYA8pmZ"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4582318000DF;
	Fri, 10 May 2024 04:48:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 10 May 2024 04:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715330890; x=1715417290; bh=tF9jPXSkmF
	ov/BLoDV7LvAkJ4kqjbA6FLNY6UyprSaM=; b=a64MS1t4lm9qtIyZGzj1GAPBZm
	1em8Z8zW1sC6zw8067YSRSxGiYNd47TrDdhe486K8RXR8+BVhoQA0CnCm6mHFMVm
	xtmOYkEUlGWXpCFgG2V8hl22rga52mJbNSRzbUrDHvn0wyosD1MJrkA/9ppa6cV3
	jGAHMPBKiOJFVoP03dsH50ez67h7AnjHZQYTlVPdYRAz2G6x2sxoP/o5SgjKXvCZ
	fTSxF8WXemVepRIxwSVevjt5Hbav+fq/DMsdiuwucLEtt27voED+1JKTazYz4Kiz
	hjcVhStB4c5YaeAvRx0SefELbM7AckMI8VKExu7xBIHdUn+YPh/pz6dl3PZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715330890; x=1715417290; bh=tF9jPXSkmFov/BLoDV7LvAkJ4kqj
	bA6FLNY6UyprSaM=; b=WoYA8pmZDg6E7V5WQMSsiS7Y/Sout2KnLliT1seRPr84
	d6K6YCzuY7XeIwJiRU3Qua76xAnkcIuiTV6a4H9cyhXlNJKL4Wn3q7RUzGY/R4WL
	0plSLAMgrNNzJ4I+RvjPH+U+339o4Zz26ZNUBwuSJbLN0Qyb4bGdPOuwwDtYBlXL
	5ACq/uNby+e8LnG4x8V/eJJVR7btlI+X8bfiOahl8iBNiW218CIEiXxT9wwvz4UO
	krI4fzFnTkNpZqjHWeifO2r4s2bztRALLi6jtiYLyfP9eF7pVZXWIJczypIDnCzh
	f5WoLF3FxvJ1MDlYrbJKbwGNRuomvPBmrLSb7uLzZw==
X-ME-Sender: <xms:St89ZnYEnGJyIsTRZhRj5SseVROck3vwuSfsCeS_GnCMr5Frpzj9rw>
    <xme:St89ZmYGLuFRfSlME2nJbiIUxZcTMxknpL-h1UOSA9qKFk3x0sWblo3_G9ROdrL6Y
    3PJSR2S0l41PtA8aw>
X-ME-Received: <xmr:St89Zp-1wIv4pGn3z3vBlVZHxvpdjQueIZTJm-Onr3wqOVC2-x_zXW3WsN6OaVg56d4CmfOo9_pmkVc7z6KU06pEA_Hw0R9zAXN0hBCalO-UDvqc1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:St89ZtqasTkd3P0WP-dN_SJaNHIHm2cC4H66gJYh1ouzlsFEwDG_LA>
    <xmx:St89ZiqP-irxXeZ2SmaPA2hLBN6F4B-1awleDcAyCRrMvrXim_Rdjw>
    <xmx:St89ZjRN7VDvyDuz7Uj14xQwROEpWW5AtKIUn2_p31Y1T3hVYcTdUg>
    <xmx:St89Zqoo9F7P9SymOaz_sw62Drp6CIWGcqG9emjqyUQlHsB3bQWgsQ>
    <xmx:St89ZudDFCEOm2ayVaGv1-Wzu251g1-2dk3FN34JgTRMjr6z0WjTCyhi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 04:48:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8aa587cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 08:47:56 +0000 (UTC)
Date: Fri, 10 May 2024 10:48:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v4 01/10] Documentation/glossary: redefine pseudorefs as
 special refs
Message-ID: <b1fc4c1ac7cd14eb72355739adce274894aaaff4.1715330206.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715330206.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kfNzpbW2f7p05xD6"
Content-Disposition: inline
In-Reply-To: <cover.1715330206.git.ps@pks.im>


--kfNzpbW2f7p05xD6
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
2.45.0


--kfNzpbW2f7p05xD6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY930UACgkQVbJhu7ck
PpTzew/9Fv5O9g023KTzgZGxrZEckCQJgxnhpUwvfcPYcNLJnESREk9GzM/S3QF8
h8b61jL2byEIKVFwnADjLpJkTp864n289TDlFNnzI/oeIrjjTitUhsln21QXP2Yl
FWivMhQc+yPgfg+yssGiQC9wgVfG/seD4vSwbwu0S0rZ3+Cot0uZPhUSqlC4uI76
ePPFtIFtB7a+LXGfhXhZiq/2x2U/SrOq3CiS/e1Xqzq+IPJrfz3cdMYD5EFvvC2Z
SbgN27d+MMzdu//iz46OHLu9nu13x6hR8OXaMfH/L7viBZLW0JJBtiOGki4Xgd58
1ui085Ai/ECONT36FKo1PhzPsHZL+UqMEfosvilxxSou4U84hQx4NLa0Zi40TOVX
j7dZ4F2RJTxWvWrr0gFlU2Jdz7K88iT12/voE4nDDxhgsSrU7bNJXPQ8il+HdKWt
cby+pM+sDlL0HzbUNODdNJEXHw7u7Obk1/EiK5XRuoqM5CT0g3VrPci301oQTUPm
FNbPoA5Xhk439v2SwC66mAkmJ2ROV0capaUKNVaLIhvw5SZyR7UwnC9D85tYTFMj
c7upnotwyDlnFULlj9owS96ExTYw4j/hzbVL3DSrVNZvtvhVjjQ5ojBhPJ9VMszw
xu5g06JqIrJkpryo2wn2/L+M9xOrKWVsAGV6/IzkwE4jk5eLl88=
=w8TW
-----END PGP SIGNATURE-----

--kfNzpbW2f7p05xD6--
