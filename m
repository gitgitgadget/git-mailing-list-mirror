Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A32003A8
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793334; cv=none; b=qciwioP//crhsovsRDw3XDqxzEyWsx6S/RZI2ko5ClBazmhuc3oKyVQEcW7JzBUtl2gsjkBTo669gYPB4kiqgZeHyWAuJQaYrIxHmhslqZ6AhZHA/+jtvKq4FH2zzBMA2ZepQnB9RMI4RMetEcoP4KnArHsbyxLNX4C4spicfAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793334; c=relaxed/simple;
	bh=m+fY40M06lffNnAJ1OzhbOwsGkNJUbzrVm6pFyx8BUw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c0zeUBlOJopbqQCh5SycSlsRrHiwsqzGvLJZ1YPxImZfojtmHzxR3D375tjxMUgwD70LALnKI5gPzXSSX0zuHlFuCFZROqskKf75xv5/CSP7LNs9oBEu+gano8UuHw9RVMSVwOe4pNTk2hc/2FQp0rs7xIaHwQaloYcJCY8JaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bmeOkI8M; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bmeOkI8M"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2954ada861so2282785276.3
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729793331; x=1730398131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TiD9pb+i5iVYKZz4maAOXqyh5+IO4TjsdcmlK3H+66A=;
        b=bmeOkI8Mly7ih2E35NWK8XAEXS95QT4gxGfK3hV96Xk9Ypv8IIwKQv/1NtALcAfnpt
         bvLMFylsrjJgqm808nTwKHWdbzja+D/crNJQeFe6VMB15VRrom1WMCA8s75cr0Kx4BL4
         BoI+K7ezEcfsR5kU730MdR+6n+vciZaoI7i6+U+ILaXmBa+3Dna4BBfdxeMx5x7+hZ/0
         0KfWPVQLTOMdce6qFnhiySf6mguMflAOFQLUmBZ+Z7+Uvxd3LJYKkgGyjsPq4zsxYpbZ
         dw3rKZXVVPJ4FFmMoVQhOEG3U3TxS6oo5OOdRHGqIMco3RFmVcwsGqsxg85oM6WX0+Q4
         uYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729793331; x=1730398131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TiD9pb+i5iVYKZz4maAOXqyh5+IO4TjsdcmlK3H+66A=;
        b=je1b4TsGRjkIsIv9vILGxYnKZT7wQyoNjBxjdIfnmdOvCv2XzRgaKzwqBXWyOJ9eZL
         XiAS+kbP6IGY9zVQhouhud+tOvWHRpp3sO7wcrbyS6vzIQt155YxFi0eam3ZqWFk+eYj
         EbeIPL3F132K9RHG2kTriM7JCINdFA5lfjbFVOsZiV6gGCXLHKjHAb6zEZIwYLjt++E4
         gBtQruuAlgkpI/7cGxz3I72GFwc2OQZxBUax3hOWbRcDh3oc9mPRXkm6AWRFefQF2ybK
         dp1JDheqY+R1V4x5nLrbhDl9LI7B/H/ag2veB0lesCrmBjCZueFw4rM224Il2zh2QpPg
         +ghw==
X-Gm-Message-State: AOJu0YzXdWb1Aa/tBhPuO3/2XNij0BBOEdRl3aQqkwrgRGJfhry45e5u
	6oTPmPQyRyZS65SqU5P7Zbl4eOLRh8eWbWJqNwWsg59s7oxQwQZnXYON+kVmJBRIgIut/wZGMSr
	fAp6GpSFH4t4uuEgmFlkiHSxG0/yKjfAqwdSgLUhlqTHJrdevzyqXRUuc98gQsGVpj8GSZ3p8y3
	59kpzleaR8TnLOnaUwr/61xSPihQPYElZHJwMGI8SBvBowv3znl52SBdWwXyTIW0zQzA==
X-Google-Smtp-Source: AGHT+IGeodZcrF0vCM0Uj1ABfYRth7WRehsoFyWvbmCFO13byxpPstJafdsHQ3Rn6ZaH3OPFeWFlCUbV1Kz5w03PXXBt
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:3554:17cc:309d:28c9])
 (user=jonathantanmy job=sendgmr) by 2002:a25:b113:0:b0:e2b:ce2f:787a with
 SMTP id 3f1490d57ef6-e2f2302ed44mr8054276.3.1729793331241; Thu, 24 Oct 2024
 11:08:51 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:08:40 -0700
In-Reply-To: <cover.1729792911.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1729792911.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <b2c76c207d3ea880c612f115f733a91bc6b529a3.1729792911.git.jonathantanmy@google.com>
Subject: [PATCH 1/5] pack-objects: make variable non-static
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, calvinwan@google.com, 
	hanyang.tony@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/pack-objects.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0fc0680b40..e15fbaeb21 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -238,8 +238,6 @@ static enum {
 } write_bitmap_index;
 static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE;
 
-static int exclude_promisor_objects;
-
 static int use_delta_islands;
 
 static unsigned long delta_cache_size = 0;
@@ -4327,6 +4325,7 @@ int cmd_pack_objects(int argc,
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
+	int exclude_promisor_objects = 0;
 
 	struct option pack_objects_options[] = {
 		OPT_CALLBACK_F('q', "quiet", &progress, NULL,
-- 
2.47.0.163.g1226f6d8fa-goog

