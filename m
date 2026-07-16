Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B6D2E739A
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220962; cv=none; b=Ach0E92ypRyOF56GtpXxFeUNXd2MeMlZkaUK0OrEdjYCsRHrhY1MUKiocIwgkgapHGsM6zQterPqhzXpa/0gV8QcA+7eJjdiZJfFMdGHc+Sfo4xz1tAioY3N5FZjeY6zmL+IP0E+SZYdNjeZ7c9lGT5I2seoDPyYMQCq5zDsObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220962; c=relaxed/simple;
	bh=LafoEdQTPX/tfeyD0OdaBTvSwNn7NlXnKyUQHg1V94Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDl8mqdTtfzv76IPwqG3jQU2JSOaNjLgRkaZzlJqS3vGWKjPVUk3t03VuuTspKcqQwN1vfIPu83vaAUGmpGjvhcceQqeU1yOJMgxzrxoGxfoNHya6cSOXuQtYxgmm28XGWpzssQ+0FpIAcpoilyehSN4zh+OCangNlFAbhj+bc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWxcx5sF; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWxcx5sF"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69a5ecbbfb2so5973394a12.2
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784220947; x=1784825747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=194VjPSto7LCgzJhptUut2SsMCuPLDsK3C1QHgVOrOM=;
        b=UWxcx5sFNqnPLAKOh9SnI++5aUpPA1QuMgJmnlKqjHz2UktVMR4Dv2GGXF6apBQg8v
         6zfbZhldz/TYokEpwzz+2WtFglTNxrRUTjDX2vNsTUdbVtbFm4OLWEnx7+N5hLywhO3o
         UpUQMYW2ccGesVZTpKKPFVmEVlRhkZsuWLQ4QmqENNSAaJn/5GKTi8lZ+/2N18xdxXik
         tm/Jz1jUkjzasrSLEXkaszpsUcDWslH94PUInfJG6TGuPtkvzNtxWSkIQvZWMbYkRrh7
         xZOnCSjMnZ+BQe8Gx+oYnCx32ROmgRgq+qjbT77YrFPbcQsA0RcbG5SQfXhzYlBClvCA
         2NVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784220947; x=1784825747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=194VjPSto7LCgzJhptUut2SsMCuPLDsK3C1QHgVOrOM=;
        b=qQcqS9aRf7UQuVwSwEdP0OhyVpg2o0uvqT6nAnD0tjjaM44ZvpWTRWW1Yjr1KHm/17
         Us6obuX6uQYoz0RsAyvwegCUjYH/JyGmSV1LADcLlk8PeVKxzbfTiSg0XibtWW1ee09D
         F4RAJxFQy6iYTyFbO6RgFzVfjgs7EWlAmsrEjULeJ1R1bJN4SFQfPc2EWERn9IBooOEV
         UEoKBODA222J12149Q7RJD0qA/rEptghKfhLzUL919Tpr9mcYmEsTcRSwGCfl60mUaJD
         nyUWw1pE+0EEJSxH9Ge3izz2Wd63ECfYvc7LIvh3GFaahFFfiVOk/5p98BDCmn5AN1W4
         M3dA==
X-Gm-Message-State: AOJu0YxeLAJUohb2b5RWir0je00ziyZ7+RyfyJIO0SU2oBWX/hULNhZV
	+yrqh9ninmBLpVsyYjrWYtHeAB65RwSiVaD8kGhTEAZwpin0CXVYc4SQmjKH1cwuJnI=
X-Gm-Gg: AfdE7ck0ABauVCtCrTT/B16u9JMuAcmbMO7pfBQRTGSaODXkwlJYStrW1j6axkXn9Ar
	t2qM/ykTeNiMo89kSq3kodecnh2razwiNjc1++n9INfNS8mG8gZ9QzhiTr/ndTAniWBN37Otjio
	UHRGg+AI7toxGln05UKx+1Ux/9wNRh5gk1xUvULEkwjT1JBT7VKCvIao6WC8PXGdvSZh9VLcvTL
	5yBOwy6yEVJDydXHpzwJoqpkziDa/LiCFd/hu+A/ZO0WNUakM2z1GjQO2yz8oQQNjTLzIwNgZYB
	ScF665j1pGFLL+vw7qJWq/IESeZ6LetThIxSOBqIWRfRhiPbu12rDxeXo/P6SIU0jmuS/+DDpER
	busQCK9FW7AVFdNMJn5iE8jaITbkurrP9IklTvx6X5wofcZuiXY2csUiDoB7d2mLRDiWyVIN6R5
	0nr41FLjuzUf9MWR6aaK5jhZNqrzqgdqBHnL5TuFmXQigH2xOq0W84efMthm6NIacDxkvkLpFrJ
	lix5D8AqKBErSS7Gw==
X-Received: by 2002:a17:907:e158:b0:c16:7414:4c29 with SMTP id a640c23a62f3a-c16741451c3mr300383866b.25.1784220947077;
        Thu, 16 Jul 2026 09:55:47 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd2937527sm5017149a12.20.2026.07.16.09.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:55:44 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/7] api-parse-options.adoc: document hidden and OPT_*_F option macros
Date: Thu, 16 Jul 2026 18:55:13 +0200
Message-ID: <20260716165517.433849-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.185.g9120d2b5c0
In-Reply-To: <20260716165517.433849-1-christian.couder@gmail.com>
References: <20260716165517.433849-1-christian.couder@gmail.com>
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

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/technical/api-parse-options.adoc | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/technical/api-parse-options.adoc b/Documentation/technical/api-parse-options.adoc
index fb4580e755..0e10327d07 100644
--- a/Documentation/technical/api-parse-options.adoc
+++ b/Documentation/technical/api-parse-options.adoc
@@ -213,6 +213,13 @@ Macros
 
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
 
@@ -236,10 +243,21 @@ There are some macros to easily define options:
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
2.55.0.185.g9120d2b5c0

