Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9970C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 04:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C99F20796
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 04:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw4nlPnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbgJBD64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 23:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgJBD6z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 23:58:55 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E2DC0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 20:58:55 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l18so74764pjz.1
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 20:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EHH+u2clF14YwNVSlhq9Xb1zTlFOg9kMdLQkedA82Sg=;
        b=Zw4nlPnKsafLYqhZmS+VsxWMfh+tF7tpEfpH0T7Txp3gNni4IpZrx4xPonYMSBRgPs
         A2zAkuCz8GNV7wEA8GW82mMIjWRC21btK29xMz0t02/hmLWU0PesdvB2ogkOZ9l9EDvc
         eRFBP2luPsy952hfj7SBuNVdI1ajaeSi9hlN0jH5+8mdnmhUekJBt2K2C+14qJkAqbLM
         MkbsKsfR6w98C/dHmIat1HLgm2cpYEmjavxXAQPKRYEAtQ76CH3o/2DOZjGiYSPqBPVl
         dsyp2L/EflBpts3hoZxIX1CD7OFdRw91/PNXQ1gJW4HRDSbsI7HJtVEAoC7cc5md7X38
         i5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EHH+u2clF14YwNVSlhq9Xb1zTlFOg9kMdLQkedA82Sg=;
        b=EdjYB4Yww3CeOBj/yCl3RpqkbvoKese1BuzfhqLijoJbKH4qeIqRYStjN7/9Wc6izZ
         HdID3iHz4gz0iHLoBKTchRe6Utq/j2X19e4tlzsAgZ6efjhD0Ywqs/xZQCVOEHhAk5su
         rfL2AF0jua644k51KKH89KES2sXvzjwBknYSgfKXRRVuwVqyIA3Sc6tYJoxksClLaOrl
         bjemKSlAGCaUys2ANxBwatd2tsrSvs4tcuIvbDFmNliKKFrWVRStLOHJmty0qj3FwvNj
         BYJSUIgal26sRaoqVInY61xO30Tg4wyk5xNdAZ5jkkrWl9lNugFlVgRGTd9NZ1IBMQIb
         jIrQ==
X-Gm-Message-State: AOAM532e7cC4SW6jpdaPVAVLZPgF1I8Dk1mjlpb1/EOW5HlJnRhqCh3I
        hc3EJBDtLOm8DdffRJvVh3o=
X-Google-Smtp-Source: ABdhPJzgt5ix183Fewc7SV3C7iJFZEbf7KnX83xV/UblzvnCBjgw5vpjw/tQ8oRRUbB9MwDA7W5DNg==
X-Received: by 2002:a17:90b:357:: with SMTP id fh23mr572573pjb.221.1601611134081;
        Thu, 01 Oct 2020 20:58:54 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id x140sm94669pfc.211.2020.10.01.20.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 20:58:53 -0700 (PDT)
Date:   Thu, 1 Oct 2020 20:58:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 02/13] reftable: define the public API
Message-ID: <20201002035851.GB3252492@google.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
 <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <5d1b946ab5473504e9599d90c0feda407a179a05.1601568663.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d1b946ab5473504e9599d90c0feda407a179a05.1601568663.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Han-Wen Nienhuys wrote:

>  reftable/reftable.h | 585 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 585 insertions(+)
>  create mode 100644 reftable/reftable.h

Adding a header in a separate patch from the implementation doesn't
match the usual practice.  Can we add declarations in the same patch
as the functions being declared instead?

We could still introduce the header early in its own patch if we want,
but it would be a skeleton of a header that gets filled out by later
patches.

[...]
> --- /dev/null
> +++ b/reftable/reftable.h
> @@ -0,0 +1,585 @@
[...]
> +#ifndef REFTABLE_H
> +#define REFTABLE_H
> +
> +#include <stdint.h>
> +#include <stddef.h>

Git tends to prefer to rely on the caller to have #include-ed
git-compat-util.h instead.  That helps avoid having to worry about
portability gotchas around what feature test macros need to have been
set before the first #include of a standard header.

> +
> +void reftable_set_alloc(void *(*malloc)(size_t),
> +			void *(*realloc)(void *, size_t), void (*free)(void *));
> +
> +/****************************************************************
> + Basic data types
> +
> + Reftables store the state of each ref in struct reftable_ref_record, and they
> + store a sequence of reflog updates in struct reftable_log_record.
> + ****************************************************************/

nit: Git style for comments would be

/*
 * Basic data types
 *
 * Reftables store the state of each [etc]
 */

In other words:

- no lines of stars
- "/*" with no text after it as first line
- " *" leading subsequent lines
- " */" as last line


> +
> +/* reftable_ref_record holds a ref database entry target_value */
> +struct reftable_ref_record {
> +	char *refname; /* Name of the ref, malloced. */
> +	uint64_t update_index; /* Logical timestamp at which this value is
> +				  written */

Likewise: Git doesn't have this style of multi-line comment, but this
could be e.g. a single-line comment before

	/* logical timestamp at which this value was written */
	uint64_t update_index;

> +	uint8_t *value; /* SHA1, or NULL. malloced. */

What does "NULL. malloced" mean?  Is the point that the
reftable_ref_record owns the memory?  (We don't do as good a job of
documenting that as we should.  Often a non-const pointer is owned,
but in this example it's probably better to be explicit that this
struct owns the memory pointed to by all its fields in the comment
describing the struct as a whole.)

It would be more idiomatic for this to be a 'struct object_id' inline
in the reftable_ref_record.

> +	uint8_t *target_value; /* peeled annotated tag, or NULL. malloced. */
> +	char *target; /* symref, or NULL. malloced. */
> +};
> +
> +/* returns whether 'ref' represents a deletion */
> +int reftable_ref_record_is_deletion(const struct reftable_ref_record *ref);

Nice, this looks pleasant to use.

> +
> +/* prints a reftable_ref_record onto stdout */
> +void reftable_ref_record_print(struct reftable_ref_record *ref,
> +			       uint32_t hash_id);

Probably worth being explicit about the purpose: is this for
debugging?

What is a hash_id?

> +
> +/* frees and nulls all pointer values. */
> +void reftable_ref_record_clear(struct reftable_ref_record *ref);
> +
> +/* returns whether two reftable_ref_records are the same */
> +int reftable_ref_record_equal(struct reftable_ref_record *a,
> +			      struct reftable_ref_record *b, int hash_size);
> +
> +/* reftable_log_record holds a reflog entry */
> +struct reftable_log_record {

Should some of this documentation mention the reftable spec?  E.g. an
opening comment at the beginning of the header.  That might help avoid
having to duplicate too much explanation when terminology matches.

> +	char *refname;
> +	uint64_t update_index; /* logical timestamp of a transactional update.
> +				*/

multiline comment (I won't mention the rest).

> +	uint8_t *new_hash;
> +	uint8_t *old_hash;
> +	char *name;
> +	char *email;
> +	uint64_t time;
> +	int16_t tz_offset;
> +	char *message;
> +};
> +
> +/* returns whether 'ref' represents the deletion of a log record. */

These are a bit subtle --- should the comment include a little more
explanation (e.g. about how this is mostly for tools like "git
stash")?

> +int reftable_log_record_is_deletion(const struct reftable_log_record *log);
> +
> +/* frees and nulls all pointer values. */
> +void reftable_log_record_clear(struct reftable_log_record *log);
> +
> +/* returns whether two records are equal. */
> +int reftable_log_record_equal(struct reftable_log_record *a,
> +			      struct reftable_log_record *b, int hash_size);
> +
> +/* dumps a reftable_log_record on stdout, for debugging/testing. */
> +void reftable_log_record_print(struct reftable_log_record *log,
> +			       uint32_t hash_id);
> +
> +/****************************************************************
> + Error handling
> +
> + Error are signaled with negative integer return values. 0 means success.
> + ****************************************************************/
> +
> +/* different types of errors */
> +enum reftable_error {

Reminds me of zlib and liblzma.  I like it.

> +	/* Unexpected file system behavior */
> +	REFTABLE_IO_ERROR = -2,
> +
> +	/* Format inconsistency on reading data
> +	 */
> +	REFTABLE_FORMAT_ERROR = -3,
> +
> +	/* File does not exist. Returned from block_source_from_file(),  because
> +	   it needs special handling in stack.
> +	*/
> +	REFTABLE_NOT_EXIST_ERROR = -4,
> +
> +	/* Trying to write out-of-date data. */
> +	REFTABLE_LOCK_ERROR = -5,
> +
> +	/* Misuse of the API:
> +	   - on writing a record with NULL refname.
> +	   - on writing a reftable_ref_record outside the table limits
> +	   - on writing a ref or log record before the stack's next_update_index
> +	   - on writing a log record with multiline message with
> +	   exact_log_message unset
> +	   - on reading a reftable_ref_record from log iterator, or vice versa.
> +	*/
> +	REFTABLE_API_ERROR = -6,

Should these call BUG()?  Or is it useful for some callers to be able
to recover from these errors?

> +
> +	/* Decompression error */
> +	REFTABLE_ZLIB_ERROR = -7,
> +
> +	/* Wrote a table without blocks. */
> +	REFTABLE_EMPTY_TABLE_ERROR = -8,
> +
> +	/* Dir/file conflict. */

This is when adding a ref?

> +	REFTABLE_NAME_CONFLICT = -9,
> +
> +	/* Illegal ref name. */
> +	REFTABLE_REFNAME_ERROR = -10,
> +};
> +
> +/* convert the numeric error code to a string. The string should not be
> + * deallocated. */
> +const char *reftable_error_str(int err);

In the ZLIB_ERROR case this would produce a frustratingly vague
message.  I think I don't mind, but it might be worth a NEEDSWORK
comment to revisit in the future.

> +
> +/*
> + * Convert the numeric error code to an equivalent errno code.
> + */
> +int reftable_error_to_errno(int err);

What is the intended use of this function?

[...]
> +/* reftable_block_stats holds statistics for a single block type */
> +struct reftable_block_stats {

Are these for use in tracing, debugging, or some other purpose?

[...]
> +/* reftable_new_writer creates a new writer */
> +struct reftable_writer *
> +reftable_new_writer(int (*writer_func)(void *, const void *, size_t),
> +		    void *writer_arg, struct reftable_write_options *opts);

What is a writer?  What is a writer_func?  Is this a handle that
allows me to determine where I write my reftable?  (Sounds reasonable
but the comment could be more explicit.)

[...]
> +
> +/* write to a file descriptor. fdp should be an int* pointing to the fd. */
> +int reftable_fd_write(void *fdp, const void *data, size_t size);

What does this do for interrupted writes?

> +
> +/* Set the range of update indices for the records we will add.  When
> +   writing a table into a stack, the min should be at least
> +   reftable_stack_next_update_index(), or REFTABLE_API_ERROR is returned.
> +
> +   For transactional updates, typically min==max. When converting an existing
> +   ref database into a single reftable, this would be a range of update-index
> +   timestamps.
> + */
> +void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
> +				uint64_t max);

What happens if I write to a reftable_writer without setting limits
first?

> +
> +/* adds a reftable_ref_record. Must be called in ascending
> +   order. The update_index must be within the limits set by
> +   reftable_writer_set_limits(), or REFTABLE_API_ERROR is returned.
> +
> +   It is an error to write a ref record after a log record.
> + */
> +int reftable_writer_add_ref(struct reftable_writer *w,
> +			    struct reftable_ref_record *ref);

optional: since it's called a writer, _write_ref() feels like a
slightly more natural verb (likewise for the others).

[...]
> +/* adds a reftable_log_record. Must be called in ascending order (with more
> +   recent log entries first.)
> + */
> +int reftable_writer_add_log(struct reftable_writer *w,
> +			    struct reftable_log_record *log);

If I want to write multiple log records with the same update_index to
represent a multi-ref transaction, do I have to do anything careful?

> +
> +/* Convenience function to add multiple logs. Will sort the records by
> +   key before adding. */
> +int reftable_writer_add_logs(struct reftable_writer *w,
> +			     struct reftable_log_record *logs, int n);
> +
> +/* reftable_writer_close finalizes the reftable. The writer is retained so
> + * statistics can be inspected. */
> +int reftable_writer_close(struct reftable_writer *w);

Nice.

> +
> +/* writer_stats returns the statistics on the reftable being written.
> +
> +   This struct becomes invalid when the writer is freed.
> + */
> +const struct reftable_stats *writer_stats(struct reftable_writer *w);

Also nice.

[...]
> +/* iterator is the generic interface for walking over data stored in a
> +   reftable. It is generally passed around by value.
> +*/
> +struct reftable_iterator {
> +	struct reftable_iterator_vtable *ops;
> +	void *iter_arg;
> +};

Even small structs like this one tend not to be passed by value in the
Git codebase.  The only counterexample I found with a quick search
(builtin/stash.c::save_untracked_files) appears to be a typo.

[...]
> +/* a contiguous segment of bytes. It keeps track of its generating block_source
> +   so it can return itself into the pool.
> +*/
> +struct reftable_block {
> +	uint8_t *data;
> +	int len;
> +	struct reftable_block_source source;
> +};

Is this something that could use mem-pool.h?

> +/* block_source_vtable are the operations that make up block_source */
> +struct reftable_block_source_vtable {
> +	/* returns the size of a block source */
> +	uint64_t (*size)(void *source);
> +
> +	/* reads a segment from the block source. It is an error to read
> +	   beyond the end of the block */
> +	int (*read_block)(void *source, struct reftable_block *dest,
> +			  uint64_t off, uint32_t size);
> +	/* mark the block as read; may return the data back to malloc */
> +	void (*return_block)(void *source, struct reftable_block *blockp);
> +
> +	/* release all resources associated with the block source */
> +	void (*close)(void *source);
> +};

This is abstracting file input?  I wonder if some name emphasizing the
'read' operation like block_reader might be clearer.

Do I pass in the 'struct block_source *' as the source arg?  If so, why
are these declared as void *?

Is the reason this manages the buffer instead of requiring a
caller-supplied buffer to support zero-copy?

[...]
> +
> +/* opens a file on the file system as a block_source */
> +int reftable_block_source_from_file(struct reftable_block_source *block_src,
> +				    const char *name);
> +
> +/* The reader struct is a handle to an open reftable file. */
> +struct reftable_reader;

... ah, this is why the underlying file handle isn't called a reader.
Hmm.

[...]
> +/* reftable_reader_seek_ref returns an iterator where 'name' would be inserted
> +   in the table.  To seek to the start of the table, use name = "".

nit: s/iterator where/iterator pointing where/

> +
> +   example:
> +
> +   struct reftable_reader *r = NULL;
> +   int err = reftable_new_reader(&r, &src, "filename");
> +   if (err < 0) { ... }
> +   struct reftable_iterator it  = {0};
> +   err = reftable_reader_seek_ref(r, &it, "refs/heads/master");
> +   if (err < 0) { ... }
> +   struct reftable_ref_record ref  = {0};
> +   while (1) {
> +     err = reftable_iterator_next_ref(&it, &ref);
> +     if (err > 0) {
> +       break;
> +     }
> +     if (err < 0) {
> +       ..error handling..
> +     }
> +     ..found..
> +   }
> +   reftable_iterator_destroy(&it);
> +   reftable_ref_record_clear(&ref);

Nice.

> + */
> +int reftable_reader_seek_ref(struct reftable_reader *r,
> +			     struct reftable_iterator *it, const char *name);
> +
> +/* returns the hash ID used in this table. */
> +uint32_t reftable_reader_hash_id(struct reftable_reader *r);

What is a hash id?

[...]
> + Merged tables
> +
> + A ref database kept in a sequence of table files. The merged_table presents a
> + unified view to reading (seeking, iterating) a sequence of immutable tables.

Nice as well.

[...]
> +/* returns the max update_index covered by this merged table. */
> +uint64_t
> +reftable_merged_table_max_update_index(struct reftable_merged_table *mt);

nit: return type should be on the same line as the function name

	uint64_t reftable_merged_table_max_update_index(
					struct reftable_merged_table *mt);

[...]
> + Generic tables
> +
> + A unified API for reading tables, either merged tables, or single readers.

Are there callers/helpers that don't know whether they want one or the
other?

[...]
> + * a stack is a stack of reftables, which can be mutated by pushing a table to
> + * the top of the stack

Nice.

[...]
> +/* holds a transaction to add tables at the top of a stack. */
> +struct reftable_addition;

When would I add multiple tables at once to the top?  Is this used
during compacting, for example?

[...]
> +/* heuristically compact unbalanced table stack. */
> +int reftable_stack_auto_compact(struct reftable_stack *st);

When do I call this?  What are the semantics?  (By this I don't mean
what heuristic does it use, but what expectation should I have as a
caller?)

> +/* convenience function to read a single log. Returns < 0 for error, 0
> +   for success, and 1 if ref not found. */
> +int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
> +			    struct reftable_log_record *log);

nit: single log *record*?

> +/* statistics on past compactions. */
> +struct reftable_compaction_stats {
> +	uint64_t bytes; /* total number of bytes written */
> +	uint64_t entries_written; /* total number of entries written, including
> +				     failures. */
> +	int attempts; /* how often we tried to compact */
> +	int failures; /* failures happen on concurrent updates */
> +};
> +
> +/* return statistics for compaction up till now. */
> +struct reftable_compaction_stats *
> +reftable_stack_compaction_stats(struct reftable_stack *st);

All in all, I like this API.  Thanks for putting it together
thoughtfully.

The API builds up in layers (blocks, reftables, merged reftables, etc),
suggesting a natural division for the patch series.  I think the rest of
the series follows that --- let's see.

Thanks,
Jonathan
