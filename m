Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DBD2C375F
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271810; cv=none; b=bPl/0rB1VnnX/fl5p1XeM+ZrJDay0DEKRJcj0I0lrVqkxFo7GZv7Me0J7vIf+04inx/rKo65zPhD7j3r2tX9eCo8NKWpEDlQi0lz0KbfCXXyKAOmwD1Rt5lpOKRHZUZOHNl13amq1iHFTU9O3AfPSomDoBExQ14jAOW1wXRdOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271810; c=relaxed/simple;
	bh=O0Wwsu4kQinmCC92p2XPe0k6lGROkyhXyvJZ452mktg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ftayZ/Kpr891GWTROpA/8ZIsmYRgBH9CVMakcsgTZ/Ur3s5Or/PiQCz+lUURcvR9c8EpwzZvDyI7H0KjoT0ADq46vRUP8ydbxr1UyhwHZKGk585YAq4f1k3GajbhukWcWaTxDuNnNkvol0bCWnzQD8TZrP+snQZrFyILNgOfIrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MP/tcIr9; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MP/tcIr9"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2eb6d07bso2004181b3a.3
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 08:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755271807; x=1755876607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uP+5O0n8LktNhjOW0RqWKbBjsS5mGcqPfKaJBs6UZr8=;
        b=MP/tcIr9BU7AiEGuvjO/0mYUv0cXwMQfmgliwOdFm8DvmCnjo5V+K0qwjGueujAbeP
         GuMkxcp/IjK6DdkpISKHtfMf2DNBRHWqCuZP3q57tDEi9HWilmIm9tYedAlTuQKUCsXB
         IaotdarObsp2Z6SoCzg0Kmp4VsHmvF5OeW5y5q+9KYX4f0eL9xJQdAwszSuHpx4kp0f5
         AJmDV83TdQfDPzv/+fxYuhHPrPp8HtbLFRpGFXuhnB0fKRI15N5b1vYcMHRsB6x2p8Mh
         X/7E65teBPQ4pknFR21N8NkJvUKYDLRWS7V0o4eNYQp0XPQlWBMbC1dRpcbawjzE2oRS
         znAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755271807; x=1755876607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uP+5O0n8LktNhjOW0RqWKbBjsS5mGcqPfKaJBs6UZr8=;
        b=P85f+OkcUWmeFeHIKu0albIOgMvdZ705L5DiLDMu/r51EH1x3Fbp86i03Du1AenyIz
         Hxmwq4zbl1Lm/NzQl17+eIxddYSoeVqhGmOO1P64vlH0/37Kw3S9SPexRe+kyU922jBv
         C2t5oUtCoPJdWFWLvKKmFFW/vjqun3+nqvUWGABvO7FjNfs7tJMN2nHC1noB5qIDGxrP
         hgPEwNbRJAZh4u3VMG2DcpTQtLDA4lPfr+v+NscnNqF94zl9SxhNDYs8nHWWh+epCjj3
         lIhcbSt3qqEvqfMlJyKa+ga/jZMlIn0hrFQbOy1Cp6IvF9aDxRgWzM8AnbW/bpop0qNR
         1WPg==
X-Gm-Message-State: AOJu0YwemGAbAEX2HeaP+CaUSOfY45CdJxKRpoNzLI486dWx64e/92Su
	skr8McE5c/Ch1kOZdpVYgrc/WDwgmol2Md9twUxmqJ5uNQ9FoEiykg815K/qzg==
X-Gm-Gg: ASbGncujObfCvGIMspaBQ1IcdqpzgGVxpOopluBat6CQaly9oMOg9dfTp9PIkiQ/Ta/
	lVKgN567DObYsH/7grkokdEizFYR/FoZoagKovmwlsznfZlk6UnB5x/cthmpCSZ7MRzmaMR5t7w
	BIrLGwtVZWeUj5XfQYcLa5pTvD3swxrZgVPQG+debMbjDQ5lnzcCCQa7ZMZ7dKTcDN+Fa0CtWZl
	njHZRPPJPGUDkVK04d4sZ8ASjLdNvIViC5vputGXKmI6H2bANA1nB/DnfKGz7iiwWU4LDFFHZJb
	V+LEj5EQPZ8wVJiVSBSbuiAGFNWhfRPYMlPKSLXPw0PSj1IsGEoWgFS65lcoD7WcAqulmQhp32G
	JIxkmkvue2VAtmnaJ6Py2ztETVwDqZDKzVO8wK0nsmsN8VL3ElkSl6oqXsSoOoMaMRL8NkEJB
X-Google-Smtp-Source: AGHT+IFpDHh71mXyChc/ddHt0FJzLym6fazGohdIbSFkJ6RmR54NlzteX4JC5OTH4jIdnlZPZa8KXg==
X-Received: by 2002:a05:6a00:3d0e:b0:76b:eedc:8e05 with SMTP id d2e1a72fcca58-76e447c2984mr3219887b3a.11.1755271807106;
        Fri, 15 Aug 2025 08:30:07 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8e83:7089:f932:3359:f50e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e452666besm1393260b3a.1.2025.08.15.08.30.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 Aug 2025 08:30:06 -0700 (PDT)
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
Subject: [GSoC PATCH v10 4/5] repo: add the field layout.shallow
Date: Fri, 15 Aug 2025 10:55:20 -0300
Message-Id: <20250815135521.44044-5-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250815135521.44044-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250815135521.44044-1-lucasseikioshiro@gmail.com>
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
 t/t1900-repo.sh             | 13 +++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index d26c01a21b..3231a93947 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -41,6 +41,9 @@ values that they return:
 `layout.bare`::
 `true` if this is a bare repository, otherwise `false`.
 
+`layout.shallow`::
+`true` if this is a shallow repository, otherwise `false`.
+
 `references.format`::
 The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index aada476e1c..3c9140593b 100644
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
 /* repo_info_fields keys must be in lexicographical order */
 static const struct field repo_info_fields[] = {
 	{ "layout.bare", get_layout_bare },
+	{ "layout.shallow", get_layout_shallow },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 8368a168b6..78766a3f4f 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -41,6 +41,19 @@ test_repo_info 'bare repository = false is retrieved correctly' \
 test_repo_info 'bare repository = true is retrieved correctly' \
 	'git init --bare' 'bare' 'layout.bare' 'true'
 
+test_repo_info 'shallow repository = false is retrieved correctly' \
+	'git init' 'nonshallow' 'layout.shallow' 'false'
+
+test_expect_success 'setup remote' '
+	git init remote &&
+	echo x >remote/x &&
+	git -C remote add x &&
+	git -C remote commit -m x
+'
+
+test_repo_info 'shallow repository = true is retrieved correctly' \
+	'git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'
+
 test_expect_success 'values returned in order requested' '
 	cat >expect <<-\EOF &&
 	layout.bare=false
-- 
2.39.5 (Apple Git-154)

