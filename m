Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7529CB3E
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947724; cv=none; b=MLct9ypGpwW6+pvAxqzkSJz8ndqwAEDpG+yj8n9T17OCaDRY4YtdC/UjLVvGfJ4TFWCOq28xeU+r98z/mOL9h5xDMrq4Yh10RKYJalYpZblspMYbUbAOTd+5kNGRzxkSOCK1HOlefnkzplLUz6K/zkd91Trgu7b7V7lgI4ZugP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947724; c=relaxed/simple;
	bh=/8OS9RN8NrlonOtSODIf2pUhn3LZ/mkLWKOkseN861Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoQEtBE8+Crxg3QJhLCbn49T/VlJVrNy8e/XkE6bDdq+JjnWi3oK30tVwRStNV0dm8ZnYEcvHH6a6ktX7+ZeMXrjlum/LGsfk2+2mFnchpk+q7azkJynCgnmVc3cjyMS/n2tAf8s8kOS+d2X6KNiZP9TSQG2qPEvKlC4Ia1mJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MlWtc6XZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lhFoN1O3; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MlWtc6XZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lhFoN1O3"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 3673B1D00DFD;
	Thu, 31 Jul 2025 03:42:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 31 Jul 2025 03:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1753947720; x=
	1754034120; bh=BNh3VXNjc5/OjzN6jnteaRatjZVgd7EKrR1odT5V5J8=; b=M
	lWtc6XZxP9yetzb32u1edvM5Cz0KuvpUFYXLotqCwrtmMqKd+SjpeGQGGrAePKGy
	ReoS9wHCWw3W5ffhqcM5A6i/GYIMlFV4le7h2+wiuyhZgKaQFavENyyJNLC1tYpH
	ANOMqb/McvyDhH9oAe1d8GAd7CBpmXNhEEzMBrXRIg208kIFADKpKfmdQOfGrmZQ
	QPTce27p7mbtxiVHdlL6sa3e24pyvw4UMJJiXbA4j0aTtZut52VY7RsXm4OoSj5G
	f6f7NZR2+TQIjJCY7DcVie1XtI9d7szbeVxxOEfciSRvbyScaD/zNtXlJ0dshQdp
	/XlgCcoZUe7sXWXJ9cH1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1753947720; x=1754034120; bh=BNh3VXNjc5/OjzN6jnteaRatjZVg
	d7EKrR1odT5V5J8=; b=lhFoN1O3eO69obs8muQIIuGemNC3fs5bnbpG4FYZMf4T
	EBjzbjhnFkkdsnAOkwhdYdAbu39uVbdS4l0B7Gcm3truPmwzXGeU1dcsdan4a6RL
	+ioAwVxi82rvjL5/mklOzUwdqEpab4VfUY/arMde7gt5P02q4L/EzqQDqTZig+B8
	Igoeb6Dq7ClD/c4rB6JD/HD+hq5bhUpu3+cNPzuK7OeSKKj+4UQpxTNireWrSB77
	fJyXAlcTYkDU3vavnvGVfMajKkMQaC76eFKueo8/rlT68QSBcYghqUUleujXbpbK
	Dmcszuk2nUZPvvTz9BNvneGXnplx9oNh2qncLDMluQ==
X-ME-Sender: <xms:Rx6LaK6SrXf27VGYshWNiT6DbYkp8Z5cyCNyKOmIlbPeIH5xhzDKHA>
    <xme:Rx6LaEG-YDd7CJcwjyUJDxrRKKj-IyE0gtai0nYU9SYNHyklaU-7JC3rvSIIDjTnx
    K0SBFqcMfZxf1LdrA>
X-ME-Received: <xmr:Rx6LaLSw5WixlTbmHpzpYp2n532h1aQg_r4UqnoVvPQWn1-wVl2q0rOAHiA0uBc_vpuo5BcEVGQ6B8Nv0hqDyJbjG5gSl2iSkyzQApU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:Rx6LaFtyRO6pS_lgHYgP-tSwu0vWg__kxkUOJRIeBX_e4UT40Sg3RA>
    <xmx:Rx6LaCxeXuWNiYciPhsUdcRvkhtos5ULr-XkGmy4xVALrRxM_nWE3g>
    <xmx:Rx6LaH5T7kXLN6uBUEJI9rCTuCYJ5eqkslXzBCU6ozwaUj5E7q0xkA>
    <xmx:Rx6LaEW4dtObc4rLjx3OdeMviH5OFyoa89rKpGkNFu8BU9xvXcriDw>
    <xmx:SB6LaFd9swLrnp0wUgMxlFZ_C-V9R8H7DFt5wsBdB-ZvXfvMOPqNEnHU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 03:41:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/9] clean: do not pass strbuf by value
Date: Thu, 31 Jul 2025 00:41:47 -0700
Message-ID: <20250731074154.2835370-3-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-612-g4756c59422
In-Reply-To: <20250731074154.2835370-1-gitster@pobox.com>
References: <20250731074154.2835370-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

