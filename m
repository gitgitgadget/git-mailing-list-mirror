Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E01A58D
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767055562; cv=none; b=AYJ+4jxj7ytJSqHi12VnsW5ZBHBT2J4YadO4XjJA1l85hHtMGKNSuAwxM20MLNzX1ZaL7OdD1x5LuIdtIYApM9uipEzDIJfslBAu7GTiczPBSGA+qcjJZa75m8J81KqJHvnlMLWkPK6JaIKuDloGplLTjKZ5e0/nJjTIkHVPtKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767055562; c=relaxed/simple;
	bh=p6gZGXizxGB09FVvqCUP6hUUk8Hg3xw3XQCRglnbsZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eo/Kup5G3tJhVlvAFE6G2X98k/91ufMWR6PB5ts0lJUnGVkBr+UQUCXFeYwz8MGmwNbHlSXe2SyJiYL7a03xvdUc3S0jTQaGSQCnUAhv7c/Yxc5Q+BUPGNgy5SuHJPglUd4k0J+L4Q0T1zLedEp1xLWtLzDqYPMplhprc6+/GK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GfHx1G4y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pRGKM1d1; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GfHx1G4y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pRGKM1d1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CE6941D000CB;
	Mon, 29 Dec 2025 19:45:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 29 Dec 2025 19:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767055559; x=1767141959; bh=Mm+VO4D1lL
	TN6Vgyssi5XD+zu0oghO/Yba+eqRLZq3w=; b=GfHx1G4yDqyeuIcswVzt7s5kP7
	aaR4vvXPzW1xaAnP24/jkz6K3xDOep4Yp1SnV2el0f6j+VdAqK3AcDUlVgaLKQcT
	Jn/6bAV0wixMjNA9hJYj5fI1BDf0anRzy41OFG9S2VJFow2KgyMPBgcitsODMGAT
	lJ6lvakU0aqh5on34u2lu9WcxylnjcW0XQt2q/BATBayZ37aRzSSiv5kNoa+29l8
	guf+VEEw2KRwCBEvMpvjFio+phN93V6u3F91AdeAQaXZzktjYkxDaVTNqTdnndiI
	SEx6erehkWj0AArUfvHJn9zN9JYWXoqq00y82J52md2OZaSX1dtDc10a3LNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767055559; x=1767141959; bh=Mm+VO4D1lLTN6Vgyssi5XD+zu0oghO/Yba+
	eqRLZq3w=; b=pRGKM1d16jpk1m5U0RILkmHQbr1GgY2ZBLve1mnQqElTL8nEoAV
	LuyHZGg4l9ASoHvQSrPiReFm+uFJTO8cU4aakp1NwUkafYPjdihFSC8bIQPelPFN
	oCec/EZzokZvQ3n8frkZKAXoawID349Hc4qKc0lFOCj4ex+p+PlZQl68GxVF2wUE
	FMsJeeLeVTOU133BBp8exIiGhazLOS1T+cTy5tLNADc2mrPYc6T4esTftLGglrR3
	vjI4/eN22AjRxOwljfe/H7EvVD53dv1xfjIH1W3qtiMix9UE6YzKP/xdabHp+EOf
	UfKt2egLCQGVclLp7AbA8MJcTItZZEelvHQ==
X-ME-Sender: <xms:xyBTae05vjjXohlMW5ZYtfAGgr7fyHt9y6QBfrjGkmwG_eb3FvrGjQ>
    <xme:xyBTaX9-shg27_-1EMQuk9Dd5D2IgodAN7nVwMXZXCkbIKGaV-nFvaydfjG-TQxxI
    8n_CLEl_WcSN4GVdETKiF2P7anPDwadhBGtdXLsAAro7fbl1KS5gA>
X-ME-Received: <xmr:xyBTafOIzEPx_Cp6LQC3euYqaiLIDQdSL-IJLP0cUTeP7YcXwItEodiONN_xOmtHxy-uONNaGVaUYgnEp4yc6fv7W4tDlh1DzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejkeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhjtghhvggvthhhrghmse
    houhhtlhhoohhkrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:xyBTabfLxSCx159gzqdZigjIjIT-dv4sG-xL6xtmyNzhz2AZiT0grQ>
    <xmx:xyBTaeXjB11isyaPefGLaOHmW6RuFakHHTv6Qq1wkwbELYyR9-BKZg>
    <xmx:xyBTaTggNGRyN5u3_PCv_0lQfg6dOA_N5Jq8V2CtIjthNURWEsrbhA>
    <xmx:xyBTad9P_RjUwobxa6C7-fT0Ih1gaTouoT_LarsPS973DlniUDQ4Ow>
    <xmx:xyBTaebb6jPXvrtRCsnaVjosyf5HcHdltTp2fPfsNI7QgxICjHUv3l48>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Dec 2025 19:45:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Matthew John
 Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH] fsck: snapshot default refs before object walk
In-Reply-To: <pull.2026.git.1767035549378.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Mon, 29 Dec 2025 19:12:29
	+0000")
References: <pull.2026.git.1767035549378.gitgitgadget@gmail.com>
Date: Tue, 30 Dec 2025 09:45:57 +0900
Message-ID: <xmqq344siypm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This problem doesn't occur when refs are specified on the command line
> for us to check, since we use those specified refs for both walking and
> checking.  Using the same refs for walking and checking seems to just
> make sense, so modify the existing code to do the same when refs aren't
> specified.

Excellent analysis and good approach.

> Snapshot the refs at the beginning, and also ignore all
> reflog entries since the time of our snapshot (while this technically
> means we could ignore a reflog entry created before the fsck process
> if the local clock is weird, since reflogs are local-only there are not
> concerns about differences between clocks on different machines).

Repository on a network filesystem being accessed by hosts with
broken clock?

I do not think our reflog API has (1) give me some token to mark
your current state (2) here is the token you gave me earlier, now
iterate and yield entries but ignore entries added after you gave me
that token, so going by the reflog timestamp is probably the best we
could do.  Any approach may get confused when the user tries to be
cute and issues "reflog delete" or "reflog expire" in the middle
anyway, I suspect ;-)

> While worries about live updates while running fsck is likely of most
> interest for forge operators, it will likely also benefit those with
> automated jobs (such as git maintenance) or even casual users who want
> to do other work in their clone while fsck is running.

Great.  Will queue.  Thanks.

> @@ -509,6 +510,9 @@ static int fsck_handle_reflog_ent(const char *refname,
>  				  timestamp_t timestamp, int tz UNUSED,
>  				  const char *message UNUSED, void *cb_data UNUSED)
>  {
> +	if (now && timestamp > now)
> +		return 0;
> +
>  	if (verbose)
>  		fprintf_ln(stderr, _("Checking reflog %s->%s"),
>  			   oid_to_hex(ooid), oid_to_hex(noid));
> @@ -567,14 +571,53 @@ static int fsck_head_link(const char *head_ref_name,
>  			  const char **head_points_at,
>  			  struct object_id *head_oid);
>  
> -static void get_default_heads(void)
> +struct ref_snapshot {
> +	size_t nr;
> +	size_t name_alloc;
> +	size_t oid_alloc;
> +	char **refname;
> +	struct object_id *oid;
> +};

This data structure is somewhat unexpected.  Instead of a struct
that holds two arrays, I would have rather expected an array of
"struct { refname, oid }", with the possiblity to add a "token to
mark the latest reflog entry" to the mix I alluded to earlier when
such an API function materializes.


[Footnote]

We could call refs_for_each_reflog_ent_reverse(), grab the
parameters that each_reflog_ent_fn receives as that "token" for the
latest reflog entry and stop.  That way, we will learn the value of
<old,new,committer,timestamp,tz,msg>, which should be a robust
enough unique key.

After that when iterating over the reflog, we know we should stop
after processing the reflog entry that holds the recorded value.
