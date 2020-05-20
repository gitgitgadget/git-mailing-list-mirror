Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30ABC433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 16:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96BE720759
	for <git@archiver.kernel.org>; Wed, 20 May 2020 16:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INvWiXfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETQHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 12:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETQHG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 12:07:06 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C82C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 09:07:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m185so3474697wme.3
        for <git@vger.kernel.org>; Wed, 20 May 2020 09:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p/cEYDc/v8hG6SJLbS39YwhPHiMoGOBlc5kEihiXdJg=;
        b=INvWiXfqFsb3C0N0p3DXyAN64qgE7VjZ+6eTfWYUGqu8QfCRVrmHSaxdP0Z9damAqF
         kFFZrGCqldPUdlMrqU/VdW+yhIWBfiGOOMLgffYI9OHBZsl22Xgd+m/w+XvFRVYlhp5M
         zSxCPZLeh9amwlsc2gZyFAUN63PAwUBnFOtNHnnb/wQ+8uOTV7qpTycq4LEUxJqP82wP
         ZhnJsiTxxL0kXhZECwX6Lwi8VTHhzZFIYJSM4g8P8/wrFlrj5/gIrpIZY9akv+sTZFHI
         4vKrYuah8QGLZTHX31pBmi8fH+lGavhTjGbgN7NuWyoVEWbvTsBuf1pHPYluk+qYAw+Q
         AmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p/cEYDc/v8hG6SJLbS39YwhPHiMoGOBlc5kEihiXdJg=;
        b=iE9uGh9DCg/JaFfeE8AY+gvulxx+9vLr35C7uXY2nYX1vyFLZRf7JBLADDotwAAc2a
         qmVNxOCChyweNMTpoClgqERYbyqqSE6EQNmtZfqcfEqGO7NV+gLfosECMjEOb2GiqhlZ
         eP91bpJNn6yRr6nRH9KaWOTnYHeNB76kPhhESVS9Atk3YvTQvISUzodfZpDTwF08eX00
         SGFmz5R6G254pEUAlaiVkoVXL2yHYX2tR3eToW78n9iS6nbwRFs7k+pyQYdSo3320tzO
         wmhzlVCh6eLcywVWYKIlf7xRfSotC0rAy8ZBVr+x9Zuhum31rwaWPOtafCYzWlOYP+cj
         UZuA==
X-Gm-Message-State: AOAM531fLx4ikFmuO9HWCnE0n0M+tlce0mNXfzGYXz6EpogKqb9qglrO
        dziyVxpg5BejGcnKXMAQIil8ub9gkfZtZbDKTXWp9Q==
X-Google-Smtp-Source: ABdhPJy16pRw2C3xH+dksy2KubCWF2p5zW1K/6TqHLLvKMN49VAUIJtiCsbokjS7JTbl9k14l6JyjCJd2HChaQ1DdAs=
X-Received: by 2002:a7b:c1c1:: with SMTP id a1mr5172018wmj.122.1589990821509;
 Wed, 20 May 2020 09:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
 <pull.539.v13.git.1589226388.gitgitgadget@gmail.com> <96fd9814a6753e87fb99c6f9d55a0728d3dba6cb.1589226388.git.gitgitgadget@gmail.com>
 <xmqqeerfzitt.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeerfzitt.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 20 May 2020 18:06:49 +0200
Message-ID: <CAFQ2z_OazuU32Nm3geLCbu_R2u_JKTqCXX0NF35C0=9xV7Ow0g@mail.gmail.com>
Subject: Re: [PATCH v13 04/13] reftable: file format documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 20, 2020 at 12:00 AM Junio C Hamano <gitster@pobox.com> wrote:
> > Some repositories contain a lot of references (e.g. android at 866k,
> > rails at 31k). The reftable format provides:
> >
> > - Near constant time lookup for any single reference, even when the
> >   repository is cold and not in process or kernel cache.
> > - Near constant time verification a SHA-1 is referred to by at least
> >   one reference (for allow-tip-sha1-in-want).
>
> Not quite grammatical sentence?  Perhaps "if" after "verification?

Done.

> > - Efficient lookup of an entire namespace, such as `refs/tags/`.
> > - Support atomic push `O(size_of_update)` operations.
> > - Combine reflog storage with ref storage.
> >
> > This file format spec was originally written in July, 2017 by Shawn
> > Pearce.  Some refinements since then were made by Shawn and by Han-Wen
> > Nienhuys based on experiences implementing and experimenting with the
> > format.  (All of this was in the context of our work at Google and
> > Google is happy to contribute the result to the Git project.)
> >
> > Imported from JGit[1]'s current version (c217d33ff,
> > "Documentation/technical/reftable: improve repo layout", 2020-02-04)
> > of Documentation/technical/reftable.md and converted to asciidoc by
> > running
> >
> >   pandoc -t asciidoc -f markdown reftable.md >reftable.txt
> >
> > using pandoc 2.2.1.  The result required the following additional
> > minor changes:
> >
> > - removed the [TOC] directive to add a table of contents, since
> >   asciidoc does not support it
> > - replaced git-scm.com/docs links with linkgit: directives that link
> >   to other pages within Git's documentation
>
> There are many
>
>         =E2=80=99

fixed.

> Typoes pointed out below may probably be from the original where
> they should be corrected.

fixed.
> Let's not use &nbsp; here after "e.g.".  I see a normal space after "e.g.=
"
> a few lines below.

fixed.

> > +rails at 31k). The existing packed-refs format takes up a lot of space
> > +(e.g. 62M), and does not scale with additional references. Lookup of a
> > +single reference requires linearly scanning the file.
> > +
> > +Atomic pushes modifying multiple references require copying the entire
> > +packed-refs file, which can be a considerable amount of data moved
> > +(e.g. 62M in, 62M out) for even small transactions (2 refs modified).

(*)

> > +Repositories with many loose references occupy a large number of disk
> > +blocks from the local file system, as each reference is its own file
> > +storing 41 bytes (and another file for the corresponding reflog). This
> > +negatively affects the number of inodes available when a large number =
of
> > +repositories are stored on the same filesystem. Readers can be penaliz=
ed
> > +due to the larger number of syscalls required to traverse and read the
> > +`$GIT_DIR/refs` directory.
>
> Another downside is that we cannot arrange atomic updates to
> multiple refs over loose refs, even though the "lookup of a single
> reference does not require linear scan" unlike packed-refs, (as long
> as the filesystem does its job).  Worth mentioning?

that's already there at (*), no?

> > +* Near constant time lookup for any single reference, even when the
> > +repository is cold and not in process or kernel cache.
> > +* Near constant time verification if a SHA-1 is referred to by at leas=
t
> > +one reference (for allow-tip-sha1-in-want).
> > +* Efficient lookup of an entire namespace, such as `refs/tags/`.
>
> Does this "lookup" refer to "do we have anything in refs/tags/
> hierarchy?" or "enumerate all refs under refs/tags/ hierarchy?"
>
> If the latter, perhaps s/lookup of/iteration over/

changed to "efficient enumeration".

> > +Peeling
> > +^^^^^^^
> > +
> > +References stored in a reftable are peeled, a record for an annotated
> > +(or signed) tag records both the tag object, and the object it refers
> > +to.
>
> OK.  Peeled results are recorded in packed-refs file because quite
> often when we use a tag object, what we actually want to access is
> the commit object it points at.  We do so here for the same reason?

I think so. Added a reference to packed-refs

> > +Directory/file conflicts
> > +^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +The reftable format accepts both `refs/heads/foo` and
> > +`refs/heads/foo/bar` as distinct references.
> > +
> > +This property is useful for retaining log records in reftable, but may
> > +confuse versions of Git using `$GIT_DIR/refs` directory tree to mainta=
in
> > +references. Users of reftable may choose to continue to reject `foo` a=
nd
> > +`foo/bar` type conflicts to prevent problems for peers.
>
> Here "users" refer to things like "git-core", "jgit", "libgit2", etc.?
>
> Let's say we have these two "conflicting" branches and want to
> interoperate with existing versions of Git (e.g. a "git ls-remote"
> client requests us to show what we have).  We could either show
> "refs/heads/foo" with its object name, or "refs/heads/foo/bar" with
> its object name, but not both.
>
> "users ... may choose" implies that it is up to the implementation
> of reftable user which one to show, so given a single repository,
> "jgit" may show "refs/heads/foo" while "libgit2" may choose to show
> the other one.
>
> I am not sure if that is desirable---I suspect that we want to
> record which one needs to be chosen so that these "D/F conflicts
> disallowing" users can make consistent choices, but I dunno.

I think it's beyond the scope of the document. In reftable the
library, I added an option to validate for file/dir conflicts.

(Google's deployment doesn't do the validation completely correctly.
We had a ref ending in '/' for example.)

>
> > +Block size
> > +^^^^^^^^^^
> > +
> > +The file=E2=80=99s block size is arbitrarily determined by the writer,=
 and does
> > +not have to be a power of 2. The block size must be larger than the
> > +longest reference name or log entry used in the repository, as
> > +references cannot span blocks.
> > +
> > +Powers of two that are friendly to the virtual memory system or
> > +filesystem (such as 4k or 8k) are recommended. Larger sizes (64k) can
> > +yield better compression, with a possible increased cost incurred by
> > +readers during access.
> > +
> > +The largest block size is `16777215` bytes (15.99 MiB).
>
> The number being "(2**24) - 1" might be as significant as "15.99
> MiB" to readers.  As we recommend, and the users would find it
> natural, to use powers of two, the largest block size in practice
> would be 8 MiB?

Beyond 4096 bytes (size of a page on x86), I don't think there is a
need for powers of two. What makes for a good block size would also be
decided by the characteristics of the underlying storage system. At
google, we use 64k, IIRC.


> > +Ref block format
> > +^^^^^^^^^^^^^^^^
> > +
> > +A ref block is written as:
> > +
> > +....
> > +'r'
> > +uint24( block_len )
> > +ref_record+
> > +uint24( restart_offset )+
> > +uint16( restart_count )
> > +
> > +padding?
> > +....
> > +
> > +Blocks begin with `block_type =3D 'r'` and a 3-byte `block_len` which
> > +encodes the number of bytes in the block up to, but not including the
> > +optional `padding`. This is always less than or equal to the file=E2=
=80=99s
> > +block size. In the first ref block, `block_len` includes 24 bytes for
> > +the file header.
> > +
> > +The 2-byte `restart_count` stores the number of entries in the
> > +`restart_offset` list, which must not be empty. Readers can use
> > +`restart_count` to binary search between restarts before starting a
> > +linear scan.
> > +
> > +Exactly `restart_count` 3-byte `restart_offset` values precedes the
> > +`restart_count`. Offsets are relative to the start of the block and
> > +refer to the first byte of any `ref_record` whose name has not been
> > +prefix compressed. Entries in the `restart_offset` list must be sorted=
,
> > +ascending. Readers can start linear scans from any of these records.
>
> So the algorithm to find a record in a single block would be
>
>  - see how big the block_len is by reading the first four bytes;
>
>  - look at the last 16-bit word to see how many restart_offset
>    entries there are;
>
>  - bisect using restart_offset array to see where to start a linear
>    scan in the ref_record array
>
>  - linear scan the range between two adjacent offsets in
>    restart_offset array.

yes, that works. In practice, you find the last restart before the
key, and then iterate until you find a key that is >=3D the wanted key.
There is no real need to find the next restart.

> The document clarifies that the chosen variant of varint
> representation much later, but it may want to be moved up close to
> where "we use network byte order" etc. are declared.

moved.

> > +Recovering a reference name from any `ref_record` is a simple concat:
> > +
> > +....
> > +this_name =3D prior_name[0..prefix_length] + suffix
> > +....
> > +
> > +The `suffix_length` value provides the number of bytes available in
> > +`suffix` to copy from `suffix` to complete the reference name.
>
> It is interesting that suffix is *not* a simple NUL terminated
> string.  This DOES allow a NUL byte in a refname, but because we
> upfront declared that only the refnames allowed are the ones that
> pass check-ref-format, that would not be an advantage the use of
> varint to encode the suffix seeks.  Then what is it?

reflog records encode update_index in the key, which may lead to keys
with zero bytes. So you can't rely on zero termination.

> I guess the answer is that a lot of time, the suffix length is
> shorter than 16 bytes (=3D 128/8), so we can store 3-bit value_type
> for free in such a case.  Is that worth a mention?

Here, and in other places, I would like to avoid annotating rationales
in detail.  First of all, this was Shawn's spec; if I go and rewrite
whole sections, the authorship becomes muddled. Second, a lot of the
"why" will invite questions how to do it differently to achieve the
same objectives (see below, where you muse about '<' and '>'), and
that's a past station given that it's in JGit. Finally, all these
edits cause extra work with conflict resolution in follow-up changes
in the series. If we want to editorialize more, I'd rather do it in a
follow up series.


> > +The `update_index` that last modified the reference can be obtained by
> > +adding `update_index_delta` to the `min_update_index` from the file
> > +header: `min_update_index + update_index_delta`.
>
> At this point, we can infer the following from we have learned so
> far by reading the document:
>
>  - there is a quantity called "update index" attached to each ref
>    record;
>
>  - each file knows the range of update indices used in it; and
>
>
> But we haven't learned at all what "update index" is and how it is
> used, which makes it a frustrating read.  We probably should give a
> mention of what it is here (a brief description at the same level of
> detail as say "monotonically increasing counter that is used as a
> transaction id when any ref update is made"), even though we will go
> into much deeper details in a later section.

I think update_index is poorly named. I think it's supposed to be the
index into an ordered array of updates.

A better name would be 'logical timestamp'. It is a timestamp, because
we use it to determine which update came first, but it is 'logical'
because it can't depend on actual clocks, because of synchronization
problems.  Inside Google, I think we use microsecond Spanner
timestamps of the database transaction on the global ref database.

In a local setting, it's good enough to use a sequential number, which
is determined by incrementing the last update_index.

>  - when files are chained together, the range of update indices do
>    not overlap---all indices in one file are strictly larger or
>    smaller than those in another file.

That's what I thought initially too , but it is a dangerous
assumption. See reftable/merged.c,  merged_iter_next_entry() for a
comment.

At Google, in the datacenter deployment, update indices of different
reftable can overlap. This can happen when compaction and replication
delay interact.

> We probably should write these as "one (binary) object name", and
> "two (binary) object names", without hardwiring the number of bytes
> needed to represent an object name.

This is addressed in the follow-up change for SHA256. Let's leave this alon=
e.

> > +Symbolic references use `0x3`, followed by the complete name of the
> > +reference target. No compression is applied to the target name.
>
> Is there a place in the file format where an incomplete name can be
> stored?  If not, I think it makes it easier to read if we drop
> "complete" from the sentence.

All of the keys prefix compressed, so most refnames are incomplete.

> > +Types `0x4..0x7` are reserved for future use.
> > +
> > +Ref index
> > +^^^^^^^^^
> > +
> > +The ref index stores the name of the last reference from every ref blo=
ck
> > +in the file, enabling reduced disk seeks for lookups. Any reference ca=
n
> > +be found by searching the index, identifying the containing block, and
> > +searching within that block.
> > +
> > +The index may be organized into a multi-level index, where the 1st lev=
el
> > +index block points to additional ref index blocks (2nd level), which m=
ay
> > +in turn point to either additional index blocks (e.g. 3rd level) or re=
f
> > +blocks (leaf level). Disk reads required to access a ref go up with
> > +higher index levels. Multi-level indexes may be required to ensure no
> > +single index block exceeds the file format=E2=80=99s max block size of
> > +`16777215` bytes (15.99 MiB). To acheive constant O(1) disk seeks for
>
> achieve
>
> > +lookups the index must be a single level, which is permitted to exceed
> > +the file=E2=80=99s configured block size, but not the format=E2=80=99s=
 max block size of
> > +15.99 MiB.
>
>
> > +Obj block format
> > +^^^^^^^^^^^^^^^^
> > +
> > +Object blocks are optional. Writers may choose to omit object blocks,
> > +especially if readers will not use the SHA-1 to ref mapping.
>
> "the object name to ref mapping".
>
> > +Object blocks use unique, abbreviated 2-20 byte SHA-1 keys, mapping to
>
> Likewise.  "unique prefix of object names no less than 2 bytes" or
> somesuch to futureproof "2-20 byte SHA-1".
>
> > +ref blocks containing references pointing to that object directly, or =
as
> > +the peeled value of an annotated tag. Like ref blocks, object blocks u=
se
> > +the file=E2=80=99s standard block size. The abbrevation length is avai=
lable in
>
> abbreviation
>
> > +the footer as `obj_id_len`.
> > +
> > +To save space in small files, object blocks may be omitted if the ref
> > +index is not present, as brute force search will only need to read a f=
ew
> > +ref blocks. When missing, readers should brute force a linear search o=
f
> > +all references to lookup by SHA-1.
> > +
> > +An object block is written as:
> > +
> > +....
> > +'o'
> > +uint24( block_len )
> > +obj_record+
> > +uint24( restart_offset )+
> > +uint16( restart_count )
> > +
> > +padding?
> > +....
> > +
> > +Fields are identical to ref block. Binary search using the restart tab=
le
> > +works the same as in reference blocks.
> > +
> > +Because object identifiers are abbreviated by writers to the shortest
> > +unique abbreviation within the reftable, obj key lengths are variable
> > +between 2 and 20 bytes. Readers must compare only for common prefix
>
> Futureproof "2 and 20" similarly.
>
> > +match within an obj block or obj index.
>
> > +Log block format
> > +^^^^^^^^^^^^^^^^
> > +
> > +Unlike ref and obj blocks, log blocks are always unaligned.
> > +
> > +Log blocks are variable in size, and do not match the `block_size`
> > +specified in the file header or footer. Writers should choose an
> > +appropriate buffer size to prepare a log block for deflation, such as
> > +`2 * block_size`.
>
> I can guess the reason behind this design decision, but the readers
> may not be able to.  Should we write it down here, or would it make
> too much irrelevant details?

I honestly don't know about the reason. reflogs will compress well
(because there is lots of ascii text), but it makes the format
needlessly complex IMO. But it's there, so we can't do much about it
now.

> > +A log block is written as:
> > +
> > +....
> > +'g'
> > +uint24( block_len )
> > +zlib_deflate {
> > +  log_record+
> > +  uint24( restart_offset )+
> > +  uint16( restart_count )
> > +}
> > +....
> > +
> > +Log blocks look similar to ref blocks, except `block_type =3D 'g'`.
> > +
> > +The 4-byte block header is followed by the deflated block contents usi=
ng
> > +zlib deflate. The `block_len` in the header is the inflated size
> > +(including 4-byte block header), and should be used by readers to
> > +preallocate the inflation output buffer. A log block=E2=80=99s `block_=
len` may
> > +exceed the file=E2=80=99s block size.
> > +
> > +Offsets within the log block (e.g. `restart_offset`) still include the
> > +4-byte header. Readers may prefer prefixing the inflation output buffe=
r
> > +with the 4-byte header.
> > +
> > +Within the deflate container, a variable number of `log_record` descri=
be
> > +reference changes. The log record format is described below. See ref
> > +block format (above) for a description of `restart_offset` and
> > +`restart_count`.
> > +
> > +Because log blocks have no alignment or padding between blocks, reader=
s
> > +must keep track of the bytes consumed by the inflater to know where th=
e
> > +next log block begins.
> > +
> > +log record
> > +++++++++++
> > +
> > +Log record keys are structured as:
> > +
> > +....
> > +ref_name '\0' reverse_int64( update_index )
> > +....
> > +
> > +where `update_index` is the unique transaction identifier. The
> > +`update_index` field must be unique within the scope of a `ref_name`.
> > +See the update transactions section below for further details.
> > +
> > +The `reverse_int64` function inverses the value so lexographical
>
> lexicographical
>
> > +ordering the network byte order encoding sorts the more recent records
> > +with higher `update_index` values first:
> > +
> > +....
> > +reverse_int64(int64 t) {
> > +  return 0xffffffffffffffff - t;
> > +}
> > +....
>
> Rationale?  It may be to ease the iteration over reflog i.e. "log
> -g" that wants to go from the youngest to older---isn't it worth
> mentioning?
>
> > +Log records have a similar starting structure to ref and index records=
,
> > +utilizing the same prefix compression scheme applied to the log record
> > +key described above.
> > +
> > +....
> > +    varint( prefix_length )
> > +    varint( (suffix_length << 3) | log_type )
> > +    suffix
> > +    log_data {
> > +      old_id
> > +      new_id
> > +      varint( name_length    )  name
> > +      varint( email_length   )  email
> > +      varint( time_seconds )
> > +      sint16( tz_offset )
> > +      varint( message_length )  message
> > +    }?
> > +....
> > +
> > +Log record entries use `log_type` to indicate what follows:
> > +
> > +* `0x0`: deletion; no log data.
> > +* `0x1`: standard git reflog data using `log_data` above.
> > +
> > +The `log_type =3D 0x0` is mostly useful for `git stash drop`, removing=
 an
> > +entry from the reflog of `refs/stash` in a transaction file (below),
> > +without needing to rewrite larger files. Readers reading a stack of
> > +reflogs must treat this as a deletion.
> > +
> > +For `log_type =3D 0x1`, the `log_data` section follows
> > +linkgit:git-update-ref[1] logging and includes:
> > +
> > +* two 20-byte SHA-1s (old id, new id)
>
> "two (binary) object names (old name, new name)" for futureproof out
> of SHA-1 world.
>
> > +* varint string of committer=E2=80=99s name
> > +* varint string of committer=E2=80=99s email
> > +* varint time in seconds since epoch (Jan 1, 1970)
> > +* 2-byte timezone offset in minutes (signed)
>
> We use minus eight hundred for "GMT-0800" internally, but this would
> use -480, which makes more sense ;-)
>
> > +* varint string of message
> > +
> > +`tz_offset` is the absolute number of minutes from GMT the committer w=
as
> > +at the time of the update. For example `GMT-0800` is encoded in reftab=
le
> > +as `sint16(-480)` and `GMT+0230` is `sint16(150)`.
> > +
> > +The committer email does not contain `<` or `>`, it=E2=80=99s the valu=
e normally
> > +found between the `<>` in a git commit object header.
>
> Saving two precious bytes?

If you store reflogs in ascii files, both for convention, and  to
separate the name from the email. Internally, it's much more
convenient to not have the '<' '>'. For any practical application of
the email address (Say, you want to send out an email to the user),
you'll need to strip off the < >

> This is a tangent but in a repository at hosting provider, whose
> primary (and often the only) source of updates are by end-user
> pushing into it, if reflogs are enabled, whose name and email are
> recorded in the logs?  The committer or tagger of the object that
> sits at the tip of the ref after the update?  What happens when a
> blob is pushed to update a ref?  Or would it be just a single "user"
> that represents the "server operator"?

That's up to the caller to decide. I think JGit uses the committer
identity, but I'd have to check.

> We know in a non-bare repository an individual contributor works on
> typically records only one <name, email> in the reflog: the user who
> works in it.
>
> What I am trying to get at is if it makes more sense to have a small
> table of unique <name, email> pairs used in the file and have
> log_data record a single varint that is the index into that
> "committer ident" table.  I would suspect that it would give us
> significantly more gain than mere <> two bytes per log_data entry.

gain in what dimension? Space-wise, the zlib compression will remove
all slack anyway.

> > +The `message_length` may be 0, in which case there was no message
> > +supplied for the update.
> > +
> > +Contrary to traditional reflog (which is a file), renames are encoded =
as
> > +a combination of ref deletion and ref creation.
>
> Yay?  How does the deletion record look like?  The new object name
> being 0*hashlength?  I didn't see it defined in the description (and
> I am guessing that log_type of 0x0 is *NOT* used for that purpose).

quoting the spec:

"Log record entries use `log_type` to indicate what follows:

* `0x0`: deletion; no log data."

> So, NEEDSWORK: describe how "creation of a ref" and "deletion of a ref"
> appears in a log as a log record entry.

the creation would be the appearance of a reflog record for the ref.
You'd have to search back in time to decide if a reflog record it was
an update to an existing record or a creation.

> > +....
>
> As already said, I think this should be given upfront next to where
> we declare that we use network byte order.

I moved this

--
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
