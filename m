Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32EEE55C
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 01:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081106; cv=none; b=Ca9hNF1xE3AFO1jifmY8e6zfpUZc9s/dsiyeZc0HXTDLPtOJ2vU6qp5gDBL/BXYKmmk9Dh9IivCzX+w/230JE9qSAmdLPcCG966cXAUdhy/JPRK2cYznU7nvqjIeCNYee3OgFjqHFPQtn8m9zWViVlBvH9PjlkDODOr3txE5iN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081106; c=relaxed/simple;
	bh=7bUHjWGBvk+D1g4vuapZy+X4SOSWNwoO6yWcllyN9AQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g0E9lreD5izNNCeg7dZIRIeOCM8PR6VkfWNzvGLr/IEEO33qq0gtNEPkIktnH2UFQo0zGSES30wVxOfl2sSZBkG4qdlSbou68QdmhMhX2KRanpIh49yRiQ31u8i1tHi9ojualeBxQcGYlQRPPYc5CM97/OtC2SH1CW8A89fHtt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lAtavySA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uf7F2x7X; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lAtavySA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uf7F2x7X"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 325161D000AC;
	Mon,  2 Feb 2026 20:11:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 02 Feb 2026 20:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770081102; x=1770167502; bh=Le2UhMPfxT
	wFUiyTgVdcd6UG0N9i2BDY5zD9Dxtdmfs=; b=lAtavySAQIMEr5k4Uf3cZVze+o
	Lgo0UpCwVNUwSCObCbdof/DwFXhWRFTtRQcisNBcRu854HMJsBgJzlXetWgs3oEI
	+fIpRpUYLYyE6utdmpvMix1mAKd+n+JxNcBN8ANhPc7w4uzbhPZDJAGRHp3qB+bi
	qFVzO/HargsO06npORGYMBZcvUh9qJjyeVt9cV3hO7y4GZKJQGnAwH/d/fq/kQwX
	GVsUXXZ6VeDKYjaZONr2pbu6rGneajV6nIlzt7mwb4w4rohRm0gtFCP6LOtgWQkj
	XkdR7L7yBQZn/llvG/V0Re6l0jP6e87WJmb532iy9VOXjApFPi3kC093TKYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770081102; x=1770167502; bh=Le2UhMPfxTwFUiyTgVdcd6UG0N9i2BDY5zD
	9Dxtdmfs=; b=uf7F2x7Xzz4TLZEIy4RvZtXlYxl/NpGV2QcpXauEQIalCxf4mQH
	iHneDJso+3zH9rHES/Mrg3wzCak7sreOb2rl6rZnFE0LFWJ33YhdKec0EN/vPGWK
	MyJIJrHVB99nA1VpJDyf6v8r8tjE4FdrtBCul795Lsg9oeojiPkRnPbAUMWa4Jzt
	F7TvTZ/gVPGVZG2lwmPU1VWiP9QeT70tq8sduJAc520LFON45wlRbn59qDV+MyJ3
	M+i/z+v3C3ArJHEdh5ffMH5wssiWtTQtddH2h/M7sr1I6rz7eZGhsb+syabO1t+H
	66IXuKMj600lyg04kiwPDsabhzxajnAHLaQ==
X-ME-Sender: <xms:TUuBacTi6koR-DxO4MW-qTA0cTAf9AaDaCCAmFGSb7HvOvU1I7SFLA>
    <xme:TUuBaWWMOmrJ7TuyDeS3img11EgSFtCifvCCxkzIxK3GQ8TG63EOblMFZai5BLKYy
    QmUS-Rs2fjPvTahCPAbIVhihPxUpwF4cqY53PiGvaW3_BQsZ4cgOw>
X-ME-Received: <xmr:TUuBaeS90ksGeaol30QhyaW01xuzpEK68yEFom_pR6gWU2m8gVsfKkjrw9ERA9pKAg9T5hE4Y7T4HDs2_2OEIaIo2bLaHvqs-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeeludejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthht
    ohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtph
    htthhopehstghhfigrsgeslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepohhp
    ohhhohhrvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrsh
    gthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:TUuBaW2z-pXR4uHChxXO2xASVlezh3hcHqf3wapfPawwS-kWHMn_gA>
    <xmx:TUuBaWcrjGMBv3hh2KeKII7iyMKtk3bNn7c9iAzXGq3HodZcjGuBfA>
    <xmx:TUuBaWN8o38AR_G2sFY0TjMUXwjxOqyOTfJfnBzIPJqp0Nohdzy3Rg>
    <xmx:TUuBaSVRYVNlSOa8VKNLgaabbDfaXiwChOmjWjIjURHk8MXLRW5t5Q>
    <xmx:TkuBaT8vuji7SMLLkOEGwU9YzX7MehafZ7afxHjjyjeGEgArEauCmaP_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 20:11:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>,  Andreas Schwab <schwab@linux-m68k.org>,
  Ondrej Pohorelsky <opohorel@redhat.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
In-Reply-To: <aWlz-0AOlsFLaBO9@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Thu, 15 Jan 2026 23:10:51 +0000")
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
	<pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
	<fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com>
	<aWD2x154F5f-c3pL@pks.im>
	<aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
	<20260115211448.GF1053259@coredump.intra.peff.net>
	<aWlz-0AOlsFLaBO9@fruit.crustytoothpaste.net>
Date: Mon, 02 Feb 2026 17:11:39 -0800
Message-ID: <xmqqo6m6vdf8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2026-01-15 at 21:14:48, Jeff King wrote:
>> Is there any reason we cannot introduce the new functionality as a
>> config option but _not_ enable it by default?
>> 
>> That gives people the tools to protect themselves if they want to bear
>> the potential cost. It just feels a shame to deny them the tool because
>> we can't agree on the default.
>
> Yes, I think that would be a fine and reasonable approach.

Absolutely.

After a few weeks, however, nobody seems to have stepped up to help
us move forward (unless I missed a patch or two, of course), so here
is my attempt.  To be applied on top of Dscho's 5-patch series (v3)
that ends at c5b95e19 (sideband: offer to configure sanitizing on a
per-URL basis, 2026-01-16).

Thanks.

--- >8 ---
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 2 Feb 2026 17:06:03 -0800
Subject: [PATCH 5/4] sideband: neuter the sideband filtering

To prevent breaking settings that are working well for existing
users, tone down the sideband filtering feature and turn it off by
default.  This hopefully matches the way how distros like Fedora and
RHEL are shipping this feature in theirs.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/sideband.txt   | 14 +++++++-------
 sideband.c                          |  6 ++----
 t/t5409-colorize-remote-messages.sh | 12 ++++++++----
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/sideband.txt b/Documentation/config/sideband.txt
index 32088bbf2f..d2cd86fa60 100644
--- a/Documentation/config/sideband.txt
+++ b/Documentation/config/sideband.txt
@@ -1,15 +1,15 @@
 sideband.allowControlCharacters::
-	By default, control characters that are delivered via the sideband
-	are masked, except ANSI color sequences. This prevents potentially
-	unwanted ANSI escape sequences from being sent to the terminal. Use
-	this config setting to override this behavior (the value can be
-	a comma-separated list of the following keywords):
+	By default, control characters that are delivered via the
+	sideband are all passed through.  To prevent potentially
+	unwanted ANSI escape sequences from being sent to the
+	terminal, use this config setting to override this behavior
+	(the value can be a comma-separated list of the following
+	keywords):
 +
 --
-	`default`::
 	`color`::
 		Allow ANSI color sequences, line feeds and horizontal tabs,
-		but mask all other control characters. This is the default.
+		but mask all other control characters.
 	`cursor:`:
 		Allow control sequences that move the cursor. This is
 		disabled by default.
diff --git a/sideband.c b/sideband.c
index a8cd142cd7..3d8534671e 100644
--- a/sideband.c
+++ b/sideband.c
@@ -61,9 +61,7 @@ int sideband_allow_control_characters_config(const char *var, const char *value)
 
 	allow_control_characters = ALLOW_NO_CONTROL_CHARACTERS;
 	while (*value) {
-		if (skip_prefix_in_csv(value, "default", &value))
-			allow_control_characters |= ALLOW_DEFAULT_ANSI_SEQUENCES;
-		else if (skip_prefix_in_csv(value, "color", &value))
+		if (skip_prefix_in_csv(value, "color", &value))
 			allow_control_characters |= ALLOW_ANSI_COLOR_SEQUENCES;
 		else if (skip_prefix_in_csv(value, "cursor", &value))
 			allow_control_characters |= ALLOW_ANSI_CURSOR_MOVEMENTS;
@@ -125,7 +123,7 @@ static int use_sideband_colors(void)
 			sideband_allow_control_characters_config("sideband.allowcontrolcharacters", value);
 
 		if (allow_control_characters == ALLOW_CONTROL_SEQUENCES_UNSET)
-			allow_control_characters = ALLOW_DEFAULT_ANSI_SEQUENCES;
+			allow_control_characters = ALLOW_ALL_CONTROL_CHARACTERS;
 	}
 
 	if (!git_config_get_string_tmp(key, &value))
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index 1d039cbdaf..47bc8bbef2 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -107,7 +107,8 @@ test_expect_success 'disallow (color) control sequences in sideband' '
 	test_config_global uploadPack.packObjectsHook ./color-me-surprised &&
 	test_commit need-at-least-one-commit &&
 
-	git clone --no-local . throw-away 2>stderr &&
+	git -c sideband.allowControlCharacters=color \
+		clone --no-local . throw-away 2>stderr &&
 	test_decode_color <stderr >decoded &&
 	test_grep RED decoded &&
 	test_grep "\\^G" stderr &&
@@ -122,7 +123,8 @@ test_expect_success 'disallow (color) control sequences in sideband' '
 	test_grep "\\^G" stderr &&
 
 	rm -rf throw-away &&
-	git -c sideband.allowControlCharacters clone --no-local . throw-away 2>stderr &&
+	git -c sideband.allowControlCharacters \
+		clone --no-local . throw-away 2>stderr &&
 	test_decode_color <stderr >decoded &&
 	test_grep RED decoded &&
 	tr -dc "\\007" <stderr >actual &&
@@ -148,7 +150,8 @@ test_expect_success 'control sequences in sideband allowed by default' '
 	test_commit need-at-least-one-commit-at-least &&
 
 	rm -rf throw-away &&
-	git clone --no-local . throw-away 2>stderr &&
+	git -c sideband.allowControlCharacters=color \
+		clone --no-local . throw-away 2>stderr &&
 	test_decode_color <stderr >color-decoded &&
 	test_decode_csi <color-decoded >decoded &&
 	test_grep ! "CSI \\[K" decoded &&
@@ -176,7 +179,8 @@ test_expect_success 'allow all control sequences for a specific URL' '
 	test_commit one-more-please &&
 
 	rm -rf throw-away &&
-	git clone --no-local . throw-away 2>stderr &&
+	git -c sideband.allowControlCharacters=color \
+		clone --no-local . throw-away 2>stderr &&
 	test_decode_color <stderr >color-decoded &&
 	test_decode_csi <color-decoded >decoded &&
 	test_grep ! "CSI \\[K" decoded &&
-- 
2.53.0-162-gcda875bd0b

