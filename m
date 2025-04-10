Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D742853F8
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288784; cv=none; b=dD4b4VTGwCJnJz2v7fTb304sYU9IGO/0xt0jG4bUrzokLjudNZ+eQ8bZBWdOEVoTP37SJ3iMGqH8m0TvqwM558HbhGqYklncbHeG+Kc7R/J7MjaojiL8TdW9CWeQomZqlajXu+JtIIvKnGF/XOfseFzzN1tYAPd0p0c7Vr/3a1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288784; c=relaxed/simple;
	bh=OnlBiKt3MRUmSOMtD5umCn0ESadJpOoPtHFTOz5IMgw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QeDGbvIFVqY/Soc0cZG0GEOJ2mmg7KYucfMm8SQLwvbGsK6YF2EilLnDAQmb0idBVtatg6e11QvWEMgqb8rS4rap2ybSHCWtLZfyil9HjMp8ILceDOJRkuyo7RBMDkoPYUpx/KxFa/f4bjMjlkOm53mfI39Acz99yeaii+aCe34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gihc5rkc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TQ896dBh; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gihc5rkc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TQ896dBh"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1627325401F4;
	Thu, 10 Apr 2025 08:39:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 10 Apr 2025 08:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744288780; x=1744375180; bh=6+FleJOZx6
	7Fit97QmTvkq+6Uyhu5BiPdNtcP1utmJA=; b=Gihc5rkc1WQxi18VvpbkgvS9o8
	BOcOIjk3NJI52UFcyQkivHu9P2nTczga62OFCF98u852mlrxKisFXngGEX+6AScK
	amoYipC6UCOTrZI//K1uyl5dwBeCPsPsCB99Vx3EvhX3u74Cj4Lj8JkLylzg76Qx
	XOq6W+uPDRV/Wn5NI8dYQfpKiURc5hJHZvSoto5053w7aco44r/y7hQDlNVh2IKB
	k1IthUqPL4YTbanfyMBnx2bq5q4gbjePuh/X3P0HqEe/Dem0Rh5q/0+kPukR3+Lv
	a43gi55pf3k1ACIOaW2iBXQMfNIRoG+q5GUGi2Rh1TeqkalAJgGNPNOrBt8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744288780; x=1744375180; bh=6+FleJOZx67Fit97QmTvkq+6Uyhu5BiPdNt
	cP1utmJA=; b=TQ896dBh15SrVTGlph0E+qEGmxmA71J8jHQ8RRJ9b1AHioclz92
	QnyxkCX1s5vtlzC0qo62JLQllQvAO6dx4wVgDTQxbeuMlqG7McH2Ko9cSe/kv9G0
	Gj/CA9EsCS0x+Rv3cOwMWtuY0Cu7SloaKqbL0w9n+FGVDseJe0ypysrYgZckamN1
	1+N1Cg40vslLJu1XuC8WKDAM2atwoeQ2bWPBWRCo/4OF4zAdU5FrGT5OxoStZURt
	pnWiaWgeyGvNeDd/tGIcY6jQxhjHcHUozPAXCUFGabD6h1hYLi0rVexj17zs8o67
	Crfh32AvIk6dYwHqR0yPYbjFmTs+YkS6zow==
X-ME-Sender: <xms:DLz3Z-bsb9oLj9oJvBrOKYtAQtEYDAOi-5H4shBsL1rQVeK6XvV3bQ>
    <xme:DLz3ZxaefLBPUtYgScQwrOBbcK-ODG9zBGZBmmlCgSfpkfZDVeqFQx9dR7xe09ncF
    _n7trDd1qKCwt2dsw>
X-ME-Received: <xmr:DLz3Z49rv-IkbgFPLZ4t03FLGg2kGVn54JGBE_wIR4s73trY2lPsP-cGOZBGNpTJjANKgriuRBaY7ONwWsc6GtQ7w8COxNxmMSHJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehsnhdtfedrghgvnhgvrhgrlhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DLz3Zwqy2vSb3w3TyU4Bj2SAR0JYtD0LcRi1n4ie3ZynnnmC5k7tbA>
    <xmx:DLz3Z5qOjsZ3FhUFxjbgpTFNbUhuM0SlO94Wgzvm9GywIA8IWChY3Q>
    <xmx:DLz3Z-SvryHDw4tVd8o2E3xlXgqZ1I6foZh2a-sSq1-3UQJJVaof6g>
    <xmx:DLz3Z5pNooCBmraa6oig_E1RhyD1KioOeB8qWVW-2rhYF0OcbYRklg>
    <xmx:DLz3Z_T8YFratOFHu2319_ts-hQcuJlFhTBytGrJESYtIKyGroH6IBMl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Apr 2025 08:39:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Subhaditya Nath <sn03.general@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  sunshine@sunshineco.com
Subject: Re: [PATCH] t7422: fix extra printf argument, eliminate loops
In-Reply-To: <20250409191139.29644-2-sn03.general@gmail.com> (Subhaditya
	Nath's message of "Thu, 10 Apr 2025 00:41:11 +0530")
References: <xmqqr021qkeh.fsf@gitster.g>
	<20250409191139.29644-1-sn03.general@gmail.com>
	<20250409191139.29644-2-sn03.general@gmail.com>
Date: Thu, 10 Apr 2025 05:39:38 -0700
Message-ID: <xmqqcydkp4vp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Subhaditya Nath <sn03.general@gmail.com> writes:

> -		for i in $(test_seq 2000)
> -		do
> -			printf "[submodule \"sm-$i\"]\npath = recursive-submodule-path-$i\n" "$i" ||
> -			return 1
> -		done >gitmodules &&
> +		printf "[submodule \"sm-%d\"]\npath = recursive-submodule-path-%d\n" \
> +			$(test_seq 2000 | sed p) >gitmodules &&
>  		BLOB=$(git hash-object -w --stdin <gitmodules) &&
>  
>  		printf "100644 blob $BLOB\t.gitmodules\n" >tree &&
> -		for i in $(test_seq 2000)
> -		do
> -			printf "160000 commit $COMMIT\trecursive-submodule-path-%d\n" "$i" ||
> -			return 1
> -		done >>tree &&
> +		printf "160000 commit $COMMIT\trecursive-submodule-path-%d\n" \
> +			$(test_seq 2000) >>tree &&
>  		TREE=$(git mktree <tree) &&
>  
>  		COMMIT=$(git commit-tree "$TREE") &&

Other than the cuteness value (in other words, "by rewriting this
way, I can use this shiny fun feature `printf` has that I just
learned about"), I do not see in what way(s) the updated code is
better than what Eric picked as "most natural" among the four
candidates you presented earlier.

If I am not mistaken, the `printf` utility tends to be implemented
as a built-in in modern shells, so it is not like the above rewrite
replaced 2000 fork+exec with a single fork+exec of /usr/bin/printf,
so for those shells, there is no performance based argument to
prefer it.  And with shells that do have to fork+exec
/usr/bin/printf, the command line to invoke it once now uses about
18k bytes with the current code that uses 2-thousand submodules.

When somebody wants to extend the test to try with more submodules,
at some point they need to start worring about hitting argv[] limit
of the userspace-kernel interface, and at that point, it is likely
that they have to go back to a for loop, doing something like

	i=0
	while test "$i" -le 200000
	do
		printf ... "$i" "$i"
		i=$((i+1))
	done

Sorry for not spelling "I would not recommend going in that
direction" in all caps in red letters in my earlier message.


