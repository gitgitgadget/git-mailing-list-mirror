Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E110F1E47A5
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502921; cv=none; b=Xj+AdHLNh9bxt6HmP9WXRwETurJCKmLrjT/wLkbJSDDMBsidxKJQbQGTU2etWY0qFJobcrazaVVEPH25n1fE1PFHgRSzKi9c3fSAajI0UbGFEKUFqjoty4hRhknAw0tGXC+QJ9mWOKWZjLg5TRU3jr4YWYX0+lCVm46xJy7l6cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502921; c=relaxed/simple;
	bh=IFZ9vSQZDCWi1RT8jVbJ6zQmAlaf9dlFNP3TBNjCZfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/6EYUIsR6knZy1oahGXCBYzUyfsFXYd/lt3nS14dwjw9qJfshKckZwQy39ai5caxHo6iGIzWjB2B7fmNatUw3zVsaDSFtRTfPp0btOBcxQwpVh0DOpnD2skShlOQRsfJ4VaPmfwRqm/o++0jNbIgTZkFNV+XdkOCi809667kzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qM8q6m0A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a7uFCbcc; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qM8q6m0A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a7uFCbcc"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0CB3E1380267;
	Mon, 21 Oct 2024 05:28:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 21 Oct 2024 05:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502919; x=1729589319; bh=I1qIa4kc4t
	hWacIytpHFDDEEaKqpY7zQjy26FDACRbM=; b=qM8q6m0Adk+HHS/wJ2+6iT7dXW
	VYeiwpavJIzneesVzEX8ash9IgZec1raiNrLJCWKMvwzBuDdxOLN02JkbQlxdfN0
	ooPKzjZQzJVrHMwvgYCG8QqfYlzZFkNVaaaySm9H+uVUPsb9d4TTK5fNGLit9cIj
	OgRFiIdJuaMzxf4fjzvHG8rMRDnnHQ5AmmAfLcxrSxlHLoiZoda2+5jWshBT6G33
	kfpNej/PKOqn/OGtLMJJCpmRyB/ZwphpYPlzaiqlV9rOS0FXt1bTWe9ktJ2ZMKOl
	BwTTz98UhpiyPsIC3VPU5SMQ0XFs7MA+THuaWn/sOeW4Ha39ySrIWFr1VXiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502919; x=1729589319; bh=I1qIa4kc4thWacIytpHFDDEEaKqp
	Y7zQjy26FDACRbM=; b=a7uFCbccQY+ipguJCS9WA+Bt9pfoGhUtXuZzd6lVurUW
	L5km71aiD2XapzawKGzESzHZAS5uz9bTud60GhK8sykCtLgveXHAhSLj5seqdu9P
	rpJhN4egIxE9OtKL0G07ByLJGmubZ13Q8rQvT9KZJ7P2TGt67lmi2kO2SUxNgcii
	XFpPgoBQCYbUhxCm3FZWEtYFJt/2Z23w/NIMaCmoqOwmZ3mGiZp1gqsavZ7OiZVc
	fC24pbwJ3PxEyiSQ4ValTyFaXJvARBJ67CCmcGmwMWw6PKBuFYHWhwfOdK7WVdaS
	QRS0JoLIwTj2ACNQvgOlWkdEcraBjdkV0hXU4AEEOQ==
X-ME-Sender: <xms:xh4WZ24L-cC9r_-WuitDma-7CuocY4yC1XExAUmGS2e3qQo1oonJfw>
    <xme:xh4WZ_7NrB_EE5p7brSiZOAK7D-iGwIuSpkgLmFqW2cR8xu0ldpPFCRhGDfp53YNO
    v5vgGOfASLvlUu0Rw>
X-ME-Received: <xmr:xh4WZ1dBLt8v_ck4o2eNHHO19g4zmAszxsjzbK9FjiplA6F3BYUvxdN_ARVHMHDZhE906QPjaf2LBuzBLh49UTnYfw8VwR24BUQQ4Ing6CJa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhm
X-ME-Proxy: <xmx:xh4WZzJofYixTlCF3QeGygeHa_g5GJuqsOQQJ_mSD7b617LYtOPeUg>
    <xmx:xh4WZ6INXm9YK_-hqABAcXBOvviIGjY3xrWdNVJ8kouM715gMLyeLw>
    <xmx:xh4WZ0z2iXl0AaxRAefl7xgeO4lVR7BroYlKUQOPqMRedPZFqhcBww>
    <xmx:xh4WZ-K3sxsUs8jurKXH1R3C73pdfuWkk7EBu_qQFf2OSzQiNmT6MA>
    <xmx:xx4WZ21ZZg1FaJPioJQpEj15Ak1ADD-oumlqv8gJvSRnfrsYz29Ze7A2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:28:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 466604ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:27:10 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:28:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 11/22] trailer: fix leaking strbufs when formatting
 trailers
Message-ID: <5b851453bcea945f95c3f29138e510d8448e96e6.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

We are populating, but never releasing two string buffers in
`format_trailers()`, causing a memory leak. Plug this leak by lifting
those buffers outside of the loop and releasing them on function return.
This fixes the memory leaks, but also optimizes the loop as we don't
have to reallocate the buffers on every single iteration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7513-interpret-trailers.sh |  1 +
 trailer.c                     | 13 ++++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 0f7d8938d98..38d6ccaa001 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -5,6 +5,7 @@
 
 test_description='git interpret-trailers'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # When we want one trailing space at the end of each line, let's use sed
diff --git a/trailer.c b/trailer.c
index f1eca6d5d15..24e4e56fdf8 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1111,16 +1111,19 @@ void format_trailers(const struct process_trailer_options *opts,
 		     struct list_head *trailers,
 		     struct strbuf *out)
 {
+	struct strbuf tok = STRBUF_INIT;
+	struct strbuf val = STRBUF_INIT;
 	size_t origlen = out->len;
 	struct list_head *pos;
 	struct trailer_item *item;
 
+
 	list_for_each(pos, trailers) {
 		item = list_entry(pos, struct trailer_item, list);
 		if (item->token) {
-			struct strbuf tok = STRBUF_INIT;
-			struct strbuf val = STRBUF_INIT;
+			strbuf_reset(&tok);
 			strbuf_addstr(&tok, item->token);
+			strbuf_reset(&val);
 			strbuf_addstr(&val, item->value);
 
 			/*
@@ -1151,9 +1154,6 @@ void format_trailers(const struct process_trailer_options *opts,
 				if (!opts->separator)
 					strbuf_addch(out, '\n');
 			}
-			strbuf_release(&tok);
-			strbuf_release(&val);
-
 		} else if (!opts->only_trailers) {
 			if (opts->separator && out->len != origlen) {
 				strbuf_addbuf(out, opts->separator);
@@ -1165,6 +1165,9 @@ void format_trailers(const struct process_trailer_options *opts,
 				strbuf_addch(out, '\n');
 		}
 	}
+
+	strbuf_release(&tok);
+	strbuf_release(&val);
 }
 
 void format_trailers_from_commit(const struct process_trailer_options *opts,
-- 
2.47.0.72.gef8ce8f3d4.dirty

