Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7AA2DF3F9
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840880; cv=none; b=Z4n+DrRX53TOxUkkZXgXViZOn2kZaG5RgKporphpqZoD8wb4fJMmwhOrqKkQ18s6SYIe39omWVDIrXs3+qKHs4BejK5z1cVwVUiHjX6EB9dZcI2eso55VujxkaIwkMX+A5d041w8XH3Y/6sbEPvtv4AhtHtrR0Rr+0eK1C43Swo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840880; c=relaxed/simple;
	bh=vxJiSOIoobqUxsjCBhUhEiryD6OrWrkwfMD5+47OXW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hrzX7cCBvcwc4SbbJz6D0YMLffjlY0lC9cxdoi3aVutgZYKtE8pURHlGjsOXfY0FFzjYsLSEr4pmsrpdhUGVFXzdS/wjAvaL7WQwL+92fmUvq7zgJctKMNEqHDtketMbpAdWp0dG/cLCQU7MiD2JcWaegrfXqlRzAlxQlHLd960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Smfn6eeX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ioe1KFLi; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Smfn6eeX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ioe1KFLi"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B1CC81400079;
	Tue,  7 Oct 2025 08:41:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 07 Oct 2025 08:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759840878;
	 x=1759927278; bh=L0kwczjjPXB1+Y3BhN7Q7BTBXA11aCI2pQ8EyNC2lSY=; b=
	Smfn6eeXGvgSGlHd9O3t91leX7ugdmnpvCYh0Fm32VQde3YZv04wXlU82ZoREGb2
	WBlVsEwUaByOKrVAKunW5GI0q8QAZWfjGdbfWGVeH/3Gi03qdBrlqelLZx5AbZwB
	qfZqcS+UrqlyM2k7TL3+lS9RZ/nuyvRaQapRdvyl9R09tYAsfibfp1u3Lcaw/aZ3
	iMZuS5sKHccXjCVxqdhPsE7n2SAyNmS47UB1bYo+NCIWyZxFs9y5j9P29nxxh7pN
	1dSxYOJQ4skwZVNvuYMauxf/M7qJCjqjHn9se1LlSpTuJB9JJ8l8REOzWz0W+Frq
	nJYM8rJwBBkxYclFwGz+UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759840878; x=
	1759927278; bh=L0kwczjjPXB1+Y3BhN7Q7BTBXA11aCI2pQ8EyNC2lSY=; b=I
	oe1KFLiVgjE2aRrwdOhxkPvyeGGw/H2aCOfvDJAgYvscSdOk076hNx58VmxRwoys
	EFAQBvpNky5ip4cGNISjgBnv4h2Uugkp/gBSMp1FEpmxLoxGtqCWaZrCHzrQtD4P
	jGu+Q2h8PWDi55/q8iIwG2oKZ3h2YAC3EIteQM0O5IZ7iZF9E5z7dWu/Zo/Ou686
	jtG9fQx0Av2KBp4Y8QTb4O59zv8ZLTFUZWSIHmOn9xTJu9SMrivYcO6cbpJ8Ez9o
	3jsmkDeiIcPiNQ0iRh4keUc7EtK9vkCHAn5zYqdxxiGsDXJDTeXsm4EparF+apgs
	OqwGaEHoFtmL+BefC8jBw==
X-ME-Sender: <xms:bgrlaDnZXsDqVoGffFXBEFYbz1tGU8Rl3TQa7GbVoa8Y-IVeOJvj4A>
    <xme:bgrlaM1Sq6bAxM0av0JMykke-JYtYlaMPJyjzn1aUWtsk-roxlNz0UlbC81yDS-3c
    ujGl3AnydDb0pgvLqnsi0SVY1d_FWe4ZeM5J3I3xAolvYCltXjz>
X-ME-Received: <xmr:bgrlaHRlmzJZMAHl9Z7vbf8IeRp8KMw_vhDawQd8E6mp5yjVTvp-aWGMwwnLRt8RBd0m1leNMqsUDqS7dTlRCQ___6HEkH6JjglrTVw725k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:bgrlaGuzGnCWlsOy1jvJtKbAKtjN82YmaD9Zznj_qkSP2XqUU9lEMA>
    <xmx:bgrlaEYE-9KDRZVSnBDKa501TTKxHEUQbtbCW-bvE7TsssBU9-H1vA>
    <xmx:bgrlaDuh15w-qhr7qGVY1wn-f4WjX_5C1jiqZIGwlZb07_PauQyljg>
    <xmx:bgrlaOFaoyoPo1wgUAFyU1l7tnvkwc3zacaasTLOpfdIK-ACd54idw>
    <xmx:bgrlaNvvKq7pYHoeSpAYCkctaA-7CGHCkrAZ21jHUhkcF4oVMxh-aRKq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 08:41:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b406f7f3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 12:41:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 14:41:08 +0200
Subject: [PATCH 2/6] builtin/gc: convert to use
 `packfile_store_get_all_packs()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-pks-packfiles-convert-get-all-v1-2-428227657a89@pks.im>
References: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
In-Reply-To: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

When running maintenance tasks via git-maintenance(1) we have a couple
of auto-conditions that check whether or not a specific task should be
running. One such check is for incremental repacks, which essentially
use `git multi-pack-index repack` to repack a set of smaller packfiles
into one larger packfile.

The auto-condition for this task checks how many packfiles there are
that aren't indexed by any multi-pack index. If there is a sufficient
number then we execute the above command to combine those into a single
pack and add them to the MIDX.

As we don't care about MIDX'd packs we use `packfile_store_get_packs()`,
which knows to not load any packs that are indexed by a MIDX. But as
explained in the preceding commit, we want to get rid of that function.

We already handle packfiles that have an MIDX alright by the very nature
of this function, as we explicitly count non-MIDX'd packs. As such, we
can trivially switch over to use `packfile_store_get_all_packs()`
instead.

Do so.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e19e13d978..ab6d6d3bd1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1425,7 +1425,7 @@ static int incremental_repack_auto_condition(struct gc_config *cfg UNUSED)
 	if (incremental_repack_auto_limit < 0)
 		return 1;
 
-	for (p = packfile_store_get_packs(the_repository->objects->packfiles);
+	for (p = packfile_store_get_all_packs(the_repository->objects->packfiles);
 	     count < incremental_repack_auto_limit && p;
 	     p = p->next) {
 		if (!p->multi_pack_index)

-- 
2.51.0.764.g787ff6f08a.dirty

