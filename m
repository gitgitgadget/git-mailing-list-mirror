Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D9208986
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730926090; cv=none; b=iuOtA6bIIE6bT16CcKYGD2hH1hGl87A5xXUpYjeU/r+iuMaUALR35Jm7LcPTVTofzn+qBRaERtp27SGLPAuva/6lPu7cDEo9sqKrH5dT9KvISFYf9s+W0HzzJVhYulQv5wRPm3D+JW8zdvmLE4vN4hGbLQripFnersuRXLXScto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730926090; c=relaxed/simple;
	bh=lYdCGNmUXUDJRVtLNfhJSJH7eZ5qCSWs8NLTf7c+OfE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qKJL2acRpsQ18zzuU9rdXm+O9S4cL6rHEyKprGBGqiKEkZ0//eZgi/Hl5PmZHd3lBpuGCd05IxJKNtntYqB0ZiLtLdmXqeh4PyvDH322O5EuI2qDLdK+7YYM5dyb7OSyUhLloTeFerYFQ0ngpWPt5RitcdAxQsmSk4KAfgyfKn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHdEN8gs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHdEN8gs"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso2204115e9.3
        for <git@vger.kernel.org>; Wed, 06 Nov 2024 12:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730926086; x=1731530886; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kc0K+vQIjrK9TRrlc8Xtegj1qAqWg9yAmrhZy5bd6SI=;
        b=AHdEN8gsvNJG2cCh2/Xu7rvQycs2ZXe8ervINyeMZI4cpsF1WsJAZ2W7/NWxwUouwY
         Y4ZSSukdiH2q5ZU/k8XU57Ise676Qqyjwdg+wE+iPzUr3KBngt33kA4b9j4vyPCUMkTO
         s2y5FRFbD5Ky12moEINGvp9grTp5lfUQ/belcUIx/T4zEK220ArLpyLTJy8FhMMUrvbC
         d7xUHNaauQ0DEPV63pX0ZV1c58RpX5BvdGFDzqC8sahux5KFMHNbkxmEs251XrsE81dW
         H0pVpNlyqa0xhP7k6lRBiWqFasDzWsQREIzO7MXy7ir/liXYhHKq4BZw/nkLPn9pWaRy
         XTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730926086; x=1731530886;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kc0K+vQIjrK9TRrlc8Xtegj1qAqWg9yAmrhZy5bd6SI=;
        b=MLs2MYhwyOjl5xf7F8+vm4VHIBwbOpn0xknrnurxI4irrzdpC1imNkjm2hd9HAfeUh
         wxnOZigJDa+l85d4jrfFwXShYMPbOBtgbGPCUJNX7jZAPwrQI+clcYIIDjYiUg/I+zyq
         oAV439XOmvN38NMOdf1cJEDbwqotupz8fitjCpWp7SyU49tIS9J/2Oi3hpYu/38QQyHg
         LtZeHN/hXPZIBiZvg9ooq8jWkp9g8giNs6Al0WbiFiD6g0fTKS0SMxgrCjlcfbXFa62b
         bZM6ZBMq73rdB99zR0pFYGw2SQZVl840Qr8SNw5XFus/i7ASoDUv8ELBrFhZ1/uSTGh9
         K1GQ==
X-Gm-Message-State: AOJu0Yyi2NkJrrIcU8zfBGqPxlayANLVb0kbcU6S/oNqDsSi8gPSPV3g
	8dx2NX7IYLkyMHjP8G/NYIwUosysUqsVazu1ym0NMbXCLAFQ3L091tfo6g==
X-Google-Smtp-Source: AGHT+IEBQj7KH+y1g4zfnh0xEVpkPawRr0h5i1R88uHVUr4RwY7FF6RGysY/0uwRSNaHpUJ4WZMI4w==
X-Received: by 2002:a05:6000:1fad:b0:37c:cf73:4bf7 with SMTP id ffacd0b85a97d-381be7c2c8amr20458148f8f.34.1730926086548;
        Wed, 06 Nov 2024 12:48:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113dd8asm20318356f8f.73.2024.11.06.12.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 12:48:06 -0800 (PST)
Message-Id: <19c97feb06ef2f01f89b462678fe304b58fcba37.1730926082.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com>
References: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 06 Nov 2024 20:48:01 +0000
Subject: [PATCH 2/3] setup: initialize is_bare_cfg
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
Cc: John Cai <johncai86@gmail.com>,
    John Cai <jcai@gitlab.com>

From: John Cai <jcai@gitlab.com>

A subsequent commit will BUG() when the is_bare_cfg member is
uninitialized. Since there are still some codepaths that initializing the
is_bare_cfg variable, initialize them.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 setup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/setup.c b/setup.c
index 6bc4aef3a8b..5680976c598 100644
--- a/setup.c
+++ b/setup.c
@@ -741,6 +741,7 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 
 	if (verify_repository_format(candidate, &err) < 0) {
 		if (nongit_ok) {
+			the_repository->is_bare_cfg = 1;
 			warning("%s", err.buf);
 			strbuf_release(&err);
 			*nongit_ok = -1;
@@ -1017,6 +1018,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 		if (nongit_ok) {
 			*nongit_ok = 1;
 			free(gitfile);
+			the_repository->is_bare_cfg = 0;
 			return NULL;
 		}
 		die(_("not a git repository: '%s'"), gitdirenv);
@@ -1069,6 +1071,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 
 	/* set_git_work_tree() must have been called by now */
 	worktree = repo_get_work_tree(the_repository);
+	the_repository->is_bare_cfg = 0;
 
 	/* both repo_get_work_tree() and cwd are already normalized */
 	if (!strcmp(cwd->buf, worktree)) { /* cwd == worktree */
@@ -1125,6 +1128,9 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 
 	/* #0, #1, #5, #8, #9, #12, #13 */
 	set_git_work_tree(".");
+
+	if (the_repository->is_bare_cfg < 0)
+		the_repository->is_bare_cfg = 0;
 	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
 		set_git_dir(gitdir, 0);
 	inside_git_dir = 0;
@@ -1767,6 +1773,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			die(_("not a git repository (or any of the parent directories): %s"),
 			    DEFAULT_GIT_DIR_ENVIRONMENT);
 		*nongit_ok = 1;
+		the_repository->is_bare_cfg = 1;
 		break;
 	case GIT_DIR_HIT_MOUNT_POINT:
 		if (!nongit_ok)
-- 
gitgitgadget

