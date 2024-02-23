Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A6310A3B
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 03:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658313; cv=none; b=YEbQuajNyAp8sFuzB0cKUdKO9HKew9/dDLqXVZpyYr4aNUgklpSNNp16n7KwfoDludwoRPdhnnMf8b/zBKbS4Hxf5akCNKcYO02n5HmFbj+I9jr88dUHA4c7JNWn5K3Bb0wtj+WS8nU9B9HWWY3AzhqwOGWbgxivrRGVIflyrJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658313; c=relaxed/simple;
	bh=DnjbJn5SgHmuTQJljNZYrS5EkVANHvKGjY/CNPBUE9A=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DIfmH5Uj90j8811cnXys/1dIUqAPErA+T5dhArAJal2zxmgdTWx5evv1uqPo/7A/FnRzHXed4I5/qqJ+rbgfaSQSTjMJzl9Gx1/NXe/ZWmsuP0O7ziiVU5TKdr+MRhOhCXe7rdIQkxzAS+oMSU4wuP0ae/FzYcoImViOHEiP+es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kc0UiMAN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc0UiMAN"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412748b183aso3021625e9.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708658309; x=1709263109; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi0NPEODrtkk3ddoQg9K0JweYxe+PjhAUviQ4zCBQzw=;
        b=kc0UiMANtPDcCqRSQaR5Xl++vblhOIVyYJhv7TKptycqOAU0/QGqn2vVwTlK4oCizt
         k+omUdUPMknOUYw26+30w4wzj5zFPdlLf94UJCjWvWd27VdNiegipk4wwFZRqsvxwyJW
         5NUUrkdw8Ri/thL8fGW9TPbjMHOxIXfIYDLJVGGAJIoBMFUsadubzVAuD0qgybBbSBPV
         GGQ+5dqKJRdFNjxOthgrszFLXuaXvD6cezg4YJA3lrJ+q/9lfMoqQcSwfrXn+J927RU8
         RU/ZjdM/A28XEiX+ByamMZv/0nwgMKnaYjkuAAgrT7pqKWomSJq1Pk5vYmBkla3z/Jrq
         Xh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658309; x=1709263109;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fi0NPEODrtkk3ddoQg9K0JweYxe+PjhAUviQ4zCBQzw=;
        b=oK/rdVN0lKLUbpGbdswwpo8E26yHN++nqlEMOFzwRn8b5UoeQa3QuABSNe0OkiYTqi
         nJssHlCAMls0c6K/gZQ8D1pFTuS2k1N5F0dOz8nskOSZVrcO1fHqMUs33hfkVUyqDOGJ
         Qmiv5UYhFuP1iOG1l2UmT0YXeUoyfKbte00wWXeDQT+VHOi3BReCu3KkG8HeY6vBxOWk
         pw7OwEiAko+coRlqhZcMO8B/Hkk5VdDUsLUgd3PAsQbK4x2AQfpuF8FR3g5O4S5GFo1t
         1C2p77aV7yZ2Ccyri98CUV5TQMDvaaOtHVhLETn2ZzA5EFGnQ/DaSKKO+h9Rc9o0rGUF
         r2lg==
X-Gm-Message-State: AOJu0YzyRBADRRGtBcFqFyDjAcGC23Qc/l81XtGMsrtwM5AVo28pEYBx
	9qldn4lq9X7o+WZCwjQK0Yd+dTR6emT+Bl9dGY49XHrnyC0C9XPC0+2hsQ+T
X-Google-Smtp-Source: AGHT+IGTyZ4HiSeB3R6qFn63LRoQ+93By3e4jdF9F4d9wcEmkuw8aA8nD64B1l2y/VlCE/sa9Q5n+w==
X-Received: by 2002:a05:600c:190e:b0:412:5e41:6f35 with SMTP id j14-20020a05600c190e00b004125e416f35mr264729wmq.10.1708658309677;
        Thu, 22 Feb 2024 19:18:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c029a00b004128e903b2csm571359wmk.39.2024.02.22.19.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:18:29 -0800 (PST)
Message-ID: <f2d6765d84ff93a729359e7dcfaddd878f9458e2.1708658300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 03:18:12 +0000
Subject: [PATCH v2 08/16] fsmonitor: refactor untracked-cache invalidation
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

Update fsmonitor_refresh_callback() to use the new
untracked_cache_invalidate_trimmed_path() to invalidate
the cache using the observed pathname without needing to
modify the caller's buffer.

Previously, we modified the caller's buffer when the observed pathname
contained a trailing slash (and did not restore it).  This wasn't a
problem for the single use-case caller, but felt dirty nontheless.  In
a later commit we will want to invalidate case-corrected versions of
the pathname (using possibly borrowed pathnames from the name-hash or
dir-name-hash) and we may not want to keep the tradition of altering
the passed-in pathname.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 364198d258f..2787f7ca5d1 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -271,21 +271,16 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 
 	if (name[len - 1] == '/') {
 		handle_path_with_trailing_slash(istate, name, pos);
-
-		/*
-		 * We need to remove the traling "/" from the path
-		 * for the untracked cache.
-		 */
-		name[len - 1] = '\0';
 	} else {
 		handle_path_without_trailing_slash(istate, name, pos);
 	}
 
 	/*
 	 * Mark the untracked cache dirty even if it wasn't found in the index
-	 * as it could be a new untracked file.
+	 * as it could be a new untracked file.  (Let the untracked cache
+	 * layer silently deal with any trailing slash.)
 	 */
-	untracked_cache_invalidate_path(istate, name, 0);
+	untracked_cache_invalidate_trimmed_path(istate, name, 0);
 }
 
 /*
-- 
gitgitgadget

