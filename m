Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653C61C5F14
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754001974; cv=none; b=rxAKl2NsLZuNyO7z2aFIDshsokgdzM5uPb5AxKoRZ0WKuFU1tqnr4exPlKt1cyWYVWRG4zOfrIJBZDO+Ge8LIjbUTyvjbBP1lVKC4FZQFRg9HZHHTKEEmFooN48uwa5AtBafWXn4oH3UXaXMXPME2iMbq4y+ZnciUknobnVQqsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754001974; c=relaxed/simple;
	bh=i1mN6EokDjAIEFLlYNGrPhmmO5AumdBm2FZLi3LC1y8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnoB0h21d6iK4TuGkClqJMfuVGvqFWSB3377htIDISfQ20RWPL7cu7vAo/ccTtvPayA3ElI4FB/H/4nZQO5MmSCCUad9pdF48Cm0pm8dwSIhGZRIub6nM3563JdtW4sB8JoanJFuc8BTreD8zQxvtAr7HOAPWXU2jj0R4Ez4TgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E57JGbm2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tg0izJqT; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E57JGbm2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tg0izJqT"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 651DFEC16C5;
	Thu, 31 Jul 2025 18:46:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 31 Jul 2025 18:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754001970; x=
	1754088370; bh=mRCcs44tbHH/4bskMHu5YvcrUvS31iWRdF3VFIfj+FQ=; b=E
	57JGbm2FDNDxvZ51eusA5InLajiyo6+Y/3haPfYatpGtVr4TmLBZSSBcZBMan5mG
	eyfkb9ctOOBgvTsRhyoRzGRliXb+7lYIdAh3rKwazXd4FekXxB/CfBunBpAQonmE
	yiQiCS67EXIGj2w1NjiIGaXkjy2zNau2HAv/LiGGeKXZjISxax7rdFEYgqxKpEuv
	kPI5zrAKiVpLUPn77m7wy9ZHLvUctAvVAiLjaovONcgVAID6cBQ0TvlmmLPuwIHc
	nlfrU+d9sYxFiEIGFgRG8BTqC9DjMbBAE8hxHOpAZe5lsZAxvt/NUsWdggXX8jZz
	GIaM0VTuduknmR38HCwiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754001970; x=1754088370; bh=mRCcs44tbHH/4bskMHu5YvcrUvS3
	1iWRdF3VFIfj+FQ=; b=Tg0izJqTBK7YUA6qIrnnlIwuR4qI9syC5C1+TvFKjBzm
	KlEYmsuYUGgMvBhs4Ne/pBPismOzvir9iuebI1Xw8iaU3luZbfGog4NejpZ/fcMA
	B1q1qhjaX3c03lE4M+tH8S+dh15tRaBOKcxlwKgLc9osbDsbrSI0z5VXNyXpOZMm
	Dbc+sSzaQC+Ko3z0Jjy8pdLQPt9SKbBjJTVz7KdHFQLaWGyVhIlLYUTfVGmGi1g7
	QCR7lDgQJ42CaV/CcV+qS7kJHZ+osaYRmIwotovZ4eamOQrt0pdQBQFEJjOG1Weo
	SaKxZawhgDrQRkuW0+RvzvPzAaIR2e8V0qTt+gMumQ==
X-ME-Sender: <xms:MvKLaLexUiIXCtoEOJEZ7ixkfa0XAUnQXd3e3Mq00YC6nLVqUzb7Gg>
    <xme:MvKLaBYL3aPrFtEvjMZDaOa1XJ9yv5JG-Txt3sUghRItzq2Sjpn58Zg4oc5tdUOtT
    E8pZA2wsb0omF5VQw>
X-ME-Received: <xmr:MvKLaGXFNdGoIsFAvpfqO0NXfQX0owVu2eqAdY6TbJubtQIZuYj8NuhMSW-ROTQNrb53S27ZM-1mJpOGUAm7ZZyj84UlGToOogSMsOU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:MvKLaLhHINyFbtOkmgtyjjDBFbop_gJmpodK472GZC_fZ0Jjz_w9WQ>
    <xmx:MvKLaMXEZQUAy4E4EYriSBe-h8BruONPGMUvGWQZZvbu2_e5hDuh9g>
    <xmx:MvKLaKN4TtKOY0N8tIImyY5Oh6ewm7A4iH5leraQ928lcRIphROfRg>
    <xmx:MvKLaAbH4U1tOL7X2143GGrOajHL66BPcVSiH0QpaX3l0xzcz5ZkWA>
    <xmx:MvKLaODUqbuV0es3DbwEc8k43uDGtQtQF4dSsnsx-gr-QMJBm920Kcvz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:46:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 1/7] string-list: report programming error with BUG
Date: Thu, 31 Jul 2025 15:46:00 -0700
Message-ID: <20250731224607.3942417-2-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-618-g45d530d26b
In-Reply-To: <20250731224607.3942417-1-gitster@pobox.com>
References: <20250731063949.1601669-1-gitster@pobox.com>
 <20250731224607.3942417-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Passing a string list that has .strdup_strings bit unset to
string_list_split(), or one that has .strdup_strings bit set to
string_list_split_in_place(), is a programmer error.  Do not use
die() to abort the execution.  Use BUG() instead.

As a developer-facing message, the message string itself should
be a lot more concise, but let's keep the original one for now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 string-list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/string-list.c b/string-list.c
index 53faaa8420..0cb920e9b0 100644
--- a/string-list.c
+++ b/string-list.c
@@ -283,7 +283,7 @@ int string_list_split(struct string_list *list, const char *string,
 	const char *p = string, *end;
 
 	if (!list->strdup_strings)
-		die("internal error in string_list_split(): "
+		BUG("internal error in string_list_split(): "
 		    "list->strdup_strings must be set");
 	for (;;) {
 		count++;
@@ -309,7 +309,7 @@ int string_list_split_in_place(struct string_list *list, char *string,
 	char *p = string, *end;
 
 	if (list->strdup_strings)
-		die("internal error in string_list_split_in_place(): "
+		BUG("internal error in string_list_split_in_place(): "
 		    "list->strdup_strings must not be set");
 	for (;;) {
 		count++;
-- 
2.50.1-618-g45d530d26b

