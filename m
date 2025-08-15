Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B2C291C03
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271816; cv=none; b=ECPbFLZeLtwCjgSydBqsqMEPgB6+SaJwraqCwB2fHpJKfo7NItVAGU/c9EPThpEBil6eqUlwyMmQLEozTVlqIRfvegFfydqlbOn34nOuUDIdP08qKrXWgI6Mt/6iftTCpmt5RbqiQXh9y4yzOg7+hasA4Z3FMgepPL1isXiXq4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271816; c=relaxed/simple;
	bh=FzOckVqx7sB+gly1BsRyL0wHuEMKonKnCtwLxT0LlhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lfJfKwaUwjLv7+wc7doEaDR8/De1Xvy4AAzuJOOw7+zTvkSf5nL9VgqQb9+zEi/q2B9aFxHsPPspXO/rS7p+YvZ/lBc8P1RlPLV965V3oXES0+nE+5fcNo7x1wwqWB2yzTu+LLjaYj6haC0NyQXhainUlYWUspKMoE4kIktWgTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ce+25Ilp; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ce+25Ilp"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2ea887f6so1628588b3a.2
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755271811; x=1755876611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjArEDADX5RIyT8VX0aAWwK8iKPJ2jK4ichbOJY7m+o=;
        b=ce+25IlpZ9E1L8ej9m30P4iQe89bLa4ggHkbs4632dqHEJ30A9hGaxHPBI/ZW4iVA5
         Gwzh1jGWnQzXEWbeBbRIf44KXy0CEwx5ndTrWuy5SMSnwQfBpdKfPGMUCAC4kJnr+cpF
         afd7bq/iVPvI4+MK/lBdsyISnWesb+XYqXx+L9caOWTzSLaxGrgclDaVNJslSKw47wYo
         rMbTke9kQx6vTe8khQKZQh1go+ESM1ofjoMm9364cRJTVFOZbEkK3RBOI1R7SUFhrUn1
         NGYkgFOiZH9z9RYaQO5uyY2rD2jr7Fv3NL/urs1P2F0AEtUsMfHoRNArKzWK993mg7br
         CvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755271811; x=1755876611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjArEDADX5RIyT8VX0aAWwK8iKPJ2jK4ichbOJY7m+o=;
        b=mwkCyXLQDrwgvMxWggiyxt5Onqa+foExVUd5/8S0/RFlcmoXudpM3CFJXMaXwQXfim
         rBi8X5VlVs9UHXJ51qwsMq9I+QY4dxB9SlzGXx5xiQyDYtOrbjAO/fw+8TzTVEa9rACR
         25mvCBsFBxfAnwlAivDWE5tAiQGB1Q77v07PCr9GJJa/MGw60tKS+/Z6CxxZp/KxJT3C
         6VSZcJ73SDnYJzQR91WXAcIhp6kTm45v3VRalX61K4eVTf+a/aIKmg8iq5EVKLozVdf5
         jiLJWrwc0Qv3jzX8Ipa6V+5Mf/WZavxVAz1qcBs4u2U9xxKEP2NJpH+LIOPOP5rauYDo
         TW0Q==
X-Gm-Message-State: AOJu0YyxFc9X3iOoibnnBE1XZTVbWSNm2LPTDlJPdItVkDhukCho2gLp
	xBNwSX8CSOgRSVh5jKhFRzDpD1B8BrnH7MDQf5wpjroQGxKzttUQmTL9A2Msqg==
X-Gm-Gg: ASbGncsc7Z0p9fBxbloiChCnBKcCBdM26WocIrzFQS4L26jw4nP8u0anuSR4B9PcWSF
	nFUlabMDoRh0Y+ncUT4x9g5Xmug0K50XNeaK6TQP7Axg4nZCYUxd5NjQo1yo1wGqpER7A+huBJ4
	GMQTm4sHMAo1qmSbHPYUEfMLEo548GIJAOdUz9G7x/Q6h/P21yfextLADosBtszCXFAHoUwNdhr
	rE/ro96oqICeL3EaXFeLYbjjSd/uQ1qZ0qwZ0UbuO7AbExatkitGwydo33S3owguOpfvZfLu7DO
	fLoW4eF40M4qMP7lbBffaU9EQGOIrl8QZ6x5QpoZSiYNB2EwzOq4yluBjyna8Ql+niY8bHGxNYG
	AtnC3QbOmI+FU60fXkknqSPu84T3DALUrCR7a2ISYSZfOxzRGTPbcTumEQUHxWw==
X-Google-Smtp-Source: AGHT+IGwuKVk6m5iIVTmjWcHnYV7vIHGNB3Moaca3yt5BxZVTUqLyE9tDzPre+IAA3AX01e2KgJyjQ==
X-Received: by 2002:a05:6a21:6da0:b0:240:1d4f:720b with SMTP id adf61e73a8af0-240d2fbf46amr4317480637.23.1755271810966;
        Fri, 15 Aug 2025 08:30:10 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8e83:7089:f932:3359:f50e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e452666besm1393260b3a.1.2025.08.15.08.30.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 Aug 2025 08:30:10 -0700 (PDT)
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
Subject: [GSoC PATCH v10 5/5] repo: add the --format flag
Date: Fri, 15 Aug 2025 10:55:21 -0300
Message-Id: <20250815135521.44044-6-lucasseikioshiro@gmail.com>
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
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 38 ++++++++++++++++++++++++------
 builtin/repo.c              | 46 ++++++++++++++++++++++++++++++++-----
 t/t1900-repo.sh             | 24 +++++++++++++++----
 3 files changed, 91 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 3231a93947..cb22f7ef65 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
 SYNOPSIS
 --------
 [synopsis]
-git repo info [<key>...]
+git repo info [--format=(keyvalue|nul)] [<key>...]
 
 DESCRIPTION
 -----------
@@ -18,7 +18,7 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 COMMANDS
 --------
-`info [<key>...]`::
+`info [--format=(keyvalue|nul)] [<key>...]`::
 	Retrieve metadata-related information about the current repository. Only
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
@@ -26,14 +26,21 @@ COMMANDS
 The values are returned in the same order in which their respective keys were
 requested.
 +
-The output format consists of key-value pairs one per line using the `=`
-character as the delimiter between the key and the value. Values containing
-"unusual" characters are quoted as explained for the configuration variable
-`core.quotePath` (see linkgit:git-config[1]).
+The output format can be chosen through the flag `--format`. Two formats are
+supported:
++
+* `keyvalue`: output key-value pairs one per line using the `=` character as
+the delimiter between the key and the value. Values containing "unusual"
+characters are quoted as explained for the configuration variable
+`core.quotePath` (see linkgit:git-config[1]). This is the default.
+
+* `nul`: similar to `keyvalue`, but using a newline character as the delimiter
+between the key and the value and using a null character after each value.
+This format is better suited for being parsed by another applications than
+`keyvalue`. Unlike in the `keyvalue` format, the values are never quoted.
 
 INFO KEYS
 ---------
-
 In order to obtain a set of values from `git repo info`, you should provide
 the keys that identify them. Here's a list of the available keys and the
 values that they return:
@@ -49,6 +56,23 @@ The reference storage format. The valid values are:
 +
 include::ref-storage-format.adoc[]
 
+EXAMPLES
+--------
+
+* Retrieves the reference format of the current repository:
++
+------------
+git repo info references.format
+------------
++
+
+* Retrieves whether the current repository is bare and whether it is shallow
+using the `nul` format:
++
+------------
+git repo info --format=nul layout.bare layout.shallow
+------------
+
 SEE ALSO
 --------
 linkgit:git-rev-parse[1]
diff --git a/builtin/repo.c b/builtin/repo.c
index 3c9140593b..8c6e7f42ab 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -9,12 +9,17 @@
 #include "shallow.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [<key>...]",
+	"git repo info [--format=(keyvalue|nul)] [<key>...]",
 	NULL
 };
 
 typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
 
+enum output_format {
+	FORMAT_KEYVALUE,
+	FORMAT_NUL_TERMINATED,
+};
+
 struct field {
 	const char *key;
 	get_value_fn *get_value;
@@ -65,7 +70,9 @@ static get_value_fn *get_value_fn_for_key(const char *key)
 	return found ? found->get_value : NULL;
 }
 
-static int print_fields(int argc, const char **argv, struct repository *repo)
+static int print_fields(int argc, const char **argv,
+			struct repository *repo,
+			enum output_format format)
 {
 	int ret = 0;
 	struct strbuf valbuf = STRBUF_INIT;
@@ -86,8 +93,18 @@ static int print_fields(int argc, const char **argv, struct repository *repo)
 		strbuf_reset(&quotbuf);
 
 		get_value(repo, &valbuf);
-		quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
-		printf("%s=%s\n", key, quotbuf.buf);
+
+		switch (format) {
+		case FORMAT_KEYVALUE:
+			quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
+			printf("%s=%s\n", key, quotbuf.buf);
+			break;
+		case FORMAT_NUL_TERMINATED:
+			printf("%s\n%s%c", key, valbuf.buf, '\0');
+			break;
+		default:
+			BUG("not a valid output format: %d", format);
+		}
 	}
 
 	strbuf_release(&valbuf);
@@ -95,10 +112,27 @@ static int print_fields(int argc, const char **argv, struct repository *repo)
 	return ret;
 }
 
-static int repo_info(int argc, const char **argv, const char *prefix UNUSED,
+static int repo_info(int argc, const char **argv, const char *prefix,
 		     struct repository *repo)
 {
-	return print_fields(argc - 1, argv + 1, repo);
+	const char *format_str = "keyvalue";
+	enum output_format format;
+	struct option options[] = {
+		OPT_STRING(0, "format", &format_str, N_("format"),
+			   N_("output format")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
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
index 78766a3f4f..a4ec6b42df 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -21,12 +21,22 @@ test_repo_info () {
 	key=$4
 	expected_value=$5
 
-	test_expect_success "$label" '
-		eval "$init_command $repo_name" &&
-		echo "$key=$expected_value" >expected &&
-		git -C $repo_name repo info "$key" >actual &&
+	repo_name_keyvalue="$repo_name"-keyvalue
+	repo_name_nul="$repo_name"-nul
+
+	test_expect_success "keyvalue: $label" '
+		eval "$init_command $repo_name_keyvalue" &&
+		echo "$key=$expected_value" > expected &&
+		git -C "$repo_name_keyvalue" repo info "$key" >actual &&
 		test_cmp expected actual
 	'
+
+	test_expect_success "nul: $label" '
+		eval "$init_command $repo_name_nul" &&
+		printf "%s\n%s\0" "$key" "$expected_value" >expected &&
+		git -C "$repo_name_nul" repo info --format=nul "$key" >actual &&
+		test_cmp_bin expected actual
+	'
 }
 
 test_repo_info 'ref format files is retrieved correctly' \
@@ -77,4 +87,10 @@ test_expect_success 'git-repo-info outputs data even if there is an invalid fiel
 	test_cmp expected actual
 '
 
+test_expect_success 'git-repo-info aborts when requesting an invalid format' '
+	echo "fatal: invalid format ${SQ}foo${SQ}" >expected &&
+	test_must_fail git repo info --format=foo 2>err &&
+	test_cmp expected err
+'
+
 test_done
-- 
2.39.5 (Apple Git-154)

