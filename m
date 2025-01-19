Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94A41B86EF
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737285581; cv=none; b=Ha0wXVTO3juVmLnzg6xHOA5uz8j5QThtOd7+ANb2QtN/VLW1rVm38PYcXlVf1T6jS4IUrSwQs+ZeqLBwRGi8dGZLBcK/uTy7i/dc0+DCHtILGFW/w9Wxxhk0HcE9B5K36udqmuRTek9vOzO8sq5miWMaJmj94aSpET3innFe3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737285581; c=relaxed/simple;
	bh=eJh50frnAgEBcRahU/ovUpY2gTVwjSznGbZKKe7Spsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oot/S94FzsifYZuR0Hmw9/+tqCHl/YMFV060MlIOK8M12/NHHEzal29/6+SdrYYIv9MnoEcG8WXy8lkXsSQNlD25OBKHxLjtGN9WGb43iht1vBf7shTF5KdDo39lDe1oxO+B0w33Lec5PU0WmIHXqGicmGNXVocTmlaWPv2fRXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIQSkLk4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIQSkLk4"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2166f1e589cso87843145ad.3
        for <git@vger.kernel.org>; Sun, 19 Jan 2025 03:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737285579; x=1737890379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x69q624R53wnHN1Cq1R59YFdwCfle6YPlFG5K6yLxqU=;
        b=AIQSkLk4iZzRbX/Y0TrL9a/jT9FwzEagEYl/ZR07VMMdWAOkKbEybphwrS2mf5B6rG
         AwjqlIHHu8ofomFrmg+OWB+APlDWJ0Foda3M6pi/K6FTI2H0DF/2TNjxNj13ztQIsEX9
         m8gb2mga5wijcXqe2SSwYTvAjR6nKlJPYggPpBzlVzcxyTGzo/l5rrs7+Z/DdNfXfV/M
         NjCZ2Nq6U5qypHsHBSZlpRSg8b1ZFQK1TRNLsTEV8Ko0odhkVP/x+YfoeseXIhZGnaDj
         qXwFnnzLrVNsp7KK3yojXQOVO5KIUB5wTjK4t0Zn7PKmUIJUCPX7pTQviYSW8+ihKYfz
         fBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737285579; x=1737890379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x69q624R53wnHN1Cq1R59YFdwCfle6YPlFG5K6yLxqU=;
        b=vBrjON+O5au07/1QY/l80hDlAujpU69tTXszAjglet7Bm4Y6PM6B28I709Y6uLFWvg
         Z0btrejXd2K1f3nnLJRd3BFsmQxm+JEFunIZ8MQdXl/Hs8s+z7N4puRVY7m6/v9U73HZ
         NgYDuz54bXhI0KUESeFXGo6MQVAIJpsr2Rk00mHuouWmb8xHPE4p7tAZLUqQYHEq3Q9S
         T7kF0sk5P9WuuLlIdIwk51arIq7QVn9p8gnpm8hX5I6cNrbbJKTZxEEuHd3mrB4FVw+r
         2TkBmc2mcXXQgBw9RLRdylj1RPtRccjgFICM2f02jW5vZy7y0Nz8FFJQEV0lEfupXPIb
         jBnA==
X-Gm-Message-State: AOJu0Ywv+NmbGp7bmKaTOYSWb7B0tHUKgmDM0HUX65yU4enZbmt/Ei33
	CYArpMGGJT+2Fp1DGb/+5Hlmy8HA32meHZLCR2EIavByoUuGc7eFlwS94wKv
X-Gm-Gg: ASbGnctzGlbcdEBPE2Mf63ipDs7r1oNSIdcQNfFvcV9A5ad3x650LgdMznmwtOcwhRj
	jRuMx7dwOqFC10swDGgInTa4gK3eU/Yy7Taa6iEn30WDaON0yTtRJWnh087tojiCNhCOiKdHvBG
	P3FEaD4XE0fNt21WjqDRcjk+roMT9qgDVr0tzfA+PpuCrOKtumMVV+H84H0H/XFxNAungrMaO08
	W+bBT8K+ySFFwavPKSav4kTpxckfviDftrI37rjJjiRH+Cpxc7ImQZcU//E1lgADogcLQS1
X-Google-Smtp-Source: AGHT+IHuvqOgzk/7GHAiH4XrM5tIrxTcNV8xkizkWOIhaAxex8rU9trf7Ay2htHGGzYRrCCU06E7Hw==
X-Received: by 2002:a17:902:ccc2:b0:216:3e86:1cb9 with SMTP id d9443c01a7336-21c357a608dmr131247215ad.50.1737285578790;
        Sun, 19 Jan 2025 03:19:38 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cfbd01fsm43031415ad.104.2025.01.19.03.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 03:19:38 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 19 Jan 2025 12:19:26 +0100
Subject: [PATCH v3 1/5] pack-write: pass hash_algo to
 `fixup_pack_header_footer()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250119-kn-the-repo-cleanup-v3-1-a495fce08d71@gmail.com>
References: <20250119-kn-the-repo-cleanup-v3-0-a495fce08d71@gmail.com>
In-Reply-To: <20250119-kn-the-repo-cleanup-v3-0-a495fce08d71@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 toon@iotcl.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7836; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=eJh50frnAgEBcRahU/ovUpY2gTVwjSznGbZKKe7Spsw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeM38Rzvue7tAFAkxn7hlqc2bzR4j5qALFwO
 uxcG+0Augf2vYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnjN/EAAoJED7VnySO
 Rox/A3AL/Rm0YBbaY1xMxMeAQhaxmPPEkmHV6NvcBpgbTNYEph6GcxV8zqecxfxANdaw6DHzCsq
 /CcRQc4h4YbdFLpoAAaRMK8Ov1A3HPHg/7mqdsm/7ygwBQKZtCWZma+BTmUAEPzQNT7PPR5hYdR
 IwmRZBY1KmXmBJDX5D7t4naSp/7XsAYTgWMRWObvI+8VXnneo0lwfhp7PvKQeeNfgpgg0h5/ggD
 SWOR+M03c8CJHvHAQPWEoCn4MbPwDUO+IPjgitCMOybWpkRKNvRBwOZ7/T4o7d+LmpNryUIuC6s
 1tNxrNvG7/qGazQbaP68vaAy+fx701wB+0+bOiQtj7mumdBSbHuTp6tedfK/xE92pu/tZziaX67
 JV9ZfKIxq79/XXDxfDbDRCVhbiW/+OAy/JV9p1PDf9kkXPPub4WFBLNNgWyJR0vbkXsdlb8cYpi
 jOrZxPVyPXcWyyGzisTjv/Wv3ugU/uBOGSP/vyR/qgOs2QqV3eToxDdijFiIfFjlCIA3MWbTc76
 qk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `fixup_pack_header_footer()` function uses the global
`the_hash_algo` variable to access the repository's hash function. To
avoid global variable usage, pass a hash_algo from the layers above.

Altough the layers above could have access to the hash_algo internally,
simply pass in `the_hash_algo`. This avoids any compatibility issues and
bubbles up global variable usage to upper layers which can be eventually
resolved.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fast-import.c  |  7 ++++---
 builtin/index-pack.c   |  2 +-
 builtin/pack-objects.c |  5 +++--
 bulk-checkin.c         |  2 +-
 pack-write.c           | 28 ++++++++++++++--------------
 pack.h                 |  4 +++-
 6 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 0f86392761abbe6acb217fef7f4fe7c3ff5ac1fa..6baf2b1b71e2443a7987a41e0cd246076682bf58 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -878,9 +878,10 @@ static void end_packfile(void)
 
 		close_pack_windows(pack_data);
 		finalize_hashfile(pack_file, cur_pack_oid.hash, FSYNC_COMPONENT_PACK, 0);
-		fixup_pack_header_footer(pack_data->pack_fd, pack_data->hash,
-					 pack_data->pack_name, object_count,
-					 cur_pack_oid.hash, pack_size);
+		fixup_pack_header_footer(the_hash_algo, pack_data->pack_fd,
+					 pack_data->hash, pack_data->pack_name,
+					 object_count, cur_pack_oid.hash,
+					 pack_size);
 
 		if (object_count <= unpack_limit) {
 			if (!loosen_small_pack(pack_data)) {
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0bef61c57232e198ba539cd44ec301d26dcb0eb8..6c5e3483f4fe67fb2e26132c55b1f8395d60c11f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1390,7 +1390,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 		strbuf_release(&msg);
 		finalize_hashfile(f, tail_hash, FSYNC_COMPONENT_PACK, 0);
 		hashcpy(read_hash, pack_hash, the_repository->hash_algo);
-		fixup_pack_header_footer(output_fd, pack_hash,
+		fixup_pack_header_footer(the_hash_algo, output_fd, pack_hash,
 					 curr_pack, nr_objects,
 					 read_hash, consumed_bytes-the_hash_algo->rawsz);
 		if (!hasheq(read_hash, tail_hash, the_repository->hash_algo))
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d51c021d99d9f470c04b7ec52565ab2f4c1c19ae..ffc62930b68c9b4152057572ede216381a4b0991 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1319,8 +1319,9 @@ static void write_pack_file(void)
 			 */
 
 			int fd = finalize_hashfile(f, hash, FSYNC_COMPONENT_PACK, 0);
-			fixup_pack_header_footer(fd, hash, pack_tmp_name,
-						 nr_written, hash, offset);
+			fixup_pack_header_footer(the_hash_algo, fd, hash,
+						 pack_tmp_name, nr_written,
+						 hash, offset);
 			close(fd);
 			if (write_bitmap_index) {
 				if (write_bitmap_index != WRITE_BITMAP_QUIET)
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 5044cb7fa083d692a3797e2491c27b61ec44c69c..c4b085f57f74fb8b998576ac9d84fed9e01ed0ed 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -70,7 +70,7 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 				  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 	} else {
 		int fd = finalize_hashfile(state->f, hash, FSYNC_COMPONENT_PACK, 0);
-		fixup_pack_header_footer(fd, hash, state->pack_tmp_name,
+		fixup_pack_header_footer(the_hash_algo, fd, hash, state->pack_tmp_name,
 					 state->nr_written, hash,
 					 state->offset);
 		close(fd);
diff --git a/pack-write.c b/pack-write.c
index 98a8c0e7853d7b46b5ce9a9672e0249ff051b5f9..fc887850dfb9789132b8642733c6472944dbe32d 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -380,7 +380,8 @@ off_t write_pack_header(struct hashfile *f, uint32_t nr_entries)
  * partial_pack_sha1 can refer to the same buffer if the caller is not
  * interested in the resulting SHA1 of pack data above partial_pack_offset.
  */
-void fixup_pack_header_footer(int pack_fd,
+void fixup_pack_header_footer(const struct git_hash_algo *hash_algo,
+			 int pack_fd,
 			 unsigned char *new_pack_hash,
 			 const char *pack_name,
 			 uint32_t object_count,
@@ -393,8 +394,8 @@ void fixup_pack_header_footer(int pack_fd,
 	char *buf;
 	ssize_t read_result;
 
-	the_hash_algo->init_fn(&old_hash_ctx);
-	the_hash_algo->init_fn(&new_hash_ctx);
+	hash_algo->init_fn(&old_hash_ctx);
+	hash_algo->init_fn(&new_hash_ctx);
 
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
 		die_errno("Failed seeking to start of '%s'", pack_name);
@@ -406,9 +407,9 @@ void fixup_pack_header_footer(int pack_fd,
 			  pack_name);
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
 		die_errno("Failed seeking to start of '%s'", pack_name);
-	the_hash_algo->update_fn(&old_hash_ctx, &hdr, sizeof(hdr));
+	hash_algo->update_fn(&old_hash_ctx, &hdr, sizeof(hdr));
 	hdr.hdr_entries = htonl(object_count);
-	the_hash_algo->update_fn(&new_hash_ctx, &hdr, sizeof(hdr));
+	hash_algo->update_fn(&new_hash_ctx, &hdr, sizeof(hdr));
 	write_or_die(pack_fd, &hdr, sizeof(hdr));
 	partial_pack_offset -= sizeof(hdr);
 
@@ -423,7 +424,7 @@ void fixup_pack_header_footer(int pack_fd,
 			break;
 		if (n < 0)
 			die_errno("Failed to checksum '%s'", pack_name);
-		the_hash_algo->update_fn(&new_hash_ctx, buf, n);
+		hash_algo->update_fn(&new_hash_ctx, buf, n);
 
 		aligned_sz -= n;
 		if (!aligned_sz)
@@ -432,13 +433,12 @@ void fixup_pack_header_footer(int pack_fd,
 		if (!partial_pack_hash)
 			continue;
 
-		the_hash_algo->update_fn(&old_hash_ctx, buf, n);
+		hash_algo->update_fn(&old_hash_ctx, buf, n);
 		partial_pack_offset -= n;
 		if (partial_pack_offset == 0) {
 			unsigned char hash[GIT_MAX_RAWSZ];
-			the_hash_algo->final_fn(hash, &old_hash_ctx);
-			if (!hasheq(hash, partial_pack_hash,
-				    the_repository->hash_algo))
+			hash_algo->final_fn(hash, &old_hash_ctx);
+			if (!hasheq(hash, partial_pack_hash, hash_algo))
 				die("Unexpected checksum for %s "
 				    "(disk corruption?)", pack_name);
 			/*
@@ -446,7 +446,7 @@ void fixup_pack_header_footer(int pack_fd,
 			 * pack, which also means making partial_pack_offset
 			 * big enough not to matter anymore.
 			 */
-			the_hash_algo->init_fn(&old_hash_ctx);
+			hash_algo->init_fn(&old_hash_ctx);
 			partial_pack_offset = ~partial_pack_offset;
 			partial_pack_offset -= MSB(partial_pack_offset, 1);
 		}
@@ -454,9 +454,9 @@ void fixup_pack_header_footer(int pack_fd,
 	free(buf);
 
 	if (partial_pack_hash)
-		the_hash_algo->final_fn(partial_pack_hash, &old_hash_ctx);
-	the_hash_algo->final_fn(new_pack_hash, &new_hash_ctx);
-	write_or_die(pack_fd, new_pack_hash, the_hash_algo->rawsz);
+		hash_algo->final_fn(partial_pack_hash, &old_hash_ctx);
+	hash_algo->final_fn(new_pack_hash, &new_hash_ctx);
+	write_or_die(pack_fd, new_pack_hash, hash_algo->rawsz);
 	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
 }
 
diff --git a/pack.h b/pack.h
index a8da0406299bf267205256aaa8efb215f2ff73be..6d9d477adc83e83d9e9175ccf699c100b4c147c6 100644
--- a/pack.h
+++ b/pack.h
@@ -91,7 +91,9 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offs
 int verify_pack_index(struct packed_git *);
 int verify_pack(struct repository *, struct packed_git *, verify_fn fn, struct progress *, uint32_t);
 off_t write_pack_header(struct hashfile *f, uint32_t);
-void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
+void fixup_pack_header_footer(const struct git_hash_algo *, int,
+			      unsigned char *, const char *, uint32_t,
+			      unsigned char *, off_t);
 char *index_pack_lockfile(int fd, int *is_well_formed);
 
 struct ref;

-- 
2.47.0

