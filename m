Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B816F0DF
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008986; cv=none; b=KOrUviOk9ZQ0omcaQrFGoN6Q7L6U1829GRrlF09ICLPE7QhwZe54QSXvGqIZRxnrZNuAyVNyrI/W+VmMKXbYddmqHRNCk0y4P36qQBwRM6Z4T9jm5w57JIz4mT3jH2dmL2BZeps7+zZsUKpFqEXvQeqFbe3FyePrmza79IoUqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008986; c=relaxed/simple;
	bh=8eOG7V/j8a9xbiofvwfUgM8epzyfufMLuIRGC8lIKts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6Nl1kFqPtGQlMxp/5f556ZGTjQc2i4PE6YJuc7lJlFxX0eSiIn410U7yKArLxY68e47BM/eu6BiDGHeMnfF3qECB3d6GCF9ulWOzVvkQwABqqwym5mUM3pB3K8cf/bZ6fm0y5TvAiH3xeY38jK23T0ReWFKliO7/W27LMwVH5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K7jscsT2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mZbifFDg; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K7jscsT2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZbifFDg"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 91B401140240;
	Fri, 30 Aug 2024 05:09:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 30 Aug 2024 05:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725008984; x=1725095384; bh=JTYkqay8tG
	Kra5vGqEltXTgHjzaFkvjI4FmWTrbSPgE=; b=K7jscsT2qkYWnXgXeGsWoXrncA
	H5JChDJgwq35k/jJIAo7XALFk1E6QijFBrnLpGa8KjfChB4shjLDlEV0BZ25MRAP
	U5eTXpcxDp0j8H7r5VCGk+wVCg9FBMyCtcb3+kZUaZf8nYwl9QSBRmQJEn4B4H5B
	94c6RynvYTlrYuu2nf3hnDr4Zj6eExw8Tq+euG+ylBe9Sh8S6+hzQKnlG/3AzfUU
	wAVP8R31iZqiCETKRQgaArLz2kgULYnpr2NYATJL6rU0K3NJpv6GtcCowHUWpGUj
	vQT6uddUrcAJyxBwUt6ZaW5y8RLPWiI1TRc3K7/caL1h4Py0/C6m85uaq6iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725008984; x=1725095384; bh=JTYkqay8tGKra5vGqEltXTgHjzaF
	kvjI4FmWTrbSPgE=; b=mZbifFDg0iS30LOjVNxHNw2gkDrKSynvmRN5QBZMijfT
	OV9kAUXx0SJmArhFg/f3m/8xKG1EQAemFSdTmMpU1/hG6tv2ubu8abA1ipGPMzAl
	FfSzNccmUCvlZ3zegSctde3qg2sLrd5bb/+8TgA8z/1UKBMep1lBqb+5kXzdxydR
	AjkIwhywBY/h8+ryDZYzd6hPlf7v7SZidGM/s1S21dRMIk9YLoeipHBjF3AzRZ/g
	wHY7Sie0VhsoTyqtjqQp5Pcrob5ubytkGcVR5ZeyziFrXYKFTpuqp67ArqR4UU2E
	NCXQijdA2agkEQTs32hFls1JAC+8fqbWu2b75OKakw==
X-ME-Sender: <xms:WIzRZoj-xXNVGrLWiblRh_nSvMnsZU3yNltiJWVGvqvduBFHFRwwCQ>
    <xme:WIzRZhCsUQuQ-8WJSekMHB6qyodwe-8qxU2w8v_-dRnJPAWbefqtILhS16R90eOBd
    W5WduJDWphP330pSQ>
X-ME-Received: <xmr:WIzRZgH7fKjbZlWuTFM5R_JATkLQWh-924_42Nmbe8z9jwkFRQKGPiEtO3pk6UWrAMumVlfu2YibsRyOtlK0xIUbToilC-7nni60R49yoFXaJv923w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegtrghlvhhi
    nhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:WIzRZpQxiY7cQBOJnJsJxk5Wg1FnuNegXY-uHvfiMjY7wfkIoM1mMA>
    <xmx:WIzRZlzYqDuhUgzlXf0i5qTC1Xs_yopXrl-3AsuehtsGsdokvyBwhA>
    <xmx:WIzRZn5j_dZAKbtv2Vn_pNw7_gsFoQtobF-k3G1N128B9JgPlHKzuw>
    <xmx:WIzRZiwiDKB3M1--xXzARdt6VLpp-hg2SObRGzCqKhaqgRaCHeT69w>
    <xmx:WIzRZntKF8SRCW9Ct8jFmNI3c7GWmUK2uNQ_iBP1WB4EtJEnKbmMDqzA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:09:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fbc8a45f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:09:33 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:09:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 16/21] branch: stop modifying `log_all_ref_updates`
 variable
Message-ID: <fc30365e1f13d47eb89339603f6a4744525b3967.1725008898.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725008897.git.ps@pks.im>

In "branch.c" we modify the global `log_all_ref_updates` variable to
force creation of a reflog entry. Modifying global state like this is
discouraged, as it may have all kinds of consequences in other places of
our codebase.

Stop modifying the variable and pass the `REF_FORCE_CREATE_REFLOG` flag,
which has the same effect.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 branch.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index c887ea21514..08fa4094d2b 100644
--- a/branch.c
+++ b/branch.c
@@ -601,6 +601,7 @@ void create_branch(struct repository *r,
 	int forcing = 0;
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
+	int flags = 0;
 	char *msg;
 
 	if (track == BRANCH_TRACK_OVERRIDE)
@@ -619,7 +620,7 @@ void create_branch(struct repository *r,
 		goto cleanup;
 
 	if (reflog)
-		log_all_ref_updates = LOG_REFS_NORMAL;
+		flags |= REF_FORCE_CREATE_REFLOG;
 
 	if (forcing)
 		msg = xstrfmt("branch: Reset to %s", start_name);
@@ -630,7 +631,7 @@ void create_branch(struct repository *r,
 	if (!transaction ||
 		ref_transaction_update(transaction, ref.buf,
 					&oid, forcing ? NULL : null_oid(),
-					NULL, NULL, 0, msg, &err) ||
+					NULL, NULL, flags, msg, &err) ||
 		ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 	ref_transaction_free(transaction);
-- 
2.46.0.421.g159f2d50e7.dirty

