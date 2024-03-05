Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0B85664
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709601751; cv=none; b=P1j/wTtDMi8qVLWiTpB9LAyEHimUf/w9rGOS8h1yeZJhkHr7jyQZa7s3yEnBIHc0Ficu35rkdJ2yhj8laZHKEJWpG9ZZGaZfxn64O646qYFtT3OYoWqMjG7tMjYmC3kyJIsA2qWPHhwEGs9CqTBC3COE8HOLG2h77+GJahiaiX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709601751; c=relaxed/simple;
	bh=G+oW77TjnTjnTh+vSrJtmK7X607SJcN0eyPP69LQnzc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vCIY5mdwwlfnKvHehW7OvnofjW0/VFUlHF6YnoonBzLJ4IyukhLhWRNwNt1hLPZUfOKBgBgAEKhBUQ0C/hO78tOgFdwxgT5gbN4PJji+a4P/Yl8Z9UmrBPtbSfnZj2ow5YqvrhXB7LjOQcjqwrZm1KOqwKCfFoNPib8WqdsWbS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--atneya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8lhISkm; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--atneya.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8lhISkm"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso8809633276.1
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 17:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709601749; x=1710206549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mr9pwK0AlYnn4aBV1+s0A2I/JGdMoYX3va1Z9Jyvnlc=;
        b=u8lhISkm9YGUKkITp6tuklXimSXzTU33TvIMezXhTu+bWAbyzBBxowBp4MLiTkJypt
         Kzvw/CYWjiOZcuGZfmEAkQVi4mMbHgGo73EfkSUVNOah/Dtd38DYkVi08nNsygDmaYhP
         SGS1pSgazXgVu4eu7gY+C2vBRKWJ4NcMAbfS9xKS6u2nYQRzkDW7Bt/ki9MNOFExaQUJ
         2nQFZtxBcgAAduMDqZbM7b9NZXSX4shVJCngXuHKNEGDK8HKZOUxvWQzd4ZCiFYCYIWr
         l7gzyoRe5PsW7cyfWLwrkBFyB6tgSRYYYHNsdNQUwjFic7mMMITmPb37qpOm1nvL7Jkc
         aXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709601749; x=1710206549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mr9pwK0AlYnn4aBV1+s0A2I/JGdMoYX3va1Z9Jyvnlc=;
        b=xGUTxGoUVVftdvOh3L9E+gRgydNaK+2+SJUw9Rl5kTRFbKScYSRD32/hsePfInPLjj
         TdEH3haOfHTqMGdfRyo5tOK26U2UjG4NVjrb12zv8LYxqeKoWd08AcfKqlZOVD21+0Wp
         HcmV+aHhc9Ps2KlTBvz7JwCYGm9drBGC9m/WK+Ry42BHEeFZfZBjrIJ3DcSi3vCAZm9V
         jZttdjDJlN2udIqoTwaerscs/Q0bm8keYSbnB98WgJenUSPsPAS2yNsfYmKLKhKiN3Lk
         80FujHeIjnPZYoAUqLVodINW9idUw9p8pRt77PsxUgmKhITtoU035o7bgWnfZj4+S+jL
         B7Zg==
X-Gm-Message-State: AOJu0YysaRy4gSTOJm1HEBjh5RRpmlTjD+VHzpvbqN6kU0tZ7oYLv8Cv
	HJ5n1zmfJ3B45kYkdLxsX6SWVzGv3yXPlUKMIWa35LJhGKi+lj78W3MiwXbHHAZ8myme86EgDEt
	a8xIVTdJ8cW5J8t0C2mkfrCdBtny914PC/Wz+JnYpzO7+JIcM+htpunccHNxsord03T+aRyAD0K
	8y8UDOCg4bnQFei6yOcojY8WpaJeFM
X-Google-Smtp-Source: AGHT+IE+5oyMXQ9aElIIb+gB22osFL1vRB3oAyBcUysgiCFZNEmJA8gzuOtVY8nbMrSDjgogbbls0p7KC3c=
X-Received: from capy.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:151e])
 (user=atneya job=sendgmr) by 2002:a05:6902:1885:b0:dc6:207e:e8b1 with SMTP id
 cj5-20020a056902188500b00dc6207ee8b1mr2731068ybb.2.1709601749051; Mon, 04 Mar
 2024 17:22:29 -0800 (PST)
Date: Mon,  4 Mar 2024 17:21:12 -0800
In-Reply-To: <20240305012112.1598053-2-atneya@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305012112.1598053-2-atneya@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240305012112.1598053-4-atneya@google.com>
Subject: [RFC PATCH 2/3] Make ce_compare_gitlink thread-safe
From: Atneya Nair <atneya@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, jeffhost@microsoft.com, me@ttaylorr.com, 
	nasamuffin@google.com, Atneya Nair <atneya@google.com>
Content-Type: text/plain; charset="UTF-8"

To enable parallel update of the read cache for submodules,
ce_compare_gitlink must be thread safe (for different objects).

Remove string interning in do_config_from (called from
repo_submodule_init) and add locking around accessing the ref_store_map.

Signed-off-by: Atneya Nair <atneya@google.com>
---

Notes:
    Chasing down thread unsafe code was done using tsan.
    
    Open questions:
     - Is there any additional thread-unsafety that was missed?
     - Is it safe to strdup in do_config_from (do the filenames need static
       lifetime)? What is the performance implication (it seems small)?
     - Is the locking around ref_store_map appropriate and/or can it be made
       more granular?

 config.c | 3 ++-
 config.h | 2 +-
 refs.c   | 9 +++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 3cfeb3d8bd..d7f73d8745 100644
--- a/config.c
+++ b/config.c
@@ -1017,7 +1017,7 @@ static void kvi_from_source(struct config_source *cs,
 			    enum config_scope scope,
 			    struct key_value_info *out)
 {
-	out->filename = strintern(cs->name);
+	out->filename = strdup(cs->name);
 	out->origin_type = cs->origin_type;
 	out->linenr = cs->linenr;
 	out->scope = scope;
@@ -1857,6 +1857,7 @@ static int do_config_from(struct config_source *top, config_fn_t fn,
 
 	strbuf_release(&top->value);
 	strbuf_release(&top->var);
+	free(kvi.filename);
 
 	return ret;
 }
diff --git a/config.h b/config.h
index 5dba984f77..b78f1b6667 100644
--- a/config.h
+++ b/config.h
@@ -118,7 +118,7 @@ struct config_options {
 
 /* Config source metadata for a given config key-value pair */
 struct key_value_info {
-	const char *filename;
+	char *filename;
 	int linenr;
 	enum config_origin_type origin_type;
 	enum config_scope scope;
diff --git a/refs.c b/refs.c
index c633abf284..cce8a31b22 100644
--- a/refs.c
+++ b/refs.c
@@ -2126,6 +2126,9 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 	size_t len;
 	struct repository *subrepo;
 
+	// TODO is this locking tolerable, and/or can we get any finer
+	static pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
+
 	if (!submodule)
 		return NULL;
 
@@ -2139,7 +2142,9 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 		/* We need to strip off one or more trailing slashes */
 		submodule = to_free = xmemdupz(submodule, len);
 
+	pthread_mutex_lock(&lock);
 	refs = lookup_ref_store_map(&submodule_ref_stores, submodule);
+	pthread_mutex_unlock(&lock);
 	if (refs)
 		goto done;
 
@@ -2162,10 +2167,14 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 		free(subrepo);
 		goto done;
 	}
+
+	pthread_mutex_lock(&lock);
+	// TODO maybe lock this separately
 	refs = ref_store_init(subrepo, submodule_sb.buf,
 			      REF_STORE_READ | REF_STORE_ODB);
 	register_ref_store_map(&submodule_ref_stores, "submodule",
 			       refs, submodule);
+	pthread_mutex_unlock(&lock);
 
 done:
 	strbuf_release(&submodule_sb);
-- 
2.44.0.rc1.240.g4c46232300-goog

