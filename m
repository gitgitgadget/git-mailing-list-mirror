Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C035BDC7
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573171; cv=none; b=irBvwcgNYrewScBQnTED7l+e9rwAUHh3HoIZlVw4YQ9tF4tCT0quohoFnur8tqFBmibUQCkE8mBNPOYP5Wg3j2ZmwbxfxhvV1EEgtZLoqiYDs9aTGmjqqm4wk6Chaof8HGVR60q7fI9apN74p/W1ipFnN1TF/xzkWAHMMI74g0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573171; c=relaxed/simple;
	bh=2qbzDsG/b8G7rMNfY2kJu9GtH4t9LlRMByZqcgwz+k0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hzBdOekmT751Zevqi9qYoOuj1usi/bj1Fned2rAdamLX0xjfsQI1fKZ7oLx9AFjIuPKU8xHDCMO7KnzhKatOmq+7vBZeFT7U93mcHxuhJVPFMmcAaIjdpupnRIz5GVA5Z6J+TEbhNmVN/KaVGnPUJ9J/AgtjRE4m0Som60bMCNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BB9CSEJz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZVFC4gaA; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BB9CSEJz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZVFC4gaA"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D3C9AEC064A;
	Tue,  3 Mar 2026 16:26:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 03 Mar 2026 16:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772573169; x=1772659569; bh=6SCXCGQoZm
	fYzR7fpJwFj3DZsLNFKL55kWw8vARyYQE=; b=BB9CSEJz88oHBicHZO9f/iHRx4
	64fW1Q1Da0mouJ6q8zW2O5v51pz7i831DbMEHV+UXRx0+dCg91NBtixTAAAqsbJV
	Fl9oZl7yEmOfDgWhsppx6J+fhnTt0zny5W1Qp8vHOsSTzRbCHA1ly1XPEkf/vCOi
	WkeoXNonB5qaXbtapwqbnbBGr82Aj4ECkQKmfRR6vePVJO9sRWqsuRdH4v6iWuJP
	2FFRcJLs4uABXe8/0JlBQZWihhsLhWGm5JWF6L7i9lHZGXnCTSKM5rY4zw3OR2/n
	VQxTlm5VOKFxI1uKc94LAhFRdPnfz0azPBeVhWlOoncJ3Kip8t/yqRe2bdkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772573169; x=1772659569; bh=6SCXCGQoZmfYzR7fpJwFj3DZsLNFKL55kWw
	8vARyYQE=; b=ZVFC4gaAsW2YRHPRCLU6VINyOu8cUbIjKp3y7dRn9WzuSLTjjZf
	1D4WBQh+t2fCC1K3m3JRhWbTGGIL1eS94q1XPO5fVhsVezRO3Jbi93/vX+yhSeLL
	X9DdvUbr4G4vBUdv/jDhVijKBrFMCiqz8XRK5sKV0YbKs3G1T1r1JemGUzjF86sb
	/9BiIj3yaRxZhYPWnOLuPAaYoxAZ68vzfDG1N8f3AcmsBOzV231IQkZl+mDQe6+z
	xtLO8MRGb+Oc9vqxEal9mIzWAksAlveD1nyorCscZe2OvHWQJpnlgO0uEzze0Ebc
	E8ol4FvBGRj8SvUTMEm7rB+Qz4OnLfogV/g==
X-ME-Sender: <xms:8VGnacU4bKs53olhyrvHhjJVz4CZ9caXOC4SWX4_g5HpRqbFtionRQ>
    <xme:8VGnaaqJ_rVTwC-Et7tFmaCQZnSdL1igxXCdzix08fWP9h6e1qDaDoex0zIBa6Pda
    Jlyuqh85UYEZlpfdDp3F5BCn50lwqrRE2rKtu0LPrxj7nmco72-QA>
X-ME-Received: <xmr:8VGnaQS1ofVK7IwtXdwsa6iVb3EuBzi0E1hsJQsJkTjNe7XAgomWssyEYws1jCI9YfJ7SIB9B0xvWaVcK5W9yJA4t9JfdKe_fA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopehnrghsshgvrhdrghhrrghinhgrfihisehoshhsrdhq
    uhgrlhgtohhmmhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8VGnac2llMRqJ0AMOcQe_H3iUMFpeUriiEdhw_B2r_qZHNN8klSuFw>
    <xmx:8VGnaUCEyXLvz4mUKtpSwja2Bl6kjdsa3QC79Pu5Kt1q88TbAZzh9A>
    <xmx:8VGnaQjth8werf9cU9zku4Rg0ge8RYbf9EzuGj50JQVZ6RD50ZorbQ>
    <xmx:8VGnaeOqc9B5APBjsXEsFALsgTrSIFK_8Fmlsd4VGv2nlw0iCu14gw>
    <xmx:8VGnaeolTNX3GWk_xDiAE-LYzx7u127Q_55oem3W30A1_U5Qsdi78-yK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 16:26:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v5] submodule: fetch missing objects from default remote
In-Reply-To: <2e62dc94-b821-4815-8dd2-f806580d2027@ramsayjones.plus.com>
	(Ramsay Jones's message of "Tue, 3 Mar 2026 20:47:02 +0000")
References: <20260301025327.3845292-1-nasser.grainawi@oss.qualcomm.com>
	<20260303200906.4118348-1-nasser.grainawi@oss.qualcomm.com>
	<2e62dc94-b821-4815-8dd2-f806580d2027@ramsayjones.plus.com>
Date: Tue, 03 Mar 2026 13:26:07 -0800
Message-ID: <xmqqms0obo5s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>   + diff -u expect_fetch_custom actual_fetch_warnings_removed
>   --- expect_fetch_custom 2026-03-03 20:35:13.949600802 +0000
>   +++ actual_fetch_warnings_removed       2026-03-03 20:35:14.150601532 +0000
>   @@ -4,9 +4,9 @@
>    Fetching submodule sub1/subdir/deepsubmodule
>    Fetching submodule submodule
>    Fetching submodule submodule/subdir/deepsubmodule
>   -From /home/ramsay/git/t/trash directory.t5526-fetch-submodules.stress-5/./sub1
>   - * branch            43c17d99ab9d4fcabf7107e36660b27113b54663 -> FETCH_HEAD
>   -Fetching submodule sub1/subdir/deepsubmodule
>    From /home/ramsay/git/t/trash directory.t5526-fetch-submodules.stress-5/submodule
>     * branch            e38933e027ee8a2000f603124aa899302a09a51f -> FETCH_HEAD
>    Fetching submodule submodule/subdir/deepsubmodule
>   +From /home/ramsay/git/t/trash directory.t5526-fetch-submodules.stress-5/./sub1
>   + * branch            43c17d99ab9d4fcabf7107e36660b27113b54663 -> FETCH_HEAD
>   +Fetching submodule sub1/subdir/deepsubmodule
>   error: last command exited with $?=1
>   not ok 44 - fetch new submodule commits on-demand outside standard refspec with custom remote name
>
>   ...
>
>   $ 
>
> From which I guess that the order of the output is somewhat unpredictable.
>
> Also, other test files in that patch didn't fail for me with 'make test', but it
> could be possible that they are also flaky. I didn't look.

Ah, looks like the command tries to fetch from multiple places in
parallel and it is up to the luck which one reports its result
first?  We probably do not want such a "human readable progress
output should look exactly like this" test.

Thanks for reporting.
