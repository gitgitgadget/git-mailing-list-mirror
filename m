Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D6C2B9A5
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726943885; cv=none; b=qlI4GpAXWKvjRzAYdKmw9bETCz8wwY9gS1fFrjixiPlOAC2MKmkqCgojMuo7Lm5mWeJlDUJl+LMwARrBosFwPBz/t/BtKH+T1244YsLFTE3XNYqmMkbAcOzR7FOfOKrVdKMlxPiYiavnwnc+DKDg/ZswrhoVdwTtztGdKhhSqNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726943885; c=relaxed/simple;
	bh=sRSInpGC/Gjvd28IQb3k75hP9iHU1CP+v7jJZMqyILU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cLwDcIRy6lqaTyTMxyvIz8z9DCa8ZtDjqdGbPD0ssX3BlQjlQTLf15OIYfVE02d1rAdUP+QcwLnLHYu/NcxtSRV8lSRhBGvTIN9C85oZ9dNZlFeKouW4KpERdkDUriRp9gZq43adq0aAlewOkWQ1jkiTzhjsHfIpgp75q5h9zso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQVFQ7lp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQVFQ7lp"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so372655166b.2
        for <git@vger.kernel.org>; Sat, 21 Sep 2024 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726943882; x=1727548682; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3lUiRaPU/VBZ9o31F4aIJh+0EZAHSL2RUeZaItGub8=;
        b=lQVFQ7lpT43hDjzDsWWc9NzjkEzC7qGrT2JEZA8wBZf5rry+b6pxGXBgYTO8SdNYj2
         Xk0uSccTYsq4v7Ds4tXJMVd5VIfXxZ16ziFsn9VMgRU8Sysib6rY96JokF4AQbfvnGuU
         Zozo6UT8OmhYLOavEUClSo7xAWpIw3bfttNfWIEo+uk0Pyze1pbTcWxODskRD2zMxo1g
         hQn3bS98YWWxY9mLZ/lEHjD9zc+9H7cm+LSEUK7U80fBxEd5QbznIsr5LQNGWjVnZtwC
         tIGRCuGcEiKuPyXcmsPh4Sh5ZTkG7LLf3IFCT4b9uUgcE22nKWNPc01cWboRwuhDtnfA
         KglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726943882; x=1727548682;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3lUiRaPU/VBZ9o31F4aIJh+0EZAHSL2RUeZaItGub8=;
        b=kBxivEkUyvEh9xvaBDdPpUVePqxrWPNDJRPc6X4eJiUR++c/9UBjlN5wy6vzFSsDDO
         RX+/sWuLS0+k8ADP5B5ozPvM597dZeDfArPMC/8/nBWdroa++rg4D8X91X/DAV3T/sBS
         9SpBNxnfQ3OiB07KgPe+xzUpP2BJbnw5MGvHvfDDeqkk8pHj2odkdErdzPijvU9AopVd
         ePPqVyP4eXqBEVgzqDkJRDC5Y3lCPDHkv0jP1pLlsI5vc2lQFbp0KxdklkgNqWPQF/OC
         ak1BeDTuwx364/R5NAkf+eevrPYQUL+cE8UWV5f8ubdEHzavWDbajDjlZenF/x1jNlEr
         ygTQ==
X-Gm-Message-State: AOJu0YyKS6Xn+o6rt3s0jHMrpClPu6k9RvgObmTR5tnbOt8IYOXm6mbW
	mv+sNqqqYGoS1iKpmZ+gOuty3f4yChOjvocnoGj3k6mcAZB6UHqPdmvhcA==
X-Google-Smtp-Source: AGHT+IH7tCjUooyURq/v+D7gvzz4z2dWrscg/rlzK6VYFQBMlpbXutsk3fWQN28TyqRxyS9p+HRHww==
X-Received: by 2002:a17:907:d869:b0:a8d:51d6:b3ef with SMTP id a640c23a62f3a-a90d5835e39mr603817666b.56.1726943881926;
        Sat, 21 Sep 2024 11:38:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610962d1sm997761066b.32.2024.09.21.11.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 11:38:01 -0700 (PDT)
Message-Id: <7f3d5e5da356f93ebef300ef73bfd6c312013e09.1726943880.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1784.git.git.1726943880.gitgitgadget@gmail.com>
References: <pull.1784.git.git.1726943880.gitgitgadget@gmail.com>
From: "Nicolas Guichard via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Sep 2024 18:37:59 +0000
Subject: [PATCH 1/2] sequencer.c: extract load_branch_decorations
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
Cc: Nicolas Guichard <nicolas@guichard.eu>,
    Nicolas Guichard <nicolas@guichard.eu>

From: Nicolas Guichard <nicolas@guichard.eu>

Extract load_branch_decorations from todo_list_add_update_ref_commands so
it can be re-used in make_script_with_merges.

Signed-off-by: Nicolas Guichard <nicolas@guichard.eu>
---
 sequencer.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8d01cd50ac9..e5eb6f8cd76 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5810,6 +5810,20 @@ static const char *label_oid(struct object_id *oid, const char *label,
 	return string_entry->string;
 }
 
+static void load_branch_decorations(void)
+{
+	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
+	static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
+	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
+	struct decoration_filter decoration_filter = {
+		.include_ref_pattern = &decorate_refs_include,
+		.exclude_ref_pattern = &decorate_refs_exclude,
+		.exclude_ref_config_pattern = &decorate_refs_exclude_config,
+	};
+	string_list_append(&decorate_refs_include, "refs/heads/");
+	load_ref_decorations(&decoration_filter, 0);
+}
+
 static int make_script_with_merges(struct pretty_print_context *pp,
 				   struct rev_info *revs, struct strbuf *out,
 				   unsigned flags)
@@ -6403,14 +6417,6 @@ static int add_decorations_to_list(const struct commit *commit,
 static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
 {
 	int i, res;
-	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
-	static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
-	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
-	struct decoration_filter decoration_filter = {
-		.include_ref_pattern = &decorate_refs_include,
-		.exclude_ref_pattern = &decorate_refs_exclude,
-		.exclude_ref_config_pattern = &decorate_refs_exclude_config,
-	};
 	struct todo_add_branch_context ctx = {
 		.buf = &todo_list->buf,
 		.refs_to_oids = STRING_LIST_INIT_DUP,
@@ -6419,8 +6425,7 @@ static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
 	ctx.items_alloc = 2 * todo_list->nr + 1;
 	ALLOC_ARRAY(ctx.items, ctx.items_alloc);
 
-	string_list_append(&decorate_refs_include, "refs/heads/");
-	load_ref_decorations(&decoration_filter, 0);
+	load_branch_decorations();
 
 	for (i = 0; i < todo_list->nr; ) {
 		struct todo_item *item = &todo_list->items[i];
-- 
gitgitgadget

