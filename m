Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6AA1D1304
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882167; cv=none; b=XR82/xTLXf4ycYYgiDZnP1OxdwzdHCJBsiy31zEYa4LsyND5pr4D8fu3haPqzVY8OI1Ukgxc/onVRrzkWBAJKVJFuGqOZxdU6RKLVyi9BytNSv66wnBdFBN1E5g892ytx96eHTMzMGGhdJI9bUTfflEXWhmPZ2+hsdiiFQArUqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882167; c=relaxed/simple;
	bh=KaeamRs6hoXQtKAKfTvQNV7Y2Q2d0QKohiI0efm7vDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suj3ZxPeM1q0lMYGThAhedzTh5CrgIETEzpBkBir6GaHwfJkVnMyAKWMgkhtUYk5dwiFUUuGf7YYC+WsceId2DaKMvUaifsKXhjipGeWRU7ecYj0rPlaE4kdJSjpa/lMYKrRJva/w8e2H1+ASLja7tqdrlK9MzSwhy/2W52Y0VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kdsz3R0a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ibp8gCs3; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kdsz3R0a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ibp8gCs3"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 948721140111;
	Wed,  2 Oct 2024 11:16:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 11:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727882165; x=1727968565; bh=tDRW2ASynI
	exwAQfMUojWS5wUXxv/OGy14h9d0CTvB0=; b=Kdsz3R0abepYLogyF1hxjPwEN7
	jruer0K4UGW9zEz0KjE0QdM3QW6sBizBO1BfyDJak3FjKUKnjSQsH2eLUj6HQEPx
	f70pK4DJqHObbcVs5/2JXmyWkbt+EzhlWV3RymSJBSlnY8+Voj5MUEojHaBoP8dq
	Y1kgOba3uHx1Bw3KwrlObVBgeCFN3RZsiiv38t+alXbYwtYei6hqcq3ppfE2IZt/
	IO7BG4tba+KzpHZ53gChNLzWFI/Ko3THwfTTq678vpQcUP3BaQyGe7pNnsmkAJSS
	aXdNRvy2u1CKrjAFmnpm4xEq60dP0dKTaYwUH05SxUGpGXBbmUfYviGX2/jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727882165; x=1727968565; bh=tDRW2ASynIexwAQfMUojWS5wUXxv
	/OGy14h9d0CTvB0=; b=ibp8gCs31QdNlVtK3jya1xPzt17dJy+Cn6x2T5EYCY+R
	REt+fJigLlVLx6TA+c56L7XRNJwr3EorHdQ22SPfoyVlOJT/Mge3OkaJCPN9ETUU
	XYBmFOnVHw3sho9QrqFD4VSskOo9PodOr/qmCQdd/+rRZzLyz0IRgTJCYGlmKJSm
	zKmAzYZjHFsdUJbhFq/liwysVOOkztxReDfzKQFZxAxUfmSS5fkh2E4IOnfh85F6
	NjxRyVsBudr2XgGh6DZyUFARw1Ei2BUZb97d/pCjdTia8CflnzBN1CJ8s7bAC8Uu
	5Hbf8ZIEFhj6tG/TRht6c2k+zFRlawQwRLXgT+VLDA==
X-ME-Sender: <xms:tWP9ZiuG9T8K4MKNlDpI26gdkYMsBP8tixuJCzOgDDTutRXfV42ahw>
    <xme:tWP9ZnferhMTMuZkOZvzyZFGlVFrTn15eR9gqTkCCFq3noeS6io84Pmi5puYOyo_u
    KnX-yF_FcFIZ57fgw>
X-ME-Received: <xmr:tWP9Ztz6Z7yXSO1cYE2Te_tZ4n9Y89gAa-Sz49DWrjlPFgVXuGz-xsAjR9wMj2WOtnMgqF4hy8EAn44LM_YZdNLP8561RQE9NAqJFQ_GtmhrtDYt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:tWP9ZtPjWvNl-2RLZhtabMtQJ3l9biVuc3_TaewpkZl2eSmaeGk6bA>
    <xmx:tWP9Zi9XKoPi-6l6vvYUB3Y_C9nZIl5R07eL4tM59cRXK9yuH1-z_g>
    <xmx:tWP9ZlX1lYXdDPfrpMQoFjIcEtywo-C6gOqkc2Q6GlAE1mAc6N624Q>
    <xmx:tWP9ZrdkPe4r8mMcMY6bHnREdKnFs41n3A87oo_KaISPp3azSRE4PQ>
    <xmx:tWP9ZkJ7MbzlPVY7ZzLPTgJeZPsBrDhPDIHJeUNy8VmOyuhj-QMZ0pXD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 11:16:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e2734ac3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 15:15:14 +0000 (UTC)
Date: Wed, 2 Oct 2024 17:16:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
Subject: [RFC PATCH 09/21] http: fix build error on FreeBSD
Message-ID: <1c1cd4d8ef9aef843f8825321a2ab7a8026b0580.1727881164.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727881164.git.ps@pks.im>

The `result` parameter passed to `http_request_reauth()` may either
point to a `struct strbuf` or a `FILE *`, where the `target` parameter
tells us which of either it actually is. To accommodate for both types
the pointer is a `void *`, which we then pass directly to functions
without doing a cast.

This is fine on most platforms, but it breaks on FreeBSD because
`fileno()` is implemented as a macro that tries to directly access the
`FILE *` structure.

Fix this issue by storing the `FILE *` in a local variable before we
pass it on to other functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 http.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index 376af88c5d..28f70a7a9c 100644
--- a/http.c
+++ b/http.c
@@ -2289,17 +2289,19 @@ static int http_request_reauth(const char *url,
 		case HTTP_REQUEST_STRBUF:
 			strbuf_reset(result);
 			break;
-		case HTTP_REQUEST_FILE:
-			if (fflush(result)) {
+		case HTTP_REQUEST_FILE: {
+			FILE *f = result;
+			if (fflush(f)) {
 				error_errno("unable to flush a file");
 				return HTTP_START_FAILED;
 			}
-			rewind(result);
-			if (ftruncate(fileno(result), 0) < 0) {
+			rewind(f);
+			if (ftruncate(fileno(f), 0) < 0) {
 				error_errno("unable to truncate a file");
 				return HTTP_START_FAILED;
 			}
 			break;
+		}
 		default:
 			BUG("Unknown http_request target");
 		}
-- 
2.47.0.rc0.dirty

