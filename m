Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D5751F404
	for <e@80x24.org>; Sat, 15 Sep 2018 10:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeIOPV2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 11:21:28 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43821 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbeIOPV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 11:21:28 -0400
Received: by mail-io1-f65.google.com with SMTP id y10-v6so7909769ioa.10
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 03:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1QOf8G9nMxrJPJYzzHphMIVkdeMawBkCaccwkJjc4C8=;
        b=mF85xkCMUzTKeT89B1HpfB4hqR7nMh57p0Qf6IxPG9hWZZ7k7kVksjVZW7Q6Ygdc2P
         PQ78ub6vWl2Gv2JLhhEa30VcIQF2MHvyK8m81+BHIp9FcrHAUT1lJjNx5e4ntO/xD4X/
         GUOHA89G74Q7qt4v7IOQ1YgXINdxph+tUwB5nx5IUN8iMZLpticJMLCNb9k1wFiH5u3d
         QMjwraCgod4onRn8r1mOge62Nxb9gwaqpPX7AGP6asDggXIH0RlRGEEE1FTt47b+UEVi
         VPBOwjwtuXc4WGdSy9m8sXMlD7aKrcpIQZv+ENvcsyMRJIlYyv3hX5/eaH18WXDpl7uc
         LqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1QOf8G9nMxrJPJYzzHphMIVkdeMawBkCaccwkJjc4C8=;
        b=lF4AZ+LoVfzvyK7IXePzLCNuJUd+4/l3Hd1/yKXTD/MPpOl7hnFFQXrBDmA5k1Z0q3
         yczT18j5JY3EYZ2UHVcHDhYze+zmtDTJXr1eVW2Q5wXAxb47u/CeITL6V3HO1x1xYseI
         gZYVsLND1znt4NVkgv+Ym8RxZDefRi1GZa3n1EoGAUqUFq9q6jDGR1gTqTKmxgRy7xLX
         wdkkVR6yX+sq+j6U0GFQ2twLBo6gC0YHcNIduEzxTOACzyukQoSoJMUUJQnoxjTJIr6A
         lACkA4OfvspD8U61mCMW531j/ZDS1wK2YmY5X5WFViwmj5ttoooCwQ8pXCbPkYzJRluO
         XXbQ==
X-Gm-Message-State: APzg51CuVxDFRR+wf6a3QHywUV8+ff94rBoTrPmu4qXuD6lat4ts0gNj
        m9ePEGaemMHBO6gm7/11gsqUNcwQbGwR4wc1Zro=
X-Google-Smtp-Source: ANB0VdYv1z+rzBMHFj6+xhQ4+15fMZuCjqLQd1gQl9uudM/GPqWVviP9ehG6SPi7wH8H8edoZBy3slWPAFsZ6fwxbHE=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr12596670ioe.282.1537005782413;
 Sat, 15 Sep 2018 03:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180912161832.55324-1-benpeart@microsoft.com> <20180912161832.55324-2-benpeart@microsoft.com>
In-Reply-To: <20180912161832.55324-2-benpeart@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 15 Sep 2018 12:02:35 +0200
Message-ID: <CACsJy8B51s2j0aR69UdwtpSbRN6qdLy--am_tyP5Xqo=5Zm_7g@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] eoie: add End of Index Entry (EOIE) extension
To:     Ben Peart <benpeart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 12, 2018 at 6:18 PM Ben Peart <benpeart@microsoft.com> wrote:
>
> The End of Index Entry (EOIE) is used to locate the end of the variable
> length index entries and the beginning of the extensions. Code can take
> advantage of this to quickly locate the index extensions without having
> to parse through all of the index entries.
>
> Because it must be able to be loaded before the variable length cache
> entries and other index extensions, this extension must be written last.
> The signature for this extension is { 'E', 'O', 'I', 'E' }.
>
> The extension consists of:
>
> - 32-bit offset to the end of the index entries
>
> - 160-bit SHA-1 over the extension types and their sizes (but not
> their contents).  E.g. if we have "TREE" extension that is N-bytes
> long, "REUC" extension that is M-bytes long, followed by "EOIE",
> then the hash would be:
>
> SHA-1("TREE" + <binary representation of N> +
>         "REUC" + <binary representation of M>)
>
> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
> ---
>  Documentation/technical/index-format.txt |  23 ++++
>  read-cache.c                             | 154 +++++++++++++++++++++--
>  t/README                                 |   5 +
>  t/t1700-split-index.sh                   |   1 +
>  4 files changed, 175 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
> index db3572626b..6bc2d90f7f 100644
> --- a/Documentation/technical/index-format.txt
> +++ b/Documentation/technical/index-format.txt
> @@ -314,3 +314,26 @@ The remaining data of each directory block is grouped by type:
>
>    - An ewah bitmap, the n-th bit indicates whether the n-th index entry
>      is not CE_FSMONITOR_VALID.
> +
> +== End of Index Entry
> +
> +  The End of Index Entry (EOIE) is used to locate the end of the variable
> +  length index entries and the begining of the extensions. Code can take
> +  advantage of this to quickly locate the index extensions without having
> +  to parse through all of the index entries.
> +
> +  Because it must be able to be loaded before the variable length cache
> +  entries and other index extensions, this extension must be written last.
> +  The signature for this extension is { 'E', 'O', 'I', 'E' }.
> +
> +  The extension consists of:
> +
> +  - 32-bit offset to the end of the index entries
> +
> +  - 160-bit SHA-1 over the extension types and their sizes (but not
> +       their contents).  E.g. if we have "TREE" extension that is N-bytes
> +       long, "REUC" extension that is M-bytes long, followed by "EOIE",
> +       then the hash would be:
> +
> +       SHA-1("TREE" + <binary representation of N> +
> +               "REUC" + <binary representation of M>)
> diff --git a/read-cache.c b/read-cache.c
> index 7b1354d759..858935f123 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -43,6 +43,7 @@
>  #define CACHE_EXT_LINK 0x6c696e6b        /* "link" */
>  #define CACHE_EXT_UNTRACKED 0x554E5452   /* "UNTR" */
>  #define CACHE_EXT_FSMONITOR 0x46534D4E   /* "FSMN" */
> +#define CACHE_EXT_ENDOFINDEXENTRIES 0x454F4945 /* "EOIE" */
>
>  /* changes that can be kept in $GIT_DIR/index (basically all extensions) */
>  #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
> @@ -1693,6 +1694,9 @@ static int read_index_extension(struct index_state *istate,
>         case CACHE_EXT_FSMONITOR:
>                 read_fsmonitor_extension(istate, data, sz);
>                 break;
> +       case CACHE_EXT_ENDOFINDEXENTRIES:
> +               /* already handled in do_read_index() */
> +               break;

Perhaps catch this extension when it's not written at the end (e.g. by
some other git implementation) and warn.

>         default:
>                 if (*ext < 'A' || 'Z' < *ext)
>                         return error("index uses %.4s extension, which we do not understand",
> @@ -1889,6 +1893,11 @@ static size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
>         return ondisk_size + entries * per_entry;
>  }
>
> +#ifndef NO_PTHREADS
> +static unsigned long read_eoie_extension(void *mmap_, size_t mmap_size);
> +#endif

Keep functions unconditionally built as much as possible. I don't see
why this read_eoie_extension() must be built only on multithread
platforms.

> +static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, unsigned long offset);
> +
>  /* remember to discard_cache() before reading a different cache! */
>  int do_read_index(struct index_state *istate, const char *path, int must_exist)
>  {
> @@ -2198,11 +2207,15 @@ static int ce_write(git_hash_ctx *context, int fd, void *data, unsigned int len)
>         return 0;
>  }
>
> -static int write_index_ext_header(git_hash_ctx *context, int fd,
> -                                 unsigned int ext, unsigned int sz)
> +static int write_index_ext_header(git_hash_ctx *context, git_hash_ctx *eoie_context,
> +                                 int fd, unsigned int ext, unsigned int sz)
>  {
>         ext = htonl(ext);
>         sz = htonl(sz);
> +       if (eoie_context) {
> +               the_hash_algo->update_fn(eoie_context, &ext, 4);
> +               the_hash_algo->update_fn(eoie_context, &sz, 4);
> +       }
>         return ((ce_write(context, fd, &ext, 4) < 0) ||
>                 (ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
>  }
> @@ -2445,7 +2458,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>  {
>         uint64_t start = getnanotime();
>         int newfd = tempfile->fd;
> -       git_hash_ctx c;
> +       git_hash_ctx c, eoie_c;
>         struct cache_header hdr;
>         int i, err = 0, removed, extended, hdr_version;
>         struct cache_entry **cache = istate->cache;
> @@ -2454,6 +2467,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>         struct ondisk_cache_entry_extended ondisk;
>         struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
>         int drop_cache_tree = istate->drop_cache_tree;
> +       unsigned long offset;
>
>         for (i = removed = extended = 0; i < entries; i++) {
>                 if (cache[i]->ce_flags & CE_REMOVE)
> @@ -2520,11 +2534,13 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>                 return err;
>
>         /* Write extension data here */
> +       offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
> +       the_hash_algo->init_fn(&eoie_c);

Don't write (or even calculate to write it) unless it's needed. Which
means only do this when parallel reading is enabled and the index size
large enough, or when a test variable is set so you can force writing
this extension.

I briefly wondered if we should continue writing the extension if it's
already written. This way you can manually enable it with "git
update-index". But I don't think it's worth the complexity.

>         if (!strip_extensions && istate->split_index) {
>                 struct strbuf sb = STRBUF_INIT;
>
>                 err = write_link_extension(&sb, istate) < 0 ||
> -                       write_index_ext_header(&c, newfd, CACHE_EXT_LINK,
> +                       write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_LINK,
>                                                sb.len) < 0 ||
>                         ce_write(&c, newfd, sb.buf, sb.len) < 0;
>                 strbuf_release(&sb);
> @@ -2535,7 +2551,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>                 struct strbuf sb = STRBUF_INIT;
>
>                 cache_tree_write(&sb, istate->cache_tree);
> -               err = write_index_ext_header(&c, newfd, CACHE_EXT_TREE, sb.len) < 0
> +               err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_TREE, sb.len) < 0
>                         || ce_write(&c, newfd, sb.buf, sb.len) < 0;
>                 strbuf_release(&sb);
>                 if (err)
> @@ -2545,7 +2561,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>                 struct strbuf sb = STRBUF_INIT;
>
>                 resolve_undo_write(&sb, istate->resolve_undo);
> -               err = write_index_ext_header(&c, newfd, CACHE_EXT_RESOLVE_UNDO,
> +               err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_RESOLVE_UNDO,
>                                              sb.len) < 0
>                         || ce_write(&c, newfd, sb.buf, sb.len) < 0;
>                 strbuf_release(&sb);
> @@ -2556,7 +2572,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>                 struct strbuf sb = STRBUF_INIT;
>
>                 write_untracked_extension(&sb, istate->untracked);
> -               err = write_index_ext_header(&c, newfd, CACHE_EXT_UNTRACKED,
> +               err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_UNTRACKED,
>                                              sb.len) < 0 ||
>                         ce_write(&c, newfd, sb.buf, sb.len) < 0;
>                 strbuf_release(&sb);
> @@ -2567,7 +2583,23 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>                 struct strbuf sb = STRBUF_INIT;
>
>                 write_fsmonitor_extension(&sb, istate);
> -               err = write_index_ext_header(&c, newfd, CACHE_EXT_FSMONITOR, sb.len) < 0
> +               err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_FSMONITOR, sb.len) < 0
> +                       || ce_write(&c, newfd, sb.buf, sb.len) < 0;
> +               strbuf_release(&sb);
> +               if (err)
> +                       return -1;
> +       }
> +
> +       /*
> +        * CACHE_EXT_ENDOFINDEXENTRIES must be written as the last entry before the SHA1
> +        * so that it can be found and processed before all the index entries are
> +        * read.
> +        */
> +       if (!strip_extensions && offset && !git_env_bool("GIT_TEST_DISABLE_EOIE", 0)) {
> +               struct strbuf sb = STRBUF_INIT;
> +
> +               write_eoie_extension(&sb, &eoie_c, offset);
> +               err = write_index_ext_header(&c, NULL, newfd, CACHE_EXT_ENDOFINDEXENTRIES, sb.len) < 0
>                         || ce_write(&c, newfd, sb.buf, sb.len) < 0;
>                 strbuf_release(&sb);
>                 if (err)
> @@ -2978,3 +3010,109 @@ int should_validate_cache_entries(void)
>
>         return validate_index_cache_entries;
>  }
> +
> +#define EOIE_SIZE (4 + GIT_SHA1_RAWSZ) /* <4-byte offset> + <20-byte hash> */
> +#define EOIE_SIZE_WITH_HEADER (4 + 4 + EOIE_SIZE) /* <4-byte signature> + <4-byte length> + EOIE_SIZE */
> +
> +#ifndef NO_PTHREADS
> +static unsigned long read_eoie_extension(void *mmap_, size_t mmap_size)
> +{
> +       /*
> +        * The end of index entries (EOIE) extension is guaranteed to be last
> +        * so that it can be found by scanning backwards from the EOF.
> +        *
> +        * "EOIE"
> +        * <4-byte length>
> +        * <4-byte offset>
> +        * <20-byte hash>
> +        */
> +       const char *mmap = mmap_;
> +       const char *index, *eoie;
> +       uint32_t extsize;
> +       unsigned long offset, src_offset;
> +       unsigned char hash[GIT_MAX_RAWSZ];
> +       git_hash_ctx c;
> +
> +       /* ensure we have an index big enough to contain an EOIE extension */
> +       if (mmap_size < sizeof(struct cache_header) + EOIE_SIZE_WITH_HEADER + the_hash_algo->rawsz)
> +               return 0;

All these "return 0" indicates an error in EOIE extension. You
probably want to print some warning (much easier to track down why
parallel reading does not happen).

> +
> +       /* validate the extension signature */
> +       index = eoie = mmap + mmap_size - EOIE_SIZE_WITH_HEADER - the_hash_algo->rawsz;
> +       if (CACHE_EXT(index) != CACHE_EXT_ENDOFINDEXENTRIES)
> +               return 0;
> +       index += sizeof(uint32_t);
> +
> +       /* validate the extension size */
> +       extsize = get_be32(index);
> +       if (extsize != EOIE_SIZE)
> +               return 0;
> +       index += sizeof(uint32_t);
> +
> +       /*
> +        * Validate the offset we're going to look for the first extension
> +        * signature is after the index header and before the eoie extension.
> +        */
> +       offset = get_be32(index);
> +       if (mmap + offset < mmap + sizeof(struct cache_header))
> +               return 0;
> +       if (mmap + offset >= eoie)
> +               return 0;
> +       index += sizeof(uint32_t);
> +
> +       /*
> +        * The hash is computed over extension types and their sizes (but not
> +        * their contents).  E.g. if we have "TREE" extension that is N-bytes
> +        * long, "REUC" extension that is M-bytes long, followed by "EOIE",
> +        * then the hash would be:
> +        *
> +        * SHA-1("TREE" + <binary representation of N> +
> +        *               "REUC" + <binary representation of M>)
> +        */
> +       src_offset = offset;
> +       the_hash_algo->init_fn(&c);
> +       while (src_offset < mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEADER) {
> +               /* After an array of active_nr index entries,
> +                * there can be arbitrary number of extended
> +                * sections, each of which is prefixed with
> +                * extension name (4-byte) and section length
> +                * in 4-byte network byte order.
> +                */
> +               uint32_t extsize;
> +               memcpy(&extsize, (char *)mmap + src_offset + 4, 4);
> +               extsize = ntohl(extsize);
> +
> +               /* verify the extension size isn't so large it will wrap around */
> +               if (src_offset + 8 + extsize < src_offset)
> +                       return 0;
> +
> +               the_hash_algo->update_fn(&c, mmap + src_offset, 8);
> +
> +               src_offset += 8;
> +               src_offset += extsize;
> +       }
> +       the_hash_algo->final_fn(hash, &c);
> +       if (hashcmp(hash, (const unsigned char *)index))
> +               return 0;
> +
> +       /* Validate that the extension offsets returned us back to the eoie extension. */
> +       if (src_offset != mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEADER)
> +               return 0;
> +
> +       return offset;
> +}
> +#endif
> +
> +static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, unsigned long offset)

We normally just put function implementations before it's used to
avoid static forward declaration. Any special reason why it's not done
here?

> +{
> +       uint32_t buffer;
> +       unsigned char hash[GIT_MAX_RAWSZ];
> +
> +       /* offset */
> +       put_be32(&buffer, offset);
> +       strbuf_add(sb, &buffer, sizeof(uint32_t));
> +
> +       /* hash */
> +       the_hash_algo->final_fn(hash, eoie_context);
> +       strbuf_add(sb, hash, the_hash_algo->rawsz);
> +}
> diff --git a/t/README b/t/README
> index 9028b47d92..d8754dd23a 100644
> --- a/t/README
> +++ b/t/README
> @@ -319,6 +319,11 @@ GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncomon pack-objects code
>  path where deltas larger than this limit require extra memory
>  allocation for bookkeeping.
>
> +GIT_TEST_DISABLE_EOIE=<boolean> disables writing the EOIE extension.
> +This is used to allow tests 1, 4-9 in t1700-split-index.sh to succeed

I have a feeling that you won't have problems if you don't write eoie
extension by default in the first place. Then this could be switched
to GIT_TEST_ENABLE_EOIE instead. We may still have problem if both
eoie and split index are forced on when running through the test
suite, but that should be an easy fix.

> +as they currently hard code SHA values for the index which are no longer
> +valid due to the addition of the EOIE extension.
> +
>  Naming Tests
>  ------------
>
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index 39133bcbc8..f613dd72e3 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -7,6 +7,7 @@ test_description='split index mode tests'
>  # We need total control of index splitting here
>  sane_unset GIT_TEST_SPLIT_INDEX
>  sane_unset GIT_FSMONITOR_TEST
> +export GIT_TEST_DISABLE_EOIE=true
>
>  test_expect_success 'enable split index' '
>         git config splitIndex.maxPercentChange 100 &&
> --
> 2.18.0.windows.1
>


-- 
Duy
