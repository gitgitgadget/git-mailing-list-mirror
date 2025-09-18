Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93D01DDC1D
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209350; cv=none; b=kw1A7WA0RTObyZYGfYW1R4bqL+BguGHm3wRYExXEBZkJjZuf7aZbtZZCs+XUlLgXwU+m5RQHNYFC+1wOfv+TXSX2zQCJHjvTTtEDcYUpdQyMr8X96ZJ9feuXpeO4Ry4WWU+XczDBzzX0jHGUMjXtc1Qm58jY7hdcXSPeN+OgVj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209350; c=relaxed/simple;
	bh=nxiSH6M6hVyU8Bpc6EEAChTDtJKSPvzmnPHR+nK1/fM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U1y4qUurN9NFOhy010HoJ7uVA6H75tuGXvZJy6KCIR1kiuT3PXgKI/aZefwqJggYXO30B2xFJEzon17gDI+/pR+MGYYbou29oB7dH2qLCpJ6TLoYd4m/c4dnb+5XbLpkO3NBbnVloT/5R85BnovHtT50JyDkJh36cpw4EuAvgoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h861uIoG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iJDFuWvR; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h861uIoG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iJDFuWvR"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DCC8414000EE;
	Thu, 18 Sep 2025 11:29:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 18 Sep 2025 11:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758209347; x=1758295747; bh=3fD3lW46HS
	5RhXW/begMT4o0z10H+a0RCT6jVJUsUsc=; b=h861uIoGG6/3e+K7TOpsODw2aE
	8hu+yAbnW/rWn3Dag70RPPp9x6yDMG6KH8kdKh4l4g2tRvmY9vg6d+dEjdr5ARSp
	IQ9f71qq5vPsFqYHHaqhI9k3XBUD4NqTJD5Isk5h3dHfmGdVYJ2M6Malix7LxfYG
	k1UpDs9pu8JWTiXOsncVtRRLOxw+hwreDt/Y4AKLzqnEo6zyqInWpdDHqiChDXFf
	kA5nMCuFwtZBkxHvfIKtDMNT9L5UEg/8XOHuRXdF/lcsoKfNEaWka5G59X9hsSUp
	BPZKELhtb8dQJeKLQ28c9+qMVrX/87nTXmJgfImXbdXlD+VUtIfOdOXgFWqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758209347; x=1758295747; bh=3fD3lW46HS5RhXW/begMT4o0z10H+a0RCT6
	jVJUsUsc=; b=iJDFuWvRWIvNfnfIxZ7G1UPqwl66qBMXtSO8CrNju70m+b8DTKH
	oMH9+60vYO4Hde/9DYI2dh5PkbTbr+FTKEiGb3vckgDMSq8SlcYMYRvMTOoxkHmU
	kLWV1v2v8jwA1f6EgUsKj9e23PX3GbL/KbfRRp+KalMCJmHdychcbNcifsPJdztq
	ZBRpsBe33E+E3VCsgBGMsx7PgmqaCCfaHQSASGB3ha6TBk4+pTLtkQgi8PWB+F5H
	oLex6eQ3QBaZE5LUfy3A5fJBjPHjXVTK38y/SeZhC4MW5/KyItChZJKZjpoGyX3g
	hpxUNJIy1Zqln7mWgVD/6aDGdTPnE/eXJBA==
X-ME-Sender: <xms:QyXMaJZTGixrq1xcXl9Pju8-JDNkfEGMlMKeKxlgsZ57VvAz5hf_9w>
    <xme:QyXMaL7tqDMJFnr6_Dym3meuj1p5eJ8mDNKE3pfUU4HmrKWqIkILKF38NCBa8QCU4
    k3615SLKvWW8aNfmA>
X-ME-Received: <xmr:QyXMaCYYTzkbu7rUlLVMVg8NS_wimhEzOpA4vkXwbdOPxp0yGbcSjwCT_Af8_ihj4livHZk-bbwfMd6BkZdL6aFfu9lcMsbY4n3tPD0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegieeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeekffffgeeutdethffhtefgfeeuleevgfdvfeefveetuefhledvteevgfethfeh
    hfenucffohhmrghinheptghlvggrnhhuphdrshhonecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhih
    hllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhih
    hnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptgihqhhsihhmohhnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QyXMaCgpfeJf-LZPzabzQYPdrwoeXvJH8wXYFl4Ev9Kl21-msNv8uw>
    <xmx:QyXMaL_PIIeIzNf_Vd1b2_Ulox31rCTfLyL1zAU7RauzKpp_dCMUVQ>
    <xmx:QyXMaFpW63-3QzRyOe7snv0tlL80v1_FAV9XbD73UaCzPD8RCHjixQ>
    <xmx:QyXMaLXhMYUyfb53QovwATx0ibNceYfq4nhDFmDhT9bbQE8JwfwDxQ>
    <xmx:QyXMaJ8j8wD1FO3bcTourMFh8w9S6gRHD1EqA1XjtHO7S0WQTbRcgkBm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 11:29:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Simon Cheng <cyqsimon@gmail.com>
Subject: Re: [PATCH 1/2] rebase -i: respect commit.cleanup when picking fixups
In-Reply-To: <8fb1b4b4a5f4857a3d7d98d029b22904751ec144.1758186038.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 18 Sep 2025 10:00:38 +0100")
References: <cover.1758186038.git.phillip.wood@dunelm.org.uk>
	<8fb1b4b4a5f4857a3d7d98d029b22904751ec144.1758186038.git.phillip.wood@dunelm.org.uk>
Date: Thu, 18 Sep 2025 08:29:06 -0700
Message-ID: <xmqqtt0z93ul.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... The cause of that
> bug was that before f7d42ceec52 the sequencer passed CLEANUP_MSG
> when committing the final fixup. That commit should have simply
> removed the CLEANUP_MSG flag, not changed it to VERBATIM_MSG. Using
> VERBATIM_MSG ignores the user's commit.cleanup config when committing
> the final fixup which means it behaves differently to an ordinary
> "pick" command which respects commit.cleanup.

So cleanly analysed and clearly described. 

> diff --git a/sequencer.c b/sequencer.c
> index 9ae40a91b24..47c57c2ea3c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2436,7 +2436,6 @@ static int do_pick_commit(struct repository *r,
>  		if (!final_fixup)
>  			msg_file = rebase_path_squash_msg();
>  		else if (file_exists(rebase_path_fixup_msg())) {
> -			flags |= VERBATIM_MSG;
>  			msg_file = rebase_path_fixup_msg();
>  		} else {
>  			const char *dest = git_path_squash_msg(r);

And this is the location the earlier commit replaced the code that
sets CLEANUP_MSG, which matches the fix described in the proposed
log message.  Makes sense.

The commit at the source of the bug is what introduced VERBATIM_MSG,
and I think it can be removed (this was the only place it was set).

And you removed it in a separate step ;-).  Well done.

Thanks.
