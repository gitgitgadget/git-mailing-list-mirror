Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B457C274FDF
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771493912; cv=none; b=qYvxkup7RnTofZqksLQIFMfNbkx2BtmqZuvvkkKYd8PqR+ZQ+/L5UbZrJSuLHe9hmZOhhV5MTMA17952MVjZ79xxI3tClQ2HtMrvtxinfjGnia2qV2SjYIl+SqqymJe0FxHDRL5NxHLNpynNNv39E7pHF2oDCOfJ20wKPZfalCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771493912; c=relaxed/simple;
	bh=2WBfOmh9GZyMbYc41valBaoZ0O5SEiYwLw6sFB0DklE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tgzRKgLMurIvcQiyNHwPwj2GTNVtRLTokwNqLto24hOftHOBE2G9FoqBW9I01CNZMiQ4mvexyUiORbs4vhlnCjUqXQqklFtSatPn4gN4TPgjmF8Vl6Kv2gce/KeLjl31eYT2AZ6bD7p6WtnZ7qLIMb6LeU0XETtqxK+UDpft0SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZYlGEoz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZYlGEoz"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so7502435e9.2
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 01:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771493909; x=1772098709; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EPdz894sob7TcykBB6/DWBN2kZgN+dR/0aJEdqfNaM=;
        b=bZYlGEozXxj9xQIvK7smllfOSzxlCKK86zIY0Xd5yP6XdDQkMZVvh31T3eA6yuAVuE
         9mpH4+2g15JD5yocFlIWKGOEg7VBxsSYreoiGC0CBDT9DaBMPxwf0lIJMvh1ypC61Gd9
         ljq/zA7HYP+VN2G/a0bmKxFKHZMq4ifm9dgLCNu6zrpzx3dFLOHGRJM3eZloe3T2it1y
         dEOGjLwCkbbKIs38EEVnshsr/DAdiVq+4xdcPgbWBek+Ny28LjdnCczZvGY9kxpt7jja
         crL6F586yRjm5AsAZ0SdGbMUh4rsRCeuC8jTLPdv4vbQG8oX+0IPqZ2Ui1P4Pggz+yKl
         U1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771493909; x=1772098709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9EPdz894sob7TcykBB6/DWBN2kZgN+dR/0aJEdqfNaM=;
        b=B6LAvaZKudiWIKMaUeMPQh+otVFfZ5WrxXAjXEDxoXT5k4a0mPiTRiOfwNHoZFI//U
         vCqv9ODgBHomHcP+sO8WxX0ofS2BF9gT4aa1IiLrmN5dHn/8A5FMfY/YnMjD4dL4llHU
         Ar/7OCOj/di1FScHrXXnEJilh6FDPQt9z3Lx0O40MLawYpRsj0zOy2WmNI3SawEe/4iJ
         Ybx6SGBvBnSnpm9zyg3qFIUOl5Lx9cwhMbhmydfxgZYdzqA1uBqsszASKtQUC291Foit
         Uw/TaeVL/+qVJduA9nu/F7S0vw/+6raH2cyw7oGb3m+nYXkcpXA7l5GV7K+KVKk76Ja/
         t0bQ==
X-Gm-Message-State: AOJu0YwXEg4wwNtHTWcuSzoensPQJDQA6LfpZ6+GNLvojwmhpp8YY8dN
	LU4Yy82QZ9HJDQ7/RMGObCvoD5FH/TXWCNkRYJXuPlXYC0XUjvBv4/0t
X-Gm-Gg: AZuq6aLi2fLx8sa4W4QhYofAgpM06+Wggn1r9GwnEg0kDBZrh6mUZbwlwxEYqLP19NT
	XjzpkJgEIgTE8G4IlpTUVfgLmTLEIBFjfhE7aKDFWFF7u9O4Rm4slj3h+NjYKEssqI4YonY0Dr4
	F7z43IU4bSeoVvjDR8VyCtd+0PCaL7+SmsVV5nuTN8Cojxzv7HiZZWwXAjYaEOHVJjjcTTNnwji
	etcMsF0QeydhTe244S7atMk1kSaKmuhUBdODJwTJF6TlkyFKBtOPrAtfzuwiaDLDNI4RTJEAGkD
	64zEiSR/LCLrh8SpuAMpFCUlfmUZrMEv2HWfnACeX4Vyeil6cmU7n11/4YfCq+WNpzk6nx5xuuW
	gEkabiQ3cj4vOGk9HuXtdad0+Cr++OYGZ/De0wmdWaGGQIE6Rt34othvjKT9/kvFRF/R0RDLBGj
	+5/meQ1YdD5wJshceX6CkB5zHa1FRvAikq5d7RkxOi
X-Received: by 2002:a05:600c:3110:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-48398b6e4f7mr72736295e9.28.1771493908995;
        Thu, 19 Feb 2026 01:38:28 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1ea7:2b8f:9148:411a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd34sm694274985e9.7.2026.02.19.01.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 01:38:28 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 19 Feb 2026 10:38:20 +0100
Subject: [PATCH v7 1/6] setup: don't modify repo in
 `create_reference_database()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-kn-alternate-ref-dir-v7-1-16f27860dbdf@gmail.com>
References: <20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com>
In-Reply-To: <20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 toon@iotcl.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3529; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=2WBfOmh9GZyMbYc41valBaoZ0O5SEiYwLw6sFB0DklE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmW2hKWSrppFXmKP9P1Y1hrj9Ci73/BeD7ve
 6b4KK9sM2U4iIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpltoSAAoJED7VnySO
 Rox/qV8L/30F6AYgDmRmAxGrzDgyEXVRP6bud0I44uqynb0VFSccwjXtbihz3l54BCFixL1XHvi
 00idVZsjvqcb+eV28qTiFqA3Y5TpW3c8aK5DtJy8mE/e38OReGDQo2k6nQP/Dazogy1qyfes3FM
 Vtsh1oqHi5ohDzZNJRZudyw0LVUW1gy71OMr+cTzyOJ0XcQmRwXKx5L3oeiQXd+YjUYw43CakYf
 3xAX4fcSu0vDYfEULpnLhyqTRUl+P8eRQyy7sdcPUw8o8T3qFXhaa27/z4A/AsKpZhV1r5DmQBF
 cDvWbARTjwZVQJtJKsyWsl/+DFXu1zbC25F6GrxkV80qM31bcDDummsnLpyfghis/teyi0yxFIq
 UeWnE1/9Re/tp/n3pQusJ1j9eOTlJ2L8E/aD9a/wtPERI0Z6cOKhvOuxY+1SkZKONEnxsUerWKY
 cdt8x6MzvNAWKZ/nG6GBtaS1Y2NlctQt/PnDO6WQZaaW0y+x4psDTKwSrxlDDBFCkvNonEs5nY4
 fY=
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

