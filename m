Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38CE23F28D
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751402575; cv=none; b=Thu5g35nx/l+HPD3s0sYiBCuAiRy+nH9ZyvzoEvyfofCKhufgpA+Lg8hvasw4Wjcqz+3wkQjKzE56idxxynmu7kU0cvfvO9xpjrMXYOZ1k1CSptDpZ+iunNHUEg8QPsdC5LUhn14tcJBCC06TnBc3O5k82YaNV4+oTKHuZU+GdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751402575; c=relaxed/simple;
	bh=OexY/Dijcufn+tJQxVVS96vLxJ1EOf9LW6aV2Ei5QNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U95tfA437Lz991mbDTD2XAzIYep26zoPunan2xele1WvQx9cKmjHesWQr06h2kRfZoDOBIDaafOx85tzUmqhs9MOyI/BujxkKugDL/4OpSXS1W3+/xiLkeJAQXeFsMbF7j2Ulc2SxiZ9hxxKVTOeOpc8dZfCaUQZ+o9ks7op7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKCVrnm3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKCVrnm3"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7490cb9a892so4358275b3a.0
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 13:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751402573; x=1752007373; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=id7NCp9YL29EQY/81AiwmaaEymysUN7AWeNS14CoRNw=;
        b=OKCVrnm3APgPkT0gRbr3w9QVommcXDVZyKE+uWMBks6rhREvM+G+v9yq8Imq5TjidZ
         2Vt2JBYa+77OTG7lODHZ+2k+MGzCcttL2PEs10Af55mCZ/3F7bgI8rI7gENl8oR27YzP
         6JXE8c/RxN4pbgkBjh03RUzgdZGOaLHF/q6I8re+cmUesMf1Hk+eUdiwnyvdz1JuY+E/
         s8Eq5+0APK/PD5wrF6ejXNfBJhtuAI/i1MaF6q6wsz4dV3mwIhb0SetTuZfSpGCo4iFB
         OzmN9w+W5ye+NwWS5y+lCiwPPiHRPcSbSAElZ411ma/1LsMD1MYKwgrPgdfrKvtoVqW3
         CQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751402573; x=1752007373;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=id7NCp9YL29EQY/81AiwmaaEymysUN7AWeNS14CoRNw=;
        b=T4ruGj3YLLTK20j+uDfBHTja/QZy8vbw96s1wQ4tNyhh66N2w3cMhUl0C1EyjurMUF
         DJgJffrHq/+TDE+VNxt6WQbcsrpsXTLEcXXUHZCt12v249DcgR+P7Aw30QAG+3iyhf9C
         P/tyztE2BJWE1mF3ixE5jJlVUvw9a2SIEYb/cW+o9DTu5FK1wJywZNtO5elEXUhIyFT8
         YQtMkN3UoIV4fQ1SsGHyocLSAw6F9Q4ldpFDPgg/sfmDKzJUPWIjVASaXA5aNT3Xhvsv
         2WryGzVnzSUVWQClpK4jCWsIzFamIr3V2m7bbaDh+5Gs8WKEL1I/0exovq7p1lzJZLPL
         DvDA==
X-Forwarded-Encrypted: i=1; AJvYcCXLM+4KE9cpVTCz4LqZBrYAC1pSCylJ+81MCe6VvNaIdK++/6PZJop1W7fnsZVPcGwSFpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4rQsqW7Rlu6gJ4bDOuRVJFAzyXWldPQT4JQC40c4QDUnG3ifW
	4/xo8Mox5lXTPizcmsbkI1aKMtC5A0hPgKnx2WAVx+KroptW4QqvuYBL
X-Gm-Gg: ASbGncttYZP2Gxs1SaP1MUQbhNxX+IOGhdovdjA/L1xE1tzQuJeuw1hYoQoKt3QMOHZ
	XrJaR7FohPXWBRluox4AHeOQtBBdlk5rKD1Sj+cGvt9iDL8/utOp7+p/ZmnLk6sqwhRQN2gJeCO
	EI4XXb3e9hATr9/gjMWAeINmWPrera0WJdMkQMBpKvNDDgMfvLun6XUgbUEo3IklL///cWs0ll8
	FmZcrlyaAnK6jiC52ecASf8VtVIE+iivWHvmtKTo+uY1BM2UHrlz8+DplCpAlsu3lPbR6wLJTSL
	2KvkZ+GGK8HIFaIAIcYuKwekFD8D72Rx5IOLKlE1JgBCIg9G5e8UY22K15mUM9nW2s9RcoNcnoa
	sh8G56eLop9QTxUkgTbCf/D15Zco=
X-Google-Smtp-Source: AGHT+IHBGs3M9/0T4Tsa2D02vKvHkspu1a45TwztP+e3SeSIfBSymSHw7H3cYLJK94gAb6jMyA0fvA==
X-Received: by 2002:a05:6a21:328c:b0:21a:e091:ac25 with SMTP id adf61e73a8af0-222d7dbad9fmr902664637.6.1751402572818;
        Tue, 01 Jul 2025 13:42:52 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b34e31e8118sm9539694a12.64.2025.07.01.13.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 13:42:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Collin Funk
 <collin.funk1@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>
Subject: Re: .clang-format: how useful, how often used, and how well
 maintained?
In-Reply-To: <875xgcq9zf.fsf@iotcl.com> (Toon Claes's message of "Tue, 01 Jul
	2025 16:08:52 +0200")
References: <xmqqmsa3adpw.fsf@gitster.g>
	<aFR-Yf0PMj30ex2O@fruit.crustytoothpaste.net>
	<87msa3quzs.fsf@gmail.com>
	<aFSVhpnNnj6p3r7n@fruit.crustytoothpaste.net>
	<xmqqbjqi5tk3.fsf@gitster.g> <875xgcq9zf.fsf@iotcl.com>
Date: Tue, 01 Jul 2025 13:42:51 -0700
Message-ID: <xmqqh5zvk5h0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> I think the only way we can stop bikeshedding about formatting, is by
> adopting clang-format and make it's output the golden standard. We might
> not like it's output (similar to many people do not like `gofmt`s
> output), but it's a standard.

Having other people to blame when the tool leaves unreadable code
that is not easy to read is certainly handy.  But I care more about
the tool giving a reasonably readable result.  It is not about
people not "liking" it.

Here is what clang-format suggests on top of your "last-modified"
series.  For this particular example, the tool gets the resulting
format mostly right, except for an extra space after "foreach"
before the opening parenthesis.  I presume that this is some setting
in the .clang-format file can tweak?

There is one instance of 80-column line wrapping making the result
less easy to view.  If you need to wrap, keep related things
together, i.e. when you rewrite this line ...

-int last_modified_run(struct last_modified *lm, last_modified_callback cb, void *cbdata)

... we should not wrap after "cb," only because it is still shorter
than 80 columns.

+int last_modified_run(struct last_modified *lm, last_modified_callback cb,
+		      void *cbdata)

In fact, slightly busting the 80-column limit like the original had
would be easier to understand while coasting your eyes over the line.
If we need to wrap, we should do this instead ...

+int last_modified_run(struct last_modified *lm,
+		      last_modified_callback cb, void *cbdata)

... so that related things (i.e., the callback function and the
data fed to it) are kept together.

In this particular patch, there was only one such instance that the
tools output was noticeably more irritating than the original.  With
more excercise like this with enough positive experience (I do count
this one as positive, if we fix the space after "foreach"), I might
change my mind.

Anyway, here is the patch.

 builtin.h               |  3 ++-
 builtin/last-modified.c |  6 ++----
 git.c                   | 20 +++++++++++---------
 last-modified.c         | 26 ++++++++++++--------------
 last-modified.h         | 14 +++++---------
 5 files changed, 32 insertions(+), 37 deletions(-)

diff --git c/builtin.h i/builtin.h
index 6ed6759ec4..5f89e51c61 100644
--- c/builtin.h
+++ i/builtin.h
@@ -176,7 +176,8 @@ int cmd_hook(int argc, const char **argv, const char *prefix, struct repository
 int cmd_index_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_init_db(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_last_modified(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_last_modified(int argc, const char **argv, const char *prefix,
+		      struct repository *repo);
 int cmd_log_reflog(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_log(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_ls_files(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git c/builtin/last-modified.c i/builtin/last-modified.c
index 4ff058c302..86b98e7a46 100644
--- c/builtin/last-modified.c
+++ i/builtin/last-modified.c
@@ -23,10 +23,8 @@ static void show_entry(const char *path, const struct commit *commit, void *d)
 	fflush(stdout);
 }
 
-int cmd_last_modified(int argc,
-		   const char **argv,
-		   const char *prefix,
-		   struct repository *repo)
+int cmd_last_modified(int argc, const char **argv, const char *prefix,
+		      struct repository *repo)
 {
 	struct last_modified lm;
 
diff --git c/git.c i/git.c
index 65afc0d0e7..918d83762a 100644
--- c/git.c
+++ i/git.c
@@ -516,12 +516,10 @@ static struct cmd_struct commands[] = {
 	{ "check-attr", cmd_check_attr, RUN_SETUP },
 	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
 	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
-	{ "check-ref-format", cmd_check_ref_format, NO_PARSEOPT  },
+	{ "check-ref-format", cmd_check_ref_format, NO_PARSEOPT },
 	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
-	{ "checkout--worker", cmd_checkout__worker,
-		RUN_SETUP | NEED_WORK_TREE },
-	{ "checkout-index", cmd_checkout_index,
-		RUN_SETUP | NEED_WORK_TREE},
+	{ "checkout--worker", cmd_checkout__worker, RUN_SETUP | NEED_WORK_TREE },
+	{ "checkout-index", cmd_checkout_index, RUN_SETUP | NEED_WORK_TREE },
 	{ "cherry", cmd_cherry, RUN_SETUP },
 	{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
 	{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
@@ -578,10 +576,14 @@ static struct cmd_struct commands[] = {
 	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
 	{ "merge-index", cmd_merge_index, RUN_SETUP | NO_PARSEOPT },
 	{ "merge-ours", cmd_merge_ours, RUN_SETUP | NO_PARSEOPT },
-	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
-	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
-	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
-	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-recursive", cmd_merge_recursive,
+	  RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-recursive-ours", cmd_merge_recursive,
+	  RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-recursive-theirs", cmd_merge_recursive,
+	  RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-subtree", cmd_merge_recursive,
+	  RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-tree", cmd_merge_tree, RUN_SETUP },
 	{ "mktag", cmd_mktag, RUN_SETUP },
 	{ "mktree", cmd_mktree, RUN_SETUP },
diff --git c/last-modified.c i/last-modified.c
index 2097894c6e..f7f6a67d3b 100644
--- c/last-modified.c
+++ i/last-modified.c
@@ -19,8 +19,7 @@ struct last_modified_entry {
 };
 
 static void add_path_from_diff(struct diff_queue_struct *q,
-			       struct diff_options *opt UNUSED,
-			       void *data)
+			       struct diff_options *opt UNUSED, void *data)
 {
 	struct last_modified *lm = data;
 
@@ -72,9 +71,9 @@ static int populate_paths_from_revs(struct last_modified *lm)
 }
 
 static int last_modified_entry_hashcmp(const void *unused UNUSED,
-				    const struct hashmap_entry *hent1,
-				    const struct hashmap_entry *hent2,
-				    const void *path)
+				       const struct hashmap_entry *hent1,
+				       const struct hashmap_entry *hent2,
+				       const void *path)
 {
 	const struct last_modified_entry *ent1 =
 		container_of(hent1, const struct last_modified_entry, hashent);
@@ -83,10 +82,8 @@ static int last_modified_entry_hashcmp(const void *unused UNUSED,
 	return strcmp(ent1->path, path ? path : ent2->path);
 }
 
-int last_modified_init(struct last_modified *lm,
-		     struct repository *r,
-		     const char *prefix,
-		     int argc, const char **argv)
+int last_modified_init(struct last_modified *lm, struct repository *r,
+		       const char *prefix, int argc, const char **argv)
 {
 	memset(lm, 0, sizeof(*lm));
 	hashmap_init(&lm->paths, last_modified_entry_hashcmp, NULL, 0);
@@ -119,7 +116,7 @@ void last_modified_release(struct last_modified *lm)
 	struct hashmap_iter iter;
 	struct last_modified_entry *ent;
 
-	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent)
+	hashmap_for_each_entry (&lm->paths, &iter, ent, hashent)
 		clear_bloom_key(&ent->key);
 
 	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
@@ -213,7 +210,7 @@ static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
 	if (!filter)
 		return 1;
 
-	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
+	hashmap_for_each_entry (&lm->paths, &iter, ent, hashent) {
 		if (bloom_filter_contains(filter, &ent->key,
 					  lm->rev.bloom_filter_settings))
 			return 1;
@@ -221,7 +218,8 @@ static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
 	return 0;
 }
 
-int last_modified_run(struct last_modified *lm, last_modified_callback cb, void *cbdata)
+int last_modified_run(struct last_modified *lm, last_modified_callback cb,
+		      void *cbdata)
 {
 	struct last_modified_callback_data data;
 
@@ -245,8 +243,8 @@ int last_modified_run(struct last_modified *lm, last_modified_callback cb, void
 
 		if (data.commit->object.flags & BOUNDARY) {
 			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
-				       &data.commit->object.oid,
-				       "", &lm->rev.diffopt);
+				      &data.commit->object.oid, "",
+				      &lm->rev.diffopt);
 			diff_flush(&lm->rev.diffopt);
 		} else {
 			log_tree_commit(&lm->rev, data.commit);
diff --git c/last-modified.h i/last-modified.h
index 04d5a1a5b6..3e83094d77 100644
--- c/last-modified.h
+++ i/last-modified.h
@@ -13,23 +13,19 @@ struct last_modified {
 /*
  * Initialize the last-modified machinery using command line arguments.
  */
-int last_modified_init(struct last_modified *lm,
-		     struct repository *r,
-		     const char *prefix,
-		     int argc, const char **argv);
+int last_modified_init(struct last_modified *lm, struct repository *r,
+		       const char *prefix, int argc, const char **argv);
 
 void last_modified_release(struct last_modified *);
 
 typedef void (*last_modified_callback)(const char *path,
-				    const struct commit *commit,
-				    void *data);
+				       const struct commit *commit, void *data);
 
 /*
  * Run the last-modified traversal. For each path found the callback is called
  * passing the path, the commit, and the cbdata.
  */
-int last_modified_run(struct last_modified *lm,
-		   last_modified_callback cb,
-		   void *cbdata);
+int last_modified_run(struct last_modified *lm, last_modified_callback cb,
+		      void *cbdata);
 
 #endif /* LAST_MODIFIED_H */

