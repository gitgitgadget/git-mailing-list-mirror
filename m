Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653A812CD88
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753144166; cv=none; b=Js0OzI/48YHP5CCQDbK6Bnn1AjM3A5+PRMoqv1HCNqWZj6pwSGvhxO/0wKTAkVliKXabKDD0hfTUzwM0YuAT1OAYGbDtOTs1ed+7b6huBFx8mgkYy/AX/7mk+/IKy5HT0xS2cXw2aZNdlKsbaRfYfozChPnqEv24FdVqYuPd9lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753144166; c=relaxed/simple;
	bh=zl9l8wnXXLIDpXGdjd7+osW2fB/IxeJ1K9zuI9MeK5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tYcHcvb6VSU52qcLDBjNj6gKAuKPHm6RoLArFeN2zjCJTUOVZuS7kqoafoug/2+mNxXcUU2rsyL00mYVK+x9lkLxbs2Ie3XRzVAlonbjRbvVSveM1G+inoFXLrbxENFoikUw/zVxDC6FkCvTbM4RZGXxLaMgy5eLGcmaszDACOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1ooWxtS; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1ooWxtS"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4f3162155a4so318181137.2
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 17:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753144163; x=1753748963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ty0OqcDH8YUl/yGMJM5RK7z9lereA1U0s4LKVt6lji8=;
        b=Y1ooWxtSWz7RYVNKrz6rm8hOhgEWse3EoOpUiKJ48PNhtMrzaikcSP++MIF119lS1o
         6cHlCLFS0A0qjaTMpVHjPYBaFc/N5ftMJiPIJHt5RLVGZzeHpczeOB4llqqvnKFrc6F8
         jDmqGyFz7MxqKRMKp6Kj70u+YynGRteoQ/RMlrQQ50Cboskj5OGPWBcYPe1s6/hUN2un
         RI4yIdzwp2nSg8GitI3J63w3D50N8aOD9m9Kg4xos3cQioc50zxQuSHBpbT71d0k0WUi
         Lx/IxP0AQexFccSBOYVNDNVurGaiA7n6j3RJ2pT7A9LsTxm4zhlxCST2eVAOPyLRZf7/
         apgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753144163; x=1753748963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ty0OqcDH8YUl/yGMJM5RK7z9lereA1U0s4LKVt6lji8=;
        b=NI1MauKstvWVC0b3dnuxdGmyKanuCpTdKRJiMKWfBuIIL+lt3q39Eo9hgzgNlbeUA+
         uM8uTs55xSModeTmKOm6IyrMIAcVNzNXZ6+GoRLXPdK0FmTMp0tXZUQ3f5wwd23cv0lG
         Bc03PSyMIEcXOElM8yRmNLJG1+/wmyQeM6e2QRb43fGezWLds/UXV4bi67X60id6ItAl
         ZlrFVYtrDmt6iM4pJrUJuhaeEMDro1MFRH7uiAiAEcvmU8njx82lZSxGtS18MBYVCjwd
         VT0cZ1vvZFBp/3mz4ij+oFaB7Ti2TPfgf8dq7e7l8aAdRE/fKWvH2//R4RyfVuA2wqAy
         y8tA==
X-Gm-Message-State: AOJu0YzeEFJSJw582yh/sXNQ16TuQWtnXvWtWfzX8llCQXAYhF+3BPSV
	Iy1lCj78lpUfsM8YsPJu7mLflUN6U0y3R6QNYjPVFlXZuxpwpKSFqDDmmyiGxg==
X-Gm-Gg: ASbGncvsGe9JTPJra8ejTc7regXgPogNqEA0mAFihTTrndsFcF/Iw7UuJQiSTC+51BU
	ytAQhvFQ9OZ7y3yLXihPjLu2XQeZe/3kYglehhFO1lF2lYO+HKGvbsXA0Wa5mxLt7wLAqchi/AK
	sYByEle2e29t2qqH2RgtVNoHPsxC3n+yBTfEoqAziTN4fILinzeraWM2Gd2gpnywh4Z81YzAww/
	bP7S/nORaHq+LS6n7UxzLLX9pk88RD17kYgZn0HiCZIS8Co1h9MMURSgVSzcKKaC/PoWZfyVsXb
	Sg0hlX+8Vsb5DLydevU4KNvlYA2JXtRi5pX23tnCt+wX0j29j6PRrc0iknMq5+Z1r/ooSQ+BDd3
	IL1/w/2Ut0xoCZhB4IGtKl+A+urJi17EpHWM3qrrQepfN8bkTqpMSTPb7aq2wCV2UVQ==
X-Google-Smtp-Source: AGHT+IFQGsbgfGjqtfZRkcG/M0D5UIF76ulfjSRMIl27Tzi+qfwzJpMesot356jFVzo0p6MdbgVaAA==
X-Received: by 2002:a05:6102:6316:10b0:4f9:6a91:cc95 with SMTP id ada2fe7eead31-4f96a91cec6mr7002774137.27.1753144162988;
        Mon, 21 Jul 2025 17:29:22 -0700 (PDT)
Received: from localhost.localdomain ([179.113.63.169])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b0ad603easm3344169241.16.2025.07.21.17.29.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Jul 2025 17:29:22 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de,
	ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v5 4/5] repo: add field layout.shallow
Date: Mon, 21 Jul 2025 21:28:34 -0300
Message-Id: <20250722002835.33428-5-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250722002835.33428-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com>
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
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc |  1 +
 builtin/repo.c              |  7 +++++++
 t/t1900-repo.sh             | 21 +++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 7124487323..375b956d3f 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -36,6 +36,7 @@ Reference-related data:
 `layout`::
 Information about the how the current repository is represented:
 * `bare`: `true` if this is a bare repository, otherwise `false`.
+* `shallow`: `true` if this is a shallow repository, otherwise `false`.
 
 SEE ALSO
 --------
diff --git a/builtin/repo.c b/builtin/repo.c
index b85bd10889..490fa9dd49 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -4,6 +4,7 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "environment.h"
+#include "shallow.h"
 
 typedef const char *get_value_fn(struct repository *repo);
 
@@ -17,6 +18,11 @@ static const char *get_layout_bare(struct repository *repo UNUSED)
 	return is_bare_repository() ? "true" : "false";
 }
 
+static const char *get_layout_shallow(struct repository *repo)
+{
+	return is_repository_shallow(repo) ? "true" : "false";
+}
+
 static const char *get_references_format(struct repository *repo)
 {
 	return ref_storage_format_to_name(repo->ref_storage_format);
@@ -25,6 +31,7 @@ static const char *get_references_format(struct repository *repo)
 /* repo_info_fields keys should be in lexicographical order */
 static const struct field repo_info_fields[] = {
 	{ "layout.bare", get_layout_bare },
+	{ "layout.shallow", get_layout_shallow },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 03609ffff9..c46ace1fd3 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -42,6 +42,20 @@ test_repo_info 'bare repository = false is retrieved correctly' '
 test_repo_info 'bare repository = true is retrieved correctly' '
 	git init --bare repo' 'layout.bare' 'true'
 
+test_repo_info 'shallow repository = false is retrieved correctly' '
+	git init repo' 'layout.shallow' 'false'
+
+test_repo_info 'shallow repository = true is retrieved correctly' '
+	git init remote &&
+	cd remote &&
+	echo x >x &&
+	git add x &&
+	git commit -m x &&
+	cd .. &&
+	git clone --depth 1 "file://$PWD/remote" repo &&
+	rm -rf remote
+	' 'layout.shallow' 'true'
+
 test_expect_success "only one value is returned if the same key is requested twice" '
 	test_when_finished "rm -f expected_key expected_value actual_key actual_value output" &&
 	echo "references.format" >expected_key &&
@@ -53,4 +67,11 @@ test_expect_success "only one value is returned if the same key is requested twi
         test_cmp expected_value actual_value
 '
 
+test_expect_success 'output is returned correctly when two keys are requested' '
+	test_when_finished "rm -f expect" &&
+	printf "layout.bare=false\nlayout.shallow=false\n" >expect &&
+	git repo info layout.shallow layout.bare >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.39.5 (Apple Git-154)

