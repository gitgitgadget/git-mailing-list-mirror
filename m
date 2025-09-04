Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C3F319861
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010477; cv=none; b=pTJ1HRZ9XOfwrVzaeM7Be9pMWCEs1e2tnO3OkdtaespB+GQSHYHKDP3eC5z3wcYYARW9EcfKFPQn4yE7hmn4qH8mVWX2YZtOn/Wp0DPbKeNLrg5mFsLZCg/AShhu/UTX4kGK41b89uB8b8pG/mf7tAxJJrtpnQcwTyspXEPWmNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010477; c=relaxed/simple;
	bh=xAPDKijVti0c/r2qXP57+aqtWyAcM+ROBc3e9lgLaWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pdTtkBuIKA6v/QHxSfQTu6vfY1kKBFF4tB/aSECg5mIONvGrc1MlMYWxrYCxKt7ux7frAILS+4tOpJUjxt7YHX8PPo/CK3d7IhD+zUDC9LiF9OiL3Y0nM1U9/gs8PNGf0jVOlGgyZMo3u7vdHE/Jxhq25IoYHvHNWAfBbb/4KAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UiU9jO7R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DuOxiscs; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UiU9jO7R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DuOxiscs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D69BE7A0436;
	Thu,  4 Sep 2025 14:27:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 04 Sep 2025 14:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757010473; x=1757096873; bh=CL75fdqvZ5
	t8dkyWZwLxrv2u2zJDvcp5MeiTMWcFfG8=; b=UiU9jO7Rn/NQTUi10jMy3ZJAf3
	ndxaA7JO1KMkKP761k+6BYOGSAyh0AP6YUhvJL8IxutvGJwgI1E41JHPhOBO94NT
	CSV8Da+P4ghwUH6NaKoHXynuqLPqYObhLMmVTly458Q+KXd6kJDkCRJtd++WMaOb
	ytFHnDkMsx9zWmEHj3Q1v5Os2QbhqlYm1UYxO0R0Z+imn/0HzOmu2pHf/L5y2QN0
	qfY/ZWBXhhZImqbI+X30mDEKDoxpiSEy1qClefcHdOXHN4kne+Wp6vo/1iEQ30DV
	OaFrBqnTZgsyvI9V1WNLersM8k7w+ScbNmr6hKVfXoWydTnc0BG8Y5z5eJ8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757010473; x=1757096873; bh=CL75fdqvZ5t8dkyWZwLxrv2u2zJDvcp5Mei
	TMWcFfG8=; b=DuOxiscsaYZ6zeGYqiO9NfWQ1Mu+AklgxQd9sm6sn5Y/xVSJm/k
	QaqjKyJKD79EKTh6nB8G2h2xwiRfmx98MPnEp19n9cA994F0hj20o4GwB2F2NV3p
	vZkCg0PoBO+BdhxpqZ0xE9WIFkFynAUSsamYMPqdyyA5qXG/w82zKcsghS/EYbbH
	svobrKsAknRYQsOllbQy4d38uQCWMlGx0UpbWhuzjqPeKJuzY/g3FUD0tBax3Ugn
	AfZF4Fzv2ikQR7W16zQmMSOmZbNAapipAe/BcbCUMp7jTbAvWFDug+KbNsVUqlnr
	LWuxId/Xebxl8JrvEj1inSQpZhYZJktbn9Q==
X-ME-Sender: <xms:Kdq5aB2WZIhBxdoLDgeUGxzwYiYas4xxvb3AElWea8JGL9uCgI-vyw>
    <xme:Kdq5aAhTMUPDItiMZ-FzBpkzt0WaE2phedIFevFaF6aBtTDA845T55k-YwXtv95Q9
    zIpbYYjzxO_Dm8W8Q>
X-ME-Received: <xmr:Kdq5aCX65kvaDLm6FOvxorCilXXcaAIDsTK-V8MpvaE6GfKLwYlfN0180HveevSTepOVQXkiLued2g2j65SshoAJ8bCzfyTeQkI9ZyI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoh
    ephhhurghnghhsvghnfeeiheesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Kdq5aPWOp-yB5L7GfW_xP-jptvFyPwIRMXNothCYtQRMYMpQcyZyuQ>
    <xmx:Kdq5aCgb1Bxcn9DN6Ic4oEZYcJyTEHc1QlhQtVbICN_2tgRLC_ZQow>
    <xmx:Kdq5aKb2nZ3Ib_E-qP67U9L5Z4AK-NvHvXhx3GXHkzc2M7dwRlSpSQ>
    <xmx:Kdq5aPossVsSVOddEx31bO76s2o7Jh2tX3SC8PIlxgGNcgRqHLII-Q>
    <xmx:Kdq5aIUjWx3RGB8ISaHlhG81h5jNqANXcue2y62zb_p2Ud2slz_zQnJ3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 14:27:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Wing Huang <huangsen365@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 3/4] t9902: switch default branch name to main
In-Reply-To: <f1bf01e13226cf3f6ca0e811123278248e4eea6d.1756992089.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 4 Sep 2025 14:21:31 +0100")
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
	<cover.1756992089.git.phillip.wood@dunelm.org.uk>
	<f1bf01e13226cf3f6ca0e811123278248e4eea6d.1756992089.git.phillip.wood@dunelm.org.uk>
Date: Thu, 04 Sep 2025 11:27:51 -0700
Message-ID: <xmqqfrd28448.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Remove the penultimate use of "GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=
> main" in our test suite. We have slowly been removing these ever since

s|main|master|, probably?

> we started to switch the default branch name used in tests to "main".
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  t/t9902-completion.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 6650d33fba6..964e1f15693 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -11,9 +11,9 @@ test_description='test bash completion'
>  # untraceable with such ancient Bash versions.
>  test_untraceable=UnfortunatelyYes
>  
> -# Override environment and always use master for the default initial branch
> +# Override environment and always use main for the default initial branch
>  # name for these tests, so that rev completion candidates are as expected.
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./lib-bash.sh
> @@ -1453,7 +1453,7 @@ test_expect_success 'git bisect - start subcommand arguments before double-dash
>  		HEAD Z
>  		final Z
>  		initial Z
> -		master Z
> +		main Z
>  		EOF
>  	)
>  '
