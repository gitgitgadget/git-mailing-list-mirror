Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD021CAA6C
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012452; cv=none; b=PSPNShqYZnJznJcxHh1HoYBLc3p0VdaOdtRRhe3sTKv/yud6ODXFVpJwQ1YJIkupxAW/2XS3P+g/fe4swxQrBvmXKpjOoRmppUrcuDGkXJyEX29W/JiMOrcyM4GZrwE7dhDgy/mNjmJvTfvBEfrU0KKEdAZ2RJ3BJlfzuNZSD4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012452; c=relaxed/simple;
	bh=2WBfOmh9GZyMbYc41valBaoZ0O5SEiYwLw6sFB0DklE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oKKg1NdMULXd1IzLfEGri6SkbFdCs+QxAj9E5hm66VP9fCBte0erB8XWA3nezpE7BGD5MlmUDTIzrIWRzEZMTmU2A+P+Q/jH1WUSkO8qPqhov/6Qukr21w43MgAK6hBk6kSxU8YL+ELY6NHD1d+T9NB4IevyLZ7gxLbb3GU/7fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koFXa821; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koFXa821"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso55984755e9.3
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 01:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772012449; x=1772617249; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EPdz894sob7TcykBB6/DWBN2kZgN+dR/0aJEdqfNaM=;
        b=koFXa821yzsuPuDvTke0utCJXNozHSUTK3ihoFVx1z1M8RDGBU01d6NZ5EMJBtJLn3
         0lTJ/7unYsTDNQdi6d/2GP78ecVaahn5vt+bEZM4zOZWIhKCCJu57v6jE4z1MPAX80dl
         2ajxMpLYaCZQKEYoYtL2hxu/fBv0MYzqR1QjsEzHxAXhiz5NNeBF1Xggwb/qfS4VzM01
         AOfX/vtGCOft9vUlh/46XnlGDYCveFGFLOAU8Tew/19zNLbn912D4XWhNLfigH34QVyx
         bo2giqSGSp7FD6cGH8UxGMsuhpT8GVAGSO9vAalUAZJIcDmNQQoVctxBYL8s7+HVfhWq
         ykxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772012449; x=1772617249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9EPdz894sob7TcykBB6/DWBN2kZgN+dR/0aJEdqfNaM=;
        b=XRzRsr57RG4BGTpMHzNJUKqFt5IRCc5XE/ObGc6gM7NA6eDY1Yu4aZKNp2mZ/SwhvF
         ShwuHG55Gjn9/FKXe6zzeTuimTZ+qjHwR57mNsT7ASs5PZLVQ453VZCSlIdvfdAx72F5
         kFdEXzAFk1RDgulO9MhOsUAPtPl5LAmbHSkQ/iyOIm4F59iL7cm1wE6PV8RlKVtDaBlt
         6mU7nh+ERrOeqlMkycljQE2PyHZGTgtlMIU6e4ANSQPWcJCcWmns1qL1Q8ZC8P/NoUuJ
         fs7qaDF8D9Buf22WEdoEAAHAYvh4PHlGTxAhsgdhlXd5wZNDYMWEX+Cy7bbU90/Y2aua
         kITA==
X-Gm-Message-State: AOJu0Yy9wiUggL0vzKOl8aYcRsVYn+v/ljcafzLcz1Dx6pNZ51pdZYhA
	vFil2wuU9nqb7g05qdbKEMPewUqXbUNKobcZUQfsKWwmbTk41Aqsvpqv
X-Gm-Gg: ATEYQzyWm2F4i0t5OwVMmP3zUhbsrcm0TcnyjqMqH9GCcx23Qqc6Qh+gtQgpjv7LRxE
	/wCAaQ5e4GZTjcXlRuYAIbF8IDPFpCpHJkVJ2tnV6lh8dA1m6jfdvVdCMl0xaWv0F9ioq4yl+os
	UDconOPScKPIZ0UpWfSStNAQk1X9jBj0icnw28Djpzkb1Sk3sLx4ImC3HCNSArBSX8VQrA14TJl
	ufDRKgEdB7P7ROPL+Eb6OPh0kmtF78o+0FaekbzM1BUH4f8P93dqn+QbZpZYMgshqNO87ZgD0Bh
	DadDx5NNOcAsQnuW8X1m8Ql9dTbmYUh6n0geaCCyxKqG7mjagXyqUrqYcBlVOh+zC9ZjCLkCW6B
	BSYDtYMv8H4dczxv1af1nwRxssrKiGFDD0Nd5wC8/fjuQpa5fC0x5/RGA8vkciddLhnHD8zT+nY
	PKL5R9fm4hwAuaFa3yfs/4e7kycZ66s60=
X-Received: by 2002:a05:600c:154b:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-483a962e38bmr239490655e9.21.1772012448876;
        Wed, 25 Feb 2026 01:40:48 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:d32e:ae2b:c73c:65c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bffc17dasm12956025e9.2.2026.02.25.01.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:40:47 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 25 Feb 2026 10:40:41 +0100
Subject: [PATCH v9 1/6] setup: don't modify repo in
 `create_reference_database()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-kn-alternate-ref-dir-v9-1-3fe118e40e28@gmail.com>
References: <20260225-kn-alternate-ref-dir-v9-0-3fe118e40e28@gmail.com>
In-Reply-To: <20260225-kn-alternate-ref-dir-v9-0-3fe118e40e28@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3529; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=2WBfOmh9GZyMbYc41valBaoZ0O5SEiYwLw6sFB0DklE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmew5yvq1cLnBmiD0mj+hN6ooUF3n3L2Dn66
 BDNmabQqbsrtYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpnsOcAAoJED7VnySO
 Rox/+e4L/1dDTyeuzh+glNBh313Hj4gKO3t8/e5h+MyCrny8Du3+olSJRMpFuRwM09NDDflfulY
 XTwBdKT02ARJfbAoUkgIH2I7i9FuvNhaAg/Gsl81flAuur75W+VblcpDXW38BAE4R/3f2LP38T5
 3FcdKGFxUvKteGAI7nXt6mj17muwsEojN5wdfSQXWupJgr+KnWqdHWagM54P5iE+jqBvKfKCr/1
 QsIDG6zPeJS4a6xLXbwlzARwXVRMkgZ6dTGo78yH7rNsMjQalXUgYdZA2tW0LHOtd2iHQiUsrwo
 jV0nmKCEOO/Yv3GcHddEpasbQJqnyd2j5445Ov5eIUAH0t6+iwWweEe2d9HyfdvJIrn2ZcS9jJE
 +dWida9+ODtcCSGBFHwotbIn3w0ssWj19T40bMmdKbuXRuHK9V8gNM6PTk83aLWNxtBsBXfLB3t
 6OVPKt6mk8WI675EKsRIsFsuawW4p+AEbdDSE9AYva6xDWMj9sfMN2iruIL7420IRkdPWlTwxX7
 sA=
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

