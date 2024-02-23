Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F896111B6
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 03:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658314; cv=none; b=NM4lqHkUkwmDwziW0HkVBkG30qhqIKmFpmc6iHTGrZteOesgR0ywUK107lM7vO2DLuDn60nMEv8JMGmPLLuaU97Zq7unVAzofF9BvwKAU60sJRxNxlrQge9RfwXT5/3TU7yAzxqO0nNFjhPOO07qr5bx3u535nK+dNkRJVotwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658314; c=relaxed/simple;
	bh=sUlvd8QxFgxP6Yjnn7Jtk/vpZchrcbfCg8YI4jN7Yk0=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rGUI+cEcSR6scl917J0+S2u/K8zgZ3msnMEG8nj0ZmRrxmS/h9UoSe0qhS94P2lQS2swUQ95ZTfrlzfuy6qLoqu5jghPHIuFI2mGc2uYCAA4JuJKFqM66lCOZBgRU7YXRw1SC1bhgDoV/ZoOvKOsMLgImkN+LiIDkwcrVk1i2Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llnCwke2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llnCwke2"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412949fd224so229185e9.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708658311; x=1709263111; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4Jcgvy7Olro7z6RpSrzXJuYbzSeAvtk6dx39T9KAYI=;
        b=llnCwke2wkmemHoPWYbwruv29jMNckyt0I7PS9yFm+JxT1twgllFRapMBh4V+KmhWB
         XRBwXp8LlTD0uH2p+oR1hWmNnXAso2kjQTvFVs5m8zYIJdY8i7HYFTnGFoDXpXc/4lf/
         iy41EHjOYMVcu5zMMNtmuOpj+9Y4VAseP8ZZG/gCxvwOtAa9encGOTyr5azWuXKsbdEI
         Mvx96Z1MeKTp6gm0t1HAN8GNGFndEbud8q8RFoJoaqPl362yaNiG3FcOblzXcqw6vob6
         qlxuEe9XGgTvawY4MiaLdioizIyWTpEfmyf/YzSum+2QKbUP9Zk6LOgkohMXAJSc3Wxa
         JQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658311; x=1709263111;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4Jcgvy7Olro7z6RpSrzXJuYbzSeAvtk6dx39T9KAYI=;
        b=FNMVyHmkPyztwzKBMLsMIWvkMQg1M8mq9zE34DxxBP3aH1IYBey62XfpAWAAADC1gq
         MfZG63isheQ5yBtnGEKYUFG1mBly23HqMzFzMd/myQ8W6B2XnHdq3vhzI3SaIe9wPMbd
         U9HZ+zs2wIICdgPL/OF2jp6vnHTaTOhStG2bPg+mm3lylVc+sHJ/a9Efoyc92JgtPQqf
         66hbtT/DjqvLQSBKmeEQM6dBLI5mhcvJNuEEXlGnRXePzDMA3kSxHAeYH+XFfp+/vcOZ
         yK+aHz6miNDlQm3M0KL5xeIa3b/46G+HrmvJRT6vZXs60mQKm1zuInQOQ3Csmp8H1oA2
         WNWw==
X-Gm-Message-State: AOJu0YwUFtHl4sFt8I8h8dcCqqIlyyyLMnBRKgkQzSTrkt1zbo/+k3so
	dA+3HkQPjIzhxdDNS52giH9gmglBc0qAe/JIS67xRUMIIfd7ncN3GUBInQTE
X-Google-Smtp-Source: AGHT+IFZcBhxLw7rsmaefai+b33hye6wnP3BxeQ4aplJqvFfYc9tmcABIxdzIEhWI5gom2Pl3SGkUQ==
X-Received: by 2002:a05:600c:46c9:b0:412:8cc3:bf67 with SMTP id q9-20020a05600c46c900b004128cc3bf67mr2888024wmo.8.1708658310849;
        Thu, 22 Feb 2024 19:18:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b0041294d015fbsm184377wmq.40.2024.02.22.19.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:18:30 -0800 (PST)
Message-ID: <af6f57ab3e6d61036cd969f5fd9256200313aaa9.1708658300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 03:18:13 +0000
Subject: [PATCH v2 09/16] fsmonitor: move untracked invalidation into helper
 functions
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

Move the call to invalidate the untracked cache for the FSEvent
pathname into the two helper functions.

In a later commit in this series, we will call these helpers
from other contexts and it safer to include the UC invalidation
in the helper than to remember to also add it to each helper
call-site.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 2787f7ca5d1..2f58ee2fe5a 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -188,6 +188,16 @@ static void handle_path_without_trailing_slash(
 {
 	int i;
 
+	/*
+	 * Mark the untracked cache dirty for this path (regardless of
+	 * whether or not we find an exact match for it in the index).
+	 * Since the path is unqualified (no trailing slash hint in the
+	 * FSEvent), it may refer to a file or directory. So we should
+	 * not assume one or the other and should always let the untracked
+	 * cache decide what needs to invalidated.
+	 */
+	untracked_cache_invalidate_trimmed_path(istate, name, 0);
+
 	if (pos >= 0) {
 		/*
 		 * We have an exact match for this path and can just
@@ -249,6 +259,15 @@ static void handle_path_with_trailing_slash(
 {
 	int i;
 
+	/*
+	 * Mark the untracked cache dirty for this directory path
+	 * (regardless of whether or not we find an exact match for it
+	 * in the index or find it to be proper prefix of one or more
+	 * files in the index), since the FSEvent is hinting that
+	 * there may be changes on or within the directory.
+	 */
+	untracked_cache_invalidate_trimmed_path(istate, name, 0);
+
 	if (pos < 0)
 		pos = -pos - 1;
 
@@ -274,13 +293,6 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 	} else {
 		handle_path_without_trailing_slash(istate, name, pos);
 	}
-
-	/*
-	 * Mark the untracked cache dirty even if it wasn't found in the index
-	 * as it could be a new untracked file.  (Let the untracked cache
-	 * layer silently deal with any trailing slash.)
-	 */
-	untracked_cache_invalidate_trimmed_path(istate, name, 0);
 }
 
 /*
-- 
gitgitgadget

