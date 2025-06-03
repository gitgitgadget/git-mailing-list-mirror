Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FBA1B85C5
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 23:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748995034; cv=none; b=DLfuHazQToNSKAL7ccBehseur/mf1xOsAILiM+fKsIdBwLOF8t2yZYXebgBXrq0WbOekhbVuCdFeX/B4WfL89hMJ/NzUij5FBjSpWy0Tbn61DWTCLuUVuUktkrR442AyaclPgFp6Uk2D4Fw48CFCjJrZrecNVYqpoXbB2V9DA30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748995034; c=relaxed/simple;
	bh=uYtpDg3R9Sa+5WjzygjR8MCvuj21rAIJy78lUz8ABcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=djkFKWe61GOmNHPNTItk0ys3kgFYqHcCrjx9HpGxUMTwoJeyXIF5uUK77bWAVrxjNwykBJd0Cgi6AwsejkBrFn7yXWv3F8pI3liIRxyWKd7kRnoT8MAliWdFMv69CUWJt7IJJxo5TqKH942DVfnoqBSJq7x/Luu/4/kXpcuhHuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vgldoWap; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OcHZ61e8; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vgldoWap";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OcHZ61e8"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 54D1F114012C;
	Tue,  3 Jun 2025 19:57:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 03 Jun 2025 19:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748995031; x=1749081431; bh=yO7ciw67+d
	1/7Ufa7JGhT8jKLktrJXm896GrnB2rLP0=; b=vgldoWap1fC//3NhbuoCxv8IeN
	OkW8voDUEVAVy5aaveyD3XvIB7+LT6TUMIOR2mNVMhBcjlm+6pcn2VIwqz9nYppf
	+7fP0sAMnJZ3vbepTY3e9vzzYjR5TBbt/1kn1QZC8T0TcRG8ONO3GoWi02bm0Evs
	JtI2QUcowF7+csMXCCjA0DIdJjdZwmV3qIVgTmMKDU7q+2VQnE7/Rs1+i8dFqkkS
	HIwJYeQTpO4rFw2J43t6plH+mi8vpClPCoJPL6q0VNA41DCZdCLHTjtnlXCKyjTp
	cqXnzTSlLJ5VbLXbTuuK0/WHgtjZWKgtCXnN9PplME4JfB3K5R0loAlGDeVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748995031; x=1749081431; bh=yO7ciw67+d1/7Ufa7JGhT8jKLktrJXm896G
	rnB2rLP0=; b=OcHZ61e8rzZlM2562ad9yFGIGyo7bR9XpmgRj4T0s32obeozCwd
	fqIDLUhCVeUrBqjrZRvpgVR0eQnAFHBABpuk/yUs5AxqwF2Qt/fR1tLIPP5zuYvI
	yvPMI4rx1ZwWHdkgTfZV6leihl8E5Mv+eL+Zg+01zYJ/PkTKwqViwD14hJ9JgVzE
	b6Ayx1GWgZZ84ofCkrUeGBh4A8GPMkAm5dLXwDsidqNV1tTXFx/1m3DwnB0i2vjA
	pQzTf8r4J6sB5Fr3T7iGt6I3cEsN+5lv2KuS0Tc7NOazQVVodJVuBk2yY4kkXDyo
	CSFyHBvOHuGeGlD0fOcK+S30tv1wFbgvGhA==
X-ME-Sender: <xms:14s_aIVuWIQ9Z1BufNaR51Mngz8BFXM9udFSq7ti9VJeJhWCUqN1UA>
    <xme:14s_aMmohE3x15PRSlCIBeUvGgbOROYwc1RQEwlO9CeCf9qyPo90cgZBOZHs-4ucr
    JDkrnQCZ5Mk2M-XZQ>
X-ME-Received: <xmr:14s_aMbLzA9yO3e7j8MpAp2dgECGG7RqRbI60-ZJHiJiVi4zeF4zdimV8L1_eoHMNMz00LHZqaHiMzIxY_dxjvHNjtMGyt0xk5aQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptgholhhlihhnrdhfuh
    hnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:14s_aHUTsoy7WJcA2nj6k6OVIiprZm7EYqYb-refbSbbxtq2vZTdvQ>
    <xmx:14s_aCkrbYdu5XoECaLaQ82IbRD_jkLiCv5Ui8DZx4EcKbtPJL1EhA>
    <xmx:14s_aMfS9JZeEBSROvv_YtLfolWAS67GIvemHkvQtaO0m0ylrlDuZg>
    <xmx:14s_aEEaro8-Xh-4xTJjTXwUGCZiT9KeWKWpfEyAcoqMCpmIPcpFlQ>
    <xmx:14s_aMSJBgguJBnIedFKWhnZ6fLbunTy0E_DpB_ovyKk1nfGmY8PJK8_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 19:57:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] CodingGuidelines: document formatting of similar
 config variables.
In-Reply-To: <802402a288f0976765f1ba1c82d14c2289c8cf72.1748990700.git.collin.funk1@gmail.com>
	(Collin Funk's message of "Tue, 3 Jun 2025 15:45:39 -0700")
References: <45c586122afab8ae3624be6963d64e770b7396b2.1748911713.git.collin.funk1@gmail.com>
	<802402a288f0976765f1ba1c82d14c2289c8cf72.1748990700.git.collin.funk1@gmail.com>
Date: Tue, 03 Jun 2025 16:57:09 -0700
Message-ID: <xmqqldq8fkfe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Collin Funk <collin.funk1@gmail.com> writes:

> Document that related `git config` variables should be placed
> one-per-line instead of separated by commas.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Collin Funk <collin.funk1@gmail.com>
> ---
>  Documentation/CodingGuidelines | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Looks good.  Thanks.

> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index c1046abfb7..3dd339f802 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -877,6 +877,17 @@ Characters are also surrounded by underscores:
>  As a side effect, backquoted placeholders are correctly typeset, but
>  this style is not recommended.
>  
> + When documenting multiple related `git config` variables, place them on
> + a separate line instead of separating them by commas.  For example, do
> + not write this:
> +   `core.var1`, `core.var2`::
> +  	Description common to `core.var1` and `core.var2`.
> +
> +Instead write this:
> +   `core.var1`::
> +   `core.var2`::
> +  	Description common to `core.var1` and `core.var2`.
> +
>  Synopsis Syntax
>  
>   The synopsis (a paragraph with [synopsis] attribute) is automatically
