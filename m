Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFD715219B
	for <git@vger.kernel.org>; Fri,  3 May 2024 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740087; cv=none; b=GuirkctFAXzkqslEqBMutbdWYOl64WtaQkeM1YO3jt+Ri4YpxF6XNu47mqTL3M56ViWuPlkBfVUWYSxTl4u+MjdrrJxqpgwsXxNnXYLqzEe7Z7IE2nO3XgFN+Rg+qhParItTB+ZyDmOupwIzY941Gy6gHMi2EC+IjCgcq+BrZo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740087; c=relaxed/simple;
	bh=M8uZzTWP5riag+MhzZOFXsg1MdCr3znkpwZSnVjr9Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJXYVokxXi/Obr2xH1CNhaG+6wsFQLIHpMdm/XYNOYOtlW+4ysiEdCFCLN5FMyP9wDfBxe0ScX6+oxyecHPRCmSkM/m80SArKC2cM1DDxqhOiE1jV913Ik9VLWriASzsNHsK8mURfoFuwiHYw5w/ZosngdMHK/WlaxJPSgRQFYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIaL1Zca; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIaL1Zca"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a51addddbd4so1137497666b.0
        for <git@vger.kernel.org>; Fri, 03 May 2024 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714740084; x=1715344884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqhgek0HElC0rAfv9jQjHsyARw2W/VzMAuJ6Bo3w27s=;
        b=gIaL1Zca1oek/PoHhS3wntFll61SAwXYxBbr3fzDdDeIGAtIdf0Jg9VxFaS4CH1Vsg
         q/bGyBJbiBifydM8WnCpN3+ccbVV9f+ARGDIYIn53uipNkSMgSt/PSLK7F2FYIkTKt0Q
         EU7q5gt0ieXw+BsSHEMWHyoey2Sdz7CowAytjlPxi2tspybFggURTk660yog4uVo8ljA
         SMb+4h84CBAzsfQm79euDeJDous1VQ0kb2yU5sX07YwQvc+mdrZCcrYJI+vh9sWly8na
         TPxmO1UNiitvoIju+aYa8MWJNb2Au61eGrRB/3lvf8AWC1/Kr2at4FHmcde2iBEfypMo
         ZC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714740084; x=1715344884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqhgek0HElC0rAfv9jQjHsyARw2W/VzMAuJ6Bo3w27s=;
        b=PnUSM6PAF0x2KQBVweJx9Ygsjlz/psCMrldYwMVniJf+RBkVi8fepWOaIP02ibWVRY
         W3tzutME/XIokGEqyEHF+pNvnci5bCn3dGYFg/VFzYcdYyychyMtxxLBnUKA315U5UFE
         eOodmw63xxSIv1SqgiRrTJaeZJm5jXbnJHhckTnuh4JEfz2wU9shPcgbob1uP5FkAgit
         loNEA/G4xJasYqp6Qvfei8ve+JCAwL7OMEJP0iDQS+vP3mfGWFCyDxe8eTkuXeQYJ1Uc
         O4EScNvBNhN3YT18F8xm+2XHsNnq8u8fhDEudXEoBE45pazQzdd61CHeX5tNhM1sMCPn
         sxMg==
X-Forwarded-Encrypted: i=1; AJvYcCX2tnet1vFZIfhZat4FOvM7sPV7fozt809SNyvOk80A3nKy0V3Gpb8ABArMy8cv9Ae67vDbwKsjMMjQEQY9VHqojf3e
X-Gm-Message-State: AOJu0Yxe2TWZYoeauhDrFHVpWiL56M/on45ts/ZRaeYDMH77kLV3HFt/
	nrXDJFplZuyOEb5V6eLc9UpYUlbI2ysRsROS65fC5e5C5Wf/KEGX
X-Google-Smtp-Source: AGHT+IEq/a6Y5MxOVxWGot/0Sfeixq/AltXFC9NpufWOaRj6pwleCxOF+iyVmbXTfONc4wBdzC8pQw==
X-Received: by 2002:a17:906:341a:b0:a58:ed1d:93e4 with SMTP id c26-20020a170906341a00b00a58ed1d93e4mr1344489ejb.65.1714740084123;
        Fri, 03 May 2024 05:41:24 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id ot38-20020a170906cce600b00a5994c5c948sm533323ejb.133.2024.05.03.05.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 05:41:23 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v6 6/7] refs: rename `refs_create_symref()` to `refs_update_symref()`
Date: Fri,  3 May 2024 14:41:14 +0200
Message-ID: <20240503124115.252413-7-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503124115.252413-1-knayak@gitlab.com>
References: <20240501202229.2695774-1-knayak@gitlab.com>
 <20240503124115.252413-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The `refs_create_symref()` function is used to update/create a symref.
But it doesn't check the old target of the symref, if existing. It force
updates the symref. In this regard, the name `refs_create_symref()` is a
bit misleading. So let's rename it to `refs_update_symref()`. This is
akin to how 'git-update-ref(1)' also allows us to create apart from
update.

While we're here, rename the arguments in the function to clarify what
they actually signify and reduce confusion.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c          |  2 +-
 builtin/worktree.c        |  2 +-
 refs.c                    | 12 +++++-------
 refs.h                    |  2 +-
 t/helper/test-ref-store.c |  2 +-
 5 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index dd3e3a7dc0..4491f7a20c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -555,7 +555,7 @@ static int replace_each_worktree_head_symref(struct worktree **worktrees,
 			continue;
 
 		refs = get_worktree_ref_store(worktrees[i]);
-		if (refs_create_symref(refs, "HEAD", newref, logmsg))
+		if (refs_update_symref(refs, "HEAD", newref, logmsg))
 			ret = error(_("HEAD of working tree %s is not updated"),
 				    worktrees[i]->path);
 	}
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7c6c72536b..480202c517 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -517,7 +517,7 @@ static int add_worktree(const char *path, const char *refname,
 		ret = refs_update_ref(wt_refs, NULL, "HEAD", &commit->object.oid,
 				      NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 	else
-		ret = refs_create_symref(wt_refs, "HEAD", symref.buf, NULL);
+		ret = refs_update_symref(wt_refs, "HEAD", symref.buf, NULL);
 	if (ret)
 		goto done;
 
diff --git a/refs.c b/refs.c
index 195861b09b..3645b805c1 100644
--- a/refs.c
+++ b/refs.c
@@ -2284,10 +2284,8 @@ int peel_iterated_oid(const struct object_id *base, struct object_id *peeled)
 	return peel_object(base, peeled) ? -1 : 0;
 }
 
-int refs_create_symref(struct ref_store *refs,
-		       const char *ref_target,
-		       const char *refs_heads_master,
-		       const char *logmsg)
+int refs_update_symref(struct ref_store *refs, const char *ref,
+		       const char *target, const char *logmsg)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
@@ -2295,8 +2293,8 @@ int refs_create_symref(struct ref_store *refs,
 
 	transaction = ref_store_transaction_begin(refs, &err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref_target, NULL, NULL,
-				   refs_heads_master, NULL, REF_NO_DEREF,
+	    ref_transaction_update(transaction, ref, NULL, NULL,
+				   target, NULL, REF_NO_DEREF,
 				   logmsg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ret = error("%s", err.buf);
@@ -2312,7 +2310,7 @@ int refs_create_symref(struct ref_store *refs,
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
-	return refs_create_symref(get_main_ref_store(the_repository), ref_target,
+	return refs_update_symref(get_main_ref_store(the_repository), ref_target,
 				  refs_heads_master, logmsg);
 }
 
diff --git a/refs.h b/refs.h
index c7851bf587..71cc1c58e0 100644
--- a/refs.h
+++ b/refs.h
@@ -606,7 +606,7 @@ int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
 int copy_existing_ref(const char *oldref, const char *newref,
 			const char *logmsg);
 
-int refs_create_symref(struct ref_store *refs, const char *refname,
+int refs_update_symref(struct ref_store *refs, const char *refname,
 		       const char *target, const char *logmsg);
 int create_symref(const char *refname, const char *target, const char *logmsg);
 
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 82bbf6e2e6..4651e4ced7 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -118,7 +118,7 @@ static int cmd_create_symref(struct ref_store *refs, const char **argv)
 	const char *target = notnull(*argv++, "target");
 	const char *logmsg = *argv++;
 
-	return refs_create_symref(refs, refname, target, logmsg);
+	return refs_update_symref(refs, refname, target, logmsg);
 }
 
 static struct flag_definition transaction_flags[] = {
-- 
2.43.GIT

