Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1F8498917
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790622114; cv=none; b=rID7IrZ71OqHgqvr33Lhuq6grWo+uR61+QuPGCKQajdYaXfumTq3L7KowqEk0ME/1pSa8mOfzbZ6gPHrUQbnhyhR97SU7AluuHPog2Bn+B06nTbFdiCDypsUwCC5N+5Yw4bLGr0MKDaOI4SZ1UI6hEiphYZ8ZJzG4HI8f15OFMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790622114; c=relaxed/simple;
	bh=l3jRmOCTCm6jfxgznfKYV4DLS62BE5OirQoVMSfJleU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XqX4IdjOjNajstaQWSTTYI0Vb71b9/uX5cBowUy8GjnsGtE4V7Kj1Os55KbzTcVNntpU23E6muz2HBHmsf8vAcAcL2FP0BdwM6gAreI/KmnO3PbNOXMdSaYea6I2DMj+UtB0VDe0BR4twiInlePqsch+pdiWB4k/T37sMB4qTP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gbe5GrnB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EUeT6kZ0; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gbe5GrnB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EUeT6kZ0"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B7E0B7A0053;
	Mon, 28 Sep 2026 15:01:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 28 Sep 2026 15:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790622111; x=1790708511; bh=Xj1X6lff0N
	nt+rzO/eR/59uy8jHIKVs9dwvDmuq5ngE=; b=Gbe5GrnBWG0bxFPu8tVSuz55Cn
	EnZIs+jZpy7RfwP5o2WmmTfj7FakGsX9P0VkL/zAxL852w4ljW5/t47fNDQXKP2i
	dAO5XWi22Yal63wBWfnj9VYuK5Gsp9PZSCw6W9d5sMoc1GxDdA07WNbVO0YtyWvC
	Ywfmt7SsXfedi67dEPrWEd0YA5p4O12wNgkeJR/PnDMuVwxp/1YmNDw2uAl/vMn8
	up7s4fqWnfEaoZDR7xKXZtetz5vYZyb2/aXMEfmYUr/l4P76zcRqfnIBvhyesPUF
	0M4Em5wEJiT5+6Q8fpttEIYS4WtOdk9aTBQCQUpQrZdqBnFLhNCxPhVAUQyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790622111; x=1790708511; bh=Xj1X6lff0Nnt+rzO/eR/59uy8jHIKVs9dwv
	Dmuq5ngE=; b=EUeT6kZ0nszn7vN3lRbN0OrePLn64fiRmxIn8yfdq1dzpz5xrI0
	zxWhpKJ4AOKMuaBJMbc4siU3givr3i+J3Rt65gGcdZb3wEgcu291KOsWHtUmX6sq
	w5gJZrzYITan0dYTplZfi6yTfBRv6Ly7NF8v7GjVJO6YfXL/mVIBCSiN7pQBNZA7
	k5xkza/dmAd8T3wA5kx5Mfh3jVTjT6jvdkveV0+mXxat2OPl/xIq1qlB29OvH5mH
	wsbFJTcVHGpy6TiEC5IWw/uhhnO87/d2B5yzaWZJuwwjUszUgEw4q7pAGtp6WQIl
	O1D8cdziGHh+i4lVLJyY1D2t6HcyZW9wCXQ==
X-ME-Sender: <xms:n7m6aj7Wkw_422OQY336kEmHuC4tddHdKvdMzMdRylYr1SC3KBmLAg>
    <xme:n7m6arLwY7jKrlbWTEw8HLXyEMQW3eom0utJeSofDR1MeyLLHTNL0rIrt3u-BjEmq
    0_vkb9J23gmzsfAk7K9tvKXpqup_Js7VQTOoNYYLwcwdLlXgoAY7Og>
X-ME-Received: <xmr:n7m6astDKXgE2p7CFOEOGiv6Fjnx5Rp1q-OlgyGYMcKzcmgZGSWXUFz6lfZE9A5pZqYxx5fgnjLHZZ3h46zoyY7Ol0D_NJ59NROE>
X-ME-Proxy-Cause: dmFkZTGletcwF06gcTycrqXCU8AYQ5DsXKjfQ4crscVN0+KYROW1NZF205MLs0MjLXH2y3
    ch/NbjOwxFyKT83N4GzhnwHPPinI75+M56jDoLx3e253HdAcpLiYbDnQgiY/f5DVvKFBzy
    aHtCMMkNcwLpH2BZIcbBwjoUqGJgOGzuZS6JOE8/+N8Pc8IbLG+An0YVQpDf3R2QeMqPz1
    eqJMHozFXbSR54DCNlMKJaZz9THNJFgl2zBnZPYGP011dXrud9Oo6s7RgIPrWvqt+NzWwU
    nBvcDNYZ/a/SaxIAAXXV38YlSK0PZswezxA4KxhFjcjUo7LfzYsX0boLY1rVIowD1ly7hp
    GtMVri7Gb9i1X0WSyFs0esIThrNHsM3sH4W0iFHZMPlH1w7smvwEXFMKFQ+Lece6kh/iHQ
    CUPvJo22d5uRka9ALyMuB9wZaosUZZbkw4gcO8MKEmYU41Z/XpgfVZ14ZupwLm2ui3HPqC
    eRJSe4kx1jRL8+E1mpbiXBd2GLGR8Z0ZvDlDA+8e9HF6HtZ2U2dwYzYYTjcX3EXN2kqulp
    lyIMQUnYNBDvAflARiiaY2iH3Bqi0U3HOgWHP/g7FKM2z871pRovx1OZEg/u5OjCZLptpc
    +tAvsxbN1wZlRr+tx7PunLpKbjcaC9L/H6HcT7uCWkk30oOdktcAcJr6/qWg
X-ME-Proxy: <xmx:n7m6aqKtTVRBQl4wPI9_cMOqkq2HmpMkqq04CkRKmMJLH2kP3S-VQQ>
    <xmx:n7m6al9OH4SfuZ1VuTUf1tIE530L4VC0GVRIdtBPQ-ZIaaJ9F1dg8g>
    <xmx:n7m6ajwYn1X32nW56Z9zKL6JvqxGyQDkkXgIeOmZjwk34GbUJ-JilQ>
    <xmx:n7m6ai6VrTfEnG7rK9w-IpETzIdor80HpJhSwwEAaSANMD00welFQQ>
    <xmx:n7m6asWfUHiVXqY7ETa1c8XomCuUZXumztqFvYYwkSr_p6--CEIT5KUK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 15:01:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: git@vger.kernel.org,  Niklas Cassel <cassel@kernel.org>,  Bence
 Ferdinandy <bence@ferdinandy.com>,  Philip Oakley <philipoakley@iee.org>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] doc: clarify that set-head does not change the remote's
 HEAD
In-Reply-To: <20260927055040.2441925-1-matthias.goergens@gmail.com> (Matthias
	Goergens's message of "Sun, 27 Sep 2026 13:50:40 +0800")
References: <20260927055040.2441925-1-matthias.goergens@gmail.com>
Date: Mon, 28 Sep 2026 12:01:49 -0700
Message-ID: <xmqq4if9mc82.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthias Goergens <matthias.goergens@gmail.com> writes:

> `git remote set-head <name> <branch>` never changes the remote
> repository's own `HEAD`, i.e. the branch that a fresh `git clone` of
> that remote checks out; every change it makes is local.

This is true, but the local nature of the command is not limited to
set-head.

Adding a new 5 line paragraph specifically to the description of the
`set-head` command may be an improvement, but I wonder if we should
tell the readers that anything and everything done via "git remote"
affects the local repository, not the remote one, as the very first
thing in the manual page.  That way, we do not have to say that
'remote prune' only prunes remote-tracking branches and does not run
any pruning command on the remote repository, for example.

Thanks.

>  Documentation/git-remote.adoc | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.adoc
> index eaae30aa88..c9cf17e7bd 100644
> --- a/Documentation/git-remote.adoc
> +++ b/Documentation/git-remote.adoc
> @@ -107,6 +107,12 @@ branch. For example, if the default branch for `origin` is set to
>  `master`, then `origin` may be specified wherever you would normally
>  specify `origin/master`.
>  +
> +This command does not change the remote repository's own `HEAD`, i.e.
> +the branch that a fresh `git clone` of that remote will check out;
> +every change it makes is local. Git provides no way to change a
> +remote's own default branch from the client; how that is done depends
> +on how the remote is hosted.
> ++
>  With `-d` or `--delete`, the symbolic ref `refs/remotes/<name>/HEAD` is deleted.
>  +
>  With `-a` or `--auto`, the remote is queried to determine its `HEAD`, then the
