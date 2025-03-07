Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB121B1A7
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381069; cv=none; b=crvbrA9I7nRo/Cf/M7GUs0Gh+DmozPyKFQweyr9TJeU8iiysjJ8Y5vMh3uDXLFfmm8l1dyf9mbYx5NjciGI+rj76g8Y73bVLF4UPl57CAyBdD+2CmGQ8/0wBARxIkrkLQyX4+4ADEs7HBP68hz5md1XcSKuSRDho2rKJy90dT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381069; c=relaxed/simple;
	bh=bEf/eMgDelxTLWLQWbckQHvJrudxzi9vbZ21/CcKgWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i/RB39RTH3KErxK1xbMHoqyRDUcdqu8OicWvt/4DXzgn0JNMnqd8kjKGe75ufHjzygB4/Y3f40cpfz1Uc+tTBXWDh9a4Va1gDP91h8tYV02ai45zysOalHdwikda6OeBVDbf2n7LppiHoBLCIZY9di38NAO6a+WZKVzLRl4LroI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QWUaZaDz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KOhjQUWn; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QWUaZaDz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KOhjQUWn"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 83E961140159;
	Fri,  7 Mar 2025 15:57:46 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 07 Mar 2025 15:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741381066; x=1741467466; bh=WtR1reEn/M
	IJCwgNL0HNhuTuQj8qiXQox46jD0KB8f0=; b=QWUaZaDzhQbINeGLo5fJ55gRQn
	vNNxTERkdCtdgYiqgdgrzcOk2I+LOfOACa2alhI81dkp74vTyN/XuJOXbqe7mEMm
	F1pT2X8R/bI25Yc+IOyl3Ik5mowdbioMknRP/Trd/RUlAHoxHGfDheHgaD+ed71+
	tfNyn3lS2nB2lNpxUAlk+KBXw3GE4wuxRMfHDqwVxtrkU2fKGN9GdTh6Cnc08hRs
	K2Rrn1W3d14jpEG4aI8fnGWtJVjYePsXMqBXirFzPNaojW1AiQzyld3JnHWQ9B5H
	9eJa7iZY4r8XFzPxSzLL0k11j5TKwIdYxRhfFt7cDO9NdabjhBMRQgXq5cDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741381066; x=1741467466; bh=WtR1reEn/MIJCwgNL0HNhuTuQj8qiXQox46
	jD0KB8f0=; b=KOhjQUWn8mzFsp4GSqQUrAXKeYviETRkKgc03ghhfTQNk4IHrHR
	IQ+H8gTF1XKBhqtfvKudv32xTc5QsgPo+lSwEQH3y9wy3qt71o45EE+1DEQmzw1m
	JpRVrkf8Qie6sn1W8knRinB6Ckcw9yzj5osI+RaB7HaqhedbhNMmKJcAdUbaJhYb
	HSJJ4Kz8c90R/EYOsfTMFnsYWBsFVeC7gKpwGfO3JLjLpc5utaOzql6G+hhXIwDc
	/iWjgALzWZAkIdHYX9YRKPtB30XGdFuR7GCeMGocFJN7Xp7kZDCSDq96YM6IWSWz
	H755ljno9PmJQoA4z3A0pUBe1d3rk0hPR+Q==
X-ME-Sender: <xms:yl3LZ4sz1H4qG05A0AjT5zS4xSxDfR6Lw5JuhZbtKesdV3r0kxWlqw>
    <xme:yl3LZ1fwwvwBcYtJkEjmdG4Q8Ik2SAxWqGwQj2MG7J_nf0_n4Z2ii0GrOWJjjdnNi
    UCnIJAe3fMLrtzSig>
X-ME-Received: <xmr:yl3LZzzXgrzLF3jl8tnr6rjprnmhVWZLPlQ4S9crDIJj4S1fHOU3ePDVrpn9vteqDA4ew_SRiA2MAirHZBBaELeN8Q9RWQI75zlI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugesmh
    grnhguvghlsggvrhhgrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yl3LZ7P4SIlJ0SnDp3Z5lOGARqfMx9Wk9V3JgGYrcea5iPxpqWI6TA>
    <xmx:yl3LZ496yr5pTgua-fYxVo2Imird9aN10xE7HdjyAHcBCwgS24ZfTQ>
    <xmx:yl3LZzVFDaURpbzVtkJ6DPZmVifzqqe7gc9yIzifO-PM6-vJB_11lQ>
    <xmx:yl3LZxenTWjdRcOQ1Nk8jkJwKoWfeDAtPvXFYGPpRqlSHFP9seTxBQ>
    <xmx:yl3LZ3l7yBkjaa1wUCrjvSTm83wIWXNZYgc0rbi38m6g6Kj_mfy8p7HU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 15:57:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: David Mandelberg <david@mandelberg.org>
Cc: David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
In-Reply-To: <05bf397e-4bc2-4255-87b5-925c80667f4c@mandelberg.org> (David
	Mandelberg's message of "Fri, 7 Mar 2025 15:11:32 -0500")
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
	<95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
	<xmqqh645hopj.fsf@gitster.g>
	<05bf397e-4bc2-4255-87b5-925c80667f4c@mandelberg.org>
Date: Fri, 07 Mar 2025 12:57:44 -0800
Message-ID: <xmqqtt84d0dz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Mandelberg <david@mandelberg.org> writes:

> I'm not sure if I'm remembering right, but I think I got the idea from
> seeing slashes in branch names to organize a hierarchy of branches,
> and realizing I could do the same with remotes. Was it intentional to
> allow slash in branch names, or is that a similar situation?

Reference names were hierarchical pretty much from the beginning.

>> Anyway, this is not something we'd do lightly, but we may want to
>> see if we should tighten the naming rules for remote nicknames and
>> the mapping from nicknames to remote-tracking hiearchy, at Git 3.0
>> version boundary.
>
> What does that mean for this patch now? Do you want to fix the
> completion for the currently (unintentionally) supported remote names,
> or leave it broken to discourage their use? Fixing the completion
> might also give anybody reading the completion script the idea that
> slashes in remote names are somewhat sanctioned.

It probably would not mean much either way, and certainly not
something we should worry about during pre-release feature freeze.

The "fix" may take quite different shapes.  Remote nick/name may
still be allowed but the default fetch refspec left by "git clone"
would start using the refs/remotes/nick-name/ hierarchy instead of
the refs/remotes/nick/name hierarchy, for example, but as long as
this round of completion fixes properly read the configuration to
learn the remote-tracking hierarchy by reading the configured value
of "remote.nick/name.fetch", such a change would not break the code
in the completion script at all.  Or remote nick/name may outright
banned and people are encouraged to use nick-name instead, in which
case even if the completion code is prepared to accept remote names
with slashes in it, as long as it still works correctly with remote
names with no slashes in it, it will keep working in such a future.

Or the "fix" may be to declare "there is nothing to fix, if people
want to use

    [remote "nick/name"] fetch = +refs/heads/*:refs/remotes/nickname/*
    [remote "nocknyme"] fetch = +refs/heads/*:refs/remotes/nock/nyme/*

that's their choice, and the completion code would do the right thing
anyway".

I didn't read your patches, so the situation may be different and
with any shape of "fix", or without any "fix", there might still be
need for further polishing.  But hopefully you got the idea.  For
this particular patch, there is nothing urgently needed.  Well, we
are right now in the pre-release feature freeze anyway ;-).

Thanks.
