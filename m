Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318E82D3EF1
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996910; cv=none; b=l/7fJQK5r0MqqUrebmgZzYZDS7mYU9wsT5mE6mzQ64MEkTMyBF4Nybx+GAhF3CI0YLEy1gFrFOf5q/IVtWwzbEm62O/6V9E9obQg7hrKM6XKsnj+r3dDSl0wyJtn923nEjDauOLg5lPeV4OzUjgI9vEp77pkEq8VXCFR/9GlbDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996910; c=relaxed/simple;
	bh=L+Kpt82mgQ/ot3Ry0ArzLMpALGkiU0yMN8idatUXQbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pr877JBZk5nmcQBD7UVLtfuW9hW1FFyzT8csN6yKDlj1ClSNUajWU9lOeOF6x+Gfc2S5uronP2GZnXwhhd3t2g/sCDtehZ6KbrfNcnz719cGLtccoUAs4qrrM/usBoFGiG/neqTbiGuAkkwU73LQ5u924epM9yRcTfMfhC6cvZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BDAIrJ7N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fDhq1VVC; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BDAIrJ7N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fDhq1VVC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F0E787A00D1;
	Thu,  9 Oct 2025 04:01:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 09 Oct 2025 04:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759996906;
	 x=1760083306; bh=WNvDNEsi76a9IqicjGzzBvJffKjHHdmPggHJ7sM/RlI=; b=
	BDAIrJ7N1P0D6+9BAzLWqquKkbuzHfS6FCcINGpdwtn0L+Pch4mAQgjw2vNG+88E
	/qybyzgYCH/JobbfNy6zaNKM9s4jA4oCSN475WVxY0Doa9ClaUIVkFENMgA0JaSC
	aWFZlyKLCxjxZKA0N0F6OiOBR4R1cZOo3By9bQqiIdPc59iS9LlYLAx/xfJt0JYB
	RdAVALbUs2+F86Yv2+i+lKz4/nP0lt6BnKOsiXS/1OAuT5iRXyO85CmW1O0fXSKR
	Y0J5MscBHQZ/Bw7L+fhAp9ekrHLhFuK4psPw2Pb689/ANijLGXxNq/e90KdMOwFi
	RrYZXjmuIe3Lz6yGzEcFbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759996906; x=
	1760083306; bh=WNvDNEsi76a9IqicjGzzBvJffKjHHdmPggHJ7sM/RlI=; b=f
	Dhq1VVChUBL5CA9M0FwjNOCl2iiE+f//zmEUUfIp3r54wrtQqmhgcOhkzFC9jPjI
	kVkLm0KQkXbDcpD+8XmPRE902nrUv91LNjRRrTEVox2+MPGOb5Zgg+DLc2oYIQ9H
	g19GouzRXs1LgHM5V2ptcJm92xIOe3YvTpFC0jmYcBclHicCPSOdM1iFddlBPZfn
	7Vu4F1Xj50xX/Uw0cv2AJL0pebebU3cN0bZw35eCuwP6SBBvhMkCWDUgoXrm95Kr
	J2eZK3g58xDTvHeQ5mdZWvGBgkLmc2zZDB27xlDViAcwlPT4ijHfA4V8ODtPE7Sv
	s32+43Ijh/wf1rNDnh3ng==
X-ME-Sender: <xms:6mvnaDmH8wgahXbMxEWBiFOON6_oN6P2ZhX02P2PFc09Q8ja226IlA>
    <xme:6mvnaM1oTYo-OR_V1oDDHtkzKjW8mXoM0T0SlEC3IFv7bcU7aE-uAG8tYXjA1VDeF
    b3HOirV3zvMB2XRDfvDb79l_i4sCouE4cJWqWApq2ytbmqOGq9Z9g>
X-ME-Received: <xmr:6mvnaHTDYgZQfZCnPGEnaA-6N9sOTFWYB-TFYTkMmVwh-Yc-eup6kgA0yETKorhKZaIJnKxNbzKwoCvCvCOOKD5NjSTk-YoZ059PjYhm7po>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:6mvnaGu5cWKKRbnfp5QMMZhyP78GE715UAQRz3UC7SV0hanNf_Ou9Q>
    <xmx:6mvnaEaSbLk_E5uvNwoqb4SF8dynTq2B0Lg1DlheQ97SHsQ3g4hQiw>
    <xmx:6mvnaDsXxahoChf5ttaiDBbHcXakQBoJBX5pTo1y9DFxKl_yj7pXrw>
    <xmx:6mvnaOGYwl6t7V72hnRdQ27q9A2dLJAWnzMF8zWGa0soEumFcPf2-w>
    <xmx:6mvnaNu9buCpmZXcrY7ii0bO6NzKTQDN1ppJ-SxvFBbV-W4zRBAma9qv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 04:01:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7d5fcc69 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 9 Oct 2025 08:01:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Oct 2025 10:01:35 +0200
Subject: [PATCH v2 1/6] object-name: convert to use
 `packfile_store_get_all_packs()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-pks-packfiles-convert-get-all-v2-1-0d73b87ce711@pks.im>
References: <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>
In-Reply-To: <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

When searching for abbreviated or when trying to disambiguate object IDs
we do this in two steps:

  1. We search through the multi-pack index.

  2. We search through all packfiles not part of any multi-pack index.

The second step uses `packfile_store_get_packs()`, which knows to skip
loading any packfiles that are indexed by an MIDX; this is exactly what
we want.

But that function is somewhat problematic, as its behaviour is stateful
and is influenced by `packfile_store_get_all_packs()`. This function
basically does the same as `packfile_store_get_packs()`, but in addition
it also loads all packfiles indexed by an MIDX. The problem here is that
both of these functions act on the same linked list of packfiles, and
thus depending on whether or not `get_all_packs()` was called the result
returned by `get_packs()` will be different. Consequently, all callers
of `get_packs()` need to be prepared to see MIDX'd packs even though
these should in theory be excluded.

This interface is confusing and thus potentially dangerous, which is why
we're converting all callers of `get_packs()` to use `get_all_packs()`
instead.

Do so for the above functions in "object-name.c". As explained, we
already know to skip any MIDX'd packs in both `find_abbrev_len_packed()`
and `find_short_packed_object()`, so it's fine to start loading MIDX'd
packfiles.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/object-name.c b/object-name.c
index f6902e140d..4e62bfa330 100644
--- a/object-name.c
+++ b/object-name.c
@@ -213,7 +213,7 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 			unique_in_midx(m, ds);
 	}
 
-	for (p = packfile_store_get_packs(ds->repo->objects->packfiles); p && !ds->ambiguous;
+	for (p = packfile_store_get_all_packs(ds->repo->objects->packfiles); p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
 }
@@ -805,7 +805,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 			find_abbrev_len_for_midx(m, mad);
 	}
 
-	for (p = packfile_store_get_packs(mad->repo->objects->packfiles); p; p = p->next)
+	for (p = packfile_store_get_all_packs(mad->repo->objects->packfiles); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
 

-- 
2.51.0.764.g787ff6f08a.dirty

