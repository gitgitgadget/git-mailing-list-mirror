Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3812309F1D
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 05:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772428560; cv=none; b=tf5h/FdbWvscwglUpUOJltkOgDG28JymMVPuw+H8cjBGdLV+hOzkk8kybggZQSgNMxkaCtoAsijAMiDTTytdnw2LtaCE11YUNow31ywWVFW+mjAe5KVkbNPqyVgLlUtt3arNgsNEcf6svLIKQKi4V8nVLMEjLi2N29+AaitS834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772428560; c=relaxed/simple;
	bh=rYaPcoN9d1Sa7h+NSXgG127wcLmHw9ki3PgQX/D8Q/g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XZMHunrdJvti7mbKVQvMwcGmFf12GmhYZXsJMQxREt9ZTQ9Ya7cALjhUBGxMOxh098h/WXWY4JP93cTXE7a7rIyF5vW7Ps7KQYz9/tS5YDuTUbfmY377GKV9Ehh1c/Vh+7AtT7Z+qt31CXpjS5nNmxz7gX2jE4pj6ggyFiOtnG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSl01NGg; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSl01NGg"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb39f64348so400790585a.0
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 21:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772428558; x=1773033358; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+UxtNmpBEhaV0i8IG40XlbHGVuKABN3p0yOW9DFDGs=;
        b=mSl01NGgUfC2W9t6mb5Dq66jahHhqjC65FI84rosKUpkvnliRzIfIf1WKmXTadnSPn
         ZGExII9VY6KWkpih8vtspFCFki6BBl6KAZ2lN+mWpb88j02atLMNx+NG9FJkbCfLZfaw
         0Ww9cJCp0uZeIBbaFekT9a8duCgf0Tmbj8K9xZYrgRAZvFTM4JrfvnmQpFoVW1xBmfTR
         ac67GYrFRJpTP/DLH86fyH5oZtLNTUsTuKuFCekkgj2W8Ob+4qH5uG+GO+6tCQ4Tc4AE
         +41zuGHafhSHi7AsMGjE6RK0u7z4H14+04j4BA+7fUQCeVo9rD5sg7BL0rcm8x3RacMl
         o4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772428558; x=1773033358;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z+UxtNmpBEhaV0i8IG40XlbHGVuKABN3p0yOW9DFDGs=;
        b=wxYSv/LhkFlD3PrldwvKBNo+Y2iUaR2MBhXStQ3AkX6PWHSmwicF1QmmCoNn95VDUy
         pBZB5Yj3BSQk9SNNW/+qUo2n18sD+Li+t339ztjJOdkx9YuT5ED7KvoyZZzyQBgs6Ww8
         bymM/at1cSOS76KJN52clXLvwJEXEGiLGkPV5b1YIMhGeHFmk3XmC6QbU6bGWkikSPku
         Zqgwnd5XOJo7sJWaxtcca+LgRJCM5NP9cDzGNqzri2xOZx/cichZy0XugbO7G4gfShwY
         wPTgz/EnlexAXb6Vt6QngJ/8fiW9+iTgvtr7KhiZffg/ljuWQuQ1IORECh2GnwaxlxYg
         OMHQ==
X-Gm-Message-State: AOJu0Ywqk0XogeqGrrEu2fXIlcFjHtfKZYU18HMIs4lgRHlG52JGsRpV
	sPxSH6egf3qlLfNz2WNF2phT/t3098ruTkHzmI5KUYX0+WuCJTogmqIIGX3JT/Qg
X-Gm-Gg: ATEYQzxfqE7FKoKIOJ67QeYqKfOZrgCdun6yTb2DMs92tfTIg3DBixauWQl0oq0AkKn
	sioOyWwTM79L1D3iRttGSvNDgkJzacUnec9VpQn7aCg9zvVlZ9IM7VhTS4Fj/fE/LVU79QoIXs1
	3mGyg6u5JKSVmd/uCxqs8TrpppT6b7dUMyY6sXewzuDX+uZtFIqIiXMTCdTOqdkiemt69CH/D1C
	NTlMIslN6b4G20wbh+K1VIf5F9PC9Qa+75MsRg8dau1FBb471DeUvxIOlNDnrCx9DmfCwRrXyae
	Xt/fVvGJc1wNUgWQrrGfARQWIYrPddl2kNHP7M80JVrY+/ovIBm81/yF2wWS+gjEYCQ3R5pUrxx
	pYx6lp0Ih0bbKgE17MHAnAsKmqdq5HDvQXKNaI7/8sQG1wf922mTPhlkT7Ba9YiBUg9U6ynjqhR
	zyJO28JrrMn04DCsovNrh2+HL+dQ==
X-Received: by 2002:a05:620a:4892:b0:8c7:7a3:501c with SMTP id af79cd13be357-8cbc8df715fmr1362914485a.52.1772428558070;
        Sun, 01 Mar 2026 21:15:58 -0800 (PST)
Received: from [127.0.0.1] ([172.183.95.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf678156sm1183761485a.18.2026.03.01.21.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:15:56 -0800 (PST)
Message-Id: <2a7afe4f877d4cad361dbb0d68d86ceab9448edf.1772428548.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com>
References: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
	<pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 05:15:46 +0000
Subject: [PATCH v6 4/6] repo: add --path-format for info path output
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Teach git repo info to accept --path-format=(absolute|relative)
so scripts can request stable path style explicitly.

This aligns path.* output behavior with existing rev-parse usage
patterns and reduces ad-hoc path conversion in callers.

The option is wired through repo_info context and used by
repo_info_add_path(), so path formatting remains centralized and
consistent across all path.* keys.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 builtin/repo.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 87c5850929..bcdb9210cb 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -20,15 +20,21 @@
 #include "utf8.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]",
+	"git repo info [--format=(lines|nul) | -z] [--path-format=(absolute|relative)] [--all | <key>...]",
 	"git repo info --keys [--format=(lines|nul) | -z]",
 	"git repo structure [--format=(table|lines|nul) | -z]",
 	NULL
 };
 
+enum path_format {
+	PATH_FORMAT_ABSOLUTE,
+	PATH_FORMAT_RELATIVE,
+};
+
 struct repo_info {
 	struct repository *repo;
 	const char *prefix;
+	enum path_format path_format;
 };
 
 typedef int get_value_fn(struct repo_info *info, struct strbuf *buf);
@@ -48,6 +54,16 @@ static void repo_info_add_path(struct repo_info *info,
 			      struct strbuf *buf,
 			      const char *path)
 {
+	if (info->path_format == PATH_FORMAT_RELATIVE) {
+		char *cwd = xgetcwd();
+		struct strbuf rel_path = STRBUF_INIT;
+
+		strbuf_addstr(buf, relative_path(path, cwd, &rel_path));
+		strbuf_release(&rel_path);
+		free(cwd);
+		return;
+	}
+
 	strbuf_add_absolute_path(buf, path);
 }
 
@@ -329,6 +345,21 @@ static int parse_format_cb(const struct option *opt,
 	return 0;
 }
 
+static int parse_path_format_cb(const struct option *opt,
+				const char *arg, int unset UNUSED)
+{
+	enum path_format *path_format = opt->value;
+
+	if (!strcmp(arg, "absolute"))
+		*path_format = PATH_FORMAT_ABSOLUTE;
+	else if (!strcmp(arg, "relative"))
+		*path_format = PATH_FORMAT_RELATIVE;
+	else
+		die(_("invalid path format '%s'"), arg);
+
+	return 0;
+}
+
 static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			 struct repository *repo)
 {
@@ -336,6 +367,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	struct repo_info info = {
 		.repo = repo,
 		.prefix = prefix ? prefix : "",
+		.path_format = PATH_FORMAT_ABSOLUTE,
 	};
 	int all_keys = 0;
 	int show_keys = 0;
@@ -347,6 +379,9 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			       N_("synonym for --format=nul"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       parse_format_cb),
+		OPT_CALLBACK_F(0, "path-format", &info.path_format,
+			       N_("format"), N_("path output format"),
+			       PARSE_OPT_NONEG, parse_path_format_cb),
 		OPT_BOOL(0, "all", &all_keys, N_("print all keys/values")),
 		OPT_BOOL(0, "keys", &show_keys, N_("show keys")),
 		OPT_END()
-- 
gitgitgadget

