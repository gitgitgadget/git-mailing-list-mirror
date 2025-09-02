Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF8F31E0EA
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829429; cv=none; b=OQ1z8WZzYmC/DUAnjMKi04eWNEMXRFnRLAPeDiyNfqKDxAaqAhgHSpIKPF3b+yY2C7G23BmxkwAxji7fKCXNwIlgsCn3tgAetVNvIf3rP+NZyqWaMRWAaNuk9ciecEOPsVwDLWFQen34NdkXr+Vj6H8o8qo8wcygUjP8DMnFaZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829429; c=relaxed/simple;
	bh=TtiXbTFHKUpTk9VQnpaE2GrpoyNcDnqQ5ZKV+5yg8ug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tRleD9v1NPsOLxYxocKCgI1kTmP1QNKALhYt37pJQacajTddS7s4uZsY5UD7U6D5po26IDyJ6uILmTo/i4cL1ATtaXi9kjsESfG60l0A99Iue1dZFcI+4Dt9m+3TJd+hGYcbsOIx/pa9zoXVo2yvC9aAqizR8AEsn+0gikX/LTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=3g1RCWuG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=On4r//j8; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="3g1RCWuG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="On4r//j8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 827EEEC0502;
	Tue,  2 Sep 2025 12:10:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 02 Sep 2025 12:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756829426; x=1756915826; bh=8LD9/vZ63H
	IrSaUWTBHQEEpV+BwQZzm5BWJ0iZjHfK4=; b=3g1RCWuGZ2dJzXLBIlN5VXDjkJ
	NP/5ycwKnT0yyprVrHCffSEBSUwjP0wvgXX1u6Hv0fPG2dlu/dwmmGocAwkW7y/W
	ZLnjMQksqq9zGYauzt6QlmqNrfWd0kUUDr2VJIiRR6atg/SjJZTCoiCtjWB7oeaA
	dllu+h8RyoG9E2zqjBUI1mpWV59J9HfMpEryaR7XRaxGlmM/AjSNrxBATcKPwzzO
	k5gMyTr39A6M0ZU2pk5ktgO8dj2nBs2TuyK9q7GMEdBQ3ojmX9FVs08BHAjaWlul
	JSXsunlDsaJqluT7U4PQMOk4sssE+5PmzPs7k80l3HU3YPZaLzMahpsGaFTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756829426; x=1756915826; bh=8LD9/vZ63HIrSaUWTBHQEEpV+BwQZzm5BWJ
	0iZjHfK4=; b=On4r//j8BzjfDP7EvJ0OFYEu2ANVwudN1Y5TnAIFVV1Wy+JWnzp
	xMvEaUyaFloca4Fm3LuFOVRxN3hG8gHLzRLm8nMilY92vdwr40PXLIKXua9ERb/4
	cnb/wNFqk+xkpXsoPm1m4+nHlD4nDz6hJbQF0cHR/h6zEf1R0azLmyfDcdOq24EP
	cre1CUZ2/QeQFbNW/p8AijiGPdv1ZfDrH1P+a8/cbF0W5YaptfoPXGE3CbBoDgL9
	Wvt51ukFBPdL0jATChnIrJCFvN++cV1oUGUNktdzMaJP5K2WCO4JCP7khGRE1LsC
	Hb2uG3nXi3lwTW2aWO4D/2IMrm3sO1PCr/Q==
X-ME-Sender: <xms:8ha3aGdzQjgDIsqZDNuOiWr3Kks1aebFtXKuve4mndK_H2lqZF2Zkw>
    <xme:8ha3aBvXjuJ2Q4gzphv29PuYn9pr9uvvQbOCC8HQIg08yLmFStHhGA-rUusX2VJaS
    iqgdlVdlQ4WWzi8QA>
X-ME-Received: <xmr:8ha3aHmVDbhDHJzWZXnqr3kJxawJj7X-2YKSYsNqk_AoEUCxzKnmIJM8gqEHPpFRb4EMzV8xSYXNA3Xwaqcb7t_z_AB7GOPiu339YwI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8ha3aDy0m0_F_SHBeXhtVPTpMGfBREGiQAfPJ4q79FBjYrxeYx_Img>
    <xmx:8ha3aJPtwk62oAoB-zJGS-_YIypscx2XR9tQ5v1q9zskOww7A9MACQ>
    <xmx:8ha3aPp6Zh-oZithxroq9opISppVDKYpM2rpaiD5hXRkGFEUjoj_5Q>
    <xmx:8ha3aCFTWuQ0Va052broqcovuoelZmIzdKRMarcL2go4ytktfqfLiQ>
    <xmx:8ha3aLdR1e9SACNJEf90LbUzLjnGoJngoFn2HZ7kN71swIqzTBBcSMcG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 12:10:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben
 Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 3/5] doc: git-checkout: don't use "reset"
In-Reply-To: <9d708558-df36-4bdd-a914-522228b27215@app.fastmail.com> (Julia
	Evans's message of "Mon, 01 Sep 2025 10:28:44 -0400")
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
	<pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
	<360051d2a656727ca42d489de81ffec9b23a6386.1756467934.git.gitgitgadget@gmail.com>
	<xmqqh5xqnlmo.fsf@gitster.g>
	<9d708558-df36-4bdd-a914-522228b27215@app.fastmail.com>
Date: Tue, 02 Sep 2025 09:10:24 -0700
Message-ID: <xmqqv7m0ltsf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> I'm surprised to hear you say that "reset" is one of the most often
> used Git commands -- what I frequently hear from Git users is that they
> use `git reset` only in "emergencies" where something has gone wrong
> and that they're afraid of using it.

For the list of commands that have been historically considered
"common":

    $ git -h

is meant to serve a good guide.  We may want to cull/update some
entries (like, "backfill" which should not be more prominent than
"maintenance", for example), but I think it is not far off or way
too stale (for one thing, it no longer lists checkout but gives two
separate commands, restore and switch, which are no longer marked as
experimental).

>>>  `git checkout --detach [<branch>]`::
>>>  `git checkout [--detach] <commit>`::
>>
>> This is in response to "transactional equivalent".  I've always felt
>> that there is no need to say "transactional" in this at all.  IOW, I
>> wouldn't have minded if we rewrote this more heavily.
>
> "Transactional equivalent" was bothering me too and I like the
> idea of rewriting it, will give it a shot.

Thanks.
