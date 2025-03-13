Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E836AAD
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 00:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741825276; cv=none; b=bkzNcnfONcTyiMl6OTmLRql3nlrXwCnIRUzz93CE8ha0YRR6JBlyIhll6trEWoCjzblAQpuVIyY2OpekBHpfQbrw92AapCJmOKXpN4wHtKugWTkpQnSux1onlaMHPyl8tPnCym/2XF0TZd0ViD8GkEhqaSXP/KFzTkkvHCj0SYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741825276; c=relaxed/simple;
	bh=9Oixtf8VtLt11mtugwndN5WDyIGQO6bIWKsWs5kuz2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gI0LuYUsdu5aYuX/GfNR48ielCnATWBUrwL1JzLPkkvPnlQvuyACoHGeecU2Ou6lvhgUdOomNecaJCE6/ZTKA9K190Axa868bOxWujQTGe3ZIA7NN1e+2FPtVPGDmU72ULfZdSKkDs5ZNuqK6Qcb33tKDsqgM2zfWt05OCO0SpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zm52nfOu; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zm52nfOu"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72b7a53ceb6so347302a34.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 17:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741825274; x=1742430074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNuZlJ4W5k6Ov8daMR9JpIecLLiQjZVFryYurms4G8k=;
        b=Zm52nfOuDJYHgCCrDLthLL4Gcw7/fyuuvU9p3fSbW0USEIGbzF455I/0KQguawtXuh
         3bzTSJlm0+ZFz5/EVDkZSd2rpKfxXifckNLsawRK25c1GK8OX6eL7LPbH8w40eNXG1Jd
         FE1UEG3mBToZBQOJ//S1ZfhwoTFHhipEC2CHQ7KfB/8fY2MjpJl61iK3x7FY0h3WEmRV
         1GV9HFSqO2BPvJKzz99qqS4H2CkLXXBHtJ1oCIUsPGoQ9qffbHxPhKVVzhJ6C/iiZpEs
         QudkbOGHVVxzRqTO5gEvsmYlVot/rbvoF3Kgcoo4+lNLktVc+BU/Gxa1F/Ioe0vwI6WC
         2SKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741825274; x=1742430074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNuZlJ4W5k6Ov8daMR9JpIecLLiQjZVFryYurms4G8k=;
        b=PMSV45huiJ4BqXBBJsiq1vxUgv7I8DThi4TNRic8SFot0xZgOqHddqLNboJoQagw/R
         joLvNh3gGmfgJpMr8LxhR4qKyvbD/0RT0Fsf+N3e6puYmWxYYGeBLdvpNLTIHJFop8yN
         o47LybrWbgwwHEqx+5J5flGKCB4CLW4D2+er5ATRqmjHsuFbRarLj/LY0YBlT+Na/ZJz
         ElUIuOzx5yuScjvbxFwS1RNlgVwr76V1axnitYrCR/gUlhIS9gsZKmQfTUzjp2q7Gx+C
         41Qk6oJey+C99OUHKH7//cUh7gJYR1Qm07ceJIJBOKaKfYEyYE0CbJHf9isjbcN/3bHO
         nW7Q==
X-Gm-Message-State: AOJu0YzK2CCBC0oHnnMPj5gkCfwy0p6H47TSEWBBc6FMXhU8QiSrNmKE
	70CYCPam6p9R5uatihrI24jAy2wEva71tIQQxVu1eM7FOPioRM9wYFvWtxK+
X-Gm-Gg: ASbGncstf9qJdV/dgndFeG46IgZyk9fgoVmBJG0dSZkjfyosVZDsWagGmy4dZMJBhFU
	c53nEyAS2LM3a/o6H0/satk/Jx7/kmJEdvXF/WHJCESQe25CBO1QxbfDfpQUToSSiO2K465aDis
	CNAFiIc9n7f7nXC/ooK8/CvvnbtjKHkB+TbuO83BoWEtny+5wLij1rTzstaz4pITRz87zhQ/eri
	H3zCaEdGEYaAUcjHnOMFQe6rXDi+scEYfUfpugWfyOwE7N1MZgL+m+l2trbXGxGjQU9csOsh6Rl
	2/JSB55QB35oF0/An2ppRo5nzKA0In5LFRIhjOl5rNaS5Oab8d4q
X-Google-Smtp-Source: AGHT+IGFC5BZtvftr513PR6QoED2qTyMWXyJtQdimhKuQqJQ1IzgcaAbV2ppIb798jVOT57kxELGQQ==
X-Received: by 2002:a05:6830:1614:b0:72a:48d1:7fca with SMTP id 46e09a7af769-72bb18ce1a2mr294314a34.4.1741825273805;
        Wed, 12 Mar 2025 17:21:13 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb267a8b4sm24028a34.9.2025.03.12.17.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 17:21:13 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	peff@peff.net,
	ben.knoble@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/6] rev-list: inline `show_object_with_name()` in `show_object()`
Date: Wed, 12 Mar 2025 19:17:01 -0500
Message-ID: <20250313001706.3390502-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250313001706.3390502-1-jltobler@gmail.com>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250313001706.3390502-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `show_object_with_name()` function only has a single call site.
Inline call to `show_object_with_name()` in `show_object()` so the
explicit function can be cleaned up and live closer to where it is used.
While at it, factor out the code that prints the OID and newline for
both objects with and without a name. In a subsequent commit,
`show_object()` is modified to support printing object information in a
NUL-delimited format.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/rev-list.c | 13 +++++++++----
 revision.c         |  8 --------
 revision.h         |  2 --
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index bb26bee0d4..dcd079c16c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -357,10 +357,15 @@ static void show_object(struct object *obj, const char *name, void *cb_data)
 		return;
 	}
 
-	if (arg_show_object_names)
-		show_object_with_name(stdout, obj, name);
-	else
-		printf("%s\n", oid_to_hex(&obj->oid));
+	printf("%s", oid_to_hex(&obj->oid));
+
+	if (arg_show_object_names) {
+		putchar(' ');
+		for (const char *p = name; *p && *p != '\n'; p++)
+			putchar(*p);
+	}
+
+	putchar('\n');
 }
 
 static void show_edge(struct commit *commit)
diff --git a/revision.c b/revision.c
index c4390f0938..0eaebe4478 100644
--- a/revision.c
+++ b/revision.c
@@ -59,14 +59,6 @@ implement_shared_commit_slab(revision_sources, char *);
 
 static inline int want_ancestry(const struct rev_info *revs);
 
-void show_object_with_name(FILE *out, struct object *obj, const char *name)
-{
-	fprintf(out, "%s ", oid_to_hex(&obj->oid));
-	for (const char *p = name; *p && *p != '\n'; p++)
-		fputc(*p, out);
-	fputc('\n', out);
-}
-
 static void mark_blob_uninteresting(struct blob *blob)
 {
 	if (!blob)
diff --git a/revision.h b/revision.h
index 71e984c452..21c6a69899 100644
--- a/revision.h
+++ b/revision.h
@@ -489,8 +489,6 @@ void mark_parents_uninteresting(struct rev_info *revs, struct commit *commit);
 void mark_tree_uninteresting(struct repository *r, struct tree *tree);
 void mark_trees_uninteresting_sparse(struct repository *r, struct oidset *trees);
 
-void show_object_with_name(FILE *, struct object *, const char *);
-
 /**
  * Helpers to check if a reference should be excluded.
  */
-- 
2.49.0.rc2

