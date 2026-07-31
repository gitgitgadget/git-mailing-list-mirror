Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD03FD15C
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513425; cv=none; b=G+Atk2lBnOwTPJ+/j5YxAxRfel1v4Ajf2NJDhIKQDALpNmDcQcjnKI2cTm/p84p/wgTvQhXHXiCWtgApfye8yfXlxbbuKjPHyQTjs7nodnp91XaJvdv5PYTB/3BaMQgA0FZzw28HkWdWSZYwKwuPCwMSDAckLf+zUq+/SDgt/28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513425; c=relaxed/simple;
	bh=hpRb9alUxuvc5oHeiV0Uo1MH3aHT2rHdpZxo+IobKj0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YHzM6l2TCw3jLAutfBbanRen5wKW/QjnQeKXUOPDUXJApwvSbHqBQOlYsnWsYEyZ5w0whe03804McQO9d3VPp0b9IHIm4LbkX6p+Jofn7fBSd0KWce3fJU/zxzNkyjvlJGDTSkGuLX+XTYaj899/5ytbBIv27YhztIjoam9E3KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AJJuezq1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YeFtKLk0; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AJJuezq1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YeFtKLk0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 869F7EC0120;
	Fri, 31 Jul 2026 11:57:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 31 Jul 2026 11:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785513423; x=1785599823; bh=pNmqSkuJEj
	W29cu5gg+vlaPuKCTTq+YbQIilzi9IF1g=; b=AJJuezq13+tA/FaX1YZikZ4sD6
	4wM5X8RffoOBDIwlMpoeKieYuXuKCu1nUJjLc9deIeOXsgCEfoQbGZTSKJ2Q+Mn9
	5UWMGo/MBShdX1AjFB8eymo6avCEDqWrD2wvIRSrj3/dDir9Jnk7RhC/5MczWO1B
	Gt5ys/+2Cel1NdZsG4lI4w8Kr68EMzIwuUENniFXN1rNJo57zfHAxJ/tblazuz8y
	CQlUHJY8P5eHonjqEJRDhononj6XiyG+XvVDO2zhyUsTJgfKW30PxPXSEBBrNKdw
	IRb5Q3xUkH2zQgeEMSskPd4K5k8evOXDTka8+OsHlsgitfR4ZfLsq97cyJqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785513423; x=1785599823; bh=pNmqSkuJEjW29cu5gg+vlaPuKCTTq+YbQIi
	lzi9IF1g=; b=YeFtKLk0Gvr83U2mzhpbKOGE4ZKnebxIKILlEZC4plWoY2AI02t
	dGP+cthzanrBY1od+JM8B5I7QHimukN4BqKo/qsKfM4nJTg1JlneCNJ9JFf+J3gI
	Gxvz+ybrctM3WegSCtfq139cTM/bLtjh1zHyJLjqUCbP2Ks48bGuUSIe9NO/oSoF
	Jj6u1sQipvqZyo+YziYsEzU4h6OZrD1xtpRjFHyCvkaI7Aavm/3qdK/FmNPPmbxH
	L92/dhRVaCZ5ECQ8kQfnZKotkLAzxxdHaukKat678AM1f1rQcF2A8ClBFPhxwfbh
	qvU+Q70RuPzZG/Ww2xuq3Rtnz/CAtkKF2zA==
X-ME-Sender: <xms:z8VsagLeJU9cK-1HGCcZV72T45iZeGwj2blTLoaTP1vuQfi-92puKA>
    <xme:z8VsanA5mjkJDExbptvN7nXHlvwvv6VXeKa1SvX3NNSMMeEsORUNB_3tfckH-RHIv
    SLlmqfVuvk7KCFkGx6aTtcoXVIgRbxgW_sFkQOCzwPtq8m5daOpMA>
X-ME-Received: <xmr:z8VsapCnl8xSqlLnrqoJgh5pT0FnceUt87_XXHgraZKZI-zgYpIWWK2r8R_Dn1F5csgDUH1-V6jzbqkckOOoMvq77SQfFE09nQ>
X-ME-Proxy-Cause: dmFkZTFt2p+sr/1KyDVC4FgDvOl7ndQmo51FJTNVZxXMxmqYIU8sOZjv7nVNbmF+fsiSVj
    1ySaiMiiBFef6DukOe8rcNJOxULFdqM21uWX81J1hKJI2X0R7VJ75b0fHZuIy6S3exeI9r
    VjwCZ4zuLvZlNMOuwQy8lu6L2aoLD1uLL7Ue0z2ffiksUSMmhTJjrcLxmVll6umNin/SxH
    HSLMV9u/cZNcjYapLuJ3UaflUK2zCiro2RZG+R4/xjf+R+b1rNqC5ZnsJ2kzhHoOgJiSOp
    w+jQ2IW4Hd8DRIhjABgxeLWtAcvyV46FkJjag/j3i2teObrcQh88WsZ6BAKdUjvQH9JEVz
    3HIT/kuPvChkHwN7bFx4SXbn+lQFhsUUa1tp1XaTaFPpLoD1x2b/kwpUq4jTrNRD2VCrRA
    vaMdfp/8JmCltQSpSQSJd4mR43kbm0HgfZQV6wyJ/lb0fxxPEGk9LbNGdcPISW24BygsVs
    eaNDCg9cqMKRE2KC6HUkUWoXlr0lmHbvtzIN2tcH2DoJUWqsF08GtbW8/clILTEKg4TUYt
    4Me1bN7n/vXaTUa/g+/AVDf1I9VvKXYfFrLSdt2NPNEhiXI5WvKkmcrFfG2mWHuiZOShg2
    hpQ9puG3drbQUkgqI0eT49JaJu/5gX4YrLd8U+TUriR/WJc2zz18KJa8NUMQ
X-ME-Proxy: <xmx:z8VsapDifjufgrxLTrzXZMh-evdoqABHEt0dRaLfgqyb20ZzHcOmvA>
    <xmx:z8VsakqUaUbEa6anX_AdiquW0dbvpOqCrTijwYV8QX03pHamlIrosA>
    <xmx:z8Vsajn5YrrKbktbMjKKgXWpEkpSG8O7SjvvZ6jo0tqkROjF7pZbKw>
    <xmx:z8Vsakyb0syHMRhw8fc-dRZtp2vP6FZd8Yk38xzLJbPhArL32DdyPg>
    <xmx:z8VsalhYwejrZyffCHJH2W9uJhAnAgQ4F2eu_6QQGSPa0linA-V-OhVv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 11:57:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Taylor Blau <ttaylorr@openai.com>,  Derrick Stolee via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] trace2: tolerate failed timestamp formatting
In-Reply-To: <fbb118df-7c82-49a5-90bb-4458b7e9a850@gmail.com> (Derrick
	Stolee's message of "Fri, 31 Jul 2026 09:26:38 -0400")
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
	<alpXW5U6sndZtgqV@com-79390>
	<c8d443a5-3cfb-4752-8716-cf0d8fadd9d3@gmail.com>
	<xmqqzezlhgyo.fsf@gitster.g> <xmqqh5lho4xc.fsf@gitster.g>
	<fbb118df-7c82-49a5-90bb-4458b7e9a850@gmail.com>
Date: Fri, 31 Jul 2026 08:57:01 -0700
Message-ID: <xmqqpl03cfua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> * Taylor's hunch that the memory allocation is more likely at fault
>   is seeming more and more correct. When we fixed this issue, other
>   issues around memory allocation came to light.
>
> * For that reason, I'll rework this patch to point at the allocation
>   as the likely reason the parsing fails. Avoiding a die() in the
>   tracing code is still critical.
>
> * Thus, I'll also replace the xstrdup() in the trace code to avoid a
>   die() due to allocation problems.
>
> * I will take a deeper look at this wrapper change and how it might
>   be done in a careful way, as Taylor says his patch was an example
>   only and not the "right" way to do it.

Thanks.
