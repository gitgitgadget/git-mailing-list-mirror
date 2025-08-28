Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31CD320CD3
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397912; cv=none; b=UMRSh4H/osxXu6DbYiH4HmhK5FmI0fez4Bv1DxbVdmw0uPROAFnpNbO/zIxzuU5O1h+In9wnhxPkbyaiWXv08wn1WTRrVuFjOKTLoiNByouQLccJQaBGrb4NONv1vVM2uj2RTnKBq9r+Ve8NEoa1BzbychPmQbEIyUwXvlF0AUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397912; c=relaxed/simple;
	bh=4zDGFKEcqtvAnBbrKMyQqFudyU+n3VFT1tg+CrNX8ks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lSDb4egCNiMXAp+ZKna7z8PE80FzsCF9Gy0Si6YN/dhyCSnbeXWieXAiLU4/WtVcAmi4k5ieQ2BFkGd1dyF0Hrv8Phnm6ttkR9cyr296vuW/3hPkxFymQGvA3Xe/AWO2aEh/bPW5cRkTSjhGeB2FiFs7BTwRUiOgFAP7BpzPncQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I9ISjASf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q9Rt3itN; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I9ISjASf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q9Rt3itN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B76DD1D000F8;
	Thu, 28 Aug 2025 12:18:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 28 Aug 2025 12:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756397909;
	 x=1756484309; bh=yxzjZkpoT8wTN5h05kRilM13tgtVAGdoccsgphsdXoY=; b=
	I9ISjASfQ/GtHeU9ZKJ8u2KjDjr1Gy1wLeFCNhcyId8DytbR2wPWcLxuroXjRmdm
	0thK2LmRWse2Q5ZGJR+r8wOt5EveL0nTTJ1kBiMuu/N8Xo7d5zkxQTQPHRyIz6cx
	G4Dhe/SDDzK9jxrL9ZkG9LjSgFJ16aupjSqOnvwdFfPmt+cRAgu0pgXF+prVN5LS
	AxGLRPqepUMCKygggnMcqDdc2SlRW6gscZpf2glDhN2aLqBNpr7nGdgnuo/1X/RT
	PhIfCEX/f0T5KfWFo6KyWzw6yUuTyzdJQn5cCCQPKWXqVxuudwBthFnTyp44EPCa
	nBWgWFJc0aQomgdZ9lG8Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756397909; x=
	1756484309; bh=yxzjZkpoT8wTN5h05kRilM13tgtVAGdoccsgphsdXoY=; b=Q
	9Rt3itNSyyrrv7YjQ3bQ6l86Kv4B++O2SLr7M7FnulK52oAIqr9+1UrdCFVp0hIQ
	ho4hfCvYOpA+lkSx4UjqnQ4GZGlhzMYT3enkAg608t1dJrUKXlCyktgfkr+1RDl6
	gO2GE5DsZOL+F344KbNJVYd0FNYeaVxFsfPOnHrgjpvyvO2LdAZEztRGKYiXqKJf
	NwlCsWocuw4z6k5DjhMwRmQn5Kzf9Nu5dbA1ecq/SFevfMVxc6sklpANSqk9smHW
	AU/Ej9mR4ASfO8zv2GbYy3GK7tiwGVKqbjJ30B5Bujq4b9cqwHk0lo5nuuExCRQr
	LKhMJPtLZH2AmFwCJ+Aqw==
X-ME-Sender: <xms:VYGwaClS1Bl6HYCJg5oXf59oqcOoll-Yo2GwgDcjfY9THmRMNDbdAw>
    <xme:VYGwaFVkFrCnxIpxRA_ni80ZTMxz98MocXkfAzfp7uYQ22o17s16Q9U3sKRBG0jS7
    6c8_S07KbcH8_QURw>
X-ME-Received: <xmr:VYGwaHFAqtGtR7pvQS1n4nWijMb7WK0yeplg3NfkUlvdu0KnDscamVKwvmwzBiyeyJD1JFtW2Yn-bdryDz62ELqBPvMxiAkLTS98-_8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedugeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedvhfegieehtddtfeehjeeigeffieetueegleejueekueehudduieeflefh
    hedtteenucffohhmrghinhepghhithdqshgtmhdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VYGwaBezpNbZOqjLjVoK7-Fz6_VsInPQv-uRJ_LoRGP5OOjavgiEyQ>
    <xmx:VYGwaIJEN2w-hXbRreJc5Ahl9r7VzAEhRz7igqdvbAw0FzpDjg0i5A>
    <xmx:VYGwaGE_JvXJgmKunfHPx_Jyh5uJ25SeK6aspwFMekeXNYgEJhxSSw>
    <xmx:VYGwaLBjF0HanyN8BQ8eFkgMjYio9gyjCBW0qSWAAyxPxAaDcprlpQ>
    <xmx:VYGwaE0XMlBjcdpPJLU-NTcs3_1OG5LthzMLdkQFdPjouWkkXK1oxmn->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 12:18:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 1/4] doc: git-push: update intro
In-Reply-To: <CALnO6CCca2Yp7K16ShqUaZNN_POv106qyXfKq1aJMyXhA+EyCw@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 28 Aug 2025 09:53:06 -0400")
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
	<2fa98fb5cae78b8872d0b864ee246ba619ef631b.1756240823.git.gitgitgadget@gmail.com>
	<CALnO6CCca2Yp7K16ShqUaZNN_POv106qyXfKq1aJMyXhA+EyCw@mail.gmail.com>
Date: Thu, 28 Aug 2025 09:18:28 -0700
Message-ID: <xmqqtt1rwhbf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> +Updates one or more branches, tags, or other references in a remote
>> +repository from your local repository.
>
> Considering the glossary entry[1] is for "ref", not "reference", what about
>
> (a) linking to the glossary (is this possible?), and/or
> (b) saying something like
>
>     Updates one or more branches, tags, or other references (called "refs")…
>
> ?
>
> [1]: "git help glossary", or
> https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-ref

Both sound good ideas.  We should make sure that readers are aware
of the glossary by linking into it from more places. 

