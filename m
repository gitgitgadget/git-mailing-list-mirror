Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1254A220687
	for <git@vger.kernel.org>; Fri,  8 May 2026 01:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778205538; cv=none; b=TG6B10PPl61RFLcBY28dpDe4g1bfjF9FTnxVWqdUDrHY026sakvjmDspwr+qtf8u8CbGP+MSKCFQecHJpU8tvO/sxJznen9o6D7GA5HYzdaxnQzhKRivAghnlq0me6TLq8tCfBlMrkH1i5tpDjduDN3fqhOvzdCWMEKZ7aTZeXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778205538; c=relaxed/simple;
	bh=SccqBwm9GqvfFwMm90ikb0vyS5l/Iy9Mn5vP8h/Ep3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0lRAdp3E04niELG79Aa4VNEdz0l05Pd//nMt0DiN2oZwJ0TY8JE0MeV7AXUoF/wW0WQKG4CRC3t3JZHj55Q4whakV1Fvxfb+X9qKeZLmZPCL6dW0Mqe/OvBpNEzO2ZBY0XF6E+fq3ntP652qIj3oatSxPwPM8wBve2DLXWRlBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abhinavg.net; spf=pass smtp.mailfrom=abhinavg.net; dkim=pass (2048-bit key) header.d=abhinavg.net header.i=@abhinavg.net header.b=eOfsoZii; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qaBavISK; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abhinavg.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abhinavg.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=abhinavg.net header.i=@abhinavg.net header.b="eOfsoZii";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qaBavISK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ECDE87A009F;
	Thu,  7 May 2026 21:58:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 07 May 2026 21:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abhinavg.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1778205535; x=
	1778291935; bh=tNNraFHEwyMnHQPVptgf8ZYADYXqn82GmjhGIXx3ttI=; b=e
	OfsoZii4HNa49mCVKNIUgmbGh7UCD3h3XvDOdROqJIiknaV9tFI0rP6vCwaVTLAY
	PCnFFpN0VUyqgXhYNOwLg6hKx3+Mb1KFLREdUCAdxu+bfBbA7G90VBoOk6cYUwkB
	5gB1E3dT/3DfP7ydp+ggXnVuJ1/BrecXCIJf3szJ57b+VFhp322e9DXRL9oTf1Xl
	yuVVLXXs8Ao/caPjpJLjGAJDWdmKv5JHUlbXvBHPJL7TEmPf5isfE/gLJ17U2TYl
	W99Hm85E8WOzaJqcrYZl7B1yczluv2Z+3Zg1+3MvzwvN4xWd6dQj/3MBA2Mm9RiE
	CvSYEqQikhuS7qoljy1gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778205535; x=1778291935; bh=t
	NNraFHEwyMnHQPVptgf8ZYADYXqn82GmjhGIXx3ttI=; b=qaBavISKSLVARlhmo
	+MLktOSuwViGJ9K+y4BFnAjA30oVlE1oVcy3zYeMypbo1SzMXH2N3q2rxQldTZBK
	wjGHKabPwGqezh/90z3Ic2HHDyqPD09Xa27Eiq8+nOQf7nV7+3UnUGD1jJxIplzz
	vpk23ZgvA/Eamp3FxWMYkTtZP+uLGKVzlZiIPp76R8BT9wIgBdyqb9va5J2n9Zyt
	EiGcyWJ9I92rxVP17VbU8SHmAziR4NuDXiZeTkm/uep0e2XAD4ginJQB+edI0fyv
	hrS5una+V9xx0wDYVUrc8LPWFsUIkZ70IAMIDD0VfYM7Ynn7AXNOubjqaFrN+sKt
	bI06Q==
X-ME-Sender: <xms:X0P9aT1t5r6Eik4UiuR7vA43A4BIj3BXe1bxzySf6brGxI45Qw_b8A>
    <xme:X0P9aTl7Hm4Cz1tIs_1BJe8gJoh5qasK5mnzMah3jYvnc-Vt-ugUgS6xnNHx2K1HQ
    TgsR8CNgzkQ6a6LJ9IlHxe6OXQOJRuPBpj0bByJ9k2vxEf6BLCEfHY>
X-ME-Received: <xmr:X0P9aT9qUYHXtombwFK11lqHW6TlDZJphRDbkzD7IubrxYkmwQ6_oh-X-FV9Bw5nOE-4t7XBSpXzf3C1aEOy8_uLltkOGhjf_9tVMP7iFdkk5cBV0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdeltdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmhgrihhlsegr
    sghhihhnrghvghdrnhgvthenucggtffrrghtthgvrhhnpeevgfdukeduhfeluefgvdegvd
    fgveevvdehfeeujeeutdevteeitdelueegffevieenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghilhesrggshhhinhgrvhhgrdhnvghtpd
    hnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepmhgrihhlsegrsghhihhnrghv
    ghdrnhgvthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:X0P9aYowL811jfAuRcJai5l-iWNd8TxYgUph9_Vi_UdKY-aex4eeUw>
    <xmx:X0P9acnuJITjoZlaFs5NcxV8cgga0JHaYs5TZlUVbX0vy5mvlg8zyw>
    <xmx:X0P9afiC_9iTaot1VSqwpWJ-zeVjA2MpWb-bmsJf9rqLoAqRSArRhA>
    <xmx:X0P9aUfu2AlwNPyEax0lvp2sL87F9W35dfVQ_qxKlq5enzYu6isfLg>
    <xmx:X0P9aU4hhA1llO8VjTT3vmvCmNiu7mQWOs-lCSdG62tzxJjwM8GkBYtC>
Feedback-ID: i43f949e9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 21:58:54 -0400 (EDT)
From: mail@abhinavg.net
To: git@vger.kernel.org,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: Abhinav Gupta <mail@abhinavg.net>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] rebase: ignore non-branch update-refs
Date: Thu,  7 May 2026 18:58:17 -0700
Message-ID: <20260508015817.86177-1-mail@abhinavg.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506023944.90691-1-mail@abhinavg.net>
References: <20260506023944.90691-1-mail@abhinavg.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abhinav Gupta <mail@abhinavg.net>

The following Git configuration breaks git rebase --update-refs:

    [rebase]
        instructionFormat = %s%d

The '%d' format requests all available decorations for a commit,
filling the global decoration table with all of them,
which --update-refs then uses to populate 'update-ref' instructions
in the rebase todo list.

Specifically, this results in the following instruction:

    update-ref HEAD

The todo parser then rejects the instruction:

    error: update-ref requires a fully qualified refname e.g. refs/heads/HEAD
    error: invalid line 3: update-ref HEAD

To fix, ignore decorations that are not local branches
when scanning through the table.

This matches the documented contract:
it moves branch refs under refs/heads/
and leaves display-only decorations (HEAD, tags, etc.) alone.

Verification:
A regression test that fails without this fix is included.

Signed-off-by: Abhinav Gupta <mail@abhinavg.net>
---
Updates:
    v2: incorporate suggestions to simplify the test

 sequencer.c                   | 10 ++++++++++
 t/t3404-rebase-interactive.sh | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index b7d8dca47f..25bcfc5da0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6428,6 +6428,16 @@ static int add_decorations_to_list(const struct commit *commit,
 		const char *path;
 		size_t base_offset = ctx->buf->len;
 
+		/*
+		 * The global decoration table may contain names loaded by
+		 * a previous pretty format such as "%d".
+		 * This will result in refs such as "HEAD" being present.
+		 */
+		if (decoration->type != DECORATION_REF_LOCAL) {
+			decoration = decoration->next;
+			continue;
+		}
+
 		/*
 		 * If the branch is the current HEAD, then it will be
 		 * updated by the default rebase behavior.
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3e44562afa..58b3bb0c27 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1960,6 +1960,24 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
 	)
 '
 
+test_expect_success '--update-refs ignores non-branch decorations' '
+	test_when_finished "git branch -D update-refs" &&
+	test_when_finished "git checkout primary" &&
+	git checkout -B update-refs no-conflict-branch &&
+	(
+		set_cat_todo_editor &&
+
+		# rebase.instructionFormat=%d loads normal log decorations before
+		# --update-refs adds its branch placeholders so we must ignore
+		# all non-local decorations.
+		test_must_fail git -c rebase.instructionFormat="%s%d" \
+			rebase -i --update-refs HEAD^ >todo
+	) &&
+	grep ^update-ref todo >actual &&
+	test_write_lines "update-ref refs/heads/no-conflict-branch" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success '--update-refs updates refs correctly' '
 	git checkout -B update-refs no-conflict-branch &&
 	git branch -f base HEAD~4 &&

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
2.54.0

