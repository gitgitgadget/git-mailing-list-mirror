Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD1D2F3C3E
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 21:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788124521; cv=none; b=csdmgSmsSxeM5DOElwk6eTteHHULyWsFuUJC0wgA9Fb4omitwg3wwmgrhtdKf1T8CWzEIoCK9S0srKdQ+0PwBs4yq/t2oM0z7F9n17F9Wbg/DCDgoazKfsC1CnN7+ZnxhVJqyryQvd9eJu43X2craxZQqpNp16XyHeeyrumGMUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788124521; c=relaxed/simple;
	bh=o12iRjzaCCSjld09Ryhh2JA5l5OQbe8fekG3un3wSrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JmbESnsh/k96oRI/C86upY5DcHxICvAhD6RkfskROr/jWTYhmR5Pqgoa4MzdQVy8oZ2XQ8q9D8x/0u3O1Xx1hwmd4Mu9FUSsZkBSdD3joW9QPUEFG/cRsR6kjKwbiR9b7aeiIwzPEALOb6/C1LjIOU1PKxq/LCjlvi/4KR5lclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wwXi7Ghc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SXO97GJj; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wwXi7Ghc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SXO97GJj"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 842A714000BA;
	Sun, 30 Aug 2026 17:15:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 30 Aug 2026 17:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788124519; x=1788210919; bh=bEM9lm3a10
	UgtLRSKZnSqUdhkFt4ZSsd5yht3b/5c5o=; b=wwXi7GhcUAhVbO2QIEtjbktfx+
	OwSekXaAIkAokCgwg0uPO7v2+r5pvcY3aeeL9k19MM2dSyb8D/rka32UdaHtPjfW
	sHYxIWfeagx9RBl5B6ApGwrqYiFFQC+vgmTcU8bDjBfDAtAU17WCHJGMSkzjPBR0
	ksCjXQt4ThRoDwuUEale7pH75W+ws2u8bsdXpJNQbGjKAf6jymSgSGAGI4oafvcG
	crzcLaUYt1Mphbgr4j1F/2oiGlgQSnC5NE9cGTF9oE5P6f05v1hxqjuL+/DZV45X
	pBBytcK7k7ERH91H7eIPduJBuGNbIditlU5OqUHLoJbKLdVIlYp2+IcnGDhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788124519; x=1788210919; bh=bEM9lm3a10UgtLRSKZnSqUdhkFt4ZSsd5yh
	t3b/5c5o=; b=SXO97GJjmrHBk4O9FfgVIv3KtzaoU0M2eaoVnU2CwHwfZV6MuUb
	MBuu6li3rdOzfC1dTZEtCLqMmsbPs87w3t7HHOvk7QC+kVnWR7GhhWA7CMG6dSMc
	rLJFWo1wZ3DXGP8tBuhaqHd8F/OnFzgpasp2n/q1POTi15+5F/fv3h1iQLu2utPc
	OHv2wgvbDj2tJheourJDE1aHWGRt0iVHK1UvNyoBjp8HtDme3iAsPv+3OJ2Un1Ms
	zMEj/ugIwMKg4nnDh/yqhY+lIjAaWt77bSh/CX2Y31URVvhOIgOwnlVZn8iUkvab
	zDC4JSTpQskYZXkrClagji3eyIr96pJkrzA==
X-ME-Sender: <xms:Z52UakzDK84r1np0M-9S9DALO8sp_2NiGGueDcmcnbeA9XAJyp4yOQ>
    <xme:Z52Uaqhz9gop_SHuM4GjvN7ueXO0Q057mZKBuTA4HHNmLQLR8eRuAWX9UxmaJP8GK
    y_yi8ZoDNTZYwqxg4BOmaS6b0WZj3IC8ZUbY-rqMdgEldtDQCI0Kg>
X-ME-Received: <xmr:Z52UaokK_FDRjrUxrhHts5yugjIQAxHSykk9S73WLXlPHxv3i1rYsAAaDJ1_oO5FiUlpoMyiaY2nUNxZgdtaYzv9qtsGLmUJ1w>
X-ME-Proxy-Cause: dmFkZTFHoXt3Pr+no3LVYDVGfZFroRXIiiaQN78CWGeVetrJ+twtogKoXg4zTCUawNuLgr
    GyuLfC6+OkB4ymGfSwJBImlqZVZxEdsTEnqEsghFDMXhBFtedTrYLesJDKOK/5sBQi7o2r
    XX3jD4bZecZTsYkRDu9+WSk3qoh6ybUfbzsbyNknWV5Oq7GXh+l+Xoji9wB2XoWn4bXJw6
    j+9raQCEURzNBuEj2B+IPwC8TufvEg8rf3EL06f2kY+lrEgor/aaoZaBxvw2irvlFL5MUx
    onj5XUqiMY+Qd4UUhiU+9T3X1m96srPE/KGHkqPhhrEDnfa/uDz2PgZi3svba+K7vovdk4
    EXTlEgdpJ5blx9ZWPLssiqYxPjMOVN/MVtCac6O5hRpMah6NvKrfA9fE7v5y2CyQeJX2Jn
    mnWl4ClRfW8MVaatCnXOtZ0+z8CCYB5UpEv0vG4eSrtlCP8LUGiJD/dyW+BclohSgui7Q5
    6gIQOTIpV9myQL1em0mUFPwPGqSMioB5M4sDTWlQJWyq1DOYzcuproPGm3xwND0qVCDy9F
    bMDhYYlVVjPx6rTuBd26wis+qYnQa7bRcWql2+Vf6aTt9YBhr8LFSpTg5JHIx+Ol8orxxW
    eQc0MnFrSDbA0kqbgis57wR9FsDk2i9vq11BWlxNme5vg9qlj2hnhCddWm4g
X-ME-Proxy: <xmx:Z52UaogAw__aBA2L5eyNawJOOm4po7nAQfy2nvkGZxFmkXbfamcpsA>
    <xmx:Z52Uak0-ls3XKXDPxilUyZzrMM2tQQ5Poq6oIMJFu5Ga6oHDvsoGhQ>
    <xmx:Z52UapIUOwxyoymYYg6_QCrsnACKLKDs930dqR0_0OLx354F_hcEfw>
    <xmx:Z52UasxJFVCmZF9J3KTbfG6p6c7QcnQm1I3nFbpWTEftLM5eWpX3sg>
    <xmx:Z52UakP7F4nB_bk0h_MOC-kHHhvwsiP8zFX4LYGtkVfeF0pBdiYP0Zyc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Aug 2026 17:15:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Olamide Caleb Bello <belkid98@gmail.com>,  Todd
 Zullinger <tmz@pobox.com>,  Tian Yuchen <cat@malon.dev>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
In-Reply-To: <01cd487cd23f23b1d18359b86fbcf18e25039e6d.1788010335.git.ben.knoble@gmail.com>
	(D. Ben Knoble's message of "Sat, 29 Aug 2026 09:38:20 -0400")
References: <cover.1787231825.git.ben.knoble@gmail.com>
	<cover.1788010335.git.ben.knoble@gmail.com>
	<01cd487cd23f23b1d18359b86fbcf18e25039e6d.1788010335.git.ben.knoble@gmail.com>
Date: Sun, 30 Aug 2026 14:15:17 -0700
Message-ID: <xmqq8q5n1fa2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> +		/* nanosecond timestamped files can also be racy! */
> +		(repo_config_values(istate->repo)->use_nanosec
> +		 ? (istate->timestamp.sec < sd->sd_mtime.sec ||
> +		    (istate->timestamp.sec == sd->sd_mtime.sec &&
> +		     istate->timestamp.nsec <= sd->sd_mtime.nsec))
> +		 : istate->timestamp.sec <= sd->sd_mtime.sec));
>  }

Currently this is probably fine, but the use of repo_config_values()
here means that the order in which we can transition/libify two
unrelated things are forced on us:

 * We'd first need to make sure repo_config_values() can work on an
   instance of repository that is not the_repository,

 * And until the above happens, we cannot do a --recurse-submodule
   option that loads the index in a submodule and operate on it in
   the same process (e.g., "git diff --resurse-submodules"),
   because immediately at this step, istate taken from a submodule
   would have its .repo member pointing at something that is not
   the_repository and we will hit a BUG().

And after writing all of the above, I realized that I am mostly
repeating what Patric already said in the upstream, e.g.,

    https://lore.kernel.org/git/an720tZnot07HYiK@pks.im/

Other than that, this looks good to me.
