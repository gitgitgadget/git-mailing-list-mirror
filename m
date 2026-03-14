Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621E11B85F8
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773464439; cv=none; b=ogAvMYKyPtNVKw28ot8vOZOeTT4uEtojAYeEV6I7o2M9tfD9aVSaI2g1z41AlWI96VZdTFppwNJ2KkA4EKUJXV+Oa5wm4VHWuDB/QRgSo6qYb+Jf5jeZ+dqS+HW8rwJ9VUSufLdWL1ADpesYO2PudUhwkenaidpH0XtFyGfIn4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773464439; c=relaxed/simple;
	bh=bbUTecsfA151AS8ZO/XQqwdBe8xTuMp8esIszJtGcBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BM47DmNwJBwN7fY2c3J5aexa9wBe6Ct9+L7cPM2z1bvp3JoLq8WnIPdKegazAqlygXaRMWrPklvQ5hpFAFIJf6kf7S48xyNNR6t9fmcDQulYGX81YBRsuv414pfxg1IIr6Vg6z+uS1XxwYS492VADKvrJ/ZiZWxw4Ml1o0xRWx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=evwr3pQr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JsD0yPaJ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="evwr3pQr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JsD0yPaJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 846E07A0182;
	Sat, 14 Mar 2026 01:00:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 14 Mar 2026 01:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773464436; x=1773550836; bh=TuyeuCuEse
	8F0h+wPESLR+/3IpInBR360Fha+woxwpI=; b=evwr3pQrnsKaoHdlc1Dv3LLHD4
	shXOG35ge6WX8uTgOTM5wHs00e8QSg/HTyDAilr4jNOxoZ/Hs3Xnhd7vOgTJMdML
	p1Ywum7XB6kr/zdZgPOQ6ZzwAz3HE05csCrxOnbF0lKvbxUtG8Rz0eUZtD+wDYxA
	hlWVeNCrv7baPIoLpgbu8EJ8jJZ9kOF3ZY0xYM365IDDuuzDGaw76uSSbpWNAxTZ
	gXxiff80MFTUDc88VTjbUVztTSx6VV662bdNo4g+u9KxUjByemxAw+v/2FKHyAWz
	zUkYM29hbwuvrqXEcCQm2bmJornlfgWEv5o3k/qZGa1vxOuFEUXMg4XWzlqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773464436; x=1773550836; bh=TuyeuCuEse8F0h+wPESLR+/3IpInBR360Fh
	a+woxwpI=; b=JsD0yPaJ0z3txcNfXX7Piio+0AwbpriYjlcclL7kidFrodNRo1r
	GBFQQY+7rXQkImDYsNJnRoyC7Nw1vkxY0AktYVdj/IZC2Z4tjW0pS434s0gzmbr7
	htmBTNqeL9ggYVb9V9V+OWfkjiV29bsYsx11jqKsCdzBYJGrZVcxYKsvQWdbCoFn
	dE7MIz2jx/xaCYO9drXn+hKIm5QKBrx38QOFK4/V3ahFwkk3E3BUJqr/+vKlrmYo
	Wyp2eN9y3Bfi9J0daC0gB1SL8mHPjjKYWG0iYJyakpiona9axLVtG2Wsw72BQB79
	7qyi/Tk97GTTRk1YDXXmQ10dnNqhKn4c3Kw==
X-ME-Sender: <xms:dOu0aRtVeTYiA1xMIFGKUDjODqvefa0CbZNkJwgxv-WBzElHocfjdg>
    <xme:dOu0aR521cT-Bp_p6xDe8G8os9CDb8zbO1DCRU2YJJPx5qWX9_6gX2hq9SsA9WiRF
    z95inGezkxQgGgOV9H000YoDMbAzjYfNKHhyolCvHiG7qVPVpGGZMM>
X-ME-Received: <xmr:dOu0aSJHKLPSyGIZL0G2WXWtIRep2tKWjTM10k0ATECA5pBAbJhkX2fDewQPzYZvL-03E6UAgDTOHxIjfrUobGXnWs0K9rVC2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleduieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhithgvshhhjhgujeehsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dOu0aR5ZMXB81XmqqWwzRGg7rEUKiNDtnSap_4XRrNhWCS-5yWJ7vA>
    <xmx:dOu0aVxhHbH1TfULqzJEFayZ3jcfCZOhi5jK1fGu23eoqTPY83H8FA>
    <xmx:dOu0aVadXGJ6vMjbtNc4FWPBt2kf7X64jnpgCAGOxsUhXUI6pPtGUw>
    <xmx:dOu0aXRL5SOEsA0sjN_h5b0Looeg2XxVwZUbLB12DFaC_5KkdkEE5Q>
    <xmx:dOu0ad6xSieFBYywYRLgYgPvE85nY368mvql15zr5QhE3M07vh2IZh3d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Mar 2026 01:00:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ritesh Singh Jadoun <riteshjd75@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] t/pack-refs-tests: use test_path_is_missing
In-Reply-To: <20260314034617.1261-1-riteshjd75@gmail.com> (Ritesh Singh
	Jadoun's message of "Sat, 14 Mar 2026 09:16:17 +0530")
References: <20260314034617.1261-1-riteshjd75@gmail.com>
Date: Fri, 13 Mar 2026 22:00:34 -0700
Message-ID: <xmqqfr63xax9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ritesh Singh Jadoun <riteshjd75@gmail.com> writes:

> The pack-refs tests currently use raw 'test -f' checks with negation.
> Update them to use Git's standard helper function test_path_is_missing
> for clearer failure reporting.
>
> Signed-off-by: Ritesh Singh Jadoun <riteshjd75@gmail.com>
> ---
>  t/pack-refs-tests.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

> diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
> index dca0c77ca1..3cc4906f05 100644
> --- a/t/pack-refs-tests.sh
> +++ b/t/pack-refs-tests.sh
> @@ -61,7 +61,7 @@ test_expect_success 'see if a branch still exists after git ${pack_refs} --prune
>  test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
>  	git branch f &&
>  	git ${pack_refs} --all --prune &&
> -	! test_path_is_file .git/refs/heads/f
> +	test_path_is_missing .git/refs/heads/f
>  '

This test in my tree looks like this:

        test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
                git branch f &&
                git ${pack_refs} --all --prune &&
                ! test -f .git/refs/heads/f
        '

No patch that turns this instance of "! test -f" into an incorrect
use of test_path_is_file helper, i.e., "!  test_path_is_file", has
ever been accepted to my tree.  Which means that this [v2] will not
apply to my tree.

I suspect that you have two patches on top of my tree, one is a
botched attempt that turns "! test -f" into "!  test_path_is_file",
and the other one is an "oops, the previous one was a bad change, so
fix it on top with another commit" that further changes it to
"test_path_is_missing", and we are looking only at the latter patch.

We however do not work that way around here.  Until a patch is
accepted and merged to the 'next' branch, updates are expected to
come as wholesale replacements.  See Documentation/SubmittingPatches.

Even though no developer is perfect, when you are presenting your
updated work, armed with wisdom borrowed from your reviewers'
comments on your earlier attempts, you are expected to take the
opportunity to pretend to have written a series of patches that are
perfect logical progression towards the final shape of the code
without detours, change of plans, and fixing earlier mistakes made
in the series.

The final series accepted by the project will have to stay in our
history for later developers to see in "git log" output to learn
from, and a series being clean logical progression is a must for
that to happen.

In this case, if what you have is indeed a pair of patches "one went
into a wrong direction, the next corrects the course", then you
would want to squash them into a single patch that turns "! test -f
.git/refs/heads/f" that is in my tree into an improved form that is
"test_path_is_missing".  And send that as the second attempt (v2).

See also

    https://lore.kernel.org/git/xmqq34283b12.fsf@gitster.g/

Thanks.


