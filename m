Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278DD2D04E
	for <git@vger.kernel.org>; Thu,  2 May 2024 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637840; cv=none; b=nfIrqHzgw5NN0mda32rWv6ejytj2QQQhra4K4pml/ywut6oi7UKyRQ0srArUrRf3HGpJmdo4Ukc+Yg6r3I1Pnz9qLIW2yLK6KTgVc1TK8sJf2Rvn8IZcMHwygt7ODSaLnQFgo/fJ1dmKaMsHA7S6qm1sM1pRlCN+UdFW3iJtjjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637840; c=relaxed/simple;
	bh=96T3EiAUzPaISRFb3sl+nIzwuBQnTOxOJqZbpuSQMZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6T232o2EoGqAA+XG0DGb2rIU6W87XtcDA0yp8zEhmACeyrBTm2IYDHYiIxN2ReBHsd6Z8LW7HIAOe70/+VCNcpfJQeQDG1InaQg+h+432gKs0KjEIzO9K8ZMZNSHO4KPtRDGYzKSpq3nopsenGXDh9lG3i7QFyuVTN7zN+GYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=is8cNbIp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UQPoWpT4; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="is8cNbIp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UQPoWpT4"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 468261380F7B;
	Thu,  2 May 2024 04:17:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 May 2024 04:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714637838; x=1714724238; bh=Ot4gOESHFm
	HddF422iyQma4mBE+I+qGIL3TgEIJqAh8=; b=is8cNbIp6ECZG5Ex4tLLEDum5J
	8Ec70+4cWHAEX+hDbvnl6llVFTRlBM7OTixcpgQ6gA1sPkfBdqUpE4TdkFZs5j2K
	0ObEZ7ed/JDJhF8vmAJMHNhckLZTryFdq95UK8d3BHelXmy5TYRZEPqPwsvlT89N
	d/FkPpHYIjwubBK651TfxmSwvJjwySxAPs4FHxonzfZs9TvY8m7Feibn3ufW/7En
	kyvreOazHOhh7/JvMDdDXfLzSBl9JOQTa96JtHeC3XAXtjqwgd/hkY57ULvHKY2Q
	V+vv0ab1jJ1MbzUVuywr5VPnktGEJ6xC+p78q3ObIB/j63CItCUt2UufsM/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714637838; x=1714724238; bh=Ot4gOESHFmHddF422iyQma4mBE+I
	+qGIL3TgEIJqAh8=; b=UQPoWpT4nVJ3Ddyd2ru7+vSDltJgFdqAyF40YlJ+O4lI
	Cbip/eDTQYSBt1fq2AEw7pUJMm8jJUjVOzOaP21CHj0ciV/+YDtkzDH3BB5JXpFd
	jyT9+XkIOdmXQaRxqqDlt4lvd2vZJTGXUAP/rAsS/pz7FVf93W8nIAuZx1EqDklh
	G6zGB0rXZGEzshNyIqsNLB3c1M2SnH5pOT5WNityHmqTHaMFbsWHtu/yYlFFrKqu
	KVBzZbg5Hhbmxn6CdfsUMuKJ6j7RMKR+bZRfWpEh/qVPLwDDLQBomXjTkGSuyWpt
	ku6c/L1roiNCTC6jAvTgeIU7bQUoMseUiSTMdOvRfw==
X-ME-Sender: <xms:DUwzZg4Wqia9dy8QlBH2h5Wq24VJbDHa9gW-U_IqdK4Lcy0ebXZj1w>
    <xme:DUwzZh4UGgfVt7P4n01YvgXH_CUDJkrmu99QzizKO-skQMtlDhMSaVI49uXQhDDP5
    w0dID0G5a3yO_tmIQ>
X-ME-Received: <xmr:DUwzZvfcNftKGr279uMNXNpU5Vb8yxLPr7k0mpddOBBy7BaWhXu4qSSUJKX9bikdaB6pcvTAyTNkwnBuf8uQqXmAUF62sVdlfRVXN5rsUKgo510>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:DUwzZlJrDIW30vwgGqOIOCaJU1PtRStzyZE9PbqfZTUqH4SRYH5T5w>
    <xmx:DUwzZkIikRYwbkLbDMtuScrYRcjIZapfF147O8wfRRCZIvreue-LCA>
    <xmx:DUwzZmx-UVKtVu6S5zJ1VT1jl1yx_ZnQxs1ERTKtQVuuuoRS3OSSTw>
    <xmx:DUwzZoJtdeo1gJudE2HG4bGJykMbYx6EBD5vyVG9AYMTv31P5vPdqw>
    <xmx:DkwzZtrhyFFR0q4X_Jdakc9MJSzNcHBvieCRB7m_tdqhoRB8VuUrk61w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 04:17:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c2ee2f54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 08:16:50 +0000 (UTC)
Date: Thu, 2 May 2024 10:17:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 01/10] Documentation/glossary: redefine pseudorefs as
 special refs
Message-ID: <e651bae690e5390ae2f4e906d8edcc34b4f25003.1714637671.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714637671.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sLJ99//NZET39tD3"
Content-Disposition: inline
In-Reply-To: <cover.1714637671.git.ps@pks.im>


--sLJ99//NZET39tD3
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
index d71b199955..ca04768e3b 100644
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


--sLJ99//NZET39tD3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzTAgACgkQVbJhu7ck
PpRYsw/+LkwlypN/IXa0RS0T8hNy5HqpX11RJEeMBoWu2oUb017xGwyZGZsXWAN7
8yfL9ZsFY1cbJR84UzSSOL/tfdLmF3chu8kbPaf/xLQUAIXHQEIBKsTGjr/UInlH
zPHpIskUDdaTcKxlVVm0hokNQZEKRcPOJ/BHmRm+SLV80x0FttrcjwYAvRZqCaM0
+/r3pkSp5U91EeHZV7l+kX95MoZbVpTka0dqqDYW3iM3yl0cQKf1ZpF4SawCUuxJ
CbNsYa4WsWjSHyjKBuzG5/L0MdvYA6qhMo/aryQInxvMDHM9WlUoB6RDA2Ad+S0M
EklJhd5c60N+rxQ+KgNpWYvLMKqsW2gQZElATgvgZisI1+xSreJNyEQUMKkHeqjF
XVxZZT9emPvQ9PIYKgcVTsYabaxgLQy+poLVhriKKem+o8wt+2W/APdDVJxqZgWZ
CVFopEISa//9CU09DXKagPJI/131bjYTHVb/FF4wkEPpq3yJASPibHGohyiF/IRs
ipeeoHwNqsBbJcWrKU7QeCmrQBSYAKh/mj9AzHtoPrWJExkWCKoWuq+qP3ESs3uw
dVvG+As6/meGs7r/4tseuAjgkwU1uTytzHXcvnYm41qvOEUyevYJ/idVLCy0OClF
RP9CSRlR9PCLnPN5B3qLVr/S+Hgdt5excq3Wp0yx29alq7jgo68=
=CP7K
-----END PGP SIGNATURE-----

--sLJ99//NZET39tD3--
