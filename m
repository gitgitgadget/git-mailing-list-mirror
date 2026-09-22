Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F76A5632A3
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097067; cv=none; b=BebRPJQ0uslJ5bEcv/haKfKuLcm36MB1VvlRX5RhsHY7Sq7ZDEXPNp/TqGabMcBAMUQ+w0OfTckQNwmb8z0pgA7sFePnrYjeqr5ntGrjMEn7/7yI0hhe93dgk1mosXK3WCNbs7SROdNoycBYiLOcEbvLhtkZ4fNjV58Ave2EFvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097067; c=relaxed/simple;
	bh=1BfVA4x861vxQOI8Te3TOy+bpfrZaUTB5iK2uP1FO84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jctBF+0OlUEw3ST94bvXqgm82mF9BOlZo3sG9x7GI1SIyFmQdVmI2tLnaWPwySFbB54L82VUHDVvDRfAYLaDPnq8r8ij2WdCexTuorhHiFk5pWpMm0h3xuA+7aucazJDS0CRHOH3mn6hgQhodu2kcon/dJGqWFX66Ix/v49D2/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GoyojoeZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O+1x1G8z; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GoyojoeZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O+1x1G8z"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C522DEC0173;
	Tue, 22 Sep 2026 13:11:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 22 Sep 2026 13:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790097064; x=1790183464; bh=gDOn1/z0Qv
	ulULGXAbc3McTao1IyGvqIPv6u5MR3Y0U=; b=GoyojoeZYh+4QIUZLNqwPXz3HM
	xhBH4OqcbasIXDZZp2CwwMKdAsUSNL2zBoRoJfZ8oPLM7hZe++j3nv6dsnQ4thGT
	yp5VcwuFKXFzQN1EnfqcW1U+5/Dc8TossVb5gv3j2GSWKLfmeqU+nwJpvRZLG71m
	+fnqWM64AvT6bv+5AibcJoHjKMXhGTK4YVh9DLbn78iSS5q15F88iF+yuajTcYgH
	5vDJNrQhnG3YrsqG4kpbDos1IrJVJ+VSY7fcseOXemgQTWWOrBDKoX8p5fJpccui
	YXt1GQnD0KUhf8x90jz+L1Re0AoVS2DXrbsHg8QWQBpVN1Bfp8OmA5Gt/O7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790097064; x=1790183464; bh=gDOn1/z0QvulULGXAbc3McTao1IyGvqIPv6
	u5MR3Y0U=; b=O+1x1G8zzeLMXcOZ13R+B4d14IKl41obXph5Y2xVtBZRNY3iNaq
	7ftVsGe6eUJJeV3mkHxjpJqJU2rC2Nul7y5rmvu+Ml/+mOplDEyzHIl9MOpxutDL
	/t3RaCyy0ybUG9/cGxbYxQ/PvaaaTEyYYJmrPIWQmeASprt2cV3KoZZDNDhRklT0
	Duw0mP4iJt6T6iLuaHL4AuGS5m6qS0OSF3rwsg+bcs/BCrDumJKtA5GmbFev6lIP
	lDgWjIvPUIs82HMXC/AAAUOPx/Ah7tPQ2776NSp4x0mQWdGno31DhOJlpFWPUQVn
	d3fLH762+vOv0IL7G5WkeGcvBnYtWGI9Tug==
X-ME-Sender: <xms:qLayaonpGZeItB3cVkPwOrBvccm4FDWny-B5ctJ9dzuIB9RQplB0cA>
    <xme:qLayautrUtHz33_6x_HkZKEhSSxhBmsBSvFE5oM3PdEM6rgIc0ejCuvCLmGOUyvpE
    ztHXKefek3sssPxywh_WR4Z4kUC7t4v3uX9VvJm0TGdg0jkLBtItIw3>
X-ME-Received: <xmr:qLayau-nwxZIUtEks6Vrvrbyj9Xhb9Xpv36BL13jWCFUpUjh5GXLsD65V2-4svpAbkh4Zq3tgwjAJTTwiF3wQ9x5KJaGAcvHOy7C>
X-ME-Proxy-Cause: dmFkZTEZfwtAqIWh9ooSR/7mLlwfbTLrTitSG+WdCfsfUNhvuL4pIxc6cH5v/t404zOHRr
    jTlgH7LJt3gbYsP0ChZyNzcHTwsBoUd8vZlTPW4J3otwCt2M2nNF1aU6bkdaVYUzQceQe5
    UmdBSa5VFsFT67sOMeJtISo5eHa7Amrp5IMwsw9+2EEzvxZarpeCCSXFIBMkmauC0q/lrf
    CKjuhqP67x5sadJPxE88iqANjXIQPcRZPWfqpWdQkv37fYtrlemTzXQuOc/yKbRuJY2N2G
    0EdSSzxOjsZWxlaA2hrMkZeu6s8Cfy3zY1/p05EFvRjUHfp21FdpSBmNZqqVy7Gxr7BoWD
    HzROXdWD6+k+pzeTOCMU6008bFMUCnJ+3aBQJT8WpOhcEAqLBHC8mlXK8zE/oAw4hIX3cp
    vcGuvWoveucBqeVqlELYPel/kcPi3/Lno8FW9fO8LvRuVYrZKa8ok0GIEQm5YIIvfgt9p1
    OqI0gKtG0RnQyqDL1UiA6PSKdKYvcKXLUA+E2fefIlduqm79FT9BTeERLNyoXkbLunbWCW
    fbGTg+JoQyLLwV+eYgwdhs6NYGogiWSyeFK06+B+K0huFIJ9vObhNf1N3o0WlCI7gLO1h7
    2iAQu91p/OJJJWKK6DyCYnucecXm7HQ0MnaUr1iWB6IcRdMeFW65jMoAf1oA
X-ME-Proxy: <xmx:qLayagNlJBK17bGisLt5ND_YxiGh1yDwi7yAn0mX73iHEQ6hYEVR0Q>
    <xmx:qLayakFxGVqsEp_9psZ30da-ScPs5F0-DoAkvWtUZ9snI0_l1F11Tg>
    <xmx:qLayamT4fQIgJa5cZRsS5l5zz-qx9g_d-ZBpc_xMOeICYLD9g1WnrQ>
    <xmx:qLayapviNUc7KWK-vIMseKgoaRaBxGhHHGHU3CGBakW2KFYjgVy5mQ>
    <xmx:qLayavcI75NeaJOoF5OH3rukjm9M5dogH8G-tLBgMgq4w-QElVYDMVeV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 13:11:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] fetch: add config to avoid fetching every branch in
 shallow repo
In-Reply-To: <7f084e4d-f738-4bd4-9b4d-cad995f04be8@gmail.com> (Phillip Wood's
	message of "Mon, 21 Sep 2026 14:28:08 +0100")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<7f084e4d-f738-4bd4-9b4d-cad995f04be8@gmail.com>
Date: Tue, 22 Sep 2026 10:11:03 -0700
Message-ID: <xmqqh5jhfbyw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think the sparse checkout is irrelevant? It is unclear to me if this 
> is talking about a case where there are many branches in the remote 
> repository and only one of them was cloned, then adding a second remote 
> created a wildcard fetch refspec; or if there are intentionally lots of 
> remote tracking branches in the local repository and you don't want to 
> wait for them all to update. If it is the former then we should think 
> how we can improve the behavior of "git remote add" in a sparse 
> repository to prevent it adding a wildcard fetch refspec and instead 
> setup the new remote to fetch only the branch(es) we're interested in.

Very good suggestions.  "Avoid wildcards" is easy, but designing a
suitable alternative ("only the ones we are interested in") may be
harder.

Perhaps we want to have something similar in spirit to the
"matching" mode 'git push' has, where the set of local branches we
have defines the set of branches we are interested in?  That is,
when 'remote.*.fetch' is configured to signal that special mode,
'git fetch' would:

 - Find each local branch that has its '@{upstream}' set to a branch
   at the remote we are fetching from.

 - Fetch these branches at the remote that our local branches care
   about.

I said "in spirit" above, and I find it tempting to use ':' and '+:'
as the special '<refspec>' to trigger this mode, to mimic what 'git
push' does when using the local branches we have as the set of
branches we care about.  But there are important differences:

 (1) The correspondence between local and remote-tracking branches
     is not one-to-one, as you can fork multiple local topics out
     of the same upstream branch.  Maybe our 7 local branches build
     on top of only 2 branches we fetch from the remote, for
     example.

 (2) Corollary.  Unlike the matching mode in 'git push' where local
     branch 'B' is used to update branch 'B' at the remote (if it
     exists), this new mode in 'git fetch' only uses local branches
     as a guide to determine which branches to fetch from the
     remote.  If our local branch 'B' builds on top of branch 'U' at
     the remote, it is branch 'U' we fetch and store as the
     'refs/remotes/R/U' remote-tracking branch, where 'R' is the
     remote, and 'B' as the name does not get anywhere in the
     picture.

In other words, this is not "matching" at all, even though it takes
inspiration from it.  I do not know what it should be called, but I
think it would be a useful addition.

Thanks.
