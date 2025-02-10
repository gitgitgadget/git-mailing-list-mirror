Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80891ACED2
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 19:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214944; cv=none; b=cgZqWGE2dX8LY4awy6DGpsFwB7LzNqmEigXLnDfJT8y77yULgqt34mAVPOqYnTlIWYyKZRTqx7fxmvJtANyK9L/UfLgqOpPPNchi3VzwJk+ssBhKKS7T3MT7X9YoUzFXDb3qIh8OPYBukBhtdP6A+EN94jDrD3v3bLhzdJPeIxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214944; c=relaxed/simple;
	bh=qiebpfHq6wNnnlP1OOx2a7PlKITqFYp/FzkupOanbw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTZ48i71sRPHxLGCemUF50wPMDSy6VdY+CTFNStu4p3VHIak9RMMwisyAj+t415onUZDywkzZGWad5wHvkeFWuU1xeSC2HV5Rx7bjYOJXxLwvJiSqR4waJ9V5IkywGD2Zek6H9gBil1JBc6cbTEFGJPGM9ynxemTWPjrV/tl/p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=j5H2IoLy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="j5H2IoLy"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436249df846so32348005e9.3
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 11:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1739214941; x=1739819741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrJrjVeT4dMJIQ72ksXeI+2Ny2ldJIQi9NNeFCHG0Y8=;
        b=j5H2IoLyG2AJy6vItycZueb3bNqHtovtRw6ZJrFQ7k7YZF3ZxBa77exwvMFGuqc6fr
         zNQCwNxFyUqEAiygGTMb8mAud9Dde9FWFie0PagtwYsj/0vTW9599gIPifYsqQ/1FdIo
         jExQ+PRhMEUwHb8ZOfPm4oiNfjlymmECWOvZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739214941; x=1739819741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrJrjVeT4dMJIQ72ksXeI+2Ny2ldJIQi9NNeFCHG0Y8=;
        b=Xf4UjkhLrCTmxUTxWNbBarcQM8ZGJF8QUIf/LcaR4EsVJA+gc666rLDswTccovME7s
         EXcoMAFlC5SDLwtKGzeX9gGUYa0f8F9V+7iTwGCuC8kRfGdZ0HezOjxESCFvZxJYgapk
         aDgN7dNegzyGgu0BfcCG4Ijgol1STn3Cuhl+BmbHHaJ72uiSXJdmXDRjXa26hzE+xbQE
         CAS7dsFNA+ywDez8Na7RihrFRvTfRc8FbI6k+PG2o5JZA8+FvN0WTsMst4eY20A2uJdv
         PO2BEUKwLex0t1R2kL5srJA2oCc2ZrB77YD+c+Gmf7M01/TdIBt3QOWCEBFyZdaaEi/g
         J1Jg==
X-Gm-Message-State: AOJu0YxzjIhKtQM4ephjhhUglxKBE6VJCFjH1UNAi9dKogk3dURNYFAJ
	OqCMTCESImRLtKdWfzVYtRcOmO8CdYFADxreUyVjsx1prNMBDDT+T/OEPFg3nKN+1ATJCSEpLIr
	933ZMNQ==
X-Gm-Gg: ASbGncv5m1RdDGArh8GPxZzJ3dR5K05XATuKeNwyfo7v/NU/jrwK06CTd+Jkbk+kzy+
	dr20uq1mJSRfU1m05WRnwoxdNVYcTRiQIiuV4SoCu3//O6cPMlm6FXL+6wrpK5EndRln3u3bINF
	z2ru9WZZj5ulbTkY/r+PcNbXD+VNpHrmIWlyz1cY9y/68U4CS3+G/s1HXsDHZ/6bodYf0ZWT0Tf
	xdfUpX1Ejbfh2Xa95HauUKog6PwWkrAWjqANBa8jXwy/Fwrohydk15oGti4vn6+4IS+D5TvwKfw
	SkCwLy0L+StoqXCynhjL83QS2CBhOh1U8g==
X-Google-Smtp-Source: AGHT+IF+OpSDeUp5KC8m7YMj3py1UdCVy2Sm6jSrGs33m1VfZG3HCIcpNoJSMI36nrItuDNdR98ZDA==
X-Received: by 2002:a05:600c:204b:b0:439:3039:2ece with SMTP id 5b1f17b1804b1-4393039318amr73749755e9.28.1739214940584;
        Mon, 10 Feb 2025 11:15:40 -0800 (PST)
Received: from able.tailbefcf.ts.net ([91.151.136.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43946bff4d4sm30477055e9.3.2025.02.10.11.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:15:40 -0800 (PST)
From: Ivan Shapovalov <intelfx@intelfx.name>
To: git@vger.kernel.org
Cc: Ivan Shapovalov <intelfx@intelfx.name>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] clean, dir: add and use new helper `add_patterns_from_string_list()`
Date: Mon, 10 Feb 2025 23:14:37 +0400
Message-ID: <20250210191504.309661-2-intelfx@intelfx.name>
X-Mailer: git-send-email 2.48.1.5.g9188e14f140
In-Reply-To: <20250210191504.309661-1-intelfx@intelfx.name>
References: <20250210191504.309661-1-intelfx@intelfx.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
---
 builtin/clean.c |  5 +----
 dir.c           | 15 +++++++++++++++
 dir.h           |  4 ++++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 053c94fc6b..eaddf6a06e 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -931,7 +931,6 @@ int cmd_clean(int argc,
 	struct pathspec pathspec;
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
-	struct pattern_list *pl;
 	struct string_list_item *item;
 	const char *qname;
 	struct option options[] = {
@@ -1017,9 +1016,7 @@ int cmd_clean(int argc,
 	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
 
-	pl = add_pattern_list(&dir, EXC_CMDL, "--exclude option");
-	for (i = 0; i < exclude_list.nr; i++)
-		add_pattern(exclude_list.items[i].string, "", 0, pl, -(i+1));
+	add_patterns_from_string_list(&dir, EXC_CMDL, "--exclude option", &exclude_list);
 
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD,
diff --git a/dir.c b/dir.c
index 5b2181e589..fa3fd53649 100644
--- a/dir.c
+++ b/dir.c
@@ -1263,6 +1263,21 @@ struct pattern_list *add_pattern_list(struct dir_struct *dir,
 	return pl;
 }
 
+/*
+ * Convenience function to convert a string_list into pattern_list.
+ */
+struct pattern_list *add_patterns_from_string_list(struct dir_struct *dir,
+						   int group_type,
+						   const char *src,
+						   struct string_list *sl)
+{
+	struct pattern_list *pl;
+	pl = add_pattern_list(dir, group_type, src);
+	for (int i = 0; i < sl->nr; i++)
+		add_pattern(sl->items[i].string, "", 0, pl, -(i+1));
+	return pl;
+}
+
 /*
  * Used to set up core.excludesfile and .git/info/exclude lists.
  */
diff --git a/dir.h b/dir.h
index a3a2f00f5d..eb843c9bb6 100644
--- a/dir.h
+++ b/dir.h
@@ -460,6 +460,10 @@ int hashmap_contains_parent(struct hashmap *map,
 			    struct strbuf *buffer);
 struct pattern_list *add_pattern_list(struct dir_struct *dir,
 				      int group_type, const char *src);
+struct pattern_list *add_patterns_from_string_list(struct dir_struct *dir,
+						   int group_type,
+						   const char *src,
+						   struct string_list *lst);
 int add_patterns_from_file_to_list(const char *fname, const char *base, int baselen,
 				   struct pattern_list *pl, struct index_state *istate,
 				   unsigned flags);
-- 
2.48.1.5.g9188e14f140

