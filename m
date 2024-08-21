Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A0F192D6A
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244138; cv=none; b=lWLY5qz6Ce9KRCnXxszjCWT2ISxEwhorm+aXZiGm9gElt1bwA+a1kFTF00KVN4rW/oZcmQ+RaJfWfBVGffuMxNw+falM3WHMWF08d3BxcPjrE4j/PacA3XaIkt7twfgjAHwz1QCoWpeu+V1i5ZDlEPOX+Bj/uEDUsXcSOSXWwlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244138; c=relaxed/simple;
	bh=yo1Qfl3QPMjJ+KjDvGo8cEDBWDxZktFNpX17dBWTHJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKT+NwpxH9SdZMjhG45bW7NGFjJ1QzoJEZc4sc2a8w5dpAB3E61nugAdxocHJZNK1/2utEIjUp6/ilm6Z19ML+SzQKk0n77qwuz9Pv5bnvyeLfRU/TtWQIMUu9zWGsAAT3ZX28E/rGLKIKKen2HJMcORTMyaQ/n4SK12wyV7VCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABw0irXQ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABw0irXQ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3b5f2f621so4646114a91.1
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724244135; x=1724848935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2N2JVny8nWloohNtr/5vVr0PVZNFcLLHUrHSjFo/Gw=;
        b=ABw0irXQKhEubsnY5SJbA3dFbbITw8IZvCDeBW4/MEwefyXXT4bz4iB+mBIec1XUZn
         45/RizD48+maC0FjJM7CCpS4GqkCKmTDcoHPmKOgytul5zmmEgKXH1D0Bs2sq+k63Vt4
         A0JlkP7yZ7kSBDg+bH9aio+IrFM+kRWXQbhJGdyRh71Zm3o6r718RxeDSLGhe8H5cIgc
         qj1vLPtmzg1AXOM3h1/5GMylWHtiysiZnqMABU/PA4VUgEYHwrGBPg6RGdiKQjIyXb62
         ifkJGN+rUsvNKwg2/WwpIV7xhf/JIkm+mSnNKb5saJvFLs17j3a5Ri1OnUfEvf5QbHuT
         dtag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244135; x=1724848935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2N2JVny8nWloohNtr/5vVr0PVZNFcLLHUrHSjFo/Gw=;
        b=FXNoaEKi2qSG5eAEGenuSUHi1RMYXIKQL1/Zg1XKOqP0UGdP59HbBwqKYuWQsaxrlF
         jMft3Palr/4NVLBF/in5P6azLkXm9/x9Qvx6v6jH8HAEcOo75kLC8WgKqtuAHkOX7CtH
         swB2YlCc8Bl1QYFIh5fH6kgpyYOyDO5msbuGTGCGRL6BXeEddkRqr9M5D7i/r5692i4B
         HUd7XG1FMqiTssAAtCbuTXpaWiA5eFlP3wbDGThr4jwdSK5VzzYCIJNl0zxdyYHi9BkT
         LVlmY+KcbmAZjrKmXu8p6e59qNYKoJU4oGUNIr0wDt8OH+dwXOlbnUTQa609c/Jsn9cZ
         EZTw==
X-Gm-Message-State: AOJu0YznCXxC3gPUFTGus0eR2JpAKD/8Y58dymKZOASR25RGdbTg4lAV
	TsfREmL3EOaHwy6o84QqCwKvoPU8orrhF3kudZcMbFeumWA/Lktv4ck0IvX6
X-Google-Smtp-Source: AGHT+IEgfPOfCsz1F3r3jAyNbPhg9l/47pYGStgIz2dDX9kR4IahfcOtVAJD+HHYEEvApiDsK1GZMg==
X-Received: by 2002:a17:90b:2712:b0:2d3:b5ca:f1e9 with SMTP id 98e67ed59e1d1-2d5e9ec94d9mr2216992a91.33.1724244135112;
        Wed, 21 Aug 2024 05:42:15 -0700 (PDT)
Received: from Ubuntu.. ([27.59.95.0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d5ebba8853sm1670963a91.56.2024.08.21.05.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:42:14 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v3 00/11] t: port reftable/block_test.c to the unit testing framework
Date: Wed, 21 Aug 2024 18:00:50 +0530
Message-ID: <20240821124150.4463-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240816175414.5169-1-chandrapratap3519@gmail.com>
References: <20240816175414.5169-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reftable library comes with self tests, which are exercised
as part of the usual end-to-end tests and are designed to
observe the end-user visible effects of Git commands. What it
exercises, however, is a better match for the unit-testing
framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
2023-12-09), which is designed to observe how low level
implementation details, at the level of sequences of individual
function calls, behave.

Hence, port reftable/block_test.c to the unit testing framework and
improve upon the ported test. The first patch in the series moves
the test to the unit testing framework, and the rest of the patches
improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v3:
- Use block_source_from_strbuf() instead of malloc_block_source()
  in log, obj, and index block tests (patches 9, 10, 11).
- Remove a line that causes a memory leak in obj test (patch 10).

CI/PR: https://github.com/gitgitgadget/git/pull/1749

Chandra Pratap(11):
t: move reftable/block_test.c to the unit testing framework
t: harmonize t-reftable-block.c with coding guidelines
t-reftable-block: release used block reader
t-reftable-block: use reftable_record_equal() instead of check_str()
t-reftable-block: use reftable_record_key() instead of strbuf_addstr()
t-reftable-block: use block_iter_reset() instead of block_iter_close()
t-reftable-block: use xstrfmt() instead of xstrdup()
t-reftable-block: remove unnecessary variable 'j'
t-reftable-block: add tests for log blocks
t-reftable-block: add tests for obj blocks
t-reftable-block: add tests for index blocks

Makefile                        |   2 +-
reftable/block_test.c           | 123 ------------------------------
reftable/reftable-tests.h       |   1 -
t/helper/test-reftable.c        |   1 -
t/unit-tests/t-reftable-block.c | 370 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
5 files changed, 371 insertions(+), 126 deletions(-)

Range-diff against v2:
1:  502fcc1374 ! 1:  4cd1981016 t-reftable-block: add tests for log blocks
    @@ t/unit-tests/t-reftable-block.c: static void t_block_read_write(void)
     +	int ret;
     +	struct block_reader br = { 0 };
     +	struct block_iter it = BLOCK_ITER_INIT;
    -+	struct strbuf want = STRBUF_INIT;
    ++	struct strbuf want = STRBUF_INIT, buf = STRBUF_INIT;
     +
     +	REFTABLE_CALLOC_ARRAY(block.data, block_size);
     +	block.len = block_size;
    -+	block.source = malloc_block_source();
    ++	block_source_from_strbuf(&block.source ,&buf);
     +	block_writer_init(&bw, BLOCK_TYPE_LOG, block.data, block_size,
     +			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
     +
    @@ t/unit-tests/t-reftable-block.c: static void t_block_read_write(void)
     +	reftable_record_release(&rec);
     +	reftable_block_done(&br.block);
     +	strbuf_release(&want);
    ++	strbuf_release(&buf);
     +	for (i = 0; i < N; i++)
     +		reftable_record_release(&recs[i]);
     +}
2:  e3cefa7e3d ! 2:  4e9752e72a t-reftable-block: add tests for obj blocks
    @@ t/unit-tests/t-reftable-block.c: static void t_log_block_read_write(void)
     +	int ret;
     +	struct block_reader br = { 0 };
     +	struct block_iter it = BLOCK_ITER_INIT;
    -+	struct strbuf want = STRBUF_INIT;
    ++	struct strbuf want = STRBUF_INIT, buf = STRBUF_INIT;
     +
     +	REFTABLE_CALLOC_ARRAY(block.data, block_size);
     +	block.len = block_size;
    -+	block.source = malloc_block_source();
    ++	block_source_from_strbuf(&block.source, &buf);
     +	block_writer_init(&bw, BLOCK_TYPE_OBJ, block.data, block_size,
     +			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
     +
     +	for (i = 0; i < N; i++) {
     +		uint8_t bytes[] = { i, i + 1, i + 2, i + 3, i + 5 }, *allocated;
    -+		allocated = reftable_malloc(ARRAY_SIZE(bytes));
     +		DUP_ARRAY(allocated, bytes, ARRAY_SIZE(bytes));
     +
     +		rec.u.obj.hash_prefix = allocated;
    @@ t/unit-tests/t-reftable-block.c: static void t_log_block_read_write(void)
     +	reftable_record_release(&rec);
     +	reftable_block_done(&br.block);
     +	strbuf_release(&want);
    ++	strbuf_release(&buf);
     +	for (i = 0; i < N; i++)
     +		reftable_record_release(&recs[i]);
     +}
3:  4be7749c4b ! 3:  db62f23594 t-reftable-block: add tests for index blocks
    @@ t/unit-tests/t-reftable-block.c: static void t_obj_block_read_write(void)
     +	int ret;
     +	struct block_reader br = { 0 };
     +	struct block_iter it = BLOCK_ITER_INIT;
    -+	struct strbuf want = STRBUF_INIT;
    ++	struct strbuf want = STRBUF_INIT, buf = STRBUF_INIT;
     +
     +	REFTABLE_CALLOC_ARRAY(block.data, block_size);
     +	block.len = block_size;
    -+	block.source = malloc_block_source();
    ++	block_source_from_strbuf(&block.source, &buf);
     +	block_writer_init(&bw, BLOCK_TYPE_INDEX, block.data, block_size,
     +			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
     +
    @@ t/unit-tests/t-reftable-block.c: static void t_obj_block_read_write(void)
     +	reftable_record_release(&rec);
     +	reftable_block_done(&br.block);
     +	strbuf_release(&want);
    ++	strbuf_release(&buf);
     +	for (i = 0; i < N; i++)
     +		reftable_record_release(&recs[i]);
     +}

