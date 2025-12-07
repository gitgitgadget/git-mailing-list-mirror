Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C53E18C332
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 05:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765085914; cv=none; b=EJ5ttHrkN8eRPfYbDl3ykSlQAe2JLlc+toxP1MSr1fmEAeyT7OPG9ZBjFpSMEncZSvMcxSs6KoKfO8uaY90l8KUO3yOF89iDrVWngO+2sY6cHl1DHlM4driR5UCQ2tbf7gfRk3L+5sbymi5calvoArgBW508reav5+tMXr2EZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765085914; c=relaxed/simple;
	bh=FSmh+dkB7vJEOEqi5ldNbqTO3LKotrVrnErN5ZH0A9k=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=loqhuhHAL29SuqLM0BLhVjq9T+S2+oeslhHGRPJwjfvdPN7OlHs2VoW1Eq7lQBRYHldqRsV1pvflYvk7ls43EF3JnBjNJrV0tYTmquuEjUr6pAzX4pIe79is75Fj6PEqXOWANcLtyB8U8C93SxmAseq8ubsI47HYErjmEjZ5Yt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EitmNQvA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NSNKNDTR; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EitmNQvA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NSNKNDTR"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69DBB1400134;
	Sun,  7 Dec 2025 00:38:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sun, 07 Dec 2025 00:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765085911; x=1765172311; bh=Didn6s8Xyt
	Xc4ee3VQvzhkw/TCNu1oY0XcX5pZSu0Wk=; b=EitmNQvA7dmo5QNDssAlrCXulH
	avKjniWx5ER7wpRGrVbXgqYkbTcvFPwd9ksSL3g5yeJ1tVcMFgw64oBdUkAQKND1
	EoAWY2NqYsrekppCPMvdtCG/zFzZ2G9leUzuSxo9ShhYUGIhTBXDAUtf35pV+rAA
	Ea+Hv4s5FUAkVyqWVb1dWfDl6NBWltW2OdoPCD72sJ+kEd+Bmnom5zMNbZOuETvx
	aVdiEzZRWmEYwoqr8kQDap8int7PBmhLea5+cH0CJuHzAe4v3cg975P9b8e6SXJG
	JFcW8j4jSBO88bz1AlubxyBO02Yu07ZYTaFowD1MxQJw/13066W3IGVwG1Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765085911; x=1765172311; bh=Didn6s8XytXc4ee3VQvzhkw/TCNu1oY0XcX
	5pZSu0Wk=; b=NSNKNDTRrn6bgt8gN+l1UFAqI39z7LRCcej7P3DttJHbnI6NWM3
	tzmogsDsqeMSeJnvZ+GDUfCpTK56SVJjimrb2mz65bbY+yto8piQIC5/RT/K12VQ
	1FlxUCPwNuAn8c9ERffxPQsKkjzWRAqQYZqfZKQeJkwB9JXz2a1Sgu2qxsd5AjSe
	g1CMU66zDjLxVdp2uj5TEthK7w7UzrhF55KIQ5yWdv8fi589RPMOeVQnIp60EUPg
	mCpQikdLRmDkduI+sOfQSvXGJ1NehK2yxVc+Spa4OOUYLTOL64s2QSJyPuueuDY8
	/cwWBwXD1Ap910SVsuLMU3ZDmzBsxEsa+BQ==
X-ME-Sender: <xms:1xI1aUpXGEQvL8okZ610wAsGYkZKXjeLlD7nrmwU97IHpI9Z-smKLQ>
    <xme:1xI1aQpGlVmKvxiLkgcQupt5fZNbzV46rTQt9goxATWGWFhtjlNomePK9AypUJSk3
    dd6OBCvMYrWYYQKm4slQesPS4rV8jhZfUr7iK6KlotK0W90YY4_Ow>
X-ME-Received: <xmr:1xI1aW3E_LLNhaRgUnQpAQWfMoM8XGYXmQmXQOy2xMJ6SXuM6BuWJT9ddsZc9yGTs9jRrYgKxAfOdsVic52wGBSloPXxUjmeiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfeuudetkefgtdeugedvgfeuieeuvd
    elgffgfeekvdffuddvvdekuefhieefjeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:1xI1aXDZbxBNGWABIQ1IdiQn1Tx58TXKI54N__UwmII7n3Ht6Rcz8w>
    <xmx:1xI1aWeyAPrwTBrGJ7HR_uZzmaB33yflEhYkv-yRy7BhaRHf5DRXEA>
    <xmx:1xI1aUhrIHkichQDusIWITKIMmMl7Bz3Zi3SMQviukunk5_J9HKFxA>
    <xmx:1xI1aWoQJeW-R2VyiVYC1aU-5h3J35Y-gsF3hWzZ19Ur5si6mb_ILw>
    <xmx:1xI1aYDS7BDBnEIPbOT05qQc5PzBs99iK9arbCtsvX0uIgirFbURxXmF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Dec 2025 00:38:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH] completion: clarify support for short options and
 arguments
In-Reply-To: <xmqqzf7vm7b7.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	07 Dec 2025 10:03:56 +0900")
References: <xmqqzf7vm7b7.fsf@gitster.g>
Date: Sun, 07 Dec 2025 14:38:29 +0900
Message-ID: <xmqqbjkan962.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> The list of supported completions in the header of the file was
> mostly written a long time ago when Shawn added the initial version
> of this script in 2006.  The list explicitly states that we complete
> "common --long-options", which implies that we do not complete
> not-so-common ones and single letter options (this text dates back
> to May 2007).
>
> Update the description to explicitly state that single-letter
> options are not completed.  Also, document that arguments to options
> are completed, even for single-letter options (e.g., "git -c <TAB>"
> offers configuration variables).

I appended the following to the end of the proposed commit log
message:

  The reason why we do not complete single-letter options is because
  it does not seem to help all that much to learn that the command
  takes -c, -d, -e options when "git foo -<TAB>" offers these three,
  unlike long options that is easier to guess what they are about.

  Because this rationale is primarily for our developers, let's leave
  it out of the completion script itself, whose messages are entirely
  for end-users.  Our developers can run "git blame" to find this
  commit as needed.
