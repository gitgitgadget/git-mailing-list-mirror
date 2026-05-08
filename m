Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A85C3E557E
	for <git@vger.kernel.org>; Fri,  8 May 2026 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246751; cv=none; b=JcBHIa5LqmgJE/JpV0jdITPSgLCM2T3960LzZC0PXL0CzyhCV8WVUoQ0zpp5+CV/AROljMVOLfeJuLCF3oTMJhV4CEI6RWhyfA8vG436NGjATWtHvFwe/hv+r6k5Ws4G19eyfzDfbFhjhcjIY4Q57/Fr1fzHawdSk+IDMFxTjR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246751; c=relaxed/simple;
	bh=LD1XMrBwb8QP0iu4XHqssr1phuDTd585iB1LpFmkwN4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=naE93r1CnKa4tjIfK+rXTQUZntXkCHKB9vi294hl+x0eS+BrF7QeZ00DuoT8l1ImHNZpXtf0uphZWqc35AoFqJYvgY8ynW7932zAT293ujr3hAEtM287Uj1crNua3b404aR5U3UhbzahqFI1BWSPMD1lZGHI1RlKKmE1xT0KIr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PrGFYpwu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dxdig/8F; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PrGFYpwu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dxdig/8F"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 86D66EC005A;
	Fri,  8 May 2026 09:25:47 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-06.internal (MEProxy); Fri, 08 May 2026 09:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778246747;
	 x=1778333147; bh=LD1XMrBwb8QP0iu4XHqssr1phuDTd585iB1LpFmkwN4=; b=
	PrGFYpwuwyXcIYJkzhbhxJUMOfjzXgvt66swoVSip0fM0mSxyT0D1U/kKztDZ/UD
	7HnqRU9aV7+0EXECg8txfGb/uD50bQJ8uB71F1uLZF0/nbbzi1qExfTCGp6A8eUn
	yrJceI+ZjKLFQ61uqjWdKQ/Neiaeb4yQ4o0YwK6Qww+4guKP3dhT9Me8iUYz6pyr
	IpF46FW7TbFyP9B/9CGX+1AI+2CB82U041xdqJtdYt0887lXB+xmimMwQay7df4q
	Wi7W0d67Q/SoWW4W0iD/UcnoT8j6bBKm1eNCmFYHSxL0jKTP6AKZ3QOAZUHqUZ0n
	8CDDsFdzn64KzCdhvLofXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778246747; x=
	1778333147; bh=LD1XMrBwb8QP0iu4XHqssr1phuDTd585iB1LpFmkwN4=; b=D
	xdig/8FsePx+HzcJLArab17/lO8VfZ26dT2uysPyFxQfA914aHeBJPqA8xvUudUL
	zyKsTFQmt3o6pSec9y9wxVWvzYGi551I+HF3R8UZVIvRn7brHnSd5YvnKxtWfYwr
	oEInBZwjdJKuhrrRo39salHOEPgwaD35PPdkD8X55QQxfmePyavfRaxfkC19xXMc
	uOD2FMlQ/4VUQ/prZ2ibhoQFMxzYIG2LR8Lv3WihGGwRroZdhD69Wq25FshNEbHP
	9HjIYti9DnZppJdWFpGw12VqGa3j1rARsY6ek3sIUKgLaurIvCK494+xFhRqEzi1
	oTVFyHp2iRbbsQm4UYyCA==
X-ME-Sender: <xms:WuT9aW_HtUAV7q8X8qgZS3SThtyjgF43zXYZcreY_F8lXeroExxdH8w>
    <xme:WuT9aRh4dtaMNbe9uTTne2rd4xepBFR3ONMQTfga2d8SVT6OOjHH9J_CW14kkGtvU
    HZeHxfcy9HYcBBK1bRhY54tLzpxu9VS46FHKNXm_xkfXQMihRfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddtgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    rhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WuT9aZQGBEXwTd3-frYxZC8CtiVVzAVCIj_lOeVAa9JJtEDnfLenFw>
    <xmx:WuT9aWcGgWAOTYXlPgCyllbW1rq1YbJ-skJ8zaFUZimkTegwrx13BA>
    <xmx:WuT9aYqeZ4SazzmqlDsB0kyiiO3kzwhRDORmvBqcXCTY0srYPXJn7w>
    <xmx:WuT9aX_ssy9YdsewPYoPH7jHzeBgVFnJymvbOjKA5ccrRdCgC3DORQ>
    <xmx:W-T9afxS-PohEWLy1PsfPMxiycXblqzV7VCuAqfRX1VtrF_6L4rbAnt_>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B8972C40075; Fri,  8 May 2026 09:25:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aq0cXLUbXG1o
Date: Fri, 08 May 2026 15:25:26 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Ramsay Jones" <ramsay@ramsayjones.plus.com>,
 "Junio C Hamano" <gitster@pobox.com>
Message-Id: <c04d9cf9-e6a9-4e12-8025-9baededfdafc@app.fastmail.com>
In-Reply-To: <V4_format-rev_new_builtin.6af@msgid.xyz>
References: <V3_CV_format-rev.66a@msgid.xyz> <V4_CV_format-rev.6aa@msgid.xyz>
 <V4_format-rev_new_builtin.6af@msgid.xyz>
Subject: Re: [PATCH v4 5/5] format-rev: introduce builtin for on-demand pretty
 formatting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026, at 21:34, me myself wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>[snip]
> +[[io]]
> +INPUT AND OUTPUT FORMAT
> +-----------------------
> +
> +The command uses newlines for both input and output termination by
> +default. See the `-z`, `--null-output`, and `--null-input` options for
> +using _NUL_ character as the terminator.
> +
> +The mode `--stdin-mode=3Drevs` outputs one formatted commit followed =
by
> +the terminator. This could either be called a _line_ or a _record_ in
> +case "line" is too suggestive of newline termination.
> +
> +Note that this means that the terminator character (newline or _NUL_)
> +acts as a _terminator_, not a _separator_. In other words, the final
> +line or record is also terminated by the terminator character.
> +
> +The mode `--stdin-mode=3Dtext` replaces each object name with the
> +formatted commit, i.e. the format `%s` would transform the object name
> +`abcdef012...` to `<subject>` without any termination. Like this:
> +
> +----
> +Did we not fix this in "<subject>"?
> +----
> +
> +Regarding input in this mode: using `-z` or `--null-input` makes sure
> +that _NUL_ characters in the input are passed through correctly.

This was the paragraph that I was unhappy with (see cover letter).

We=E2=80=99re supposed to be dealing with text here. So on second though=
t I
don=E2=80=99t think we need to fuzz about passing through NUL characters.

Instead I could mention that `-z` for this mode allows you to further
transform running text from other commands that use NUL
termination. Like `git last-modified -z` (see the Examples section).

> +
> +It is safe to interactively read and write from this command since ea=
ch
> +record is immediately flushed.
> +
> +[[examples]]
> +EXAMPLES
> +--------
> +
> +The command linkgit:git-last-modified[1] shows the commit that each f=
ile
> +was last modified in.
>[snip]
