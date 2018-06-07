Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E99801F403
	for <e@80x24.org>; Thu,  7 Jun 2018 18:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934243AbeFGS1Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 14:27:24 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40137 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933529AbeFGS1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 14:27:24 -0400
Received: by mail-ot0-f193.google.com with SMTP id w9-v6so7170988otj.7
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 11:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0NLzu4kDnVpTgZRi1s78THWegyDk8rrEnjzls1DT7jE=;
        b=PYyW1l44wfWDArr2lvMGV83+OWM2WfPPeBNU0MErs5HUHfKbU3NttxdtbICoim8pCt
         Qcottr6qf1ZrsOCpwYzVOj4GvIgwdM+Roo1JXIyeBnOO+NptE34/VyKdz4cc7kmUsEQd
         QiRowsqi8K6WyPMUI4wa3vgdynB0VvbCgMRfX2j8HFaAuZSowrQGBHdEjHjMnTMyqXBl
         TddgXbIbLkWtPI8y4gbd2WOXbSp1+WwsXsnCuu4bSaFSHcRNI20KBMNNigk1wdXcE2vT
         8yhi6AQ9Zm4/YhQbglSQkS7VHWAT8809qrCPB4z///runwqak5fh+T04hLvaip1pPkj+
         pM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0NLzu4kDnVpTgZRi1s78THWegyDk8rrEnjzls1DT7jE=;
        b=kN1RBxRzWmoXBdm0AVT4gouixQPuq2lAWM5MCCtYyB9YOgAZQWsEZ69qG4LWNNituU
         g9youdFscOdxPsER4C9pQ2zfYFBqSjuhdIzBonS94Hmj22P33yawtpGWaTvsRqE99Ceg
         thrq4XEGNO2lR8j91ug3EESSwRw9kWtuCPa6Ylk65RP/3Z+D4GucfVCbjNPKgQ59rDCZ
         lJt8QrduWtLZ0LBu67424PuPxoPFz3KMIIhx5kWlkA3J7s1gCnJceLWLJFbcM7xi+9Ja
         a24y1RrQ9irRH0r8/RjCI2Shj64ciFtPqPq2Mh59+hIV8kkwCtULD4QTtZbneWTcGyqR
         X4sQ==
X-Gm-Message-State: APt69E31vODGrMpV5tZ+y5iOBS74rgL18oaG8fuNN602lddpEzGFqKkF
        Kx0uLRiB8id6AJ3H1sG5IOK2cdrLgJV0ToLHpcI=
X-Google-Smtp-Source: ADUXVKKQ6zy0AN64dCkjVMPziajMAolYb35kHK899np0oYsr/EM+UybAzbXfwdvQmxSw1dzJ4W4qHGIYjsoh+8CRH/4=
X-Received: by 2002:a9d:2f91:: with SMTP id r17-v6mr1833684otb.356.1528396043343;
 Thu, 07 Jun 2018 11:27:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 11:26:52 -0700 (PDT)
In-Reply-To: <20180607140338.32440-10-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-10-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 7 Jun 2018 20:26:52 +0200
Message-ID: <CACsJy8ARDLeWaWq1_npZq5ARCVgcETpS--YUVLqZkZA52E7Msw@mail.gmail.com>
Subject: Re: [PATCH 09/23] midx: write pack names in chunk
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 4:03 PM, Derrick Stolee <stolee@gmail.com> wrote:
> @@ -74,6 +80,31 @@ struct midxed_git *load_midxed_git(const char *object_dir)
>         m->num_chunks = *(m->data + 6);
>         m->num_packs = get_be32(m->data + 8);
>
> +       for (i = 0; i < m->num_chunks; i++) {
> +               uint32_t chunk_id = get_be32(m->data + 12 + MIDX_CHUNKLOOKUP_WIDTH * i);
> +               uint64_t chunk_offset = get_be64(m->data + 16 + MIDX_CHUNKLOOKUP_WIDTH * i);

Would be good to reduce magic numbers like 12 and 16, I think you have
some header length constants for those already.

> +               switch (chunk_id) {
> +                       case MIDX_CHUNKID_PACKNAMES:
> +                               m->chunk_pack_names = m->data + chunk_offset;
> +                               break;
> +
> +                       case 0:
> +                               die("terminating MIDX chunk id appears earlier than expected");

_()

> +                               break;
> +
> +                       default:
> +                               /*
> +                                * Do nothing on unrecognized chunks, allowing future
> +                                * extensions to add optional chunks.
> +                                */

I wrote about the chunk term reminding me of PNG format then deleted
it. But it may help to do similar to PNG here. The first letter can
let us know if the chunk is optional and can be safely ignored. E.g.
uppercase first letter cannot be ignored, lowercase go wild.

> +                               break;
> +               }
> +       }
> +
> +       if (!m->chunk_pack_names)
> +               die("MIDX missing required pack-name chunk");

_()

> +
>         return m;
>
>  cleanup_fail:
> @@ -99,18 +130,88 @@ static size_t write_midx_header(struct hashfile *f,
>         return MIDX_HEADER_SIZE;
>  }
>
> +struct pack_pair {
> +       uint32_t pack_int_id;

can this be just pack_id?

> +       char *pack_name;
> +};
> +
> +static int pack_pair_compare(const void *_a, const void *_b)
> +{
> +       struct pack_pair *a = (struct pack_pair *)_a;
> +       struct pack_pair *b = (struct pack_pair *)_b;
> +       return strcmp(a->pack_name, b->pack_name);
> +}
> +
> +static void sort_packs_by_name(char **pack_names, uint32_t nr_packs, uint32_t *perm)
> +{
> +       uint32_t i;
> +       struct pack_pair *pairs;
> +
> +       ALLOC_ARRAY(pairs, nr_packs);
> +
> +       for (i = 0; i < nr_packs; i++) {
> +               pairs[i].pack_int_id = i;
> +               pairs[i].pack_name = pack_names[i];
> +       }
> +
> +       QSORT(pairs, nr_packs, pack_pair_compare);
> +
> +       for (i = 0; i < nr_packs; i++) {
> +               pack_names[i] = pairs[i].pack_name;
> +               perm[pairs[i].pack_int_id] = i;
> +       }

pairs[] is leaked?

> +}
> +
> +static size_t write_midx_pack_names(struct hashfile *f,
> +                                   char **pack_names,
> +                                   uint32_t num_packs)
> +{
> +       uint32_t i;
> +       unsigned char padding[MIDX_CHUNK_ALIGNMENT];
> +       size_t written = 0;
> +
> +       for (i = 0; i < num_packs; i++) {
> +               size_t writelen = strlen(pack_names[i]) + 1;
> +
> +               if (i && strcmp(pack_names[i], pack_names[i - 1]) <= 0)
> +                       BUG("incorrect pack-file order: %s before %s",
> +                           pack_names[i - 1],
> +                           pack_names[i]);
> +
> +               hashwrite(f, pack_names[i], writelen);
> +               written += writelen;

side note. This pattern happens a lot. It may be a good idea to make
hashwrite() return writelen so we can just write

written += hashwrite(f, ..., writelen);

> +       }
> +
> +       /* add padding to be aligned */
> +       i = MIDX_CHUNK_ALIGNMENT - (written % MIDX_CHUNK_ALIGNMENT);
> +       if (i < MIDX_CHUNK_ALIGNMENT) {
> +               bzero(padding, sizeof(padding));
> +               hashwrite(f, padding, i);
> +               written += i;
> +       }
> +
> +       return written;
> +}
> +
>  int write_midx_file(const char *object_dir)
>  {
> -       unsigned char num_chunks = 0;
> +       unsigned char cur_chunk, num_chunks = 0;
>         char *midx_name;
>         struct hashfile *f;
>         struct lock_file lk;
>         struct packed_git **packs = NULL;
> +       char **pack_names = NULL;
> +       uint32_t *pack_perm;
>         uint32_t i, nr_packs = 0, alloc_packs = 0;
> +       uint32_t alloc_pack_names = 0;
>         DIR *dir;
>         struct dirent *de;
>         struct strbuf pack_dir = STRBUF_INIT;
>         size_t pack_dir_len;
> +       uint64_t pack_name_concat_len = 0;
> +       uint64_t written = 0;
> +       uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
> +       uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];

This long list of local vars may be a good indicator that this
function needs split up into smaller ones.

>
>         midx_name = get_midx_filename(object_dir);
>         if (safe_create_leading_directories(midx_name)) {
> @@ -132,12 +233,14 @@ int write_midx_file(const char *object_dir)
>         strbuf_addch(&pack_dir, '/');
>         pack_dir_len = pack_dir.len;
>         ALLOC_ARRAY(packs, alloc_packs);
> +       ALLOC_ARRAY(pack_names, alloc_pack_names);
>         while ((de = readdir(dir)) != NULL) {
>                 if (is_dot_or_dotdot(de->d_name))
>                         continue;
>
>                 if (ends_with(de->d_name, ".idx")) {
>                         ALLOC_GROW(packs, nr_packs + 1, alloc_packs);
> +                       ALLOC_GROW(pack_names, nr_packs + 1, alloc_pack_names);
>
>                         strbuf_setlen(&pack_dir, pack_dir_len);
>                         strbuf_addstr(&pack_dir, de->d_name);
> @@ -145,21 +248,83 @@ int write_midx_file(const char *object_dir)
>                         packs[nr_packs] = add_packed_git(pack_dir.buf,
>                                                          pack_dir.len,
>                                                          0);
> -                       if (!packs[nr_packs])
> +                       if (!packs[nr_packs]) {
>                                 warning("failed to add packfile '%s'",
>                                         pack_dir.buf);
> -                       else
> -                               nr_packs++;
> +                               continue;
> +                       }
> +
> +                       pack_names[nr_packs] = xstrdup(de->d_name);
> +                       pack_name_concat_len += strlen(de->d_name) + 1;
> +                       nr_packs++;
>                 }
>         }
> +
>         closedir(dir);
>         strbuf_release(&pack_dir);
>
> +       if (pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
> +               pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
> +                                       (pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
> +
> +       ALLOC_ARRAY(pack_perm, nr_packs);
> +       sort_packs_by_name(pack_names, nr_packs, pack_perm);
> +
>         hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
>         f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
>         FREE_AND_NULL(midx_name);
>
> -       write_midx_header(f, num_chunks, nr_packs);
> +       cur_chunk = 0;
> +       num_chunks = 1;
> +
> +       written = write_midx_header(f, num_chunks, nr_packs);
> +
> +       chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKNAMES;
> +       chunk_offsets[cur_chunk] = written + (num_chunks + 1) * MIDX_CHUNKLOOKUP_WIDTH;
> +
> +       cur_chunk++;
> +       chunk_ids[cur_chunk] = 0;
> +       chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + pack_name_concat_len;
> +
> +       for (i = 0; i <= num_chunks; i++) {
> +               if (i && chunk_offsets[i] < chunk_offsets[i - 1])
> +                       BUG("incorrect chunk offsets: %"PRIu64" before %"PRIu64,
> +                           chunk_offsets[i - 1],
> +                           chunk_offsets[i]);
> +
> +               if (chunk_offsets[i] % MIDX_CHUNK_ALIGNMENT)
> +                       BUG("chunk offset %"PRIu64" is not properly aligned",
> +                           chunk_offsets[i]);
> +
> +               hashwrite_be32(f, chunk_ids[i]);
> +               hashwrite_be32(f, chunk_offsets[i] >> 32);
> +               hashwrite_be32(f, chunk_offsets[i]);
> +
> +               written += MIDX_CHUNKLOOKUP_WIDTH;
> +       }
> +
> +       for (i = 0; i < num_chunks; i++) {
> +               if (written != chunk_offsets[i])
> +                       BUG("inccrrect chunk offset (%"PRIu64" != %"PRIu64") for chunk id %"PRIx32,

incorrect

> +                           chunk_offsets[i],
> +                           written,
> +                           chunk_ids[i]);
> +
> +               switch (chunk_ids[i]) {
> +                       case MIDX_CHUNKID_PACKNAMES:
> +                               written += write_midx_pack_names(f, pack_names, nr_packs);
> +                               break;
> +
> +                       default:
> +                               BUG("trying to write unknown chunk id %"PRIx32,
> +                                   chunk_ids[i]);
> +               }
> +       }
> +
> +       if (written != chunk_offsets[num_chunks])
> +               BUG("incorrect final offset %"PRIu64" != %"PRIu64,
> +                   written,
> +                   chunk_offsets[num_chunks]);
>
>         finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
>         commit_lock_file(&lk);
> @@ -170,5 +335,6 @@ int write_midx_file(const char *object_dir)
>         }
>
>         FREE_AND_NULL(packs);
> +       FREE_AND_NULL(pack_names);

What about the strings in this array? I think they are xstrdup() but I
didn't spot them being freed.

And maybe just use string_list...

>         return 0;
>  }
-- 
Duy
