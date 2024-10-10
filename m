Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE061E32D4
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594836; cv=none; b=nDaaZACoCYMRMgUj6pDrMJ1O9eI2iB4CpJYVc3QTLZtXMkHB4wPdQhIWjoIy48LuIHzc7owGOmyClF+/pJnwUfOirbEOvkxY7uc9J5iFMpjSznHkJ/xE5qlMv21SJ4xr/Ue/hApWX2bpoFUJYmIXyFOQRslFb2jzfgdw2DLf93I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594836; c=relaxed/simple;
	bh=MkOCFaT5SwqBGLC85ctmkoRHDeyTur94B15a1M6h3UQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=utGncO8tcdGV7oiRCG0DzZ6B5fgkWNrsktCsAWi9DvPcGThKXhHqXAsmF4kZF0JQM9KMF77AuqUYWLk57DsQLCvD8LazCtJ7E9xp33hPhVq9ew0ADNC+Xty54A+RZO7d1sFTN8GYfnUF2TF6xIpZye8eWOvmo9URjvg5aYEDWNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alAKg3fv; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alAKg3fv"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9960371b62so151242566b.3
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594832; x=1729199632; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPK0M/mrxeFlpFHSSPKKGePzxVSY9keAdsUPttS8i5A=;
        b=alAKg3fvE6gKjyf1kbdGUB7zKTJGFSc6N8yP0b4g8dSuSmxyyhhfQt6nTNzVkfUw6H
         6E9wT7tp1D23RlgMMUzpR8iEbNrJUh3rrZm2xKiuUqEYIEVURogONMhkAx4/G/90o0Gq
         Zh/y3aUzsVw5al7bxX8sxqI7a941l2LcIKgy+sdF8QZhac56/nPWbVDtCxCOVzN+5IL7
         /LfoJllGhQ+/wbEE1RtlqsTSXjYJeCgo5fEZBhYZ83uhsdzUZt6MDriTljkeoTEEkehw
         IWA4P64l6FPhiH2KlZFJJkTc7C+wJtCDd3c3Qp0WTCbNonCaKuMglJcOFSO2lSC3HQ4U
         BRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594832; x=1729199632;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPK0M/mrxeFlpFHSSPKKGePzxVSY9keAdsUPttS8i5A=;
        b=jKpkbNeiXtxuX25uxQ70p3H86VlUX0Xc8gaX/s11FgfRkBvDvKFkGfADvE1tcS7z/W
         5I/S9rpzHF5yo5IweWlaav5ePo1jcxjKzRNPmtkNEaGtjjeZ6bmgcLxPggw8El8IA+oZ
         OBL19uyPvy6xQZxUWpeFeQO/LoO6pRE2Bmd8dGBT0+1zv+VYMYdz5if0BOLUytP447FC
         BZXAwZ7ANr2CnNVTo05xhIMOgc8b78WyfEw+PciZqksbBy6SFEfsLSN3n+HuTKsJAyAc
         O0PZ+wBYX86LsvzgAXS9fHOnxuc3MYjsS4focz6c5CVTdmrFhRadlDbllHxUD6RVN/MW
         8iEw==
X-Gm-Message-State: AOJu0YyUfmYtUmbHS30vbIq53E7yDcdFvu8q4jdlByP2JqF489Ubem89
	tdXV+Q2fz0PkJCNAbQS/92/+NgNGIhJLlZn+ftzsZuteyc2qX8YX36RRog==
X-Google-Smtp-Source: AGHT+IGEOfrEL0R6ojKeVtm9Qdv6TjMh8aVqy1HJw27qxvH3WB9PGJvhsFuXWuPxxMn3Tp8dDlmDQQ==
X-Received: by 2002:a17:907:e60c:b0:a8b:2604:1da3 with SMTP id a640c23a62f3a-a99b945c9dfmr27860566b.17.1728594832038;
        Thu, 10 Oct 2024 14:13:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dcd03sm138350466b.174.2024.10.10.14.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 14:13:51 -0700 (PDT)
Message-Id: <736212f34b5806de2fc12f5ebc5030bc71884cc7.1728594828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1788.v4.git.git.1728594828.gitgitgadget@gmail.com>
References: <pull.1788.v3.git.git.1728099043.gitgitgadget@gmail.com>
	<pull.1788.v4.git.git.1728594828.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Oct 2024 21:13:48 +0000
Subject: [PATCH v4 3/3] archive: remove the_repository global variable
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
Cc: shejialuo <shejialuo@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

As part of the effort to get rid of global state due to the global
the_repository variable, replace the_repository with the repository
argument that gets passed down through the builtin function.

The repo might be NULL, but we should be safe in write_archive() because
it detects if we are outside of a repository and calls
setup_git_directory() which will error.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/archive.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index dc926d1a3df..13ea7308c8b 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -2,7 +2,6 @@
  * Copyright (c) 2006 Franck Bui-Huu
  * Copyright (c) 2006 Rene Scharfe
  */
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "archive.h"
 #include "gettext.h"
@@ -79,7 +78,7 @@ static int run_remote_archiver(int argc, const char **argv,
 int cmd_archive(int argc,
 		const char **argv,
 		const char *prefix,
-		struct repository *repo UNUSED)
+		struct repository *repo)
 {
 	const char *exec = "git-upload-archive";
 	char *output = NULL;
@@ -110,7 +109,7 @@ int cmd_archive(int argc,
 
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
 
-	ret = write_archive(argc, argv, prefix, the_repository, output, 0);
+	ret = write_archive(argc, argv, prefix, repo, output, 0);
 
 out:
 	free(output);
-- 
gitgitgadget
