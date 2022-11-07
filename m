Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2C0C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbiKGSgN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiKGSgL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:36:11 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660C220BF9
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:10 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l14so17592639wrw.2
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WefgVLjhe4OA0CfLG1K4M32LWeD7NxCDVXtdSjOhz5w=;
        b=K/Uw/VwxZceen+bwzIbvdvnz/l552rYfgKCZXlkFi/G/Wg53euHNkwy7f6tgQCeo9/
         ELvlSHIdIkMgCNG/iIUdWofv/17nKmHfpjOYOn/mpCQjXoeqHXd5NbTCYisIuJ1fWFGJ
         8DLbHnPfWaxRoxMAdl1/hlmkKqoAXDxior6/cQnpCTAB/3FpjmTw2cTL5zmasp28yLp/
         8JlJ1DPuMTJsXhRfcLiQnUZMd6Iexou3sI8QCrw1WrHWDsRg4VopPve0KRVYZHVfI6X4
         C4pbkd7QW71WXEU3Ul0I2C8iKWDXxzS1tCojNefvNIz3Ihe40NBnx2w5ma8ERkVBvpk5
         xl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WefgVLjhe4OA0CfLG1K4M32LWeD7NxCDVXtdSjOhz5w=;
        b=Cmw1a8cB2KCKo1/YM8ZlvnaN3vK1gmiLzz3HGlE7qcNChL50SW3cBtVpsoX63Zl+M9
         39RUmKtCtxf6YdfVDZVHQc3Ex+L5j5RiVD9SS+aJ4ct5d8ntFPGnvHicTgLiiRlmAOKR
         n98ko+uoomFW2k0UhdBQuzH/nATX4U4y+FAd/KYcOPy6mSrJSs+PgrEz2DvvRXNFCWRV
         pq/LhLBKE3r7U7lYJw8tG/mnEA705YNK7F6Lfkv1pgK8xvRmeUVmn+Rkj1MurN4PviCB
         OrJr2JiwwFftwwFUTEuHBY8mlGsfdm8yRvJAP39yg8/n6zHWMi2yzkXfDOC4Pxkt36ak
         1ppQ==
X-Gm-Message-State: ACrzQf0ZVv0tTtRWn9KzoKYKxjY0cxuknf8PUIRU+oytuJ1bqvAU/w4X
        7VFKPvdLbmX5OSu9zGvOh/OwL2ohb9E=
X-Google-Smtp-Source: AMsMyM6KHNDMDsQImWjY9wqYSCws8QKx2ek8bP2zpv4fkRZSMxNUSDiSCRAo4eMr/wZExisEfH0srw==
X-Received: by 2002:adf:b612:0:b0:236:5d1f:143a with SMTP id f18-20020adfb612000000b002365d1f143amr31624793wre.364.1667846168712;
        Mon, 07 Nov 2022 10:36:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5948000000b0023657e1b97esm8110315wri.11.2022.11.07.10.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:08 -0800 (PST)
Message-Id: <030d76f52af654470026b0c4b1dfba2b6c996885.1667846164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:36 +0000
Subject: [PATCH 02/30] read-cache: add index.computeHash config option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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

Following a similar approach to one used in the microsoft/git fork [1],
add a new config option that allows disabling this hashing during the
index write. The cost is that we can no longer validate the contents for
corruption-at-rest using the trailing hash.

[1] https://github.com/microsoft/git/commit/21fed2d91410f45d85279467f21d717a2db45201

While older Git versions will not recognize the null hash as a special
case, the file format itself is still being met in terms of its
structure. Using this null hash will still allow Git operations to
function across older versions.

The one exception is 'git fsck' which checks the hash of the index file.
Here, we disable this check if the trailing hash is all zeroes. We add a
warning to the config option that this may cause undesirable behavior
with older Git versions.

As a quick comparison, I tested 'git update-index --force-write' with
and without index.computHash=false on a copy of the Linux kernel
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

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/index.txt |  8 ++++++++
 read-cache.c                   | 22 +++++++++++++++++++++-
 t/t1600-index.sh               |  8 ++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
index 75f3a2d1054..709ba72f622 100644
--- a/Documentation/config/index.txt
+++ b/Documentation/config/index.txt
@@ -30,3 +30,11 @@ index.version::
 	Specify the version with which new index files should be
 	initialized.  This does not affect existing repositories.
 	If `feature.manyFiles` is enabled, then the default is 4.
+
+index.computeHash::
+	When enabled, compute the hash of the index file as it is written
+	and store the hash at the end of the content. This is enabled by
+	default.
++
+If you disable `index.computHash`, then older Git clients may report that
+your index is corrupt during `git fsck`.
diff --git a/read-cache.c b/read-cache.c
index 32024029274..f24d96de4d3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1817,6 +1817,8 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 	git_hash_ctx c;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	int hdr_version;
+	int all_zeroes = 1;
+	unsigned char *start, *end;
 
 	if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
 		return error(_("bad signature 0x%08x"), hdr->hdr_signature);
@@ -1827,10 +1829,23 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 	if (!verify_index_checksum)
 		return 0;
 
+	end = (unsigned char *)hdr + size;
+	start = end - the_hash_algo->rawsz;
+	while (start < end) {
+		if (*start != 0) {
+			all_zeroes = 0;
+			break;
+		}
+		start++;
+	}
+
+	if (all_zeroes)
+		return 0;
+
 	the_hash_algo->init_fn(&c);
 	the_hash_algo->update_fn(&c, hdr, size - the_hash_algo->rawsz);
 	the_hash_algo->final_fn(hash, &c);
-	if (!hasheq(hash, (unsigned char *)hdr + size - the_hash_algo->rawsz))
+	if (!hasheq(hash, end - the_hash_algo->rawsz))
 		return error(_("bad index file sha1 signature"));
 	return 0;
 }
@@ -2917,9 +2932,14 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	int ieot_entries = 1;
 	struct index_entry_offset_table *ieot = NULL;
 	int nr, nr_threads;
+	int compute_hash;
 
 	f = hashfd(tempfile->fd, tempfile->filename.buf);
 
+	if (!git_config_get_maybe_bool("index.computehash", &compute_hash) &&
+	    !compute_hash)
+		f->skip_hash = 1;
+
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
 			removed++;
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 010989f90e6..24ab90ca047 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -103,4 +103,12 @@ test_expect_success 'index version config precedence' '
 	test_index_version 0 true 2 2
 '
 
+test_expect_success 'index.computeHash config option' '
+	(
+		rm -f .git/index &&
+		git -c index.computeHash=false add a &&
+		git fsck
+	)
+'
+
 test_done
-- 
gitgitgadget

