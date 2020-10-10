Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8D4C35257
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC9C2075E
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1AeJAWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390023AbgJJW4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731545AbgJJTe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 15:34:28 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55222C08EA6F
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 09:58:09 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id x185so6776540vsb.1
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g4uexw/bmmT9rV8C/0vwSRQYnlkMzwU5HSxrnwi5uZA=;
        b=u1AeJAWNh5oV0UYmTSa5o8Hq/IfWOvV66ddDfYG51WE+lm26k1WEWh+/P4PvAMrl9I
         IOFilMAoydW0/FH0CckMOStUzoXIaBxETPQDBnQo4wMAsRLyf7fqL6/DieHIrrSAkwN4
         HpV/Lmx5iSknU6SDwPDsM/+flO5J0EVTmValVkHdIBdZHWelsocvy1pCgn26B/0uoMnR
         9aIEOm0axe18kZS+UcCaH+lJns39NUCDJC0rXILx/TO3FZw3SmH9LYkhGEBl2BYRdP63
         LQxAJzcH9qUDYCTQYmQNd1sWxT5c5AenxWo94lSmlKd5whsMTMj3sztg5oQ0AwpJwPTu
         cqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g4uexw/bmmT9rV8C/0vwSRQYnlkMzwU5HSxrnwi5uZA=;
        b=kCkJyj/12QeO2ChxOVf+1LdzTLoJLjeiXpcthQT51FkcPCqhF+KntI9tvXVwbQwccC
         34Pvf8p7nmIDWl3bqQ6j1BaVuYB+dAAPa9TRKrGB6jb19IvI+WPeL+/Nibyr2ZqXZ7j9
         j2LRqS8OJ6CiqcrZrVWNbJr1przrjylLdb6NCiVloDjThxhYIhvwF83DfSgOWT1RBzGu
         6MgM+0WJCWVTQ7nm8IOS93duDmGii65BKby2Ra7zUb79gD+pEzFvOxnhGH1gHYgN+7XB
         GvKY/GEbqJA+R9PN0XaCkABAhFtIkxjU8diKOidyyFn6RLTDXY9lwlVYDQzhyBzjKPis
         Bnhw==
X-Gm-Message-State: AOAM530ZWt8v+na7ApLzwxcK+gsjoWBwg+9ZhgdqxZlmktiD57eH60ZP
        GjqPODBaChA6nl+4gwaZEAj3yitPwD+QAS8tuZvrFw==
X-Google-Smtp-Source: ABdhPJwax2U/3Mk7SioFSiIMgMrffEagP5Qtg3yP2Cfm5YKuuTBkm8q0B52KQ/R9ssSAmz8Mz1web1g+JMrIRo4Wn+I=
X-Received: by 2002:a67:ea12:: with SMTP id g18mr10185368vso.50.1602349087943;
 Sat, 10 Oct 2020 09:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <5d1b946ab5473504e9599d90c0feda407a179a05.1601568663.git.gitgitgadget@gmail.com>
 <20201008014124.1410535-1-jonathantanmy@google.com>
In-Reply-To: <20201008014124.1410535-1-jonathantanmy@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Sat, 10 Oct 2020 18:57:56 +0200
Message-ID: <CAFQ2z_PGyOyjDwPsbwUHZZayNUZYVZteHSWRGKdtLBw4_J26vA@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] reftable: define the public API
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

thanks for a detailed look at the API. I'm replying to some queries
here, but I won't have time for another 2 weeks to revisit the code.

On Thu, Oct 8, 2020 at 3:41 AM Jonathan Tan <jonathantanmy@google.com> wrot=
e:
> A typical user would just want to do refname->hash, refname->log, or poss=
ibly
> hash->refname lookups, so a ref record would be meant for low-level

You are forgetting refname -> symref target and refname -> peeled tag.

> users. I can't think of a typical use case, but even if such existed, I
> wouldn't expect this API - in particular, the refname is not written as
> such on disk (it is composed from a prefix and a suffix, if I remember
> correctly), so I would expect a function that one can call to write the
> refname, but not for it to appear in a data structure.

It works with records, because it is more practical for the low level
code, but also because it obviates defining many functions for the
different types of lookups and seeks.

> > +/* returns whether 'ref' represents a deletion */
> > +int reftable_ref_record_is_deletion(const struct reftable_ref_record *=
ref);
>
> This looks unorthogonal - looking at the spec, the "value type" can
> represent a deletion, one object name (value of the ref), two object
> names (value of the ref + peeled target), or symbolic reference. If
> we're willing to allocate memory for a ref record, I think we can afford
> the extra 4 bytes (maybe 8) and use a tagged union instead.

I guess you want something like

  struct {
     enum TYPE  { REF_DEL, REF_1VAL, REF_2VAL, REF_SYM } record_type;
     char *ref_name;
     uint64_t update_index;
     union  {
          uint_8 *val1;
          struct { uint8_t *val1, *val2; } val2;
          char *sym;
     };
  };

I suspect it makes initialization more verbose, but yes, I could do that.

> > +/* returns whether two reftable_ref_records are the same */
> > +int reftable_ref_record_equal(struct reftable_ref_record *a,
> > +                           struct reftable_ref_record *b, int hash_siz=
e);
>
> Not sure what this will be used for.

This is useful for testing.

> > +/* Set the range of update indices for the records we will add.  When
> > +   writing a table into a stack, the min should be at least
> > +   reftable_stack_next_update_index(), or REFTABLE_API_ERROR is return=
ed.
> > +
> > +   For transactional updates, typically min=3D=3Dmax. When converting =
an existing
> > +   ref database into a single reftable, this would be a range of updat=
e-index
> > +   timestamps.
> > + */
> > +void reftable_writer_set_limits(struct reftable_writer *w, uint64_t mi=
n,
> > +                             uint64_t max);
>
> This seems to be here because we want to write the file in a single
> pass, and the update index maximum and minimum appear in the header. If
> we were allowed to seek while writing, could the update index maximum
> and minimum be deduced instead?

No. The ref record update_index is delta encoded against the min
update_index, so you have to know it upfront.

If I could redesign the format, I'd leave out the max update_index
from the header (because it can be determined afterwards.), but it's
too late now.

>
> > +/* adds a reftable_ref_record. Must be called in ascending
> > +   order. The update_index must be within the limits set by
> > +   reftable_writer_set_limits(), or REFTABLE_API_ERROR is returned.
> > +
> > +   It is an error to write a ref record after a log record.
> > + */
> > +int reftable_writer_add_ref(struct reftable_writer *w,
> > +                         struct reftable_ref_record *ref);
> > +
> > +/* Convenience function to add multiple refs. Will sort the refs by
> > +   name before adding. */
> > +int reftable_writer_add_refs(struct reftable_writer *w,
> > +                          struct reftable_ref_record *refs, int n);
>
> Since refs is an array of objects and not an array of pointers, these
> two functions could be combined - the first is the same as calling the
> second with n=3D1.
>
> Also, ascending order of what?

Of record keys, ie. refname in case of ref records.

> The user will also need to know where to get the update index from - I
> presume that this will be the maximum update index of any record with
> the given refname + 1.

there is a reftable_stack_next_update_index() for that.

> > +/* reads the next reftable_ref_record. Returns < 0 for error, 0 for OK=
 and > 0:
> > +   end of iteration.
> > +*/
> > +int reftable_iterator_next_ref(struct reftable_iterator *it,
> > +                            struct reftable_ref_record *ref);
> > +
> > +/* reads the next reftable_log_record. Returns < 0 for error, 0 for OK=
 and > 0:
> > +   end of iteration.
> > +*/
> > +int reftable_iterator_next_log(struct reftable_iterator *it,
> > +                            struct reftable_log_record *log);
>
> From my recollection, in Git, we typically use foreach functions with a
> callback that is invoked once for each result. I think that's preferable
> to this approach.

The iterator interface has the advantage that it captures reading both
individual entries (read_raw_ref) and iteration. It's also a natural
structure, because internally the iteration state has to be stored
(iterating merged tables stores the iterators in a priority queue.)


> [snip]
>
> > +/****************************************************************
> > + Merged tables
> > +
> > + A ref database kept in a sequence of table files. The merged_table pr=
esents a
> > + unified view to reading (seeking, iterating) a sequence of immutable =
tables.
> > + ****************************************************************/
> > +
> > +/* A merged table is implements seeking/iterating over a stack of tabl=
es. */
> > +struct reftable_merged_table;
> > +
> > +/* A generic reftable; see below. */
> > +struct reftable_table;
>
> Why would we need to see an individual reftable?

It could be useful diagnostics and troubleshooting. For example, if
you are debugging or trying to troubleshoot/fsck a repo, it might be
interesting to read a single file from .git/reftable/

Philosophically, since we have to expose the functionality to write a
single table, it seems reasonable to read single tables for symmetry
as well.

> Could we just represent
> a merged table as a virtual concatenation of blocks (as if all the
> blocks were in the same file)?

No. The format doesn't work like that.

> > +/* reftable_new_merged_table creates a new merged table. It takes owne=
rship of
> > +   the stack array.
> > +*/
> > +int reftable_new_merged_table(struct reftable_merged_table **dest,
> > +                           struct reftable_table *stack, int n,
> > +                           uint32_t hash_id);
>
> I presume this would be used for things like compacting a few reftables
> together? In which case, I would expect this function to just take a
> list of filenames.

The merging of tables has nothing to do with the filesystem, and could
be done with reftables represented as in memory structure. This is
also how the unittests work.

> > +/* returns an iterator positioned just before 'name' */
> > +int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
> > +                                struct reftable_iterator *it,
> > +                                const char *name);
> > +
> > +/* returns an iterator for log entry, at given update_index */
> > +int reftable_merged_table_seek_log_at(struct reftable_merged_table *mt=
,
> > +                                   struct reftable_iterator *it,
> > +                                   const char *name, uint64_t update_i=
ndex);
> > +
> > +/* like reftable_merged_table_seek_log_at but look for the newest entr=
y. */
> > +int reftable_merged_table_seek_log(struct reftable_merged_table *mt,
> > +                                struct reftable_iterator *it,
> > +                                const char *name);
>
> Why do iterators need to be precisely positioned if this merged table is
> immutable?

I don't understand the question. How would you read a single ref from
a merged table without a seek function?

> > +/* convenience function to read a single ref. Returns < 0 for error, 0
> > +   for success, and 1 if ref not found. */
> > +int reftable_table_read_ref(struct reftable_table *tab, const char *na=
me,
> > +                         struct reftable_ref_record *ref);
>
> I presume this returns the most up-to-date record in the (possibly
> merged) table? So we can just read the hash off the record to know what
> this ref points to.

correct.

> > +/****************************************************************
> > + Mutable ref database
> > +
> > + The stack presents an interface to a mutable sequence of reftables.
> > + ****************************************************************/
>
> So I would expect ref mutations to be done by opening the existing
> reftables as a merged table, open a reftable writer, write all the
> changes that need to be written, and update the tables.list file...

Roughly, yes, but there are other considerations: you have to check
for concurrent updates (by the time you finish reading tables.list, a
compaction may have deleted some of the tables referenced, so you have
to retry). If there are any failures, the transaction fails and you
have to clean up already written tables. If the write succeeds, but
the stack becomes unbalanced, you have to do a compaction. If you have
to reload data, you want to avoid closing and opening the same file.

If you are curious what the stack does, have a look at stack.c.

Also, this is for separation of logic. The merged table is composed of
reftables that have no particular type of storage, but support the
read interface. The stack is what ties the merged table to a
posix-like file system, and provides mutations.

> > +/* holds a transaction to add tables at the top of a stack. */
> > +struct reftable_addition;
> > +
> > +/*
> > +  returns a new transaction to add reftables to the given stack. As a =
side
> > +  effect, the ref database is locked.
> > +*/
> > +int reftable_stack_new_addition(struct reftable_addition **dest,
> > +                             struct reftable_stack *st);
> > +
> > +/* Adds a reftable to transaction. */
> > +int reftable_addition_add(struct reftable_addition *add,
> > +                       int (*write_table)(struct reftable_writer *wr,
> > +                                          void *arg),
> > +                       void *arg);
> > +
> > +/* Commits the transaction, releasing the lock. */
> > +int reftable_addition_commit(struct reftable_addition *add);
> > +
> > +/* Release all non-committed data from the transaction, and deallocate=
 the
> > +   transaction. Releases the lock if held. */
> > +void reftable_addition_destroy(struct reftable_addition *add);
>
> We do need a transaction to write the new tables.list and then
> atomically update the repository with it, but I don't think we need one
> just to add a reftable to the stack.

see above.

> > +/* compacts all reftables into a giant table. Expire reflog entries if=
 config is
> > + * non-NULL */
> > +int reftable_stack_compact_all(struct reftable_stack *st,
> > +                            struct reftable_log_expiry_config *config)=
;
>
> Ah, the stack is used for compacting as well. I don't think compacting
> belongs here though - it should be its own thing that can make use of
> the merged-table reader and the single-table writer.

Why should it be like that, and where should compaction live?

> Some things that I think are missing:
>
>  - foreach all latest record of all refs (in any order) (I see some

Ref records are keyed by name, so the iteration produces each ref only once=
.

>    functions above that can set the position of the iterator, but I
>    don't think that the iterator skips over irrelevant refs?

What makes you think that?

> So we can't
>    use it for iterating over all refs if we don't care about the history
>    of refs)

I think you might be confusing the refs with reflogs here. The history
of a ref is kept in the reflog. This is why functions that want to
seek to a log record need an update_index timestamp.

>  - foreach all log entries of one ref (or all refs)

Before reviewing the API header here, I think it might be useful to
also look at the commit in the other series that uses the API to
implement the git ref backend. It shows how the foreach functions can
be implemented using the iterator interface.

> In summary, I would have expected a mechanism to read multiple (possibly
> one) reftable and perform queries on it, a mechanism to write a single
> reftable, and some functions to update tables.list.

I understand your expectation, but I think that expectation glosses
over important details of how it actually works.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
