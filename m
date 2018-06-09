Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EF1A1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 17:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753433AbeFIRZ2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 13:25:28 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:46354 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753286AbeFIRZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 13:25:28 -0400
Received: by mail-ot0-f193.google.com with SMTP id q1-v6so19275480oth.13
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 10:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rfe3QJbE404ydaWfI3EiaOf477KZQQC2oq9e7H92BiA=;
        b=fbW6L8MXmdQxXkfGwiVpFb9zwd2wa2ugs1xilPYNnCku0defa0hdyVZ5axjuNRpB5N
         6HIjhdzlD4+ga3TFM1fwb3IYrRD01UG324WAqiSmtk63xekZUKNMWQ8UnPJ9gDoMwFCh
         FYl2xEGd7Tbe1ODg9HRJFtDoytaJCxNnXga7g8MlregTP2t8VCexqfhx8pmi9Qzku5ZY
         T+8a2Aw2HlYj3jLo4aDcb2zEpMtxhiJCxW7QxMrHyoF4/wtMdL996cch0HeBhCrL8urB
         m51PX1IOm5Dvt/m4v5WUErqh8aX+42lWOiwVZT0e9jFpVEWzdlPB9ZD80J4YW2gqNzoz
         rjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rfe3QJbE404ydaWfI3EiaOf477KZQQC2oq9e7H92BiA=;
        b=Ll6plkEaDYzHyJOrvoJjzYZ45L0hOXLhF3C+VFMEJmYKcffgZxwaQau6UbUihYFcpZ
         +xt9yjQPQpciv+A7rXBMoqCKI6OU6pdJmtHrstqgi4IpFXmK2g4RYabZ/AqlvwA4aLUz
         KUzd67PvTyBvo4GEk8+roOobgqyemv0/g4KNLx1iPYxNYh1i1MPAqUd7q05+BWSgY6QS
         mhSy0OyQMlNvPC+wV//nN7QfpkflhTx6XQYOiGyLbYyyzexaA7PMy6EgKp04cqXmP2Kg
         Wpb7uVrQ0Kf8xanD6QLEG01zAAjS2WITzAU0NGIu6g34QoMAtJWSqS/mpKcMc704+0un
         6PLQ==
X-Gm-Message-State: APt69E1/+uiqBcqhwEW4XeJ+ZQUV2ttqqYRj1hY/lKy7ngvlE2TTINXG
        kq4J5oep0dEIuqfVxYk0Voqpilda/HHGU3nLM3Y=
X-Google-Smtp-Source: ADUXVKJE2p/zHnk++0IrRB7HKj0gLpb+Xcmjund4+lzuy5aUpT1vBInLW/Zwj8jPIFIgJNElKAMz8yz+/Rs++G2/1Iw=
X-Received: by 2002:a9d:2c94:: with SMTP id p20-v6mr6676259otb.14.1528565127420;
 Sat, 09 Jun 2018 10:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-13-dstolee@microsoft.com>
In-Reply-To: <20180607140338.32440-13-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Jun 2018 19:25:01 +0200
Message-ID: <CACsJy8AVV9bJdC_uh3fGWfoQSCvMexFA5VTSL+cZ+hSULrXc6Q@mail.gmail.com>
Subject: Re: [PATCH 12/23] midx: write object ids in a chunk
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

On Thu, Jun 7, 2018 at 4:07 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/pack-format.txt |  4 ++
>  builtin/midx.c                          |  2 +
>  midx.c                                  | 50 +++++++++++++++++++++++--
>  object-store.h                          |  1 +
>  t/t5319-midx.sh                         |  4 +-
>  5 files changed, 55 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
> index 29bf87283a..de9ac778b6 100644
> --- a/Documentation/technical/pack-format.txt
> +++ b/Documentation/technical/pack-format.txt
> @@ -307,6 +307,10 @@ CHUNK DATA:
>             name. This is the only chunk not guaranteed to be a multiple of four
>             bytes in length, so should be the last chunk for alignment reasons.
>
> +       OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)

So N is the number of objects and H is hash size? Please don't let me guess.

> +           The OIDs for all objects in the MIDX are stored in lexicographic
> +           order in this chunk.

The reason we keep all hashes together, packed right, is to reduce
cache footprint. Another observation is it takes us usually just 12
bytes or less to uniquely identify an object, which means we could
pack even tighter if we split he object hash into two chunks, do
bsearch in the first chunk with just <n> bytes then verify that the
remaining 20-<b> bytes is matched in the second chunk. This may matter
more when we move to larger hashes. The split would of course be
configurable since different project may have different optimal value,
but default value could be 10/10 bytes.

> +
>         (This section intentionally left incomplete.)
>
>  TRAILER:
> diff --git a/builtin/midx.c b/builtin/midx.c
> index 3a261e9bbf..86edd30174 100644
> --- a/builtin/midx.c
> +++ b/builtin/midx.c
> @@ -35,6 +35,8 @@ static int read_midx_file(const char *object_dir)
>                 printf(" pack_lookup");
>         if (m->chunk_pack_names)
>                 printf(" pack_names");
> +       if (m->chunk_oid_lookup)
> +               printf(" oid_lookup");
>
>         printf("\n");
>
> diff --git a/midx.c b/midx.c
> index b20d52713c..d06bc6876a 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -14,10 +14,11 @@
>  #define MIDX_HASH_LEN 20
>  #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + MIDX_HASH_LEN)
>
> -#define MIDX_MAX_CHUNKS 2
> +#define MIDX_MAX_CHUNKS 3
>  #define MIDX_CHUNK_ALIGNMENT 4
>  #define MIDX_CHUNKID_PACKLOOKUP 0x504c4f4f /* "PLOO" */
>  #define MIDX_CHUNKID_PACKNAMES 0x504e414d /* "PNAM" */
> +#define MIDX_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
>  #define MIDX_CHUNKLOOKUP_WIDTH (sizeof(uint32_t) + sizeof(uint64_t))
>
>  static char *get_midx_filename(const char *object_dir)
> @@ -95,6 +96,10 @@ struct midxed_git *load_midxed_git(const char *object_dir)
>                                 m->chunk_pack_names = m->data + chunk_offset;
>                                 break;
>
> +                       case MIDX_CHUNKID_OIDLOOKUP:
> +                               m->chunk_oid_lookup = m->data + chunk_offset;
> +                               break;


I just now realized, how do you protect from duplicate chunks? From
this patch, it looks like you could accept two oidlookup chunks just
fine then siliently ignore the first one.

>                         case 0:
>                                 die("terminating MIDX chunk id appears earlier than expected");
>                                 break;
> @@ -112,6 +117,8 @@ struct midxed_git *load_midxed_git(const char *object_dir)
>                 die("MIDX missing required pack lookup chunk");
>         if (!m->chunk_pack_names)
>                 die("MIDX missing required pack-name chunk");
> +       if (!m->chunk_oid_lookup)
> +               die("MIDX missing required OID lookup chunk");

_()

>
>         m->pack_names = xcalloc(m->num_packs, sizeof(const char *));
>         for (i = 0; i < m->num_packs; i++) {
> @@ -370,6 +377,32 @@ static size_t write_midx_pack_names(struct hashfile *f,
>         return written;
>  }
>
> +static size_t write_midx_oid_lookup(struct hashfile *f, unsigned char hash_len,
> +                                   struct pack_midx_entry *objects,
> +                                   uint32_t nr_objects)
> +{
> +       struct pack_midx_entry *list = objects;
> +       uint32_t i;
> +       size_t written = 0;
> +
> +       for (i = 0; i < nr_objects; i++) {
> +               struct pack_midx_entry *obj = list++;
> +
> +               if (i < nr_objects - 1) {
> +                       struct pack_midx_entry *next = list;
> +                       if (oidcmp(&obj->oid, &next->oid) >= 0)
> +                               BUG("OIDs not in order: %s >= %s",
> +                               oid_to_hex(&obj->oid),
> +                               oid_to_hex(&next->oid));

Indentation. I almost thought oid_to_hex() was a separate statement.

> +               }
> +
> +               hashwrite(f, obj->oid.hash, (int)hash_len);

Is (int) really necessary? There's no loss in automatically casting
unsigned char to int. But I didn't check C spec, maybe there's some
rules...

> +               written += hash_len;
> +       }
> +
> +       return written;
> +}
> +
>  int write_midx_file(const char *object_dir)
>  {
>         unsigned char cur_chunk, num_chunks = 0;
> @@ -389,6 +422,7 @@ int write_midx_file(const char *object_dir)
>         uint64_t written = 0;
>         uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
>         uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
> +       struct pack_midx_entry *entries;
>         uint32_t nr_entries;
>
>         midx_name = get_midx_filename(object_dir);
> @@ -448,14 +482,14 @@ int write_midx_file(const char *object_dir)
>         ALLOC_ARRAY(pack_perm, nr_packs);
>         sort_packs_by_name(pack_names, nr_packs, pack_perm);
>
> -       get_sorted_entries(packs, pack_perm, nr_packs, &nr_entries);
> +       entries = get_sorted_entries(packs, pack_perm, nr_packs, &nr_entries);

This change should belong to the previous patch. This patch alone
can't tell me that entries is a new allocation. If I didn't remember
the last patch, I could not realize that entries should be freed (and
it does not look like it is here)

>
>         hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
>         f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
>         FREE_AND_NULL(midx_name);
>
>         cur_chunk = 0;
> -       num_chunks = 2;
> +       num_chunks = 3;
>
>         written = write_midx_header(f, num_chunks, nr_packs);
>
> @@ -467,9 +501,13 @@ int write_midx_file(const char *object_dir)
>         chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_packs * sizeof(uint32_t);
>
>         cur_chunk++;
> -       chunk_ids[cur_chunk] = 0;
> +       chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDLOOKUP;
>         chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + pack_name_concat_len;
>
> +       cur_chunk++;
> +       chunk_ids[cur_chunk] = 0;
> +       chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_entries * MIDX_HASH_LEN;
> +
>         for (i = 0; i <= num_chunks; i++) {
>                 if (i && chunk_offsets[i] < chunk_offsets[i - 1])
>                         BUG("incorrect chunk offsets: %"PRIu64" before %"PRIu64,
> @@ -503,6 +541,10 @@ int write_midx_file(const char *object_dir)
>                                 written += write_midx_pack_names(f, pack_names, nr_packs);
>                                 break;
>
> +                       case MIDX_CHUNKID_OIDLOOKUP:
> +                               written += write_midx_oid_lookup(f, MIDX_HASH_LEN, entries, nr_entries);
> +                               break;
> +
>                         default:
>                                 BUG("trying to write unknown chunk id %"PRIx32,
>                                     chunk_ids[i]);
> diff --git a/object-store.h b/object-store.h
> index 1ba50459ca..7d14d3586e 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -102,6 +102,7 @@ struct midxed_git {
>
>         const uint32_t *chunk_pack_lookup;
>         const unsigned char *chunk_pack_names;
> +       const unsigned char *chunk_oid_lookup;
>
>         const char **pack_names;
>         char object_dir[FLEX_ARRAY];
> diff --git a/t/t5319-midx.sh b/t/t5319-midx.sh
> index a31c387c8f..e71aa52b80 100755
> --- a/t/t5319-midx.sh
> +++ b/t/t5319-midx.sh
> @@ -6,8 +6,8 @@ test_description='multi-pack-indexes'
>  midx_read_expect() {
>         NUM_PACKS=$1
>         cat >expect <<- EOF
> -       header: 4d494458 1 1 2 $NUM_PACKS
> -       chunks: pack_lookup pack_names
> +       header: 4d494458 1 1 3 $NUM_PACKS
> +       chunks: pack_lookup pack_names oid_lookup
>         packs:
>         EOF
>         if [ $NUM_PACKS -ge 1 ]
> --
> 2.18.0.rc1
>


-- 
Duy
