Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6203EC54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F98C2077D
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="srUPXO6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgDWXSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:18:09 -0400
Received: from avasout01.plus.net ([84.93.230.227]:33351 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729716AbgDWXSC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 19:18:02 -0400
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Apr 2020 19:18:01 EDT
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id RkzDjTjwMuzYfRkzEjfxEd; Fri, 24 Apr 2020 00:10:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1587683428; bh=1aKxF97sakDssD96NMV0e2CQ2SdNiZRlsaM8w9R4pvY=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=srUPXO6gf7+ARJ3204BQQyuLGVmXnmUh/W22WG9P2C3WfAgZnqAl0a08iTGmvOcap
         F0jr/RaF6xY2LB9ttAh9MClWpnUqJ5JFWBZv5hmg2hOblSjTlndc12cOsjnYyjJVGq
         aM5SoiIttvotmV3kurrsUdSZCLMZMiKt79d6oC1aUc0qnRj1wwKX1MjcnKvmDORVTY
         oxo5AdCD1fsY3Nq4TAtmrakJ8t4/fcLuQXeXpXlM/emsh26xT92wRcLMkWjQGYNdRF
         +vZyJggyQmF172ppCgjrwL0jo0sPxvJ9k66k2qr3ruputFUNywuwsUOL6pYQy6cq4s
         Lo6CvsZbQKhFw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=H8RAP9Qi c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=eiBuYnCo3If3s6K_Q4YA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 0/4] fix make sparse warning
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
References: <cover.1587648870.git.congdanhqx@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <86ef24e2-3ab6-5e9c-900b-0eb4dbc1bb04@ramsayjones.plus.com>
Date:   Fri, 24 Apr 2020 00:10:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1587648870.git.congdanhqx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIqxUh1yTk2NOtsTNoihKyAnLlt0NHQkBTrBEuREUEA+xmh6zJwRsdVvy12jamMv+0zDhsx5WXZdcnc4xuYXrxxpq1rz6EY1qmYGVLajFFoev2cgzIbc
 of6NNnWUqHY/7gJYbto/oFyiE32p0y7nwMJvkgBb2U6QmkBjpAoWw5j+rjGcTW0JT+c0ghba8NzX+g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/04/2020 14:47, Đoàn Trần Công Danh wrote:
> It's happened that I tried to run make check on project that support autoconf.

I try to ignore autoconf as much as possible, so I don't know why people
who use it regularly seem to expect a 'make check' target (is that anything
to do with ./config.status --recheck?).

> Git's Makefile told me to run `make sparse` instead.

In which case, you must have had sparse installed, otherwise you would
have been directed to 'make test'. [See commit 912f9980d2 ("Makefile: help
people who run 'make check' by mistake", 2008-11-11)]

The 'check' target was introduced in commit 44c9e8594e ("Fix up header file
dependencies and add sparse checking rules", 2005-07-03). As you can see,
that target has nothing to do with autoconf/configure.

Exactly a year later, support for autoconf tools was added in commit
556677144b ("autoconf: Use autoconf to write installation directories to config.mak.autogen", 2006-07-03). This provides an 'alternative' to just
using the Makefile (which is the _primary_ method used to build git).

I suspect that the majority of git developers don't use the autoconf
tools (I have no numbers, just gut feeling).

I added the 'sparse' target in commit 0bcd9ae85d ("sparse: Fix errors due to missing target-specific variables", 2011-04-21). After nine years, we could
perhaps just drop the 'check' target altogether? dunno.

> I /think/ if we have a rule in Makefile, we should adhere to it.

Hmm, do you mean that 'make check' should be _reserved_ for autoconf use?
[fun fact: the test target in the sparse Makefile is 'check' :-D ]

> I also fix another change in ds/blame-on-bloom, which I think it's worth to
> fix, see: <20200423133937.GA1984@danh.dev>

Yes, looks good.

> This series is developed from latest master.

I have some comments on the patches (I'm running out of time here,
so I may not get to them till tomorrow).

> It's conflicted when merge down next and pu.
> 
> For next, please ignore the conflict with fmt-merge-msg.c and
> apply [5/4] instead.
> 
> For pu, reftable.c has too much warnings, I'm too lazy to look into it.

For those interested, the 'too much warnings' on the 'pu' branch looks
like (for pu@faf094bf11):

  $ make sparse >psp-out 2>&1
  $ diff nsp-out psp-out
  154a155
  >     SP refs/reftable-backend.c
  406a408
  >     SP t/helper/test-proc-receive.c
  447a450,511
  >     SP reftable/basics.c
  > reftable/basics.c:157:6: warning: symbol 'reftable_malloc_ptr' was not declared. Should it be static?
  > reftable/basics.c:158:6: warning: symbol 'reftable_realloc_ptr' was not declared. Should it be static?
  > reftable/basics.c:159:6: warning: symbol 'reftable_free_ptr' was not declared. Should it be static?
  >     SP reftable/block.c
  >     SP reftable/bytes.c
  >     SP reftable/file.c
  > reftable/file.c:57:37: warning: symbol 'file_vtable' was not declared. Should it be static?
  >     SP reftable/iter.c
  > reftable/iter.c:32:33: warning: symbol 'empty_vtable' was not declared. Should it be static?
  > reftable/iter.c:61:31: warning: Using plain integer as NULL pointer
  > reftable/iter.c:69:31: warning: Using plain integer as NULL pointer
  > reftable/iter.c:96:57: warning: Using plain integer as NULL pointer
  > reftable/iter.c:124:33: warning: symbol 'filtering_ref_iterator_vtable' was not declared. Should it be static?
  > reftable/iter.c:224:33: warning: symbol 'indexed_table_ref_iter_vtable' was not declared. Should it be static?
  >     SP reftable/merged.c
  > reftable/merged.c:141:33: warning: symbol 'merged_iter_vtable' was not declared. Should it be static?
  > reftable/merged.c:283:31: warning: Using plain integer as NULL pointer
  > reftable/merged.c:296:31: warning: Using plain integer as NULL pointer
  >     SP reftable/pq.c
  >     SP reftable/reader.c
  > reftable/reader.c:180:42: warning: Using plain integer as NULL pointer
  > reftable/reader.c:181:42: warning: Using plain integer as NULL pointer
  > reftable/reader.c:284:41: warning: Using plain integer as NULL pointer
  > reftable/reader.c:360:44: warning: Using plain integer as NULL pointer
  > reftable/reader.c:396:33: warning: symbol 'table_iter_vtable' was not declared. Should it be static?
  > reftable/reader.c:450:36: warning: Using plain integer as NULL pointer
  > reftable/reader.c:498:42: warning: Using plain integer as NULL pointer
  > reftable/reader.c:500:44: warning: Using plain integer as NULL pointer
  > reftable/reader.c:501:42: warning: Using plain integer as NULL pointer
  > reftable/reader.c:502:36: warning: Using plain integer as NULL pointer
  > reftable/reader.c:565:34: warning: Using plain integer as NULL pointer
  > reftable/reader.c:610:31: warning: Using plain integer as NULL pointer
  > reftable/reader.c:623:31: warning: Using plain integer as NULL pointer
  > reftable/reader.c:669:36: warning: Using plain integer as NULL pointer
  > reftable/reader.c:670:42: warning: Using plain integer as NULL pointer
  > reftable/reader.c:671:35: warning: Using plain integer as NULL pointer
  > reftable/reader.c:672:35: warning: Using plain integer as NULL pointer
  >     SP reftable/record.c
  > reftable/record.c:556:22: warning: symbol 'obj_record_vtable' was not declared. Should it be static?
  > reftable/record.c:839:22: warning: symbol 'reftable_log_record_vtable' was not declared. Should it be static?
  > reftable/record.c:961:22: warning: symbol 'index_record_vtable' was not declared. Should it be static?
  >     SP reftable/slice.c
  > reftable/slice.c:180:37: warning: symbol 'slice_vtable' was not declared. Should it be static?
  > reftable/slice.c:200:37: warning: symbol 'malloc_vtable' was not declared. Should it be static?
  > reftable/slice.c:204:30: warning: symbol 'malloc_block_source_instance' was not declared. Should it be static?
  >     SP reftable/stack.c
  > reftable/stack.c:157:62: warning: Using plain integer as NULL pointer
  > reftable/stack.c:667:41: warning: Using plain integer as NULL pointer
  > reftable/stack.c:668:44: warning: Using plain integer as NULL pointer
  > reftable/stack.c:669:44: warning: Using plain integer as NULL pointer
  > reftable/stack.c:1085:41: warning: Using plain integer as NULL pointer
  > reftable/stack.c:1111:41: warning: Using plain integer as NULL pointer
  >     SP reftable/tree.c
  >     SP reftable/writer.c
  > reftable/writer.c:231:31: warning: Using plain integer as NULL pointer
  > reftable/writer.c:299:39: warning: Using plain integer as NULL pointer
  > reftable/writer.c:347:47: warning: Using plain integer as NULL pointer
  > reftable/writer.c:426:31: warning: Using plain integer as NULL pointer
  > reftable/writer.c:468:45: warning: Using plain integer as NULL pointer
  > reftable/writer.c:584:11: warning: symbol 'debug' was not declared. Should it be static?
  >     SP reftable/zlib-compat.c

Also, my static-check perl script says the following symbols are not
used outside the file which defines them (so they could be marked static):

  $ ./static-check.pl >psc
  $ diff nsc psc
  71a72,136
  > reftable/basics.o	- reftable_free_ptr
  > reftable/basics.o	- reftable_malloc_ptr
  > reftable/basics.o	- reftable_realloc_ptr
  > reftable/basics.o	- reftable_set_alloc
  > reftable/block.o	- block_reader_seek
  > reftable/block.o	- block_writer_register_restart
  > reftable/file.o	- file_vtable
  > reftable/iter.o	- empty_vtable
  > reftable/iter.o	- filtering_ref_iterator_vtable
  > reftable/iter.o	- indexed_table_ref_iter_vtable
  > reftable/merged.o	- merged_iter_vtable
  > reftable/merged.o	- reftable_merged_table_max_update_index
  > reftable/merged.o	- reftable_merged_table_min_update_index
  > reftable/merged.o	- reftable_merged_table_seek_log_at
  > reftable/pq.o	- merged_iter_pqueue_check
  > reftable/pq.o	- pq_less
  > reftable/reader.o	- block_source_close
  > reftable/reader.o	- block_source_read_block
  > reftable/reader.o	- block_source_size
  > reftable/reader.o	- init_reader
  > reftable/reader.o	- reftable_reader_hash_id
  > reftable/reader.o	- reftable_reader_refs_for
  > reftable/reader.o	- reftable_reader_seek_log
  > reftable/reader.o	- reftable_reader_seek_log_at
  > reftable/reader.o	- table_iter_vtable
  > reftable/record.o	- get_var_int
  > reftable/record.o	- index_record_vtable
  > reftable/record.o	- obj_record_vtable
  > reftable/record.o	- put_var_int
  > reftable/record.o	- record_as_log
  > reftable/record.o	- record_as_ref
  > reftable/record.o	- reftable_log_record_equal
  > reftable/record.o	- reftable_log_record_print
  > reftable/record.o	- reftable_log_record_vtable
  > reftable/record.o	- reftable_ref_record_equal
  > reftable/record.o	- reftable_ref_record_print
  > reftable/record.o	- reftable_ref_record_vtable
  > reftable/slice.o	- block_source_from_slice
  > reftable/slice.o	- malloc_block_source_instance
  > reftable/slice.o	- malloc_vtable
  > reftable/slice.o	- slice_equal
  > reftable/slice.o	- slice_vtable
  > reftable/slice.o	- slice_write
  > reftable/slice.o	- slice_write_void
  > reftable/slice.o	- slice_yield
  > reftable/stack.o	- fastlog2
  > reftable/stack.o	- read_lines
  > reftable/stack.o	- reftable_addition_add
  > reftable/stack.o	- reftable_addition_close
  > reftable/stack.o	- reftable_addition_commit
  > reftable/stack.o	- reftable_stack_auto_compact
  > reftable/stack.o	- reftable_stack_compaction_stats
  > reftable/stack.o	- reftable_stack_destroy
  > reftable/stack.o	- reftable_stack_new_addition
  > reftable/stack.o	- reftable_stack_read_log
  > reftable/stack.o	- reftable_stack_reload
  > reftable/stack.o	- sizes_to_segments
  > reftable/stack.o	- stack_try_add
  > reftable/stack.o	- stack_write_compact
  > reftable/stack.o	- suggest_compaction_segment
  > reftable/writer.o	- debug
  > reftable/writer.o	- writer_clear_index
  > reftable/writer.o	- writer_finish_public_section
  > reftable/writer.o	- writer_flush_block
  > reftable/writer.o	- writer_stats

Note: I have not looked at any of the reftable patches/files.

ATB,
Ramsay Jones
