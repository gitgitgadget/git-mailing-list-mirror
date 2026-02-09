Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ABC37FF60
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652706; cv=none; b=HDOebxh1R5fAS0ekIX3s/CNBaxVzvjgi/6SOBL/oMTAtIVuF9ElgSVyjKlxlJVg1bj6bTWZxSVw1h4HNuRpNHv/eJe6jroTsmZMAYaYkAH0aM3dr84upOAMsiKUzELMD1KnZQ6LRqZCf+914GzTyCFCrJ0STYtmtxLJOJrF8eVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652706; c=relaxed/simple;
	bh=lqsdjVAhjFLHC3oZt/s7kOM6I93haOQyiFsw8UXJZbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BM+upi6nZkDAw0tJkm3HunzZPDrW7NoDub9RBKjlAGWc5CwD08/IxVKWzWwfJD0EUNCBk0wmhQR0SWLqd3/+PORRjdMkip6qekIao1WRtFIMucMY1VXKqpxYi9H7SgRqIHUPCAkWiUph2uyJUv6dsr26yaHpLLsUOE5w8Rm+iGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=St+4/5pI; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St+4/5pI"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-482f2599980so53695605e9.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 07:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770652704; x=1771257504; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFvGAb+RnW1Oh4meLN9DJrXkEVSEOIpsD3G726iu4HE=;
        b=St+4/5pIKzyqOCHwr3whyDTuw0Ueh7gJLxU0crDz6Jysj6zGE/qNDUiqyaY5zNgYjB
         xDJvppDkCRMCgSv+VJxMT/IIRbBTVQq2zS6+jJf57d9F5geV79Q8OedYuj5SXSaZNx7f
         nw4dYw1nkVj+XBbLZ/ulytPlBJSp+q3BX+qLkbzqc3cJEEdJF/uLNy7YgHs4qx7vP3nB
         T1ezNaHsZIvPI7eGttXhidYASWYE1ijkbYzQWg4CMeVszUXzyX0GDeoHS5U6oNm4i6ey
         vGzMFZIaK5dBGJxWECojLZtwRHC6X8Vw5JPH6sBpIw8yF9E9Hrcvrd/1txOh/WhtxTdv
         f+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770652704; x=1771257504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WFvGAb+RnW1Oh4meLN9DJrXkEVSEOIpsD3G726iu4HE=;
        b=W/CHSE4fx3i7ifLFrsxx92R1P71fsWieDtd7JsirT1agR6NxBR0THxgJWyqBJlsSeI
         CFDFkqJgeybjLQ8Fvoiuq3cJLmr/532ek5/3IYau8IwOh+EtwE1QyBhSRGgYNuCzBGhD
         nptqwopVWQtfTmNkJ+TPf1s9oFJgRIVP95/euJGsI8Dh5PlrSC79YyJBGsvPkILSRPGx
         FbWh3nL0Rb1z4/j1OYF+XIrdJJfKVsUEGPPNelGji8ywzS9t0inkhzg9gsBxi2me1ppE
         zUYpyAsOKquvGmJnjSprP6EdKQvqsuYU8zYnaHZ6idVEahg04leCVsKQpxvHkx20M85i
         6Wiw==
X-Gm-Message-State: AOJu0Yw5B5L9KKomBGGoBzY3IC6TiwDb6afUzwC5o9Oko3CrCQIPzuWm
	s2KIyMC1Tm1ULdW9ROcLS7mUiKEKC7x8M6OyPaugK5jRWCfyxYANqWiV
X-Gm-Gg: AZuq6aKdTzo7iphpvtmAUzKiZEbZyHK+cQNhfNgQX1yu2BPETCWu2t+/yhKUS1npFpv
	zhEZE77OmEb1bijjca0DYueVtSq361NFnygUmnYUNei2x1RQOiSIgCCia/VPQ9712BwO4RHoaYx
	vr2LYq6puHGZ0i3xaEvKs7/ZQo073X8IRocFJCMKhgnem+VRUcAYr1vi7FkwvPLrGlWZWYbc68g
	fQvxGHtnEmoAnFquc5qBF3Z67wphnVAXr7LkBxJOIeGUgJka2Egrj7LCjaPfhUHbf+DKow3CMRb
	bBJmfY7AKiAtjCEXzS0lCfRFzmqkk/FlesRAfNQE0sWyEiM/qYR3/+DLgvmB/5vrRmWn7Zry6fx
	4yNUadp0Y1qSOSaUztuPqDRw4tj2sT8nIL84YqzuRr/CIg+I054CFRhmvhwh2oDmG2o3juesNGB
	RRHo7Qhm/H53aB8jXwzjxyM4zRLzGPXQ==
X-Received: by 2002:a05:600c:8b45:b0:477:9cdb:e32e with SMTP id 5b1f17b1804b1-483201e713fmr161935085e9.9.1770652704243;
        Mon, 09 Feb 2026 07:58:24 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:9616:5969:7cd9:8b71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832096f127sm128163635e9.6.2026.02.09.07.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 07:58:23 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 09 Feb 2026 16:58:18 +0100
Subject: [PATCH v5 1/4] refs: extract out `refs_create_refdir_stubs()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-kn-alternate-ref-dir-v5-1-740899834ceb@gmail.com>
References: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
In-Reply-To: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4398; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=lqsdjVAhjFLHC3oZt/s7kOM6I93haOQyiFsw8UXJZbM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmKBBxpTXexeJgR9a2parLQXtt33Nzfk+QLZ
 InvEU2Yt/Sj7IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpigQcAAoJED7VnySO
 Rox/MSoL/RMIbYpELaCwGqMW2Y98/JWV89bfjjmD37cpj6xjd0P8B09v5JLipbh9yGeM3TZ1MF+
 YZYC8mqC/+5UuE+12Xd7zKdtTI0DYP6keP0gBsZM0LkpZljWmoKtW3o0DnkHbUoetcfkpOTl/Se
 iMbW49+xHX1RaR9lDMlkBhgb5G459JX+nCHnhKYoarajrHlnugErNu1d+wXoMMCWOJV39RWxsUh
 oW9h9uTj3N8IH06oIe6olU865Xb4K74e7XEDEKgUsk+rd+3ynA2NNjNQ3i27hjUa1kQa1a0z6PT
 ZHYNyAvGuwYhqhNfIWxosvYPJ0HLstm/CXfXO1ri3GrW0TTl7SR1EoVX6JrPyM2Y8PiVbMgi/+F
 1Hq/WAs0MFHucadd9/RgVIF2Q5YTDKIliFaS/pEziu0jdnxq9mnXZMTcUCpGU9OG32TQw4Z1hKZ
 Uc/paKpRs62pQo75iWM0UOsZWcEiGa6HK9MK8hfiZD5HEZy7FvmD/FDPBnRHMj17uIGvWGRAa87
 QQ=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

For Git to recognize a directory as a Git directory, it requires the
directory to contain:

  1. 'HEAD' file
  2. 'objects/' directory
  3. 'refs/' directory

Here, #1 and #3 are part of the reference storage mechanism,
specifically the files backend. Since then, newer backends such as the
reftable backend have moved to using their own path ('reftable/') for
storing references. But to ensure Git still recognizes the directory as
a Git directory, we create stubs.

There are two locations where we create stubs:

- In 'refs/reftable-backend.c' when creating the reftable backend.
- In 'clone.c' before spawning transport helpers.

In a following commit, we'll add another instance. So instead of
repeating the code, let's extract out this code to
`refs_create_refdir_stubs()` and use it.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/clone.c         |  7 +------
 refs.c                  | 23 +++++++++++++++++++++++
 refs.h                  | 13 +++++++++++++
 refs/reftable-backend.c | 14 ++------------
 4 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b40cee5968..535a257b10 100644
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
index 627b7f8698..36f3441632 100644
--- a/refs.c
+++ b/refs.c
@@ -3402,3 +3402,26 @@ const char *ref_transaction_error_msg(enum ref_transaction_error err)
 		return "unknown failure";
 	}
 }
+
+void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
+			      const char *refs_heads_content)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	strbuf_addf(&path, "%s/HEAD", refdir);
+	write_file(path.buf, "ref: refs/heads/.invalid");
+	adjust_shared_perm(repo, path.buf);
+
+	strbuf_reset(&path);
+	strbuf_addf(&path, "%s/refs", refdir);
+	safe_create_dir(repo, path.buf, 1);
+
+	if (refs_heads_content) {
+		strbuf_reset(&path);
+		strbuf_addf(&path, "%s/refs/heads", refdir);
+		write_file(path.buf, "%s", refs_heads_content);
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

