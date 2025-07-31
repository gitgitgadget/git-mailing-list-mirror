Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A286227FB18
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754002486; cv=none; b=ff9ZKtHlMNYLNe1SVuIhThkr8zx/yZb9QSsWbj1v1kCciwhsSFsahcQDAJlANnI/5Lm2bBNVVwxiTj0XNYJf7xNteI6CxBSbmOCijRq/elkG3UnO1NUZUkQfAhHD2gBPS8xLxZjsy7xqqb1Bj2Uq1mkeActPML6sbDs9MlYuDjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754002486; c=relaxed/simple;
	bh=Is+tASwm+nBwpN9gYdwroR4PInggfZPktXpn9O3Ynkc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbNU0Hq10q+/Mb+f2wgQsbKbKayG8kJzUTqbXwWeyYLcnl8W9GZNPpLCVjV+KyOGQKGIim9G0RRMhPxRUUmO8mPhYBKOoatymAoNuSHNtdfl3a/3ZvFSNeSDbdpJ5sr48OjjVfrUgcakY0xDfo4Dpdb7quSvnqAT5E+Rw4uIzCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MMGJSwzG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZLcDdS/L; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MMGJSwzG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZLcDdS/L"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0CA07EC1560;
	Thu, 31 Jul 2025 18:54:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 31 Jul 2025 18:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754002484; x=
	1754088884; bh=U7bXJVIIL6JPlu1oeOyjSeCkD+FN/MJd4q5D/ziYCoE=; b=M
	MGJSwzG6jK4rqntBOA61MB8rNsLkCPFDcuyk+l9GK8kwKUGrDWhctXAJgE6uLgON
	MtG46f5nYNjqsHjEum5m1b25PWo3C2EPS/t9G7HZFEfmoLD+iAYR2xi7KLIF1ARw
	Vt5z9Ie59uFcegJ4wqvN/XZtK20VQKDaeaSgU3NiIaBZIEnJ8KWWDgaEQbgaZItu
	RE+ixzOb3JlbVrcfw2nOdYuIx3Iw9JNz4+SFuC16tGSL4Wd0Tbw/FKN1pmOOgZzk
	Typhk00N24YzeZWhnapEJ6G8ec+831Idr7MoMfdF+5VkArz895MgUF77AZ9m5Ec8
	LyTE8/tqVQFiv/GvqUDrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754002484; x=1754088884; bh=U7bXJVIIL6JPlu1oeOyjSeCkD+FN
	/MJd4q5D/ziYCoE=; b=ZLcDdS/LWG7qDDzf2If+hBllEe6QMOIJv7i5Sx5m/c0f
	/Lwlfa6yuOx8xCTLijlweveQyk3yvnTxQRpr8MV59sK+oMdOZzHUy68Vt/d0Ft5/
	zUH1zhMbi62fKVTs5q9YzoZmcemG/pzYzYWm/D5GNewnGZ/j4lRvaod4URzJ0zns
	jMppYn7/SP4tXc1wl3J/l7ETFiTczBEIrHsOXtZl18hBnfiOvPkbWnIyURflORcO
	nIAnXiaBNnMnjtM+rwZj/DqO7hunOcwQTroG0J91xYQr1hRWMg/Qy2fblVptQEiU
	OiAJfZj8GP3OLme8vzMPT1mofHKdaO3g3e+T4aVWjQ==
X-ME-Sender: <xms:M_SLaK3huE61UXssK1Z_e4wgBwEg_Ts70DQxqcb2pCaE9cVCHN4qDg>
    <xme:M_SLaNR6PuX5u6bygEsITZqrqEY3MOjHopWTd-kAZu-6bsYewRQfUUvarf9yVQjuk
    2LhX6mcPQzOUrv0RA>
X-ME-Received: <xmr:M_SLaEsNP_kFKUnDhOHs1uox4hY-hlMkq0DVN8GhDNMPjRWlmMQ9rOlS6LRx0mjTQ6CQX93tSwNj8GiOngtvMkYTmmeYjs57RpbIl9I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:M_SLaKaItPrDsYBn6i2Fe9EC4c8ZBwaYHLhhz4dmVM5X-fN4YPV3tw>
    <xmx:M_SLaBs-Q3zMMCgaeqlDDyWYa5wTel_Gy2SADT0JoW26P4PaUZUtDA>
    <xmx:M_SLaEFm5tgUlmA8Px47NM88l5JrUM-WPkaILOsMAbibm1ckq_9d9A>
    <xmx:M_SLaEznta1S4g_eBxJIbNi-6lsxUnlH040dm63nDj1crjErhX_W0Q>
    <xmx:NPSLaNY3pZmIsH9zlqIxNHRWJLOgHHdrm40rvTu0nr20iVkzE9zPfLOR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:54:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 06/11] notes: do not use strbuf_split*()
Date: Thu, 31 Jul 2025 15:54:28 -0700
Message-ID: <20250731225433.4028872-7-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-618-g45d530d26b
In-Reply-To: <20250731225433.4028872-1-gitster@pobox.com>
References: <20250731074154.2835370-1-gitster@pobox.com>
 <20250731225433.4028872-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading copy instructions from the standard input, the program
reads a line, splits it into tokens at whitespace, and trims each of
the tokens before using.  We no longer need to use strbuf just to be
able to trim, as string_list_split*() family now can trim while
splitting a string.

Retire the use of strbuf_split() from this code path.

Note that this loop is a bit sloppy in that it ensures at least
there are two tokens on each line, but ignores if there are extra
tokens on the line.  Tightening it is outside the scope of this
series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/notes.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index a9529b1696..4fb36a743c 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -375,18 +375,19 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 
 	while (strbuf_getline_lf(&buf, stdin) != EOF) {
 		struct object_id from_obj, to_obj;
-		struct strbuf **split;
+		struct string_list split = STRING_LIST_INIT_NODUP;
 		int err;
 
-		split = strbuf_split(&buf, ' ');
-		if (!split[0] || !split[1])
+		string_list_split_in_place_f(&split, buf.buf, " ", -1,
+					     STRING_LIST_SPLIT_TRIM);
+		if (split.nr < 2)
 			die(_("malformed input line: '%s'."), buf.buf);
-		strbuf_rtrim(split[0]);
-		strbuf_rtrim(split[1]);
-		if (repo_get_oid(the_repository, split[0]->buf, &from_obj))
-			die(_("failed to resolve '%s' as a valid ref."), split[0]->buf);
-		if (repo_get_oid(the_repository, split[1]->buf, &to_obj))
-			die(_("failed to resolve '%s' as a valid ref."), split[1]->buf);
+		if (repo_get_oid(the_repository, split.items[0].string, &from_obj))
+			die(_("failed to resolve '%s' as a valid ref."),
+			    split.items[0].string);
+		if (repo_get_oid(the_repository, split.items[1].string, &to_obj))
+			die(_("failed to resolve '%s' as a valid ref."),
+			    split.items[1].string);
 
 		if (rewrite_cmd)
 			err = copy_note_for_rewrite(c, &from_obj, &to_obj);
@@ -396,11 +397,11 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 
 		if (err) {
 			error(_("failed to copy notes from '%s' to '%s'"),
-			      split[0]->buf, split[1]->buf);
+			      split.items[0].string, split.items[1].string);
 			ret = 1;
 		}
 
-		strbuf_list_free(split);
+		string_list_clear(&split, 0);
 	}
 
 	if (!rewrite_cmd) {
-- 
2.50.1-618-g45d530d26b

