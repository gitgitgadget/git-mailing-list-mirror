Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7245331691F
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758566491; cv=none; b=EYqrplfPn/VoYgYSHvHZOdkeUDE1kowRTJOk15TvwNriJKpAFukv5Mi5QkUZjKWwzcc60h0ASwXc6FQJRcc3cdGDf1lkJHr4/ArXg31/WIITm2Py6QKHYpVCphcoq15STfycIR/TIOGc9jjIox46JCwzhMfWI7EaksyE/1pPIqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758566491; c=relaxed/simple;
	bh=LIwEnx9BgRPYPFI6fjXn0nWfKQGOap1xCEm+iCm+L+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qJK1stHimniOYmzRfe0DdUuX2Kfu0lA0kTNH3eTsJzw0qkc46JhlI1cmg9IcGsDAZJ++/qn5dbApNy7iesgfh89f6EzoCZIfwK2cmw2/o37/WCzWWocxIzxdATZIrt7CSJ9sj2dQYlcA2TOYMNtdBVQ0LnCltxmO1P+e8UrFez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fiUhWyZc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M7OYBCrb; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fiUhWyZc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M7OYBCrb"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 524C91D0026F;
	Mon, 22 Sep 2025 14:41:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 22 Sep 2025 14:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758566488; x=1758652888; bh=uxjRzqJEm1
	Vw/HZSzA2/4y6xr4Tijk46O0MA7hVrg20=; b=fiUhWyZcbzPjS9WjmFWlYm8rg4
	G7VTFM4L8vBzkc8oZbwc/C28B1rix2gzZUJ0WFHxbVgsUAr1zvBLRPMyy5AcTBB1
	3H8eLmz7J92+kFLD7eBXjAH3hf3kza9mnAAP3M5V7KhCodDKMtyrP2exqihDeoZd
	UPk36XV6rQXAd8+dI6hlSN3mgWi+WMvx1bk6v2rG19XouCOIohSsK2qBS7tKEBuF
	DOg0T4qGanVEhBa/KRg03JsOAQhmwVWGPyWs17LIZM0bTpSRPR1YLtXc4E2yGhb+
	tQU8i70+1CtV5R9tIeugHt7sw+E5nGQAjW6E7YjGTrWwjY83pTgI+RmW+t/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758566488; x=1758652888; bh=uxjRzqJEm1Vw/HZSzA2/4y6xr4Tijk46O0M
	A7hVrg20=; b=M7OYBCrb5XmqlFioIjlNl/X0YiIRjCUNsnFej3qPhO7gKd0AZ1G
	r8NeKKmpzZhUwJ1oTPZRl7JTfYeU4jccuo/yk68PlU7t2dnd5vIhKmXL7ixEmLyt
	Dg61sovx9g10Ihso8BFVkCgHl35LBH/HY+6bW1BtBKUiBgQS6LRh8/Oz9LBNcw2e
	FY5Ga4tdJ4mDz4aSnZ3fowAv6wP+z+veEny8oCU6yq215lXEtbbswGp0E3KZFYmM
	tyDLIRJd1vJ4w+WQcHHfcBagy2aB3M6xJCd7F74c83tSoD5wREQaMpCdkLugUzt3
	VlMRpiTXFZU6seU3+dp9SQmX45snStw1ZPQ==
X-ME-Sender: <xms:V5jRaFZXAG0l-DIA6RColRlzQGD6eOvMOJXihhVnq79ea0gA--C4Cg>
    <xme:V5jRaDRaEeoilBzno3frzmblz2dHWYqyTDe6OlizajSJW_3yM6lPqYyHgEwngs0HF
    qHRNkXM0sAWhgt9TF2S0ykTgQRIMMXe0YgwGrlS0TvvbVyVojs>
X-ME-Received: <xmr:V5jRaASzcCMWHXqet6y5XG31X3pOAvZozpdkKr6Wakq-Fdl6fVSSE7FSLFROYv38M2LPvKLoy83HBbz6z00KYpb9yDtmbSWrzT_9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WJjRaPT6Il1d2OxowXGTV-c8IqerjAJ4sOTKgX73gv15liHkfrlOIg>
    <xmx:WJjRaN7OYTsHK02ZKoQC6G09hcS29-jlGQtEFA0PfkQt68b5zbEPaA>
    <xmx:WJjRaD3iJGWQEeMudC3PkzV0EyfxN4PeGw-AtjSigUlbyfNSt0dVeg>
    <xmx:WJjRaABqbADkF7BP9-ohJQy92mtkclHdcvEg3-COHkHbvjp4slB0Zw>
    <xmx:WJjRaCgWOYjyCHCfGCEyBf79CYALb7kvno8o4jyqg8TbmDK6xAQiC6Ke>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 14:41:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
In-Reply-To: <CAH=ZcbA5hAM9kmO410KzVW7RXWWiwX2oJk6GGPP+6oVYatRVOw@mail.gmail.com>
	(Ezekiel Newren's message of "Mon, 22 Sep 2025 12:33:50 -0600")
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
	<aMpODEpyaaVhFMO0@pks.im>
	<CAH=ZcbBNFSwU7E+P7hkQnt9UrMKiCRESgGvWPL7pRUa0i2U5-Q@mail.gmail.com>
	<aNFIozagGc0MoseL@pks.im>
	<CAH=ZcbCZXavx52521cFHdXZn=BCWBiR1aG10ekZVg3PVVJb2VA@mail.gmail.com>
	<xmqqikhav3i0.fsf@gitster.g>
	<CAH=ZcbCsKdZAPxBEPUMvE471ogTNptjFy7FFksWnJfnX=J-F2A@mail.gmail.com>
	<CAH=ZcbC_ecyPeLS_0DfN3+w9RTqcrt6Je08RPXqb6pJVGaPjuw@mail.gmail.com>
	<xmqqqzvytkqi.fsf@gitster.g>
	<CAH=ZcbA5hAM9kmO410KzVW7RXWWiwX2oJk6GGPP+6oVYatRVOw@mail.gmail.com>
Date: Mon, 22 Sep 2025 11:41:26 -0700
Message-ID: <xmqqms6mtjmx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> already refactored my code to use [ui]int(8|16|32|64)_t in part 2 of
> my xdiff cleanup.

Noted.  I think [u]int(8|16|32|64)_t would be familiar to both C
writers and Rust folks who need to peek into C for working with it.

Thanks.
