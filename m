Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E326D277814
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366901; cv=none; b=FM4pxup2qE6CUraFzzOeEhkLZmk/Nx2xpK8bnBeGnRxNOHTjX9Zkj8YzNeVMGDACQ9bHOls1qqa/tH3p2VXb9zTZRePPLBSNZAU7JSXT1h91V7XxZVIwvf//9EZkUDblDTwzCh3sK20kN0B9w5dmKAODTrBT9Qg32zs3y26gul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366901; c=relaxed/simple;
	bh=zT6C2B8DhE2cApW5VVxwFUbgcSmKv/FuUeW5xnQVdU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U7GBcGTuHI+z8TOotIrhQfZPAqs931cQbmmV2eDqB8o2zRekFfzBWi8yUjHxvfVqAhKVB8uJhOS4TNEyMIacDx8PGCUYIMNyQ7ffvlaXaZ86nErMotsG28N+GXyF8PyzZmW/agvYlLfZQljfjOrGdYsI2FdgtrpmaCCPYpp/WoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Poio5hCk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gWaz27ZD; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Poio5hCk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gWaz27ZD"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F309C14000CF;
	Mon, 13 Oct 2025 10:48:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 13 Oct 2025 10:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760366897; x=1760453297; bh=6O7PCouWyb
	QxdB5fE0QNwyIqz1e/jF6Mj7dcIbf6b/8=; b=Poio5hCk/Mb7VjyjNkBMeLutG8
	ZwKpE+AXTPoYDsSGuCHfs5WcoXi5I4qT3hJD0DUeqmLQtlwk/IMJZxyesAFQkUGH
	2nFEhwTqkxbpZpMgGPbfM8QS+LQrYGQ5zN1YRJyA6R3ymVkR2N1le7qwqPISJHWQ
	7so9+LMZkHsTcrL8KmbMCQI9YA/J2n6EZaXmU8C6M/w63bND6moTF9K0AuwV816j
	+0yt0Gm3H+uLSVpAS2TdInkUNIZgEatZ98ov7Vu8vtp7YYt5RIod4h3yo6jcRUbD
	LOfekxyufGYpf66gaX9KHyHwNxMgti+zhXm8UiW3nsbfzmRW8oIn5DXliq0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760366897; x=1760453297; bh=6O7PCouWybQxdB5fE0QNwyIqz1e/jF6Mj7d
	cIbf6b/8=; b=gWaz27ZDpJRnIhOeBPQbPMpOlW3Hhqpa4nF9tsTilTDXQNVkO/X
	wA0UmsIlC3YyvrRJ29kpX8Q3ObZIfsXhq2Mqm3ZQnMn8AQfqRb1cjIEtGHilfJMX
	PHDD76anDQJI6s20sumEby2kC5ajwtR9iQgpUzDa2AaXLWeua/GAVXhb1yy0Vl7D
	OvXijNYQlsFsiUzya3ouk9MJLCiDa8pbi3skPJ+rHcy1hddLRkVqss5sQs7iv61J
	uwUnh2zgjrQ9lvAIf5usecxUc5bVEUh1zpzKCvxNbm2xXmSPi3HRQJN0R4p04oyt
	QBFoWDMfxhGVB8r7PCBW6PGIe7ZeqKTgc1Q==
X-ME-Sender: <xms:MRHtaCjcIeMcCyleTc00REfwuZd9zNbFsxEzilS8XpBP_Bodw1msxg>
    <xme:MRHtaFSx5MT_wxTPD1AwbMi41i7ljcr7Lis9ejfu3IzHl5YWFFWG1loApryyRcPSM
    AawyA-hRuxiiqdxtLgWPQ0qlqREXN1PesN0F7gO33VSEdaZtHNm6EI>
X-ME-Received: <xmr:MRHtaMXUZInnr32rJsaOb-6WcIk6RylgGZBkmakBHYdEOB43DinABMZQ5ftyAu_IM2cPkPbZWg03RMvh21coK5gxWGqfbTcjenXi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudejleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MRHtaBQEY6HW0aZTQppfzpxt6dYZbYpGS0W5cuea-33JkBtNDDHRkw>
    <xmx:MRHtaOmI9w79JK--yR81W-II06T5DALbOkdUQr3JEhGXixAvY_tzHQ>
    <xmx:MRHtaP4AgFtkPglLfQ9zDwRMhLWvSi9S9mAzLjqcHPLmacDr6Yycsg>
    <xmx:MRHtaMj7Zpht4wNK_esfWgV7R5HK-LEhK6nQh92nicp5QWH6a9r7Sw>
    <xmx:MRHtaMGeuPsZqucv0uwYNDwYxpJ6hWbV_ytlhzD-R1gc3NomPsG2bGUJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 10:48:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2] doc: add a explanation of Git's data model
In-Reply-To: <aOjzQ7-88m5e_YJl@pks.im> (Patrick Steinhardt's message of "Fri,
	10 Oct 2025 13:51:31 +0200")
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
	<pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
	<aOjzQ7-88m5e_YJl@pks.im>
Date: Mon, 13 Oct 2025 07:48:15 -0700
Message-ID: <xmqq8qhe5040.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Oct 08, 2025 at 01:53:41PM +0000, Julia Evans via GitGitGadget wrote:
> [snip]
>> +[[blob]]
>> +blobs::
>> +    A blob is how Git represents a file. A blob object contains the
>> +    file's contents.
>> ++
>> +
>> +NOTE: Storing a new blob for every new version of a file can use a
>> +lot of disk space. To handle this, Git periodically runs repository
>> +maintenance with linkgit:git-gc[1]. Part of this maintenance is
>
> By the way, this isn't true nowadays: Git does not use `git gc --auto`
> anymore, but instead `git maintenance run --auto`. So we really should
> be linking to "linkgit:git-maintenance[1]".
>
> This tool _by default_ executes git-gc(1). But it can be configured to
> use alternative strategies, and when using scalar(1) we actually use a
> different strategy.

For the curious, this happened around a95ce124 (maintenance: replace
run_auto_gc(), 2020-09-17).

> Not quite true. Pseudo refs are outside the hierarchy and are in fact
> treated differently. But root refs are treated the same as any other
> reference.
>
>     References are stored in a hierarchy. While most references are
>     stored in the "refs/" hierarchy, some references with special
>     meaning like for example "HEAD" are stored directly in the root of
>     the hierarchy.
>
> I don't really think we should get into root refs vs pseudo refs here,
> so maybe this is sufficient?

I do not think "root ref" (or pseudo for that matter) is a concept
that has no use in this context.  If this is really about data
model, where you find refs (or what the "pathname looking" thing
exactly look like that names your refs) should be immaterial.  It
does help to know that HEAD is just a ref.  It also would help to
know there are symbolic refs that point at other refs, which is much
more relevant to the data model.

Thanks.
