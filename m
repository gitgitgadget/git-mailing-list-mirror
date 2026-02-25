Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709442264A8
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 21:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055040; cv=none; b=sO8pfUPx7B4DoIM+QmcNkug47PU4AKkj4Y7OLLpqMnqy1+QS5haQ9D5w3s8R7KX3AOQvAzxLVF4Y8EDTf6/di9Js2pA/ta93eTDJcYQP6PGq9bPym/u4HAjjpir41cEAJhM/rtNX66992qSo5JLKGmsRq0n3tR+3E/tPhiuv1D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055040; c=relaxed/simple;
	bh=5v70e1LaH4bVyXO77blxSNhNfD0JXudQS+K3/ORVUNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HRU8o9mKbhyjwavwua2rxvShknWxWtAkj+Ie5iQBg2PX/puMXfFOA6EnFWtQGLirQB2fHA+vNxWCCIkouXmh+DUc5xXwFAx8676gigpoJY7G+NIshEHyi//vPXHI8nZLFMLTXKcIo/CM8AXKSmyRiscwupmc6NDYZsMTf/a8S5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NKZ3e9h7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uVz4TUo/; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NKZ3e9h7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uVz4TUo/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id AE3D2EC067D;
	Wed, 25 Feb 2026 16:30:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 25 Feb 2026 16:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772055038; x=1772141438; bh=JhdIQflnUl
	40nH/QFvgdYtu8vs/kgoinYk9fn7ZfmhQ=; b=NKZ3e9h7xYtumFghD7vXclxqum
	ezSJuiqzPccWNBrfBxjFL0iOxBj108dt+2L4C1fTfxkptGkHGV1fd4I8ZmqK76Y+
	wGjwcfnxkqSsdjUCCjCioaAk71/WJP93gsPU6tcwEfDtyBALv7Oi/1lq0sMUeXZ8
	+kVjAj1WPP1GW47Ge/F21MubVS9TQyYJSvL64HU/6gPggx/j+po4QK3eyBJduHs7
	H0/GgeUprh1dRlLmk/bIt4Lqp+gb85L6oeK1u5c8qnXb2XDvtcxpLGGlev66FBpj
	+c7QTWlmQDmKBvDlDq3hnJARBs5s/MY74oJJMJsuYB4Kzm1MXspsmXLDCLOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772055038; x=1772141438; bh=JhdIQflnUl40nH/QFvgdYtu8vs/kgoinYk9
	fn7ZfmhQ=; b=uVz4TUo/IehaEvTpcZtrOfjGyAU+PitHHWmm1SqV+4PFPDnQNNu
	nT6uk4wNuloWCjSszWtZPmFmbqahPYpgt3g5bxqdN+QuKKZp9XecX7gY3JM5rB9d
	OctDOj/TEO6FrIqP1u5U4zokTN2MolQgVOxwQTozSI8o4uwZt2d6PmcIuerJHZ9p
	1CLLDO4n63VClzJHzWIdBdkbybYD+qAfDx5C8A1W82tVgkRzqbZ2lmTw8bnqJocE
	dY9SoX3zpRXIrv/nPPFI3ZJD7hVdm/UmirJEQTvPanfHUoy+xufi2ap2vaERtDtv
	PrtGXbFAYvcF05OGu6nszLiqo4C9NGvIhtw==
X-ME-Sender: <xms:_mmfacLcEMjlXpBgF18D8E127RUkhRBznqAN2b52mAqhvRA_jCbDcg>
    <xme:_mmfaTAxiS82oituKR9H-krYVnzJp7zpV3y4rh3YnTnHayXO65yMrJR76RnRekR5n
    BMH9vSdhHd_O_Zk9zMPs-STqlQkdF7ShsW1R8yTve7ZPE_ugoyQwA>
X-ME-Received: <xmr:_mmfaVCk7RpPrw7vLjjXsV9tF7-xzGXIjQ6ENcMnsA53pGMUAD7B92yLM5RzJspj3PKlZvyKznCv0xu-0e8AJwYVK_1BeZ_VfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepghhithhhuhgssehprghulhhishgrghgvvg
    hkrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_mmfaVAAMFiy1oZxHAul0uNkeLFR91QZ-sCnGrv-yzgpCy3YQiKVgQ>
    <xmx:_mmfaQq_jYt_-CTnSgNCmY4M49RUysB4zKRWaLveg2jFvhIOd2w9EQ>
    <xmx:_mmfafmsMZJEkihoz5LCF5l25EfZAaYWomTI-J0BJvzzNaIF6ITGZQ>
    <xmx:_mmfaQykU5rrDzX9SCerQk7w8XF0nmuA-SjZqL2HxalIKg5kgBzZXQ>
    <xmx:_mmfaQdPe-F400NhGI1NkXeW_UyuZYjoCr16x4pyHnYGTT-NoNGj8Dql>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 16:30:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Paul Tarjan
 <github@paulisageek.com>
Subject: Re: [PATCH v6 05/10] fsmonitor: deduplicate IPC path logic for Unix
 platforms
In-Reply-To: <ff31e359a7070c8d410518da0230ad0ecae7d771.1772050636.git.gitgitgadget@gmail.com>
	(Paul Tarjan via GitGitGadget's message of "Wed, 25 Feb 2026 20:17:11
	+0000")
References: <pull.2147.v5.git.git.1771896704209.gitgitgadget@gmail.com>
	<pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
	<ff31e359a7070c8d410518da0230ad0ecae7d771.1772050636.git.gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 13:30:37 -0800
Message-ID: <xmqqqzq88q9u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Paul Tarjan <github@paulisageek.com>
>
> The IPC path logic for determining the Unix domain socket location is
> nearly identical between macOS and Linux.  Both need to check whether
> the .git directory is on a remote filesystem and, if so, fall back to
> a socket path under $HOME or a user-configured directory.
>
> Merge the two implementations into a single fsm-ipc-unix.c that is
> shared by both platforms.  The unified version includes the worktree
> NULL check (BUG guard) from the Linux implementation, which was missing
> in the macOS version.
>
> Update Makefile, meson.build, and CMakeLists.txt to use the new shared
> file for non-Windows platforms.

This sounds as if the patch started with two IPC path logic for
macOS and Linux, and the patch removes one of them and updates the
other one so that both platforms can use the surviving one.

But the patch seems to indicate somewhat different story.  The code
before this patch started with a single macOS (darwin) one, but
because it is mostly applicable to other UNIX variants as well, the
patch renames the existing macOS one for unix and makes a small
adjustment (namely, asserts that r->worktree is not NULL).

Perhaps you started with two separate implementations (possibly with
a new one called UNIX that was added by largely copying and pasting
from the macOS one) and unified them, but that history does not
exist in this 10-patch series, so the above story would need to be
rewritten to say what actually is happening in this series, e.g., we
realized macOS one is applicable generally for UNIX variants so we
are renaming it from darwin to unix, or something.

> @@ -2365,7 +2365,11 @@ ifdef FSMONITOR_DAEMON_BACKEND
>  	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
>  	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
>  	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
> -	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
> +ifeq ($(FSMONITOR_DAEMON_BACKEND),win32)
> +	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-win32.o
> +else
> +	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-unix.o
> +endif

Makes me wonder if doing

    #define FSMONITOR_DAEMON_BACKEND unix

for macOS and then keeping

	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o

as-is would be cleaner.  

Later, we can add the same "#define FSMONITOR_DAEMON_BACKEND unix"
for Linux, perhaps?

This is doubly true when we look at the build recipe changes to the
meson one below ...

> diff --git a/meson.build b/meson.build
> index dd52efd1c8..8de795f9d4 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1332,11 +1332,16 @@ if fsmonitor_backend != ''
>  
>    libgit_sources += [
>      'compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
> -    'compat/fsmonitor/fsm-ipc-' + fsmonitor_backend + '.c',
>      'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
>      'compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
>      'compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
>    ]
> +
> +  if fsmonitor_backend == 'win32'
> +    libgit_sources += 'compat/fsmonitor/fsm-ipc-win32.c'
> +  else
> +    libgit_sources += 'compat/fsmonitor/fsm-ipc-unix.c'
> +  endif
>  endif

... which would not be needed if fsmonitor_backend is set to 'unix'
instead of 'darwin'.
