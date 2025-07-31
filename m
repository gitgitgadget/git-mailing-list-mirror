Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DAB290BC4
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952454; cv=none; b=tYpTR9/EMnpadasIX/c1jg1ywylImFj+5ns5LbP0XwCNJfvI3EXs3GXtBfpWFtbPPJYOf5Tl1U4TzZjdUOjeEzYYzxxpWQHGpLLKRQ4kxFyx1Y0uw2l2m8PAqRs8dNE6ndvdB6SpYzmSWAjcyUP7YXkCga3S76nCU7cXRTIq1ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952454; c=relaxed/simple;
	bh=G31/ZiMin1weTE4bFUtvX162FUEp4rxiHl/9S5fpl0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C9Zzsm1ZycSPAitRTUlmLpWN/Qi/ikapqG2o+y+3w1zwW4hqPpAAFsfav92O1Ol8mkZfWcIVvZWi0mhCGQlGDzPpGEYKgCwCggVV6VPJ75J2Ew1BPjttsDB0Dq9AmcGAztKCC/Dl5nyYh+QGgRczSYx8gfultmnoK1YR6WYuDm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEF+0WVb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEF+0WVb"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76b0724d64bso627670b3a.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753952452; x=1754557252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8F093nCyJn+sF6FeIQbNSbpTuhmCKBxQ7dTwq7w9II=;
        b=eEF+0WVb5IaUZZeucJTxya6qG/1GC7KsATEUdrhdkDCQYbbaY1yVo9kJm80PPn+anw
         63DCnD3YppgMssK8eF4cRkzB4b2mleSJYgB4HtxKS2RNpmGQIJrwj8ktT/5cDyGNET/F
         m/Zl0zwHWyl0dzAM1eIvTudjYe62HHYNLjejFL69eYFQWbmRi2zJ4pvEC9fq/K2cxnnO
         53+C/3KKfJfHfuYoMITOR7E7PfQHiPl5vsGFD9wj1FS57TzuvizIpaLLgcbZyKyriyEl
         kjIli8bHFmtr0gd/bGr+PZByqRFVKYidi/OZVWuxcvic9uxY0clyfMWc13QaJbu1BDmu
         iHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753952452; x=1754557252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8F093nCyJn+sF6FeIQbNSbpTuhmCKBxQ7dTwq7w9II=;
        b=ZpXEwgKHqi0k70y4epJ766hETY4Uj1Z5ztef58SEobfKzrA0arPhfxgMjPhF340zOC
         LMyMnjGMHZC1oHqf9TaALLw5/rq4XWnrp+WvOS7GDWXru1fjOUFJU4yEglXtlFKPpZG8
         KX4Fcw3x9G+ZD0P+AnyzP8uwA2GLaQXnWFrsM6zG6lnuwLxkbhNveBNGszQQ95YlYR3z
         Fln6D7AoNIqNO09TSusOYnnM/NzJnrAeTHJlpJhN7Cb02HZc++Q2IQUSk0/lB1wseqN/
         HDaABHsgcaI1EfkSnjL37KohA5QNL+03ZVw3NcGQrFWB5pyXZnppdplqjHX6o6c7S+va
         rrVA==
X-Gm-Message-State: AOJu0Ywbo7SNz8O3e6rvt02pIXhJXiLFnk+QRGihtsJIGBwrjW8e9tVS
	DmSsbqPF6IO4WFDOEWwNRSxL6uPyGCztvLQSzPwp5RlB00hojqpF080KFokkkg==
X-Gm-Gg: ASbGnctWzumWquh8sl3sf3XCYr1QiUWUvMgFtR0eXe56dGwuwaJE0u/FQLlkWfLUe+K
	PnitbfA75hmG0Td9FLggW05FZGNbyhlnPbKmG3x4S2G+1B5b/ev80xczpUsd27fFBq9rAmrQZHo
	Bm6d1SV83dI7Dd242NLkSsAWXVsLnXpFuZT5/0A7qUF1+EDCtapmYjgHMWiacVKVQHdVBqImYNr
	hcF7k0JpuJSo3nFwHfdyQWQFjCG3/QyecwIPWE/f5nrL/nZWmY0t8oCKULkFOm9Ip1ylGYogmPF
	cvhPAnXrRpzCZVRNs57+aXCOtZRfnodeum/fIMNWRDRm08kxGIpSUGImfjxzA1UTurOCkc7NFog
	LrsRkD99FJ7AB8z0G9e0=
X-Google-Smtp-Source: AGHT+IEcszqo1xRF7j+I/usNut4OMiqWgPL3VvNsc98iwqBHdZwkd0PYv6Y73VRReVFRvsdPuTLHeQ==
X-Received: by 2002:a05:6a00:2e28:b0:736:a8db:93bb with SMTP id d2e1a72fcca58-76ab0827c94mr10090880b3a.5.1753952451534;
        Thu, 31 Jul 2025 02:00:51 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd22csm1057745b3a.65.2025.07.31.02.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:00:51 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	sunshine@sunshineco.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Aaron Lipman <alipman88@gmail.com>,
	=?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
	Jeff King <peff@peff.net>,
	Victoria Dye <vdye@github.com>,
	Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [GSoC][RFC PATCH v4 1/5] doc: factor out common option
Date: Thu, 31 Jul 2025 14:30:36 +0530
Message-Id: <20250731090040.1625303-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250731090040.1625303-1-meetsoni3017@gmail.com>
References: <20250723064313.29866-1-meetsoni3017@gmail.com>
 <20250731090040.1625303-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding documentation for `git refs list`, factor out
the common options from the `git-for-each-ref` man page into a
shareable file `for-each-ref-options.adoc` and update
`git-for-each-ref.adoc` to use an `include::` macro.

This change is a pure refactoring and results in no change to the
final rendered documentation for `for-each-ref`.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 Documentation/for-each-ref-options.adoc | 79 ++++++++++++++++++++++++
 Documentation/git-for-each-ref.adoc     | 80 +------------------------
 2 files changed, 80 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/for-each-ref-options.adoc

diff --git a/Documentation/for-each-ref-options.adoc b/Documentation/for-each-ref-options.adoc
new file mode 100644
index 0000000000..5f3a85bf64
--- /dev/null
+++ b/Documentation/for-each-ref-options.adoc
@@ -0,0 +1,79 @@
+<pattern>...::
+	If one or more patterns are given, only refs are shown that
+	match against at least one pattern, either using fnmatch(3) or
+	literally, in the latter case matching completely or from the
+	beginning up to a slash.
+
+--stdin::
+	If `--stdin` is supplied, then the list of patterns is read from
+	standard input instead of from the argument list.
+
+--count=<count>::
+	By default the command shows all refs that match
+	`<pattern>`.  This option makes it stop after showing
+	that many refs.
+
+--sort=<key>::
+	A field name to sort on.  Prefix `-` to sort in
+	descending order of the value.  When unspecified,
+	`refname` is used.  You may use the --sort=<key> option
+	multiple times, in which case the last key becomes the primary
+	key.
+
+--format=<format>::
+	A string that interpolates `%(fieldname)` from a ref being shown and
+	the object it points at. In addition, the string literal `%%`
+	renders as `%` and `%xx` - where `xx` are hex digits - renders as
+	the character with hex code `xx`. For example, `%00` interpolates to
+	`\0` (NUL), `%09` to `\t` (TAB), and `%0a` to `\n` (LF).
++
+When unspecified, `<format>` defaults to `%(objectname) SPC %(objecttype)
+TAB %(refname)`.
+
+--color[=<when>]::
+	Respect any colors specified in the `--format` option. The
+	`<when>` field must be one of `always`, `never`, or `auto` (if
+	`<when>` is absent, behave as if `always` was given).
+
+--shell::
+--perl::
+--python::
+--tcl::
+	If given, strings that substitute `%(fieldname)`
+	placeholders are quoted as string literals suitable for
+	the specified host language.  This is meant to produce
+	a scriptlet that can directly be `eval`ed.
+
+--points-at=<object>::
+	Only list refs which points at the given object.
+
+--merged[=<object>]::
+	Only list refs whose tips are reachable from the
+	specified commit (HEAD if not specified).
+
+--no-merged[=<object>]::
+	Only list refs whose tips are not reachable from the
+	specified commit (HEAD if not specified).
+
+--contains[=<object>]::
+	Only list refs which contain the specified commit (HEAD if not
+	specified).
+
+--no-contains[=<object>]::
+	Only list refs which don't contain the specified commit (HEAD
+	if not specified).
+
+--ignore-case::
+	Sorting and filtering refs are case insensitive.
+
+--omit-empty::
+	Do not print a newline after formatted refs where the format expands
+	to the empty string.
+
+--exclude=<pattern>::
+	If one or more patterns are given, only refs which do not match
+	any excluded pattern(s) are shown. Matching is done using the
+	same rules as `<pattern>` above.
+
+--include-root-refs::
+	List root refs (HEAD and pseudorefs) apart from regular refs.
diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index 5ef89fc0fe..c3cf1752e3 100644
--- a/Documentation/git-for-each-ref.adoc
+++ b/Documentation/git-for-each-ref.adoc
@@ -28,85 +28,7 @@ host language allowing their direct evaluation in that language.
 
 OPTIONS
 -------
-<pattern>...::
-	If one or more patterns are given, only refs are shown that
-	match against at least one pattern, either using fnmatch(3) or
-	literally, in the latter case matching completely or from the
-	beginning up to a slash.
-
---stdin::
-	If `--stdin` is supplied, then the list of patterns is read from
-	standard input instead of from the argument list.
-
---count=<count>::
-	By default the command shows all refs that match
-	`<pattern>`.  This option makes it stop after showing
-	that many refs.
-
---sort=<key>::
-	A field name to sort on.  Prefix `-` to sort in
-	descending order of the value.  When unspecified,
-	`refname` is used.  You may use the --sort=<key> option
-	multiple times, in which case the last key becomes the primary
-	key.
-
---format=<format>::
-	A string that interpolates `%(fieldname)` from a ref being shown and
-	the object it points at. In addition, the string literal `%%`
-	renders as `%` and `%xx` - where `xx` are hex digits - renders as
-	the character with hex code `xx`. For example, `%00` interpolates to
-	`\0` (NUL), `%09` to `\t` (TAB), and `%0a` to `\n` (LF).
-+
-When unspecified, `<format>` defaults to `%(objectname) SPC %(objecttype)
-TAB %(refname)`.
-
---color[=<when>]::
-	Respect any colors specified in the `--format` option. The
-	`<when>` field must be one of `always`, `never`, or `auto` (if
-	`<when>` is absent, behave as if `always` was given).
-
---shell::
---perl::
---python::
---tcl::
-	If given, strings that substitute `%(fieldname)`
-	placeholders are quoted as string literals suitable for
-	the specified host language.  This is meant to produce
-	a scriptlet that can directly be `eval`ed.
-
---points-at=<object>::
-	Only list refs which points at the given object.
-
---merged[=<object>]::
-	Only list refs whose tips are reachable from the
-	specified commit (HEAD if not specified).
-
---no-merged[=<object>]::
-	Only list refs whose tips are not reachable from the
-	specified commit (HEAD if not specified).
-
---contains[=<object>]::
-	Only list refs which contain the specified commit (HEAD if not
-	specified).
-
---no-contains[=<object>]::
-	Only list refs which don't contain the specified commit (HEAD
-	if not specified).
-
---ignore-case::
-	Sorting and filtering refs are case insensitive.
-
---omit-empty::
-	Do not print a newline after formatted refs where the format expands
-	to the empty string.
-
---exclude=<pattern>::
-	If one or more patterns are given, only refs which do not match
-	any excluded pattern(s) are shown. Matching is done using the
-	same rules as `<pattern>` above.
-
---include-root-refs::
-	List root refs (HEAD and pseudorefs) apart from regular refs.
+include::for-each-ref-options.adoc[]
 
 FIELD NAMES
 -----------
-- 
2.34.1

