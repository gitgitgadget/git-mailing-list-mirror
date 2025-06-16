Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891D529408
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037117; cv=none; b=tHBgzw62uxvFejdPnPkPYxSnOgaTFirTb7XpxUqKg2/ESjeK8yqw4f60hJKMIr4bRN+fxyuO++W3+L+xu//HLrdqtUVXzGwHKeCgadlS4CEaeo8lorngcXdyfJOAvmCMzT65gJXUkKY41WUqkkyza3ytxGBfrRJDIXsbdaVVed4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037117; c=relaxed/simple;
	bh=Q69CV01ZvR1P95VxkJLVrhJedlW4jQHfcaMd6wp8TNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EVXoDyobcnqBWBvJ62eqO1SZC2N1oib0pcHzNbVggRC/jqBADH7Ws8oQMqHGNTmc1w8qE2BgHQH9uVeuenzbgBduqMNVecK8GV6w5En/5rZLeiy913PF6HqwiuNqKAP8MRI+apvJEnb4GBNfFwtcIgY3qceCQk57NBOY30oLQSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mdsYP4X9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EFoi9QmU; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mdsYP4X9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EFoi9QmU"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B17311140278;
	Sun, 15 Jun 2025 21:25:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Sun, 15 Jun 2025 21:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750037114; x=1750123514; bh=d2fuOI7wol
	KSxM+5XWfMDL3urGHUhQNM7Th57qABy3E=; b=mdsYP4X9a8Z9AXgZTCKf4nMj/2
	C/yUGGAsEY4hsK0ydlTSkR9Hyfk0hszPbtcBrci3Fo2bqmW/xiBkBxNNyHNq4Eqd
	loOM/6+YDD1VENgisdm2if9gQsEp2VIBGvIYeZlTQRre35jUNHBI/ryj/vfBZs3y
	LAl/FNeKqa5wS0ZL6icmVt1ByRSiYY1LfF0l0YzaGwOEtG2KuuOOVv2vEi9oiLZT
	rb0j3+e61Y1eCLDIqc3459b9/vukKp+osv7Xn1y9qD7/uorGFIsZNYIO+KzZnH44
	qE7Y3ckt8gRPZHfiNLJVWnxydE7xLYJtDYefrnBtALd3PWa/AC9NoFoSReiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750037114; x=1750123514; bh=d2fuOI7wolKSxM+5XWfMDL3urGHUhQNM7Th
	57qABy3E=; b=EFoi9QmUY1Hp+hvarIaSrVv1uEMMCPoJapqZdABZvXGFgc7Qn1s
	GXVni7j9rET3A2GaOj4JvPMN6r8a+GhOYyGOnEsxmALH10mhHgWievGSuRnefM2g
	i/Adq8KUAGpLup62NJFwMjba/DIYEKZPM3W1DDNKIXxuETrtQ5qnHVcKpuP2fllU
	r8lVRZjfXc18BM0huXbEQ8a5q7XaLOceR6AmG1Mugqs4KYRYHTf3NKBzT/VlILw+
	zg78OsYfAs8hvC+RALZCEnRzv+MufhXMPJguyMNfWaWXjdVyDj6khTp/4EgPg2fz
	aUDSZL4tBgiLCeiyzCmYAV7dRe3fDcrh1sg==
X-ME-Sender: <xms:enJPaFbjJfZZ2xj2bwZMteJisf_3mBUvxEjJhfQBgcYYxQRcm1p2JQ>
    <xme:enJPaMYrn0eSegLydc9BvMd7GnUL_JecFyC1sMenEznVlaZYuR0Kt04faAftTg2ig
    bUf5VsA5lIXCextmg>
X-ME-Received: <xmr:enJPaH_fAYb6oMl2qGtJg0Fjrjacve4dXAQ3wnYfFclQsvW8xuDyese6DJ-7KTIIlSENBIlUKqFRpdFzdTkDUpMKTuPZdgF4xlh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvhedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohephihlughhohhmvgdvugdvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeehtddvtddvgeef
    fedttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtghpthhtoheprgihuhdrtg
    hhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghn
    rdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhihrghmthhhrghkkh
    grrhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:enJPaDqvjy0B-twZlAzTjqlRsmm9GLwtzIHv-qgihKUGv3r88_z2Hw>
    <xmx:enJPaAp8V48YWajvhlgl58CbC6fL256LFTlJi2nXUiH8SoO4TkT36w>
    <xmx:enJPaJRozycnU0KgE5xwQ0cC2x0sgbllO9mrq0oOmtsSAkeCWFX4UA>
    <xmx:enJPaIoQUn459Dz1pvqUvKoReiPieHu-z736C4xt4rRy7mTfj_KWCg>
    <xmx:enJPaA7exgVMWIQMdiT9KEnzRuzPXN6lfVRbAPuoBWIYrkzVEeGEOeGg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Jun 2025 21:25:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  Lidong Yan <502024330056@smail.nju.edu.cn>,
  ayu.chandekar@gmail.com,  christian.couder@gmail.com,
  shyamthakkar001@gmail.com
Subject: Re: [RFC PATCH v3 0/2] small fixes for git.c and setup.c
In-Reply-To: <20250615144604.1447302-1-502024330056@smail.nju.edu.cn> (Lidong
	Yan's message of "Sun, 15 Jun 2025 22:46:02 +0800")
References: <20250614050331.304405-1-502024330056@smail.nju.edu.cn>
	<20250615144604.1447302-1-502024330056@smail.nju.edu.cn>
Date: Sun, 15 Jun 2025 18:25:12 -0700
Message-ID: <xmqqbjqo4gw7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

> I've been reading through the git code from the beginning. This
> patch series fixes some NEEDSWORKs and cleans up some unnecessary
> uses of the_repository that I came across.

FYI, when we have "NEEDSWORK: do X", the intention is often "we
haven't spent enough brain cycles when we wrote this comment, so the
first step is to evaluate if doing X is a sensible thing in the
first place, and only if that is the case, do X".

> The first commit replace the use of the_repository to run_builtin()'s
> argument repo. Since each caller pass the_repository to run_builtin(),
> this replacement is safe.

That change is safe.  I'd rather see the comment left intact or
reverted to the original shape to clarify what code the comment
applies to (see the other message).

> The second commit takes care of a NEEDSWORK in setup_git_directory_gently()
> we now properly error out if we hit a .git that is not a file or directory
> when looking for the .git.

We used to just ignore and keep going to check the parent directory,
right?  Now we would error out when .git is a FIFO or device or any
other random things.  Is a bit of behaviour change, but I am not
sure if it is worth doing.  As finding these weird non-file things
in your working tree and naming them ".git" is extremely rare and
useless (from Git's point of view), I suspect that the user is
deliberately doing so for whatever reason they have, so it smells
like this change has very little chance to detect a real problem
with a larger chance to break a set-up that was deliberately done by
the end-user.  I dunno.

Thanks.


