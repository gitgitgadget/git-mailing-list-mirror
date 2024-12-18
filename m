Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941F91B043B
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533385; cv=none; b=fsmJEL9Em+P6xK0rZZf/1xgQEWlDGXVQRXB3SqT7NYez2rJuEuXtACPeyiRcH4djuwKW/Ny/mlHH2hdXJ9ETvhLKrj5KZv1pHlwYMOKA7xSijSjRzPtD172q8khZzPakvDG7GvkVCOmRlbITUhTVoMHx0wRZfDxuLPaQWOHUNJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533385; c=relaxed/simple;
	bh=GAtP7Y2Gsb4ZAy80mxsSXSzJW4TQrrxLWVNEo37IuOE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IxVaLjhWJh4vL1trxizXNtxp72qwxeMIBlW+NmF2KzR0UNQWHPZ4pwNwVlPzxzRfg/INZoV+8uAfHiBVfr8+CL9J8LnuPE3fLALaZeNd2RzBTiOw05a3NQqu788gj8OiLQXhmursNF6zpjpyRsYMQrijHQTTRysAOMT7uIzFmD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aKsUsdql; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NyqkDwxd; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aKsUsdql";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NyqkDwxd"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 88B8925401D5;
	Wed, 18 Dec 2024 09:49:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 18 Dec 2024 09:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734533381; x=1734619781; bh=kCiQmo242V
	ztayhWo8/dICA0tglSSJdKIDvQDqlsNLA=; b=aKsUsdqlKcz3MnMie/uqbowvO6
	OjGgeHJlEULl8YplftHU3T1bZ5Cwjc+bUrc3y46fIxBi3QaQA80T7Gx0KG7Wm9LN
	HSWW0hwRCKvIDuqQuq3+EapipgIL863kqVVKkdHwl0/qfdVb/hC/C+82fflkO7GN
	tR6iAeTLVZPSMyJXnEtBhVtEqD7MqioNjujFo67hnYCNZOs9hy8QN34JfrqFlsY8
	zLdDXIwr1+JVdYlOz5Q8ylXC3GuFmF0OaPkznHddBtXfFZOGlbMAPrMpUenQaMAW
	fC3r8iTMjo90rGS9fbEVGmR5YNqImnna7k5r+QRd6npod1bEgS8leej6sYpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734533381; x=1734619781; bh=kCiQmo242VztayhWo8/dICA0tglSSJdKIDv
	QDqlsNLA=; b=NyqkDwxdUfp5kLZbQ2nIBJTtKF6nUsJv0oJmFBPU5it/hb2tjdh
	s+Byih6TbKLc1SOMTtGwk5Mvime6qfy2TAp6iffJASsmTlwWYkSQIO6eUyb03qpZ
	7Q8ZVHreRznnl3rTh3LtmnVw5BhrRIAFNOFusJ74xRAM5cdaXb1U+VinbJAliZD/
	Isd9MBMjldCzkwP5qmtt90bTao5j2Ze497ZvV0zHZUethC0LLIFKd8xfecBDQthp
	LQTgF2ARoe8uUH4wEqz5P7TDbMZdR1rQw8noFwAHAXT2HPxMyOuc30kXbeZxik7v
	Nb2pBKiVbqP6UfvZ3UwLgOxsVp+TCZ9+HnQ==
X-ME-Sender: <xms:BeFiZy-isrBNZhlXZhgUn9pKNqDh6KpgFZdnew9gzDlYTTlXRakMZg>
    <xme:BeFiZytkD0fcwbfQGffRwoyKMVpRf0WTrysXsNcvgLoDOkQKMmCuifb6DAC5itQpT
    66Z5UztCAr1c6WQcQ>
X-ME-Received: <xmr:BeFiZ4CgkK7UQRiKc1KJkOSJ9kYV76cR2RLh_umfMOy6ahKnQ7YHqKFJ9py9-6ej4U5HRpS5dcRUZ7YdGD2W1jyRxWsIXEMxf7C88HM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleekgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedv
    udegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrghgrghsughothhmvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithdqlhdutdhnsehgohhoghhlvghgrhhouhhpshdrtghomh
    dprhgtphhtthhopeifohhrlhguhhgvlhhlohdrnhgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BeFiZ6fCqn6nsEQChacwPHvk8AZJppN2HlBQQg-AfXq_2GqaY6LF9w>
    <xmx:BeFiZ3OvztkobbRgWTkOpZ8rCLJPY9o0-AFBzORXDk817uPRXpI3fw>
    <xmx:BeFiZ0mijGdJYGxYLD0SpPiXwel3s_jo4Ny8RO4511VnFDwTcD7xOQ>
    <xmx:BeFiZ5tAmMyeMQBUs2DS17NQriq4-th6Uwpw1ZseIg4WF2Wq-ZNJ2w>
    <xmx:BeFiZy1j9hJ5lQpsAuWi1agqMw4akX5s_HTqxvEDir3-tKSTHS_38OTX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Dec 2024 09:49:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,  Git l10n discussion group
 <git-l10n@googlegroups.com>,  Jiang Xin <worldhello.net@gmail.com>
Subject: Re: OK to submit l10n PR with signed commits?
In-Reply-To: <Z2KfIl87JOWdcGR3@archie.me> (Bagas Sanjaya's message of "Wed, 18
	Dec 2024 17:08:34 +0700")
References: <Z2KfIl87JOWdcGR3@archie.me>
Date: Wed, 18 Dec 2024 06:49:39 -0800
Message-ID: <xmqqzfktujuk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> So I'm interested in GPG-sign my commits (that is, ``git commit -S``) for l10n
> pull request (which I should submit in this cycle). Is it OK to do that?
> Drawbacks?

Instead of talking first about drawbacks, we should consider the
upsides.  Why would we even want to see your GPG signature, when
most of us do not even have your GPG public key in our keychains?

What are we trying to achieve by doing this?
