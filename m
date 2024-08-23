Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0635193089
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422371; cv=none; b=frHg5e8seBpmfscZUkbKhe/jS/J5n3H/x8nRvJCO9i5HfN5ULP1Kv/BRRW/JTmAmTCvaOMyUqwh0vDSJN9cGoOUpsG8+K3YfcF8bnfnbiscsA68p5XYyRhO5/srtkzoH6vQDqLBlL197R5gzWyFQlKlr04a9Aua0AaVtp4FiB8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422371; c=relaxed/simple;
	bh=CxCN1HxCKt5CyjmkvvUW28BYXyq71hsH0/JRus5sI/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q24vdjPpDIzqKr/LIciFdIavDfg60nhiyiFUTd2wL8StSCdNcVeZrTThnklaA56hanvMyLYxv4biKS6XQpKboWtX1CqgqHNt8NIDrDHnvzdtNwiOQrUlMIxtRbX9/NBtdVbFxoDKEUwA4XWah/myoeWid6m/sl9asa5F0UVtrEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JepQgtJT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ii92zQld; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JepQgtJT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ii92zQld"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id EA4E5138FF42;
	Fri, 23 Aug 2024 10:12:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 23 Aug 2024 10:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724422368; x=1724508768; bh=UFC1CjraK+
	CojECdNRi4i8zXe2r8WQvuWqj53WEVd4w=; b=JepQgtJT5cRMj/2iaSi2IGfs2y
	w3bBs6fGA/xJ6ABj2MTq08cECmydL3Pwy7XA01GrDtu2DH0qccTWfEaaR/DAjKp2
	TDBMz1r2oN3yVWyx3bU+1GLSiv8JmOEC+YzDjmMw0qSo46diSJLxSeMeLqVJZUW4
	6fF9pl0C6rO5I0iN8mavEofH+pZpiMEfAJdA+cGGhclkwZx5zXy6bzCdTaulbVuw
	nUDjJL4L8Pp3jqibRNuAXW3Zoqd4S9wqCJAK+evo8Gzt+Yze0H1kPWxwkCKw/Xsa
	qrzZQVtsS5HKN0p48i21a5asWhB7mawGinMmAJGE9C8sakMm/OMjKZlkQYMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724422368; x=1724508768; bh=UFC1CjraK+CojECdNRi4i8zXe2r8
	WQvuWqj53WEVd4w=; b=ii92zQldi/FhZ84nuS2zv0aNfHOEUraufFvDliukWJr+
	2Qm+aq+gpRUUbpFBqxAmgpPm5OeAeKVFJzDk0DCVpq6sdmDSb/igeAeFvyKJqL8G
	sSsMNp6q09PKDqnuJReyOMAZPDBjD3zoFEVtIka+z8Gf7QwlFAP8taWctuMc7KgL
	iP+FnhVop6ZHdthxezLM8vkMZvPffx5zjhu4cSTPGh1hvmvSGBDlUMOJDT21bSWS
	W7dwtxY27z8HfwmGkiTj41+IyJCIdCYCwZyF9oKTF+k4pXor+ppA5EPfTmSlMTjJ
	mqanpDUxSIQEogX1iJXZlYX5ZKs/X0v6hV2JdT2b3g==
X-ME-Sender: <xms:4JjIZsXbouKkP94Ew-NawJZrXo1v2fSE4kyoD7UbjlKqV0uHqXwErA>
    <xme:4JjIZgmtXIgFwp9Sj0yePiRBcfDjtQonafNwoBpB7R5dTqTXXHkD-t26NAvktkMXP
    PFdunrucquq4tbBJQ>
X-ME-Received: <xmr:4JjIZgYbmJyGynFscsaHv-HMV3RGhIG4cAgBAd4Q0SHUbUe4i3tW8kMapx_sKj261pCIO4eEwhWQIGdDJ-6hnwDkGb2fv5EhNzbh0ROC9XwY6AAeEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvvddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:4JjIZrVRdrdo_9h3abElXXdPkR5gwF1TRrWjDgYkA1lxXu7izxPPXg>
    <xmx:4JjIZmks6e_oDrlsinWI9vKxhThRgs7nip3ZHbUktfSr5mjPjF5w7Q>
    <xmx:4JjIZgfb4CORjus-w88LkqMpAhj4VUHP5Fj6HwIpIPdjpX00_U6NJA>
    <xmx:4JjIZoEdl7orhmIKV9uLwU9e9mgqm45rFc7I1iBXfaPwmELw_9XGJw>
    <xmx:4JjIZnB7ZKBRksZtqm34Wp0qPaLzzsl8SbZeILv_fiUwAGdElLA1guC_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Aug 2024 10:12:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6cb25e5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Aug 2024 14:12:10 +0000 (UTC)
Date: Fri, 23 Aug 2024 16:12:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/10] reftable/stack: fix broken refnames in
 `write_n_ref_tables()`
Message-ID: <e3b28709b5fd525b95c6f296e5b2920561d9a8a3.1724420744.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im>
 <cover.1724420744.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724420744.git.ps@pks.im>

The `write_n_ref_tables()` helper function writes N references in
separate tables. We never reset the computed name of those references
though, leading us to end up with unexpected names.

Fix this by resetting the buffer.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 42044ed8a3e..de0669b7b8a 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -125,6 +125,7 @@ static void write_n_ref_tables(struct reftable_stack *st,
 			.value_type = REFTABLE_REF_VAL1,
 		};
 
+		strbuf_reset(&buf);
 		strbuf_addf(&buf, "refs/heads/branch-%04u", (unsigned) i);
 		ref.refname = buf.buf;
 		set_test_hash(ref.value.val1, i);
-- 
2.46.0.164.g477ce5ccd6.dirty

