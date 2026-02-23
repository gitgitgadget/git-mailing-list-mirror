Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED4634A3C5
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771833709; cv=none; b=BkiNS7a4jcUTO7TEfttx5ErpUC2Lbg3cvZXZiAOvLaLFEEUOUS5MRYyAJoU1HiDAagKhZI8QlwLU/5gJAu/eKAnZl+Xi+4JfXAJHRaN+7c3tnjRu9rdLXJPl7eeXEB/+y55f0Xl47waZYgilUswWUXOIGNX6XoizVTO4txi6xoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771833709; c=relaxed/simple;
	bh=2WBfOmh9GZyMbYc41valBaoZ0O5SEiYwLw6sFB0DklE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l0pNHV5dcQUZVXbToDiYqYsXH54PVAzCoLOt5cmrE84WYmaX10dDbhqf7mpN43zg5xeK9g20AiLNnSHutHV3m6qEa86TPPhOSvjZb7lPrb0Dky0SV9EM+Fr2oB71/dwQsghg/kfzwSltsvT0N/8q9DNvvcTBBwsn+FYQA1keL1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SESg1rJ3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SESg1rJ3"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso33820635e9.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771833706; x=1772438506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EPdz894sob7TcykBB6/DWBN2kZgN+dR/0aJEdqfNaM=;
        b=SESg1rJ3aNQri3+KbeKrPajrSQ8cTKLFaCKim/0clTC5nbXn04A846E04XjSwEb6E5
         ISAxgMMqnGNXV1Wcgu0cawBi6Mo7lm5INaDkCtf74QzAsXHnKUImzI8/blky7D/O/o+r
         SSphf2HXQEuqLpkpZjVyscf/Koj3ECHaliGKsCSCQ7SHxgqOaxHLgrMIPwclM20LuDen
         m1JhPZvRInSwnrkG0DnaRj8Z9BQrGygtOmE/zN+WDrduJBM3Q7mVksyWbeToMVpP926f
         x42tJJhmcpwKIrb9TWrwSESLdv2QQrkbLSqaphC4jzJMjAfg8EyUGfiZK8Z0LJCNi9Fi
         9IvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771833706; x=1772438506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9EPdz894sob7TcykBB6/DWBN2kZgN+dR/0aJEdqfNaM=;
        b=kKkwTlSdqfKgrNRrSviUHBGEKaezlHL3vnRDjKx15RiMN3O70mLfvAF7uHrGwgFjKq
         XtXAXX9TbvfdDqaKHAb2a6sEQCjSLftC+CIQyeZyW4tiVF4SJhbxUI8Vm0ueKbfdHjQ3
         ka5ElHjupD+9RKbSiCtrvHb1u9YcOjSQVBPT08KGOIf6Jpkb6Iw7SO5lmcYyihhM9UgM
         l6ZKorFpr3Rv878y/58iJgBeeXrkY8rNELs5kpggfQ9PQ0vKuGZ8b4PLAVc5ErFfd5CC
         LQenlG+GmVryGEFcpyxtCtUBXl8B57j63jMdHsOPupC2cyB2DfPw5DNF7qCa95BVpFAZ
         6BMA==
X-Gm-Message-State: AOJu0YzPKeTbh8PHz2bMGspG2C2EphICTCLcpQepIemBLZzA0kTwBc6h
	iVWCeHB3bkZ9luueVoJbDA2Ig2U/GRLaBtLiryN0hrLvsV4qY7PdeMq+VgEnRfOX
X-Gm-Gg: AZuq6aJC2HGoFZ978Um85cm5aYoqILSam82G7gBsGiLItTNTPJ3wViz40ZWBYa2KCRx
	7XpbG5nwCb0bFH7dJsGbK5WzrWxOapsKogrA/9xIMBcdVtDX5XPxBQ0NYC+W9JWzHPwEgHHBfZ3
	sRwFNCdbmqFGbiPiFUn24Q3M4FRHkfAw75PRZ4kjdJmPUVYs+M+ZnumJ9r/n7V1IqLhA5awE3W2
	biBbsOx8eYR9wdpNnS8iM/L7punoM1j6EHtPsf1cJRz6RcWMLCkNm6F23UmgTJNaEzamOMiPGia
	JfHKpj6/0K72gBWyKKm/mnv9cVb/xEQ8wkHCiOV6wsIscUFN2i0m77z/JAlIQWiNZ9kvmZ6EqG8
	a6trLRZZ1f7Ob2OFkw6i/aVNBr74e3rZaH3UbXj+WjR3I/ikXO+NB1TGvLzXWXzLvJvO18G7LOd
	SpAK/5Ycq+Bk1tdqmdKdxZqb3cvA2Xauo=
X-Received: by 2002:a05:600c:1e09:b0:480:25ae:9993 with SMTP id 5b1f17b1804b1-483a962e3c9mr137554765e9.20.1771833705580;
        Mon, 23 Feb 2026 00:01:45 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:f529:6f94:a480:7bd4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3db3369sm117333775e9.0.2026.02.23.00.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:01:45 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 23 Feb 2026 09:01:36 +0100
Subject: [PATCH v8 1/6] setup: don't modify repo in
 `create_reference_database()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-kn-alternate-ref-dir-v8-1-0509c132a203@gmail.com>
References: <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
In-Reply-To: <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3529; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=2WBfOmh9GZyMbYc41valBaoZ0O5SEiYwLw6sFB0DklE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmcCWYynt7eL/v0rYjlSJ0irqL4p1lADpVz4
 ypbE3dpZEEa1okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpnAlmAAoJED7VnySO
 Rox/bPcL/R2t03qMcNu0TR3+NpgIuG4BVZ50H6h8O4mJoATj9JFiIN7OkN70RwF4IoSHRzw8icc
 YIGcPcAPLG9m2wuwTfDtWsm/CsWLcvgTr8CF+EFrtljTXbBkFIUgMkyGpIXUBpD/q5qanVuapIZ
 tWK01PEq9dOvZjqQSY2ANwB5SmezXz8KvnieXMwPPP16uAsP3EYuxaQ7+xxTrSIIMAd9BFHJemJ
 +OOTKuVSBgK44T9aseEEqODBU7okrmFpvvGeeruHHgKy3CWZ7QNrNzWTpk2yJwRogNZStxG7KhX
 K6tjkERK4YBJ6JuAjOiNnwlzVg/SFXXQLyZbYvONuw+hCQNzsDvGtr5B0gYIPL0nbkRXGHXbIrF
 uXA2DYxAOlt7MRS61Ag+JD41lXofwjPmWfor6wvgxzH0gryY35/qSzjs4VQ2aHvltKrq1pJk4vM
 cdpBvaoO00NOTdcMJFIfG5MgOYYDw9AZgqlbTFgcpQAUYFEIWBA3vKMy1APK0BmxNTnhAvk1c04
 Mc=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `create_reference_database()` function is used to create the
reference database during initialization of a repository. The function
calls `repo_set_ref_storage_format()` to set the repositories reference
format. This is an unexpected side-effect of the function. More so
because the function is only called in two locations:

  1. During git-init(1) where the value is propagated from the `struct
     repository_format repo_fmt` value.

  2. During git-clone(1) where the value is propagated from the
     `the_repository` value.

The former is valid, however the flow already calls
`repo_set_ref_storage_format()`, so this effort is simply duplicated.
The latter sets the existing value in `the_repository` back to itself.
While this is okay for now, introduction of more fields in
`repo_set_ref_storage_format()` would cause issues, especially
dynamically allocated strings, where we would free/allocate the same
string back into `the_repostiory`.

To avoid all this confusion, clean up the function to no longer take in
and set the repo's reference storage format.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/clone.c | 2 +-
 setup.c         | 7 ++-----
 setup.h         | 3 +--
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b40cee5968..cd43bb5aa2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1442,7 +1442,7 @@ int cmd_clone(int argc,
 	hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 	initialize_repository_version(hash_algo, the_repository->ref_storage_format, 1);
 	repo_set_hash_algo(the_repository, hash_algo);
-	create_reference_database(the_repository->ref_storage_format, NULL, 1);
+	create_reference_database(NULL, 1);
 
 	/*
 	 * Before fetching from the remote, download and install bundle
diff --git a/setup.c b/setup.c
index b723f8b339..1fc9ae3872 100644
--- a/setup.c
+++ b/setup.c
@@ -2359,14 +2359,12 @@ static int is_reinit(void)
 	return ret;
 }
 
-void create_reference_database(enum ref_storage_format ref_storage_format,
-			       const char *initial_branch, int quiet)
+void create_reference_database(const char *initial_branch, int quiet)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *to_free = NULL;
 	int reinit = is_reinit();
 
-	repo_set_ref_storage_format(the_repository, ref_storage_format);
 	if (ref_store_create_on_disk(get_main_ref_store(the_repository), 0, &err))
 		die("failed to set up refs db: %s", err.buf);
 
@@ -2701,8 +2699,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 				      &repo_fmt, init_shared_repository);
 
 	if (!(flags & INIT_DB_SKIP_REFDB))
-		create_reference_database(repo_fmt.ref_storage_format,
-					  initial_branch, flags & INIT_DB_QUIET);
+		create_reference_database(initial_branch, flags & INIT_DB_QUIET);
 	create_object_directory();
 
 	if (repo_settings_get_shared_repository(the_repository)) {
diff --git a/setup.h b/setup.h
index d55dcc6608..ddb9f6701c 100644
--- a/setup.h
+++ b/setup.h
@@ -240,8 +240,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 void initialize_repository_version(int hash_algo,
 				   enum ref_storage_format ref_storage_format,
 				   int reinit);
-void create_reference_database(enum ref_storage_format ref_storage_format,
-			       const char *initial_branch, int quiet);
+void create_reference_database(const char *initial_branch, int quiet);
 
 /*
  * NOTE NOTE NOTE!!

-- 
2.53.GIT

