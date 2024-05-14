Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713D4181318
	for <git@vger.kernel.org>; Tue, 14 May 2024 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716618; cv=none; b=qWLcQ24ZYf4dk4Gi7uYcoaBNi7D2OSP7hPc6WefzH2wU8eWtyQFTpoNZv3rBcPIsZBjdyjZ5oFkgKnAcjgVCybWORXqXbBMfn1LR/vARv7Rqx6zCPxXcNr5tfOSCdkIC5sZKtrDRC0Yufzh52AcScYDM7img7n05YDkvK8g5XPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716618; c=relaxed/simple;
	bh=4Vz6cCvmiUoddiTWDKwFmI6fIPXoqUL/ACHnWR/H/bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2qr3OX48iSaTXZieCZcTk+9xszPBfzOaONaSTHGZoXFFIzC/9PvEKZyay4OywbdMcRPP5t9culEm08A5FCbIuUh7KWFgMAtQ1Yl6o28imx1p4RPCqPUwKx+Yh70r5pgg7sSCmE/lYgmYeZgVghzvDCVz6jS31Fn/O72voP+vrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=gspRVBX3; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gspRVBX3"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-792b934de39so520195285a.3
        for <git@vger.kernel.org>; Tue, 14 May 2024 12:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715716615; x=1716321415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DtJ+lV7XgBbq32BQT3DpjqKGF9XYzIDWJvQRTihEwQI=;
        b=gspRVBX3G1QFlgbY3gpgmeawX5uMmt+5NIgYxXL+gtDvQjgP249YKAqJ4gTvRK1/Mu
         bvT/6HxClgoKsJrMcrtHdTsdHIBlk+gHT4T8lcp0VR/6hfw5IxuxjWdVAkimwVXKgsgA
         AJbBhAYNo0JGW+RNufF4uPUbDy11/9TzFaoYzO+IBieYpFn1SiqBfXVn3YQFr5DIrmCq
         28BH7rr90V/HlUPUo8xq4I69emmuGqtqhE9j5M2hfdxQQVmb2NoARb2gF7QrMzEL7ul3
         /Q9XnFuCzUKRUWsa3yb5vY/7NTzosfRqnSQpKjkxOiQ1b4TaMDFGfIw+BaxX0k5iMOgh
         at4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716615; x=1716321415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtJ+lV7XgBbq32BQT3DpjqKGF9XYzIDWJvQRTihEwQI=;
        b=YykbgD9NaEEyZu/ISphEENZj3mPSuYMARVrkfIaVceqFcglX2+DV1bzZf0kqnw4JO0
         QOZwzv36qvyTtazZyCZbGFbMXVpddz4fsv/2GtxXNr+3KMR4XEAQqevM5FHXsi1tCuOA
         LXQZ6TA46idPUAruq8MoeoLNnpSTE3ZB3R/7Ndd7qj4+xKZ2EYBtOty6hgEIhQp/fqn7
         o9qcB9oFgYs5j1MttiL9VZIdnVzTdgse3ByAQIQI1bHjgyUYycUz52IHzP8nkcBCu/i3
         sJL3pQnxH2FXBOvZjVpqw5qxOJM8ele0/C5z4/mtwdjVaRI6KMuqtU0QyKF+dUDeFEzv
         Q4Cg==
X-Gm-Message-State: AOJu0YzIQL7jPHGnzqIUl32dfbwOWlp30SKMjSbYw/06sfEVqOQAHJ4V
	Kk/0JAjIN9WFzvzA+/E+Eev1F1Jl5uuebAs0aIRbm6QEAbOCcQuBU2OpLR799/Qybf3TMkeWEDc
	m
X-Google-Smtp-Source: AGHT+IEQcq97Gb9C6sOoO+QYXeBKPYQV5X8cVjkNSsAe7JG9ukXPhg+LmGZ1A2yMSF2sJ71sl7MTJg==
X-Received: by 2002:a05:620a:3cb:b0:792:a1c5:659f with SMTP id af79cd13be357-792c75abda4mr1483890385a.32.1715716615066;
        Tue, 14 May 2024 12:56:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf3106c2sm597786285a.106.2024.05.14.12.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 12:56:54 -0700 (PDT)
Date: Tue, 14 May 2024 15:56:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/6] pack-bitmap-write.c: move commit_positions into
 commit_pos fields
Message-ID: <cbedff02ed1409c2b5f97596fe0b43d0a4a4d0ff.1715716605.git.me@ttaylorr.com>
References: <cover.1715716605.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1715716605.git.me@ttaylorr.com>

In 7cc8f971085 (pack-objects: implement bitmap writing, 2013-12-21), the
bitmapped_commit struct was introduced, including the 'commit_pos'
field, which has been unused ever since its introduction more than a
decade ago.

Instead, we have used the nearby `commit_positions` array leaving the
bitmapped_commit struct with an unused 4-byte field.

We could drop the `commit_pos` field as unused, and continue to store
the values in the auxiliary array. But we could also drop the array and
store the data for each bitmapped_commit struct inside of the structure
itself, which is what this patch does.

In any spot that we previously read `commit_positions[i]`, we can now
instead read `writer.selected[i].commit_pos`. There are a few spots that
need changing as a result:

  - write_selected_commits_v1() is a simple transformation, since we're
    just reading the field. As a result, the function no longer needs an
    explicit argument to pass the commit_positions array.

  - write_lookup_table() also no longer needs the explicit
    commit_positions array passed in as an argument. But it still needs
    to sort an array of indices into the writer.selected array to read
    them in commit_pos order, so table_cmp() is adjusted accordingly.

  - bitmap_writer_finish() no longer needs to allocate, populate, and
    free the commit_positions table. Instead, we can just write the data
    directly into each struct bitmapped_commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index c6c8f94cc5..2ae82b8696 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -670,9 +670,7 @@ static const struct object_id *oid_access(size_t pos, const void *table)
 	return &index[pos]->oid;
 }
 
-static void write_selected_commits_v1(struct hashfile *f,
-				      uint32_t *commit_positions,
-				      off_t *offsets)
+static void write_selected_commits_v1(struct hashfile *f, off_t *offsets)
 {
 	int i;
 
@@ -682,7 +680,7 @@ static void write_selected_commits_v1(struct hashfile *f,
 		if (offsets)
 			offsets[i] = hashfile_total(f);
 
-		hashwrite_be32(f, commit_positions[i]);
+		hashwrite_be32(f, stored->commit_pos);
 		hashwrite_u8(f, stored->xor_offset);
 		hashwrite_u8(f, stored->flags);
 
@@ -690,23 +688,20 @@ static void write_selected_commits_v1(struct hashfile *f,
 	}
 }
 
-static int table_cmp(const void *_va, const void *_vb, void *_data)
+static int table_cmp(const void *_va, const void *_vb)
 {
-	uint32_t *commit_positions = _data;
-	uint32_t a = commit_positions[*(uint32_t *)_va];
-	uint32_t b = commit_positions[*(uint32_t *)_vb];
+	struct bitmapped_commit *a = &writer.selected[*(uint32_t *)_va];
+	struct bitmapped_commit *b = &writer.selected[*(uint32_t *)_vb];
 
-	if (a > b)
+	if (a->commit_pos < b->commit_pos)
+		return -1;
+	else if (a->commit_pos > b->commit_pos)
 		return 1;
-	else if (a < b)
-		return -1;
 
 	return 0;
 }
 
-static void write_lookup_table(struct hashfile *f,
-			       uint32_t *commit_positions,
-			       off_t *offsets)
+static void write_lookup_table(struct hashfile *f, off_t *offsets)
 {
 	uint32_t i;
 	uint32_t *table, *table_inv;
@@ -722,7 +717,7 @@ static void write_lookup_table(struct hashfile *f,
 	 * bitmap corresponds to j'th bitmapped commit (among the selected
 	 * commits) in lex order of OIDs.
 	 */
-	QSORT_S(table, writer.selected_nr, table_cmp, commit_positions);
+	QSORT(table, writer.selected_nr, table_cmp);
 
 	/* table_inv helps us discover that relationship (i'th bitmap
 	 * to j'th commit by j = table_inv[i])
@@ -753,7 +748,7 @@ static void write_lookup_table(struct hashfile *f,
 			xor_row = 0xffffffff;
 		}
 
-		hashwrite_be32(f, commit_positions[table[i]]);
+		hashwrite_be32(f, writer.selected[table[i]].commit_pos);
 		hashwrite_be64(f, (uint64_t)offsets[table[i]]);
 		hashwrite_be32(f, xor_row);
 	}
@@ -789,7 +784,6 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	static uint16_t flags = BITMAP_OPT_FULL_DAG;
 	struct strbuf tmp_file = STRBUF_INIT;
 	struct hashfile *f;
-	uint32_t *commit_positions = NULL;
 	off_t *offsets = NULL;
 	uint32_t i;
 
@@ -814,22 +808,20 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	if (options & BITMAP_OPT_LOOKUP_TABLE)
 		CALLOC_ARRAY(offsets, index_nr);
 
-	ALLOC_ARRAY(commit_positions, writer.selected_nr);
-
 	for (i = 0; i < writer.selected_nr; i++) {
 		struct bitmapped_commit *stored = &writer.selected[i];
-		int commit_pos = oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
+		int commit_pos = oid_pos(&stored->commit->object.oid, index,
+					 index_nr, oid_access);
 
 		if (commit_pos < 0)
 			BUG(_("trying to write commit not in index"));
-
-		commit_positions[i] = commit_pos;
+		stored->commit_pos = commit_pos;
 	}
 
-	write_selected_commits_v1(f, commit_positions, offsets);
+	write_selected_commits_v1(f, offsets);
 
 	if (options & BITMAP_OPT_LOOKUP_TABLE)
-		write_lookup_table(f, commit_positions, offsets);
+		write_lookup_table(f, offsets);
 
 	if (options & BITMAP_OPT_HASH_CACHE)
 		write_hash_cache(f, index, index_nr);
@@ -844,6 +836,5 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 		die_errno("unable to rename temporary bitmap file to '%s'", filename);
 
 	strbuf_release(&tmp_file);
-	free(commit_positions);
 	free(offsets);
 }
-- 
2.45.1.151.g7cc3499008c

