Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6E022173A
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753638722; cv=none; b=YcpTbSDVSbuarKLDFkHqbsP/cM1RhW2GdlYNjeBuwf7VqSvcm3qtJeDmvFMcNZ2R7IAxKjaRw3BgFpPEsVTdYkmxmEGx9rVHnUXWnQ9P6KN6R5DxU2ytcZCHI+CWJbP+42+rFZRSsqkOZVhkKEIAYQgp7TFbuwRyRLxlZzA0vo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753638722; c=relaxed/simple;
	bh=9JWNO42lG7li/xCEXZnSFFa07Q3dECvQuWeGcK7cLPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u3oR9Oi68w1EAe9jGEuLw0jNYIkhKGKdakkerSDafLjOY/Qom3zjVv+ALqEnKVuXrb3nQxUQ4OY34+YdG0XyBmVDkY619q3PV7PaW1O6EzLJW+4L9a1az9dJ4jfDvTXd2wQ/55Urj/tzwAL0bQYzclF147qmQqhtRF3kTQU2yFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqfDbx41; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqfDbx41"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b3220c39cffso3783520a12.0
        for <git@vger.kernel.org>; Sun, 27 Jul 2025 10:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753638720; x=1754243520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3n9eNgh8J7eQJ1lJx1zX+r3zodCyozuOr2ADhFMA1I=;
        b=WqfDbx41TxKjmTpU+HUCS4L8kLHEYli62YtUCoJWzdGdp846JLn6IJpoXLumTdydEp
         BolonExSJSrZO5Q1ZsWFgK9Cu794ejbmz7Csjd3EXSDqMKvbZbWDYsqq6ooxcokwz2CN
         nCGLEH0R+nnGGgUQsoxbGn30xv6HPOTlcbr6uPK9l11ibFpt8aglQNkzC1t+4xVOlm39
         Fc7Jw0EVJK42Sl22BOGDMUAAPsUPsfd057MZyzCz5PhlHrVY7tW5giZzt9wVXgiFt6MU
         jfIGQTN5qWZk+UXzOXIyiVrNvYGfr2BU8y97fz7RxyvaorGor+RdR2DUtTUqUqSTsTiM
         N4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753638720; x=1754243520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3n9eNgh8J7eQJ1lJx1zX+r3zodCyozuOr2ADhFMA1I=;
        b=U/J24WKj15OPN3AXADm/NamdjCbQ47mmQAVMzcmiCdGRJciVfvIjKWhl3uDQKUT+99
         f3WDGrJdH7j7ZxvjHAQKD/CYgr7OScO6QNIjhJkXEc9RmDzOULWVjgqb61Y9RoxvODT2
         EqJfy/ZOxfzGVW15Ec5+Jzmf6jrTUFCnyF0vWANLwLR0Tps2Xv4es4ef36ONPqMC+i5L
         jeDftV4KN+53Rgey+KCYnFZJYu8J0p0IvFDA9M67VdVaQIDyf5rnddVf4jMUfz818Rma
         HzZiLpfOlVsKqU/A0mhgcnr68GPMd6LS9EvTaMazDuMjDE3Nmiwhc27HEm4sj9A6bHd2
         4hHA==
X-Gm-Message-State: AOJu0YxeUq9+frTDaIrzT7uKOS3adGSu+12qwtnYZjuygDjHjagmaanW
	Ks6EJzzEM2fzz+v3VA3MRqPBJxiKPysE1G7UgDRqA93K79k6yjtBnKpjh5d2yg==
X-Gm-Gg: ASbGncsOrL55je6Bc+KeNT2H8NPIVhU6iQsSq4DzVisp6NIfp8Syk7LbmFJnNqtKLbj
	q8Dc9cblVg3yAuU6fLPl6c5sCxv+Cqrpc7gzDTlR3c2Cvd931FT7uUZo6fC7Vfjf9SmUIafS1Y8
	BdweutsLthFRyJ/uYQvEls1PC1QWQV0fH+JZwbwk+LItyh/kLqM7/FTBwGo5xT0+Dkwusrb/4QY
	nDOX4JXwuFeBoVG+fGupYUhl1S4orT1sexJqiwzr7vV0pi4/murSOZGCBanCeP9X+sLi9DJ8a1c
	zZBoWFZEhzuYugho1wLOHVzXkYNfMiQeTwdr8yaQZ6k72BaDYI0Kk5GSADcFPMRmWwiSb/SnFm1
	XL+vqEkQ3d9ZMCNDcaINsU2eqM4U+xQSOCG3ia8yWR5aDGed2lj7leDm2lZAu37dcdZsBiBa+bi
	CYi4FdkdvAIwg=
X-Google-Smtp-Source: AGHT+IHRD9jndc10rrKMDKNoa/97PuILXkhPT3byg0xG9+vSM27O2SL8pVk9TzAsX+djgamGShczRg==
X-Received: by 2002:a05:6a21:6da8:b0:218:59b:b2f4 with SMTP id adf61e73a8af0-23d704297a2mr13758185637.42.1753638720013;
        Sun, 27 Jul 2025 10:52:00 -0700 (PDT)
Received: from localhost.localdomain (201-1-210-243.dsl.telesp.net.br. [201.1.210.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f58bec0sm3392488a12.17.2025.07.27.10.51.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Jul 2025 10:51:59 -0700 (PDT)
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
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v5 5/5] repo: add the --format flag
Date: Sun, 27 Jul 2025 14:51:10 -0300
Message-Id: <20250727175110.84770-6-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250727175110.84770-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250727175110.84770-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the --format flag to git-repo-info. By using this flag, the users
can choose the format for obtaining the data they requested.

Given that this command can be used for generating input for other
applications and for being read by end users, it requires at least two
formats: one for being read by humans and other for being read by
machines. Some other Git commands also have two output formats, notably
git-config which was the inspiration for the two formats that were
chosen here:

- keyvalue, where the retrieved data is printed one per line, using =
  for delimiting the key and the value. This is the default format,
  targeted for end users.
- nul, where the retrieved data is separated by null characters, using
  the newline character for delimiting the key and the value. This
  format is targeted for being read by machines.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 13 +++++++++-
 builtin/repo.c              | 49 ++++++++++++++++++++++++++++++++++---
 t/t1900-repo.sh             | 20 +++++++++++++--
 3 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 3f920b619f..6cc3ff581c 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -18,10 +18,21 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 COMMANDS
 --------
-`info [<key>...]`::
+`info [--format=<format>] [<key>...]`::
 	Retrieve metadata-related information about the current repository. Only
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
++
+The output format can be chosen through the flag `--format`. Two formats are
+supported:
++
+* `keyvalue`: output key-value pairs one per line using the `=` character as
+the delimiter between the key and the value. This is the default.
+
+* `nul`: similar to `keyvalue`, but using a newline character as the delimiter
+between the key and the value and using a null character after each value.
+This format is better suited for being parsed by another applications than
+`keyvalue`.
 
 INFO KEYS
 ---------
diff --git a/builtin/repo.c b/builtin/repo.c
index 37fb1803f6..a293d32b92 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -9,6 +9,11 @@
 
 typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
 
+enum output_format {
+	FORMAT_KEYVALUE,
+	FORMAT_NUL_TERMINATED,
+};
+
 struct field {
 	const char *key;
 	get_value_fn *get_value;
@@ -68,9 +73,24 @@ static int qsort_strcmp(const void *va, const void *vb)
 	return strcmp(a, b);
 }
 
-static int print_fields(int argc, const char **argv, struct repository *repo)
+static int print_fields(int argc, const char **argv,
+			struct repository *repo,
+			enum output_format format)
 {
 	const char *last = "";
+	char kv_sep;
+	char field_sep;
+
+	switch (format) {
+	case FORMAT_KEYVALUE:
+		kv_sep = '=';
+		field_sep = '\n';
+		break;
+	case FORMAT_NUL_TERMINATED:
+		kv_sep = '\n';
+		field_sep = '\0';
+		break;
+	}
 
 	QSORT(argv, argc, qsort_strcmp);
 
@@ -91,7 +111,7 @@ static int print_fields(int argc, const char **argv, struct repository *repo)
 		}
 
 		get_value(repo, &value);
-		printf("%s=%s\n", key, value.buf);
+		printf("%s%c%s%c", key, kv_sep, value.buf, field_sep);
 		last = key;
 		strbuf_release(&value);
 	}
@@ -99,10 +119,31 @@ static int print_fields(int argc, const char **argv, struct repository *repo)
 	return 0;
 }
 
-static int repo_info(int argc, const char **argv, const char *prefix UNUSED,
+static int repo_info(int argc, const char **argv, const char *prefix,
 		     struct repository *repo)
 {
-	return print_fields(argc - 1, argv + 1, repo);
+	const char *format_str = "keyvalue";
+	enum output_format format;
+	const char *const repo_info_usage[] = {
+		"git repo info [<key>...]",
+		NULL
+	};
+	struct option options[] = {
+		OPT_STRING(0, "format", &format_str, N_("format"),
+			   N_("output format")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, repo_info_usage, 0);
+
+	if (!strcmp(format_str, "keyvalue"))
+		format = FORMAT_KEYVALUE;
+	else if (!strcmp(format_str, "nul"))
+		format = FORMAT_NUL_TERMINATED;
+	else
+		die(_("invalid format '%s'"), format_str);
+
+	return print_fields(argc, argv, repo, format);
 }
 
 int cmd_repo(int argc, const char **argv, const char *prefix,
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 0bdbf6911e..94a98c52f6 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -20,11 +20,20 @@ test_repo_info () {
 	key=$3
 	expected_value=$4
 
-	test_expect_success "$label" '
+	test_expect_success "null-terminated: $label" '
+		test_when_finished "rm -rf repo" &&
+		eval "$init_command" &&
+		echo "$expected_value" | lf_to_nul >expected &&
+		git -C repo repo info --format=nul "$key" >output &&
+		tail -n 1 output >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "key-value: $label" '
 		test_when_finished "rm -rf repo" &&
 		eval "$init_command" &&
 		echo "$expected_value" >expected &&
-		git -C repo repo info "$key" >output &&
+		git -C repo repo info --format=keyvalue "$key" >output &&
 		cut -d "=" -f 2 <output >actual &&
 		test_cmp expected actual
 	'
@@ -81,4 +90,11 @@ test_expect_success 'output is returned correctly when two keys are requested' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git-repo-info aborts when requesting an invalid format' '
+	test_when_finished "rm -f err expected" &&
+	echo "fatal: invalid format '\'foo\''" >expected &&
+	test_must_fail git repo info --format=foo 2>err &&
+	test_cmp expected err
+'
+
 test_done
-- 
2.39.5 (Apple Git-154)

