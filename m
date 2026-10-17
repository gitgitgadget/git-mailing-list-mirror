Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CB42135B8
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792243069; cv=none; b=E60FXpX+ksyV01Zlkt4ko2dU4ULyiRNbE2xQFtmFQ+LgjC33q7HvDdMVhsrmW6I5AmTcgYyCaPOJa861oSjh4n1XTSwFere/0HNqYSUfwjpUaFYZAIVRRJzD4rUMeU+Es9cz10g54Nc3csjYKtbKPMqAhBoCRXUoh/R4svtHSvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792243069; c=relaxed/simple;
	bh=C0wODODFglXV9gJ2/ietGf0A4duzgGk09vhIarU+Ae4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nfjL28oyWeKE5KbHneG/+TM4zv1DIslGwMZP44NGePTqw46yvUZmWVc3Vc6s3V5MBkqA0fRzBcyn/NhgUh1jqRJS/YxZ69S4vxRrptLSuwL1cUGV1ERk8UOdIkmQYTFXGX9YihgIgtRjusWhRQD6RMCIWvhv+BJpNdi8njGWJ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGry5N0w; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGry5N0w"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so5266955e9.2
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 06:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792243066; x=1792847866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B5PMH5Vmk9CIKRWLsWQ/N0/786d/cNBRTXoyCbNwHx0=;
        b=nGry5N0wz2l2Xtd2YLwu0fOPtlacZPxMEfXC3V9/+GqQNmGxgJZjYNdtqmAnvCCp7F
         bYGOf88ppv6sAYAdr1IJ2KMbwQUWYCMwCzY4fiuOS40Zi9oaiZztDkkRnEQ0GO6IZPSm
         Bzm0FsNMJpv/8W23uzkFE9+TdqJ/M8a8WUiT8UXib8uX65IlQjCCiejW9WGUfQAetpG+
         KCfecrb/U59sF+68KUQTvG1aQPg6v3xonFyyiCzZEjjXNkIzes7oPkXmoyrBm7JG18Ke
         5sXGGcMysl6ogJoyLML4o/zN+nq1PrJ5GyicO94VaQHK7Irqk0BAw5p9hA5BgfetsD9b
         5TPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792243066; x=1792847866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B5PMH5Vmk9CIKRWLsWQ/N0/786d/cNBRTXoyCbNwHx0=;
        b=q/lubmYNzsxQ79S+eoGqFOv02RPsJUoKxdgUox7PKuuyX90CcGsmcvDndmq3TCIvOh
         qTBNOD7HBOeI8dvy79Qv6BCTFxLTGECAaOBUk5W4CQuv59tYLCUt/85LRAD/sTqNkxC8
         j+VYilKdltHZmO2RbW9Jdvgxd60mBbll/wf+sOuGERTFf9dIdzc0gZ8uYrYdSKQZ0hD9
         Mv4I/E6oJoyGLmtfqK6fCamYO8ePMczZ6hwOpFp4jLmBEl+cLPZtdAtiK8mw3d+h/HLi
         08tc3dXorIQUVwjH2i/9lV4PN+2xc7jrh+IPNqjNulRO6XdwTlLQhgdxZZDRynq76Nia
         tEOg==
X-Gm-Message-State: AFq9FYLmjwRQU3600y6OhCUuAnRoKpIyxFvv2PEm+m8D+RZ13cDz+bc7
	XSB4aQjq5bvWyayG3u7BwwkYhOXRsW7GXm+OJtVrygEY2cW1NBxZ+d4V
X-Gm-Gg: AYBFou26jIwAbTJqvmyvwoanWpd2rUBXyOsbuXZqyiMo/UZQSQuvIl+5snNEbIbhPtx
	LlqrwH4jOGCHFbjEjXNbTXuuAnYgEdz7s5J2Anunot1YD6KDL/hNiKHDkA43LUg/0/N3NtMyQmH
	v5CFMaPD3QFWQ1WFMY2JAoWluALDJUoiHr/Q/JEwRQ3ajVp5CDIL5cOrBbkWyUkJmmpQSSURvKb
	dt0j2vChcgOosilssmPCNKGWx8bZRK8+6lRrLvNgWMG3T+RB1O1cFMDvsPaX4sa1/fSUjulZd8I
	CcRKoBvEqmblnzcOvHDBVVO5nWu+LDqPEQqczGroSZ0pWlOAur5i/qgjRGdG+P/LVjOiqZYK+f0
	um6u39cDTRSUak0+RCI8ev7gkQjF/C5BOJLijdgrx+fYlTgMY3KuTkgOj0uOB3Z7OmDMM+6Unzd
	O3AHDax4SY+PsyCAlZ7WrVlNs1nkSDc0N0Wb2n+CdHQ3K+ueeV+RJDONr5s0sLudH+nmMbPYc7+
	n/ZQe0OOU4wrnkAdvKX71M=
X-Received: by 2002:a05:600c:e555:20b0:4a1:d272:a911 with SMTP id 5b1f17b1804b1-4a1d7601b23mr36004985e9.21.1792243065839;
        Sat, 17 Oct 2026 06:17:45 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1dea678cdsm32814505e9.1.2026.10.17.06.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 06:17:45 -0700 (PDT)
From: kerylefondji7@gmail.com
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	Keryle Fondji <kerylefondji7@gmail.com>
Subject: [Outreachy][PATCH v3] builtin/var: refactor to use parse-options API
Date: Sat, 17 Oct 2026 14:17:30 +0100
Message-ID: <20261017131730.642-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keryle Fondji <kerylefondji7@gmail.com>

Migrate option handling in 'git var' to the parse-options API.
This update also aligns variable resolution with current Git configuration
and attribute handling.

Signed-off-by: Keryle Fondji <kerylefondji7@gmail.com>
---
 builtin/var.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/builtin/var.c b/builtin/var.c
index cc3a43cde2..b9234a55eb 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -3,11 +3,9 @@
  *
  * Copyright (C) Eric Biederman, 2005
  */
-
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
-
 #include "attr.h"
 #include "config.h"
 #include "editor.h"
@@ -18,8 +16,12 @@
 #include "path.h"
 #include "strbuf.h"
 #include "run-command.h"
+#include "parse-options.h"
 
-static const char var_usage[] = "git var (-l | <variable>)";
+static const char * const var_usage[] = {
+	N_("git var (-l | <variable>)"),
+	NULL
+};
 
 static char *committer(int ident_flag)
 {
@@ -120,6 +122,7 @@ struct git_var {
 	char *(*read)(int);
 	int multivalued;
 };
+
 static struct git_var git_vars[] = {
 	{
 		.name = "GIT_COMMITTER_IDENT",
@@ -221,21 +224,32 @@ int cmd_var(int argc,
 {
 	const struct git_var *git_var;
 	char *val;
+	int list = 0;
 
-	show_usage_if_asked(argc, argv, var_usage);
-	if (argc != 2)
-		usage(var_usage);
+	struct option builtin_var_options[] = {
+		OPT_BOOL('l', "list", &list, N_("list builtin variables")),
+		OPT_END()
+	};
 
-	if (strcmp(argv[1], "-l") == 0) {
+	argc = parse_options(argc, argv, prefix, builtin_var_options,
+			     var_usage, 0);
+
+	if (list) {
+		if (argc > 0)
+			usage(var_usage[0]);
 		repo_config(the_repository, show_config, NULL);
 		list_vars();
 		return 0;
 	}
+
+	if (argc != 1)
+		usage(var_usage[0]);
+
 	repo_config(the_repository, git_default_config, NULL);
 
-	git_var = get_git_var(argv[1]);
+	git_var = get_git_var(argv[0]);
 	if (!git_var)
-		usage(var_usage);
+		usage(var_usage[0]);
 
 	val = git_var->read(IDENT_STRICT);
 	if (!val)
-- 
2.53.0

