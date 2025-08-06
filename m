Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31E82BE620
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510172; cv=none; b=q0DSL0MbCa6zARm+2jUUaofjSJwNjeTdQKDAWlmII8Yhbwx6AD2u/c1fLAl0N3q2Hm2Ol1Hn0mZkspUZUnpN3PWwhO7x1/yJSQHvzfusyYCDUK0bhE2BxQlCXoJKcy7IW1tbo6d+SIefJHWzuienB6KwgpqS2mH8yHedA7nQbmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510172; c=relaxed/simple;
	bh=9esqS/wqFZo7tos1Dem/bneBYx5r5XtpYp0QCf6cpUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=baohPgDNqaH3B8xBvQO/WEjlxuA4bdyOARSQo4R+cyRaBHzi6ia4NYSvMVdosBGCBFw9Nvqmrzc7dk0RFiFKP2Dc/Ex0aFAqcBCH78x0BXTl6NIJ1IJDaBECKYKLDo+O+cj2hPIo/mUnDT3/wIFFLdYIhk4I4w2jfmBY04excp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IowTaMl6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IowTaMl6"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76bdce2ee10so305711b3a.2
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 12:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754510170; x=1755114970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y7PdhQ+BF48CoAse0czslwJBBCPFbMWOU7BIRhj9LE=;
        b=IowTaMl6NqeSH6E80jY4wtAaV1rEAqTvl79B+jPr+Gp+CdtorYFqeUfVn8oIO5f09u
         znJhEHoKjatANNxzfjfAM/hK/5mDZ563Iiq4tC+MTiYEhYkuuehi3iKhEUNOlI2g7NLQ
         9e92df2stO2hIx+Umc8FK+hcI9FkiXqP8EqZg4aQJuKIR8jG4k+Qcn8JfY0rKMbS90mw
         xuLKjhqwK69SvWh75QImAU5CZhgMQYPxPEqAffb3FhHMUByGxfKP4f8/rYexZQ2r+wwq
         Umh444MHDeiUdobf6eeggCOFPtd6EnUik4BP4re+9GuWCZhbHjB0/6wJx9MAuABNUTxV
         XpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510170; x=1755114970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Y7PdhQ+BF48CoAse0czslwJBBCPFbMWOU7BIRhj9LE=;
        b=a2SGdFZD7DO0vlXQ61MqE7KKPMGbZvKaCtvBjpgAXsN/XlRU7CUrqzaJYIes3N+yIG
         VWMsNuwXXoJZjgDXLb55+LN85M1fqSK1WupWnw4x30DhYIEo4f0tecgNepaVp/HkaT4m
         fF0K1N6oojIm0tT0XCvJFeTEzzNO5P6IunCm7XQoFKLaMl0BlSxLK0RGjUOCGccz6x0J
         Lbz2HzSlb+XXxTbV+jkmAdbPpadi/CbMoQjtS82v3k4BXfrHb59+d3nqC5tCtgr1QLq3
         p9Ajo4tiougg0dkftlCrbTIDKiGGHAnqdQWKKloxJZREoUwvmdrlv9uHdjPWRx4l8eog
         BupA==
X-Gm-Message-State: AOJu0YxEf9fM+6PczdTQP36ZqHDMDAdY5toV5ODj7c/BlEaOU4QPkHKw
	SZyCdBTbB+qIxfceAhs5hpJ5Ds+NH1ZAvCaNhgIoSaCJbDGpbpHrXPxRWTDvcx9J
X-Gm-Gg: ASbGncsS54oad242vbDGAu14Z/FSEsBA6YT1naQnzQ8+wCDvZ5dBWOMKiMbme9D+dzZ
	fJI0MiDMGhwmAg3jqWWx5+suz8WWoBB4cK8eyHn5Gi6tSAQTOGQGjAWu9QzJe92QHVO+wRtatXn
	OyDlSZO7A1JUaHJSQVxBKTiXOJGrPfLOZk+A+6yu1ohX4QsIeFnchFTunH8qXkpZt3SWAXEzdOd
	85Aw5H/74aYu8AFRAaWDhCs1dq0uHnQIOhNM4umZ+0PrrIWACS5wN5wVwSbVmK0S7yg5YjBGEUZ
	SeZDMAX++GwZJFk4Vb78T33rpMm7KLwHxZpTahrm7LSeJDjeGg8wK3aAUPXDPKm7X9XI1wt6S+u
	qVrahJ7zxTwo7vyHhkh6a2reRfjSLniaKp77Ct69QInGb29SadhO4HLDyTaU8scc=
X-Google-Smtp-Source: AGHT+IF57Pi2Cc5Cp3FYdJAz7CAVCGRPlXv4q7aoVAsAaD7njPSlqLjZRDPNBJC+TM92Ls94zobUJQ==
X-Received: by 2002:a05:6a00:2d8b:b0:76b:cf2b:18bf with SMTP id d2e1a72fcca58-76c2af20982mr4817852b3a.2.1754510169770;
        Wed, 06 Aug 2025 12:56:09 -0700 (PDT)
Received: from localhost.localdomain (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd026dsm16212400b3a.95.2025.08.06.12.56.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Aug 2025 12:56:09 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de,
	ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	jn.avila@free.fr,
	sunshine@sunshineco.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v8 3/5] repo: add the field layout.bare
Date: Wed,  6 Aug 2025 16:55:35 -0300
Message-Id: <20250806195537.93302-4-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250806195537.93302-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250806195537.93302-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit is part of the series that introduces the new subcommand
git-repo-info.

The flag --is-bare-repository from git-rev-parse is used for retrieving
whether the current repository is bare. This way, it is used for
querying repository metadata, fitting in the purpose of git-repo-info.

Then, add a new field layout.bare to the git-repo-info subcommand
containing that information.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Justin Tobler <jltobler@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc |  3 +++
 builtin/repo.c              | 10 ++++++++++
 t/t1900-repo.sh             | 16 ++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 0ee783abc2..0ef851ee9c 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -37,6 +37,9 @@ In order to obtain a set of values from `git repo info`, you should provide
 the keys that identify them. Here's a list of the available keys and the
 values that they return:
 
+`layout.bare`::
+`true` if this is a bare repository, otherwise `false`.
+
 `references.format`::
 The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index 2b7ab5875e..abdc929e19 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,4 +1,7 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
+#include "environment.h"
 #include "parse-options.h"
 #include "quote.h"
 #include "refs.h"
@@ -16,6 +19,12 @@ struct field {
 	get_value_fn *get_value;
 };
 
+static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
+{
+	strbuf_addstr(buf, is_bare_repository() ? "true" : "false");
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -25,6 +34,7 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 
 /* repo_info_fields keys should be in lexicographical order */
 static const struct field repo_info_fields[] = {
+	{ "layout.bare", get_layout_bare },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index ce02b394da..32f64b635b 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -35,6 +35,12 @@ test_repo_info 'ref format files is retrieved correctly' '
 test_repo_info 'ref format reftable is retrieved correctly' '
 	git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
 
+test_repo_info 'bare repository = false is retrieved correctly' \
+	'git init' 'nonbare' 'layout.bare' 'false'
+
+test_repo_info 'bare repository = true is retrieved correctly' \
+	'git init --bare' 'bare' 'layout.bare' 'true'
+
 test_expect_success 'git-repo-info fails if an invalid key is requested' '
 	echo "error: key '\'foo\'' not found" >expected_err &&
 	test_must_fail git repo info foo 2>actual_err &&
@@ -54,4 +60,14 @@ test_expect_success 'only one value is returned if the same key is requested twi
 	test_cmp expect actual
 '
 
+test_expect_success 'output is returned correctly when two keys are requested' '
+	cat >expected <<-\EOF &&
+	layout.bare=false
+	references.format=files
+	EOF
+	git init --ref-format=files two-keys &&
+	git -C two-keys repo info layout.bare references.format > actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.39.5 (Apple Git-154)

