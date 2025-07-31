Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7543218ADC
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753994983; cv=none; b=PEIiI7KChn+SUAdLp9FXhGM8g3d/B5U8mXbNZHDMl73SVZJQ/Ky5VwAc5tMkEIpo51Vxa+g5GVXDlZawlll6Q3HCWvP3sABnUKw0X/ETa7bEuhpKMAGkq3U2VWrOn9uEDM1BTys0Er9hxsDIHaIZv9lTzTy2Q2jJ0sCt/I5oF2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753994983; c=relaxed/simple;
	bh=SsTs0mCRh4vtZ3XKq2kPoOmbBTr/PhDKuD4C/cPMwhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TtiksHr1hdOuJS0xmfrd58F538zOEz1ahjX7tMZ517wBU3tB6T7gqv/j1ixhd9Td61MeVVo5xiCuPpWQUldibdyN9gPUpuIvVp0MzgQj8N+6rk29UDi+R4lY5i2djavD1r75fH2dca8MIkFklagFVuuxAyPxqg7H4bAIVDjGOzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gORAuGLf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CM9bMtsZ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gORAuGLf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CM9bMtsZ"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id B874BEC1516;
	Thu, 31 Jul 2025 16:49:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 31 Jul 2025 16:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753994979; x=1754081379; bh=s9PUfBDyce
	Dycrq3VaebZVntdeFKjO2AUJDSXfvSkMo=; b=gORAuGLf4JzEVuSnjMZf687xhg
	Bul2vo99+IQKhW1N3cuIhZiUumTCH39ChoJwX+wODnKS+e8em7QgHxot3r90DKqA
	m0qXMFd1+VutzY7UOhaiSaH8nXUFszAUKuLrMwX9RKzNirqLUYewbbuTWAODRXSx
	YgxGFSzm63NuA4drunx4o2Sj10Rvklc1DwOrT7gf4DiW2W+x3wVVc8eaYSvAYAtg
	GItHdfDgLPb2Mnw6PF8IfecNmOHXCwYZw+2l6lh3NNAgYZ1lWiDhnUfbYSTVxNmf
	+zcCVj1acafEExB3sAR93MUFrNhYVJ94fcyKstMMDaCOp1cdC5IxSb0Gt4Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753994979; x=1754081379; bh=s9PUfBDyceDycrq3VaebZVntdeFKjO2AUJD
	SXfvSkMo=; b=CM9bMtsZIDad1phfDP1RMJq3MxZ1evOENiyaNqoPdZhpsCzZ69V
	tvoSFitqKf77jf7xuip6YhM7r9Q5s0Prk6FZlwbp+KAYFmXspItSpaD+Wbp61tnV
	PdG/NGW1JsOmw5wFMeh0xW3bzvHRrCZZ2MvmNfwjlVzZqImnOGCh37jEgYbWSgI1
	XgjrB10OYuLA7ua9sFNp+jWojWpXsIkrkYflIdYPxnDeYjOiJsTUL387QD3OMS5L
	KMeJOvzzVBmWdvm+iIZYiYQ/6N1WKiF1JBrVhtguVUzOKXnr5KT+k0aBarIg4HCe
	WuXllXdUzRhsNFAESLjIW5pHg/l2hxMSaTg==
X-ME-Sender: <xms:49aLaNaObM7a62iGBLHVIxamdv3NR-8e73HZIQeO5Um8C0vDIv9QlQ>
    <xme:49aLaB_xGJm2nHQOqVzNqaGvnJyuDC27VBBkJu4frYZjKTismzhsmgltSDX5QiZwz
    VUw5dpjw8J4bzWc7w>
X-ME-Received: <xmr:49aLaGbyg1H0N9d-sloTU0RdscjCvoWd5KoJB4HHpcZJdVxarZ3zmscyhFYVfMyoCltxBxQbnNPJZz4wY0_uGB1xjZTnkPy94rf8t1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddukeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:49aLaNOtsnKreTSaahzdYANnaDPEa2WgPBwhL3sFyZ1Esl58886UpQ>
    <xmx:49aLaKD0EOlXojUbvqtafzRp9gXdDa1HACEmOJe-LuWbPzcBJYmUQw>
    <xmx:49aLaMJDWi8JFGBpQh-sJINucqBdehObBPMtt7bP5Vq-IE0Z0IX_HA>
    <xmx:49aLaLMgkIPsHztydQyHm8XWrk0-KLC03kiVAQTQVIkBKWltVCFCCw>
    <xmx:49aLaNHTIsyGBW_KAB-SRAaBuBOn3IEg-euSrvN6HQlgO36T6wiKU7No>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 16:49:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Ayush Chandekar <ayu.chandekar@gmail.com>,  Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>,  Taylor Blau <me@ttaylorr.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 1/3] breaking-changes: deprecate support for
 core.commentString=auto
In-Reply-To: <a6355451d4b22730ffd20eb5ea5e820582d20b03.1753975294.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 31 Jul 2025 16:21:53 +0100")
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
	<cover.1753975294.git.phillip.wood@dunelm.org.uk>
	<a6355451d4b22730ffd20eb5ea5e820582d20b03.1753975294.git.phillip.wood@dunelm.org.uk>
Date: Thu, 31 Jul 2025 13:49:37 -0700
Message-ID: <xmqqwm7oozku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When "core.commentString" is set to "auto" then "git commit" will
> automatically select the comment character ensuring that it is not the
> first character on any of the lines in the commit message. This was
> introduced by commit 84c9dc2c5a2 (commit: allow core.commentChar=auto
> for character auto selection, 2014-05-17) The motivation seems to be

"5-17) The" -> "5-17). The".

> to avoid commenting out lines from the existing message when amending
> a commit that was created with a message from a file.
>
> Unfortunately this feature does not work with:
>
>  * commit message templates that contain comments.
>
>  * prepare-commit-msg hooks that introduce comments.
>
>  * "git commit --cleanup=strip --edit -F <file>" which means that it
>    is incompatible with
>
>    - the "fixup" and "squash" commands of "git rebase -i" as the
>      comments added by those commands are then treated as part of
>      the commit message.
>
>    - the conflict comments added to the commit message by "git
>      cherry-pick", "git rebase" etc. as these comments are then
>      treated as part of the commit message.
>
> It is also ignored by "git notes" when amending a note.
>
> The issues with comments coming from a template, hook or file are a
> consequence of the design of this feature and are therefore hard to
> fix.
>
> As the costs of this feature outweigh the benefits deprecate it and

"the benefits deprecate" -> "the benefits, deprecate".

> remove it in Git 3.0. If someone comes up with some patches that fix
> all the issues in a maintainable way then I'd be happy to see this
> change reverted.
>
> The next commits will add a warning and some advice for users on how
> they can update their config settings.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  +
> -If set to "auto", `git-commit` would select a character that is not
> +ifndef::with-breaking-changes[]
> +If set to "auto", `git-commit` will select a character that is not
>  the beginning character of any line in existing commit messages.
> -+
> +Support for this value is deprecated and will be removed in Git 3.0
> +due to the following limitations:
> ++
> +--
> +* It is incompatible with adding comments in a commit message
> +  template. This includes the conflicts comments added to
> +  the commit message by `cherry-pick`, `merge`, `rebase` and
> +  `revert`.
> +* It is incompatible with adding comments to the commit message
> +  in the `prepare-commit-msg` hook.
> +* It is incompatible with the `fixup` and `squash` commands when
> +  rebasing,
> +* It is not respected by `git notes`
> +--
> ++
> +endif::with-breaking-changes[]

The above is shown to everybody before the 3.0 happens (and if you
opt into 3.0 early, you will stop seeing it earlier than others).

The rest of the patch looks good to me.
