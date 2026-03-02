Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D12630DEDC
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772475114; cv=none; b=IYmRO58WS8+KK4ylO6Y+x6ZeoPCNWD/3cioyVTnUcn1rU3BoDQWUT9pBqJ8wN3Hf4g6OIABL0rofxSmZpfOBSHcJFK9FqdroXG9QzlJJpOhp3Zklez5bAmJwLHt4AzEHMnvTUrNEXzBs8+1FGwySz1F7xGWsKmKc6zhH1bbHWxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772475114; c=relaxed/simple;
	bh=Luaa1A4vYBE8IlRHlYHhdECUW0rNaMfg3Fstausm0nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phcXKmrSOejUUK600BuXhey/JrTROwRdm54Rbs9qzfQuvmrus/TRdderAIdrAo11tOS2aEtDoS6Et4WSbooArFe4kMl/Y6uIo5wJSpxOmEaozhNA3qTaXbD0oc1RU7nqKblU7S6LRFeHX1C8WOpcIh/At0QUwCE1T2A+GEZ302g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DyrQ7pEm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N2ZfPxcB; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DyrQ7pEm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N2ZfPxcB"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id D31FEEC0107;
	Mon,  2 Mar 2026 13:11:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 02 Mar 2026 13:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772475112; x=
	1772561512; bh=EjkEEFlFMeAOCjklm4RaATNYh80BGrgIkdJjdvd9hu8=; b=D
	yrQ7pEmv2G7NOKYJ9tPGrYtzEQcLzKKll5vw+63h3ZqpPt+qj8/z53q2jvUoj8BC
	4pNUA9XNlyqwmBWtWbuc++fnVv9XqLD+eXJhABbAg+T3BKter96OLpIDMF+gB0T+
	1S9risoiguoAnVg32uOwaaphtalQJXLQ3goYX+N1ULnDQYze7VFGXf/5Yt3hcVLm
	AS9OcuGKYFJCUHrLDCZp7aZ9D9mDUdBENj2Pq9U5iRixxL9d8nIDhtj6K8CVjzUt
	scEY8nXpbXf0poU1T9mxqwTYqlJWb8pajUGceZzR9QMu8Da5QX5zsQRlaqC2eBhi
	Jd8lrMnOoBrYr97ot65FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1772475112; x=1772561512; bh=E
	jkEEFlFMeAOCjklm4RaATNYh80BGrgIkdJjdvd9hu8=; b=N2ZfPxcBuwBdQLwKa
	+9AOlanzoXr4Wop106+236zSH4AGZhvQpFwmvoksERZpLti9hNoHu7gm0OIcMh81
	p8XswW0r73cu92niCnY3L7LOwtYHX8KbV7eBuHQVFVQSBkCDzgN/jmsfbsZ19S5U
	g/DITKpISOFifkEIYFdub0z+DUghWcQ04CLFW279xBKycj36ZqUJthy+2Mrh1jqw
	Kh1UayYEHDIDD0r9y+rjRdgOrqukE4IbIP9yr0YFiVZT6eUE6XTp+XL6REqY3eWe
	wO1GxgWb81NHyb9pvKDC9BsMg+UkVyQ8U0SEVjbd6jtfdjbLDDtZOI1eQ3/5Uex/
	J/WrA==
X-ME-Sender: <xms:6NKlaUiUZ5QAnKPivol-OqxyTyV5gTbycFWl4iJUZViwPG3ldvvyfA>
    <xme:6NKlaZm5ftmiSagXdAjPHr5M2OceXyG_Wsj3IH9DcGZMGdfMBc30nkUmgEnLy9TEM
    MalUySMv3rGO8o65RU6N7a4WCYLnGSh94M6FnT67gTrM1AuXCPw>
X-ME-Received: <xmr:6NKlaQi1ZrBEm_mkAZOkVRHpPGap1raKfTEZncK1OFgpppK1R06I5tHKcM3HcScybBLwXf7kaxzCJ1eT88RUjhQklnNU3uTx8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepvdfflefhueetgfektedthfduleffudetleefieeulefhvdduieeukefhtddv
    udeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehstghhfigrsgeslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohep
    ohhpohhhohhrvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhk
    nhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthh
    hinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:6NKlacFFNWZWRt5Z_ivkLxgtUUiDbL-heJt2PP1r3Qdyq55-kRHjJA>
    <xmx:6NKlaSvxY2kk5dFAb1xl9wbbIiSZycmz1POEYzqp9oVAyau0wMZj2g>
    <xmx:6NKladfI4CBekTsNQ8Dvs5Ws7tf267Y2bRCDL-7OY7i_QiTYR9FJ5Q>
    <xmx:6NKlaYkWGyB-zci82OtIxLTG6wCgwP5GrvSyHwOM8ryPu76W63y7ww>
    <xmx:6NKlaWO_C_cRKv36oyOdQyO_MpP9Ml5ht3qAg0l9R8OyAWOg_Kl-gq7h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:11:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	"D.  Ben Knoble" <ben.knoble@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/3] sideband: drop 'default' configuration
Date: Mon,  2 Mar 2026 10:11:47 -0800
Message-ID: <20260302181149.3502811-2-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-549-g863838a955
In-Reply-To: <20260302181149.3502811-1-gitster@pobox.com>
References: <xmqqv7gcnwd4.fsf@gitster.g>
 <20260302181149.3502811-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The topic so far allows users to tweak the configuration variable
sideband.allowControlCharacters to override the hardcoded default,
but among which there is the value called 'default'.  The plan [*]
of the series is to loosen the setting by a later commit in the
series and schedule it to tighten at the Git 3.0 boundary for end
users, and the meaning of this 'default' value will change.

Which has to be called a horrible design.  A user expresses their
preference by setting configuration variable in order to guard
against sudden change brought in by changes to the hardcoded default
behaviour, and letting them set it to 'default' that will change at
the Git 3.0 boundary completely defeats its purpose.  If a user
wants to say "I am easy and can go with whatever hardcoded default
Git implementors choose for me", they simply leave the configuration
variable unspecified.

Let's remove it from the state before Git 3.0 so that those users
who set it to 'default' will not see the behaviour changed under
their feet all of a sudden.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/sideband.adoc | 1 -
 sideband.c                         | 6 ++----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/sideband.adoc b/Documentation/config/sideband.adoc
index 32088bbf2f..96fade7f5f 100644
--- a/Documentation/config/sideband.adoc
+++ b/Documentation/config/sideband.adoc
@@ -6,7 +6,6 @@ sideband.allowControlCharacters::
 	a comma-separated list of the following keywords):
 +
 --
-	`default`::
 	`color`::
 		Allow ANSI color sequences, line feeds and horizontal tabs,
 		but mask all other control characters. This is the default.
diff --git a/sideband.c b/sideband.c
index a90db9e288..04282a568e 100644
--- a/sideband.c
+++ b/sideband.c
@@ -33,8 +33,8 @@ static enum {
 	ALLOW_ANSI_COLOR_SEQUENCES    = 1<<0,
 	ALLOW_ANSI_CURSOR_MOVEMENTS   = 1<<1,
 	ALLOW_ANSI_ERASE              = 1<<2,
-	ALLOW_DEFAULT_ANSI_SEQUENCES  = ALLOW_ANSI_COLOR_SEQUENCES,
 	ALLOW_ALL_CONTROL_CHARACTERS  = 1<<3,
+	ALLOW_DEFAULT_ANSI_SEQUENCES  = ALLOW_ANSI_COLOR_SEQUENCES
 } allow_control_characters = ALLOW_CONTROL_SEQUENCES_UNSET;
 
 static inline int skip_prefix_in_csv(const char *value, const char *prefix,
@@ -62,9 +62,7 @@ int sideband_allow_control_characters_config(const char *var, const char *value)
 
 	allow_control_characters = ALLOW_NO_CONTROL_CHARACTERS;
 	while (*value) {
-		if (skip_prefix_in_csv(value, "default", &value))
-			allow_control_characters |= ALLOW_DEFAULT_ANSI_SEQUENCES;
-		else if (skip_prefix_in_csv(value, "color", &value))
+		if (skip_prefix_in_csv(value, "color", &value))
 			allow_control_characters |= ALLOW_ANSI_COLOR_SEQUENCES;
 		else if (skip_prefix_in_csv(value, "cursor", &value))
 			allow_control_characters |= ALLOW_ANSI_CURSOR_MOVEMENTS;
-- 
2.53.0-549-g863838a955

