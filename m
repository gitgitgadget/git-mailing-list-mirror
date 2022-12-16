Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38D7C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 15:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiLPPba (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 10:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiLPPbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 10:31:25 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2974711A0E
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 07:31:24 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso4350813wme.5
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 07:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fbg90W1EzLJTTyG1F65DCePyJ3sPmIjFmGXqlXxzxd4=;
        b=IIQOj3o5XD7nvyZiGwKJ5eteoZYiw+rpt6Byr/zURinWgTLtjGY7dXeG5naifw8Ql5
         59OEIurCy/6o8OKFXzR+Oy9q+mvDxRTvt4AVdky7JOCcjZRUSPJXnIuaFHMt0Ncr6AdR
         fetKhFfiJ6fT1v0XXCXd5WCeP+CsFuw+oWLuIpJt/9yMoj2VM38su+AyuZEZd0gTAUWA
         +iAroqZ+tJnZGqaMT7WwC51rd7lPptCGABB4SBEtOW5RvjBmhl1His+ufDyzQXqx0XFz
         C/xQOGUvEccJA69XGHfSysZ3SNKS3UU+2bWZyqGbQF4AS8QrVsvvl9CyXdL1ghZIiw/n
         kVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fbg90W1EzLJTTyG1F65DCePyJ3sPmIjFmGXqlXxzxd4=;
        b=ZWQZ3JmprLpPX/un/mf7QUdxTyW2uQHAkCWxWXWlMiuYE6ldDM8cO7HsdyH7Fz9O93
         bk7zTVqq7WahN7vIm2snwIBdWy1kyDwoDDPW+YCK/1c41dg9yb9xmP4PDvbZBtOCmHpS
         LXeSvXAUKZycjxR8B+joALwKbYHjDKg0i4+jeB2uEaL00I0f+nng1pUTqZu+5q0vD2vE
         To1R9NJLhQj7aeMnna5i0tp0oKxhr86Mx8IXEa3SQRW2LiWI6dvjPJrDz+q1imA9fDCQ
         RR3AgKgAWcBJ1bvXaox0ccpL2qO6y1G7r6FoI8pumhw/2i2p7P8p8z9RSwEC4gw2QQlk
         xE2A==
X-Gm-Message-State: ANoB5pkMllLYbQ8HRX5C/v6n/OzihchwhRCsJbNUk0kujDKDmU+pmPPm
        /cVdHWQnmSt4L58O/ZzosEe0lBPQgVU=
X-Google-Smtp-Source: AA0mqf7dWkfJdvwAzLOWDgdvJTEWZbeQxLuCzzIXuP86k19zjhgPq7lkVH9zDoZ9P8tpmx3Qs1WVuA==
X-Received: by 2002:a05:600c:4f89:b0:3cf:d0be:1231 with SMTP id n9-20020a05600c4f8900b003cfd0be1231mr35884488wmq.13.1671204682465;
        Fri, 16 Dec 2022 07:31:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi7-20020a05600c3d8700b003d1e051f671sm2843622wmb.9.2022.12.16.07.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:31:22 -0800 (PST)
Message-Id: <aae047cbc9f62654c7bd84fbc7ba6c8dfdc3b234.1671204678.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
References: <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
        <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Dec 2022 15:31:16 +0000
Subject: [PATCH v4 2/4] read-cache: add index.skipHash config option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Jacob Keller <jacob.keller@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change allowed skipping the hashing portion of the
hashwrite API, using it instead as a buffered write API. Disabling the
hashwrite can be particularly helpful when the write operation is in a
critical path.

One such critical path is the writing of the index. This operation is so
critical that the sparse index was created specifically to reduce the
size of the index to make these writes (and reads) faster.

This trade-off between file stability at rest and write-time performance
is not easy to balance. The index is an interesting case for a couple
reasons:

1. Writes block users. Writing the index takes place in many user-
   blocking foreground operations. The speed improvement directly
   impacts their use. Other file formats are typically written in the
   background (commit-graph, multi-pack-index) or are super-critical to
   correctness (pack-files).

2. Index files are short lived. It is rare that a user leaves an index
   for a long time with many staged changes. Outside of staged changes,
   the index can be completely destroyed and rewritten with minimal
   impact to the user.

Following a similar approach to one used in the microsoft/git fork [1],
add a new config option (index.skipHash) that allows disabling this
hashing during the index write. The cost is that we can no longer
validate the contents for corruption-at-rest using the trailing hash.

[1] https://github.com/microsoft/git/commit/21fed2d91410f45d85279467f21d717a2db45201

We load this config from the repository config given by istate->repo,
with a fallback to the_repository if it is not set.

While older Git versions will not recognize the null hash as a special
case, the file format itself is still being met in terms of its
structure. Using this null hash will still allow Git operations to
function across older versions.

The one exception is 'git fsck' which checks the hash of the index file.
This used to be a check on every index read, but was split out to just
the index in a33fc72fe91 (read-cache: force_verify_index_checksum,
2017-04-14) and released first in Git 2.13.0. Document the versions that
relaxed these restrictions, with the optimistic expectation that this
change will be included in Git 2.40.0.

Here, we disable this check if the trailing hash is all zeroes. We add a
warning to the config option that this may cause undesirable behavior
with older Git versions.

As a quick comparison, I tested 'git update-index --force-write' with
and without index.skipHash=true on a copy of the Linux kernel
repository.

Benchmark 1: with hash
  Time (mean ± σ):      46.3 ms ±  13.8 ms    [User: 34.3 ms, System: 11.9 ms]
  Range (min … max):    34.3 ms …  79.1 ms    82 runs

Benchmark 2: without hash
  Time (mean ± σ):      26.0 ms ±   7.9 ms    [User: 11.8 ms, System: 14.2 ms]
  Range (min … max):    16.3 ms …  42.0 ms    69 runs

Summary
  'without hash' ran
    1.78 ± 0.76 times faster than 'with hash'

These performance benefits are substantial enough to allow users the
ability to opt-in to this feature, even with the potential confusion
with older 'git fsck' versions.

It is critical that this test is placed before the test_index_version
tests, since those tests obliterate the .git/config file and hence lose
the setting from GIT_TEST_DEFAULT_HASH, if set.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/index.txt | 11 +++++++++++
 read-cache.c                   | 13 ++++++++++++-
 t/t1600-index.sh               |  6 ++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
index 75f3a2d1054..23c7985eb40 100644
--- a/Documentation/config/index.txt
+++ b/Documentation/config/index.txt
@@ -30,3 +30,14 @@ index.version::
 	Specify the version with which new index files should be
 	initialized.  This does not affect existing repositories.
 	If `feature.manyFiles` is enabled, then the default is 4.
+
+index.skipHash::
+	When enabled, do not compute the trailing hash for the index file.
+	This accelerates Git commands that manipulate the index, such as
+	`git add`, `git commit`, or `git status`. Instead of storing the
+	checksum, write a trailing set of bytes with value zero, indicating
+	that the computation was skipped.
++
+If you enable `index.skipHash`, then Git clients older than 2.13.0 will
+refuse to parse the index and Git clients older than 2.40.0 will report an
+error during `git fsck`.
diff --git a/read-cache.c b/read-cache.c
index 46f5e497b14..fde0697873c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1817,6 +1817,8 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 	git_hash_ctx c;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	int hdr_version;
+	unsigned char *start, *end;
+	struct object_id oid;
 
 	if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
 		return error(_("bad signature 0x%08x"), hdr->hdr_signature);
@@ -1827,10 +1829,16 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 	if (!verify_index_checksum)
 		return 0;
 
+	end = (unsigned char *)hdr + size;
+	start = end - the_hash_algo->rawsz;
+	oidread(&oid, start);
+	if (oideq(&oid, null_oid()))
+		return 0;
+
 	the_hash_algo->init_fn(&c);
 	the_hash_algo->update_fn(&c, hdr, size - the_hash_algo->rawsz);
 	the_hash_algo->final_fn(hash, &c);
-	if (!hasheq(hash, (unsigned char *)hdr + size - the_hash_algo->rawsz))
+	if (!hasheq(hash, start))
 		return error(_("bad index file sha1 signature"));
 	return 0;
 }
@@ -2915,9 +2923,12 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	int ieot_entries = 1;
 	struct index_entry_offset_table *ieot = NULL;
 	int nr, nr_threads;
+	struct repository *r = istate->repo ? istate->repo : the_repository;
 
 	f = hashfd(tempfile->fd, tempfile->filename.buf);
 
+	repo_config_get_maybe_bool(r, "index.skiphash", &f->skip_hash);
+
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
 			removed++;
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 010989f90e6..45feb0fc5d8 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -65,6 +65,12 @@ test_expect_success 'out of bounds index.version issues warning' '
 	)
 '
 
+test_expect_success 'index.skipHash config option' '
+	rm -f .git/index &&
+	git -c index.skipHash=true add a &&
+	git fsck
+'
+
 test_index_version () {
 	INDEX_VERSION_CONFIG=$1 &&
 	FEATURE_MANY_FILES=$2 &&
-- 
gitgitgadget

