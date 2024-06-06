Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98273444
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 22:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717712375; cv=none; b=EOPri+cMhd+8Cde6qGjYgjAg30qE6Es4VJBhTPWfeWbmzfEBKLRCcZj6VwB8rsa3Vu2PMc0Zg1S4lmkVNZ8Zrkyo0HVJivS8QYnvCbE5ipiiOStUbG2uVs4kct4J8aZ7U4t/5zOwWDbaZ91PP+EDZP6f9Zy/rB/qJ/GN391jtMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717712375; c=relaxed/simple;
	bh=Q7UBmu9GzPEFqjJJauo7s+5JBmtilcQsK5bzE0XMwbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXrydFUXAgR5o6oJv0K6HyTOtdw5X4WXavUamkgOky+aif3fL60aZTyTAE2wlHELiJiAJwRZASloiaOj7vboagEp7VjAQHdSUhnS1+ylxXaZ+cZiXscPcNQK/QXC7FuXnSQMzlrg7yNrMSjWGyQeirX2dFUL2y8RT86Jjt3VuTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=rCxcZ2x6; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rCxcZ2x6"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d1ffaf6091so824066b6e.3
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 15:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717712373; x=1718317173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CHL//jDFzqaeLoKKP5Z/bq5VZ3YyKc9m5Ot3xsEJyQQ=;
        b=rCxcZ2x6DF4QT/qzU+tUHnMZcrdF7oaygAcH8L6gRuD3LQEy8KdywrIhUsv9ei8TzE
         L6MuYK5dzet5HRRGzqL757KHeU4Wrsmqr9/m9tDKfbwI5cdlumCrpndlc/q8+5w0WntK
         i3LT+dVrjiZfO7wiV4p2O3r4nNrcUGWUAOCCUyvTmUPqhEmo8x4u3sjzuo/A78+pww+M
         ojqVNJKNlpeQSGI9VZQ4Hp3y0FjAKy4rjFu07/rav7wsjz+ukaQGZtdFBsPF/rWK2Pl/
         jkqPnErX5gtkHA2RxuOEoxwrhuDL3+5qswTwewy0zvskSWWI6UBLJkW8wcHEjfcmGnx0
         KDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717712373; x=1718317173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHL//jDFzqaeLoKKP5Z/bq5VZ3YyKc9m5Ot3xsEJyQQ=;
        b=aD8tjlYanKWs/qNz9zYUWo9YM28MPYj8vIP+c6V9ziw4s2tMKNovFlK41xMAushLu8
         sMAKQdr3RVDP+dADzTvBWN/Xt3gbIW1dG51q7/9/Hwh1Di7QoGw6ureOVvTKqJQPM0LK
         oVdd7qJTpz+sjWrcW/lEhsJIhU+RjV0JT/NbHB64JBJqn/Mkd17uOKI1+5CRqokl6fWM
         GZbuuwPYlpN4Y2AJAtS3mI0IcBIsLxSI91OdwUdh48j5aAygnUkl+l3BZbpjKqviv5mC
         e6spss4iTjH2qFxh6CLBgkKYCPRqBGC2IegR4EA8T8SoyjMHFuZhgmeLOeRoDWCBJC3T
         tIGA==
X-Gm-Message-State: AOJu0YwRC+4EUILGPwewPKk8GYgRIGgJEp6ChsI+JNM3uZ/s6s3eCCiL
	YeGslD77SaeXUrmQCIYlk4BGYpNs2BY6K/f8ovExq2U+s6UpDXWJ7rxb5tUokxcIRasnWE1Brfv
	9rA4=
X-Google-Smtp-Source: AGHT+IFZEgM+ir/7k6K4lxvvfl5xtP2KokHWTs8xdDHFGu/y2lG7SWc2ynmaOUjNxEsB7xq62l5U6w==
X-Received: by 2002:a05:6808:23ca:b0:3d1:fd7e:2234 with SMTP id 5614622812f47-3d210d699bfmr1038825b6e.14.1717712373198;
        Thu, 06 Jun 2024 15:19:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795331c9e2esm99888685a.101.2024.06.06.15.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 15:19:32 -0700 (PDT)
Date: Thu, 6 Jun 2024 18:19:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] server-info.c: remove temporary info files on exit
Message-ID: <2d5a0536af1a6d45835622e2c020266079fa0873.1717712358.git.me@ttaylorr.com>
References: <cover.1717712358.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717712358.git.me@ttaylorr.com>

The update_info_file() function within server-info.c is responsible for
moving the info/refs and info/packs files around when updating server
info.

These updates are staged into a temporary file and then moved into place
atomically to avoid race conditions when reading those files. However,
the temporary file used to stage these changes is managed outside of the
tempfile.h API, and thus survives process death.

Manage these files instead with the tempfile.h API so that they are
automatically cleaned up upon abnormal process death.

Unfortunately, and unlike in the previous step, there isn't a
straightforward way to inject a failure into the update-server-info step
that causes us to die() rather than take the cleanup path in label
'out', hence the lack of a test here.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 server-info.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/server-info.c b/server-info.c
index 6feaa457c5c..37d1085982e 100644
--- a/server-info.c
+++ b/server-info.c
@@ -13,6 +13,7 @@
 #include "object-store-ll.h"
 #include "server-info.h"
 #include "strbuf.h"
+#include "tempfile.h"
 
 struct update_info_ctx {
 	FILE *cur_fp;
@@ -75,9 +76,8 @@ static int update_info_file(char *path,
 			int force)
 {
 	char *tmp = mkpathdup("%s_XXXXXX", path);
+	struct tempfile *f = NULL;
 	int ret = -1;
-	int fd = -1;
-	FILE *to_close;
 	struct update_info_ctx uic = {
 		.cur_fp = NULL,
 		.old_fp = NULL,
@@ -86,13 +86,12 @@ static int update_info_file(char *path,
 	};
 
 	safe_create_leading_directories(path);
-	fd = git_mkstemp_mode(tmp, 0666);
-	if (fd < 0)
+	f = mks_tempfile_m(tmp, 0666);
+	if (!f)
 		goto out;
-	to_close = uic.cur_fp = fdopen(fd, "w");
+	uic.cur_fp = fdopen_tempfile(f, "w");
 	if (!uic.cur_fp)
 		goto out;
-	fd = -1;
 
 	/* no problem on ENOENT and old_fp == NULL, it's stale, now */
 	if (!force)
@@ -121,27 +120,22 @@ static int update_info_file(char *path,
 	}
 
 	uic.cur_fp = NULL;
-	if (fclose(to_close))
-		goto out;
 
 	if (uic_is_stale(&uic)) {
-		if (adjust_shared_perm(tmp) < 0)
+		if (adjust_shared_perm(get_tempfile_path(f)) < 0)
 			goto out;
-		if (rename(tmp, path) < 0)
+		if (rename_tempfile(&f, path) < 0)
 			goto out;
 	} else {
-		unlink(tmp);
+		delete_tempfile(&f);
 	}
 	ret = 0;
 
 out:
 	if (ret) {
 		error_errno("unable to update %s", path);
-		if (uic.cur_fp)
-			fclose(uic.cur_fp);
-		else if (fd >= 0)
-			close(fd);
-		unlink(tmp);
+		if (f)
+			delete_tempfile(&f);
 	}
 	free(tmp);
 	if (uic.old_fp)
-- 
2.45.2.411.g2d5a0536af1
