Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEF93612F4
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784573380; cv=none; b=COeNVUOSJOBqEj0xAp5caWnUMRzlrURf8WJTfwG9eDH9OOHj4oMzZpxAWOF78sv3thPhiYhTQ47NCt5tz3EvvbkFq9tyvV9dZvQcitl/jxaPRjj680z4vcJYEpe7muNN/3rO+wC08vhTGuyfwPJLuESREB74UmEdLNSrdT0t8qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784573380; c=relaxed/simple;
	bh=8Kl+qtDRuASM5PLK+cRPEd34r/FfE5APf79vHWTmM3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NAHgELfOgq88BPcuwrYJBkx9XGtt6gXms2UMuanOHyrJdx3+bopuNAuxIPcICE/VcMMFs2az2dCPWlNwOONI3gkt8N7+UEDnIDLAHqi46Z9lb63ZBXeIZJZRo5aE4Rxq2MyrTEY2qmrcpgwNWPF4sQToxyWNps95d3iEX9uKEVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pnnnmqhr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PQ8PIJOP; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pnnnmqhr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PQ8PIJOP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 760517A00EB;
	Mon, 20 Jul 2026 14:49:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 20 Jul 2026 14:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784573377; x=1784659777; bh=CKsZARqybF
	Qt/AnNfeKqY3gynEjJUfMAGxKNe7+To1I=; b=pnnnmqhryZff/KEPwY9CHGrKJh
	P0j0WBJ9PtZrJ6RsRnxzdRKNu2lEu8sDed2j2JDSLt0Wd9BIRZogoZRduKUvc+lB
	+8Su7mRzn7WtZ6/XFjYFGhnFz+jhasGxNOEZlu+lwMaeigPd3wuIgp9Vet8RmmTc
	fAmUjaBDzADlo1QDq7sou9u1KjFQLITJAjj2/DEVmOKw/R05lAPtftTbfJKdMcF+
	rTJizefQTJ6Nlq+Z6J6tWnw7X8tndAZOq8fWdd8nrS8bhXEkzcikU4i6QncNjAej
	+KaY7D/qLjXVpH29WBdNUakwvFzALAh2GfGMOGWie6ewQunqiVv+a03+iJVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784573377; x=1784659777; bh=CKsZARqybFQt/AnNfeKqY3gynEjJUfMAGxK
	Ne7+To1I=; b=PQ8PIJOPjx5SUwAoCDEGMs7nl7+PQw3eaQMJMGuN2d9y5og7MTf
	ONCkooA+f0vm+ewybZQtxdsoFufb+LNsvlyfXGRyJ6d0dQCUZIxNb9qDnbe3VJar
	zjBsbJcCVkGtT10dtSe+r5LCBNU+X+nksX9e4JrmjfN9ngUcAdXGvC0KaNHuxyFF
	cMXNE/TbZAK4Op+hhuvWP4M0rupRMhHLOEypxjKVf75akzB0h+f7Vi3Rlfs1hKvH
	PJWJPSCvsA8jcIgifOPaPUBgDtN3fUPPU8lmzmP1ReWFZtiVInabEFL+69PoS2ZJ
	41d8zFI0FMFPkji9EHCXTAxQyaeapIjtiSQ==
X-ME-Sender: <xms:wW1eauiebKQRBmkXUwte2ENHgXYq0VsUPJHwt_qWEGBGHq9o99r2SA>
    <xme:wW1eamDZEqpvJfVpPDKHQ6s-vlvISHUOIV4BA0jcwq169FINFaSPeYn5KFe7suTTp
    DIwhVTIrSJc62V5jIQzyxXXLLP2KZ5KO4JzkPTpSyaHn0QGfC7-5A>
X-ME-Received: <xmr:wW1earHbvGvHPIeRx6QuHtKK3MJcTDwVBMVolQpq_9-eyqwZGNKladhccVd20RUG3tIGNMEeujJiaLBWJT0s8XAKutRZrH21MA>
X-ME-Proxy-Cause: dmFkZTE0DQEAKCcP3bYHdaNYhdEgs9RTkcerKgXWzFdk8rHZNRnAKkg8ZepGe00Hg+31AB
    /c9wVR4m17i4iWEYX3LDy/Ri8YDOUvmBVUkNnkm5XM2VTc/nxDS+1bWVRc5ZZjgLYdVWLw
    o3FubAJBCmNKMGCOk7k3KPPsfuKU0MHcqhgafLyZdwWIluF35whwH8ML7DOeASWyxXpPOk
    ioxvn7YjvrCB/8Tq29clFuaa9Gf0bWlvc8F87XChInYK9wstrQBx1QUCoa60IRSYhm5Yqg
    MTgeUnBWtUqQ6rZSFZppx7kWolFfGlifupOoQ1RuuhP4wFIe1XinUhRVx7HPFBf212yXEc
    X8ZBshDCL3pcY6lYTDlyKgUErYKh2YPzPxTqxGUPgeje7lmeaPjoYUooCrcDyuoveoAuiW
    LpYJ68z7Jtqr0PFdKcFJoWTvP8Pgtmv+sj/hiR5NUDCtxwn6Bldm2kuQ7LwsClurub7xAR
    GnYiSIXv6jnwTtzglS6tLZF+DA9mRZrH/E23p+erVhF80UjbHjZghkGITdR5WaY+Z0Sal9
    ms1AuLPo9RkopuxM3IiimMDvU1PS7w/fyinMQrpZoLqDE92hldR7EWzMXydRniP6stBkkA
    wxYVkIGul1yUQPYOsLXHpbjzLrL9HQl20efk3wUQwJX2rWHCJ5xijKwapO1A
X-ME-Proxy: <xmx:wW1eamKeFmtzJXCiWsste13732C6UHDOmEz7DgGU-MGQlOOMMSQtWg>
    <xmx:wW1eanmxhpao_glsNqLWVa-mwbp-ynhAlryBdR9AwURVwZsKrkQ-Lg>
    <xmx:wW1eamSU7vJSI5BcP-CYc_2HkqAncjncpkSQxK18RvjBqxY_AJPk_w>
    <xmx:wW1eahIaAtXC0WNRimO7qkHCdzh2k1V4KG1TXYZrjKWy-pEOuEkKHA>
    <xmx:wW1eaikpVBRsAA70UV60WzzFmk3hbWjBrclsOHaDYoFPTN5UUUVLPfwZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 14:49:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 2/2] remote: resolve URL-valued push tracking remotes
In-Reply-To: <ff645b21591a4b365b30acaf67a295510889141c.1784538618.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Mon, 20 Jul 2026
	09:10:18 +0000")
References: <pull.2358.git.git.1784538618.gitgitgadget@gmail.com>
	<ff645b21591a4b365b30acaf67a295510889141c.1784538618.git.gitgitgadget@gmail.com>
Date: Mon, 20 Jul 2026 11:49:35 -0700
Message-ID: <xmqq4ihtcx8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> A branch may name its push destination with a URL instead of a
> configured remote. This is useful in fork workflows, where the original
> remote is renamed to "upstream", the fork is added as "origin", and an
> existing branch.<name>.pushRemote continues to contain the fork URL.
>
> Git can still push through the anonymous remote created for that URL.
> However, the anonymous remote has no fetch refspec. Git therefore cannot
> resolve @{push} to origin/<branch> or update that remote-tracking branch
> after a push. The push can succeed, or report that everything is up to
> date, while status continues to compare against a stale tracking ref or
> cannot show the push branch at all.

Let me try to think aloud, rephrasing the explanation with a
slightly more concrete illustration, to see whether I understand
what you are trying to achieve.

The current system allows you to set:

     [branch "mytopic"]
        pushRemote = https://hosting.site/users/me/mine.git/
     [remote "notlinked"]
        url = https://hosting.site/users/me/mine.git/
        push = refs/heads/mytopic
        fetch = refs/heads/*:refs/remotes/notlinked/*

but when on the 'mytopic' branch, @{push} cannot determine which
branch at the remote repository to update, so it cannot map it back
to our remote-tracking branch ('refs/remotes/notlinked/mytopic' in
the above illustration).

A question.  Do we currently accept a string that is not a remote
name as the value for 'branch.<name>.pushRemote' by design?

The 'git config --help' output explains that:

 - 'branch.<name>.pushRemote' overrides 'branch.<name>.remote' and
   'remote.pushDefault'; and

 - 'branch.<name>.remote' and 'remote.pushDefault' tell 'git fetch'
   and 'git push' which remote to work with.

It therefore seems clear that setting a string that is not a remote
name (such as a URL) as the value for these three variables is a
misconfiguration in the current system.

I am not saying that it should stay that way forever.  But please
re-read your first sentence and tell me whether it is clear that the
patch extends the current system with a new feature.  It was far
from clear to me and caused significant confusion.  Writing it like
this:

    Under the current system, a branch cannot name its push
    destination using a URL.  If we were to extend the system
    to allow this, such and such benefits would become
    possible.

would have been far less confusing.

If that is what you are doing, that is.

> A uniquely matching configured remote already provides the missing
> mapping.

A very good consideration.  It was the first thing that came to my
mind while I was thinking aloud, constructing an illustration with
'notlinked', wondering "what if there is another remote, with the
same URL, but different 'push' configuration?".

> Use its fetch refspec when resolving the push tracking branch
> and when updating tracking refs after a push.

Is this not needless, and is mentioning it not confusing?  If I
understand correctly, what the change entails is:

 * If the value of 'branch.<name>.pushRemote' (call it X) is 'not' a
   remote name, try to see whether there is a unique remote that
   has either (1) a 'pushurl' whose value matches X, or (2) no
   'pushurl' but a 'url' whose value matches X.  If no such remote
   exists, simply abort and refuse to proceed.

 * If there is such a remote, pretend that the value of
   'branch.<name>.pushRemote' were the name of that remote, and do
   everything else as usual.

And mapping the current branch name to its push destination via
'remote.<name>.push' to find the name of the destination branch at
the remote, and then mapping it back to our remote-tracking branch
using 'remote.<name>.fetch', is not something new that this topic
needs to update, no?

Thanks.  Once I understand what you are trying to achieve, I will
offer further comments on the implementation, as I find this topic
potentially quite interesting.
