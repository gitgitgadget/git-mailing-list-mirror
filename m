Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EF42FFF9C
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 20:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763237230; cv=none; b=TBSuYM18wfIxlRzJqEilUXhGmUAfqe8C9DZgIfkJGtte2R6Ou3jP63m9YxPihpVqrNpV8mm8d063I77Gx6Wipr3KrR8D7/P8R5dSzJE2p7ju426bK0QE6BJWWtFIoQAJu/5wCBd4stOYCdmoq2FAF023XUK77c3QbS8uyPzgHfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763237230; c=relaxed/simple;
	bh=fgQte54gJcwKayHe2hdaQF0EoB21tKLE4OJwcDPEvyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=buFxPv0m5DfP3h6mVz5brxuwcFqvGtlvUrzXvX/hzHIEO8QiUI7hFzTmVjJMCLKJeKViyzeG4VstMUmxTpMymlFU0Xcpafma/yHp05IoDa1ydI17hfHVr2Y1+YssMiZ1Z9bIUHDuWA3HVy3JSUyZxwwNvSocB4TCOFLpTt70xqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JAONR9hw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eQbTyUuW; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JAONR9hw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eQbTyUuW"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 648B61D00118;
	Sat, 15 Nov 2025 15:07:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sat, 15 Nov 2025 15:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763237227; x=1763323627; bh=iA2jW5K3Nc
	McT3b82tneJCJSlRZHpsVmriuMuUCGT/8=; b=JAONR9hwuKCkokid1y2G7dktp3
	UnLH9sdcyW8M8rufjKulVTKF13PUAh3FZi7+XUDNExv9EepE4wS7Xf2WX3dsKPBY
	/bbwtduJOHOqy1WACpg+OGc0D+PkNJ0kb5Ln2CVIRnYu3CZXFXycB4+dzMQ9Y2wR
	6xP2zUQhWrapNm5iG6HtpfgoZdF4UqMUrLCxxGaPDFdB8iggPmUmS87ejjkX0j+F
	J3s5gN16xorJyrwnXnPE8do8DWQQPG0vblYuJnyqm3rf5ADcwjnqcw6LSMOi4GDP
	lrJVC3HwBHGt0846mNpd69PkwDKvCkLEs/rZkSDc3IMqqV9PI4IFeSzM9q3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763237227; x=1763323627; bh=iA2jW5K3NcMcT3b82tneJCJSlRZHpsVmriu
	MuUCGT/8=; b=eQbTyUuWFNE03MZDS4PgKVgBQp3xxjynd+Vu+sqw2LpjPxC5oEX
	o1hkyiOB30Iw+cWlYOi2Y26cC6c5t3PzTCUaDh62DgFs3bgrXy4homEdJfElhx2J
	c/74htQlWnsU1I6N0ZOhWnfxrBeOlsQ8AIsWjidIDVxoLoQGfZjDxpe1aeFEYuUi
	yaUK9zlMIwQ6s486tX/3cm0LWWyXNRGft6Due0BQqqB9XpksbsS+AtJnxQwUIUMJ
	5zTUzP9nGKSuywrp47sm/vamiQbrQqseY1vEkbn+YmjF0hcinDhEiGz03u0Vy5Xr
	NICJAGV0mv+68GHhEKxVwArg/XJxfcFe5fA==
X-ME-Sender: <xms:at0YaU8en7WAxnmYCjFZByl_xGxQNQgBG3yCNMipeG2aQAMp0HA4-g>
    <xme:at0YaTui_R9QS3q1yR_0vBu2Q6EklrrhhskfcpRTC-06bxVb1STzRGimjeQ2ScBk3
    M0ef1bm7bPeC8zYd1sdv2017t4lrCe5K86knY3bY1lYjlWKAMNF>
X-ME-Received: <xmr:at0YafAiDaXF1Hl27JZ-KrNIg-B3rcqtuYz2LEHkDSvBtXCtEmOq9yOK98AUhMy3DVLFVYom1zQx5yF_0_ZGYYJdo7XQyBzos84u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudefiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepjeekueejgeetveejteegieelueejieejfeeugeeiteeitdelffdvffehieeh
    udefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughg
    vghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepihhvrghnohhvkhhirhhilhhgsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:a90YaTWOW0ISfBUDhoNgEIY-MhJdnIYIlqIsWvmzQQBn26wbHjaT7g>
    <xmx:a90YaVBg3D70iGf98SlPL2r_Ax3IKywckxLTyhltCFtS5vA9MrjEsA>
    <xmx:a90Yae8vszqYqy9bHB8JYVIlZNu9q952pX5PmYCI6foLHAFqJcVLuA>
    <xmx:a90YaUE2m_VvtytF67VEcNQWFymSLWkPPvSc8IMp9W7WgAlJj00lkA>
    <xmx:a90YaShVbw2-tqjeyB8bz3DJ8qj1MkCG1zwvMfykpSk5vh_StFHvU_zq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Nov 2025 15:07:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "Kiril Ivanov via GitGitGadget" <gitgitgadget@gmail.com>,  Kiril Ivanov
 <ivanovkirilg@gmail.com>
Subject: Re: [PATCH 0/3] git-prompt: add quiet upstream indicator option
In-Reply-To: <pull.2101.git.git.1763232863.gitgitgadget@gmail.com> (Kiril
	Ivanov via GitGitGadget's message of "Sat, 15 Nov 2025 18:54:20
	+0000")
References: <pull.2101.git.git.1763232863.gitgitgadget@gmail.com>
Date: Sat, 15 Nov 2025 12:07:05 -0800
Message-ID: <xmqqjyzrdpqu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kiril Ivanov via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Kiril Ivanov (3):
>   t9903: shorten setup using test_commit
>   t9903: add upstream indicator tests
>   git-prompt: add quiet upstream indicator option
>
>  contrib/completion/git-prompt.sh | 14 ++++--
>  t/t9903-bash-prompt.sh           | 86 ++++++++++++++++++++++++++------


Not about the patch, but a slightly related tangent, but I wonder if
we want to update t/t9903-bash-prompt.sh script so that it starts
with "#!/bin/bash" not "#!/bin/sh" (this is a reaction to seeing
some bash-isms in these patches.  No complaints here, as the test
script is all about the command line prompt feature to be used with
bash and nothing else).



>  2 files changed, 80 insertions(+), 20 deletions(-)
>
>
> base-commit: fd372d9b1a69a01a676398882bbe3840bf51fe72
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2101%2Fivanovkirilg%2Fquiet-option-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2101/ivanovkirilg/quiet-option-v1
> Pull-Request: https://github.com/git/git/pull/2101
