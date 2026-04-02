Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE76388E51
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113611; cv=none; b=f46VdaP33WnHfIQ+iK6u0sw0UYOdMHLeJ2tOhhnjo98OvMlZn+qM3gyQS8FCYbh98NJbgYDCpSampLJJ4JIkFu+52dlRte1NKK5Sp+HzzV2F9QJDgUVmBnyVsSGGxRwTjsO5+dxVu1KR6YPiqOI87W23T1kh7ACzjJjV69C6+OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113611; c=relaxed/simple;
	bh=GoIzPmfFKw6u6aFjgiAjm5+oVee+c6aY4hCn/dTlO04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F01cjMDCNOl0gHEckxWeeXfLPQLRgeHLcqk6TfFaNiVuVJGpRteuIRkRGd/hLJNiJhquC+IDC+hQLarbkCtzbNX3zYUSwwelmcOuLiPQm+aIrSWW0sjEFGJCmZS5wa0Bcyt35LJkKmjkF8FVU86xmYPENIICPO+TE31RVtOHsCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI1zD6cZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI1zD6cZ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4887eca00c4so3081915e9.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 00:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775113607; x=1775718407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kZLGKW5Xbp7j6HeqcRRIWdMJv7xTFkNbItsRdvzrlI=;
        b=SI1zD6cZBw5iZPZPhR0XQL45PU0jHco2ktJoJeBThJ/cBvRw/Sx638FTmw4fzZEOtX
         YUO7MqLBtnih8qVfSZBjcjtS7D/6NrqFpIZktyqpru6155wq1NoTXFUnOyNd6P3nhJzG
         uusdCPMsdWKFoSqqNfeX8HxRPneYFZb8W4El9QxPu0cdtsHDcaS2ECzosqzYxkgewLuV
         6GwmOTXCGXwu1nKgnNGNVHUM4YkA/ANwNJA69jq4Y39oTcgsPUB/c81ByCJwnQQICZwu
         sAVZOTi2o0o2jTC0GeKUj0HbSITi8Yxf/kUVx1ea9cqVKcQ0surysRRcCeydF5/f9LMi
         OTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113607; x=1775718407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7kZLGKW5Xbp7j6HeqcRRIWdMJv7xTFkNbItsRdvzrlI=;
        b=H+rddYdwYQ5aIYzNubptkACZ4T2XzYk5EqYTPPy7jM3DSdDv9zzpjLbIjfc8bK5eox
         KYgRN9LwtjiFf7xnf76dv39XDfNnyBuSjA0BTNPueeVFCZrV2Fe9yxQFBpglQZTwkdZy
         6mBK4e6HXWWsQdWMUP58KoHkTK9NxFfjFIE/OnCdLzV0FPFaJIBrkgFHPi0qXbcTAQ7i
         2HCu0nBxe2fBJjsub6L5JQc50YYC0A9OE7nuT9AnXSSM1BB7WwLe/sYYjXEcbWwB3Xjm
         ecKbXoQTFPl6GgCcccLlyi1UPNlLxGXVIth3ndBCl6moWWEGvQHwTXzM5Em55j2clSzM
         QMmQ==
X-Gm-Message-State: AOJu0YyxnkAHa+sPmrz2tQ36U21M3CEFR7qy31X43XovtXiZzp+HZAnV
	dtzGVlgPJROVziRiB5t3BNg/Gh04XzlCgPjsXDABavDNT4hWjISPc76z0J76Gg==
X-Gm-Gg: ATEYQzxO4UfOPIIGLBTEmCVUbdKsS0KgchTqQWqCAKSsaTVd6d+7T4QNOlW7U4H0TvO
	MtpetPzqHLUUIybWW+ST+TfpV/5Ok7R4lA2Q3FrDYGJOSoCCQbWxXCrgwV/igwITrC276HUNXWt
	8LbDkdY6B/DEVPDqRU4KnXNl+Eg6rJzTuxrVsNeSqVMtKiiI15q/VwiVITIsGdG8JaZdTaSV8nA
	Mlf6KOAZN510UgDGxKJP00dx4OvHTWj9Pf3JHYhuQwSml2GrV1KlRB0Qa6gCVLTlscgDEgZwH6l
	6J2Hvj5xy9I/5rY0Owm/PsMiX2L84wN2Jsct9GofwCXgB2Ytun6c8wJfh6GUSXdF6jxwwTV6x2c
	k8xBVkju0juEb6R8ciIkQg/9tRZF8LIohPE+3oaeHUdRd2cPIMph+mvOGmHiJws6Llz2iu9WJqp
	vgkEzDjnlyK1uO+CRHzM3Yt8humzvPWwgzHyNU5+14sSV5ePBk9kRT6ypUFTQacqIc8URL94Ns5
	SdsxyFPT2ZFRZOykxQ4ABI8CYBvmUzXIJJM0iA=
X-Received: by 2002:a05:600c:450e:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-488835b3083mr110289885e9.21.1775113606868;
        Thu, 02 Apr 2026 00:06:46 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8bc9dcsm101916335e9.6.2026.04.02.00.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 00:06:46 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 09/10] promisor-remote: remove the 'accepted' strvec
Date: Thu,  2 Apr 2026 09:06:12 +0200
Message-ID: <20260402070613.85934-10-christian.couder@gmail.com>
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

In a previous commit, filter_promisor_remote() was refactored to keep
accepted 'struct promisor_info' instances alive instead of dismantling
them into separate parallel data structures.

Let's go one step further and replace the 'struct strvec *accepted'
argument passed to filter_promisor_remote() with a
'struct string_list *accepted_remotes' argument.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 74e65e9dd0..38fa050542 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -885,12 +885,11 @@ static enum accept_promisor accept_from_server(struct repository *repo)
 }
 
 static void filter_promisor_remote(struct repository *repo,
-				   struct strvec *accepted,
+				   struct string_list *accepted_remotes,
 				   const char *info)
 {
 	struct string_list config_info = STRING_LIST_INIT_NODUP;
 	struct string_list remote_info = STRING_LIST_INIT_DUP;
-	struct string_list accepted_remotes = STRING_LIST_INIT_NODUP;
 	struct store_info *store_info = NULL;
 	struct string_list_item *item;
 	bool reload_config = false;
@@ -922,7 +921,7 @@ static void filter_promisor_remote(struct repository *repo,
 			if (promisor_store_advertised_fields(advertised, store_info))
 				reload_config = true;
 
-			string_list_append(&accepted_remotes, advertised->name)->util = advertised;
+			string_list_append(accepted_remotes, advertised->name)->util = advertised;
 		} else {
 			promisor_info_free(advertised);
 		}
@@ -936,12 +935,10 @@ static void filter_promisor_remote(struct repository *repo,
 		repo_promisor_remote_reinit(repo);
 
 	/* Apply accepted remotes to the stable repo state */
-	for_each_string_list_item(item, &accepted_remotes) {
+	for_each_string_list_item(item, accepted_remotes) {
 		struct promisor_info *info = item->util;
 		struct promisor_remote *r = repo_promisor_remote_find(repo, info->name);
 
-		strvec_push(accepted, info->name);
-
 		if (r) {
 			r->accepted = 1;
 			if (info->filter) {
@@ -950,23 +947,23 @@ static void filter_promisor_remote(struct repository *repo,
 			}
 		}
 	}
-
-	promisor_info_list_clear(&accepted_remotes);
 }
 
 void promisor_remote_reply(const char *info, char **accepted_out)
 {
-	struct strvec accepted = STRVEC_INIT;
+	struct string_list accepted_remotes = STRING_LIST_INIT_NODUP;
 
-	filter_promisor_remote(the_repository, &accepted, info);
+	filter_promisor_remote(the_repository, &accepted_remotes, info);
 
 	if (accepted_out) {
-		if (accepted.nr) {
+		if (accepted_remotes.nr) {
 			struct strbuf reply = STRBUF_INIT;
-			for (size_t i = 0; i < accepted.nr; i++) {
-				if (i)
+			struct string_list_item *item;
+
+			for_each_string_list_item(item, &accepted_remotes) {
+				if (reply.len)
 					strbuf_addch(&reply, ';');
-				strbuf_addstr_urlencode(&reply, accepted.v[i], allow_unsanitized);
+				strbuf_addstr_urlencode(&reply, item->string, allow_unsanitized);
 			}
 			*accepted_out = strbuf_detach(&reply, NULL);
 		} else {
@@ -974,7 +971,7 @@ void promisor_remote_reply(const char *info, char **accepted_out)
 		}
 	}
 
-	strvec_clear(&accepted);
+	promisor_info_list_clear(&accepted_remotes);
 }
 
 void mark_promisor_remotes_as_accepted(struct repository *r, const char *remotes)
-- 
2.53.0.765.g57b94de1f0.dirty

