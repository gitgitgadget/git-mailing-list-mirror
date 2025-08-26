Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82887237165
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234823; cv=none; b=l07fGFerT0BwI9i4AGIRyVl9AycVsvfAo8QjAAYHZaVp7FK5xRs6ht2facoanBIFVqKW8l3tK30JnuV80k+/GAsGNrdGVxJL7c67D62RN6tBFFBImwA0QunljAQWXf1qTY8IL+/s6KrSoGmG0sCI2FOwzjr8Httc/2kYmBWBCPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234823; c=relaxed/simple;
	bh=GXf8BWhktkvQUNx4DE2KCTwBBfWuFV+ZsexoXXbcmlk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ef8QMD/+7YvXoR0KpGf2JjPVuZZ6sFPUlFecqr7fSK0eT2N1bS+4cLjppW14FS6EE/yBj8EBhcXaMuW93OAn7ULyzapteecwF7hLQTgWce1FSu5by45xkZnDIt60/pZpQf6KINhzF4hfxXvJqnupBNhsFbejPNfW3lYAXAQ1EA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RGeiE+hJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oVQ2MTj0; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RGeiE+hJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oVQ2MTj0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9EE7F14000D2;
	Tue, 26 Aug 2025 15:00:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 26 Aug 2025 15:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756234820; x=1756321220; bh=fj1hjV7QoU
	EnL5++772NIwinAKrwZzL/QRV7hKa3nBU=; b=RGeiE+hJrTfv0KIX5hjhotv7dx
	TfE8y7p+8IKZCZuiQtS21QMQG0yOAK1TscMDRPjEHXbFxrCIQz6tLcqvRwKUluAU
	T4W3nn7Z5n6UQpoxhfau+k+F/FuG2jElzzm/QkN9gXOvPh1fdSynv4zda+FPmiVG
	vO23cOf7XiyosbgzgqyzBP7QtLbMjsfZ5CuE7SAVDg7ZB34i9LEY9KcyIaVznX+v
	hRKSxmrtgn0gtPV4UF9x/P8u46V9qRggfsixcinkZ23i39UZjWbYCAFuYEHGlJ6W
	8plY/V1I/aXV3dDNGCaUc4ZEWKqhLLeNftVkmaYiYrWsj2Fr3qFkOhhtL/NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756234820; x=1756321220; bh=fj1hjV7QoUEnL5++772NIwinAKrwZzL/QRV
	7hKa3nBU=; b=oVQ2MTj0GgGRPC+z/MUX/z7MK6idVz8uQ4TBh8GFTyL+6Z9Gux5
	GPJ3jL/clbARatg5h6jW2a6zXB75E20QBxgSQXaOg1xreSBeU0ToMcMUq9RxbA4V
	EybAvW3eCe38Wb5RMkw0dS1Q5G6pZJN7j2c7VJXx53zbx5oi7bO7/v8nzhGrKexs
	YzcBKLoSnCoi+52cwFP+NQNczUdozrRFYEhyP+1CLl23PKOnsLO+XKAY3wzu4YTx
	4Zv6+OVhM+t1BsmRIOxwXyO5ROovmAupdUNKW2dI849GTEXhk8suMK3zzvWv6Zj7
	pwNHDPEavKN2PYFh2l/uuvvWcFqSfcsiiLA==
X-ME-Sender: <xms:RASuaBHrgF9Joggfu9LQT5ekFCKxWMS0OqJFJrnhFpkQTfI8KxKjWw>
    <xme:RASuaA5qq1wYDVRrPlS3v-vvfYRAwSjZheMslrpDeqTWxKQaqIkdxPfkxnjcINvvw
    euw_a4Qrt7vSUVg0w>
X-ME-Received: <xmr:RASuaPvJTDiOl11iNyt7JG9LBhijWOn7neYDlzBXBEQsFckTsBwCigiAd27A-o9bSJgmxsB1I_Koy5fag6CWbx7vtYsKOmu60cgFd5c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeitdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:RASuaJ63zoAC3sx9iedTflU_WmJG3K_pz7qUo-nGFQiqvJ_eXpPlOA>
    <xmx:RASuaCVwOinwIUUKwAl5IjtZJbk35WSS23jWrmh6FVdWKnJZJ6Z5CA>
    <xmx:RASuaD8Rqg6LOFZoP4hlYxZv3-pQrXWn4xFVyNu_862BBb7tlOUr-g>
    <xmx:RASuaGnYKK3_ufH7-KyVkqh-vy1G3suknBcObZuuGUik-OkkHLEsHg>
    <xmx:RASuaIUf4yES2sko-UkGxPX8QLCfpwJKpfY4f5dGI98hRHQcRfibLbPT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 15:00:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] ls-files: conditionally leave index sparse
In-Reply-To: <pull.1955.git.1755274373717.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Fri, 15 Aug 2025 16:12:53
	+0000")
References: <pull.1955.git.1755274373717.gitgitgadget@gmail.com>
Date: Tue, 26 Aug 2025 12:00:18 -0700
Message-ID: <xmqqh5xtkiwt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	for (i = 0; i < repo->index->cache_nr; i++) {
>  		const struct cache_entry *ce = repo->index->cache[i];
>  		struct stat st;
>  		int stat_err;
>  
> +		if (S_ISSPARSEDIR(ce->ce_mode) && !show_sparse_dirs) {
> +			/*
> +			 * This is the first time we've hit a sparse dir,
> +			 * so expansion will leave the first 'i' entries
> +			 * alone.
> +			 */

In other words,

 (1) we know that the original index entries are sorted

 (2) we are looking at a single directory entry that is sparse, say
     "D/", and ensure_full_index() will expand it (and other later
     entries in the current index).

 (3) we assume that the contents of "D/" will never sort before the
     original location where "D/" used to sit, iow, we do not have
     to rewind to the beginning of index->cache[] array and skip
     what we have already processed.

Having bitten by the index sort order number of times, I just wanted
to make sure everybody's assumption is on the same page.

> +			ensure_full_index(repo->index);
> +			ce = repo->index->cache[i];

and there is no need to say "again" (redo this round of the loop)
here, as grabbing ce was the only thing the loop did, and we just
replaced the entry for the originally folded "D/" with one for the
first subpath in "D/".  Sounds sensible.

