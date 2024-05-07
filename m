Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42D46E602
	for <git@vger.kernel.org>; Tue,  7 May 2024 06:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061654; cv=none; b=uTbaedFPoskIMOAxSFrQ9X4DnlxS0N7osD3/wKFx8sEm5ykaxg1HmDaydZAxZE+MvMggpj7CcLiXy2IelYnR/0Mh9g/d6d6ZaqcxQRlZnKkLOZ7ijzozwpPIMbOW25GDuXHyK3kWr5Jg96zgPrDMH7Eizr+x+VfmuHajgfm+c0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061654; c=relaxed/simple;
	bh=3i+z22tQX0RBr2pB4FYZcAHrbEHQnK24jJl96zwKs8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q35APmGc+6ij3ZGrGDRBaCgpCwHxDMoBnAFZsRiFYvx6vRk2aBqO5eOoCTwvxpuMHyN3tn3EblD3KtxSDPBxY25YwTztSGYPFOKKP02XCA5V+OXR06sjc6lDXDVXMKXFCixpNhUs0EALdEPHPCFaVoLevO0jlLrShz0ZXMIxrKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqD6e3e/; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqD6e3e/"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4702457ccbso675083666b.3
        for <git@vger.kernel.org>; Mon, 06 May 2024 23:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715061651; x=1715666451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzjnaJrDthg0F1Wv35QQl2XaWNLJzwznwprWuLwXgeM=;
        b=lqD6e3e/P7kbZB2SrNvstLwHeVVRBcjaG6RG2TLwKQYF62SDT122gUX+xQwiTIt5iI
         KUQhBeWvVdOICQpqcJ5VLiA5DmsbCVQHS6pYWaJ7J8igZiK/AaEvOVtdNTSxM482t7Kw
         jPJZ5yXSo9gOsTXbPeOU9aAXjEeCcr5ha57UldyNApTPyr/yzNgrrTG29ZfceKkhx+24
         6zKNwwIdtFI/xXeLa/yT4LyfKb6dT7sYHc3tHr9fKNoN6aQSiuN2yYyhJXSxnU7W6fcZ
         5TAvecSrC55j7kA/6wyr3YdhAEtzbVfvK6finu4p8+eShpTyerPPN2HKmdsygDRghGN1
         QHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715061651; x=1715666451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzjnaJrDthg0F1Wv35QQl2XaWNLJzwznwprWuLwXgeM=;
        b=NRL0mSkbeDM/AuDZt/5PXukNr/LVnEprVuzIp8nEXxPGmW9sYCFE9jwCovCpZ9Hb1l
         xYGTFRjFrSiEokPkrhlEy/iH35HqIlui8zz8uB1mMNFSlKxXJgKBJasi/8OcYmNq9BGy
         7t0oB+2ou/4iNJKmdAhUBf94wES3e0Fab63Sbi6EjtpH/7rqeU2u5wp2kHZrc9Zp4qWS
         AUEddK5F/8UtDvk4ahwxGAHGiK8KBEhUwmw74OcmRC9qIoXukriqJLa7RFiF+Asx0Op4
         xsNaTj7DrDwqg9fGB7IvbDHy2hA4iWoeXF5+afWZvxZ2sYoRbRjrJGPBWxAZTclxBHpR
         In+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXedSgvGnAtXS+uDPUqBEXcr0VgZ1P+4yTKV4LyTap7zyujZmn/lt2I7Kir9CHyvrWUQVDzHmCAhZ4KJYeSDV9SEfHU
X-Gm-Message-State: AOJu0YxN9mpL9p/iQ82OWSLjEhJ6J0jPtWgnPqUwL2dObH7dAvk0Gvw1
	dFCl6XiUz/wJ7FBNyMkWIk2b5B01GTNOtFQfHtC565KPFajFAj7K
X-Google-Smtp-Source: AGHT+IGgQVw8W1tny20B6z71uQEILr0lgB0FW5X+YcieveRaNP6QbpHOeRtQ7h/rvtT2KdaI9PGW8A==
X-Received: by 2002:a17:906:730d:b0:a59:c52b:9937 with SMTP id di13-20020a170906730d00b00a59c52b9937mr4208011ejc.4.1715061650964;
        Mon, 06 May 2024 23:00:50 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1aa1:adf2:4cd1:ebdc])
        by smtp.gmail.com with ESMTPSA id y27-20020a1709060a9b00b00a59baca79basm3066691ejf.60.2024.05.06.23.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 23:00:50 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH v7 7/8] refs: rename `refs_create_symref()` to `refs_update_symref()`
Date: Tue,  7 May 2024 08:00:34 +0200
Message-ID: <20240507060035.28602-8-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507060035.28602-1-knayak@gitlab.com>
References: <20240503124115.252413-1-knayak@gitlab.com>
 <20240507060035.28602-1-knayak@gitlab.com>
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
index 7a693dbcfb..85f53a2cbe 100644
--- a/refs.c
+++ b/refs.c
@@ -2300,10 +2300,8 @@ int peel_iterated_oid(const struct object_id *base, struct object_id *peeled)
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
@@ -2311,8 +2309,8 @@ int refs_create_symref(struct ref_store *refs,
 
 	transaction = ref_store_transaction_begin(refs, &err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref_target, NULL, NULL,
-				   refs_heads_master, NULL, REF_NO_DEREF,
+	    ref_transaction_update(transaction, ref, NULL, NULL,
+				   target, NULL, REF_NO_DEREF,
 				   logmsg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ret = error("%s", err.buf);
@@ -2328,7 +2326,7 @@ int refs_create_symref(struct ref_store *refs,
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
-	return refs_create_symref(get_main_ref_store(the_repository), ref_target,
+	return refs_update_symref(get_main_ref_store(the_repository), ref_target,
 				  refs_heads_master, logmsg);
 }
 
diff --git a/refs.h b/refs.h
index 9abbfd35a2..7c69e8cc0d 100644
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

