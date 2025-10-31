Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B652D328B47
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 21:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761947390; cv=none; b=LcturmY0tnqXV4QKfRhCxkw89qyskKQxO3QrJjuEqVOrNACmpTdSeH2AW12/jU0gDowBivukqSdvIslCjnWgyIatZKn5ZcxVE2B5A5gf/fQtwchbsdWFp1PB4Cn6i4kW2djDaRoh+zZQb71KsBj2MJxsaMVFaxag1I6WUwe6TkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761947390; c=relaxed/simple;
	bh=hMlJwQFl0+aAwm7lCfXOcNYAJqXs/hDg7MNdDI17JYo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c1ohhfQragxkVD37v+w0CvOaWaT46ArkPrHUrAonrr0JRd88nbGBf4ZNu1+4MEoSdQnzQbXglNRPx/Vd673k+nhIpHTwWBxMUaW4sdmlOlO4x1YuCQ7KO5hv8Eb7frYOq8MlqifQhif1zkXBHVPwVYnMj9i/eAqVhZrAzEfNjyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k/AhdsaW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LsPimv/h; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k/AhdsaW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LsPimv/h"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE927140008D;
	Fri, 31 Oct 2025 17:49:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 31 Oct 2025 17:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761947387; x=1762033787; bh=PXYL4lEBe6
	pFmjcYN/kPb5jBuHSLWYkPLaiautCxH3Q=; b=k/AhdsaWWqjrHtdmeZ1U5JE276
	KnXFoOdKuU5gd9kVs+aLJfVJiOf3zkIa3PJxXscxduJPQuA9vze4UFnWCsKqQO2o
	j/OWov7bvEQavUe6bSQ1RBLgh6ANRkrXuYsZa/oz7kmkMbqE24tHm21dQDaOi6kV
	0Zv52AIIlYF+aLpwKjF6bmMXGIkSoZQkrJSFNHeEg3VATMNvdQw8FxFJu/M0ubVR
	zFBLHyIIcuZjz58cHI2ITdouUOz5x1xo8WnqgrA6Asjl38NoaR604VX4tkCLBUGl
	C3Ptgok9wOgydEdrcbfhA5XvhsCY/3bfgriz6E5aAeyC8WaoGWwkgZ7aB1lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761947387; x=1762033787; bh=PXYL4lEBe6pFmjcYN/kPb5jBuHSLWYkPLai
	autCxH3Q=; b=LsPimv/hVHchFA45FqhDekExub4qAqffE/DyPXK209Httjz5jaO
	yF+fLJXMWECORBF90e0dp9LIuTSg/bO9rhCQot4HT5Ve97/nDlxZwLQbua5JNorc
	VyqgrfdEB5gfiRocCtn/WVVWp6AMHkqjVffzQMTzyWAxuKmypwB8SVf7NmkXuzZt
	Twpe69zodc2CSw1cXaz3x8jKSWOB/jxNty0rMGPGR+21cpUsBGUS2OJea/W/ql2T
	KWK46eqGOQCRHqTUzuMAZfkL7DR9cjxgbMoRIdv8NCfMWt+Ol6EgA0JKek5caNAp
	yTN4hPe8ChU6G5xHCCVdyFwlGULJuzNnVPg==
X-ME-Sender: <xms:-y4FaRNjywufJ2oUnLgnnCKgC6W6v9BqG3UbTzKpP_hgwY95YS03sw>
    <xme:-y4FaWNF7o51yLBYdIeJr_DRHUuNHE5UDuzxg1vA9eOJwT8ZIgVpTjwd6OBfbK6X3
    VMOauA2BCWtpouwkXXKS3aQKSjiS0TxR3E-fWLOH0Msy-KKqi7q>
X-ME-Received: <xmr:-y4FaShZUqrBDQ6ADncqO5F8ECp-f__HOzlyB7WWeNrz_efiB0WWClFPN1FV2Biy3Yf5LmTuwteaJ3gfzLp8_vZCrMApb4ju11IC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-y4FaTtUufD7wb83dkir2kUOWI5K6jVCe0AYvtNHxLxjQWV4K29NpQ>
    <xmx:-y4FaYSzrhjY_bCj9JFf9QTnZ8EQJm7MetKjqJQobIFEJ8Pa9fhZUQ>
    <xmx:-y4Faf1mqL9KnEtJvfh23suYPDlFvGxoafgt8dN37m8_E8TbCVRjmQ>
    <xmx:-y4FaVuDUbKe2XE-lkJv_VyEsE1U58HtxwsYQcrc9Z5R0dzolJmLzA>
    <xmx:-y4FaYDZvTxDRAxxeaKmRpqC8MNjRZaL4Q3D4-AnRkOsTp5zVbfwiZbX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 17:49:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v5] doc: add an explanation of Git's data model
In-Reply-To: <pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Thu, 30 Oct 2025 20:32:16 +0000")
References: <pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com>
	<pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
Date: Fri, 31 Oct 2025 14:49:45 -0700
Message-ID: <xmqqcy62213a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The document refers to <<object,object type>> but the id to refer
the descripion of the object is defined as [[objects]]; we need a
band-aid like this one to pass GitHub Actions CI.

As description for individual object types are titled singular like
[[commit]], [[blob]], etc., this band-aid drops the plural 's' from
the tail of [[objects]], but as long as we are consistent, of course,
we could go the other direction.


diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
index 1cefbb4833..eaab3f800b 100644
--- a/Documentation/gitdatamodel.adoc
+++ b/Documentation/gitdatamodel.adoc
@@ -18,13 +18,13 @@ means when the documentation says "object", "reference" or "index".
 
 Git's core operations use 4 kinds of data:
 
-1. <<objects,Objects>>: commits, trees, blobs, and tag objects
+1. <<object,Objects>>: commits, trees, blobs, and tag objects
 2. <<references,References>>: branches, tags,
    remote-tracking branches, etc
 3. <<index,The index>>, also known as the staging area
 4. <<reflogs,Reflogs>>: logs of changes to references ("ref log")
 
-[[objects]]
+[[object]]
 OBJECTS
 -------
 
-- 
2.51.2-719-gbbf487eab4

