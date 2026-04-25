Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FEC3624BC
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777154339; cv=none; b=LxXa3dbGbpNdqHJ+44XNEcWfwB28GddiR1sbglZLhIoPmXjRQlIj0deZoKf2HRS+Mcg9FIB6bv/EW+oiZJ8+utQV5alx1bSbrtt0JBNiTg3beTPAqW0zlL5khiFaPVDz9LDzoB74I+lBJkG8XH5CtnPBnc9WVzGeUD6RBV3djnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777154339; c=relaxed/simple;
	bh=nelslIX7/0sUDmXjeNwlMNAgRapi8ZENX3s8/jQCh9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j3/LFafgj7MauQrhuhAuxeTy+xppLOBsB95gOL9PJBfvPDHjT0YrFIKvS9IWokN7a7QQ8cKzq0TUZW1Oq38Cuu5iyj3C1f1j7NkdMYLqbzekcVOAE5u1RlWcbFI6cgSPPvpIK43H1neg+mDsIwJIHrL57FFhERYbKQwibP8t0vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fnWdPwAm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TuMHwoyM; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fnWdPwAm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TuMHwoyM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 13999EC0211;
	Sat, 25 Apr 2026 17:58:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 25 Apr 2026 17:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1777154337; x=1777240737; bh=Juxbp3s93B
	ojlLSL8qfpY8ZKkRmnabK94Xz05NOtHE4=; b=fnWdPwAmGYfjEhusI269EvKJiq
	ymBC+83+UhF3X0zkb2bm0EbENOltcxsXEwe1u7Czw5kJep6GyXq0Rvz/ickddYBz
	zfZ3f5lcidaNA6Z12X/8bNZOA/lqmiwaId8Kzc3hMDaU9s4Lwi6DuptnaL+GkHaU
	SoxNWvpEk54rMZOS+KWtvq/j0X8pKGRYpnGqK1IZPxy92A6orT7qSPbpAGEV/5vZ
	MgkmXSGjzIpNoknp1AtkyP2ANbHtScEOBKZsFirvNVZyZO5g7NOktbBCviPR8xbk
	xdDU+meqDNRrjjVt+FkEVaPCSxsrujgGEXTiV6oCKS6aIw36cyO3mDXAGERA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777154337; x=1777240737; bh=Juxbp3s93BojlLSL8qfpY8ZKkRmnabK94Xz
	05NOtHE4=; b=TuMHwoyMoRGGpSmlxWK+WtxBgxOUuMhMf+AGgoF2mhk681D+uQG
	mvzh+Z128OMerwMxYir24IpjfyQd3EfqjeTbfV4MNORdmp+RMWENT7kvMVPXNfQ7
	gSyCDWeTzELfI5yEMihAfCwA3qvB4LlTsrpDJWQXsjCv0nvQMPUApBhdrQzHvWPj
	Qkq+horAYhz0lUsOzjqee+Y3Sd4eNgkTu1264Y4uBET5crEDOLjAAaR3UE99ZaMu
	n4cdPTdN6Vf8tKqWuaEjG7TDRVZZHRdT3X3dGnns9ZNtR6lMTpuKbMK97HTrSTJZ
	rVzNpeK04nHnwytm3TIJzeu2NAd4ptxUMmw==
X-ME-Sender: <xms:IDntaUs_V8ljMQdN3hK63ll3BUQJAdf1pbfEzBEjjQQi3U1xdX5G-w>
    <xme:IDntaYcVVuPj_ZqRmHA6axQsXxJiydnAQt_KogVXYGVnyVZeGIwKCeg2DT6k7T2FQ
    VNOZOor6a622z51yIm18WddbM2Us2Vu--zOBgdAtolV-zqvfRqslw>
X-ME-Received: <xmr:IDntaUyCXHu_mQ2OlEeHnqdvQ31tR3JxJr89APpiCd8329qmlip8OlVdOQWAXmTXv338bgcT5TbBoXwEoBUBsDwFALolPALPJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejgedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    hhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IDntaWHQo4J4reDeKV5wd8fLjvWjkTqZgQQ85GBZpCQkjB1xytI6PQ>
    <xmx:IDntaQwVpLF2-yAVR3nX5Tpmp4xcYOPh0dKnHNjE8QVuq1q3JSV2Mw>
    <xmx:IDntafsLbCsSIM-63BwdJRNswKAOPLwuJiq97ryxgb-mz22d6xm_ZA>
    <xmx:IDntaV2vE80R98Zf4MD04MveKUmwm5p6lLHMkI85c1PZvrnj7Y6ndw>
    <xmx:ITntaYT_EOxhmD2x8et_7ay0KDxE-5QswHglYPiOkRUPPTruJnPKOZK8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Apr 2026 17:58:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] remote: add --set-head option to 'git remote add'
In-Reply-To: <pull.2283.git.git.1777115978088.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sat, 25 Apr 2026 11:19:38
	+0000")
References: <pull.2283.git.git.1777115978088.gitgitgadget@gmail.com>
Date: Sun, 26 Apr 2026 06:58:55 +0900
Message-ID: <xmqqzf2q8zxc.fsf@gitster.g>
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
> Mirror the behavior 'git clone' applies to its first remote: after
> fetching, set refs/remotes/<name>/HEAD to the remote's default branch.
>
> Equivalent to running:
>
>     git remote add -f <name> <url>
>     git remote set-head <name> -a
>
> The new option implies --fetch.

Should this option (and the auto mode of "git remote set-head") even
be necessary as an extra thing that the end-user should need to be
aware of these days?

It feels to me that the "fetch" part of "git remote add --fetch"
command should behave in line with what "git fetch" from the remote
does with "remote.<name>.followRemoteHEAD" configuration.

Of course, the current implementation may not do so, and that is why
you are sending this patch.  A patch would need to plumb through the
mechanism, but I think this should be pretty much automatic without
giving more control than what the users already have.

And because remote.<name>.followRemoteHEAD that is unconfigured is
the same as setting it to "create", it means "git remote add -f"
will behave just like "git clone" would to remember the upstream
choice of which of their branches is the primary one (which is what
HEAD in the publishing repository means), unless the variable is
explicitly configured to "never".

IOW, I think this should/can be done as a bugfix, i.e.,

    Even though "git clone -o <name> <URL>" does, "git remote add
    --fetch <name> <URL>" does not create refs/remotes/<name>/HEAD.

    Fix it by making it honor the remote.<name>.followRemoteHEAD
    configuration variable, which was invented exactly for this
    purpose..

or something.
