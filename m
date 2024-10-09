Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F52137C37
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495117; cv=none; b=D0RK77+a+7K0+kNHpAGQOoW2ITs/vPXprp6CuwPlpCH5ikVAoHmwVL3sSKHkd1uIAjVBEcbMQH0XMsH97cPLMZF97CZCUTReT4RLmajXm7jJwm+6Hvzm4xBf/OQJLKA5wazXhcka20NyDNJzuW7gzAdttbHMW+rvttq9uMjpD2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495117; c=relaxed/simple;
	bh=SzK7nd+SsQodPaczNxOekhBJkF4HemMMsrR4g6Rp9Qo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=At5kzPnNsom3N8IVc/CSdTrCSglBgoBCLrLOYZr74nERz7QZgh/f6EOB0GzQ8kRFT3zDK9NGNr0dmF4A8g3F7QwRV54kIO4PToELAz0KzG10rGJXQl3VPJDQlBcvHPFEYrDRla1WltLFeZaTNcAZ6SiWi6IrLncM+MJVfJs3qPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j2EdQ8Xe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A/ZwN8b2; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j2EdQ8Xe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A/ZwN8b2"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F8D81380142;
	Wed,  9 Oct 2024 13:31:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 09 Oct 2024 13:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728495114; x=1728581514; bh=SzK7nd+SsQ
	odPaczNxOekhBJkF4HemMMsrR4g6Rp9Qo=; b=j2EdQ8XeOqWRR7DtPb4eM/NDiF
	9/kgsY4f3/xooW5vMPb8cNTx4/IAMbLrYLp9IFN5dSl+8t+VSGHvozbkEx/J47OU
	GtWiH9Ryvz8ESDA4CjKCNjT1u3J8NP0sFC5+WMjJXHnbBSuSaXQJj/pmLH74/d8x
	jeVhORd7EwQd2fwZc9L0AjjOuGlanMG9cyQz9VBpEte5ZldiQuGF5K6mfJOua4Bq
	DQl3ZfDhlMcryprmoKJny/VDIS++Mkr4Je5XT+97YgC+fQ0BWGtPJlVX0LYVOf5/
	GWpnBsN1mzrq+XIcoYg6oDSn3+q3vMBNwEZ0WM73t8ywKxejURZVeUTcbzcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728495114; x=1728581514; bh=SzK7nd+SsQodPaczNxOekhBJkF4H
	emMMsrR4g6Rp9Qo=; b=A/ZwN8b2mnJnP+dubpje6UGuwuWJAJcrSPepEvcsIM7f
	yJC+sDOUu/guEMIxIYarv8EfUvoaxnYT9hhK+8BluKgfBxh2aElsVIPyhR0RvmOs
	pU/f3AsW5hAssSjM5C9VkVPikbMR73ESxH61pn5uONSacNQc4tqQsGzLGobjmMx6
	fVTzZrX97CbBbh3BaBthKVuS9ZDLF0hbrxL0N3T9N3N02MLwY2iLua9tHZd4ig/R
	HMJprlrFhpjccPcrPkXtn3Dx1k/gxnf8dMX36TeFSUpsFDk8HZp2w/uGEqO7sXfw
	3lrNWVr7L6BdyFNUIkSnZ1kFtUyoESz7wqv+T4IeFg==
X-ME-Sender: <xms:Cr4GZ9ZSeQMI6UYVqsqSE2FunnaM-x-a6mDRA7KeznVkHwSI1dQLww>
    <xme:Cr4GZ0alUrTywpkCeawObGnTCxuh_D3jFrBMh7IWs__18NtyUcqoKir9O3VHmATIv
    bZJJp3QUbzf0zgqwQ>
X-ME-Received: <xmr:Cr4GZ_-alQ-PTRVBh09Bgq9sePmkg8Q0LJgWkawDHgcobwWbEfQjA08PdtHBa0tHBkzVxTqM3WikgAWWnXCXUa_8Z9309hbIoiBd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhnuhgvthiiihesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:Cr4GZ7qE61UXTwYOfx7d_jw6nYhBEUVXZbof4XZFLG9YerEb-EdHgg>
    <xmx:Cr4GZ4pjQhIQnbeH8uTGFgc6GINi6SgjKbyc9zGgzVBHIzio0E4Czw>
    <xmx:Cr4GZxT60FuFNHq6RIx_16o8bZXKXCMQlJxX89YGgvpyFPTZSfvjCQ>
    <xmx:Cr4GZwoEti23BYgau4-OH3eDAJiGKgOademnVdvMG8hrWiG4ECNN2g>
    <xmx:Cr4GZ9D4MoC9OHdNXaV6R3yCaEzaMkUYUE_KhLT0urGUrZ0huj9a2keA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 13:31:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Gabriel =?utf-8?Q?N=C3=BCtzi?= <gnuetzi@gmail.com>,
  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: Bug: `git init` with hook `reference-transaction` running `git
 rev-parse --git-dir` fails
In-Reply-To: <ZwZPSA-J1RFQKYrw@pks.im> (Patrick Steinhardt's message of "Wed,
	9 Oct 2024 11:39:26 +0200")
References: <0084cc18b6d90ba14849a7f788939f4a1d0d61c9.camel@gmail.com>
	<ZwOVy4FltrEjxHn_@pks.im>
	<867f42bea10de470532d2f30eacceafa2b03d8de.camel@gmail.com>
	<ZwO-j0C59vuYsEnt@pks.im>
	<a8807b44026458097267932f429ef61d5b77aa4c.camel@gmail.com>
	<ZwPEwL-fKHBkUOcm@pks.im> <xmqqiku38w51.fsf@gitster.g>
	<ZwZPSA-J1RFQKYrw@pks.im>
Date: Wed, 09 Oct 2024 10:31:53 -0700
Message-ID: <xmqqfrp5uqra.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We have another solution that is even simpler: just do nothing. I do not
> think that the behaviour we exhibit is wrong. Unwieldy? Maybe. But it is
> merely stating facts: we are executing a transaction in a repository
> that is not yet fully set up. If you don't want that, either don't set
> up a global reference-transaction hook, or alternatively handle that
> edge case in your script.

I like that over all the other choices.

My art in leaving out what I really want to see happen and let
others say it is improving, it seems ;-).
