Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E605D1D1747
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298646; cv=none; b=qV2gIO3Uw78XBt6Y09QUb15Yo6h4xHjWsmBDsJ7Sp3/ERiu4e01SF+20tT93FnI3GoHMImO1oYZcQL1YF7woo2FnfX2cRaDzFw06HZNADwnKQc2WeIAXhQbubeOV5THsJ3D6/7KC52jlvvyzV8ujmC2qCd0dEpF+XQc+lVzQ34w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298646; c=relaxed/simple;
	bh=bANMnOutAIk8Esc8IICZEQo3Tqv57qW/LeyHb7SQy9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPBoVji//cjJMxL9rS3JuLx4OxeBC9LMosEn0UGmED1SQqe/elS1JIT4AQ7CvCXoraR8cBeUiLCzD8JT6FKkT75UsrzI4qeIhw/A2jIZuyAHNZGNqsfpk9kkQilh+pN2h2/PXrog8VD9t6LTw2RUdLURPLxEPALRBN/4XZZe0zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fwebTO4Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gib+qgsY; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fwebTO4Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gib+qgsY"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E848611400CB;
	Mon,  7 Oct 2024 06:57:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 07 Oct 2024 06:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728298643;
	 x=1728385043; bh=R43JK/1DqkjVT5/kFmA5p2965rEhY1VgigdUgBG+oQA=; b=
	fwebTO4Yeckod3uU5tA3Fgl9E3FN+EK26wuahUby/NGbWw4wRQXdENxAFbkAtzL0
	MMGcXyclc7rVpJ6LXaD1DxItbRPp8L7S6SUuRh5jt4CtdwDLopfG1AxHArJBnFN2
	1zkpIcnhXNaptY7ud94hVAv9NXN03h6KJ/pwu5qUp0ev+ROfTUmRERWJGEfL1diA
	VZg9XY5utpMnDNysUFaU+IGp7siqWWjorg8qOmHazL/Jj2U+tT9Gzbe4yU1KNFa9
	JK9BM+lCYCN1YCoti8Mdamqb9YK2jKTkxNG+V0IrsdrGbRwKKfar2Lvq06J8GS44
	GsxPR0k5MNe9crAFnbpQDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728298643; x=
	1728385043; bh=R43JK/1DqkjVT5/kFmA5p2965rEhY1VgigdUgBG+oQA=; b=G
	ib+qgsYPluEmxAN4LL+ktxcM0KXF8fEmz98sivuZehCt2j8dLNu6+iHrzbBhufic
	BBblujLjaMY0QBh8J/x0CAewpSB0YVvxI7vt4YNkt/HIkMQ4MMtZGwfLoyp+wf/w
	KF9mjuRbGK/u9bF6xjjTJ4SJMRjUkrdsgEeIKF+GwZQGgGr6zGXxIlSCazQl98CN
	MvGs/+hQNXYLMlJG8V88ydW3jA1j4urV2wAH8EG7xWJYOa2k0XBsokgfA8MpdHmO
	hflqiUw8f3XpNXTtddVTP2jEUWRY9OwRYvWZMB+jRY56jfYbAw5x/D4YWtkJj9K5
	5thzarN5vpJbL22DmmSKA==
X-ME-Sender: <xms:k74DZzAL3ySXLERfOLZBQb46armXzqzbchT3EYNvfT50SMcmzMau0Q>
    <xme:k74DZ5j_Ok_NMIogP5JiIYjWPxteMJcory24b-55cc82SayPALrSAjwtNHRdTnNm-
    efNzozWXeAbHbxmtA>
X-ME-Received: <xmr:k74DZ-m7QSVOBtov_ZAev7UOrBSlyST33QJQMIV4xnlU7GCedprLjulEGi5L3v2C9rSiox2xmNgcc1WXk4BSxvj0NXuQln9rJfgASevCaAHO6lIQfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgnhhuvghtiihisehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:k74DZ1zEf3m7NySr4TndtR3hpKRZIBmgN59ibPDhAaNRfjsP_xPedw>
    <xmx:k74DZ4QH5Y6jcJiFmF6pUQbWWToLcBsez4-A1e7zgQzenROQ9h58aw>
    <xmx:k74DZ4Zn24LH7ckare5Be0ZjUaSghUdms2hlH5L3u-qA_-WSV0Q8kA>
    <xmx:k74DZ5QJk-wMjuwgirATwXJXHQQN0X07dTwtE4OB3YZ7Vdhz6mkt6w>
    <xmx:k74DZ-f3mjl76GiG6P55k1Rdk89RXIYrXjFxxCr8r8RPsAmEUUz2Kc1V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 06:57:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 94b13969 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 10:56:23 +0000 (UTC)
Date: Mon, 7 Oct 2024 12:57:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Gabriel =?utf-8?B?TsO8dHpp?= <gnuetzi@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: Bug: `git init` with hook `reference-transaction` running `git
 rev-parse --git-dir` fails
Message-ID: <ZwO-j0C59vuYsEnt@pks.im>
References: <0084cc18b6d90ba14849a7f788939f4a1d0d61c9.camel@gmail.com>
 <ZwOVy4FltrEjxHn_@pks.im>
 <867f42bea10de470532d2f30eacceafa2b03d8de.camel@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <867f42bea10de470532d2f30eacceafa2b03d8de.camel@gmail.com>

On Mon, Oct 07, 2024 at 12:54:36PM +0200, Gabriel Nützi wrote:
> Hi Patrick,
> 
> Thanks for clarifications!
> Could it work if for (2) -> call the reference-transaction hook after the HEAD has been initialized, meaning that Git would internally cache the
> different reference transactions and then call the hooks in one go at once after the creation of the repo, such that it is initialized properly?
> This might be probably a more elaborate change which introduces too many technicalities?

That would break basic assumptions of how the hook operates. It is
expected that we abort the transaction when the hook returns an error,
so if we were to run the hook _after_ `HEAD` has been created that
expectation would be broken.

So the only viable solution is to create a stub `HEAD`, but as said I'm
not a 100% sure whether we want to go there or not.

Patrick
