Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FAB40DFAF
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149431; cv=none; b=U6oGl8rq9Rf0BnejNZ4YW5jIAKwO37XniotUcMOZPasDAvKuzNStRdsbZccxgmU+XJO4cp1DpMRvnl1gNvVc4DtXvsezAx/U+jriyskwEPLDTMGwFeqSr/VnMF6Y78iW91GBpnMp/fW7DtRrxlQUZK1AtrrSnCCvRWi26bXAzt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149431; c=relaxed/simple;
	bh=NnPR31PnLUsF+9wiasrxR5aPrtjUT2qoG7SwmS95T1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q6ogUVku1I6Jhn8QY9mvHVbjuSkUuMK1FOIKX2Rq/AqLP5VVqGcKAxuIZgY7D6IMb7XZpOtUw8VYV1UZDonLw5Hnj7qOydcErsC/6G95bjEYbq+PH1sW36TE08GVigzx7WRCsQnfkxyD0QHv3QpfF1EjkGQ8v2nUdddNmF4tUGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jx3k2KiS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WgbmnPqt; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jx3k2KiS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WgbmnPqt"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E6C52EC0591;
	Tue, 10 Mar 2026 09:30:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 10 Mar 2026 09:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773149429; x=1773235829; bh=oiwJ1aLB45
	vmpZyj/6yVyXzQRmRv15ou1fkO/rHbWX8=; b=Jx3k2KiS6lJtGf6pHT+rRA2wDx
	7NyPUqqW3ANCrcZlEXIr0n54GRL38gx3orQUavv/hf0UyK6vWf+LqFGiE2A3XwOi
	sWYhdZRpEhz3BJclKhRXym64HKL8VXx6BLDO5X9oaM0Szj7P2rrFfwKGzK3JylgG
	Y9vJYGSxxi8At6/wzJUl3thZSl/2/abd566WdFdYxxbS2fdFPE4LDhjHAbytgBh5
	G5GsL3c7FgP2EiV+1ORNuI2hbFx9V2MIuh7sK5mwbVfneve8PmaRkT3pg72wR5gE
	i/9ORIBzVg7CDhZxIj5/R6XXDQ80CGKSHpy+Cczct5bOFDr2X3wUhVf7qUpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773149429; x=1773235829; bh=oiwJ1aLB45vmpZyj/6yVyXzQRmRv15ou1fk
	O/rHbWX8=; b=WgbmnPqtweeF58DmYJ3so48L0loYX/05jQrmdiNRLOjf3YiZBV/
	oKisVgOjxcMnGyJl8tiiUqSKi26OgYk1xE3YEdPWP1vr4wdEJz3u7ggraAS5ElF6
	x55dyVp06IEdfZm0U3wxxfo+JOa/cnSJglddC7dLYxjuQ7bMwctMY64HJDG3pdNN
	qJgjMCUkH28LCt9mV7cRGdbSYw0WXzII4z6XxZIOfG9lcGkWHYOArfNnTq/usGZ3
	qyQdoWdFPbcdb4oEcwrNvQ4kQs+kksQRuY9fjRDTATk5HVnPG2cfhleGfyn/fjet
	77yY4ZR5ZlIn2TQMzvu1lW9x2GdXxHJIr7Q==
X-ME-Sender: <xms:9RywaRrSf9r8aq2uDqBLDMmEsqiGxVgv5P15a5BVoL5HktMXMhPzxw>
    <xme:9RywaaqRVn6Sj4PwvUjITvJTkxfAggTjsopj2RZMz8HMpOqrSSpmpDpip4T0HIeVs
    UnW-BPjjyvmX1qdCEYKlZ5toi9ocgi0T_xg9Ptzor1luz6_7Ef8Iw>
X-ME-Received: <xmr:9RywaTPPXLQ7SBhuk3gNNiVLyTLxuOsT5X-LjILxniyQQTAcxTV2pqmr7wtaWy8OQJYuY89guI9fFAYFq8L-mwkD9Ts47Z6f8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmrghnshhimhgrrghnuhekiedvjeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9RywabwY0EMKB9qVqIFrGvTiUwhT296rtOyiX2yh92P0ECIMVLJk7w>
    <xmx:9RywaculZFiJmEkOXYNFGjzxA2srHjTW-y_xp78DSnM066P5yzEjKQ>
    <xmx:9RywaU5HiT8MziRT3hoYqrhxNgsJdYIxmKASKzE7_maOXhqk2T48YA>
    <xmx:9RywabSDVkthlX2dcYuoQL0Kz5NAwxvj4YErj0evVRuPsxbUPnb2Nw>
    <xmx:9RywaSvTVIBC5zMZJGa46zo57QA53xuTcsRk_wo5YT7DrpM9Vx-7VTA3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 09:30:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Mansi Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Mansi Singh <mansimaanu8627@gmail.com>
Subject: Re: [PATCH] t7605: use test_path_is_file instead of test -f
In-Reply-To: <pull.2067.git.1773120813628.gitgitgadget@gmail.com> (Mansi Singh
	via GitGitGadget's message of "Tue, 10 Mar 2026 05:33:33 +0000")
References: <pull.2067.git.1773120813628.gitgitgadget@gmail.com>
Date: Tue, 10 Mar 2026 06:30:27 -0700
Message-ID: <xmqq7brjyfpo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Mansi Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

The e-mail header seems to imply you are "Mansi Singh".  Do you want
to be known to this community under that name, or just "Mansi"?

> From: Mansi <mansimaanu8627@gmail.com>
>
> Replace old-style 'test -f' path checks with the modern
> test_path_is_file helper in the merge_c1_to_c2_cmds block.
>
> The helper provides clearer failure messages and is the
> established convention in Git's test suite.

OK.

> These instances were found using:
>   grep -rn "test -[efd]" t/ --include="*.sh"

People seem to add the above paragraph to their test-path helper
patches, but unless the coverage of the work is fairly thorough and
you want to say "all the similar issues should be found with this
command and I addressed all of them", I do not see much point saying
how you found one of them and addressed it.

You could have used "git grep -e <pattern> -- t/\*.sh", or you could
have been working to fix something in t7605 and noticed these while
you were doing something else to the file.

I do not see it as too huge a deal and it is probably not a cause to
send in another iteration once it is already written, though.

> Signed-off-by: Mansi <mansimaanu8627@gmail.com>

No matter which name you pick, this should match the identity used
on your in-body "From:" header.  In this message you are using the
same "Mansi" with address, which is good, but see also
Documentation/SubmittingPatches::real-name section.

> diff --git a/t/t7605-merge-resolve.sh b/t/t7605-merge-resolve.sh
> index 5d56c38546..44de97a480 100755
> --- a/t/t7605-merge-resolve.sh
> +++ b/t/t7605-merge-resolve.sh
> @@ -34,9 +34,9 @@ merge_c1_to_c2_cmds='
>  	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
>  	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
>  	git diff --exit-code &&
> -	test -f c0.c &&
> -	test -f c1.c &&
> -	test -f c2.c &&
> +	test_path_is_file c0.c &&
> +	test_path_is_file c1.c &&
> +	test_path_is_file c2.c &&

The patch is quite straight-forward.  Good.

>  	test 3 = $(git ls-tree -r HEAD | wc -l) &&
>  	test 3 = $(git ls-files | wc -l)
>  '
>
> base-commit: d181b9354cf85b44455ce3ca9e6af0b9559e0ae2
