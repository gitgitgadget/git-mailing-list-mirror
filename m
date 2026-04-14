Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE7C2253EC
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776185667; cv=none; b=KkhYjU/tQB6Rs7AEx2900yFZdnhqbIBsna/roX2yJ0mX2TflGunaLO4dxFfnK/S+MtBhZWUuP751k3W5Y1+OvI0SPJEt9o88IW+fYndxlhiAkXqK7EeB3uFykHDFkik0FY1fYCjl3noZ8vwGpAMQLDvO7h7sWqgpfiGbZ5UxchU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776185667; c=relaxed/simple;
	bh=4uKaJh+MMoHWlUq649y5pDqvopOmmB8lWQjKEfRLR5I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a8Sz8daEMJgW9lC5hdlad8++iO5Evzwp1rcehRxKIlfY77VUmnTjqmH2lA/ychk5Cdta92xRkQ74gzoffjJ8P2hv75QAdkhwZTJUkmikPlkpBojn3AP/WGoMAkLowql++3Jbd5cS27W3lk5+mNECELde83RpMA3/GDz+ZqdUpOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fHLMeHIs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iZUtTcZp; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fHLMeHIs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iZUtTcZp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 267681D0015C;
	Tue, 14 Apr 2026 12:54:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 14 Apr 2026 12:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776185665; x=1776272065; bh=2hKQ8tlfL3
	4FVq/oo3et/BmyG9qFYcrMG41M84NKrlE=; b=fHLMeHIsKDlzfhnK9NEOciS9NS
	p4aeatowI67FOvIdnR6pLlTEH0IytPzk2P2ccLGNrOXnQviNVPFMZsF/ed24h+Fx
	IKfjCejayz/lttf1NeOHiOiK99HzOvNQM+dm5MRigPYD7ciJA7fKCsnV73ky4BjP
	s1UfCq2nTU5szhQ9N9ZJdlnazk6lK1qHbF9MCncCAztp7gFt0W3eANx9ZxQZQ/ON
	9vGc11Xjy2G6MkkUQKoKOi0GB+EtPfJwYsoWBHPQzb6J/UGQV2H0i0IdGU239SeQ
	z/sbvBy38pHc7lsPIsIFAZZLmf398+iIlDdW4Ujsouico2lSDreIw7FuAjfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776185665; x=1776272065; bh=2hKQ8tlfL34FVq/oo3et/BmyG9qFYcrMG41
	M84NKrlE=; b=iZUtTcZp9Lfr38sYDKrySLvJudw232nAJiuXQDRvi8NMWYmxRys
	3pdmuZGsmHmqXLOECxsgK9Mwft4CVJvk6N7OO2zWaYD1S0mJQu/U89VCnYA77Xl6
	7PN6ytsqmRueFTvWr1g81xGRBf5/bjZBZGevcJ1Prs8WPN6NHMKK6dOyS9uazLhC
	IFB+We+yYn2aWte17e2Uq1TapRk36jOI3wH8k3NmlbEXHmjbJSO3Fgx8U24evWYl
	F5mBigj153SDkcm7kRqFbs1tVsyUDYHBdf4DI35M83pV5eC2KtMbzl1wNwMvU6DR
	VMc0qosbqJdvwzzOaEq4GeQfysSuMfeWZlQ==
X-ME-Sender: <xms:QHHeadZzIgA7P92L_SrZGuZMhtSuKy5Q1BeL3G5mfIw99l5yCeBHTA>
    <xme:QHHeaWqa014VYux0hiS2hEpQ7VJwn5sKOUc5tmm5EFfug04pf8qH2va16QH1AQeS7
    3UTTtBMMlBKs4OtyQNWLXsagES8PzaJT12gTh2-gOJZDQajj7b7gIs>
X-ME-Received: <xmr:QHHeaSPXz60NOtTVHsEWgHC8yEOVMc3c2_9qrLhLwhSqJoF8wwHRkO8k39KaaW-0JNaml6Ng4676OU_pMEU_FE541L5Ts2fbfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrrdhsihguughhrghrthhhrdhshhhrihhmrghlihesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprggsughosghnghgrugesghhmrghilhdrtghomhdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghnugihrdgt
    ohhmpdhrtghpthhtohepjhhohhhnrdgrrdhprghsshgrrhhosehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QHHeaRp6u_nyyUq1toNZ00gkb4i4Olpy4DA3JAuMClMac8K6wVj7ZA>
    <xmx:QHHeaXctMyijkAKpoutnyVzlkdHVMb3yjB04Ruw0RPEJ7XgFiyTuFA>
    <xmx:QHHeaXSlpIaWiXG_Nzz4Kna161t54oQcKzw-Lygulm-zGCcAEeY2jw>
    <xmx:QHHeaQYGi9P_aWzEx-3ZTjwHQzSefjaAxGDdsDHcRxJs0WOm__OhLw>
    <xmx:QXHeaZUPrWDx24xOs_AX8zOMI42F2bFDA1_5hg8NRNxNkHDMkc8pPjyO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 12:54:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  abdobngad@gmail.com,  ps@pks.im,
  bence@ferdinandy.com,  john.a.passaro@gmail.com
Subject: Re: [PATCH 1/3] t7004: drop hardcoded tag count in invalid name test
In-Reply-To: <20260414141828.27576-2-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Tue, 14 Apr 2026 19:48:26 +0530")
References: <20260414141828.27576-1-r.siddharth.shrimali@gmail.com>
	<20260414141828.27576-2-r.siddharth.shrimali@gmail.com>
Date: Tue, 14 Apr 2026 09:54:23 -0700
Message-ID: <xmqqmrz5bhz4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> The test 'trying to create a tag with a non-valid name should fail',
> checked that exactly one tag existed in the repository before and after
> attempting to create invalid tags.
>
> As pointed out by Junio, this makes the test brittle by relying on a
> specific global tag count. If future tests are added or removed before
> this test, the expected state changes and this test would break for
> completely unrelated reasons.
>
> Since we already use 'test_must_fail' to guarantee that the invalid
> tags are rejected by Git, counting the tags before and after is redundant.
>
> Drop the 'test_line_count = 1' checks so the test doesn't rely on the
> exact number of tags left behind by earlier tests.

The only thing I suggested was that relying on exact state before
this test makes this test brittle.  I do not necessarily think
"redundant" is bad.  Having belt-and-suspenders sometimes help.

Alternatively, if we wanted to catch a bug where "git tag" exits
with a non-zero status, satisfying test_must_fail, but still creates
the requested tag, then we could do

	git tag -l >tags-before &&
	test_must_fail git tag "" &&
	... random attempts to create with invalid names ...
	test_must_fail git tag "other~tag" &&
	git tag -l >tags-after &&
	test_cmp tags-before tags-after

instead.   And that is a belt-and-suspenders approach.

Having said that, the patch is already an improvement, so let's take
it as is.  Unless there are other things we may want to improve in
this or other patches in the series, that is.

Thanks.

> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
>  t/t7004-tag.sh | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index faf7d97fc4..6ca5c75b57 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -191,15 +191,11 @@ test_expect_success 'trying to create a tag with the name of one existing should
>  '
>  
>  test_expect_success 'trying to create a tag with a non-valid name should fail' '
> -	git tag -l >actual &&
> -	test_line_count = 1 actual &&
>  	test_must_fail git tag "" &&
>  	test_must_fail git tag .othertag &&
>  	test_must_fail git tag "other tag" &&
>  	test_must_fail git tag "othertag^" &&
> -	test_must_fail git tag "other~tag" &&
> -	git tag -l >actual &&
> -	test_line_count = 1 actual
> +	test_must_fail git tag "other~tag"
>  '
>  
>  test_expect_success 'creating a tag using HEAD directly should succeed' '
