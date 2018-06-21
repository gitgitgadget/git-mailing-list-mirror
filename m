Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 754EF1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 15:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933182AbeFUPZn (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 11:25:43 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42699 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933162AbeFUPZm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 11:25:42 -0400
Received: by mail-qt0-f194.google.com with SMTP id y31-v6so3176361qty.9
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 08:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wWPbgEeGZ5mJVfCLyv7nCNHuAaSoV3AV0fth/5t6nQE=;
        b=O2dg8C0VRRIseEmKEnVoqQ2XcO5M3f6FM86CzHlWwDyNvunIKBGS6+l2U+vvdjDTWA
         28dIURkrKJzObmBtbwBSY61D0ipcMP2G5t4tLvhss0DiOLBAhGctSC8Qd5eLOQ/Gwsfy
         hJV/cyE0hZib8P6esH6ylr4Oyft10rHQ8jUr7+4kudrzXyyzAjWScZMCDBbsADfLGizo
         Jln91RwAFbAAIIos7jl3HyWCu5SUB0x3J5VGrS++5vMTqb4I4z30tZM270okuw8qCVss
         WsYOaidglGdEYGN+Tw1dQtoiDLv5h8LaXnTCgl4b6sDWbOd/7AuB+WnH/8y3o+hBkm47
         kKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wWPbgEeGZ5mJVfCLyv7nCNHuAaSoV3AV0fth/5t6nQE=;
        b=qwbPMEfOCT4OAy/K8UGtF2t+aiXh78PSvt3PHePMaev7o+x7HbVLa18t632ckpXNYF
         /l6duM60hgt/09xk6L7nvBTCQf/NyOY3WqmVKT3jf4oPAfoYGpyXWu50us3P8Nm2UuKn
         wfq/IiHPBYYRoDABbf7usprkaqaw5btk0qrMAGZvZgy1TwzW5DlytREpNKRXVlv4UF7n
         dsl+QFqmDZ1C7ekmr15n+i5PyMy7fpKrxJuEWSH3DcXtjE0EmcM0zdBoqqyEWg0jTJMK
         Vyf/rtig8bH7StnjGGFZ/mAKrpKZHF2gAVFQ53L8znae1Je04gAtTVgEFbNeIbLaN9YG
         cmgw==
X-Gm-Message-State: APt69E3cVRgPl4jn8SfWk1n7XuS1mv872tuWHMjbYhAeU//JfuEhS/sO
        Q3K9U8cq54c1DFd/HyCBIgw=
X-Google-Smtp-Source: ADUXVKK6asZeOTqAUlUTkSd4tT/r27BD1opvJZuExz0yd2KGaz6vmRt1ifForD4WSY2UZejAqMYn2Q==
X-Received: by 2002:aed:3a24:: with SMTP id n33-v6mr24150958qte.348.1529594740691;
        Thu, 21 Jun 2018 08:25:40 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:342c:51f1:bd43:3fe6? ([2001:4898:8010:0:1d62:51f1:bd43:3fe6])
        by smtp.gmail.com with ESMTPSA id w66-v6sm3289456qkc.86.2018.06.21.08.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 08:25:40 -0700 (PDT)
Subject: Re: [PATCH 09/23] midx: write pack names in chunk
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-10-dstolee@microsoft.com>
 <CACsJy8ARDLeWaWq1_npZq5ARCVgcETpS--YUVLqZkZA52E7Msw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4082c785-9fb2-7b15-b646-3c658b54abbe@gmail.com>
Date:   Thu, 21 Jun 2018 11:25:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8ARDLeWaWq1_npZq5ARCVgcETpS--YUVLqZkZA52E7Msw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2018 2:26 PM, Duy Nguyen wrote:
> On Thu, Jun 7, 2018 at 4:03 PM, Derrick Stolee <stolee@gmail.com> wrote:
>> @@ -74,6 +80,31 @@ struct midxed_git *load_midxed_git(const char *object_dir)
>>          m->num_chunks = *(m->data + 6);
>>          m->num_packs = get_be32(m->data + 8);
>>
>> +       for (i = 0; i < m->num_chunks; i++) {
>> +               uint32_t chunk_id = get_be32(m->data + 12 + MIDX_CHUNKLOOKUP_WIDTH * i);
>> +               uint64_t chunk_offset = get_be64(m->data + 16 + MIDX_CHUNKLOOKUP_WIDTH * i);
> Would be good to reduce magic numbers like 12 and 16, I think you have
> some header length constants for those already.
>
>> +               switch (chunk_id) {
>> +                       case MIDX_CHUNKID_PACKNAMES:
>> +                               m->chunk_pack_names = m->data + chunk_offset;
>> +                               break;
>> +
>> +                       case 0:
>> +                               die("terminating MIDX chunk id appears earlier than expected");
> _()

This die() and others like it are not marked for translation on purpose, 
as they should never be seen by an end-user.

>
>> +                               break;
>> +
>> +                       default:
>> +                               /*
>> +                                * Do nothing on unrecognized chunks, allowing future
>> +                                * extensions to add optional chunks.
>> +                                */
> I wrote about the chunk term reminding me of PNG format then deleted
> it. But it may help to do similar to PNG here. The first letter can
> let us know if the chunk is optional and can be safely ignored. E.g.
> uppercase first letter cannot be ignored, lowercase go wild.

That's an interesting way to think about it. That way you could add a 
new "required" chunk and earlier versions could die() realizing they 
don't know how to parse that required chunk.

I think for this format, we should update the file version value when a 
required chunk is needed.

>
>> +                               break;
>> +               }
>> +       }
>> +
>> +       if (!m->chunk_pack_names)
>> +               die("MIDX missing required pack-name chunk");
> _()
>
>> +
>>          return m;
>>
>>   cleanup_fail:
>> @@ -99,18 +130,88 @@ static size_t write_midx_header(struct hashfile *f,
>>          return MIDX_HEADER_SIZE;
>>   }
>>
>> +struct pack_pair {
>> +       uint32_t pack_int_id;
> can this be just pack_id?

Since packfiles are usually named pack-{hash}.pack, I chose to be 
specific here.

>
>> +       char *pack_name;
>> +};
>> +
>> +static int pack_pair_compare(const void *_a, const void *_b)
>> +{
>> +       struct pack_pair *a = (struct pack_pair *)_a;
>> +       struct pack_pair *b = (struct pack_pair *)_b;
>> +       return strcmp(a->pack_name, b->pack_name);
>> +}
>> +
>> +static void sort_packs_by_name(char **pack_names, uint32_t nr_packs, uint32_t *perm)
>> +{
>> +       uint32_t i;
>> +       struct pack_pair *pairs;
>> +
>> +       ALLOC_ARRAY(pairs, nr_packs);
>> +
>> +       for (i = 0; i < nr_packs; i++) {
>> +               pairs[i].pack_int_id = i;
>> +               pairs[i].pack_name = pack_names[i];
>> +       }
>> +
>> +       QSORT(pairs, nr_packs, pack_pair_compare);
>> +
>> +       for (i = 0; i < nr_packs; i++) {
>> +               pack_names[i] = pairs[i].pack_name;
>> +               perm[pairs[i].pack_int_id] = i;
>> +       }
> pairs[] is leaked?

Good catch!

>
>> +}
>> +
>> +static size_t write_midx_pack_names(struct hashfile *f,
>> +                                   char **pack_names,
>> +                                   uint32_t num_packs)
>> +{
>> +       uint32_t i;
>> +       unsigned char padding[MIDX_CHUNK_ALIGNMENT];
>> +       size_t written = 0;
>> +
>> +       for (i = 0; i < num_packs; i++) {
>> +               size_t writelen = strlen(pack_names[i]) + 1;
>> +
>> +               if (i && strcmp(pack_names[i], pack_names[i - 1]) <= 0)
>> +                       BUG("incorrect pack-file order: %s before %s",
>> +                           pack_names[i - 1],
>> +                           pack_names[i]);
>> +
>> +               hashwrite(f, pack_names[i], writelen);
>> +               written += writelen;
> side note. This pattern happens a lot. It may be a good idea to make
> hashwrite() return writelen so we can just write
>
> written += hashwrite(f, ..., writelen);

If I change the prototype of hashwrite(), will other callers get 
warnings about not inspecting the return value (for some build options 
on some platforms)?

>
>> +       }
>> +
>> +       /* add padding to be aligned */
>> +       i = MIDX_CHUNK_ALIGNMENT - (written % MIDX_CHUNK_ALIGNMENT);
>> +       if (i < MIDX_CHUNK_ALIGNMENT) {
>> +               bzero(padding, sizeof(padding));
>> +               hashwrite(f, padding, i);
>> +               written += i;
>> +       }
>> +
>> +       return written;
>> +}
>> +
>>   int write_midx_file(const char *object_dir)
>>   {
>> -       unsigned char num_chunks = 0;
>> +       unsigned char cur_chunk, num_chunks = 0;
>>          char *midx_name;
>>          struct hashfile *f;
>>          struct lock_file lk;
>>          struct packed_git **packs = NULL;
>> +       char **pack_names = NULL;
>> +       uint32_t *pack_perm;
>>          uint32_t i, nr_packs = 0, alloc_packs = 0;
>> +       uint32_t alloc_pack_names = 0;
>>          DIR *dir;
>>          struct dirent *de;
>>          struct strbuf pack_dir = STRBUF_INIT;
>>          size_t pack_dir_len;
>> +       uint64_t pack_name_concat_len = 0;
>> +       uint64_t written = 0;
>> +       uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
>> +       uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
> This long list of local vars may be a good indicator that this
> function needs split up into smaller ones.

Or the data needs to be grouped into structs, which is happening in my 
local branch due to the for_each_file_in_pack_dir() method.

>>          midx_name = get_midx_filename(object_dir);
>>          if (safe_create_leading_directories(midx_name)) {
>> @@ -132,12 +233,14 @@ int write_midx_file(const char *object_dir)
>>          strbuf_addch(&pack_dir, '/');
>>          pack_dir_len = pack_dir.len;
>>          ALLOC_ARRAY(packs, alloc_packs);
>> +       ALLOC_ARRAY(pack_names, alloc_pack_names);
>>          while ((de = readdir(dir)) != NULL) {
>>                  if (is_dot_or_dotdot(de->d_name))
>>                          continue;
>>
>>                  if (ends_with(de->d_name, ".idx")) {
>>                          ALLOC_GROW(packs, nr_packs + 1, alloc_packs);
>> +                       ALLOC_GROW(pack_names, nr_packs + 1, alloc_pack_names);
>>
>>                          strbuf_setlen(&pack_dir, pack_dir_len);
>>                          strbuf_addstr(&pack_dir, de->d_name);
>> @@ -145,21 +248,83 @@ int write_midx_file(const char *object_dir)
>>                          packs[nr_packs] = add_packed_git(pack_dir.buf,
>>                                                           pack_dir.len,
>>                                                           0);
>> -                       if (!packs[nr_packs])
>> +                       if (!packs[nr_packs]) {
>>                                  warning("failed to add packfile '%s'",
>>                                          pack_dir.buf);
>> -                       else
>> -                               nr_packs++;
>> +                               continue;
>> +                       }
>> +
>> +                       pack_names[nr_packs] = xstrdup(de->d_name);
>> +                       pack_name_concat_len += strlen(de->d_name) + 1;
>> +                       nr_packs++;
>>                  }
>>          }
>> +
>>          closedir(dir);
>>          strbuf_release(&pack_dir);
>>
>> +       if (pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
>> +               pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
>> +                                       (pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
>> +
>> +       ALLOC_ARRAY(pack_perm, nr_packs);
>> +       sort_packs_by_name(pack_names, nr_packs, pack_perm);
>> +
>>          hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
>>          f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
>>          FREE_AND_NULL(midx_name);
>>
>> -       write_midx_header(f, num_chunks, nr_packs);
>> +       cur_chunk = 0;
>> +       num_chunks = 1;
>> +
>> +       written = write_midx_header(f, num_chunks, nr_packs);
>> +
>> +       chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKNAMES;
>> +       chunk_offsets[cur_chunk] = written + (num_chunks + 1) * MIDX_CHUNKLOOKUP_WIDTH;
>> +
>> +       cur_chunk++;
>> +       chunk_ids[cur_chunk] = 0;
>> +       chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + pack_name_concat_len;
>> +
>> +       for (i = 0; i <= num_chunks; i++) {
>> +               if (i && chunk_offsets[i] < chunk_offsets[i - 1])
>> +                       BUG("incorrect chunk offsets: %"PRIu64" before %"PRIu64,
>> +                           chunk_offsets[i - 1],
>> +                           chunk_offsets[i]);
>> +
>> +               if (chunk_offsets[i] % MIDX_CHUNK_ALIGNMENT)
>> +                       BUG("chunk offset %"PRIu64" is not properly aligned",
>> +                           chunk_offsets[i]);
>> +
>> +               hashwrite_be32(f, chunk_ids[i]);
>> +               hashwrite_be32(f, chunk_offsets[i] >> 32);
>> +               hashwrite_be32(f, chunk_offsets[i]);
>> +
>> +               written += MIDX_CHUNKLOOKUP_WIDTH;
>> +       }
>> +
>> +       for (i = 0; i < num_chunks; i++) {
>> +               if (written != chunk_offsets[i])
>> +                       BUG("inccrrect chunk offset (%"PRIu64" != %"PRIu64") for chunk id %"PRIx32,
> incorrect
>
>> +                           chunk_offsets[i],
>> +                           written,
>> +                           chunk_ids[i]);
>> +
>> +               switch (chunk_ids[i]) {
>> +                       case MIDX_CHUNKID_PACKNAMES:
>> +                               written += write_midx_pack_names(f, pack_names, nr_packs);
>> +                               break;
>> +
>> +                       default:
>> +                               BUG("trying to write unknown chunk id %"PRIx32,
>> +                                   chunk_ids[i]);
>> +               }
>> +       }
>> +
>> +       if (written != chunk_offsets[num_chunks])
>> +               BUG("incorrect final offset %"PRIu64" != %"PRIu64,
>> +                   written,
>> +                   chunk_offsets[num_chunks]);
>>
>>          finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
>>          commit_lock_file(&lk);
>> @@ -170,5 +335,6 @@ int write_midx_file(const char *object_dir)
>>          }
>>
>>          FREE_AND_NULL(packs);
>> +       FREE_AND_NULL(pack_names);
> What about the strings in this array? I think they are xstrdup() but I
> didn't spot them being freed.
>
> And maybe just use string_list...

Will do! Thanks.
