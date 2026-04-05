Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635D3346FAB
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 05:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775366132; cv=none; b=q9PBF1+oLjS0B+5VQaTck7eAdJyYqzOreUlIDLnmO/gfDRLW8j2eUV2NVoz+VGae86RhYpuSaFCTSnlwYcyrqcDB6z0aL1tamnnGvTs6Yj8YP+iqqIJxE4zP/LkpfEBzFLxBd9QuAmIUapCvGHTIiE1Uy37bdJ6v6Q9ZfYh0h78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775366132; c=relaxed/simple;
	bh=KmW/aLF1KoqsWig0PlZRDyU4+aZc7/cg2nLnlQMoi4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHpTgiadYMYsNYm4Fy5JeFpiLb9b2/b46Yto4P3xVJf64vVwu7yYCyUNbqrU4tjqzMUWHcTq1OYP6OOcWAMZkwneU/Y5KbMEQlkm8/GJYTXyhowlZIFcvmRtMZpY5EatFXHi3vwXVQCBQOWQZu3w73dXCx6GZ4ZgtePD+BgXN7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oM8EMAHV; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oM8EMAHV"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c76cce85bd9so967259a12.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 22:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775366130; x=1775970930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6Mwn/8b+XaByMyUjJbpUw7u5VwLg163fvghI5Atm6A=;
        b=oM8EMAHVkEAS1lOdXpmNV4uBBAKKp8a/3rvIzQPMrM1uz/sfhiVFPbhdElOr/8j291
         Kk3ajit+yml6YSnHuJ+XD5K862ritazLan3vSp9ZQ8zsVkfa8SnIOY6IztfLtUQ418c4
         j5//gfTO3f54yloJCzkP1AsY23HBZTkrJwr7ExWKWocl0B/6jm1TCm4j0qYXseG5KHSR
         NfBNDQIJDtD5AjknCWfaL55mlALPR37y1RL71ZWXCZGns60QtP4k8wjiHaZCoMrG20w3
         hNa/GMTrDb9+nxmQHLRO2L4Wz04SgV9bxcN/IMSu6mo3HDchOiODEYgcOj5Wz/jgD57k
         WzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775366130; x=1775970930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w6Mwn/8b+XaByMyUjJbpUw7u5VwLg163fvghI5Atm6A=;
        b=YWznKMt4vyub38iFTfybOQg9MiiL9h/3dBE8BUIXB3qsv4oACA42EQc+DRJm4/3bUl
         98snuHnUCbt4xDTBwjD+GDOobGGpKdgYp+fGj8r5PIljf6NJXTJ2+KA9wSnFJZwLPl3M
         mJIfFVC2YnJO7VLc5WzibHgRCnYfy+6Fge8G5TnoBCaDd7NG/eCZBCKuBYxItbsijkp3
         ZLnQCw5WkLCzKXghgY84o71e9YG0iHMkp0MXNJBX51ts3fSAk2CsoVlarJwhsAderDTE
         q6xZd7vf2AbygczDSpjnUZFIyBrdWA46Nh8rqWaJwC1sfwMtuuSc59aycfxfh4VXk437
         WtwQ==
X-Gm-Message-State: AOJu0YxA0rLLvoGmfSkaQe3nXeT1iNIWmTuvFYanrcK4oslJ+FlV2FDH
	ltvGLbm2N8M70NmnBEyb8xMLYc11wASKPMIAFwRt6rC5o0goQJB7Y5C6O+TRPjBk
X-Gm-Gg: AeBDiesMkrMNDOuUlQJ7ElQVwayqTjfHluZgOmOpQL1hIvKILkmBmIYgWGaynYA3dYf
	W6hKueDj2eJ2WFina3ItOkmwwpMCRP1EzL0wYhmeoXaLj0BbOZKy3vdIiq0KnexjPkAvAtVKqNc
	vH+1XTTB8vlxaySCX710BGJKbtfOMEynSXaw0XY6L99p5b0t7XVzvXg5RL/4u3cOnFkehi9kQv2
	BlXWjoB3pHbps4h9K8f4NlP9o5WXMoyIw+Y6uoK1vE2FpiqhL0NW2YQHVEichpRHQzmUNwTbToe
	6NXWZaNNmA4Z+sm8N0q/QBs7tyXaDgq5j11wpiqxTKkhBoXbLJ/1TCXs6LTccSUIH+Xad4t31lR
	MCc7K+73iCm2b31AfphgCg7h3TUIZ4RUuwy9QFLtEnvvXB/gKJLLfGR5C3NjLgu4RMXuaJnYpNd
	52LPz0yQ5PVeZK1Cg2i9NBmBjuqMuETE2yqcmNWbIDRnZxfdVkiFe1jO+Zi49DjoIF1xHPxUA23
	DF4q0cEKw==
X-Received: by 2002:a05:6a00:301f:b0:82c:9fe1:aa4e with SMTP id d2e1a72fcca58-82d0da8f68amr8521152b3a.21.1775366130235;
        Sat, 04 Apr 2026 22:15:30 -0700 (PDT)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b261b6sm12151602b3a.3.2026.04.04.22.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 22:15:29 -0700 (PDT)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: Johannes.Schindelin@gmx.de,
	gitster@pobox.com,
	ps@pks.im,
	stolee@gmail.com,
	gitgitgadget@gmail.com
Subject: Re: [PATCH v12 13/13] fsmonitor: fix split-index bitmap bounds in tweak_fsmonitor()
Date: Sat,  4 Apr 2026 23:15:28 -0600
Message-ID: <20260405051528.74435-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <b96ed977-525e-c3fc-a626-db1a4b3da376@gmx.de>
References: <b96ed977-525e-c3fc-a626-db1a4b3da376@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So the actual bug fix would be to ensure that `write_shared_index()`
> produces a hash even if `index.skipHash=true`, because that hash is
> needed to identify the shared index.

You're right, and I verified this. I reverted my fsmonitor.c patch
from seen, applied the fix below in write_shared_index(), and ran
t9210 with GIT_TEST_SPLIT_INDEX=yes on Fedora:

  Without either fix:     not ok 12, not ok 13 (BUG assertion)
  With only skipHash fix: passed all 22 test(s)

The fsmonitor.c patch is not needed. I'll drop it from the next
version of the series.

Happy to submit this as a separate patch or include it in my
series if that's helpful. Or if someone is already working on the
skipHash + split-index interaction, I'll stay out of the way.

--- >8 ---

diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ write_shared_index
 	move_cache_to_base_index(istate);
 	convert_to_sparse(istate, 0);

-	trace2_region_enter_printf("index", "shared/do_write_index",
-				   the_repository, "%s", get_tempfile_path(*temp));
-	ret = do_write_index(si->base, *temp, WRITE_NO_EXTENSION, flags);
-	trace2_region_leave_printf("index", "shared/do_write_index",
-				   the_repository, "%s", get_tempfile_path(*temp));
+	/*
+	 * The shared index is identified by the hash of its contents
+	 * (sharedindex.<oid>).  If index.skipHash is set, do_write_index()
+	 * would produce an all-zero hash and the shared index would not
+	 * be found on re-read (is_null_oid() check in read_index_from()).
+	 * Temporarily force hashing for the shared index write.
+	 */
+	{
+		struct repository *r = the_repository;
+		int save_skip_hash;
+
+		prepare_repo_settings(r);
+		save_skip_hash = r->settings.index_skip_hash;
+		r->settings.index_skip_hash = 0;
+
+		trace2_region_enter_printf("index", "shared/do_write_index",
+					   the_repository, "%s", get_tempfile_path(*temp));
+		ret = do_write_index(si->base, *temp, WRITE_NO_EXTENSION, flags);
+		trace2_region_leave_printf("index", "shared/do_write_index",
+					   the_repository, "%s", get_tempfile_path(*temp));
+
+		r->settings.index_skip_hash = save_skip_hash;
+	}

 	if (was_full)
 		ensure_full_index(istate);

Paul
