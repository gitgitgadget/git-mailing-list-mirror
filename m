Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA5C21D00A
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753638714; cv=none; b=kX8Kx9EUb2mWyOcEb6ccP+Ktj2H4VvvW8cWNXNNzLYkBh+IdtAuCPAQV9pZhCENZSQy3HjXgk3Kgq1EpWziHkZr8T4nohy2RYFqJvjssfAmOYpR9KrXfk48cVdUq85udcTUKWphQ6cbtB9Woarw48vNRM9OMR4VtVLuiEdw3Id8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753638714; c=relaxed/simple;
	bh=Q/I4NQBm+sdWPgiQ9gJseanj9CF+cQjZKPN61IWGycI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d8V5/3MbqXaMpugBgwmSfa7d5yXScmPYAU37JQbhR8qgCKB9/9rEO4+qEn7LuJ05Abx1Ri/TWWLKUMRG6+5IcdVtE50EiJP2Y9lKM3w/68jPFjRmNN37co2rGRjgx3Ku8jLdR0DxFeI4pFbfVBkQ9djc4hANy6STXnGml+SIIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRiv2Jg5; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRiv2Jg5"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b34a71d9208so2602918a12.3
        for <git@vger.kernel.org>; Sun, 27 Jul 2025 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753638712; x=1754243512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHnPXgZ2N9Tn8ZxPtRh607xAdrYFRG1sQ8uyuJ/2izk=;
        b=SRiv2Jg5IOIJOoSvqIomgCSoaPbFBk+x1OSiI7DPWWgK9aRwUSW1Mw+lRJNlgpjfnA
         cibrKaRmo+D+8tSLsEyNQqooy9WXbFf4f6Gkh1NDHkryH3h3759NHwh55SMkL4hspOsW
         27kA2Kr/24/hLfLHdGCiEd5i2Cbu4MIygdXIlOL+rNnpdVVBIFeZklJtsKOAnvI3lopf
         N5qMVBSLp7JuV7vgXSC0Ts98IH15zgtVom5E30TXUexMECb1MvV+mabO27r2koXf//xM
         1JDBtiEDRI+a448yUkFLuQ0d0egMSkI/b7rJ7M19K7+xiuUbegXp1MgIFd5VGYg2fUVG
         PFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753638712; x=1754243512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHnPXgZ2N9Tn8ZxPtRh607xAdrYFRG1sQ8uyuJ/2izk=;
        b=l7Z4YQIcu8GyAL8MFUXIn7BB+USXvYUYHgYNBCO/WNr6xIrJM5lcJZuuLpxVLU2pys
         wmCGgVUyBTJuQ+VWxOjhBARq+KDx607vBzlz60tu8EqM8Kuci9rpsd7jwyLyKY7H3BQ/
         zgo5aQTSTCB1DevCT9BZWJ3t5Dl3wC7/Oc9hWSQ/iHtP3J8UlBKANExkK8LzOh/R2Nti
         FJ2HTIETP0PgpBubqWHIuG5T9lMeEyqS/oOzlQOM0m7o2MMZ1ViFeqZFSAHVc1qq58GS
         RfFBF8x8KMAeFpOwVFSyJW8bFjJv5zPPBhWjzrXr3SStkgCH5Bb8YDLkzVH9Gg3VLH/u
         RHtg==
X-Gm-Message-State: AOJu0YxP9U5o5coDFi+HbwwJaaCH7GnLGOZGfTF9e1DpTYlaTi5KZ+Yo
	GDSinrhUZVkphPeYSDMcI9ayVIS56JXQ9vVTnuRGxa+WxdzT0eMC9A/G/mUkrA==
X-Gm-Gg: ASbGncv09ekTxIynwAa61of0FrSUqRRRrHCvgrCQWEhhDA3vc0ucHYB4sdsjrkcLUIY
	gAc7+Zq5yjpnv8+baZ4htldXJi+ai0D2Gsgfk1oTKNjUrnVnuWHSEh0Dkn5oKaDV734FpdpIrvI
	uXia6yLQCnbNAV8iDS2hXMURPI2QdzswOF0JegVV/J9f5skTFb8tAdfmaaApKI1lOo7Wt8kaSUl
	OgEZaKqIIaDCMxOatifV7ydj2K5MwOqfO7MuvoUaoKkKVzB/VZKObYnacKMKY62hnV7VmcZyRy9
	EvBHuFfT8cCL2R7oONornVQxv26ECBVoQadPO/wc6AnxU0+qeae6OtsIGHNLLvMMk2wcsOH92/G
	oEsooCF7MgdGwOZ2TnF6wV0Gaj/Uo47s95l9HTAT7vWGAphDDGRXX0/HzXs+OXbAt52reFss52b
	lngyQRHjLoay0acABW/ReU0Q==
X-Google-Smtp-Source: AGHT+IFpsngOAwJ8LtbNiCRiz8TDH2+92Xz9K6WU+rUGLP6In6UVguN31J8muRYPim9RZn26dtNHMA==
X-Received: by 2002:a05:6a21:a103:b0:23d:9dd0:b2e9 with SMTP id adf61e73a8af0-23d9dd0b4acmr265801637.42.1753638711894;
        Sun, 27 Jul 2025 10:51:51 -0700 (PDT)
Received: from localhost.localdomain (201-1-210-243.dsl.telesp.net.br. [201.1.210.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f58bec0sm3392488a12.17.2025.07.27.10.51.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Jul 2025 10:51:51 -0700 (PDT)
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
Subject: [GSoC PATCH v5 3/5] repo: add field layout.bare
Date: Sun, 27 Jul 2025 14:51:08 -0300
Message-Id: <20250727175110.84770-4-lucasseikioshiro@gmail.com>
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

The flag --is-bare-repository from git-rev-parse is used for retrieving
whether the current repository is bare. This way, it is used for
querying repository metadata, fitting in the purpose of git-repo-info.

Then, add a new field layout.bare to the git-repo-info subcommand
containing that information.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc |  4 ++++
 builtin/repo.c              | 11 +++++++++++
 t/t1900-repo.sh             |  6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index ac2578299f..d52f4666be 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -33,6 +33,10 @@ categories:
 Reference-related data:
 * `format`: the reference storage format
 
+`layout`::
+Information about the how the current repository is represented:
+* `bare`: `true` if this is a bare repository, otherwise `false`.
+
 SEE ALSO
 --------
 linkgit:git-rev-parse[1]
diff --git a/builtin/repo.c b/builtin/repo.c
index 02d5821c77..2aba6a39c7 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,4 +1,7 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
+#include "environment.h"
 #include "parse-options.h"
 #include "refs.h"
 #include "strbuf.h"
@@ -10,6 +13,13 @@ struct field {
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
@@ -19,6 +29,7 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 
 /* repo_info_fields keys should be in lexicographical order */
 static const struct field repo_info_fields[] = {
+	{ "layout.bare", get_layout_bare },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index cc54b0644d..7304629cb2 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -36,6 +36,12 @@ test_repo_info 'ref format files is retrieved correctly' '
 test_repo_info 'ref format reftable is retrieved correctly' '
 	git init --ref-format=reftable repo' 'references.format' 'reftable'
 
+test_repo_info 'bare repository = false is retrieved correctly' '
+	git init repo' 'layout.bare' 'false'
+
+test_repo_info 'bare repository = true is retrieved correctly' '
+	git init --bare repo' 'layout.bare' 'true'
+
 test_expect_success 'git-repo-info aborts if an invalid key is requested' '
 	test_when_finished "rm -rf expected err" &&
 	echo "error: key '\'foo\'' not found" >expected &&
-- 
2.39.5 (Apple Git-154)

