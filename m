Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E54CC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 15:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLOPHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 10:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLOPHK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 10:07:10 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A4F2FBD7
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 07:07:06 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m14so3347819wrh.7
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 07:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEbMq54j8bKhuo9OUPycuOxora+wDnAP3HoafrfWaOs=;
        b=BZJrAhfkCxK0dcBnxyJzmVGUfVifEKo8dLsXnnfJJx3fFcAASKvnNgBtV6ft4UlFAz
         Qfv+cIcNYGUJOSCr1Hr75e/MXHFZG5duYu/Wrj+OROqdsejLLimBIT0lvBl18Z1bh1l1
         KhgvVqBYvLR/jh9l505/caDIFTfXDCtXKYh+c38GZlo58k5jiWA5jRGFb9H+3BNkg38I
         UaUjwvLVehGAnlLPgsXzjSwsvQVA1ycVutADFFMCaW8yKzVZ3RMCr0elUKw0891J/xr9
         S3axe14UDq6LhF/N0LjKN7BhSsMonDA1uc9TtI3hXanGPzdX+cJP+X767JGeW3ETRMCe
         Tp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEbMq54j8bKhuo9OUPycuOxora+wDnAP3HoafrfWaOs=;
        b=ectzJez8Zm6d5H5CGLEsuSOJoij2+0AMxKZIPPHMXO/QUTek9J5s+KWaY0NSWBXEBE
         AzujPRD1P7swS2BMoFbtCO957ULlCdTx3ou/6H0SL3UusyN874IzNXqKw0ulT/yKhlfi
         GZC4XN17pEGXr6yDmns58/OUSQ3OO2i4HZwrgO5GYzHFhFWO2msxQZZ5ElOWO0sO37u7
         eG89+a+6wEnnWyciFxpXxyu3A3BPNO9qifvB+rJtJz5oXQ4H4SZRCErVtKZIiqTQ7+wT
         vu1CMou1YpuGsS2K8G/UzYkuWpypOQEEOgsOMB600j/6lbcb9tNuViesNbQpM+R4zn7d
         l4LQ==
X-Gm-Message-State: ANoB5pkWNXIaW6niemADco4UAru3Cqu96TwNnYlk0Nm5bPEJxM2bpG3K
        IQ4wjpzjU3h9kDDT1WkE/rIXIfHyiJw=
X-Google-Smtp-Source: AA0mqf6tSs0f7MXoOXhUPMzIE+SSMOjeRxItp7g5M7OMStIKGHoCHibbPXfhScqiukBexiCsC6hjTA==
X-Received: by 2002:adf:a385:0:b0:242:7fd1:e9d2 with SMTP id l5-20020adfa385000000b002427fd1e9d2mr18087703wrb.62.1671116824222;
        Thu, 15 Dec 2022 07:07:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1-20020adfa381000000b002423a5d7cb1sm6138601wrb.113.2022.12.15.07.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 07:07:03 -0800 (PST)
Message-Id: <00738c81a1212970910da6f29fe3ecef87c2ec3a.1671116820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
References: <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
        <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Dec 2022 15:06:58 +0000
Subject: [PATCH v3 2/4] read-cache: add index.skipHash config option
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
 read-cache.c                   | 12 +++++++++++-
 t/t1600-index.sh               |  6 ++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

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
index 46f5e497b14..3f7de8b2e20 100644
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
+	if (!hasheq(hash, end - the_hash_algo->rawsz))
 		return error(_("bad index file sha1 signature"));
 	return 0;
 }
@@ -2918,6 +2926,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 	f = hashfd(tempfile->fd, tempfile->filename.buf);
 
+	git_config_get_maybe_bool("index.skiphash", (int *)&f->skip_hash);
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

