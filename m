Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C5338643C
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113609; cv=none; b=LZoDf4h93VUI2RF64FxqE838+ESMPFnxh/d+1s3m3wm4PDU/RSh8nU22JNU/LkZRpdO4KcqKX8psRTTam8gy9nkOvclSzWdRmPPjGRZzKoj4J+6qPvIQdNy5vY5UNkvmW1jrCBeR40Tc2MpDCcDEBsjwDb3xbC4Eyy+ev63os8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113609; c=relaxed/simple;
	bh=zQr6KLkC9uDF8T122KADleY7rMGUF2smjB58CKON6wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKTzvlgfKj8+l0Un4WJZQ/QsXbS8VorW9sceevV8iXasyVnB7Dk2kTCGl/OCcTvYdyAql0yDD4ZFEs/XZQqcB5jLiVcsth4fvK6JNeBnG3+7f1L6KgK6yUjrkV4h4w845rBWnqQXvTKvzd0CTwUyBgTTrOx2gcbcrn4vWGzQbKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbGK1VKK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbGK1VKK"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4888375f735so3949115e9.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 00:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775113606; x=1775718406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS6Q3WPrrFHm46PZiRXV/yFm0580M6j88sSYzJyeVc4=;
        b=CbGK1VKK84eBICyzrUs20oR6xnWV9WFOPwksOzQgkivta7rU8x5SuKecmG6MNeN6CW
         Xu0c7LYgMS7wX1pNY0xxQukWhoFsCOCURWTRw4biNYCQoHGccpAsZy/8f2VTsXpb11PE
         QjaRArXtYxA2RXMBJ1aYcgi3Azi4NZ0VF0DQAfwA8FZL83eJlEpEg4W6is3zZk6Trk0D
         ri6uDz7zrqWm/O1gz0iPyC3ImwOODMlDOYnaClZ2jOZZAMCxzzYeVK5/ejwHxnJSQ8of
         lsikTEC9yzMC48nApQLf7HzC2M8G5H5rs9LST1egUUrSqzs6JPeTCM615oay5qhCZc9I
         U4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113606; x=1775718406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OS6Q3WPrrFHm46PZiRXV/yFm0580M6j88sSYzJyeVc4=;
        b=UZLudauNEO2xqf4aKAdCJEFuj1bDau5U8CM/KrUKvDdYqi3Vy1HRoDdEEBUDxwE3QV
         VuaAMJDcEl2we/CR6Lyp6S9c3vm0G9jSB7N1tjuCxw3LD/3JNpUdcmXYbFd2XPSACE7k
         A2Omc0k85Ucbfl/KRsChA4nuZLbyC9j2nUT39wRBU/e8530eBCrU8ISelKJ/2qtHA8c+
         rps/JuKLmO0w0uS1cbGcC4AM1vlJuseeN9A/XfnblaQ8t2IYDtTc1sH+y+t6DsqK766F
         BUnljF5IHz8epQ8W0BxCHfgwiKbxdNAEwPb931a6//enfMZe7ktNjXu7rNdvD/cVOkpE
         n5uw==
X-Gm-Message-State: AOJu0YxXwz40cmvS8pA47hkDwEydfoMmFJnA91emPlHOH2for/MZq4EH
	IoTDGhlkuJ908qgzG0/sCIft+yVfPKIjUIqtRr2xsusp3XeIZyWPjHzuKqyNvg==
X-Gm-Gg: ATEYQzzylY9g7jxVqR5YQwGHKhGTFVcMiH1nQAjt0UqldN1p6pi/PnbznXh7cOcLgSf
	FWzSm3CfWOLqJXMTKDopy3unA5fn8mB19w9+h6eeagQS4Yh2lp6JuRw4K8W4HHrPSM/5KO+D75q
	YYVulnNRFKgdPmMQJohvsPRsIY7CKivO0UQ9CSq8vo5ypKpMLgnczLkDtnkKZfnM7gyVBq0IByb
	VODEiMTKBz8HWFBmNd03bVCwMglHBt7PRHqBgT1a1+9InC1SUyyZEnd8yYoVMOiqtXJ9vt9Cz//
	4LTwccldgGqsuUZplQNXnWxPilOztruajVSubGkQ8zqg9+n2bkx2iHXXyLP/ZShWZLvZW90AqjN
	O/Ska0EZ8xpN26pKk87iozJClRD2FcZ1vI4WfKMoSIOmUJe1nKj2mVGe5zA9QbhDOI2bnzIP883
	twVg/xLbc7xqmccWTJEdz9MEfh3F7CdqgYm/0SWeKZPlbzLx5xaJIAjTna8aVamdUN9VS+c6iug
	oo0C0CYmhHeZubG8155SvgcBIHRNHM7bw8OZMc=
X-Received: by 2002:a05:600c:c04a:b0:485:3d3e:1675 with SMTP id 5b1f17b1804b1-488835714e5mr73771145e9.8.1775113605435;
        Thu, 02 Apr 2026 00:06:45 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8bc9dcsm101916335e9.6.2026.04.02.00.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 00:06:44 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 08/10] promisor-remote: keep accepted promisor_info structs alive
Date: Thu,  2 Apr 2026 09:06:11 +0200
Message-ID: <20260402070613.85934-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.765.g57b94de1f0.dirty
In-Reply-To: <20260402070613.85934-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In filter_promisor_remote(), the instances of `struct promisor_info`
for accepted remotes are dismantled into separate parallel data
structures (the 'accepted' strvec for server names, and
'accepted_filters' for filter strings) and then immediately freed.

Instead, let's keep these instances on an 'accepted_remotes' list.

This way the post-loop phase can iterate a single list to build the
protocol reply, apply advertised filters, and mark remotes as
accepted, rather than iterating three separate structures.

This refactoring also prepares for a future commit that will add a
'local_name' member to 'struct promisor_info'. Since struct instances
stay alive, downstream code will be able to simply read both names
from them rather than needing yet another parallel strvec.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 8d80ef6040..74e65e9dd0 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -890,10 +890,10 @@ static void filter_promisor_remote(struct repository *repo,
 {
 	struct string_list config_info = STRING_LIST_INIT_NODUP;
 	struct string_list remote_info = STRING_LIST_INIT_DUP;
+	struct string_list accepted_remotes = STRING_LIST_INIT_NODUP;
 	struct store_info *store_info = NULL;
 	struct string_list_item *item;
 	bool reload_config = false;
-	struct string_list accepted_filters = STRING_LIST_INIT_DUP;
 	enum accept_promisor accept = accept_from_server(repo);
 
 	if (accept == ACCEPT_NONE)
@@ -922,17 +922,10 @@ static void filter_promisor_remote(struct repository *repo,
 			if (promisor_store_advertised_fields(advertised, store_info))
 				reload_config = true;
 
-			strvec_push(accepted, advertised->name);
-
-			/* Capture advertised filters for accepted remotes */
-			if (advertised->filter) {
-				struct string_list_item *i;
-				i = string_list_append(&accepted_filters, advertised->name);
-				i->util = xstrdup(advertised->filter);
-			}
+			string_list_append(&accepted_remotes, advertised->name)->util = advertised;
+		} else {
+			promisor_info_free(advertised);
 		}
-
-		promisor_info_free(advertised);
 	}
 
 	promisor_info_list_clear(&config_info);
@@ -942,24 +935,23 @@ static void filter_promisor_remote(struct repository *repo,
 	if (reload_config)
 		repo_promisor_remote_reinit(repo);
 
-	/* Apply accepted remote filters to the stable repo state */
-	for_each_string_list_item(item, &accepted_filters) {
-		struct promisor_remote *r = repo_promisor_remote_find(repo, item->string);
-		if (r) {
-			free(r->advertised_filter);
-			r->advertised_filter = item->util;
-			item->util = NULL;
-		}
-	}
+	/* Apply accepted remotes to the stable repo state */
+	for_each_string_list_item(item, &accepted_remotes) {
+		struct promisor_info *info = item->util;
+		struct promisor_remote *r = repo_promisor_remote_find(repo, info->name);
 
-	string_list_clear(&accepted_filters, 1);
+		strvec_push(accepted, info->name);
 
-	/* Mark the remotes as accepted in the repository state */
-	for (size_t i = 0; i < accepted->nr; i++) {
-		struct promisor_remote *r = repo_promisor_remote_find(repo, accepted->v[i]);
-		if (r)
+		if (r) {
 			r->accepted = 1;
+			if (info->filter) {
+				free(r->advertised_filter);
+				r->advertised_filter = xstrdup(info->filter);
+			}
+		}
 	}
+
+	promisor_info_list_clear(&accepted_remotes);
 }
 
 void promisor_remote_reply(const char *info, char **accepted_out)
-- 
2.53.0.765.g57b94de1f0.dirty

