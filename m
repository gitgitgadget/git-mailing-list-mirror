Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AF54418F2
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485106; cv=none; b=JS4ZsPs5IRQlbY4RSYiVYgHYwFqHD3LsSPh6Z5pS8h45UZ2WfGd9CqlG3QKSjf/3axvtTyyZwkKQebvpYLGHzpaNHZN+U8WRbdhne640CnHyjqPT0DFcubMQeftIY/OsIqz4QagmMy1fZiSCY0Q2oRehWmIUZ9q0CKDva52j/ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485106; c=relaxed/simple;
	bh=dKqJRa01/QEjg5/OLXcqg6OsJxSZFnGGXZd/amdbMPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+RGqobtzujSd9wdsfIzb3T0CHzerrS6XcZA8EmHG6ERF/L5mHPWy6oxYvY78NQuyKrdzxBjxAWMEanfUgKcRkoNmgUd9i5pUj/2lX34U/AcGNSs5pWBm+Tox0U1DMTT7hj93hXLp2yLhJskVHVuPXBlx65bZsIO6CJ7FrGnYmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0tz+U1R; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0tz+U1R"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8589498839so1825302a12.2
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 04:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780485104; x=1781089904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJFXLQpjifbfaKRsx+eFlj2y1LohHP5y8q+QuY/5yoA=;
        b=b0tz+U1RudshY0fYzPPA6EklHkXMGe0FuVaTS8JOKR0u7bmLqyZvDQSJThQgXGXnNC
         0uloApOjoCuUF6awO91JayYYuEGE0Y3jx8tcIyemXJRQ0lZ6PaUenNNNmVV4iZ0NJiRx
         +andFZGdkjQxM55mSqAbXHWzKkR86nVZ9fEp41f3XqcRLzTiS+ox2WKNcldNDbQSHn+3
         USpWKgECjTQEezAkgNUigTrsOK31mXCKOPLnVQYTJfyAeF5YGjpOiWdyRk8g/GV1INkS
         b6w7JY+Kp1xAqtW2sY0shkvIxHNQkR6FhDClPOjMnQR7a2N5MpH2qSoBmid49qAf5l7T
         ycgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780485104; x=1781089904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AJFXLQpjifbfaKRsx+eFlj2y1LohHP5y8q+QuY/5yoA=;
        b=MknmsgdVv6dTB+QZoM2wrDi3s6Cp2FpFkeAF8JeDwNV466XGhpRF8AgD/gzQjPN56n
         btk4aUHLG5ek6Ehe9VEeYahtLygu9eHBI/JWE7cqF17iX5OiJ9jgI5WJOiVisJZ78v8M
         x8PpyApLjRvweSX/li0S7CxadIA7rFe6dX8PTVNY4VvYDhivExEVvz+6kjorCo3V92M/
         iZEMo21voPxk2zWyWXtNuQU3QGjknN3cDpPPDzXUOJAyHslLHOF5FNDI8OpP8DttWHe/
         A3iy24a8Yt9B3ZiFvfqRGGw6kKHGdD785GXCr+TdwqWMPMfLAU/W/WxY3tEbDrf5zIv7
         H73g==
X-Gm-Message-State: AOJu0YxzirvI60FTFYcxVGVvfZLNAj4+ukcU6skkhxGR3lxEoky8i8VE
	yQXDC2dfoxxYAPkG4rVy2GrnLMcXuO5LKcO/Ly/wqVRAJXrqvuI4Flv2EgzHdQ==
X-Gm-Gg: Acq92OHSbmTXxrpq/EebRjsH7bXCku0gHyz9uLI0f+zYMZe9CbsaffsjyQ8LIFob7KR
	/3X001sSl1GK4RSVhm6xuJTf1CPYmcpMjhSEOpZJhSdXbBTDLT6ERzAUUXYFdlR/MO2guyqY4Ah
	cJ+mX0ixd+D+gWXSt5RhEl0kauXWB+K/JPFiDIhQ0u2T+iRR9zzsfg/SOuHAYexUA+CgjPQfEV0
	BJoJmALDs7XMqxH2gwhJkBVJ0QzVXpmtatpZcfnlHMat9dxu2hk3k097sR2/Uyg8LqXLxKfCYDJ
	e2F1ap9iO2TGAuwt4n366joKtnBFm9XhCaJB4vqKcyLvYyMle+1qGar38ovtaLA1vYD4gUAaQqn
	Ub/WAtdA5znBytVWqb0OnkYeqAU/pvC6W6vfxSPvjCUFvSAwYcv754YecPrRzl8Mql8L/3zMyjA
	vJaIa0bT7FBSLYFjc5gPgWUMy04ntaContR9ZvtujGXAiwbDRIpUTb5nh0Po1DhBNV9yYWh/bEK
	l8+S/3cW22Y3DexAwsKXAZovb3UzK7I30z6ilfwJG0+l9z6NTU/bJR91EtnBMIh7HMC+t0=
X-Received: by 2002:a05:6a21:6e03:b0:3b4:913c:296a with SMTP id adf61e73a8af0-3b49758695fmr3623120637.21.1780485104359;
        Wed, 03 Jun 2026 04:11:44 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:88fa:8837:5c6c:ee92:51c2:81c6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282372502sm2972578b3a.16.2026.06.03.04.11.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Jun 2026 04:11:44 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	toon@iotcl.com,
	jn.avila@free.fr,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH 2/2] builtin/add: use die_for_required_opt() helper
Date: Wed,  3 Jun 2026 16:40:44 +0530
Message-ID: <20260603111044.39116-3-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603111044.39116-1-r.siddharth.shrimali@gmail.com>
References: <20260603111044.39116-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up manual option dependency checks by replacing explicit conditional
blocks with the newly introduced die_for_required_opt() helper function.

Specifically, simplify the prerequisite check logic for both
'--ignore-missing' (which requires '--dry-run') and '--pathspec-file-nul'
(which requires '--pathspec-from-file').

Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 builtin/add.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index c859f66519..a5c91c6dcf 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -441,8 +441,7 @@ int cmd_add(int argc,
 	if (addremove && take_worktree_changes)
 		die(_("options '%s' and '%s' cannot be used together"), "-A", "-u");
 
-	if (!show_only && ignore_missing)
-		die(_("the option '%s' requires '%s'"), "--ignore-missing", "--dry-run");
+	die_for_required_opt(ignore_missing, "--ignore-missing", show_only, "--dry-run");
 
 	if (chmod_arg && ((chmod_arg[0] != '-' && chmod_arg[0] != '+') ||
 			  chmod_arg[1] != 'x' || chmod_arg[2]))
@@ -462,6 +461,8 @@ int cmd_add(int argc,
 		       PATHSPEC_SYMLINK_LEADING_PATH,
 		       prefix, argv);
 
+	die_for_required_opt(pathspec_file_nul, "--pathspec-file-nul",
+				!!pathspec_from_file, "--pathspec-from-file");
 	if (pathspec_from_file) {
 		if (pathspec.nr)
 			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
@@ -470,8 +471,6 @@ int cmd_add(int argc,
 				    PATHSPEC_PREFER_FULL |
 				    PATHSPEC_SYMLINK_LEADING_PATH,
 				    prefix, pathspec_from_file, pathspec_file_nul);
-	} else if (pathspec_file_nul) {
-		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	if (require_pathspec && pathspec.nr == 0) {
-- 
2.54.0

