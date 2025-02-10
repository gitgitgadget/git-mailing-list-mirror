Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4194E257458
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214952; cv=none; b=VxazUuW+k44BSQiSMWhIXhY/L/1lO8seu+PZQ6Q6bdNWdzFdzBNd8MqKjIchF9nshVgL5bvRL7Ae7gQH+WNxShAp405bdV7vmMpeMS+PVzNrSyol76TdAWH6xBamMKSpIE2eXHTsn6ZsSwwunAUSdt1teTpLRu1H8M39KOWknYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214952; c=relaxed/simple;
	bh=oeEGsG+i0iiLaqKZqyD7SS847ZwCTX9NEQfUxbp0CjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioJRKWi1R8qyZKOW2UXV/iSC7WtPrJDhlydtnDsDYCvxgAt59ZPp4AgNW3jnwgILIla/Lxl0AyVjX5JX8R8pMmDRLUxLXXdH/qpUSHbrFNzkhPfuFQR7hWKYP4A5BvVyJTTJVkYWhjxUh1McovF+aQ2Hlx56B+gFl9vq9fNwT2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=XqIf6omA; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="XqIf6omA"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38dc73cc5acso2178756f8f.0
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 11:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1739214948; x=1739819748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beeVlPqLpm7tn2I9D9dConSLD30jKUzQ93SY3OCsk9o=;
        b=XqIf6omAV+JSuTnsKS3SS82anAI3QE8zXHcv6hQd/cdS/xu0hkLiD5BkXE0R91zRtb
         lqpiEAmmUIELQghQ3i1Odw/KbBb+O6TFx+sPRf0bOrO3hVT+Z2+rYoaeS6HS78VTxFnI
         +4QLlfDCEFjbtxI90KaQ356cX7BgpzD9EJFdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739214948; x=1739819748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beeVlPqLpm7tn2I9D9dConSLD30jKUzQ93SY3OCsk9o=;
        b=HAu1gaZoS0gD3DUqr3GWSAa+tTOgcjVB+o+ogLhXzb180he68o49LqzMBldYXqDFUg
         WVbnNP3/DAy6r7/KdBY5jZMq8+FFDQX8qIyCpll9pWA+qkz+RCcyKSvI5D90IrvPayuD
         +yRby98t0w70uG5wTgio14vOPJjZ9TorPO53mV5WIqdsz9rb8OInq0m1UovbwImsTM1Z
         TUglw74wubjfBXoBtMf3sA9s7Ev4Ofytxl3q7Vi28ypvjPc5Q8sqIkkTb2g3/pkApx3c
         Ex9jfQthaRsLi1Rr08+Vlao42a4/YbWjPcwZj7e2RohEiS46nYa8IW8kFDunt7snLb5T
         70Jw==
X-Gm-Message-State: AOJu0YxEr/CNk2nHcmaEbJZnCl+Q8fqFAFokZ/QV1tYwe3l2ngZLc2x2
	v+4AhjtXSvOfwRmgty5dpDREstB4p+LvktmsUZWEEWl6Whtgsxe1/kE1hrl6Xne4SvqopHrg8ic
	zRyMJeQ==
X-Gm-Gg: ASbGncsxHU8uw26/nP2XAopUi0y2rUNkUa9hdQcgSyWdc+TSd7ukW+h0LNz/Q9vZgXI
	9NiYP9pTY9TtP8gztRc/RAd2irOPf+EYASOItMxcx1DzgwclDN2v5qWf0i6vPQZNx+ab2r65017
	PR4cJu3iCGG+Jg42hRYM95/OluqZg2P6TSA76VoyVAh1n+cMfXCeRmjineMVngUhk0WOJrP5xwN
	ZQSlZVYU/mCPMAPbt02W0eTDc0BEOZ4cHdi2i/IPRpqobVXQdo+y8zSzCZvyoap1E6qIcx6Wdcn
	Je1YGinc5h7Sehr3yRkcOVDriNxsJExSfQ==
X-Google-Smtp-Source: AGHT+IG4/qjF46hZny6U098hnwCqfceogLYzzjWyqX2ztAocRGeEPBoQa8rpf1z6kgHTmkm6OzEhhA==
X-Received: by 2002:a5d:598d:0:b0:38a:8b34:76b0 with SMTP id ffacd0b85a97d-38de43ec4b6mr472900f8f.27.1739214948173;
        Mon, 10 Feb 2025 11:15:48 -0800 (PST)
Received: from able.tailbefcf.ts.net ([91.151.136.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43946bff4d4sm30477055e9.3.2025.02.10.11.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:15:46 -0800 (PST)
From: Ivan Shapovalov <intelfx@intelfx.name>
To: git@vger.kernel.org
Cc: Ivan Shapovalov <intelfx@intelfx.name>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] clean: add `config.exclude` and `--remove-excluded`
Date: Mon, 10 Feb 2025 23:14:39 +0400
Message-ID: <20250210191504.309661-4-intelfx@intelfx.name>
X-Mailer: git-send-email 2.48.1.5.g9188e14f140
In-Reply-To: <20250210191504.309661-1-intelfx@intelfx.name>
References: <20250210191504.309661-1-intelfx@intelfx.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add `config.exclude` to configure "always excluded" files (same as `-e`
on the command line), and `--remove-excluded` (intentionally without a
short form) to "REALLY remove everything, dammit!"

This might seem like euphemism treadmill, but there is a specific
use-case for all of the exclusion methods and options:

.gitignore:     files that _the project_ does not want to track or touch
                (build artifacts)
clean.exclude:  files that _the user_ does not want to track or touch
                (IDE configuration)
git clean -x:   remove build artifacts, but keep precious files
                (when a pristine build is desired)
git clean -x --remove-excluded:
                remove everything, including precious files
                (e.g. for redistribution)

Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
---
 Documentation/config/clean.txt | 11 +++++++++++
 Documentation/git-clean.txt    | 22 +++++++++++++++-------
 builtin/clean.c                | 19 ++++++++++++++++---
 3 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/clean.txt b/Documentation/config/clean.txt
index c0188ead4e..eb64ad26fa 100644
--- a/Documentation/config/clean.txt
+++ b/Documentation/config/clean.txt
@@ -1,3 +1,14 @@
 clean.requireForce::
 	A boolean to make git-clean refuse to delete files unless -f
 	is given. Defaults to true.
+
+clean.exclude::
+	Additional exclude patterns that have higher priority than the standard
+	linkgit:gitignore[5] rules and will be honored in (almost) all cases,
+	even if the `-x` or `-X` options are given. These patterns are intended
+	to be used for user-specific "precious" files such as IDE configuration
+	that must not be removed even if a pristine build is desired. This list
+	has the same priority and semantics as the `-e` command line option.
+
+	The `--remove-excluded` command line option can be used to disregard
+	these exclude patterns (intentionally no short form).
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index fd17165416..33d6fb7228 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -59,15 +59,10 @@ OPTIONS
 	Be quiet, only report errors, but not the files that are
 	successfully removed.
 
--e <pattern>::
---exclude=<pattern>::
-	Use the given exclude pattern in addition to the standard ignore rules
-	(see linkgit:gitignore[5]).
-
 -x::
 	Don't use the standard ignore rules (see linkgit:gitignore[5]), but
-	still use the ignore rules given with `-e` options from the command
-	line.  This allows removing all untracked
+	still use the ignore rules given with the `-e` command line option or the
+	`clean.exclude` configuration variable.  This allows removing all untracked
 	files, including build products.  This can be used (possibly in
 	conjunction with 'git restore' or 'git reset') to create a pristine
 	working directory to test a clean build.
@@ -76,6 +71,19 @@ OPTIONS
 	Remove only files ignored by Git.  This may be useful to rebuild
 	everything from scratch, but keep manually created files.
 
+-e <pattern>::
+--exclude=<pattern>::
+	Use the given exclude pattern in addition to the standard ignore rules
+	(see linkgit:gitignore[5]). Exclude patterns can also be configured
+	using the `clean.exclude` configuration variable. These patterns have
+	higher priority than the `-x` or `-X` options and will be honored
+	even in their presence.
+
+--remove-excluded::
+	Disregard the additional exclude patterns provided by `-e` or the
+	configuration variable `clean.exclude`. This flag has the highest
+	priority and intentionally does not have a short form.
+
 Interactive mode
 ----------------
 When the command enters the interactive mode, it shows the
diff --git a/builtin/clean.c b/builtin/clean.c
index ec58338049..eae22a1ec7 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -29,6 +29,7 @@
 static int require_force = -1; /* unset */
 static int interactive;
 static struct string_list del_list = STRING_LIST_INIT_DUP;
+static struct string_list config_exclude_list = STRING_LIST_INIT_DUP;
 static unsigned int colopts;
 
 static const char *const builtin_clean_usage[] = {
@@ -133,6 +134,11 @@ static int git_clean_config(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp(var, "clean.exclude")) {
+		string_list_append(&config_exclude_list, value);
+		return 0;
+	}
+
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
@@ -925,6 +931,7 @@ int cmd_clean(int argc,
 	int i, res;
 	int dry_run = 0, remove_directories = 0, quiet = 0, remove_ignored = 0;
 	int ignored_only = 0, force = 0, errors = 0, gone = 1;
+	int remove_excluded = 0;
 	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
 	struct strbuf abs_path = STRBUF_INIT;
 	struct dir_struct dir = DIR_INIT;
@@ -940,11 +947,13 @@ int cmd_clean(int argc,
 		OPT_BOOL('i', "interactive", &interactive, N_("interactive cleaning")),
 		OPT_BOOL('d', NULL, &remove_directories,
 				N_("remove whole directories")),
-		OPT_CALLBACK_F('e', "exclude", &exclude_list, N_("pattern"),
-		  N_("add <pattern> to ignore rules"), PARSE_OPT_NONEG, exclude_cb),
 		OPT_BOOL('x', NULL, &remove_ignored, N_("remove ignored files, too")),
 		OPT_BOOL('X', NULL, &ignored_only,
 				N_("remove only ignored files")),
+		OPT_CALLBACK_F('e', "exclude", &exclude_list, N_("pattern"),
+				N_("always exclude <pattern> from cleaning (overrides -x)"), PARSE_OPT_NONEG, exclude_cb),
+		OPT_BOOL(0, "remove-excluded", &remove_excluded,
+				N_("remove excluded files, too (overrides -e and clean.exclude)")),
 		OPT_END()
 	};
 
@@ -1016,7 +1025,10 @@ int cmd_clean(int argc,
 	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
 
-	add_patterns_from_string_list(&dir, EXC_CMDL, "--exclude option", &exclude_list);
+	if (!remove_excluded) {
+		add_patterns_from_string_list(&dir, EXC_CMDL, "--exclude option", &exclude_list);
+		add_patterns_from_string_list(&dir, EXC_CMDL, "clean.exclude", &config_exclude_list);
+	}
 
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD,
@@ -1091,6 +1103,7 @@ int cmd_clean(int argc,
 	strbuf_release(&buf);
 	string_list_clear(&del_list, 0);
 	string_list_clear(&exclude_list, 0);
+	string_list_clear(&config_exclude_list, 0);
 	clear_pathspec(&pathspec);
 	return (errors != 0);
 }
-- 
2.48.1.5.g9188e14f140

