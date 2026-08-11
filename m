Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A6541A565
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437218; cv=none; b=cfgCl7jMPcwnmyp3dSrzXjYJ73ekeiMh3zREGC5phTr1wLrzdjiJ0ynfmgOmU/nxjGHWYgc6odlL4+UH01bPxK43PeYF1jNhDeKWwAWZKXaVbSaL7B+ai/nqaH1xYBlL9YEQasAWe+VJl2cal6guPKIMhyew43kBlgN3GZJxihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437218; c=relaxed/simple;
	bh=j41T3Uv0TAsDHeapckkpNdsJ6PM37Cnhjm44bqZq/AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HebBdBez5si+DmbWXAvYsBqKpZ0I80BhbZqyWToFK6zICJySuPClCwWM4eRSoTRsfd9SodIrH5Nadm6AjSeP/9lLjzim7YWp/6sDw/y5fE1fEb6jFF8EJwj6P23XCtBZBZx+kSxbhR749BHA9vJ0EfqqT7K3MH2KaIuoHpjzh3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAZeyJI4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAZeyJI4"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso11810895e9.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 01:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437215; x=1787042015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NPo83o6wTvk7GEtpunC3VlWdpgEh6etIv65H1qF0jso=;
        b=LAZeyJI44G/VDze2000nQjjF3svH0WjKArBDNswTvcQHrL9CBwYTPAbHLz1GN2Dwyk
         N7SEUCIRCQXzGJvIVjxd+/xX1Bz7DMr/YlgjsdbYUuQRKWRnGhphNnllT9sY/fofy8OM
         V0eiREtTeWDaVdPQOb0kpB9HOGAzu3gbeF4tFKyg42lF+LeEzR5UwElyOlIGlAxHHWbE
         Mp5WeIRuvuW0IrZhydtD3hQWtuLBeh7b+fnC9tnqO+bGpGPIB2wBD2ghmogtSYXUdpgR
         V5ESoV7BLojP4o6Xke0rdkWxFFO89BQQxPKNZ3YlFktVSasql7iMdlK3kTaAArt1Z47p
         QJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437215; x=1787042015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NPo83o6wTvk7GEtpunC3VlWdpgEh6etIv65H1qF0jso=;
        b=Tp/PnzWDmhf23zj9m3s3pHWk1pZz0ENgfiEOKjVptjIuy3NZ1bJKtBtijR3J5ZTnMf
         sxOHbI+uTamnRDqILrwhV3Of85EtJYqtU+F5+188ziGVKbkEF2RLle5+ZfZhdQ3PLCPJ
         esy2jlRYOyvkFRh8Tm2ZpMPPVFwAJWur2ftlivZeqQni4WLaf193R0x5hI4nWjpSaYXq
         czJ03hUM4GUgrAQuPdIi5cZBx4PtfVxPaMSFDnIWvBh2Q8HKs3taF9PalwBwPqyspfJk
         d/4KLjG2NLaMmDeQwYvuU5dMPBLn+qGbTnqSfEtOlcIv1P3V0IhKg3SioLdUV3kXwaiv
         54kA==
X-Gm-Message-State: AOJu0Yxj4VQcTrMUzI57UI9iJ6ffqLKgY6kpp2Hkm8yBHapUJ1tyVv8l
	U6XOAjZUXwNEuUxcCqbd49Qa0V6ZRRxWSWLh5JmPZLUMiqzG+wVf1khqBYR7yw==
X-Gm-Gg: AR+sD132FRXrXLS1HwGpVnBVUlh4vCaUOyyTHdt7h3fFnwZgJhWnXaR5azdJVy6/d4A
	rM3UKqffNeiYv1Uv8KIbUD+e6GKW9TmBbVxzOvvydF6xSyNPojHRHTn3I2uPCJdNRFbFsKWI2/C
	5VI1uWZqYXdzSDPiPYrfxblwn9gyj9HvmPXKeLwBp8DMklvEVTpVsi26zEXoC4oAeKiazlDrnMH
	DYWf9LxSoZtExMk9fYRU3VvBnanypjmenA8CNg3U1lwsOc+7ZBccxczK00MJYlEQmz6mclc0n3m
	PGWvp0uAKBwaWWM4zgxAU+WTzBuJGe3nK3qxUB7U2ESH8fwtI7OkS02f0kn8RREufiy4+9zj1ex
	YkYhGlQRVSE2CHTIPmJVkuyBlpNaMVzJoQ8EeX3BLiI0X+hoopcVBMZASDPmTKRAoQ4AV4H6gGN
	D8yS/tLhgRa1TMIHmDuw9kpEzjXQwL28ZGi/AXxzqM7Iv4bJ/THJ/lNsXKkSwE+2OTvml5jSjal
	CviDwTjls2t5znyFu+WqTK0Kqi7EtE/80G94+8PGep1PkGwWEslkmdxrqh0Jgi9yh9ZtJyuxnw+
	iSk=
X-Received: by 2002:a05:600c:3b05:b0:499:520c:62a7 with SMTP id 5b1f17b1804b1-49978436f3cmr26641435e9.5.1786437215151;
        Tue, 11 Aug 2026 01:33:35 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([2001:863:5c3:4d0d:8be2:b2d7:3667:a5fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c302sm18728075e9.1.2026.08.11.01.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:33:34 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 03/12] api-parse-options.adoc: document hidden and OPT_*_F option macros
Date: Tue, 11 Aug 2026 10:33:05 +0200
Message-ID: <20260811083314.2023489-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.530.gdb3615d990.dirty
In-Reply-To: <20260811083314.2023489-1-christian.couder@gmail.com>
References: <20260804100355.1299498-1-christian.couder@gmail.com>
 <20260811083314.2023489-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "Documentation/technical/api-parse-options.adoc", the list of option
macros does not mention the `OPT_*_F()` macro variants that take a
trailing `flags` argument, nor the `OPT_HIDDEN_GROUP()` and
`OPT_HIDDEN_BOOL()` convenience macros.

Now that a previous commit documents the per-option flags, let's
document these macros too:

  - Add a paragraph explaining the `OPT_*_F` convention and how it
    relates to the per-option flags.

  - Document `OPT_HIDDEN_GROUP()`, introduced in a previous commit,
    right after `OPT_GROUP()`.

  - Document `OPT_HIDDEN_BOOL()` right after `OPT_BOOL()`.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 Documentation/technical/api-parse-options.adoc | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/technical/api-parse-options.adoc b/Documentation/technical/api-parse-options.adoc
index 5602cd44b2..95b7924e84 100644
--- a/Documentation/technical/api-parse-options.adoc
+++ b/Documentation/technical/api-parse-options.adoc
@@ -214,6 +214,13 @@ Macros
 
 There are some macros to easily define options:
 
+Many of the macros below have an `_F` variant (for example `OPT_BOOL_F`,
+`OPT_STRING_F`, `OPT_INTEGER_F`, `OPT_SET_INT_F`, `OPT_BIT_F` and
+`OPT_CALLBACK_F`) that takes an additional trailing `flags` argument.
+That argument is the bitwise-or of the per-option flags described in the
+"Option flags" section above; the non-`_F` macros are simply defined
+with `flags` set to `0`.
+
 `OPT__ABBREV(&int_var)`::
 	Add `--abbrev[=<n>]`.
 
@@ -237,10 +244,21 @@ There are some macros to easily define options:
 	describes the group or an empty string.
 	Start the description with an upper-case letter.
 
+`OPT_HIDDEN_GROUP(description)`::
+	Like `OPT_GROUP()`, but the group header carries
+	`PARSE_OPT_HIDDEN`, so it is only shown by `--help-all` and not
+	by `-h`. Use it to label a group that contains only hidden
+	options, which would otherwise show an empty header under `-h`.
+
 `OPT_BOOL(short, long, &int_var, description)`::
 	Introduce a boolean option. `int_var` is set to one with
 	`--option` and set to zero with `--no-option`.
 
+`OPT_HIDDEN_BOOL(short, long, &int_var, description)`::
+	Like `OPT_BOOL()`, but the option carries `PARSE_OPT_HIDDEN`,
+	so it is hidden from `-h` while still being shown by
+	`--help-all`.
+
 `OPT_COUNTUP(short, long, &int_var, description)`::
 	Introduce a count-up option.
 	Each use of `--option` increments `int_var`, starting from zero
-- 
2.55.0.530.gdb3615d990.dirty

