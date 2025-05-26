Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3944381AC8
	for <git@vger.kernel.org>; Mon, 26 May 2025 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748265716; cv=none; b=N8n+jiSh+1mFTuaobXGLB5XVTVFbaFj9CkTh0EjFWgNZfrGhku6+G9HqriP3gGZrS7G8dbqpqFOvEvXi4DWUwBRAfT3229JW0kW3t0aHalD1f3LqJFrHs4AG9tLqPkJ0yulo9TzhuzpWUkqjqxb0zQMTmNkBmdKM/1QfRKNxYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748265716; c=relaxed/simple;
	bh=j2t4QXylzBl93xCs8RVShcPNJFlEQUz1sUc7bm5QPfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfnKAjjHrccpIR97cZ3Bwgic5htShEYZ+rwO+SqLsDeB66OHIf5gbtQe4adCuHTNQ5QzYGPmwDZwGAuxxnPN7pG0Ik9jfnPfATOR9ePpZbt/08Irc8XTQs6Lq+r3S+aEbJw/h0iIWMKkSKMlgA6w17lXJK+2141TP/9McZJyUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eOnkpJ80; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ADa1Lbnm; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eOnkpJ80";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ADa1Lbnm"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2FF25138065B;
	Mon, 26 May 2025 09:21:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 26 May 2025 09:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748265713; x=1748352113; bh=T4JFsMEu08
	x/2VvXXusIMm45W7FeeUkFGRfcVylMGOo=; b=eOnkpJ806w+m37KuCldvbhj+50
	p9djI2PBJuuzimxDgpbgY5SXxShGeKrIG3gl/ApilaU7cqOCC/0peGE3gCLY86P7
	yyBFH5xmddPCtISCoy3BmdivTj0uHx00XpstCqk8OgRFn3uJZXS/TVwiSEdVfg0p
	4MV/9a7evBTWMb4jCmpVlCMN6WxDeimU829VBZNs/L2nwe816h85w4ZnTfDpIVII
	C8ecUpRuh7miVPvbL48rgMT3HYJaUdXsEizep358wty7OkKPK/2eqCxoWMBiYs0m
	thinAFZYimwaebsAqK+odK8qG5okoAon1DpI6AB51rkGlWuDbQdLTnj2Os0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748265713; x=1748352113; bh=T4JFsMEu08x/2VvXXusIMm45W7FeeUkFGRf
	cVylMGOo=; b=ADa1LbnmaDBO7/PikEsemjx2Y/nYH1hp9TWoIW0D3GED0voaArB
	2owhoBcQssD2Qab2V3GlEZoI+VbK1rS7Eu0+kSwFDeFAw0OJDAIQZpXAUHOPFwhN
	hy0C6Em3gQAqDlPS+Q8kaHpEQvpv0OvBmy9YfR6f7hw1SNYs14j05auNsGM46QRh
	+V0WGhjQg2XGSwYUCEv36c01VoTF8tYasrXeUrAHWEIODBc3ezdyJUtCnfDiusKI
	iHh/QpRl93dlV3HHhwxeN+8WPPKSTgnBQFBQTJPSL0eXv0dvMP34oZ8pTpnZ0Vmq
	e80ZQEezn8o0q2t0zfKO5NoVW8z56LewdlA==
X-ME-Sender: <xms:8Wo0aAt5Rx9jUho6YB7HnKFHzhfznrB9axdemEq8CNMgwkKlUxGflA>
    <xme:8Wo0aNeHSPBh2bGkslJ3gDxQHwVLAm82AxtSiz7uBZLb-EFXVn8sGMkoupy0iwbj8
    xqL7hdLjsKfp3pCIw>
X-ME-Received: <xmr:8Wo0aLxYgRzqwnOiAQhc768WDFuTBskv3wejtEo0dPKFiUMEZvToH7W8QCJ4rrbka7R2S1FmIu6FfCsPQc8WazlmBmbeTjLyfaeMPF8bs7jT0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujeeivdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrshhrrghfleesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:8Wo0aDMc_3KJOsXjRu8GvMpQ8I0ulIzeWRPQ9C2iLiJBoL2DUZ3Hfw>
    <xmx:8Wo0aA-YPJ_-4M_EN6YG7gHGIBHLmAOjPmFYvuOnc2dc4F8sGz5LXg>
    <xmx:8Wo0aLXUJO6m89W4R_jy2Ti-K0bf8xvqvReGygdAl22VzWAc2c8q0Q>
    <xmx:8Wo0aJfAQvw61aymb_6qNSb9f4TltEuaH0m0oVM1xmVfBAOJvPdKFg>
    <xmx:8Wo0aIanVPKF9RZUxoaNCfltFPivkjmbfhTcxjrPIWtS9ch-9JGxnSyj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 09:21:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 42e5580f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 26 May 2025 13:21:50 +0000 (UTC)
Date: Mon, 26 May 2025 15:21:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: david asraf <dasraf9@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: HEAD.lock and git maintenance
Message-ID: <aDRq6oIgkSfAepcP@pks.im>
References: <CANi7bVAkNc+gY1NoXfJuDRjxjZLTgL8Lfn8_ZmWsvLAoiLPkNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANi7bVAkNc+gY1NoXfJuDRjxjZLTgL8Lfn8_ZmWsvLAoiLPkNg@mail.gmail.com>

Hi,

On Thu, May 22, 2025 at 07:53:58PM +0300, david asraf wrote:
> Thank you for filling out a Git bug report!
> 
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> We have a system that runs many git commands on a local repo connected
> to a remote repo on GitHub via HTTPS. Our system creates many commits
> and works with many un-staged files. Every once in a while, we run the
> following sequence of commands:
> 
> git stash --all
> 
> git checkout b1
> 
> git remote -v
> 
> git fetch
> 
> git status --branch --porcelain=v1 -u
> 
> git checkout b2
> 
> git stash pop
> 
> We start this sequence from branch b1 and record the output for internal use.
> 
> What did you expect to happen? (Expected behavior)
> 
> We expected git checkout b2 to succeed consistently.
> 
> What happened instead? (Actual behavior)
> 
> git checkout b2 sometimes fails because the HEAD.lock file already exists.
> 
> What's different between what you expected and what actually happened?
> 
> The git checkout b2 command, which previously succeeded consistently,
> now occasionally fails due to the presence of a HEAD.lock file. This
> issue started occurring after upgrading Git from version 2.39.5 to
> 2.47.2.
> 
> Anything else you want to add:
> 
> Using GIT_TRACE_PERFORMANCE, we noticed that a Git maintenance process
> (/usr/libexec/git-core/git maintenance run --auto --no-quiet --detach)
> sometimes starts after the git fetch command, occasionally in detached
> mode. We suspect this operation is causing the issue because we've
> verified that the git maintenance command requires HEAD.lock before it
> starts running. We are considering setting maintenance.autoDetach to
> false. We are unsure if this is a bug or if it is working as intended,
> and would appreciate your comments on this.

thanks for your report! A couple months ago there was a similar
discussion with someone else, but I cannot find that thread anymore,
unfortunately.

The root cause here is repository maintenance with `--auto --detach`
will detach before spawning git-gc(1). This command may decide to pack
your references and thus cause them to be locked. This then triggers a
race condition, where the next Git command that wants to modify refs may
not be able to lock "packed-refs" because we are still busy repacking
them.

The actual timeout to lock the "packed-refs" file is configurable via
"core.packedRefsTimeout", so bumping this value may make the problem
less likely to happen. But it's only papering over the actual issue.

I'll send a patch series soonish that fixes this issue. I think the
solution would be to make git-maintenance(1) learn about tasks that
should run previous and after daemonizing the process to avoid this race
condition. The effect would be that the caller of auto-maintenance will
not continue before refs have been packed, which is similar to what
git-gc(1) used to do in the past.

Patrick
