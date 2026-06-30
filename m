Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6293CF1F9
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833365; cv=none; b=lFmDnAmfLmAaSKexEeDAlnUaqHhGPBgG78UhXdRR+j98J/7AEqZJTGyEYrSYbAXIRh+j6OtLGin1eBM2T3Z1aqsT93Q1Q108lXsdtckj+uH2atFkasl9XwrjanVatiubG+0lHft+/CG+Rql7AjPBwPfyfUEHQajCNB5OMlG9Ico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833365; c=relaxed/simple;
	bh=5sMQDczbYO4UwUvuLVlRDFnuJ4bcbX8+ThcPvAaneOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoyu9opi0Js4xjp4rc++4IKyM/9luF6IEdPeEIZcRAkZBb2BAmt1r917k5k6Ez6tyD1P2VMBJEt4RNeT0uZd7uhBb7BFvQHxR5E9dsj7yTC4RwlMp5T23hfTiJP/soaZ04ik9bQnSJCMOgfrYITcxV66GjU/dqN4eL/GFUT998c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X24OYXgu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X24OYXgu"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4704d652e9cso2478506f8f.3
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782833359; x=1783438159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MApez5AsTrB7XkZSvgI+DMJNKA6D9JbI7CnXCRr01rk=;
        b=X24OYXgumWDFCH404cCsrgesg6TnikLRctbMAi/9DO38tCvqT5/wLhEIwUGo1wJpcU
         1o+w6j1/1qjN/0y5UFnZsoH/FYSnE1sXOT43DVuQ83OVKpMtCbwpcUqhaZJhYBp8nS2M
         KDUZvO5+QfiELod97w+I7ap6XMaIo4t2Lc0mGHLR7rfueyo6FziLOubsFNiRoPFUvxQi
         kg8bknR+cd2U6+WeUpFjEKu0W1HGlNwR95OHwTVRbOxtaZlyvofFc0hitgebFNyPosHe
         njaoHD/RZCr1IcAynl1JyFMiFY6830noQYpC2x7YrFuWSAc5IDgdJCgcWfYByhWkt8EC
         hLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833359; x=1783438159;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MApez5AsTrB7XkZSvgI+DMJNKA6D9JbI7CnXCRr01rk=;
        b=QwMFG2Mp7HkL0i52ZoHtc7/JZB5uvLngTkTW0q2nPiWXuetjMyoZmdFE9VuNVnKs++
         Z+QtNwTc1X3HNu3UJdP6GglPGqpJLYcbcSxvVGTNiLZ/NdrE8yaEHFIJpZJvtmxS/cLl
         DkeQ4xP3yef3Qlt4pjpaR+o+K8gad+cZs2TB75YOr2brBK/Q5+XuottgvTRt8WSMGl3b
         KcRIK2yhApe8rWWhwT87YUevinhlwNJx2Xbw+vXWGvcgbfaQGZ1h7LC1uRvH1HSnFEKa
         80ardeljSgJxttO5wG5p84bqmrtVDgUzXnSHvIfLNae4mhbKW1DeJs4B69vsnLkFgw7k
         cILQ==
X-Gm-Message-State: AOJu0Yx0/N65jQG/boOTcSxRw6gRmHyQhLQA7gij0hahM0wMU9e/GieA
	+YQU1o9ekNaog5tw1LrBcffL0xaqGmHFYXZKu4QQmbGw7eLTH928kc0vLYy/gg==
X-Gm-Gg: AfdE7cm99QQ+76rXIko1oCbghUl4eGQcbvRgFF/HElWqioZYLHRhNUl3NhSrJknmZWT
	/vyZ7bd40EYg6cfQI1PTMO/R5KffXlSCDTLTntMVE0naSTVcm7/zcpyMinPUdT5K6AaRYbB/f9i
	Mq6oj788ZXeuPprSgNvh+44vAIcdm5j+gs5o5YWpDyoyDJ8D38TX6BxJIl+hnVIWDSHzgN3wGfN
	WJyv3hZhx4IF3rPdA1/HsyLAMmFzpQqFnuQTLMRSkLJiZRHG+4S9ppK+zTwNZZxymG6dRaEYHjy
	UTlGzH7fjwbN/6IiGkK0IC6ZQ6DiMK57jexoNKNsqIdWmmFZ56v1S3uJpTEDW9W95juJ9GXOkTF
	qUmwEQGBMTcT2H076RK4ISgFBqEWGW8SwY68jl2+0Yp3NW6hs/5LL3guCX+obQw4WpPbxDDRT75
	2X8hBFVJK8+GFE82n5
X-Received: by 2002:a05:6000:1aca:b0:473:bb9f:b035 with SMTP id ffacd0b85a97d-475521c87famr5744772f8f.26.1782833358533;
        Tue, 30 Jun 2026 08:29:18 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567979eafsm8477378f8f.34.2026.06.30.08.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:29:18 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 04/11] sequencer: never reschedule on failed commit
Date: Tue, 30 Jun 2026 16:28:54 +0100
Message-ID: <3ffd06d65096d77bdc372a13bd883a00c8cf4c82.1782833268.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com> <cover.1782833268.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If "git commit" fails to run then run_git_commit() returns -1 which
causes the current command to be rescheduled. This is incorrect as
we have successfully picked the commit and have written all the state
files we need to successfully commit when the user continues. Fix this
by converting -1 to 1 which matches what do_merge() does.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index e6626c4db4e..d7e439b1feb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2542,6 +2542,12 @@ static int do_pick_commit(struct repository *r,
 			res = run_git_commit(NULL, reflog_action, opts, flags);
 			*check_todo = 1;
 		}
+		/*
+		 * If "git commit" failed to run than res == -1 but we dont
+		 * want reschedule the last command because the picking the
+		 * commit was successful.
+		 */
+		res = !!res;
 	}
 
 
-- 
2.54.0.200.gfd8d68259e3

