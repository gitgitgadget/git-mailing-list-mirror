Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3026412DD88
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656910; cv=none; b=IfQUHcs6cqKQorB9WPtEA/W7ezY8oqYS5Osi2UoTTK8+OjyHaLME+dRbqbifFTVvDUq1Gsr3/OTe7WdKIQSj8HJ68FzRvvmHwNVHnVUNh8mwXE/rADeDaAkMzRJMBQ+vJKA2zviEYCJWPf8WgLGN08FM82oQns0r2NMPgKTusw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656910; c=relaxed/simple;
	bh=hrBbhECVCQPTvF1c1YFq/yVIdPCwxk0m5uvMuU2lukQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGMNQJm8eCIDprDePYOPk7dO2v35wKDThQDecS/xl8GvByRakd5IVSR2ddj6njSnKHT/6mC4JiRTI65ZUucVe7y+yqF0fuE0d+1kB1CeO9zj5RZ7mHe9m7qHpTGnCG4FO7fbZIkEQqc9LSupdVdL6me9ktNd1QcKksrAlFoR4bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y9B2yerr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lshakw3z; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y9B2yerr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lshakw3z"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3F6B51390775
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:21:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 26 Aug 2024 03:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656908; x=1724743308; bh=utaLNgXSki
	lva6ulXzPRcwH+nxo3wvLqc1U0+XbhR8o=; b=Y9B2yerrPq+d1cXFzUpZul5CJb
	eeD3KNKl6bOCP48Oq+oYmJY501DbfVCMEEjPUp5O0OxQIlcg7GlrF/pOHNVBQ0nR
	RpXbPIxTKc+ma/ICYgTuKdimIvo0X5ojZPwxA2H0o3mpqqMLORbkJthuNVf126g3
	aCjnX0TrduOsJyrobgm4+vQcr96eIpjbCm82ctZ4cxGHVjjgtcECclbI7NNKn7jL
	yx8HMppgNYZnAba4oyM3HIZRW6gPVFvkOAHwwSiNVigjJvoVavEVu6BB+v3E8Thw
	TCitfd8B1bZ04BhVP2BpTC3qYZZ7U0wjktpp0A3Xahu+02pB9LjnoEbqidmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656908; x=1724743308; bh=utaLNgXSkilva6ulXzPRcwH+nxo3
	wvLqc1U0+XbhR8o=; b=lshakw3zXxnquz6pjZcrZugGDawH3iyKSxxqmuY8HhnF
	R4LUT7Q0nP90H8EEN1ya4jE063EC1+7vH17Pqr1QU0cMJk6I6U8sX7hRPs1cceBm
	Ck1FOSWdAyy0wSzryAnQz7L4rzRFIta11i8rdDbtxdr12yGzIFU6HRQqLEvTchSu
	4UCw6A377r4b6M81XlJ4XkDla1QOgctOC4rXoYfAIecpf/xc5rmN8u/fo+eef3ps
	GcNBaQ1lzJsFeRzk8VZqeD+krU+ewdA3mabWh1xY78pQcwR191S2OoLmMjlI61Gr
	a8qpm9rPY5l32ajbf+AeoVOK5uQfeLFTnm9uFSNDpg==
X-ME-Sender: <xms:DC3MZkurPpKWR4BMslRCuyc-033K065VNoCBtIDfvNGVSKhCLs8EzA>
    <xme:DC3MZhdtrs0JXLQbyYLrVuBRkkdE0A-MmJgaJU8wG_jEEOOc1XoHuQMtxUAH_fkcL
    19JgdcHjpzFCKC-iw>
X-ME-Received: <xmr:DC3MZvx028MryFp9Yg6-8LO1Uo_jMHmkptPOvkwjXBq4ejLJj8EVlFgbp9p1gM_C2fyFrc5G0pWYyNfL-UecPHAWS23WXtkk9iHLeAkN2Pd6VTs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DC3MZnOjvjTJyXcUMY7gXYJ7lvoOZMy8VEfR6xUeJJBUlUDMvAUPWA>
    <xmx:DC3MZk-uTGDu4fD7Ong84p4pTxu3qQhOEFuZBjX-k3Bix9n5Qe2ViA>
    <xmx:DC3MZvXN-5j-_plohMm2Nis0ForIEx_A-8cF3sFi-bwWO3lcai1AzQ>
    <xmx:DC3MZtdguiR2AwrDa_mmm7nEf_Lo674XbhJcvfYUlyLTCd2oJ5X3wA>
    <xmx:DC3MZimKDVw8fOXZmdEx3-MSlD-PlnvYO4afSyfgH9zY3T9ZPvkNWS4x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:21:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f81dd811 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:21:45 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:21:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/22] builtin/push: fix leaking refspec query result
Message-ID: <92fc97b3db86bb0bdf610a2f76c03a96a99bfe8d.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

When appending a refspec via `refspec_append_mapped()` we leak the
result of `query_refspecs()`. The overall logic around refspec queries
is quite weird, as callers are expected to either set the `src` or `dst`
pointers, and then the (allocated) result will be in the respective
other struct member.

As we have the `src` member set, plugging the memory leak is thus as
easy as just freeing the `dst` member. While at it, use designated
initializers to initialize the structure.

This leak was exposed by t5516, but fixing it is not sufficient to make
the whole test suite leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/push.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 7a67398124f..0b123eb9c1e 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -72,13 +72,15 @@ static void refspec_append_mapped(struct refspec *refspec, const char *ref,
 	const char *branch_name;
 
 	if (remote->push.nr) {
-		struct refspec_item query;
-		memset(&query, 0, sizeof(struct refspec_item));
-		query.src = matched->name;
+		struct refspec_item query = {
+			.src = matched->name,
+		};
+
 		if (!query_refspecs(&remote->push, &query) && query.dst) {
 			refspec_appendf(refspec, "%s%s:%s",
 					query.force ? "+" : "",
 					query.src, query.dst);
+			free(query.dst);
 			return;
 		}
 	}
-- 
2.46.0.164.g477ce5ccd6.dirty

