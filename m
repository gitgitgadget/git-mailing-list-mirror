Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DE4612F9
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857555; cv=none; b=c+BaXwDmSHIgLiYpleXjhTBXkvp0fjR9lTw/rDwilkWHQb9kKXse42BHHHHAgsKf+MAVjc2bZ0l4hPnfJMf+7/xlSEdB0oM3IHuWAOC9JDVqFHqxC0SFOGfK++6OXN4P899OFaWWgWHG6oHoQnxXHfqTbyyY+ozOuZTcYBcsV3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857555; c=relaxed/simple;
	bh=GUwgwiNLNa5h58evi7O+FZbmMziB3B7fbsZQy5Gli9A=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iyX6koZdOk8cM3To6M3WQw0euJ89CMhq3EZ1ZjfM6oQ6wuxVsRrpD0WFqMDx24pA0w97G9LOGwQ0TIKqDaqA2cbMKkytv1Ii/gTqdfAwM/GyqVtyfzo5JnypusFtPaMaiWTdqsXyR8SlTND1BBCRkQ017JFfcGkou/ZcBTMZeEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlAmHjg+; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlAmHjg+"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d090c83d45so63128721fa.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 12:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707857551; x=1708462351; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aasr3DWCPvtTIrJX3OH9e1+U7yA+xVpNznRB7OPQquU=;
        b=XlAmHjg+vnXpYTMobUffjFoGKfiAwXcpqDSH9FoSQiJ9L9P2ChksviD47iPM7Q7J0p
         TpbbGW28NAEaNO5RvYRUDvfRl01lslpTSSp9SFcGAaTnkz4YPw4GaNASnFzfiz0TpowF
         QNgUJQ4ZgNpIsciVNRurQVXKOu5s70vi4EF+2ppgnwmEMKcl29ntvVkv53ilaP6VcE02
         Nl6oCqG7bJIB+A35CPTdFrUvG/lvyedyF7VUzIIDs78UsXIXnsjg6RaPePNHVQX94VAe
         gWABRLDZyiMJgV5TaMrpsRW7rPZ0jblT1ytEW4p1Qj72PDcamJpqOfuSyTUsSey/quBS
         RIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707857551; x=1708462351;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aasr3DWCPvtTIrJX3OH9e1+U7yA+xVpNznRB7OPQquU=;
        b=ZuqLqP1Ln80fOYlLR8qXifayO2NYG090m4Saa3i0GQ15sxZUHMUd26AaON72kB3bBY
         /fknW+VPNwUf2qXvUr/vgkOVufsHFrQoNs55orN9cRUuDIPZAcNLp5cc6hAN0glOudEn
         G11lRaWrqCn7f3zdZpDVRGjy4ByuH9AYBoHp2LCmoPFnoUyCZU0a4U39KdQxm2vxCtzf
         xxG9ZDDAjVTrbWaRxtA7aj5l/5S/sTfdqe98C/0tv8CYIeQbdH0m5v6OLlg7Jb4VZQAb
         7a6LTPuQNgCenVaMQvme3t8jeu/xAQgluRyrQ9ghWMo6FlkhBA8JAwG05vMK4tVE3xx1
         MHrQ==
X-Gm-Message-State: AOJu0YwCeShuFKIMLTFjI9HS0O7gyw5P3GIx43W2p89ou2OSgLeCaK45
	MyBqpgOgCwwvxk2zMOTd6RqcG4oNJNEO8ejDqeLW20ToxRRZjI+K+UW6ezNM
X-Google-Smtp-Source: AGHT+IHJlTjOp3+LixGEX13tGOEJVWSMT0re9c30Xv5ZYYlQGNmcfb+jCGTguMZ0WjfYt/GFv08pAA==
X-Received: by 2002:a2e:94c2:0:b0:2d1:e53:cede with SMTP id r2-20020a2e94c2000000b002d10e53cedemr498367ljh.25.1707857550723;
        Tue, 13 Feb 2024 12:52:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15-20020a05600c0a0f00b00411d6c1476asm916826wmp.1.2024.02.13.12.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 12:52:30 -0800 (PST)
Message-ID: <a0cc4c8274c108d231816ac981781d9e3cf8fded.1707857541.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 20:52:18 +0000
Subject: [PATCH 09/12] fsmonitor: refactor non-directory callback
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

Refactor the fsmonitor_refresh_callback_unqualified() code
to try to use the _callback_slash() code and avoid having
a custom filter in the child cache-entry scanner.

On platforms that DO NOT annotate FS events with a trailing
slash, if we fail to find an exact match for the pathname
in the index, we do not know if the pathname represents a
directory or simply an untracked file.  Pretend that the pathname
is a directory and try again before assuming it is an untracked
file.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 59 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 73e6ac82af7..cb27bae8aa8 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -287,41 +287,52 @@ static int my_callback_dir_name_hash(
 	return nr_in_cone;
 }
 
-static void fsmonitor_refresh_callback_unqualified(
+/*
+ * The daemon sent an observed pathname without a trailing slash.
+ * (This is the normal case.)  We do not know if it is a tracked or
+ * untracked file, a sparse-directory, or a populated directory (on a
+ * platform such as Windows where FSEvents are not qualified).
+ *
+ * The pathname contains the observed case reported by the FS. We
+ * do not know it is case-correct or -incorrect.
+ *
+ * Assume it is case-correct and try an exact match.
+ *
+ * Return the number of cache-entries that we invalidated.
+ */
+static int fsmonitor_refresh_callback_unqualified(
 	struct index_state *istate, const char *name, int len, int pos)
 {
-	int i;
-
 	my_invalidate_untracked_cache(istate, name, len);
 
 	if (pos >= 0) {
 		/*
-		 * We have an exact match for this path and can just
-		 * invalidate it.
+		 * An exact match on a tracked file. We assume that we
+		 * do not need to scan forward for a sparse-directory
+		 * cache-entry with the same pathname, nor for a cone
+		 * at that directory. (That is, assume no D/F conflicts.)
 		 */
 		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
+		return 1;
 	} else {
+		int nr_in_cone;
+		struct strbuf work_path = STRBUF_INIT;
+
 		/*
-		 * The path is not a tracked file -or- it is a
-		 * directory event on a platform that cannot
-		 * distinguish between file and directory events in
-		 * the event handler, such as Windows.
-		 *
-		 * Scan as if it is a directory and invalidate the
-		 * cone under it.  (But remember to ignore items
-		 * between "name" and "name/", such as "name-" and
-		 * "name.".
+		 * The negative "pos" gives us the suggested insertion
+		 * point for the pathname (without the trailing slash).
+		 * We need to see if there is a directory with that
+		 * prefix, but there can be lots of pathnames between
+		 * "foo" and "foo/" like "foo-" or "foo-bar", so we
+		 * don't want to do our own scan.
 		 */
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
+		strbuf_add(&work_path, name, len);
+		strbuf_addch(&work_path, '/');
+		pos = index_name_pos(istate, work_path.buf, work_path.len);
+		nr_in_cone = fsmonitor_refresh_callback_slash(
+			istate, work_path.buf, work_path.len, pos);
+		strbuf_release(&work_path);
+		return nr_in_cone;
 	}
 }
 
-- 
gitgitgadget

