Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC5619924D
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753138007; cv=none; b=W6dYOPQ8ztB5h1goxOva/cuyfc4c9PkO1Z9GvvQYyu44Qmda2AJJSclB3PZRcz/tiQy24jROCsgqnG29xR8KBQIAPiSu9pFvYoA5jJgpQe2Sucxdik1w7xfSiF6i79dMF7ZpoR3GRI45g4IFn/GUVG8thIzaexopE3F+JS/d5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753138007; c=relaxed/simple;
	bh=VXVAuvw5Da3hCiP67cVNttxKWPJoX+hcD4BC2fdcOMk=;
	h=From:To:Subject:References:Date:Message-ID:MIME-Version:
	 Content-Type; b=mxoaAfueUfbTyl/UB30BPDkPI9v7hlURbZIDqiY8TCTq+jG9zAtoUB9WWwbPM5248BtR3kZo8Rt5RwNN9npo73zi2yVBqusFPzlrVwby2glaaCQrJuwkjtKkUFayHEcBcmdX9pi3jEEsCD8mNkhcFlBzndW/JpB3NLIPn8Vjz+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MTWJghLc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OOMTbomZ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MTWJghLc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OOMTbomZ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 689F77A00E4;
	Mon, 21 Jul 2025 18:46:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 21 Jul 2025 18:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1753138004; x=1753224404; bh=Otsyry2KtUqUqJwW/asWn
	SHHPmRrFZWNae0y/kyEpkk=; b=MTWJghLcOnS8UhJ6/KOMs9eGqhwl7Ci2Dj8mi
	3ijX0T+uFH1nDLtktwlDEkLKZnDw2Vy7EUbMJ6ETr4FjTPdAbm3VztBbEg3FFclL
	/2OrYK44VQtkp/SijO3wW7M6HgYNfg+EUsV/VqxYiMIANynYny/NLrKbKQ1gz+Z1
	h7Cle0kqp69R94jNisyvusYFt8PBk76fXHxhk+FIucm3rM2x0jcKV2Xk3oiKpDWE
	jL+CJ/QL/s22YbwjUvCtG9SJrGPRXTjPuyUp0EQ93wGe2cws6SfDDKH7dDdQkgK9
	g+x0FGaVnq7fgCRPIO80l+6NwEYQCKcJJm+FwPLLwiZJ02GGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753138004; x=1753224404; bh=Otsyry2KtUqUqJwW/asWnSHHPmRrFZWNae0
	y/kyEpkk=; b=OOMTbomZ+dVc2+W+/BQqU8E0NpsyMxdl2bbFpJZVz4SVi5McJLF
	fXf5cnvEfTLWMrTZEYg+gsMA10WphRp0SMB6C/vXADILyJVxInnw+Vlsg431cLgm
	qVC2Zp7xJ8HXoYgTi9nxPLxw/g6TdBz2ftzXtrxqwQJvuRUmMeeZYZjtI/XyjA5L
	XeInz3+U1ihRNxep65x4RHAdne8oXr18p5HYqXWo53Kfk68oeVEygF3uVlW24NCx
	x7537maQ6bry2OxkAEAv+/UnCesVr6c6g9gPLdnU6uz4gyynw+Ro5x5WZFONKumc
	GuIcVDWc/wpl9FJtohNeMA/YY6Vk/2ga8xw==
X-ME-Sender: <xms:VMN-aBMVcduWDugQYU7Dma4zT_jzfOI1anbdAyQaTOR8DzhpsCtZ8g>
    <xme:VMN-aEIB4iN1BbbDHLP0FQ1TuIKoXSulI-ZYqXGTbZajv16EYUpDbXIAsPUA3SnWh
    6iuobW0Ydi1VB7WzQ>
X-ME-Received: <xmr:VMN-aCEeDuHiBPYwoeYRJ6swEk5rlDXt2SzRe2ORsJvPzMSaI9ForINSon1QqJ7kdW85DnUtTzc3tUWUJEsyfuxO6vqKOnzDMVctN2E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejfeefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufhffffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnheptdekieetuddttddtieduuefhhfdtuefhvd
    etieeljefgffejiefhveegffejveevnecuffhomhgrihhnpehrvghvqdhlihhsthdrtgif
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VMN-aMT3RtBIkYF1XaGGb8iM3HEQP9-I-D_3UZWArcya_VOVtArxOQ>
    <xmx:VMN-aOGBGW863UJsmBAe5x0L6GSYb6zW5GehagfNTUXDyaA1wnjttA>
    <xmx:VMN-aI8lje3O4c19PeZ7vRWha7MkFFnVloFP4PO6WkOmWpeSdREcww>
    <xmx:VMN-aIJvfUiSgHFtJuXYAXEYWdvYjYnsVABiehIPAdYmNml5Z4dmDg>
    <xmx:VMN-aDwW6fcvbzN2lhTdP4O7WmdUy4Y8x7_8yaHJ0ODj1SDzXhCEADY1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 18:46:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] rev-list: update a NEEDSWORK comment
References: <xmqqa551127o.fsf@gitster.g>
Date: Mon, 21 Jul 2025 15:46:42 -0700
Message-ID: <xmqqecu9w4a5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The comment was poorly phrased and it wasn't clear what it wanted to
say.  Strongly discourage this broken pattern to be copied and
pasted to other code paths.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Obviously, fixing this broken code is left as an exercise for
   readers, as a #leftoverbits item.

 builtin/rev-list.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git c/builtin/rev-list.c w/builtin/rev-list.c
index 2bb6360ec1..7549114635 100644
--- c/builtin/rev-list.c
+++ w/builtin/rev-list.c
@@ -658,17 +658,21 @@ int cmd_rev_list(int argc,
 	 *
 	 * Let "--missing" to conditionally set fetch_if_missing.
 	 */
+
 	/*
-	 * NEEDSWORK: These loops that attempt to find presence of
-	 * options without understanding that the options they are
-	 * skipping are broken (e.g., it would not know "--grep
+	 * NEEDSWORK: The next loop is utterly broken.  It tries to
+	 * notice an option is used, but without understanding if each
+	 * option takes an argument, which fundamentally would not
+	 * work.  It would not know "--grep
 	 * --exclude-promisor-objects" is not triggering
-	 * "--exclude-promisor-objects" option).  We really need
-	 * setup_revisions() to have a mechanism to allow and disallow
-	 * some sets of options for different commands (like rev-list,
-	 * replay, etc). Such a mechanism should do an early parsing
-	 * of options and be able to manage the `--missing=...` and
-	 * `--exclude-promisor-objects` options below.
+	 * "--exclude-promisor-objects" option, for example.
+	 *
+	 * We really need setup_revisions() to have a mechanism to
+	 * allow and disallow some sets of options for different
+	 * commands (like rev-list, replay, etc). Such a mechanism
+	 * should do an early parsing of options and be able to manage
+	 * the `--missing=...` and `--exclude-promisor-objects`
+	 * options below.
 	 */
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
