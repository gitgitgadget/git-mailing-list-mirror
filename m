Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893902D9EC5
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578919; cv=none; b=Ix3EZk0Dapb8FARMQ+4mNWOpc0nhMHgucOZDw+kHsqmKupJR+MkoQS4/VzxUmDUwWJG7Qjo9KBEvULfReEuPIna1inl3hSD6Q2twPbNJUkazo391ICnLZqA2q3sALyMHTXOhmXFz30w2ggXmVqxZg+8LQ1jl/1z3q8Kg/iJKGS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578919; c=relaxed/simple;
	bh=lxcyiGkYC8GjzAwyovkWCa/L06nYNJhKVCJUVLLBRyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XH1DEjQ5pnEKtWZoPcigqcYX2RcGg8v0qlNvQKhfeO3roI/ZJ5mPxrtwNXYxFF6i42c8+eN2PBvcklgYrN3XPlzOIgDMGVj8mC5O29CGq1qgXIWYMIOMVaFjRwAajTwDE+LU1yzLhUNv77wKZfg83S6bYdOipD1JcJtWxuuZJRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqpLz8V7; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqpLz8V7"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso8774758a12.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 04:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752578916; x=1753183716; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aihRlBk3k0eqPmc0HbPnY7aYLzqjbjT80lLtaOBFs4o=;
        b=QqpLz8V7hZM++lU7wNAMVF8ES7kBrJWotRvGIC946wwSupMBTuWoY1aBuKheDttWQF
         +ZT6hxtZo0491MhwE/t5+H7LPiiihDHcOJmMDrAKUm1cyaTCHBmioBULynF/o14bUntY
         njWtIVzcqkqkZmuookPefCaoRM8Mi0Fm+2EChW4Blpv++e2EYGyZLNxZcXiNprbsPN0S
         +WAoqmbv/b8S2eoE3ItFRE5YAc4kHynTmWMQ1ZM386iQF+RFwvGgrJLis0oSJPNWnFws
         CfNlN5h4tZKc1DzBnq+czOhpxpxxG0cBYvn3i02/iNWLYmzYnGV7r5Vt6CmeXW6yZHAV
         0yPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752578916; x=1753183716;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aihRlBk3k0eqPmc0HbPnY7aYLzqjbjT80lLtaOBFs4o=;
        b=SG+qdrQsegch9rlMvkfujmiivsuLtXkRuFWIIFlcjartT2/owMYQTX80dvhHf1/acA
         qu5tI8Xnenl7kmZrv1mqFDlWPl5bY7GmJuT+gvbLCT1ZD9rmma2f9l60ccqxXIxEDfRt
         P1z3S0qL5z33MXEkOHuz+t2x1JW5LrPZi35zLq8siFCMLZMK/oMPIzmcPpzbOclhNpJO
         EpPRUb+rVDfSYFVn6ZS++FtZWtYcUKh1odzWY9Rb3P8l22ZnCmS5jMcSPUVZSloJhlpb
         pBZwZBIl4Eb1uNJXYbqfnGLAMePcRXIoVbDw1GpgXLpV99uw9I2aGQ93b6aX7IECCY3n
         QDSA==
X-Gm-Message-State: AOJu0Yz8ZclIDZpmJ8cy/EvEufI9kHvQawrwyaRc5iO3wXIUqeWjw3iJ
	STTIFQDxoSHFKfpPNKsIVfHYFf6Qva8YHfQsUBUJlOIB6xJatGHvZ5Ok
X-Gm-Gg: ASbGnctjhPNDbe5FusSJxZlV1Y5M/+f6yJy8wL2r2lxDFN+qAaNddwBTFFDY+5SiJy9
	JnUS0dcnMnXinOJlYpTUFOODlAolGIKksSTY0MYsivR/DKYKeltEo+NPGRiPRJSbNDEMMxAEihH
	gGrUSo54IO3WGZwpdYoLQM7Ir1G7us1l23Uy+OE3bsY/qj3Eo0nqdW+W2LV0IAMWyV9LRFzXE79
	H5qA75jGMRpEUPfeQkDftsKXK+VSigChqVZVjMk0xX0BUkSErB9VEWlz8Pe8t5IuS9n7tDgA+VQ
	cCd1AjxI0JAFq6le1c1+B9suM7HwNPtPbo5DzlMruTb2tehUDce12RJ4uCzbuKRV/5uk05P/nM3
	zh2zY
X-Google-Smtp-Source: AGHT+IHkEp3uG4WUKnc0l4VApIBz0AkRUAZ6yjTZ1AcPaEPKeg/6oIUWLDPa3EXFODjKCPEBpRdtow==
X-Received: by 2002:a05:6402:2934:b0:607:f431:33f8 with SMTP id 4fb4d7f45d1cf-611e84d7493mr12224731a12.24.1752578915464;
        Tue, 15 Jul 2025 04:28:35 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:624:7896:99ce:d9ca])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c976dc62sm7206596a12.59.2025.07.15.04.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:28:35 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 15 Jul 2025 13:28:29 +0200
Subject: [PATCH v5 4/5] ref-filter: remove unnecessary else clause
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-306-git-for-each-ref-pagination-v5-4-852d5a2f56e1@gmail.com>
References: <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
In-Reply-To: <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 schwab@linux-m68k.org, phillip.wood123@gmail.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3429; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=lxcyiGkYC8GjzAwyovkWCa/L06nYNJhKVCJUVLLBRyw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGh2O1xjcqdWmfBs7s4vexwJ34BxEkLyh9ofq
 nuLQUl4ZnAyCIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJodjtcAAoJED7VnySO
 Rox/XHML/jBAYPE6Bs1YIi5Biyy53FNeLX+ATpAUAl+J/Wcj7ZkY6ydOgy9QsB8eiPd6Khio/0j
 Uoq5STc3F+OZOHqlZLUz5UR2/HknBEg6zrdodSJuVVhcYTV3xMmJlZCSW3kFnAhzpAInBn5hJfy
 eWv1WFHXI9rTxmwzWeR6jkebsCMlkKgnMNLeBTycOJMPvFQTcpi8sz1UHq8B1tEyCRzV6OGVk7p
 tfR4wbXrP3LeAWH5Y39x+9cBQ6yLbXTde/Hl5b01fCMM54vVMSqScrdLLRGF1DXz/bmU3KTYjBT
 Pvc7lUVQ4H8fwCwFaTXeXqYbdQVTY2wbE9pO2ngOh4GMCMAY1uDWkQVr3GppMzXlydEsN1gxO6b
 ydBE0Lj1nLnTYWwOSa7p38KRqrr9P19X4LvTj2QfmuhWqxy0JxfQ7JLtpGvLjiV+HrMX9mGnK61
 K28EEwcdDJKuJ0e0U79AQk97Zyk2FDxu5rfSlu0tayFEin8sPJ/DjHDJyeOdlM4qsZnvHI0vFh5
 Gc=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 'ref-filter.c', there is an 'else' clause within `do_filter_refs()`.
This is unnecessary since the 'if' clause calls `die()`, which would
exit the program. So let's remove the unnecessary 'else' clause. This
improves readability since the indentation is also reduced and flow is
simpler.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 60 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 7a274633cf..da663c7ac8 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3199,37 +3199,37 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
 	/*  Simple per-ref filtering */
 	if (!filter->kind)
 		die("filter_refs: invalid type");
-	else {
-		/*
-		 * For common cases where we need only branches or remotes or tags,
-		 * we only iterate through those refs. If a mix of refs is needed,
-		 * we iterate over all refs and filter out required refs with the help
-		 * of filter_ref_kind().
-		 */
-		if (filter->kind == FILTER_REFS_BRANCHES)
-			ret = refs_for_each_fullref_in(get_main_ref_store(the_repository),
-						       "refs/heads/", NULL,
-						       fn, cb_data);
-		else if (filter->kind == FILTER_REFS_REMOTES)
-			ret = refs_for_each_fullref_in(get_main_ref_store(the_repository),
-						       "refs/remotes/", NULL,
-						       fn, cb_data);
-		else if (filter->kind == FILTER_REFS_TAGS)
-			ret = refs_for_each_fullref_in(get_main_ref_store(the_repository),
-						       "refs/tags/", NULL, fn,
-						       cb_data);
-		else if (filter->kind & FILTER_REFS_REGULAR)
-			ret = for_each_fullref_in_pattern(filter, fn, cb_data);
 
-		/*
-		 * When printing all ref types, HEAD is already included,
-		 * so we don't want to print HEAD again.
-		 */
-		if (!ret && !(filter->kind & FILTER_REFS_ROOT_REFS) &&
-		    (filter->kind & FILTER_REFS_DETACHED_HEAD))
-			refs_head_ref(get_main_ref_store(the_repository), fn,
-				      cb_data);
-	}
+	/*
+	 * For common cases where we need only branches or remotes or tags,
+	 * we only iterate through those refs. If a mix of refs is needed,
+	 * we iterate over all refs and filter out required refs with the help
+	 * of filter_ref_kind().
+	 */
+	if (filter->kind == FILTER_REFS_BRANCHES)
+		ret = refs_for_each_fullref_in(get_main_ref_store(the_repository),
+					       "refs/heads/", NULL,
+					       fn, cb_data);
+	else if (filter->kind == FILTER_REFS_REMOTES)
+		ret = refs_for_each_fullref_in(get_main_ref_store(the_repository),
+					       "refs/remotes/", NULL,
+					       fn, cb_data);
+	else if (filter->kind == FILTER_REFS_TAGS)
+		ret = refs_for_each_fullref_in(get_main_ref_store(the_repository),
+					       "refs/tags/", NULL, fn,
+					       cb_data);
+	else if (filter->kind & FILTER_REFS_REGULAR)
+		ret = for_each_fullref_in_pattern(filter, fn, cb_data);
+
+	/*
+	 * When printing all ref types, HEAD is already included,
+	 * so we don't want to print HEAD again.
+	 */
+	if (!ret && !(filter->kind & FILTER_REFS_ROOT_REFS) &&
+	    (filter->kind & FILTER_REFS_DETACHED_HEAD))
+		refs_head_ref(get_main_ref_store(the_repository), fn,
+			      cb_data);
+
 
 	clear_contains_cache(&filter->internal.contains_cache);
 	clear_contains_cache(&filter->internal.no_contains_cache);

-- 
2.49.0

