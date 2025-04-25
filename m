Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CAD281501
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745594288; cv=none; b=cP2koFLatSJXp7Gb3vhFPJnubawiFfNxOTeH5hh+9lsA1BYg6+KGeRmAFKlxhkQTVvrOqYcErQheL13rl+McK39oX8D9BSAaneZg5WpmeHuJ1znLzEfjbMVp+rVqg9BF0M0dtXMZTyeYaJYM3MAuiPSg52mGUvt/Gisfb0TSZ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745594288; c=relaxed/simple;
	bh=NJpmFp6tlIBDAgIWLpoCTHcXgTDyIPIYCQ4NO1mb8ec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZrLNIGAQstqqq8KL4ahjpYwziyYNeAX/4WP/mLWVZGu5njKIjE2Uv4HHG2Qwph8GZFu/Im5fdFgxa8F957TQ3vInQrqNYRELVqCvDnPKF8+DlVa5lPa45+TQBgr0xQm4LZr9S0DDzXhjnf0MI8iex2MyvgfzsGG5BJEwE6Tmpoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e0mUGXKc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UKQqZXD1; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e0mUGXKc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UKQqZXD1"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E99B61140122;
	Fri, 25 Apr 2025 11:18:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 25 Apr 2025 11:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745594284; x=1745680684; bh=TDgOdvO1jN
	wzmzJ1L0vCqeaQsaGFGUXS4XomR2wziOQ=; b=e0mUGXKcPhpkCzOgYnewqRkvQ4
	eJgRgpB8PllhirdbXKACmD32pklYmgdpTo0KIQB19korIrgiKxspKEnijQrBKj+l
	MoKqitpMa0igfTMFyShXgQ0PkiyUqo2oXPCpg/ga2k8jhdj/rDUwYSIATypiW6SN
	VIKxqyk9fIkgPsS/GgWH9CyC6pmR/d5TSo7bnGqPqPSt5RQZPXrVsPgB59WQtDvL
	KibpR/d/H7wsIFYrQPUuGM3/6byDK7X2BhPRb7QgOJ2FCcv/D1kymldRHxyVPT/5
	McNloyJf2LPFKTFTZEjuqi2ithzLXIdXBKl+EUX2ZftrrKmUvy2ZzxuJ3XkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745594284; x=1745680684; bh=TDgOdvO1jNwzmzJ1L0vCqeaQsaGFGUXS4Xo
	mR2wziOQ=; b=UKQqZXD1HLdjCN+DtS+d+iIYux/fyE3MqaWoGJOMUnDHWq2DX7F
	+Brjy8Wq3m30iMY9BzGi37yv/BBErlAyTO9tkwCLC09uZBq0k/j9X+g+0rnqdQ2b
	ne6fDrb2YnKwgNpMiaUAJCN15Z0GKxneFErtrjBEJ51d6N6HZRJCh3Blkm7CAAD3
	crOBqwD8Y8ca+be+oPjgcItC8IuekgFBlu7Xo7sfGZFWzLwPcrS7okRLUrSMc6bw
	top1rvbGoTp61F4CD1UHgIpPSO36LBcxsxkHhxWIt+EOEQmEZeuogJFzWKqJWUfU
	tFf/dyDRtKOz7UtnIK3F1M0Ub5lT+V7VarA==
X-ME-Sender: <xms:rKcLaK6xkltaJkhSc4oMQE0NJfEd7JNroTTCZ70vMA0b2ruslEZN4Q>
    <xme:rKcLaD4XdsH97LG8eJEX0VnK6wOY_6p8XiZVAXV8NZ9MjBbA8eRLM7vTyKZodFfIR
    zYw4kSgfhwZqCh3KQ>
X-ME-Received: <xmr:rKcLaJfxsaAMrAZXvv79Bjiwfpqw-69gD628xruHXtYcEeyiZEFuT9hoq_HI6u4G99DXpG6XYVr0_oGw3XNdzdcqsiiMrzWmLDl8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhn
    sehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rKcLaHLz6DhS7yvCO1lNctWGsumdZcFRp83WpFAZX1sxq98HnRJ_Jw>
    <xmx:rKcLaOLXQws73vRMeI8YeYRrI3cPB0xheImg3isHGxX28fSFSPAz_A>
    <xmx:rKcLaIyTFkHyRmx3U1z9jAgFBAvgOat3qoICeU73ZMZZArUVZhJA2Q>
    <xmx:rKcLaCIs2t7qrqxJWePvW9iHusWwLe-AlfNgfyh3ticldAQVuVhcnw>
    <xmx:rKcLaCsNU0iKoO8sLTMdKr6eP5Uboo0XSr3GxIRSFqOono16KEKzPOZD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 11:18:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(win+Meson): build in Release mode, avoiding t7001-mv
 hangs
In-Reply-To: <pull.1908.git.1745593515875.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Fri, 25 Apr 2025 15:05:15
	+0000")
References: <pull.1908.git.1745593515875.gitgitgadget@gmail.com>
Date: Fri, 25 Apr 2025 08:18:02 -0700
Message-ID: <xmqqmsc4uv6d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Since switching to `--vsenv`, the t7001-mv test consistently times out
> after six hours in the CI builds on GitHub. This kind of waste is
> inconsistent with my values.

With mine too and I would presume everybody else's.  I've been
annoyed for a long time by one of those sharded Meson-Win test jobs
that hang around until timeout.

Thank you very much for addressing the issue.

> The reason for this timeout is the test case 'nonsense mv triggers
> assertion failure and partially updated index' in t7001-mv (which is
> not even a regression test, but instead merely demonstrates a bug that
> someone thought someone else should fix at some time). As the name
> suggests, it triggers an assertion. The problem with this is that an
> assertion on Windows, at least when run in Debug mode, will open a modal
> dialog that patiently awaits some buttons to be clicked. Which never
> happens in automated builds.

Interesting.

So another viable fix (no, I am not suggesting a counter-proposal,
but asking a pure question to see if I understand the issue
correctly) is to rewrite "assert(cond)" to "if (cond) BUG(...)"
or something like that, so that it truly fails?

> The solution is straight-forward: Just like the `win+VS` job already did
> in forever, build in Release mode (where that modal assertion dialog is
> never shown).

OK.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     ci(win+Meson): build in Release mode, avoiding t7001-mv hangs
>     
>     I was surprised to find this issue today, and that this had not been
>     addressed yet.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1908%2Fdscho%2Fdont-let-win%2BMeson-hang-in-t7001-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1908/dscho/dont-let-win+Meson-hang-in-t7001-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1908
>
>  .github/workflows/main.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 83ca8e4182b..275240be5dc 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -265,7 +265,7 @@ jobs:
>        run: pip install meson ninja
>      - name: Setup
>        shell: pwsh
> -      run: meson setup build --vsenv -Dperl=disabled -Dcredential_helpers=wincred
> +      run: meson setup build --vsenv -Dbuildtype=release -Dperl=disabled -Dcredential_helpers=wincred
>      - name: Compile
>        shell: pwsh
>        run: meson compile -C build
>
> base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
