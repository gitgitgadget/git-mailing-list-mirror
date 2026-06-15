Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE1B3F44FC
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531833; cv=none; b=koJhn2oGRnIbRnu9CPFRDmXBtiD9MzreKixCg7H9Ac98L4QU82v7kLSNWxZYufBC4WLbQbr6G60HI5lKO2yKL63K0zU0Om2j48KN76iSKcr8LRejOpWQ24WofqZ9iLCWRdjTRZMsw1POe+VoKpXIKnauswbvt3CQjqWsl3jTkfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531833; c=relaxed/simple;
	bh=iBUp/OZY+6Z6qpReLv2aneNEHDTv54tKshCGpKMrQ1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fhKEz9tskNUsrcBrlIceUl7M3h4tq+wDaEalh451811p+EvMsPT8B8lBrTa0KlxP7afZesd7/AKwvCrbiYr8L6pPOtT5nKlq88oEAmu2FsjtJpytoEE6g+hRy61PTr6gIw0zCfY0XI49RA4qke+jzfVrzhEJ4NpxZM2D0s/O6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=la7tfnDG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QDlSQn4K; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="la7tfnDG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QDlSQn4K"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7DAB01400042;
	Mon, 15 Jun 2026 09:57:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Jun 2026 09:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781531831;
	 x=1781618231; bh=wVlVNRr/UkwsjHko6Ckbj/voZM+ngNaAP9P/L8Tqot0=; b=
	la7tfnDG2yman6VofZg1+zg+r6Kpuk7MLTeOSiSpMlclDEf/CzT5eW2OwY8+x8Sh
	AAxCpKbZRwxPZudZCCyEAhxaBZTf107MMjDXeq0h3UsWRsNTIROr8p8A4FGNaXdr
	6d2r0m16JeK+aEAoTfHt4tUzjepLpggWn+jfKF1ArFrsUZtdf51Tyx/wfsrQYjt1
	CLX9r+IQZCWENFzCmykiRUlYQZkGAv4qwoJoGDoNXrZBJ6suHpONeWidW9YgvTIy
	HVw9+OTreK0BAb4+QP8JPqo1wcLLOei9/UJ3z7XwfQYs8YM3QljxpHdx+lUgsmRw
	w8HXBRqcpUwKyDgvsjjTzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781531831; x=
	1781618231; bh=wVlVNRr/UkwsjHko6Ckbj/voZM+ngNaAP9P/L8Tqot0=; b=Q
	DlSQn4KQA9vdubISRdKdHCgJWyJOqzbka86V0cn2kMMKS/cJV8slqqAl6jk/rIGi
	y0+58rHJqQddMzHsDQxLaZad4a2PkhrzPJl3Nxv1Z9QjRMnNsbjga+nage8N11Jm
	diEMOsGscUVPbYzT/Jj9u343E4k03WACpBTWaczNAR/+OnBrWcwQObql2stRO8Ud
	OEBZqK+HuuZE6X4T57fUbpg3RAmB2rCTdeZ8eqJWsOXWtHBfjK9ZSaDZGbpyxGfT
	998Z5d3Ve0otRaSj1verb7LOY0FQeLir9gXxxDS0fpYCywo2hTEA5LJEIabEa852
	V50+EBfqU3v5iL77DY6ow==
X-ME-Sender: <xms:twQwao7PkLIr4buFckGRK_XeOBOWP0F2EAv5CLnmSNE7BC1K9jKNxg>
    <xme:twQwahXr204n3BTTS6YRcaXsGlYb3VSvOVCLNUNIIJqmnuD74_T1AR8YopwA_RZ9Y
    x0hJjIC7P2f_iAbi0edKOFwm5o5Cp_vS0eFxYEOL2CpXDqRmfq79F0>
X-ME-Received: <xmr:twQwak3-sUqvFpmuHBm1ezBw_fxGMA-r-bCnyjcNVzbG2b9K6RNW1-hcf9HcZuizDI2qPGUIOxB9D6I68OkyhQTlTp6vBUh5HU49SUJuUA>
X-ME-Proxy-Cause: dmFkZTGFhnwv/YvFh6g4CptNd7XsyKN95Web0ZIZs4XMP2v59A2c8hDhZ4VNJ/MQxBhMoI
    FWZ9GvenrC3kM7RRy3k2kxBtkzeIGwjw8dLo/RpOMYqK1kz3TfFEo7V8uaLwaE7NQYHF3I
    wfF67zuCkHSv7iQgvKBFFp6OUjP0P3VEOUQIt8OSsqw2klesHbMKhOydcbE6VEmPPlIPNq
    ZySPByW6p2jKJ0N4UqPKjGwqXr9fX/2NZVLxm0BYmDIPXuoILOsOLWVhQptj77pEZp+d72
    CziUcfUBHDeap8uqtsPocxWbqNRndtyNwiJlbnFM0XNN1VUAqQL6wbZ0+VSk9v9/mJXbjy
    MaXVIv8eV/2g2Sjlu8jnkph+SZGdrtR3aN7pDrGF67V2MdG4lwQxGM68sImXqaLv++SPLL
    +RAGxZXndHYcIAa00+M7k7TomSq2LRH2u1eqxRNzkDd5H2/RzRXIWf/8FxW7NXXPha3ypL
    0jZbUKQF3gvMBYhJcia5k7pbg0ZSqZu/1wksuc6o76b3AkK/3LeaDsUOIZl+89HBcfKhm4
    YkO9DQ70dgpIFxuVthGDlux05Y0KIZ1N/SLlQOtZkTp0E3pikuUG4l+d4lfL97oY7IjNVn
    DXDpXg530VeGwtZ4L4m+UbkQawwJSoU+HPdlvjlWzi0BZeG8KdokrGSgKuBg
X-ME-Proxy: <xmx:twQwam34CNakgbBSXrH4vtBFubbohzAMYsmsO49yE6p832MuZjm_uA>
    <xmx:twQwav8v4SVWjLYe2c1HgX5tmpHHibx70EOMm4KZW6TGINYSMfDe2A>
    <xmx:twQwar0Kpt3AbRs4RdOLlhhSSXxC7enDXE7ykn8iWI7I1Qe4wwJC4w>
    <xmx:twQwak9qZ8fp4fpDaUCtPSltcYXbUWpyii4TFNEaNhePSmP0Euuc9A>
    <xmx:twQwaiBlt5VKibmoZgfXdcTr6ryPeVyLAVRIm8eY7BFHQKD9q6-23JJB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:57:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4088db67 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:57:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 15:56:53 +0200
Subject: [PATCH v2 7/8] refs: fix recursing `get_main_ref_store()` with
 "onbranch" config
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-7-f4854aa99859@pks.im>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
In-Reply-To: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

When we have an "onbranch" condition we need to ask the reference
database whether HEAD currently points at the configured branch. This
unfortunately creates a chicken-and-egg problem:

  - The reference database needs to read the configuration so that it
    can configure itself.

  - The configuration needs to construct a reference database to fully
    parse all of its conditionals.

The way we handle this is by simply excluding "onbranch" conditionals
when we haven't yet configured the reference database.

The mechanism for this is broken though: to verify whether or not we
have configured the reference database we check whether its format is
set to `REF_STORAGE_UNKNOWN` in `include_by_branch()`. But typically,
the format _is_ already known at that time because we set it up during
repository discovery in "setup.c".

The consequence is that we have recursion:

  1. We call `get_main_ref_store()`.

  2. We don't yet have a reference store, so we call `ref_store_init()`.

  3. We parse the configuration required for the reference store.

  4. We eventually end up in `include_by_branch()`.

  5. We have already configured the reference storage format, so we end
     up calling `get_main_ref_store()` again.

We still haven't finished (1) though, so `get_main_ref_store()` will now
call `ref_store_init()` a second time. The end result is that we have
constructed the same reference store twice.

Of course, as both reference stores would be assigned to `refs_private`,
we leak one of those two instances. This never surfaced as an actual
leak though because the pointer is kept alive by the "chdir_notify"
subsystem.

For now, we can fix the issue by explicitly unsetting the reference
storage format before constructing it. This makes the mentioned check
trigger as expected, and consequently we won't end up constructing a
second reference database at all. Ultimately, this means that we
consistently stop evaluating "onbranch" conditions when constructing the
main reference database.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index d3caa9a633..e69b9b8ac8 100644
--- a/refs.c
+++ b/refs.c
@@ -2351,15 +2351,31 @@ void ref_store_release(struct ref_store *ref_store)
 
 struct ref_store *get_main_ref_store(struct repository *r)
 {
+	enum ref_storage_format format;
+
 	if (r->refs_private)
 		return r->refs_private;
 
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
 
-	r->refs_private = ref_store_init(r, r->ref_storage_format,
-					 r->gitdir, REF_STORE_ALL_CAPS);
+	/*
+	 * When constructing the reference backend we'll end up reading the Git
+	 * configuration. This means we'll also try to evaluate "onbranch"
+	 * conditions.
+	 *
+	 * We cannot read branches when constructing the refdb, so it is not
+	 * possible to evaluate those conditions in the first place. To gate
+	 * their evaluation we check whether or not the reference storage
+	 * format has been configured -- we thus have to temporarily set it to
+	 * UNKNOWN here so that we don't end up recursing.
+	 */
+	format = r->ref_storage_format;
+	r->ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
+	r->refs_private = ref_store_init(r, format, r->gitdir, REF_STORE_ALL_CAPS);
 	r->refs_private = maybe_debug_wrap_ref_store(r->gitdir, r->refs_private);
+	r->ref_storage_format = format;
+
 	return r->refs_private;
 }
 

-- 
2.55.0.rc0.738.g0c8ab3ebcc.dirty

