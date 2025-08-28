Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD7ADF72
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 22:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756420487; cv=none; b=nYQnaakP4GS/SWmGU4I70mjnzWvbPlmPtIx4f0zSRVPB5YpuFhYvC+Rj1sICGwxZfiBzqx6jBuSjEvrx+114gh0vNK/nhtUwOm0Ybl/48an8SgAEygT0m+5gZuAQT5vwU1OHagMQJLV4Gc71YvF3Q334/EER8KNuwMc/huHFTWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756420487; c=relaxed/simple;
	bh=eJH8MHADF+R5TyoeRK9DDIhih0JdsT3FQ0YmtfCudlQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IE2X/WI17kecYRWxgje1TUEBN1uiB6GG8sn+xhKV0fiL1uh3Q68NjsBoNkON3oPObHgFe/1sVgvy+sJFM6k1dmU7V5MS19R/BtWQ9cWrjdQQ8j4Gbj/0QBNsonq8pOABAdp4bcvXd+qvNQZNSbLokSJqh8NWVH90oQllx1+HPM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=NrWX90qp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L85TAlqd; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="NrWX90qp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L85TAlqd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2CE7F7A0166;
	Thu, 28 Aug 2025 18:34:44 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Thu, 28 Aug 2025 18:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756420484;
	 x=1756506884; bh=RHH26pTIsIq+o13N47Jteag8Xq88eoL+DzPJyVgD4Fo=; b=
	NrWX90qpLxQBevb9zVkOkshIiIEpIe2TRfPSxu81UW3GE2BcrFSRQQNGF41HWL+i
	PTvxttp3SewWF3XE06gYZXLbT3YohRrGWbuXgjDkLLCOPGhoSW1hLFFqEx9o1Is6
	l57STOFsqaZvht3KH09hUIsqaOAvdhc6KaCPsZG+7rKWp24C1jsSpyU2JXJ8uG+M
	g5WNub8WXCeJlNi2/1aA6Ht0g/yv6LBA2IGALmh4XtH93fWuzK0hEFGuZE7YkwN9
	1NzklGesVhBBDl9h2kQ4ai1ZmYHMjRj3jepmiCOh+il98nc7bLFa22lITXkhKT/2
	WCLfQrE4jEfaU2lDbThdGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756420484; x=
	1756506884; bh=RHH26pTIsIq+o13N47Jteag8Xq88eoL+DzPJyVgD4Fo=; b=L
	85TAlqdtJK17ySDcGbR8seXUUiyGtc5N3tOz1Np2frU/UaY+PRTK+AmO4xrqaNaM
	i5GjEHdkWO4dXE+W7QvSTQakKrotbTsZdUzxRsyqZunjAh6BlYwicSxAEKNH7lna
	FtBKtqITRDqhyNwKpuyZ6Jvj18n9sIvAeVyXJUsbIzhj+rvyx2dshfJ2AIzM+vzY
	truPparie8FNJF4p/iwt+oTBu/a3Kj+LxE6iW7WHg/oeKXGu4joC0vGP2CAE8gWd
	UvZjpMMosiUVjIgYTSHb0ZQ/1Q9IRgLjDnHoVaRlLG0CDaHrTemUO5gNjC/ooz0U
	1duD1TgST7FoHKm787Qbg==
X-ME-Sender: <xms:g9mwaDsD_phGYpt_xWVDrqx9I3qpcvDDrv9yj81urLJ0GbNGuI_Olg>
    <xme:g9mwaEd-aMc9iLv4OPSiZYPypkHzRsOx0FREgoAjBlS2vTiYDeLEUgkFfUI-2k-8T
    N5tV9hklVagau1rIgE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:g9mwaGVZjVfaPtFJOPsRgeUnx9alwTum2alJcVsFmiCgQrxUIygOmg>
    <xmx:g9mwaJdJ_a7kjb_GuO3BV1A7-ty-KWrWbm83ItC1-YGIUHGlfQ5fVg>
    <xmx:g9mwaHWAu-XpLm9rPWvcGdowCxjwEOtuplQlmomd06rDu-GEYLBXnw>
    <xmx:g9mwaKfZ7ZULiLK_cingEv28VCrMbUcyANjuyeTSecOW4iIt76kqPA>
    <xmx:hNmwaGSaj0V1kbhMG1R60QaI4xX_NI-VirkjPx0aTHA0tOek1moelIJJ>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BD3A87840CC; Thu, 28 Aug 2025 18:34:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aye-6GR96UBw
Date: Thu, 28 Aug 2025 18:34:23 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <f440d0e4-0754-49a0-9677-980f60a5dbf5@app.fastmail.com>
In-Reply-To: 
 <CALnO6CCvD-uoan=-VW+OmfCk5cLgNm=zENAejL9vX2czahMGxg@mail.gmail.com>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
 <a6125a0128937392af283033e63d2b04776caf2c.1756148933.git.gitgitgadget@gmail.com>
 <CALnO6CCvD-uoan=-VW+OmfCk5cLgNm=zENAejL9vX2czahMGxg@mail.gmail.com>
Subject: Re: [PATCH 1/5] doc: git-checkout: clarify intro
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> I think we've dropped the bit about the default interpretation of "git
> checkout <something>". Maybe
>
>     When you run `git checkout <something>`, Git tries to guess whether
>     `<something>` is intended to be a branch, a commit, or a set of file(s),
>     and then switches branches, switches commits, or restores the files.
>
>     By default, Git interprets `<something>` as a _<tree-ish>_.
>     [explain what choosing a tree-ish means for the user?]
>
>     [Your notes on disambiguation as before]

Thanks, will fix. Though I don't think it's accurate that
Git will treat <something> as a <tree-ish> in this context, since
`git checkout <tree>` is not valid. Will find a different wording.
(I get "fatal: Cannot switch branch to a non-commit")
