Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F64154425
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757987073; cv=none; b=CZ8R1cfyCrTVsjvhpYT6uIWDnR5Pj/rHfU7dbzgdG0q+HYE6M2xLdueGGCyKZXSmBATvXoNkNX8ZWiAQrDm0sO/W6V9h9xB48YM3qyjq+8IFkJZmsu7dYmQz3O796oaQjDyYW64Arlnj9Afrn+bjp6fhGAD1Yzghw1QSOoVrA7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757987073; c=relaxed/simple;
	bh=rlRSFkQAhW+P60lu4uOkpVXDYCLV+zsgOcPkqwdED6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=btQ7TITP8xr+nhWx5gz1iIbiCS5Ddfry1sjZrfaskTlE/mhpybbCWy96r26yoU0m7elRABRoATzOG3Li3Y62AyEd1XF7JeXxouMq1xSHPXLNdXjhY4AIIvrMJC48b2+qqgzcdPxyV1KSEIAohQPcNYHKw2QPsfKiGqHCNfl1pwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=00oH/4HL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NMNdhREP; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="00oH/4HL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NMNdhREP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 632D67A01DB;
	Mon, 15 Sep 2025 21:44:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 15 Sep 2025 21:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757987070; x=1758073470; bh=+N2cFZqolv
	4WG/Q2cRIW0K0p/ETx4JTZRz8LrKTsDQ8=; b=00oH/4HL6zHlhps+mm7tcSZKH3
	YPZNxuJ5FlDDUmLb9ECSfOzvOgq7UP2n1F0VTzcd8iVxT/vxJhUsdmoOnoFj7d/s
	9XtmEgkqMIwqZHm0VhD6sNMv5zyFJu47855yjeRXSFDC9zwVzy64pgyoA3NAMOjl
	XDNnC8WkDeBQSbbNmtFbVla3Qg/awcJKvNgNLNzDzZ+5oz1BsgF+jj6Zbi8HzVOA
	wiDhaJTp8kY6cJ08Oab20YL//Cp4Q/4f18sA87rZ/7BPHqR1W6MYEcHnsvPnDNN2
	maTSvY8Dae5P0kqmimoDVeDDTrm3fhwUlavtqVsuKIMJe5FuHqrSEWR/hETw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757987070; x=1758073470; bh=+N2cFZqolv4WG/Q2cRIW0K0p/ETx4JTZRz8
	LrKTsDQ8=; b=NMNdhREPw1o4+zmUVDwVVY6Qi++H5UlT40Xy5kw9dtixm7jcTJC
	Rf6VzIwhP6pGJxT+QbZ7qn/1YAGQpB/+ylYnsIWPx9WbkiLgqXvI9748rJmP6JS5
	EMtvue+J/5m7oA/Zo3WsFawXuXyl2JGofBvyAnswjCt+L0OMYd4ENar48a0GCQRG
	rhq8cw5aS03M0Oj7M6p6vo4AIJZ0jy/C+25YGoiFiTyCuCjCUxsRkxO8s52HtlOy
	2Nh5DPju06hsWRB67Vnig2ZJ9cLXPK7Bit6N6PgiOLzWYGQgJvDuGYNQSLsHhyMZ
	arPfObiIbL5wnt2C76Pnps8CJKh8Wxt4CjA==
X-ME-Sender: <xms:_sDIaIxXeNaR_nUQHpaB30ay0k62nrLTLvuZg3FHDoSmZf4QksE8Hw>
    <xme:_sDIaEtpuNUaIekAj0SzBq2Q0e2f0ndvHQuNeaF1lwCmwbB9hZN_5ziI1Ne0TTDnr
    dRjAAPneGeF9yrNkA>
X-ME-Received: <xmr:_sDIaKymL63rPcYMwNDPdoL8PcWZuUtxWevlrkTb6srGokzrdSOV4fq-UZucU7qJIb3VNeR29b60jjlZHLbflACxtGhfgCfB11kPT6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefledvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:_sDIaHBODsJyidKmimE1TSRWWNSsqgLwNHafeREqPIrYSpsjarKkUw>
    <xmx:_sDIaIckAHmFGts2Lf_JiHk0mOzou4ySsyM7dhFDQDoPgYrwTAtgPQ>
    <xmx:_sDIaBlOXXIFrftknXSAVL-cj9z1hjgxbCEarfIZVpz1Rc9jOX0uhw>
    <xmx:_sDIaPG6vjGTjeuagYwj47qRnkNNS0_po299rpEwvdG2qfKnnIcd9Q>
    <xmx:_sDIaHVnftdPodNqpCdYPgjnwKxAeKGFyQnV6pLA8I_JUVUPD3fQhT2C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 21:44:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 1/4] doc: git-push: clarify intro
In-Reply-To: <70034c35-8f08-4ee0-9017-7faf6f55ae14@app.fastmail.com> (Julia
	Evans's message of "Mon, 15 Sep 2025 16:00:43 -0400")
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
	<pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<270edd2b00e63ef396ae69a9a7e9113a54f0df82.1757703309.git.gitgitgadget@gmail.com>
	<xmqqjz23l7ci.fsf@gitster.g>
	<70034c35-8f08-4ee0-9017-7faf6f55ae14@app.fastmail.com>
Date: Mon, 15 Sep 2025 18:44:28 -0700
Message-ID: <xmqq7bxzcgsj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> Re "refs": I think "refs" is pretty relevant to `git push`, which is why I left it in
> (as "or other references", to give readers a hint that a branch is a type
> of ref/reference).

I have (and I didn't have) no issues with "refs" -> "references".

> Will try this:
>
>     Updates one or more branches, tags, or other references in a remote
>     repository from your local repository, and sends all necessary data in
>     those branches or tags that isn't already on the remote.
>
> The goal there is to make sure the reader knows that git push may need to
> send a significant amount of data, depending on what's in the new commits
> you're pushing.

Yes.  I do not partculary see the point of deliberately trying to be
vague by saying "data" (in "all necessary data") instead of "tags,
commits, trees, and blobs (collectively known as objects), but I
agree with the stated goal here.
