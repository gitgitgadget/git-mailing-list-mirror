Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F7817DFE8
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935356; cv=none; b=renFHSD3NjoLAeRBG6Tp8ewYtOOBNuHSsipb7uFF0squtrRLsTXnVfsglfr8SN+MvLuZAT7j9wB1ZekBnqutUwUjtVKrAulKIxt61pxACqfqYibOYGTh/PldQ/fLNnty6gc8SAtOo3I4Iv85L8RF41+F7snHmhjlEK71BXvalGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935356; c=relaxed/simple;
	bh=0xfSBK+gtVzJWzzFWtcbF7uOaXmJ7Zy/DKlx7MkylJI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=R1qTGFNwFhfd81HOsSCIwL0m+oGA3CSQ4FQOtmyHxAyLsOJk54CWw8Z/H2dtTYB69FcnaWFkcN9/ejyN62WmARBqmkVfcgMbxyUc0PzS8jL/AsUqkkYFUb+HAgZ09tspRpgJDw1gDFrv/aCPwxYX5DyzwIEscikTW3HDKaPhzaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gW8jz9jl; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gW8jz9jl"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-374bd0da617so147523f8f.3
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935353; x=1726540153; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lB37MuKhQj/8cviwldin0IXWfEt5gYeFdN+KFF+dEE=;
        b=gW8jz9jljczjGIinZA90PO10l7d/JvV7okckGrqYjB8SagidifU8c4mIEt94xzdExE
         pJ4bCjwc5GV3RVD4i5WUr9yOw8Ffq6Z2DOkqTC9HIZpOd32bDc42SRD8hSufawwAXzsg
         3tVNXOIXWbeBO+Kpz06M5Z7kQ/a92H1TTq1IdeBjmoVrJRcFQ5lI1cJ7gaARwHpTU8vd
         2qRFiFxvGzHbuAs5Ea1ZLGYUR9LmFzMxzrZwWOB+CUof9MZ6pqUNynW6YtorOqU1jEJu
         f3BGGOFfHWRRzByoNCPTe0vwSMdP6ibNmV4WcacGjk/dK8VG8Cofhjwd8f9TrA9Wl1vB
         39tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935353; x=1726540153;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lB37MuKhQj/8cviwldin0IXWfEt5gYeFdN+KFF+dEE=;
        b=P25I61DfPSjZEi+Mpl+pfGH8qrN0sa0PHZe6++Z+8byR+RKWtCdNsJNxNtF5r+kik6
         t28y4InjgZ+4B+YeoCXX1JTGis+5ladfiVibK9CjwCOoKCmbfx3LZf6y9ySE/5woqTEf
         zS/s864qRODwT4n4HTYFYl5U1l3Tc+mqegE5ytUtWDUA+eVJpEauFc/h0IRwsB9e7iqB
         FmKKbxDHFPv5BhZSGvzJg5VmNk6NbOANCzqh9lMurn6XOXRrKNrfKuyHsrBXKEoZiiFN
         TW9FHnyQ4vDwtlaWk8NxgD4a9ggFWxhtNP9UCp0kH+SAxQcMkPb9RinovmxJ/FeBGv0x
         ovsg==
X-Gm-Message-State: AOJu0YyiY4FdYJ41gEFKV/C71OqxsyqlRQG7+JO6JjO/bjC+Si5A+q4d
	YlClWJF33hROUHr39tbx1rKDMWvJsxuZeNmKuulbvEYjLK+nUWTurptviA==
X-Google-Smtp-Source: AGHT+IE4yOwhcRMxGzyuLz1YURtR6C7n5LgqPIp9Yhpee0FtKqGRcG6j060IqCLyh2rFJVH/ziqi1Q==
X-Received: by 2002:a5d:54c2:0:b0:374:bb00:31eb with SMTP id ffacd0b85a97d-378895c5c5amr7048628f8f.6.1725935353199;
        Mon, 09 Sep 2024 19:29:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c72e56sm411892966b.124.2024.09.09.19.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:12 -0700 (PDT)
Message-Id: <9c54c14435742927a66487df2862204aca8e6fc7.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:40 +0000
Subject: [PATCH 15/30] survey: show progress during object walk
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/survey.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/builtin/survey.c b/builtin/survey.c
index 435c4bd452a..baaaf8a6374 100644
--- a/builtin/survey.c
+++ b/builtin/survey.c
@@ -618,6 +618,9 @@ static int survey_objects_path_walk_fn(const char *path,
 				type, oids->nr);
 	increment_object_totals(ctx, oids, type);
 
+	ctx->progress_nr += oids->nr;
+	display_progress(ctx->progress, ctx->progress_nr);
+
 	return 0;
 }
 
@@ -682,6 +685,11 @@ static void survey_phase_objects(struct survey_context *ctx)
 
 	repo_init_revisions(ctx->repo, &revs, "");
 
+	ctx->progress_nr = 0;
+	ctx->progress_total = ctx->ref_array.nr;
+	if (ctx->opts.show_progress)
+		ctx->progress = start_progress(_("Preparing object walk"),
+					       ctx->progress_total);
 	for (size_t i = 0; i < ctx->ref_array.nr; i++) {
 		struct ref_array_item *item = ctx->ref_array.items[i];
 		struct object_id peeled;
@@ -709,9 +717,17 @@ static void survey_phase_objects(struct survey_context *ctx)
 		default:
 			break;
 		}
+
+		display_progress(ctx->progress, ++(ctx->progress_nr));
 	}
+	stop_progress(&ctx->progress);
 
+	ctx->progress_nr = 0;
+	ctx->progress_total = 0;
+	if (ctx->opts.show_progress)
+		ctx->progress = start_progress(_("Walking objects"), 0);
 	walk_objects_by_path(&info);
+	stop_progress(&ctx->progress);
 
 	release_revisions(&revs);
 	trace2_region_leave("survey", "phase/objects", ctx->repo);
-- 
gitgitgadget

