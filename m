Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C1B253F17
	for <git@vger.kernel.org>; Thu, 15 May 2025 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329206; cv=none; b=oOTiuAwK8M7eCWiCXK8Zpmp/r2CTruZGQWqqEA0E+x3CBn0Rq3heJ5mAoZEfq9CToBFycoqky9yN1g3mhdnGcBbyVuGBxIG9phC/B1y86MPLea8H7dioW33sOT/u/Qpda16Rna8+i/npCEdHhVgeJ9rqdyWLeEnoLGgXftFzkds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329206; c=relaxed/simple;
	bh=6Xqumbq3fqE8ozHs2/Wm8l+B1NU9fFAmpSoYkYKKlHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NjkKUpFaOvXXEBIBOX/c2pEvLStElVeCO8+ez5T4ZHUNTkGS8H7weVmM4ZZE/qT9RjDouBRkBJLcFVoYBzw7y/cZY/LRfYh7P0N2/UGAJHDO+aByfvtH+lCNI9y3lRfxa5TIEXND6VxqxpOK5tdyBsYyIRyL8wHr+9KTYV3B6MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gS7yX7At; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OcJ5y408; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gS7yX7At";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OcJ5y408"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 60DFF1140123;
	Thu, 15 May 2025 13:13:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 15 May 2025 13:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747329202; x=1747415602; bh=9/Ko4Ox63F
	ykul9VzV0Nq2bsDeh5IPTKv2VYVdLH7FI=; b=gS7yX7Atf7z+hqUWIenDSfFgJN
	TSlkAi2Nny5bmiEJbWJz8iL+QORqWW6wUekUNA9kaFGGQP8sHmtTI6VAzA5Bu5o4
	vW4/dWKTVf/DdsGNEPpdyn5fuMOus5sTJq/BxWxmM1I/4Wr8dzX3LNTBJOesMNtA
	d20H9OsUAk4S6kxJGo23TiAGQZHriBAlnd6NcuWw80JMuSeY9jPqr1VwJL+SQoQn
	NnNAIjRsLIrNxPNUfqNKCP06WGXaE8umMhvTG4e19nrLAzYtqzfNsNNvnSdfm+PS
	T4A+vpjsi/7ROPDjn+xyRsiwPFXeztT3IdqOpssoCGcFiZc/bWBhI3qMFrvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747329202; x=1747415602; bh=9/Ko4Ox63Fykul9VzV0Nq2bsDeh5IPTKv2V
	YVdLH7FI=; b=OcJ5y4082uNIbcLcXyEMfiwJWn9lm8eA3A4CM1SAuW/6vRD1Vn6
	kPpcFnda2xesyobCY0RqRYfo/AopUNEs+imae1FJi2URB9DQXIpXjccaJEu5/FfJ
	Kso0kKsd/j1Ezy0je0O4CFHSjSqqAJ2/PQvjpa2eVIBdFuuplQEEc5BJ63xZzG8x
	cokz0J7zEHmsmv6DNXT7ej2rVa2O/5asoVwZuHkOnaAfbK0s80UIQf4+/H81r6UG
	jacz6otJFcoYlsj3YAGYYxAV9IPaMzO9ad00a+wkUUfaUpO50643okpRpBaTGExI
	x4UDNW8bSoYzwhymYWOH1azmVMYw5Eo0XCA==
X-ME-Sender: <xms:siAmaLN0PI2e2ybf7wzAXqXF_w05JC3kx6cBRm7eD-ayxuVmdXKL0w>
    <xme:siAmaF-ekIrEnW2LEgqFX-x3cZi456s227g95J8a6ufLZGcieqMgknqxN5UAoMBSh
    s53XN2G2PCX-ZUJaw>
X-ME-Received: <xmr:siAmaKQg0UaKlM8651exfx2_84g67r26NG2wO4-yvXewqXRtgkMrJT1JBZ2DB-RJoEfCfInPqeTyUsMhUG6jtsu9SFEr2InD-HPxOq4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:siAmaPupcZ6yKtNyNyWONg-nWm4MWZR0UCJQlqMsT-VBKASa2_BuSw>
    <xmx:siAmaDemxC6KtkZZgiYvZsffID9Y9ix4Hxui48_U3p4hZFUmdlvbTg>
    <xmx:siAmaL3LqgTyAlXzC_tsF-9cpBNvIUGERoz7PqavMPiAgSFdEzzmCA>
    <xmx:siAmaP8enppTjyT8TRxus-bhJnd9km9CnDX0cP-Q_JBC2zgyb8DgFA>
    <xmx:siAmaMr3D5JcRw-6qwv3Lw2FJTOu0Xf1T0RyU_Lrwzl50iCPSPkhYdL9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 13:13:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 01/14] revision: defensive programming
In-Reply-To: <604e67ee64167efd5282b9efabbcb6e72eeaf5e6.1747313140.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 15 May 2025
	12:45:26 +0000")
References: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
	<604e67ee64167efd5282b9efabbcb6e72eeaf5e6.1747313140.git.gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 10:13:20 -0700
Message-ID: <xmqq8qmx23wv.fsf@gitster.g>
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
> On the off chance that `lookup_decoration()` cannot find anything, let
> `leave_one_treesame_to_parent()` return gracefully instead of crashing.

But wouldn't it be a BUG("") worthy event for the treesame
decoration not to exist for the commit object in question at this
point of the code?  Is it really defensive to silently pretend that
nothing bad happened and to move forward?

> Pointed out by CodeQL.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  revision.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/revision.c b/revision.c
> index c4390f0938cb..59eae4eb8ba8 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3359,6 +3359,9 @@ static int leave_one_treesame_to_parent(struct rev_info *revs, struct commit *co
>  	struct commit_list *p;
>  	unsigned n;
>  
> +	if (!ts)
> +		return 0;
> +
>  	for (p = commit->parents, n = 0; p; p = p->next, n++) {
>  		if (ts->treesame[n]) {
>  			if (p->item->object.flags & TMP_MARK) {
