Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9347F1F8755
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271806; cv=none; b=J60u9AxoOzmE2euRTegJnlDHq+xzpccEkW+hEOcKJeVMQjSmr1Pxs0QQgeuCijKmRITndpPgZk8DvSuxh/RvJzHoPev+yHkFq03pVQk7qNaXUWjnC0gTOkmCwUk31oRKIpGCEDCcF+PuSNA9OpYXFg6SMJV0IfvqgeiLi3HczPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271806; c=relaxed/simple;
	bh=XmRzTNb+TtBiIwlERzCqgoOrd+gOkgMnBaXE20037wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WL1btWMeBT9dVCbDY7dJKoW5KDRgK/qX4dIh/qSqShH1fAhEyrBWE/+4sSZMYGm/lJGkk8mK0tX1DvBdE8yoP6LjLiQR8wODMgWoOWVATFDOImrtIYzt5+vcTZaFUuw8bbU7Vr2KsrgAl1WiNjGoyvJjAEUO7v6o7t08tMD3u0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/AVrpzI; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/AVrpzI"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2e629fc4so2201224b3a.0
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 08:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755271804; x=1755876604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsEj/Emi1QPBxlYA0SIu92E47mC87XqEofXe68N1SHY=;
        b=R/AVrpzIDQJHnRpJLvkmfQ1bB7QcTb5TWm2+GxphRy0aZ9/04vnJ30L70f7GDWvH7R
         BsvE82LAllpoTjZYwxCRqG/ndb71KHicfnKh/Q7ENufKRCYlUokW7Hj9SmfxlUTL7w68
         P1xt2nnviV0yZ/EQZL49+8AQ8wZnz8/WFpqnuScdOafaga4qKJyTA+77NDFm3LrtbFTP
         VHQCS4EOKTDE+1Bgn2uVMbU/9xPbPBbYYets9Lls7/yRRhituGIXU5Mm5S1iThSk1+gf
         Zc0XtPg8UMkrdn7nYwJ3BaGHTsE9V3C41OZV9p27KdeL1HMjya+Ga9UGcLKPpIF/EKU6
         Pynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755271804; x=1755876604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsEj/Emi1QPBxlYA0SIu92E47mC87XqEofXe68N1SHY=;
        b=w8hgNPIWrfPa+V06GKFYgbvbTR6g8YuNls+gGUn8QXi4vY0azFwox/0mxD1IQvoYeK
         7tgfT/Q3F3XzI2PJdK/r886dQhF4EO/okGs9FDrdnSLA5RUK90q1FR/9qN+pulcek7le
         z8kD2YI+xjCCpqpunQdcYt8f62E1+sgy5r1oru4E+xg0QCfz7HdBHyf3f8/rWQsq8fnK
         8YYg+9iF/UZsJR2/DQ6qN1tLFpkGLXP7HEeQzpaqicMRx2Tlsrdv8GPiM99SOH2BPZ7H
         cYQoTAMmUe7i6LFX/uLzzsOOgVWtVOKXkLISBz8XvjnfWPhwiWxwFPBEBKus3L0WPz9T
         iXdw==
X-Gm-Message-State: AOJu0Yxo+26IhCVxF6xwjeK3hXH43bg+c8dsvKkIrJgkS9cRHEpTHaxn
	3Obp/ghYfgjYHXUNCzNicK378u11HeJogOZKkQzlafQfmNdc4WuVH2kiPejUVg==
X-Gm-Gg: ASbGnctmudOGeM7fBUxIj3MJz3d6TJ1MulOBijVkNbTXQ0UT5NGBUTnwOJTVnmrfLfx
	t9YziZlsnLur3ASlMsrkQkJyseTNbzUjX2q55RBF4H/rFi0nFkTRlGB4YB9bIBkSjHw5BGAenWe
	RK1QEm5n3185Tzxo992JwV9rfdVM5ydpGTZ/cp5Lpkosa2Rj5cRqTf5Cx4BLiuu1fjbhwGVkbPS
	5YydV+1ALisnQNx/PA56SfQonFZ49rC7Ff9sN8JMbURRyV5oIr6e5FoxlYpgiFXjdMvtCeFddIo
	PwOa9L3MpTo95GsPj5WFSuDRdeB96rjz284YsiA0Z6LPQhLeCoDsG3i/QjtyHM4hqcNA3FACzY4
	5cDgvyhuPob7RiNyEHLsgjF4gBnQshKnbnZOWbpfp+kZtImBJeizsgVG24T7RGw==
X-Google-Smtp-Source: AGHT+IFdZ8tq5FBa0/2hfxD/nSP99BBkCcs0VC0W2xDtqx2G0DCZ5ky8eU4dRs1TBFFa2AiuF1NBVA==
X-Received: by 2002:a05:6a00:4650:b0:76b:fbf4:b9d8 with SMTP id d2e1a72fcca58-76e4484e7c0mr3438617b3a.22.1755271803575;
        Fri, 15 Aug 2025 08:30:03 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8e83:7089:f932:3359:f50e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e452666besm1393260b3a.1.2025.08.15.08.30.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 Aug 2025 08:30:03 -0700 (PDT)
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
Subject: [GSoC PATCH v10 3/5] repo: add the field layout.bare
Date: Fri, 15 Aug 2025 10:55:19 -0300
Message-Id: <20250815135521.44044-4-lucasseikioshiro@gmail.com>
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
 t/t1900-repo.sh             | 17 +++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index a708c70a3d..d26c01a21b 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -38,6 +38,9 @@ In order to obtain a set of values from `git repo info`, you should provide
 the keys that identify them. Here's a list of the available keys and the
 values that they return:
 
+`layout.bare`::
+`true` if this is a bare repository, otherwise `false`.
+
 `references.format`::
 The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index 73d4e27a16..aada476e1c 100644
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
 
 /* repo_info_fields keys must be in lexicographical order */
 static const struct field repo_info_fields[] = {
+	{ "layout.bare", get_layout_bare },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index dca4023a00..8368a168b6 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -35,6 +35,23 @@ test_repo_info 'ref format files is retrieved correctly' \
 test_repo_info 'ref format reftable is retrieved correctly' \
 	'git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
 
+test_repo_info 'bare repository = false is retrieved correctly' \
+	'git init' 'nonbare' 'layout.bare' 'false'
+
+test_repo_info 'bare repository = true is retrieved correctly' \
+	'git init --bare' 'bare' 'layout.bare' 'true'
+
+test_expect_success 'values returned in order requested' '
+	cat >expect <<-\EOF &&
+	layout.bare=false
+	references.format=files
+	layout.bare=false
+	EOF
+	git init --ref-format=files ordered &&
+	git -C ordered repo info layout.bare references.format layout.bare >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git-repo-info fails if an invalid key is requested' '
 	echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
 	test_must_fail git repo info foo 2>actual_err &&
-- 
2.39.5 (Apple Git-154)

