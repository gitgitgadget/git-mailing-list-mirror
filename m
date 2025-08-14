Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6259327FB1E
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755209451; cv=none; b=b8L7MjnGwZFWi6nVyUDcUM5Z7equ5WRuAaNxOEwIAzQYxdozD+W4bgtQ7z+KYcIzJPTdUoGCXsPsTnbt75vYCjTrcJykW/2t3rAiVhhND4LhT0Lzk8IFauYDX/WBDSBNDc+HkzwYAmZeEGb3fTJsbiHX2yTe05eEaqb5FiJEwT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755209451; c=relaxed/simple;
	bh=dKXBnwkGCREGuwY3vw0Xs70WEEJ41DNum3VWDuyeqOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y44qgU/OPROaT3vJs28e4C32XrQZLRauZ5xEsifgNa9xDkr5lIQ4fnpCb1LxCCGR1Wo89aA1dQeAHKlHFn2jKvg2P6XfyCBCe2pHURVadrrlAB0DYgeBqAdYrIz9UfhRC6KyTP/jO5CL6nyy2SyTqoi8j/b2I9x5GowcqvDAxh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V11pxczB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JDiqiAs5; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V11pxczB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JDiqiAs5"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 56A511400209;
	Thu, 14 Aug 2025 18:10:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 14 Aug 2025 18:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755209448; x=1755295848; bh=PAYWytalPk
	jPmRWN2aEoeFuCoXi2N+w8LMsns0oUoxE=; b=V11pxczBFHX706g8ssIVAd2n9Q
	tBNtDkQEk4fFyGlIffU9EcGShyYmakuocZi8vk0wdfp7S5fU/Wbbzbh5vBNLogf8
	vB1qrp4zSi1hGWpCq8/USM3TQ/PSaezVattNmOieMAN+pfdzAZbyu//ph8chFW4E
	vLQKOlC+f0xE4kUqlvV0Wx8nW/vUSAop29k+nnQCUyL4JNrl0DdK8M5KADBY/q8m
	SPW5WMt6DdrlhdMifsb9p64gVEZXYx7Jt4OO0/yXCmBKV4y55fIUmqAEEnQZ4M3+
	Hx1B/Ew1vQR2UR1QKDX9LX0cWBACtSvcUFETt679QJQicOd0v6xuX4m4XVsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755209448; x=1755295848; bh=PAYWytalPkjPmRWN2aEoeFuCoXi2N+w8LMs
	ns0oUoxE=; b=JDiqiAs5wQsVetxnw+47fU7+ZaCz6Y2lH2DlF1sKUYp+8RDZuIy
	u7HcJ8GdupRCwsrmoVUWD5VMwVXilY2SzLBm+ZAgfQTeO3vlCDb6p6X0P6pAG6ID
	fL8s9qpSzDRDjNGiT6HXzA7ABqsOqU01oJU5a8wD5qiDOUWJ+VyKACvLgNEDZcLw
	nd0M3/qJARW0Y2o5eKK2/xoos7PSYhvMhHPemQX5rCT2J7JRLWqdpjWZiqBvO3Th
	Ur61npT935sVRQ/HAp/RSKSZ7mYIBP1GiBzzDa5v9oZ/8rTbea1XRp/IdrYM87gC
	hq++lbXfVzfsoEgxVd1HgjTiDkxK0NVV5HA==
X-ME-Sender: <xms:6F6eaPveTnPj7Rd8rGhUmguLixSxHYeObAkCqM6qHyYhSSSxJP-GOQ>
    <xme:6F6eaOBOkhklh1frJPNMgXpCbbuElWpFT3ETZolSTZDvQgfgusGyH3lXzOzweRgHI
    9iBjCYETgFU7hKujA>
X-ME-Received: <xmr:6F6eaJNDWNv6xEjUKQG9MvulQBzTkveX5Xb1YLQGLNZOaVF8d0GNtKzFAJEmwjcUxRxokNgiWtHIlPVnw6ddgzuqIsUFEXpCQgRlkrI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgv
    vgdrfhhrpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6F6eaPyrg76ffluDvzLBqn4RSik-RhsJ8qy20SJCiQW4x6EA3OBTJQ>
    <xmx:6F6eaBUCMtG3hwqcEKIYYb9lTdDZNGHHXE18cxz0_QQVELg-h_vYpg>
    <xmx:6F6eaJMcYJVYzEVYfY2OEj9ItGn6RnKYFM5ShuzTli3rYqI98axBCA>
    <xmx:6F6eaLA3hVOo_ms2p_GMYHCKlyt-PSAB9rjh7AW7L0-WaeEfM3f_rg>
    <xmx:6F6eaL4jyIdf1DJaWwEPoQ-2tekWq_yR_68jhIDhEF8l9B7WUcLTGBga>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 18:10:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chris Torek <chris.torek@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,
  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 2/4] doc: git-add: simplify discussion of ignored files
In-Reply-To: <63c9e0361dc02c15afeea3cad1656e1631637f60.1755127218.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Wed, 13 Aug 2025 23:20:16
	+0000")
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
	<pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
	<63c9e0361dc02c15afeea3cad1656e1631637f60.1755127218.git.gitgitgadget@gmail.com>
Date: Thu, 14 Aug 2025 15:10:46 -0700
Message-ID: <xmqqbjohy2op.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -The `git add` command will not add ignored files by default.  If any
> -ignored files were explicitly specified on the command line, `git add`
> -will fail with a list of ignored files.  Ignored files reached by
> -directory recursion or filename globbing performed by Git (quote your
> -globs before the shell) will be silently ignored.  The `git add` command can
> -be used to add ignored files with the `-f` (force) option.


> +`git add` will not add ignored files by default. You can use the
> +`--force` option to add ignored files. If you explicitly specify the
> +exact filename of an ignored file (e.g. `git add ignored.txt`), `git
> +add` will fail with a list of ignored files. Otherwise it will silently
> +ignore the file.

I think we no longer need to say "explicitly" now that we added
"exact".

The earlier text used "explicitly" because it wanted to say that
"git add t/ 'ig*.txt'" silently ignores "t/ignored-file.txt" and
"ignored-file.txt" because these files are not explicitly named
(they were only implicitly named via recursion or globbing).  Your
new wording "exact filename" already covers these cases.

Do we discuss that "git add t/" attempts to add everything that is
not ignored under the t/ directory elsewhere in this document after
these patches?  If we do, then I am 100% OK with the decision to
stop talking about globs and recursion in this paragraph.  Otherwise,
I would want to see some mention of this "naming directory names its
contents recursively" somewhere in the document (it does not have to
be, but can naturally be, in this paragraph).

Thanks.


