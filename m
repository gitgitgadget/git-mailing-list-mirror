Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF19C2472BF
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053895; cv=none; b=rct0WQpVToe1Vx4XhlP+6UGs4vpYJ3HGpY+/HjHk9Qfiv8coeWU/N8+CbO0QfWNpIK/6pQQlnKy2RG3poHGuCV2F5fNHDT6sZLY6Ou2HPiEt8JQXZWRMFnaDNaPXg094nHSTEOH8ciir/3RUxkce3HO7dD0msVM1Jt6DmVEAHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053895; c=relaxed/simple;
	bh=ibk4YGz/C9k/45sNlw1eDPoOy67ktWp3SSOFFsRW2fM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IwGLZWRUUtYeH6aOl7ZvF3rdYuv04R02z1FArNzshrJpL6KSHXFFdfC6btguaPsuTxnbGhfp68NkQH9EyKXq+8gkNKpo08Vyx5dzyIe2d39bt2OOVq7Uca9levyOIJYR9O8ow+NtV7pcKYVjC3dzZwYXWpz/D6CmoUAjdhcpKNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X00UHS1H; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X00UHS1H"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76bddb92dc1so793762b3a.0
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 06:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754053893; x=1754658693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSkw9dZBAjGhGo5Fo9u6KiHFuTBy7j+b7ayIG+YpePU=;
        b=X00UHS1H4skbBMojNkE0jGPuVfqrGxpzVffI1wJDIi9EmYCefQbok617ymsWto5Iam
         74VqXqWl6pZGn+FDXq0R3FlvUP7ewlL+fY5Lr5TOe0ircLbvHrq2XXRoQidT0Z+HcejQ
         fquRgp3xCdWU65X16z0Hhstib6JVk2vQBRFvZA/S+pA6Tw4cQOTbiPsCjariEXlCH02Y
         m9vHhwyX2Pla5Xh36ntfVlhAjfpENb+ArbHMP+FemtxucGiD/Hf7XmOdjg4zxv0zr+/y
         i8auZLImXsxqSQMIuejQsc3pMsiDhjdSKmS+UuitGRCmLHb3Se2O6fCYxX++rN5DbU2O
         P5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754053893; x=1754658693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSkw9dZBAjGhGo5Fo9u6KiHFuTBy7j+b7ayIG+YpePU=;
        b=leGdfhCRGwXS1w3K2q2lz9VEPVBXz+phRfobDxjY1GBtFVOCFnhWBg78pLFMXoFIhp
         WOiquIVkYWKww/Tg/ILXptvp5Gpg4Gt7HzkzH8I2XjqZqYdzgjnM5ONLpF4tKwd3cme2
         i0aQrKXizb5HCEnnTDJ37yMOZobcFTstZI+CyEcU3fwXVPwKLfHGkKpyvilpFJpx0/HL
         5dSrH9Hn2drK10l9LpwZi4sEUE21NQnRaN9US6RHmmumjDcPzqiZsPfjupHJpGAj2+5L
         X8tuTCWg9b7zuWB+UwIdJunJNCKP/MHhD/BB6OlU1lXD+tnOZbtIHrct7yfdfzaW5Ck8
         FtIg==
X-Gm-Message-State: AOJu0YzWwWY62j5Bc6WOs/UlHee1NCwtRP/bqyV0TD+V2RmgNESxHFoE
	iNGCsRe4yOr4N1t7ya2Nyg9PqqhGfJe6xKO56Y1D9SyRxLkj/JI6aBiHoVI/haTA
X-Gm-Gg: ASbGnctSb3t+ozU4eORkHrNLl7a13VqNzlsXKmmiYNfxQrcDuvHQAdzVk+L9SsXADq9
	TxI5vF3TesCdMQG7fNamDeIRdeidFdwsCGh1u7HW3tMTbp5H3/gvEv8y7iUJFLEL64CzHxlJVCo
	+YCkSZG8JKMSbC0F5nVB+M1RtJUZpQww+WsKHwc3W8BpO8Q788GYExy2iOiofNEOs5ajrxCz3CZ
	yLv9G8JTJo1+eYJ4VYwqAFyeI/QDk7XXNO8IySqHE8t5fHskqUyChcN05RPLa7FJQEKTzgg/cCX
	sghNCsn9OXKG9V8TkPUNcPctpts6fGxAlWECn5hoJfqlrSTzOFA4xZJESqOzyg/u0LbEfavOjje
	c/fbmZJiW//kazBUdZbg/wv2obWtz+k2iPejyFZhK6DLjXQWexm/KheWjWRID+TSvnyXnEFfDvk
	dq
X-Google-Smtp-Source: AGHT+IEDGBH69sglql4v9rpK15COHLo7etflGRaKfo45W6oCeacmma9VGR0xwaQlRI/jovdDqvNnxA==
X-Received: by 2002:a05:6300:218a:b0:23d:9f06:3af1 with SMTP id adf61e73a8af0-23dc0ee39fdmr18427179637.35.1754053892765;
        Fri, 01 Aug 2025 06:11:32 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8c1d:878:ec5d:4583:4785])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7e4fc1sm3542272a12.28.2025.08.01.06.11.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 Aug 2025 06:11:32 -0700 (PDT)
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
Subject: [GSoC PATCH v7 3/5] repo: add the field layout.bare
Date: Fri,  1 Aug 2025 10:11:08 -0300
Message-Id: <20250801131111.8115-4-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250801131111.8115-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-1-lucasseikioshiro@gmail.com>
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
 builtin/repo.c              | 11 +++++++++++
 t/t1900-repo.sh             | 14 ++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 2dd130f3dd..98358c5539 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -32,6 +32,9 @@ In order to obtain a set of values from `git repo info`, you should provide
 the keys that identify them. Here's a list of the available keys and the
 values that they return:
 
+`layout.bare`::
+`true` if this is a bare repository, otherwise `false`.
+
 `references.format`::
 The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index 6824e50d00..2d51bfa195 100644
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
@@ -16,6 +19,13 @@ struct field {
 	get_value_fn *get_value;
 };
 
+static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
+{
+	strbuf_addstr(buf,
+		      is_bare_repository() ? "true" : "false");
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -25,6 +35,7 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 
 /* repo_info_fields keys should be in lexicographical order */
 static const struct field repo_info_fields[] = {
+	{ "layout.bare", get_layout_bare },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 9796e36087..6c555e90c3 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -35,6 +35,12 @@ test_repo_info 'ref format files is retrieved correctly' '
 test_repo_info 'ref format reftable is retrieved correctly' '
 	git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
 
+test_repo_info 'bare repository = false is retrieved correctly' '
+	git init' 'bare' 'layout.bare' 'false'
+
+test_repo_info 'bare repository = true is retrieved correctly' '
+	git init --bare' 'nonbare' 'layout.bare' 'true'
+
 test_expect_success 'git-repo-info fails if an invalid key is requested' '
 	echo "error: key '\'foo\'' not found" >expected_err &&
 	test_must_fail git repo info foo 2>actual_err &&
@@ -54,4 +60,12 @@ test_expect_success 'only one value is returned if the same key is requested twi
 	test_cmp expect actual
 '
 
+test_expect_success 'output is returned correctly when two keys are requested' '
+	cat >expect <<-\EOF &&
+	layout.bare=false
+	references.format=files
+	EOF
+	git init --ref-format=files two-keys &&
+	git -C two-keys repo info layout.bare references.format
+'
 test_done
-- 
2.39.5 (Apple Git-154)

