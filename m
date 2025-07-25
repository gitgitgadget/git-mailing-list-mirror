Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8793126C1E
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 23:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753487566; cv=none; b=cfgQSS+srxm4my22E/yzMIJ7j+fyWb1leSz6NXaxDmOX9tqLNmMfTn4VJtp+pOmDlb3ZwAG/XcQRh2rdGBBuKV5VVIdFfMXdFa4qQIjOWRQTO2ngqt8Zfyx5Me54+EQPiGX6DBqVHU3bNDWs2rTczi1+no5DgklJFUy6opkpiKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753487566; c=relaxed/simple;
	bh=e4hKee+KXFycotpukpqLu3+j6IY0nPA7RUOiMhJv7FU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pu9Y/HheU5+y/6897CbjxVPtlKZ90ZYHyMtqL/5+vsHZAM9Hc9Y4gTU/0FqwC02wH0bZ9APHLYaWJ5TwcmlgG3PaIrb0o4BUhu01gCjHCNAub1xCpaYj127erraLxQFh4s1t2QaNTzQcFT61a/VHbWoRi4gtj2J8zLhaqVU4YDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DVs4/TLM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YOUFdKLJ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DVs4/TLM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YOUFdKLJ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EA14D14000EA;
	Fri, 25 Jul 2025 19:52:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 25 Jul 2025 19:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1753487562;
	 x=1753573962; bh=9qFjyeKAgSTbaNkTcokR2J92OepemGljzO9fckIu8MY=; b=
	DVs4/TLM7dzx7OaAXb1nMYGvBmO+pH1g6jofcwMzOvSyArwIQ3BTA1pTFBhYmvWa
	xNAsAC7UXKBueS6OjUOwKOdYnu88KIxs56BabE1rSEk8DzshXCDIONgHwTSP52rB
	CvUmzUOoQcVt9wM5RaHXsr7pxbcJa0OlBA0J3e1rWMLgYhUVnHC/f5eI104QFQgM
	mf6O5pDI2sgZ7qnzGtBZ4ExKZMh90pdhZg75rwfnMJZin+EYPm9tQZ9otu1C+OFX
	9J+pIpLfJ0MzVDt8AfGONXQe+XCmQVc5tRQB/Ykj9q3mqBkOPvBtD0ECWgbVWNJn
	WSsNBz1ELqrzIFDGp4v7Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753487562; x=
	1753573962; bh=9qFjyeKAgSTbaNkTcokR2J92OepemGljzO9fckIu8MY=; b=Y
	OUFdKLJUqHzhrXVSGm6lMkyCil9CGSh+f0HJonm14x4Z+vSwz0rPx0/KHmCSMBgz
	gz3I562TZ1SwpfyBMXildqAyXFkc7Xcw7GCGKAgyAmW9qabY4MNO6GJYw9xqBT/p
	nrddUn/xU39ysUEwVVxwMqTxveii48cC18qsmU6+tK5GEMC1FIOz6sSPwYn4Wk6Y
	WON1tKoYSzGhKYO4alGUrfJeJDZHgXLkQRLNgij4cNRSN9KMURuivMY+AGssbJcc
	fnszUCGZL35rgnhLgyqUSwaI4OIjoMfmM8UCo2GnC0y0N35QWmee16Xw4nPx43so
	XMKesyl4AcWLP0k6+9sBA==
X-ME-Sender: <xms:yhiEaPJAJhGV2FiCaqWP0uTNlgiqIqi7A3EzgdCZkrIfoJCSD2AaAQ>
    <xme:yhiEaLltfq_fVD4ksnmlcbLZz7pLJa3dN3qtI65wxcadKP7UAWax_s7LeBMK6cJED
    dWiGOqVtBvg-mCuxw>
X-ME-Received: <xmr:yhiEaIJd4sfZfQoNJHXpEN_2MwQzpvynRNjlXKnF1d7TrxrgFCaK00FHKv_dmdYO2O3q0sx6uXEuG-XR6NVbpv1VEcUI2TxnMIS89DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekgeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepkh
    gvvhhinhdrsghrohgushhkhiesrghrmhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehrrghvihesphhrvghvrghsrdgukhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yhiEaI5rstFOADZk3snB0jiMFvpZjGmy9IA-XGbeCxiiLjhYVuldow>
    <xmx:yhiEaE1-sW_Jk_ZGlQ3309oYX-HBWhE82LftDbPu7CWShLE44ABeYQ>
    <xmx:yhiEaGdrEEn6OeeKxzd5Dhv4VmOpKOpzyv9t8BO3EpW788BBYOUxRw>
    <xmx:yhiEaCdJPjBSfaplODOIoMhXPGS8EHN7sKm6HDNv8y0m6NtMNnAtig>
    <xmx:yhiEaIelD5Uw4koU8a8j8Zk3MwhGY2SUKjIXkynJEKHRFN6lF2LWHXPX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 19:52:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH] git: show alias info only with lone -h
In-Reply-To: <a35dc2bf-015c-472d-9528-6763f7aac180@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Fri, 25 Jul 2025 20:41:24 +0200")
References: <1c3a0463-36ee-4a2d-92e0-fac9c0bf77da@arm.com>
	<a35dc2bf-015c-472d-9528-6763f7aac180@web.de>
Date: Fri, 25 Jul 2025 16:52:40 -0700
Message-ID: <xmqqqzy33k1j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Builtin commands show usage information on stdout if called with -h as
> their only option, usage.c::show_usage_if_asked() makes sure of that.
>
> Aliases show alias information on stderr if called with -h as the first
> option since a9a60b94cc (git.c: handle_alias: prepend alias info when
> first argument is -h, 2018-10-09).  This is surprising when using
> aliases for commands that take -h as a normal argument among others,
> like git grep.
>
> Tighten the condition and show the alias information only if -h is the
> only option given, to be consistent with builtins.

Hmph.  This certainly is an obvious improvement, especially when the
alias does not redirect to our commands, e.g. "git g" is an alias to
the system supplied (likely to be GNU) grep:

   $ git -c alias.g='!grep' g -h frotz *.c

which gives us hits in our sources as expected.  But without
arguments, we get the obvious plus something we may not want to see:

   $ git -c alias.g='!grep' g -h
   'g' is aliased to '!grep'
   Usage: grep [OPTION]... PATTERNS [FILE]...
   Try 'grep --help' for more information.

I wonder if we should not run the underlying/aliased command after
showing the alias expansion?  With "grep" we got lucky that a sole
"-h" means the same thing as it means to us (i.e. short help), but
if it is not one of our commands that would not generally hold.  It
is risky to blindly run the external command with a single "-h" as
an argument.

When it redirects to our commands, it is less risky as we aim to
make all our commands honor a single "-h" via t0450.

   $ git -c alias.c=checkout c -h
   'c' is aliased to 'checkout'
   usage: git checkout [<options>] <branch>
      or: git checkout [<options>] [<branch>] -- <file>...

       -b <branch>           create and checkout a new branch
       -B <branch>           create/reset and checkout a branch
   ...
       --pathspec-from-file <file>
                             read pathspec from file
       --pathspec-file-nul   with --pathspec-from-file, pathspec elements are separated with NUL character

But then, it may not be such a good idea to pay attention to "do we
have extra '-h'?" when alias expands to our commands, e.g.

   $ git -c alias.c=checkout c -h main
   usage: git checkout [<options>] <branch>
      or: git checkout [<options>] [<branch>] -- <file>...

       -b <branch>           create and checkout a new branch
       -B <branch>           create/reset and checkout a branch
   ...
       --pathspec-from-file <file>
                             read pathspec from file
       --pathspec-file-nul   with --pathspec-from-file, pathspec elements are separated with NUL character

We get the same short-help, without what alias expansion caused this
mess, and without any indication that we lost 'main' on the command
line.

So, I dunno.
