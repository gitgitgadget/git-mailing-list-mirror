Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6811E2F25F5
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155401; cv=none; b=VF3FS9bYxwcMVAGw1Dg9NkOd/PCS5w22B0SQgtj3QctCcfB7Le8afALWMXAmj6CLq5/gJVrJI3Ohr0+sexxIR47U3iOSSvbs3uZhM3eeqllM0aCgMDuX61c5aByZE4oyMAoqy5jihgxjCCcxX0W0j6v19MSF8sB1Pi/rr19BNLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155401; c=relaxed/simple;
	bh=Dx2lLm9q3MqB9Ox+ThLFtauxBtMTtTOe430QqOSvKKg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D7fZa6VJzZ9qYdm1Yfe0JDElp+TT1QVI3VP+VQQ5FGzq2J/+U+xUfpDDG/bZYVP6i7lo9NFonM0UKJaAdRiNvdphuK4KjxVFPuUaQY0UaWjUhsXcgTtnlNS5ezx/xsvqzOn26DtZ8crbpZXEcKtbWNIJVm0ndw0pSQ04KIZG6Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UfMGOcTJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uUhRogXg; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UfMGOcTJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uUhRogXg"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 903FA1D000C5;
	Mon, 29 Sep 2025 10:16:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 29 Sep 2025 10:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759155398;
	 x=1759241798; bh=rPFKDc1pGRrTHQl+1Xacf3deMK/Ll0nlkJK6yiUmTFw=; b=
	UfMGOcTJy9AcJMEy9klQJFMMwvilM/zm2XOBQ0+0i8X6eksYb0ZAsYN2i3wytUkT
	3wdgQdv/gFkoCRfO/yzKlNXCTeMKV3UNqsrBJO659ejUPAZLjNAUeavWVkd7cNaR
	ddtoIJQLv3ia/cmnwVM3W3xStUfNSenwGohnmVhdcgX3ExR/4LsWZvsTp0FKF9ri
	PfLpj2NNhx/vxdzXhJ7S7a82Ru8ze6fzqGqG3fz4YfEmhjEKSBDmLmCDHHquxdTE
	3XNKrZtvDeddPUD97leTVzfZiFMC2VhbQwEj2LWjh54awMmXPMHpiERX5NgFcqfT
	RvQL/uXLTD1cpBbHjJYDVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759155398; x=
	1759241798; bh=rPFKDc1pGRrTHQl+1Xacf3deMK/Ll0nlkJK6yiUmTFw=; b=u
	UhRogXg/CRi4nYIhxszHHYvyQGrHJ63/zeAR1DB8jcD5nQFpO4vT5ZSHu18wyYgE
	y9oDxTodlRwdFYAbq0C+9NsI732is0THcdLwWRjuuO21IXhoSIVlcPK859WMUA8I
	tPcDiMnnf6shqk2qZwHzOcQUt/su7Ovql5kmGfV5nszbPd3ajs0hWidy2xKz9RYJ
	Uzb6dHR5xKaEbRplWROwPWNe6gBQWiDvqQTpXm38vZrDZsyJf6t1Ja37gYdLWcTb
	pMbObsX3Ha5UQsVl6rlg+9evu2gLbde457V/j4T5lEWexu0L4ikCpFrH5iS6fFhZ
	Z1tikjfVG2ddjde9qTqxQ==
X-ME-Sender: <xms:xpTaaE_Wy7cShvnt_N_xTaZBlHyw1m_TbIJc73_lOFELhxUlem8otA>
    <xme:xpTaaEIx-yh8HbcrAgxuJW9zD-ki8WCA7mL49qiEuCUg_ENYAL9I4Ca6oPq-6zp_i
    XOl9WK1TVFLrg4JUhF4hDRFJStp1G7m2oxJIv2P-OAtCICNkv5f>
X-ME-Received: <xmr:xpTaaHZNi_ohekLSAhly8ORAfctG2umKSZUuAbJQFRvavuNApqSwL7HXVME-6J8YayeCgk7LgYE736KUJ_zgLQkehPI2EVq0plCE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejkedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xpTaaOKCenpIW4LRDk1DIUCKNMm_AvH8gJr3djeTTyWutJetD90KvQ>
    <xmx:xpTaaNBBekZfzFI12QHo0ltgXU5s4shaYMPgsTLT2D6Cv0jcozyu2g>
    <xmx:xpTaaLpmgO8D2qXraI2ha1eYl1zfEnjIBo_jhgZheG9hHOLJOIOAzw>
    <xmx:xpTaaAjjQcPwLEstf4mAqrRYb4JTx8qu6Pl1dRiEHG3VgEvgVGJykg>
    <xmx:xpTaaERowpjyyydqGXQqdYp4sht-hpd2wMfJbxOPR17F2IOk36OvIiO8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 10:16:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: I still use git whatchanged
In-Reply-To: <971c5431-f203-41b6-a629-e06480afbf1e@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 29 Sep 2025 10:58:17 +0200")
References: <FAF6A70E-D242-49BB-B303-A7859CAC8E11@gmx.de>
	<971c5431-f203-41b6-a629-e06480afbf1e@app.fastmail.com>
Date: Mon, 29 Sep 2025 07:16:36 -0700
Message-ID: <xmqq8qhx5oor.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Mon, Sep 29, 2025, at 10:42, Henrik Bennin wrote:
>> May I ask not to remove git whatchanged because I still use it regularly?
>
> What the error message you got doesn’t say is that you can use
> git-log(1) instead.  It supports everything that git-whatchanged(1)
> supports.
>
> • Given: `git whatchanged <opts>`
> • Replace with: `git log <opts> --no-merges --raw`
>
> Additionally for the sake of readability, you might have more use for
> `--stat` or `--name-only` rather than `--raw` if you are only reading
> the output.

We probably should merge kh/you-still-use-whatchanged-fix to produce
Git 2.51.1 sooner.

Thanks.

