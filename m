Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E8C13AD1E
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 21:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746172; cv=none; b=gK8gav5ibHowWlvZD9CuIwdB6dGTVvWthSU3JZrl6k1tsx7a1Eh8yu6T+VAPKnYyqX0/9tT9TOFstZ9jj65PdX6UdMwjX2Lb4yU/po8nR0XoCo2y3a6jLOaHpCuxuubkDSG/VARMNDO0KXZXFnaFum33KRxHUvtCCLwuvWonz7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746172; c=relaxed/simple;
	bh=CDo+f/jeqcnFWm+SosfSCI3kwzPXsV1gbWfGwMVcWMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnHLx6iZXC1kN4FGI2waJZldYSBFCkjqm5EUyCZcKtwECx8lGodi/w4tv6qiHmy16U9D/im9UkxKx7Xrkr/f6XWG6hD9yrNKXaELkqYhfWQzbdo6T0uZhX7j3v7wgiyK5zR/I0h482SF2I48dC/rOB80heBm8H+QIiTM43t5030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQWSOtuM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQWSOtuM"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e0f2798cd8so20964615ad.3
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 14:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711746170; x=1712350970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdXv6zFewObycaDa3BGUf1Ki/nEP6niYmGnn7nsxykA=;
        b=KQWSOtuMUi4UXmlrMzv/zLZa3Ih/h9UwmNIBFs2VOXO6appp/t3JwlZ/nEUyk8YWg1
         VY7nVZTZzcHszfZ1rG8k8SvSgG2Ay7M+vu4Mzi9Xh8X0EU80m9jFZE9rq+6/s75g+3ot
         VGC1vEEVbfE9lpioUKEOhGg4WU8RKH9p6BX+K4xvwIMVq9/gulM+ke47/2j9E0MAhV76
         Gw/dL3pYEb6Z4uNkpmUHMa7IquHbil3xSm7kNzhnXH2Gd1jbBxS7htFX+snq22MfGMap
         Q7Hgu0XwFwqO5TgWCVRkWfU+XN/slZiXj3dSmN0FiFqRw5uxVAi146/SFmIakmjd6ZB3
         aWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711746170; x=1712350970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdXv6zFewObycaDa3BGUf1Ki/nEP6niYmGnn7nsxykA=;
        b=Dkz6ytZ16pmibkqqBR0zaI76FTOALorbwTAL4i8LXZtug4QKVTp2uF/vu0+9Km93gu
         6CIW1Nyxp7cpKfpEGSWYAjDR41EQEEl9tOmnrs2qR6LrbEecFwjpdedxYEcg+JjenaUD
         4z55U648JYIST4ESgzDN6yUJct7QL52KRkl7fnhMHZUVqIhtaMueFXrBNo+iqwup8hi+
         OTdfn5ztpR8JBDa/0QuRo4aFkW3DZGjJbiqT0HXJ8//s7o0PLQKbab2wF5tm6aoZtKSX
         s4/C7o+P1zhn+/ctO0H17DvoQQSudSYHn6x5nBPR2y17cFi+eKWId4bQTTs9vGoVnp7g
         NFTw==
X-Gm-Message-State: AOJu0YwgkWg2yV0qPrOrHgSpamCl6a3fEJZ42T7JykuWnFNsQ5he1Wvi
	bgCu1mbboJVzJFOkzBmgHi+Ody97JbCvXnqvtnvSGP3tu5E2Rkc08KYghRybtnc=
X-Google-Smtp-Source: AGHT+IFnnyzauu5fcBzhxYK9newmBBajP4YVEq9LSVz3vIMkyY1Z2jjjENyTCp+4l7byicrTt0knNA==
X-Received: by 2002:a17:902:ecd2:b0:1dd:a3d4:9545 with SMTP id a18-20020a170902ecd200b001dda3d49545mr4203499plh.54.1711746169726;
        Fri, 29 Mar 2024 14:02:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b001e020a47fe9sm3875327plr.261.2024.03.29.14.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 14:02:49 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v2 3/3] builtin/add: error out when passing untracked path with -u
Date: Sat, 30 Mar 2024 02:26:21 +0530
Message-ID: <20240329205649.1483032-5-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318155219.494206-2-shyamthakkar001@gmail.com>
References: <20240318155219.494206-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When passing untracked path with -u option, it silently succeeds. There
is no error message and the exit code is zero. This is inconsistent
with other instances of git commands where the expected argument is a
known path. In those other instances, we error out when the path is
not known.

Therefore, fix this by passing a character array to
add_files_to_cache() to collect the pathspec matching information and
report the error if a pathspec does not match any cache entry. Also add
a testcase to cover this scenario.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 builtin/add.c         | 9 ++++++++-
 t/t2200-add-update.sh | 6 ++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index ffe5fd8d44..650432bb13 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -370,6 +370,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int add_new_files;
 	int require_pathspec;
 	char *seen = NULL;
+	char *ps_matched = NULL;
 	struct lock_file lock_file = LOCK_INIT;
 
 	git_config(add_config, NULL);
@@ -547,15 +548,20 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		string_list_clear(&only_match_skip_worktree, 0);
 	}
 
+
 	begin_odb_transaction();
 
+	ps_matched = xcalloc(pathspec.nr, 1);
 	if (add_renormalize)
 		exit_status |= renormalize_tracked_files(&pathspec, flags);
 	else
 		exit_status |= add_files_to_cache(the_repository, prefix,
-						  &pathspec, NULL,
+						  &pathspec, ps_matched,
 						  include_sparse, flags);
 
+	if (take_worktree_changes)
+		exit_status |= report_path_error(ps_matched, &pathspec);
+
 	if (add_new_files)
 		exit_status |= add_files(&dir, flags);
 
@@ -568,6 +574,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("unable to write new index file"));
 
+	free(ps_matched);
 	dir_clear(&dir);
 	clear_pathspec(&pathspec);
 	return exit_status;
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index c01492f33f..7cba325f08 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -65,6 +65,12 @@ test_expect_success 'update did not touch untracked files' '
 	test_must_be_empty out
 '
 
+test_expect_success 'error out when passing untracked path' '
+	echo content >baz &&
+	test_must_fail git add -u baz 2>err &&
+	test_grep -e "error: pathspec .baz. did not match any file(s) known to git" err
+'
+
 test_expect_success 'cache tree has not been corrupted' '
 
 	git ls-files -s |
-- 
2.44.0

