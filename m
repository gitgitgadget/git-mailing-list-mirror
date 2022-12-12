Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CE3C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 16:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiLLQbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 11:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiLLQb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 11:31:27 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E9EFCF0
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 08:31:22 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h7so12669397wrs.6
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 08:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+RQlk3U7znlrez+HRor0VkDoWW9HIopyv+94qA9Dt4=;
        b=dc0ZKHgzJFz58d7MnuDkHWSNIOOfeYuy4/WFeHyASLbv3PqXu/nBtLP8IETRuDf6HW
         4Koz/JAIzAPooAHEAhiuL4iOPK0Q/KLozrraIauPNbTHvd11IduGF6uZxZO4WFdpXObt
         Y5GlClnw73qITXmeCH0pR4+cH+ri2HD7xnK6vS0KSZbPTBMVbz6j2+P528SujS1z4XvV
         DII9VXCVtqRYtZLEqW6CCmxRyC/wmlzAKpAWglWu+hr/6J0d6IgSIGWkwzERZg7MbCK3
         j9SC65PpoIoNzHr6PMAXD5MH9vXZy5AXIxD6IDIkn+Y4W+H+yOYmvD77kSiEww3ByDSj
         m7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+RQlk3U7znlrez+HRor0VkDoWW9HIopyv+94qA9Dt4=;
        b=x92dDV7t1rbHeRkbNEtspYBT5w9RUdi3AVqEpBtrXb1eMR9LS46sC+jwrK8X0zr0UA
         GkdrP+irUO4bO86wxt46gzM1OrD5XywPcMZuQ5ehkSCORQJbI0CJawghJDJTn1VQQa2G
         7D5+5fRhx6iEz9VzbkXuDOLwZHSeoJnGBns3+/lxhUcCjlEOIFkN2/YFVpeydLXXJACA
         uFQYgHQB41Apjg10jGy76kx38+TPkDpDmbiO0ku9PTfvefaH9VVWsb+IeHxTz6KiRiwl
         EH5qbSaJfYHoA8VH+5yl/w8LTBy2ZIqgs3o0JdrPq1ne8Bh5xcPE063+SaVc/C1/OW39
         ispA==
X-Gm-Message-State: ANoB5plMKH9kuysoOyoj7Io6xD9A092IzQN91v6e0GCDdBiQxR2+PVdw
        BogqD1X2UjnofzzbCUZ0sX0LEiYuMfI=
X-Google-Smtp-Source: AA0mqf6jNNjMxymW+wm/dCiPD2e9u09AtEwEbZe9TJPypNaFo36b3edy8X/+y9P8fzeg32rFu5PUsQ==
X-Received: by 2002:adf:e946:0:b0:242:483f:e9b9 with SMTP id m6-20020adfe946000000b00242483fe9b9mr9156654wrn.24.1670862680366;
        Mon, 12 Dec 2022 08:31:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x1-20020a5d60c1000000b00241c712916fsm10958925wrt.0.2022.12.12.08.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 08:31:19 -0800 (PST)
Message-Id: <c8a2fd3a470e1c12a7b182854874f63ed25b9992.1670862677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
        <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 16:31:15 +0000
Subject: [PATCH v2 2/4] read-cache: add index.skipHash config option
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
 Documentation/config/index.txt |  9 +++++++++
 read-cache.c                   | 12 +++++++++++-
 t/t1600-index.sh               |  6 ++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
index 75f3a2d1054..5d62489c302 100644
--- a/Documentation/config/index.txt
+++ b/Documentation/config/index.txt
@@ -30,3 +30,12 @@ index.version::
 	Specify the version with which new index files should be
 	initialized.  This does not affect existing repositories.
 	If `feature.manyFiles` is enabled, then the default is 4.
+
+index.skipHash::
+	When enabled, do not compute the trailing hash for the index file.
+	Instead, write a trailing set of bytes with value zero, indicating
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

