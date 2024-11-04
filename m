Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512E3E552
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 19:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730746971; cv=none; b=T50pUyESOKIALisl7qfz8HgxQ4WRcQdIm87wnWe8ubj1FWvIYk66IrhxD/vGsTiEOtiYrqQEAWqeZcfhvjEj01RpIxYDVBnRCTM8vbl4qaXvvOu3WtLNRIpt5XW3dBPSLq0o3kMhcTaC+2pB0jW6/g3d52vCPFntUL/CuzaosQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730746971; c=relaxed/simple;
	bh=B+OuBAvFzI0ntZD5ywtC6Dd8k983bJyDY/gzHXntdpA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RzPajcv7NvmEfVVuRtCC8kDQJkolm1QAOoTKZn2Zzcft5p7fy+hFji9S8cQLeR0wnzEzJp62d47Dbfz61pqrn7FPCO5yNfi82jptBQay0OzeRrniCoqeXEsSKsmvIiq/CPgPCeYkRshcTZop1e9IQv+kJNYOTtY0og08P3hbtuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW/y15Ex; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW/y15Ex"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43158625112so40242985e9.3
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 11:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730746967; x=1731351767; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9k3/E7bA5YlNeAq/cUKkUl4wRaY91TBUnwDBj+5EDA=;
        b=LW/y15ExHFJbN0D8yZ22yx+g271UqmywXR+lrirFvO+SkQ+ysqJvhhhwEHlrKp/qic
         jblRo+2qSF0yvfRtBkU7DH3UCH7ii5wyAl1+XkITRHeNsHwMGg9FSIp03tLwZ/cPOVID
         3GWn+DH0N/NgyYV1Ca/TsjCoFzlyZbqJvJIdgXF4lA0/j2tlkTDzsStxndM4bBPry/mi
         OP1HUeBHVOlOQBkTaPTP6Gz4jSJkHjU9rK6bixxyKUtbEhqZzOA8JapOq/rgEjE9Opwe
         4Ue4CGiCV/ThisQCv9/aPCHBR4PWJSaC1BtS8jHIbs/WPBOVjCV3QynKcGrxeZxewjIV
         LRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730746967; x=1731351767;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9k3/E7bA5YlNeAq/cUKkUl4wRaY91TBUnwDBj+5EDA=;
        b=f5G1BjjcE2aBsqCQtvNH+K7a3db7H+fEUaZez+dg6vsAgJMLjXPr7ONvqawx6JPn4H
         oXgetVqq8mw5x0TKoh8zZFeZV8RGwy3vGuz7bK4IKFKE4RidxhV78iJzCeqwWiH0srNR
         AnrNhAIGSB06BpeUwY4d/TsC1YmTPwb8RUbjMXOAeueqsnS0iYkhU/oPRx/AHAsmuL04
         4XO6u9oSYM3Haru9sRnl+jS18dShytclU2dHwm2e038G9kxWhZxbyUgodnGtrD620pGx
         7DN3feh+5u56rtAAZFdel1ZQ0MRsIX85tBtrNJMudHXBSVa9NyOQ15KC7BPL+rSiPWgb
         CI+w==
X-Gm-Message-State: AOJu0Yw8tR0Vvv4hjH6EOx64Sz/MR/B9dD8F3+0yICummbJ8l9Oh2LRR
	Hu/CoZdkD6lhZWN5TtisPKnXjBbZMzSoLZfbeCZ8B73yWFxlTQ2/z9s9OQ==
X-Google-Smtp-Source: AGHT+IF8RMf0g0ZqfkwKCZQrgnjuCyqbXUPuOSgc0m7vtyv1bKbi7knmcffjZnZrovs8NhDhDX9htg==
X-Received: by 2002:a5d:6c62:0:b0:37d:42ce:f3a5 with SMTP id ffacd0b85a97d-381c7a3a6b3mr10016356f8f.12.1730746966699;
        Mon, 04 Nov 2024 11:02:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d42adsm13857277f8f.40.2024.11.04.11.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 11:02:46 -0800 (PST)
Message-Id: <bb8dbc5c7086ce5c09f8980c923ec85da38c9147.1730746964.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1822.git.1730746964.gitgitgadget@gmail.com>
References: <pull.1822.git.1730746964.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 Nov 2024 19:02:43 +0000
Subject: [PATCH 1/2] upload-pack: fix ambiguous error message
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

upload-pack.c takes any --shallow-exclude argument(s) from
clone/fetch/etc. and passes them through expand_ref().  If it does not
get back exactly one ref from the call to expand_ref(), it will die with
the following error:

    fatal: git upload-pack: ambiguous deepen-not: %s

Given that the documentation suggests to users that --shallow-exclude
accepts a revision rather than a ref (which will be corrected in a
subsequent commit), users may try to pass a revision.  In such a case,
expand_ref() will return 0 matches, but the error message we print will
be misleading since "ambiguous" suggests there are multiple matches.
Provide a clearer error message for such a case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t5500-fetch-pack.sh | 7 +++++++
 upload-pack.c         | 6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 8da8e7fe423..6552da78d19 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -926,6 +926,13 @@ test_expect_success 'fetch exclude tag one' '
 	test_cmp expected actual
 '
 
+test_expect_success 'fetch exclude tag one as revision' '
+	test_when_finished rm -f rev err &&
+	git -C shallow-exclude rev-parse one >rev &&
+	test_must_fail git -C shallow12 fetch --shallow-exclude $(cat rev) origin 2>err &&
+	grep "deepen-not is not a ref:" err
+'
+
 test_expect_success 'fetching deepen' '
 	test_create_repo shallow-deepen &&
 	(
diff --git a/upload-pack.c b/upload-pack.c
index 6d6e0f9f980..640d45295e1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1025,10 +1025,14 @@ static int process_deepen_not(const char *line, struct oidset *deepen_not, int *
 {
 	const char *arg;
 	if (skip_prefix(line, "deepen-not ", &arg)) {
+		int cnt;
 		char *ref = NULL;
 		struct object_id oid;
-		if (expand_ref(the_repository, arg, strlen(arg), &oid, &ref) != 1)
+		cnt = expand_ref(the_repository, arg, strlen(arg), &oid, &ref);
+		if (cnt > 1)
 			die("git upload-pack: ambiguous deepen-not: %s", line);
+		if (cnt < 1)
+			die("git upload-pack: deepen-not is not a ref: %s", line);
 		oidset_insert(deepen_not, &oid);
 		free(ref);
 		*deepen_rev_list = 1;
-- 
gitgitgadget

