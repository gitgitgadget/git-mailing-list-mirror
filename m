Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC2A20322
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742326467; cv=none; b=Evr/bCqStEYF6g3b9bry9pL5TnhFrS+PbI1OpbAcExF2cfFQSVU2XLLi8wgZplOJOUN31hdkGf1XKo1V5M5kJlUUxYiZitFzGGgjLaEuwgv9Bus0s8k9vFtDIL34h1ISiP+zD0gjQUyuftgtPKEw0Rj/pxOg180y2inw0Lnjjkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742326467; c=relaxed/simple;
	bh=/BMHNedJE0B1of6oz2s+a+eeRww+MmOwWG78pjin52A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dcX30sScPkxidJLpJxc7WVCq5C8wMss7UNNC1rECikGo7IEA9fZDX9p5NFNXom/PAFcdUVsrrNiK9/ew8EGCxFFyQpYZyj1dCViilocz8+rlG11D3I//soTf2FNRb2NLyVvRM/Ndu2ck29DIcp13WvmYuSJo6PTO8KDBq02pV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eMSuVzDw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=At51YP4z; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eMSuVzDw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="At51YP4z"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id AE29C1382D18;
	Tue, 18 Mar 2025 15:34:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 18 Mar 2025 15:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1742326460;
	 x=1742412860; bh=0Hb8QGyJT170wP6IG9D8xVCxrycNXL2wy0r0IZ3oAOQ=; b=
	eMSuVzDw3VPt0HtYpzICyqXamRVTwbTd+Pcjx2rBm7uaCD8/nqkpchvyBb5rbM46
	txm0l5ZDZ3vlcvDMy/wfzJWWjZA4m/aQd6Buj7EURnlk5NXzUe35+gNYIW/ihhlu
	BKEEU72a9YZwB/2tDsqy9B+zpk1UTCqqfyj1DFBVeBKt8JbFM7v1YAlrV96AyVV4
	g8qky2bxmwKml/bnJnS3yAaFK38NYHqa5nruHUgzypBY1vm0OM+Y1YGnJgp90bw0
	RGvlV773pvgOf5tZNonvIo1Vq2T7fgTo+LDJKyOS7oHJBZzxR/t9u655c6t+b2SM
	BisTd/OtmHpAubwnu3biaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742326460; x=
	1742412860; bh=0Hb8QGyJT170wP6IG9D8xVCxrycNXL2wy0r0IZ3oAOQ=; b=A
	t51YP4zxO/bX9DK0uhH3E/0VI42HXcCkMSe0E0bsCoMzbtxro9MPYUekVjCQai8I
	W0NfUKtScyyYFym93rTqXQaObF+J59u1pKVc06kREZVet/M782H7V/Rbl0EfwyFo
	26+IZEh2tVv8GJCqdjjRBnhcGIMye29akcs4aWlimZ43coliSfyjSCrTJwGR6Sid
	wn5pPEUK65JLeMkTOsdImhxSvgsfxABpNPRF+0GI4xEliB8+JK4er2N0OmY/Gvfd
	E4Q/fm6hFRJ1GHXZCH11iVhSTSh6goM3CGsjbqhzaMbrnE5VjNimyS3u+/kp7ENG
	9XY6WrbGxcsh1WYUQCksA==
X-ME-Sender: <xms:vMrZZ9z-oTCZXDzdbebyB6rgc4vIGEx5ypWM4pfdprJdB4BecNXuPA>
    <xme:vMrZZ9RHuUJgcCIrMQJT2fJxnG0WPqOqIv8q1ka3vzWbFLxLtd09d9zza9iSpzopU
    nGI6sN8wpCC1DOzyw>
X-ME-Received: <xmr:vMrZZ3VlPOZMnFrAV0fXmyxZ2EHfT-dZYLBp5i3qFbcq1ubcRpOVvcpgCTxaOFkzqQ2hZkdxWOMxt9j5g8y6TZ-W440E-vDMBrlhWC0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeefvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvjeehudehgeelheefieevtdeg
    leefvdfftdevtdduffeikeeiieejvdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhi
    thhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepshgrmhhprhhihihoghhuihhnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vMrZZ_i8nY3uauPZ6L8uD2l4otXpFDzxddyoY7hgTnHQlzyMe4xBEQ>
    <xmx:vMrZZ_AJ1IQh0qerldhhRHVy3ZF5UjkHTkaEV-FmOmLnbgKd8e5VQw>
    <xmx:vMrZZ4J3XNlIUgTqVgL0O0IMS1c_juGT302CxWciCsDteWVL3pNyug>
    <xmx:vMrZZ-A_M_pZbkBCp6PQ_n06sRXgjWjkr6_jKUdAGaHccfbQycNpCw>
    <xmx:vMrZZxBvFGIJoCO6qOC-n92Pcb6sFtYGOp6Vg7tAsJS_ZqBjkruO60-g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 15:34:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Sampriyo Guin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Sampriyo Guin <sampriyoguin@gmail.com>
Subject: Re: [PATCH] [GSoC Patch] Modernize Test Path Checking: test -(e|f|d)
In-Reply-To: <CAPig+cQrCdtN4+hyZyPWQuvnoetarbcgkwKU7cD-TpzfzK=jzw@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 18 Mar 2025 13:39:35 -0400")
References: <pull.1918.git.git.1742299111861.gitgitgadget@gmail.com>
	<CAPig+cQrCdtN4+hyZyPWQuvnoetarbcgkwKU7cD-TpzfzK=jzw@mail.gmail.com>
Date: Tue, 18 Mar 2025 12:34:18 -0700
Message-ID: <xmqqiko62kw5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> Thanks for submitting this GSoC microproject. See comments below...
>
> On Tue, Mar 18, 2025 at 7:58 AM Sampriyo Guin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> From: rimo <sampriyoguin@gmail.com>
>
> This name should match the Signed-off-by: name. Since the "From:"
> header is generated from the author information in the commit, you
> probably need to adjust your "user.name" configuration to fix this.
>
>> test -e changed to test_path_exists
>> test -f changed to test_path_is_file
>
> People reading the patch would like to know why a change is being
> made, so this is where you should explain the reason (for instance,
> "the test_path_* functions provide better diagnostics upon failure" or
> such). As Karthik mentioned[*], read the "Describe your changes well"
> section in Documentation/SubmittingPatches to learn how to craft a
> good commit message.
>
> [*]: https://lore.kernel.org/git/CAOLa=ZSkMp+H9PZeBZXK47=fx1sH=S54AuPT=oUosm7F7V8MGg@mail.gmail.com/
>
>> Signed-off-by: Sampriyo Guin <sampriyoguin@gmail.com>
>> ---
>>     , Jialuo She shejialuo@gmail.com , Christian Couder
>>     christian.couder@gmail.com, Ghanshyam Thakkar shyamthakkar001@gmail.com
>
> It appears that GitGitGadget didn't like how this list was formatted.
> Instead, place each recipient on its own Cc: line.
>
>>  t/chainlint/chained-subshell.expect | 2 +-
>>  t/chainlint/chained-subshell.test   | 2 +-
>>  t/chainlint/function.expect         | 2 +-
>>  t/chainlint/function.test           | 2 +-
>>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> Let's not touch any of the "chainlint" files; they are checking
> validity of a completely separate tool ("chainlint"), and have nothing
> to do with checking Git itself. Instead, pick one of the t/t???-*.sh
> files.

Yeah, these changes to make them use test_path_* are not "fixes" but
something else.  The first step for a contributor is to understand
why "test_path_*" are preferred over "test -[def]" and in what
context, but touching these files shows that such understanding is
missing, unfortunately.

I find the "as specified in Git Microprojects" in the patch
description the most disturbing,

    A simple fix as specified in Git Microprojects.

as it may be an indication that some introductory write-up is
misleading potential students in a wrong direction.  Our mentors may
need a bit more handholding at this early stage of dipping your toes
in the water step, perhaps?  Or is it up to the aspiring students to
do their homework?



