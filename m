Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9C4194C96
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784250693; cv=none; b=NDeFU4PCTHMqxKuegpr72cwXjZGUvG/zYBS1DkRRlNmL6gwGZrpGUJ86oZj9JDPjTxZmlVKV0SLsuu1H0GfwSciBr7Pt3Brc6dozyIaJNbSN2DIE44ZmpVpnDAZjBO2vpDbwe7mRnfOT6krdkvPpn4hBwW5YEz618eviE2GkcEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784250693; c=relaxed/simple;
	bh=JzWEYzdcVfDPTOaWmVApJjitbjAgB7gR5DYVFnQdOvM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BgClU8NrGggsO5Z3D53v7VxtjzvuKjkGNuakCORpNPCiD+i94HVD1fF8tfleehow+FxVdWgcXO0ub8m+Ven82tyF/aYe+miii/WXQJ4npUTV6Z8TgCXXXAHimrVeO6eyL1bKAig6PT0kwUPNYnoFqNJw6Lco3l1MM8GAVhNbXLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PWEAAHNv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AMAFSOE3; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PWEAAHNv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AMAFSOE3"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0123E140007E;
	Thu, 16 Jul 2026 21:11:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 16 Jul 2026 21:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784250690; x=1784337090; bh=L2TQl9Srsu
	nS/WYx5pobWwf42KRLdUvWJq+NU3Agi8A=; b=PWEAAHNvIeXnRd6piP89AXz/Lo
	8S05iHDSB/bnvrPACKWLF5HLt0mfSWUzgNQaBLbwgzwPHBTXjqiKqK3pIsaU7gUZ
	x+AIOttLl+aKsuRXmzkwJpOW7QtTg+evaB9+bE7THZxB5deq/2PgTvzaWDVaVfst
	UR2XICVYer68HfybBKMLoIoobsMCdXleHzcrjiWK11ESxG4n/WgcQCC1BlhGORic
	TcFQ7UqwqMvgKIPZchDSKE8E1jEyQtjYL8JVqMiKB739uJsaU+OckB1FQWUY9Lrx
	h1Wm9RFPdsp0h2Sp8Q5f1hZzXrDgkt7+M/C287ICoJ1Remrjs2AneHb4lYhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784250690; x=1784337090; bh=L2TQl9SrsunS/WYx5pobWwf42KRLdUvWJq+
	NU3Agi8A=; b=AMAFSOE3bxYnfJwuwk5RTwBKbG0fkoCEf3ApVrmhZmryitROws0
	JvHA+FV9FELcneWCRccrYZbhR/lX5JTYchMRiveUFSjQnJmiuLkrjXlskaTaN+6z
	MnFiz718d2d5LHS+Og+6ekyBx/LxddyIJp13DXfHmdVIveAtxvnf/m46RlVzTwN2
	L0WNCe3j6U524+1/dMsIb9/Lfj+qYA+0cuAANwpslFT1UI8WrykuDKAqJ9p7eeHv
	ws/NLeku+deiQICY2J9p5m/pOJZG8x/L/OAI8+KkhhfNh1MVhgYZT2Az4Bjwt0Uk
	dPFGt9cNlGCi4o5BDiB1to4jz1Ju6cnmwYw==
X-ME-Sender: <xms:QoFZaqdSIx8uNfLTU6GP5Lh03YME3c57GlWKFYnglNzTOa1jSxZTgA>
    <xme:QoFZanQ8tTLW8Gxo9Nb1inhdXQ7U_8ztZB8UIrIarRmzNu3GcLCECzUXEHc98vH5a
    a7H_6ehM7eOd7GkLPM4KCUlWN5UBKgejZVGPwy1VHJIthCPiYx4>
X-ME-Received: <xmr:QoFZamLNiBrc9QsL5n86opuOlI6WPkIkxXqfswht2A3WytUjauCT_3RPQIsJ-Yp_aEZcA3i17mjxPnByQTd7PJAn-NtiLOaGaebi_H4>
X-ME-Proxy-Cause: dmFkZTEAA1/MbY33+/6Dd0OR0qEZOZUMyOe9HOSJYVECg4jEv5fynlBfMGKasttuUPzYwF
    VnIvE250F56to5maKrP3ZDk7R6Cooqk6OOMCZJB9TJUNu2H7WBTyiqzpy6LiLU4UQSICKk
    Bzf2TjK8voDzXYAeGlwjXK/iCS0q8KhwUlDeqenXBcArN3ISebrVE7NjflihGztqnihdYX
    LJro46BRKgADbUNQlNTMtSUNNsM2wkP1ploX37B7VbWJmvd6LzqYrq1Rd8DnPhbY5TQ21Y
    NyjDxGZEEyE4V6Be1FsrrmS2iQLM/OfVsQ9LH/+sWakYeoToyIZs+XNHAf8ssjqJUzCmcZ
    Vo9wcXFsFh7+MwiFW+zpO3tGiMCpYp3QKufEYonVrosLc8KBDuIk26KICwwmIdY674AF4G
    lxalZ2AW0lhwAydXbj2qhm4mA+Ehm3mp6lfM5qLW0Oofn1XEIVnWEsVjdVEeQUGjFifvty
    Pc+UzNoPfPqw/tp92v1mmiqA5isWXDg6P0DTotVo/lHgqx5QkFbnfjcdUkGiuqnTA+AD3D
    kDzLCZIxGqI76DU6hY8idfWGHupd/Oexu09sQSJmPlWfVQhFATpDkAHKZWDCRGZY+Zxt3s
    ukpLZTovPsVqfS8NVaK+2gmtzM2k7J1yt3qyeiEmAQZSacdlhwAwkZHOp0PQ
X-ME-Proxy: <xmx:QoFZakL2H2AdKMKlx2zQH29KIiy0R9oNipqRtTFIbQ63xNdDfbCMdQ>
    <xmx:QoFZahiPc3nmiGqxMinqqw9T1qVfGkchM4UhCtWt0JtDGXhBV60Uvg>
    <xmx:QoFZauONVQXlJy8YJ57ZfoAR6IgOpzIepIVg8xxwlxccy0qYWoL4XQ>
    <xmx:QoFZasodplPrJt-q-vpJakDcPI0-NEHkhgoRQs2hUiw0wnlzsXiuvQ>
    <xmx:QoFZalI2hU1w2bR7k4FuSEC1U16qxsySJVPxDjMec96WZsEFngW8BMZ->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 21:11:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Emin =?utf-8?Q?=C3=96zata?= via
 GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Greg Hewgill
 <greg@hewgill.com>,  Micheil Smith <micheil@brandedcode.com>,  Michael
 Haggerty <mhagger@alum.mit.edu>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>,  Emin =?utf-8?Q?=C3=96zata?= <eminozata@proton.me>
Subject: Re: [PATCH] stash: add 'rename' subcommand
In-Reply-To: <allISNh-b6Sc6y5-@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Thu, 16 Jul 2026 21:08:24 +0000")
References: <pull.2180.git.1784190706028.gitgitgadget@gmail.com>
	<alitkCsplW_DIaRw@pks.im> <xmqqh5lyhlp6.fsf@gitster.g>
	<allISNh-b6Sc6y5-@fruit.crustytoothpaste.net>
Date: Thu, 16 Jul 2026 18:11:28 -0700
Message-ID: <xmqqpl0mbetb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I have a large number of stashes in my git.git repository (211 at
> present) and it may be that I, in a mad rush to solve some problem or
> another, went with the default message.  I do this kind of thing with
> repositories at work all the time.  But it's inconvenient to have to
> search through `git stash list -p` to see which change it was and which
> stash I need to pop to resume my work, so I can see the utility of this
> approach.

Hmph, are you saying that you are going to wade through 211
stash entries one by one and reword them?

> In my case, the stash is likely on an existing branch (such as my
> sha256-interop branch), so I don't want to create another branch right
> now, but I do want to distinguish a couple of different stashes.

This is not necessarily related to what Emin's patch does or tries
to do, but it suggests to me that it would be ultra-nice if we could
have a stash that is associated with each individual branch.  It is
as if we have been living in a world with only detached HEADs and
you suddenly invented named branches.  ;-)

Well, the original design motivation behind "git stash" was the
"boss is here" emergency mode, and the expectation was that such
an emergency would not nest to leave anyone with more than a
handful of entries.  Thus, a single stash shared repository-wide
across your branches was not a huge problem.  But our workflows
have evolved, so our tool support may have to evolve alongside
them.

Thanks for the food for thought.
