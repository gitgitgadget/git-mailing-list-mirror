Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B801C6F72
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727992534; cv=none; b=G7G4fLoINWSoJEiZZM3Q865KMGVMAN7EPDauu91vYD6pH/rmf53Cl9Tkl6cQXfyMv2EAa6E3fZZr3jZI6CpG5N9+W5/2UOjE5ThSwYie4aYYMypDqJy8utqiuzL5Bk9u6CTF4TRQecV/e2l8/rfNkjA/5fRQmAYVnlMJ5u3E4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727992534; c=relaxed/simple;
	bh=+Ij8FdL348/D5c4aUaeWKV+4FjA7AhD5U4TsoyhLsm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ijIlig9f04p5qwjENEqolzuhrMX1mu7hhsTt38zR3E7iM5JZdu3IpEp37ER6ZILQSZD75MYnI/4ZBZ+38rH5TSRDQaH6ahdBrSqftKb4UOTXwuQRxcbEc6F8ILg4zN+IcYxgZaQycCT8rt1ruTDaC5FCOkmc94S9kx5RLz9vWDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aOOuhdaa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZUe9lY09; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aOOuhdaa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZUe9lY09"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E65C11400F7;
	Thu,  3 Oct 2024 17:55:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 03 Oct 2024 17:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727992531; x=1728078931; bh=8oKZsORKZb
	y8tCuB0jSyJQu3vzk725fNqxsdWAYXR4I=; b=aOOuhdaa21elwrU5kaFTVdXTi3
	4YaNVcY50s7LgvuDSgTS4fEeHYFrOGawjZSJTpLkJaTBwir1KKTjr5JLik/Jl4sa
	V5zcT10gUrclRumb2h+74CUGjLa2cVHSDoWZNmi7/3ZdMJaGVFzxHUhyibE09379
	hjbHejP7OCdKrdppy4XPjinVfhiDfSlTQiLqZyUT33qZt8wjz8dxGOxjToBqbUEw
	ggPzsXguXIcHXFfLkeECV3NvlfaWIiCS/QXYKOk7n+BqVqaFGYihm4JrcOTmDg+G
	AuFl8aD7Oel3bY+wIhMC0ZzsGZ8zaXNHPIWxDqUtl7+KFaxBs+Ca9oXFTysw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727992531; x=1728078931; bh=8oKZsORKZby8tCuB0jSyJQu3vzk7
	25fNqxsdWAYXR4I=; b=ZUe9lY09+51iwiLvRbDpMS/FuE8aXrC73iogkS264cMU
	AKfUgj/pnUSGxnSFGtVyXpBTvXwiftriNuHc3YTj/NWtSK2n1HLxc48GDULlRrNu
	byuHRgTt3qFjb7iqsc97nm5PedJrl+TUJ2FUpQNX39s1NwTLDIiL0asUl4Ot4zEo
	XpITx2oVChkkxtHSdT1v9c77hqhCFERJxEIwvH00+7xofREGXdNLDy8JulHHjoKU
	2yNm0r9GDzrksQJ1joaghllva/HPvdcthymS803Ok/jRxGiiwyi0aIil08MWc3P8
	hjtQ/0KYWRaxkDBlt5fyees+vYBpMfjx+/UymlTPhw==
X-ME-Sender: <xms:0xL_Zr6scd5MkG8qDqRxIrJ7bUO5YaHWBQgwwfKUalyrhPCoXE4Sfg>
    <xme:0xL_Zg5dtyKe4_LlXeIS2yv2ttmNnSKKBFHs_K4N8EWp14ZJkWjxj4sgfFrs-9RC7
    TWMBXk-nWltOd4O1w>
X-ME-Received: <xmr:0xL_ZieL9WlMA4GbWIa8fSc3aVi7cJpafVvN6nh7ybIYniAQT39AJdfynzzVsY4WuGNR6gpqkx4gjmSvfWLK8tFBzh-fZ6An19DBv88>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvvddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhprghrrhdtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohht
    hhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0xL_ZsK1aBdXdN_3erJgj2DkPJ3c7-ExSoK4aICJatMavXDjlKq60Q>
    <xmx:0xL_ZvJz_RE04OulB7wCm468Y4megncYy-AcLMZn_Cks0Zj4mTp-6w>
    <xmx:0xL_ZlxmFJ_Yr2It2FJqxvAolMTkOXZnJPdWOd5EEL7H-ljluq_oOw>
    <xmx:0xL_ZrLOE6fnsesHRwY3xu9THzkr0QJcIGarvuXKxTzsumFhMzZk_A>
    <xmx:0xL_Zljbv7rny7s5NYhOt8Q0iVN51bq-UNncGetKaiYofl4jlvW1gjIN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 17:55:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Sparr <sparr0@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: Lack of system-level excludesFile
In-Reply-To: <20241003212451.GA12763@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 3 Oct 2024 17:24:51 -0400")
References: <CANp3UNBGd=jiSZyFSAdPjayvgHbP5SF4Dm-uCNwna_H16bRgRA@mail.gmail.com>
	<CANp3UNCXqLJmAj2Vc7jB+i9qRjfKzrri_Mr9VvG4J5tUR-1HeQ@mail.gmail.com>
	<Zv5SpewqUmlvhOl-@tapette.crustytoothpaste.net>
	<xmqq34ldjiup.fsf@gitster.g>
	<CANp3UNB_4_mcK4CV3WF7p3AWaLTK6qb13tS3imDBGU5XBOzG0A@mail.gmail.com>
	<20241003212451.GA12763@coredump.intra.peff.net>
Date: Thu, 03 Oct 2024 14:55:29 -0700
Message-ID: <xmqqh69shmwe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> PS If you want to get really wild, consider this: the exclude/ignore
>    feature is really just a proper subset of the attributes system that
>    came later. If we were designing today, we could ditch .gitignore
>    entirely in favor of a special "ignored" attribute,

Yes, this was brought up in the past a few times.

Both the exclude stack (in dir.c) and attr stack (in attr.c) use a
similar approach to optimize the accesses to the data for callers
that traverse the paths in-order and ask if something is ignored (or
has this attribute) for each of the paths they encounter, so their
performance characteristics might be similar.  It certainly is a
tempting thought and indeed is a big project, especially if you want
to keep some sort of backward compatibility ;-)
