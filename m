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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D7791F403
	for <e@80x24.org>; Sat,  9 Jun 2018 16:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbeFIQoZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 12:44:25 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33677 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753438AbeFIQoW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 12:44:22 -0400
Received: by mail-ot0-f195.google.com with SMTP id h6-v6so19245173otj.0
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 09:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aX4nR7mTzrnLfyn0Pz8QxF7D7r7m7OvGkQA36OYn4+g=;
        b=q8AxSpkv5Px11LYo4H+Z8qTjmzIc34h11giPxxRA/hg4SgSxldaLL8zGJ2WT8Q3TVh
         4cjxXwGFsnn2CChTWprSawb7hiPK2KXGGhNicZk3RJ//lU9LSBZc4ybx03HCW1pwngg3
         rSusC4sDBYStbKr8oKRDgYUvEKxYMceGPX6neuECYtLFuYupjbSSx3s0aGdpj48M9WMz
         V1URqcPYLxMggIAffGFoe5XNYKnsGJzhDauYI8zoWdy64LzIua05+SGtR1VdYPSnsOGO
         vi0FRafRJAZXHtSSPsaMDKT7oPlFsB3A/q2X2jt4HhjQOSyIzfc85K4G4I1Gay5heFjC
         kpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aX4nR7mTzrnLfyn0Pz8QxF7D7r7m7OvGkQA36OYn4+g=;
        b=PjEWr2ZPGsN5hkcVSIqcwisagJMOW8ONrz3cGtx62fipl8mmGlMz/LMC+0xuNEisay
         c6zXA70uq9ct5B/ubuuAjIr6BwHogQw4Tb4cBKl1y1ty3zVb9kxvROdGCsrAWhTE6qOc
         PIiF24V1Y0QnJmtZeT7zecx0lt/PVg7fOQvKm0BXL4CBWlr91DbIU11kIOBiIuumkyjx
         IW7ZhaG+5QDsUWNu96/diDvxVLiyD8ILSTKB23RzUt71S70bgeJr/if5O0xrQwXLS/ho
         WUe7DZhffZYUenleQTonPwvui60xUD1nB1F2sdnKPW14xR2oPMedFziFCStxxnVFVUXr
         DkOg==
X-Gm-Message-State: APt69E2x68HuwO8B4d2pPiNog7VAp6b+iTlhhMyVZetihty29bwLxd0B
        gztU+LPWzFerrdjoyXnUU3y7BfEIcRldB+HS9II=
X-Google-Smtp-Source: ADUXVKLi/Ez/ahbh1HiiewvXlRZsTkOcYUAGAhy+ckG2glx4S8HSq8mbVDWcWtRbXoUbCkOCjNrmDcpjUs5W2XMDGFw=
X-Received: by 2002:a9d:124:: with SMTP id 33-v6mr6655581otu.65.1528562662304;
 Sat, 09 Jun 2018 09:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-11-dstolee@microsoft.com>
In-Reply-To: <20180607140338.32440-11-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Jun 2018 18:43:55 +0200
Message-ID: <CACsJy8C0K_3-=S-sV+jfKdRoF0Ta8eafbOT_B1zOfWCftwz8Bw@mail.gmail.com>
Subject: Re: [PATCH 10/23] midx: write a lookup into the pack names chunk
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

On Thu, Jun 7, 2018 at 7:01 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/pack-format.txt |  5 +++
>  builtin/midx.c                          |  7 ++++
>  midx.c                                  | 56 +++++++++++++++++++++++--
>  object-store.h                          |  2 +
>  t/t5319-midx.sh                         | 11 +++--
>  5 files changed, 75 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
> index 2b37be7b33..29bf87283a 100644
> --- a/Documentation/technical/pack-format.txt
> +++ b/Documentation/technical/pack-format.txt
> @@ -296,6 +296,11 @@ CHUNK LOOKUP:
>
>  CHUNK DATA:
>
> +       Packfile Name Lookup (ID: {'P', 'L', 'O', 'O'}) (P * 4 bytes)
> +           P * 4 bytes storing the offset in the packfile name chunk for
> +           the null-terminated string containing the filename for the
> +           ith packfile.
> +

Commit message is too light on this one. Why does this need to be
stored? Isn't the cost of rebuilding this in-core cheap?

Adding this chunk on disk in my opinion only adds more burden. Now you
have to verify that these offsets actually point to the right place.

>         Packfile Names (ID: {'P', 'N', 'A', 'M'})
>             Stores the packfile names as concatenated, null-terminated strings.
>             Packfiles must be listed in lexicographic order for fast lookups by
> diff --git a/builtin/midx.c b/builtin/midx.c
> index fe56560853..3a261e9bbf 100644
> --- a/builtin/midx.c
> +++ b/builtin/midx.c
> @@ -16,6 +16,7 @@ static struct opts_midx {
>
>  static int read_midx_file(const char *object_dir)
>  {
> +       uint32_t i;
>         struct midxed_git *m = load_midxed_git(object_dir);
>
>         if (!m)
> @@ -30,11 +31,17 @@ static int read_midx_file(const char *object_dir)
>
>         printf("chunks:");
>
> +       if (m->chunk_pack_lookup)
> +               printf(" pack_lookup");
>         if (m->chunk_pack_names)
>                 printf(" pack_names");
>
>         printf("\n");
>
> +       printf("packs:\n");
> +       for (i = 0; i < m->num_packs; i++)
> +               printf("%s\n", m->pack_names[i]);
> +
>         printf("object_dir: %s\n", m->object_dir);
>
>         return 0;
> diff --git a/midx.c b/midx.c
> index d4f4a01a51..923acda72e 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -13,8 +13,9 @@
>  #define MIDX_HASH_LEN 20
>  #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + MIDX_HASH_LEN)
>
> -#define MIDX_MAX_CHUNKS 1
> +#define MIDX_MAX_CHUNKS 2
>  #define MIDX_CHUNK_ALIGNMENT 4
> +#define MIDX_CHUNKID_PACKLOOKUP 0x504c4f4f /* "PLOO" */
>  #define MIDX_CHUNKID_PACKNAMES 0x504e414d /* "PNAM" */
>  #define MIDX_CHUNKLOOKUP_WIDTH (sizeof(uint32_t) + sizeof(uint64_t))
>
> @@ -85,6 +86,10 @@ struct midxed_git *load_midxed_git(const char *object_dir)
>                 uint64_t chunk_offset = get_be64(m->data + 16 + MIDX_CHUNKLOOKUP_WIDTH * i);
>
>                 switch (chunk_id) {
> +                       case MIDX_CHUNKID_PACKLOOKUP:
> +                               m->chunk_pack_lookup = (uint32_t *)(m->data + chunk_offset);
> +                               break;
> +
>                         case MIDX_CHUNKID_PACKNAMES:
>                                 m->chunk_pack_names = m->data + chunk_offset;
>                                 break;
> @@ -102,9 +107,32 @@ struct midxed_git *load_midxed_git(const char *object_dir)
>                 }
>         }
>
> +       if (!m->chunk_pack_lookup)
> +               die("MIDX missing required pack lookup chunk");
>         if (!m->chunk_pack_names)
>                 die("MIDX missing required pack-name chunk");
>
> +       m->pack_names = xcalloc(m->num_packs, sizeof(const char *));
> +       for (i = 0; i < m->num_packs; i++) {
> +               if (i) {
> +                       if (ntohl(m->chunk_pack_lookup[i]) <= ntohl(m->chunk_pack_lookup[i - 1])) {
> +                               error("MIDX pack lookup value %d before %d",
> +                                     ntohl(m->chunk_pack_lookup[i - 1]),
> +                                     ntohl(m->chunk_pack_lookup[i]));
> +                               goto cleanup_fail;
> +                       }
> +               }
> +
> +               m->pack_names[i] = (const char *)(m->chunk_pack_names + ntohl(m->chunk_pack_lookup[i]));
> +
> +               if (i && strcmp(m->pack_names[i], m->pack_names[i - 1]) <= 0) {
> +                       error("MIDX pack names out of order: '%s' before '%s'",
> +                             m->pack_names[i - 1],
> +                             m->pack_names[i]);
> +                       goto cleanup_fail;
> +               }
> +       }
> +
>         return m;
>
>  cleanup_fail:
> @@ -162,6 +190,20 @@ static void sort_packs_by_name(char **pack_names, uint32_t nr_packs, uint32_t *p
>         }
>  }
>
> +static size_t write_midx_pack_lookup(struct hashfile *f,
> +                                    char **pack_names,
> +                                    uint32_t nr_packs)
> +{
> +       uint32_t i, cur_len = 0;
> +
> +       for (i = 0; i < nr_packs; i++) {
> +               hashwrite_be32(f, cur_len);
> +               cur_len += strlen(pack_names[i]) + 1;
> +       }
> +
> +       return sizeof(uint32_t) * (size_t)nr_packs;
> +}
> +
>  static size_t write_midx_pack_names(struct hashfile *f,
>                                     char **pack_names,
>                                     uint32_t num_packs)
> @@ -275,13 +317,17 @@ int write_midx_file(const char *object_dir)
>         FREE_AND_NULL(midx_name);
>
>         cur_chunk = 0;
> -       num_chunks = 1;
> +       num_chunks = 2;
>
>         written = write_midx_header(f, num_chunks, nr_packs);
>
> -       chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKNAMES;
> +       chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKLOOKUP;
>         chunk_offsets[cur_chunk] = written + (num_chunks + 1) * MIDX_CHUNKLOOKUP_WIDTH;
>
> +       cur_chunk++;
> +       chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKNAMES;
> +       chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_packs * sizeof(uint32_t);
> +
>         cur_chunk++;
>         chunk_ids[cur_chunk] = 0;
>         chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + pack_name_concat_len;
> @@ -311,6 +357,10 @@ int write_midx_file(const char *object_dir)
>                             chunk_ids[i]);
>
>                 switch (chunk_ids[i]) {
> +                       case MIDX_CHUNKID_PACKLOOKUP:
> +                               written += write_midx_pack_lookup(f, pack_names, nr_packs);
> +                               break;
> +
>                         case MIDX_CHUNKID_PACKNAMES:
>                                 written += write_midx_pack_names(f, pack_names, nr_packs);
>                                 break;
> diff --git a/object-store.h b/object-store.h
> index 199cf4bd44..1ba50459ca 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -100,8 +100,10 @@ struct midxed_git {
>         uint32_t num_packs;
>         uint32_t num_objects;
>
> +       const uint32_t *chunk_pack_lookup;
>         const unsigned char *chunk_pack_names;
>
> +       const char **pack_names;
>         char object_dir[FLEX_ARRAY];
>  };
>
> diff --git a/t/t5319-midx.sh b/t/t5319-midx.sh
> index fdf4f84a90..a31c387c8f 100755
> --- a/t/t5319-midx.sh
> +++ b/t/t5319-midx.sh
> @@ -6,10 +6,15 @@ test_description='multi-pack-indexes'
>  midx_read_expect() {
>         NUM_PACKS=$1
>         cat >expect <<- EOF
> -       header: 4d494458 1 1 1 $NUM_PACKS
> -       chunks: pack_names
> -       object_dir: .
> +       header: 4d494458 1 1 2 $NUM_PACKS
> +       chunks: pack_lookup pack_names
> +       packs:
>         EOF
> +       if [ $NUM_PACKS -ge 1 ]
> +       then
> +               ls pack/ | grep idx | sort >> expect
> +       fi
> +       printf "object_dir: .\n" >>expect &&
>         git midx read --object-dir=. >actual &&
>         test_cmp expect actual
>  }
> --
> 2.18.0.rc1
>


-- 
Duy
