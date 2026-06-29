Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E3E3F8254
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723744; cv=none; b=ji4/NXxoTZCtcFiYWG7+cMvK5fptp0HlMdkOgODYX/3qUpJpwa06G/+rw7/+KYey8WfLVClGGxYbn4K1uGOtI3Xsn90sjcC/AOO2qsP9+0umQHhhObhQiwXLxAgVyZcXGzbU5zDrewL96/DdzYsD1/sBPZ1bcnQfqawQkaQpzco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723744; c=relaxed/simple;
	bh=7hM21DfoHfO+airwXsgqXCfrutRzAD3wVXWkO+pBZ0w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=r3TxAD7gcEZp5VxiBOuXBGCnfiBunatUX2bVZ68hYdpWiOlLMqZvEV3Whiik3aeoxKc0J0Bz0lP7/4vkuEOK5669rf7ejtWUstu/p+pkxm3zOukEVZ4zPlDrMCY5Jl8u+0tyUXgCmzmijWanIJaWi3RBEiXuXVTEUridjJ5ShcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S6zzipfJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ePGE7N2K; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S6zzipfJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ePGE7N2K"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 313117A00D4;
	Mon, 29 Jun 2026 05:02:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 29 Jun 2026 05:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782723742;
	 x=1782810142; bh=SRzY20F8ycrLXIoj3SdM46qwDRm1Emx8dy4rCrj1oes=; b=
	S6zzipfJ4J5kpoF6rdLd4OUIDWn5Y7TBkwrmjLbm/cUlGTRCQrdoZoiGw2HsXaFu
	oJGO5VgEXCr9TpDl38QwgPZ5+955Ov6s1GVFe/tbiFhSvDCDxBdyg6smbxdgObWH
	uGwpw70WPVdvfS/4FH8EF+fCb0Br9JdCzX2FRMO13VXAY4BQgMt1AZC2qo5+bGjZ
	ilTOhfKeuRxnZVBOmRPzMEPbKTPlI69LvnKoFSvplWH1tcyPQWdbJWtjeED+Q1nM
	n2QfiwKnfhi3QfUZIonrm52hy/tRa7ApX4mvBl2i9rnMvnKHixQxeB/cl1BaVRtG
	amK3y8HCRS7Wg2ZZMJqqRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782723742; x=
	1782810142; bh=SRzY20F8ycrLXIoj3SdM46qwDRm1Emx8dy4rCrj1oes=; b=e
	PGE7N2KRLlbTPzVpcgu0UMM5upmUbnN1/7CTPR22YwTfAhTkFhOfg4rv4irbWeMu
	nWJHhAZRLp7Odi1TYdogvZ8+HeaX73WjPZDd5v2mBEpGBzTQ8xvMrjMrDO81r15W
	4tKgQgyEYm/LVU0FJbvXcC0mpBPjNUzkmtmVycTFXgta451r4het6YiXj9+VrYLd
	tXr4TcHgIUN8MCFU7zND+DAcg0SL/DYeNetuv8HOIa9vx4Cej//xflXvgqY80etr
	VC1P8kbIDoubm+NRmWXqrwDoDXqS5V0r5/tnLhMQzKse4OnNL/h7xBXC6bUWz+Gd
	9yW3YKhM8l9Bhcd7MbPAg==
X-ME-Sender: <xms:nTRCaiX6H8WfzOc6O-Rzozp4SLMgHjRtbq8PRhVuVC-n6C7z5h1cqQ>
    <xme:nTRCamC3SAu8RfICYHlgzMUlUvI2SVQjQjObVRpWU-w_Xfhxs-28K8CFJHJ4IyLKC
    yysSeTJktFTwYXlWc2SQnBehzwFNCaAKr48vJVRa1GjQAMGTVzOH4o>
X-ME-Received: <xmr:nTRCajxctKPz60V18X834ECHO14TWoAoT_4QjN_4zScIAdlwQ3QxNXQPplf9sB8rXGOMleGTYCANtg15sCgGZNl7qVDfreAQR3uodMcia3IE>
X-ME-Proxy-Cause: dmFkZTEiK9aH6JM++k7RUyIA/51QuyxRomzw94ZNyikrCJx1afi4EErA8u+xhgErQ7dqg/
    l6bB4jzrcWUjtDk0O7/O1OqRx4idFbP+4Uwu6xpAhFCWMbEGibf+JvmP/9OzW9bt3Bb/1B
    8BAK7n/djZt5RnrnrgKVTt0Jp9dtBIADoNxbCzzs8vBj6fbnNBJzHdJI+hfQ68ApEPXGon
    C275Mw2cTauVPY7uRTaqrkFu12hu2XeJwN+vgCK3xAP7QJddMXL+CQBNht96yUWxkaQV5k
    57/pIPFaRdYIXBBDjOUFBJ3Ltj4ye9tumUKde+cfdE7rLRpwhKYs4V9BgQ9mdASkkzggdO
    PZC8it5ohWbLt/xAl3bq0Vh0R8XE0U8M5TrUe3ADpbKZyBHekyLALSxQDZiYQ1V9SAPr7C
    dUTNkafYOQyp3Fhg9GAAxvEEcxoCuzDJFYPCsYyiVvP77MjonpRk9BAjSbJMx3kMo0w1cB
    14VzDDe8w8zYV8QV4Xgh230mz6q0ZsxzJPh1sXdg755ttA8iCLKKUp1UqJDAE0i+O9KSjF
    A8lPu0rKZLY/EWxJg2FnDF1SDclPLxm0V4INX4QGNF9Oo0UU0RynYCerS+RA+mWevNF99b
    SaVtOpyrNsOYWfeR+PY/rOn/sE0KxADNTpM1qy7N3e9iMo6SFpbGuuOH5cPA
X-ME-Proxy: <xmx:nTRCajCxw7aaKezHd9Rjt5-FIEWO-Xd2EbCo6FQ80IbRSIoFqPmJ3g>
    <xmx:nTRCagYNJQV1HJkg5SfXkXS55tB2rFieGo6pXItqFRJbCzyNWUWG1w>
    <xmx:nTRCarhwk7qRlz3xBONIr2N-E6i6jXb0qDhUf54TRv8Skgmr7r9A5Q>
    <xmx:nTRCai5Yf8-XV79yTPdl-WZrUsbr_YLMFgsQ6f5bEAtSHuTInFOuVA>
    <xmx:njRCak9ScpFQbpS_K-_eP4sISzb7i3O2TfjTicKsAcAx89zD1k33hRGW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 05:02:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0df924eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 09:02:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/12] reftable: harden against corrupted tables
Date: Mon, 29 Jun 2026 11:02:13 +0200
Message-Id: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJU0QmoC/3WNQQ6CMBBFr0Jm7RgoOIor72FYlDLAqBTSItEQ7
 m7BuHT5kvf/m8GzE/ZwjmZwPImX3gZQuwhMq23DKFVgULGimFSKw92j43rU5YOx1a5iK7bB+pB
 VTHnNmlII4yE48tqOr8WX/bO8sRnXt9VoxY+9e2/lKVm9XyT7F5kSjJGIM8Ono6EyvwRxLx0Uy
 7J8AF2sZAHLAAAA
X-Change-ID: 20260623-pks-reftable-hardening-f54de69fea63
In-Reply-To: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
References: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

Hi,

this patch series addresses a bunch of errors that may happen when
trying to read corrupted tables. These errors include out-of-bounds
writes, out-of-bounds reads and the ability to hit abort(3p) calls.

The out-of-bounds write was originally reported by awo on the security
mailing list. As we never transfer reftables over the protocol it would
require local disk access to create such corrupted reftables, so there
isn't really an easy way to exploit these.

In any case, I took that chance and wrote a fuzzer for parsing the
tables, which surfaced a bunch of issues. At the end of this series
though the fuzzer can now run for an extended amount of time (2hrs+)
without surfacing any new issues.

Changes in v2:
  - Introduce a test helper that writes a reftable block.
  - Link to v1: https://patch.msgid.link/20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (12):
      meson: support building fuzzers with libFuzzer
      oss-fuzz: add fuzzer for parsing reftables
      reftable/basics: fix OOB read on binary search of empty range
      reftable/record: don't abort when decoding invalid ref value type
      t/unit-tests: introduce test helper to write reftable blocks
      reftable/block: fix OOB write with bogus inflated log size
      reftable/block: fix OOB read with bogus block size
      reftable/block: fix OOB read with bogus restart count
      reftable/block: fix use of uninitialized memory when binsearch fails
      reftable/block: fix OOB read with bogus restart offset
      reftable/table: fix NULL pointer access when seeking to bogus offsets
      reftable/table: fix OOB read on truncated table

 Makefile                            |   1 +
 ci/run-build-and-minimal-fuzzers.sh |   1 +
 meson.build                         |  15 +++
 meson_options.txt                   |   2 +
 oss-fuzz/.gitignore                 |   1 +
 oss-fuzz/fuzz-reftable.c            |  74 +++++++++++++++
 oss-fuzz/meson.build                |   2 +
 reftable/basics.c                   |   3 +
 reftable/block.c                    |  39 +++++++-
 reftable/record.c                   |   6 +-
 reftable/table.c                    |   7 ++
 t/unit-tests/u-reftable-basics.c    |  11 +++
 t/unit-tests/u-reftable-block.c     | 184 ++++++++++++++++++++++++++++++++----
 t/unit-tests/u-reftable-record.c    |  24 +++++
 t/unit-tests/u-reftable-table.c     |  91 ++++++++++++++++++
 15 files changed, 435 insertions(+), 26 deletions(-)

Range-diff versus v1:

 1:  82275a5448 =  1:  5bb58da117 meson: support building fuzzers with libFuzzer
 2:  8b234b5dc6 =  2:  8d11b15082 oss-fuzz: add fuzzer for parsing reftables
 3:  f265bcf6f4 =  3:  21186da3f1 reftable/basics: fix OOB read on binary search of empty range
 4:  a56c6cb50c =  4:  3c327bacc2 reftable/record: don't abort when decoding invalid ref value type
 -:  ---------- >  5:  4125c76a97 t/unit-tests: introduce test helper to write reftable blocks
 5:  9074372e30 !  6:  e923c23518 reftable/block: fix OOB write with bogus inflated log size
    @@ reftable/block.c: int reftable_block_init(struct reftable_block *block,
     
      ## t/unit-tests/u-reftable-block.c ##
     @@ t/unit-tests/u-reftable-block.c: void test_reftable_block__iterator(void)
    - 	block_writer_release(&writer);
    + 	reftable_block_release(&block);
      	reftable_buf_release(&data);
      }
     +
     +void test_reftable_block__corrupt_log_block_size(void)
     +{
     +	struct reftable_block_source source = { 0 };
    -+	struct block_writer writer = {
    -+		.last_key = REFTABLE_BUF_INIT,
    -+	};
     +	struct reftable_record rec = {
     +		.type = REFTABLE_BLOCK_TYPE_LOG,
     +		.u.log = {
    @@ t/unit-tests/u-reftable-block.c: void test_reftable_block__iterator(void)
     +		},
     +	};
     +	struct reftable_block block = { 0 };
    -+	struct reftable_buf data;
    -+
    -+	data.len = 1024;
    -+	REFTABLE_CALLOC_ARRAY(data.buf, data.len);
    -+	cl_assert(data.buf != NULL);
    ++	struct reftable_buf data = REFTABLE_BUF_INIT;
     +
    -+	cl_must_pass(block_writer_init(&writer, REFTABLE_BLOCK_TYPE_LOG,
    -+				       (uint8_t *) data.buf, data.len,
    -+				       0, hash_size(REFTABLE_HASH_SHA1)));
    -+	cl_must_pass(block_writer_add(&writer, &rec));
    -+	cl_assert(block_writer_finish(&writer) > 0);
    ++	cl_reftable_write_block(&data, REFTABLE_BLOCK_TYPE_LOG, &rec, 1);
     +
     +	/*
     +	 * Log blocks store their inflated size as a big-endian 24-bit integer
    @@ t/unit-tests/u-reftable-block.c: void test_reftable_block__iterator(void)
     +			  REFTABLE_FORMAT_ERROR);
     +
     +	reftable_block_release(&block);
    -+	block_writer_release(&writer);
     +	reftable_buf_release(&data);
     +}
 6:  6877f58485 !  7:  16c2904a96 reftable/block: fix OOB read with bogus block size
    @@ reftable/block.c: int reftable_block_init(struct reftable_block *block,
     
      ## t/unit-tests/u-reftable-block.c ##
     @@ t/unit-tests/u-reftable-block.c: void test_reftable_block__corrupt_log_block_size(void)
    - 	block_writer_release(&writer);
    + 	reftable_block_release(&block);
      	reftable_buf_release(&data);
      }
     +
     +void test_reftable_block__corrupt_block_size(void)
     +{
     +	struct reftable_block_source source = { 0 };
    -+	struct block_writer writer = {
    -+		.last_key = REFTABLE_BUF_INIT,
    -+	};
     +	struct reftable_record rec = {
     +		.type = REFTABLE_BLOCK_TYPE_REF,
     +		.u.ref = {
    @@ t/unit-tests/u-reftable-block.c: void test_reftable_block__corrupt_log_block_siz
     +		},
     +	};
     +	struct reftable_block block = { 0 };
    -+	struct reftable_buf data;
    -+
    -+	data.len = 1024;
    -+	REFTABLE_CALLOC_ARRAY(data.buf, data.len);
    -+	cl_assert(data.buf != NULL);
    ++	struct reftable_buf data = REFTABLE_BUF_INIT;
     +
    -+	cl_must_pass(block_writer_init(&writer, REFTABLE_BLOCK_TYPE_REF,
    -+				       (uint8_t *) data.buf, data.len,
    -+				       0, hash_size(REFTABLE_HASH_SHA1)));
    -+	cl_must_pass(block_writer_add(&writer, &rec));
    -+	cl_assert(block_writer_finish(&writer) > 0);
    ++	cl_reftable_write_block(&data, REFTABLE_BLOCK_TYPE_REF, &rec, 1);
     +
     +	/*
     +	 * The block size is stored as a big-endian 24-bit integer right after
    @@ t/unit-tests/u-reftable-block.c: void test_reftable_block__corrupt_log_block_siz
     +			  REFTABLE_FORMAT_ERROR);
     +
     +	reftable_block_release(&block);
    -+	block_writer_release(&writer);
     +	reftable_buf_release(&data);
     +}
 7:  3c022a4f97 !  8:  872eca67bb reftable/block: fix OOB read with bogus restart count
    @@ reftable/block.c: int reftable_block_init(struct reftable_block *block,
     
      ## t/unit-tests/u-reftable-block.c ##
     @@ t/unit-tests/u-reftable-block.c: void test_reftable_block__corrupt_block_size(void)
    - 	block_writer_release(&writer);
    + 	reftable_block_release(&block);
      	reftable_buf_release(&data);
      }
     +
     +void test_reftable_block__corrupt_restart_count(void)
     +{
     +	struct reftable_block_source source = { 0 };
    -+	struct block_writer writer = {
    -+		.last_key = REFTABLE_BUF_INIT,
    -+	};
     +	struct reftable_record rec = {
     +		.type = REFTABLE_BLOCK_TYPE_REF,
     +		.u.ref = {
    @@ t/unit-tests/u-reftable-block.c: void test_reftable_block__corrupt_block_size(vo
     +		},
     +	};
     +	struct reftable_block block = { 0 };
    -+	struct reftable_buf data;
    ++	struct reftable_buf data = REFTABLE_BUF_INIT;
     +	int block_size;
     +
    -+	data.len = 1024;
    -+	REFTABLE_CALLOC_ARRAY(data.buf, data.len);
    -+	cl_assert(data.buf != NULL);
    -+
    -+	cl_must_pass(block_writer_init(&writer, REFTABLE_BLOCK_TYPE_REF,
    -+				       (uint8_t *) data.buf, data.len,
    -+				       0, hash_size(REFTABLE_HASH_SHA1)));
    -+	cl_must_pass(block_writer_add(&writer, &rec));
    -+	block_size = block_writer_finish(&writer);
    -+	cl_assert(block_size > 0);
    ++	block_size = cl_reftable_write_block(&data, REFTABLE_BLOCK_TYPE_REF, &rec, 1);
     +
     +	/*
     +	 * Corrupt the restart count to claim a bogus number of restart points.
    @@ t/unit-tests/u-reftable-block.c: void test_reftable_block__corrupt_block_size(vo
     +			  REFTABLE_FORMAT_ERROR);
     +
     +	reftable_block_release(&block);
    -+	block_writer_release(&writer);
     +	reftable_buf_release(&data);
     +}
 8:  af5697b85b =  9:  c82d51c163 reftable/block: fix use of uninitialized memory when binsearch fails
 9:  e9d4eca613 ! 10:  16e1087a66 reftable/block: fix OOB read with bogus restart offset
    @@ reftable/block.c: static int restart_needle_less(size_t idx, void *_args)
     
      ## t/unit-tests/u-reftable-block.c ##
     @@ t/unit-tests/u-reftable-block.c: void test_reftable_block__corrupt_restart_count(void)
    - 	block_writer_release(&writer);
    + 	reftable_block_release(&block);
      	reftable_buf_release(&data);
      }
     +
     +void test_reftable_block__corrupt_restart_offset(void)
     +{
     +	struct reftable_block_source source = { 0 };
    -+	struct block_writer writer = {
    -+		.last_key = REFTABLE_BUF_INIT,
    -+	};
     +	struct reftable_record rec = {
     +		.type = REFTABLE_BLOCK_TYPE_REF,
     +		.u.ref = {
    @@ t/unit-tests/u-reftable-block.c: void test_reftable_block__corrupt_restart_count
     +	struct reftable_block block = { 0 };
     +	struct block_iter it = BLOCK_ITER_INIT;
     +	struct reftable_buf want = REFTABLE_BUF_INIT;
    -+	struct reftable_buf data;
    -+
    -+	data.len = 1024;
    -+	REFTABLE_CALLOC_ARRAY(data.buf, data.len);
    -+	cl_assert(data.buf != NULL);
    ++	struct reftable_buf data = REFTABLE_BUF_INIT;
     +
    -+	cl_must_pass(block_writer_init(&writer, REFTABLE_BLOCK_TYPE_REF,
    -+				       (uint8_t *) data.buf, data.len,
    -+				       0, hash_size(REFTABLE_HASH_SHA1)));
    -+	cl_must_pass(block_writer_add(&writer, &rec));
    -+	cl_assert(block_writer_finish(&writer) > 0);
    ++	cl_reftable_write_block(&data, REFTABLE_BLOCK_TYPE_REF, &rec, 1);
     +
     +	block_source_from_buf(&source, &data);
     +	cl_must_pass(reftable_block_init(&block, &source, 0, 0, data.len,
    @@ t/unit-tests/u-reftable-block.c: void test_reftable_block__corrupt_restart_count
     +	reftable_buf_release(&want);
     +	block_iter_close(&it);
     +	reftable_block_release(&block);
    -+	block_writer_release(&writer);
     +	reftable_buf_release(&data);
     +}
10:  4bb729aeb0 = 11:  63dd98f908 reftable/table: fix NULL pointer access when seeking to bogus offsets
11:  e3bca6af6e = 12:  32696a01bc reftable/table: fix OOB read on truncated table

---
base-commit: ab776a62a78576513ee121424adb19597fbb7613
change-id: 20260623-pks-reftable-hardening-f54de69fea63

