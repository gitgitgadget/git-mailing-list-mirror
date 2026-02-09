Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2908919F137
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770640361; cv=none; b=YXOLHDzDIPADKHbu5HN/nR9KEIqZvwqkUD9lTxvB2iWur0+t+JufESuY2DvAKYCSAotjfy/BgXrY9njsEit6VQHPHY8itry16+0P+oPxRJWrjTSC+ZboWZazSB0hWEkM8nmnMr0hmvL1yri/w6/K59G39vX9EEhWtDrP9/3u4M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770640361; c=relaxed/simple;
	bh=vPSExof7jHvAP9fYFfJAH+oURQCvbayYuxl18DXZGA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeKRQXJigqV+K+K6mKBn9719JFiOLqD9B9NMT2HOjHA8dieWpMNRp5uJFu6E7dmGyXNCpPw1v9fYwrAIgA85BO5lxwSzlPR6Lv9cb3z4KCRIUnrI4ciqX2YRF2wj2sKRuH+dTTff4WtHZNHYjrzEV0AVUKXyC4Dr2LraWBTLWe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jJrjaz3F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ph/0hMAP; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jJrjaz3F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ph/0hMAP"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 522D61D0008A;
	Mon,  9 Feb 2026 07:32:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 09 Feb 2026 07:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770640360; x=1770726760; bh=++vPJkr/uQ
	i57kjzO5nN2wGi6EAAIqr7Vrycu12ZPHE=; b=jJrjaz3F39R6QXt1INmIsWbPQm
	SD5oUnsCIp8mt1uQoVnJQxZcJ7s8Yxsl9gsV2i2WTaEaEAy70MiF/6o7zSuwjxES
	OASwcPOq0m/q+T7xxczta7VfFqhGe8uQpwR7qXjsPo1fheEVoFfrzD0cKCQ4ebia
	0iwuGu0mQDVvTDEbdy6G23+l4p16gEl1ZXEuWk+hBMwzt7BbhwHk1Z+aAt3JvJ1T
	PG5YToOO40d2hlqzFlhhyUBWIBNm1lSvKzyrpZLfENZq0qw18E3lYs7aBv2uPOOu
	YKE8T6w/Cm0oq4SNaqtW62XMs5NGuBO8RaLA13NV9bsyVpjObyWIcKTZVxEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770640360; x=1770726760; bh=++vPJkr/uQi57kjzO5nN2wGi6EAAIqr7Vry
	cu12ZPHE=; b=ph/0hMAPbEVX46e/io5nCw+snVRmMVXEk2N+E5wrGKRRy0iQ5qX
	KSmKRAQr+yOTvGJXi8vM8lxPRLVI0EreUEjBG+6WteQAM6YV7tW/mIY0DDD0/jDf
	fHeaVx2sFOqYSs3Ki9ogpdDl5EqG2n32h5WRQ3UQIYmCP9iIbeQfz7l1kw/1RJWa
	w/x4CbXuMexz3orhlpJNPLE0xar45x5pnu5VFAKOagebESie05rxeZ3q/HMDbRfd
	S8h3xXzU0kgdZZnWmM/DR1cJdqhzRXiYQ9Qjm+F9YpQ0f7KDIetfIQKq3DDFJ+1a
	2diIOs/dGZYzxSoZbJWtjxPQokrFLN11tsg==
X-ME-Sender: <xms:59OJabFyDxi0ibR3ei14e3EJ5AJnKO2ft_Jmlc-jWMQudP4U_gXM3A>
    <xme:59OJaQFflUEiYCrpPrfqCJIegeTgKxMbXGwQn7z63rYkmuwiLBHfiRMJe7TXkfjKr
    NTDpuXeGlPgGcAK8Kde_a7PPlndcucBP9tKzSJ9XS0N-axakJi6eA>
X-ME-Received: <xmr:59OJaQPVQf1eI4fQlQyUFbm8rS_XCxhLQx_GNsqgtEw03OGxDd7aTEKa3p310lVlIEAKCqKcViwvVRSu5mLFy7VzSmkDd0pSn8qqR4fZ4uo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleeikedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdr
    fihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:59OJaXHlvf2t06oxBck_16bWkdtjpK_HGFkOuYV5tlz0Rk7pzy8yqw>
    <xmx:59OJafNA_ZVJMaz0dB_8QShuorug3v_cfx9QSKPdToiK4g8RLSMsuw>
    <xmx:59OJaQ-6YWI1iXM_Xm5EURzBqctbN0bgPCbdMyeP5FkVxKK5wO62gA>
    <xmx:59OJaTTAg6brDmk4hdSEgl7x8N1W7QIEaZ6JVkGWUanf4nkgctl6og>
    <xmx:6NOJaa94LhtQpjnnIEhPoa6XCO8rrF1n9r73dhy_LdgbQOkeqoBataoW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 07:32:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 83e13789 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 12:32:36 +0000 (UTC)
Date: Mon, 9 Feb 2026 13:32:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] meson: fix building mergetool docs
Message-ID: <aYnT4XdQQ2hBEsTQ@pks.im>
References: <604c79018992dee019205741934508091cdd1e47.1770631599.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <604c79018992dee019205741934508091cdd1e47.1770631599.git.phillip.wood@dunelm.org.uk>

On Mon, Feb 09, 2026 at 10:08:43AM +0000, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Building the documentation with meson when the build directory is
> not an immediate subdirectory of the source directory prints the
> following error
> 
> [2/1349] Generating Documentation/mer... command (wrapped by meson to set env)
> ../../Documentation/generate-mergetool-list.sh: line 15: ../git-mergetool--lib.sh: No such file or directory

Oh, good catch.

> The build does not fail because the failure is upstream of a pipe. Fix
> the error by passing the correct source directory when meson runs
> "generate-mergetool-list.sh". As that script sets $MERGE_TOOLS_DIR
> we do not need to set it in the environment when running the script.

Huh.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> We should probably change the script so that error is not ignored
> as well. I also wonder if we should use something more exotic than
> "build" as the meson build directory in our CI though that wont make
> any difference if the script does not fail.

We probably could, I guess. And making the script more solid would
definitely be a very good step regardless of whether or not we want to
use a more esoteric build directory.

> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index f02dbc20cbc..d0e557c2078 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -353,13 +353,10 @@ foreach mode : [ 'diff', 'merge' ]
>      command: [
>        shell,
>        '@INPUT@',
> -      '..',
> +      meson.project_source_root(),
>        mode,
>        '@OUTPUT@'
>      ],

Makes sense. I assume that this is the only change required to make
out-of-source builds work?

> -    env: [
> -      'MERGE_TOOLS_DIR=' + meson.project_source_root() / 'mergetools',
> -    ],

Hm. We indeed set this environment variable in the script itself. I was
a bit puzzled at first because we don't export it, and it's not used
directly. But we source "git-mergetool--lib.sh", which in turn uses the
variable, so it shouldn't be needed to export it.

So this looks like a nice simplification to me, thanks!

Patrick
