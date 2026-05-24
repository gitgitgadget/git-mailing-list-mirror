Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3765637F8C3
	for <git@vger.kernel.org>; Sun, 24 May 2026 22:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779663098; cv=none; b=SgI60Y4BVOXNIP8HxohWnp5196stvUaUiXpXnP8qqO7SfpacZ6svbQfl7zLIYSq3LMMK2d+EEh3c/bbfDUeSDA8AVNGp7mYKU7pgzkg4GILXAz5xXg/xY4fbusyT5nujHoFd7emPckTQQGqEW0Dod792UkzjiqEWEz4DfYe6Yzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779663098; c=relaxed/simple;
	bh=DijATmOSq6dEibqQPcWnZHFVWrg+LZuRrPLA/J5/b5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GIH40XISeCNU4wXy7e5kXQfHGRxSbiD2J3VWhBPsu9DEUYRw2vUmC+aOGzUE/1V3RS4MiuGoUJhaic6AY8Zg8IdQ+1MC4YcT+zDtRGQJG6kjnANEt3tJ+XR62OULuzldllzGaRiRSPTrLlUBRdB7zt9RD/mNJYxDG0cK/kpNCV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N4uNEmOZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dL3XZvgk; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N4uNEmOZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dL3XZvgk"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 489E7140003C;
	Sun, 24 May 2026 18:51:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 24 May 2026 18:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779663093; x=1779749493; bh=hQnTrif0Gu
	x/iXbqaQW/sbRsCdqBCSEqsCJYkIUPSRw=; b=N4uNEmOZ50ucroB4ka1022AC5J
	feCbqwm+wPJY6oB3+256kFrYQX11MJB5XPIYwM6yr/kskO2PJG5ZfsZrhNzd4/rd
	u50jirJHuOGm7OAufAIXPGH5kieX+pJZodb8yv2sp36/4AFUbT9dkddL0/Esl5fw
	Il5wCOm6HTufiS0kGAv4cZ7LsIvVUHjixpzFJh+wu8cRvMttTEmZMoZztqcT1gJn
	O52VJ2dTNKdbdhpsluUtjWUKXqV45zaugqMdPNGxa11XGlrouslSy7DRyLKrJnG0
	J42TIzUuGVS1E5VdcvW/iVM+fHpFMvc40S4s1EJpqm+w6GExJcajsyDw5pig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779663093; x=1779749493; bh=hQnTrif0Gux/iXbqaQW/sbRsCdqBCSEqsCJ
	YkIUPSRw=; b=dL3XZvgk/Uy/VB3csNCjFtF+oI6PQoule0oxpmEyJM9RT1+Va4d
	1Q3usSSeEKlbbO3/6SQDnomdX3t/mOl4U5zlp1cSNgRdCJFr/eXnP1bYVkjLgq5+
	LsLVdIw5qBuBZ2dvD8OH5baO2lQOGCRmDHd0o8VhFfI+iuXY1f1iEuaDRsZ0LTYo
	S1CcsoQ0C2ov0IiRZTL3mJG8w+cz8VqZT4R49LdqnLWo5wOayZn414nnDReATMkC
	SeH9hsFzNYhYsSCx4DNr9AQ5bHAP0LJj1sz/z7AfJOIi81LQds+/st3JT8asdKa7
	0cA53JH/iXxawz0ua847kW2pFcgA2J2H5Qw==
X-ME-Sender: <xms:9YATautkuLBICRY-Dm8ChNSP0lQqJxNr2GnQ4UNflxopz6Ie2fpP6w>
    <xme:9YATaqfaAB8nfwhSvGTKbFh6b1zBzs7FrFbtuJw0_-Of_txHiSQpw-TgyjCzNBiXW
    QzSzv9kTRvo05_kiCOIV2Tvsg1pj4B0ZRnuf_4FrINYX0q_zb54ChY>
X-ME-Received: <xmr:9YATauwwrcnOeNEIgKsWzxgmQoEuHHw_JxNj41Xklz6pPjIoosWewMKsKVIkpiqBfeCr0lDUOCgiOoIQUnJWYiCZZEBZqwyEVwfi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheejudekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:9YATaoHqYRObh_ECT7m6B_AqnZiKl3CCzH_ap7Deu7G3hDdMNYRn9A>
    <xmx:9YATaqz0jfMSC6ShYW8YJRzbGuG54ET2kFvKl8NBJrA5jJV-DH-qsg>
    <xmx:9YATahsDakK7l_RUdGJ84Dav2Tycgi9tRKyRgXUnj7YbTVGWpd0fmQ>
    <xmx:9YATav2nvFTJgmBA3XQV9JqSEVxFWBRvMfaf-PN43L4ZKNbez9jL8Q>
    <xmx:9YATaovjLf68WxTQHbdYh9IbreKyBU7EeICPa2NycspvL83VGkWMoniT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 May 2026 18:51:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/2] t1092: test 'git restore' with sparse index
In-Reply-To: <7c56d038307d54929d9eaa9b8cb3cf26af181702.1779644412.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Sun, 24 May 2026
	17:40:11 +0000")
References: <pull.2121.git.1779644412.gitgitgadget@gmail.com>
	<7c56d038307d54929d9eaa9b8cb3cf26af181702.1779644412.git.gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 07:51:31 +0900
Message-ID: <xmqqzf1oh158.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> A user reported that 'git restore --staged .' causes the sparse index to
> expand. This is somewhat natural because the '.' pathspec means 'check
> every path'. However, the restore will not update paths marked with the
> SKIP_WORKTREE bit, so we shouldn't need to process such entries.

Interesting.  So, ideally we should be able to say "we are doing
everything because the user gave us '.' from the top level of the
working tree, so let's see each entry and decide what to do.  Ah we
have this tree entry in this sparse index, and that is outside the
directories we are dealing with in this working tree that is
sparsely checked out, so we would skip", and for that we have no
need to expand the index.  But in reality, what happens is "OK, '.'
so we need to deal with everything. Let's expand.", which would
break the contents of such a "skipped" tree out to constituent
paths, all of which inherits the SKIP_WORKTREE bit to tell us that
these paths are outside the directories we are dealing with".

The end result in the working tree should be the same, but we
unnecessarily expand the index.  Correctness wins with a room for
improvement in the performance, which is what we want to see and
then improve ;-)  Nice.

> For now, establish the current behavior, including the sparse index
> expansion, in the t1092 test case as a baseline.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 50 ++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index d98cb4ac11..d69434e7ab 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2573,4 +2573,54 @@ test_expect_success 'sparse-index is not expanded: merge-ours' '
>  	ensure_not_expanded merge -s ours merge-right
>  '
>  
> +test_expect_success 'restore --staged with sparse definition' '
> +	init_repos &&
> +
> +	# Stage changes within the sparse definition
> +	test_all_match git checkout -b restore-staged-1 base &&
> +	test_all_match git reset --soft update-deep &&
> +	test_all_match git restore --staged . &&
> +	test_all_match git status --porcelain=v2 &&
> +	test_all_match git diff --cached
> +'
> +
> +test_expect_success 'restore --staged with outside sparse definition' '
> +	init_repos &&
> +
> +	# Stage changes that include paths outside the sparse definition.
> +	# Although the working tree differs between full and sparse checkouts
> +	# after restore, the state of the index should be the same.
> +	test_all_match git checkout -b restore-staged-2 base &&
> +	test_all_match git reset --soft update-folder1 &&
> +	test_sparse_match git restore --staged . &&
> +	git -C full-checkout restore --staged . &&
> +	test_all_match git ls-files -s -- folder1 &&
> +	test_all_match git diff --cached -- folder1
> +'
> +
> +test_expect_success 'restore --staged with wildcards' '
> +	init_repos &&
> +
> +	test_all_match git checkout -b restore-staged-3 base &&
> +	test_all_match git reset --soft update-deep &&
> +	test_all_match git restore --staged "deep/*" &&
> +	test_all_match git status --porcelain=v2 &&
> +	test_all_match git diff --cached
> +'
> +
> +test_expect_success 'sparse-index is expanded: restore --staged' '
> +	init_repos &&
> +
> +	git -C sparse-index checkout -b restore-staged-exp base &&
> +	git -C sparse-index reset --soft update-folder1 &&
> +	ensure_expanded restore --staged .
> +'
> +
> +test_expect_success 'sparse-index is expanded: restore --source --staged' '
> +	init_repos &&
> +
> +	git -C sparse-index checkout -b restore-source-staged base &&
> +	ensure_expanded restore --source update-folder1 --staged .
> +'
> +
>  test_done
