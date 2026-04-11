Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351233A6B77
	for <git@vger.kernel.org>; Sat, 11 Apr 2026 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775940479; cv=none; b=cczO0wbBhs3DoSDagmyvRNljzYW0cxz58fYWztcSKTRtmWeS0OlNDhcAMxBa4wldm0DT4QG1ljAg5hA9809gxd1xaMcS4/25Ahf8Q0FsKTCJuUDfxU4rs0lhFGshsVc4/H+HXohlW968DafLDT9xLROtA3bpFZ8vMyqf/TummSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775940479; c=relaxed/simple;
	bh=YirgbTfSVCn7DOmyzjYZDGZNGDUCFiMoCsjqOtdL7oI=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ESnFOMMvT2a+9KGuKQQmeuv4gdHq26n1T+0uZanQXEI6c74W3xGL5WgDBGPADZKEG9R3DAn7QOkpM0XRfBPL9cK49KcMStqt9UrSTV4xNt3wLgv8pbEZbf2gThoib1F2ES394LtuSMdUI7ze23z7UBHpLxWQ+DkZ0D8eAVP5H/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WG+cDhjX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bmnJBD8w; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WG+cDhjX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bmnJBD8w"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4946FEC0094;
	Sat, 11 Apr 2026 16:47:56 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sat, 11 Apr 2026 16:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775940476;
	 x=1776026876; bh=cMgzzMF458oWlDlI7Wtar31wfS2ToQi5emJekVG/ZMM=; b=
	WG+cDhjXIszQO6NoNECPl1LspU9PI70Et60TisA+js0+CTUfVjN39+JCo7oeh2Tn
	z8O1puW7tgQiOyZjeEubjro6qdRMdVaJzGLDUAeicS7xkAzrifUXnxSf/QQiuFBC
	rdKboBYeyaQD4Uf59HLj8H+wB/XEKovPvIf6lIlJDL3A5Lbx6J7p2/km9CtkHUj6
	FCG1AH7RRVJmlzH2UqbZAfPnnmDgdq6U5SF1T0mrdEYor/7BK5BP0/25dKXCWrQM
	JyeQ9+UnzXMhLZRXeH/0ZcLtBvaTRMoTHE5UU26XoGLeuSzJTEeAqJqKbbFOPgEH
	gC1JXehHBEWULLVqqWwlLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775940476; x=1776026876; bh=c
	MgzzMF458oWlDlI7Wtar31wfS2ToQi5emJekVG/ZMM=; b=bmnJBD8wOg0toASxL
	ZEvII0Q8xmNPvo868eL8081u2YdKdeopbTbi1twRt/HW1M2wLnfQlA2czEWxqstA
	lqwWvuMEyVaHoPMnkRlOs0zyo5pntKfXusis3gcA0sBW5AMHd8hTJnLBL7FdazJs
	dOrHdaQYoCSA2Kk/EnAyROAy6YI/PnQzJzUYmMmMODRVGPq1RQsSc9iXpDXvWhcN
	ZLRXjxUO5pN9DqzkraZhRpEQAqDugnoQ3BfcOJHJwsTYSyboFtA1W4L8f5W5K11N
	Kp2LKYi2Qr8UBDJ8jTyasP1+lD56v5h/J05PMDBbzmJCn313bcE88fLzavPWKJ5i
	bC0iQ==
X-ME-Sender: <xms:e7PaaeDUvcUQChxpr3I4RssB26e0BuT8_w_i1uHg132f8KKk7MDTZf4>
    <xme:e7PaaTW3Ixmsz7uj-oQ6hg1mAkx4rEtu57VWj1eA-cz2zYp3VRsnl-yq6kQUTjTbM
    J45UIiX_xTqsR8tbW39LSIVHChIyQe-cAD7d6hNDjQ4XotIRfxBBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeffeefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthejredtre
    dttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpedvieegtdfgteeghfffteetleduveehteefkeffheehfeeihedukeev
    leevfffhjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:fLPaaQs0pyHgAHORmebeHa5I6dF6rLcyK5-w4yNXnYqBjj_4fA9ilw>
    <xmx:fLPaabZT8Tgz3QGW1WEh3PZfuviND0kPrplzZgu7uW7uTENnIT_hYg>
    <xmx:fLPaaTWmhPl-10DMPwIlqqNEnAOq25_zWNuG0iLVknXmQZvr2ed6Hw>
    <xmx:fLPaaf5NQjdpCTY1gczejxxdHmIzSaJDG8hlh2-k_b7i8rnw_4gRZg>
    <xmx:fLPaaby062mjUc5fcEE-IFn8MVKg0u0Jt_-066iWSKz3LASIHIcSwWs6>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D1A1E1EA006B; Sat, 11 Apr 2026 16:47:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A__05JlRJZT-
Date: Sat, 11 Apr 2026 22:47:34 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>, git@vger.kernel.org
Message-Id: <236b32a3-a04b-4d20-8290-02a464037b1d@app.fastmail.com>
In-Reply-To: <fb4dff1b-d304-4f29-a96c-373b1a73989b@app.fastmail.com>
References: <20260411190625.GA754966@coredump.intra.peff.net>
 <fb4dff1b-d304-4f29-a96c-373b1a73989b@app.fastmail.com>
Subject: Re: [PATCH] gitglossary: fix indentation of sub-lists
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Apr 11, 2026, at 22:34, Kristoffer Haugsbakk wrote:
> On Sat, Apr 11, 2026, at 21:06, Jeff King wrote:
>>[snip]
>
> `Documentation/doc-diff` confirms that this is the effect of this change.
>
>>
>> The same problem appears in several other spots in the glossary.
>
> And that it is the effect for all the other spots at as well: pull a
> paragraph out of a bullet list back to the previous block (or level).
>

But with `make html` there are some `+` artifacts:

    + Glob magic is incompatible with literal magic.
    [...]
    + Note that when matching against a tree object, attributes are [...]

This is very off the cuff since I have to go now. So I might be missing
something/made a mistake.

I think the first thing is caused by the context already being in an
open block?

>[snip]
