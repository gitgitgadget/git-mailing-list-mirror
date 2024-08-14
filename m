Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D813A40C
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618335; cv=none; b=qaGiIu+20TAlfSnwGAK7MgoLe69JbD78LMZUY+fuqEexEgDMuTkdgTRtPMsEMxIoh3RNqmq13Zv1bYBY3q5u0bRL0LNEb9dJEzEDoQt0WCS7RMYA0PO/PC1QKGp9JGbBVK6ZpUsZ4EOPR/Ih+ooElq04+yoTMg5tDq8Y3X3cDK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618335; c=relaxed/simple;
	bh=dAZYz0j98vNnestOGKXW2iOYHIoBsZx/oj1Z4PZF0eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGylVWYiKXM/8it3UjT00eBMOhtd+dhakL8hX4BRneeY/u+ks+rUt81z1mdfvCeZxD1mimE/yXhja0f7LszEhLaxpfSuX6kDNJeYcfOrNX1uTrcUkhwomUYszLJNyPI7NGIstYuCVizEZC1BVznMo3PtfLZNZscJgdz5IcnZTcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lZAT4CA2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DiO2Q7By; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lZAT4CA2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DiO2Q7By"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C4FDC1151A98;
	Wed, 14 Aug 2024 02:52:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 Aug 2024 02:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618332; x=1723704732; bh=95K6mA5Ybu
	4amAaRvVVRKZHzdzJH9x1N6WV3yk/phGA=; b=lZAT4CA27S/X/Wlmb5og5418gj
	DO+KAg8RmNFeRvVJHjmLoiI7/82yKpB1iSgpIIh2DUHT6bnBfaPMd/z3hUPXvbcD
	wpZtkTs1cmakxxLwwyy7DUewDe8wR3gC+uJ7SghF5xxN/gxCgPj6D+m6A22moSFV
	nIunGigEciwPw86eoqXQVmjNXJWb/09QcODedGpydv2c+sEI0bcVyTMnnmYPqmum
	WIBQIl0s3caN9fDaz4dyko7JRZaOEEadP+1OYJlFz3HRCfRMVEcoI3IdTVw7Zd4w
	Y+7gYw0HDKAT9zx1SVy0/ceOO2QXMzwlgTqT2OXyjf/DUJECWSk5ZUvxQAww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618332; x=1723704732; bh=95K6mA5Ybu4amAaRvVVRKZHzdzJH
	9x1N6WV3yk/phGA=; b=DiO2Q7ByzglugF+lY6vvMcBiNoX4q4PO8AK5FJnYNG1A
	SccWcMgcWx8hqgfFwoOBMekD/P2QUpWSUSwQ5EfSkYYbZK4MPi1kntR+ZGhVPfdN
	Y5c+aYugWPwrZrFux7ZoExY9vZC69zRBtC/I1uClKrl3mWRYQNinltYXYshd/163
	QD2vjHihiLPqxo1LY//gaO5vXZ/j6DCiMLHD1C2fnew9AFS7Y9aXluL/yJ/EmiZ3
	Qc/bwtKxvowS7Kv7sRkGhtpCsnF+YGWfg0/HeImtPoPbGkZ4vpSp2pEEynw+FC2M
	+R/j1rJDxIsQvDfwWcsIqKD6pA3FFjoS2Ck2mnlLSw==
X-ME-Sender: <xms:HFS8ZkAnBrYwfHP4G8DwAnHKWJ-TqwLF8B7C5YyVL6Il1L4iGnSWzg>
    <xme:HFS8ZmhS2P65nSW2c6IdbVRQSIg_K9-CimnT5ntz6IlU8Nf-xS2UTuWfpE-JGq2a8
    Z-ozplfM3Mt-wD6qA>
X-ME-Received: <xmr:HFS8ZnneZPsyYEJtMsjs-Iemj5bIxBdXWNxcuklxLE0wySc7WoH6uAGFlqR8W4o0VOMMhxAIjNRFAOyR_IvKSRHg2fCknDBxHG8v8pa5Y50j5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguud
    dvfeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:HFS8ZqzbQvRL2jSXbowgW2qmpOPVEkoIzw30ZqAz-S99wbjFplT3xA>
    <xmx:HFS8ZpTUp_j3JqV3eZrPmo8XJV0uy4tDBH-9IuG75eD9j1DB81lRPw>
    <xmx:HFS8ZlYXyXks9YKs-kzOl4w5BVVf7d0oT0r7jPLHG1QT4328SqbjTA>
    <xmx:HFS8ZiTFew8SFnjcWQPFWI51xHdQZC7u6azuwy6K0uOdKOb4f8sWPQ>
    <xmx:HFS8ZoHcS7jduo-jcXDP_uS6Hjj_Zc3gnNqbmJHFVfWNlzUvvXAhK7gg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:52:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6616149a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:51:52 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:52:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 06/22] read-cache: fix leaking hashfile when writing index
 fails
Message-ID: <ed0608e7059c925e50daf5dc454ced781a09a948.1723614263.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723614263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723614263.git.ps@pks.im>

In `do_write_index()`, we use a `struct hashfile` to write the index
with a trailer hash. In case the write fails though, we never clean up
the allocated `hashfile` state and thus leak memory.

Refactor the code to have a common exit path where we can free this and
other allocated memory. While at it, refactor our use of `strbuf`s such
that we reuse the same buffer to avoid some unneeded allocations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 read-cache.c                       | 97 ++++++++++++++++++------------
 t/t1601-index-bogus.sh             |  2 +
 t/t2107-update-index-basic.sh      |  1 +
 t/t7008-filter-branch-null-sha1.sh |  1 +
 4 files changed, 62 insertions(+), 39 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 48bf24f87c..36821fe5b5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2840,8 +2840,9 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	int csum_fsync_flag;
 	int ieot_entries = 1;
 	struct index_entry_offset_table *ieot = NULL;
-	int nr, nr_threads;
 	struct repository *r = istate->repo;
+	struct strbuf sb = STRBUF_INIT;
+	int nr, nr_threads, ret;
 
 	f = hashfd(tempfile->fd, tempfile->filename.buf);
 
@@ -2962,8 +2963,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	strbuf_release(&previous_name_buf);
 
 	if (err) {
-		free(ieot);
-		return err;
+		ret = err;
+		goto out;
 	}
 
 	offset = hashfile_total(f);
@@ -2985,20 +2986,20 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	 * index.
 	 */
 	if (ieot) {
-		struct strbuf sb = STRBUF_INIT;
+		strbuf_reset(&sb);
 
 		write_ieot_extension(&sb, ieot);
 		err = write_index_ext_header(f, eoie_c, CACHE_EXT_INDEXENTRYOFFSETTABLE, sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		free(ieot);
-		if (err)
-			return -1;
+		if (err) {
+			ret = -1;
+			goto out;
+		}
 	}
 
 	if (write_extensions & WRITE_SPLIT_INDEX_EXTENSION &&
 	    istate->split_index) {
-		struct strbuf sb = STRBUF_INIT;
+		strbuf_reset(&sb);
 
 		if (istate->sparse_index)
 			die(_("cannot write split index for a sparse index"));
@@ -3007,59 +3008,66 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			write_index_ext_header(f, eoie_c, CACHE_EXT_LINK,
 					       sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		if (err)
-			return -1;
+		if (err) {
+			ret = -1;
+			goto out;
+		}
 	}
 	if (write_extensions & WRITE_CACHE_TREE_EXTENSION &&
 	    !drop_cache_tree && istate->cache_tree) {
-		struct strbuf sb = STRBUF_INIT;
+		strbuf_reset(&sb);
 
 		cache_tree_write(&sb, istate->cache_tree);
 		err = write_index_ext_header(f, eoie_c, CACHE_EXT_TREE, sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		if (err)
-			return -1;
+		if (err) {
+			ret = -1;
+			goto out;
+		}
 	}
 	if (write_extensions & WRITE_RESOLVE_UNDO_EXTENSION &&
 	    istate->resolve_undo) {
-		struct strbuf sb = STRBUF_INIT;
+		strbuf_reset(&sb);
 
 		resolve_undo_write(&sb, istate->resolve_undo);
 		err = write_index_ext_header(f, eoie_c, CACHE_EXT_RESOLVE_UNDO,
 					     sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		if (err)
-			return -1;
+		if (err) {
+			ret = -1;
+			goto out;
+		}
 	}
 	if (write_extensions & WRITE_UNTRACKED_CACHE_EXTENSION &&
 	    istate->untracked) {
-		struct strbuf sb = STRBUF_INIT;
+		strbuf_reset(&sb);
 
 		write_untracked_extension(&sb, istate->untracked);
 		err = write_index_ext_header(f, eoie_c, CACHE_EXT_UNTRACKED,
 					     sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		if (err)
-			return -1;
+		if (err) {
+			ret = -1;
+			goto out;
+		}
 	}
 	if (write_extensions & WRITE_FSMONITOR_EXTENSION &&
 	    istate->fsmonitor_last_update) {
-		struct strbuf sb = STRBUF_INIT;
+		strbuf_reset(&sb);
 
 		write_fsmonitor_extension(&sb, istate);
 		err = write_index_ext_header(f, eoie_c, CACHE_EXT_FSMONITOR, sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		if (err)
-			return -1;
+		if (err) {
+			ret = -1;
+			goto out;
+		}
 	}
 	if (istate->sparse_index) {
-		if (write_index_ext_header(f, eoie_c, CACHE_EXT_SPARSE_DIRECTORIES, 0) < 0)
-			return -1;
+		if (write_index_ext_header(f, eoie_c, CACHE_EXT_SPARSE_DIRECTORIES, 0) < 0) {
+			ret = -1;
+			goto out;
+		}
 	}
 
 	/*
@@ -3069,14 +3077,15 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	 * when loading the shared index.
 	 */
 	if (eoie_c) {
-		struct strbuf sb = STRBUF_INIT;
+		strbuf_reset(&sb);
 
 		write_eoie_extension(&sb, eoie_c, offset);
 		err = write_index_ext_header(f, NULL, CACHE_EXT_ENDOFINDEXENTRIES, sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		if (err)
-			return -1;
+		if (err) {
+			ret = -1;
+			goto out;
+		}
 	}
 
 	csum_fsync_flag = 0;
@@ -3085,13 +3094,16 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 	finalize_hashfile(f, istate->oid.hash, FSYNC_COMPONENT_INDEX,
 			  CSUM_HASH_IN_STREAM | csum_fsync_flag);
+	f = NULL;
 
 	if (close_tempfile_gently(tempfile)) {
-		error(_("could not close '%s'"), get_tempfile_path(tempfile));
-		return -1;
+		ret = error(_("could not close '%s'"), get_tempfile_path(tempfile));
+		goto out;
+	}
+	if (stat(get_tempfile_path(tempfile), &st)) {
+		ret = -1;
+		goto out;
 	}
-	if (stat(get_tempfile_path(tempfile), &st))
-		return -1;
 	istate->timestamp.sec = (unsigned int)st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 	trace_performance_since(start, "write index, changed mask = %x", istate->cache_changed);
@@ -3105,7 +3117,14 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	trace2_data_intmax("index", the_repository, "write/cache_nr",
 			   istate->cache_nr);
 
-	return 0;
+	ret = 0;
+
+out:
+	if (f)
+		free_hashfile(f);
+	strbuf_release(&sb);
+	free(ieot);
+	return ret;
 }
 
 void set_alternate_index_output(const char *name)
diff --git a/t/t1601-index-bogus.sh b/t/t1601-index-bogus.sh
index 4171f1e141..5dcc101882 100755
--- a/t/t1601-index-bogus.sh
+++ b/t/t1601-index-bogus.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test handling of bogus index entries'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create tree with null sha1' '
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index cc72ead79f..f0eab13f96 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -5,6 +5,7 @@ test_description='basic update-index tests
 Tests for command-line parsing and basic operation.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'update-index --nonsense fails' '
diff --git a/t/t7008-filter-branch-null-sha1.sh b/t/t7008-filter-branch-null-sha1.sh
index 93fbc92b8d..0ce8fd2c89 100755
--- a/t/t7008-filter-branch-null-sha1.sh
+++ b/t/t7008-filter-branch-null-sha1.sh
@@ -2,6 +2,7 @@
 
 test_description='filter-branch removal of trees with null sha1'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: base commits' '
-- 
2.46.0.46.g406f326d27.dirty

