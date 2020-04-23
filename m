Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58536C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D1A20724
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWFq9D+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgDWX6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgDWX6O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 19:58:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00953C09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 16:58:12 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ms17so3244493pjb.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 16:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VmtO9176PZPbCSp1/jsrEqdHE5QzNehNSG1V81tZ0eQ=;
        b=XWFq9D+vtSXL+8mxWXHZQkGz7HPLij3fmQnLD0P+IYC6J5JEmWPj6TzwF1xRJWfncw
         zgPOlyVFdYv6uypMpYJ/0lKKkHTdxW0naYiE4d6XDaU4MWCWkgcLikEtJ7Cih6d19i8A
         A+/phz0Ak4JDTlXNrn6LdumBweTjAep8OiJscUTr0XDxZazGuphm57vB9o9m/DNxN9mR
         HM/KuRC11yABRmmB8qCqgJcHYpDQDwqOP8W+Pa7Rdvfc2WmukQYphF/s7RhXAro99T8I
         FBhXToCsYHHFjxrS3qFg4Dylw/NcYDTbf+XblH7U2qixuOAnc+sN3qu8HutUFUwcHYk0
         3pCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VmtO9176PZPbCSp1/jsrEqdHE5QzNehNSG1V81tZ0eQ=;
        b=XOo4m83Ffrtm2/va4q2GtRwnIpmXHvnxGqpHbwYbwENVEeYDlbR9dGMF1CySwTrOjv
         Q/ETr9+CsJ8vv6U4cG7sYhHOVFqNdGRK24EaLzhqA546+Nj1nx0NYZAzzx67RhFpJ1HW
         uHpk+LV3L9uRF/8/q0aAv2AjLnb4GDeObgsyAQyq6/9elLp9C3i/KjRQvuGs9g2CIMZu
         JcBBGK5gFk+rJxd6riXdnnpoDQyHtAwR699s1BFr3LergHtg9jdgRlk7W7SF9gQQqqC2
         6ZeVFV2VvyYl/EERUX8WCcBBdnZ7m9FcAQOzEMFcKqAXQYaX95gJhUdY2LsNXYG4Epvj
         p/GA==
X-Gm-Message-State: AGi0PuYuferCsxJeyeRe/ZHe3W437Eq4X0ih/6AqowLJPEIAvqJY/oLY
        WivIZwqAo2oF3o2Kcx3EThwwSn7M
X-Google-Smtp-Source: APiQypJtI+1GviQWu6MFFtBZNmu68kwg36T4fIWS3r7IdVtgJy2d1mIK2cSSxj9cXss6woEoBUSgwQ==
X-Received: by 2002:a17:90a:f68d:: with SMTP id cl13mr3481387pjb.107.1587686292146;
        Thu, 23 Apr 2020 16:58:12 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id p2sm3081230pgh.25.2020.04.23.16.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 16:58:11 -0700 (PDT)
Date:   Fri, 24 Apr 2020 06:58:09 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] fix make sparse warning
Message-ID: <20200423235809.GA1949@danh.dev>
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <86ef24e2-3ab6-5e9c-900b-0eb4dbc1bb04@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86ef24e2-3ab6-5e9c-900b-0eb4dbc1bb04@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-24 00:10:25+0100, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> 
> 
> On 23/04/2020 14:47, Đoàn Trần Công Danh wrote:
> > It's happened that I tried to run make check on project that support autoconf.
> 
> I try to ignore autoconf as much as possible, so I don't know why people

For some reason, people refer to autotools as autohell

> who use it regularly seem to expect a 'make check' target (is that anything
> to do with ./config.status --recheck?).

Because it's autotools's recommendation.
https://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/Basic-Installation.html#Basic-Installation
https://www.gnu.org/software/automake/manual/automake.html#Standard-Targets

Yes, Linux kernel, and Git don't like GNU Coding Standards (and me
neither, because of their weird bracket position). But, it's
reasonable expectation if autotools is used.

> > Git's Makefile told me to run `make sparse` instead.
> 
> In which case, you must have had sparse installed, otherwise you would
> have been directed to 'make test'. [See commit 912f9980d2 ("Makefile: help
> people who run 'make check' by mistake", 2008-11-11)]
> 
> The 'check' target was introduced in commit 44c9e8594e ("Fix up header file
> dependencies and add sparse checking rules", 2005-07-03). As you can see,
> that target has nothing to do with autoconf/configure.
> 
> Exactly a year later, support for autoconf tools was added in commit
> 556677144b ("autoconf: Use autoconf to write installation
> directories to config.mak.autogen", 2006-07-03). This provides an
> 'alternative' to just
> using the Makefile (which is the _primary_ method used to build git).
> 
> I suspect that the majority of git developers don't use the autoconf
> tools (I have no numbers, just gut feeling).

I also think so.
 
> I added the 'sparse' target in commit 0bcd9ae85d ("sparse: Fix
> errors due to missing target-specific variables", 2011-04-21). After
> nine years, we could
> perhaps just drop the 'check' target altogether? dunno.
> 
> > I /think/ if we have a rule in Makefile, we should adhere to it.
> 
> Hmm, do you mean that 'make check' should be _reserved_ for autoconf use?
> [fun fact: the test target in the sparse Makefile is 'check' :-D ]

No, I didn't mean that, I just want to fix sparse warning.

I don't care much about the target's name,
in fact, I prefer `make test` over `make check`.

If we don't really care about sparse warning.
Let's remove this sparse target.

But, I think we do care about some sparse warning that modern compiler
stopped caring about, like the one with final_new_line.

> > I also fix another change in ds/blame-on-bloom, which I think it's worth to
> > fix, see: <20200423133937.GA1984@danh.dev>
> 
> Yes, looks good.
> 
> > This series is developed from latest master.
> 
> I have some comments on the patches (I'm running out of time here,
> so I may not get to them till tomorrow).
> 
> > It's conflicted when merge down next and pu.
> > 
> > For next, please ignore the conflict with fmt-merge-msg.c and
> > apply [5/4] instead.
> > 
> > For pu, reftable.c has too much warnings, I'm too lazy to look into it.
> 
> For those interested, the 'too much warnings' on the 'pu' branch looks
> like (for pu@faf094bf11):
> 
>   $ make sparse >psp-out 2>&1
>   $ diff nsp-out psp-out
>   154a155
>   >     SP refs/reftable-backend.c
>   406a408
>   >     SP t/helper/test-proc-receive.c
>   447a450,511
>   >     SP reftable/basics.c
>   > reftable/basics.c:157:6: warning: symbol 'reftable_malloc_ptr' was not declared. Should it be static?
>   > reftable/basics.c:158:6: warning: symbol 'reftable_realloc_ptr' was not declared. Should it be static?
>   > reftable/basics.c:159:6: warning: symbol 'reftable_free_ptr' was not declared. Should it be static?
>   >     SP reftable/block.c
>   >     SP reftable/bytes.c
>   >     SP reftable/file.c
>   > reftable/file.c:57:37: warning: symbol 'file_vtable' was not declared. Should it be static?
>   >     SP reftable/iter.c
>   > reftable/iter.c:32:33: warning: symbol 'empty_vtable' was not declared. Should it be static?
>   > reftable/iter.c:61:31: warning: Using plain integer as NULL pointer
>   > reftable/iter.c:69:31: warning: Using plain integer as NULL pointer
>   > reftable/iter.c:96:57: warning: Using plain integer as NULL pointer
>   > reftable/iter.c:124:33: warning: symbol 'filtering_ref_iterator_vtable' was not declared. Should it be static?
>   > reftable/iter.c:224:33: warning: symbol 'indexed_table_ref_iter_vtable' was not declared. Should it be static?
>   >     SP reftable/merged.c
>   > reftable/merged.c:141:33: warning: symbol 'merged_iter_vtable' was not declared. Should it be static?
>   > reftable/merged.c:283:31: warning: Using plain integer as NULL pointer
>   > reftable/merged.c:296:31: warning: Using plain integer as NULL pointer
>   >     SP reftable/pq.c
>   >     SP reftable/reader.c
>   > reftable/reader.c:180:42: warning: Using plain integer as NULL pointer
>   > reftable/reader.c:181:42: warning: Using plain integer as NULL pointer
>   > reftable/reader.c:284:41: warning: Using plain integer as NULL pointer
>   > reftable/reader.c:360:44: warning: Using plain integer as NULL pointer
>   > reftable/reader.c:396:33: warning: symbol 'table_iter_vtable' was not declared. Should it be static?
>   > reftable/reader.c:450:36: warning: Using plain integer as NULL pointer
>   > reftable/reader.c:498:42: warning: Using plain integer as NULL pointer
>   > reftable/reader.c:500:44: warning: Using plain integer as NULL pointer
>   > reftable/reader.c:501:42: warning: Using plain integer as NULL pointer
>   > reftable/reader.c:502:36: warning: Using plain integer as NULL pointer
>   > reftable/reader.c:565:34: warning: Using plain integer as NULL pointer
>   > reftable/reader.c:610:31: warning: Using plain integer as NULL pointer
>   > reftable/reader.c:623:31: warning: Using plain integer as NULL pointer
>   > reftable/reader.c:669:36: warning: Using plain integer as NULL pointer
>   > reftable/reader.c:670:42: warning: Using plain integer as NULL pointer
>   > reftable/reader.c:671:35: warning: Using plain integer as NULL pointer
>   > reftable/reader.c:672:35: warning: Using plain integer as NULL pointer
>   >     SP reftable/record.c
>   > reftable/record.c:556:22: warning: symbol 'obj_record_vtable' was not declared. Should it be static?
>   > reftable/record.c:839:22: warning: symbol 'reftable_log_record_vtable' was not declared. Should it be static?
>   > reftable/record.c:961:22: warning: symbol 'index_record_vtable' was not declared. Should it be static?
>   >     SP reftable/slice.c
>   > reftable/slice.c:180:37: warning: symbol 'slice_vtable' was not declared. Should it be static?
>   > reftable/slice.c:200:37: warning: symbol 'malloc_vtable' was not declared. Should it be static?
>   > reftable/slice.c:204:30: warning: symbol 'malloc_block_source_instance' was not declared. Should it be static?
>   >     SP reftable/stack.c
>   > reftable/stack.c:157:62: warning: Using plain integer as NULL pointer
>   > reftable/stack.c:667:41: warning: Using plain integer as NULL pointer
>   > reftable/stack.c:668:44: warning: Using plain integer as NULL pointer
>   > reftable/stack.c:669:44: warning: Using plain integer as NULL pointer
>   > reftable/stack.c:1085:41: warning: Using plain integer as NULL pointer
>   > reftable/stack.c:1111:41: warning: Using plain integer as NULL pointer
>   >     SP reftable/tree.c
>   >     SP reftable/writer.c
>   > reftable/writer.c:231:31: warning: Using plain integer as NULL pointer
>   > reftable/writer.c:299:39: warning: Using plain integer as NULL pointer
>   > reftable/writer.c:347:47: warning: Using plain integer as NULL pointer
>   > reftable/writer.c:426:31: warning: Using plain integer as NULL pointer
>   > reftable/writer.c:468:45: warning: Using plain integer as NULL pointer
>   > reftable/writer.c:584:11: warning: symbol 'debug' was not declared. Should it be static?
>   >     SP reftable/zlib-compat.c
> 
> Also, my static-check perl script says the following symbols are not
> used outside the file which defines them (so they could be marked static):

All of them are in reftable, and they're catched by `make sparse`,
too.

>   $ ./static-check.pl >psc
>   $ diff nsc psc
>   71a72,136
>   > reftable/basics.o	- reftable_free_ptr
>   > reftable/basics.o	- reftable_malloc_ptr
>   > reftable/basics.o	- reftable_realloc_ptr
>   > reftable/basics.o	- reftable_set_alloc
>   > reftable/block.o	- block_reader_seek
>   > reftable/block.o	- block_writer_register_restart
>   > reftable/file.o	- file_vtable
>   > reftable/iter.o	- empty_vtable
>   > reftable/iter.o	- filtering_ref_iterator_vtable
>   > reftable/iter.o	- indexed_table_ref_iter_vtable
>   > reftable/merged.o	- merged_iter_vtable
>   > reftable/merged.o	- reftable_merged_table_max_update_index
>   > reftable/merged.o	- reftable_merged_table_min_update_index
>   > reftable/merged.o	- reftable_merged_table_seek_log_at
>   > reftable/pq.o	- merged_iter_pqueue_check
>   > reftable/pq.o	- pq_less
>   > reftable/reader.o	- block_source_close
>   > reftable/reader.o	- block_source_read_block
>   > reftable/reader.o	- block_source_size
>   > reftable/reader.o	- init_reader
>   > reftable/reader.o	- reftable_reader_hash_id
>   > reftable/reader.o	- reftable_reader_refs_for
>   > reftable/reader.o	- reftable_reader_seek_log
>   > reftable/reader.o	- reftable_reader_seek_log_at
>   > reftable/reader.o	- table_iter_vtable
>   > reftable/record.o	- get_var_int
>   > reftable/record.o	- index_record_vtable
>   > reftable/record.o	- obj_record_vtable
>   > reftable/record.o	- put_var_int
>   > reftable/record.o	- record_as_log
>   > reftable/record.o	- record_as_ref
>   > reftable/record.o	- reftable_log_record_equal
>   > reftable/record.o	- reftable_log_record_print
>   > reftable/record.o	- reftable_log_record_vtable
>   > reftable/record.o	- reftable_ref_record_equal
>   > reftable/record.o	- reftable_ref_record_print
>   > reftable/record.o	- reftable_ref_record_vtable
>   > reftable/slice.o	- block_source_from_slice
>   > reftable/slice.o	- malloc_block_source_instance
>   > reftable/slice.o	- malloc_vtable
>   > reftable/slice.o	- slice_equal
>   > reftable/slice.o	- slice_vtable
>   > reftable/slice.o	- slice_write
>   > reftable/slice.o	- slice_write_void
>   > reftable/slice.o	- slice_yield
>   > reftable/stack.o	- fastlog2
>   > reftable/stack.o	- read_lines
>   > reftable/stack.o	- reftable_addition_add
>   > reftable/stack.o	- reftable_addition_close
>   > reftable/stack.o	- reftable_addition_commit
>   > reftable/stack.o	- reftable_stack_auto_compact
>   > reftable/stack.o	- reftable_stack_compaction_stats
>   > reftable/stack.o	- reftable_stack_destroy
>   > reftable/stack.o	- reftable_stack_new_addition
>   > reftable/stack.o	- reftable_stack_read_log
>   > reftable/stack.o	- reftable_stack_reload
>   > reftable/stack.o	- sizes_to_segments
>   > reftable/stack.o	- stack_try_add
>   > reftable/stack.o	- stack_write_compact
>   > reftable/stack.o	- suggest_compaction_segment
>   > reftable/writer.o	- debug
>   > reftable/writer.o	- writer_clear_index
>   > reftable/writer.o	- writer_finish_public_section
>   > reftable/writer.o	- writer_flush_block
>   > reftable/writer.o	- writer_stats
> 
> Note: I have not looked at any of the reftable patches/files.

Me neither.

-- 
Danh
