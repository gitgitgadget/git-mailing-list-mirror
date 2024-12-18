Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF053596E
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734485734; cv=none; b=tdDBVPNLwEmEs/8yg3ANu7D8yIaR4CxkBuCguVeamOPvYvSZX5jO7JizL08vawVvvW3o6kEByoYqz8iU6IxjbnoK2d4XGTpD04IFetg3vm3b4Z34oVDgkJZSZ/S43Rj1cxeL7LpFYFOgX1MH3Q00MWfnlEEWFgVfbZApCRVss0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734485734; c=relaxed/simple;
	bh=4lle7JFtiz3fz6AJrIm5LMxz1is+eBDiJ4AiHAxWpyw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MK1KmX5LrGpL3IuwpYi3y01slFAmdLay1gK2EKP99PcEhV8COMcVr43P0OCAGoUzAkO+8uC6s2CQt1n6K/S1xpMaKfHVREC4DdUC+psVbV9sGzLJOX3HtJKMoOGkHBoGM3HR7OeLuflHhuo6SmZv5ew90OkvLSFnIuP9ZiDGIcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ycq70OXw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ycq70OXw"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso5039517f8f.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 17:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734485730; x=1735090530; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5zbXgch16Oo5jjM5Y20IwGDn76btyUHDYFcbMGzDKU=;
        b=Ycq70OXwyChcVrvxHK5uKy5g8QvKBneENn6L7Yx848eeynywAtbvfkL43zEMFv4wJJ
         yurUd7mXExXx3fbHcKzHxRM4d5PFujP80glCOI+8wB+6MHZ+jIKGezhFGwKYuUZasZ1M
         Bp+C1zLxyx9xAM2veS1FqzmlYbkR2lqYSmmE8kqx9gTYdskkbNFxYSgPM/A9Tld1U59g
         e9d4kJ99XjrVORxdSm3BrXSMKAjZ6AcGigQbYXQ8gTopawAO5BLTMWzf6EUUccr0ivqX
         vTk5Uh16kE6TAcOig/srrfV2UcJI57I/oRvTR5GYhaOQJGEUvc4oKl9PfZsEJYr9kUxt
         7ofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734485730; x=1735090530;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5zbXgch16Oo5jjM5Y20IwGDn76btyUHDYFcbMGzDKU=;
        b=HIFtASaDDnBC/szHPuEV5TF6eE7S8ai6ETmbmJsd3Sbcyz2GT93N8zzaFnl3Rl5X6D
         uFpZ615o2iTVI9UQcLm0yfvEHTHDhGauZJUnn1eNfaefIiCELbFrIgwUAoV6D47sNlys
         hTlAdor6AGUFP290IMTaqlZ7jvibq+8DUAU1n25ohOeqs/X24H3clYfcpGgWV/Pk5qBe
         BUgUwuwenKMX9PYwvypRBTFjGJYlPu48S+TZUeqc2j+HF901aSE12dCMOTvLLEDYknW/
         8Oc5pCNq84/CSdjWrRQpuNM0x/PAhy1Jk/pwPmgG75qdarYCfSEh+kTJ1MBBViwk9q6t
         +usQ==
X-Gm-Message-State: AOJu0Yzg278MmXKzw5D5Cjj9fsyeKMaaPSusp2flqjF82jZ2GpKszD3v
	868AB7mI81rUKeWF44CrJh7KjXcJDZdod4qZ1CCxbUtI65Y4/KTyoJCCGA==
X-Gm-Gg: ASbGncvvNWvNssvsbyk2ODe6IK2EoKqjgBEcZZljMSYIsGtVaEbP6XVYyF4hj52PSVF
	eE6uavuNL62+xDshlpXsqorqspRfuSlOgeH37FLtR2DLHo3hm2oc6oGF5yGROcKLbtI3HAXFwaR
	ZWqkULd28tfl20gP7qxKgzMnJsBsx2BbpHqMRY2a1FBhLvXLYnb1DRZ1wbQaM7utcL9v8TG02X3
	xgrJcKNMmsRTJlxk/luXShVUY2OPCczc5+P699RTkQrjgKIFryBSIN3QA==
X-Google-Smtp-Source: AGHT+IF6YS8HPTDowPeGt3S9GRPOiC/LpfwaqpCgp/Vy5ATQOpNR87D7wHBnt6/AZNRrHWsHUmHNpQ==
X-Received: by 2002:a5d:648f:0:b0:385:e2d5:cdf2 with SMTP id ffacd0b85a97d-388e4d83f1emr565139f8f.19.1734485730327;
        Tue, 17 Dec 2024 17:35:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b7esm3695435e9.13.2024.12.17.17.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 17:35:29 -0800 (PST)
Message-Id: <pull.1843.v2.git.git.1734485729135.gitgitgadget@gmail.com>
In-Reply-To: <pull.1843.git.git.1734480952423.gitgitgadget@gmail.com>
References: <pull.1843.git.git.1734480952423.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 01:35:29 +0000
Subject: [PATCH v2] git: use signed loop counters when comparing with signed
 vars
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
Cc: AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

The compiler (at least LLVM) treats them better anyway
because of the C standard not defining signed overflow.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: use signed loop counters when comparing with signed vars
    
    The compiler (at least LLVM) treats them better anyway because of the C
    standard not defining signed overflow.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1843%2FAreaZR%2Fone-more-time-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1843/AreaZR/one-more-time-v2
Pull-Request: https://github.com/git/git/pull/1843

Range-diff vs v1:

 1:  1dea0ce98b4 ! 1:  c8552548fe9 git: use signed counters when comparing with signed vars
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    git: use signed counters when comparing with signed vars
     +    git: use signed loop counters when comparing with signed vars
      
          The compiler (at least LLVM) treats them better anyway
          because of the C standard not defining signed overflow.


 add-interactive.c | 2 +-
 bloom.c           | 2 +-
 git.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 49042b30261..12c23fa10ba 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -848,7 +848,7 @@ static int get_untracked_files(struct repository *r,
 			       const struct pathspec *ps)
 {
 	struct dir_struct dir = { 0 };
-	size_t i;
+	int i;
 	struct strbuf buf = STRBUF_INIT;
 
 	if (repo_read_index(r) < 0)
diff --git a/bloom.c b/bloom.c
index c4286341059..42db509bea9 100644
--- a/bloom.c
+++ b/bloom.c
@@ -314,7 +314,7 @@ static int has_entries_with_high_bit(struct repository *r, struct tree *t)
 
 		init_tree_desc(&desc, &t->object.oid, t->buffer, t->size);
 		while (tree_entry(&desc, &entry)) {
-			size_t i;
+			int i;
 			for (i = 0; i < entry.pathlen; i++) {
 				if (entry.path[i] & 0x80) {
 					t->object.flags |= HIGH_BITS;
diff --git a/git.c b/git.c
index 46b3c740c5d..86f7112f4bf 100644
--- a/git.c
+++ b/git.c
@@ -946,7 +946,7 @@ int cmd_main(int argc, const char **argv)
 	 */
 	setup_path();
 
-	for (size_t i = 0; i < argc; i++)
+	for (int i = 0; i < argc; i++)
 		strvec_push(&args, argv[i]);
 
 	while (1) {

base-commit: 063bcebf0c917140ca0e705cbe0fdea127e90086
-- 
gitgitgadget
