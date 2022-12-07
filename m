Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B6FC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 17:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiLGR0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 12:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiLGR0E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 12:26:04 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D399669A95
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 09:26:02 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d1so29037017wrs.12
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 09:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/sYCO0g63r3rEs9I2ZMdvq3WSQ0z/98w5Msc+Z9TkE=;
        b=ANpe3W0O/Pui6JZ12//faaQ9p002uwfUYV0aDEV7wFGV+rI+6WDiIFJ0Rmb+eOd5wX
         8yy+sjx5b5hJYu0jrUrotgw01yVOiObEvCjvF8vfWag65PgQZ0a3V83quCUOq9JLJz+O
         mfY6tcZgPIEC6wVS3OMTVyWU+hReU2WQa42upzS2g13wMkk9NtCPW42K7JalcdaUB4/E
         rWjBvw6UVPl9TxvCNy3mPk0kJx5fhVBQDgM2w8sj3ZrIBpXYHM7QnYDW11cdofTIJFvn
         1Kx+fo5HXTFN9vik96+pHd70TcVkbCBBwbZve87EiCXWqCeCPs/S7kBdNYAPTz/pRyPf
         Ijng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/sYCO0g63r3rEs9I2ZMdvq3WSQ0z/98w5Msc+Z9TkE=;
        b=StLrhPRylfRNXGtS30X6FHt9YLBJpjsnOc5lbC0xtbsUYaF43mQuttNTZPO4CMa26c
         huL5FX9pSqHIbZMHoQxNV6mG08qBLWaA4DvwAbQqfK+XGCaKU1iCf0QQUKPsOAnyMgHl
         QInXqGSgI6Z2s3POg/ldJDk7coVSMje9gFx1Z75oD0w8eeEi+v5N1XQvMmMhKyM5uolE
         RdR4uThsIjbOYocn90sHI4DiZr9NDPFZzpGtHLQVLjM4naaK4ExhS7+feHtmTSV5pj7T
         K2cbjpdYZyjh1Hsx0uAJig67uxJ5D11Q8QbuoAEKJryGdD3HRRdkOqvuuxkYP/S+w5Eq
         6ZVw==
X-Gm-Message-State: ANoB5pkGRXMMHq0YQt1HveUrYkD9i/P5ZPGX4nu7xxGwMeOh0pGZB03Q
        amgpyZQJJLh4Gp5eMovQi8T6KUifSLY=
X-Google-Smtp-Source: AA0mqf65hAIFm444tbEaZvs2sM0syppFpNOWwFInySB/kHEG80HDZCtdlXNkOua6pTKjul1Owh+/Lw==
X-Received: by 2002:a05:6000:989:b0:236:91d0:1f with SMTP id by9-20020a056000098900b0023691d0001fmr48952203wrb.33.1670433961243;
        Wed, 07 Dec 2022 09:26:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5-20020a1c7205000000b003cf6c2f9513sm2274337wmc.2.2022.12.07.09.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 09:26:00 -0800 (PST)
Message-Id: <5fb4b5a36ac806f3ee07a614bcb93df2c430507c.1670433958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Dec 2022 17:25:56 +0000
Subject: [PATCH 2/4] read-cache: add index.skipHash config option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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
2017-04-14).

Here, we disable this check if the trailing hash is all zeroes. We add a
warning to the config option that this may cause undesirable behavior
with older Git versions.

As a quick comparison, I tested 'git update-index --force-write' with
and without index.computeHash=false on a copy of the Linux kernel
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
 Documentation/config/index.txt |  8 ++++++++
 read-cache.c                   | 14 +++++++++++++-
 t/t1600-index.sh               |  8 ++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
index 75f3a2d1054..3ea0962631d 100644
--- a/Documentation/config/index.txt
+++ b/Documentation/config/index.txt
@@ -30,3 +30,11 @@ index.version::
 	Specify the version with which new index files should be
 	initialized.  This does not affect existing repositories.
 	If `feature.manyFiles` is enabled, then the default is 4.
+
+index.skipHash::
+	When enabled, do not compute the trailing hash for the index file.
+	Instead, write a trailing set of bytes with value zero, indicating
+	that the computation was skipped.
++
+If you enable `index.skipHash`, then older Git clients may report that
+your index is corrupt during `git fsck`.
diff --git a/read-cache.c b/read-cache.c
index 46f5e497b14..fb4d6fb6387 100644
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
@@ -2915,9 +2923,13 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	int ieot_entries = 1;
 	struct index_entry_offset_table *ieot = NULL;
 	int nr, nr_threads;
+	int skip_hash;
 
 	f = hashfd(tempfile->fd, tempfile->filename.buf);
 
+	if (!git_config_get_maybe_bool("index.skiphash", &skip_hash))
+		f->skip_hash = skip_hash;
+
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
 			removed++;
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 010989f90e6..df07c587e0e 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -65,6 +65,14 @@ test_expect_success 'out of bounds index.version issues warning' '
 	)
 '
 
+test_expect_success 'index.skipHash config option' '
+	(
+		rm -f .git/index &&
+		git -c index.skipHash=true add a &&
+		git fsck
+	)
+'
+
 test_index_version () {
 	INDEX_VERSION_CONFIG=$1 &&
 	FEATURE_MANY_FILES=$2 &&
-- 
gitgitgadget

