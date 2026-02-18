Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF64327C18
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771421438; cv=none; b=D2rMmIWgEYPf7aETtDIwPCwSN6EQzIlMEdmrg3j2m07XEbVmpj+xsNB6cqs/YZ9CzpzY+QdzlfVQ6D1ub8aLKhGab8fQbVi+gookMS8AiwgLB3XcKOq5g2Ew+7I5I2NtNNbpndCnaCBqwPmPwD3yb/Gg7t+iaMPkuWqXo8RG+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771421438; c=relaxed/simple;
	bh=jtcno7i/ywsc3Mxp7UoPpIh4VKSHvMhehdfzKVg8aF8=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OzFH8RJYvAdmPa+645mS6o5hHT0ctKwjHzZ0DsZgE9gMfEH9WXGB6dF3PsvEKNHHWJ9sLbGXjyzQjHLbKmS2HBmn92G4jo7Eo5eQFnbJwet8zK3m1tpZehHAipfNOrhrqeqzO0+Im3yjYAOIYYxDhnFRIqUbeb+lswRxf0g7loc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XsT6ova+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iO0hvwtV; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XsT6ova+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iO0hvwtV"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D35487A013B;
	Wed, 18 Feb 2026 08:30:35 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 18 Feb 2026 08:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771421435;
	 x=1771507835; bh=04jC5JkoXFZRBLXCRhqIxGXeHJ2D60mKgQxcCqGq9vQ=; b=
	XsT6ova+L5n1EPRDhlDvBq0Z5tefx46M2do0fnfNvyz+3D8Pn9bJyT23su5+Aw/x
	FFPVv7jEn8S935u73lAS6qw5OT368ylmWqYQbVKXSGJfdiZFH2K67zlTovdj3yww
	TodBwNQRXIqoCuoy+Bkylkkk//wNsdQsiG8CE0nqIXNXH5IM3aVd9WUXcPgbZHx1
	ytM91cVofy6C4+QCzhEVBhj0G2uXmEBocy0h5U1By32yybp0x3vaYkLnTRXl6sY+
	62vKJYAjdiBqdGwaMhXKy/3cMkBPoY4xsNGinWuLKDdxadhql/VBZ9L4DO6AVM1U
	i1Lj1371LnSOvanP3vvgMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771421435; x=1771507835; bh=0
	4jC5JkoXFZRBLXCRhqIxGXeHJ2D60mKgQxcCqGq9vQ=; b=iO0hvwtVLmsAXsURh
	KbCYE3YxFL6H6KrfvNVoNtRr8Db6dTI2Tt1RMqIk8XXuaDj+o/HtUaG0WOuMbEGV
	KRJq2jAvCu/5EJgqFmlgUwVlh8UlcIoJayE6qys4hf9zoEafqvRNUzzdSV7XY5h3
	8bmfmgCKX53fYk4udiLVRPAz7rizyegyKS/UuNWOv3Q3KArfKMxpWkWg3XdT1+Zx
	A+Ed9eA1uNfU3MhITd9emZFb1RxF25a8efQWfQohXcKb2cCfX4Z/ihmMNbuLnAQW
	fnQjEJpVwVqWFz0xXpq5a4l+BRZahLOPfJilTFkBuhaJT/IEVhc/KcoZbR8NGaS4
	Ztuig==
X-ME-Sender: <xms:-76VaVTuRqlX4khXPfB1WsDERPgBcpc1q1ojs8xCHLAcacu_0pd1hL4>
    <xme:-76VaZnFUTbjvzSxNxtiywZy1XlQJBCvTBhpY8i_eay2ZhI33Ra9zrhOJj91LRxcs
    YwCmHuiCCUpWYKPUTIZHZmrOuTrt7Tv_PBuOOXjT7DwkmZRMcY3Pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddvjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvieegtdfgteeg
    hfffteetleduveehteefkeffheehfeeihedukeevleevfffhjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheptggrrhihrdhrvggrmhhssehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-76VaX-SOQIAc2DffN8mrS51lpEI1DyYd423sZr7zXe5MhT7WWq0mQ>
    <xmx:-76VaRrDDwMB_x-hjDKCNI35DywU3MPCGbpDqGoJabWSQZ72s924Eg>
    <xmx:-76Vacnrvcgpj3ZzfXZPWled6xjHFH390lLjmn5LmKdii5-AynpRZA>
    <xmx:-76VaQLml2PLgYigkOr4JFQL0bwCKcwhag2L_J6d2j82CrxYUBs3Gw>
    <xmx:-76VaSUfxNtEOGDpxBxPDE0VSGVWjPgw9WW4oUHDVVMy8oHnSFvc7sBS>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8F9F41EA006B; Wed, 18 Feb 2026 08:30:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWwtz4B94KsF
Date: Wed, 18 Feb 2026 14:30:15 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Cary Reams" <cary.reams@gmail.com>, git@vger.kernel.org
Message-Id: <ec016470-ecd6-49c4-b9cd-95cc89112050@app.fastmail.com>
In-Reply-To: 
 <CALT4vkh_t35eJ8oWkSokVzt4mj+cZYxPQCr=gtU5hEuA0v1baA@mail.gmail.com>
References: 
 <CALT4vkh_t35eJ8oWkSokVzt4mj+cZYxPQCr=gtU5hEuA0v1baA@mail.gmail.com>
Subject: Re: rebase --abort had issues
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 18, 2026, at 13:05, Cary Reams wrote:
> wont be a lot to go on, but here goes. Apologies, I don't have a
> precise timeline for you,
> as its all running together mixed with a nontrivial amount of adrenaline.
>
> while attempting a rebase, made it to commit 7 of 18, when received message
> about segmentation fault and inability to parse the file experiencing
> the merge conflict
>
> fixed the file as per normal
> added the file
> rebase --continue failed
> rebase --abort failed
> repo seemed to be stuck in the middle of the commit
> would permit checkout of other branches, but still displayed the
> interim rebase status report
>
> At more than one juncture I received this message:
>
> fatal: Unable to create '...MERGE_RR.lock': File exists.
>
> Another git process seems to be running in this repository, e.g.
> an editor opened by 'git commit'. Please make sure all processes
> are terminated then try again. If it still fails, a git process
> may have crashed in this repository earlier:
>
> However, after removing MERGE_RR.lock and attempting rebase --continue
> or --abort (I don't recall which), I received the simple segmentation fault
> response with no other messaging.
>
>
> w/r/t to state of the compromised repo, I have been able to checkout
> multiple branches
> I have under development and move them to a fresh repo clone (init
> from backup). However, every
> status command responds as if the rebase is still in play, regardless of branch:
>
> On branch <any>
> Last commands done (7 commands done):
>    pick 6c706e0f5 refactors endpoints to include element-delimiting comma
>    pick 0373d1796 #1680 interim save to do research
>   (see more in file .git/rebase-merge/done)
> Next commands to do (11 remaining commands):
>    drop 5e3a99f46 fixes 0-day enabling facilitator to edit their org data
>    drop 428947142 #1680 creates facGroupInvoiceCreate template
>   (use "git rebase --edit-todo" to view and edit)
> You are currently editing a commit while rebasing branch
> 'wip_i1680_pass1' on '85bcb9270'.
>   (use "git commit --amend" to amend the current commit)
>   (use "git rebase --continue" once you are satisfied with your changes)
>
> nothing to commit, working tree clean
>
> Began rebuilding a new copy of my repo. Once I finished getting my
> files transferred,
> I attempted to get precise error messages and detail for this report.
>
> the status message is as above
> checked out the branch I was attempting to rebase
> rebase --continue failed,
> rebase --abort did not fail
> and status no longer displays the interim rebase update messages
>
> not sure what to think, now.
>
> self-healing ??

What Git version?

You can also run `git bugreport` and just use the generated information
at the end.
