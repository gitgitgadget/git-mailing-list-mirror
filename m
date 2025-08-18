Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B8B32C309
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536819; cv=none; b=VMKGeeylMCPJfzQJT0R+wazmDm3wnqSp6qczoUnPEu1O8Y3ihbIS0RWaETfT5B4aJhT5LYPOvosAQgEgCEP3zIqyrWjqNPMYlWnyI7KyjUJehdBqQkzeP9b0Rdy8/Sdg8A4zpDJ0iU4ahbKQ109OU5xtpI6uOIbRgPKH2uRL3ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536819; c=relaxed/simple;
	bh=XcaCpbZynt8o1rGSOqbbCJIPsmDavVxuroQ3yC8hbHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SXBFaEPAPQvpNRlYoU9l3ruFgea2ULQQF7eSsMV1gIy92HlPR6fmFSHaPvJWNVVunwL+arwDI5mhhI24pz60MmzY5qUaxbP/uTg5D8Z/auwjc3ciU/WdpnmN1ptHgFhHiWDGZxsSyud+IlwisQPFBRuockBg+g0QghScQ4xfbHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AWqNiRnc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ApmoVTT4; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AWqNiRnc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ApmoVTT4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A57641D000C6;
	Mon, 18 Aug 2025 13:06:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 18 Aug 2025 13:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755536814; x=1755623214; bh=diXeq3n+ti
	ZJcOrvyzoSZAe+rBOXBnH3+SnL0sKYwvo=; b=AWqNiRncaO9MzSZd/uIV5ubIM0
	Gd2vzi0FP+GW6OA8e0KSxiJIt79AZTJ3ogKkzEnUU3PaPOyogs4yhV7H+QFebjXp
	BVEdaNY88DHPDpWAd3IClMdIWceGmGqyRD/XGy0xtiK8C+ehaGLg7l+MtnAgt8AE
	SAM72HxW87oTO9jVp8ptIE0D52c+YLndEfnpt196w85X4eolt7+d2mYUaAKkd6Kv
	hlT1l+BHuJ/ip4nMOiupv4k3vs3tS6iYwGqNk5RopDuqHQOajGaUEet/phndxTgr
	DWunpoULqefgmbviWxHsDmdftwGvbyRg/unvb9qYFtSmHRW0qzOzn92vDY4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755536814; x=1755623214; bh=diXeq3n+tiZJcOrvyzoSZAe+rBOXBnH3+Sn
	L0sKYwvo=; b=ApmoVTT4Ra4Sk6V9TPUTH1rnaieAEfRDitA3VtVI5AJF0/DJ878
	yi1TQLld9Yh/MTp/nOnJKS7ectpa98rVPOaNpeSPrX9pBIvWGMG4gMervKTA3fJa
	0mkmH66uyMYdmBiJAxJkHvO/HTr2tQnKXVs9ilAHhgOPr1MmtrUnN45lMAyERi/d
	Vy5O2b886DzPhAnax1b6crqNZ5ic6plFkAT0u8b3h5HKey5oEaXQgfLrSxQGkY23
	Q6oaxWSClMUDWrQDNKTbhykodUjGg9j1+RBKayzN7d67GIlM7IVbQh0BXqw7OrKl
	RghseWTycKDcouLH2J4z6mwNbZ4zooXtVYw==
X-ME-Sender: <xms:rl2jaKtiVHIO8FyQXAcTRjSkWhA3Hbr3I9XNOZNBs6H2Tbid0mHUqA>
    <xme:rl2jaMZixFHpoLnqAT5lyWRUpPO-oVfxwwcsSFNo00AalUFPvwugPn2VP_f22872P
    Oh24CUfPcISCZ-Riw>
X-ME-Received: <xmr:rl2jaBYQzXi5hZygrEa5hVUe4Z-cluMJi9fgpOEcc3rKrj-hQa-88h2ExHIDawn5VZ0qJgQzrcgudVOOk6kwilkztn6qR2xX2jgfrzU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheefudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsg
    gvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:rl2jaNkrSryq_5g8RMx1t5G3EtvVxFv1RJBZWZ8yo07wYstYiQhNRg>
    <xmx:rl2jaE2fvUmZNKQh3QTxIrvyq8D0BJrWK6J7WTogToFXMAOHeNfg-A>
    <xmx:rl2jaF1Sm-ZMRnmROcSsQw8HXE0I7teFW4DIbvmJ6zbq1meuHhCk2g>
    <xmx:rl2jaOp_kYKrMnHpoeak_HOfE2w2ZkW5qKKoU6Ga8_739VOsDbCD2w>
    <xmx:rl2jaE_bfZ9dFBVMVs3YQnroBNIG3S0MFYav9h9-nzM1eIyzJSDwHicG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 13:06:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Karthik Nayak <karthik.188@gmail.com>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v8 4/5] doc: git-rebase: move --onto explanation down
In-Reply-To: <51468411-8251-4f13-90f2-5cd5184d7c52@gmail.com> (Phillip Wood's
	message of "Mon, 18 Aug 2025 14:42:57 +0100")
References: <pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
	<pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
	<4686417b28e4ab386983ad68e4d4d4798a467811.1755276751.git.gitgitgadget@gmail.com>
	<xmqqh5y8nvmv.fsf@gitster.g>
	<51468411-8251-4f13-90f2-5cd5184d7c52@gmail.com>
Date: Mon, 18 Aug 2025 10:06:52 -0700
Message-ID: <xmqq4iu4k18z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> The new location of this section on "--onto" felt a bit off.
>> Perhaps it is just me, but in case others have different opinions,
>> I'd raise it here.
>
> I agree that "--onto" is a fairly commonly used option and so it might
> be nice to mention it in the general description.

That would independently be a good idea.

> The existing
> examples are all good reasons why one might want to use "--onto" so
> I'm slightly wary of replacing them with a single example in the
> description.

Then perhaps we should find a better place to put it.  The section
on advanced topics notes are mostly about operations using sequencer
machinery, except for the onto section.  Perhaps immediately after
the apply/merge comparison?
