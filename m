Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6513F3D5243
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903186; cv=none; b=augJcwMsFtel1ivqluE6MZbBRFnkJm7CMLjhOZfTYE6OXnIbYKhFnQXLs8lZEF+bJruOPsTZapqJUM7SXLOM8QB9JrCczKfDjQ4fHtD+/h+ttrwG/+Kr1IJKVqwQ38VHexQzDyHIy+TG0bs9fAOxKsYP85ekfVeBOn2EKddxN5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903186; c=relaxed/simple;
	bh=1o1OqEM4vGJ+9voTC8Lh6BxpYhtsFFgCh7Edm4PPdtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VX4pSSIqv7Q/aZ6+oUU6cJbKcnWZswEzxB1k9mvnvaFpbnvIoJOL58C7l2Vzn/G/PMsvtb5DLgl+1J+/mjpmW9myIYJl259G0W3q0CyQrcOBBrs/lHwgdcr7r3amRchEy0VyqV8ZxzC/rztMdBgPekVRAEzwpjfaZifn0oLTSPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfeWWwH3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfeWWwH3"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fbc305914so4205419f8f.0
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 01:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768903182; x=1769507982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/z5RpW3pchwFlgS3fZdGOHEQ+0671WFzbQ18+lht6Z4=;
        b=bfeWWwH38BhFlVTAjGe1kBi7DRSvKT0ogNE/OK2Z1H2x0BnzHdnDK/rSsXrc0yKYct
         y6goIRHQFPNWR44pMjY7ivcIYeO7QbmZE3ekEgFgJqo+oI+08SiRfIxVsQyT4QiofIml
         Q/hqrOd5jEukXJRY7fJy6TGx/Xdvp/2EDC05cl8MOOGfZ2bgm1lmTkFwywsPCfctjRkt
         dG65JeLO/9J8YjX0pSUQrbQ1rKO9YccziA99/UGuiCHKyJQH3zIEHTx3Q8RB5Uv1ryc9
         0oJjqXhC229EGNcjpL9dQOhLDqjs0HlBTOlO4aAPBGTYbrZTytZPYSujeutLcQ5Ya0Z/
         SS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903182; x=1769507982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/z5RpW3pchwFlgS3fZdGOHEQ+0671WFzbQ18+lht6Z4=;
        b=dPNowtx/f27EHGI2NtAEtUTlgDaHeMWdpIPg5GD/nvutU6Cys89hCxUWvTvKMon3yV
         KV2OOsRxRBDDKEdSsZib6ZFML47MPjojmQHOvUj5BQQhc39VrFXAoIuCZ1ihBi97kv+5
         dBi6z10hbsu92gR96vHxTzTyYSrkYhrQUemyaqqF+aAxjuTEy1HM0FBdR+jdybA7kLab
         Fut1xT5Gpwv+CLgaBJUjYiCKJBMiW9oqs0RuQO8V2ffNNf1MnrZ0fUR5wAH3W5ajqT5h
         THDfcEwbnheTvqu0m5n15jUbc0WQ+Rvi0spKgkzasciW3bY6qVi778RsxbDzrHlHp8uz
         D06w==
X-Gm-Message-State: AOJu0YxLbUMLS9Zp9HQek6MXHLn9kedSuyZFwpMMoQ1JbsMPmCBljQFp
	iLrpYzfNvKxXAy82B4Q8qoDGLEniO2HCn7UrjeLDXQhM15KGI17PUoG7
X-Gm-Gg: AZuq6aIMjZPhkQkq6xdOU+vlvtnb713Kbn+vspzACOjtJCo/QKE8dgPP1K9/T7GVSZY
	ySFyXJZJb+jLp0JBC7qgiRf+FsZtRJbysqhbuwhjnRbUPO1w8MTeABz+FsKEjYBfpy+/5L3Wxyy
	iZ1Xof/ABBeekVCT8zeKiVOjmC90RcJ93PlDayvQKln5yvY0QsKHTUeFBfShx/uEHmlpvyMMJZe
	Nn5gzLLTbh+8MzEisOuaL5yAzbsg2JJSLhajtH5lP+eOHxVZgufBOL85BV10M+AJahotKilP8+L
	A7PmoRAprVljPLo+e6o8cxMQCVEoP3Setx5Lm+BJZAr7K9MjEB0ArBeJutP93qm4YWWB6eLgTct
	9tQuBYvG5F3OaDqTZUlkwnE4dpJ6T74qx83XDqzSmrQXSQH3PQSUzWhUiqGKYHCawkHRZ2+UOfd
	pmIFZvonyINbxANGR5ow==
X-Received: by 2002:a05:6000:605:b0:42f:9f4d:a4b2 with SMTP id ffacd0b85a97d-4358fed7960mr1857023f8f.19.1768903181493;
        Tue, 20 Jan 2026 01:59:41 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:9d17:c155:e8f0:9505])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921f6esm27879778f8f.4.2026.01.20.01.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:59:41 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 20 Jan 2026 10:59:24 +0100
Subject: [PATCH v3 6/6] fetch: delay user information post committing of
 transaction
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-6-e0edb29acbef@gmail.com>
References: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com>
In-Reply-To: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 newren@gmail.com, gitster@pobox.com, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=19454;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=1o1OqEM4vGJ+9voTC8Lh6BxpYhtsFFgCh7Edm4PPdtY=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlvUgf6l4AXIGxgbiLrUKQKSS8xM7Lbh+xCI
 db54u54CopBb4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpb1IHAAoJED7VnySO
 Rox/g5IMAIQH3IuM+aSKYlnB1rsqBdBlJDAs/VUBOnuFoTDTjx48/wy2L+zQDBvFw9hOtQNmv4M
 utdc6lsiNsYyd86b4FS8n0ZXdktROXohNsEnJbeznBBpFyP8MA5RVu7GaUWJdEQ8Odq5LgGu27D
 l3wtGxV8THIQpzQpXAj/J4pjx7pdVVM4Sr87MnaQPaojq3hXyoDhU4tpNOKnaMnQGRbLeFm9AEL
 O7yo6Cn4XXlUm2Nkp9SPFjlxttQT5p5pz2wTBaQ0+I2ZEEus3K/q8Bp82WCQFcXUtbVKaOMS55h
 Vm8agT8O0V56souNND34W82jY5CpUjqfN+voX0rM0Mb34xmuVAUlr5VAruSswX9ahFztXCsyb3W
 hs8uoXo8vhDPrT9GmAxm4xLbSiLtg4OOyBMPiy+6GlfOkTHfyNkToHyGH6WeH98LzsmtLFg/Q8y
 eMfSnABBdfO9LSbhMHEgqKj7ZCZ8MIQfXT6uc83Iqp3/HsgWnXOn+O0diNeY5z4/c2Y+QeRC5u6
 +s=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In Git 2.50 and earlier, we would display failure codes and error
message as part of the status display:

  $ git fetch . v1.0.0:refs/heads/foo
    error: cannot update ref 'refs/heads/foo': trying to write non-commit object f665776185ad074b236c00751d666da7d1977dbe to branch 'refs/heads/foo'
    From .
     ! [new tag]               v1.0.0     -> foo  (unable to update local ref)

With the addition of batched updates, this information is no longer
shown to the user:

  $ git fetch . v1.0.0:refs/heads/foo
    From .
     * [new tag]               v1.0.0     -> foo
    error: cannot update ref 'refs/heads/foo': trying to write non-commit object f665776185ad074b236c00751d666da7d1977dbe to branch 'refs/heads/foo'

Since reference updates are batched and processed together at the end,
information around the outcome is not available during individual
reference parsing.

To overcome this, collate and delay the output to the end. Introduce
`ref_update_display_info` which will hold individual update's
information and also whether the update failed or succeeded. This
finally allows us to iterate over all such updates and print them to the
user.

Using an dynamic array and strmap does add some overhead to
'git-fetch(1)', but from benchmarking this seems to be not too bad:

  Benchmark 1: fetch: many refs (refformat = files, refcount = 1000, revision = master)
    Time (mean ± σ):      42.6 ms ±   1.2 ms    [User: 13.1 ms, System: 29.8 ms]
    Range (min … max):    40.1 ms …  45.8 ms    47 runs

  Benchmark 2: fetch: many refs (refformat = files, refcount = 1000, revision = HEAD)
    Time (mean ± σ):      43.1 ms ±   1.2 ms    [User: 12.7 ms, System: 30.7 ms]
    Range (min … max):    40.5 ms …  45.8 ms    48 runs

  Summary
    fetch: many refs (refformat = files, refcount = 1000, revision = master) ran
      1.01 ± 0.04 times faster than fetch: many refs (refformat = files, refcount = 1000, revision = HEAD)

Another approach would be to move the status printing logic to be
handled post the transaction being committed. That however would require
adding an iterator to the ref transaction that tracks both the outcome
(success/failure) and the original refspec information for each update,
which is more involved infrastructure work compared to the strmap
approach here.

Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c       | 250 +++++++++++++++++++++++++++++++++++++++-----------
 t/t5516-fetch-push.sh |   1 +
 2 files changed, 197 insertions(+), 54 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 49495be0b6..3a3f1d8914 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -861,12 +861,87 @@ static void display_ref_update(struct display_state *display_state, char code,
 	fputs(display_state->buf.buf, f);
 }
 
+struct ref_update_display_info {
+	bool failed;
+	char success_code;
+	char fail_code;
+	const char *summary;
+	const char *fail_detail;
+	const char *success_detail;
+	const char *ref;
+	const char *remote;
+	struct object_id old_oid;
+	struct object_id new_oid;
+};
+
+static struct ref_update_display_info *ref_update_display_info_append(
+					   struct ref_update_display_info **list,
+					   size_t *count,
+					   char success_code,
+					   char fail_code,
+					   const char *summary,
+					   const char *success_detail,
+					   const char *fail_detail,
+					   const char *ref,
+					   const char *remote,
+					   const struct object_id *old_oid,
+					   const struct object_id *new_oid)
+{
+	struct ref_update_display_info *info;
+	size_t index = *count;
+
+	(*count)++;
+	REALLOC_ARRAY(*list, *count);
+
+	info = &(*list)[index];
+
+	info->failed = false;
+	info->success_code = success_code;
+	info->fail_code = fail_code;
+	info->summary = xstrdup(summary);
+	info->success_detail = xstrdup_or_null(success_detail);
+	info->fail_detail = xstrdup_or_null(fail_detail);
+	info->remote = xstrdup(remote);
+	info->ref = xstrdup(ref);
+
+	oidcpy(&info->old_oid, old_oid);
+	oidcpy(&info->new_oid, new_oid);
+
+	return info;
+}
+
+static void ref_update_display_info_set_failed(struct ref_update_display_info *info)
+{
+	info->failed = true;
+}
+
+static void ref_update_display_info_free(struct ref_update_display_info *info)
+{
+	free((char *)info->summary);
+	free((char *)info->success_detail);
+	free((char *)info->fail_detail);
+	free((char *)info->remote);
+	free((char *)info->ref);
+}
+
+static void ref_update_display_info_display(struct ref_update_display_info *info,
+					    struct display_state *display_state,
+					    int summary_width)
+{
+	display_ref_update(display_state,
+			   info->failed ? info->fail_code : info->success_code,
+			   info->summary,
+			   info->failed ? info->fail_detail : info->success_detail,
+			   info->remote, info->ref, &info->old_oid,
+			   &info->new_oid, summary_width);
+}
+
 static int update_local_ref(struct ref *ref,
 			    struct ref_transaction *transaction,
-			    struct display_state *display_state,
 			    const struct ref *remote_ref,
-			    int summary_width,
-			    const struct fetch_config *config)
+			    const struct fetch_config *config,
+			    struct ref_update_display_info **display_list,
+			    size_t *display_count)
 {
 	struct commit *current = NULL, *updated;
 	int fast_forward = 0;
@@ -877,41 +952,56 @@ static int update_local_ref(struct ref *ref,
 
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
-			display_ref_update(display_state, '=', _("[up to date]"), NULL,
-					   remote_ref->name, ref->name,
-					   &ref->old_oid, &ref->new_oid, summary_width);
+			ref_update_display_info_append(display_list, display_count,
+						       '=', '=', _("[up to date]"),
+						       NULL, NULL, ref->name,
+						       remote_ref->name, &ref->old_oid,
+						       &ref->new_oid);
 		return 0;
 	}
 
 	if (!update_head_ok &&
 	    !is_null_oid(&ref->old_oid) &&
 	    branch_checked_out(ref->name)) {
+		struct ref_update_display_info *info;
 		/*
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
-		display_ref_update(display_state, '!', _("[rejected]"),
-				   _("can't fetch into checked-out branch"),
-				   remote_ref->name, ref->name,
-				   &ref->old_oid, &ref->new_oid, summary_width);
+		info = ref_update_display_info_append(display_list, display_count,
+						      '!', '!', _("[rejected]"),
+						      NULL, _("can't fetch into checked-out branch"),
+						      ref->name, remote_ref->name,
+						      &ref->old_oid, &ref->new_oid);
+		ref_update_display_info_set_failed(info);
 		return 1;
 	}
 
 	if (!is_null_oid(&ref->old_oid) &&
 	    starts_with(ref->name, "refs/tags/")) {
+		struct ref_update_display_info *info;
+
 		if (force || ref->force) {
 			int r;
+
 			r = s_update_ref("updating tag", ref, transaction, 0);
-			display_ref_update(display_state, r ? '!' : 't', _("[tag update]"),
-					   r ? _("unable to update local ref") : NULL,
-					   remote_ref->name, ref->name,
-					   &ref->old_oid, &ref->new_oid, summary_width);
+
+			info = ref_update_display_info_append(display_list, display_count,
+							      't', '!', _("[tag update]"), NULL,
+							      _("unable to update local ref"),
+							      ref->name, remote_ref->name,
+							      &ref->old_oid, &ref->new_oid);
+			if (r)
+				ref_update_display_info_set_failed(info);
+
 			return r;
 		} else {
-			display_ref_update(display_state, '!', _("[rejected]"),
-					   _("would clobber existing tag"),
-					   remote_ref->name, ref->name,
-					   &ref->old_oid, &ref->new_oid, summary_width);
+			info = ref_update_display_info_append(display_list, display_count,
+							      '!', '!', _("[rejected]"), NULL,
+							      _("would clobber existing tag"),
+							      ref->name, remote_ref->name,
+							      &ref->old_oid, &ref->new_oid);
+			ref_update_display_info_set_failed(info);
 			return 1;
 		}
 	}
@@ -921,6 +1011,7 @@ static int update_local_ref(struct ref *ref,
 	updated = lookup_commit_reference_gently(the_repository,
 						 &ref->new_oid, 1);
 	if (!current || !updated) {
+		struct ref_update_display_info *info;
 		const char *msg;
 		const char *what;
 		int r;
@@ -941,10 +1032,15 @@ static int update_local_ref(struct ref *ref,
 		}
 
 		r = s_update_ref(msg, ref, transaction, 0);
-		display_ref_update(display_state, r ? '!' : '*', what,
-				   r ? _("unable to update local ref") : NULL,
-				   remote_ref->name, ref->name,
-				   &ref->old_oid, &ref->new_oid, summary_width);
+
+		info = ref_update_display_info_append(display_list, display_count,
+						      '*', '!', what, NULL,
+						      _("unable to update local ref"),
+						      ref->name, remote_ref->name,
+						      &ref->old_oid, &ref->new_oid);
+		if (r)
+			ref_update_display_info_set_failed(info);
+
 		return r;
 	}
 
@@ -960,6 +1056,7 @@ static int update_local_ref(struct ref *ref,
 	}
 
 	if (fast_forward) {
+		struct ref_update_display_info *info;
 		struct strbuf quickref = STRBUF_INIT;
 		int r;
 
@@ -967,29 +1064,46 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		r = s_update_ref("fast-forward", ref, transaction, 1);
-		display_ref_update(display_state, r ? '!' : ' ', quickref.buf,
-				   r ? _("unable to update local ref") : NULL,
-				   remote_ref->name, ref->name,
-				   &ref->old_oid, &ref->new_oid, summary_width);
+
+		info = ref_update_display_info_append(display_list, display_count,
+						      ' ', '!', quickref.buf, NULL,
+						      _("unable to update local ref"),
+						      ref->name, remote_ref->name,
+						      &ref->old_oid, &ref->new_oid);
+		if (r)
+			ref_update_display_info_set_failed(info);
+
 		strbuf_release(&quickref);
 		return r;
 	} else if (force || ref->force) {
+		struct ref_update_display_info *info;
 		struct strbuf quickref = STRBUF_INIT;
 		int r;
+
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
 		strbuf_addstr(&quickref, "...");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		r = s_update_ref("forced-update", ref, transaction, 1);
-		display_ref_update(display_state, r ? '!' : '+', quickref.buf,
-				   r ? _("unable to update local ref") : _("forced update"),
-				   remote_ref->name, ref->name,
-				   &ref->old_oid, &ref->new_oid, summary_width);
+
+		info = ref_update_display_info_append(display_list, display_count,
+						      '+', '!', quickref.buf, _("forced update"),
+						      _("unable to update local ref"),
+						      ref->name, remote_ref->name,
+						      &ref->old_oid, &ref->new_oid);
+
+		if (r)
+			ref_update_display_info_set_failed(info);
+
 		strbuf_release(&quickref);
 		return r;
 	} else {
-		display_ref_update(display_state, '!', _("[rejected]"), _("non-fast-forward"),
-				   remote_ref->name, ref->name,
-				   &ref->old_oid, &ref->new_oid, summary_width);
+		struct ref_update_display_info *info;
+		info = ref_update_display_info_append(display_list, display_count,
+						      '!', '!', _("[rejected]"), NULL,
+						      _("non-fast-forward"),
+						      ref->name, remote_ref->name,
+						      &ref->old_oid, &ref->new_oid);
+		ref_update_display_info_set_failed(info);
 		return 1;
 	}
 }
@@ -1103,17 +1217,15 @@ static int store_updated_refs(struct display_state *display_state,
 			      int connectivity_checked,
 			      struct ref_transaction *transaction, struct ref *ref_map,
 			      struct fetch_head *fetch_head,
-			      const struct fetch_config *config)
+			      const struct fetch_config *config,
+			      struct ref_update_display_info **display_list,
+			      size_t *display_count)
 {
 	int rc = 0;
 	struct strbuf note = STRBUF_INIT;
 	const char *what, *kind;
 	struct ref *rm;
 	int want_status;
-	int summary_width = 0;
-
-	if (verbosity >= 0)
-		summary_width = transport_summary_width(ref_map);
 
 	if (!connectivity_checked) {
 		struct check_connected_options opt = CHECK_CONNECTED_INIT;
@@ -1218,8 +1330,9 @@ static int store_updated_refs(struct display_state *display_state,
 					  display_state->url_len);
 
 			if (ref) {
-				rc |= update_local_ref(ref, transaction, display_state,
-						       rm, summary_width, config);
+				rc |= update_local_ref(ref, transaction, rm,
+						       config, display_list,
+						       display_count);
 				free(ref);
 			} else if (write_fetch_head || dry_run) {
 				/*
@@ -1227,12 +1340,11 @@ static int store_updated_refs(struct display_state *display_state,
 				 * would be written to FETCH_HEAD, if --dry-run
 				 * is set).
 				 */
-				display_ref_update(display_state, '*',
-						   *kind ? kind : "branch", NULL,
-						   rm->name,
-						   "FETCH_HEAD",
-						   &rm->new_oid, &rm->old_oid,
-						   summary_width);
+
+				ref_update_display_info_append(display_list, display_count,
+							       '*', '*', *kind ? kind : "branch",
+							       NULL, NULL, "FETCH_HEAD", rm->name,
+							       &rm->new_oid, &rm->old_oid);
 			}
 		}
 	}
@@ -1300,7 +1412,9 @@ static int fetch_and_consume_refs(struct display_state *display_state,
 				  struct ref_transaction *transaction,
 				  struct ref *ref_map,
 				  struct fetch_head *fetch_head,
-				  const struct fetch_config *config)
+				  const struct fetch_config *config,
+				  struct ref_update_display_info **display_list,
+				  size_t *display_count)
 {
 	int connectivity_checked = 1;
 	int ret;
@@ -1322,7 +1436,8 @@ static int fetch_and_consume_refs(struct display_state *display_state,
 
 	trace2_region_enter("fetch", "consume_refs", the_repository);
 	ret = store_updated_refs(display_state, connectivity_checked,
-				 transaction, ref_map, fetch_head, config);
+				 transaction, ref_map, fetch_head, config,
+				 display_list, display_count);
 	trace2_region_leave("fetch", "consume_refs", the_repository);
 
 out:
@@ -1493,7 +1608,9 @@ static int backfill_tags(struct display_state *display_state,
 			 struct ref_transaction *transaction,
 			 struct ref *ref_map,
 			 struct fetch_head *fetch_head,
-			 const struct fetch_config *config)
+			 const struct fetch_config *config,
+			 struct ref_update_display_info **display_list,
+			 size_t *display_count)
 {
 	int retcode, cannot_reuse;
 
@@ -1515,7 +1632,7 @@ static int backfill_tags(struct display_state *display_state,
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
 	retcode = fetch_and_consume_refs(display_state, transport, transaction, ref_map,
-					 fetch_head, config);
+					 fetch_head, config, display_list, display_count);
 
 	if (gsecondary) {
 		transport_disconnect(gsecondary);
@@ -1641,6 +1758,7 @@ struct ref_rejection_data {
 	bool conflict_msg_shown;
 	bool case_sensitive_msg_shown;
 	const char *remote_name;
+	struct strmap *rejected_refs;
 };
 
 static void ref_transaction_rejection_handler(const char *refname,
@@ -1681,6 +1799,7 @@ static void ref_transaction_rejection_handler(const char *refname,
 			      refname, ref_transaction_error_msg(err));
 	}
 
+	strmap_put(data->rejected_refs, refname, NULL);
 	*data->retcode = 1;
 }
 
@@ -1690,6 +1809,7 @@ static void ref_transaction_rejection_handler(const char *refname,
  */
 static int commit_ref_transaction(struct ref_transaction **transaction,
 				  bool is_atomic, const char *remote_name,
+				  struct strmap *rejected_refs,
 				  struct strbuf *err)
 {
 	int retcode = ref_transaction_commit(*transaction, err);
@@ -1701,6 +1821,7 @@ static int commit_ref_transaction(struct ref_transaction **transaction,
 			.conflict_msg_shown = 0,
 			.remote_name = remote_name,
 			.retcode = &retcode,
+			.rejected_refs = rejected_refs,
 		};
 
 		ref_transaction_for_each_rejected_update(*transaction,
@@ -1729,6 +1850,10 @@ static int do_fetch(struct transport *transport,
 	struct fetch_head fetch_head = { 0 };
 	struct strbuf err = STRBUF_INIT;
 	int do_set_head = 0;
+	struct ref_update_display_info *display_list = NULL;
+	struct strmap rejected_refs = STRMAP_INIT;
+	size_t display_count = 0;
+	int summary_width = 0;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1853,7 +1978,7 @@ static int do_fetch(struct transport *transport,
 	}
 
 	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
-				   &fetch_head, config)) {
+				   &fetch_head, config, &display_list, &display_count)) {
 		retcode = 1;
 		goto cleanup;
 	}
@@ -1876,7 +2001,7 @@ static int do_fetch(struct transport *transport,
 			 * the transaction and don't commit anything.
 			 */
 			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
-					  &fetch_head, config))
+					  &fetch_head, config, &display_list, &display_count))
 				retcode = 1;
 		}
 
@@ -1886,8 +2011,12 @@ static int do_fetch(struct transport *transport,
 	if (retcode)
 		goto cleanup;
 
+	if (verbosity >= 0)
+		summary_width = transport_summary_width(ref_map);
+
 	retcode = commit_ref_transaction(&transaction, atomic_fetch,
-					 transport->remote->name, &err);
+					 transport->remote->name,
+					 &rejected_refs, &err);
 	/*
 	 * With '--atomic', bail out if the transaction fails. Without '--atomic',
 	 * continue to fetch head and perform other post-fetch operations.
@@ -1965,7 +2094,17 @@ static int do_fetch(struct transport *transport,
 	 */
 	if (retcode && !atomic_fetch && transaction)
 		commit_ref_transaction(&transaction, false,
-				       transport->remote->name, &err);
+				       transport->remote->name,
+				       &rejected_refs, &err);
+
+	for (size_t i = 0; i < display_count; i++) {
+		struct ref_update_display_info *info = &display_list[i];
+
+		if (!info->failed && strmap_contains(&rejected_refs, info->ref))
+			ref_update_display_info_set_failed(info);
+		ref_update_display_info_display(info, &display_state, summary_width);
+		ref_update_display_info_free(info);
+	}
 
 	if (retcode) {
 		if (err.len) {
@@ -1980,6 +2119,9 @@ static int do_fetch(struct transport *transport,
 
 	if (transaction)
 		ref_transaction_free(transaction);
+
+	free(display_list);
+	strmap_clear(&rejected_refs, 0);
 	display_state_release(&display_state);
 	close_fetch_head(&fetch_head);
 	strbuf_release(&err);
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 45595991c8..29e2f17608 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1893,6 +1893,7 @@ test_expect_success 'pushing non-commit objects should report error' '
 
 		tagsha=$(git rev-parse test^{tag}) &&
 		test_must_fail git push ../dest "$tagsha:refs/heads/branch" 2>err &&
+		test_grep "! \[remote rejected\] $tagsha -> branch (invalid new value provided)" err &&
 		test_grep "trying to write non-commit object $tagsha to branch ${SQ}refs/heads/branch${SQ}" err
 	)
 '

-- 
2.51.2

