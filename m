Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD3E25C809
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 04:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770699573; cv=none; b=PvQ1ybsgiaoT8yh3pcTMbXpbJepSV/Shc/CgppiPCK7/+zNjsqP74d6kKMFhKLZxJJhpc8Jnd0nFyb4PdD5qlNCSqEq5z/2ibF78g1TL9Ft5UzPtya6s+fQwsDmZ/eI1b5+iO9YLLOt+D62/w4iXgaMr1pHMfx/VLbf0f3g2Umk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770699573; c=relaxed/simple;
	bh=vcAU5qdIeZTtzx2BV9i0L+2GdLIDnHWrbzNX0gKNTtE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f1Yy6OW4FYhTJ/CUDVTInIUWl4knC/ctbHcXLBYCdaryLNiWE/SZ+6mn9GVv3s3DndHJGKlot9rOpJIE/9MKyxhC//Y4JaQrMWfbt6qKfMPD/0JV7u4kzVmtb4Fzj03ICht0zrHe5b66GU+ErrXlM9C9OZXOkwneUwewEfxiON8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LaSf0yVO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=khHB8QHp; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LaSf0yVO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="khHB8QHp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 087C91400149;
	Mon,  9 Feb 2026 23:59:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 09 Feb 2026 23:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770699571; x=1770785971; bh=+Owk17VTpX
	ef9/wNwBjoix6EOYXkbREL8KJC0P+2ny8=; b=LaSf0yVO6Gb2EaB6h/vAdvo+Bv
	FXWojpN3Kn0GRWc4Z4Hj7ffUknVrPKnWcMIksV5XJ0IDnin1pQkLWST2GE2SeSsJ
	sAZifgXNt7P1imEc1IqQPm/SgDtoMoRv+Gfl7zqcicaqNjHuK0LxI00NWqE9vL6+
	7UOsZ6ZT87YM1073sN3/2TRRiavL8KD6ufewHCcEbIsQTdQRni2Ugk8WUbCJnvCu
	3GxX1JmcSX0c5f+3TzskmxcqD6gLFbp+Uq3QCryxM7mWAOxpAKfTlTsD5pZMxBcG
	HdCSG2HZOc9TaKvPqtZm8quneclvgVq2pvLIXFQN8egax7I1fULTuwy1lZqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770699571; x=1770785971; bh=+Owk17VTpXef9/wNwBjoix6EOYXkbREL8KJ
	C0P+2ny8=; b=khHB8QHpK220TRPlP3kbq19rRwtZcfAwDIlKmCq15RW3pJyRa8k
	DRlPOIyG3ZaLQVpoQ0ILZgBUcQMMoHEnFJX1wqawB+Fl3CZ/DK9Z7PummdNj5Exn
	AvSl8WBra0YK8VN0yVg/Kj4NAzD2KAqcjT24cFdlpdFXSMp7BnvrRUAY5H9Ggoie
	nzbXQxvfyJ6Udzw6hlzhNapF7DZTCpJoTuZMu3tmlsIDYdybHm+pWgv0Et1uO4Ex
	CtoiQLn6JTRS+IyZUQfD4GPFmAEl4uwZ8iuAAWGulxRlZOKZ2p2n/LYBKkZmNhY2
	oNsTaxIF1tX659KtjgPG2YcXE7JPiO2HHDQ==
X-ME-Sender: <xms:MruKaXw7XbFkh8adY31CrIgO86sqPC3h8rEj99SZ5ellbwxtSDmKzA>
    <xme:MruKacN5ADr4dR0uJzPc8CfsRlW6s7y-SDFCcdyOEQL0qcHgAn04SR3WQ0KNQKAsP
    93QrmWFlJOBUiReFY4Vr-msu5tRxoLXeZonLfc9SRo4oqGQDfxl5A>
X-ME-Received: <xmr:MruKac8nRu6Z3cPcHKgdKjXCZbWMYi2JuP53AWf_vntHSqy0iTVcEbbUCj4ZY-cGnYzOIuDmLBhRNXenXOdtXkNGFggmsXA5Pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleekjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddv
    feesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhr
    vggvrdhfrhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MruKaZ57tdjp8RdsL_YpOyCXdl-ra-_Vl6kZBrrvYkYLpQ9j8RTYfA>
    <xmx:MruKaS6UtSxtGdg_ptUYooNfmEqNhxHYprYDllx4A0AO9wlekO54-g>
    <xmx:MruKaSq8nC2u19MlXOA29PQ7nSMhR5dHmUlCjhTR621QTgWxmrJXQA>
    <xmx:MruKaTO6NVIzD8WQDb_ruych9KAzwSIVyeI_0PFK05-CVOoBi2gHug>
    <xmx:M7uKafm83qMlIHPHObcObe8kYJvdldFy0FbiUxdG7xpWj0abf9-pwTME>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 23:59:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Phillip Wood <phillip.wood123@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/5] [RFC] Make 'git config list --type=' parse and
 filter types
In-Reply-To: <pull.2044.git.1770698579.gitgitgadget@gmail.com> (Derrick Stolee
	via GitGitGadget's message of "Tue, 10 Feb 2026 04:42:54 +0000")
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
Date: Mon, 09 Feb 2026 20:59:28 -0800
Message-ID: <xmqqldh119e7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Problem: 'git config list' doesn't respect --type=<X>!

;-).  

As there is no "inherent" type associated with each configuration
variable (in other words, type of a particular configuration
variable is something determined by the caller that wants the value
of that variable), "git config list/get --type=auto" would not work,
but it would not be too bad to allow "git config list --type=path"
to treat everything as if it is a path and having to filter nonsense
out of the result (like "core.bare = true/false" or even "core.bare"
without value that means true, which may make the "*force*
interpreting it as path" approach to barf), which is an inevitable
consequence.

> This boils down to the fact that the iterator function show_all_config()
> doesn't call format_config(), which includes the type-parsing code.
>
> This wasn't super trivial to update:
>
>  1. format_config() uses git_config_parse_*() methods, which die() on a bad
>     parse.
>  2. The path parsing code didn't have a gentle version.
>  3. The two paths ('git config list' and 'git config --list') needed to
>     standardize their display options to work with format_config().

Thanks for dealing with them.  These are what I would have expected
as part of the "inevitable consequence".

>  4. Finally, we need to filter out key-value pairs that don't match the
>     given type.

This one, however, I need to see the actual code before commenting,
as I do not think key-value pairs have inherent types.  The _only_
special case where you can tell what type the thing is is the
valueless true, which we can safely say is inherently boolean.
Everything else is text string, sometimes interpreted as boolean,
sometimes number, sometimes human-scaled number, sometimes path
(with possible tilde expansion), etc.

> This is marked as an RFC because I need to add some more tests and because
> this is a behavior change! If there are any tools currently passing the
> --type=<X> argument to git config list then they will have a change of
> behavior with this series. It's an easy workaround: drop the --type argument
> or add --no-type to go back to the previous behavior.
>
> Thanks for any and all feedback, -Stolee
>
> Derrick Stolee (5):
>   config: move show_all_config()
>   parse: add git_parse_maybe_pathname()
>   config: allow format_config() to filter
>   config: create special init for list mode
>   config: make 'git config list --type=<X>' work
>
>  Documentation/git-config.adoc |   3 +
>  builtin/config.c              | 130 ++++++++++++++++++++++++----------
>  config.c                      |  14 +---
>  parse.c                       |  24 +++++++
>  parse.h                       |   2 +
>  t/t1300-config.sh             |  26 ++++++-
>  6 files changed, 147 insertions(+), 52 deletions(-)
>
>
> base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2044%2Fderrickstolee%2Fconfig-list-type-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2044/derrickstolee/config-list-type-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2044
