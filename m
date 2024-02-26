Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5EE130E3E
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983574; cv=none; b=jQ04f104J96tFlT7lGzG2uHT+srl7NJzyWqdAe46eFUQeKsVv1ha8ylEnIrOpwBUXjDO8daM9uRV4U+Z941WbGB01CrUqH5A+Y2Jv9Z0lYHRPgMVPdiRk91snBuOrtm29phoxvWowPfcUmrOAKPS50LIinDUWnkgO9f/ksZL7p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983574; c=relaxed/simple;
	bh=erNCQFjvIiC2NHLYEteWfRNdfyr0Xh9cfM3eyTbANwk=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fXGsNMn3pyiE0MolftSN8daDFz6Fc2d0Sdk32pd50J3b2tvkHvOH5nwsOtZ1tP7fYEoqqkG2Lb38AB50XCU5RcPuNUr7JWpVFAu8Rlm53PJ+qrdGdXN1skZlffudKgpD8xw5uL6EO9Yu8NLz6sX0fptJACwDVxDREMGjULXVcbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/XXyk/k; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/XXyk/k"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412a9ea61adso3264295e9.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 13:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708983570; x=1709588370; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRBX0CPHr6Kn4VU7i/3jgm014tLL34H/9vHqAiywal4=;
        b=b/XXyk/kjzYvkNvFaDgTFpVjPjngBelRKAWRexuMYI+Zs+oLp0Yk1oHm9fw6rkoZem
         W707xS8BNI9boY5/TegrU/7aXHNMyrcUUITyy+CKbOMzh3ZSfRijhEV/5ZVXLrwbvBly
         r2LQMtATFwLdikIHSCpd0EBNFHaZ0CszFKRYIMZXQov1vV+4t0wY+c3H49eewV5lRP5b
         zWx0kUaRIKQ+wFxcrXkdfnFM5j3WZW1HR4IfOZLE7Dsr/ZKmHyZ74yu8cInSrJ8RBDMm
         uHQFZytpx67JTAm3mw98a4DmL4WXo2ElMJGPke/e8ROAaN5BaqgYI3iGySME9AI/r1qk
         78qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708983570; x=1709588370;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRBX0CPHr6Kn4VU7i/3jgm014tLL34H/9vHqAiywal4=;
        b=hVhN1KGaHYiSDJeU/rexmbih1j99uGkdQBYYoGu0aCM/217uSgcuBy3X3m4El0qvjm
         FiPJCdbrw6CjyL8BvaNhG/9WIId4xda5OTok5tDtSPz9LNmDi9rKQL4/xBTnBbjqvVAs
         sIeZHLuxFEE8WpZIReFG/fjvMCTuCmBGz4sxe5SELx6i2zmwUkGXcPXjTmXRHfwArNOG
         RlXL6ukEbygysGj2BMVAkg6wcxgQSON2W9OggCCIQST/YkgUFHrk2S5mCxCRiRw9iEMh
         Q0wZEm2Knes1v8CBtJW/2z0LgDHuS7e2/6nX/yjmxDDJNC2u6SVEHM5E0gkz50L70bf6
         h7yg==
X-Gm-Message-State: AOJu0Ywi4ALGywKsnc777C33pQZBBo6vcKNH0i+6IGe0G7QRz2ikV0Es
	7AL/7UnF0YMsY0qmzCFa60A84TGnWrTJP4FBwRFyOk5gwiYwi/P47+TV/CGS
X-Google-Smtp-Source: AGHT+IEc2cte3mYGrHrdmuMs10MyGvrVAl5I567ZrOl2cSETUuczKUxFM7+WEI6qKjjI0yytbZNqmA==
X-Received: by 2002:a05:600c:4708:b0:412:a333:1d36 with SMTP id v8-20020a05600c470800b00412a3331d36mr3344151wmo.32.1708983570330;
        Mon, 26 Feb 2024 13:39:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15-20020a05600c220f00b004126e26f756sm12998089wml.43.2024.02.26.13.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:39:29 -0800 (PST)
Message-ID: <518cb4dd5df0c71ef43078129fbf78a8b232a749.1708983566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 21:39:14 +0000
Subject: [PATCH v3 03/14] fsmonitor: refactor refresh callback on directory
 events
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

Move the code to handle directory FSEvents (containing pathnames with
a trailing slash) into a helper function.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 52 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index f670c509378..6fecae9aeb2 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -183,6 +183,35 @@ static int query_fsmonitor_hook(struct repository *r,
 	return result;
 }
 
+static void handle_path_with_trailing_slash(
+	struct index_state *istate, const char *name, int pos)
+{
+	int i;
+
+	/*
+	 * The daemon can decorate directory events, such as
+	 * moves or renames, with a trailing slash if the OS
+	 * FS Event contains sufficient information, such as
+	 * MacOS.
+	 *
+	 * Use this to invalidate the entire cone under that
+	 * directory.
+	 *
+	 * We do not expect an exact match because the index
+	 * does not normally contain directory entries, so we
+	 * start at the insertion point and scan.
+	 */
+	if (pos < 0)
+		pos = -pos - 1;
+
+	/* Mark all entries for the folder invalid */
+	for (i = pos; i < istate->cache_nr; i++) {
+		if (!starts_with(istate->cache[i]->name, name))
+			break;
+		istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+	}
+}
+
 static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 {
 	int i, len = strlen(name);
@@ -193,28 +222,7 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 			 name, pos);
 
 	if (name[len - 1] == '/') {
-		/*
-		 * The daemon can decorate directory events, such as
-		 * moves or renames, with a trailing slash if the OS
-		 * FS Event contains sufficient information, such as
-		 * MacOS.
-		 *
-		 * Use this to invalidate the entire cone under that
-		 * directory.
-		 *
-		 * We do not expect an exact match because the index
-		 * does not normally contain directory entries, so we
-		 * start at the insertion point and scan.
-		 */
-		if (pos < 0)
-			pos = -pos - 1;
-
-		/* Mark all entries for the folder invalid */
-		for (i = pos; i < istate->cache_nr; i++) {
-			if (!starts_with(istate->cache[i]->name, name))
-				break;
-			istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
-		}
+		handle_path_with_trailing_slash(istate, name, pos);
 
 		/*
 		 * We need to remove the traling "/" from the path
-- 
gitgitgadget

