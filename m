Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A3B1D61B7
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777557; cv=none; b=S8cAzYA51dyFPYu6KgU4s/eDCF3aaEYD4usm0vy4gqtMnUVunsoIAc+20HjjuH170fr7/BB3ZbAZUd+91n1P5WEIVsj8tj7v+PXpzRvWjy3doq3z4yCne0b7b4ZTPmdq7Q1/MS6+Q8X9dwVYOaP0t+Yr4L3LqFTZSEVUYK3wCWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777557; c=relaxed/simple;
	bh=K0OABEiYs6ZfThqR+UfNR8VRU8L4uSGHfCCIwmZfHg8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MHcVHUOEi+hQVAMBnMBixm60zyttCBh85z7PkddFuvKn9Zl4Y8kTdOQOieqNXLbOtONUaj6oFJ1QHV5miVBb4y7MFoiDhqQoXJlonYihskUTChP8sQc+HGuw0tYnCRmkktF9qJwQ8CAUTdg8lz6kQ53CRJt2+ourOi+54aqe86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HVpO3jQ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OFv4Z9bQ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HVpO3jQ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OFv4Z9bQ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 466ED1D0003E;
	Tue, 17 Mar 2026 15:59:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 17 Mar 2026 15:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773777555; x=1773863955; bh=CKlMvheCp3
	et98q0KzgewKeJSfp9Hu/kmmVoASQ8giI=; b=HVpO3jQ4r0LJUgnF921xEYLAvh
	8eSlZo6V7yCSiAzW77BuUKaAQ8U3cdfy4ljaDcO+iAPl9q5VrgSgFQEcUflgZ5oD
	Ck9YIIWx12QoRIusxdopqoKyLq7QxjhEPbgAXGrCrzouaTEFgZUl7q4pZYKO8yD5
	YxiQduEH6wO0wzwbdE0Cav4TtX+5OuRfc808UrG9hf/NH0sWUw04Oj9RpiRwTrgI
	+sdcq+37XfAnw909jfed0QFzwJL9yE9g4v/UNwQzaP4RZaIhw+nV1lqarNQauazS
	uLd/HeihZhF7WHC+RtGAZcXcW2P35PgFipNG7OOSd5vsQmNR7/4HsqtC+qqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773777555; x=1773863955; bh=CKlMvheCp3et98q0KzgewKeJSfp9Hu/kmmV
	oASQ8giI=; b=OFv4Z9bQryhflpgFhQ+coFEr7EQyohV97bWu9GuF57co8golxC/
	n7paM40lHbtO0TOeWvxb2qk+gJlzZbUuNb+51MEUluMCo3JSqaKQ300xb2hPkLRo
	h273Y+ZPitoPK3fZA2U/fJKXt7ElAUSNfO5ma2SBfhp4a0zvPhXnu9oUfpBXkIHw
	zcZDnpdiHm11TCJJ+8AaYvkJxAQcyburLPgpylfnaiCELn/9TM/GHitUDpWnwvK9
	M7yppvktZSlaN4k78Xgu0ZVUfAPCWOE+qXUNKKeyvw5nBY7on3mIa8/CcY0aTo76
	4LmNlRaZfhDEAjRUGDWqrAMRI2fVrBFmoHA==
X-ME-Sender: <xms:krK5aaYO1WqCx07tCTlp225sjpzAijmEWpdXIbC7Ts-lqJfxcBINSQ>
    <xme:krK5aU1Yug5MRNIEifLJ0WF7PX0urc8GVzm-0pL3hso2pasIzw4lngvWXf2VuhXRz
    wkqTye3VwK4JpExg8eGvmpgATcyho8fNfNut7uLM2f3R4Gmq5kV>
X-ME-Received: <xmr:krK5aSXPJhLs-F8zClTyxUu6x40hVCyJjtgiQ-r1XIotj5VJ_GLTB0uInRgqV16BFM7nZ8fTG6cchIDyWT223QsFvskwoyLPQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:krK5aWX0h43rq3uPUoUjiR2wc2YYKJQWlJiVZZJ0rieVqMZPwLhrVg>
    <xmx:krK5aZdI87WAeNGYaQKMEBJextFvN-1z9dc09F2QIjZsMiUsFgiLPA>
    <xmx:krK5aXUTk_NZJUNdSaZCBZNrG88PujHMXaFX2iOvQ0oJMzsJCga98w>
    <xmx:krK5aadwyayfoZ4HxB8HkRtu9QSLPf7obQOrKy0S9Jz1w_d9stIbFw>
    <xmx:k7K5aRf_SYwHieB9wY9Vul2TgkB-V5l8RW_d7x86h7WMAryLWc28O-tE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 15:59:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] replay: support replaying down from root commit
In-Reply-To: <20260317-toon-replay-down-to-root-v1-1-cb5c249e15fd@iotcl.com>
	(Toon Claes's message of "Tue, 17 Mar 2026 19:56:26 +0100")
References: <20260317-toon-replay-down-to-root-v1-1-cb5c249e15fd@iotcl.com>
Date: Tue, 17 Mar 2026 12:59:13 -0700
Message-ID: <xmqqwlzajkha.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> git-replay(1) doesn't allow replaying commits all the way down to the
> root commit. Fix that.

OK.

> -	base = pickme->parents->item;
> -	replayed_base = mapped_commit(replayed_commits, base, onto);
> +	if (pickme->parents) {
> +		base = pickme->parents->item;
> +		replayed_base = mapped_commit(replayed_commits, base, onto);
> +		base_tree = repo_get_commit_tree(repo, base);

So, if we are replaying a commit with parent(s), we do the same as
before (base_tree used to be computed a bit later).  But ...

> +	} else {
> +		base = NULL;
> +		replayed_base = onto;
> +		base_tree = lookup_tree(repo, repo->hash_algo->empty_tree);
> +	}

... if we are replaying the root commit, there is no base (in
contrast to "the first parent of the original commit" used in the
other branch of this if-else construct).  We use an empty tree for
the base_tree, which is the natural thing to use to replay for a
root commit, of course.

I am not sure why replayed_base is computed differently, though?  Is
it because mapped_commit() would not work when base==NULL?

I have to wonder if the handling of that case should also be
encapsulated inside mapped_commit() helper, just like the helper
knows to "fallback" when the commit is not yet mapped, but that is
minor.  After all, if we drive that line of thought to the extreme,
we would end up making repo_get_commit_tree() to return an empty
tree object for base==NULL, too, which may be logical but it is
probably too much.

