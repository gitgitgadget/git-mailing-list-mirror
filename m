Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124FB47F6A
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755844; cv=none; b=rBEBG9krGwCJLczitZcuLBfr2IRJAInhBvcAAXY5Jn51M+6GoxXrtj5FjJcEnBydPKv2T2G2mIyBid+qjMwsl04m7BCUPH+DbR2CN3EdZTVhOTJbxLiO6B7shziyGC4ZFEKuW/DlxA1zJn9qk6nPvkUO63ayuYuJRoPqzzkRjKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755844; c=relaxed/simple;
	bh=f+1JJbtCJomcgheMcjFIQbsWFrzM0ZykFaHtoZv81Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X25wMGwb0Yn/mU4AT1tFPvnQ2rLDKejVFqAbXS7S7e31Y62JswxZGXHtTrrIoRzciJ73RUbknJAkMba6BjSyPDxx+Fbkz0YEUj2VgdFaPxrHQG2lHJTeW3m1AfM2YJNYFKp2HUM1FThqJR8relcj67+MwnEQvRn8b6GMRhxdGO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LfofOvjM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cDyrVmgn; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LfofOvjM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cDyrVmgn"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 256B31140189;
	Wed, 15 May 2024 02:50:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 15 May 2024 02:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755842; x=1715842242; bh=5HlBw6C3Ti
	Sc8sse/hoLej1tefGAG2Mr8Qo39n3+KvI=; b=LfofOvjMdhlGzzqNte+2PCSpZL
	UkrpHAYQnuPzk2AzkiyyJaJkZVtPAs1oUZZqkpjFHhSkHu/2jHvzV+/725BvMrtH
	8m+hm7xU75X+a8juuS+/Lk2XsOmouCMUQR7gCJpkqEZkZJRMtaYWUbMA6XAF4Ao4
	TxREDRf24o3OZmmayowL17VJJddlTQIqkSpVTxKkUCCAHJG1B3D2/fNzZ++/iz6t
	6VLcIB2VqVny4hhKOqqvRqHJzd4zKOaX9H6gEnUtKjul2+QqZV6cusRbT8tvbVj+
	SXTZBNLJedsJSdWPHJc/P0/negrRDDtfanCHG+l/6VXQeYdII0BBcKQaL+EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755842; x=1715842242; bh=5HlBw6C3TiSc8sse/hoLej1tefGA
	G2Mr8Qo39n3+KvI=; b=cDyrVmgnp/PoOUfMQ6ZZWbRBnr2U+njAu5z5Z+4sxd+5
	NOXy2jYb/hbkoc+UrNdWwmdqaVNSRwPEFLSKnLATncNd/+Kh402BGYUahCXs+oXt
	nTTP6y2doMvSfCistSSse9vv9JkQGmKAkbXJqeqT1p86V1eMN1PbAveMHFEi9kQw
	s2PtHpnK5lA9ifgrsTx/2vcDGwzlcnb4zPCXBa2hni+OnbIkn7b9Wl2+07Kq5jGv
	su8uLu4UWOZ5r8aKYm9ZwNFR/NpB92ynWYywjXy9Btd3hrIssJNiw2fdcS1zlGvt
	mLYp3VgInemC8tnwn78VJYuZJmsQG2eQMaCDgeP3nQ==
X-ME-Sender: <xms:QVtEZgyOy-6MwB-XnibRQBO8NPK3pTi3aoeXow7mRsqwwrd9nli0DQ>
    <xme:QVtEZkRfUDGgur4z3hUM4kvJxfLy2HEcnfJ2G6D_cEYPY2LmK2fROHfrhQCB1Fr40
    -p35BPLeqIxQOCIwQ>
X-ME-Received: <xmr:QVtEZiUA4PZmJcki5aaChZYN0og99eyEaWQ95o0PwIxA3T-EfuJW-Z008eHpWTD5dQN3Gt9K6fRj2hL--WQSXv_WB5Rymv2WFnQ5PuxzkKN_gz2F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:QVtEZui5gNqEqtZxDSIwPdIcDvkLvEXHVu8ZfVuJWnHOhHW54rl6LQ>
    <xmx:QVtEZiBc-X19GepUVam1ZBjywqBDw2DrNV49lgi5yJQQFHuKsXv18Q>
    <xmx:QVtEZvKVV9oWYcbFw7QDDC1jtGGtrOQb_kceqycpF0rHv25IR2ZokA>
    <xmx:QVtEZpDVtzG8I6Jf7d8CllT1SpMWXS3rAgBoRWrqW0__oA06NtOGGQ>
    <xmx:QltEZu07U5ew4qZMZZUoigl-Z51MGY0xuIUAJvoaKQrdgbLy2q11q_9i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:50:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0f6bdb63 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:50:17 +0000 (UTC)
Date: Wed, 15 May 2024 08:50:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v5 03/10] Documentation/glossary: define root refs as refs
Message-ID: <0d185e6479394025c31d2869c144a667df3f4301.1715755591.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715755591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gw5zG1STYQ2B0jFu"
Content-Disposition: inline
In-Reply-To: <cover.1715755591.git.ps@pks.im>


--gw5zG1STYQ2B0jFu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Except for the pseudorefs MERGE_HEAD and FETCH_HEAD, all refs that live
in the root of the ref hierarchy behave the exact same as normal refs.
They can be symbolic refs or direct refs and can be read, iterated over
and written via normal tooling. All of these refs are stored in the ref
backends, which further demonstrates that they are just normal refs.

Extend the definition of "ref" to also cover such root refs. The only
additional restriction for root refs is that they must conform to a
specific naming schema.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/glossary-content.txt | 32 +++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-co=
ntent.txt
index d8c04b37be..c434387186 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -550,20 +550,38 @@ The following pseudorefs are known to Git:
 	to the result.
=20
 [[def_ref]]ref::
-	A name that begins with `refs/` (e.g. `refs/heads/master`)
-	that points to an <<def_object_name,object name>> or another
-	ref (the latter is called a <<def_symref,symbolic ref>>).
+	A name that that points to an <<def_object_name,object name>> or
+	another ref (the latter is called a <<def_symref,symbolic ref>>).
 	For convenience, a ref can sometimes be abbreviated when used
 	as an argument to a Git command; see linkgit:gitrevisions[7]
 	for details.
 	Refs are stored in the <<def_repository,repository>>.
 +
 The ref namespace is hierarchical.
-Different subhierarchies are used for different purposes (e.g. the
-`refs/heads/` hierarchy is used to represent local branches).
+Ref names must either start with `refs/` or be located in the root of
+the hierarchy. For the latter, their name must follow these rules:
 +
-There are a few special-purpose refs that do not begin with `refs/`.
-The most notable example is `HEAD`.
+ - The name consists of only upper-case characters or underscores.
+
+ - The name ends with "`_HEAD`" or is equal to "`HEAD`".
++
+There are some irregular refs in the root of the hierarchy that do not
+match these rules. The following list is exhaustive and shall not be
+extended in the future:
++
+ - `AUTO_MERGE`
+
+ - `BISECT_EXPECTED_REV`
+
+ - `NOTES_MERGE_PARTIAL`
+
+ - `NOTES_MERGE_REF`
+
+ - `MERGE_AUTOSTASH`
++
+Different subhierarchies are used for different purposes. For example,
+the `refs/heads/` hierarchy is used to represent local branches whereas
+the `refs/tags/` hierarchy is used to represent local tags..
=20
 [[def_reflog]]reflog::
 	A reflog shows the local "history" of a ref.  In other words,
--=20
2.45.GIT


--gw5zG1STYQ2B0jFu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWzwACgkQVbJhu7ck
PpRXKQ/+Py6LJVhuB0XqEVFqPzSZgPB/zpfm0Tkkmh5zKjaF0xduv1SP6NMeS5OO
bg0f8R5xQksYPyjUnxEyvr7cL+XbPWC1GHo/6FLAAPuGR4IIp/qP2xXp0DeJAsMj
7KzGGZaGdQfskI5EFj3oNaqbiJLbwEDPBSpEUkGkEjfBTNbvZLT1kf07Moo0yMLk
urlQtY2afkuFwIIDSTw9kcNX3BZ9DIkWn41ll4onZoNxAcCow/GuwuhBZ4iu1XD3
kGYhA+huRfZiV42IxNw5QqOzUwYzUlI4UXQRjt2cauDJp0CQ6azvHb+FFokcUYGC
mMdwtdx33Jinw6qmcfB56F87/2e0HQ/byph5EqHtmcdJlaHvPRyGU9JujyG0WXWX
vrJVONoZM82q7LEnHE5dwOnmUEf5m92ZgKHr0K9YbpEUIVPrMGZHyIAxhJY7xeWC
dqbgw2Qt681aghIXi5nGl7tItZ32Ucr2tSuSue5o3tAERdn345z66qPshSVsaJtx
DlWLJRj4vNULD4o3f/huwvtAviCcCfiCqyywBdaKd3tEf59RbRy/qI1p9IvaHH2+
pI+RNaRMiX0TQc6WFATFPTolmbTJBGts5Tk9zN3fzYRqsa6zO3riwZXU2U6+CkmA
m3bZ0j9H/q4izTL/tj6bbVatGQaiOGlOyR6a9Wgk8/8qmj6h93A=
=qsUt
-----END PGP SIGNATURE-----

--gw5zG1STYQ2B0jFu--
