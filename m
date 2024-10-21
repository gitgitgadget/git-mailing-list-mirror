Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA72E1E8847
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513256; cv=none; b=tOewxHI6B7eC8WpcShDKcTHgz5C5yHZJbGCxQ2ckNTXfSRKCROUzQ1dM/TC85ko/I6XLprloAgtTkEg7XB8Wr60RrEpcntab8BavV/r6W/jKTWQmJTOR1BqIVjbG/eUXIPcGjYzgDCWUfVVbnHo7xjoGYm+RLX6E8eXU66mCmeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513256; c=relaxed/simple;
	bh=N4lw5D6wC2Ubi4YTTb654tjn+Eedj/t57EoM9W56EZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0odOeTHAoc2eQH2R+v5H5u3m0s70x/zrMQ7+CSbPfcAucFdm7EcdSEsfYlc+A1U1PlvfAuzrI0lZ3nJqIpDjKxVwgqOSpaFUQJ9FrpA5Dd9CYnCt0wINZnJoI76C6Kas279SJnm5NoVjXVx5tItTepJcdDOmAcf9hm2tcExW7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rBSulwdu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cEZrl6q9; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rBSulwdu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cEZrl6q9"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E877813806A3;
	Mon, 21 Oct 2024 08:20:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 21 Oct 2024 08:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729513253; x=1729599653; bh=FZQzc5ZgdI
	jrMsF6lJaIlVREiqAupsQH46DQx+nlV40=; b=rBSulwduLZOMt0PcbSBEKlxJz6
	kTUWuN1FVgQkZVsrAXG/Lyw1609AEQ/wKXZr2XiAdYAGjMHn0xZ/7HofiWBa8Z1q
	p0VLU68BLFxzeFMJItvX/tUHs3wWZNJQH/pk0ias5xz6kzFHgCXvilF2vgVS6A3/
	7SBnrwMIZALZL5GgWJ4Z0tnfpNKtURiop+8bW10uqlO8jd5wfGFlPL0CXrmMhzh3
	31e2JG/LbeLgh+2kcnuB+S2tcoRQdhuvxNB86saoS4l9TmvaUNJaJeed1UDa+MjW
	hVE8B5oWv3oBBl6Pq4JroIg5/eelxYeO+zrHfEb+g+uWjq6yW8N86heG6YMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729513253; x=1729599653; bh=FZQzc5ZgdIjrMsF6lJaIlVREiqAu
	psQH46DQx+nlV40=; b=cEZrl6q997wOJO6rtqx3pzgBaRFmqG8OkTMB+hRTfpCJ
	MjmfMFSQNM2sFGNhnHBsllosXj61SSe3nEBLKJ81dwfKlTHPohF+AhvP6PT+s0ig
	G/DYcZcNTMAtsRmA4bvq5m+rh507jyZ7oM10tXjBn2TI3wRfnDQjfToSjuHTPteC
	ACLBUktoXswmo1ybN2tJVjL+K6hpx+8FnggCfQeyVP0OesOwmPnGCNnY02Euv1MF
	NEtlOVelab+n19h/U7BKt82gA4eETm7Oc9wMeL4ls4n31zhhZE4vZcCxIypohNIB
	EzL9iqUMwv9S7m8dSLe8P8XifC14NkltcEmUPvsd5w==
X-ME-Sender: <xms:JUcWZzKGfPm-aTg_1fcWPfFNc3AZ_BlUGUdHo7ZguGKoRGVCP5ETyw>
    <xme:JUcWZ3IrpHTlZvjeN3rl0wqldtL4IbMNfnvAoEECvefnPF3_HKSBYoRZB5UVj_brc
    EEnTmSKdPW-K39j8w>
X-ME-Received: <xmr:JUcWZ7tDZwlchq1oXZ5RWGsgGVRHuqtCB_lj9Wdv2v_VTx2g0ZtedoDi0dOFQzyuMoBY7u40nn8T98_D3kXDXqaJBiqGSqskDJKA-O5_Uu9s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:JUcWZ8ZEGafCpPD38glcyZJErQDgS6OZB_0F3wtG2U9Y4eUzB3C_8Q>
    <xmx:JUcWZ6bwVzAsysfqAk25J58eA2SYVw0nvbALE8bO-pueuLr7F4mKnw>
    <xmx:JUcWZwA3leXXyHPzOGdUwNrurjy8z4ybmdSnAlGHnMbHSqIA4rWYGw>
    <xmx:JUcWZ4b8j_bRr2MZ2BUJYkSUFdG52uQv-4YZxhJ_5ojX3qUuoVu7Wg>
    <xmx:JUcWZ6F8DR7LBPF0KYMLMnNr0nOIepvtGj3TZ311xSU19hs8zQ4Pc5EH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 08:20:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 605e550b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 12:19:25 +0000 (UTC)
Date: Mon, 21 Oct 2024 14:20:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v2 3/3] imap: replace atoi() with strtol_i() for
 UIDVALIDITY and UIDNEXT parsing
Message-ID: <ZxZHIk-gH0Onpt15@pks.im>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
 <c09c7b3df0d7eac3069cee45cddc49a76da2503e.1729259580.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c09c7b3df0d7eac3069cee45cddc49a76da2503e.1729259580.git.gitgitgadget@gmail.com>

On Fri, Oct 18, 2024 at 01:53:00PM +0000, Usman Akinyemi via GitGitGadget wrote:
> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> 
> Replaced unsafe uses of atoi() with strtol_i() to improve error handling
> when parsing UIDVALIDITY, UIDNEXT, and APPENDUID in IMAP commands.
> Invalid values, such as those with letters,
> now trigger error messages and prevent malformed status responses.

The line break after "letters," is a bit funny.

It would also be nice to point out why this commit doesn't add any new
tests. I guess the answer is that we don't have any tests for
git-imap-send(1) at all, which is too bad, but a fair excuse and not a
problem of your patch. So introducing such tests would be too much to
ask.

Patrick
