Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2506727B4F9
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977765; cv=none; b=skgSn6SLvMNJh1UidFvD+PxPOVWQmxB0S4TXdJXXqkpRi7O4zy5Zk8ZdUb4PI0Q/4Va6mXxSuGpyvFUeAxsGl350XNXvthWy6VeZ5uVk4XNRKcBKJ0/+EyiU78hhevN9c5kYG1W8WxQUus+l1ks4K9zu/pxyW4xCUmGMPOxQhk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977765; c=relaxed/simple;
	bh=pAqFZs4L9NGohjulrXB6xObk8a33LdkTzt47Qxk2Hmg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V2mgBDmlGq9UidYbp4qfGCQiY1SaIsegKTzcCyhR7YO95BFuTSUhdtINimI35kTygy+7MS9QO50wzscNmBuxzzB69nSOaaYmFyEQ+LIvbCnwjaw/Uus4/TnCnZ6OxdCR1y6vHVGAFnQ/flyxYZw0yOEzT9D0PUxaelNUc4YHDfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KdsgSjHA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MbaLpdmU; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KdsgSjHA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MbaLpdmU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1660A7A0133;
	Mon, 20 Oct 2025 12:29:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 20 Oct 2025 12:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760977761; x=1761064161; bh=slSrKy99Rw
	Le81n3XhxkBZGZU5cmasED/9PAETDzBWY=; b=KdsgSjHAz8mqIWY6vipYR/X/MN
	PzLN5ihLAYIMr6x2yYvqpP06WBvwAUXIfo09eK1pRtVV3UbJt2onZqEFxbyzqk5s
	kjs2ULfnHkCRCoVA8JGmZ6VnND3SbXGW/N0/JSO0Y+KjgPYA433PFCOFTGOjgyXR
	xnxjiW/km95c3TbJaNrARiPDplKKGKyieojVgjfTtizKW5fd2DX9DPsWB8Iqp5pP
	LsYYLlrizstsyVJ00FQIoMAzMSNP9BlnNvv9Rqkx7q/5mdK6Z4U8dNpOM3yAbIiB
	1lKLUWRJOf9H2MRGvr88X6l9U6LH2zXB9VclI3ZCeb7PzNQlejKUnmTng6IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760977761; x=1761064161; bh=slSrKy99RwLe81n3XhxkBZGZU5cmasED/9P
	AETDzBWY=; b=MbaLpdmU7HKP2xvC2Ry4IGqx7GStK+sTlxrmBO8CAwStYYrlwep
	caCfl74nO52juHhzBVXUz5WoNabfLkQRNlW1sn8dYTr9FoNZnXaZ3tIxQtG0uqno
	EqXLW5dNWYCO3Fes4h7GVHe2E3D3N0fiIfsxCoKcBjT87AnZPpG52JZJSKTUG9LM
	aanH3X9Xkd2PxERkSyqfWLOVEFu7m/epXvEK2UNeFBHZHCHeRDdvhWWZ+HUx2HlX
	ecrb/c4SRA4V3X2QU7339etMnm9yen7DKdPeOUFtvZvX7WTsKyNfh6wSIkyF507O
	swfuYTPDJQXAa8oDmXjPaaCfFxx3FvMrJaQ==
X-ME-Sender: <xms:YWP2aJ-jmWYS7vwZ3-dVyY1osPM7ACqFER_klx4ZCti8omlqr2Qggw>
    <xme:YWP2aBbGcGiRkUT0zOSlE2ywu7IJShaJLvllFmLYkNcQmUUBOn4kDkDVo-vEFlNPL
    a0rwpUHXTLX829HVlMN9slog3Vsrx9GN349QWoHuyxN7DcGkkcc>
X-ME-Received: <xmr:YWP2aA12B8O5wJjZYVAPU-Zxv2GaaMGa4aLfsAwcUHcxHGo2x8jKgJR6Vt37ck4alaqqPtg4dXjuhfk6SEgkJCsbDU7S2eS2D_An>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YWP2aEZhJrxlY31oqS-oXZPCTW-QBkDexlRk33SYaGc0M7mOrhYoTg>
    <xmx:YWP2aAIeul5xpZSEQ05S9iQ3DafoS_PbdqTLhRequ1y_9OIu2Goi8w>
    <xmx:YWP2aLGxPIFzAN9lMXZ3YFRTxtQFw-yGOXrF24g_efaLWKWDxHVQ_A>
    <xmx:YWP2aPskselHtjQZpfcanFDUEK-N5WKdbhT627V-VuQ8mgfN3B3LYQ>
    <xmx:YWP2aB9NlfhA1WaeAeQsftK9rUnYczTS-KXYDXUG9V1J93AnBhzmifEk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 12:29:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  newren@gmail.com,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 8/8] sparse-index: improve advice message instructions
In-Reply-To: <a34cc559-5823-4e68-8f3f-07c182f7299b@gmail.com> (Derrick
	Stolee's message of "Mon, 20 Oct 2025 10:24:04 -0400")
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
	<pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
	<a34cc559-5823-4e68-8f3f-07c182f7299b@gmail.com>
Date: Mon, 20 Oct 2025 09:29:20 -0700
Message-ID: <xmqq7bwp1qqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

I am getting

warning: Patch sent with format=flowed; space at the end of lines might be lost.
Applying: sparse-index: improve advice message instructions

but hopefully the result is correct.

>  From 0ee829fea73d495dd32deda4553ea00f9299c701 Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <stolee@gmail.com>
> Date: Mon, 20 Oct 2025 10:19:22 -0400
> Subject: [PATCH 8/8] sparse-index: improve advice message instructions

I will strip the above out with "commit --amend"

> When an on-disk sparse index is expanded to a full one, this could be due to
> some worktree state that requires looking at file entries hidden within
> sparse tree entries.

I would find it smoother to read with "this could be" -> "it could
be", but that would be just me.

> These can be avoided if the worktree is cleaned up and
> some other issues related to the index state.

Now "These" confused me.  Does it refer to the same thing as the
previous sentence refers to with "this"?  Also, I can understand up
to "if the worktree is cleaned up", but the rest of the sentence
does not quite parse for me.  It may be that we are missing " are
resolved" between "state" and the full stop? 

Even though it would leave readers in suspense to know what "some
other issues" are, it is answered by reading the message updated by
the patch, so it is OK ;-)

> Expand the advice message to
> include all of these cases, since 'git sparse-checkout clean' is not
> currently capable of handling all cases.
>
> In the future, we may improve the behavior of 'git sparse-checkout clean' to
> handle all of the cases.
>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
> Here is an add-on patch to add to this series to hopefully satisfy
> Elijah's feedback. Sorry it took so long to be able to get back to
> this!

Great.  Thanks, both.

If the title were numbered [8/7], that would have been even nicer,
but I was following the discussion this time, so it was not a
surprise to me to see only [8/8] in my mailbox.

> diff --git a/sparse-index.c b/sparse-index.c
> index 5d14795063b..76f90da5f5f 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -32,8 +32,9 @@ int give_advice_on_expansion = 1;
>   	"Your working directory likely has contents that are outside of\n"     \
>   	"your sparse-checkout patterns. Use 'git sparse-checkout list' to\n"   \
>   	"see your sparse-checkout definition and compare it to your working\n" \
> -	"directory contents. Running 'git sparse-checkout clean' may assist\n" \
> -	"in this cleanup."
> +	"directory contents. Cleaning up any merge conflicts or staged\n"      \
> +	"changes before running 'git sparse-checkout clean' or 'git\n"         \
> +	"sparse-checkout reapply' may assist in this cleanup."
>
>   struct modify_index_context {
>   	struct index_state *write;
