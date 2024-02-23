Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C5AD29B
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 03:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658311; cv=none; b=Ou6mU6Z+S+GcPcufO2UomZhSXpnes84KrGKE/N0Y3qxWfEknvtjU2tFCSSIKFxy0sWpKqyLmpfMxSA4sPL98haVRzZrN5jrCwkAeU4do74ERwaTob9YJ3dwoJPdfMA9K4ng1wCct96u8GomhplShCufzTJ6zma3Z3f4yzK3rlH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658311; c=relaxed/simple;
	bh=erNCQFjvIiC2NHLYEteWfRNdfyr0Xh9cfM3eyTbANwk=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jh75wLTJbqmSUMmI/WGuyWWK92Jbey2IbobgTU/S2BNRNTtad8YoRruqGdLleFTcBRGnhlmicA8VyBk2m8m7xgmLYpbm+8L5otp7tKBSYdmNykNO4b5jGsq82t3prHEeJc0gNeJkAWbW8zNWZLd7uZH2GmjvdWK3oGWa7iGZmao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6w47fHA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6w47fHA"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41275855dc4so3212445e9.0
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708658307; x=1709263107; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRBX0CPHr6Kn4VU7i/3jgm014tLL34H/9vHqAiywal4=;
        b=g6w47fHAmYB0+eNjfDV+ebRJx3iBnSM0lVMsiUu+CEJ2M+bW0jnjqFVe8LXa5YTxNC
         pR39sg6PfLFF59JVz1ZS5/4gLO6SsmdgvZPTt01umIdB9jTiVaicYyQFFZwImj4zKDR0
         tV1oS0HMQ+22jjEHgpjSdZS805TDRFitVzOCb/ow5n3jxakQFnbrtdvenLtvq0Bs9Dtf
         vEvYx2rOz8hlm02AyZdHGBWOoyihV/9NQoDsECvYqf+b5OFJs3UMIif/6mbKnI1Y0mkI
         6KDAwGPDKhrD8Ps/HHbhTR6E4HQkg18wuzjYjokjAUnWym6xjqw/enOn0QSdBlHTRTCr
         +2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658307; x=1709263107;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRBX0CPHr6Kn4VU7i/3jgm014tLL34H/9vHqAiywal4=;
        b=iq+ofM0rMq6ls5ETrZgbHFebBvufuidFFbCbr/nnVEpIScOHjF5KZCTRHQlkPyt/cQ
         zGRS5o5H2ANuzSXMEg6Z2I7BIV/I6IdCmVjx3ovC/412dGvYzW5X4YyDK6Wtsb/Wjm06
         NOl1wUCnaJDZwPTQ57m1OqQiataxjySizaP8GQ6WntfmREH/jUJz736Y5ysDNjpI9gW9
         BRzahL3DRPDCI6xo5vYN1etYP65L7JVT/CRGfUI4c/wNIYRGxukLUhpqPClXavvxlWSX
         2j5gcNhBGqCONtzGTL1D3EOsWJV1PC75H6M+Kgh2RyR6t6WL4H/iPzg5np2V4ZpVlGp5
         gGcg==
X-Gm-Message-State: AOJu0YxI/EzBf1uOd/u3qqV9MprzD0v5ZKQFmmXnYpaJKnz7wGEOruh9
	Hznh6I6+rYEmgJB7tRznc2/ScimtNM8RUPsIcAJcSHUoP5k7WdWm08ndwuwR
X-Google-Smtp-Source: AGHT+IFhmc+b4gewiHJmjL1dJtphxUigIZw4r93j5EOoi/mAgzc8Lm8a3WAcHC2RtqUGEe9H+cLl3A==
X-Received: by 2002:a05:600c:4e0d:b0:412:901d:a844 with SMTP id b13-20020a05600c4e0d00b00412901da844mr332334wmq.37.1708658306800;
        Thu, 22 Feb 2024 19:18:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c4ecb00b004124219a8c9sm585950wmq.32.2024.02.22.19.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:18:25 -0800 (PST)
Message-ID: <5516670e30e26c5b50c67b69e48e3e8a5e0d8990.1708658300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 03:18:08 +0000
Subject: [PATCH v2 04/16] fsmonitor: refactor refresh callback on directory
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

