Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE4B1E0DBD
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389851; cv=none; b=ixUaUnsWMsSstm50COO9akvlt1Pwa49ypMbG6d+QCZGX0g5hT5hxkFP55i0632HQg/aizy7cnSP1AqPVeYJalrLWcxulL9co5ok4+2CeoL+toYzc1vCIDaPpDErur51efutWiUFVMsPEgu5mZoetCojfDqGKqZoINOPCrxwECmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389851; c=relaxed/simple;
	bh=BM0snzznvc65otvEFII//9/xkHQLAuXZNlnJRVOTph8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=XN8ePL8o3CN1YaGeHp2JntiSoL/2dQD2faQ29sJaf7KADzVC8s4rtOoHhd3BsCUmDDtx44GywFogXsfeftWkPFRdV1ORqTbIZ/7j559J9ydw1V1MNNHSzITrrwkbP/wMtQbwia8uIuh4zzG65VvxfIAQ58AqIdupbprNgnOUUag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rbTCz8xj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SwP0S5bm; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rbTCz8xj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SwP0S5bm"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 50DD41140212;
	Mon, 20 Jan 2025 11:17:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 20 Jan 2025 11:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737389848;
	 x=1737476248; bh=oPScLLryjO3Wsh95GZ3ks+nf6s/QIRIB+35Q/ZVlGXI=; b=
	rbTCz8xjq1Y9uW9vGBGMX4PGb7yAImxinXbPeSXQGALUJtzxBD7uoy5OTkYa0bMR
	WBQdam6qaDOg/C67dPBh+9XfsvI3QY8ZOnXxo7Y2lr124DmeSku+Sl8d9mROiNe9
	LWPR1MExTxusxRFfgwGx+JUeAAoACUvzxLzVWzfhnePz5mNHmYN30MyMzd4WrFut
	yOnItUPZ4Ou+lC8x2q2mqPBYeveKdKvJxiZrEMKt8WKh+Nw9Ji5EZHlHtMHMzPB+
	3EI3hpUFmjquU8aQa2vl3jNxw12UvTpBkW9epN7RjZPlYAazsQBKNVVJ0dMruI8W
	hgq0u3HeSL6aZhPMMkc4gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737389848; x=
	1737476248; bh=oPScLLryjO3Wsh95GZ3ks+nf6s/QIRIB+35Q/ZVlGXI=; b=S
	wP0S5bmvNahsN9KIBMLrWegebFwlHpIKsBCT5ZorNfT4QjpNRbIjPisIfrWr8rhV
	ojFoq/3J1QiWvMkhsyn77bm8ZQj0XTRPdjPFrkdW+FLh+t2pn/3CoJTEoRqaYNDM
	PdPmNbSXn0jJ/1GgyfruwwZVSnl+Jz0SE+vzeyeuNc7p0+lVP/UdAoYF3OSNkzut
	mSsSjkNS4ChIndNxoRq2m5WPSA1dSgFz8/hTZhnuAYNuZh6SW5/ulNlOaDckLW7S
	T4xfPKiUDcgZiNGF2E8mIltygu9afol9aZ0x8TQ9bF6Hyg/oyCoo2XSib+M0Nz2W
	+PiriLU8uU8Dg+fsBD7vA==
X-ME-Sender: <xms:GHeOZ4-FMInam8Xb1jOzxKthrk8TiKdma-rK3kprEWtFte9Nq5Xoew>
    <xme:GHeOZwt0cWvPgrR-lI2d74x_sqvC107SyoMjnnje15L87lqmiUnnb0tPhkw0d5BPl
    puFzDZQ_29km3AA7A>
X-ME-Received: <xmr:GHeOZ-CiFCk2AbU82awDpys4feHiybLvCuG06_1r0nxZdeH7oALqVZRNjStiloemLcHTlBcSYIKp1Bk-XgpyWTY3wHiHcsc5JPDReg19-iX9ZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheef
    hfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GHeOZ4cFgrM9tR9N4fEHM65v4reAv3aqNv3c1rYxdG8LflOcBRdgHA>
    <xmx:GHeOZ9NoC6Ylm78-pdGwptxK7Pdr1I2ns-C9Z9loUQXzyAxm-ROZdA>
    <xmx:GHeOZynQcxCLLpIC9D61w-a8etJaUqAkLNovqIutp5N5LofvRCcA-A>
    <xmx:GHeOZ_sIvvQWJ_e2-1ZJgUcntuQy4O2CBptp15mFq_ikbqMc3YuQdQ>
    <xmx:GHeOZ2ad3W2QEVFbm6BySa0UcKHJI2rbYN3l1r8zQfjnjLrx5HUEXQ_c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 11:17:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 756b49ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 16:17:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/10] reftable: fix -Wsign-compare warnings
Date: Mon, 20 Jan 2025 17:17:18 +0100
Message-Id: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA53jmcC/42NQQ6CMBBFr0Jm7Zi2Iigr72FYtPCFiQJNS4iGc
 HcrJ3D5fl7eXykiCCJV2UoBi0SZxgTmkFHT27EDS5uYjDJnpXXBLmf/jBzwmK17gaN0IzfT4G0
 AX2CtsyjzRhWUEj5p8t7z9zpxL3Gewmd/W/Rv/TO8aFbs2pOCAa4FyltyjzJQvW3bF4AQnODFA
 AAA
X-Change-ID: 20250116-b4-pks-reftable-sign-compare-8eaabae74c06
In-Reply-To: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
References: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Hi,

during the last steps of converting the reftable codebase to become a
standalone library I noticed that the new -Wsign-compare warnings
created a bit of a problem due to the `DISABLE_SIGN_COMPARE_WARNINGS`
macro that we started using. As a consequence I wasn't able to easily
drop "git-compat-util.h" anymore. This patch series is thus addresses
the issue by fixing all sign comparison warnings in the reftable
library.

Changes in v2:
  - Document why we add/subtract 1 when encoding and decoding varints.
  - Constistently use hex representations when encoding varints.
  - Use `+` instead of `|` to add values in varint decoding -- it
    shouldn't make a difference, but is closer to what Git's own
    algorithm uses.
  - Link to v1: https://lore.kernel.org/r/20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (10):
      meson: stop disabling -Wsign-compare
      reftable/record: drop unused `print` function pointer
      reftable/record: handle overflows when decoding varints
      reftable/basics: adjust `common_prefix_size()` to return `size_t`
      reftable/basics: adjust `hash_size()` to return `uint32_t`
      reftable/block: adapt header and footer size to return a `size_t`
      reftable/block: adjust type of the restart length
      reftable/blocksource: adjust type of the block length
      reftable/blocksource: adjust `read_block()` to return `ssize_t`
      reftable: address trivial -Wsign-compare warnings

 meson.build                         |   1 -
 reftable/basics.c                   |  10 ++-
 reftable/basics.h                   |   4 +-
 reftable/block.c                    |  20 +++---
 reftable/block.h                    |  14 ++--
 reftable/blocksource.c              |   8 +--
 reftable/reader.c                   |  32 +++++----
 reftable/reader.h                   |   6 +-
 reftable/record.c                   | 125 +++++++++++++++++-------------------
 reftable/record.h                   |  25 ++++----
 reftable/reftable-blocksource.h     |  13 ++--
 reftable/reftable-record.h          |   4 +-
 reftable/reftable-writer.h          |   2 +-
 reftable/stack.c                    |  12 ++--
 reftable/system.h                   |   2 -
 reftable/writer.c                   |   7 +-
 t/unit-tests/t-reftable-basics.c    |   2 +-
 t/unit-tests/t-reftable-readwrite.c |   2 +-
 t/unit-tests/t-reftable-record.c    |  19 +++++-
 19 files changed, 157 insertions(+), 151 deletions(-)

Range-diff versus v1:

 1:  2fb873ee80 =  1:  dcc0fa1906 meson: stop disabling -Wsign-compare
 2:  da4f0ce11e =  2:  059ee6afe1 reftable/record: drop unused `print` function pointer
 3:  6f242d9af0 !  3:  2a50096d14 reftable/record: handle overflows when decoding varints
    @@ Commit message
         implementation is basically copied from Git's own `decode_varint()`,
         which already knows to handle overflows. The only adjustment is that we
         also take into account the string view's length in order to not overrun
    -    it.
    +    it. The reftable documentation explicitly notes that those two encoding
    +    schemas are supposed to be the same:
    +
    +        Varint encoding
    +        ^^^^^^^^^^^^^^^
    +
    +        Varint encoding is identical to the ofs-delta encoding method used
    +        within pack files.
    +
    +        Decoder works as follows:
    +
    +        ....
    +        val = buf[ptr] & 0x7f
    +        while (buf[ptr] & 0x80) {
    +          ptr++
    +          val = ((val + 1) << 7) | (buf[ptr] & 0x7f)
    +        }
    +        ....
     
         While at it, refactor `put_var_int()` in the same way by copying over
         the implementation of `encode_varint()`. While `put_var_int()` doesn't
    @@ reftable/record.c: static void *reftable_record_data(struct reftable_record *rec
     +	val = c & 0x7f;
     +
     +	while (c & 0x80) {
    ++		/*
    ++		 * We use a micro-optimization here: whenever we see that the
    ++		 * 0x80 bit is set, we know that the remainder of the value
    ++		 * cannot be 0. The zero-values thus doesn't need to be encoded
    ++		 * at all, which is why we subtract 1 when encoding and add 1
    ++		 * when decoding.
    ++		 *
    ++		 * This allows us to save a byte in some edge cases.
    ++		 */
     +		val += 1;
     +		if (!val || (val & (uint64_t)(~0ULL << (64 - 7))))
     +			return -1; /* overflow */
    @@ reftable/record.c: static void *reftable_record_data(struct reftable_record *rec
     -		}
     -		val = (val + 1) << 7 | (uint64_t)(in->buf[ptr] & 0x7f);
     +		c = *buf++;
    -+		val = (val << 7) | (c & 0x7f);
    ++		val = (val << 7) + (c & 0x7f);
      	}
      
      	*dest = val;
    @@ reftable/record.c: static void *reftable_record_data(struct reftable_record *rec
     -	if (dest->len < n)
     +	unsigned char varint[10];
     +	unsigned pos = sizeof(varint) - 1;
    -+	varint[pos] = value & 127;
    ++	varint[pos] = value & 0x7f;
     +	while (value >>= 7)
    -+		varint[--pos] = 128 | (--value & 127);
    ++		varint[--pos] = 0x80 | (--value & 0x7f);
     +	if (dest->len < sizeof(varint) - pos)
      		return -1;
     -	memcpy(dest->buf, &buf[i + 1], n);
    @@ reftable/record.c: static void *reftable_record_data(struct reftable_record *rec
     
      ## reftable/record.h ##
     @@ reftable/record.h: static inline void string_view_consume(struct string_view *s, int n)
    + 	s->len -= n;
    + }
      
    - /* utilities for de/encoding varints */
    - 
    +-/* utilities for de/encoding varints */
    +-
     +/*
     + * Decode and encode a varint. Returns the number of bytes read/written, or a
     + * negative value in case encoding/decoding the varint has failed.
 4:  e109babe15 !  4:  227002d330 reftable/basics: adjust `common_prefix_size()` to return `size_t`
    @@ reftable/record.c: int reftable_encode_key(int *restart, struct string_view dest
      	string_view_consume(&dest, n);
     
      ## reftable/writer.c ##
    +@@ reftable/writer.c: static int writer_finish_section(struct reftable_writer *w)
    + 
    + struct common_prefix_arg {
    + 	struct reftable_buf *last;
    +-	int max;
    ++	size_t max;
    + };
    + 
    + static void update_common(void *void_arg, void *key)
     @@ reftable/writer.c: static void update_common(void *void_arg, void *key)
      	struct common_prefix_arg *arg = void_arg;
      	struct obj_index_tree_node *entry = key;
 5:  bf9a568639 =  5:  63e709b44f reftable/basics: adjust `hash_size()` to return `uint32_t`
 6:  65b7137b90 =  6:  7f620bfeca reftable/block: adapt header and footer size to return a `size_t`
 7:  88748fd8a1 =  7:  e679e37e32 reftable/block: adjust type of the restart length
 8:  7d8c0eda59 =  8:  43d20a41e0 reftable/blocksource: adjust type of the block length
 9:  048be4c779 =  9:  48cccb5c00 reftable/blocksource: adjust `read_block()` to return `ssize_t`
10:  31b97b00f4 ! 10:  83f35b88d4 reftable: address trivial -Wsign-compare warnings
    @@ reftable/system.h: license that can be found in the LICENSE file or at
      #include "git-compat-util.h"
      
      /*
    -
    - ## reftable/writer.c ##
    -@@ reftable/writer.c: static int writer_finish_section(struct reftable_writer *w)
    - 
    - struct common_prefix_arg {
    - 	struct reftable_buf *last;
    --	int max;
    -+	size_t max;
    - };
    - 
    - static void update_common(void *void_arg, void *key)

---
base-commit: 757161efcca150a9a96b312d9e780a071e601a03
change-id: 20250116-b4-pks-reftable-sign-compare-8eaabae74c06

