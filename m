Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E36368293
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746118; cv=none; b=g1hjFzhFaDCXFzN1olw9k+f50/3Zmm1erCbEQkUzQib2XBX05liSVfjPRmdEeEorsrg4InOj9ulovzaJZ+xzjLlR3fudVGI2HCT0QIfzneYj06uUCopNMWK5Ap1mu0OpbYR5jQ+OA6fBVvqM2UQqtb//ADd4J0KyDBQrsvSVVTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746118; c=relaxed/simple;
	bh=qgPVS756c+oJaSDs7F4cSgygpN1q8pGrRMH3RGHtRkc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sKMLb6qYTf0rFAwkb/iXHNr/uIQLuu1Emkj60MXrqPaGj7Vs6iv3tC/YlSPiau8giCNy5/jef1ilGerM2OkS/4AM3NezpXFKjSQyAcQJzTNwYvAPB2pYxKOnqS8gnAxbMrHfFUGJhqIfNy8TwY7K7ItZom9NXcl6msfwq97SBII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YAy7qPOO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZP1/E8pB; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YAy7qPOO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZP1/E8pB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C336114001F8;
	Thu,  9 Apr 2026 10:48:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 09 Apr 2026 10:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775746106; x=1775832506; bh=UvbX3fLQuy
	f11T3fdSUDbQ7KlhWW4e7AtL9ndkERNX0=; b=YAy7qPOOajWgNox4fe8g8aiF6w
	OeXjfxiezT+DpR6BkhxMmlZuQ4hJ68ZXOQj8EBQeGvOR88dvIk8HT061oRApmOLb
	R/Pv45y+KZNeiQMxrWuNnw8er59wgS5bNsqA4QUfx1gCVeaGtYv/vWBT4VZ5l4ez
	dIxesT0qGPLf6Fe36pd8z3AW/8hbiopTNaFctdafOyeuoCY36+o1gKyP3P4nSAEL
	D3nl41eoPcrry06E67JokRCkzEQNFDc9eNxmJrIkiewiNZkpdPheOxCCc5MpzzKu
	f5mnl3MZysAU0HgL2lB8JKYVo6V9HUHN45DLDidWJUTh0L5JTOBkBT9RY/xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775746106; x=1775832506; bh=UvbX3fLQuyf11T3fdSUDbQ7KlhWW4e7AtL9
	ndkERNX0=; b=ZP1/E8pB206JuKddXKch4uOl/U/k2ddFvBDOGedL/+Ad4Bp+82k
	L+LKsqnHz1W5xhsj2gmOgn9tGyEJsejAtk2oIvCvMjGaOtRWepVDAk5RVArsXkoa
	Dwu2RY3DbL8EYcg3VktpW32TszCA/lNHrYvCu/nybABkyhDhE9DFNSH2bdDkU0fL
	z4ZJrwqu2LT7mjXkqBTexvtO9vJfWQGWdaEJL7TFGHcKGjTqw5soLAtKGQW4ssUH
	TPO4L/omG5PQiJkLF/Bk3iWsbT5nBiyK9C08IAicqxhPRosZjpdykOBBOeTE25Wj
	w5b4XInoI5n0Ro67oYUlNEhDp7dEVlhT1tQ==
X-ME-Sender: <xms:OrzXaW27M_h-vmxNF8tKoanFRPrtAhxeRlvUCCjaYbhHA_-yxVrujw>
    <xme:OrzXacz8V25pzMXdL4y_ZV9Ncm7gLWMtj9uTvtDX1DGYayPVhsetuyIE6QU0eGM9E
    MSMxf6-YLPEva16OpxsxBx1kxDDpe9l0_4hZMxhlH3LTxGjo0SWMg>
X-ME-Received: <xmr:OrzXaYtFaUVWw9sfQlmM-fPbKgAkYrArhwXj5qQz8m1bGmMsSg17ncwnalp1EPWpkdoHYBv9G4eJx9yoez85fzEbcSjpNpEiYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvieejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehjrgihvghshhgurghgrgelleesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OrzXaeztXqwpy5KJcCF1P7GXh-hw14BZjN3drM5OQBiseyyWrlaBGg>
    <xmx:OrzXabAkMxKzc9zHs0EUS4M960gkjEiLigeaPW0WzeBG7PGPB5xaBA>
    <xmx:OrzXacfdLLQwJpTcN5aX4xASHLhT7w08uiyY57EQPKfOZcgPSVLldg>
    <xmx:OrzXaVmu1xkilds2pIaX5DP01e0lQBsM5fSdx3b9MBsLSQLuRNZhQQ>
    <xmx:OrzXadaE5-Umq3FCN5kJ7K9mLpxQCfnGXG0zjGu-V67ejEfxw7yW-Z0C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 10:48:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Jayesh Daga via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Jayesh Daga
 <jayeshdaga99@gmail.com>
Subject: Re: [PATCH v3] repo: add paths.toplevel to repo info
In-Reply-To: <CAOLa=ZRo2qWES4XW3UuDxe1Wjew_z7PDy48qQdsjQzD=G8E2ew@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 9 Apr 2026 09:13:35 -0400")
References: <pull.2264.v2.git.git.1775668134796.gitgitgadget@gmail.com>
	<pull.2264.v3.git.git.1775714492944.gitgitgadget@gmail.com>
	<CAOLa=ZRo2qWES4XW3UuDxe1Wjew_z7PDy48qQdsjQzD=G8E2ew@mail.gmail.com>
Date: Thu, 09 Apr 2026 07:48:25 -0700
Message-ID: <xmqq4ilkw5om.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Don't we still have to decide how we want to support relative vs
> absolute paths? [1]

I suspect more than just a few requests to this command yield
path-valued response, so do we want an independent boolean "if we
are showing a path, show it in relative (yes) or absolute (no)"
option, or something?

> Also seeing that you're a GSoC candidate and this is part of the project
> that you've (and other potential contributors) applied for, our
> recommendation is to not start working on a project before the selection
> process.

Perhaps I should refrain from commenting on these patches to
discourage the authors if that is the case.  I am not raising an
objection, but do you have a pointer to the rationale behind the
recommendation?
