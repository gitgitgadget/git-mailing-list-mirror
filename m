Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBE11E531
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596654; cv=none; b=rw08ec3WSDidt3RU3KNZiK3Ya7Omtl9ixpHZl2/ct14SLuWwVL+o0kFonErqjzQC8Z/4zD9MeT9L6yBR9GQz8RJZbX/5tNWGt7q1Rqc+I4fsqTbEeg61o9F1Q7Frm7Sm3yu//ITU/zsoPDWomtey1jr/YhbELY8QFKVUflfdaj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596654; c=relaxed/simple;
	bh=ceyx0RnjroOUz2N2YxVCzxUQ/pcIlwj2q2yiLUhQZU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OJlXYCcGvzgxzhTf5H8rtL65O9CoS89UULycuSvx+WJHbK2Noy5+PHD6Uau7FaQ3dhwfOyNJDG7+TE3OUjiRvYba5h77aK/NPAUAJfPiXKOWXZPOkb3CeXtdUunn6CRHpqw1CqceK6mHbyc5gHmQy2/6EkJC7nrpEzX4qriUQKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aWBekRpJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k5Lsnp9k; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aWBekRpJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k5Lsnp9k"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B4A11D00278;
	Tue, 15 Jul 2025 12:24:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 15 Jul 2025 12:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752596650; x=1752683050; bh=qsIFSO1W0d
	0+04EauyHbMVztH2gWZIIn0bi2Tz5fT1Q=; b=aWBekRpJeut1T+snbUFsBQKOni
	RYHstjKaeCoeyja2nVTG3uZjsWyXoadeJeuZcje+JfGkHwIN28xSegD9wGiohgQP
	dbhUi3TanG4Hpsthi2wfxHU4gVYJ4UZuc9QHSLvabHV/6JUoWAnAPDxVQu8Vrpcg
	K1LQBjFFFQ573JBsui2t9KQxGlufhxdJ1jM6J8FGQXWGcrTwJklLZmF/raOv7FcZ
	gtF4DJsfw2mqUCZCUmLR81YklR+RuzPv87qwqz6AHAMtw/3v1oi4YmEetE5V+ufZ
	zhHMLsUc5T19eTzzYRLDdaib/SB5tnUHl/21CA5tHdWpLWOiFws80way0wRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752596650; x=1752683050; bh=qsIFSO1W0d0+04EauyHbMVztH2gWZIIn0bi
	2Tz5fT1Q=; b=k5Lsnp9kKshFOSQfe6dwt7i+ys8TOvdQeF5MNabT/v1MclpFGl1
	RMJko5Xchq1AValKSnHxADqYFgbCtZ+HE1rdiRFhXqRGfN0sMeUwk0ktDne2ELQp
	VHjJUFgckGVF1aNCJmS7WOCmuLznX5c4rgH3NwJ7nc8ySS4fCdHjJDG0IeItH+iP
	yklomgkP3L56GCKj4EtGbkQgz6Jr4uarN07vxauSvX+Bf0o/joP77g0TgHArSnHq
	HnFX/CrzXkM0+Xnx29PUg1chhv/2rBQhkFgxoi6uUCiSbelJ1QOkcNjhqT3nJVZ6
	9LbXQg79cilEZq5iAod3zHsIgZvg6rdUEzw==
X-ME-Sender: <xms:qoB2aDMr6hXED_dv4gec6g94azBScL0M8NIcoTi-ple3ysaN1k58jw>
    <xme:qoB2aIhEcjKmRNYmxpq4_Cf7MVhcgRuB8mphByHm3rn2pLoRs68bzTRqaB-9lAPDO
    b8AqkYwOBgecYk5wg>
X-ME-Received: <xmr:qoB2aO1ruRpXpxExN5g8Cn4FktIfoqr4hOi5O1xP7WVrSoWuzfNowHG5q0nnzTPgXNYpoeH1SnxRPBJmoTaVlXUxIgWue7HGhdrHXP0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:qoB2aKgXp6kWnn1GDYYTNC8AyR8l2LhNu7VRTWV7Z86I2FGNXvM60w>
    <xmx:qoB2aGdQ3CgZSh7NwXTStv5dQNhIvjY5fx2Q0HWTmWtoBQyvkrAW1g>
    <xmx:qoB2aFnZ6U6B-Tf-kW41ebT6GDdH8wVkh3GLm02j06b6KpH-z2Tw-Q>
    <xmx:qoB2aHtnEFptf_0w44AAdDzwm7OtfaKnlrCadRKlRZOwUkvINrTb3g>
    <xmx:qoB2aPfjgBDyRQQSxgTEew_gB6luutR9-SEvx0kxMprBWTo6amXyNfS6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 12:24:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] strbuf: add compound literal test balloon
In-Reply-To: <aHYXJ7EmRQE1P5xe@pks.im> (Patrick Steinhardt's message of "Tue,
	15 Jul 2025 10:53:59 +0200")
References: <7ac55a5096c261b706f47ca239c381f71db2b67a.1752499653.git.phillip.wood@dunelm.org.uk>
	<xmqqa556x2z4.fsf@gitster.g> <aHYXJ7EmRQE1P5xe@pks.im>
Date: Tue, 15 Jul 2025 09:24:08 -0700
Message-ID: <xmqqqzyhifrr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We already have a two test balloons, both defined in
> "reftable/system.h":
>
>     #define REFTABLE_FLOCK_INIT ((struct reftable_flock){ .fd = -1, })
>
>     #define REFTABLE_TMPFILE_INIT ((struct reftable_tmpfile) { .fd = -1, })
>
> Both of those are getting used in a way that'd break if those weren't
> properly supported in "reftable/stack.c":
>
> 	for (i = 0; i < last - first + 1; i++)
> 		table_locks[i] = REFTABLE_FLOCK_INIT;
>
> 	tab_file = REFTABLE_TMPFILE_INIT;
>
> Those are rather recent additions though, released with Git 2.50. I also
> totally missed that we didn't have any test balloons for this syntax.
> Should we maybe retroactively mark them as test balloons instead of
> converting and marking some new sites?

That sounds good.  I was wondering if it is easier to keep track of
things to add a new section to the CodingGuildlines document,
perhaps like this?

 Documentation/CodingGuidelines | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
index 6350949f2e..dd3dbb9c57 100644
--- c/Documentation/CodingGuidelines
+++ w/Documentation/CodingGuidelines
@@ -298,6 +298,14 @@ For C programs:
    . since late 2021 with 44ba10d6, we have had variables declared in
      the for loop "for (int i = 0; i < 10; i++)".
 
+   C99 features we have test balloons for:
+
+   . since late 2024 with v2.48.0-rc0~20, we have test balloons for
+     compound literal syntax, e.g., (struct foo){ .member = value };
+     our hope is that no platforms we care about have trouble using
+     them, and officially adopt its wider use in mid 2026.  Do not add
+     more use of the syntax until that happens.
+
    New C99 features that we cannot use yet:
 
    . %z and %zu as a printf() argument for a size_t (the %z being for
