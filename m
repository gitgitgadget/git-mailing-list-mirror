Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40D8482C9
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566816; cv=none; b=tSC/y+fXIiOrhl1QnbgpzLD/fxOibYHKw07iqKq2mc35p2u7xKu/2DB8BndNooeMMt9zky2aqWLqcIg5ihjTvN0c9mnscinBzyD6r2Gfif7dSWMW594XCQt6iueRn1ojRnMjxHNXfZjQGv19FpZDuvVaBvKKBQ3hhnGIwHD+wRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566816; c=relaxed/simple;
	bh=m20nHkEJ9M9RgMnpiunE57cAJy/LUOenPGO0EFxA04U=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kUyspQQ3GyCt5Z+s0yu/DmGRbzEWpFaZ1Kr+FT/HurGT0rTFecCpjjRB05DsqG6GgenS0l6/Boh026N8r8yoHbwy/+TKpkRSL4xmKflhq7Ax5qxwpbhlFrQorUjd6PFEsKQueNkLCNZoA21h7jjSgGWCexY8OWx3LcrJcr6Ov6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6jnhKKw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6jnhKKw"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33ddd1624beso2993976f8f.1
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 07:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709566813; x=1710171613; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgER52tmIvBJG4lqzwRTZ1uvr/BPpXF0FMqkFydmFc4=;
        b=U6jnhKKwahBGLCBa8FDghpJrdXaVbhefG7nzI7LjrZ3YTB6MGKTztWp6b2xUek2EIX
         tdHp31JKRZpUKjUNJmG451UNG5z4Be1plGEK8criZy/sEWFQsCwfuJrf7lvYvuqBbUuS
         nxw/NSz0mP/venpo6HEa8pEPx21AFHpRmWvq6CWQrAsihPAtx90GC2nIYDDPLTle+3xz
         ciywcuyPszf+UT/xGLmLRze96Hg9YQ1WSDnI/OGbc5OfmFkyY7SRWhSWbrlFB46SsxlH
         3sxWBWF6VYvOquYgSH9ry+IH+uqJ2nxufvpqdk80wqRKJknXBxAPF9OsZVzmpnuLl87X
         3ZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709566813; x=1710171613;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgER52tmIvBJG4lqzwRTZ1uvr/BPpXF0FMqkFydmFc4=;
        b=tZFTVn2MxyUYc9MJ+FckEZe7QSM1fsCFPdxU0pVvCVtq3EFoCtdehyzMcO1mUwadeL
         vd9CWSLrFHQ2d4nO5Xn6d6/DK5GQolVHjYNI/lAnOxrYKU4wnSfmXDYPTK9n5vbEcyF9
         cU4aGgNx46sZ0H6m4q0JfnfOmooIapsUIwbfGY1Xej2XSOoobNF48F/PO3HXyCp9UrYR
         8wSTHYvEnrtVB59TjiEiLBP1wfs3soZHDMamAWjTjh0HB80LeR/zTfhvxdgWUqcjd5q6
         k0hqqFWZFVv3zPa4BOYzuu9vVb9wD7sDe8t9ac6jzpPdfGgM07tPBLU7+euNr9fUj5PH
         eCsg==
X-Gm-Message-State: AOJu0YyjKHXkshbnhci7XyeNLIoMho7NrsMLw8i/ARTnm0I7FYGXFhsH
	PyTM8e1nTsngRCAxGzfy095gZD0d2QuRz18EYsMPm/hIR1QpH0SIQQ9mMXV7
X-Google-Smtp-Source: AGHT+IHKmhB5hn1+Lg6a5kTMTXnqxmYXaDDTF8ZkiqtonVZJgRfWxrxUAd2x8JvU3tZ1ss0iyCC6nA==
X-Received: by 2002:adf:e58a:0:b0:33e:1c3b:9638 with SMTP id l10-20020adfe58a000000b0033e1c3b9638mr8496655wrm.19.1709566812440;
        Mon, 04 Mar 2024 07:40:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bp3-20020a5d5a83000000b0033e431950c5sm1831636wrb.97.2024.03.04.07.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:40:11 -0800 (PST)
Message-ID: <65068e97597241e297f5d7cdb60012be1784e9dc.1709566808.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1679.git.1709566808.gitgitgadget@gmail.com>
References: <pull.1679.git.1709566808.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 Mar 2024 15:40:06 +0000
Subject: [PATCH 2/4] trace2: avoid emitting 'def_param' set more than once
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
Cc: Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

During nested alias expansion it is possible for
"trace2_cmd_list_config()" and "trace2_cmd_list_env_vars()"
to be called more than once.  This causes a full set of
'def_param' events to be emitted each time.  Let's avoid
that.

Add code to those two functions to only emit them once.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 t/t0211-trace2-perf.sh |  2 +-
 trace2.c               | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 588c5bad033..7b353195396 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -470,7 +470,7 @@ test_expect_success 'expect def_params during shell alias expansion' '
 	grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
 '
 
-test_expect_failure 'expect def_params during nested git alias expansion' '
+test_expect_success 'expect def_params during nested git alias expansion' '
 	test_when_finished "rm prop.perf actual" &&
 
 	test_config_global "trace2.configParams" "cfg.prop.*" &&
diff --git a/trace2.c b/trace2.c
index f1e268bd159..facce641ef3 100644
--- a/trace2.c
+++ b/trace2.c
@@ -464,17 +464,29 @@ void trace2_cmd_alias_fl(const char *file, int line, const char *alias,
 
 void trace2_cmd_list_config_fl(const char *file, int line)
 {
+	static int emitted = 0;
+
 	if (!trace2_enabled)
 		return;
 
+	if (emitted)
+		return;
+	emitted = 1;
+
 	tr2_cfg_list_config_fl(file, line);
 }
 
 void trace2_cmd_list_env_vars_fl(const char *file, int line)
 {
+	static int emitted = 0;
+
 	if (!trace2_enabled)
 		return;
 
+	if (emitted)
+		return;
+	emitted = 1;
+
 	tr2_list_env_vars_fl(file, line);
 }
 
-- 
gitgitgadget

