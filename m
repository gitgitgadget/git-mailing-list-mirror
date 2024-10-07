Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF51BB686
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296923; cv=none; b=YE7Slp1J27/lCtxUj4N1sXayInK37dsOUAXxkze3C455vunlFMvon7EyWjwi5ELMrxgZRHgJEw0mKo18pjsgLFF5yIZ6yb9AN8fvAwaoD5VlSOeeVJGfT/fepXAoLkxNu/WZ8WjYpPfnjcKFg2eQ01Ts4nU4KfsEG99cdXwDvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296923; c=relaxed/simple;
	bh=uRKphCs05eo186bpDotKfja6HVqdW1dgxAfhRVA8ts4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyPwm1GOEd1ART2+zRAsUmbmqnJStqJQ8g1RJZYQLOOHlwwbvzpXIa1fggOMAfCQoIloMiPMB/aGmTi36xz8d7XNnUr9taHPaXlZ87h2uIkWdIeRsFd1NyiFumEKgZqnYGwZklZkzDbCIlYSOLz7fojzAEjlTXnTR3UpONhCsr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TEUbAqOe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aJ+cvfnE; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TEUbAqOe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aJ+cvfnE"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 6230911400DE;
	Mon,  7 Oct 2024 06:28:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 07 Oct 2024 06:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728296921; x=1728383321; bh=ceC1/SYjKw
	Z4K3OepHgoSO+AOKLtatVQwRewikzszQE=; b=TEUbAqOe54Cn1RKn5QgcSfUxvK
	0EZX7tdHmfEn95FETigxYMevfkmWgK8iZ/WVQFUufXmIfRGO+yE4x+/HCEMUg+35
	3IGxafZT5z8ZR8B4BK12o3ImtWEu0rBLh05p61DoyeZuqfIbU3jEvwiXvPG2qH5r
	rk1pkoVH54cyQINmpF+sopY7K4isfRKxW5h10PFmkS78enoYjkfXBgt8IlOWBsaW
	0WpjcNX+DuoVPnFQC8o+OKgqedINqVAjx1MLIPPJj8zF+X7+YMqZv0nPODh5gknq
	8g91r3YGjv35ha00lEWL+lZK+wqkv2oyO9sRrnNgatIE4+wo96W/6zsHEzhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728296921; x=1728383321; bh=ceC1/SYjKwZ4K3OepHgoSO+AOKLt
	atVQwRewikzszQE=; b=aJ+cvfnE8lZMXneS0rmf/51/nCBtL/1CeONQE/UdQxKg
	WPeuATy6LSQG7gxUy+hBSoP14fd0RLS/mSMd0kCZjlWKg2wmX+2l7Xsl7iHy3rkw
	2iwXb2uh5lF8AbKjCh1nQE144L+rgby3Zluea5BzbkIzsVkeQGccMv9Yu06Ozemt
	xIdweUReK459mNO6R6S7EUxqLRAWnBKAwqsUZZS0tmwU+E4c/JEA7cvkYiGlmDo8
	ZJgAGIvd+S79z4ugflGgD2u6y2hmzUeEojl8LKha5ubjS10GqHU14X34Xvym8T+m
	GFXR9jXgHHcv9CILWEHHy9JfF47o0KfgUD973uF6bw==
X-ME-Sender: <xms:2bcDZzbIqmwaQMeY5vGMTBaqnSb6A43oNVVhFrq8WBH181mvmihcag>
    <xme:2bcDZybfVWLnoeoGhdc9WSUERMrSbtlzGO6dkSiWeZn87l_v2bdcBpxkXpjoZRmSv
    0CCyj_eKkdip0thSg>
X-ME-Received: <xmr:2bcDZ19_dKf4yyp-XCfRoyc5afYofSp34qyP0TEhjCY5byKRJpjvA97QdIHNdNEf8CJYMhp23QgQPm8HRYTCWsE_RmDuhPihAuh2mAFpQsJ5NbWZPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2bcDZ5oBgQkjQvNZIcrs0S2V4WCuF_jHCTMT4JNr74XvFBWfbu95ig>
    <xmx:2bcDZ-rOmTVA9B5tmICnQPRm2DVz5SZatGSMOcgWhnz1kFeWyGGcpg>
    <xmx:2bcDZ_TxAS-wLanLN7wZCgRAkDO2hi0k1eqpK2LtdttmxhY7NTtauw>
    <xmx:2bcDZ2rOwtpgeAH8weTVsNpsDuRzLhzov3jiMB_DOI9wJyBuKtAhLw>
    <xmx:2bcDZxUic662fcw-kQjIPmKcwxg8qo09zQPQmT7WgezWKRzfyTXA7zZg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 06:28:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 032f0b3a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 10:27:40 +0000 (UTC)
Date: Mon, 7 Oct 2024 12:28:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v4 2/2] [Outreachy][Patch v1] t3404: employing
 test_line_count() to replace test
Message-ID: <ZwO30-cFO9w3frca@pks.im>
References: <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
 <pull.1805.v4.git.git.1728296531.gitgitgadget@gmail.com>
 <864b00997b725dbd7f3bea06391570df7d428f3b.1728296531.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864b00997b725dbd7f3bea06391570df7d428f3b.1728296531.git.gitgitgadget@gmail.com>

On Mon, Oct 07, 2024 at 10:22:11AM +0000, Usman Akinyemi via GitGitGadget wrote:

The title of this commit still has the "[Outreachy][Patch v1]" prefix
that you likely want to remove.

> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> 
> Refactor t3404 to replace instances of `test` with `test_line_count()`
> for checking line counts. This improves readability and aligns with Git's
> current test practices.
> 
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> 
> removed test

I think this line got here by accident :)

> ---
>  t/t3404-rebase-interactive.sh | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 96a65783c47..81f984f4cf5 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -281,7 +281,8 @@ test_expect_success 'stop on conflicting pick' '
>  	test_cmp expect2 file1 &&
>  	test "$(git diff --name-status |
>  		sed -n -e "/^U/s/^U[^a-z]*//p")" = file1 &&
> -	test 4 = $(grep -v "^#" < .git/rebase-merge/done | wc -l) &&
> +	grep -v "^#" < .git/rebase-merge/done > actual &&

We do not use a space after redirects, so this should be
"<.git/rebase-merge/done" and ">actual".

Other than that this patch looks good to me, thanks!

Patrick
