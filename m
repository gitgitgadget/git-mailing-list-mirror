Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B655B1D04A9
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797951; cv=none; b=thmTCgvkagaN0E+Q4pkcKwIPZqMP9ku8H88isDm7hjYL8pfcOra5sT0HEFj0nynQuO4JWuqB4RxW4nCX4RTm2A1ojpypSBaxCIrmeDPLeP9mivNIqvVJRK84kW1UU3Q3yYxpervZNF2NbEk02q2gCb2BnWRbMg0ZRYG0dZxl6m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797951; c=relaxed/simple;
	bh=/PuXU3Z/DKlGCXSMcRCMREyi0uzuubH0dVd9ZiZGMAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2CuCzu1NSEZFfXkUQQVA1VlMNfPKvCtbSiBY5ljETlE2Y6yIIckjofTTucxwDHpQxM93wGeFnlOlbO2IxTrRlTni9UVaB07EVH6QHUO/06m1e6gbMFsiTCwtFc655AK8Biu3LgyRV0iyNhP6UPVHfYpAsG/uwOD77XH101LbSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xCUQewvO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K8awN/oY; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xCUQewvO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K8awN/oY"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id BB9CD1140171;
	Tue,  5 Nov 2024 04:12:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 05 Nov 2024 04:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730797948;
	 x=1730884348; bh=r3USq8gIBRthfs8tV8A6Jiwa7hsE2GVK7eSPH18idj4=; b=
	xCUQewvOggD/GkESD69Q91M+gogqrB8wigK6Pey33832NTkHDoN/Jj0zPX6Wi2E1
	YPF8UrIyhFGIkgj2Hwru9DSXSRyxnTO4DDT8YDQz9/QAUWMr2+EJuA+3h/q5s/Ia
	gyJpb0OVTVJZDg5MytwhnktdFm23ClWzeqTFTgkof86wSW0YsMgty0ozSu2AOZmw
	MKd1JYyd/b9kJ5WPntncOt4sbWs3w0tBAo6Dd2Q7GNW1dRHTISBJks8C10SSXJ/B
	ZJeJkrB8BIdS/wKS8Q5UHypzmxto0YgvbsK0YqTtNisXBZxhJP/2T/sCvIiaujpy
	ON7EjoQAs56MEH3AmalSVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730797948; x=
	1730884348; bh=r3USq8gIBRthfs8tV8A6Jiwa7hsE2GVK7eSPH18idj4=; b=K
	8awN/oYJDk5NrnUXi1Z6K35OjepiCdtkqfstKBd1+RLjXgPQuzJy3SjPWkquOe4m
	JrzsriGoHyDAWUJ5VwL7+RUuUnkovioakiCBgM28g/iNIBh5ea4Jm/A90D3OdXee
	mcvRmx9IfVknTRrt6J3uSYeXfPRl6qB2K1zcvh/zJcnlPcbfWiXkqtV6Q3YvCi5L
	v+JvSYxdkbuxzPKG3E39JzJf51+3f9QGSsFx0XYCoqyBR8X9lWac/lyElyB3J3r/
	AkKQ87VgOCspnB1RHj5OMGKjPWd4uhulR+TrXDLRSeg1xiA1zY/aIZnG6JF/cZwF
	ptocb3Nmc+mnzeWZhJWHg==
X-ME-Sender: <xms:fOEpZ5Z7_D8ZgxluUIsCb-7NAZD8WISGqfMPPvncJgeuMFPG15z7Kw>
    <xme:fOEpZwZ_x1_RSgUMenu3Oo2QDruV4hHRv36RqYg61awo3_bN9FASybXng5P0wXKTo
    79AjdExkIc4c1fwkQ>
X-ME-Received: <xmr:fOEpZ7_R-EgR-tLmsYnU8iHS3UnmeytrQChuoR-PMcCOAKpFlLKQswvbE-zaAXnwsQu9XHA7eikx1daIZSdMowDwRTY07isQmdMGcgnkPjBIfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelkedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitd
    etleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:fOEpZ3pUWuGkvsZQUUPZyFUAhd2pHMTojOjPxtQ_MI52wSm0OSUu3w>
    <xmx:fOEpZ0pYFwQsMokHvU9z_8iiFcc3vmCUy6SZzWiX9NsdHncyEhCoxw>
    <xmx:fOEpZ9SvYcgxJC1KxzvikqOlXf9VslkaWqrvQTiVX8WPnum7D4ANQg>
    <xmx:fOEpZ8rmnXcBkPsk_-uSjqgalHlPJEOszDEy8gNZwFT1hy2X3q8Pdw>
    <xmx:fOEpZ71kVXxRUZFtjqXmCLJPG7Sue09LJbCXCoRGHuZ4YyCqJaFc5Scr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 04:12:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 19b682d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 09:12:06 +0000 (UTC)
Date: Tue, 5 Nov 2024 10:12:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 8/8] refs/reftable: reuse iterators when reading refs
Message-ID: <276c27e770ace7030bdd83106c05f4fe5b07dbe5.1730792627.git.ps@pks.im>
References: <cover.1730732881.git.ps@pks.im>
 <cover.1730792627.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1730792627.git.ps@pks.im>

When reading references the reftable backend has to:

  1. Create a new ref iterator.

  2. Seek the iterator to the record we're searching for.

  3. Read the record.

We cannot really avoid the last two steps, but re-creating the iterator
every single time we want to read a reference is kind of expensive and a
waste of resources. We couldn't help it in the past though because it
was not possible to reuse iterators. But starting with 5bf96e0c39
(reftable/generic: move seeking of records into the iterator,
2024-05-13) we have split up the iterator lifecycle such that creating
the iterator and seeking are two different concerns.

Refactor the code such that we cache iterators in the reftable backend.
This cache is invalidated whenever the respective stack is reloaded such
that we know to recreate the iterator in that case. This leads to a
sizeable speedup when creating many refs, which requires a lot of random
reference reads:

    Benchmark 1: update-ref: create many refs (refcount = 100000, revision = master)
      Time (mean ± σ):      1.793 s ±  0.010 s    [User: 0.954 s, System: 0.835 s]
      Range (min … max):    1.781 s …  1.811 s    10 runs

    Benchmark 2: update-ref: create many refs (refcount = 100000, revision = HEAD)
      Time (mean ± σ):      1.680 s ±  0.013 s    [User: 0.846 s, System: 0.831 s]
      Range (min … max):    1.664 s …  1.702 s    10 runs

    Summary
      update-ref: create many refs (refcount = 100000, revision = HEAD) ran
        1.07 ± 0.01 times faster than update-ref: create many refs (refcount = 100000, revision = master)

While 7% is not a huge win, you have to consider that the benchmark is
_writing_ data, so _reading_ references is only one part of what we do.
Flame graphs show that we spend around 40% of our time reading refs, so
the speedup when reading refs is approximately ~2.5x that. I could not
find better benchmarks where we perform a lot of random ref reads.

You can also see a sizeable impact on memory usage when creating 100k
references. Before this change:

    HEAP SUMMARY:
        in use at exit: 19,112,538 bytes in 200,170 blocks
      total heap usage: 8,400,426 allocs, 8,200,256 frees, 454,367,048 bytes allocated

After this change:

    HEAP SUMMARY:
        in use at exit: 674,416 bytes in 169 blocks
      total heap usage: 7,929,872 allocs, 7,929,703 frees, 281,509,985 bytes allocated

As an additional factor, this refactoring opens up the possibility for
more performance optimizations in how we re-seek iterators. Any change
that allows us to optimize re-seeking by e.g. reusing data structures
would thus also directly speed up random reads.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 9c6e9c8374..4942363712 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -36,19 +36,30 @@
 
 struct reftable_backend {
 	struct reftable_stack *stack;
+	struct reftable_iterator it;
 };
 
+static void reftable_backend_on_reload(void *payload)
+{
+	struct reftable_backend *be = payload;
+	reftable_iterator_destroy(&be->it);
+}
+
 static int reftable_backend_init(struct reftable_backend *be,
 				 const char *path,
-				 const struct reftable_write_options *opts)
+				 const struct reftable_write_options *_opts)
 {
-	return reftable_new_stack(&be->stack, path, opts);
+	struct reftable_write_options opts = *_opts;
+	opts.on_reload = reftable_backend_on_reload;
+	opts.on_reload_payload = be;
+	return reftable_new_stack(&be->stack, path, &opts);
 }
 
 static void reftable_backend_release(struct reftable_backend *be)
 {
 	reftable_stack_destroy(be->stack);
 	be->stack = NULL;
+	reftable_iterator_destroy(&be->it);
 }
 
 static int reftable_backend_read_ref(struct reftable_backend *be,
@@ -60,10 +71,25 @@ static int reftable_backend_read_ref(struct reftable_backend *be,
 	struct reftable_ref_record ref = {0};
 	int ret;
 
-	ret = reftable_stack_read_ref(be->stack, refname, &ref);
+	if (!be->it.ops) {
+		ret = reftable_stack_init_ref_iterator(be->stack, &be->it);
+		if (ret)
+			goto done;
+	}
+
+	ret = reftable_iterator_seek_ref(&be->it, refname);
 	if (ret)
 		goto done;
 
+	ret = reftable_iterator_next_ref(&be->it, &ref);
+	if (ret)
+		goto done;
+
+	if (strcmp(ref.refname, refname)) {
+		ret = 1;
+		goto done;
+	}
+
 	if (ref.value_type == REFTABLE_REF_SYMREF) {
 		strbuf_reset(referent);
 		strbuf_addstr(referent, ref.value.symref);
-- 
2.47.0.229.g8f8d6eee53.dirty

