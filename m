Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2ED26CE08
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750778741; cv=none; b=t0sWWHRA8LNZ9uRchAACmQ+tnieaBHrD+OcwFegrrnTh6krBYBpYvF/jk6YDNcPm6qTgfWVpFpvBDuPx8aEAPt0FJ5QFmuAdRJeR7LXyv45ANOvQNYJKJEA6+rHOgC0YHQtN33slNnYjS/ywhi+kYcxSPlTURl/APOTu+R8SRX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750778741; c=relaxed/simple;
	bh=W3tFKMhRlRVWLs2c4INz2yJJmNlYhGBVSeT0cOJfQGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JMdHiLnNcVQhy0lr2xIwNcyYIpF63D3HRBkNCSaJTf61ceVTwqrEgVaiNLRN5hyGSTQIg74u0uW0dNwvIy762l2P9xyBl7DC4BW92L9BfFhLFI7ZOQtGxksi2Pw2lFjWrASq3AMsS7vpdf1QsUxAzV6WuoN5+wVUsah4DK9RDeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Os+/Y5zv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UIDsjjsK; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Os+/Y5zv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UIDsjjsK"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3B5EF1D001AF;
	Tue, 24 Jun 2025 11:25:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 24 Jun 2025 11:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750778738; x=1750865138; bh=tmXJ8uo5MB
	yhE04rAB/WFOEyhU7+XQhkGjZt3majUBM=; b=Os+/Y5zv51UiAwMdKvSpk9/YYj
	uG0E27Clu5Sn1dJy6NfbOt4UtI9mQWYaFm/i3KyWG6MFdFvP7pQgXVrTO6M0eDxy
	oQ2SYVNCokjHcFGBSfWYbF3oUeBZNOkMVXNpu/shLUkfoOyl4zBoXNjP7h+rxZLB
	fGFDlksaGamBg2fUl5R39NQdCgJAOEhUG3ePpRCwCfHkwrH4f/6d4swMoaAl35+o
	3GMUPTZyCSGXe0P+UFMwnpOt2NTv/bKo9S5IZsKwHpU68AyA6jmecqDAsRwwNs74
	0wCGLnToz0F+N1wWeZtA/U/3csnVoJSAuOFTCHaQaJ4X1hD7oe49dJJnVerQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750778738; x=1750865138; bh=tmXJ8uo5MByhE04rAB/WFOEyhU7+XQhkGjZ
	t3majUBM=; b=UIDsjjsK007lOnMhfpQ6bYRcVD1uHPfMQ+ArimmedEILV+MNDnV
	g2sOE1YEi55DAq8Oind278VjX7JqmWDt8rEsQcQjVJkRLUhkPxil/IthpagjO0Xb
	IK11Tbzfxj1bYK1isVaKM+cbPsKbR28v29NCn5wzwGvz78tDk/vwqFfhYwp8tGgW
	pexcPdOBJFBISsq532aJX+5Pb9NvHj3IbkF4mllBX0YYBffXHU9FBQWEI+NUOKCR
	YUaIZcb7s+kbjkPq+LsatNBmQ617utvAc9MtG5avswfXJvZsqybWWKGP+aVCyRYA
	+hvDwayjPUsSvsLq1WpPGhJtqAKjAnx5yVg==
X-ME-Sender: <xms:ccNaaPtivn7Zs8m8e6mms1fUArjQZKv6CBywIWv-ZqA5aNCj7s_Alw>
    <xme:ccNaaAfDVzWFv5A9RxvwIO15T1YZwS6hzi_Ssg5q8lkQIxkU64k58ercdl9vpKcjY
    lCrrG6VBypg3ygzdg>
X-ME-Received: <xmr:ccNaaCysamOdenGvuWXoM-CDLTJTww0Pzk0wa15uiW5YwUBfxKmIW_6nU7vHGWetx08qEC2zSdb0_j1NnNSb9rDt-W4vZ54iL6uf0nM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ccNaaONCjlAbr_K7_YG9pR4AQz1hAajaVncQkDHkV0Dyn4Qj9EPK6g>
    <xmx:ccNaaP8wMtz6QCRdCVlYC1O1bpNFQ5X4o77EyI9Na4aKOL9WsYDerQ>
    <xmx:ccNaaOWSXqfSX34WTArfnR3v7kg81wia7EpqXD1cE1pdZlwzoqZ-mA>
    <xmx:ccNaaAfb9668ST3xxsq8xU1OUbF1N9heIgH6B9uDm2W-ONMyEJDCQg>
    <xmx:csNaaFqWN_QTxQWuuUz3J2a8Q9zDaYJDHr0GxoijWcgB5OlB9VLbd6BB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 11:25:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  ps@pks.im,  karthik.188@gmail.com,  ben.knoble@gmail.com
Subject: Re: [GSoC RFC PATCH v2 5/7] repo-info: add the field references.format
In-Reply-To: <254e4819-a693-4fb7-aa92-260038cbfbe2@gmail.com> (Phillip Wood's
	message of "Tue, 24 Jun 2025 15:03:01 +0100")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250619225751.99699-1-lucasseikioshiro@gmail.com>
	<20250619225751.99699-6-lucasseikioshiro@gmail.com>
	<254e4819-a693-4fb7-aa92-260038cbfbe2@gmail.com>
Date: Tue, 24 Jun 2025 08:25:35 -0700
Message-ID: <xmqq8qlh2mc0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I've concentrated my comments on the tests as others have commented on
> the code itself. In general test bodies should be wrapped in single
> quotes rather than double quotes and one should prefer test_cmp() over
> test_line_count().

>> +                echo '$expected_value' >expect &&
>> +                git repo-info '$key' >output &&
>> +                cat output | parse_json >parsed &&

Running "cat" on a single file and piping it to anything is an
anti-pattern.  The fact that you can pipe output into the downstream
command means that the downstream command is prepared to read from
its standard input, so

	parse_json <output >parsed &&

should be sufficient, right?

>> +                grep -F 'row[0].$key' parsed | cut -d ' ' -f 2 >value &&
>> +                cat value | sed 's/^0$/false/' | sed 's/^1$/true/' >actual &&
>
> sed accepts filenames so there is no need to use "cat" here. It also
> accepts multiple expressions so you only need a single command
>
>     sed "s/^0\$/false/; s/^1\$/true/" value >actual &&

And you probably do not even need grep piped into cut either, as sed
is a powerful enough language.  We can also cheat a bit by taking
advantage of the fact that the characters used in keys are fairly
tightly controlled, so perhaps something along this line?

	sed -n -e "/row[0].$key/{
		s/^[^ ]* //
                s/^1\$/true/
		s/^0\$/false/
                p;
	}" parsed >actual &&

> Best Wishes
>
> Phillip

Thanks.
