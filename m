Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8895727FB1E
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 20:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079303; cv=none; b=LIVLRmmZ33y/0TO4m0m9zsHy5H+1JgRvX/uANLyGeA6e4C/Z5p7BbZvAVgO/Amvna610Y51dXwTZMKPLeAqCo5rbvaF/aVhEQ/RPm/hXSBpLgz7Npmt2HB+1DdA8rK91mspJYcqeP2z3ARpL6Gxnfol8NRJKdWqUHiR3XN+7GIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079303; c=relaxed/simple;
	bh=Pqa9Lzi155+MySi6ghu9f9rK8BV7b+nUkk5r5fB7rJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bBblPKp08e4HP7u852yDBtm58JYQipxG9Ky2ZSmVbEtJAAhFB7g62ZXDeFBW3F7ig+9AhzteJ65Qaug8SFPafjVR9F8lvo5CVTHzkiBnHDCPafLsFFfd7idMmCvgqa/I9kTAupiP7Pz29VtzDFlNnsXy+MhHQfdvl9vjmWA6vU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e5sN7Gp0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qB43T6Uy; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e5sN7Gp0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qB43T6Uy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 88D277A00B3;
	Tue, 21 Oct 2025 16:41:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 21 Oct 2025 16:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761079300; x=1761165700; bh=kxidqDEFNO
	NgFk3EMZJEznIlVOOyQfVOvTihtqStK2k=; b=e5sN7Gp0W4jq8Ro24i3pzbqH+5
	ObmOj/s4gGjCwYSjH1L8fr4Cc9S459AngFfopDSXMlOYxLm6OLZfwgUlPYaWI2B5
	3e/QeAMdMc+knC5gt6+NMGhJrYg+WGEHQzqai9ZYTRPPmxedUYKkSpisTdwuudpk
	xxpe/kDmgZT6Yfo/lccGOq1Axu8YLQpi6333D338SIAkM+P+bX5LkoDJOKg8KVl5
	VqW6+Asy9JZLjLmOCkmJei68Xf94hjUT1gCCGnoL/bjr3z1INGLmcwzuLi+TFTdM
	YJrvs1J5fq/cNNPdPnVBGzqGEhJ51C8GvyHHs9hQ8ZWPo9atzt7Rol5K3HNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761079300; x=1761165700; bh=kxidqDEFNONgFk3EMZJEznIlVOOyQfVOvTi
	htqStK2k=; b=qB43T6Uyv8yww5HT+JjU2zWP257+klZfxUSjnJym71sD/+6fuxB
	G5FtushF/iD4GJmxMPXfVGFTOz9EDd6KVOpZ6WkeyafOf87XD9yn3bjDi4NAq+5g
	pXNokDeDvKytqdbMocqnLz8JlrhculRV5N5h3kJQKB3LiC6ZvXxDQ4k0OH8Emn/0
	Rx2NPH8kvurjxDQ9uos5Yi/u4KAbSlCXDcrKiSqThP0esbB42/vOYJumNKUFExui
	D+maC/KJd5+2TowX04CtxRSl5g9JXB3K4NvfzF/BYfc7sHGD5SoKpVD5iLDhBdRP
	gE3fPdTf7GQbpXY3gy8qDpkJOeTDJh6rINA==
X-ME-Sender: <xms:BPD3aC6Sy88efLe0O2c9scqmoeSnKcsutyXwOYtPxTdT7YtklYDlxA>
    <xme:BPD3aId4Nn2FvC4_oU-twd7N2WW04RZe_phy1oVOELOGyvDrvcNRMevgiUwbX6-FS
    s7slEck20-mkCdBwcpNfJaoSpFPzLQHKRPEsEd2FvZtCtdqYVlxtQ>
X-ME-Received: <xmr:BPD3aF7UlOIaQbRfHhxnUV9D_NPga3JgKa3gXSmiIAqihE0jzrlZCNBu9_RwJ2n_gDAjzsB-duu2ItEGw-KW5g4wDiFxIB7n3Z3T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeduieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomh
    dprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehmrghr
    thhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:BPD3aF_hR6ueOkmqdf8Q-gcyjG5O2fxGlHkhVROxpEpMlgH9ryIUaw>
    <xmx:BPD3aHEnyAP6gDP_R5EcIAgw9vDDa9_jpkyB-yt28suOgRgi6696nQ>
    <xmx:BPD3aKXI1qKEt8iZYhfX4ZDdkUqI3f_Z_ytJO5hLjGE9OO2-S_7BBA>
    <xmx:BPD3aD8VlO_NS4u4ApX4oi8OhN_zuzf8Ecp_anF4cIZgvUiW9YZ_HQ>
    <xmx:BPD3aJKVMBWpVgeZw3siCiRNkh3YcSqqm56PeV8w6fCcqleAOT5zSwoQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 16:41:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Sergey
 Organov <sorganov@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Martin
 von Zweigbergk <martinvonz@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Elijah Newren <newren@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 02/12] replay: extract logic to pick commits
In-Reply-To: <20251021-b4-pks-history-builtin-v5-2-78d23f578fe6@pks.im>
	(Patrick Steinhardt's message of "Tue, 21 Oct 2025 16:15:50 +0200")
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
	<20251021-b4-pks-history-builtin-v5-2-78d23f578fe6@pks.im>
Date: Tue, 21 Oct 2025 13:41:38 -0700
Message-ID: <xmqq4irsugvx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We're about to add a new git-history(1) command that will reuse some of
> the same infrastructure as git-replay(1). To prepare for this, extract
> the logic to pick a commit into a new "replay.c" file so that it can be
> shared between both commands.
>
> Rename the function to have a "replay_" prefix to clearly indicate its
> subsystem.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Makefile         |   1 +
>  builtin/replay.c | 110 ++--------------------------------------------------
>  meson.build      |   1 +
>  replay.c         | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  replay.h         |  18 +++++++++
>  5 files changed, 138 insertions(+), 107 deletions(-)

A clean refactoring that --color-moved helps vastly in reading.  I
wish all our patches are this easy ;-)
