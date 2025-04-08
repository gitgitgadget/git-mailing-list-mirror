Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D2F2641E7
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102861; cv=none; b=QNRVDgq7usjusbqWS0gz4kCpo8n51hDKHZBPwS7igaspQvASDCzPKH3vW2iI0Oeu6yGiT5AyEuYeHLw4HVWJkpvVo83pynOxfFkUv/TtHADIJg+vL4bsBH2OOdWClhmDrk0/ASyggw3iShzsdccttH8z6nP2Iq1ABsrNOmrp4Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102861; c=relaxed/simple;
	bh=YiDcrN3Zr7q0b0AG5uCF9cDfKLhevczF8VHJocYvU+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2I3XQdaC31QaMFgZXTIPxPmVWnIhk+hZ18OptwkE2U0EXYeSnnRjc/Rocy6HY6Mxa47ienmrV+QAT+0zaWP1Nt4JlrDyJlji91OKwEyZWuQGy55nEizaWMBjX0U8J0ap/4ofBxM0bT3nsEugRKCnek8mhgu/4q6tM9kRKeCbPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c45COzcq; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c45COzcq"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5eb92df4fcbso9185806a12.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 02:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744102858; x=1744707658; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88BoGfQ0n8iIDMzjNw9Wk2/ui77vHUHDN9GG4r3u51E=;
        b=c45COzcqq23ZSVza+ISAEXUGPEg/HKsiOhh7o9xNxqoH3hHmXzoiyDDMnmvMfImuOa
         +PdLPWPiZtV45T995vwokB64fN9klI/0NFzU6Q670WrCRB/JB2QzLJar0Kzx7EXulxq1
         nXXsOvbLWVoJSDog5vK5P3IUIHT8IrRrD/ppW9R7E8xMpgsd5UCPZt/HEc2xSYPvbd6s
         pT4WLzDFMu4tf4Go10e9RAeFmWwpLyCsF/rl8ckrU/QYbLShUO4lwuR6sAAKVS2KGFtq
         3bllo/5G/W9ldNKSdAO0FsGHc2q/yMX3CVY5E+lIgBTHTvLE9fQgwNHKKkKn4maKvoM/
         2XLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102858; x=1744707658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88BoGfQ0n8iIDMzjNw9Wk2/ui77vHUHDN9GG4r3u51E=;
        b=Pl3/RZ9+dGMPpWxqEK5zhgVlst61uLg9c9uPWiN/OhBygpIZdp3CUQ8Lgr+o639nEp
         EZUFPw4mxTG15pTCCu0GnL9CdIZK2s1mS9ZnXC42WitZp9TzPIxvyf0n8PaaBW8z33cv
         rSveRbr6kwBkPUnvFXspNeOu0yDyVgpxLH0DWIvpnjHhSlM3IyzEsbNyuy8EHxx4PEj6
         pdjZSKNDhEI1q82mJVaXtIaxQdCTvDkj5tx/1LXsjk8ew7bFTsCtBKVVtix2rNoDBQws
         TtZHS91mhHfEjTZud+AriU0wWh12cD2uRombVAB6OTvBlbTv4VuSB+aKk65EJIm503wJ
         /xNw==
X-Gm-Message-State: AOJu0YwzgGiQUn0Sy2BtR0bHMfWMwz3mZoXGtr4v1Dm5olfu/gIXc9jM
	RdDLJ2MzMdYd/e7SSfAB5nxiyEGJcXPoaWqW11M8TLsCKrYYxGDG
X-Gm-Gg: ASbGncsA19ehNtxQbOQ011dy9o05ASz4n5tZK74Y5tjNIEvnoH3fg3DsIFvi8gPM0d8
	BDZNHr9SjlP0eGx1RHsfzWdUiFjvKw9gXvHgK2mfyRJxUicLO+CveJU7644fIW709ezZRbPZA8M
	nqENnLcwUDrhx1/jex6gVjwyXN8H/zub/4mFExXU+Kpx46JLh2iIlTWVMj94mTd+ugFWQnABSlv
	giXUXAh8RJXpkBvA9TW90lSmUhafPBYWFEpeavZpEp0/nzkxWlRGKmGtsd/yULsP/WT5l9eOEXj
	jJx6lFFiKxKTAzVeOrppcbC90zqOxm+34DXHdDy4m6lxU7xqammI4wY=
X-Google-Smtp-Source: AGHT+IG50afoEJds4GQt70gy9OZttvpW12CVkv7/Cpv2NEiANezRFLn2MN5sWHeyTedtOStv4bn1rA==
X-Received: by 2002:a17:907:9809:b0:ac3:bbc8:ecab with SMTP id a640c23a62f3a-ac7d185ac5cmr1446173466b.11.1744102857610;
        Tue, 08 Apr 2025 02:00:57 -0700 (PDT)
Received: from [127.0.0.2] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5d442sm875538666b.26.2025.04.08.02.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:00:57 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 08 Apr 2025 11:00:53 +0200
Subject: [PATCH v2 2/2] bundle: fix non-linear performance scaling with
 refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250408-488-generating-bundles-with-many-references-has-non-linear-performance-v2-2-0802fc36a23d@gmail.com>
References: <20250408-488-generating-bundles-with-many-references-has-non-linear-performance-v2-0-0802fc36a23d@gmail.com>
In-Reply-To: <20250408-488-generating-bundles-with-many-references-has-non-linear-performance-v2-0-0802fc36a23d@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7839; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=YiDcrN3Zr7q0b0AG5uCF9cDfKLhevczF8VHJocYvU+E=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGf05cdbQWolpSjl63YReZJQMWtTt+QxVDlWo
 CNlcqbQz4QwK4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn9OXHAAoJED7VnySO
 Rox/XhIL/33Jtnltz3jpxw89HxMVHRAnJBj0/nmy+gTYlYxtsLEVmAELxG4v0xR8I8oxikSvoTM
 qgFdXrnQS6ZtSBDnOZW+10oJCh2gQ95hZ9QXfh+LCQz9KOgPP3/JnYeBT9gqsx3J1csskDFkRbj
 y3hVN7dN9JRejAAuSV+5mggzEDFqJXIHXs9QZLeguZWW1sU21pSPUHRQ4zuhyrpu0sYPEWDw3bC
 vG+SJ8Ke/QPb1vPPwL2lbhjBAkcPCBRC49wqfjlpe+StmqOrsFqKlkYlLPNklsAyoYXxfvBJuOA
 LxcwHvmt4vLkWU8xWjV+KZJxiZttdVGuevjHzhJejoSepY872rw4hATvf80H0FVAIYIxoE0ggEk
 99X7/8BnIG1E6XLSaQwDoa64M3YJffLFWVDYiuNo5sc2o5m4OAXkQN4St4WgKOZnuTBiYHoGv4M
 IYjNBcgYF0Ht/gBRUebDMGAbFXk0jvOIfe62GxI1xvWJ6uOMpBncBAe254NNkKafn8d4mCToX73
 RM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'git bundle create' command has non-linear performance with the
number of refs in the repository. Benchmarking the command shows that
a large portion of the time (~75%) is spent in the
`object_array_remove_duplicates()` function.

The `object_array_remove_duplicates()` function was added in
b2a6d1c686 (bundle: allow the same ref to be given more than once,
2009-01-17) to skip duplicate refs provided by the user from being
written to the bundle. Since this is an O(N^2) algorithm, in repos with
large number of references, this can take up a large amount of time.

Let's instead use a 'strset' to skip duplicates inside
`write_bundle_refs()`. This improves the performance by around 6 times
when tested against in repository with 100000 refs:

Benchmark 1: bundle (refcount = 100000, revision = master)
  Time (mean ± σ):     14.653 s ±  0.203 s    [User: 13.940 s, System: 0.762 s]
  Range (min … max):   14.237 s … 14.920 s    10 runs

Benchmark 2: bundle (refcount = 100000, revision = HEAD)
  Time (mean ± σ):      2.394 s ±  0.023 s    [User: 1.684 s, System: 0.798 s]
  Range (min … max):    2.364 s …  2.425 s    10 runs

Summary
  bundle (refcount = 100000, revision = HEAD) ran
    6.12 ± 0.10 times faster than bundle (refcount = 100000, revision = master)

Previously, `object_array_remove_duplicates()` ensured that both the
refname and the object it pointed to were checked for duplicates. The
new approach, implemented within `write_bundle_refs()`, eliminates
duplicate refnames without comparing the objects they reference. This
works because, for bundle creation, we only need to prevent duplicate
refs from being written to the bundle header. The `revs->pending` array
can contain duplicates of multiple types.

First, references which resolve to the same refname. For e.g. "git
bundle create out.bdl master master" or "git bundle create out.bdl
refs/heads/master refs/heads/master" or "git bundle create out.bdl
master refs/heads/master". In these scenarios we want to prevent writing
"refs/heads/master" twice to the bundle header. Since both the refnames
here would point to the same object (unless there is a race), we do not
need to check equality of the object.

Second, refnames which are duplicates but do not point to the same
object. This can happen when we use an exclusion criteria. For e.g. "git
bundle create out.bdl master master^!", Here `revs->pending` would
contain two elements, both with refname set to "master". However, each
of them would be pointing to an INTERESTING and UNINTERESTING object
respectively. Since we only write refnames with INTERESTING objects to
the bundle header, we perform our duplicate checks only on such objects.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 bundle.c               |  8 +++++++-
 object.c               | 33 ---------------------------------
 object.h               |  6 ------
 t/t6020-bundle-misc.sh |  4 ----
 4 files changed, 7 insertions(+), 44 deletions(-)

diff --git a/bundle.c b/bundle.c
index d7ad690843..0614426e20 100644
--- a/bundle.c
+++ b/bundle.c
@@ -384,6 +384,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 {
 	int i;
 	int ref_count = 0;
+	struct strset objects = STRSET_INIT;
 
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *e = revs->pending.objects + i;
@@ -401,6 +402,9 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 			flag = 0;
 		display_ref = (flag & REF_ISSYMREF) ? e->name : ref;
 
+		if (strset_contains(&objects, display_ref))
+			goto skip_write_ref;
+
 		if (e->item->type == OBJ_TAG &&
 				!is_tag_in_date_range(e->item, revs)) {
 			e->item->flags |= UNINTERESTING;
@@ -423,6 +427,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 		}
 
 		ref_count++;
+		strset_add(&objects, display_ref);
 		write_or_die(bundle_fd, oid_to_hex(&e->item->oid), the_hash_algo->hexsz);
 		write_or_die(bundle_fd, " ", 1);
 		write_or_die(bundle_fd, display_ref, strlen(display_ref));
@@ -431,6 +436,8 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 		free(ref);
 	}
 
+	strset_clear(&objects);
+
 	/* end header */
 	write_or_die(bundle_fd, "\n", 1);
 	return ref_count;
@@ -566,7 +573,6 @@ int create_bundle(struct repository *r, const char *path,
 	 */
 	revs.blob_objects = revs.tree_objects = 0;
 	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
-	object_array_remove_duplicates(&revs_copy.pending);
 
 	/* write bundle refs */
 	ref_count = write_bundle_refs(bundle_fd, &revs_copy);
diff --git a/object.c b/object.c
index 100bf9b8d1..a2c5986178 100644
--- a/object.c
+++ b/object.c
@@ -491,39 +491,6 @@ void object_array_clear(struct object_array *array)
 	array->nr = array->alloc = 0;
 }
 
-/*
- * Return true if array already contains an entry.
- */
-static int contains_object(struct object_array *array,
-			   const struct object *item, const char *name)
-{
-	unsigned nr = array->nr, i;
-	struct object_array_entry *object = array->objects;
-
-	for (i = 0; i < nr; i++, object++)
-		if (item == object->item && !strcmp(object->name, name))
-			return 1;
-	return 0;
-}
-
-void object_array_remove_duplicates(struct object_array *array)
-{
-	unsigned nr = array->nr, src;
-	struct object_array_entry *objects = array->objects;
-
-	array->nr = 0;
-	for (src = 0; src < nr; src++) {
-		if (!contains_object(array, objects[src].item,
-				     objects[src].name)) {
-			if (src != array->nr)
-				objects[array->nr] = objects[src];
-			array->nr++;
-		} else {
-			object_array_release_entry(&objects[src]);
-		}
-	}
-}
-
 void clear_object_flags(unsigned flags)
 {
 	int i;
diff --git a/object.h b/object.h
index 17f32f1103..0e12c75922 100644
--- a/object.h
+++ b/object.h
@@ -324,12 +324,6 @@ typedef int (*object_array_each_func_t)(struct object_array_entry *, void *);
 void object_array_filter(struct object_array *array,
 			 object_array_each_func_t want, void *cb_data);
 
-/*
- * Remove from array all but the first entry with a given name.
- * Warning: this function uses an O(N^2) algorithm.
- */
-void object_array_remove_duplicates(struct object_array *array);
-
 /*
  * Remove any objects from the array, freeing all used memory; afterwards
  * the array is ready to store more objects with add_object_array().
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index dd09df1287..500c81b8a1 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -684,7 +684,6 @@ test_expect_success 'create bundle with duplicate refnames' '
 	test_cmp expect actual
 '
 
-# This exhibits a bug, since the same refname is now added to the bundle twice.
 test_expect_success 'create bundle with duplicate refnames and --all' '
 	git bundle create out.bdl --all "main" "main" &&
 
@@ -701,7 +700,6 @@ test_expect_success 'create bundle with duplicate refnames and --all' '
 	<TAG-2> refs/tags/v2
 	<TAG-3> refs/tags/v3
 	<COMMIT-P> HEAD
-	<COMMIT-P> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
@@ -717,7 +715,6 @@ test_expect_success 'create bundle with duplicate exlusion refnames' '
 	test_cmp expect actual
 '
 
-# This exhibits a bug, since the same refname is now added to the bundle twice.
 test_expect_success 'create bundle with duplicate refname short-form' '
 	git bundle create out.bdl "main" "main" "refs/heads/main" "refs/heads/main" &&
 
@@ -725,7 +722,6 @@ test_expect_success 'create bundle with duplicate refname short-form' '
 		make_user_friendly_and_stable_output >actual &&
 	cat >expect <<-\EOF &&
 	<COMMIT-P> refs/heads/main
-	<COMMIT-P> refs/heads/main
 	EOF
 	test_cmp expect actual
 '

-- 
2.48.1

