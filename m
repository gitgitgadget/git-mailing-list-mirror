Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44DBDDC3
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 20:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744663293; cv=none; b=R2hVQNWk7EdO+c+JlbA0DyyOD61zW0DJVNGxTromTTnakIf4ZOQnSWQ+l+npjDXT26JXrih4ETngb51bhKFCnteAKI7dZ3anI5gTwUs6pHoosrfyv46XQnt/uExQVOKOplO3lzfQ6QZEDd2tU6Unu0jID9BQUmB0IjvDP2L2k5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744663293; c=relaxed/simple;
	bh=LemveEJC7C1Pj3t3DfMcY0+EoKlLhx8MxG5NgcSK9iU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EsRHR7fLoHy4MuDr5ivHP+6Aedjq4fW/AU05YHpSkI2u/dZVE0sUw9BpB1XmKLBUiYYBMiail74tLCC9l1zgo4Nb6RUFL/mrhZ08JCUttxGYejb6EGCEVJGhDsWL+hGb80pC5x/mWCKaN5ICg4zso4WBUkEVwj9RvRpQP3i9/d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tfsairF2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uRwKskYc; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tfsairF2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uRwKskYc"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A2428114020C;
	Mon, 14 Apr 2025 16:41:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 14 Apr 2025 16:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744663289; x=1744749689; bh=2jpnUUWWa0
	6uTuQCglmONekdvCaErCjMJalLVGkV7NY=; b=tfsairF2Kg3/fFSbJYtlnOSsxS
	kRE7xIp9vQ7uOExB2pqboYMotuq90QsHYsVVwMDezuLqN8hw1V9NScMlEfhScxaR
	zG56cocb97RnmHb/ZoIJyK8P7G9wJKGOwbjnyM+nRl3/KKEoXebeGoK6UxN8Lyvs
	1aOAo3lZ9lBSeRsg9/xB7Bvr09W98p7KA2Aj+GYS2AbS1rFzESsc6XE1XI1oIuwf
	7vURAW7AXCY97OFgVgV0MiRMMZedxu0oWpATYXyoH4N568U26NE5P9MM7lwlrv8G
	Vx/lTRFqI5DEJXTQMS/+P+a/7mV8IB5kt3BvUHu0ZGGnYwpz4DNBCtFxOScQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744663289; x=1744749689; bh=2jpnUUWWa06uTuQCglmONekdvCaErCjMJal
	LVGkV7NY=; b=uRwKskYct3v9ZDbURa0Qskf0ti7tecYymHdFL0y+y8uFobufVR5
	49BHr7kuuzHH3eza2KuzRCy2aV7+y3aq8V9rt+Pj1bfkIOtcXvO4Vc1AkF16UidA
	V+IO9t+Q9gTVx6KZHQ87ANmjwdsQpoRipsHgGnsMmB+Lym3L+BdJ/CVGJAUq0of8
	O/ailmlDE4+12b3SEYvyLeaRqn8JjX+m1j1BYItrv/EdgUgsx6Wm9Cqqwf5GvZii
	x+LHA8FwYaTngHzHPGGq4uzQr7BWSRmZrsk727t9mM0IgKQ4PjkiJOGRsRdkToaN
	HYkL5J0XdjgZVi2EtPQSAjCC8U4FMM1Hmfw==
X-ME-Sender: <xms:-XL9Z_z8j8-Hb0SaESi4AUsU_Dl9lfgjxnt_UoYWj950ECh2lZgVfw>
    <xme:-XL9Z3Q738U8wc29_AkSSGkcW-fLpg2LoSJnnfXDlObFOqXYFLBI0V8LUJiHsPd-u
    86nf2A4j6fL2wWbBg>
X-ME-Received: <xmr:-XL9Z5Xgxi23kzLdLV1tN_aVdSMhP43A3uN9IXFwwKpRnDdfNzYScdprZefMQp5VPDQzMtdOtBAyZ1X4STIfJm5c9l1NhCUzqiib>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdduheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-XL9Z5jpsq8rAfszX_vbeICb7tjMA7EPdAJ_tfAGsItCzSgd3t1MXA>
    <xmx:-XL9ZxDKb_GCYQulF6_rdda_yT_2WCvO-dPDoLcjSOqPHu5qMqm7Kw>
    <xmx:-XL9ZyIFyuP6gUvzjLA7z34woQ3_BqLI_YiA7Tp8AH6eROqWi8tFNw>
    <xmx:-XL9ZwBNlidS5KYwHQt37Yp_2QgvwFgV3vHYBXLS9SojE4f7s5u7WA>
    <xmx:-XL9Z_0q7_z_Q9cZWwQZh_74O3SFPBHBp0pRaNKsaMFQgJkQ2z52i9vh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 16:41:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v2 1/8] pack-objects: use standard option
 incompatibility functions
In-Reply-To: <65bc7e46309712e06a2d743172ea4ec518ee928f.1744661167.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 14 Apr 2025 16:06:11 -0400")
References: <cover.1744413969.git.me@ttaylorr.com>
	<cover.1744661167.git.me@ttaylorr.com>
	<65bc7e46309712e06a2d743172ea4ec518ee928f.1744661167.git.me@ttaylorr.com>
Date: Mon, 14 Apr 2025 13:41:27 -0700
Message-ID: <xmqqwmbmpjbc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> pack-objects has a handful of explicit checks for pairs of command-line
> options which are mutually incompatible. Many of these pre-date
> a699367bb8 (i18n: factorize more 'incompatible options' messages,
> 2022-01-31).
>
> Convert the explicit checks into die_for_incompatible_opt2() calls,
> which simplifies the implementation and standardizes pack-objects'
> output when given incompatible options (e.g., --stdin-packs with
> --filter gives different output than --keep-unreachable with
> --unpack-unreachable).

Makes sense.

> -	if (stdin_packs && filter_options.choice)
> -		die(_("cannot use --filter with --stdin-packs"));
> +	die_for_incompatible_opt2(filter_options.choice, "--filter",
> +				  stdin_packs, "--stdin-packs");

The order of check is now reversed (which does not make any
difference to correctness or performance), but this way, we list the
options in the same order in the message as before, which is nice.

>  		test_must_fail git pack-objects --stdin-packs --stdout \
>  			--filter=blob:none </dev/null 2>err &&
> -		test_grep "cannot use --filter with --stdin-packs" err
> +		test_grep "options .--filter. and .--stdin-packs. cannot be used together" err
>  	)
>  '
