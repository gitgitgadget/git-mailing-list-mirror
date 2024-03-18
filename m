Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A351F37162
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759190; cv=none; b=Hokb9COSeTaVetClWGN6pa7nsmgJfFALUdNeDLWrTwOiiGW94fi3JnkhM3CSBOisMnnFoX83c2P0JdvgkOvsc9ZC0lTJZpVvuppu5XBGaLwYnCKJoc1EuX2J4infpAcJKmoPSx45vCMTjwW8m8twk2vPzrAIlFfDrFY2irdZ7Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759190; c=relaxed/simple;
	bh=IMM1/viW/LzwGwufRw/2442IL6Z7zSr4o8r8LQe6vAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6ZiyeFyS70i5XjoRl9RVzHiqfGVICMsthuCpNxr5KeErharnUxzYR7dV++4mqqebJQiWy594T6Bljwb4ja85EriU7QA9DJRUXnfZkrAjtJTxWoBq7rNToMfPWP87oKNgQ7qb579Tv1L9NXsgWDR8nV1Uz6Ex8uWX7lCn19/G24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l5+mqjge; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T6EVSsio; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l5+mqjge";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T6EVSsio"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id C9F8C13800B8;
	Mon, 18 Mar 2024 06:53:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 18 Mar 2024 06:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710759186; x=1710845586; bh=XKBZZRJ7hB
	6UxlSt/Fjqr2jFVS1LRjVEGrsdzfMpgpA=; b=l5+mqjgeMol+Ug0Di4gaBb7MPx
	8/SrVFSMH/MbXWVE5TqsvLRciKrazV8FTOpoUCuAw2WueqW523x7K80gn3PT33xM
	bQRh8ZCS6EOsQ7jmBo312JdGDKGeTch7k+g7kmgOg26U0xYMpJ3m8vx0NOPbinGE
	ehEPQ/fQ/9Gc8KLc545evtWZL5R3Me+kkN5t2gPPQSEhMlBkN8U8eKyY2I5RJ6Cp
	cfUoc/Y5/uV4VTrIT8Cd7mm1BYq6k6AAwiSyeXlZRFvqu6e4eh8gPuXZcgA3UxVx
	ej/5lKvFI0D3jpA0h76FJYcM/8x9RDqEb0oZm41BM3/McfMFvSMojwNrnCFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710759186; x=1710845586; bh=XKBZZRJ7hB6UxlSt/Fjqr2jFVS1L
	RjVEGrsdzfMpgpA=; b=T6EVSsioRjv9occoE2R06tVFC+bxoOlFG6k3vS7Z4hyL
	bwC9h4MHzKbg41AMwBb0L/Vcw/dU2FfQ16qJXkpZk14p9c9671RYoVTy3od52CpU
	7M+RDRxyGxja4MHDSpsy6gT+ZvnGrWBY7Y0UaBHzxOq86sCUeAbsfocFC+BLJOfa
	h829E9UWJamev4FQRkMB8OvpQRtVakqMItibqoll0K8LhIevrfg8MzRcItqQeOQB
	81D0Ztyvcm6fEuioQ2Lwu8y0XTso7gus5VR6kHhGNMeUoq+hLlkLsO0NTZ0iKXa7
	9F4Dv3d5Nm1xMp6I/L1cRW6jYb2CIG4lUTHzVxcADA==
X-ME-Sender: <xms:Eh34ZQSz5TDrjqXM4Hnq2kkeQ8TuAb0RdLP7YUeKMxuxHc9Xa0C3qw>
    <xme:Eh34ZdzsSPhKkkoUCe4VOAb_ekNLVOLYK3OgBKgDcPv0hmubl8eFQspaqHq5OxoOD
    h-Y8Msj93l3JWwrwA>
X-ME-Received: <xmr:Eh34Zd3ZClaedl1XvjSfBblosCbuYK2Pe4UX_Z-sio6TlZwiwS9nosHv2DFDUffwSoYhRniNOeB3As3LgQzaMCQKEoNMOgFCsf6wXlwHgfqaBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Eh34ZUC9-iT79YNOEwdt62xsFlpvyiv1YzRVrljBeiSNtzfhXsnkXA>
    <xmx:Eh34ZZjYDTjxrV64N-jg9JHbhHPknHaC3dHzp4CqvmXiKnAjE8YNgQ>
    <xmx:Eh34ZQplhEv6aYQBowWDKfgA-hs1wDSdWU6pzPMr3YTY8GL3aXzzqA>
    <xmx:Eh34ZciS-10pRz4pUtXocKCicondebC-GXBdIIswoasDX-NUyUNFtQ>
    <xmx:Eh34Zeuh7Kwq4G7zYGTXQte1c7cEg6pquXMmP0wHo9OSZTi1vRKwgw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 06:53:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 34be92b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Mar 2024 10:48:15 +0000 (UTC)
Date: Mon, 18 Mar 2024 11:53:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 09/15] refs/reftable: expose auto compaction via new flag
Message-ID: <61ebcb2d52e829cf8d8a5b24f16a79b8ff4d0f3b.1710706118.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PQX63nC4/bC3QWBb"
Content-Disposition: inline
In-Reply-To: <cover.1710706118.git.ps@pks.im>


--PQX63nC4/bC3QWBb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Under normal circumstances, the "reftable" backend will automatically
perform compaction after appending to the stack. It is thus not
necessary and may even be considered wasteful to run git-pack-refs(1) in
"reftable"-backed repositories as it will cause the backend to compact
all tables into a single one. We do exactly that though when running
`git maintenance run --auto` or `git gc --auto`, which gets spawned by
Git after running some specific commands.

The `--auto` mode is typically only executing optimizations as needed.
To do so, we already use several heuristics for the various different
data structures in Git to determine whether to optimize them or not.
We do not use any heuristics for refs though and instead always optimize
them.

Introduce a new `PACK_REFS_AUTO` flag that can be passed to the backend.
When not handled by the backend we will continue to behave the exact
same as we do right now, that is we optimize refs unconditionally. This
is done for the "files" backend for now to retain current behaviour,
even though we may eventually also want to introduce heuristics here.
For the "reftable" backend though we already do have auto-compaction, so
we can easily reuse that logic to implement the new auto-packing flag.

Note that under normal circumstances, this should always end up being a
no-op. After all, we already invoke the code for every single addition
to the stack. But there are special cases where it can still be helpful
to execute the auto-compaction code explicitly:

  - Concurrent writers may cause compaction to not run due to locks.

  - Callers may decide to disable compaction altogether and then pack
    refs at a later point due to various reasons.

  - Other implementations of the reftable format may do compaction
    differently or even not at all.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.h                  | 6 +++++-
 refs/reftable-backend.c | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/refs.h b/refs.h
index 8c8994cb29..d278775e08 100644
--- a/refs.h
+++ b/refs.h
@@ -422,8 +422,12 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_f=
mt,
 /*
  * Flags for controlling behaviour of pack_refs()
  * PACK_REFS_PRUNE: Prune loose refs after packing
+ * PACK_REFS_AUTO: Pack refs on a best effort basis. The heuristics and end
+ *                 result are decided by the ref backend. Backends may ign=
ore
+ *                 this flag and fall back to a normal repack.
  */
-#define PACK_REFS_PRUNE 0x0001
+#define PACK_REFS_PRUNE (1 << 0)
+#define PACK_REFS_AUTO  (1 << 1)
=20
 struct pack_refs_opts {
 	unsigned int flags;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 66cdbbdb24..135bd4e268 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1220,7 +1220,10 @@ static int reftable_be_pack_refs(struct ref_store *r=
ef_store,
 	if (!stack)
 		stack =3D refs->main_stack;
=20
-	ret =3D reftable_stack_compact_all(stack, NULL);
+	if (opts->flags & PACK_REFS_AUTO)
+		ret =3D reftable_stack_auto_compact(stack);
+	else
+		ret =3D reftable_stack_compact_all(stack, NULL);
 	if (ret < 0) {
 		ret =3D error(_("unable to compact stack: %s"),
 			    reftable_error_str(ret));
--=20
2.44.0


--PQX63nC4/bC3QWBb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX4HQ8ACgkQVbJhu7ck
PpTmCA//auLt79VCwQ/HXC+9bCmeOpNPUGaXoa7mLUC46m1EXCkdcg2bc22U5Sk9
N/3vK/0SZ33imFn5J/Z65bvGesxpPBwF6686X5bS007PYN2dQLlTT2nwuxcaQuJI
knbaH38guhBMVmP/wlxTKU9HkChYgTopo6opp2lbN/bfB73DwfH86h5cL8iWVBJu
QVINlPeQhHzbYq9hdgBk+yOrgW0xiCi7spsk+kUMzcEVw9jPcqfiqjwSabIHZ6jQ
8a8sPSHEEh8tLFbfLTMs+E+9OsyjLX6txtvAVW9epNo+IZl53dMCz7j2ozks9s23
in6mlt6x6tkbScnJOJGcIkAo3oIUAtpfy8kH23nANz09iiKMFVQpZ4O6PSfObYIW
Rz/aWkZQmqYSjJU1llfFs7jEBLL9aXAuyx+G3UuCWzRNoGBVhJpHNje6853CL47d
/4cfk3XW1Y19T8isL+WnWtOIcbDSoNXTLTF5H+mCF4suMlnDY70ZvKnJoYrVPC12
4Cdd872lKz02ZOZD9p2lNUUuAJGvdwNZaIX6ylUp6rpv5c79NwXMZUJr7c/Sr2GF
E8QOIbH60OSQnLASUR5TGZW4UMEiyj0R02NmNCv2zSY2+w4a4azIVlgETQD2jq7e
F2Le+zCj/MGcdzEM7Fxyf03Q1epniGhSoeMqIHx5PM5D1+a/kqM=
=UwrO
-----END PGP SIGNATURE-----

--PQX63nC4/bC3QWBb--
