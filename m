Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A451C4A29
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003808; cv=none; b=gDDe2naHJBfDKP+MECgTSqkQRJeeYLzVjZ37okq12HztsfI+iYJeoSB67QpICGSvVhAMPkIWVfGdom4T3DrCDWXxftmMkGpESw/WLf+Q1Jd7MYXzS/7kbKMfu9GkPo2ZYgQVIho8GnshtRKhMYBltyKBDDS7D41rg0Zb9NGrPuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003808; c=relaxed/simple;
	bh=SJqRw6gXn5Xphv2AhH0XG+QfY6aQB5uqHNHnmkM41+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTaz6bbWuSj3fbvULU6Apd+QqrCYdA3LY/WNcgI1sUMBU8AAzK/piNjz41WUyMhs8Q1Xn3lMsp+TohJZeqiBRSKnguelJ0oeZuojFMNnuHFT0rUWhu1e8fBf2fgy0iyrQs3lqyl3ud5LfLQ0q0ouOyQhvl2aLnwA3qEEwdbdfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaW/0mWF; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaW/0mWF"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7db238d07b3so4765727a12.2
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 07:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729003806; x=1729608606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om3nq+43Ttf2RKA0tDZdiNjGNMvPTiMC54rrKHSXbrA=;
        b=UaW/0mWFn28ue96pGFvBfIAwvQftgY6KUgRnbPfmDurEjRVUL2CtXZWnXFbwA3jPNo
         anh5AP97fKWJKXxQkwRkLkxTTqbimuLy0V3V9pQwuFtMYWJJ6b+csnzI0yI26Zrx0ugs
         7T1QbbELiS0sXivfN1KQwg152g8MjruM0IXZgKx679LvDgFMQQPh3+bxoVfylqr7ucH/
         tDkjBCezIDZcQTskknqRbS4E2bjtuwHYVeXJQgcApyCVsGNLU1F9rbxBXNqMWFtdLfbP
         DZ8y/KM0VVzRBboJG3xul5aMBoUqI4DrfIox0O9KqPFMTNYPgtdYns2y7nVLiMbYHewD
         E+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003806; x=1729608606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=om3nq+43Ttf2RKA0tDZdiNjGNMvPTiMC54rrKHSXbrA=;
        b=KsE0n8oaMxZftMEXa4UZa/y8pMuVyqrHxcXzZM9aDOrE17ivCTitvNio+hLMZL16hJ
         J9RBgPtG3l0kr9OTdGsXFirIJdzsN3CbDAwW86VXZkjQ2gv6Yo5McR9mg0u91+HkOfB3
         I1qWEwc4LamyS3aNhbKXeJrl32H89YxMW07Y2Ot62AK9O117uYy38YKLTQTEuXhQgemg
         J1DsNt7WqgBIL96yg7D7rVJa4lv16kZHrl+s1a+Yt76uimBWfUdY8L/oTigTsw0UyfgO
         eP44w1lUQqvPgwRegjlAdNwVpp92AFLKgdYVhXlfLNJH3wy9VhFSEGBCPuwOoutzzvSq
         S38A==
X-Gm-Message-State: AOJu0YwXsFUb6eD9SKXWcotDOJXDCXaXfP/rKL6gjroA6/JaZ1BButbr
	9xYxozcQg8aY3M4ojVwhLnu1sc642GMFaONQ0UPBvNZG/rQ/T04ymag/sA==
X-Google-Smtp-Source: AGHT+IH+rmUVFujQf+g4ka3lJFQlbEsgUKrscI9heDNyntrQWKh42uIHKlgOKdo41JfPyApfHy+92Q==
X-Received: by 2002:a05:6a21:2d07:b0:1d8:a1dc:b43 with SMTP id adf61e73a8af0-1d905efe6d1mr731503637.24.1729003806491;
        Tue, 15 Oct 2024 07:50:06 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:3236:51ac:756c:f3be:7ccc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e7753420asm1328000b3a.205.2024.10.15.07.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:50:06 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: git@vger.kernel.org
Cc: Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH 3/3] builtin/mailinfo: don't rely on "the_repository"
Date: Tue, 15 Oct 2024 20:01:24 +0530
Message-ID: <20241015144935.4059-4-five231003@gmail.com>
X-Mailer: git-send-email 2.47.0.73.g7a80afd5fd.dirty
In-Reply-To: <20241015144935.4059-1-five231003@gmail.com>
References: <20241015144935.4059-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change builtin/mailinfo.c so that it doesn't have to rely on
"the_repository" anymore - hence also allowing us the remove the
USE_THE_REPOSITORY_VARIABLE guard.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 builtin/mailinfo.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 828b2b5845..9463a8780a 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -2,7 +2,6 @@
  * Another stupid program, this one parsing the headers of an
  * email to figure out authorship and subject
  */
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "environment.h"
@@ -52,7 +51,7 @@ static int parse_opt_quoted_cr(const struct option *opt, const char *arg, int un
 int cmd_mailinfo(int argc,
 		 const char **argv,
 		 const char *prefix,
-		 struct repository *repo UNUSED)
+		 struct repository *repo)
 {
 	struct metainfo_charset meta_charset;
 	struct mailinfo mi;
@@ -93,8 +92,7 @@ int cmd_mailinfo(int argc,
 
 	switch (meta_charset.policy) {
 	case CHARSET_DEFAULT:
-		mi.metainfo_charset =
-			repo_get_commit_output_encoding(the_repository);
+		mi.metainfo_charset = repo_get_commit_output_encoding(repo);
 		break;
 	case CHARSET_NO_REENCODE:
 		mi.metainfo_charset = NULL;
-- 
2.47.0.73.g7a80afd5fd.dirty

