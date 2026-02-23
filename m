Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D47335BBB
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771874135; cv=none; b=hBQXUkKG2noQX3mAD2zPYiLD04cTaPKnRdsb2YvG2lJnT2nWY3dmXOA44oJghy+vZoXETIM3XpECBXyyvNBRz9Y+y9EFLunAbxNLNyNNKS038LEsvTYdVxX5sASmfQHDut8lczgSrJl4n8U//rMMDRX5RKYOKdQoxU94sEdZLic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771874135; c=relaxed/simple;
	bh=vKtvoO3XsqIZPK9TPAEAwW466frZzuk4NUPgDqZ5ByA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pagMSaGi2fL0VBIouFSDYMvco/LFdNMjRGap7qYOkcDbupiyD8x9yhU84ChkqvN3n7JGtM0GI6CEKyb1kzKKnlu7/gZZCd7VIWqDm/erLd15+2qHdPQvLVmXpFZl0X5k0bzSsKd4nghWr4IkjzKwNZKApbNWEl4IgwS1PKTEyDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dGjRdVWy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XrEFZ35L; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dGjRdVWy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XrEFZ35L"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 112E014001CE;
	Mon, 23 Feb 2026 14:15:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 23 Feb 2026 14:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771874134; x=1771960534; bh=6wnqNDpmY4
	URe6kme84x91GQgVWjt6nn1N9rNfs4uu4=; b=dGjRdVWydIP3CKyD0Hv6TnG+pf
	UzhFRwI+TUnEviBZyhHuS15WW8xL4VfM9FqC3HWIY8ecMUUMFuErhF9fRWATC/F0
	gRLJXJaXjiQFmZmVUlVDfoxcmjOCHB39CgHF9+Uxn/wXYyE64J2mOvOjzh28Fa8m
	3nC4IsdIGYBSj7XiGwCF86iVeaIfyxungpcfHnQYvOzn4Nf5EoAUWshrKoRBbJKc
	NND26vLsUzTgYScfAjO4lLlDp01Yw1h6Ie37372pE6kcPuQq31fxHm5pncQ68Err
	Y+pnQQm//KWAFm0B4oZrSvHnTXA3E6jhKbKS/qIyCNoSDJh/2c0zE3Gm1U7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771874134; x=1771960534; bh=6wnqNDpmY4URe6kme84x91GQgVWjt6nn1N9
	rNfs4uu4=; b=XrEFZ35Lc+1mTfnAxFLxk36/hGjWBAT6yklx4QUPsf6vpGu+6W9
	oj1H9SjrSB0hAX8JQ5BcosvwHN3YvcOlgHvf9CRpDg2ZWT5fXz31ESE7QSduND58
	DEevtZZiQclZbrX31WZQ7Qgz/DML05bOINrny/KErX0HtDnRBm9RM6I6O+wNGfVD
	PfKOOWxk6ghHx4FHRYb9pM1N2/KRjDVIEIlKZG3zOPdkwnFh2AJ0O/UiRXSrprRw
	j41DYaAdi2bJ3hUnChk8NHB2cIeyQxwNNIqRDo0ZnfoLWpA2zOoqDBFvL2LvpYJx
	RsuAXpIOyrge9n28IwdoOW26WEEb3UgY7Yg==
X-ME-Sender: <xms:VaecaQZGc3jpEvhk1p-kVtVTQ7yejMlaNgu7Z5iWJrIpVYS-_DXYYg>
    <xme:VaecaS0sWE3B6HQT3CO96PBuqebO6C53M7h2k08fBUYkgh2Vuf5B7evA3zCis1Bbl
    fBbZbsfJzy_upC5qhimZwAIyUQ-ZD3hCpHy6xjuo1Rb0DuFonIgFg>
X-ME-Received: <xmr:VaecaYVFNRqTY8tCxT_pCgLrzKbfNOgViSgEAYA9t_dukEcUCcfPIbrMxRv-bVe3rdVWuXIyhoZNBxqXNryfzP1gFBPq6KcShg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeektdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesrhhu
    nhigihihuhdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VaecaUWbilq7neflfjnF2EhSOz0IuHs3mXJ0qdajQH2LQd9bQTGPjQ>
    <xmx:VaecafeVgXg9SwE889G3319o7Q_-V3Ste7OeX_8T6WXlTIagoCk1DQ>
    <xmx:VaecaVVFLjhXWQeiu8LQoSGyFjgVhFEKHCkldTvLAKk-q08Sb5Bq-A>
    <xmx:VaecaQftLIwJ5jo4Crh91tP-h4y84jFFm1PCQlA0NOCnmEcAtk3xMA>
    <xmx:VqecaRO1_c9Q1WwJDey8HM1NcxR-UzQMv6op_CPGfXJDCp9qBN6GPTrJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 14:15:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Runxi Yu <me@runxiyu.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH git] t5516: test updateInstead with worktree and unborn
 bare HEAD
In-Reply-To: <20260223141236.22476-1-me@runxiyu.org> (Runxi Yu's message of
	"Mon, 23 Feb 2026 22:12:20 +0800")
References: <20260223141236.22476-1-me@runxiyu.org>
Date: Mon, 23 Feb 2026 11:15:32 -0800
Message-ID: <xmqq1pibnuej.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Runxi Yu <me@runxiyu.org> writes:

> This is a regression test which should presently fail, to demonstrate
> the behavior I encountered that looks like a bug.

Did it ever worked before?  When did it regress?
