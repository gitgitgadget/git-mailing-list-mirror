Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E86931DD86
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764155529; cv=none; b=jVIIGhNoX/ypaS68rKbZx/bejhQixWNhszA1ufoY5UNLFk9dBqjIp/kty5sjZ+QXnBkywTHj5KiyrU/ejJvB5fMm+jmsDueHyGALPiYAMtekIwiJbgOoo+egtxfdVza5L6ZncgsCw6bL+q3Hh3SReNiK8ugZVHLSXh/HyK20qWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764155529; c=relaxed/simple;
	bh=vHcWDUsx3+okA+j9pHqZFsO4BCXznJion0Rd9+Ii2U0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=saKlI2fz50XpRHDWWO4i4AzG5Qms91RbIO8nun0+KGUndc6fM4dXY5NyR/f0sLMyOj25G0U7Upp7AxTg0KPKXvpam2S3kjaQu/OINo2oN9V7EclAlZVvMEYUj/x5lHeD9qX9VZEuCkPcXpV4q9407F0zhCxwmPAC+qP+mvk/708=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P71zDNDz; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P71zDNDz"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so10174890a12.2
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 03:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764155526; x=1764760326; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmYND3ypDoY7eQbwuhjJ5W/IPJWsJNUBtNaAuOg+Shk=;
        b=P71zDNDzKwd9XK9NFmSSxcOtXFtrJc/jYN/Ph1DOaS89wz6VXXppPudCqb5JSr0g4l
         hGlKqc/v/1Byqfp9OEd98jw8z3R7vbYW0jncbzIlyj4kAlchJOx2VTvOSV2TzPPgN/Ds
         TjwdNGhkwzmdQjqlTItly7xeIJcCO0mE74ue5ZW56JpOhxRAPHaUYab9GYB51OKtLSXw
         ziMQa8uRSg1a18K1uacHhLq7dgguZg3/MmPexy1Bq+wCS9Sk8YNDhnVy1SgQyS9w47UW
         voZif+ForbTiUSv5mFovUnTZlY++R3Y0c7NJsCCsCCuE8FqzgAMk3BAvmtQy+ccE5UTa
         i20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764155526; x=1764760326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BmYND3ypDoY7eQbwuhjJ5W/IPJWsJNUBtNaAuOg+Shk=;
        b=kEmk84OXNjduPc9Y/uhinUZOXvjuK4Rcu6BipZqFBy7VFfAMZzdf9Z5c4/VE9joPRH
         0eFpcwNClEJ6k7qLf1omYJCnWmX1OvNLDYbYhCiyUQuf5t/7+RqSizpzdpCJ+xmz4lm7
         OnW9iLKMk4xt/JqcEZWVQHQAkOwmmIespG7TFEP6r3lkX+bBDEWyA5gT/hDUoGXnGML8
         7vyWYynBG7D3xxYfmxM8ESkvqU3S9DXnob01ZIvAXo+uE6TC92XCUyPtSVUATQKpsKOC
         E0lh9xHUKDSeEq/A1OkQOBVDTziaZNKZ2KSj+NdbGsu7Hei+2e9IS6mssbirFb72tt7R
         siNA==
X-Gm-Message-State: AOJu0YzKdiJM4AD0CqDvwMElCFK6Sazy9HpyiD3DOrOOaJESUS+JgQSL
	DeZgAoba6I44G96nZRRlR/AV/jpjEaMx81op/fYzOVGYFMAIzpJHpMIbO76T1A==
X-Gm-Gg: ASbGncvN0JDW38qD2SoVE/H5o/p09Y2Usvj89j+NW/fG/0eIv+8ImxveZejMsOC0bSY
	HYZYxguITIEIEj9eTCq+vGkyZ7BMdDMY9WIgLi1EEL8eQgYteKZzOw00R49Ly6JaSzOnCsC4k7u
	Mh1i8LsC6LTkUWDMOM9qb+pEXpsh0k8eBdNicgHtc0U/QYrp5d338S+X8AebXKPvMHjhkcHd7WE
	DJpt7eou7UFddnmKknhmBkFG3Tn7xIUKAHSffw5JHuL1PErTK38G5Ar3QJZn5xgmuiEuEYJg0lh
	rbo7kzs78V74FWj6Fw8RVuCuKb+MKeToVBQ6sXJ96g5d4ZqoHFKJkT1WYR/1UN2TLJKfnI9c1oE
	P5QljdP+jXk5U8DUISrF9Yu2pvSfsH/rTJQUfeuQS1iSAckKY97wwtm5ZyiJo840HzKsXIDzleH
	fU9WU7w5du3GB743hXDg==
X-Google-Smtp-Source: AGHT+IGPLL/3Sz2hG+KtLU4M1oT1GbBz+KG2QYQqYwtVSFOtAt5V0o4Ba/knqkfv2UBzV/JsNSzR9g==
X-Received: by 2002:a17:906:4fcd:b0:b72:1b8b:cc3 with SMTP id a640c23a62f3a-b767170c9eamr2046718966b.33.1764155525769;
        Wed, 26 Nov 2025 03:12:05 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:e97b:ea4a:70d1:4f56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d54cf2sm1835186866b.18.2025.11.26.03.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 03:12:05 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 26 Nov 2025 12:12:01 +0100
Subject: [PATCH v2 2/2] refs: add GIT_REF_URI to specify reference backend
 and directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251126-kn-alternate-ref-dir-v2-2-8b9f6f18f635@gmail.com>
References: <20251126-kn-alternate-ref-dir-v2-0-8b9f6f18f635@gmail.com>
In-Reply-To: <20251126-kn-alternate-ref-dir-v2-0-8b9f6f18f635@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
 gitster@pobox.com, toon@iotcl.com, sunshine@sunshineco.com, 
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8565; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=vHcWDUsx3+okA+j9pHqZFsO4BCXznJion0Rd9+Ii2U0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkm4IMFSF7ZtQn/NMLyN7NhBtFWUPf6na1ZR
 m9HNOvRaCU0IokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpJuCDAAoJED7VnySO
 Rox/BPwL/2RJbYE4+53iz2a+x/n0DaKrFWh8oZhe/26LVQeUVxU16zy8DbO2lEyXT8THCWCEC6g
 vlIMK851phMuae+4BVhMoDX8sOUe3PQaB/2VAGEAonUvadMmRDksJn7q6+GFSu2vrgv5gEaCcS0
 pLtmOKNGbVrSESFAXMamKq7uYtqf4P0Eq2aOoHN35igNJY7SOkm4V3kTKdBLUQd8iI7u9S+7khU
 kL3uJCq9hnU4ktggeSg2qYrxkPEeMymg5k373rS3bVdUfXF81Hp7g1uXc9EKBsHUOl6wmyZ1vtg
 a57b3L8pkT9HSewNATFnHdBmjjfYdqbAjXmx4+BvJEPMwTFUpaOF6lGronF/ZAGShqdnjwRO+zr
 i+tEpyDUnNPPIT43kR7GhA8wqG1fqxneA9HQqjnZfkXd9xemXtcWX06uAeaTdYf09itEWLG2ZV3
 lfJmoOekQukdQ+zL0/ay5QKl1I6dM7r0+HAmdllYE20lZtv14bqDkZ27nCE6OJzvzdZW2V97u86
 9U=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Git allows setting a different object directory via
'GIT_OBJECT_DIRECTORY', but provides no equivalent for references.
This asymmetry makes it difficult to test different reference backends
or use alternative reference storage locations without modifying the
repository structure.

Add a new environment variable 'GIT_REF_URI' that specifies both the
reference backend and directory path using a URI format:

    <ref_backend>://<URI-for-resource>

When set, this variable is used to obtain the main reference store for
all Git commands. The variable is checked in `get_main_ref_store()`
when lazily assigning `repo->refs_private`. We cannot initialize this
earlier in `repo_set_gitdir()` because the repository's hash algorithm
isn't known at that point, and the reftable backend requires this
information during initialization.

When used with worktrees, the specified directory is treated as the
reference directory for all worktree operations.

Add a new test file 't1423-ref-backend.sh' to test this environment
variable.

Helped-by: Jean-Noël Avila <jn.avila@free.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git.adoc |   8 ++++
 environment.h          |   1 +
 refs.c                 |  60 +++++++++++++++++++++++-
 t/meson.build          |   1 +
 t/t1423-ref-backend.sh | 121 +++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 190 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index ce099e78b8..8c6a3f6042 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -584,6 +584,14 @@ double-quotes and respecting backslash escapes. E.g., the value
 	repositories will be set to this value. The default is "files".
 	See `--ref-format` in linkgit:git-init[1].
 
+`GIT_REF_URI`::
+    Specify which reference backend to be used along with its URI. Reference
+    backends like the files, reftable backend use the $GIT_DIR as their URI.
++
+Expects the format `<ref_backend>://<URI-for-resource>`, where the
+_<ref_backend>_ specifies the reference backend and the _<URI-for-resource>_
+specifies the URI used by the backend.
+
 Git Commits
 ~~~~~~~~~~~
 `GIT_AUTHOR_NAME`::
diff --git a/environment.h b/environment.h
index 51898c99cd..9bc380bba4 100644
--- a/environment.h
+++ b/environment.h
@@ -42,6 +42,7 @@
 #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
 #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
 #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
+#define GIT_REF_URI_ENVIRONMENT "GIT_REF_URI"
 
 /*
  * Environment variable used to propagate the --no-advice global option to the
diff --git a/refs.c b/refs.c
index 23f46867f2..a7af228799 100644
--- a/refs.c
+++ b/refs.c
@@ -2186,15 +2186,73 @@ static struct ref_store *get_ref_store_for_dir(struct repository *r,
 	return maybe_debug_wrap_ref_store(dir, ref_store);
 }
 
+static struct ref_store *get_ref_store_from_uri(struct repository *repo,
+						const char *uri)
+{
+	struct string_list ref_backend_info = STRING_LIST_INIT_DUP;
+	enum ref_storage_format format;
+	struct ref_store *store = NULL;
+	char *format_string;
+	char *dir;
+
+	if (!uri || !uri[0]) {
+		error("reference backend uri is empty");
+		goto cleanup;
+	}
+
+	if (string_list_split(&ref_backend_info, uri, ":", 2) != 2) {
+		error("invalid reference backend uri format '%s'", uri);
+		goto cleanup;
+	}
+
+	format_string = ref_backend_info.items[0].string;
+	if (!starts_with(ref_backend_info.items[1].string, "//")) {
+		error("invalid reference backend uri format '%s'", uri);
+		goto cleanup;
+	}
+	dir = ref_backend_info.items[1].string + 2;
+
+	format_string = ref_backend_info.items[0].string;
+	dir = ref_backend_info.items[1].string + 2;
+
+	if (!dir || !dir[0]) {
+		error("invalid path in uri '%s'", uri);
+		goto cleanup;
+	}
+
+	format = ref_storage_format_by_name(format_string);
+	if (format == REF_STORAGE_FORMAT_UNKNOWN) {
+		error("unknown reference backend '%s'", format_string);
+		goto cleanup;
+	}
+
+	store = get_ref_store_for_dir(repo, dir, format);
+
+cleanup:
+	string_list_clear(&ref_backend_info, 0);
+	return store;
+}
+
 struct ref_store *get_main_ref_store(struct repository *r)
 {
+	char *ref_uri;
+
 	if (r->refs_private)
 		return r->refs_private;
 
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
 
-	r->refs_private = get_ref_store_for_dir(r, r->gitdir, r->ref_storage_format);
+	ref_uri = getenv(GIT_REF_URI_ENVIRONMENT);
+	if (ref_uri) {
+		r->refs_private = get_ref_store_from_uri(r, ref_uri);
+		if (!r->refs_private)
+			die("failed to initialize ref store from URI: %s", ref_uri);
+
+	} else {
+		r->refs_private = get_ref_store_for_dir(r, r->gitdir,
+							r->ref_storage_format);
+	}
 	return r->refs_private;
 }
 
diff --git a/t/meson.build b/t/meson.build
index a5531df415..a66f8fafff 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -208,6 +208,7 @@ integration_tests = [
   't1420-lost-found.sh',
   't1421-reflog-write.sh',
   't1422-show-ref-exists.sh',
+  't1423-ref-backend.sh',
   't1430-bad-ref-name.sh',
   't1450-fsck.sh',
   't1451-fsck-buffer.sh',
diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
new file mode 100755
index 0000000000..f6756bdd2b
--- /dev/null
+++ b/t/t1423-ref-backend.sh
@@ -0,0 +1,121 @@
+#!/bin/sh
+
+test_description='Test different reference backend URIs'
+
+. ./test-lib.sh
+
+test_expect_success 'empty uri provided' '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=files repo &&
+	(
+		cd repo &&
+		GIT_REF_URI="" &&
+		export GIT_REF_URI &&
+		test_must_fail git refs list 2>err &&
+		test_grep "reference backend uri is empty" err
+	)
+'
+
+test_expect_success 'invalid uri provided' '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=files repo &&
+	(
+		cd repo &&
+		GIT_REF_URI="reftable@/home/reftable" &&
+		export GIT_REF_URI &&
+		test_must_fail git refs list 2>err &&
+		test_grep "invalid reference backend uri format" err
+	)
+'
+
+test_expect_success 'empty path in uri' '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=files repo &&
+	(
+		cd repo &&
+		GIT_REF_URI="reftable://" &&
+		export GIT_REF_URI &&
+		test_must_fail git refs list 2>err &&
+		test_grep "invalid path in uri" err
+	)
+'
+
+test_expect_success 'uri ends at colon' '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=files repo &&
+	(
+		cd repo &&
+		GIT_REF_URI="reftable:" &&
+		export GIT_REF_URI &&
+		test_must_fail git refs list 2>err &&
+		test_grep "invalid reference backend uri format" err
+	)
+'
+
+test_expect_success 'unknown reference backend' '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=files repo &&
+	(
+		cd repo &&
+		GIT_REF_URI="db://.git" &&
+		export GIT_REF_URI &&
+		test_must_fail git refs list 2>err &&
+		test_grep "unknown reference backend" err
+	)
+'
+
+ref_formats="files reftable"
+for from_format in $ref_formats
+do
+	for to_format in $ref_formats
+	do
+		if test "$from_format" = "$to_format"
+		then
+			continue
+		fi
+
+		test_expect_success "read from $to_format backend" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=$from_format repo &&
+			(
+				cd repo &&
+				test_commit 1 &&
+				test_commit 2 &&
+				test_commit 3 &&
+
+				git refs migrate --dry-run --ref-format=$to_format >out &&
+				BACKEND_PATH=$(cat out | sed "s/.* ${SQ}\(.*\)${SQ}/\1/") &&
+				git refs list >expect &&
+				GIT_REF_URI="$to_format://$BACKEND_PATH" git refs list >actual &&
+				test_cmp expect actual
+			)
+		'
+
+		test_expect_success "write to $to_format backend" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=$from_format repo &&
+			(
+				cd repo &&
+				test_commit 1 &&
+				test_commit 2 &&
+				test_commit 3 &&
+
+				git refs migrate --dry-run --ref-format=$to_format >out &&
+				git refs list >expect &&
+
+				BACKEND_PATH=$(cat out | sed "s/.* ${SQ}\(.*\)${SQ}/\1/") &&
+				GIT_REF_URI="$to_format://$BACKEND_PATH" git tag -d 1 &&
+
+				git refs list >actual &&
+				test_cmp expect actual &&
+
+				GIT_REF_URI="$to_format://$BACKEND_PATH" git refs list >expect &&
+				git refs list >out &&
+				cat out | grep -v "refs/tags/1" >actual &&
+				test_cmp expect actual
+			)
+		'
+	done
+done
+
+test_done

-- 
2.51.2

