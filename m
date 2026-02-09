Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD5B37756C
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647288; cv=none; b=aumHCofHQHuXM8Vi+XHfzg62HE8TJGPwyDwPqmD4s3YLxtDi+bC1dRjo0AbDqZUeNhOm1iTFj4mOmgb34KrwPnarZQiCOs/EIMEBkpx7sUUh457CI49W2zqFkt5ChaTMPpFc0xDogFvAmJtCwnaCCaGY/5a7VNYv1lpFgA9YsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647288; c=relaxed/simple;
	bh=m5Db/OAuUGbcn7tN8XdLvz+KLPEce8xXYt839kL2pQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJLqMnt3bmpKB/1AzQ0GCG3sfwGss7POyfgwyQ/YTv9Whp5cGOZG09iHJQrJyzdvQiBrzc2HfhAH17yqX78nrZWMtjtFwM6KjkTaKZxGO76IuSmODdUh9aI/balkGJMHNPX79o7Qm1F4Nk7MI72z4kRJajLN0Auun/BqnS5u8Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iL4biMhY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=phSoaxHr; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iL4biMhY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="phSoaxHr"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 589AC7A01D4;
	Mon,  9 Feb 2026 09:28:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 09 Feb 2026 09:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770647287; x=1770733687; bh=lK6ryOWldk
	m/IkLjs1Wp8ZU9/Zj2zU7Mw7zRfJPzHvI=; b=iL4biMhYhx4d+YYAmy/dpuhP99
	dWW4OtZbPkVnLKVF1eD5c3fL8GktGOOpi0va79QctQu28zC57zjbHp3PKQqcJTik
	ZugIKJlNgXpyquzqVRbzwi7OQN0EENIaBjIRdjnzwzcUOXB5I14e0FFoUQ50fs9w
	O1vXR1M/8VCat2zEbwLx8oCPvtYDOi2L6A+AbGze46a8Cf2lmwra2oW9DVqOzUL+
	TfdC0XC7sIsq2QvFnUFiPGUJQjsUkzjCut9lEuaII1uGXZnZDZspwfeJLAM7HqLr
	46XMlz6EZCORfVnPN4p3wx8XLnoTVvbGubPQd6ooZ0A81/n0k4nz+RxvF3Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770647287; x=1770733687; bh=lK6ryOWldkm/IkLjs1Wp8ZU9/Zj2zU7Mw7z
	RfJPzHvI=; b=phSoaxHryKKqRtYGmBMrcPa+PDb/06UZkp2MTuTxV+Wv9H5074B
	5WCdDRvFpNA8XeNVkHBoiPiu76rDve4BEUpYEzo+X8VIhvHhpBS2sOj1Zf4ORXss
	WB8KxLFBmKyTUxppz69zKEwKutUMp2T8zSWayRIqv2pJU++De6emx1RVBz4zkBF0
	yLjW0OgaNxNA+952eIBLeCKD/v+L9muDJgv2h+Q0tZXk0Y3vWUHBirTVL62rACPM
	WKcdBLlkMnAlhz7adEFyjtdLh318bJhdgCmR+cX8hgTRIMlTAcktcQBWuXxdQQce
	fmxkaeQtTD8NqfkA7LnFgOwGZYQ/16SCHSQ==
X-ME-Sender: <xms:9-6JacoSAL_ZawFvItNQ8nd4x5vnUFa1uTmvnoK9foC2AzYQ2w3_dw>
    <xme:9-6JaU6A7-Dg3Uqm6FmMMQrULs3rE2UAsGP-mEjw7haf57Mz8Jc7R2qgBTGa6NUTT
    KO8nHXKppzoELdunLTT3DBKuBG0m-jDxW-u7bz0cBagQjRXMEQl3A>
X-ME-Received: <xmr:9-6JaTeRa8rChEA-Sqkhzb-cdx7avOgSiTpY517kCQsTcQ8HbsdwhSi09AQZ6Z4Da-tuYbvmHu52T3HY7Ty-itJYoePc6m4REGtrPr2X7ZU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoh
    epshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegvmhhilhihshhh
    rghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:9-6JaZ6sp_MpZUIXliQWrTIzYLh9Nn7-APZ9JurYZw9wCrD8jU_e6Q>
    <xmx:9-6JaatH19CjFl5H1bNsFG93H3soQy23IPvQ200XV2kQz8VxV8rHaw>
    <xmx:9-6JaZiF_gMW6XvvLAG3zpX3ukNNmMHxoVQc7VQXd3w9RUK05sScnQ>
    <xmx:9-6JaVrNX8upFVZLNs0arYJpL98kIA0WNMci3h9gK-kEMBkNB3Yfsg>
    <xmx:9-6Jaes0E-JG9sexzKYvY0f7meFRAIlcQgvzBqSm2Lch0fQlXUqRIagK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 09:28:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f21f7b23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 14:28:05 +0000 (UTC)
Date: Mon, 9 Feb 2026 15:28:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 2/4] hook: introduce "git hook list"
Message-ID: <aYnu8ltBUUflVgm2@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260204165126.1548805-3-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204165126.1548805-3-adrian.ratiu@collabora.com>

On Wed, Feb 04, 2026 at 06:51:24PM +0200, Adrian Ratiu wrote:
> From: Emily Shaffer <emilyshaffer@google.com>
> 
> If more than one hook will be run, it may be useful to see a list of
> which hooks should be run. At very least, it will be useful for us to
> test the semantics of multihooks ourselves.
> 
> For now, only list the hooks which will run in the order they will run
> in; later, it might be useful to include more information like where the
> hooks were configured and whether or not they will run.

I think the commit message could be adapted a bit again to first explain
the problem we're about to solve.

> diff --git a/builtin/hook.c b/builtin/hook.c
> index 7afec380d2..4cc6dac45a 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -20,6 +24,54 @@ static const char * const builtin_hook_run_usage[] = {
>  	NULL
>  };
>  
> +static const char *const builtin_hook_list_usage[] = {
> +	BUILTIN_HOOK_LIST_USAGE,
> +	NULL
> +};
> +

This constant can be declared inside `list()`.

> +static int list(int argc, const char **argv, const char *prefix,
> +		 struct repository *repo UNUSED)
> +{
> +	struct string_list *head;
> +	struct string_list_item *item;
> +	const char *hookname = NULL;
> +	int ret = 0;
> +
> +	struct option list_options[] = {
> +		OPT_END(),
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, list_options,
> +			     builtin_hook_list_usage, 0);
> +
> +	/*
> +	 * The only unnamed argument provided should be the hook-name; if we add
> +	 * arguments later they probably should be caught by parse_options.
> +	 */
> +	if (argc != 1)
> +		usage_msg_opt(_("You must specify a hook event name to list."),
> +			      builtin_hook_list_usage, list_options);
> +
> +	hookname = argv[0];
> +
> +	head = list_hooks(the_repository, hookname);

We can use the `repo` parameter instead. The git-hook(1) command is
declared with `RUN_SETUP`, so it will always be set.

> +	if (!head->nr) {
> +		ret = 1; /* no hooks found */
> +		goto cleanup;
> +	}

Do we want to print an error message in this case?

> +	for_each_string_list_item(item, head) {
> +		printf("%s\n", *item->string ? item->string
> +			     : _("hook from hookdir"));
> +	}

This is another case where we could avoid special-casing if the string
list contained the hook paths.

I also wonder whether we should add a "-z" mode to NUL-terminate the
output. In theory, hooks may be configured with a newline in their path.
Probably not all that common, but somehow special cases like this always
end up being encountered eventually.

> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index ed28a2fadb..d2d4a8760c 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -10,6 +10,8 @@ test_expect_success 'git hook usage' '
>  	test_expect_code 129 git hook run &&
>  	test_expect_code 129 git hook run -h &&
>  	test_expect_code 129 git hook run --unknown 2>err &&
> +	test_expect_code 129 git hook list &&
> +	test_expect_code 129 git hook list -h &&
>  	grep "unknown option" err
>  '

Shouldn't we also have some tests that show that this is working as
expected with a configured hook in ".git/hooks"?

Patrick
