Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91091758B
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754579057; cv=none; b=UppYPQn34vXnyQUNCBmeUapwGiTHv5r89LuwMrADzuDN5JPjxdsCa/tRsHfaJgctalPKUXGDa0+tfHJo+pYSrGbHKqJspjEvPJlm2ABDUroMb1WSGW+eY4QiMwhTvibhOSbIophFFnlG4isqsH+hr3SaOBj0uCdEHioQqKVndWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754579057; c=relaxed/simple;
	bh=IeMzbbdr849u7a/Bwn8p3Bw28LzWm552nFG9/o1Guzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g7RXM+UQS7jV3UhFgQA9H3lgWQ6DahMAEEmrEH5nGYGETaJ18not+SSF36EUQvN7SxtrpGigCbvgvgcFdGvYh7csp0UxcYv6DMsOMP96mJHuZTmAH3i8a04yg7obfc4ilRItZJewxMHCjt6tRE67b8S/Z5F/IJGgGBIycVTdzG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLMiJXKw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLMiJXKw"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2402b5396cdso7294155ad.2
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754579055; x=1755183855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiJrhS/+rxbTYRmrJXhRB1MRk9BGtDLsKT3v2gJDdCQ=;
        b=NLMiJXKwU753Llmr2v0Rg2IwH/oih9SV+2uVdiZWu9Z8x6MOcd4kXi56Wt4rI3wveJ
         4/w5eevKcq+VXSzPPM8JEVND7nPXGQ3Q4hAy7/CZ4SXY+XM4fFlGU/HUwth+IdmS06ls
         xZdgtZ3N0wIMqf+H29lyS02LmFz1fQHi7F++JFGBHKfy2hJvvt2TZntyNF7aVysAnIm5
         jSt2VPWUVwxb3ehpJGn9M0R1LkebLkuerxI4AGjf6ZBvEvsijPEbj/a+2+vwchzfvrbO
         9vldKbPz87K3RkwdqOap1DDLg++nSFMUQi9TeqJqd+b7WKu4jtVdZIDeZdgUdPnl3m1R
         +XKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754579055; x=1755183855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiJrhS/+rxbTYRmrJXhRB1MRk9BGtDLsKT3v2gJDdCQ=;
        b=HrqoVVE9eSNjCA52Lx9J/JgkMWeZ/Kl9nCXT89cxv+Axvsff/Ee0Qw1W05RrAfjz8A
         30LxH2uw5NUUAtqKvw8JgZJRXrhQtoGvIkDvSbGPnweAVj93xq5ADQyrer7QqRF0C4bM
         GJGtWy0M/CG40swXSP4F5Ie0sx97T8ajT2pn6GGDRnckvys3SCwQ84FL+i1EyNsE+7AK
         zZarVwcKkYLWZhGWs6m/7zTpC/P6oZlbEc6DMCUvO8eq5Ah91100uvjkeNtEt+BaF3hX
         +jNEWxuMm5DVhVdiM4ZbCoDiUDvh+TlBGqcF1lelUFqvjSQwkllt0dv2TahLKbpG6dP2
         9VKA==
X-Gm-Message-State: AOJu0YyCE3xSeMT3y8pXG3ZaH7VQ19PJeREZsqgvWYHBpIW3/dbqNwgR
	p9cPUrM4jnldw82F9oFB2j1EShUet/t0KYEvGK8vSVMHh28EtVS9G6tmvd7APQ==
X-Gm-Gg: ASbGncuaeWw4y1uwNZthRXOEdT8v0NDtWSmnbp83LA1Br/2uwu5m72vyh1khJOwfSsN
	7atkHDcobMIlGzxAnfKJ4937TtvIC3O94/pza2y2xv221dURd1iqMRhvRw0UO7esi/1Vh2Lwo8o
	9CW42umu++ZyXwFsDjtpCmK1bGaPlJT1N173tRleYqH+iB1Shp3G2tYirei87vJoUlCxze9smkl
	S2nbcJYektBnugBvXJX/vBZ78Rn7DCYQrmn2FGNvOsKrpOjOUWnVezCz6qnsZwKsph2A2yAxRLZ
	F9wlcZdXqkm5FYfgLzJv/NDFMysNV+ei1Zx3vaEpfcIG0I3sB7O5legLbCOLWcJICWLhqPtinCp
	JS/PAQIx0nnWHfkBQ6Uqj7aRf3yI4vvpS1M3ORNkTx0anh/xKVXsAf2/lUc6Cpw==
X-Google-Smtp-Source: AGHT+IG1MLdXEixyFdMVGWjkGaUbWprnsPxQzbWQ++BOyFFTqhSmP4x+dU8FdDaaQEYNsYqBBeqllg==
X-Received: by 2002:a17:903:2352:b0:240:7fb:cb05 with SMTP id d9443c01a7336-242b1980245mr41824885ad.10.1754579054618;
        Thu, 07 Aug 2025 08:04:14 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8359:45d5:14c8:c621:17ff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2426dec66desm106617065ad.54.2025.08.07.08.04.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Aug 2025 08:04:14 -0700 (PDT)
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
Subject: [GSoC PATCH v9 4/5] repo: add the field layout.shallow
Date: Thu,  7 Aug 2025 12:02:38 -0300
Message-Id: <20250807150239.6987-5-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250807150239.6987-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit is part of the series that introduces the new subcommand
git-repo-info.

The flag `--is-shallow-repository` from git-rev-parse is used for
retrieving whether the repository is shallow. This way, it is used for
querying repository metadata, fitting in the purpose of git-repo-info.

Then, add a new field `layout.shallow` to the git-repo-info subcommand
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
 builtin/repo.c              |  9 +++++++++
 t/t1900-repo.sh             | 10 ++++++++++
 3 files changed, 22 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 0ef851ee9c..1ae9c09fac 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -40,6 +40,9 @@ values that they return:
 `layout.bare`::
 `true` if this is a bare repository, otherwise `false`.
 
+`layout.shallow`::
+`true` if this is a shallow repository, otherwise `false`.
+
 `references.format`::
 The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index abdc929e19..312fd08c34 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -6,6 +6,7 @@
 #include "quote.h"
 #include "refs.h"
 #include "strbuf.h"
+#include "shallow.h"
 
 static const char *const repo_usage[] = {
 	"git repo info [<key>...]",
@@ -25,6 +26,13 @@ static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
 	return 0;
 }
 
+static int get_layout_shallow(struct repository *repo, struct strbuf *buf)
+{
+	strbuf_addstr(buf,
+		      is_repository_shallow(repo) ? "true" : "false");
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -35,6 +43,7 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 /* repo_info_fields keys should be in lexicographical order */
 static const struct field repo_info_fields[] = {
 	{ "layout.bare", get_layout_bare },
+	{ "layout.shallow", get_layout_shallow },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index e5a624ec71..2018772631 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -41,6 +41,16 @@ test_repo_info 'bare repository = false is retrieved correctly' \
 test_repo_info 'bare repository = true is retrieved correctly' \
 	'git init --bare' 'bare' 'layout.bare' 'true'
 
+test_repo_info 'shallow repository = false is retrieved correctly' \
+	'git init' 'nonshallow' 'layout.shallow' 'false'
+
+test_repo_info 'shallow repository = true is retrieved correctly' \
+	'git init remote &&
+	echo x >remote/x &&
+	git -C remote add x &&
+	git -C remote commit -m x &&
+	git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'
+
 test_expect_success 'git-repo-info fails if an invalid key is requested' '
 	echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
 	test_must_fail git repo info foo 2>actual_err &&
-- 
2.39.5 (Apple Git-154)

