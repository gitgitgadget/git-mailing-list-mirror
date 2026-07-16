Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCBB239567
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220954; cv=none; b=P5FkB/01PJmzWKVQsS4+hkJpdCBXwWIBSVxu7p/J1rhJkQb+lfr5VqUXZV5oLDeBe0ICrzY9ZBPtUt8u+iqLmn3fhebfMc8Ef7bgZT3sl3q/Kf12VbktVCl2F1tdKlXORf5jiqgKnybBVcyWWoJgfUjaRLOUh0OuRNrWCfl8VKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220954; c=relaxed/simple;
	bh=hTgSyDm7HzI22OwZlWN2FEaa24rPKkrnE0v4IckiGxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfWCU+3lnAeUH4qqtxMEuaPFj1kb4JsYYXHl2KgWvRFmENmIOrkRwZBR4wSn3bTbVIy24WM3av0rM83Mgui6erQT0q0aTJrUHKrxPSsnEIORmxF4d3VZblSKjOBRPXSMbkAYPttqtMtLNxjesJEuGFmQJA9IcsXsIwIW5lV+ivM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qymcWTRZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qymcWTRZ"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba320so2118769a12.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 09:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784220943; x=1784825743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QghMy9WFp95ZxT/w054Nh6jVqTgAodwsc8iNYAyhsU8=;
        b=qymcWTRZuHPsAD4Tnrck7Yd0qDz5xm5+nZMLmpyK4Tr9X0x7KlhO4ok6RPeyOWG/6m
         7AvNiwQYYxxOSRaYYceGIn32OUvoIccu/cMizvUlOsO30j0gL9gfNu5ksJ0Gd/cuq2ZW
         69ZhZddpzCjxbA8RovSDKY6u4DcXgWjDJWTjVSxEkx6dvg6XqRhFpCBGT/4gO4YA0Of3
         N39dC+mjdV4H/cFFjjnBvYK/e9cGZTaHvtWejBcWobzZWnnSF3twW+Xye2b+JHKLYutD
         DHVzsieFlIvp36JySSlJGzCRImAYmQqUItCKjeg49el8XG7j/YVXG9xi8zWFVpOY4EN3
         O/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784220943; x=1784825743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QghMy9WFp95ZxT/w054Nh6jVqTgAodwsc8iNYAyhsU8=;
        b=UXx3J3O6AtnJ5TyD/6hmhJ55x3KEXvA65aVPIJNGe6lOmN9UrSClMxIxvRM7p8vdO4
         VuvltoX7NjfZxC01YlLWQ+bsQGkObEvk+C8wFK12Gbr+7B2ftO7IbJO0KNi11cm9+bop
         IDJgFhn0YCYFlFSySXS8WqeoU79fd71jNnER8wfTu9YGg08gV62NFB7hS/5Vd7yKZ8bg
         1/dPwo0JGoHspx5LBMl0ZoCYHOwrFWMGZPBoEEzi474WvCVqy43YJGdU3zL9nUr2N4Bn
         6WwGBy2MvGh7Oi2kkrah9GtLUIjRaYmgW+CemAHBvFuELzUbe0Fe0jgVZh2AA22jpmLE
         a4nQ==
X-Gm-Message-State: AOJu0Yz9y5jkaI6LUFiK5WPpbGpSQ02TePplns1bWdFpxs3gHcFY8EbB
	u6DOTne8kr1vEZ5l2oYOgjYnLHjLShiS44uad4kDb/dJ8GkX4uaiCbF/iOVns8uYX18=
X-Gm-Gg: AfdE7ckGDQDZ2Ff/zfM24xZlUYhJpPAOhzoQiAyWD5mD1Tg0EQ/y+osdUaxjehOVim2
	KcLwdYj10h0YhzCFn+uscW7+WaBLmd2+PE0CaPKfGE9ersVbYVsk2REEhh5kYqX6ZJuZZfdeU0H
	YqicY7dCL+d34t6TEF4e+sUN5FiVXmBpoc+MgE8mnCGA+88ZWK3Nq+bu6s2/GZ8u+hwwcyyfXLz
	NQTcov1OS7Qob45W9pb131KpiJ3TxPiPQG9AIKjts9zyXX1QA81UA/hRYU3DMYRgsYMowdhAwgD
	4bK3pHPpAWsrT1Qcn7xqhZwuqNslL5nCsaAHYlu5cZC6wGLqVLhmozDrVQBc3iVWL3xkFHJNfH1
	Kpzey9eIRT9vCGrEgYI2+jzqlMoGtFgEIC4aBxz0Zi8WK3dDcBO1SbxAG/B72jRzpUdwhYylWLZ
	IK5q8uWEfopUEb+Rb9FraqnRyrpSd27iiqTnxYzOPOvT2FAIgfUG0ksFphk+rk1XEQY/5cbkpwG
	FhyksuYjUe46Jw5FpGOaPCPwDUF
X-Received: by 2002:a05:6402:457:b0:698:86ce:8dc8 with SMTP id 4fb4d7f45d1cf-69e38d36178mr1042889a12.10.1784220943226;
        Thu, 16 Jul 2026 09:55:43 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd2937527sm5017149a12.20.2026.07.16.09.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:55:42 -0700 (PDT)
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
Subject: [PATCH 2/7] api-parse-options.adoc: document per-option flags
Date: Thu, 16 Jul 2026 18:55:12 +0200
Message-ID: <20260716165517.433849-3-christian.couder@gmail.com>
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

The "Flags" section in "Documentation/technical/api-parse-options.adoc"
documents the flags that can be passed to parse_options() itself. It
does not, however, document the flags that can be set on individual
options through the `flags` member of `struct option` (and through the
`OPT_*_F()` macro variants).

These per-option flags are used throughout the codebase (for example
`PARSE_OPT_HIDDEN` is used to hide an option from `-h` while still
showing it with `--help-all`), but a reader currently has to dig into
"parse-options.h" to find them.

To remediate that, let's add an "Option flags" subsection to the
"Data Structure" section, just before the list of option macros.

Let's also make it explicit that these are distinct from the
parse_options() flags described earlier, and let's describe the `-h`
versus `--help-all` behavior for `PARSE_OPT_HIDDEN`.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 .../technical/api-parse-options.adoc          | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/Documentation/technical/api-parse-options.adoc b/Documentation/technical/api-parse-options.adoc
index 880eb94642..fb4580e755 100644
--- a/Documentation/technical/api-parse-options.adoc
+++ b/Documentation/technical/api-parse-options.adoc
@@ -150,6 +150,67 @@ Data Structure
 
 The main data structure is an array of the `option` struct,
 say `static struct option builtin_add_options[]`.
+
+Option flags
+~~~~~~~~~~~~
+
+Each option can carry flags in the `flags` field of its `option`
+struct. These are per-option flags and are distinct from the
+`parse_options()` flags described above; they are usually set through
+the `OPT_*_F()` macro variants (see below) rather than by hand. They
+are the bitwise-or of:
+
+`PARSE_OPT_OPTARG`::
+	The option's argument is optional, i.e. both `--option` and
+	`--option=<value>` are accepted.
+
+`PARSE_OPT_NOARG`::
+	The option takes no argument at all. Using `--option=<value>`
+	is rejected.
+
+`PARSE_OPT_NONEG`::
+	Disable the automatically generated negated `--no-option`
+	form.
+
+`PARSE_OPT_HIDDEN`::
+	Hide the option: it is omitted from the usage shown by
+	`git <cmd> -h`, but is still shown by `git <cmd> --help-all`.
+	The option is parsed as usual either way. This is meant for
+	deprecated, advanced or otherwise uncommon options.
+
+`PARSE_OPT_LASTARG_DEFAULT`::
+	Use the default value (`defval`) when the option is used
+	without an argument, even for an option that normally requires
+	one. Only the last argument on the command line takes effect.
+
+`PARSE_OPT_NODASH`::
+	The option is a single character without a leading dash, such
+	as the `+` used by some commands.
+
+`PARSE_OPT_LITERAL_ARGHELP`::
+	Use the argument help string (`argh`) verbatim in the usage
+	output instead of surrounding it with `<>` or `[]`. Useful when
+	`argh` already contains a hand-formatted description.
+
+`PARSE_OPT_FROM_ALIAS`::
+	Internal flag, set on options that were expanded from a
+	configured alias. It should not be set by callers.
+
+`PARSE_OPT_NOCOMPLETE`::
+	Do not offer this option for completion.
+
+`PARSE_OPT_COMP_ARG`::
+	The option's argument, rather than the option itself, is what
+	should be completed.
+
+`PARSE_OPT_CMDMODE`::
+	The option is one of several mutually exclusive "command mode"
+	options that share the same variable. Using more than one of
+	them at once is rejected.
+
+Macros
+~~~~~~
+
 There are some macros to easily define options:
 
 `OPT__ABBREV(&int_var)`::
-- 
2.55.0.185.g9120d2b5c0

