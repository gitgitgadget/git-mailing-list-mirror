Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3996143759
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736441198; cv=none; b=U/l6Op84Jx8K2BtrA6O/GSho7ejxD2H7ye4BXtyp3+zr0yjft9rmnMNyoaiD3O26n3pk92DHLMjJ2JDVq8J8Eiz/mb2YF44GmfW4lkBvxabgq7L5bziTOk8m3BImnJJTXJAYtlgJ0UZGJDS2vLmjqVtSG0tha8h7vGVZFFoWBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736441198; c=relaxed/simple;
	bh=oFignV6NXhEI+ctvU12uxC3/39h9i9+DCJKkoopb7xg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ul798yxulxIFeQw3wXlQYenVSUmIvG3Jt/cgyvHP0pbPEAJPzysACXlmhQlSyRNQ7h3k8hg8D9XrNW5ddq04ph//oc1JwgRNo9MPbSpJ5Hhy+WvPBbsm2ZwYUsLEB+FTwJpq8VyW4x6eYonJiHo1WcNzu7p0tpKZroqvpQV5XnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KTAqq+IM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Soc2lM8I; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KTAqq+IM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Soc2lM8I"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 06B1D11400C9;
	Thu,  9 Jan 2025 11:46:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 09 Jan 2025 11:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736441196; x=1736527596; bh=zLQjzc5Xar
	CPlVrnwlDU4XFTs0ShPdC6rulxWkv+IXY=; b=KTAqq+IMlK6X86xVotsC1cEVjs
	WXySm9Y4q26eGxYuUMpXOZHnd1y7Z5frW7RHcPJtJPOyHN7QeGiKXAvmfUlLiUgn
	tC5HEsQf74GZc0qqNWNSKnAR/GT/ItYXn8K6Nd+o1rFfN/8qjvw3R3zKGfF/M+qy
	MMpxrMTOHW6VEZsUuF9Xts2l8CQ5Sj0LdNJFr8Xu9DDdUB73xbidlcXWUiRbjkDu
	xr9DsJ40T2kTb6aDR5EOR+IH68fVuPJXRAXk8Xh4eq3QNggBum48XryNIUSLiTXm
	tMVYqEf9cj9AEpjRdAn1SkF44A/7Ybc701N7ocKrYTx2SCXi4QU96UqKB9bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736441196; x=1736527596; bh=zLQjzc5XarCPlVrnwlDU4XFTs0ShPdC6rul
	xWkv+IXY=; b=Soc2lM8IYgqVj4Voz3bheawrA4JWJjsrdaKYC2RgNvAKn9/OxbJ
	Pb9g7yR9DREdxzMe5bpUU/wTpN2HvFGv74UvTiEUuskHMAGNBor4wVSLdKjTFL2e
	BDgIS9dHJWXAz0ipcYCmnH0CDwxK6wkYeKjTbyKvD0guqgtBc6DxSsUp8w2OYUUT
	/aQIUsQuwje2dqbwQ9QQAQ90HrbDWU+V2Y+2kZYRsdhuOjFSu0tJW5G+zRn3ETI1
	C5m5KGxs+JXI50MpUd2BeRnYvcAzOpyT1A/Xrd2uHdxbkLWt6vk7jouqq5F98FsY
	BJ8Agpr9PJ6mskghEQLor8BTwb7H7ZBQs8A==
X-ME-Sender: <xms:a_1_Z5YHvN9CPj0zCI_xAAHCDyQSNLfhrMCTGu6UvJlxcbL1xCUUuw>
    <xme:a_1_ZwYbHoyKfzb5No_pVwpjvcQ65D2G6lC1KSUzR422bGFii0lODbt7k7al_zpbJ
    2Favsq-l7N2wlvU7w>
X-ME-Received: <xmr:a_1_Z789AcqetUT93BZsk1rNmJHTBpcX5icG-he6Kd5lWRUtCPpLWvM6D3Aulz_jYrV_l_RNc5xBvTLMpp28UDsqUZrake9AZ2Ez>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtth
    hopehmrghthhgvuhhsrdgsvghrnhgrrhguihhnohesuhhsphdrsghrpdhrtghpthhtohep
    mhgvsegruggrmhhjrdgvuhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:a_1_Z3pQ-PKB4UPzMBoYo9hRFw5AyGT0rNfz8BMw3EOYBA4K1fVOLg>
    <xmx:a_1_Z0qkw8QwtelHOwX3v8E4DhJLHNezssN5785QvcOQA2-J4PrpkQ>
    <xmx:a_1_Z9QLBq5t7bF1dyzpw_09iFttr5f70kY7hBHSMhu4gqS8YZbg5w>
    <xmx:a_1_Z8oSQbl_jKZ2-KbAncOcdFRCAcTxqV2p9ooqWUqYEwj5lfssXg>
    <xmx:a_1_Z1d-MqKTAGDZwGHuziwF7ySjyKTIoQjUvNxR-VDvUUcwgR7K3x53>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 11:46:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,
  Matheus Tavares <matheus.bernardino@usp.br>,  Adam Johnson <me@adamj.eu>
Subject: Re: [PATCH] difftool docs: restore correct position of tool list
In-Reply-To: <pull.1849.git.1736379323427.gitgitgadget@gmail.com> (Adam
	Johnson via GitGitGadget's message of "Wed, 08 Jan 2025 23:35:23
	+0000")
References: <pull.1849.git.1736379323427.gitgitgadget@gmail.com>
Date: Thu, 09 Jan 2025 08:46:33 -0800
Message-ID: <xmqq1pxcj5p2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Adam Johnson <me@adamj.eu>
>
> 2a9dfdf260 (difftool docs: de-duplicate configuration sections, 2022-09-07)
> moved the difftool documentation, but missed moving this "include" line that
> includes the generated list of diff tools, as referenced in the moved text.

Thanks for a very clearly written problem description.

> diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
> index fdae13a2122..1135a62a0ad 100644
> --- a/Documentation/config/diff.txt
> +++ b/Documentation/config/diff.txt
> @@ -218,8 +218,6 @@ endif::git-diff[]
>  	Set this option to `true` to make the diff driver cache the text
>  	conversion outputs.  See linkgit:gitattributes[5] for details.
>  
> -include::{build_dir}/mergetools-diff.txt[]
> -

Above this include, there was an entry for diff.guitool, and this
generated file was to enumerate possible values for the
configuration.

>  `diff.indentHeuristic`::
>  	Set this option to `false` to disable the default heuristics
>  	that shift diff hunk boundaries to make patches easier to read.
> diff --git a/Documentation/config/difftool.txt b/Documentation/config/difftool.txt
> index 447c40d85a2..6cd47331a91 100644
> --- a/Documentation/config/difftool.txt
> +++ b/Documentation/config/difftool.txt
> @@ -13,6 +13,8 @@ diff.guitool::
>  	and requires that a corresponding difftool.<guitool>.cmd variable
>  	is defined.
>  
> +include::{build_dir}/mergetools-diff.txt[]
> +

And the list now sits at the right place.

Will queue.  Thanks.

>  difftool.<tool>.cmd::
>  	Specify the command to invoke the specified diff tool.
>  	The specified command is evaluated in shell with the following
>
> base-commit: a60673e9252b08d4eca90543b3729f4798b9aafd
