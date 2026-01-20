Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626143624CB
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932467; cv=none; b=NigEVRvnGViTwYdHUMuZ0DKLDq7pZTR6A1gZgJfXIqzu2+gH1siQIYSl9kLknYFxd0uG8CJaec5zsoWf8a1Lp+8Bpui0O4ZkpmN7897k0J0nYwil4vaYI+9BZS9YyvE+v9qasETJrOpFQsOSzNiRSUn5iVbJ0JEv5sdWrEf0rB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932467; c=relaxed/simple;
	bh=QBWOysYpXExNVCddhrXVxpcxi5HO7NiL4Opm7+jjvkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nhvnMAstMMuVg9pNNPlgmWbmoL04dLxbzsb7QNIpXZ7lfEDM0B5CgaPG99Sb/hWvzCg9KQUA4aUJHTnEZnIEYwDEGU7O9xiTAoX2deznjuv2i21dnw8ua8QUqoRc6BpZ2/Oe2M01X9tHWCrUWvGs6fDQ/FcSAwAEl7isrQIRxII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l0wboBQ2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZZkN3OrO; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l0wboBQ2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZZkN3OrO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 78D4D1D0003B;
	Tue, 20 Jan 2026 13:07:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 20 Jan 2026 13:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768932464; x=1769018864; bh=i9HifmOurs
	zr0EEJfqeP77u/WUHuCEkfsDvHkovtICI=; b=l0wboBQ2UAx0pdk0n8UWfLX2NG
	X1FiVkntAk6Tx3qq+nAEAWrFNHqUua3LPKCTmejS35avTHU+KV1wAImwW0Gtocpu
	djrFX1YocZJZGUgUJKKr/F9hoK9C2dWd+XglN1JFFG+jsjn0XVaHjUezrXyebi2P
	QkiniAdZSBHHM/BbxjNpNxkAIiO7p4Uqxn+WqBP6dmWrsI5J3oiQcgYSFzE/Emoo
	ysTsw0SA9dsZc3aFRHVNpWldTjb8wQrsJOLnkREHE5+AdaZcsRgJ3PE/ZN3lJ1K5
	8qFL5fqhPwVJxgHybYS4I+KidHFrVuOHDdCIImhwTs54/SLIs/afUBD/OMZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768932464; x=1769018864; bh=i9HifmOurszr0EEJfqeP77u/WUHuCEkfsDv
	HkovtICI=; b=ZZkN3OrOLxMlPCBLq/SuvHSr+l5cu/oYvLkHCMuGdnADwa30ERV
	GfQ1RV7m08HMG4A/5vhAIDxrs0lL9a/eqbwAVkxSHQoJobkPmd6Zay1uXeifSkSk
	xnwNAsAQ7KWxKP74f2g0oHNJ1ljyExsaOZWKsShaXUzLhy/VQ3zLPu1VWsZIPHDC
	y0RojBNEWBmGz30CKU8zPkJfysrLkcXT22/d0fNvfOUvPEQIEUcEv/UkMHlRvI7H
	ti0V3VexJLLgqy9AqfyVkZdW0K3tny6NpUN6QjgYBApTq41reZ3fjTZe9c4E1upg
	bxnmRzO8rkTXDk6NwaB+J9VpmOdzUaO/Hkg==
X-ME-Sender: <xms:cMRvaRjCVhjCZcdCWstnvlJpxozMWfJfzlz_S8WcWRpiAJpbrlQ0xg>
    <xme:cMRvadcrRL9Blm28qCeXYi9FefBY4JQsZLOFpN1Z14Nj2VZdynPaYm-bRAM7u0YwO
    fkKW0H7_Wj_kRVgcfM5zoAuQhyUlp8WxoIA6L3NMAK0ZdA5zIZ-hE0>
X-ME-Received: <xmr:cMRvaefcG8At9OeTZDt5bEg4Z7mP6sQVA_zo5GOOtAriFres8CEFNs-QyNyI-xZkyp3VUO0YX_qxrc02C-GLKEUO4j3WJVnqAZTpyNU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedutdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:cMRvaf8bE7RWgfrpWwtssPDW4EWcLR5wPfZ6I7s0JfG9qbDI0l4T-A>
    <xmx:cMRvaSmBvzJOoCIZNl2Cyb9_wY_QyYa8StMNHlMbzyMXQf68Nd9qTw>
    <xmx:cMRvaZ9V8lN3Pj-zkMgonVL4vttNiBvzrvVPmbuuDsdZCeA2JlBDaA>
    <xmx:cMRvaYlYgrV3nrdmPw3aaskaNtF1LAIOqJUo3j3kElwTKPlim6E8fg>
    <xmx:cMRvaddot98lQqVR6c9VjesKIJ8ZufIyWvNIhD3-MXdl2An-aXP5Vc1u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 13:07:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] show-index: implement automatic hash detection
In-Reply-To: <20260120140901.517928-2-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Tue, 20 Jan 2026 19:35:39 +0530")
References: <20260120140901.517928-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260120140901.517928-2-shreyanshpaliwalcmsmn@gmail.com>
Date: Tue, 20 Jan 2026 10:07:42 -0800
Message-ID: <xmqqzf68yx75.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> @@ -71,6 +60,40 @@ int cmd_show_index(int argc,
>  			die("corrupt index file");
>  		nr = n;
>  	}
> +
> +	/* detection of hash algorithm
> +	Only works for small files, i.e without large offsets */
> +	if(!the_hash_algo && version == 2) {

We have one SP between "if" (and other syntactic elements like
"while") and the open parenthesis "(".  End-user controlled function
names lack this SP between <word> and "(".

If we turn what is inide of this block into a separate helper
function, it would allow us to structure the logic better.

	/* Returns GIT_HASH_* constants, or GIT_HASH_UNKNOWN */
	static int auto_detect_hash_function(int fd)

For example, ...

> +		struct stat st;
> +		size_t file_base_size;
> +		size_t table_size;
> +		size_t size_rem;
> +		size_t hash_size;
> +
> +		if(fstat(0, &st) || !S_ISREG(st.st_mode))
> +			die(_("unable to detect hash from non-regular file"));

... this "die()" does not have to be here.  We can just return
GIT_HASH_UNKNOWN and let the caller fallback.  Does the existing
code correctly complain when the filestream is opened for a
non-regular file, or it just gets totally confused?

> +		file_base_size = 8 + (256 * 4);
> +		table_size = file_base_size + (nr * 4 * 4);
> +		size_rem = st.st_size - table_size;
> +		hash_size = size_rem / (nr + 2);
> +
> +		if(hash_size == GIT_SHA1_RAWSZ) {
> +			repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +		} else if(hash_size == GIT_SHA256_RAWSZ) {
> +			repo_set_hash_algo(the_repository, GIT_HASH_SHA256);

And instead of calling repo_set_hash_algo(), just return the
constants so that the caller can handle it.  And 

> +		} else {
> +			die(_("unable to detect hash algorithm, "
> +					"use --object-format option"));

... this also can return GIT_HASH_UNKNOWN, without complaining
anything.

> +		}
> +	}

So, instead of inserting all of the above lines in cmd_show_index(),
we'd have something like the following ...

	hash_func = auto_detect_hash_function(0);
	if (hash_func == GIT_HASH_UNKNOWN) {
		warning(_("assuming SHA-1; use --object-format to override"));
		hash_func = GIT_HASH_SHA1;
	}
	repo_set_hash_algo(the_repository, hash_func);
        hashsz = the_hash_algo->rawsz;

... there.

By the way, what happens if we find SHA-256 also broken and end up
choosing another hash function that is 256-bit wide in the next hash
revamp?

Thanks.

> +
> +	/* Final fallback to SHA1 */
> +	if(!the_hash_algo)
> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +
> +	hashsz = the_hash_algo->rawsz;
> +
>  	if (version == 1) {
>  		for (i = 0; i < nr; i++) {
>  			unsigned int offset, entry[(GIT_MAX_RAWSZ + 4) / sizeof(unsigned int)];
