Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4064FFBFD
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 03:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658312; cv=none; b=dIldS75M4y/PlMonhtqif1BsijLidWcDcysfhuE4gYggj5ogsWzbLf6Mvi6ROXdn7SXXIAe27JzOjInmL7cRGuLU0IabHFdMX1DldEjXAhwc+UvifpytLrOdPZcGmAa8waTX1Ieqody7p4v33Ci9TtnwItcYIsCYdGPTlcGM1cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658312; c=relaxed/simple;
	bh=4szOJUbnumzcLWgNk92lQAmCwY/gpNS2Mi6gpmHr3vQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VDLsO02YmSnsdnzzg4HzdOGMB2nqqZNegnaNJw+JXoxLaJ+05rMA4rCc8g3nzi0m7XO2jd3T2kU19oZFmsGfuCNMAJWPwPbQruolRtJdx1qbMTd81SU/S2hxqILNndYkMCXpPVsndmka8+dcDvJ5GM42RYWXrPNai71UaaYdshM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSt4EFfx; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSt4EFfx"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d568fbf62so208108f8f.3
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708658308; x=1709263108; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQySpqc/GX+20PebOQNWz8bpck9mFzkDsq0Dr42tSAo=;
        b=bSt4EFfxwZj0SIxjF95cN/T1UQO8KQdHEDUsUQlKic+JGf9fncerPHOXVMX0ew+hRA
         lwO7vx5Tml4Yj9W/VMZYo6ZURCtmDUDILKMH43cw99Wft+sEbuQEfNUCn+ZsEPUyH2ee
         GccabCYnNjtzoLZLOCTthh/Vid0WtE1v+BAFAb4+fBLfsNWsXpYFc33bLCwwJUcLcSS9
         abaQhzy0wptkxG37WN2LAXPRi2rtwTNGCpOny5XnM2QRg9w34bE11ByGS0lexZJvuOcj
         nLhemie94t6yG0r6jOURyY7Eei4+P3uuFlm3MQS1jb1AzPDW3n8iHi9D/9B+Xgv23R7o
         FTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658308; x=1709263108;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQySpqc/GX+20PebOQNWz8bpck9mFzkDsq0Dr42tSAo=;
        b=InBQVouYlsHlWt9WN0h/7N0hfjUfOze3yV64suWIbQHWGXuf2xM8tOoqphq57IBEGM
         ubcJ6ec4Jhr1nSj/m9EuXkqFOr+HwYeGY0h8rml1EzTDLSmwntaRVFl2kxyIh3fw0njA
         bUwpEaCgjLQcw1ZE3nE2kPs6bC+GMAlyomjKexqYFdK4ne31JpXtJp39zSEiVBbmti0+
         mpVRPAMvn4bZaRc8YhE8rVwyQJmo16TOyxZbzVAuocP8g3uS3T5/iDniBsLI5ETYI28i
         MvBuA1vF2+nFmvJ6pRmToMo1al1GzBGweJ7gWm/Ut4TqPJwBmcdS2/ODjnfLAjgNaKo+
         Jgvw==
X-Gm-Message-State: AOJu0Yz4SahV7NtvB+m39jDrFYp88QEJ/lzdAtKpFxeeI2owWabJTQ4b
	03jWSgbJjQs1UZh+wyW3/KGPseCeE2Qil6DLqY7g/3Gcz/BbtEUvrn6hvVhZ
X-Google-Smtp-Source: AGHT+IECnRj89tOxeoXvAi0p+w8VrCbR1Z6JW8LcOXTf9sIQgq0UpCmpYQutqPtxHjFuZkCsQuludg==
X-Received: by 2002:adf:f551:0:b0:33d:3b82:ab2a with SMTP id j17-20020adff551000000b0033d3b82ab2amr514338wrp.19.1708658308358;
        Thu, 22 Feb 2024 19:18:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b3-20020adfe643000000b0033cffd1a302sm1007295wrn.57.2024.02.22.19.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:18:27 -0800 (PST)
Message-ID: <7ee6ca1aefd34a37d749300e317df10d80ef2b29.1708658300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 03:18:10 +0000
Subject: [PATCH v2 06/16] fsmonitor: refactor refresh callback for
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
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Move the code handle unqualified FSEvents (without a trailing slash)
into a helper function.

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

