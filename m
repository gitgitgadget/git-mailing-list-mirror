Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A65819F13F
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753823013; cv=none; b=rMH+hpU250Ch2P5ZwDdFoQawhCigWISMQVY7S9sdKBo0b5e06DMz50LZHR5Ja/xMj1GPcDmeSeFeEHzXTNrUDqToVv+CSz58zO1k0UX2+PYbgxysQ6HHK5LLfdJN2CIoillOyWM29vMsLP2LTsU42sgsD5QupxiEcKa7gbjhBRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753823013; c=relaxed/simple;
	bh=/8OS9RN8NrlonOtSODIf2pUhn3LZ/mkLWKOkseN861Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rj6DWXWGTT50wCuPeftCayotBoOBcssphfSmXfRWSzTbY9kw9uYO7e0brcHNgdEhFhCAc9pORxG6Y1083tLQyb2hRKLuVccriIhpuT5TL8qQHBG0I2YZpBHV6lQLZ9+UeWd54I7ZXZmCd3Uxbn5kh56ZN7XX57wTFJAdSiuaEOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XA5opBmX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BnYzwFXq; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XA5opBmX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BnYzwFXq"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 3F1DC1D000A2;
	Tue, 29 Jul 2025 17:03:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 29 Jul 2025 17:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1753823010; x=1753909410; bh=BNh3VXNjc5/OjzN6jnteaRatjZVgd7EK
	rR1odT5V5J8=; b=XA5opBmX/I23+obmsKD6oEOxbke8Y8dS3pZTXwa+cto/yIpZ
	9+3YtM8QFjeiNf2ikI8NkFa6EySTX3vQnIFB8N67FbG1N6H8q0Q6fBrBECKMvhsU
	TRtY2X3hzd/Kn70+34BT7V9Ycy0I1HkiZ6ZBDyW4OBxOcA1O2SiiA194dDOVQTJz
	F57fzpHt0sxUKj7RY63rhn4btBuIhojS6Qk5tlcYZh1AxbiNScVLI5obmcX1vjg7
	c0NoV2YglVlQkJR7yi4/baYMO5JrCHfFLmLZ8gRAnFkmGQHTy6KSefztpHqrdDG8
	65bJx0TcyBviToTB4XfdxMTaYQShi/gp9EMtgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753823010; x=
	1753909410; bh=BNh3VXNjc5/OjzN6jnteaRatjZVgd7EKrR1odT5V5J8=; b=B
	nYzwFXqLPe/dLCPn/TE0sZ1lhTQGnaJAX2KDxgSmurhAlwvcf7gFatRQV2qn7fnB
	WLQxh2RCvWNiuv+ptZ5m7RsvYwuySjR0CbZyiVjcnslvf6HjvjNt92nhznVknCFO
	Xq+Ym7qyr/lqHYB3owBiTVA7GmzOsRKx0uKF2gdoXCkntrkU0Ee4r9B86HIm9fnG
	GjHy0RLV1qrQmMBM50vtIjhwqFUOafQBmrv7wYa6Y51YveuY0DDIWCejjyg6h4tP
	IBTY6l+dqk0XmiUWZ+GDGwQThQMb5JrdselkF2aMMoK0prjZbNOfH7JPajK0aRjT
	B+q4JXFKoFtF5hLBZ7r6w==
X-ME-Sender: <xms:ITeJaLNkhN6nvHuAI3E_PjXISYD4Yg99iGhTivQIeL2wDiD5pvPLEQ>
    <xme:ITeJaGKoJPTC63AIXW-sbfapVF8ruIWpJbPMQ-yMQ4-KAXnW9o3S0KFbF33ROQ2qq
    xy_xYFe8NH0gZu75w>
X-ME-Received: <xmr:ITeJaMEGFkE0ye6GjFbnVTt93qaUJrX7E4M47n1STZDaY6AcMX6bbF-yqv_p3PAWKIrnRZgcFFpFBrKjd_sU1eXkWbNCZsTf12eu2uE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeliedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgfgggtsehttdfotddtredtne
    cuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohig
    rdgtohhmqeenucggtffrrghtthgvrhhnpeekhedvieeutdekveelieeuvedtheevfeehvd
    eiveeukeefieeukeehvdfhffejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtph
    htthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ITeJaOTDJALj67-g36HsL9ETZEgVkdVv5obPfsfUp1fmdkBI7ZxvdQ>
    <xmx:ITeJaIErbt1LKDQwAuqwkp6d1KtH-kDkE02NlnEy-YNhKcNJ55C-YA>
    <xmx:ITeJaK8efxdNVT2ePc0zgEibgwNVe0Q3m8UElxzaQaj56AnA-dINvw>
    <xmx:ITeJaCJC1_PTFR_bRNhJpvAUItws9NJF0S-ZEe3Lps2I2rnwoX7fyw>
    <xmx:IjeJaNy1_P2AYcEvTYaeF3sEtWNiXoZLMoCbSCa5HrSnXy1yGuP-SfV0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 17:03:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] clean: do not pass strbuf by value
Date: Tue, 29 Jul 2025 14:03:27 -0700
Message-ID: <xmqqseieogkg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

When you pass a structure by value, the callee can modify the
contents of the structure that was passed in without having to worry
about changing the structure the caller has.  Passing structure by
value sometimes (but not very often) can be a valid way to give
callee a temporary variable it can freely modify.

But not a structure with members that are pointers, like a strbuf.

builtin/clean.c:list_and_choose() reads a line interactively from
the user, and passes the line (in a strbuf) to parse_choice() by
value, which then munges by replacing ',' with ' ' (to accept both
comma and space separated list of choices).  But because the strbuf
passed by value still shares the underlying character array buf[],
this ends up munging the caller's strbuf contents.

This is a catastrophe waiting to happen.  If the callee causes the
strbuf to be reallocated, the buf[] the caller has will become
dangling, and when the caller does strbuf_release(), it would result
in double-free.

Stop calling the function with misleading call-by-value with strbuf.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clean.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 053c94fc6b..224551537e 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -477,7 +477,7 @@ static int find_unique(const char *choice, struct menu_stuff *menu_stuff)
  */
 static int parse_choice(struct menu_stuff *menu_stuff,
 			int is_single,
-			struct strbuf input,
+			struct strbuf *input,
 			int **chosen)
 {
 	struct strbuf **choice_list, **ptr;
@@ -485,14 +485,14 @@ static int parse_choice(struct menu_stuff *menu_stuff,
 	int i;
 
 	if (is_single) {
-		choice_list = strbuf_split_max(&input, '\n', 0);
+		choice_list = strbuf_split_max(input, '\n', 0);
 	} else {
-		char *p = input.buf;
+		char *p = input->buf;
 		do {
 			if (*p == ',')
 				*p = ' ';
 		} while (*p++);
-		choice_list = strbuf_split_max(&input, ' ', 0);
+		choice_list = strbuf_split_max(input, ' ', 0);
 	}
 
 	for (ptr = choice_list; *ptr; ptr++) {
@@ -630,7 +630,7 @@ static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
 
 		nr = parse_choice(stuff,
 				  opts->flags & MENU_OPTS_SINGLETON,
-				  choice,
+				  &choice,
 				  &chosen);
 
 		if (opts->flags & MENU_OPTS_SINGLETON) {
-- 
2.50.1-612-g4756c59422

