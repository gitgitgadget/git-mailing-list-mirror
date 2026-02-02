Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C23644D5
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770035227; cv=none; b=s11aV2yoNC12T/QhnbjFgWni3t+Mb4EQYynWHcZSWw9NaqqQIbWEpOZkATs8/NRxhqOwpbaze0lG84kMhRPGwSkvrn/4odXuyjsivCdI2BWQy2tn+Wmt0q0wi0W47MKkFvxX0nEm6jHlf52D6vY+ytbAWML0bbZef+k9AzVl2og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770035227; c=relaxed/simple;
	bh=1iM0MiXZU9wenIT/DaaNRwVnD2jC/T/DQHyjuxNBiC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jS5rD8uBEZ1tPUY4YC3kYPkoEj6AZ/zQcC1WrPQohroocbATsZU3OVfNm4quL/TZZ2f4myhLtsb3DJ/KSDVdX0R9ICH/rXtyT3o3Nj/K2zD6DfXBpU/rR3wfSRyQHOiXU9w9/Uc+B8SLgeU7IsSiHyLUsRV/E84En8OGBs9SHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze231AXj; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze231AXj"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43596062728so3336982f8f.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 04:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770035224; x=1770640024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/20j8z8E8y7fhWrrfxuZ79oRVbOoQjMDa1u+FgVHafI=;
        b=Ze231AXjrhwXjmEQhYtA1XQNX644jinmFitdArrQiBwp0CbsR8360t29cF6iTxRYwJ
         NORJl3qJQVSJC2hn3G7xuAR3w0Tw91jYKE6KDKF63MVteKVbaxtlbiR/n1f8kKGdhU9u
         kMU4w/QtOHVzt1wYUYqXzIDbDB71bl4fHXOAyj1EzQ+QT3MAW0e3QFptpvhaqXzYjbiQ
         TteadixWs/nowCXzBDboiqKX/lVW95PALkS3Q2P61ZYPE6x5oNEj0oeMXzY0xRyPSvd8
         sjqPYfwfa2E60KHcnYeMb5nAER6/0r/mULWE1stMkSaqKW6CKIQorLli+Z912+xJRYC7
         DY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770035224; x=1770640024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/20j8z8E8y7fhWrrfxuZ79oRVbOoQjMDa1u+FgVHafI=;
        b=IArlCEDkOcqQIMKgQDHi+I+8gxWsHkYwSrIgCnjnuVP2bbrDyEnxbmF7JtP1yAzawM
         jnvFzF9NSNg7avj2WqmVHQWnAlS+MJGa7bbJpFuA5E8BrlM00t5lVJCXeUkUpusnDX5j
         5ilVLZLaOXX6Wl7uOI32YvSTdWxFgz5m04+0zrSZulOIlbywrDMEoFMT1XZFlIuwZkZ/
         0i6zRl3cDw15w/z68kJKJFxiMJnvQZ7mfabBIRDDPqcf4o2Gv+M0wA02MNNF74YxFbHo
         PFzOx2nH3iW21F/Uvu0jNsD2aMAMUBw9s9eja3O/sq1rs/Jw2fYweNUlXqWaFV0fC/Ct
         eoMA==
X-Gm-Message-State: AOJu0YzT3rGkubj5BCyNBRyj2RSzvTz0OsIy0gZ4S5RdQt8nnE2LgZTR
	HnUV3enDNHwLUA/G4giSk/YGdjLuAjvDJP0lRI122GVWJByPI+Ad6tYO
X-Gm-Gg: AZuq6aLClQuWYPmpFgVcGHyumKi49XCL1UJ71KqIBsqd1syipyQ0/d/FYqUrXnhbL7H
	XdD7AqnU4JC0gM0V7V8QHLmnQhQ5D2VJtA65w7nQMEJf/GXGXmBzCu/zPP4d8iKJU3WGJGopKjO
	KLSQkIWAYLEk/5mwmy3iPFp3aS/1YRh1IMkeZ24g6XkGlWCo/gSa+LFT6ZeGcwaou7dEvvGKl3e
	23Kp1sOphI+qD/W6TSaex39UWAoShpzVgY4Tfc+winL36jZbL2727gfVoqMOwB6DPQVlUsjNSXD
	wpeScdBOOWdCh2ejpDLtppXml4Qc+Zsl9Sj6zVuFyuLjJ1fBjiarPrO1mIDW4Ouo0W4kKsr5IJT
	K6BuiwGMAXJqXOT3bBQozyrIWxhMl75pgs1/ZOVfxk1RJrMEAGdr5uGYQe+7T4Jl6j6jx/J5hG3
	tL8qwGosZ8Yhnw43reNQ8=
X-Received: by 2002:a05:6000:3106:b0:435:dbbb:992a with SMTP id ffacd0b85a97d-435ea05d198mr23464909f8f.6.1770035224202;
        Mon, 02 Feb 2026 04:27:04 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:4339:aac1:fb26:43f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4757sm45245735f8f.5.2026.02.02.04.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 04:27:03 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 02 Feb 2026 13:26:31 +0100
Subject: [PATCH v4 2/4] refs: extract out `refs_create_refdir_stubs()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-kn-alternate-ref-dir-v4-2-3b30430411e3@gmail.com>
References: <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>
In-Reply-To: <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4381; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=1iM0MiXZU9wenIT/DaaNRwVnD2jC/T/DQHyjuxNBiC8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmAmBQIRTM8CosyP1c9YPTA30YKN22ims/jO
 OP0kM45LdKY1IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpgJgUAAoJED7VnySO
 Rox/JNUL/3i/v07i3ePAsugtS8qrs+mU4Ek2gf+IHC2i/f/+Bxn3iOxZ5JhXb8wPd5s5ukOMz8k
 bh5yv3wn5+Qn1UO/gTXBAAw39cEQw3I3FJzb7lrdZI3RGVFRv1SDVooORfm62WanAwKStEo6Dxs
 3pLfUI0e/Zee3lDidcxieZMZp6bAgZgjQISkgDwK1VsU/6AdL2yKbIMu8Z/TIMlBdQbLVDFRDy0
 HTgJ6iiQSAFllsIJWlmZRvaGvUN+sXtHJtQ9K3tFwzgHC2S8tRfEoXoOnFfESUSB0gEF5upujvK
 EdbmMkr/270964gk3UPCP5ddzq5H+b/WyzWMVb5HdJ6ZCnflKrstNyfe8CbxLE+dW7koifaXxse
 DmBAk1g6fXC8KGy2au8FzD/FIdGk9LJvi/BNM9FStp7z4w+yEWK5usASm9rGtyKlEhpwBj1OZK8
 z4emYJ0m4Q1Dg8KkZTpS4yTkepR4aCNe1kQ4bzXGJGry/zFLTzs18IVoU7WwSEuGbv89K7WUAP6
 Yk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

For Git to recognize a directory as a Git directory, it requires the
directory to contain:

  1. 'HEAD' file
  2. object/ directory
  3. 'refs/' directory

Here, #1 and #3 are part of the reference storage mechanism,
specifically the files backend. Since then, newer backends such as the
reftable backend have moved to using their own path ('reftable/') for
storing references. But to ensure git still recognizes the directory as
a Git directory, we create stubs.

There are two locations we create stubs:

- In 'refs/reftable-backend.c' when creating the reftable backend.
- In 'clone.c' before spawning transport helpers.

In a following commit, we'll add another instance. So instead of
repeating the code, let's extract out this code to
`refs_create_refdir_stubs()` and use it.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/clone.c         |  7 +------
 refs.c                  | 24 ++++++++++++++++++++++++
 refs.h                  | 13 +++++++++++++
 refs/reftable-backend.c | 14 ++------------
 4 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 28412576b3..11854894d3 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1225,12 +1225,7 @@ int cmd_clone(int argc,
 	initialize_repository_version(GIT_HASH_UNKNOWN,
 				      the_repository->ref_storage_format, 1);
 
-	strbuf_addf(&buf, "%s/HEAD", git_dir);
-	write_file(buf.buf, "ref: refs/heads/.invalid");
-
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "%s/refs", git_dir);
-	safe_create_dir(the_repository, buf.buf, 1);
+	refs_create_refdir_stubs(the_repository, git_dir, NULL);
 
 	/*
 	 * additional config can be injected with -c, make sure it's included
diff --git a/refs.c b/refs.c
index 627b7f8698..32b4edaf2d 100644
--- a/refs.c
+++ b/refs.c
@@ -3402,3 +3402,27 @@ const char *ref_transaction_error_msg(enum ref_transaction_error err)
 		return "unknown failure";
 	}
 }
+
+void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
+			      const char *refs_heads_msg)
+{
+	struct strbuf path = STRBUF_INIT;
+
+
+	strbuf_addf(&path, "%s/HEAD", refdir);
+	write_file(path.buf, "ref: refs/heads/.invalid");
+	adjust_shared_perm(repo, path.buf);
+
+	strbuf_reset(&path);
+	strbuf_addf(&path, "%s/refs", refdir);
+	safe_create_dir(repo, path.buf, 1);
+
+	if (refs_heads_msg) {
+		strbuf_reset(&path);
+		strbuf_addf(&path, "%s/refs/heads", refdir);
+		write_file(path.buf, "%s", refs_heads_msg);
+		adjust_shared_perm(repo, path.buf);
+	}
+
+	strbuf_release(&path);
+}
diff --git a/refs.h b/refs.h
index f0abfa1d93..9d8890fdff 100644
--- a/refs.h
+++ b/refs.h
@@ -1427,4 +1427,17 @@ void ref_iterator_free(struct ref_iterator *ref_iterator);
 int do_for_each_ref_iterator(struct ref_iterator *iter,
 			     each_ref_fn fn, void *cb_data);
 
+/*
+ * Git only recognizes a directory as a repository if it contains:
+ * - HEAD file
+ * - refs/ folder
+ * While it is necessary within the files backend, newer backends may not
+ * follow the same structure. To go around this, we create stubs as necessary.
+ *
+ * If provided with a 'refs_heads_msg', we create the 'refs/heads/head' file
+ * with the provided message.
+ */
+void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
+			      const char *refs_heads_msg);
+
 #endif /* REFS_H */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index fe74af73af..d8651fe779 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -491,18 +491,8 @@ static int reftable_be_create_on_disk(struct ref_store *ref_store,
 	safe_create_dir(the_repository, sb.buf, 1);
 	strbuf_reset(&sb);
 
-	strbuf_addf(&sb, "%s/HEAD", refs->base.gitdir);
-	write_file(sb.buf, "ref: refs/heads/.invalid");
-	adjust_shared_perm(the_repository, sb.buf);
-	strbuf_reset(&sb);
-
-	strbuf_addf(&sb, "%s/refs", refs->base.gitdir);
-	safe_create_dir(the_repository, sb.buf, 1);
-	strbuf_reset(&sb);
-
-	strbuf_addf(&sb, "%s/refs/heads", refs->base.gitdir);
-	write_file(sb.buf, "this repository uses the reftable format");
-	adjust_shared_perm(the_repository, sb.buf);
+	refs_create_refdir_stubs(the_repository, refs->base.gitdir,
+				 "this repository uses the reftable format");
 
 	strbuf_release(&sb);
 	return 0;

-- 
2.52.0

