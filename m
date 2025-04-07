Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0820024CEF1
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031787; cv=none; b=qSFlDz/SJVQcJ9L1JVTZvqWYUo9JN3BhwV0Ka5gcVuG/sD4klXPGBO9r0d6vxDf3NY+uHL8VQFS5mnbie2EyMDtIW031jJ90hEh/NwyyhpzYwXebq7bePVSZEnZ8TSzKEiUj2Iv0iQOuJ1IA7Gj0XwkkC1oFsao14VlUB8CZmYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031787; c=relaxed/simple;
	bh=1oJ+rrXn165f/r6TF+FGU5JMWdmbDUCle9pnzyZum9A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=iVjOMq3lcehYyehy8nhZRvxXOhpLi8NhUFhn6JetSbx6MOF5lwf0qWdbmS6eXRJxBBPX7YL2XngrsIhn1wTRQ+Y4vO9Rfa9On2oO0Qrx1mTjHflsWiYYPmRl8xPseENFa+bMtV3Pk7+CK5kW+LoSux9HfG0nx0zFcRZq59veIZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jLjGmo+l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iastHEqZ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jLjGmo+l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iastHEqZ"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B01511401D2;
	Mon,  7 Apr 2025 09:16:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 07 Apr 2025 09:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744031784;
	 x=1744118184; bh=mWZV0avtJaOpVH2R5I3Dl2Fp+zqFT36n4VEwSA2l3fw=; b=
	jLjGmo+lRkFVPpZAYsuMpEQwWV7hLhBBXScnZV8MyfEGM7Z9UfPpTafh9uGEQx9Z
	q/kZNLnuhGe6QOCtRW/lahRNpLgTichC5/aSFhewtEj/RSUW3wWaw6IY+Em34qBX
	3zCldRYSLc4RTMF1pAotAvZL42RYlLoPDNp5edQFSp8bxkVN9yUUa8aEr5qppsW1
	5bZEeZ6Qvo1L/6O3IJzfEPF+Qj054PtyGoO4B+0vHhmyDzJjfdWSFRGaC10FQ8Te
	dZyZq8/KvpcM5rFTE52nwUIm5h2CQ7WJwYWeOzmC6xmGd6jVbkVNk3fBiHIb26cU
	IfgUXL5aXdsI+NVx9/okFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744031784; x=
	1744118184; bh=mWZV0avtJaOpVH2R5I3Dl2Fp+zqFT36n4VEwSA2l3fw=; b=i
	astHEqZTArgu7Mghc9l2b7wirVfFe31dwHGVwxqN0pJyhQZziNaFTgprUwtmWvoR
	MQlAjJ+T9aMIsRTkhVPm2pDtXEXf5AY40/dKBNRn4DYJ7weyxCH/BQphClhU3xno
	H4CIo76KaxMtHPc1S1qL8dhd/ZzZhkRyYA8l0tMHdTE0xhHJnskPyv81V4/NwjO8
	yAqRwVgyNMXXLfGnMAJJzdWLRJRzuOq+c3jC08L05qOwB4+ljvy6JJSz/PKgLSvu
	OXXGQJyJ29ijRpOd80E+dZ9jtxMVc1cca9SQJFE0NmL9vePw3ZOnX0QV2myHL+Da
	mEb8EyyVQFD2jEVJIf4KA==
X-ME-Sender: <xms:J9DzZ1AKRvbgapQ0jnmWGid3V9C-Z0Yif2gwYY0B3GChjE-crlJHtg>
    <xme:J9DzZzhgzPIDZiCufVd7rVDNR5OJL4xTvF0i8r60vuF0iQE3d0nYB7jVJ-tMJNUny
    2ZcqDggcA4T0unD2w>
X-ME-Received: <xmr:J9DzZwmgdzqSRshD3vw7wocnA6pKUczFgDSdV7RbjcP2gNQ3eaC3PDHUYrdXjaAvo-Jl43SOzZ5fowZsjUUj6HsklkxCXGSFgznrFGIQmZat6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:J9DzZ_yl5vnz6rRj2VJmHwt3ppdKmoD4aIACfSDwIlKT5jrCt6Lmdg>
    <xmx:J9DzZ6TY6GgSvLZDthG2Z-tpky-YA_FAttHXiRfXyPYvzTrRGRHABQ>
    <xmx:J9DzZyYy3k33jcv2Im0sokbSpEMKYtSat42R2APPjrQn55Lo5s3pAQ>
    <xmx:J9DzZ7QPT2pmf5ggrthxNOLWE_-4hdljmkNY0duwL3IbOyxs2dQNqQ>
    <xmx:J9DzZwcGb6EzDadnbUj_yxKQvaRqPjQpK3zpRE6mbisLg5farXUHHZC8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 09:16:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7f87617d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 13:16:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/16] reftable: overhaul the API to expose access to
 blocks
Date: Mon, 07 Apr 2025 15:16:12 +0200
Message-Id: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABzQ82cC/3WNzQ6CMBCEX4Xs2TX9IxpPvofhAO0KGxFqi42G8
 O4WPHjy+E1m5pshUmCKcCpmCJQ48jhkULsCbFcPLSG7zKCEMlJJgf4WMdB1qpue0I89x46HFrV
 WlrQ8Wkc15LHPHX5tx5fqy4Eez/w//cKO4zSG9yZPck1XTym0lv88SaJAasiVyhyMNvaci3u+Q
 7Usywf7IhVXzgAAAA==
X-Change-ID: 20241210-pks-reftable-polishing-332ce318cdea
In-Reply-To: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this patch series is a bigger overhaul of the reftable API. This
overhaul has two main motivations:

  - The reftable library is now standalone and can be used by code bases
    other than Git, like libgit2. This patch series thus renames a
    couple of subsystems to have more intuitive names before we gain any
    new users.

  - Some of the data of reftables isn't accessible at all via public
    interfaces. Most importantly, it is not possible to access
    individual blocks in a table. While users shouldn't need that access
    most of the time, an upcoming usecase that Git itself has is to
    implement consistency checks for the reftable backend. Here we'll
    want to read through blocks and their respective records one by one
    to ensure that they are sane and then iterate through records
    contained in these blocks.

The patch series is structured as follows:

  - Patch 1 is a trivial global refactoring to fix formatting of the
    license headers. They have been annoying me for far too long.

  - Patches 2 to 8 consolidate and rename a couple of data structures:

      - `reftable_reader` becomes `reftable_table`, as it is used to
        access an individual table.

      - `reftable_block` becomes `reftable_block_data`, as it is only a
        simple container for the underlying bytes.

      - `reftable_block_reader` becomes `reftable_block`, as it is used
        to access an individual block.

    Overall, the data structures are now called after what they provide
    access to compared to the rather generic previous names. This is
    also in line with other data structures like `reftable_merged_table`
    and `reftable_stack`.

  - Patches 9 to 13 refactor the block interface so that it can expose a
    generic `reftable_iterator`, granting generic access to all of its
    contained records.

  - Patches 14 to 16 refactor the table interface to expose a new
    iterator over its contained blocks.

  - Patch 17 refactors `reftable_table_print_blocks` to be implemented
    on top of these new iterators. This allows us to move it out of the
    library codebase into the test helper.

The series is built on Git v2.49.0 with ps/reftable-sans-compat-util at
8f6a2dbe340 (Makefile: skip reftable library for Coccinelle, 2025-02-18)
merged into it.

Changes in v2:
  - Rename `reftable_table_init_table_iterator()` to
    `reftable_table_iterator_init()`.
  - Rename `struct reftable_block_reader::block` to `block_data`.
  - Several improvements to commit messages.
  - Drop unneeded calls to `block_iter_seek_start()` after
    `block_iter_init()`.
  - Fix -Wcomma error.
  - Link to v1: https://lore.kernel.org/r/20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (16):
      reftable: fix formatting of the license header
      reftable/reader: rename data structure to "table"
      reftable/blocksource: consolidate code into a single file
      reftable/block: simplify how we track restart points
      reftable/table: move reading block into block reader
      reftable/block: rename `block` to `block_data`
      reftable/block: rename `block_reader` to `reftable_block`
      git-zlib: use `struct z_stream_s` instead of typedef
      reftable/block: create public interface for reading blocks
      reftable/block: store block pointer in the block iterator
      reftable/block: make block iterators reseekable
      reftable/block: expose a generic iterator over reftable records
      reftable/table: add `reftable_table` to the public interface
      reftable/table: introduce iterator for table blocks
      reftable/constants: make block types part of the public interface
      reftable/table: move printing logic into test helper

 .../howto/recover-corrupted-object-harder.adoc     |   4 +-
 Makefile                                           |   4 +-
 compat/zlib-compat.h                               |   4 +-
 git-zlib.h                                         |   2 +-
 meson.build                                        |   2 +-
 reftable/basics.c                                  |  12 +-
 reftable/basics.h                                  |  19 +-
 reftable/block.c                                   | 284 ++++++++-----
 reftable/block.h                                   |  85 ++--
 reftable/blocksource.c                             |  67 ++-
 reftable/blocksource.h                             |  39 +-
 reftable/constants.h                               |  18 +-
 reftable/error.c                                   |  12 +-
 reftable/iter.c                                    |  36 +-
 reftable/iter.h                                    |  18 +-
 reftable/merged.c                                  |  42 +-
 reftable/merged.h                                  |  16 +-
 reftable/pq.c                                      |  12 +-
 reftable/pq.h                                      |  12 +-
 reftable/reader.h                                  |  67 ---
 reftable/record.c                                  |  52 +--
 reftable/record.h                                  |  12 +-
 reftable/reftable-basics.h                         |  10 +-
 reftable/reftable-block.h                          |  74 ++++
 reftable/reftable-blocksource.h                    |  29 +-
 reftable/reftable-constants.h                      |  18 +
 reftable/reftable-error.h                          |  12 +-
 reftable/reftable-iterator.h                       |  12 +-
 reftable/reftable-merged.h                         |  18 +-
 reftable/reftable-reader.h                         |  72 ----
 reftable/reftable-record.h                         |  12 +-
 reftable/reftable-stack.h                          |  12 +-
 reftable/reftable-table.h                          | 115 +++++
 reftable/reftable-writer.h                         |  12 +-
 reftable/stack.c                                   | 188 ++++-----
 reftable/stack.h                                   |  16 +-
 reftable/system.h                                  |  12 +-
 reftable/{reader.c => table.c}                     | 463 +++++++++------------
 reftable/table.h                                   |  29 ++
 reftable/tree.c                                    |  12 +-
 reftable/tree.h                                    |  12 +-
 reftable/writer.c                                  |  34 +-
 reftable/writer.h                                  |  12 +-
 t/helper/test-reftable.c                           |  81 +++-
 t/meson.build                                      |   2 +-
 t/t0613-reftable-write-options.sh                  |   9 +
 t/unit-tests/t-reftable-block.c                    | 214 +++++++---
 t/unit-tests/t-reftable-merged.c                   |  86 ++--
 t/unit-tests/t-reftable-pq.c                       |  10 +-
 t/unit-tests/t-reftable-reader.c                   |  96 -----
 t/unit-tests/t-reftable-readwrite.c                | 106 ++---
 t/unit-tests/t-reftable-record.c                   |  40 +-
 t/unit-tests/t-reftable-stack.c                    |  66 +--
 t/unit-tests/t-reftable-table.c                    | 206 +++++++++
 54 files changed, 1635 insertions(+), 1274 deletions(-)

Range-diff versus v1:

 1:  a02dacaad85 =  1:  0647a1770ac reftable: fix formatting of the license header
 2:  29d3e212de1 =  2:  0729191d831 reftable/reader: rename data structure to "table"
 3:  0140ff1c37b !  3:  64f35be377e reftable/blocksource: consolidate code into a single file
    @@ Commit message
         reftable/blocksource: consolidate code into a single file
     
         The code that implements block sources is distributed across a couple of
    -    files even though. Consolidate all of it into "reftable/blocksource.c"
    -    and its accompanying header so that it is easier to locate and more self
    +    files. Consolidate all of it into "reftable/blocksource.c" and its
    +    accompanying header so that it is easier to locate and more self
         contained.
     
    +    While at it, rename some of the functions to have properly scoped names.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## reftable/block.c ##
 4:  f735578f50f =  4:  ad57660df13 reftable/block: simplify how we track restart points
 5:  dbce90b9520 !  5:  0ac16513e5c reftable/table: move reading block into block reader
    @@ Commit message
     
         Refactor the code so that we stop passing the block when initializing a
         reader, but instead by passing in the block source plus the offset at
    -    which we we're supposed to read a block. Like this, the ownership of the
    +    which we're supposed to read a block. Like this, the ownership of the
         block itself doesn't need to get handed over as the block reader is the
         one owning the block right from the start.
     
 6:  9a18a37e236 !  6:  30b4b1f37ed reftable/block: rename `block` to `block_data`
    @@ Commit message
         this is the structure that actually encapsulates access to the reftable
         blocks.
     
    +    Rename the `struct reftable_block_reader::block` member accordingly.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## reftable/block.c ##
    @@ reftable/block.c: int block_writer_finish(struct block_writer *w)
      }
      
      int block_reader_init(struct block_reader *br,
    +@@ reftable/block.c: int block_reader_init(struct block_reader *br,
    + 	uint8_t block_type;
    + 	int err;
    + 
    +-	err = read_block(source, &br->block, offset, guess_block_size);
    ++	err = read_block(source, &br->block_data, offset, guess_block_size);
    + 	if (err < 0)
    + 		goto done;
    + 
    +-	block_type = br->block.data[header_size];
    ++	block_type = br->block_data.data[header_size];
    + 	if (!reftable_is_block_type(block_type)) {
    + 		err = REFTABLE_FORMAT_ERROR;
    + 		goto done;
    + 	}
    + 
    +-	block_size = reftable_get_be24(br->block.data + header_size + 1);
    ++	block_size = reftable_get_be24(br->block_data.data + header_size + 1);
    + 	if (block_size > guess_block_size) {
    +-		err = read_block(source, &br->block, offset, block_size);
    ++		err = read_block(source, &br->block_data, offset, block_size);
    + 		if (err < 0)
    + 			goto done;
    + 	}
    +@@ reftable/block.c: int block_reader_init(struct block_reader *br,
    + 	if (block_type == BLOCK_TYPE_LOG) {
    + 		uint32_t block_header_skip = 4 + header_size;
    + 		uLong dst_len = block_size - block_header_skip;
    +-		uLong src_len = br->block.len - block_header_skip;
    ++		uLong src_len = br->block_data.len - block_header_skip;
    + 
    + 		/* Log blocks specify the *uncompressed* size in their header. */
    + 		REFTABLE_ALLOC_GROW_OR_NULL(br->uncompressed_data, block_size,
    +@@ reftable/block.c: int block_reader_init(struct block_reader *br,
    + 		}
    + 
    + 		/* Copy over the block header verbatim. It's not compressed. */
    +-		memcpy(br->uncompressed_data, br->block.data, block_header_skip);
    ++		memcpy(br->uncompressed_data, br->block_data.data, block_header_skip);
    + 
    + 		if (!br->zstream) {
    + 			REFTABLE_CALLOC_ARRAY(br->zstream, 1);
    +@@ reftable/block.c: int block_reader_init(struct block_reader *br,
    + 			goto done;
    + 		}
    + 
    +-		br->zstream->next_in = br->block.data + block_header_skip;
    ++		br->zstream->next_in = br->block_data.data + block_header_skip;
    + 		br->zstream->avail_in = src_len;
    + 		br->zstream->next_out = br->uncompressed_data + block_header_skip;
    + 		br->zstream->avail_out = dst_len;
     @@ reftable/block.c: int block_reader_init(struct block_reader *br,
      		}
      
      		/* We're done with the input data. */
     -		block_source_return_block(&br->block);
    -+		block_source_release_data(&br->block);
    - 		br->block.data = br->uncompressed_data;
    - 		br->block.len = block_size;
    +-		br->block.data = br->uncompressed_data;
    +-		br->block.len = block_size;
    ++		block_source_release_data(&br->block_data);
    ++		br->block_data.data = br->uncompressed_data;
    ++		br->block_data.len = block_size;
      		full_block_size = src_len + block_header_skip - br->zstream->avail_in;
    + 	} else if (full_block_size == 0) {
    + 		full_block_size = block_size;
    +-	} else if (block_size < full_block_size && block_size < br->block.len &&
    +-		   br->block.data[block_size] != 0) {
    ++	} else if (block_size < full_block_size && block_size < br->block_data.len &&
    ++		   br->block_data.data[block_size] != 0) {
    + 		/* If the block is smaller than the full block size, it is
    + 		   padded (data followed by '\0') or the next block is
    + 		   unaligned. */
    + 		full_block_size = block_size;
    + 	}
    + 
    +-	restart_count = reftable_get_be16(br->block.data + block_size - 2);
    ++	restart_count = reftable_get_be16(br->block_data.data + block_size - 2);
    + 	restart_off = block_size - 2 - 3 * restart_count;
    + 
    + 	br->block_type = block_type;
     @@ reftable/block.c: void block_reader_release(struct block_reader *br)
      	inflateEnd(br->zstream);
      	reftable_free(br->zstream);
      	reftable_free(br->uncompressed_data);
     -	block_source_return_block(&br->block);
    -+	block_source_release_data(&br->block);
    ++	block_source_release_data(&br->block_data);
      	memset(br, 0, sizeof(*br));
      }
      
    + uint8_t block_reader_type(const struct block_reader *r)
    + {
    +-	return r->block.data[r->header_off];
    ++	return r->block_data.data[r->header_off];
    + }
    + 
    + int block_reader_first_key(const struct block_reader *br, struct reftable_buf *key)
    + {
    + 	int off = br->header_off + 4, n;
    + 	struct string_view in = {
    +-		.buf = br->block.data + off,
    ++		.buf = br->block_data.data + off,
    + 		.len = br->restart_off - off,
    + 	};
    + 	uint8_t extra = 0;
    +@@ reftable/block.c: int block_reader_first_key(const struct block_reader *br, struct reftable_buf *k
    + 
    + static uint32_t block_reader_restart_offset(const struct block_reader *br, size_t idx)
    + {
    +-	return reftable_get_be24(br->block.data + br->restart_off + 3 * idx);
    ++	return reftable_get_be24(br->block_data.data + br->restart_off + 3 * idx);
    + }
    + 
    + void block_iter_seek_start(struct block_iter *it, const struct block_reader *br)
    + {
    +-	it->block = br->block.data;
    ++	it->block = br->block_data.data;
    + 	it->block_len = br->restart_off;
    + 	it->hash_size = br->hash_size;
    + 	reftable_buf_reset(&it->last_key);
    +@@ reftable/block.c: static int restart_needle_less(size_t idx, void *_args)
    + 	struct restart_needle_less_args *args = _args;
    + 	uint32_t off = block_reader_restart_offset(args->reader, idx);
    + 	struct string_view in = {
    +-		.buf = args->reader->block.data + off,
    ++		.buf = args->reader->block_data.data + off,
    + 		.len = args->reader->restart_off - off,
    + 	};
    + 	uint64_t prefix_len, suffix_len;
    +@@ reftable/block.c: int block_iter_seek_key(struct block_iter *it, const struct block_reader *br,
    + 		it->next_off = block_reader_restart_offset(br, i - 1);
    + 	else
    + 		it->next_off = br->header_off + 4;
    +-	it->block = br->block.data;
    ++	it->block = br->block_data.data;
    + 	it->block_len = br->restart_off;
    + 	it->hash_size = br->hash_size;
    + 
     
      ## reftable/block.h ##
     @@ reftable/block.h: struct block_reader {
    @@ reftable/block.h: struct block_reader {
      
      	/* the memory block */
     -	struct reftable_block block;
    -+	struct reftable_block_data block;
    ++	struct reftable_block_data block_data;
      	uint32_t hash_size;
      
      	/* Uncompressed data for log entries. */
    @@ reftable/iter.c: static void indexed_table_ref_iter_close(void *p)
      	struct indexed_table_ref_iter *it = p;
      	block_iter_close(&it->cur);
     -	block_source_return_block(&it->block_reader.block);
    -+	block_source_release_data(&it->block_reader.block);
    ++	block_source_release_data(&it->block_reader.block_data);
      	reftable_free(it->offsets);
      	reftable_buf_release(&it->oid);
      }
    @@ reftable/iter.c: static int indexed_table_ref_iter_next_block(struct indexed_tab
      	}
      
     -	block_source_return_block(&it->block_reader.block);
    -+	block_source_release_data(&it->block_reader.block);
    ++	block_source_release_data(&it->block_reader.block_data);
      
      	off = it->offsets[it->offset_idx++];
      	err = table_init_block_reader(it->table, &it->block_reader, off,
    @@ reftable/reftable-blocksource.h: struct reftable_block {
      
     
      ## reftable/table.c ##
    +@@ reftable/table.c: static int table_iter_seek_linear(struct table_iter *ti,
    + 		 * as we have more than three blocks we would have an index, so
    + 		 * we would not do a linear search there anymore.
    + 		 */
    +-		memset(&next.br.block, 0, sizeof(next.br.block));
    ++		memset(&next.br.block_data, 0, sizeof(next.br.block_data));
    + 		next.br.zstream = NULL;
    + 		next.br.uncompressed_data = NULL;
    + 		next.br.uncompressed_cap = 0;
     @@ reftable/table.c: int reftable_table_init_log_iterator(struct reftable_table *t,
      int reftable_table_new(struct reftable_table **out,
      		       struct reftable_block_source *source, char const *name)
 7:  994ac7ca02d !  7:  e6ba597eaa3 reftable/block: rename `block_reader` to `reftable_block`
    @@ reftable/block.c: int block_reader_init(struct block_reader *br,
      	uint8_t block_type;
      	int err;
      
    --	err = read_block(source, &br->block, offset, guess_block_size);
    -+	err = read_block(source, &block->block, offset, guess_block_size);
    +-	err = read_block(source, &br->block_data, offset, guess_block_size);
    ++	err = read_block(source, &block->block_data, offset, guess_block_size);
      	if (err < 0)
      		goto done;
      
    --	block_type = br->block.data[header_size];
    -+	block_type = block->block.data[header_size];
    +-	block_type = br->block_data.data[header_size];
    ++	block_type = block->block_data.data[header_size];
      	if (!reftable_is_block_type(block_type)) {
      		err = REFTABLE_FORMAT_ERROR;
      		goto done;
      	}
      
    --	block_size = reftable_get_be24(br->block.data + header_size + 1);
    -+	block_size = reftable_get_be24(block->block.data + header_size + 1);
    +-	block_size = reftable_get_be24(br->block_data.data + header_size + 1);
    ++	block_size = reftable_get_be24(block->block_data.data + header_size + 1);
      	if (block_size > guess_block_size) {
    --		err = read_block(source, &br->block, offset, block_size);
    -+		err = read_block(source, &block->block, offset, block_size);
    +-		err = read_block(source, &br->block_data, offset, block_size);
    ++		err = read_block(source, &block->block_data, offset, block_size);
      		if (err < 0)
      			goto done;
      	}
    @@ reftable/block.c: int block_reader_init(struct block_reader *br,
      	if (block_type == BLOCK_TYPE_LOG) {
      		uint32_t block_header_skip = 4 + header_size;
      		uLong dst_len = block_size - block_header_skip;
    --		uLong src_len = br->block.len - block_header_skip;
    -+		uLong src_len = block->block.len - block_header_skip;
    +-		uLong src_len = br->block_data.len - block_header_skip;
    ++		uLong src_len = block->block_data.len - block_header_skip;
      
      		/* Log blocks specify the *uncompressed* size in their header. */
     -		REFTABLE_ALLOC_GROW_OR_NULL(br->uncompressed_data, block_size,
    @@ reftable/block.c: int block_reader_init(struct block_reader *br,
      		}
      
      		/* Copy over the block header verbatim. It's not compressed. */
    --		memcpy(br->uncompressed_data, br->block.data, block_header_skip);
    -+		memcpy(block->uncompressed_data, block->block.data, block_header_skip);
    +-		memcpy(br->uncompressed_data, br->block_data.data, block_header_skip);
    ++		memcpy(block->uncompressed_data, block->block_data.data, block_header_skip);
      
     -		if (!br->zstream) {
     -			REFTABLE_CALLOC_ARRAY(br->zstream, 1);
    @@ reftable/block.c: int block_reader_init(struct block_reader *br,
      			goto done;
      		}
      
    --		br->zstream->next_in = br->block.data + block_header_skip;
    +-		br->zstream->next_in = br->block_data.data + block_header_skip;
     -		br->zstream->avail_in = src_len;
     -		br->zstream->next_out = br->uncompressed_data + block_header_skip;
     -		br->zstream->avail_out = dst_len;
    -+		block->zstream->next_in = block->block.data + block_header_skip;
    ++		block->zstream->next_in = block->block_data.data + block_header_skip;
     +		block->zstream->avail_in = src_len;
     +		block->zstream->next_out = block->uncompressed_data + block_header_skip;
     +		block->zstream->avail_out = dst_len;
    @@ reftable/block.c: int block_reader_init(struct block_reader *br,
      		}
      
      		/* We're done with the input data. */
    --		block_source_release_data(&br->block);
    --		br->block.data = br->uncompressed_data;
    --		br->block.len = block_size;
    +-		block_source_release_data(&br->block_data);
    +-		br->block_data.data = br->uncompressed_data;
    +-		br->block_data.len = block_size;
     -		full_block_size = src_len + block_header_skip - br->zstream->avail_in;
    -+		block_source_release_data(&block->block);
    -+		block->block.data = block->uncompressed_data;
    -+		block->block.len = block_size;
    ++		block_source_release_data(&block->block_data);
    ++		block->block_data.data = block->uncompressed_data;
    ++		block->block_data.len = block_size;
     +		full_block_size = src_len + block_header_skip - block->zstream->avail_in;
      	} else if (full_block_size == 0) {
      		full_block_size = block_size;
    --	} else if (block_size < full_block_size && block_size < br->block.len &&
    --		   br->block.data[block_size] != 0) {
    -+	} else if (block_size < full_block_size && block_size < block->block.len &&
    -+		   block->block.data[block_size] != 0) {
    +-	} else if (block_size < full_block_size && block_size < br->block_data.len &&
    +-		   br->block_data.data[block_size] != 0) {
    ++	} else if (block_size < full_block_size && block_size < block->block_data.len &&
    ++		   block->block_data.data[block_size] != 0) {
      		/* If the block is smaller than the full block size, it is
      		   padded (data followed by '\0') or the next block is
      		   unaligned. */
      		full_block_size = block_size;
      	}
      
    --	restart_count = reftable_get_be16(br->block.data + block_size - 2);
    -+	restart_count = reftable_get_be16(block->block.data + block_size - 2);
    +-	restart_count = reftable_get_be16(br->block_data.data + block_size - 2);
    ++	restart_count = reftable_get_be16(block->block_data.data + block_size - 2);
      	restart_off = block_size - 2 - 3 * restart_count;
      
     -	br->block_type = block_type;
    @@ reftable/block.c: int block_reader_init(struct block_reader *br,
     -	inflateEnd(br->zstream);
     -	reftable_free(br->zstream);
     -	reftable_free(br->uncompressed_data);
    --	block_source_release_data(&br->block);
    +-	block_source_release_data(&br->block_data);
     -	memset(br, 0, sizeof(*br));
     +	inflateEnd(block->zstream);
     +	reftable_free(block->zstream);
     +	reftable_free(block->uncompressed_data);
    -+	block_source_release_data(&block->block);
    ++	block_source_release_data(&block->block_data);
     +	memset(block, 0, sizeof(*block));
      }
      
     -uint8_t block_reader_type(const struct block_reader *r)
     +uint8_t reftable_block_type(const struct reftable_block *b)
      {
    --	return r->block.data[r->header_off];
    -+	return b->block.data[b->header_off];
    +-	return r->block_data.data[r->header_off];
    ++	return b->block_data.data[b->header_off];
      }
      
     -int block_reader_first_key(const struct block_reader *br, struct reftable_buf *key)
    @@ reftable/block.c: int block_reader_init(struct block_reader *br,
     -	int off = br->header_off + 4, n;
     +	int off = block->header_off + 4, n;
      	struct string_view in = {
    --		.buf = br->block.data + off,
    +-		.buf = br->block_data.data + off,
     -		.len = br->restart_off - off,
    -+		.buf = block->block.data + off,
    ++		.buf = block->block_data.data + off,
     +		.len = block->restart_off - off,
      	};
      	uint8_t extra = 0;
    @@ reftable/block.c: int block_reader_first_key(const struct block_reader *br, stru
     -static uint32_t block_reader_restart_offset(const struct block_reader *br, size_t idx)
     +static uint32_t block_restart_offset(const struct reftable_block *b, size_t idx)
      {
    --	return reftable_get_be24(br->block.data + br->restart_off + 3 * idx);
    -+	return reftable_get_be24(b->block.data + b->restart_off + 3 * idx);
    +-	return reftable_get_be24(br->block_data.data + br->restart_off + 3 * idx);
    ++	return reftable_get_be24(b->block_data.data + b->restart_off + 3 * idx);
      }
      
     -void block_iter_seek_start(struct block_iter *it, const struct block_reader *br)
     +void block_iter_seek_start(struct block_iter *it, const struct reftable_block *b)
      {
    --	it->block = br->block.data;
    +-	it->block = br->block_data.data;
     -	it->block_len = br->restart_off;
     -	it->hash_size = br->hash_size;
    -+	it->block = b->block.data;
    ++	it->block = b->block_data.data;
     +	it->block_len = b->restart_off;
     +	it->hash_size = b->hash_size;
      	reftable_buf_reset(&it->last_key);
    @@ reftable/block.c: int block_reader_first_key(const struct block_reader *br, stru
     -	uint32_t off = block_reader_restart_offset(args->reader, idx);
     +	uint32_t off = block_restart_offset(args->block, idx);
      	struct string_view in = {
    --		.buf = args->reader->block.data + off,
    +-		.buf = args->reader->block_data.data + off,
     -		.len = args->reader->restart_off - off,
    -+		.buf = args->block->block.data + off,
    ++		.buf = args->block->block_data.data + off,
     +		.len = args->block->restart_off - off,
      	};
      	uint64_t prefix_len, suffix_len;
    @@ reftable/block.c: int block_iter_seek_key(struct block_iter *it, const struct bl
     +		it->next_off = block_restart_offset(block, i - 1);
      	else
     -		it->next_off = br->header_off + 4;
    --	it->block = br->block.data;
    +-	it->block = br->block_data.data;
     -	it->block_len = br->restart_off;
     -	it->hash_size = br->hash_size;
     +		it->next_off = block->header_off + 4;
    -+	it->block = block->block.data;
    ++	it->block = block->block_data.data;
     +	it->block_len = block->restart_off;
     +	it->hash_size = block->hash_size;
      
    @@ reftable/iter.c: static void indexed_table_ref_iter_close(void *p)
      {
      	struct indexed_table_ref_iter *it = p;
      	block_iter_close(&it->cur);
    --	block_source_release_data(&it->block_reader.block);
    -+	block_source_release_data(&it->block.block);
    +-	block_source_release_data(&it->block_reader.block_data);
    ++	block_source_release_data(&it->block.block_data);
      	reftable_free(it->offsets);
      	reftable_buf_release(&it->oid);
      }
    @@ reftable/iter.c: static int indexed_table_ref_iter_next_block(struct indexed_tab
      		return 1;
      	}
      
    --	block_source_release_data(&it->block_reader.block);
    -+	block_source_release_data(&it->block.block);
    +-	block_source_release_data(&it->block_reader.block_data);
    ++	block_source_release_data(&it->block.block_data);
      
      	off = it->offsets[it->offset_idx++];
     -	err = table_init_block_reader(it->table, &it->block_reader, off,
    @@ reftable/table.c: static int table_iter_seek_linear(struct table_iter *ti,
      		 * as we have more than three blocks we would have an index, so
      		 * we would not do a linear search there anymore.
      		 */
    --		memset(&next.br.block, 0, sizeof(next.br.block));
    +-		memset(&next.br.block_data, 0, sizeof(next.br.block_data));
     -		next.br.zstream = NULL;
     -		next.br.uncompressed_data = NULL;
     -		next.br.uncompressed_cap = 0;
    -+		memset(&next.block.block, 0, sizeof(next.block.block));
    ++		memset(&next.block.block_data, 0, sizeof(next.block.block_data));
     +		next.block.zstream = NULL;
     +		next.block.uncompressed_data = NULL;
     +		next.block.uncompressed_cap = 0;
 8:  17110157b97 =  8:  9900fd1550a git-zlib: use `struct z_stream_s` instead of typedef
 9:  a93b32ed3ca !  9:  8f61a428774 reftable/block: create public interface for reading blocks
    @@ reftable/block.h: int block_writer_finish(struct block_writer *w);
     -	uint32_t header_off;
     -
     -	/* the memory block */
    --	struct reftable_block_data block;
    +-	struct reftable_block_data block_data;
     -	uint32_t hash_size;
     -
     -	/* Uncompressed data for log entries. */
    @@ reftable/reftable-block.h (new)
     +	uint32_t header_off;
     +
     +	/* The memory block. */
    -+	struct reftable_block_data block;
    ++	struct reftable_block_data block_data;
     +	uint32_t hash_size;
     +
     +	/* Uncompressed data for log entries. */
10:  82c507d95c6 ! 10:  fb78ed25b84 reftable/block: store block pointer in the block iterator
    @@ Commit message
             confusion.
     
           - The lifetime of the block iterator is tied to the block anyway, but
    -        we hide that a bit by only storing pointers into the block.
    +        we hide that a bit by only storing pointers pointing into the block.
     
         There isn't really any good reason why we rip out parts of the block
         instead of storing a pointer to the block itself.
    @@ Commit message
     
      ## reftable/block.c ##
     @@ reftable/block.c: static uint32_t block_restart_offset(const struct reftable_block *b, size_t idx)
    - 	return reftable_get_be24(b->block.data + b->restart_off + 3 * idx);
    + 	return reftable_get_be24(b->block_data.data + b->restart_off + 3 * idx);
      }
      
     -void block_iter_seek_start(struct block_iter *it, const struct reftable_block *b)
     +void block_iter_seek_start(struct block_iter *it, const struct reftable_block *block)
      {
    --	it->block = b->block.data;
    +-	it->block = b->block_data.data;
     -	it->block_len = b->restart_off;
     -	it->hash_size = b->hash_size;
     +	it->block = block;
    @@ reftable/block.c: static int restart_needle_less(size_t idx, void *_args)
      	struct string_view in = {
     -		.buf = (unsigned char *) it->block + it->next_off,
     -		.len = it->block_len - it->next_off,
    -+		.buf = (unsigned char *) it->block->block.data + it->next_off,
    ++		.buf = (unsigned char *) it->block->block_data.data + it->next_off,
     +		.len = it->block->restart_off - it->next_off,
      	};
      	struct string_view start = in;
    @@ reftable/block.c: int block_iter_seek_key(struct block_iter *it, const struct re
      		it->next_off = block_restart_offset(block, i - 1);
      	else
      		it->next_off = block->header_off + 4;
    --	it->block = block->block.data;
    +-	it->block = block->block_data.data;
     -	it->block_len = block->restart_off;
     -	it->hash_size = block->hash_size;
     +	it->block = block;
11:  132c09cff1f ! 11:  cc990effb4f reftable/block: make block iterators reseekable
    @@ Commit message
         Refactor the block iterators so that initialization and seeking are
         different from one another. This makes the iterator trivially reseekable
         by storing the pointer to the block at initialization time, which we can
    -    then reuse on ever seek.
    +    then reuse on every seek.
     
         This refactoring prepares the code for exposing a `reftable_iterator`
         interface for blocks in a subsequent commit. Callsites are adjusted
    @@ Commit message
     
      ## reftable/block.c ##
     @@ reftable/block.c: static uint32_t block_restart_offset(const struct reftable_block *b, size_t idx)
    - 	return reftable_get_be24(b->block.data + b->restart_off + 3 * idx);
    + 	return reftable_get_be24(b->block_data.data + b->restart_off + 3 * idx);
      }
      
     -void block_iter_seek_start(struct block_iter *it, const struct reftable_block *block)
    @@ t/unit-tests/t-reftable-block.c: static void t_ref_block_read_write(void)
      
     -	block_iter_seek_start(&it, &block);
     +	block_iter_init(&it, &block);
    -+	block_iter_seek_start(&it);
      
      	for (i = 0; ; i++) {
      		ret = block_iter_next(&it, &rec);
    @@ t/unit-tests/t-reftable-block.c: static void t_log_block_read_write(void)
      
     -	block_iter_seek_start(&it, &block);
     +	block_iter_init(&it, &block);
    -+	block_iter_seek_start(&it);
      
      	for (i = 0; ; i++) {
      		ret = block_iter_next(&it, &rec);
    @@ t/unit-tests/t-reftable-block.c: static void t_obj_block_read_write(void)
      
     -	block_iter_seek_start(&it, &block);
     +	block_iter_init(&it, &block);
    -+	block_iter_seek_start(&it);
      
      	for (i = 0; ; i++) {
      		ret = block_iter_next(&it, &rec);
    @@ t/unit-tests/t-reftable-block.c: static void t_index_block_read_write(void)
      
     -	block_iter_seek_start(&it, &block);
     +	block_iter_init(&it, &block);
    -+	block_iter_seek_start(&it);
      
      	for (i = 0; ; i++) {
      		ret = block_iter_next(&it, &rec);
12:  cc4fd9e7a16 = 12:  43dda28cf3a reftable/block: expose a generic iterator over reftable records
13:  e022bc4cb24 = 13:  d80412e8806 reftable/table: add `reftable_table` to the public interface
14:  0adde9c6f4a ! 14:  f12ded11167 reftable/table: introduce iterator for table blocks
    @@ reftable/reftable-table.h: uint64_t reftable_table_min_update_index(struct refta
     +	void *iter_arg;
     +};
     +
    -+int reftable_table_init_table_iterator(struct reftable_table *t,
    -+				       struct reftable_table_iterator *it);
    ++int reftable_table_iterator_init(struct reftable_table_iterator *it,
    ++				 struct reftable_table *t);
     +
     +void reftable_table_iterator_release(struct reftable_table_iterator *it);
     +
    @@ reftable/table.c: int reftable_table_print_blocks(const char *tablename)
      	return err;
      }
     +
    -+int reftable_table_init_table_iterator(struct reftable_table *t,
    -+				       struct reftable_table_iterator *it)
    ++int reftable_table_iterator_init(struct reftable_table_iterator *it,
    ++				 struct reftable_table *t)
     +{
     +	struct table_iter *ti;
     +	int err;
    @@ t/unit-tests/t-reftable-table.c: static int t_table_reseek(void)
     +
     +	REFTABLE_CALLOC_ARRAY(records, nrecords);
     +	for (size_t i = 0; i < nrecords; i++) {
    -+		records[i].value_type = REFTABLE_REF_VAL1,
    -+		records[i].refname = xstrfmt("refs/heads/branch-%03"PRIuMAX, (uintmax_t) i);
    ++		records[i].value_type = REFTABLE_REF_VAL1;
    ++		records[i].refname = xstrfmt("refs/heads/branch-%03"PRIuMAX,
    ++					     (uintmax_t) i);
     +	}
     +
     +	t_reftable_write_to_buf(&buf, records, nrecords, NULL, 0, NULL);
    @@ t/unit-tests/t-reftable-table.c: static int t_table_reseek(void)
     +	ret = reftable_table_new(&table, &source, "name");
     +	check(!ret);
     +
    -+	ret = reftable_table_init_table_iterator(table, &it);
    ++	ret = reftable_table_iterator_init(&it, table);
     +	check(!ret);
     +
     +	for (size_t i = 0; i < ARRAY_SIZE(expected_blocks); i++) {
15:  71be6c4a8f7 ! 15:  abc886e821d reftable/constants: make block types part of the public interface
    @@ reftable/block.c: int reftable_block_init(struct reftable_block *block,
     +	if (block_type == REFTABLE_BLOCK_TYPE_LOG) {
      		uint32_t block_header_skip = 4 + header_size;
      		uLong dst_len = block_size - block_header_skip;
    - 		uLong src_len = block->block.len - block_header_skip;
    + 		uLong src_len = block->block_data.len - block_header_skip;
     
      ## reftable/constants.h ##
     @@
    @@ reftable/constants.h
     
      ## reftable/iter.c ##
     @@ reftable/iter.c: static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
    - 	block_source_release_data(&it->block.block);
    + 	block_source_release_data(&it->block.block_data);
      
      	off = it->offsets[it->offset_idx++];
     -	err = table_init_block(it->table, &it->block, off, BLOCK_TYPE_REF);
16:  b4e1e25ef86 ! 16:  6a0d891ae76 reftable/table: move printing logic into test helper
    @@ reftable/table.c: uint64_t reftable_table_min_update_index(struct reftable_table
     -	return err;
     -}
     -
    - int reftable_table_init_table_iterator(struct reftable_table *t,
    - 				       struct reftable_table_iterator *it)
    + int reftable_table_iterator_init(struct reftable_table_iterator *it,
    + 				 struct reftable_table *t)
      {
     
      ## t/helper/test-reftable.c ##
    @@ t/helper/test-reftable.c: static void print_help(void)
     +	if (err < 0)
     +		goto done;
     +
    -+	err = reftable_table_init_table_iterator(table, &ti);
    ++	err = reftable_table_iterator_init(&ti, table);
     +	if (err < 0)
     +		goto done;
     +

---
base-commit: bc705c20b9a88abaff0f379bab6d545f012656af
change-id: 20241210-pks-reftable-polishing-332ce318cdea

