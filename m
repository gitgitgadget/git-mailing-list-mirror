Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90FE81F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 14:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbdKHOuo (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 09:50:44 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:55305 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbdKHOun (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 09:50:43 -0500
Received: by mail-qk0-f194.google.com with SMTP id x195so3574420qkb.12
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 06:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BmGi9Udsg5c8mfmLyVcsawSiYBEpDXzXoZG9wigGf48=;
        b=cHkvJh6lP1NeZ+a6wx1smBsFr5MKijY4fmwUdFer3h5EozF1ocSouq5lJGpEX4layc
         UhTTeeY5v4vNGxzzGq9G04qWBs+869SPZ1nv308QApgEfAp4kJ0uI10g6/T25sg+ga5a
         3hJ1Vh36lgzJJdV8vkiHjB3zP0WWFMRAcbQIT04sPZgJez8OUipvwtZKfhTR5t8P9XvB
         aNjQPxC/v7SRByex74ty+83932ukf3sXyL7PEMP7Q4VpF0f6pG2goZ089mBbBajLCB6W
         /GRA1tCBT3T0tFLzPECjgtpdl40/W5ATUvAuLEEzSCN51Kxa3JtCT6uOHj5b1yC7GK5S
         muqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BmGi9Udsg5c8mfmLyVcsawSiYBEpDXzXoZG9wigGf48=;
        b=TTCxO41Rvw77S0oH6204KXFsq0RyIHhictSYTPL/bME5/K+LkCkqk5h7gxDWZYBvl0
         T+ZoNR+fAt242lj7rM+owNVF23jsn57zBsxTktuII34jEU14hJJyOtq6c8Oipr/C6Pvy
         0xkkZkZsgOC+645fjk5ElhFM71d1JEZ43UmjTqrLLBdPVVuh1JmBnPHc+jFJ1OR9AatQ
         rB2S3QbJWtQM3oOjJ+YGyscCik7820k3wf+O1d9dlzvJ+EwuD8soPBTymzbXNjlwX3v4
         8ApPj7rfCWA3gke1GY+XLjxytpBl7yrLaGA0UDXAsGKSktJdClrU1jyzdJIjjrsE1GEA
         auYg==
X-Gm-Message-State: AJaThX5uQ2Q5aeV6i1PTS3YdKBrgYMzdb6QULBu7vvdcj1HgDnALiCdw
        92huqmC+iAZm+vbJEl8yxrXxwNjs
X-Google-Smtp-Source: ABhQp+R1XTuivksa7YWSq4+6UlFvYKu/tF59xQIapSDjkWepZm4SE363biV4F0oB5rqpQkRm+NaKaQ==
X-Received: by 10.55.120.131 with SMTP id t125mr1128802qkc.63.1510152641529;
        Wed, 08 Nov 2017 06:50:41 -0800 (PST)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id y192sm2875716qky.62.2017.11.08.06.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Nov 2017 06:50:40 -0800 (PST)
Subject: Re: [RFC] fastindex: parallelize index load
To:     Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com, jeffhost@microsoft.com,
        chriscool@tuxfamily.org, alexmv@dropbox.com, peff@peff.net
References: <20171108144253.34428-1-benpeart@microsoft.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <dcd4a9e6-dbaa-25ec-c898-d4242a8ce544@gmail.com>
Date:   Wed, 8 Nov 2017 09:50:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171108144253.34428-1-benpeart@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an RFC because it works but I've not done the code cleanup,
added tests, support in the update-index command to add/remove it, etc.
As a result, there is no reason to point out all the places I'm not
currently following the git coding style. :)

I wanted to get feedback on the concept first, especially as the way I'm
adding the TOC information via an extension that can be read before the
variable length section of cache entries and other extensions is a bit
of a clever hack, as is the resetting of the prefix encoding for V4
indexes.  They are, however, entirely backwards compatible with older
versions of git which can still properly read and use the index.

The effect can be seen using t/helper/test-read-cache:

                                 fastindex
test            count   files   TRUE    FALSE     Savings
------------------------------------------------------------------------
test-read-cache 500     100K    6.39    8.33      23.36%
test-read-cache 100     1M      12.49   18.68     33.12%



On 11/8/2017 9:42 AM, Ben Peart wrote:
> This patch will address the CPU cost of loading the index by adding
> additional data to the index that will allow us to multi-thread the
> loading and conversion of cache entries.
> 
> It accomplishes this by adding an (optional) index extension that is a
> table of offsets to blocks of cache entries in the index file.  With
> version 2, 3 or even 4 indexes, we can utilize the Index Entry Offset Table
> (IEOT) to parallelize the loading and conversion of the cache entries
> across all available CPU cores.
> 
> To make this work for V4 indexes, when writing the index, it periodically
> "resets" the compression by encoding the current entry as if the path
> name for the previous entry is completely different and saves the offset
> of that entry in the IEOT.  Basically, with V4 indexes, it generates
> offsets into blocks of prefix-compressed entries.
> 
> To enable reading the IEOT extension before reading all the variable
> length cache entries and other extensions, the IEOT is written last,
> right before the trailing SHA1.
> 
> The format of that extension has the signature bytes and size at the
> beginning (like a normal extension) as well as at the end in reverse
> order to enable parsing the extension by seeking back from the end of
> the file.  See the diagram below for details.
> 
> During index load, read the index header then seek to the end of the
> index, back up past the trailing SHA1 and look for the IEOT extension
> signature bytes.  If they exist, read the 32-bit size and seek back to
> the extension header and verify the leading header and size bits.  If
> they all match, we can be assured we have a valid IEOT extension.
> 
> If the IEOT extension is available, create multiple threads to divide
> the work of loading and converting the cache entries across all
> available CPU cores.  Once the cache entries are loaded, the rest of the
> extensions can be loaded and processed normally (skipping the IEOT entry
> as it has already been processed).  If the IEOT extension is not
> available then parsing the index will proceed as usual with a single thread.
> 
> The on-disk format looks like this:
> 
> Index header
> Cache entry 1
> Cache entry 2
> .
> .
> Extension 1
> Extension 2
> .
> .
> Index Entry Offset Table Extension (must be written last!)
> IEOT signature bytes
> 32-bit size
> 32-bit version
> 32-bit Cache Entry Offset 1
> 32-bit Cache Entry count
> 32-bit Cache Entry Offset 2
> 32-bit Cache Entry count
> .
> .
> 32-bit version
> 32-bit size
> IEOT signature bytes
> SHA1
> 
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
> 
> Notes:
>      Base Ref: v2.14.3.windows.1
>      Web-Diff: https://github.com/benpeart/git/commit/1e818c7835
>      Checkout: git fetch https://github.com/benpeart/git fastindex-v1 && git checkout 1e818c7835
> 
>   Makefile                  |   2 +
>   cache.h                   |  18 +++
>   config.c                  |  20 +++
>   config.h                  |   1 +
>   environment.c             |   3 +
>   read-cache.c              | 340 +++++++++++++++++++++++++++++++++++++++++++---
>   t/helper/test-dump-ieot.c |  78 +++++++++++
>   t/helper/test-ieot.c      |  72 ++++++++++
>   8 files changed, 513 insertions(+), 21 deletions(-)
>   create mode 100644 t/helper/test-dump-ieot.c
>   create mode 100644 t/helper/test-ieot.c
> 
> diff --git a/Makefile b/Makefile
> index ebd0a75d87..99fa8dd8d3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -640,12 +640,14 @@ TEST_PROGRAMS_NEED_X += test-config
>   TEST_PROGRAMS_NEED_X += test-date
>   TEST_PROGRAMS_NEED_X += test-delta
>   TEST_PROGRAMS_NEED_X += test-dump-cache-tree
> +TEST_PROGRAMS_NEED_X += test-dump-ieot
>   TEST_PROGRAMS_NEED_X += test-dump-split-index
>   TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
>   TEST_PROGRAMS_NEED_X += test-fake-ssh
>   TEST_PROGRAMS_NEED_X += test-genrandom
>   TEST_PROGRAMS_NEED_X += test-hashmap
>   TEST_PROGRAMS_NEED_X += test-helper
> +TEST_PROGRAMS_NEED_X += test-ieot
>   TEST_PROGRAMS_NEED_X += test-index-version
>   TEST_PROGRAMS_NEED_X += test-lazy-init-name-hash
>   TEST_PROGRAMS_NEED_X += test-line-buffer
> diff --git a/cache.h b/cache.h
> index 45597732d8..e9ec1bf41a 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -326,6 +326,7 @@ static inline unsigned int canon_mode(unsigned int mode)
>   #define CACHE_TREE_CHANGED	(1 << 5)
>   #define SPLIT_INDEX_ORDERED	(1 << 6)
>   #define UNTRACKED_CHANGED	(1 << 7)
> +#define IEOT_CHANGED		(1 << 9)
>   
>   struct split_index;
>   struct untracked_cache;
> @@ -770,6 +771,7 @@ extern char *git_replace_ref_base;
>   
>   extern int fsync_object_files;
>   extern int core_preload_index;
> +extern int core_fast_index;
>   extern int core_apply_sparse_checkout;
>   extern int precomposed_unicode;
>   extern int protect_hfs;
> @@ -2025,4 +2027,20 @@ void sleep_millisec(int millisec);
>    */
>   void safe_create_dir(const char *dir, int share);
>   
> +
> +#ifndef NO_PTHREADS
> +struct index_entry_offset
> +{	// starting byte offset into index file, count of index entries in this block
> +	int offset, nr;
> +};
> +
> +struct index_entry_offset_table
> +{
> +	int nr;				// number of ieot entries in array
> +	struct index_entry_offset entries[0];
> +};
> +
> +struct index_entry_offset_table *read_ieot_extension(void *mmap, size_t mmap_size);
> +#endif
> +
>   #endif /* CACHE_H */
> diff --git a/config.c b/config.c
> index adcd2c2441..056c21b0c9 100644
> --- a/config.c
> +++ b/config.c
> @@ -1203,6 +1203,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
>   		return 0;
>   	}
>   
> +	if (!strcmp(var, "core.fastindex")) {
> +		core_fast_index = git_config_bool(var, value);
> +		return 0;
> +	}
> +
>   	if (!strcmp(var, "core.createobject")) {
>   		if (!strcmp(value, "rename"))
>   			object_creation_mode = OBJECT_CREATION_USES_RENAMES;
> @@ -2116,6 +2121,21 @@ int git_config_get_max_percent_split_change(void)
>   	return -1; /* default value */
>   }
>   
> +int ignore_fast_index_config;
> +int git_config_get_fast_index(void)
> +{
> +	int val;
> +
> +	/* Hack for test programs like test-ieot */
> +	if (ignore_fast_index_config)
> +		return core_fast_index;
> +
> +	if (!git_config_get_maybe_bool("core.fastindex", &val))
> +		return val;
> +
> +	return -1; /* default value */
> +}
> +
>   NORETURN
>   void git_die_config_linenr(const char *key, const char *filename, int linenr)
>   {
> diff --git a/config.h b/config.h
> index 0352da117b..bb73c36e0a 100644
> --- a/config.h
> +++ b/config.h
> @@ -201,6 +201,7 @@ extern int git_config_get_pathname(const char *key, const char **dest);
>   extern int git_config_get_untracked_cache(void);
>   extern int git_config_get_split_index(void);
>   extern int git_config_get_max_percent_split_change(void);
> +extern int git_config_get_fast_index(void);
>   
>   /* This dies if the configured or default date is in the future */
>   extern int git_config_get_expiry(const char *key, const char **output);
> diff --git a/environment.c b/environment.c
> index c974bed180..bb8405cd91 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -86,6 +86,9 @@ int auto_comment_line_char;
>   /* Parallel index stat data preload? */
>   int core_preload_index = 1;
>   
> +/* Parallel index cache entry loading? */
> +int core_fast_index;
> +
>   /*
>    * This is a hack for test programs like test-dump-untracked-cache to
>    * ensure that they do not modify the untracked cache when reading it.
> diff --git a/read-cache.c b/read-cache.c
> index bc925b6736..dc2fadb61f 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -19,6 +19,7 @@
>   #include "varint.h"
>   #include "split-index.h"
>   #include "utf8.h"
> +#include "thread-utils.h"
>   
>   #ifndef NO_PTHREADS
>   #include <pthread.h>
> @@ -42,11 +43,12 @@
>   #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
>   #define CACHE_EXT_LINK 0x6c696e6b	  /* "link" */
>   #define CACHE_EXT_UNTRACKED 0x554E5452	  /* "UNTR" */
> +#define CACHE_EXT_FASTINDEX 0x49454F54	  /* "IEOT" */
>   
>   /* changes that can be kept in $GIT_DIR/index (basically all extensions) */
>   #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
>   		 CE_ENTRY_ADDED | CE_ENTRY_REMOVED | CE_ENTRY_CHANGED | \
> -		 SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED)
> +		 SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED | CACHE_EXT_FASTINDEX)
>   
>   struct index_state the_index;
>   static const char *alternate_index_output;
> @@ -1581,6 +1583,9 @@ static int read_index_extension(struct index_state *istate,
>   	case CACHE_EXT_UNTRACKED:
>   		istate->untracked = read_untracked_extension(data, sz);
>   		break;
> +	case CACHE_EXT_FASTINDEX:
> +		/* already handled in do_read_index() */
> +		break;
>   	default:
>   		if (*ext < 'A' || 'Z' < *ext)
>   			return error("index uses %.4s extension, which we do not understand",
> @@ -1634,10 +1639,12 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
>    * number of bytes to be stripped from the end of the previous name,
>    * and the bytes to append to the result, to come up with its name.
>    */
> -static unsigned long expand_name_field(struct strbuf *name, const char *cp_)
> +static unsigned long expand_name_field(struct strbuf *name, const char *cp_, int use_length)
>   {
>   	const unsigned char *ep, *cp = (const unsigned char *)cp_;
>   	size_t len = decode_varint(&cp);
> +	if (!use_length)
> +		len = name->len;
>   
>   	if (name->len < len)
>   		die("malformed name field in the index");
> @@ -1648,9 +1655,10 @@ static unsigned long expand_name_field(struct strbuf *name, const char *cp_)
>   	return (const char *)ep + 1 - cp_;
>   }
>   
> -static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
> +struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
>   					    unsigned long *ent_size,
> -					    struct strbuf *previous_name)
> +					    struct strbuf *previous_name,
> +						int use_length)
>   {
>   	struct cache_entry *ce;
>   	size_t len;
> @@ -1684,7 +1692,7 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
>   		*ent_size = ondisk_ce_size(ce);
>   	} else {
>   		unsigned long consumed;
> -		consumed = expand_name_field(previous_name, name);
> +		consumed = expand_name_field(previous_name, name, use_length);
>   		ce = cache_entry_from_ondisk(ondisk, flags,
>   					     previous_name->buf,
>   					     previous_name->len);
> @@ -1755,16 +1763,208 @@ static void post_read_index_from(struct index_state *istate)
>   	tweak_split_index(istate);
>   }
>   
> +static unsigned long load_cache_entries(struct index_state *istate, int offset, int nr, void *mmap, unsigned long start_offset)
> +{
> +	int i;
> +	unsigned long src_offset = start_offset;
> +	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
> +
> +	if (istate->version == 4)
> +		previous_name = &previous_name_buf;
> +	else
> +		previous_name = NULL;
> +
> +	for (i = offset; i < offset + nr; i++) {
> +		struct ondisk_cache_entry *disk_ce;
> +		struct cache_entry *ce;
> +		unsigned long consumed;
> +
> +		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
> +		ce = create_from_disk(disk_ce, &consumed, previous_name, i == offset ? 0 : 1);
> +		set_index_entry(istate, i, ce);
> +
> +		src_offset += consumed;
> +	}
> +	strbuf_release(&previous_name_buf);
> +	return src_offset - start_offset;
> +}
> +
> +#ifndef NO_PTHREADS
> +
> +/*
> + * Mostly randomly chosen cache entries per thread (it works on my machine):
> + * we want to have at least 7500 cache entries per thread for it to
> + * be worth starting a thread.
> + */
> +#define THREAD_COST		(7500)
> +#define IEOT_VERSION	(1)
> +
> +static int ce_write(git_SHA_CTX *context, int fd, void *data, unsigned int len);
> +
> +static int write_index_ext_header(git_SHA_CTX *context, int fd,
> +	unsigned int ext, unsigned int sz);
> +
> +struct load_cache_entries_thread_data
> +{
> +	pthread_t pthread;
> +	struct index_state *istate;
> +	int offset;			// starting index into the istate->cache array
> +	void *mmap;			// pointer to memory mapped index file
> +	unsigned long consumed;	// return # of bytes in index file processed
> +	struct index_entry_offset_table *ieot;	// pointer to ieot
> +	int ieot_offset;	// starting index into the ieot array
> +	int ieot_work;		// count of ieot entries to process
> +};
> +
> +/*
> + * A thread proc to run the load_cache_entries() computation
> + * across multiple background threads.
> + */
> +static void *load_cache_entries_thread(void *_data)
> +{
> +	struct load_cache_entries_thread_data *p = _data;
> +	int i;
> +
> +	// itterate across all ieot blocks assigned to this thread
> +	for (i = p->ieot_offset; i < p->ieot_offset + p->ieot_work; i++) {
> +		p->consumed += load_cache_entries(p->istate, p->offset, p->ieot->entries[i].nr, p->mmap, p->ieot->entries[i].offset);
> +		p->offset += p->ieot->entries[i].nr;
> +	}
> +	return NULL;
> +}
> +
> +struct index_entry_offset_table *read_ieot_extension(void *mmap, size_t mmap_size)
> +{
> +	/*
> +	 * The IEOT extension is guaranteed to be last so that it can be found
> +	 * by scanning backwards from the EOF.  In addition to the regular 4-byte
> +	 * extension name and 4-byte section length is network byte order, it
> +	 * also stores the 4-byte extension name and section length in reverse order
> +	 * at the end of the extension.
> +	 *
> +	 * IEOT
> +	 * 4-byte length
> +	 * 4-byte version
> +	 * variable length extension data...
> +	 * 4-byte version
> +	 * 4-byte length
> +	 * IEOT
> +	 * <SHA1>
> +	 *
> +	 * If both names and lengths match, the extension is assumed to be valid.
> +	 */
> +	const char *index;
> +	uint32_t extsize_leading, extsize_trailing, ext_version;
> +	struct index_entry_offset_table *ieot;
> +	int i, nr;
> +
> +	/* validate the trailing extension signature */
> +	index = (const char *)mmap + mmap_size - 20 - 4;
> +	if (CACHE_EXT(index) != CACHE_EXT_FASTINDEX)
> +		return NULL;
> +	index -= sizeof(uint32_t);
> +
> +	/*
> +	 * Validate the offset we're going to look for the leading extension
> +	 * signature is past the index header.
> +	 */
> +	extsize_trailing = get_be32(index);
> +	if ((index - extsize_trailing) < ((const char *)mmap + 12))
> +		return NULL;
> +	index -= sizeof(uint32_t);
> +
> +	/* validate the trailing version is IEOT_VERSION */
> +	ext_version = get_be32(index);
> +	if (ext_version != IEOT_VERSION)
> +		return NULL;
> +	index -= (extsize_trailing - sizeof(uint32_t));
> +
> +	/* validate the leading extension signature */
> +	if (CACHE_EXT(index) != CACHE_EXT_FASTINDEX)
> +		return NULL;
> +	index += sizeof(uint32_t);
> +
> +	/* validate the leading extension size */
> +	extsize_leading = get_be32(index);
> +	if (extsize_leading != extsize_trailing)
> +		return NULL;
> +	index += sizeof(uint32_t);
> +
> +	/* validate the leading version is IEOT_VERSION */
> +	ext_version = get_be32(index);
> +	if (ext_version != IEOT_VERSION)
> +		return NULL;
> +	index += sizeof(uint32_t);
> +
> +	/* extension size - leading/trailing version bytes - trailing size - trailing signature / bytes per entry */
> +	nr = (extsize_leading - sizeof(uint32_t) - sizeof(uint32_t) - sizeof(uint32_t) - 4) / (sizeof(uint32_t) + sizeof(uint32_t));
> +	assert(nr);
> +	ieot = xmalloc(sizeof(struct index_entry_offset_table)
> +		+ (nr * sizeof(struct index_entry_offset)));
> +	ieot->nr = nr;
> +	for (i = 0; i < nr; i++) {
> +		ieot->entries[i].offset = get_be32(index);
> +		index += sizeof(uint32_t);
> +		ieot->entries[i].nr = get_be32(index);
> +		index += sizeof(uint32_t);
> +	}
> +
> +	return ieot;
> +}
> +
> +static int write_ieot_extension(git_SHA_CTX *context, int fd, struct index_entry_offset_table *ieot)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	uint32_t buffer;
> +	int i, err;
> +
> +	/* version */
> +	put_be32(&buffer, IEOT_VERSION);
> +	strbuf_add(&sb, &buffer, sizeof(uint32_t));
> +
> +	/* ieot */
> +	for (i = 0; i < ieot->nr; i++) {
> +
> +		/* offset */
> +		put_be32(&buffer, ieot->entries[i].offset);
> +		strbuf_add(&sb, &buffer, sizeof(uint32_t));
> +
> +		/* count */
> +		put_be32(&buffer, ieot->entries[i].nr);
> +		strbuf_add(&sb, &buffer, sizeof(uint32_t));
> +	}
> +
> +	/* version */
> +	put_be32(&buffer, IEOT_VERSION);
> +	strbuf_add(&sb, &buffer, sizeof(uint32_t));
> +
> +	/* size */
> +	put_be32(&buffer, sb.len + sizeof(uint32_t) + 4);
> +	strbuf_add(&sb, &buffer, sizeof(uint32_t));
> +
> +	/* signature */
> +	put_be32(&buffer, CACHE_EXT_FASTINDEX);
> +	strbuf_add(&sb, &buffer, 4);
> +
> +	/* leading signature and size + extension data */
> +	err = write_index_ext_header(context, fd, CACHE_EXT_FASTINDEX, sb.len) < 0
> +		|| ce_write(context, fd, sb.buf, sb.len) < 0;
> +	strbuf_release(&sb);
> +
> +	return err;
> +}
> +
> +#endif
> +
>   /* remember to discard_cache() before reading a different cache! */
>   int do_read_index(struct index_state *istate, const char *path, int must_exist)
>   {
> -	int fd, i;
> +	int fd;
>   	struct stat st;
>   	unsigned long src_offset;
>   	struct cache_header *hdr;
>   	void *mmap;
>   	size_t mmap_size;
> -	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
>   #ifndef NO_PTHREADS
>   	struct verify_hdr_thread_data verify_hdr_thread_data;
>   #endif
> @@ -1819,24 +2019,71 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>   	istate->cache = xcalloc(istate->cache_alloc, sizeof(*istate->cache));
>   	istate->initialized = 1;
>   
> -	if (istate->version == 4)
> -		previous_name = &previous_name_buf;
> -	else
> -		previous_name = NULL;
> -
>   	src_offset = sizeof(*hdr);
> -	for (i = 0; i < istate->cache_nr; i++) {
> -		struct ondisk_cache_entry *disk_ce;
> -		struct cache_entry *ce;
> -		unsigned long consumed;
> +#ifdef NO_PTHREADS
> +	src_offset += load_cache_entries(istate, 0, istate->cache_nr, mmap, src_offset);
> +#else
> +	if (git_config_get_fast_index() != 1) {
> +		src_offset += load_cache_entries(istate, 0, istate->cache_nr, mmap, src_offset);
> +	} else {
> +		struct index_entry_offset_table *ieot;
> +		int threads, cpus = online_cpus();
>   
> -		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
> -		ce = create_from_disk(disk_ce, &consumed, previous_name);
> -		set_index_entry(istate, i, ce);
> +		threads = istate->cache_nr / THREAD_COST;
> +		if (threads > cpus)
> +			threads = cpus;
>   
> -		src_offset += consumed;
> +		/*
> +		 * Locate and read the fast index extension so that we can use it
> +		 * to multi-thread the reading of the cache entries.
> +		 */
> +		ieot = read_ieot_extension(mmap, mmap_size);
> +		if (threads < 2 || !ieot) {
> +			src_offset += load_cache_entries(istate, 0, istate->cache_nr, mmap, src_offset);
> +		} else {
> +			int i, offset, ieot_work, ieot_offset;
> +			struct load_cache_entries_thread_data *data;
> +
> +			/* ensure we have no more threads than we have blocks to process */
> +			if (threads > ieot->nr)
> +				threads = ieot->nr;
> +			data = xcalloc(threads * sizeof(struct load_cache_entries_thread_data), 1);
> +
> +			offset = ieot_offset = 0;
> +			ieot_work = DIV_ROUND_UP(ieot->nr, threads);
> +			for (i = 0; i < threads; i++) {
> +				struct load_cache_entries_thread_data *p = &data[i];
> +				int j;
> +
> +				if (ieot_offset + ieot_work > ieot->nr)
> +					ieot_work = ieot->nr - ieot_offset;
> +
> +				p->istate = istate;
> +				p->offset = offset;				// starting index into the istate->cache array
> +				p->mmap = mmap;					// pointer to memory mapped index file
> +				p->ieot = ieot;					// pointer to ieot
> +				p->ieot_offset = ieot_offset;	// starting index into the ieot array
> +				p->ieot_work = ieot_work;		// count of ieot entries to process
> +				if (pthread_create(&p->pthread, NULL, load_cache_entries_thread, p))
> +					die("unable to create threaded load_cache_entries");
> +
> +				// increment by the number of cache entries in the ieot block being processed
> +				for (j = 0; j < ieot_work; j++)
> +					offset += ieot->entries[ieot_offset + j].nr;
> +				ieot_offset += ieot_work;
> +			}
> +			for (i = 0; i < threads; i++) {
> +				struct load_cache_entries_thread_data *p = data + i;
> +				if (pthread_join(p->pthread, NULL))
> +					die("unable to join threaded load_cache_entries");
> +				src_offset += p->consumed;		// # of bytes in index file processed
> +			}
> +			free(data);
> +		}
> +		free(ieot);
>   	}
> -	strbuf_release(&previous_name_buf);
> +#endif
> +
>   	istate->timestamp.sec = st.st_mtime;
>   	istate->timestamp.nsec = ST_MTIME_NSEC(st);
>   
> @@ -2258,6 +2505,9 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>   	struct stat st;
>   	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
>   	int drop_cache_tree = 0;
> +	int ieot_work = 1;
> +	struct index_entry_offset_table *ieot = NULL;
> +	int offset, nr;
>   
>   	for (i = removed = extended = 0; i < entries; i++) {
>   		if (cache[i]->ce_flags & CE_REMOVE)
> @@ -2291,6 +2541,22 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>   	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
>   		return -1;
>   
> +	if (!strip_extensions && core_fast_index) {
> +		int ieot_blocks, cpus = online_cpus();
> +
> +		ieot_blocks = istate->cache_nr / THREAD_COST;
> +		if (ieot_blocks > cpus)
> +			ieot_blocks = cpus;
> +		if (ieot_blocks >= 1) {
> +			ieot = xcalloc(sizeof(struct index_entry_offset_table)
> +				+ (ieot_blocks * sizeof(struct index_entry_offset)), 1);
> +			ieot->nr = 0;
> +		}
> +		ieot_work = DIV_ROUND_UP(entries, ieot_blocks);
> +	}
> +
> +	offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
> +	nr = 0;
>   	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
>   	for (i = 0; i < entries; i++) {
>   		struct cache_entry *ce = cache[i];
> @@ -2311,8 +2577,28 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>   
>   			drop_cache_tree = 1;
>   		}
> +		if (ieot && i && (i % ieot_work == 0)) {
> +			ieot->entries[ieot->nr].nr = nr;
> +			ieot->entries[ieot->nr].offset = offset;
> +			ieot->nr++;
> +			/*
> +			 * If we have a V4 index, set the first byte to an invalid
> +			 * character to ensure there is nothing common with the previous
> +			 * entry
> +			 */
> +			if (previous_name)
> +				previous_name->buf[0] = 0;
> +			nr = 0;
> +			offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
> +		}
>   		if (ce_write_entry(&c, newfd, ce, previous_name) < 0)
>   			return -1;
> +		nr++;
> +	}
> +	if (ieot && nr) {
> +		ieot->entries[ieot->nr].nr = nr;
> +		ieot->entries[ieot->nr].offset = offset;
> +		ieot->nr++;
>   	}
>   	strbuf_release(&previous_name_buf);
>   
> @@ -2361,6 +2647,18 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>   			return -1;
>   	}
>   
> +	/*
> +	 * CACHE_EXT_FASTINDEX must be written as the last entry before the SHA1
> +	 * so that it can be found and processed before all the index entries are
> +	 * read.
> +	 */
> +	if (!strip_extensions && ieot) {
> +		err = write_ieot_extension(&c, newfd, ieot);
> +		free(ieot);
> +		if (err)
> +			return -1;
> +	}
> +
>   	if (ce_flush(&c, newfd, istate->sha1))
>   		return -1;
>   	if (close_tempfile(tempfile))
> diff --git a/t/helper/test-dump-ieot.c b/t/helper/test-dump-ieot.c
> new file mode 100644
> index 0000000000..70aa31bb41
> --- /dev/null
> +++ b/t/helper/test-dump-ieot.c
> @@ -0,0 +1,78 @@
> +#include "cache.h"
> +
> +struct ondisk_cache_entry;
> +extern struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
> +	unsigned long *ent_size,
> +	struct strbuf *previous_name,
> +	int use_length);
> +
> +int cmd_main(int ac, const char **av)
> +{
> +#ifndef NO_PTHREADS
> +	const char *path;
> +	int fd, i;
> +	struct stat st;
> +	void *mmap;
> +	size_t mmap_size;
> +	struct cache_header *hdr;
> +	struct index_entry_offset_table *ieot;
> +	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
> +
> +	setup_git_directory();
> +	path = get_index_file();
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0) {
> +		die_errno("%s: index file open failed", path);
> +	}
> +
> +	if (fstat(fd, &st))
> +		die_errno("cannot stat the open index");
> +
> +	mmap_size = xsize_t(st.st_size);
> +	if (mmap_size < sizeof(struct cache_header) + 20)
> +		die_errno("index file smaller than expected");
> +
> +	mmap = xmmap(NULL, mmap_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +	if (mmap == MAP_FAILED)
> +		die_errno("unable to map index file");
> +	close(fd);
> +
> +	hdr = mmap;
> +	if (ntohl(hdr->hdr_version) == 4)
> +		previous_name = &previous_name_buf;
> +	else
> +		previous_name = NULL;
> +
> +	ieot = read_ieot_extension(mmap, mmap_size);
> +	if (!ieot)
> +		die_errno("missing or invalid extension");
> +
> +	printf("IEOT with %d entries\n", ieot->nr);
> +	printf("  Offset    Count Name\n");
> +	printf("-------- -------- ------------------------\n");
> +	for (i = 0; i < ieot->nr; i++) {
> +		struct ondisk_cache_entry *disk_ce;
> +		struct cache_entry *ce;
> +		unsigned long consumed;
> +
> +		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + ieot->entries[i].offset);
> +		ce = create_from_disk(disk_ce, &consumed, previous_name, 0);
> +		/*
> +		 * If we have a V4 index, set the first byte to an invalid
> +		 * character to ensure there is nothing common with the previous
> +		 * entry
> +		 */
> +		if (previous_name)
> +			previous_name->buf[0] = 0;
> +		printf("%8d %8d %.*s\n", ieot->entries[i].offset, ieot->entries[i].nr, ce->ce_namelen, ce->name);
> +		free(ce);
> +	}
> +
> +	free(ieot);
> +	munmap(mmap, mmap_size);
> +	return 0;
> +#else
> +	die_errno("ieot only supported with PTHREADS");
> +	return -1;
> +#endif
> +}
> diff --git a/t/helper/test-ieot.c b/t/helper/test-ieot.c
> new file mode 100644
> index 0000000000..75f28db001
> --- /dev/null
> +++ b/t/helper/test-ieot.c
> @@ -0,0 +1,72 @@
> +#include "cache.h"
> +
> +int compare_ce(const struct cache_entry *ce1, const struct cache_entry *ce2)
> +{
> +//	struct hashmap_entry ent;
> +//	struct stat_data ce_stat_data;
> +
> +	if (ce1->ce_mode != ce2->ce_mode) {
> +		printf("ce_mode: %d:%d\n", ce1->ce_mode, ce2->ce_mode);
> +		return 1;
> +	}
> +
> +	if (ce1->ce_flags != ce2->ce_flags) {
> +		printf("ce_flags: %d:%d\n", ce1->ce_flags, ce2->ce_flags);
> +		return 1;
> +	}
> +
> +//	unsigned int ce_namelen;
> +
> +	if (ce1->index != ce2->index) {
> +		printf("index: %d:%d\n", ce1->index, ce2->index);
> +		return 1;
> +	}
> +
> +	if (oidcmp(&ce1->oid, &ce2->oid)) {
> +		printf("oid: %s:%s\n", oid_to_hex(&ce1->oid), oid_to_hex(&ce2->oid));
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +extern int ignore_fast_index_config;
> +
> +int cmd_main(int ac, const char **av)
> +{
> +#ifndef NO_PTHREADS
> +	static struct index_state index;
> +	static struct index_state ieot;
> +	int i;
> +
> +	setup_git_directory();
> +	ignore_fast_index_config = 1;
> +	core_fast_index = 0;
> +	read_index(&index);
> +	core_fast_index = 1;
> +	read_index(&ieot);
> +
> +	for (i = 0; i < index.cache_nr; i++) {
> +		if (compare_ce(index.cache[i], ieot.cache[i])) {
> +			struct cache_entry *ce;
> +
> +			ce = index.cache[i];
> +			printf("%06o %s %d\t%s\n", ce->ce_mode,
> +				oid_to_hex(&ce->oid), ce_stage(ce), ce->name);
> +			ce = ieot.cache[i];
> +			printf("%06o %s %d\t%s\n", ce->ce_mode,
> +				oid_to_hex(&ce->oid), ce_stage(ce), ce->name);
> +
> +			die_errno("cache entry %d does not match", i);
> +		}
> +	}
> +
> +	discard_index(&ieot);
> +	discard_index(&index);
> +	printf("Cache entires are the same\n");
> +	return 0;
> +#else
> +	die_errno("ieot only supported with PTHREADS");
> +	return -1;
> +#endif
> +}
> 
> base-commit: dbc8d81072630bc50324938b9ac950140669ced9
> 
