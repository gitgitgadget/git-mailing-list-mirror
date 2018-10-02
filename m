Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36CB1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 19:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeJCByT (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 21:54:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33676 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbeJCByT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 21:54:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id q40-v6so3245062qte.0
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 12:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N3uZrucHYpEzLs6m5oq2Jk9IXCfRW+xKfaeNjNzl9ag=;
        b=QBt59P1izMPkpVR91goSZQK0nn3sAt3bH/Jlcd1ij+woWxWiBVALNAAiyQYSD1MJnM
         exllbsTyRxTG6iV3GMVPE+7BqZXyZQqE9ksDY2WDhh1lFeP+L/U3KUIQLpJDlrCHbbU1
         4FTrmCOXVxUjiGV64IwrP+wsKoRWNpDSvmpaCXbAeu0Iu4rbXAO4gK8+IP9KdZG45F6L
         Pzad6NL3f3uQxTmVC2odi2rKVykC6vx2QVmzABigHSRUQyw6OmG80jE/AzJQHn0IdwjQ
         FnXY856vKXeeIBp7LQ55DY5die4hVLobeLr56XbMK/LXu34cgUTuB+N686LjMqGFF03G
         Lm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N3uZrucHYpEzLs6m5oq2Jk9IXCfRW+xKfaeNjNzl9ag=;
        b=bBeiyBmWGp7Ynd/DACihzJImsaXC482ZJ/B4FoYAZiftYuLjVgYBorPwh9j1EQCIDX
         wb/Or2AQZLesjHfFARs6ncBMkxpPN9g9Lgg5tvKPF9QvillCaOdQqVst8wXQoPNl/mfm
         eomXHLEiYa9inHS5pWQInxll4Aif9TsuN5r7vUKZy8MNwuUWbADJkyNDSQj5/z6WTN2L
         77QkXccV0QT/BchjlXy/5Op8RI2uLIoltBN3ZjPWfmXrygoziISu02qTVOyaAh+rgrIQ
         E2mRCNN6dn+rTWIRCn69C86BkUPwxcv5ir6Vp9CwT4IK+uRDd6VSBRVNTgDQKf0tpoR9
         HqvA==
X-Gm-Message-State: ABuFfohVpirhYsDqsFTZ+uCq8jfZ8vVa0uDAlKmY/RAPflWZDQS/PjPR
        J941noDRb5X6LrC/wiXfMBE=
X-Google-Smtp-Source: ACcGV60UUxiPU1ffIGjUHIWsAkklJUJx+iA84lviG6Cp5HcWBxS8MvB7ZHrqHnjJ+q+FqZrmfGVtcA==
X-Received: by 2002:aed:39e8:: with SMTP id m95-v6mr13842279qte.30.1538507367690;
        Tue, 02 Oct 2018 12:09:27 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id a8-v6sm9500957qth.43.2018.10.02.12.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 12:09:26 -0700 (PDT)
Subject: Re: [PATCH v7 7/7] read-cache: load cache entries on worker threads
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181001134556.33232-1-peartben@gmail.com>
 <20181001134556.33232-8-peartben@gmail.com>
 <CACsJy8D7Pbg6xMZBfCiz_7_=reY3Os4R_70wc65VMxbu2=Kqjw@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <8f00ea21-07dc-4d19-7bd8-16dee53eba67@gmail.com>
Date:   Tue, 2 Oct 2018 15:09:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8D7Pbg6xMZBfCiz_7_=reY3Os4R_70wc65VMxbu2=Kqjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/1/2018 1:09 PM, Duy Nguyen wrote:
> On Mon, Oct 1, 2018 at 3:46 PM Ben Peart <peartben@gmail.com> wrote:
>> +/*
>> + * A helper function that will load the specified range of cache entries
>> + * from the memory mapped file and add them to the given index.
>> + */
>> +static unsigned long load_cache_entry_block(struct index_state *istate,
>> +                       struct mem_pool *ce_mem_pool, int offset, int nr, const char *mmap,
> 
> Please use unsigned long for offset (here and in the thread_data
> struct). We should use off_t instead, but that's out of scope. At
> least keep offset type consistent in here.
> 

Unfortunately, this code is littered with different types for size and 
offset.  "int" is the most common but there are also off_t, size_t and 
some unsigned long as well.  Currently all of them are at least 32 bits 
so until we need to have an index larger than 32 bits, we should be OK. 
I agree, fixing them all is outside the scope of this patch.

>> +                       unsigned long start_offset, const struct cache_entry *previous_ce)
> 
> I don't think you want to pass previous_ce in. You always pass NULL
> anyway. And if this function is about loading a block (i.e. at block
> boundary) then initial previous_ce _must_ be NULL or things break
> horribly.
> 

The function as written can load any arbitrary subset of cache entries 
as long as previous_ce is set correctly.  I currently only use it on 
block boundaries but I don't see any good reason to limit its 
capabilities by moving what code passes the NULL in one function deeper.

>> @@ -1959,20 +2007,125 @@ static void *load_index_extensions(void *_data)
>>
>>   #define THREAD_COST            (10000)
>>
>> +struct load_cache_entries_thread_data
>> +{
>> +       pthread_t pthread;
>> +       struct index_state *istate;
>> +       struct mem_pool *ce_mem_pool;
>> +       int offset;
>> +       const char *mmap;
>> +       struct index_entry_offset_table *ieot;
>> +       int ieot_offset;        /* starting index into the ieot array */
> 
> If it's an index, maybe just name it ieot_index and we can get rid of
> the comment.
> 
>> +       int ieot_work;          /* count of ieot entries to process */
> 
> Maybe instead of saving the whole "ieot" table here. Add
> 
>       struct index_entry_offset *blocks;
> 
> which points to the starting block for this thread and rename that
> mysterious (to me) ieot_work to nr_blocks. The thread will have access
> from blocks[0] to blocks[nr_blocks - 1]
> 

Meh. Either way you have to figure out there are a block of entries and 
each thread is going to process some subset of those entries.  You can 
do the base + offset math here or down in the calling function but it 
has to happen (and be understood) either way.

I'll rename ieot_offset to ieot_start and ieot_work to ieot_blocks which 
should hopefully help make it more obvious what they do.

>> +       unsigned long consumed; /* return # of bytes in index file processed */
>> +};
>> +
>> +/*
>> + * A thread proc to run the load_cache_entries() computation
>> + * across multiple background threads.
>> + */
>> +static void *load_cache_entries_thread(void *_data)
>> +{
>> +       struct load_cache_entries_thread_data *p = _data;
>> +       int i;
>> +
>> +       /* iterate across all ieot blocks assigned to this thread */
>> +       for (i = p->ieot_offset; i < p->ieot_offset + p->ieot_work; i++) {
>> +               p->consumed += load_cache_entry_block(p->istate, p->ce_mem_pool, p->offset, p->ieot->entries[i].nr, p->mmap, p->ieot->entries[i].offset, NULL);
> 
> Please wrap this long line.
> 
>> +               p->offset += p->ieot->entries[i].nr;
>> +       }
>> +       return NULL;
>> +}
>> +
>> +static unsigned long load_cache_entries_threaded(struct index_state *istate, const char *mmap, size_t mmap_size,
>> +                       unsigned long src_offset, int nr_threads, struct index_entry_offset_table *ieot)
>> +{
>> +       int i, offset, ieot_work, ieot_offset, err;
>> +       struct load_cache_entries_thread_data *data;
>> +       unsigned long consumed = 0;
>> +       int nr;
>> +
>> +       /* a little sanity checking */
>> +       if (istate->name_hash_initialized)
>> +               BUG("the name hash isn't thread safe");
>> +
>> +       mem_pool_init(&istate->ce_mem_pool, 0);
>> +       data = xcalloc(nr_threads, sizeof(struct load_cache_entries_thread_data));
> 
> we normally use sizeof(*data) instead of sizeof(struct ...)
> 
>> +
>> +       /* ensure we have no more threads than we have blocks to process */
>> +       if (nr_threads > ieot->nr)
>> +               nr_threads = ieot->nr;
>> +       data = xcalloc(nr_threads, sizeof(struct load_cache_entries_thread_data));
> 
> eh.. reallocate the same "data"?
> 

Thanks, good catch - I hate leaky code.

>> +
>> +       offset = ieot_offset = 0;
>> +       ieot_work = DIV_ROUND_UP(ieot->nr, nr_threads);
>> +       for (i = 0; i < nr_threads; i++) {
>> +               struct load_cache_entries_thread_data *p = &data[i];
>> +               int j;
>> +
>> +               if (ieot_offset + ieot_work > ieot->nr)
>> +                       ieot_work = ieot->nr - ieot_offset;
>> +
>> +               p->istate = istate;
>> +               p->offset = offset;
>> +               p->mmap = mmap;
>> +               p->ieot = ieot;
>> +               p->ieot_offset = ieot_offset;
>> +               p->ieot_work = ieot_work;
>> +
>> +               /* create a mem_pool for each thread */
>> +               nr = 0;
> 
> Since nr is only used in this for loop. Declare it in this scope
> instead of declaring it for the whole function.
> 
>> +               for (j = p->ieot_offset; j < p->ieot_offset + p->ieot_work; j++)
>> +                       nr += p->ieot->entries[j].nr;
>> +               if (istate->version == 4) {
>> +                       mem_pool_init(&p->ce_mem_pool,
>> +                               estimate_cache_size_from_compressed(nr));
>> +               }
>> +               else {
>> +                       mem_pool_init(&p->ce_mem_pool,
>> +                               estimate_cache_size(mmap_size, nr));
>> +               }
> 
> Maybe keep this mem_pool_init code inside load_cache_entries_thread(),
> similar to how you do it for load_cache_entries_thread(). It's mostly
> to keep this loop shorter to see (and understand), of course
> parallelizing this mem_pool_init() is just noise.
> 

I understand the desire to get that part of the thread initialization 
out of the main line of this function (it's a bit messy between the 
entry counting and version differences) but I prefer to have all the 
thread initialization completed before creating the thread.  That allows 
for simpler error handling and helps minimize the state you have to pass 
into the thread (mmap_size in this case).

>> +
>> +               err = pthread_create(&p->pthread, NULL, load_cache_entries_thread, p);
>> +               if (err)
>> +                       die(_("unable to create load_cache_entries thread: %s"), strerror(err));
>> +
>> +               /* increment by the number of cache entries in the ieot block being processed */
>> +               for (j = 0; j < ieot_work; j++)
>> +                       offset += ieot->entries[ieot_offset + j].nr;
> 
> I wonder if it makes things simpler if you store cache_entry _index_
> in entrie[] array instead of storing the number of entries. You can
> easily calculate nr then by doing entries[i].index -
> entries[i-1].index. And you can count multiple blocks the same way,
> without looping like this.
> 
>> +               ieot_offset += ieot_work;
>> +       }
>> +
>> +       for (i = 0; i < nr_threads; i++) {
>> +               struct load_cache_entries_thread_data *p = &data[i];
>> +
>> +               err = pthread_join(p->pthread, NULL);
>> +               if (err)
>> +                       die(_("unable to join load_cache_entries thread: %s"), strerror(err));
>> +               mem_pool_combine(istate->ce_mem_pool, p->ce_mem_pool);
>> +               consumed += p->consumed;
>> +       }
>> +
>> +       free(data);
>> +
>> +       return consumed;
>> +}
>> +#endif
>> +
>>   /* remember to discard_cache() before reading a different cache! */
>>   int do_read_index(struct index_state *istate, const char *path, int must_exist)
>>   {
>> -       int fd, i;
>> +       int fd;
>>          struct stat st;
>>          unsigned long src_offset;
>>          const struct cache_header *hdr;
>>          const char *mmap;
>>          size_t mmap_size;
>> -       const struct cache_entry *previous_ce = NULL;
>>          struct load_index_extensions p;
>>          size_t extension_offset = 0;
>>   #ifndef NO_PTHREADS
>> -       int nr_threads;
>> +       int nr_threads, cpus;
>> +       struct index_entry_offset_table *ieot = NULL;
>>   #endif
>>
>>          if (istate->initialized)
>> @@ -2014,10 +2167,18 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>>          p.mmap = mmap;
>>          p.mmap_size = mmap_size;
>>
>> +       src_offset = sizeof(*hdr);
> 
> OK we've been doing this since forever, sizeof(struct cache_header)
> probably does not have extra padding on any supported platform.
> 
>> @@ -2032,29 +2193,22 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>>                          nr_threads--;
>>                  }
>>          }
>> -#endif
>> -
>> -       if (istate->version == 4) {
>> -               mem_pool_init(&istate->ce_mem_pool,
>> -                             estimate_cache_size_from_compressed(istate->cache_nr));
>> -       } else {
>> -               mem_pool_init(&istate->ce_mem_pool,
>> -                             estimate_cache_size(mmap_size, istate->cache_nr));
>> -       }
>>
>> -       src_offset = sizeof(*hdr);
>> -       for (i = 0; i < istate->cache_nr; i++) {
>> -               struct ondisk_cache_entry *disk_ce;
>> -               struct cache_entry *ce;
>> -               unsigned long consumed;
>> +       /*
>> +        * Locate and read the index entry offset table so that we can use it
>> +        * to multi-thread the reading of the cache entries.
>> +        */
>> +       if (extension_offset && nr_threads > 1)
>> +               ieot = read_ieot_extension(mmap, mmap_size, extension_offset);
> 
> You need to free ieot at some point.
> 

Good catch - I hate leaky code.

>>
>> -               disk_ce = (struct ondisk_cache_entry *)(mmap + src_offset);
>> -               ce = create_from_disk(istate, disk_ce, &consumed, previous_ce);
>> -               set_index_entry(istate, i, ce);
>> +       if (ieot)
>> +               src_offset += load_cache_entries_threaded(istate, mmap, mmap_size, src_offset, nr_threads, ieot);
>> +       else
>> +               src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
>> +#else
>> +       src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
>> +#endif
>>
>> -               src_offset += consumed;
>> -               previous_ce = ce;
>> -       }
>>          istate->timestamp.sec = st.st_mtime;
>>          istate->timestamp.nsec = ST_MTIME_NSEC(st);
>>
>> --
>> 2.18.0.windows.1
>>
