Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812961DE4CD
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 02:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767495292; cv=none; b=S+Q9bmIzzQ9sooVYX28sF0LxXVzbTiOZtvmhWHBNexeSw1aOvf5gvZvVDtdDWe8G8Hz1MoW9dv5Qk6OlYTgx9wNY+d9hG3KY2FzyNTbuTTLfK4eds/43boen25MsDZy7oUA/5KzaKNZwpbX4RM54U8tbB1bBW9RUs+cZBM894NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767495292; c=relaxed/simple;
	bh=ZMVxekd9pUugdlzab+jhdvQVxIjzpwodgfi/jPHzPUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oBKZQCeQhgrXB/lUPvuLafNPgSRc4JE1YmLgookANGq7zxIqT6u1Wdcx+n3SqFabZx3ls65v6KVPjU+v/vRZdyMBhl3cM2kD8pGV8j8LnRoTVQkgE7EkFHqDPGv9EChK9FGuY08UD9b6kHTAPFthpCLZBrBu2eLquFxNcIxlPYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VOcPpACw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nmfu/Xzz; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VOcPpACw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nmfu/Xzz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id AADDE1D00012;
	Sat,  3 Jan 2026 21:54:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sat, 03 Jan 2026 21:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767495287; x=1767581687; bh=QgYda2POM8
	a1+sfv4fTSCWqj51H/vf31e9xB0Stfbeo=; b=VOcPpACwSa5AgPAHZPfD5AxLg5
	sS1Go7MSBn2NWe6tzwmNin3npgtAKw10tzyj4ckNLWQ40aArnCCqAWOCdLB3VZYf
	lkWIsPgFgZ6mrYmfAn7xg07JbuQ2W1Ps7xiQ4QaxhCYeOR/xJ4H6qWxXIDL46Kxv
	55yGYqAzq22r/stM8NEQWU0hn4jstSxAY9Bhp9Pi6EYOSZ41xPn1PKZmPMnjrX2v
	bp5L1aQ/DPSbt+b4gcwN+DnYdyT8CrUBrrfbmOXm5Jl+jU4JTmgkBRd4bV4C1Aa8
	p4DXezQoqDoQcChj43kbhDF5t6VmHy1s6yNCSHCu/ii6VzUYQM+ediivwVUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767495287; x=1767581687; bh=QgYda2POM8a1+sfv4fTSCWqj51H/vf31e9x
	B0Stfbeo=; b=Nmfu/XzzsreYpCsMOM12IstbJn+f79NalbpyQZoUS8y6D7Fkxhy
	duPpmlxAdMcrfSuFSGMgTheVo4JyNFoAnFj8kpiE+WYLh2LW9YMlaAxy8rGYb73A
	4ZbdcAP7SabploB6ckP0arn4OWSz3++OTsAnPsCBfhBiuKFfUAgPZ4QhZVL+wNBW
	nQug5WxoMaZ7iaRHUER4KWCgSSS5+klweq15SJNxv6buJj7v7+c3BjaueXNCnvP7
	QoEXlUW1LGMMBF/1nvSShBQqkl6Ez7uEth6s3cHrmcbRrmEwEv6sjFnzSHdzJVAO
	j8K1LhrB3KYJbP3bxz3fA3e6GV3qAl2xhlg==
X-ME-Sender: <xms:d9ZZabBvVLx4dNlf61Iud-rIaF_RTtbzbhYKCKFOeyWu01ftxgIiUg>
    <xme:d9ZZaVPv_Jl33zUOBoIaoFv1kExdoCfGsTu46yG0-4bHrWJfhMvLqus3Q-N2wtaqQ
    fiFV_qowFdEV-fj4j7xsQkZL047ZseqtGVW_FD2NVh6xWOpxGnI>
X-ME-Received: <xmr:d9ZZaQbT_bJdEXGwhH2wZnBdPZ-CAviP6W_7bPYDJsLSm5-OtN7Vv51HvLfTBFn2-CwoDBN-YbUxcW3HMRFmwc-Z_Jjz7zK1tPhvoqM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelfedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhgrthhhvghushdrthgrvhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnh
    hnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmhgrthhthhhi
    vghurdgsvggruhgthhgrmhhprdgsohhulhgrhiesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:d9ZZaUutH-MM7MOpAZCxze5DWuXz0NH7XJiDnSgcm6dl5c8d3kOz-A>
    <xmx:d9ZZaSP6x1vSqo80NBRAPjO5p5HtWhOEUYsAYaZZZzUrae2wRlsmdA>
    <xmx:d9ZZab4RVUDR0L14HgkJAMQaujhIf2LEYT1q7JrDZHZoHCFIDlXSXg>
    <xmx:d9ZZaYS4Wf-pTeF9ByqEbdfbd4t-2VSU91tiHusz2Q7yp37GGHNQXA>
    <xmx:d9ZZaZe1zZjRZeRhguInkOURNfYzWRYpbQFvKeLewGDT0C3wSMNSNDTA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jan 2026 21:54:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Matthieu Beauchamp-Boulay via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Matheus Tavares <matheus.tavb@gmail.com>,
  Johannes Schindelin <johannes.schindelin@gmx.de>,  Matthieu
 Beauchamp-Boulay <matthieu.beauchamp.boulay@gmail.com>
Subject: Re: [PATCH] ignores: handle non UTF-8 exclude files
In-Reply-To: <pull.2157.git.git.1767478617198.gitgitgadget@gmail.com>
	(Matthieu Beauchamp-Boulay via GitGitGadget's message of "Sat, 03 Jan
	2026 22:16:57 +0000")
References: <pull.2157.git.git.1767478617198.gitgitgadget@gmail.com>
Date: Sun, 04 Jan 2026 11:54:46 +0900
Message-ID: <xmqqsecmnl3d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matthieu Beauchamp-Boulay via GitGitGadget"
<gitgitgadget@gmail.com> writes:

> From: Matthieu Beauchamp-Boulay <matthieu.beauchamp.boulay@gmail.com>
>
> When reading exclude files, git assumes it is encoded in UTF-8 and will
> fail to apply patterns if it isn't.

Is it true?  I thought we assume that the exclude patters are
written in such a way to match the encoding of the pathnames,
whatever used on the platform that our calls to readdir(3) returns.
Some platforms may have compat/ code to convert these paths and
force use of UTF-8, but please do not write such platform local
conventions as if it were universal characteristics of our system.

"ignores" -> "exclude" on the title, as that is the canonical word
we use in the codebase to refer to the ignore mechanism.

