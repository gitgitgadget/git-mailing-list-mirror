Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C80C27511A
	for <git@vger.kernel.org>; Mon, 19 May 2025 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747667578; cv=none; b=BFiXp4u5q3nOxgullfQbQYVmLUtqmmYz5vtqs5/VFblQvThBnDWOPYwTwXiuQFBzNpvufFDvB4kNfgdHbbPh6ea/4j9XQaDD+ZPUbnbt3HDgyHcx01E46khnx7XqmYUNymhY7yqP/T62qu4/ygeAJuCsaGhvZYybWPik0tp15aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747667578; c=relaxed/simple;
	bh=Xm1Cjf/o3EkliTVgI7BH0hDbyctURlL/hv5kP44jUu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tw4t+RWeZbxS8+0KvjSpTWM//Llv+gO9m8YfpyivMxEg6On4qIqILfeZfFPu8A6ylvbNW4pBTXJQuf0/Fa1WqnUl6OUiejE2lSzJpvCX3rIOSBcPhVk9JlPigmAzp2RdI/RXDU3+x866218Whv3P8ltF8HvyrRfbp4c1fbRENrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y6cKyG9s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YLX43OiT; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y6cKyG9s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YLX43OiT"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B68C1140085;
	Mon, 19 May 2025 11:12:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 19 May 2025 11:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747667574; x=1747753974; bh=xrcbdRq/wt
	H6g+O9b2P36EnpMLdkN7/rCfSMeeZ2p80=; b=Y6cKyG9s+3aZkPLRwHNHaFZUuv
	fh9OLDC+dbufRt86lbb+V8RP/0UvRod4zAQVtDFRGm3hU4KrH6xMg+lrU6P0OAx2
	JlNSGzbsvUy5zioSV7Kf/zpkUXgpG8KUmbaevKRuH60xQfFVj42Y4ZcRWn8Jm8Ps
	ffMn3AayR3Lx0s70isoMIkGe5wQrnZdbXdirpzE4DoWLpUuQNlZlCN6C+V2VVnWj
	0S58Rk032r14wwp3pbRmJw/Ys8VWJXHCvaBjHMC2fptII+ipg8THguKISwn26Act
	ZJYfWVKjvZmhWZmGBhTzjCL3sbX1ohEy1b5tADvVcGmCfNAFZsM+AJlCtXAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747667574; x=1747753974; bh=xrcbdRq/wtH6g+O9b2P36EnpMLdkN7/rCfS
	MeeZ2p80=; b=YLX43OiTCLNHDt8aO/gGQj/LxHj+SDzfbUjqbVfMQiiT+ZfBDDr
	FClE9hH7H8EinkbK24bxYURfeoXobBp493TcEaryICojU8IJna/2QgRGofm+R4il
	Mpkf7a/V4X5upC7+CKi6pFOprvgojsAk6NaapxDXT40DTKKzrc8gTIdnOR0HARmo
	fCwjj+afVK71d3AgYOAThyyiOuG1Nrb7C85EraEKvxLKl919nfervIKg56XpndsN
	nfVqFs2wP+CizTvEG2BHkoxIPNJdgNs5+W8PVsSsCOwqHPAv6qhrPq3utKbE92IL
	lWEW5KCOEH8inKiUQnSZnVpQFUsYsVqFqxg==
X-ME-Sender: <xms:dkoraFQ4YyNGbJcApyqJxihurVjoGxfJSTjdn-eGimOEChI7t8-Hvw>
    <xme:dkoraOyPQEOQgwcov_YfXUwbjmfo89BNaodYowtzRPiyv38U115AGg_HDp6TkXv9u
    A2WNFX8mSUnOD5Rvw>
X-ME-Received: <xmr:dkoraK2nu_CO5eWoml0YTNgtRkRMpv5P3Aoe_-SLcA-QkgHa9AG3JmtDYOWWaqZsnBR-mq8uycvCqu252OfyVXUHRGKwNT0krC6pFsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:dkoraNA-6_aPZTzMEY6NjY4oCB1ScDJHK_uvVh2EPrYQByo8gvkrog>
    <xmx:dkoraOhinAC3rzuyZDAVhPmkkroTDnap9n80Bh4NcIYPJ_wZpDQBdQ>
    <xmx:dkoraBopOaJZScBFzAFTZxMEDP_m0qH9YjyAzoQN9jvP0mlyE8ESQg>
    <xmx:dkoraJht2U_BQWoRFW1MtdU1VY4YxQfD62eRmzXQkqlfkCtMXS-8kg>
    <xmx:dkoraFP4eVhMmzUSsCrocdlrdQYK0Y3jLKTP6gFmBMpO6SsIXBsQroId>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 11:12:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/13] t: add lib-loose.sh
In-Reply-To: <20250516045002.GI22242@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 16 May 2025 00:50:02 -0400")
References: <20250516044916.GA21985@coredump.intra.peff.net>
	<20250516045002.GI22242@coredump.intra.peff.net>
Date: Mon, 19 May 2025 08:12:53 -0700
Message-ID: <xmqqh61gprbe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> +# Write a loose object into the odb at $1, with object type $2 and contents
> +# from stdin. Writes the oid to stdout. Example:
> +#
> +#   oid=$(echo foo | loose_obj .git/objects blob)
> +#
> +loose_obj () {
> +	cat >tmp_loose.content &&
> +	size=$(wc -c <tmp_loose.content) &&
> +	{
> +		# Do not quote $size here; we want the shell
> +		# to strip whitespace that "wc" adds on some platforms.
> +		printf "%s %s\0" "$2" $size &&

Nice to have this comment.

We probably could also do

		printf "%s %d\0" "$2" "$size"

to cope with possible leading space padding, but your version makes
the intent a lot clearer.

> +		cat tmp_loose.content
> +	} >tmp_loose.raw &&

OK, a loose object file is a deflated bytestream of object header
followed by the payload, and because the header records the size
of the payload, we need to read the payload to its end first.

> +	oid=$(test-tool $test_hash_algo <tmp_loose.raw) &&

And hashing the raw gives us the object name.

> +	suffix=${oid#??} &&
> +	prefix=${oid%$suffix} &&
> +	dir=$1/$prefix &&
> +	file=$dir/$suffix &&

OK.

> +	test-tool zlib deflate <tmp_loose.raw >tmp_loose.zlib &&
> +	mkdir -p "$dir" &&
> +	mv tmp_loose.zlib "$file" &&

Ah, you are being very careful.  As this is merely a test, we
probably could do without tmp_loose.zlib but I do not mind it being
careful.

> +	rm tmp_loose.raw tmp_loose.content &&
> +	echo "$oid"
> +}
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index d96d02ad7d..317da6869c 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -3,6 +3,7 @@
>  test_description='git cat-file'
>  
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-loose.sh"
>  
>  test_cmdmode_usage () {
>  	test_expect_code 129 "$@" 2>err &&
> @@ -657,12 +658,12 @@ test_expect_success 'setup bogus data' '
>  	bogus_short_type="bogus" &&
>  	bogus_short_content="bogus" &&
>  	bogus_short_size=$(strlen "$bogus_short_content") &&
> -	bogus_short_oid=$(echo_without_newline "$bogus_short_content" | git hash-object -t $bogus_short_type --literally -w --stdin) &&
> +	bogus_short_oid=$(echo_without_newline "$bogus_short_content" | loose_obj .git/objects $bogus_short_type) &&
>  
>  	bogus_long_type="abcdefghijklmnopqrstuvwxyz1234679" &&
>  	bogus_long_content="bogus" &&
>  	bogus_long_size=$(strlen "$bogus_long_content") &&
> -	bogus_long_oid=$(echo_without_newline "$bogus_long_content" | git hash-object -t $bogus_long_type --literally -w --stdin)
> +	bogus_long_oid=$(echo_without_newline "$bogus_long_content" | loose_obj .git/objects $bogus_long_type)
>  '

Nice.
