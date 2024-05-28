Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C2E6D1A6
	for <git@vger.kernel.org>; Tue, 28 May 2024 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877928; cv=none; b=biAXyzEsIbBezyvinfMBgZlRRihv4wgXjNNryY1eCLKNzqw8SzevA/kCfsjtLNwC3dDurBum2j5FQNlWipbDuTrECiUdsF2nlBeRKURWpLpts+pgX71nsssPwCfd7T6SnJURmpXm3il1iL/te2XmqHgXODQ3erAvKC1WXyKCAL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877928; c=relaxed/simple;
	bh=1N8Cj6X61lKUhP+vVkhp2bKXKj85A670L5WrKy0eJ14=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IcaHnHpC574qhvFt+KugV+36a8mxWj44DDcbP00YIkNNno95SNyQkEyGzTRiZWW+nM9d8teb3Ik0w2O5VQHu77O7k0KCI2uWmwbsAAUpYbjwZA2NPhLAkhkts6cCxDTyYIDBcS6KcrbEwFPRmDdjfNXpQXHedQBtn0IZE0ReUbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmvtGJOZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmvtGJOZ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-420180b59b7so3328735e9.0
        for <git@vger.kernel.org>; Mon, 27 May 2024 23:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716877924; x=1717482724; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mtodzgi0lDPpY5Z6ktdt7o8Yx3GFrAIqd2lVW3w2nek=;
        b=QmvtGJOZP9yIfgP2z2RTgUbREvX6NiCqDqtUtTeB6SBgPy+EgID7xlYamdohBQ3a35
         8iRjsJSX4uL5Kp4AcxdLa1VCbH5tPYE4jykPEH4ZCXxUC/DvSJUan0lW/uVIRyWOuTwf
         vWXtgS0BZ+Dh/3WY56wTdF+s/GYzdLmj1JnGbkj3CgTKKs9AWCXN8cgGA7Oh0gpZxVbb
         vUJu0DM84iP3AZmX/B+sqRKt0kS0Nd+swmFgyx5Ci3/6vvUToqh2CyxyGeRyhzmDsP1H
         JiwfavP6kVnQ3twUs88qo1uNCERz91wS4CLDcHGm7bavKOmL2VVE2gUpMHR55zJMEXeN
         6cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716877924; x=1717482724;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mtodzgi0lDPpY5Z6ktdt7o8Yx3GFrAIqd2lVW3w2nek=;
        b=Yj77hzFdbNXuQdr3UPVD1iqgjZ3rADIWYJVJSlDTR2x71EbvHKMSClPL48i6GdcWJo
         wbvRCITKrBF3XPum/+8PzUL/TsXAyPBl/3pYQo/0M9/sr7mXbF+SuooXoJ5MPHfyyWLP
         dbzljOUfIja42ImZmhN4muIw3NXLv/EkpfyGWyMmotlo3+HYhGtPeBNGH+sUU8Tkm3uE
         U92+CH8G/N+L703pgj3SYYqntro6BvA/8OOBU4omMXEc/Rmb8NYUBjHisURMY4L57Kor
         H3qaRN8qymyXN2Du/rUrU+B8axB372hXX4fOrVTVh8W2cG+o9lmKC0KOZ59CeLqQ6qAA
         iATg==
X-Gm-Message-State: AOJu0Ywnm3T5tb8y224MEszTxODnxEzn4egLAiuDysMKcsOBgv8t22Zm
	18GWxqlpHL0Q+QvMg/8jn3CIh5UT1/amA0+3dDE40Tt2Dcrpy2kWSqkceA==
X-Google-Smtp-Source: AGHT+IF3NBRLL+1n2+CXDtIEmPde5Xameastw6bhZcC2DULETKG0pbk+20SnbPOGfFi/rfDZFXmKLA==
X-Received: by 2002:a7b:c4c8:0:b0:41e:7a1a:d626 with SMTP id 5b1f17b1804b1-42108a03167mr99407685e9.31.1716877924025;
        Mon, 27 May 2024 23:32:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f1399asm163218535e9.11.2024.05.27.23.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 23:32:03 -0700 (PDT)
Message-Id: <c0bb37db12ea8724431fe4294d591cd8cef73e66.1716877921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1728.git.git.1716877921.gitgitgadget@gmail.com>
References: <pull.1728.git.git.1716877921.gitgitgadget@gmail.com>
From: "Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 May 2024 06:32:00 +0000
Subject: [PATCH 1/2] add-patch: do not use the_repository
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
Cc: Philip Peterson <philip.c.peterson@gmail.com>,
    Philip Peterson <philip.c.peterson@gmail.com>

From: Philip Peterson <philip.c.peterson@gmail.com>

Because usage of the global the_repository is deprecated, remove
the usage of it in favor of a passed arg representing the repository.

Signed-off-by: Philip Peterson <philip.c.peterson@gmail.com>
---
 add-patch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 2252895c280..b7f09122e1f 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -399,7 +399,7 @@ static void complete_file(char marker, struct hunk *hunk)
 		hunk->splittable_into++;
 }
 
-static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
+static int parse_diff(struct repository *r, struct add_p_state *s, const struct pathspec *ps)
 {
 	struct strvec args = STRVEC_INIT;
 	const char *diff_algorithm = s->s.interactive_diff_algorithm;
@@ -419,7 +419,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		strvec_push(&args,
 			    /* could be on an unborn branch */
 			    !strcmp("HEAD", s->revision) &&
-			    repo_get_oid(the_repository, "HEAD", &oid) ?
+			    repo_get_oid(r, "HEAD", &oid) ?
 			    empty_tree_oid_hex() : s->revision);
 	}
 	color_arg_index = args.nr;
@@ -1768,7 +1768,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	    (!s.mode->index_only &&
 	     repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
 					  NULL, NULL, NULL) < 0) ||
-	    parse_diff(&s, ps) < 0) {
+	    parse_diff(r, &s, ps) < 0) {
 		add_p_state_clear(&s);
 		return -1;
 	}
-- 
gitgitgadget

