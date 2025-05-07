Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3624028C5B0
	for <git@vger.kernel.org>; Wed,  7 May 2025 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746641274; cv=none; b=qhADGzEq6eF58rsw9HbnmrdKdvBlPLWTiw1M36PgHKiGOl3h5KP2OtVHIqFP9g+plyzkAzAgONgDSW6RsQiEpf+MiVMx+CRv4XRxMikMUcX7NXNHDjZu4yrvFKeaH6rvATB63CWjnace6trNjKSzNSno1tJJZNic1LC0HmlBTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746641274; c=relaxed/simple;
	bh=+1cgbddVqI4sURZKBkjPQs4aaqHnM/HkDlXwaKmH+a8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d2r1cEwJVJpJnQ7zuoQctOMcGHzHT6z2nwmUGwaB393A/nFCslHs7YFJCEkgFgbWox0N8MUnkBJnlyXRkdkRSGtP5AF9p04Kq/r+X5rS7mtK3npAQF5GAeezLahK+B9VMoG5UGy7su+bUznZCIesdviCG2Zabr6rv4uPCdjUhYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lRTbg7r9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rLCARekL; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lRTbg7r9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rLCARekL"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1CADD1380192;
	Wed,  7 May 2025 14:07:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 07 May 2025 14:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746641271; x=1746727671; bh=0TAN8K0693
	l7ulYOOG7FGQ8Bu8qtIi0Cw5g/6IVtEwU=; b=lRTbg7r9TwnhyGD6QZUfRExuDQ
	Y+jE5KnDT4umTxVGeaiJlLky++B59gOtFPQHQA29aszGWyV6UxKMPoYNgKC+ZA/e
	Qh8Hf1NMAcA5jmdAn4rtYumLKRkoAuJ6SUXioUj8kZDFgXnaZzdN5dfcfzuGWRp2
	yTSZUF3udhOYeg68P6vayfbEyTdMfUUNX2yX1bPWLuUqIrkIXwVgTJ4jsu02zvp0
	sJ8UYVUXI7PzMlbFUYgj5aBobj6AwnjGVZSAbZ/R33sbbO6F84TATE8btiOzm0jf
	ghRm4V83M4BzjV11KrhugoZ7+e8bKRs4Z3sxyyzHOHEOZbjSqcsVIBS5n26w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746641271; x=1746727671; bh=0TAN8K0693l7ulYOOG7FGQ8Bu8qtIi0Cw5g
	/6IVtEwU=; b=rLCARekLAzZYqUK1n4RM2C2ZMhWVW8tmPhMyAFnmtteOGwFjGS8
	oeZ0VOb3EpAifIZQHBxjgQelfSuWJuImc66RFWQoo5aihDfc+/mMrgqAo+nhRUdH
	dr8a+q+bybsmfEzZYpKYGsYn52hgDE/LcbM5ONR24DU9Zc4pCm/HjFaNrjPFJAnf
	fOg5EJGh8Vb8+K1XOu3uR1qLVERpYld9r6OQ6VWYsUmCjNZlTOO8Tz+GwhpmvgvF
	ufBorFyld5rpH+kpirsUF3fYO+MNOrQSODc4NghoimnewaYa8t1mN7gtvRk277vl
	iBN+L6h603MW/upHGMSyl4uxwGn0KSelWCA==
X-ME-Sender: <xms:dqEbaAEEPEtQX2CAqlYTXEf5F_YK2B6iAtA2hC8jtlpXDhVGq9cOFQ>
    <xme:dqEbaJW2CMtmAwUr2iBSnatVda3l3groeYtdg0oUOBGBgZga80BpeZU-2GgkjUCZq
    5kKG5CRV-IeatKAhg>
X-ME-Received: <xmr:dqEbaKLze8WOrCDm4sA_sb7ZL88ILYvsPb2ETSkBExgAGPkLALjoGNhlB--H1_ZAbNDxXG4avbRalcSXp0cqP8t_2K25I31dEPWC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhgvohhnmhhitghhrghlrghkieesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dqEbaCG05cxOiQJZZOlu0CcnP9V1w_egyrb4YXpJRZSRDznvU5WLTA>
    <xmx:dqEbaGUcU4ZyydenPS1GFjDN7hgEid09ROFrlruUh60Np5RladFjiA>
    <xmx:dqEbaFNx6CB38resoZ7mmp7x_l7Ijnfc7jNwhpuhlV1MiZ0D9Jh3Ew>
    <xmx:dqEbaN1j6r0Ni657zxKmbYA_eXa75Wq8naa1XQbgxr4QJeFvwMKAyg>
    <xmx:d6EbaCk02Yikb9V3mnkxZy0D3KUl6ZpJ8ekDIreNAlw1XXdOJsmigdjU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 14:07:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Leon Michalak <leonmichalak6@gmail.com>
Subject: Re: [PATCH 2/3] add-patch: add diff.context command line overrides
In-Reply-To: <61fe7690-87af-4159-be87-cd39c09475fe@gmail.com> (Phillip Wood's
	message of "Wed, 7 May 2025 10:51:13 +0100")
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
	<7700eb173e73bb240852dc1c7ce26f3d1f95d8ca.1746436719.git.gitgitgadget@gmail.com>
	<61fe7690-87af-4159-be87-cd39c09475fe@gmail.com>
Date: Wed, 07 May 2025 11:07:49 -0700
Message-ID: <xmqq8qn8cn0q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>
>> +`-U<n>`::
>> +`--unified=<n>`::
>> +	Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
>> +	or 3 if the config option is unset. Implies `--interactive/--patch`.
>> +
>> +`--inter-hunk-context=<n>`::
>> +	Show the context between diff hunks, up to the specified _<number>_
>> +	of lines, thereby fusing hunks that are close to each other.
>> +	Defaults to `diff.interHunkContext` or 0 if the config option
>> +	is unset. Implies `--interactive/--patch`.
>
> This documentation is repeated for each command. I think it would be
> better to put this in separate file that is then included where it is
> needed. That way if we need to update the documentation in the future
> we only have one copy to worry about. The syntax to include a file
> called diff-context-options.adoc is
>
> include::diff-context-options.adoc[]

Excellent suggestion.

I however think "-U implies -i/-p" makes no sense at all.  What if
the user said "git add -U6"?  Do we run "git add -i -U6" or go
directly to "git add -p -U6"?

I think it is better to encourage the user to be more explicit to
require them to say "git revert -U6 -p" or "git add -U6 -i".

If -U<n> is given and there is no "-i" (for "add" only) or "-p" (for
everything), just error out *until* other modes of these commands
find a good use of context width information, at which point we can
use the context length information to drive these commands in their
non-"patch" mode.

Even if we cannot think of a way to use the diff output (and with
configurable context length) in modes that are not "--patch" for
these commands RIGHT NOW, that does not mean -U<n> would never
become useful in these modes for the commands.  Let's not close the
door prematurely from our future developers by making -U<n> imply
anything, and make it an error to use -U<N> without -p/-i for now.
