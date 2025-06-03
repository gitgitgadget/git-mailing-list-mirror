Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795DC2C3261
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 03:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748920451; cv=none; b=TeK7oq+PVphqS9T451WHH7ZJS5epZEb7CevPliNBycvPeqgt34sMSV8EUJchkd7S3imQzM4HAngy54ENZYDTIL9ZBz4jHLeZUSN3/uLZC66nT5N1wniVha1wNa6fsob4sa9nOkkWjng7NHs/T5RkrnETTJtfm1Pc12fgY8y9dX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748920451; c=relaxed/simple;
	bh=RpwVzxoXKaaf/mQIfFn2EXefXwpp8kdR897We1KsXf8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dP8rjammOCEzDoltGDCqCmYyPU/FFqGmKgWNVD8OJYBaxikwjBuPAAbvPg26cvWtcJAiEYDkn/S+TAYWDXOujXf4GoNhcP9WLrPSI9/CRJCvtCJcanBVEY+uxCeYUmvkzEP/QkF5OP2p4fseie0yrBipmVZdgRFDi7T8j/jLJxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEN3UEjF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEN3UEjF"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a51481a598so92535f8f.3
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 20:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748920447; x=1749525247; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vro9RVNZauL8/MTYNtOu7fUG/3SU97unHq0dwnS2n7o=;
        b=jEN3UEjFs1LeMOeGpn0uiRQqjiiD2zUt4ZCOYLHxynlONQxdjgZIAijphpC9+vsHpg
         md7U6yiGsVVysShuNVLfKdU8K1cXVGe3iE/jBC4ShzMTD5VMm1rihsV8q5kErrE/h+1I
         uyRGsbRQrSRPNGH+BlGUPIPbsGwOPNssFgaV6Qd0zuLWKZRjdjuXgtdN7zsBEA/J8Mlr
         Ny7/dAP2EYCsgJTSUfGm6gURJvs50O8zIoMl8m12Q5fqe74bKXAFMDFnlE0f57Jt9jf7
         R6XPKKs/YC15TvhM/zUCPGH/8Mlr0lccU87CeMnx7FISkUFT0vppi6rXhO8GEWtoVhsD
         CwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748920447; x=1749525247;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vro9RVNZauL8/MTYNtOu7fUG/3SU97unHq0dwnS2n7o=;
        b=ihxDVYSAN5EW5UaeVlmJA0iWZHxPK3voSPd7ZS+hjD0CUKTe8puInuqIODFg1meqKY
         e4paz9hUNwCFMz7W+kJAzuqnWgmXuB4plGjHUNfYwCF0LBKm5qV4f+UP0u0895XjXFM/
         xh95OGB3flLzwwCefEd5M3l7cKwKWl9iyi3qZkkihEk9sa99+jFZVc4Rnm3YMsRQaFvy
         Zt8SC/Ab1vYnrAZ7l4t5NIaW37GPqek1GYy7SUl76qB1A0e6ZO6bsxfQZdPBVXhzaP9e
         ekNleMTv/1EyDIhFCohOi8FeKWukEk9GN0i1P0OHKP+q6AnDD8tZfX3fGMBpcvo2XOv2
         L3nA==
X-Gm-Message-State: AOJu0Yz/OeC5g6pS3Vguys9Yksg1706whvUjEwa7NHGoBKMKVVfh9obQ
	Jr2iXc5vAiDxyLAFMVkKV0mGEVgCl/Cf35Q7iw/u7cQWkZwp1XS5aIYfANwbWg==
X-Gm-Gg: ASbGncsz+I1oba3wfDLK7FQ3BEtv9e2oBNAHk0nB5KLgWgJaCIHifVdZD/p8rvRCcYr
	uPXMqDmsgg62qRG7oSXg+SkbkXUwVz2gkYp3lAxz3V0XIh/BW+B/f9tCTR9BRDgSfQfGcmCAsds
	PpFLK0Bj1a3S2RLX1rDKU7zVyVdk45GIqhEaM5Vv+PBJiqc5+Bud5oQaQZXuBgWTaFLqX0h+HJu
	TF9374iBQbr/2YMkykjuW6KXAon6+qWUAjv1nqH5R7pztqivO2FjiztNw021j4VDldhitfYq5Af
	wO+ejfZF0HkWSDOZRRUka1I8f2d3JqkZBTt+3z4xea1rKqcnxggaA292XVIGn8M=
X-Google-Smtp-Source: AGHT+IElcoLmxh+gXxyIPmY0PJuQ3am6EzwxvZRqmFmF7DK3roSpPFRUwVLkbIc529px1jR38TYTZQ==
X-Received: by 2002:a05:6000:220b:b0:3a4:edf5:b952 with SMTP id ffacd0b85a97d-3a4fe394872mr8086880f8f.36.1748920447096;
        Mon, 02 Jun 2025 20:14:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b92bsm16498490f8f.9.2025.06.02.20.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 20:14:06 -0700 (PDT)
Message-Id: <pull.1962.v5.git.git.1748920444.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v4.git.git.1748140983.gitgitgadget@gmail.com>
References: <pull.1962.v4.git.git.1748140983.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Jun 2025 03:14:01 +0000
Subject: [PATCH v5 0/3] pack-bitmap: fix memory leak if load_bitmap failed
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

This patch prevents pack-bitmap.c:load_bitmap() from nulling
bitmap_git->bitmap when loading failed thus eliminates memory leak. This
patch also add a test case in t5310 which use clang leak sanitizer to detect
whether leak happens when loading failed.

Lidong Yan (2):
  pack-bitmap: reword comments in test_bitmap_commits()
  pack-bitmap: add load corrupt bitmap test

Taylor Blau (1):
  pack-bitmap: fix memory leak if load_bitmap() failed

 pack-bitmap.c           | 88 ++++++++++++++++++++++++++++++-----------
 pack-bitmap.h           |  1 +
 t/helper/test-bitmap.c  |  8 ++++
 t/t5310-pack-bitmaps.sh | 30 ++++++++++++++
 4 files changed, 103 insertions(+), 24 deletions(-)


base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1962%2Fbrandb97%2Ffix-pack-bitmap-leak-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1962/brandb97/fix-pack-bitmap-leak-v5
Pull-Request: https://github.com/git/git/pull/1962

Range-diff vs v4:

 1:  b6b3a83a224 ! 1:  9ce2135df2a pack-bitmap: fix memory leak if load_bitmap() failed
     @@ Commit message
          its caller will always call free_bitmap_index() in case of an error.
      
          Signed-off-by: Taylor Blau <me@ttaylorr.com>
     +    Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
      
       ## pack-bitmap.c ##
      @@ pack-bitmap.c: static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git,
 -:  ----------- > 2:  a75d0a3cc7f pack-bitmap: reword comments in test_bitmap_commits()
 2:  7876d9a9014 ! 3:  05140e2171d pack-bitmap: add load corrupt bitmap test
     @@ Commit message
      
       ## pack-bitmap.c ##
      @@ pack-bitmap.c: struct stored_bitmap {
     + 	struct object_id oid;
     + 	struct ewah_bitmap *root;
     + 	struct stored_bitmap *xor;
     ++	size_t map_pos;
       	int flags;
       };
       
     -+struct stored_bitmap_tag_pos {
     -+	struct stored_bitmap stored;
     -+	size_t map_pos;
     -+};
     -+
     - /*
     -  * The active bitmap index for a repository. By design, repositories only have
     -  * a single bitmap index available (the index for the biggest packfile in
     -@@ pack-bitmap.c: static int existing_bitmaps_hits_nr;
     - static int existing_bitmaps_misses_nr;
     - static int roots_with_bitmaps_nr;
     - static int roots_without_bitmaps_nr;
     -+static int tag_pos_on_bitmap;
     - 
     - static struct ewah_bitmap *lookup_stored_bitmap(struct stored_bitmap *st)
     - {
      @@ pack-bitmap.c: static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
       					  struct ewah_bitmap *root,
       					  const struct object_id *oid,
     @@ pack-bitmap.c: static struct stored_bitmap *store_bitmap(struct bitmap_index *in
      +					  int flags, size_t map_pos)
       {
       	struct stored_bitmap *stored;
     -+	struct stored_bitmap_tag_pos *tagged;
       	khiter_t hash_pos;
       	int ret;
       
     --	stored = xmalloc(sizeof(struct stored_bitmap));
     -+	tagged = xmalloc(tag_pos_on_bitmap ? sizeof(struct stored_bitmap_tag_pos) :
     -+					     sizeof(struct stored_bitmap));
     -+	stored = &tagged->stored;
     -+	if (tag_pos_on_bitmap)
     -+		tagged->map_pos = map_pos;
     + 	stored = xmalloc(sizeof(struct stored_bitmap));
     ++	stored->map_pos = map_pos;
       	stored->root = root;
       	stored->xor = xor_with;
       	stored->flags = flags;
     @@ pack-bitmap.c: int test_bitmap_commits(struct repository *r)
       	return 0;
       }
       
     -+int test_bitmap_commits_offset(struct repository *r)
     ++int test_bitmap_commits_with_offset(struct repository *r)
      +{
      +	struct object_id oid;
     -+	struct stored_bitmap_tag_pos *tagged;
     ++	struct stored_bitmap *stored;
      +	struct bitmap_index *bitmap_git;
      +	size_t commit_idx_pos_map_pos, xor_offset_map_pos, flag_map_pos,
      +		ewah_bitmap_map_pos;
      +
     -+	tag_pos_on_bitmap = 1;
      +	bitmap_git = prepare_bitmap_git(r);
      +	if (!bitmap_git)
      +		die(_("failed to load bitmap indexes"));
      +
      +	/*
     -+	 * As this function is only used to print bitmap selected
     -+	 * commits, we don't have to read the commit table.
     ++	 * Since this function needs to know the position of each individual
     ++	 * bitmap, bypass the commit lookup table (if one exists) by forcing
     ++	 * the bitmap to eagerly load its entries.
      +	 */
      +	if (bitmap_git->table_lookup) {
      +		if (load_bitmap_entries_v1(bitmap_git) < 0)
      +			die(_("failed to load bitmap indexes"));
      +	}
      +
     -+	kh_foreach (bitmap_git->bitmaps, oid, tagged, {
     -+		commit_idx_pos_map_pos = tagged->map_pos;
     -+		xor_offset_map_pos = tagged->map_pos + sizeof(uint32_t);
     ++	kh_foreach (bitmap_git->bitmaps, oid, stored, {
     ++		commit_idx_pos_map_pos = stored->map_pos;
     ++		xor_offset_map_pos = stored->map_pos + sizeof(uint32_t);
      +		flag_map_pos = xor_offset_map_pos + sizeof(uint8_t);
      +		ewah_bitmap_map_pos = flag_map_pos + sizeof(uint8_t);
      +
     @@ pack-bitmap.h: void traverse_bitmap_commit_list(struct bitmap_index *,
       				 show_reachable_fn show_reachable);
       void test_bitmap_walk(struct rev_info *revs);
       int test_bitmap_commits(struct repository *r);
     -+int test_bitmap_commits_offset(struct repository *r);
     ++int test_bitmap_commits_with_offset(struct repository *r);
       int test_bitmap_hashes(struct repository *r);
       int test_bitmap_pseudo_merges(struct repository *r);
       int test_bitmap_pseudo_merge_commits(struct repository *r, uint32_t n);
     @@ t/helper/test-bitmap.c: static int bitmap_list_commits(void)
       	return test_bitmap_commits(the_repository);
       }
       
     -+static int bitmap_list_commits_offset(void)
     ++static int bitmap_list_commits_with_offset(void)
      +{
     -+	return test_bitmap_commits_offset(the_repository);
     ++	return test_bitmap_commits_with_offset(the_repository);
      +}
      +
       static int bitmap_dump_hashes(void)
     @@ t/helper/test-bitmap.c: int cmd__bitmap(int argc, const char **argv)
       
       	if (argc == 2 && !strcmp(argv[1], "list-commits"))
       		return bitmap_list_commits();
     -+	if (argc == 2 && !strcmp(argv[1], "list-commits-offset"))
     -+		return bitmap_list_commits_offset();
     ++	if (argc == 2 && !strcmp(argv[1], "list-commits-with-offset"))
     ++		return bitmap_list_commits_with_offset();
       	if (argc == 2 && !strcmp(argv[1], "dump-hashes"))
       		return bitmap_dump_hashes();
       	if (argc == 2 && !strcmp(argv[1], "dump-pseudo-merges"))
     @@ t/helper/test-bitmap.c: int cmd__bitmap(int argc, const char **argv)
       		return bitmap_dump_pseudo_merge_objects(atoi(argv[2]));
       
       	usage("\ttest-tool bitmap list-commits\n"
     -+	      "\ttest-tool bitmap list-commits-offset\n"
     ++	      "\ttest-tool bitmap list-commits-with-offset\n"
       	      "\ttest-tool bitmap dump-hashes\n"
       	      "\ttest-tool bitmap dump-pseudo-merges\n"
       	      "\ttest-tool bitmap dump-pseudo-merge-commits <n>\n"
     @@ t/t5310-pack-bitmaps.sh: test_bitmap_cases () {
      +			bitmap="$(ls .git/objects/pack/pack-*.bitmap)" &&
      +			chmod +w $bitmap &&
      +
     -+			read oid commit_off xor_off flag_off ewah_off <<-EOF &&
     -+				$(test-tool bitmap list-commits-offset | head -n 1)
     -+			EOF
     ++			test-tool bitmap list-commits-with-offset >offsets &&
     ++			xor_off=$(head -n1 offsets | awk "{print \$3}") &&
      +			printf '\161' |
      +				dd of=$bitmap count=1 bs=1 conv=notrunc seek=$xor_off &&
      +
     ++			git rev-list --objects --no-object-names HEAD >expect.raw &&
     ++			git rev-list --objects --use-bitmap-index --no-object-names HEAD \
     ++				>actual.raw &&
     ++
     ++			sort expect.raw >expect &&
     ++			sort actual.raw >actual &&
      +
     -+			git rev-list --count HEAD > expect &&
     -+			git rev-list --use-bitmap-index --count HEAD > actual &&
     -+			test_cmp expect actual
     ++		    test_cmp expect actual
      +		)
      +	'
       }

-- 
gitgitgadget
