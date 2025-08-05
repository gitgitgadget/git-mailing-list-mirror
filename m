Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B649C25DCF0
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386093; cv=none; b=JFo/rNaUnOUo+P6yJCEFTcfcDYR2463d+7eBb5ikUdJY3zC40jjgwHyzENySZWLF8rZFyI7lwjm+1bRC0+O7S3WzoKVe0egLnXOwbyRvBVFA2/2v30S7vT2drpcRM7IcceH23wFS/kCt4D8abQJ+w3cx1BelvQxXG8NyDVwqsLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386093; c=relaxed/simple;
	bh=WCvYkncq7OSU2E8wCQREI38URmDETbnZMA1nMD/fmdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ft1CFTFjK2sdlvXGpXrjYT2NUkV/Kex9m55YM8JijLyykrm7SOnTIUI5E2v4AgeUkGzvovmeJ3XgrjTnAi+uDqs+h2uZGORfFFr/rZcKTRKE83AkQtcWBPyVJwQ4UJOHNDzcyNmCJV5Xa+/oWSY/hWEJWJnVmy5w9dE5Z/UXeRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlOqCnRO; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlOqCnRO"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76bd041c431so4318367b3a.2
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 02:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754386091; x=1754990891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfAfcBDVR/OE9Hz3JpXrhg8BAKgycucU3PyPrOXI3TE=;
        b=RlOqCnROOBFFLIxF8cxIX2DhNEVxhTYpecnMLs6wZisCs5N9IgUYLxuXiosUfqtGXn
         3OO727msX0dPvOBxpkLqkjZokSI0K4n89LzjDRYPjbJRI8za/AANkgnirN8D0kiOhaUL
         gRNi2miqNe7ZzdeZXIen6irwlodM5SW07PRNPLMirT7RKwK/LwRh+6GeKPaGrqlqtvXm
         SsDstUJCChL+VqjE4v//um9fAAx/N1Q0AuOei8VwIxBAhxTvvoqj8cjXlP60OgLoyORD
         gU868hdVuZ5jFVmlh+NTw2uIytC50+TOWV4EjhV7D9bskXGV0KH0EvSNpBi9Myq7SI9z
         +h7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754386091; x=1754990891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfAfcBDVR/OE9Hz3JpXrhg8BAKgycucU3PyPrOXI3TE=;
        b=mfmjQT3zpEOFQfXN8Y+OTBlb5I4zwqOi2p1pskDFSrBUPjIEey1rr7ofrQwe6jknST
         hYWLsnHOe0kt44fyGEn4/ZNlZ1N9tvXN38lhX+0Kq57+9lrz1AuGovkwtNQoHSLqJaNp
         iHujw8oF7y4X8JqVX7Z6Fu11GEptVxdGvpLHKwySTugtQ7IloO+v+S2thbLYzhE4TzhR
         wE7bgeJNNYyO0pUUdEB3YRjAa6yJ0q/8e5s9bYZKYpdKsuTi/zXFVzMZb7FQfdiuc4hX
         3ldSdoLX31fK9DcPWt5tBh/WIlzmaZxIZ+sly4ZYZ9M+tEtbvh3H3cQa7+NWY28zP+8p
         8qFg==
X-Gm-Message-State: AOJu0YxIPXrFGCtqa0q10aSMGAfWf8MmQea/wqaOINTvchxcvitNv+gQ
	9f9k6YD2p0CN54zhJL4x1SPc6Jwe5A72WuSKz1rzMMtQyVuQajMjYBJsEk3yQ9J8
X-Gm-Gg: ASbGncuWzmOf4+IQUUFRzzL1RyhxvvQ4r1mCqkFMy10tVg+4EdBX5stR77rPJvfSJle
	XpAz0Yc/QphNHjxGYTjWQkQxoe2o34JM6uIw7z98+whHTtXmu6JEpKk0ZrXQczsQpBeunIbdG27
	Yc2NEMho78on1h+UWZgxb5QckvsJf9AZ2LgtPrcIm/7I/h2hnlWjp8/+Ib8FhMqG6Gnmwg81rvf
	Wy8E9YwESn0cIchLW7L2/T1LNZcTmq1qgdbqO3q2DNVXc/TDt/5GogZey05j/pWuEXLSc4aqJaP
	TM8YZn2VaawLtbO86PJso/FenU6AZvlEbDr6ezNBks176FVLHo+X5pZ5ay6Jr/Uj2fQgTyrmsOu
	fSA4CWxGqM+nPCi1V9ko=
X-Google-Smtp-Source: AGHT+IHuUWxzQ58HZ+xoVN1AnAh/n9lPgfkFSJTCxvXUFmRzU0bZQxBtqEMDD7+UbbV25K+HKVEvGw==
X-Received: by 2002:a05:6a00:198d:b0:76b:dd2e:5b89 with SMTP id d2e1a72fcca58-76bec33dffemr16200522b3a.6.1754386090552;
        Tue, 05 Aug 2025 02:28:10 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcceab592sm12465691b3a.58.2025.08.05.02.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:28:10 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	sunshine@sunshineco.com,
	phillip.wood123@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Aaron Lipman <alipman88@gmail.com>,
	Victoria Dye <vdye@github.com>,
	Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [GSoC][PATCH v6 1/6] doc: factor out common option
Date: Tue,  5 Aug 2025 14:57:53 +0530
Message-Id: <20250805092758.5321-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805092758.5321-1-meetsoni3017@gmail.com>
References: <20250804092255.1092973-1-meetsoni3017@gmail.com>
 <20250805092758.5321-1-meetsoni3017@gmail.com>
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
 Documentation/for-each-ref-options.adoc | 88 ++++++++++++++++++++++++
 Documentation/git-for-each-ref.adoc     | 89 +------------------------
 2 files changed, 89 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/for-each-ref-options.adoc

diff --git a/Documentation/for-each-ref-options.adoc b/Documentation/for-each-ref-options.adoc
new file mode 100644
index 0000000000..4a033d3e16
--- /dev/null
+++ b/Documentation/for-each-ref-options.adoc
@@ -0,0 +1,88 @@
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
+
+--start-after=<marker>::
+    Allows paginating the output by skipping references up to and including the
+    specified marker. When paging, it should be noted that references may be
+    deleted, modified or added between invocations. Output will only yield those
+    references which follow the marker lexicographically. Output begins from the
+    first reference that would come after the marker alphabetically. Cannot be
+    used with `--sort=<key>` or `--stdin` options, or the _<pattern>_ argument(s)
+    to limit the refs.
diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index 060940904d..130d452de0 100644
--- a/Documentation/git-for-each-ref.adoc
+++ b/Documentation/git-for-each-ref.adoc
@@ -28,94 +28,7 @@ host language allowing their direct evaluation in that language.
 
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
-
---start-after=<marker>::
-    Allows paginating the output by skipping references up to and including the
-    specified marker. When paging, it should be noted that references may be
-    deleted, modified or added between invocations. Output will only yield those
-    references which follow the marker lexicographically. Output begins from the
-    first reference that would come after the marker alphabetically. Cannot be
-    used with `--sort=<key>` or `--stdin` options, or the _<pattern>_ argument(s)
-    to limit the refs.
+include::for-each-ref-options.adoc[]
 
 FIELD NAMES
 -----------
-- 
2.34.1

