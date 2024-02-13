Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463156217D
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857557; cv=none; b=ebakFrc43nnYR2Mg/I3Uj+MCCjPRSzFFnwFHjOrq2pllb0oo2fANNVcg6dOJ3mhP8AslM7BAlOIhcVOYE9rvI72nXeVVES5D83NU0aiN7vvzTRHYsb9eFp+JOy4tHcIqV5aD/t+3ymddhKga8lEwnulrZET1xQLs/xodD/hVXR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857557; c=relaxed/simple;
	bh=pxAbmsq/7vkRMb1ulokRQgdz5tVCp/sVZQlJ0XbKjjk=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HRE/TXqw3VaFHFlgJghiiJK0TomEmmGOLHNKjPG1bu9WDcQKabtiW4QuumcAwDM8mpenqh1Bpi3IP2ZZA9q/402foht210Aj8FN4o9x9ThDVWyKs4OvbyqbXKf0X3EPujd0Z/eraHttBAfSivTqctrJ52CCVJTYOBUQgCff6T20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI3AaPLf; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI3AaPLf"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3392b12dd21so2918066f8f.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 12:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707857553; x=1708462353; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6Acumg5qQQsEumbS/4+I3hkHL6+6jFDW/025LV5oGY=;
        b=EI3AaPLfFKPUBuUX4Uz6cZNPPL3eICERq011gDzae7GVz92BqL7aNq/wP1Tj09AuDV
         EgG0773KOxcoLjkYZjWfT5lCK4JIBQI2WzszwYnDP43HV9tvwVFuJOI6VRTo+n2/eKA0
         LKfe0w7jNhu9fDJPav9n4zPm1/oqexB/jnY8JsjeX9pv7Km8u8K6mdwkIWB2oTaVioal
         mTpEiS/5jaNJ/ro1zpC49Pb5Kiveh1uSno+sCgXEdIVV43SHGCwabkiFcraICxv8fzQy
         lKLCiUEkvQdEAqBfWamdMj8kyjJIavAzsNThfUahxsipeyLCr7VdzGYvpWYVNMgVSqHj
         6n8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707857553; x=1708462353;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6Acumg5qQQsEumbS/4+I3hkHL6+6jFDW/025LV5oGY=;
        b=Nj5v4BKbkPwKHkOHJ9DrKQssNVA/W1h+c8e4/gQy47Bz+//YfR+hJGhBd1NOe5zBB4
         uJnGM2P5Qbs4w/dpCjrlwFzUg7JFYq0LBnbRkOJbGYPXfRJ51p/bU3SC3yBUq+jj/yqc
         KnozApPVWpurfcBrGdSz0lXsvI7WfOkxFlf4gZ7r0YKLiTOToshd7lRN9ya0ytQOAGFq
         iLuurasWPF9WJKl1ID0FYpp2huoSUf27cIdTlzTnX6HN2fA6PeL+XhQ2BJAEqRsLs1Gm
         nLBgqmx9d1TGKpk1Mr1Lk/9t9LaJlYJzRz5XOmprlUK1vPVUEQpN0c2gAuBctET8ZBkW
         mMJA==
X-Gm-Message-State: AOJu0YwKZ3YrXNodewv3iP0eka8OZQqoOeu8RtbY9lP7zbJDMzuIL13V
	mmjmBhnDQgxMcDx+SWfD3/hTEuhqE5LTLglPyh8CCiDgb4MLw4l89w3SvTwo
X-Google-Smtp-Source: AGHT+IH0ja1H1WIUd7mWzpd4pjPKSXMKe6Hcvu6Asjxd3enexGU6I1wPGl4YBEBV0+wahrSqlGUdIg==
X-Received: by 2002:adf:dd90:0:b0:33b:377f:7aa with SMTP id x16-20020adfdd90000000b0033b377f07aamr321327wrl.52.1707857552843;
        Tue, 13 Feb 2024 12:52:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5-20020a5d58e5000000b0033b44456463sm10379328wrd.106.2024.02.13.12.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 12:52:32 -0800 (PST)
Message-ID: <7775de735f41bdc601318cd15c3414f12b361a0c.1707857541.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 20:52:20 +0000
Subject: [PATCH 11/12] fsmonitor: refactor bit invalidation in refresh
 callback
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

Refactor code in the fsmonitor_refresh_callback() call chain dealing
with invalidating the CE_FSMONITOR_VALID bit and add a trace message.

During the refresh, we clear the CE_FSMONITOR_VALID bit in response to
data from the FSMonitor daemon (so that a later phase will lstat() and
verify the true state of the file).

Create a new function to clear the bit and add some unique tracing for
it to help debug edge cases.

This is similar to the existing `mark_fsmonitor_invalid()` function,
but we don't need the extra stuff that it does.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index a7847f07a40..75c7f73f68d 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -209,6 +209,20 @@ static void my_invalidate_untracked_cache(
 	strbuf_release(&work_path);
 }
 
+/*
+ * Invalidate the FSM bit on this CE.  This is like mark_fsmonitor_invalid()
+ * but we've already handled the untracked-cache and I want a different
+ * trace message.
+ */
+static void my_invalidate_ce_fsm(struct cache_entry *ce)
+{
+	if (ce->ce_flags & CE_FSMONITOR_VALID)
+		trace_printf_key(&trace_fsmonitor,
+				 "fsmonitor_refresh_cb_invalidate '%s'",
+				 ce->name);
+	ce->ce_flags &= ~CE_FSMONITOR_VALID;
+}
+
 /*
  * Use the name-hash to lookup the pathname.
  *
@@ -240,7 +254,7 @@ static int my_callback_name_hash(
 
 	my_invalidate_untracked_cache(istate, ce->name, ce->ce_namelen);
 
-	ce->ce_flags &= ~CE_FSMONITOR_VALID;
+	my_invalidate_ce_fsm(ce);
 	return 1;
 }
 
@@ -312,7 +326,7 @@ static int fsmonitor_refresh_callback_unqualified(
 		 * cache-entry with the same pathname, nor for a cone
 		 * at that directory. (That is, assume no D/F conflicts.)
 		 */
-		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
+		my_invalidate_ce_fsm(istate->cache[pos]);
 		return 1;
 	} else {
 		int nr_in_cone;
@@ -412,7 +426,7 @@ static int fsmonitor_refresh_callback_slash(
 	for (i = pos; i < istate->cache_nr; i++) {
 		if (!starts_with(istate->cache[i]->name, name))
 			break;
-		istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+		my_invalidate_ce_fsm(istate->cache[i]);
 		nr_in_cone++;
 	}
 
-- 
gitgitgadget

