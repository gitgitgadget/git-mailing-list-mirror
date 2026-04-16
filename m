Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FD3165F16
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776359162; cv=none; b=iezd4FYBavcMrLB+KtWO5WON1yTRaNp7qwGD1DY3Wk/Ll42pv4SYXIC2jqIACuC/j6fYH68EFabJtwvWHy4ntLotIHcFYaH1VVsctfxQWbpNIazIQxwPzu1CXXdsoz09W4VzvK8ZHpYLCFgFdI9ndBneN0Wl/lCevDEAfMBV6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776359162; c=relaxed/simple;
	bh=3/bxwrfsN5omzfwwdgCy/SQKSJUqMXWJGvIlt50WfFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m+bNGNDkIyWr+hj6kYR+iMRGv8ifqyVmfetg5ljKL2LEsEucGK3L0WPHhsWosnh4tBFjm2GDwKnANdalqrJPRMUbbrSZhDIBGY8M4F+BUt7c4C6FM7M59lsgyzNOMTgimcj46dAawSQD7f6hMwJlJGYjA7JMKABycfuXu6cNJsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BOyZFtiJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kvYY6bde; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BOyZFtiJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kvYY6bde"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8CA6A1D002CB;
	Thu, 16 Apr 2026 13:06:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 16 Apr 2026 13:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776359160; x=1776445560; bh=u87e4vqHZD
	seZOIJj9/xYQrJytslJGZ1872wrK4Y98A=; b=BOyZFtiJ/ig3kisv9y/GNYIF9n
	lfYBs72DEhJ5gjZvOWTW2InPxSS4KQN6deXIB2g2zQ+/Oc8iB5hdL+bbiVMHBQK1
	n2rq21UJTP9k852yRL40bRQTsztsdrAkTkHe75gV+4zcKV2DSKikHt0IywYkm/J4
	aMzmd8ysbTf/qvOwkjntDGC//K8BlSeyn2+0LjDdejAPea7XSrC+yesSyVRr43Vf
	5DzZsz7gSbCeCinOiWo4gHDN4Ek2Q0y70UuUm3hl/G1PIOep+H8FRZCy/1PT9EaQ
	sgNxTHjojJN7axk8JBoO8bj6ZtzylnsdMoE1Efa69hOX2jj0Tlq3jd0+0Nhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776359160; x=1776445560; bh=u87e4vqHZDseZOIJj9/xYQrJytslJGZ1872
	wrK4Y98A=; b=kvYY6bdeXzghSjckJNGMQx66SwaS+MJrRpEIFFVmbqwFCQfSAqf
	ha5eG014XJp+qIgwco3NBacVQYF3SPYeaWUU9xlnDT1L9I9KTtL41FZErVgbsMXl
	BrZSkroOiTO6qX+xpfmx14V/nnlfuoNW/Dq3S2WBNmNnnbivMGjcC//S1j0OafSl
	8fIsHAXXQaJ7Jf/PygPasia/7B3Zg2yK+nMRZudt0uWEpivJYX7PJ6uDj/uF9qqY
	OY/xLYC9cSfzTT0vApVi346qAOqabXV0gCRZuzRVQtaTKBEWKBxnfUOFqVt61u21
	LIbLpSGebNXmGtg9pqg7N1eCLeZjGwMUx/g==
X-ME-Sender: <xms:-BbhaUuqFj9NIxkie31UcV8zi-U9AaUObs2XhjtvfFjDkTyj41RQ5A>
    <xme:-BbhaY7bm_JvaxunfUExS6qbfQGTpLqlCrJd9P18IfOlZvjHxU-_yRJywFvgfwVEc
    gIYigwopicNI0pdD14M0OjyetJaFa7u7hDMS1Yvk0G3KELYz2HW>
X-ME-Received: <xmr:-BbhadIXBBNJzpENGDvuzqHs1ssAJIFoSuRgBSyAXXgFYW-7kYQPNYA1QUOalphU_jZ3OgiZWZ7wWeqPfpu3T1pmEISjQd4Uxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrrghtshgs
    ihhnohhvihhshhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-BbhaQ5Uh8CNCUuGosifo1k1ZdUof21qP15Ec2FV-0KhxleLT3MbuQ>
    <xmx:-BbhaYzZbJonbEZTRtwKUhypXQ551afKSOyFr9Ts5W8Dc73D_26fEQ>
    <xmx:-BbhacbpbYtGZVzmNSty9JxXwFTkPjZJErdwolcq4GLWB0UUfkWeDQ>
    <xmx:-BbhaSR3L8IY-VaEqRWUBFJek7xztWfGAVgK9yCj_xVkclae6jrWyA>
    <xmx:-BbhaU5DjDvhwJddzt2mJYkClcbVCUiiK4conHEdG3aI5JUMNQWk3UyG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 13:05:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jimmy Aguilar Mena <kratsbinovish@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] worktree: add --recurse-submodules support to git
 worktree add
In-Reply-To: <aeEMU-ohKz2tnSWq@RTX> (Jimmy Aguilar Mena's message of "Thu, 16
	Apr 2026 18:32:18 +0200")
References: <aeEMU-ohKz2tnSWq@RTX>
Date: Thu, 16 Apr 2026 10:05:58 -0700
Message-ID: <xmqqzf3225u1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jimmy Aguilar Mena <kratsbinovish@gmail.com> writes:

> The approach follows Phillip Wood's and Junio's feedback: each linked
> worktree gets its own per-worktree submodule gitdir under
> $GIT_COMMON_DIR/worktrees/<id>/modules/<name>/, so HEAD, refs, and
> the index are independent per worktree while pack files and loose
> objects are shared via hardlinks.  The gitdir isolation is the same
> model git worktree already uses for the superproject.

I do not quite follow.  The point of git-native worktree support
(which improved a lot compared to its precursor, "git-new-workdir",
is that it can work well in a hardlink-challenged platforms.  You
shouldn't worry about "hardlinking" yourself at all.

After the superproject successfully did "submodule init", you can
move the submodule's repository with "absorbgitdirs" to
$GIT_DIR/modules/<submodule>/ of the superproject.  The primary
motivation behind this feature was that you can switch to a commit
in the superproject that does *not* have the submodule bound to it
at all (and obviously you do not want to lose the submodule
repository only because you tentatively switch to such a commit and
have to re-download when you switch back), but I think it gives the
single instance of submodule repository that you can share across
worktrees of the submodule.  Because the single directory created
with "absorbgitdirs" looks like a bare repository, you should be
able to create two worktrees off of that, with their own HEAD etc.
