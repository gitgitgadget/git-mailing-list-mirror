Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BE5C2D0F1
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3538D2080C
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6tuny+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbgDAL3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:29:13 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:38322 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732150AbgDAL3J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 07:29:09 -0400
Received: by mail-ed1-f43.google.com with SMTP id e5so29174633edq.5
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 04:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SihTHykcjy5u3qL56dAedX770ziGTt4tKk5o1MzIYhI=;
        b=E6tuny+F+NltvHkvhLmdGvTjAB+dV0GrAyI94UL4vtn1buITAnzSejB7XFqdbpIvJ6
         3+UTfC5F2K5hNv6ZqdeK2uFT5Rt9X5ysBov4Ygj8KNQ0aixSb+laBjjf+Ydvzm8ze/+n
         ETEJA+hJySUFhoFswFpw0EbOM53W6U8/yVmGBc6JEPhetSTF5lRc9S2vghqHOjwQisS6
         vqDjhpL+yHiwQpysiRZ80Qj0dJ+SMcOI2HWa+KTbDYJvAVwRt+UlV5ehkji9ZaemjKkG
         P1S7bmYu/Z/wvVe4mg0ZKyn3KYWGLqPcqOnFc1V5I6AYRnHCZ81Ao9V5G75YjZbk8+qw
         i6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SihTHykcjy5u3qL56dAedX770ziGTt4tKk5o1MzIYhI=;
        b=LdiGeBeqmQl7Sxxqh/HN/6BCZjfLT1evWhH8OSkCBp3RhtiSkAFA8jh+y8DLqTBzpQ
         2GElPektzndNMvN0JprnPDZYlN2NS3QYAraxF2r/3ue93tCcWk0oJqCywQkZ2G0FkjIY
         5NhiqrjoWla2jK6NuoDiUwU4E75LabXYSs+VaYpyNp68II94Joq6wjUZJSmMrsm1/z/M
         0Uvu/aEEV08ahqSaZIaQARNpp9RNV5/ZJHpqNyDIYxUOpo5BksPaE5ET8KBB5lWNM+g+
         yOgGvHousi9F8uqFA2Bh/Je6PWTIxMZAyjMfWHRC2iI8C3eil0zl9EumpQ/rjHF1AjaX
         19sQ==
X-Gm-Message-State: ANhLgQ0R6nEhc3awY5+0G6JhjhSpeRyqWhNOgsTWtQQTvxK5uDafmt46
        OWjTOtHrSsRK4j/eEu5xGOrPjmKa
X-Google-Smtp-Source: ADFU+vs08jJpH++BKwyqkDJViaoRLr+CXpfZDwa3UteCyucezDm0T1ONn9wSagIsPRO+3/m+zgz1gQ==
X-Received: by 2002:a17:906:164f:: with SMTP id n15mr14693054ejd.322.1585740545289;
        Wed, 01 Apr 2020 04:29:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p34sm378239edb.63.2020.04.01.04.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 04:29:04 -0700 (PDT)
Message-Id: <dfc8b1312945750376d65435b03b44f70bd7ab6f.1585740538.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
References: <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
        <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
From:   "Jonathan Nieder via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 11:28:54 +0000
Subject: [PATCH v8 5/9] reftable: file format documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Shawn Pearce explains:

Some repositories contain a lot of references (e.g. android at 866k,
rails at 31k). The reftable format provides:

- Near constant time lookup for any single reference, even when the
  repository is cold and not in process or kernel cache.
- Near constant time verification a SHA-1 is referred to by at least
  one reference (for allow-tip-sha1-in-want).
- Efficient lookup of an entire namespace, such as `refs/tags/`.
- Support atomic push `O(size_of_update)` operations.
- Combine reflog storage with ref storage.

This file format spec was originally written in July, 2017 by Shawn
Pearce.  Some refinements since then were made by Shawn and by Han-Wen
Nienhuys based on experiences implementing and experimenting with the
format.  (All of this was in the context of our work at Google and
Google is happy to contribute the result to the Git project.)

Imported from JGit[1]'s current version (c217d33ff,
"Documentation/technical/reftable: improve repo layout", 2020-02-04)
of Documentation/technical/reftable.md and converted to asciidoc by
running

  pandoc -t asciidoc -f markdown reftable.md >reftable.txt

using pandoc 2.2.1.  The result required the following additional
minor changes:

- removed the [TOC] directive to add a table of contents, since
  asciidoc does not support it
- replaced git-scm.com/docs links with linkgit: directives that link
  to other pages within Git's documentation

[1] https://eclipse.googlesource.com/jgit/jgit

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/Makefile               |    1 +
 Documentation/technical/reftable.txt | 1067 ++++++++++++++++++++++++++
 2 files changed, 1068 insertions(+)
 create mode 100644 Documentation/technical/reftable.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 8fe829cc1b8..3aab9b8d61a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -92,6 +92,7 @@ TECH_DOCS += technical/protocol-capabilities
 TECH_DOCS += technical/protocol-common
 TECH_DOCS += technical/protocol-v2
 TECH_DOCS += technical/racy-git
+TECH_DOCS += technical/reftable
 TECH_DOCS += technical/send-pack-pipeline
 TECH_DOCS += technical/shallow
 TECH_DOCS += technical/signature-format
diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
new file mode 100644
index 00000000000..9fa4657d9ff
--- /dev/null
+++ b/Documentation/technical/reftable.txt
@@ -0,0 +1,1067 @@
+reftable
+--------
+
+Overview
+~~~~~~~~
+
+Problem statement
+^^^^^^^^^^^^^^^^^
+
+Some repositories contain a lot of references (e.g. android at 866k,
+rails at 31k). The existing packed-refs format takes up a lot of space
+(e.g. 62M), and does not scale with additional references. Lookup of a
+single reference requires linearly scanning the file.
+
+Atomic pushes modifying multiple references require copying the entire
+packed-refs file, which can be a considerable amount of data moved
+(e.g. 62M in, 62M out) for even small transactions (2 refs modified).
+
+Repositories with many loose references occupy a large number of disk
+blocks from the local file system, as each reference is its own file
+storing 41 bytes (and another file for the corresponding reflog). This
+negatively affects the number of inodes available when a large number of
+repositories are stored on the same filesystem. Readers can be penalized
+due to the larger number of syscalls required to traverse and read the
+`$GIT_DIR/refs` directory.
+
+Objectives
+^^^^^^^^^^
+
+* Near constant time lookup for any single reference, even when the
+repository is cold and not in process or kernel cache.
+* Near constant time verification if a SHA-1 is referred to by at least
+one reference (for allow-tip-sha1-in-want).
+* Efficient lookup of an entire namespace, such as `refs/tags/`.
+* Support atomic push with `O(size_of_update)` operations.
+* Combine reflog storage with ref storage for small transactions.
+* Separate reflog storage for base refs and historical logs.
+
+Description
+^^^^^^^^^^^
+
+A reftable file is a portable binary file format customized for
+reference storage. References are sorted, enabling linear scans, binary
+search lookup, and range scans.
+
+Storage in the file is organized into variable sized blocks. Prefix
+compression is used within a single block to reduce disk space. Block
+size and alignment is tunable by the writer.
+
+Performance
+^^^^^^^^^^^
+
+Space used, packed-refs vs. reftable:
+
+[cols=",>,>,>,>,>",options="header",]
+|===============================================================
+|repository |packed-refs |reftable |% original |avg ref |avg obj
+|android |62.2 M |36.1 M |58.0% |33 bytes |5 bytes
+|rails |1.8 M |1.1 M |57.7% |29 bytes |4 bytes
+|git |78.7 K |48.1 K |61.0% |50 bytes |4 bytes
+|git (heads) |332 b |269 b |81.0% |33 bytes |0 bytes
+|===============================================================
+
+Scan (read 866k refs), by reference name lookup (single ref from 866k
+refs), and by SHA-1 lookup (refs with that SHA-1, from 866k refs):
+
+[cols=",>,>,>,>",options="header",]
+|=========================================================
+|format |cache |scan |by name |by SHA-1
+|packed-refs |cold |402 ms |409,660.1 usec |412,535.8 usec
+|packed-refs |hot | |6,844.6 usec |20,110.1 usec
+|reftable |cold |112 ms |33.9 usec |323.2 usec
+|reftable |hot | |20.2 usec |320.8 usec
+|=========================================================
+
+Space used for 149,932 log entries for 43,061 refs, reflog vs. reftable:
+
+[cols=",>,>",options="header",]
+|================================
+|format |size |avg entry
+|$GIT_DIR/logs |173 M |1209 bytes
+|reftable |5 M |37 bytes
+|================================
+
+Details
+~~~~~~~
+
+Peeling
+^^^^^^^
+
+References stored in a reftable are peeled, a record for an annotated
+(or signed) tag records both the tag object, and the object it refers
+to.
+
+Reference name encoding
+^^^^^^^^^^^^^^^^^^^^^^^
+
+Reference names are an uninterpreted sequence of bytes that must pass
+linkgit:git-check-ref-format[1] as a valid reference name.
+
+Key unicity
+^^^^^^^^^^^
+
+Each entry must have a unique key; repeated keys are disallowed.
+
+Network byte order
+^^^^^^^^^^^^^^^^^^
+
+All multi-byte, fixed width fields are in network byte order.
+
+Ordering
+^^^^^^^^
+
+Blocks are lexicographically ordered by their first reference.
+
+Directory/file conflicts
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+The reftable format accepts both `refs/heads/foo` and
+`refs/heads/foo/bar` as distinct references.
+
+This property is useful for retaining log records in reftable, but may
+confuse versions of Git using `$GIT_DIR/refs` directory tree to maintain
+references. Users of reftable may choose to continue to reject `foo` and
+`foo/bar` type conflicts to prevent problems for peers.
+
+File format
+~~~~~~~~~~~
+
+Structure
+^^^^^^^^^
+
+A reftable file has the following high-level structure:
+
+....
+first_block {
+  header
+  first_ref_block
+}
+ref_block*
+ref_index*
+obj_block*
+obj_index*
+log_block*
+log_index*
+footer
+....
+
+A log-only file omits the `ref_block`, `ref_index`, `obj_block` and
+`obj_index` sections, containing only the file header and log block:
+
+....
+first_block {
+  header
+}
+log_block*
+log_index*
+footer
+....
+
+in a log-only file the first log block immediately follows the file
+header, without padding to block alignment.
+
+Block size
+^^^^^^^^^^
+
+The file’s block size is arbitrarily determined by the writer, and does
+not have to be a power of 2. The block size must be larger than the
+longest reference name or log entry used in the repository, as
+references cannot span blocks.
+
+Powers of two that are friendly to the virtual memory system or
+filesystem (such as 4k or 8k) are recommended. Larger sizes (64k) can
+yield better compression, with a possible increased cost incurred by
+readers during access.
+
+The largest block size is `16777215` bytes (15.99 MiB).
+
+Block alignment
+^^^^^^^^^^^^^^^
+
+Writers may choose to align blocks at multiples of the block size by
+including `padding` filled with NUL bytes at the end of a block to round
+out to the chosen alignment. When alignment is used, writers must
+specify the alignment with the file header’s `block_size` field.
+
+Block alignment is not required by the file format. Unaligned files must
+set `block_size = 0` in the file header, and omit `padding`. Unaligned
+files with more than one ref block must include the link:#Ref-index[ref
+index] to support fast lookup. Readers must be able to read both aligned
+and non-aligned files.
+
+Very small files (e.g. 1 only ref block) may omit `padding` and the ref
+index to reduce total file size.
+
+Header
+^^^^^^
+
+A 24-byte header appears at the beginning of the file:
+
+....
+'REFT'
+uint8( version_number = 1 )
+uint24( block_size )
+uint64( min_update_index )
+uint64( max_update_index )
+....
+
+Aligned files must specify `block_size` to configure readers with the
+expected block alignment. Unaligned files must set `block_size = 0`.
+
+The `min_update_index` and `max_update_index` describe bounds for the
+`update_index` field of all log records in this file. When reftables are
+used in a stack for link:#Update-transactions[transactions], these
+fields can order the files such that the prior file’s
+`max_update_index + 1` is the next file’s `min_update_index`.
+
+First ref block
+^^^^^^^^^^^^^^^
+
+The first ref block shares the same block as the file header, and is 24
+bytes smaller than all other blocks in the file. The first block
+immediately begins after the file header, at position 24.
+
+If the first block is a log block (a log-only file), its block header
+begins immediately at position 24.
+
+Ref block format
+^^^^^^^^^^^^^^^^
+
+A ref block is written as:
+
+....
+'r'
+uint24( block_len )
+ref_record+
+uint24( restart_offset )+
+uint16( restart_count )
+
+padding?
+....
+
+Blocks begin with `block_type = 'r'` and a 3-byte `block_len` which
+encodes the number of bytes in the block up to, but not including the
+optional `padding`. This is always less than or equal to the file’s
+block size. In the first ref block, `block_len` includes 24 bytes for
+the file header.
+
+The 2-byte `restart_count` stores the number of entries in the
+`restart_offset` list, which must not be empty. Readers can use
+`restart_count` to binary search between restarts before starting a
+linear scan.
+
+Exactly `restart_count` 3-byte `restart_offset` values precedes the
+`restart_count`. Offsets are relative to the start of the block and
+refer to the first byte of any `ref_record` whose name has not been
+prefix compressed. Entries in the `restart_offset` list must be sorted,
+ascending. Readers can start linear scans from any of these records.
+
+A variable number of `ref_record` fill the middle of the block,
+describing reference names and values. The format is described below.
+
+As the first ref block shares the first file block with the file header,
+all `restart_offset` in the first block are relative to the start of the
+file (position 0), and include the file header. This forces the first
+`restart_offset` to be `28`.
+
+ref record
+++++++++++
+
+A `ref_record` describes a single reference, storing both the name and
+its value(s). Records are formatted as:
+
+....
+varint( prefix_length )
+varint( (suffix_length << 3) | value_type )
+suffix
+varint( update_index_delta )
+value?
+....
+
+The `prefix_length` field specifies how many leading bytes of the prior
+reference record’s name should be copied to obtain this reference’s
+name. This must be 0 for the first reference in any block, and also must
+be 0 for any `ref_record` whose offset is listed in the `restart_offset`
+table at the end of the block.
+
+Recovering a reference name from any `ref_record` is a simple concat:
+
+....
+this_name = prior_name[0..prefix_length] + suffix
+....
+
+The `suffix_length` value provides the number of bytes available in
+`suffix` to copy from `suffix` to complete the reference name.
+
+The `update_index` that last modified the reference can be obtained by
+adding `update_index_delta` to the `min_update_index` from the file
+header: `min_update_index + update_index_delta`.
+
+The `value` follows. Its format is determined by `value_type`, one of
+the following:
+
+* `0x0`: deletion; no value data (see transactions, below)
+* `0x1`: one 20-byte object id; value of the ref
+* `0x2`: two 20-byte object ids; value of the ref, peeled target
+* `0x3`: symbolic reference: `varint( target_len ) target`
+
+Symbolic references use `0x3`, followed by the complete name of the
+reference target. No compression is applied to the target name.
+
+Types `0x4..0x7` are reserved for future use.
+
+Ref index
+^^^^^^^^^
+
+The ref index stores the name of the last reference from every ref block
+in the file, enabling reduced disk seeks for lookups. Any reference can
+be found by searching the index, identifying the containing block, and
+searching within that block.
+
+The index may be organized into a multi-level index, where the 1st level
+index block points to additional ref index blocks (2nd level), which may
+in turn point to either additional index blocks (e.g. 3rd level) or ref
+blocks (leaf level). Disk reads required to access a ref go up with
+higher index levels. Multi-level indexes may be required to ensure no
+single index block exceeds the file format’s max block size of
+`16777215` bytes (15.99 MiB). To acheive constant O(1) disk seeks for
+lookups the index must be a single level, which is permitted to exceed
+the file’s configured block size, but not the format’s max block size of
+15.99 MiB.
+
+If present, the ref index block(s) appears after the last ref block.
+
+If there are at least 4 ref blocks, a ref index block should be written
+to improve lookup times. Cold reads using the index require 2 disk reads
+(read index, read block), and binary searching < 4 blocks also requires
+<= 2 reads. Omitting the index block from smaller files saves space.
+
+If the file is unaligned and contains more than one ref block, the ref
+index must be written.
+
+Index block format:
+
+....
+'i'
+uint24( block_len )
+index_record+
+uint24( restart_offset )+
+uint16( restart_count )
+
+padding?
+....
+
+The index blocks begin with `block_type = 'i'` and a 3-byte `block_len`
+which encodes the number of bytes in the block, up to but not including
+the optional `padding`.
+
+The `restart_offset` and `restart_count` fields are identical in format,
+meaning and usage as in ref blocks.
+
+To reduce the number of reads required for random access in very large
+files the index block may be larger than other blocks. However, readers
+must hold the entire index in memory to benefit from this, so it’s a
+time-space tradeoff in both file size and reader memory.
+
+Increasing the file’s block size decreases the index size. Alternatively
+a multi-level index may be used, keeping index blocks within the file’s
+block size, but increasing the number of blocks that need to be
+accessed.
+
+index record
+++++++++++++
+
+An index record describes the last entry in another block. Index records
+are written as:
+
+....
+varint( prefix_length )
+varint( (suffix_length << 3) | 0 )
+suffix
+varint( block_position )
+....
+
+Index records use prefix compression exactly like `ref_record`.
+
+Index records store `block_position` after the suffix, specifying the
+absolute position in bytes (from the start of the file) of the block
+that ends with this reference. Readers can seek to `block_position` to
+begin reading the block header.
+
+Readers must examine the block header at `block_position` to determine
+if the next block is another level index block, or the leaf-level ref
+block.
+
+Reading the index
++++++++++++++++++
+
+Readers loading the ref index must first read the footer (below) to
+obtain `ref_index_position`. If not present, the position will be 0. The
+`ref_index_position` is for the 1st level root of the ref index.
+
+Obj block format
+^^^^^^^^^^^^^^^^
+
+Object blocks are optional. Writers may choose to omit object blocks,
+especially if readers will not use the SHA-1 to ref mapping.
+
+Object blocks use unique, abbreviated 2-20 byte SHA-1 keys, mapping to
+ref blocks containing references pointing to that object directly, or as
+the peeled value of an annotated tag. Like ref blocks, object blocks use
+the file’s standard block size. The abbrevation length is available in
+the footer as `obj_id_len`.
+
+To save space in small files, object blocks may be omitted if the ref
+index is not present, as brute force search will only need to read a few
+ref blocks. When missing, readers should brute force a linear search of
+all references to lookup by SHA-1.
+
+An object block is written as:
+
+....
+'o'
+uint24( block_len )
+obj_record+
+uint24( restart_offset )+
+uint16( restart_count )
+
+padding?
+....
+
+Fields are identical to ref block. Binary search using the restart table
+works the same as in reference blocks.
+
+Because object identifiers are abbreviated by writers to the shortest
+unique abbreviation within the reftable, obj key lengths are variable
+between 2 and 20 bytes. Readers must compare only for common prefix
+match within an obj block or obj index.
+
+obj record
+++++++++++
+
+An `obj_record` describes a single object abbreviation, and the blocks
+containing references using that unique abbreviation:
+
+....
+varint( prefix_length )
+varint( (suffix_length << 3) | cnt_3 )
+suffix
+varint( cnt_large )?
+varint( position_delta )*
+....
+
+Like in reference blocks, abbreviations are prefix compressed within an
+obj block. On large reftables with many unique objects, higher block
+sizes (64k), and higher restart interval (128), a `prefix_length` of 2
+or 3 and `suffix_length` of 3 may be common in obj records (unique
+abbreviation of 5-6 raw bytes, 10-12 hex digits).
+
+Each record contains `position_count` number of positions for matching
+ref blocks. For 1-7 positions the count is stored in `cnt_3`. When
+`cnt_3 = 0` the actual count follows in a varint, `cnt_large`.
+
+The use of `cnt_3` bets most objects are pointed to by only a single
+reference, some may be pointed to by a couple of references, and very
+few (if any) are pointed to by more than 7 references.
+
+A special case exists when `cnt_3 = 0` and `cnt_large = 0`: there are no
+`position_delta`, but at least one reference starts with this
+abbreviation. A reader that needs exact reference names must scan all
+references to find which specific references have the desired object.
+Writers should use this format when the `position_delta` list would have
+overflowed the file’s block size due to a high number of references
+pointing to the same object.
+
+The first `position_delta` is the position from the start of the file.
+Additional `position_delta` entries are sorted ascending and relative to
+the prior entry, e.g. a reader would perform:
+
+....
+pos = position_delta[0]
+prior = pos
+for (j = 1; j < position_count; j++) {
+  pos = prior + position_delta[j]
+  prior = pos
+}
+....
+
+With a position in hand, a reader must linearly scan the ref block,
+starting from the first `ref_record`, testing each reference’s SHA-1s
+(for `value_type = 0x1` or `0x2`) for full equality. Faster searching by
+SHA-1 within a single ref block is not supported by the reftable format.
+Smaller block sizes reduce the number of candidates this step must
+consider.
+
+Obj index
+^^^^^^^^^
+
+The obj index stores the abbreviation from the last entry for every obj
+block in the file, enabling reduced disk seeks for all lookups. It is
+formatted exactly the same as the ref index, but refers to obj blocks.
+
+The obj index should be present if obj blocks are present, as obj blocks
+should only be written in larger files.
+
+Readers loading the obj index must first read the footer (below) to
+obtain `obj_index_position`. If not present, the position will be 0.
+
+Log block format
+^^^^^^^^^^^^^^^^
+
+Unlike ref and obj blocks, log blocks are always unaligned.
+
+Log blocks are variable in size, and do not match the `block_size`
+specified in the file header or footer. Writers should choose an
+appropriate buffer size to prepare a log block for deflation, such as
+`2 * block_size`.
+
+A log block is written as:
+
+....
+'g'
+uint24( block_len )
+zlib_deflate {
+  log_record+
+  uint24( restart_offset )+
+  uint16( restart_count )
+}
+....
+
+Log blocks look similar to ref blocks, except `block_type = 'g'`.
+
+The 4-byte block header is followed by the deflated block contents using
+zlib deflate. The `block_len` in the header is the inflated size
+(including 4-byte block header), and should be used by readers to
+preallocate the inflation output buffer. A log block’s `block_len` may
+exceed the file’s block size.
+
+Offsets within the log block (e.g. `restart_offset`) still include the
+4-byte header. Readers may prefer prefixing the inflation output buffer
+with the 4-byte header.
+
+Within the deflate container, a variable number of `log_record` describe
+reference changes. The log record format is described below. See ref
+block format (above) for a description of `restart_offset` and
+`restart_count`.
+
+Because log blocks have no alignment or padding between blocks, readers
+must keep track of the bytes consumed by the inflater to know where the
+next log block begins.
+
+log record
+++++++++++
+
+Log record keys are structured as:
+
+....
+ref_name '\0' reverse_int64( update_index )
+....
+
+where `update_index` is the unique transaction identifier. The
+`update_index` field must be unique within the scope of a `ref_name`.
+See the update transactions section below for further details.
+
+The `reverse_int64` function inverses the value so lexographical
+ordering the network byte order encoding sorts the more recent records
+with higher `update_index` values first:
+
+....
+reverse_int64(int64 t) {
+  return 0xffffffffffffffff - t;
+}
+....
+
+Log records have a similar starting structure to ref and index records,
+utilizing the same prefix compression scheme applied to the log record
+key described above.
+
+....
+    varint( prefix_length )
+    varint( (suffix_length << 3) | log_type )
+    suffix
+    log_data {
+      old_id
+      new_id
+      varint( name_length    )  name
+      varint( email_length   )  email
+      varint( time_seconds )
+      sint16( tz_offset )
+      varint( message_length )  message
+    }?
+....
+
+Log record entries use `log_type` to indicate what follows:
+
+* `0x0`: deletion; no log data.
+* `0x1`: standard git reflog data using `log_data` above.
+
+The `log_type = 0x0` is mostly useful for `git stash drop`, removing an
+entry from the reflog of `refs/stash` in a transaction file (below),
+without needing to rewrite larger files. Readers reading a stack of
+reflogs must treat this as a deletion.
+
+For `log_type = 0x1`, the `log_data` section follows
+linkgit:git-update-ref[1] logging and includes:
+
+* two 20-byte SHA-1s (old id, new id)
+* varint string of committer’s name
+* varint string of committer’s email
+* varint time in seconds since epoch (Jan 1, 1970)
+* 2-byte timezone offset in minutes (signed)
+* varint string of message
+
+`tz_offset` is the absolute number of minutes from GMT the committer was
+at the time of the update. For example `GMT-0800` is encoded in reftable
+as `sint16(-480)` and `GMT+0230` is `sint16(150)`.
+
+The committer email does not contain `<` or `>`, it’s the value normally
+found between the `<>` in a git commit object header.
+
+The `message_length` may be 0, in which case there was no message
+supplied for the update.
+
+Contrary to traditional reflog (which is a file), renames are encoded as
+a combination of ref deletion and ref creation.
+
+Reading the log
++++++++++++++++
+
+Readers accessing the log must first read the footer (below) to
+determine the `log_position`. The first block of the log begins at
+`log_position` bytes since the start of the file. The `log_position` is
+not block aligned.
+
+Importing logs
+++++++++++++++
+
+When importing from `$GIT_DIR/logs` writers should globally order all
+log records roughly by timestamp while preserving file order, and assign
+unique, increasing `update_index` values for each log line. Newer log
+records get higher `update_index` values.
+
+Although an import may write only a single reftable file, the reftable
+file must span many unique `update_index`, as each log line requires its
+own `update_index` to preserve semantics.
+
+Log index
+^^^^^^^^^
+
+The log index stores the log key
+(`refname \0 reverse_int64(update_index)`) for the last log record of
+every log block in the file, supporting bounded-time lookup.
+
+A log index block must be written if 2 or more log blocks are written to
+the file. If present, the log index appears after the last log block.
+There is no padding used to align the log index to block alignment.
+
+Log index format is identical to ref index, except the keys are 9 bytes
+longer to include `'\0'` and the 8-byte `reverse_int64(update_index)`.
+Records use `block_position` to refer to the start of a log block.
+
+Reading the index
++++++++++++++++++
+
+Readers loading the log index must first read the footer (below) to
+obtain `log_index_position`. If not present, the position will be 0.
+
+Footer
+^^^^^^
+
+After the last block of the file, a file footer is written. It begins
+like the file header, but is extended with additional data.
+
+A 68-byte footer appears at the end:
+
+....
+    'REFT'
+    uint8( version_number = 1 )
+    uint24( block_size )
+    uint64( min_update_index )
+    uint64( max_update_index )
+
+    uint64( ref_index_position )
+    uint64( (obj_position << 5) | obj_id_len )
+    uint64( obj_index_position )
+
+    uint64( log_position )
+    uint64( log_index_position )
+
+    uint32( CRC-32 of above )
+....
+
+If a section is missing (e.g. ref index) the corresponding position
+field (e.g. `ref_index_position`) will be 0.
+
+* `obj_position`: byte position for the first obj block.
+* `obj_id_len`: number of bytes used to abbreviate object identifiers in
+obj blocks.
+* `log_position`: byte position for the first log block.
+* `ref_index_position`: byte position for the start of the ref index.
+* `obj_index_position`: byte position for the start of the obj index.
+* `log_index_position`: byte position for the start of the log index.
+
+Reading the footer
+++++++++++++++++++
+
+Readers must seek to `file_length - 68` to access the footer. A trusted
+external source (such as `stat(2)`) is necessary to obtain
+`file_length`. When reading the footer, readers must verify:
+
+* 4-byte magic is correct
+* 1-byte version number is recognized
+* 4-byte CRC-32 matches the other 64 bytes (including magic, and
+version)
+
+Once verified, the other fields of the footer can be accessed.
+
+Varint encoding
+^^^^^^^^^^^^^^^
+
+Varint encoding is identical to the ofs-delta encoding method used
+within pack files.
+
+Decoder works such as:
+
+....
+val = buf[ptr] & 0x7f
+while (buf[ptr] & 0x80) {
+  ptr++
+  val = ((val + 1) << 7) | (buf[ptr] & 0x7f)
+}
+....
+
+Binary search
+^^^^^^^^^^^^^
+
+Binary search within a block is supported by the `restart_offset` fields
+at the end of the block. Readers can binary search through the restart
+table to locate between which two restart points the sought reference or
+key should appear.
+
+Each record identified by a `restart_offset` stores the complete key in
+the `suffix` field of the record, making the compare operation during
+binary search straightforward.
+
+Once a restart point lexicographically before the sought reference has
+been identified, readers can linearly scan through the following record
+entries to locate the sought record, terminating if the current record
+sorts after (and therefore the sought key is not present).
+
+Restart point selection
++++++++++++++++++++++++
+
+Writers determine the restart points at file creation. The process is
+arbitrary, but every 16 or 64 records is recommended. Every 16 may be
+more suitable for smaller block sizes (4k or 8k), every 64 for larger
+block sizes (64k).
+
+More frequent restart points reduces prefix compression and increases
+space consumed by the restart table, both of which increase file size.
+
+Less frequent restart points makes prefix compression more effective,
+decreasing overall file size, with increased penalities for readers
+walking through more records after the binary search step.
+
+A maximum of `65535` restart points per block is supported.
+
+Considerations
+~~~~~~~~~~~~~~
+
+Lightweight refs dominate
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The reftable format assumes the vast majority of references are single
+SHA-1 valued with common prefixes, such as Gerrit Code Review’s
+`refs/changes/` namespace, GitHub’s `refs/pulls/` namespace, or many
+lightweight tags in the `refs/tags/` namespace.
+
+Annotated tags storing the peeled object cost an additional 20 bytes per
+reference.
+
+Low overhead
+^^^^^^^^^^^^
+
+A reftable with very few references (e.g. git.git with 5 heads) is 269
+bytes for reftable, vs. 332 bytes for packed-refs. This supports
+reftable scaling down for transaction logs (below).
+
+Block size
+^^^^^^^^^^
+
+For a Gerrit Code Review type repository with many change refs, larger
+block sizes (64 KiB) and less frequent restart points (every 64) yield
+better compression due to more references within the block compressing
+against the prior reference.
+
+Larger block sizes reduce the index size, as the reftable will require
+fewer blocks to store the same number of references.
+
+Minimal disk seeks
+^^^^^^^^^^^^^^^^^^
+
+Assuming the index block has been loaded into memory, binary searching
+for any single reference requires exactly 1 disk seek to load the
+containing block.
+
+Scans and lookups dominate
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Scanning all references and lookup by name (or namespace such as
+`refs/heads/`) are the most common activities performed on repositories.
+SHA-1s are stored directly with references to optimize this use case.
+
+Logs are infrequently read
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Logs are infrequently accessed, but can be large. Deflating log blocks
+saves disk space, with some increased penalty at read time.
+
+Logs are stored in an isolated section from refs, reducing the burden on
+reference readers that want to ignore logs. Further, historical logs can
+be isolated into log-only files.
+
+Logs are read backwards
+^^^^^^^^^^^^^^^^^^^^^^^
+
+Logs are frequently accessed backwards (most recent N records for master
+to answer `master@{4}`), so log records are grouped by reference, and
+sorted descending by update index.
+
+Repository format
+~~~~~~~~~~~~~~~~~
+
+Version 1
+^^^^^^^^^
+
+A repository must set its `$GIT_DIR/config` to configure reftable:
+
+....
+[core]
+    repositoryformatversion = 1
+[extensions]
+    refStorage = reftable
+....
+
+Layout
+^^^^^^
+
+A collection of reftable files are stored in the `$GIT_DIR/reftable/`
+directory:
+
+....
+00000001-00000001.log
+00000002-00000002.ref
+00000003-00000003.ref
+....
+
+where reftable files are named by a unique name such as produced by the
+function `${min_update_index}-${max_update_index}.ref`.
+
+Log-only files use the `.log` extension, while ref-only and mixed ref
+and log files use `.ref`. extension.
+
+The stack ordering file is `$GIT_DIR/reftable/tables.list` and lists the
+current files, one per line, in order, from oldest (base) to newest
+(most recent):
+
+....
+$ cat .git/reftable/tables.list
+00000001-00000001.log
+00000002-00000002.ref
+00000003-00000003.ref
+....
+
+Readers must read `$GIT_DIR/reftable/tables.list` to determine which
+files are relevant right now, and search through the stack in reverse
+order (last reftable is examined first).
+
+Reftable files not listed in `tables.list` may be new (and about to be
+added to the stack by the active writer), or ancient and ready to be
+pruned.
+
+Backward compatibility
+^^^^^^^^^^^^^^^^^^^^^^
+
+Older clients should continue to recognize the directory as a git
+repository so they don’t look for an enclosing repository in parent
+directories. To this end, a reftable-enabled repository must contain the
+following dummy files
+
+* `.git/HEAD`, a regular file containing `ref: refs/heads/.invalid`.
+* `.git/refs/`, a directory
+* `.git/refs/heads`, a regular file
+
+Readers
+^^^^^^^
+
+Readers can obtain a consistent snapshot of the reference space by
+following:
+
+1.  Open and read the `tables.list` file.
+2.  Open each of the reftable files that it mentions.
+3.  If any of the files is missing, goto 1.
+4.  Read from the now-open files as long as necessary.
+
+Update transactions
+^^^^^^^^^^^^^^^^^^^
+
+Although reftables are immutable, mutations are supported by writing a
+new reftable and atomically appending it to the stack:
+
+1.  Acquire `tables.list.lock`.
+2.  Read `tables.list` to determine current reftables.
+3.  Select `update_index` to be most recent file’s
+`max_update_index + 1`.
+4.  Prepare temp reftable `tmp_XXXXXX`, including log entries.
+5.  Rename `tmp_XXXXXX` to `${update_index}-${update_index}.ref`.
+6.  Copy `tables.list` to `tables.list.lock`, appending file from (5).
+7.  Rename `tables.list.lock` to `tables.list`.
+
+During step 4 the new file’s `min_update_index` and `max_update_index`
+are both set to the `update_index` selected by step 3. All log records
+for the transaction use the same `update_index` in their keys. This
+enables later correlation of which references were updated by the same
+transaction.
+
+Because a single `tables.list.lock` file is used to manage locking, the
+repository is single-threaded for writers. Writers may have to busy-spin
+(with backoff) around creating `tables.list.lock`, for up to an
+acceptable wait period, aborting if the repository is too busy to
+mutate. Application servers wrapped around repositories (e.g. Gerrit
+Code Review) can layer their own lock/wait queue to improve fairness to
+writers.
+
+Reference deletions
+^^^^^^^^^^^^^^^^^^^
+
+Deletion of any reference can be explicitly stored by setting the `type`
+to `0x0` and omitting the `value` field of the `ref_record`. This serves
+as a tombstone, overriding any assertions about the existence of the
+reference from earlier files in the stack.
+
+Compaction
+^^^^^^^^^^
+
+A partial stack of reftables can be compacted by merging references
+using a straightforward merge join across reftables, selecting the most
+recent value for output, and omitting deleted references that do not
+appear in remaining, lower reftables.
+
+A compacted reftable should set its `min_update_index` to the smallest
+of the input files’ `min_update_index`, and its `max_update_index`
+likewise to the largest input `max_update_index`.
+
+For sake of illustration, assume the stack currently consists of
+reftable files (from oldest to newest): A, B, C, and D. The compactor is
+going to compact B and C, leaving A and D alone.
+
+1.  Obtain lock `tables.list.lock` and read the `tables.list` file.
+2.  Obtain locks `B.lock` and `C.lock`. Ownership of these locks
+prevents other processes from trying to compact these files.
+3.  Release `tables.list.lock`.
+4.  Compact `B` and `C` into a temp file
+`${min_update_index}-${max_update_index}_XXXXXX`.
+5.  Reacquire lock `tables.list.lock`.
+6.  Verify that `B` and `C` are still in the stack, in that order. This
+should always be the case, assuming that other processes are adhering to
+the locking protocol.
+7.  Rename `${min_update_index}-${max_update_index}_XXXXXX` to
+`${min_update_index}-${max_update_index}.ref`.
+8.  Write the new stack to `tables.list.lock`, replacing `B` and `C`
+with the file from (4).
+9.  Rename `tables.list.lock` to `tables.list`.
+10. Delete `B` and `C`, perhaps after a short sleep to avoid forcing
+readers to backtrack.
+
+This strategy permits compactions to proceed independently of updates.
+
+Each reftable (compacted or not) is uniquely identified by its name, so
+open reftables can be cached by their name.
+
+Alternatives considered
+~~~~~~~~~~~~~~~~~~~~~~~
+
+bzip packed-refs
+^^^^^^^^^^^^^^^^
+
+`bzip2` can significantly shrink a large packed-refs file (e.g. 62 MiB
+compresses to 23 MiB, 37%). However the bzip format does not support
+random access to a single reference. Readers must inflate and discard
+while performing a linear scan.
+
+Breaking packed-refs into chunks (individually compressing each chunk)
+would reduce the amount of data a reader must inflate, but still leaves
+the problem of indexing chunks to support readers efficiently locating
+the correct chunk.
+
+Given the compression achieved by reftable’s encoding, it does not seem
+necessary to add the complexity of bzip/gzip/zlib.
+
+Michael Haggerty’s alternate format
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Michael Haggerty proposed
+https://public-inbox.org/git/CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com/[an
+alternate] format to reftable on the Git mailing list. This format uses
+smaller chunks, without the restart table, and avoids block alignment
+with padding. Reflog entries immediately follow each ref, and are thus
+interleaved between refs.
+
+Performance testing indicates reftable is faster for lookups (51%
+faster, 11.2 usec vs. 5.4 usec), although reftable produces a slightly
+larger file (+ ~3.2%, 28.3M vs 29.2M):
+
+[cols=">,>,>,>",options="header",]
+|=====================================
+|format |size |seek cold |seek hot
+|mh-alt |28.3 M |23.4 usec |11.2 usec
+|reftable |29.2 M |19.9 usec |5.4 usec
+|=====================================
+
+JGit Ketch RefTree
+^^^^^^^^^^^^^^^^^^
+
+https://dev.eclipse.org/mhonarc/lists/jgit-dev/msg03073.html[JGit Ketch]
+proposed
+https://public-inbox.org/git/CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com/[RefTree],
+an encoding of references inside Git tree objects stored as part of the
+repository’s object database.
+
+The RefTree format adds additional load on the object database storage
+layer (more loose objects, more objects in packs), and relies heavily on
+the packer’s delta compression to save space. Namespaces which are flat
+(e.g. thousands of tags in refs/tags) initially create very large loose
+objects, and so RefTree does not address the problem of copying many
+references to modify a handful.
+
+Flat namespaces are not efficiently searchable in RefTree, as tree
+objects in canonical formatting cannot be binary searched. This fails
+the need to handle a large number of references in a single namespace,
+such as GitHub’s `refs/pulls`, or a project with many tags.
+
+LMDB
+^^^^
+
+David Turner proposed
+https://public-inbox.org/git/1455772670-21142-26-git-send-email-dturner@twopensource.com/[using
+LMDB], as LMDB is lightweight (64k of runtime code) and GPL-compatible
+license.
+
+A downside of LMDB is its reliance on a single C implementation. This
+makes embedding inside JGit (a popular reimplemenation of Git)
+difficult, and hoisting onto virtual storage (for JGit DFS) virtually
+impossible.
+
+A common format that can be supported by all major Git implementations
+(git-core, JGit, libgit2) is strongly preferred.
+
+Future
+~~~~~~
+
+Longer hashes
+^^^^^^^^^^^^^
+
+Version will bump (e.g. 2) to indicate `value` uses a different object
+id length other than 20. The length could be stored in an expanded file
+header, or hardcoded as part of the version.
-- 
gitgitgadget

