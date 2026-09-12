Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B3436D9F5
	for <git@vger.kernel.org>; Sat, 12 Sep 2026 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240537; cv=none; b=WqVqRHND9TwUIYFafd+X+8GtQZs0tinLYLVGNZfC0rOwGjnIQHdGDmIsej8L5dm85KlUDNnXIw2s57ILR/NinBzmWibhPj2u6E34D7DRvoW7j7IpWsDIzsUme2MTxXWcJbpeXdxSgDhrcChFxziIO5BAazkq3INas/tGAfJ8ncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240537; c=relaxed/simple;
	bh=WP9eE5I97AaDc0JC+xSU3tu7bGkt+RCD7Iv6tXTJGro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pwj8w7YabUHzEbMaCNJrK5NMHwET3niqpOaLtlvLJgTDIkpGauBAveAGoeHvxlB0bgKI87vgZuiegvRickX6f4zQ4P9KjmLzPpHyKL2x6Px5wshSSjhdJNyNA6eyI4wrXfkdYcQg6oFrGCnrNGUws2Di02/87ER6XX4KWyuIYz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S1aB5H8H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WdzsBuUj; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S1aB5H8H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WdzsBuUj"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 08B8B7A0068;
	Sat, 12 Sep 2026 15:15:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sat, 12 Sep 2026 15:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1789240534; x=
	1789326934; bh=YuKEvBn4ejPAen/itA9MdG9q1vM5zmYfmd7wvjKnaIw=; b=S
	1aB5H8HH2yBow7v7DL08L06mCXYwkiCuMYs/xZMNwQLZ32XQDfYqRKLKMJhOeVYI
	1B5RaSIjk5XGQJU9sBsP59PthVo+c1exbesCvvtTxHe4D71YRUKxEh4Xh7sejPwO
	yNLV7fi70Ng1T9jIndd1AOexwl1t7N8puCbV6O3GiKWsl29j5FSSkb+e1XlBm2PL
	i0eyi9AfHeQH7Pb/YfI6c9BxmT7Nnr10Fvou/k7TXn5z87KznOfmBqQJTru9rHff
	nNv6Q19naNfzNr2J3la0/i7R7Ay0Y+uyXqgw3o8gm6h0jpIXrNO7NSHKP9MmZojN
	yjcyWgkjFfImRX+66Brsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789240534; x=1789326934; bh=Y
	uKEvBn4ejPAen/itA9MdG9q1vM5zmYfmd7wvjKnaIw=; b=WdzsBuUjnhaG2xRCA
	qg/RnXu27sR2U/BXHsHPn2kaC4afAbjTKq0sWnEJMDWvaBGFDl9E3L3dpPaR7JEM
	CmDGFhG+QMPpFFVbOebUopC3v7xkIKPcbBD6y3uB74Ce9h89t6/A9j01YYJIz9es
	9tnfD9hpSeS1IGj5eKJeV6i7H4976H3mO1dYCrbheZ6xJB14XungkwMtITmmqkH3
	BclK51GPW7TXHLX8A5XfLxjrHI2SUbj5Z5+VqxwVpQQmLKv6MFdGtKS81wwI6tzP
	WmvZE/PBKRI3JA2G5LabSipbJRxgs9rRvzKvgR/a0RJeQw8trAbQ2IFaJHKa4ncC
	Gx6gQ==
X-ME-Sender: <xms:1qSlahiE8vN00uxy6Dw67Xcjijs2opp6LCCUknczBmU6G515rlfazA>
    <xme:1qSlasBtoy9hjmDWuS9lg9wIL8HlCUajMIpXuqd4u8Enyqcq_OcCoYpEAMad1lR9K
    lvNKfCYoO4i22u09WAg8e7W71Cj7NvafVJEWt4x3LDYsykmtp2OdmE>
X-ME-Received: <xmr:1qSlauswef4zACXfOw8SlqL4Wsztk30Ugl5FN0m05dFnE_9Sfhx_VjdqXknhCcSFgGp7e2iHgpiJy-zx4D2mJJ_o9go5BI4YuuP-q8x-bL0zeg-BMdYVyevgwyPfKurt4oufqrblKCFM25z_>
X-ME-Proxy-Cause: dmFkZTGgyrv9fjfBch5r9WuS8+zty/bjEUQ6PaD63JJ4DuNno0NbLlCnET6SGYjDe3R38f
    6/RwmRC12sygsP78n6IjBBPYMkex2sawFiCauIIYRGPN/5Zzi/IJtwGP0zBTOYnLIPO9V2
    tJ/Ef8xZMhJZ5N9VgGKVtI4IOw5zHhPqMAlTJoq2ZwO/GSdBcd3o7AtWm4P+U6O7rbDp9p
    jNBn6lzp2udmip570jZPEyu2h9XBwUlqXOq/g7WSuBICk03YEh+OE5Iqp/HHtmhuiYWLMt
    03xAZlbtGUQG0t50uGh3bDzJxf2urZfK8452c84rTg6QtaNuAUMFi7uyIxgK01qeAIr+Pf
    YKj4IeOC9V1cEjA924kIkHWf0kA9Yt2/3W+OaiL4bJmwQpFhpmWCoQkVIuLy9zkzuhWnPw
    alM2XzhBhXJ6XLPMEXNm5LD6ulxxwOz/zCxfdt8XTnvsuI1OIzloG8mnikfNWl654XBbED
    GV8/8iKEFD/scjGIzQzbIiWfLL7y66fC8YxGBt6jqEwmhj6H6G1tak9kJfWt98v3jHNHN7
    W1vXk4tfkz+yf4t9LDbnJ5v/EXV4Kv7QNW1J2i5nUNCVXIX4Gi6lAHemBrDRForo4tP/R1
    Y3edPbnmkBfTD4BSuOo9HAPKPg4DipzXaaqac83Mtd8+mWPKj2L7ZhNOMe/g
X-ME-Proxy: <xmx:1qSlahY_C0an5F7EuoIlf24gIdp0VaYyEBPrBkEZgeRYt86CW2TmMg>
    <xmx:1qSlahUehhNI9E9uunasZWkyRQRY477_NrMKsdsDR__7wKvxbyZgIQ>
    <xmx:1qSlal6YFV4hJ8yNjJPsUwWk61zaDnkNsG6ZEqP1kSZmYCuBYOdJag>
    <xmx:1qSlasgGU0zRD7e8dRdStY1YZZgrMvAx_5QPx4TNlwL1gZpP3oogMw>
    <xmx:1qSlak5-E8CPplrZczpb0q2UOYat8RebHO-HLQsl7i8R0RSOoYpZ0mCo>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 15:15:34 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Cc: git@vger.kernel.org
Subject: [PATCH 1/3] doc lint: match commands as well as options for synopsis style check
Date: Sat, 12 Sep 2026 15:15:00 -0400
Message-ID: <20260912191509.844954-2-tmz@pobox.com>
X-Mailer: git-send-email 2.56.0.rc0
In-Reply-To: <20260912191509.844954-1-tmz@pobox.com>
References: <20260912191509.844954-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both `--option::` and `command::` should be backtick-quoted with the new
synopsis style.  Remove the requirement for a leading `-` from the regex
which scans for these patterns.

Avoid matching lines like `linkgit:git-diff[1]::` by replacing `.*` with
`[^:]*` in the regex.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/lint-documentation-style.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/lint-documentation-style.perl b/Documentation/lint-documentation-style.perl
index d7ab732293..6eece11bdc 100755
--- a/Documentation/lint-documentation-style.perl
+++ b/Documentation/lint-documentation-style.perl
@@ -24,8 +24,8 @@ sub report {
 	if ($line =~ /^\[synopsis\]$/) {
 		$synopsis_style = 1;
 	}
-	if (($line =~ /^(-[-a-z].*|<[-a-z0-9]+>(\.{3})?)(::|;;)$/) && ($synopsis_style)) {
-			report($line, "synopsis style and definition list item not backquoted");
+	if (($line =~ /^([-a-z][^:]*|<[-a-z0-9]+>(\.{3})?)(::|;;)$/) && ($synopsis_style)) {
+		report($line, "synopsis style and definition list item not backquoted");
 	}
 }
 
-- 
2.56.0.rc0

