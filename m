Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8FC131E3A
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983575; cv=none; b=jCevzkZQiYEPf1OH8KZn8ACi81d8M9jzfbqHQP4gHfhTz/FafhDxiGkQbdiPCKSI5/Wak+WO33Tuzyq1aEV5TO4YLxeWxKtjGImgF7tSMS1W0QYViTgY+y98LFF6w6aHKcNoc3WBHCiRoLzotqAPgoaaQTVYOkQxv1V+8MlSBU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983575; c=relaxed/simple;
	bh=vLaZBMjrvVg999vONXdYrb0Ew9pRcJ3/fnEw03SQqT0=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pBd/dOxPyIY7K9048pd/hH7EmYtVCoAqxlBdkU/w8I5M9VmHEf6Zy2h5Yg/JGeF5hYdVJjI8GX+cw3IAE9GGWbG9ONzzpo70zPJ2E8tARqzYH/8WNU5LNqdZgbWTPNv38AmMH6vJLhRizDJomwmS9uOf94jTC6tj2HowUEH60As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXoCSEJx; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXoCSEJx"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33d754746c3so2436144f8f.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 13:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708983572; x=1709588372; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rg+rmbAbdVTzdJr+bM0adr1ATCJ2MMLlOmTLVcUc8eA=;
        b=AXoCSEJx5QGb1cXPUYQTByJIkCNQOM6dFlb+Y7j6MhSAjF+r4VdL4c31AX2l6teJ/b
         koN4cBLOix0CZ9JTqLGfQbB999hlR/XAaxt7TV2KvMhtvrB0mU9XBMOiOpYBePoM2esG
         r8VkrGUMvDAygeOFOK9BbpnMDNUublSv5adeVOF5MSSHewf5u/IXfJRPeo+XFbjuu3zd
         BcJOvHRpSib9i1kGWksY7b+Z3ieT515COQtJaCvn1R7S0Egw69q65MU1mmyqepGhI1YM
         DeWpe/CVyDJ66eoLc1O6duhDZoCczWgcbRpGJkbAJEj9oM+rTiRzULdFeqCtq0xK2XZh
         AaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708983572; x=1709588372;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rg+rmbAbdVTzdJr+bM0adr1ATCJ2MMLlOmTLVcUc8eA=;
        b=skAc2MShZEbA7tfrwPToFFCvORo1wyC5UMl/lBx7qd3rgUqgk2bxtreX0/SISDyx0k
         1RnwwbOcY/B5B4UbnjjG8FMdw7zCrz0chnitux4+3ADGYVkmcJTGV20HfCI5po4KX0zm
         SRYfSARaf7h8NPKnXKbkMErXHeT5TETj8XR074v194q0hWJlhbJcZ/58emjxjZoJQyvr
         9iraaSneC6akDlhPw11ph7V8AgWbvbcEbzFXMwbdGnUH0jNCVpLri2C4YciPTXeJuu3P
         biGjlw92xAEUbXHZDQn/9pZP6c/op67SMAoqi5xzcXlpHP3OvzmF6zixDGn4l30f1IM8
         bA/A==
X-Gm-Message-State: AOJu0YzEFVJQyfpbV6kbuVGe27+QmBiFXKmljnMgYmPo4MTXcezxZFw7
	0kMF/x+9YzjFBW77JU2Kx8wNc+gz5WP5oE18Iq/EPUajiMyFHUNHALUOu8Hs
X-Google-Smtp-Source: AGHT+IF0pu2yM/dVNyzx6lgYAN86AZIMUQ8ffrVciAGVs5V4/ibL/zDq0IQHajdHeQHGu7KHi5t9bA==
X-Received: by 2002:adf:f78d:0:b0:33d:1656:21fa with SMTP id q13-20020adff78d000000b0033d165621famr6844761wrp.24.1708983571864;
        Mon, 26 Feb 2024 13:39:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bs23-20020a056000071700b0033d5f5571b4sm9471196wrb.44.2024.02.26.13.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:39:31 -0800 (PST)
Message-ID: <348b9b0c94e23d82f1df69b0b24b70d6cfb48a19.1708983566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 21:39:16 +0000
Subject: [PATCH v3 05/14] fsmonitor: refactor refresh callback for
 non-directory events
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Move the code that handles unqualified FSEvents (without a trailing
slash) into a helper function.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 67 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 29cce32d81c..364198d258f 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -183,6 +183,43 @@ static int query_fsmonitor_hook(struct repository *r,
 	return result;
 }
 
+static void handle_path_without_trailing_slash(
+	struct index_state *istate, const char *name, int pos)
+{
+	int i;
+
+	if (pos >= 0) {
+		/*
+		 * We have an exact match for this path and can just
+		 * invalidate it.
+		 */
+		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
+	} else {
+		/*
+		 * The path is not a tracked file -or- it is a
+		 * directory event on a platform that cannot
+		 * distinguish between file and directory events in
+		 * the event handler, such as Windows.
+		 *
+		 * Scan as if it is a directory and invalidate the
+		 * cone under it.  (But remember to ignore items
+		 * between "name" and "name/", such as "name-" and
+		 * "name.".
+		 */
+		int len = strlen(name);
+		pos = -pos - 1;
+
+		for (i = pos; i < istate->cache_nr; i++) {
+			if (!starts_with(istate->cache[i]->name, name))
+				break;
+			if ((unsigned char)istate->cache[i]->name[len] > '/')
+				break;
+			if (istate->cache[i]->name[len] == '/')
+				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+		}
+	}
+}
+
 /*
  * The daemon can decorate directory events, such as a move or rename,
  * by adding a trailing slash to the observed name.  Use this to
@@ -225,7 +262,7 @@ static void handle_path_with_trailing_slash(
 
 static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 {
-	int i, len = strlen(name);
+	int len = strlen(name);
 	int pos = index_name_pos(istate, name, len);
 
 	trace_printf_key(&trace_fsmonitor,
@@ -240,34 +277,8 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 		 * for the untracked cache.
 		 */
 		name[len - 1] = '\0';
-	} else if (pos >= 0) {
-		/*
-		 * We have an exact match for this path and can just
-		 * invalidate it.
-		 */
-		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
 	} else {
-		/*
-		 * The path is not a tracked file -or- it is a
-		 * directory event on a platform that cannot
-		 * distinguish between file and directory events in
-		 * the event handler, such as Windows.
-		 *
-		 * Scan as if it is a directory and invalidate the
-		 * cone under it.  (But remember to ignore items
-		 * between "name" and "name/", such as "name-" and
-		 * "name.".
-		 */
-		pos = -pos - 1;
-
-		for (i = pos; i < istate->cache_nr; i++) {
-			if (!starts_with(istate->cache[i]->name, name))
-				break;
-			if ((unsigned char)istate->cache[i]->name[len] > '/')
-				break;
-			if (istate->cache[i]->name[len] == '/')
-				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
-		}
+		handle_path_without_trailing_slash(istate, name, pos);
 	}
 
 	/*
-- 
gitgitgadget

