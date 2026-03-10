Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76773B19C7
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158447; cv=none; b=HQfwGebKFnIZKVvP9vfuFq7j2NWcr8YGHvL3L/dfWKrCqTxco67k8zISzz2T8OILtvDQYY4dBmNbF6IBJ9wjvmq47c3ESpoaovFYBS0WJfAE/KWqq7Ph0jEN0j9dddczNmuOlj2RiFHDDcKx3hVf+/HTB+14O//LS5M2SmTzhQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158447; c=relaxed/simple;
	bh=MZlOXqOMFyVue1Yp0FfY8AoQGgOFF2nafiSjvWFpr30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V753MgC07UfNdCvCg5O6SFM9BdR52cKxANhIXXEBaN6JCrOTZURevQm4wLz7i60D91JP/NHM388RAvePppwq775DeHNQiVWST+GZRqImXYCUu81676bL7IE5PAIgRVPF80cl1+fnDYWewQTRDtfsdnKvyW17GqU1VGJA61c4SM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJ0IOzjF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJ0IOzjF"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-829ac8d56c5so3726729b3a.3
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773158444; x=1773763244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Txkx318MFJ+bpK2yZk6GYXuWfQGzWRjfnW+eVpbS1hE=;
        b=PJ0IOzjF1xUiZqzu6zZY6F8ojJRXV7Qi6Hj77ShZY/AgQh0ZxMYqHp5velzkTIyVh2
         /HGrJ/+EAH6pzTDDIH0CireomvUpnRfFZz0cFWX5D38TSvG1yAKiT1F/XTxDleADthyp
         F0d9TUipNUlVBDe7i3rGUOauRWBi85Cs7UsfWTk9k43fl79/0JEbCbi9qU8tr7Z9WDXP
         Fex4wYOxT/mLCjtq7zBarRXhu+fk+OENCL/C1H/1sj8v0NyAbQwCZ3xQfnprnRMMngbn
         /ypKE88+PzqfO8cd7gRco5SSbnPvc/G2CQKFwvzqAu3/AL2q3OivsnLPIIpdpvvgSWlg
         3JeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773158444; x=1773763244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Txkx318MFJ+bpK2yZk6GYXuWfQGzWRjfnW+eVpbS1hE=;
        b=l6rqAbKvzBQLSU/zPefu0WO95pdudUighhP8H5hMjdTn9KOaCZkK1lFPuHh7vw6TD7
         3nZYWlWpvxFmb1YkzHiQ8V//x3uIkmXDJk4MzlayCa6e90hVTH/9fAim1iswbA2WgZFj
         eBH9tNvzBt0yTtO/1rVXWDRT4DT9Wn45JPGXviuLY42eB4DVTsrfEMyTq2308Y9py8+0
         L9ldZK4XvrBu1Z9wEkP/b9KyZHSLY+XTJimzo7/U34u9SXOK60hknwXbkLyNbPAdaiS7
         oVMOO3lw0aaG53KJ3JlxE8JBqyqT15y/dOXu9fBi5lveMdAScoSeQIqHah06WrbFVQyn
         KJAA==
X-Gm-Message-State: AOJu0YxnqxUI7QQRFSgHaIaIdUXK6gsJRByOWVJTmVv1tgfvNcWvOIUT
	I9Z9bclffi0jeNKDkRV4/gpvuaF5ja9/ryAQOof4GV2HcKqJ1M0vJATW8JB6Bxt2cZY=
X-Gm-Gg: ATEYQzz+OfFyRGvXErIfKCGhL5A4J1dupL9Rn2/6fIszWjQclC8BZJCumYpB+MFbl+N
	NVR4nP3E30j7VsIdzpVz6CgMSvJNkJkR/Y0gxufrkccSBoWwskklMd3QNwTQChD7a+jiE9hW585
	jrMA7qNle7HyWKKhHZFeMEWTQUDcpiewZ4sJMaub6wh/f7ztSMp5xK05ZthTL8JJN2n2Q5dQ3af
	AX6kssZ7eae5nL7Q3zKgo9ls5l7+drMxRh9pRICtRawiiHdj4ZbWj3PL9+uSDPsId687WhZ6cDA
	E9hbTzQkA0q7XRGCNpwqT1a0Xj5UnxRbpJ6TI9XbIJy+RpQ3cSbBG93VJRnCPgNgIeooFHlrl+U
	vYwrSntVrRJMCAImRciusvK4SUlEszmTPfNBLkOD03NlqvXV7xAFA7Tui0nGyXm6z6CyeOM7LWF
	cZrTGR8zHYJiFBzPcINwGSph308duH/L58O3nV/SNZ8+K6uy+Z6xeA1fR1IPYFhtX8HL0x9fFv1
	lxunEh177YaRE4=
X-Received: by 2002:a05:6a00:1a0e:b0:827:4526:50d with SMTP id d2e1a72fcca58-829a2dc2dd2mr12306506b3a.29.1773158443477;
        Tue, 10 Mar 2026 09:00:43 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:c0ff:5e57:d1f2:db6e:4afa:7799])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48b2c41sm13778566b3a.54.2026.03.10.09.00.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Mar 2026 09:00:42 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jonatan@jontes.page,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH v2] builtin/help.c: move strbuf out of help loops
Date: Tue, 10 Mar 2026 21:30:29 +0530
Message-ID: <20260310160029.44605-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <abARj_VI9n2nB_xT@pks.im>
References: <abARj_VI9n2nB_xT@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In list_config_help(), a strbuf was being initialized and released
inside two separate loops. This caused unnecessary memory allocation
and deallocation on every iteration.

Move the strbuf declaration to the top of the function and use
strbuf_reset() inside the loops to reuse the same buffer. Similarly
release() the buffer at the end of the function to free the memory.
This improves performance by avoiding repeated heap pressure by reducing
the number of allocations.

This also fixes a minor memory leak when the SHOW_CONFIG_HUMAN case
triggers a continue.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
Changes in v2:
- Moved strbuf_reset() after variable declarations to follow 
  coding standards.
- Removed unnecessary empty lines to tighten the code as suggested 
  by Patrick.

 builtin/help.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 86a3d03a9b..467a0763a6 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -134,13 +134,11 @@ static void list_config_help(enum show_config_type type)
 	struct string_list keys = STRING_LIST_INIT_DUP;
 	struct string_list keys_uniq = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
+	struct strbuf sb = STRBUF_INIT;
 
 	for (p = config_name_list; *p; p++) {
 		const char *var = *p;
-		struct strbuf sb = STRBUF_INIT;
-
 		for (e = slot_expansions; e->prefix; e++) {
-
 			strbuf_reset(&sb);
 			strbuf_addf(&sb, "%s.%s", e->prefix, e->placeholder);
 			if (!strcasecmp(var, sb.buf)) {
@@ -149,7 +147,6 @@ static void list_config_help(enum show_config_type type)
 				break;
 			}
 		}
-		strbuf_release(&sb);
 		if (!e->prefix)
 			string_list_append(&keys, var);
 	}
@@ -164,7 +161,7 @@ static void list_config_help(enum show_config_type type)
 		const char *var = keys.items[i].string;
 		const char *wildcard, *tag, *cut;
 		const char *dot = NULL;
-		struct strbuf sb = STRBUF_INIT;
+		strbuf_reset(&sb);
 
 		switch (type) {
 		case SHOW_CONFIG_HUMAN:
@@ -195,13 +192,13 @@ static void list_config_help(enum show_config_type type)
 
 		strbuf_add(&sb, var, cut - var);
 		string_list_append(&keys_uniq, sb.buf);
-		strbuf_release(&sb);
 
 	}
 	string_list_clear(&keys, 0);
 	string_list_remove_duplicates(&keys_uniq, 0);
 	for_each_string_list_item(item, &keys_uniq)
 		puts(item->string);
+	strbuf_release(&sb);
 	string_list_clear(&keys_uniq, 0);
 }
 
-- 
2.51.2

