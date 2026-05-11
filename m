Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F04B672
	for <git@vger.kernel.org>; Mon, 11 May 2026 03:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778468596; cv=none; b=QQd4uEJr8lRV2gskVwABjDuoecbebEdohTQ4leVXoGnARs6oERhde6vkjJIguOMDAPOYOtRFyHmtyS0WXjqVdT2VZkzECHGmwMdAepSC8lzq9wMehIaNsXUGWZZVWgLwmdNb+7PmAE68jBZLC0JAwt1DP/pdaMkCYJDtbtdb8VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778468596; c=relaxed/simple;
	bh=L0y6HTTuDN+iHMfUVIzQxQzF//qga6phdSKyEOeYuC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h5pDxBkzJp//8cTZd5Ln2x3hNwNWH5Op9b+jWxb81uU3GlLEnz329JJZkWh9IGfoUJhR2rYmkSPGpoY93mORK8WFCSgk+Z8uyZapUYoKujioXd6VF9x3sk/4cFic68ITvxAIIPi0Dj+69zzUUQ1UrOfHo+/kG+V2s8FL5CEGyIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HnHZwVpT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u3t0iKK6; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HnHZwVpT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u3t0iKK6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C1CA37A0025;
	Sun, 10 May 2026 23:03:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 10 May 2026 23:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778468594; x=1778554994; bh=FrW2agnkjA
	9FV3sqD6yR+lyGdB8Uwqhh9j+g64ryLaQ=; b=HnHZwVpT5rWWBvRifB1a2ky6pg
	kLhu9tZy0eADkFi9cElrmNuxiJHffC/Yi2Zpml05ElnVRJhdCvBgTVOhBjOH3z+k
	ZnDiR+A52466/bZdu5ltLkSJto6PPRxPOR9PzWlS6rY9X8hKTQeL/5JGoHpJ76MM
	4liATjEGfTKtHRjXSn9MAD7wAafKnjhiH/H6nmFzjhEXsu+YJLu0kuP+Qk8L9bH/
	VvxN7USu+nETKmf79D3VrzzeS8SkonqrbL2MIBsZbzd7g1f8Vby9PdzdTsqe3Azj
	MeQV6Qk/C8Kgv4ltFIA5/PvJQYfxkLeEHn7ipPKRYqmaLKObg4mtZfCOt/Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778468594; x=1778554994; bh=FrW2agnkjA9FV3sqD6yR+lyGdB8Uwqhh9j+
	g64ryLaQ=; b=u3t0iKK66o68ExtN4p80/JFbQY38xJn12bP884pdAdmMc2zPYvk
	p9/z8sXb8/JacQGXo4BpxxlncARBA+eNOPdL2ImpbkQmvGJGpPpmEpjXFpKvAAJ4
	MYGhiK4t+MG3FXeli1cEetcNU/ATYH24NjD/qllxLTUOMrDcv4x5p42inbBOAud9
	dGy1SElTyfr2KL9zHQ7xcbUmo0KhlJDqr8CB2JvJzfjg4Ja00uSC4uL3bU10g6HM
	fEswqkhOmniDfdme1ZeY2v+8Z+WPD4VsBYu8INg7S97RnsAhMbedxLLpR5eTCrh/
	q4LrGoruTzfLSGztv/MoZtH62qmoVHIT/ow==
X-ME-Sender: <xms:8kYBauyDPIpo35PByh-cayZzqvp3WtluolroLQGvCi3aKPr0r0CuUA>
    <xme:8kYBahIaB5sd-JLcew8aqdOwNyYIfO1TZaWVkRa-cI1tmmHXDWznYiaWW9VYv_Byw
    VuDC0M1LZnvB6FHcGZ3lV2qBzOBm5-xgFUG6xuR2JzUYJYaY-tsiLo>
X-ME-Received: <xmr:8kYBaorYHKtsMcQ4dtCYaZlxWcI9JPrSXbZHfNsB7EGj-KNJO1mTBpgQABE4OBPmkj1NtFg63eWS39rJmOr62j3myugIcjfzGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfeelsegsrghrrhhoihhtrdhshhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghplhgrthhtnhgv
    rhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8kYBagJZrZbG70XX4bVorA_AxEjqLPLu8OeYsJuRB829writ2ICzYA>
    <xmx:8kYBatRutOSSsWv0sCx3pg-xHi3YkF8WKXTQ6aGQwrXvZTzpx3pq0A>
    <xmx:8kYBavsB0oP-lyDIVPnDtPQqbrbTWxA7WNC561cP46-0YwIeZAmwjw>
    <xmx:8kYBauahz6GU7X_hdmRk83SIOwCreSU2LDWTT-g5r6OlIIAvU0wAOg>
    <xmx:8kYBauMEXQck37xlyX7ypUh2r0K--bLa7ItbcHsNSCHlkbIFS-jaJnN->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 23:03:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiamu Sun <39@barroit.sh>
Cc: git@vger.kernel.org,  Aaron Plattner <aplattner@nvidia.com>,  Karthik
 Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 00/10] parseopt: add subcommand autocorrection
In-Reply-To: <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	(Jiamu Sun's message of "Thu, 23 Apr 2026 10:37:50 +0900")
References: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Date: Mon, 11 May 2026 12:03:12 +0900
Message-ID: <xmqqcxz2tzpr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiamu Sun <39@barroit.sh> writes:

> Git currently provides auto-correction for builtins and aliases, but
> lacks this functionality for subcommands parsed via the parse-options
> API. Subcommands are also commands, and typos will occur, too. Like:
>
> 	git remote add-rul
>
> So, this series introduces subcommand auto-correction.
>
> By default, this implementation enables autocorrection for builtins
> with mandatory subcommands. However, for those using
> PARSE_OPT_SUBCOMMAND_OPTIONAL, autocorrection is skipped to avoid
> misinterpreting legitimate unknown arguments as mistyped subcommands.
>
> To allow builtins with optional subcommands to explicitly opt in,
> this series adds the PARSE_OPT_SUBCOMMAND_AUTOCORRECT flag, and enables
> it for git-remote and git-notes.
>
> Additionally, the existing autocorrection logic is extracted from
> help.c so subcommand handling can reuse the same config parsing and
> prompt/delay logic.
>
> Some string literals are also combined so the full text is easier to
> grep for.
>
> Changes in v6:
>   - Adjust existing tests to fit subcommand autocorrection behavior
>   - Change the similar subcommand hint exit code to 129

I've been carrying the following fix on top of these series since
Apr 23 when the topic was merged to 'seen'.  Can you fix these up at
the source, so that we can move forward with this topic?

Thanks.


diff --git a/parse-options.c b/parse-options.c
index a1258134df..1a5feab5dd 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -647,7 +647,8 @@ static const char *autocorrect_subcommand(const char *cmd,
 					  struct string_list *cmds)
 {
 	struct autocorrect autocorrect = { 0 };
-	unsigned int n = 0, best = 0;
+	unsigned int n = 0;
+	int best = 0;
 	struct string_list_item *cand;
 
 	autocorrect_resolve(&autocorrect);
@@ -657,7 +658,7 @@ static const char *autocorrect_subcommand(const char *cmd,
 
 	for_each_string_list_item(cand, cmds) {
 		if (starts_with(cand->string, cmd)) {
-			cand->util = 0;
+			cand->util = NULL;
 		} else {
 			int edit = levenshtein(cmd, cand->string,
 					       0, 2, 1, 3) + 1;
-- 
2.54.0-170-g88022b8681

