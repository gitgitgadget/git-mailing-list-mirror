Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18BD22173A
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753638718; cv=none; b=jE2mne8drv8iK4uBfdpREQO/AfIP+FokJopT8CZDHsz9qRPftSLf9XBjiSDS7D6bBnOVEzjXoHEcUIASDlxEd5TEprhJ5SPY6qsybMfWgMzabvvci1D123tdeQ1m6D/NzNy9TUOdwjpQarJES0J2lPhZ3jK9/bLPsaLuB6Hk4Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753638718; c=relaxed/simple;
	bh=S5EFswtb18LFA8pyb68iu2rXgr2n7xo2ReJn7mPSXIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7mYaAzZbYelqsvZxGtVP/tGMZGDcC0X7SC6FMnGRskz5Z9sAWFlGjV9pjJhD4+/jnSxK9FNz9YvjgIakjtyvkdU0qlip7TuNPV1H5GRMqkzFhwSGybFxuJcb7ZpJjbdk9j1Mfly0kIt3qEYF5FTlnx/NjmZ+0qpFP2mqQsTm+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBPJq/4r; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBPJq/4r"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31329098ae8so3110511a91.1
        for <git@vger.kernel.org>; Sun, 27 Jul 2025 10:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753638716; x=1754243516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JxNEn1W0Z1rjlXPA8dg55mkCO3GSZztfHw3Lb3XosM=;
        b=OBPJq/4rcGRUSAPAbRk+a5S9CE0CbMeMREgwN4hN+NbsRKDYL9YAIeNF4TZqbpZZEe
         B7i+JjiB+9qLH9axwWF2biI3DGjOPzvMqkYA0ryPrwAYHgF6qJ/TC0qjXcJljSCGjr/u
         DR2e44JiwitilSMy/BCsXrP8/hVO6w0L5yYVLKYzCFMV2ypo4Jqg143iI6mm/WA+Sj8d
         vf1iWSIat4ZpbkLpdssJtDg9DmH9zrjoiY3AWmcldBAcIiUBZ8H+rI5UtfnaHZmAscy2
         XQNZ9lI4G8z0DxGJNhDnJIp2YDQ7OTA/S7jDiS27ZGNK8v88CJZdvymNsVnstgsseE+S
         aD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753638716; x=1754243516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JxNEn1W0Z1rjlXPA8dg55mkCO3GSZztfHw3Lb3XosM=;
        b=NAYXfPzGTkIZHRGu2SoB5G+STrhkhrVfN4t3gnNUw3u1xtamOR9/SaX22vMeLAlOn3
         tsXQ5ZtFpWrXX785DEmrJWlYrw5vLDlRqzyyrfbk0wD/HG9AyOvKIkEYpSb6+/vCZMTw
         PIDbngaL5/YfYH4ETnot+LX4xtagT3TEFjkNtvOnv1Mqxk4tYiSQzLsXHBILKZ9w+YOf
         YOK7Fh/Ztw1LCp7w7+33SgplKm2h1R8TibGo81PRRh+iUZTcQpFqlH64INkKyzI3/TC6
         /Wk6XDSp6SXYCJkEXwMDOaqFplf/y2dqDAa/oxOM+1kOUnxA04Lw7Tl4HJFoIOJ96XQK
         X3AQ==
X-Gm-Message-State: AOJu0YzFje1GPjw3abLGR6H0no+RCgfNIETH1JvYhOSkwSwYK6NVLgVU
	KsubvM448UqYZa6vESBQMmZNChOQmrD5eQnsm62+pGvb84gHw3De1VVnM/I8rA==
X-Gm-Gg: ASbGnctjqZTPch0cAcQU7aDxtIvkpWmWuuNupWRHzURpBUadsWe8uD+gcTY78+rWd51
	eAcVUhKbTo6bs2ZQlAJg1cooF4xuNbshvyzK4ebBSTFybiFeehc4DzVJg1odVfac+qseJ5FbZpt
	x1enF88NcrJEGUpZv/a5QR9Yq8MIX+fstSrqDHgsabPvz2lqeVtbLoihIzVAG9bJXvDPutrQlHj
	wkUvGSRWA4O/R1M3vA4mdCPK58y66GHZ9WigJxDq5yflES5sx60LaTOQGXrVPgvm7ndNAYhUhwV
	96CWSDovkFh3eFqaWYUyb5VaUhBz3WTMU81Qledw/OjSi2mHf6jJ0WklfflKitJM5FIxX2BwdgB
	E3yGyimBvAUTyhYC4wUF+8+obeeoupPP6e8GMWxn907EyiO8krf43zDNGQPG/Jsb0cPXyhhAeEm
	+m+AQcdrPkovoKJzGubzjGmQ==
X-Google-Smtp-Source: AGHT+IHU4mhtqfyqDvlKpphjhsyIrFo8vVtPDtdWte6c2tX71+y7QeAcn6OCTq0+saO1qmJ737893w==
X-Received: by 2002:a17:90b:5251:b0:31e:a48c:25ef with SMTP id 98e67ed59e1d1-31ea48c2809mr5835134a91.10.1753638715860;
        Sun, 27 Jul 2025 10:51:55 -0700 (PDT)
Received: from localhost.localdomain (201-1-210-243.dsl.telesp.net.br. [201.1.210.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f58bec0sm3392488a12.17.2025.07.27.10.51.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Jul 2025 10:51:55 -0700 (PDT)
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
Subject: [GSoC PATCH v5 4/5] repo: add field layout.shallow
Date: Sun, 27 Jul 2025 14:51:09 -0300
Message-Id: <20250727175110.84770-5-lucasseikioshiro@gmail.com>
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
 builtin/repo.c              |  9 +++++++++
 t/t1900-repo.sh             | 21 +++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index d52f4666be..3f920b619f 100644
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
index 2aba6a39c7..37fb1803f6 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -5,6 +5,7 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "strbuf.h"
+#include "shallow.h"
 
 typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
 
@@ -20,6 +21,13 @@ static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
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
@@ -30,6 +38,7 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 /* repo_info_fields keys should be in lexicographical order */
 static const struct field repo_info_fields[] = {
 	{ "layout.bare", get_layout_bare },
+	{ "layout.shallow", get_layout_shallow },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 7304629cb2..0bdbf6911e 100755
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
 test_expect_success 'git-repo-info aborts if an invalid key is requested' '
 	test_when_finished "rm -rf expected err" &&
 	echo "error: key '\'foo\'' not found" >expected &&
@@ -60,4 +74,11 @@ test_expect_success "only one value is returned if the same key is requested twi
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

