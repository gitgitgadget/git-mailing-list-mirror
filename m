Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADE6223322
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538361; cv=none; b=TTvNox/uqjek36IrzET2cfrEF2fNkaEeMrghESSdgdFXShTtyhGSmhdBwuTD8tW8ce6qv1wQvexan+cV4dYUMcWAD+EfZ7j6LkhFCW3ZNWWNVI8wPyfd+ccEWIYrLLj2But2ThP6UdSkum4FsSkXj9z2n3xwwfCQO0pbzLUoVv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538361; c=relaxed/simple;
	bh=g0ICq77Wt0qzcAPFTGGrhY+uZ3XMlziZyq978GGoE7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bj/XzEpd+OrBMJG9aZ5U+fIuq548Yh0shypURxQMuDdO96r2+m6tS9+bzn3VC8SWVqSxCI6wGo0OHv4HfXMtHyWqsoQdLvsGHe+z8tiwCmJmvfCL1MX2Q1sOnj7AEDVhp5FW8VTiRUF3ceoRIwRacLVtKJtuTKoNxQbu3zxF1Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UIlensQi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ArrUzvF0; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UIlensQi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ArrUzvF0"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id DD31B1D00190;
	Thu, 26 Mar 2026 11:19:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 26 Mar 2026 11:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774538358; x=1774624758; bh=hFZqtYiNjw
	piPWSWLzdQf4zNI+JpNMbCnyB/JvZlALA=; b=UIlensQiw5pxt4b82kFRxiYzO+
	vFH5DiYZOVChDv5fy4FpBaeUCMYo6Hco1Vi8knPhQiZFHUwv0ODvcF/rKj2CvDzj
	Oro2H/VwNXSYHlQ3UswVsIyqj+xgi/e+o2EI0/986ou+5BuXPwjecrPlylav0UGY
	3Hrebj7UNl1DJCNWP6Si1jAamMeQJML2Mz0ArC7eRgsuQQYFUt6mo5Hhm495uhkv
	yjXacVE8YJ83lUxOXBbPK/PuBJsAwagb39YiuYod9C4+SpimTBTHjDlSa7jGCpQJ
	l1llzdppSBm56/93oeL/jd4KuQXWldhNaz/pThVwXt2zUNwz3/0MSe4Y9TaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774538358; x=1774624758; bh=hFZqtYiNjwpiPWSWLzdQf4zNI+JpNMbCnyB
	/JvZlALA=; b=ArrUzvF0LKds5OEgYiTEUw4TXwbH/bKSYFnV/x8KYDhfezAUtS/
	12Q+F0oHqgA/yOwyrq4tiJjBmmAXZGWUnePpfwdvGiqcG1zLZO3S2AKDLtyZW+Uu
	RD1hFpzFcO9r8LeQBDBRwWEYgQmvUUvKUcQSFO8UjkjVeowW2pU2wkgttWkM7nAP
	45+GKJgHzPOJ2+jOQ5Xo06/s9QKeHEDsj1J+OTPX3s8clr1RZAU4F6SageMaavXh
	Q0/Z6GUgvQbIYYnyqhFKo2Lux9WeJZ1UpNQMxqpjpFiF+P0M2hNf7nq5DBI4Xzm3
	KcIjGYqgpNAs3fVhy6JtDQnYJlujIdHDIPw==
X-ME-Sender: <xms:dk7FaUiSDY9dUh2x6M5rPAjiNUM_ip_SEpnD1ai1VHWAzT8ctpvzNA>
    <xme:dk7FaUfwZRZ1tWP-TlCKVoN8klOTg7-k26ZoJJOmyEifdOmorWd6xQQyiT2i7nqff
    f4iSShRw52MUDl0fnkF6YLVzDf2hxx0ah00gTymGKqmecwoIppl7Q>
X-ME-Received: <xmr:dk7FaZcgOWcEvB4HCjyxo5QOgF0PKWYrJ5vGvLkKZpI8f9TQkI4f6JiOunJaeAijt2TLjuiaLgR2ulCYMoVDAgkYUgNmIqhAKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhkihhn
    ghhttgegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dk7Fae8NmSyYZbrsIkdfIUfqIV97dLdNoFgdKv-BlcYptdEaO72SQA>
    <xmx:dk7FaVkkZQRC8J6Jn74_-6yuKf_EmoO9bG4DxQ13xRgQQUx59ZID0A>
    <xmx:dk7FaQ_xVXgiva0YcQJkRsJwGx4qr9oLy02LDiJKjTM_2BXbrNGioQ>
    <xmx:dk7FaTkn0hwdfDmTFQ-LxkEoSNgWXTSYvGXw78JqzoV8S_PwUphg_g>
    <xmx:dk7FaUcZoV4c7Kimm-cbNeYt2E8RLNiK1wGmByEeBKc-PSGn2MyJ_AsM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 11:19:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] t8003: avoid suppressing git's exit code
In-Reply-To: <20260326141118.146155-1-vikingtc4@gmail.com> (Trieu Huynh's
	message of "Thu, 26 Mar 2026 23:11:18 +0900")
References: <20260326141118.146155-1-vikingtc4@gmail.com>
Date: Thu, 26 Mar 2026 08:19:17 -0700
Message-ID: <xmqq4im2sjnu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Trieu Huynh <vikingtc4@gmail.com> writes:

> Update t8003-blame-corner-cases.sh to redirect git-blame output
> to a temporary file instead of piping it directly to not hide
> the exit code of git commands behind pipes, as a crash in git
> might go unnoticed.
>
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>  t/t8003-blame-corner-cases.sh | 42 +++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 14 deletions(-)

I see nothing wrong in the proposed log message nor in the patch
text.  Nicely done.

Having said that, we could be a little bit more ambitious and make
this into a two-patch series, i.e.,

 [1/2] does this exact change + "grep -> test_grep"
 [2/2] modernises the style to remove blank lines at both ends of
       each test




> diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
> index 731265541a..f753e26e82 100755
> --- a/t/t8003-blame-corner-cases.sh
> +++ b/t/t8003-blame-corner-cases.sh
> @@ -50,67 +50,78 @@ test_expect_success setup '
>  
>  test_expect_success 'straight copy without -C' '
>  
> -	git blame uno | grep Second
> +	git blame uno >actual &&
> +	grep Second actual
>  
>  '
>  
>  test_expect_success 'straight move without -C' '
>  
> -	git blame dos | grep Initial
> +	git blame dos >actual &&
> +	grep Initial actual
>  
>  '
>  
>  test_expect_success 'straight copy with -C' '
>  
> -	git blame -C1 uno | grep Second
> +	git blame -C1 uno >actual &&
> +	grep Second actual
>  
>  '
>  
>  test_expect_success 'straight move with -C' '
>  
> -	git blame -C1 dos | grep Initial
> +	git blame -C1 dos >actual &&
> +	grep Initial actual
>  
>  '
>  
>  test_expect_success 'straight copy with -C -C' '
>  
> -	git blame -C -C1 uno | grep Initial
> +	git blame -C -C1 uno >actual &&
> +	grep Initial actual
>  
>  '
>  
>  test_expect_success 'straight move with -C -C' '
>  
> -	git blame -C -C1 dos | grep Initial
> +	git blame -C -C1 dos >actual &&
> +	grep Initial actual
>  
>  '
>  
>  test_expect_success 'append without -C' '
>  
> -	git blame -L2 tres | grep Second
> +	git blame -L2 tres >actual &&
> +	grep Second actual
>  
>  '
>  
>  test_expect_success 'append with -C' '
>  
> -	git blame -L2 -C1 tres | grep Second
> +	git blame -L2 -C1 tres >actual &&
> +	grep Second actual
>  
>  '
>  
>  test_expect_success 'append with -C -C' '
>  
> -	git blame -L2 -C -C1 tres | grep Second
> +	git blame -L2 -C -C1 tres >actual &&
> +	grep Second actual
>  
 >  '
>  
>  test_expect_success 'append with -C -C -C' '
>  
> -	git blame -L2 -C -C -C1 tres | grep Initial
> +	git blame -L2 -C -C -C1 tres >actual &&
> +	grep Initial actual
>  
>  '
>  
>  test_expect_success 'blame wholesale copy' '
>  
> -	git blame -f -C -C1 HEAD^ -- cow | sed -e "$pick_fc" >current &&
> +	git blame -f -C -C1 HEAD^ -- cow >actual &&
> +	sed -e "$pick_fc" actual >current &&
>  	cat >expected <<-\EOF &&
>  	mouse-Initial
>  	mouse-Second
> @@ -122,7 +133,8 @@ test_expect_success 'blame wholesale copy' '
>  
>  test_expect_success 'blame wholesale copy and more' '
>  
> -	git blame -f -C -C1 HEAD -- cow | sed -e "$pick_fc" >current &&
> +	git blame -f -C -C1 HEAD -- cow >actual &&
> +	sed -e "$pick_fc" actual >current &&
>  	cat >expected <<-\EOF &&
>  	mouse-Initial
>  	mouse-Second
> @@ -144,7 +156,8 @@ test_expect_success 'blame wholesale copy and more in the index' '
>  	EOF
>  	git add horse &&
>  	test_when_finished "git rm -f horse" &&
> -	git blame -f -C -C1 -- horse | sed -e "$pick_fc" >current &&
> +	git blame -f -C -C1 -- horse >actual &&
> +	sed -e "$pick_fc" actual >current &&
>  	cat >expected <<-\EOF &&
>  	mouse-Initial
>  	mouse-Second
> @@ -168,7 +181,8 @@ test_expect_success 'blame during cherry-pick with file rename conflict' '
>  	(git cherry-pick HEAD@{1} || test $? -eq 1) &&
>  	git show HEAD@{1}:rodent > rodent &&
>  	git add rodent &&
> -	git blame -f -C -C1 rodent | sed -e "$pick_fc" >current &&
> +	git blame -f -C -C1 rodent >actual &&
> +	sed -e "$pick_fc" actual >current &&
>  	cat >expected <<-\EOF &&
>  	mouse-Initial
>  	mouse-Second
