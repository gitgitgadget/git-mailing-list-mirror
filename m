Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19EAA95C
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 20:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736283387; cv=none; b=C8upkAwjvJyg0qwtmD4R72Pqd+QreGWbnXKJ81xoh5THPvrlK15CV2zh9h7GnFbNAV9RFPp5yp6S3GITDOVX3xEqzXoJuo1qCUs7DES4wPVzS5jmrEml4RXhSXSEcfnZglBUCP/LfSk0nE8anEIKZyZBPc3NmFYOh5JKRP52j7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736283387; c=relaxed/simple;
	bh=IRyA5w85casG6DTOdsiwTUJl9bVv+ivFV2ulAdbZ8KM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FaxVC92TBsupprLCtEKTUK5Sy4sZjoISLd5q//vWMmuMGQYx294Ubl48AF76lJkFymXx7Svxnsk8cC9SMcXxhyBFCH0VoeOcTEPonQSoXAR0yszvKJ7+T268Kgt9iVMUMst7CxvoHkNiTh71f+cVN+Tmz7TBATxdx216llzlenk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=6aP4GKyj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vKjSqgDE; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="6aP4GKyj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vKjSqgDE"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 167011380173;
	Tue,  7 Jan 2025 15:56:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 07 Jan 2025 15:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736283384; x=1736369784; bh=daurziU+1V
	0V0Fu0jGsWf1q4XkqHo0HabkTAsfyvWlU=; b=6aP4GKyjLcQM+Zbm8yUsHXtUPR
	6CPUHpvBZmtGE2WjsFKXfU9UFqMZaW5Bt6r8ZYpOLc1LKrq1rYtekggYvaAAvunj
	sGCh2uDlGnRf9r67houDLfgUdEzOIzrDJ0URVnrSL/1klM2AiHt6AlPGkWhwqbxC
	1jRNIcPVzKtAy2ZxgM8zizuQJRUq2Ih6cSkRMgOJr5O6Tky7l886N4NPesLVOr3Y
	V50rG+nObx90f7T8O7rsepJkbg3GEgXdSHqCentrXJOA/5Y4eUDSdP4vqkoyyqrL
	Iy2+7DnB2t090JOpTWphBVTnOX6Fut3wEgkaRWoxSn1rPyvjrL14OBNdIcuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736283384; x=1736369784; bh=daurziU+1V0V0Fu0jGsWf1q4XkqHo0HabkT
	AsfyvWlU=; b=vKjSqgDEQ/uZkOKsr+V6CtUbdKoJcX9LuGr9apIVceMwn+MzRMj
	caUjbUC0hLmTIr/XL/mN68URHU6H+WT2ekYjdEuTu/KJhC0Ynad4SkC+vBwkwgqU
	lo8gQ4TYQA/7UCPHlAhZ9OA4f/Zces+ZaaKBKn4HRBDq3Qi/nTUeoJxsOiD7bdzZ
	C0GU0wIGXYlsWqPZkVLI7Oj4pvsPhC0ROzICRW93eoSWpTiNO2y3r+ic04nAufka
	jOA+1sdTcW5Kn4bwEz/4dSK8est48jbwQeAS2ABDzSTXKzykYknOIuhtv5pZTrcq
	up7yVS35gYv5J/EFttp8UiAWvL4nuMOo7hw==
X-ME-Sender: <xms:95R9Z83Iz87CnO1uKVCtKUgAp-Mo47N_vHj6-raiufpdztSFd9fISA>
    <xme:95R9Z3HJ0ufWNz1033D7wurUtCnm6ybhAzBTsBvr5rMu3V6govl2qJzp55K1lIJUq
    S83XYhYWaG2KCP9_Q>
X-ME-Received: <xmr:95R9Z06jR79w-7tKWUuqBzKSbD3Obj__7DVv-QskunjcqddMVZRYHgZFNgJSqUx-2GJr4jXMxLPI8TrjD8WJK_t8eqHM_vvzh8qJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehrrghnuggrlhhlrdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggrpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:95R9Z10IBEPpQB7XagUyM4qY0FUYoob4pnj1mUUAQkzNGEcaUQgtjg>
    <xmx:95R9Z_HhOsC6oNshE313QoAg38FdXgFS5U-2D1sfnbF5VAu7dp4U9w>
    <xmx:95R9Z-9VI4nV_RIqW6QLEZ4vzt62973Gep04QsMJFyNGgOPESNaPEQ>
    <xmx:95R9Z0niMRCJxluT6WxAKi_MrxrUnKKnIA8GLUZFwTa8MMeiL0NGfQ>
    <xmx:-JR9ZzgReHKQdPujhrDzpNhZFHd9THajYrQnzlywOYs362n5JrCiWx-I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 15:56:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 2/2] reftable/stack: accept insecure random bytes
In-Reply-To: <20250107-b4-pks-reftable-csprng-v1-2-6109a54a8756@pks.im>
	(Patrick Steinhardt's message of "Tue, 07 Jan 2025 16:27:00 +0100")
References: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im>
	<20250107-b4-pks-reftable-csprng-v1-2-6109a54a8756@pks.im>
Date: Tue, 07 Jan 2025 12:56:21 -0800
Message-ID: <xmqqzfk2qr62.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The report was for NonStop, which uses OpenSSL as the backend for
> randomness. In the preceding commit we have adapted that backend to also
> return randomness in case the entropy pool is empty and the caller
> passes the `CSPRNG_BYTES_INSECURE` flag. Do so to fix the issue.

No kidding.

This is calling rand(3).  The use of the resulting value is to fuzz
the delay before retrying, which wants NO CRYPTOGRAPHIC randomness.
This callsite does not require it, but rand(3) is perfect for ensuring
predictability/repeatability as well (via srand(3)).

And it is not allowed to fail.

Yet a platform replaces it with a function that returns an error or
aborts?  What kind of nonsense is that?  Do we really need to cater
to such an insanity?

Use of git_rand() here goes backwards against the more recent trend
in reftable/ directory to wean the code off of the rest of Git by
getting rid of unnecessary dependency, doesn't it?

I think [PATCH 1/2] makes sense regardless, though.  But shouldn't
we be pushing back this step, with "fix your rand(3)"?

Thanks.

> Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/stack.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 6d0aa774e7e29d5366ed55df19725944f8eef792..572a74e00f9ed6040534e060652e72c26641749d 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -493,7 +493,7 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
>  		close(fd);
>  		fd = -1;
>  
> -		delay = delay + (delay * rand()) / RAND_MAX + 1;
> +		delay = delay + (delay * git_rand(CSPRNG_BYTES_INSECURE)) / UINT32_MAX + 1;
>  		sleep_millisec(delay);
>  	}
>  
> @@ -659,7 +659,7 @@ int reftable_stack_add(struct reftable_stack *st,
>  static int format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)
>  {
>  	char buf[100];
> -	uint32_t rnd = (uint32_t)git_rand(0);
> +	uint32_t rnd = git_rand(CSPRNG_BYTES_INSECURE);
>  	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
>  		 min, max, rnd);
>  	reftable_buf_reset(dest);
