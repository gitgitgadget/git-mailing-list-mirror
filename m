Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1559D1DB12E
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759782077; cv=none; b=ZHlFvQWe1TlIqHNe82NYNaw9FIFOp9UXVZCjiLwnXIy3hHDu2z0xnQxYnzYqzwlJTNhE7BlO1IG2enny3CdUGdclyNRCyXEOkX1bxEi4HTtVIsifT9FaFda+tlVRGxuDptv4eS/6l9xKEdi2LsL5qficI3eAw8XA1/MKqjhpWgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759782077; c=relaxed/simple;
	bh=jHBrHOscUq2OE9R8yqXovk4eMCIfD3D5DF6dmJAT3FY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NphHa4oDnpEiNTJwNxqX1pZ9jyD3N0Ut+M6y9R61Fk7FP+Gd42ZEEXTObbVVe7b13iiKJFugepcaT4P8medXPkyIx8ze5lBlDXohtCOJbftnIuedvLcph0cdpH42aAuQ9e/KSsobuN2f/eKj35OB4EITY5KuMhG2fDo5cEa8mNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MRMSiQL4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QcAagvD8; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MRMSiQL4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QcAagvD8"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E42F3EC01A9;
	Mon,  6 Oct 2025 16:21:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 06 Oct 2025 16:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759782069; x=1759868469; bh=g8HYWbmOrz
	cwO4XDM50dcyJbxumxCA+ZWuCOE+3F6gs=; b=MRMSiQL498V5WqXmbgO33OKzS6
	p0zzpX/yelzofO5K/hR4SUZihgjFtk6onZeO2R7X69yzn4d1govF91yOqI7TBUwf
	f5kElHs5tXHvuZYSVOmdUvKs6Ss8jC7WN8CAwkGaiWIYqEWt2qbdWNjp6xYy4xmk
	oR9pByC+dRV+Ejj5UfMj8fBkXMp/QIPkXPhtoHlgi2aAosN+0ociX+bThYoSBBHF
	pwHM9T4ym2uz0LluumS1y9JKywmxLI8FZzQxSwjEu7blV5sthOsQcq/0YfxmqL9+
	dXvKv4r2lOu/on+svbZS/lrSJQ+tRModKncJcQSla6UbaY+T9XPVPG/vrXkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759782069; x=1759868469; bh=g8HYWbmOrzcwO4XDM50dcyJbxumxCA+ZWuC
	OE+3F6gs=; b=QcAagvD8BLyOAEcLreDItRuAAEiToHwxG6w8GsEXMyz37R6dVT2
	2EiGml6liiW9Jtzq44QWDtPIXpqBk/2LN2JFF+0ZNMH3lmlIm4GIDOrI+j9+e1ot
	P4A4Vfdjz13zgNwnbBr9LTJ/8bQPuslQYSpsCAPV3KsPrlC8y7yl/9HQwrfH5qhd
	k0B0cX0ktKLVXZ17jLf7ZiVJpCJnYIT/DKFCFfpuF9Tf0yqpPiryB0tHC6OUnoYk
	IrbbVUUTPXHW6TKRLT5zLu8A1amTRnKFDDTbwTV6dXomWj1hkxIG5FXwPW1RQ5Qn
	1P+/4i0LXQD9wgDsfron/XYZ1Gg8gFrzWOQ==
X-ME-Sender: <xms:tSTkaEW7jyBKySE044w-v6EhQ_RHDFNeLDAVtMlexfz8ETC1fg3XJQ>
    <xme:tSTkaE8677mTETS_yy3gyl_raU1eefw5B93VPP_Qz1UZZRO2EtXqiVjJ0pJyobZtx
    SB6cjyg52u2KGKa5Jo5stIQ_kNjolUZdvn3y4BbRPKQq24mml5dbzw>
X-ME-Received: <xmr:tSTkaM1ezp5f6IcqP65qm1ghY4r6z8RdEjUR3N476IzM_cL_wVVWxoLya9y6E9kDYyySVDzfIBcMXh59uCXWsNySid7DX9lgVE4l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehnohgrhhdrphgvnhgulhgvthhonhesghhmrghilhdrtghomhdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepthhhrhgrnhhurhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgrhhoshhsvghrrdhmihgthhgrvghlsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:tSTkaBegO7lI4IEmhxD-WbYnnDFTq5zQAkxQYAqO1fhh5lf5UbNYvg>
    <xmx:tSTkaLBzMqSweFT-ReByaI7uyVPQQBLEwxS974ZwbGr10kBYsbO-pA>
    <xmx:tSTkaA-GEp9PDUcPkJA5I5_IqUWmP9khbglm7QPckjmrRs_o8wqFXQ>
    <xmx:tSTkaHqTU4tEnsUdZmY8ANF_58OBgitR7Ej6RAdnNW-kmRuDv42ETw>
    <xmx:tSTkaEZLAkqK8K01-_8UvG1vcqraHQJciybBKz2VkOHE7j0TrbWakrKX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 16:21:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,  git@vger.kernel.org,
  Noah Pendleton <noah.pendleton@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  Thranur Andul <thranur@gmail.com>,  Michael Grosser
 <grosser.michael@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,
  Taylor Blau <me@ttaylorr.com>,  Matheus Tavares <matheus.tavb@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Calvin Wan
 <calvinwan@google.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Martin =?utf-8?Q?=C3=85gren?=
 <martin.agren@gmail.com>
Subject: Re: [PATCH v2 2/3] config: values of pathname type can be prefixed
 with :(optional)
In-Reply-To: <xmqqsefvol7s.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	06 Oct 2025 12:59:19 -0700")
References: <20250501214057.371711-1-gitster@pobox.com>
	<cover.1759094936.git.ben.knoble+github@gmail.com>
	<5c97f580a9e77c464bc6bf4ed9ea8546711c6637.1759094936.git.ben.knoble+github@gmail.com>
	<a687ec17-8ee4-428e-bae5-063716d59a08@gmail.com>
	<xmqqzfa3onxx.fsf@gitster.g> <xmqqsefvol7s.fsf@gitster.g>
Date: Mon, 06 Oct 2025 13:21:07 -0700
Message-ID: <xmqqms63ok7g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> We'd probably need a preliminary clean-up patch to fix all of these
> in the vicinity.

So, here is the preliminary clea-up step that should come before
[2/3]

--- >8 ---
Subject: [PATCH] t7500: fix GIT_EDITOR shell snippet

2140b140 (commit: error out for missing commit message template,
2011-02-25) defined

    GIT_EDITOR="echo hello >\"\$1\""

for thest two tests, with the intention that 'hello' would be
written in the given file, but as Phillip Wood points out,
GIT_EDITOR is invoked by shell after getting expanded to

    sh -c 'echo hello >"$1" "$@"' 'echo hello >"$1"' path/to/file

which is not what we want.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7500-commit-template-squash-signoff.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 05cda50186..4922543256 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -31,7 +31,7 @@ test_expect_success 'nonexistent template file should return error' '
 	echo changes >> foo &&
 	git add foo &&
 	(
-		GIT_EDITOR="echo hello >\"\$1\"" &&
+		GIT_EDITOR="echo hello >" &&
 		export GIT_EDITOR &&
 		test_must_fail git commit --template "$PWD"/notexist
 	)
@@ -40,7 +40,7 @@ test_expect_success 'nonexistent template file should return error' '
 test_expect_success 'nonexistent template file in config should return error' '
 	test_config commit.template "$PWD"/notexist &&
 	(
-		GIT_EDITOR="echo hello >\"\$1\"" &&
+		GIT_EDITOR="echo hello >" &&
 		export GIT_EDITOR &&
 		test_must_fail git commit --allow-empty
 	)
-- 
2.51.0-580-g8258b70b6e

