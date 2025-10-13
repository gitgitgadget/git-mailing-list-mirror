Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA16259CA9
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375525; cv=none; b=iJc9wxS0NqpcjGLJjPuQAaduQthEpNi+LA8IwJZOPV6HmXcxsqyr832n7LN+d4V72k32C5jdTLIpbn8yERVYfZ/x8wum5CG8ZJEFXt/WaHY5DbGAi9p2Q5E8xDaFWpAVDtm/pzTeMsUss+LQNJy9f0iRVmGjifb7RtsAuQBLL8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375525; c=relaxed/simple;
	bh=JLVfKB823U4y7gazU1bRbBHPfGS61mW9dfqPMw3AVNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h+c9naJosKjfomIb2cRINELG6/OX7jDdAMlv3Otv2ohUqJABMJl4hB9ntSgWhwFJH6RdsGeRalHIrzCs0idovqEugT6ztaXGwmLN0CDrNCX38nwYzygbVngm15DGwrm7/5pWPg6NJVnVNxaBFkrRrQS/G2BhVKZl4JCPBHVf1aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L/wNVzr5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ucjRATG/; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L/wNVzr5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ucjRATG/"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 77F61EC00C8;
	Mon, 13 Oct 2025 13:12:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 13 Oct 2025 13:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760375522; x=1760461922; bh=MLphkq5WRS
	6H3gT1pm6UeIZs2WzGYB2EvwLNxrKKZRE=; b=L/wNVzr5uJs9phBf2UhXGvYmcQ
	5kBgGqwO1MlpLrmXH76hKAWv5jhdqN4xV1bsfPGRX5Rt1Fp1ZtaHFIc+vkvAti8Q
	yjswvcsfqx/B7c/qs3hRBkDUFLkZp4klmp8q/qgJA0dLiEu9yVSlubdC996+qcOm
	YzaxUhT/4AczlU0ifykIOCPU8rTHUo3aFUtneUf5Ar3Nm+fUP+gC+uRNS0ejSnp5
	8Ac9FmqrrKmkXwQ9t2Qp62nV/8mVJXafe3sfkFfVRPAHiZMaszoLGkwEdrGpCpvE
	QVPFdmZVcFczk7Dso677QMAk5SCmbyq8aTRD0NC22KmNCH5C4r8g/Ma2zZaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760375522; x=1760461922; bh=MLphkq5WRS6H3gT1pm6UeIZs2WzGYB2EvwL
	NxrKKZRE=; b=ucjRATG/Gx1nJYWZzLKJA5mUf2Pa5gE/kc1dEg5TRRWVnb8ih0A
	Mhm8hIUeoMvG5x1+ePpU1Appi4fC0P6KyXz9XTSsC7LLnk7W9EO1JG11SJ7ZdCws
	hoxLww7YwwhYYhU/ix9x+K88CH3qzr8e4hxoAeTpBizQc+jKHpJi16MsFcI+kjKE
	N4WdmcweQhxZWDN0pILWeMNHGDRKOaovkhWszQssemOzyguJRqo+Zxod7jhPnL5s
	ZWV3sNFIzMYaHiwG/bEvg40RSPbG1qPo/0zMJtmdt54Jx/Qzhb7vs8EYS5l75wYC
	QJeljFXOBcM9eIleL6qdNuCMm1VY4irhxFg==
X-ME-Sender: <xms:4jLtaIqjZvPexpdK1gjoZOHI9_KiAzDHMFmRxEoUCR5IwTQh_U1vDQ>
    <xme:4jLtaGGVq_pl1el71r9BEyYw2FzU53SoHwYxcn49YBmWf4KcuztLx7ISdtDZg22g1
    qYcdA6sHQMVvSub-Ft-58Za7Z8kwN2JNCBYIFy7P_OGPjhU4YfC1Q>
X-ME-Received: <xmr:4jLtaKnILetUoWhayuMEcgGF4FC93DQvq6LTJuQthn_baqmZUXH5Ab1qd3HiIMGBzWC1rlabcDBflXugLbNuD-wHJVLkeLR8znLo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepohhkhhhuohhmohhnrghjrgihihehgeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4jLtaJnJXLfog9dl-9KeYMkH1b-YTDiTJXxa9tzNmCNTcUk1qo8AFg>
    <xmx:4jLtaLvHDmFMMwgRKzLfpyz7BY2KxTZ3r9c-cbbtMrRRBT4KUkTF6w>
    <xmx:4jLtaMmNsu8ZzzggVmkTn0BAroiPIkRDJvx7KGmh1jCBEQYxx7Dwiw>
    <xmx:4jLtaGv-h-vO3yZGnkQQ2F-BjVYmlHeJV-0Cr__jCKvFvF06VuG1mg>
    <xmx:4jLtaOFiJGsQ2x_dA9fGvKAVuMDMF2f-e3LBmBePYLggjApp_mUYL-jB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 13:12:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] [Outreachy] patch-ids: fix const correctness
In-Reply-To: <20251013165320.201333-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Mon, 13 Oct 2025 17:53:20 +0100")
References: <20251013165320.201333-1-okhuomonajayi54@gmail.com>
Date: Mon, 13 Oct 2025 10:12:00 -0700
Message-ID: <xmqq4is23evz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> The `patch_id_neq()` function received a pointer to diff options via
> `cmpfn_data` but cast it to a non-const type. This caused a const
> correctness warning and could potentially allow unintended modification
> of read-only data.
>
> Fix this by casting to `const struct diff_options *` instead, removing
> the outdated NEEDSWORK comment in the process.
>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
>  patch-ids.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/patch-ids.c b/patch-ids.c
> index a5683b462c..b6b808332f 100644
> --- a/patch-ids.c
> +++ b/patch-ids.c
> @@ -41,8 +41,8 @@ static int patch_id_neq(const void *cmpfn_data,
>  			const struct hashmap_entry *entry_or_key,
>  			const void *keydata UNUSED)
>  {
> -	/* NEEDSWORK: const correctness? */
> -	struct diff_options *opt = (void *)cmpfn_data;
> +	

Trailing whitespace on this line.  Remove the entire line instead.

> +	const struct diff_options *opt = (void *)cmpfn_data;
>  	struct patch_id *a, *b;
>  
>  	a = container_of(eptr, struct patch_id, ent);

I do not think this is correct.  Have you even compile-tested this
patch?

Later in this same function, opt is passed to commit_patch_id()
function (twice), which takes non-const "struct diff_options *" that
is given to diffcore_std().  And the last function in this callchain
has to modify the structure to record various findings (like "did we
see any changes in the diff?"), so it cannot be "const" at all.

I think patch_id_neq() that says cmpfn_data is const is the source
of the problem, but that function signature is mandated by the
hashmap API.  I do not know if we can loosen it there in the hashmap
API and if so what the argument would be, but thinking about these
things is what the NEEDSWORK comment is about ;-).



