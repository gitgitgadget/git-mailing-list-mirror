Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93574441056
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140494; cv=none; b=F+1ZgJBFu/l7BVeID9MBnuUZZlHTHbc8VpJrxfwL1ACW8UaniDAbu8CXsJ0E0FC3PNARGcAz6lo+wC7XPpuA1NEF/2OxZL/jaruWqeSc9fZxiNaqtUjcT2Q3jTeyim2+0yVtQCoAgQJhjk3D2AYXrbhCSLdzavra3ujXyO25u/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140494; c=relaxed/simple;
	bh=Br9fh4xYZp/0+MMbJVSZzLA+hlTvy+PAmwgycQT9I3I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G4/H+lNR81Qzk0scjyvKH7HQtdEmkUy3PjRB5Q7Adqsxt/M/nMtdVyXTnD7sY2ssQYee3kevPHZgDxdxyiMPuc7MlKEHI3RKeiv090Yc4bgnh4Vk2M3l9pzuQne5NxuuNMuNMMq4aiTkPlv8j0W1WzzN9Rx9HNVEs7RChE9mG1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYcYyMod; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYcYyMod"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cb5138df1aso134445185a.3
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 13:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772140490; x=1772745290; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyHey4t4KqYE+27pGtOhB2Kz5WT8ieoG1Bb3LiW+6fE=;
        b=iYcYyModlOoBKArqk04302rJGAjJZVdRaxIqkX+Iu9XApwnnSALQ8dzRiY3sckEfeM
         tonjhWTL3AoYRlDlvFImdpQMgJLtBi/YWZd+XlJsg57T8GhjGczZuZdL6WGDN8JR+VPQ
         rdPK3SDeBzDSBk6QgDl+NPhVfTdw7qhVQb7btSTDJFnp4lzSK2i1NwGxnrpIWUYVAy8L
         qWGKLhacAw+KIGpRC8HfQuvZ6RF8jZ8Ko7RZOgBzOrmDprZ2NXdkP3FLpiml8hofItDf
         iSS1A0874BOG1J5hRkfPF2k789yYZprumaqUXGj4ODrmLaPsfihxQRbZpBEHPJC83/sv
         tssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140490; x=1772745290;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dyHey4t4KqYE+27pGtOhB2Kz5WT8ieoG1Bb3LiW+6fE=;
        b=WXc+9JBJ1syIiHmuRE+BZ/JGPEW+9An4FW9rvHtM9LN9ud02OMnyIv8ura7tVgtPX7
         JlYPGykSJSHMdNPgamQQtbbLO7jh3h7LsJrQtW8jyGVY/UeceGSRcbP0nEzxhQmNPENE
         aEX3B8iBxIT6BQeQ1R0z9jvBMoufqH+GYTe7LWv+7nEZAEfCSuCFjuKePuJNDlAfTTil
         kBDDXZ7UvADSJBhhZ7APL549rcTNIBi9dVj3LaRFm7v0SdGxHrzVLQVYrzOpzKjpKU5L
         StD8J9+N9N7mqg97vLABxfuhuIzGWFUaHCts65Fq2rbCtxpWNFfUGLZLL8ytpd64GnSv
         pNwQ==
X-Gm-Message-State: AOJu0Yxs9qKfqnIeO58rcFG2z6YNyjmMO9VEggple4l51y8p1JO2UpKL
	YkUFxX8+VZ4hsOTUNjr7AXDh3yfobIR/J5OLOneq5dt3LwjWwOf0sQQluEPtCA==
X-Gm-Gg: ATEYQzx8OS09qARqhXK3j2iEa2CkWedwEUOh8QXiO+KGVqMiEQDYvkawowXhdmoewof
	5Rq+D6c2Dv+iV/XQ8FMzxGeRBuoybOaDlm4wySGXjg4MyVOStaLxXpgO3m6Y1xsOqqXhkc7/baU
	01MocnFm7dboAgrGV5QrplfUlzox2uzy4tjmxygWYHscIfFtRzBUI5GsEHTHyfhYPognbIq8Sj9
	Q4Ipbo27lH28iBVtCYJJBWxkmT1tdQGE8UbEs8jWJo8d2l396KzX7UUr6oxL+535M3ei8byhFXw
	hsbuvDXmjb9Ae1CzRi5WqOjCsRhhHFEhKVbRXzta6YdLu3hNb6EsWEdF+yqfVxqA9WXEFuyUkeb
	OaKWh6PtqSFJvzb3IMu9u0Ib3mxcO4dJpOZIFkn89jh1TjyELMZ04YFYmnfCSoZcaTmqaoC5q+r
	lStEWEkBGDk5xGFIAKSazVB33lRQ==
X-Received: by 2002:a05:620a:2949:b0:8c6:a64e:92b4 with SMTP id af79cd13be357-8cbc8e41e34mr57310985a.78.1772140489803;
        Thu, 26 Feb 2026 13:14:49 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6f873dsm321169185a.25.2026.02.26.13.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:14:49 -0800 (PST)
Message-Id: <99c8058298d403508ab2a23ed06c36b8707989d0.1772140487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
References: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
	<pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 21:14:38 +0000
Subject: [PATCH v4 01/10] repo: teach info context and category keys
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Introduce an explicit repo_info context for the repo info codepath
and thread it through value lookups and field printing.

This removes direct coupling from these helpers to ad-hoc
repository globals and makes key retrieval logic easier to extend
safely.

Also teach git repo info to accept category names (for example,
layout) and expand them to matching key.* entries in request
order.

This improves script ergonomics while preserving existing behavior
for explicit keys and clear errors for unknown names.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 builtin/repo.c | 70 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 0ea045abc1..e34914a9a7 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -22,7 +22,12 @@ static const char *const repo_usage[] = {
 	NULL
 };
 
-typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
+struct repo_info {
+	struct repository *repo;
+	const char *prefix;
+};
+
+typedef int get_value_fn(struct repo_info *info, struct strbuf *buf);
 
 enum output_format {
 	FORMAT_TABLE,
@@ -35,27 +40,30 @@ struct field {
 	get_value_fn *get_value;
 };
 
-static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
+static int get_layout_bare(struct repo_info *info UNUSED, struct strbuf *buf)
 {
 	strbuf_addstr(buf, is_bare_repository() ? "true" : "false");
 	return 0;
 }
 
-static int get_layout_shallow(struct repository *repo, struct strbuf *buf)
+static int get_layout_shallow(struct repo_info *info, struct strbuf *buf)
 {
+	struct repository *repo = info->repo;
 	strbuf_addstr(buf,
 		      is_repository_shallow(repo) ? "true" : "false");
 	return 0;
 }
 
-static int get_object_format(struct repository *repo, struct strbuf *buf)
+static int get_object_format(struct repo_info *info, struct strbuf *buf)
 {
+	struct repository *repo = info->repo;
 	strbuf_addstr(buf, repo->hash_algo->name);
 	return 0;
 }
 
-static int get_references_format(struct repository *repo, struct strbuf *buf)
+static int get_references_format(struct repo_info *info, struct strbuf *buf)
 {
+	struct repository *repo = info->repo;
 	strbuf_addstr(buf,
 		      ref_storage_format_to_name(repo->ref_storage_format));
 	return 0;
@@ -87,6 +95,33 @@ static get_value_fn *get_value_fn_for_key(const char *key)
 	return found ? found->get_value : NULL;
 }
 
+static void print_field(enum output_format format, const char *key,
+			const char *value);
+
+static int print_category_fields(const char *category,
+				 struct repo_info *info,
+				 enum output_format format,
+				 struct strbuf *valbuf)
+{
+	int found = 0;
+	size_t category_len = strlen(category);
+
+	for (size_t i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
+		const struct field *field = &repo_info_fields[i];
+
+		if (!starts_with(field->key, category) ||
+		    field->key[category_len] != '.')
+			continue;
+
+		strbuf_reset(valbuf);
+		field->get_value(info, valbuf);
+		print_field(format, field->key, valbuf->buf);
+		found = 1;
+	}
+
+	return found;
+}
+
 static void print_field(enum output_format format, const char *key,
 			const char *value)
 {
@@ -105,7 +140,7 @@ static void print_field(enum output_format format, const char *key,
 }
 
 static int print_fields(int argc, const char **argv,
-			struct repository *repo,
+			struct repo_info *info,
 			enum output_format format)
 {
 	int ret = 0;
@@ -117,21 +152,22 @@ static int print_fields(int argc, const char **argv,
 
 		get_value = get_value_fn_for_key(key);
 
-		if (!get_value) {
-			ret = error(_("key '%s' not found"), key);
+		if (get_value) {
+			strbuf_reset(&valbuf);
+			get_value(info, &valbuf);
+			print_field(format, key, valbuf.buf);
 			continue;
 		}
 
-		strbuf_reset(&valbuf);
-		get_value(repo, &valbuf);
-		print_field(format, key, valbuf.buf);
+		if (!print_category_fields(key, info, format, &valbuf))
+			ret = error(_("key '%s' not found"), key);
 	}
 
 	strbuf_release(&valbuf);
 	return ret;
 }
 
-static int print_all_fields(struct repository *repo,
+static int print_all_fields(struct repo_info *info,
 			    enum output_format format)
 {
 	struct strbuf valbuf = STRBUF_INIT;
@@ -140,7 +176,7 @@ static int print_all_fields(struct repository *repo,
 		const struct field *field = &repo_info_fields[i];
 
 		strbuf_reset(&valbuf);
-		field->get_value(repo, &valbuf);
+		field->get_value(info, &valbuf);
 		print_field(format, field->key, valbuf.buf);
 	}
 
@@ -171,6 +207,10 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			 struct repository *repo)
 {
 	enum output_format format = FORMAT_KEYVALUE;
+	struct repo_info info = {
+		.repo = repo,
+		.prefix = prefix,
+	};
 	int all_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
@@ -192,9 +232,9 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 		die(_("--all and <key> cannot be used together"));
 
 	if (all_keys)
-		return print_all_fields(repo, format);
+		return print_all_fields(&info, format);
 	else
-		return print_fields(argc, argv, repo, format);
+		return print_fields(argc, argv, &info, format);
 }
 
 struct ref_stats {
-- 
gitgitgadget

