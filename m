Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3E01A267
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783118978; cv=none; b=tnftPy/9rU+qtAefof6+3OM2prsWP+FCo5/cAJJYOSk2i0zPmcBtSLbhz1gVBbhQmqwTwmqArXuPdHazxThaK0eqt2RGx5vAxjxvQkO8akxvMqlNh2pwtzagzrXjY5oPOIAKm7GxF4kE+56LCXb2LEJc+EGl+Tkbj9EVcggNfw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783118978; c=relaxed/simple;
	bh=qYSYFPJU78LSmDuOOO50Q3sq+DTtLyyOBISwF8GMcHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mXyozgb1SY6O6N0TMTK7IX8S707xR7e1NZ/nZNePpLLXuXEU2SEH4FihF0jX4jZ0BFJK7KVtXzlwINzFnFQVihEbAOhRRl6HVO5/dlOC7mujkgdQ4zuF9O1d8SLm3n1/4lBWP5DodN75+AaO0yDo0H0XF9TCnzwKNwRUBPdEDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i/d4kwuh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RP09suy9; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i/d4kwuh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RP09suy9"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 560847A00CC;
	Fri,  3 Jul 2026 18:49:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 03 Jul 2026 18:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783118976; x=1783205376; bh=3NGhDmVFb9
	9vPRBnK1GOgZomu75qxnlr6UD7zCkR/DY=; b=i/d4kwuhQsvluxzVxuN1PvbXUp
	A80EtFz1rYdUlUN1CUrafLJzyoVVDWlRxTe0qFAeB35t4h6KBdeexZBw9FZYerz5
	JumCOvpzsc7SX+V6gIPmna+XDpqchUckEagtGCl8asfW65KFCBn0KdE6h7wB0CB9
	NROkVc5aksu6e704senOKRvQzelvsW8mvd74Xi2JXq/TKjiDNf2byI0jGIkYMEwr
	2ZWu+vXMCjIYPOYgbKoZ75fIxrBPzuGChRUGIH2A4avuaZSgdAKBCFSv02UbmbU9
	ogIkBKs4Yb5/LzDIB183yIPnZBE0CklsYXLm5gWJUJV0aTAqFoLb5l45B48g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783118976; x=1783205376; bh=3NGhDmVFb99vPRBnK1GOgZomu75qxnlr6UD
	7zCkR/DY=; b=RP09suy9ygZvXwAC9ouSfzjXmKnagnVzqG3lHKtCJke5U3K1qPT
	2jFdd4I1T/Im98eRRgwAOF9rFFzNi5Td0+vIPYJeFOIb4Pw3kzD7umzIZKqlBC+c
	DdlenP9rU0Rnl18opfKQZJWtijwXtUU1whzht77w4J+Z7/NgpcZ7D9GgAMwKRIio
	uWK60x/SFmS5s6Cggbdb+aws5b6sykzxjPjjlxWxuWLMNVGOZqdfy5zzNngA1Rpb
	ZJcxhy52CqcktPSCJxxak4424h3vObsPtwSMKiztF1jdATB78OeFX6CJQoBOgE/9
	sFRMdSbWy6T8KafjIM0sO/zenw8Z0BhWRZQ==
X-ME-Sender: <xms:gDxIaloUHXePoCW01FmUgwH1aCO6ZmaoC7_dsj9gpJ351hnRfVCSTw>
    <xme:gDxIauhsz8Gjy4BJBQop2DLPOk2yLBeHCHl8dVisIYIyyhoHHrHpMI8_61bhGmINk
    UdNDJiq0NFt8V7KRmLVRpLDR-uAIjyOxjeGP1ySsBZ5o_6te5TegQ>
X-ME-Received: <xmr:gDxIaqhhHBq4YENYYG_BDxgic6wjk9ZXPI8VdIyV3TUXJTakS8ug5y_2DzR1uArt7ZeiOO0n7FCNMly5328X8HVhzh_IHQt_BzjXr8A>
X-ME-Proxy-Cause: dmFkZTE5qqGol69/lOOFvP1DJuZm704tnNAWBeDZ6X6WGLhGzdDXGntgoTfnmvJI0PvcrQ
    94uMbhk73q8U+TEiOYN88YLG0IY0/n3Kjj6cb3DCJY/0T5MlzHSsUwlRAaoCKF0RnPD1p4
    8zONnkEBjQzUnxsU8xy6fqQprz5fzKYrh2SG+YyhxsncssYyKd6zaG781gdVlMCgAo/EGK
    jUlouo9pGCXA9nPdIZbEXw9paQva0cV+rAKzUphO7iUeKDaqHxGf6FES+A3eP6go40/EG2
    R3ysawqMNl4bhY8YcNQ+Wl+eaFElLGf9CGx+UEEUskGLG9sxEhh4kWdNohcHxBvEb3ShXE
    x8hhmFgu8fsV4yZGmzY7wyvGh0odRAn2u512vbTKj/FbOy59yV0L4fkttm7bch34361d39
    B60RBHHW9srRA71/3K0J59rrNX7h5O6rFudrmWMyuIzUrd9SB5jHqe96os4c86a4niKGMr
    VXGI16gXluTZGFbPYa9zcNRvaf+BDw34exDvQ0qXvw57zcSpwFhstiAD08qpEbOxo9cnkM
    53iicHeHPU7+Vx0gTiEzj4DZrhfvl4jJl5jM2IDnKA+eCiaXOCrwr/pwwxGmBupFJhToYw
    p+1d8IOSVPasHK9LGS/LkJwPOuzSEVrpUlomW9FTNvABu9Tpa6CNLtT/E9Uw
X-ME-Proxy: <xmx:gDxIasiuU9q0gGavnn4SJ9TtWO1omsgJ0Dcylxf_QbBs1YDtiNu-Fw>
    <xmx:gDxIaiLYHuo_qZMMWBRA0sCRxKrG9RWKl_z6hvthIsUry6ynhTMy5w>
    <xmx:gDxIajHspCS_k5Ydc2iBj-7mCHn4K4nGgbXeitjavfv_6M6j9EE7pg>
    <xmx:gDxIauTe0VcHwNK2fAZJtl-elwHOx6ooy6aKmJ8z95XBqJOfpeIpXQ>
    <xmx:gDxIavxajeXQSaZIJ5maGiZJqC1SXP3memoOuCBMx3KPBfY9BL7dLdeI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 18:49:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  lucasseikioshiro@gmail.com
Subject: Re: [GSoC Patch] repo: support category-based prefix querying for
 info keys
In-Reply-To: <20260703164709.22723-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Fri, 3 Jul 2026 22:17:09 +0530")
References: <20260703164709.22723-1-jayatheerthkulkarni2005@gmail.com>
Date: Fri, 03 Jul 2026 15:49:34 -0700
Message-ID: <xmqq7bnbheo1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> Currently, git repo info relies on an all-or-nothing query model
> where users must either know the exact, fully-qualified key name or use
> the --all flag to dump the entire repository state.
> As the number of supported keys expands, dumping all metadata and
> relying on external filters like grep becomes an inefficient bottleneck
> for a plumbing command.
>
> Enable category-based prefix querying so users can request
> entire groups of related keys natively

You mean "repo info" takes layout.bare and layout.shallow (right
now, later we may gain a lot more), so you want to say "everything
under 'layout' to grab these two values?

Why should we limit ourselves to "prefix match"?  Would a glob like
"layout.*", or "path.*.absolute", work better?  Especially the
latter, i.e., "I want the path variables, but am not interested in
their .relative values, only the .absolute ones."  It is especially
puzzling as you are going to do a dumb linear search in this mode
anyway.

Perhaps during each iteration of the loop over argv[], you can first
look for exact match using the existing bsearch() codepath.  If that
succeeds, you have a single key to return the value for.  If it does
not match exactly any key, use the new "prefix" (or "glob" which I
think would make far more sense) match codepath to find which key(s)
to return values for, so iterate over them (or say "Hey, that pattern
does not match any key!" and fail).
