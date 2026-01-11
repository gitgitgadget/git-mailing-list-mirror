Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E7500950
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 04:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768104118; cv=none; b=RMnIVcopmnH8nGCgYv374vxJ2n+ks7McT9ZTXo45BD/rDV8lVJle+mo/OhHf//FUxRLa9H9NT/Xg9Xpp82oMyOaUVipAwlwVbeNFFYLZPavg91AUtrvN6qroz9XkxClgj+duteVPxK93lSCNEAPlLXppz7Kzh22+3rbOjqoMqKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768104118; c=relaxed/simple;
	bh=1Oh69/pZdMhEuy240/M4VsFVskClwGKKpX6iUd4Jl/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ga1t0CGB2Fq1ueTfXmt4KjJuWkhi+fibX1Em2aSdF91NdYS1yzHb9VH+g+Jkfwpe4Y7PB/p8Nv9YfTvWfvMQKy9N8G5GiwUEix8OL+hoNkcMbVYyGp/TmXUdDJe2x8oNKlct2pMDIUYemRUuo75m8zS6oHPA2M0GVUhDcVxwiiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cDe6ygQN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jcYzsBY8; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cDe6ygQN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jcYzsBY8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 70CB11D00124;
	Sat, 10 Jan 2026 23:01:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sat, 10 Jan 2026 23:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768104116; x=1768190516; bh=pTzrhtUFkl
	ioJko3JYZTrPO2ZyDlf0yU4fjZgUEmNf4=; b=cDe6ygQN+WMSimPVLR+g6Pyw9n
	nN9HrylaU+do3T2AshdcLq2Lya9ONSdK2KGmXRT1EPQLUsIReZoj7bxGS+BT2DKN
	vugYGiLDarNouWUYsqmNFnsyAFsb1oyxgTOt/u3Cmf9f9ZqR74szE73NyjEL7cd8
	3J6qeL2LLShbfpeE0YUS6bwzHmBowXVp6MzkTGNLk8d3c39gLvuw5N9xp1uA7HK0
	uou/C2512rfvZPBMf1InTbzwxbL+YLLtE02FNODlvUHGb7/6yPYm1qxfgOcgd9s6
	ojiBRjl7MSIcXk6kSqPRQzymJYSuowNTi4wZ+oqayoI9VOo8HRlsm1nGGHEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768104116; x=1768190516; bh=pTzrhtUFklioJko3JYZTrPO2ZyDlf0yU4fj
	ZgUEmNf4=; b=jcYzsBY8kL5iuFcZh4mBLcMfikDoF0j1TPl6ziGa821H/p+PvEk
	dzzWGCmhnMx12ycVqLfZ4vIzxQdeU1a4O7Pg8Nsa72nqUSymxt5SvUrZrhWtW83h
	R0XGKShPE0KOu1CqDsqhJGSzNhlCNeknKt5aH8aA8EDU/OnAAwPi3XP/q9t3w4KB
	NmA6XoiLm1akUvu3abxiBpANryBW1BuGo5CrAgWqtccFvTMbF2S3m863eUhgsPwP
	n+DrN/xFTYA5sktRm6fKsYJ9L7pnJxpTMdAxEdGg0ZP4gQoH6iX458KHdBP0thCh
	umi40nccW3PNb4XGuc4NDkEP0KSgS+7VzMA==
X-ME-Sender: <xms:tCBjaVJK4BDnTTWF1KXQzMiS3Z8ydmGvFnwWbV3d3NSO9ICd7FAjug>
    <xme:tCBjaU2STkn7Y6R1UGfhU-Vs0ERFLIvhB8sI5iurq_DSewF47K-tY-SF4WomDBGay
    K1WoinsBooCBZo_PC_fIOn7X7p3A3ljD9fuc-BwKyMwzyu28MIZkw>
X-ME-Received: <xmr:tCBjaXjTpLtCkwqg-1gEVBamWsOt6dBXM7qgr3vPtfBB8VZqFM8R4RHVM0ZSTzSnCdK6Wo0bTR1M4oAbgkI0Yc43MUHo3vVPMmMIMIo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudefheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmjhgthhgvvghthhgrmhesohhuthhlohhokhdrtghomhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tCBjadVJueGe7TjHl0ROzb7vi3UcmtZKEac_G-KzJoumaeChL5fWtQ>
    <xmx:tCBjaeWcC8HxsGWKads3NoCTNKGeNkOyIfoZrAylE3803JyyM4QsIw>
    <xmx:tCBjaViqM2lgAnt9ujkeTOMrglKSujtsY_FfeM-TEjXS-fupymR8kQ>
    <xmx:tCBjaRYOM5194SqeIFFz_Kpg3R7PNsiaKkKWjxpRgcNBCgz1l5L-iw>
    <xmx:tCBjaYm6EwBqbug1tXftz6CXCeYHM2yFA__iELf-0PP6pNCbVPkcPwqt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jan 2026 23:01:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Matthew John Cheetham <mjcheetham@outlook.com>,
  Jeff King <peff@peff.net>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3] fsck: snapshot default refs before object walk
In-Reply-To: <pull.2026.v3.git.1767980953134.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Fri, 09 Jan 2026 17:49:13
	+0000")
References: <pull.2026.v2.git.1767749366719.gitgitgadget@gmail.com>
	<pull.2026.v3.git.1767980953134.gitgitgadget@gmail.com>
Date: Sat, 10 Jan 2026 20:01:54 -0800
Message-ID: <xmqqldi4re4t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     fsck: snapshot default refs before object walk
>     
>     Changes in v3:
>     
>      * Removed the attribution for Matthew, as per his request.
>     
>     Changes in v2, thanks to feedback & help from Peff & Junio:
>     
>      * Fixed errors in commit message
>      * Changed to use a refname, oid struct and have an array of those
>      * Snapshot command line arguments and worktree HEADs too
>      * Add TODO items for snapshotting index entries, and for possibly
>        improved reflog handling
>      * Since nothing from Matthew's original patch in GitHub's fork of git
>        remains in this patch by v2 (only a little of it remained in v1), I
>        changed authorship to myself and gave Matthew an
>        Originally-based-on-a-patch-by trailer.

Thanks.  Let's mark it for 'next'.
