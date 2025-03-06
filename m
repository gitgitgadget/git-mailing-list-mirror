Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF5417BEBF
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271815; cv=none; b=K7RDP0v8Cxpb4PYyhJZEM2AqeCZTZlD2fJ/sMzT9VA+9OSSwJuGFXjR6jh3LtMaBt/qumhinu6DETvRrj7v+9eW8T5BSFXWEQxHQrhSAlQxAJaJHWl9tq67lTPJPzu+pX2u0FDGrv48+PoqLGGt4YTH1ip1y9YBhXSONbHyqRY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271815; c=relaxed/simple;
	bh=XTJrwl6lGzYH/UD6p2YmKN1G1LrAG9X5uWXZIigQmz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8A8g39tG0YtH+g1U7GVsqM7f8g5htcehYJ593fG3Wp1ST2r8EpzgY6npaoF1YAoqciebV5lMKEf2n8vj5JwxsWc5Fsb0Ukn20UwJDT8ZJJBEvpHbLqpb9uUSL3/pNdUsJWZA9/kOF1QlJJ+a85OprvLAt7VXvQxWmPXofIEw9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CogmgyFB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CogmgyFB"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so1202052a91.2
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 06:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741271812; x=1741876612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odxIt6J5cAejMWvEFPdbwTynWI7WHeWNfI/TInK4QPk=;
        b=CogmgyFB9o3H622DZGFqek9QXbBs7KiQZRZAiTFPzQCyUHuV+HlFjPfPyRzNfvKD6u
         NrWtNYiBl4GZmmc+IvMkZPeCYwwq1ZDSjkc6PXv0Xx7afrWb0J61kIvHQR0lg0X/Bise
         Nny4BviBkdk9WbEOVNqbxjLeGMKTouU2EfDowMihAOtwNqNQbfrS+MyPwo2MFxXJvjC7
         cskPDcOd/14oiBjrzRtoitjkOeHA52HEEr6W9TchWy4nhNQz2oObekPFqW+by5px7bST
         PLIlK9PuXC6qtLnLTNIETtWEWjI/IpYulY0hHEziXW7vDNRjtQULKl5TySweYp3nw+2E
         iX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741271812; x=1741876612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odxIt6J5cAejMWvEFPdbwTynWI7WHeWNfI/TInK4QPk=;
        b=omcDH5Tx0+IKJdqFoJj3ikCHWcS1Xroyh7L59UeeSmRm8jYr0+sMyrcJMi3o1gcEXs
         JSckznzC6IUBCWGj+VchXaNvrjQ60Fjj9nTGBFGPjtgQHmPK5WE8FYM1V/deM3i9ccfA
         mWo9JcbSoaZspl934VR+pbV0d6L3hBkcTNFTlCbzUAtkzyKD0KmtZH+/99D1Mr2Q/jYz
         NX/QZ3S4CBRDD+eAAiC3ttzz1CKvGCMwAU2N2WIfZmgHZ3DMp0+DGzsB6M8O5i0+T148
         vTrWQYETWmFWqAiNa3koLLxdPPv9JsjPIHQ7KZuwZBrc5IVfUb3PT5wM8thZ9gtGhe4D
         Gchw==
X-Gm-Message-State: AOJu0YwOY8z0hz4+3b/q/VVgX78X6hUq/sxNRs3eu1khYLleZ402WPTn
	AaKjgahefGI9GGQRv9vE1TuI00R8Ris9GFwfP1ovpWdtfVoQvsRpHAZnowvU
X-Gm-Gg: ASbGnctsKow4/dM0595MzczuRL+AcY7xFteyXKIDnl4YA3v7cLc80C2Gw61ezKPjMXu
	PVrCuKAtkGJHbd/1FwbHYEYbSV/K/yRXfVpXZKfSf0/Adrx1Zjg9a2TdK+Jqg1ijhUlXyiGyqVp
	kjVSQ6Eaze8pnw35w3RewMRXxN2jz6Bpjp5rFRPX7zvz28+RhMHOR9B2hnHR8Cg9ZZL9snZ4L51
	kGxsNHQjK0m256NFD/7gs5Um38KX0zv+RmxK6nHdOI7i+oetYopeHT8H5Bkgg/ugEhP2R/2HcNS
	fmUEjmdz3bL6jcZ1NMKEEHxeefpFJl1T5xE9JJ4aOwXDfC2JKuWon8cfBC2w67n6381zGw==
X-Google-Smtp-Source: AGHT+IHt0HvJ5M+fW0qF0nIKC7Chrm/H/Nk6f8KvYdST1QQ/j5GgfcfBS0T0+uRgnGuDJeg6A/c6nw==
X-Received: by 2002:a17:90b:38c4:b0:2ff:693a:758d with SMTP id 98e67ed59e1d1-2ff693a76a4mr3558142a91.27.1741271811484;
        Thu, 06 Mar 2025 06:36:51 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ff944sm3561184a91.34.2025.03.06.06.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:36:51 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 5/8] builtin/pack-refs: stop using `the_repository`
Date: Thu,  6 Mar 2025 20:05:49 +0530
Message-ID: <20250306143629.1267358-6-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
References: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
 <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/pack-refs.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_pack_refs()` function with `repo` set
to NULL and then early in the function, `parse_options()` call will give
the options help and exit.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/pack-refs.c        | 8 +++-----
 t/t0610-reftable-basics.sh | 7 +++++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 4fdd68880e..e47bae1c80 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
@@ -15,7 +13,7 @@ static char const * const pack_refs_usage[] = {
 int cmd_pack_refs(int argc,
 		  const char **argv,
 		  const char *prefix,
-		  struct repository *repo UNUSED)
+		  struct repository *repo)
 {
 	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
 	struct string_list included_refs = STRING_LIST_INIT_NODUP;
@@ -39,7 +37,7 @@ int cmd_pack_refs(int argc,
 			N_("references to exclude")),
 		OPT_END(),
 	};
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
 
@@ -52,7 +50,7 @@ int cmd_pack_refs(int argc,
 	if (!pack_refs_opts.includes->nr)
 		string_list_append(pack_refs_opts.includes, "refs/tags/*");
 
-	ret = refs_pack_refs(get_main_ref_store(the_repository), &pack_refs_opts);
+	ret = refs_pack_refs(get_main_ref_store(repo), &pack_refs_opts);
 
 	clear_ref_exclusions(&excludes);
 	string_list_clear(&included_refs, 0);
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 4618ffc108..002a75dee8 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -14,6 +14,13 @@ export GIT_TEST_DEFAULT_REF_FORMAT
 
 INVALID_OID=$(test_oid 001)
 
+test_expect_success 'pack-refs does not crash with -h' '
+	test_expect_code 129 git pack-refs -h >usage &&
+	test_grep "[Uu]sage: git pack-refs " usage &&
+	test_expect_code 129 nongit git pack-refs -h >usage &&
+	test_grep "[Uu]sage: git pack-refs " usage
+'
+
 test_expect_success 'init: creates basic reftable structures' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.48.1

