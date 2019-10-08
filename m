Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D001B1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 08:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfJHI6h (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 04:58:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:55217 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729784AbfJHI6h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 04:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570525106;
        bh=4E4VE3Ft3GECpa/0eddDh7tDGeHXCvZY99qo1Ou255c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VzW3mUpZ6lFZ7FrXnSa2TokHivhg2IpVPdVheDeRh0KlTTRBwNDGR3YGAOTXydD0q
         AEB+VxCxlxNTswRBw0BqV+x3r8LSxGAJ9j7hzEV4nJ4j+lhfzN9xV7mpSjzsa/wrxz
         3MU2EK09+sTvF4CkuGCtW7a3FCrWrq+vXLHIIip0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ycl-1iGNLd2987-0031sx; Tue, 08
 Oct 2019 10:58:26 +0200
Date:   Tue, 8 Oct 2019 10:58:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Wong <e@80x24.org>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 00/20] hashmap bug/safety/ease-of-use fixes
In-Reply-To: <20191006233043.3516-1-e@80x24.org>
Message-ID: <nycvar.QRO.7.76.6.1910081055210.46@tvgsbejvaqbjf.bet>
References: <20191006233043.3516-1-e@80x24.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Gp2i/PGb9POw1i/hgoo2Xtve9fh1ucBM+D4pFNCztanrIgfkMYW
 bLKDWyMcKwh+/Xnqhv1d9p0tMf6NpcXsgPT9nv26p/ske6rQMAab3y7QicsRimHMhjfOkA4
 K1A6/F+k7zy4bta6WfJBqZUqJwapmj5rkAvFqVjh8FN29jjYGjFYFtC1ZrjCo2Vbql6SSf1
 69b0zJ2fhpDKNF+QpalUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g7e1qsFfY8o=:bZfsKwll21tlSlSL3sc0YH
 En2yGFYjOzEIsCynR4FbWmsWf94AMPs6KdoKV5XOg+39j++V65Rwq+qS9qaihAJZdDYslWbbC
 nSoygOGqUXiQSJ6NMGRA6RcslZxPASBmMQWW2470ReaXvWQi5s5kTpf4RuG64hZFe5D+hCWhw
 qs1gdhbImbEmMgwsuBsdM5PzQDdCs3EjiK925lDk1XyfVfCN36MhRqpZAOcmi68Q/TWRMJ6Cc
 6xpV1ZCYIdxSjA3mWXZGs2OecoLmZlRlP64aepSVVvZ83D2PYSBqpuZ0lQFJMGpOkrmD6sNbY
 HOdp6QNYL8mhAQEx9tpLawoTmrOQnD8qHgN3wWGc10aLdEokAh8iTSkTv9O+MSo90Q6gUyb5X
 IApppGUOTdvuvtQRqenC1ZvCQJR0zsNGHm7hJfbjNXf7PFjFZrVXdMaT3WSl9s+J1S8WDl5Xi
 /MeHSwYCeNm6q6ltHC2TkMt64kzD6eT7AfAMZ5fTWXcMsspeNiHy2jmTP6YICKkrzi/T6Mi0J
 fIykc3QgsXdh5Q79m+bsrOD1l9cMkzTlP74KXRYoVKs3ObkvvvOhFiB0P6HNMHf/KM1ycXKcc
 INkjPHoalUgmCBWWhabKSo2/RI1P58ylLg/zBIAWFkZ5tDWhpWipcTYHF79/WGWpK6znDK9Ac
 4sgNRR374maERZqSeNn9OLYe7XQvbc0Jr99VcbCOzIQzjZCh1CoedmfaIHLcysYJ5HAU8YvZ8
 9VFmv4WBBjyjmaTf+JimBLLfzCPNDkvfsESxs1Is3uTV63wvxlhj9j3xJzieZP5btQ/eodxSa
 jVWSIaHFtZzgRLmx5hugPIR+rfAVpJaFNXc+Ln+ZGbyqctjUJMYE0ZGFbBdsxkSeek/q54iDx
 FaW7AMPyV9N0J7iv1pWLl9qeT6nLPjS4N4+j/zPs32HYaDSRxP+2VMv0nMirw8JNCC5m06N6h
 Gol6UDgDlQcNAJwdjw1mKaCiafjfrk3X1TRsB1iE5D1RhymCcFoZo8uJsYI5U04gNyAY9punq
 RKXbVyCyMEePw91eNsO4z8Ke9XB/3I9p2O3BFEUI8A4K+BIaJNkkufW/+KzRdr/1juFwuZfF6
 KHu6RCyH46hAg8dKlRmbhGntlgh+HahMCfnrL7c2e7x7bpMEwSAKRvSz9ov9pz4STFDOWzIWg
 Y5SWKTQKfITYzxtmXslimMhGPDHWaEt/5lAT4FQBP5qqRsVXb3gfPgH0CnohwoIyYRDVC2wmx
 +YpaL2lfJrZ13Kki6Qb7BPzPgCoiMxt8GGTDO16BvXhIBVwAHRlwrhzRi528=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric & Junio,

On Sun, 6 Oct 2019, Eric Wong wrote:

> v3 changes:
> - use __typeof__ to avoid invalid clang warning on uninitialized var
> - formatting fixes recommended by Stolee
> - add Reviewed-by for Stolee
> - add patch 20 to update docs to drop first member requirement

This has quite a bit of fallout, even more than previous rounds, it
seems. I need at least these fixup???s to fix the build of `pu`:

https://github.com/git-for-windows/git/commit/f74259754971b427a14e6290681e=
18950824b99d
https://github.com/git-for-windows/git/commit/124c8bc08e974e76ca7d956dc07e=
b288e71d639e
https://github.com/git-for-windows/git/commit/45948433d1b48ff513fbd37f134c=
0f1491c78192

Junio, feel free to fetch and squash those into the appropriate merge
commit(s) (I feel that 4432e8b5f36 (Merge branch 'ds/sparse-cone' into
pu, 2019-10-08) may be the right spot).

Thanks,
Dscho

>
> v2 here:
>   https://public-inbox.org/git/20190924010324.22619-1-e@80x24.org/
>
> The following changes since commit 745f6812895b31c02b29bdfe4ae8e5498f776=
c26:
>
>   First batch after Git 2.23 (2019-08-22 12:41:04 -0700)
>
> are available in the Git repository at:
>
>   https://80x24.org/git-svn.git hashmap-wip-v3
>
> for you to fetch changes up to 4ec5200646d6b9363e64e2002eb374aa888a6c88:
>
>   hashmap_entry: remove first member requirement from docs (2019-10-06 2=
3:05:22 +0000)
>
> ----------------------------------------------------------------
> Eric Wong (20):
>       diff: use hashmap_entry_init on moved_entry.ent
>       coccicheck: detect hashmap_entry.hash assignment
>       packfile: use hashmap_entry in delta_base_cache_entry
>       hashmap_entry_init takes "struct hashmap_entry *"
>       hashmap_get_next takes "const struct hashmap_entry *"
>       hashmap_add takes "struct hashmap_entry *"
>       hashmap_get takes "const struct hashmap_entry *"
>       hashmap_remove takes "const struct hashmap_entry *"
>       hashmap_put takes "struct hashmap_entry *"
>       introduce container_of macro
>       hashmap_get_next returns "struct hashmap_entry *"
>       hashmap: use *_entry APIs to wrap container_of
>       hashmap_get{,_from_hash} return "struct hashmap_entry *"
>       hashmap_cmp_fn takes hashmap_entry params
>       hashmap: use *_entry APIs for iteration
>       hashmap: hashmap_{put,remove} return hashmap_entry *
>       hashmap: introduce hashmap_free_entries
>       OFFSETOF_VAR macro to simplify hashmap iterators
>       hashmap: remove type arg from hashmap_{get,put,remove}_entry
>       hashmap_entry: remove first member requirement from docs
>
>  attr.c                              |  24 ++---
>  blame.c                             |  25 ++---
>  builtin/describe.c                  |  21 +++--
>  builtin/difftool.c                  |  56 +++++++-----
>  builtin/fast-export.c               |  15 ++-
>  builtin/fetch.c                     |  32 ++++---
>  config.c                            |  24 ++---
>  contrib/coccinelle/hashmap.cocci    |  16 ++++
>  diff.c                              |  31 ++++---
>  diffcore-rename.c                   |  15 ++-
>  git-compat-util.h                   |  38 ++++++++
>  hashmap.c                           |  58 +++++++-----
>  hashmap.h                           | 176 +++++++++++++++++++++++++++++=
=2D------
>  merge-recursive.c                   |  87 ++++++++++--------
>  merge-recursive.h                   |   4 +-
>  name-hash.c                         |  57 ++++++------
>  oidmap.c                            |  20 ++--
>  oidmap.h                            |   6 +-
>  packfile.c                          |  22 +++--
>  patch-ids.c                         |  18 ++--
>  range-diff.c                        |  10 +-
>  ref-filter.c                        |  33 ++++---
>  refs.c                              |  25 +++--
>  remote.c                            |  21 +++--
>  remote.h                            |   2 +-
>  revision.c                          |  28 +++---
>  sequencer.c                         |  44 ++++++---
>  sub-process.c                       |  20 ++--
>  sub-process.h                       |   6 +-
>  submodule-config.c                  |  52 ++++++-----
>  t/helper/test-hashmap.c             |  50 +++++-----
>  t/helper/test-lazy-init-name-hash.c |  12 +--
>  32 files changed, 667 insertions(+), 381 deletions(-)
>  create mode 100644 contrib/coccinelle/hashmap.cocci
>
> Range-diff against v2:
>  1:  51ba91d2f9 !  1:  0f530552de diff: use hashmap_entry_init on moved_=
entry.ent
>     @@ -10,6 +10,7 @@
>          hashmap_add callers to take "struct hashmap_entry *".
>
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
>
>       diff --git a/diff.c b/diff.c
>       --- a/diff.c
>  2:  be4071d33d !  2:  d12ddb4327 coccicheck: detect hashmap_entry.hash =
assignment
>     @@ -8,6 +8,7 @@
>          hashmap_entry_init, instead.
>
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
>
>       diff --git a/contrib/coccinelle/hashmap.cocci b/contrib/coccinelle=
/hashmap.cocci
>       new file mode 100644
>  3:  ff40a39bad !  3:  624b89fbb4 packfile: use hashmap_entry in delta_b=
ase_cache_entry
>     @@ -15,6 +15,7 @@
>          systems.
>
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
>
>       diff --git a/packfile.c b/packfile.c
>       --- a/packfile.c
>  4:  d1db0f6472 !  4:  7512f2f2f7 hashmap_entry_init takes "struct hashm=
ap_entry *"
>     @@ -8,6 +8,7 @@
>          safety and readability.
>
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
>
>       diff --git a/attr.c b/attr.c
>       --- a/attr.c
>     @@ -212,8 +213,8 @@
>        * and if it is on stack, you can just let it go out of scope).
>        */
>      -static inline void hashmap_entry_init(void *entry, unsigned int ha=
sh)
>     -+static inline void
>     -+hashmap_entry_init(struct hashmap_entry *e, unsigned int hash)
>     ++static inline void hashmap_entry_init(struct hashmap_entry *e,
>     ++					unsigned int hash)
>       {
>      -	struct hashmap_entry *e =3D entry;
>       	e->hash =3D hash;
>  5:  a293445e97 !  5:  dd167a1113 hashmap_get_next takes "const struct h=
ashmap_entry *"
>     @@ -6,6 +6,7 @@
>          now detects invalid types being passed.
>
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
>
>       diff --git a/diff.c b/diff.c
>       --- a/diff.c
>  6:  beabdab6fe !  6:  53f429ef6f hashmap_add takes "struct hashmap_entr=
y *"
>     @@ -6,6 +6,7 @@
>          detects invalid types being passed.
>
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
>
>       diff --git a/attr.c b/attr.c
>       --- a/attr.c
>  7:  99970934c7 !  7:  87739268dc hashmap_get takes "const struct hashma=
p_entry *"
>     @@ -6,6 +6,7 @@
>          now detects invalid types being passed.
>
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
>
>       diff --git a/attr.c b/attr.c
>       --- a/attr.c
>  8:  8148ed70eb !  8:  22226b3bb4 hashmap_remove takes "const struct has=
hmap_entry *"
>     @@ -6,6 +6,7 @@
>          now detects invalid types being passed.
>
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
>
>       diff --git a/blame.c b/blame.c
>       --- a/blame.c
>  9:  3756dcc34e !  9:  0b64282a1f hashmap_put takes "struct hashmap_entr=
y *"
>     @@ -6,6 +6,7 @@
>          detects invalid types being passed.
>
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
>
>       diff --git a/builtin/fast-export.c b/builtin/fast-export.c
>       --- a/builtin/fast-export.c
> 10:  ff586aa43c ! 10:  c2e9201838 introduce container_of macro
>     @@ -7,15 +7,16 @@
>          and chained hash tables while allowing the compiler to do
>          type checking.
>
>     -    I intend to use this to remove the limitation of "hashmap_entry=
"
>     -    being location-dependent and to allow more compile-time type
>     -    checking.
>     +    Later patches will use container_of() to remove the limitation
>     +    of "hashmap_entry" being location-dependent. This will complete
>     +    the transition to compile-time type checking for the hashmap AP=
I.
>
>          This macro already exists in our source as "list_entry" in
>          list.h and making "list_entry" an alias to "container_of"
>          as the Linux kernel has done is a possibility.
>
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
>
>       diff --git a/git-compat-util.h b/git-compat-util.h
>       --- a/git-compat-util.h
> 11:  931356f061 ! 11:  c709e607b1 hashmap_get_next returns "struct hashm=
ap_entry *"
>     @@ -6,6 +6,7 @@
>          hashmap_entry being the first field of a struct.
>
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
>
>       diff --git a/diff.c b/diff.c
>       --- a/diff.c
>     @@ -14,10 +15,10 @@
>       {
>       	int i;
>       	char *got_match =3D xcalloc(1, pmb_nr);
>     -+	struct hashmap_entry *ent =3D &match->ent;
>     ++	struct hashmap_entry *ent;
>
>      -	for (; match; match =3D hashmap_get_next(hm, &match->ent)) {
>     -+	for (; ent; ent =3D hashmap_get_next(hm, ent)) {
>     ++	for (ent =3D &match->ent; ent; ent =3D hashmap_get_next(hm, ent))=
 {
>      +		match =3D container_of(ent, struct moved_entry, ent);
>       		for (i =3D 0; i < pmb_nr; i++) {
>       			struct moved_entry *prev =3D pmb[i].match;
> 12:  a748b9b0c4 ! 12:  27ba68a7b8 hashmap: use *_entry APIs to wrap cont=
ainer_of
>     @@ -11,6 +11,7 @@
>          extra parameter to specify the type.
>
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
>
>       diff --git a/diff.c b/diff.c
>       --- a/diff.c
>     @@ -19,9 +20,9 @@
>       {
>       	int i;
>       	char *got_match =3D xcalloc(1, pmb_nr);
>     --	struct hashmap_entry *ent =3D &match->ent;
>     +-	struct hashmap_entry *ent;
>
>     --	for (; ent; ent =3D hashmap_get_next(hm, ent)) {
>     +-	for (ent =3D &match->ent; ent; ent =3D hashmap_get_next(hm, ent))=
 {
>      -		match =3D container_of(ent, struct moved_entry, ent);
>      +	hashmap_for_each_entry_from(hm, match, struct moved_entry, ent) {
>       		for (i =3D 0; i < pmb_nr; i++) {
>     @@ -125,7 +126,6 @@
>       #define container_of(ptr, type, member) \
>       	((type *) ((char *)(ptr) - offsetof(type, member)))
>
>     -+
>      +/*
>      + * helper function for `container_of_or_null' to avoid multiple
>      + * evaluation of @ptr
> 13:  e8faa5e12e ! 13:  222b1f07f3 hashmap_get{,_from_hash} return "struc=
t hashmap_entry *"
>     @@ -9,6 +9,7 @@
>          hashmap_entry being the first field in a struct.
>
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
>
>       diff --git a/attr.c b/attr.c
>       --- a/attr.c
>     @@ -152,11 +153,13 @@
>       }
>
>      -void *hashmap_get(const struct hashmap *map, const struct hashmap_=
entry *key,
>     -+struct hashmap_entry *
>     -+hashmap_get(const struct hashmap *map, const struct hashmap_entry =
*key,
>     - 		const void *keydata)
>     +-		const void *keydata)
>     ++struct hashmap_entry *hashmap_get(const struct hashmap *map,
>     ++				const struct hashmap_entry *key,
>     ++				const void *keydata)
>       {
>       	return *find_entry_ptr(map, key, keydata);
>     + }
>      @@
>       	/* lookup interned string in pool */
>       	hashmap_entry_init(&key.ent, memhash(data, len));
>     @@ -175,21 +178,27 @@
>        * to `hashmap_cmp_fn` to decide whether the entry matches the key=
.
>        */
>      -void *hashmap_get(const struct hashmap *map, const struct hashmap_=
entry *key,
>     -+struct hashmap_entry *
>     -+hashmap_get(const struct hashmap *map, const struct hashmap_entry =
*key,
>     - 			 const void *keydata);
>     +-			 const void *keydata);
>     ++struct hashmap_entry *hashmap_get(const struct hashmap *map,
>     ++				const struct hashmap_entry *key,
>     ++				const void *keydata);
>
>       /*
>     +  * Returns the hashmap entry for the specified hash code and key d=
ata,
>      @@
>        * `entry_or_key` parameter of `hashmap_cmp_fn` points to a hashma=
p_entry
>        * structure that should not be used in the comparison.
>        */
>      -static inline void *hashmap_get_from_hash(const struct hashmap *ma=
p,
>     -+static inline struct hashmap_entry *
>     -+hashmap_get_from_hash(const struct hashmap *map,
>     - 					  unsigned int hash,
>     - 					  const void *keydata)
>     +-					  unsigned int hash,
>     +-					  const void *keydata)
>     ++static inline struct hashmap_entry *hashmap_get_from_hash(
>     ++					const struct hashmap *map,
>     ++					unsigned int hash,
>     ++					const void *keydata)
>       {
>     + 	struct hashmap_entry key;
>     + 	hashmap_entry_init(&key, hash);
>
>       diff --git a/merge-recursive.c b/merge-recursive.c
>       --- a/merge-recursive.c
> 14:  f84bd96b8e ! 14:  c789f98c81 hashmap_cmp_fn takes hashmap_entry par=
ams
>     @@ -6,6 +6,7 @@
>          being the first member of a struct.
>
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
>
>       diff --git a/attr.c b/attr.c
>       --- a/attr.c
> 15:  23fbd888d9 ! 15:  57ae5b5142 hashmap: use *_entry APIs for iteratio=
n
>     @@ -7,6 +7,7 @@
>          by compilers lacking __typeof__ support.
>
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
>
>       diff --git a/attr.c b/attr.c
>       --- a/attr.c
> 16:  6908364381 ! 16:  f1e35ba094 hashmap: hashmap_{put,remove} return h=
ashmap_entry *
>     @@ -6,6 +6,7 @@
>          to simplify most callers.
>
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
>
>       diff --git a/hashmap.c b/hashmap.c
>       --- a/hashmap.c
>     @@ -15,18 +16,20 @@
>       }
>
>      -void *hashmap_remove(struct hashmap *map, const struct hashmap_ent=
ry *key,
>     -+struct hashmap_entry *
>     -+hashmap_remove(struct hashmap *map, const struct hashmap_entry *ke=
y,
>     - 		const void *keydata)
>     +-		const void *keydata)
>     ++struct hashmap_entry *hashmap_remove(struct hashmap *map,
>     ++					const struct hashmap_entry *key,
>     ++					const void *keydata)
>       {
>       	struct hashmap_entry *old;
>     + 	struct hashmap_entry **e =3D find_entry_ptr(map, key, keydata);
>      @@
>       	return old;
>       }
>
>      -void *hashmap_put(struct hashmap *map, struct hashmap_entry *entry=
)
>     -+struct hashmap_entry *
>     -+hashmap_put(struct hashmap *map, struct hashmap_entry *entry)
>     ++struct hashmap_entry *hashmap_put(struct hashmap *map,
>     ++				struct hashmap_entry *entry)
>       {
>       	struct hashmap_entry *old =3D hashmap_remove(map, entry, NULL);
>       	hashmap_add(map, entry);
>     @@ -39,8 +42,8 @@
>        * Returns the replaced entry, or NULL if not found (i.e. the entr=
y was added).
>        */
>      -void *hashmap_put(struct hashmap *map, struct hashmap_entry *entry=
);
>     -+struct hashmap_entry *
>     -+hashmap_put(struct hashmap *map, struct hashmap_entry *entry);
>     ++struct hashmap_entry *hashmap_put(struct hashmap *map,
>     ++				struct hashmap_entry *entry);
>      +
>      +#define hashmap_put_entry(map, keyvar, type, member) \
>      +	container_of_or_null(hashmap_put(map, &(keyvar)->member), type, m=
ember)
>     @@ -52,17 +55,17 @@
>        * Argument explanation is the same as in `hashmap_get`.
>        */
>      -void *hashmap_remove(struct hashmap *map, const struct hashmap_ent=
ry *key,
>     -+struct hashmap_entry *
>     -+hashmap_remove(struct hashmap *map, const struct hashmap_entry *ke=
y,
>     - 		const void *keydata);
>     -
>     +-		const void *keydata);
>     ++struct hashmap_entry *hashmap_remove(struct hashmap *map,
>     ++					const struct hashmap_entry *key,
>     ++					const void *keydata);
>     ++
>      +#define hashmap_remove_entry(map, keyvar, keydata, type, member) \
>      +	container_of_or_null(hashmap_remove(map, &(keyvar)->member, keyda=
ta), \
>      +				type, member)
>     -+
>     +
>       /*
>        * Returns the `bucket` an entry is stored in.
>     -  * Useful for multithreaded read access.
>
>       diff --git a/range-diff.c b/range-diff.c
>       --- a/range-diff.c
> 17:  150944128b ! 17:  adc7cb5516 hashmap: introduce hashmap_free_entrie=
s
>     @@ -12,6 +12,7 @@
>          the hashmap itself.
>
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
>
>       diff --git a/blame.c b/blame.c
>       --- a/blame.c
> 18:  de212aa6d6 ! 18:  1a68e1645d OFFSETOF_VAR macro to simplify hashmap=
 iterators
>     @@ -5,7 +5,7 @@
>          While we cannot rely on a `__typeof__' operator being portable
>          to use with `offsetof'; we can calculate the pointer offset
>          using an existing pointer and the address of a member using
>     -    pointer arithmetic.
>     +    pointer arithmetic for compilers without `__typeof__'.
>
>          This allows us to simplify usage of hashmap iterator macros
>          by not having to specify a type when a pointer of that type
>     @@ -16,7 +16,10 @@
>          trouble of using container_of/list_entry macros and without
>          relying on non-portable `__typeof__'.
>
>     +    v3: use `__typeof__' to avoid clang warnings
>     +
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
>
>       diff --git a/attr.c b/attr.c
>       --- a/attr.c
>     @@ -141,11 +144,17 @@
>       	(type *)container_of_or_null_offset(ptr, offsetof(type, member))
>
>      +/*
>     -+ * like offsetof(), but takes a pointer to type instead of the typ=
e
>     -+ * @ptr is subject to multiple evaluation since we can't rely on T=
YPEOF()
>     ++ * like offsetof(), but takes a pointer to a a variable of type wh=
ich
>     ++ * contains @member, instead of a specified type.
>     ++ * @ptr is subject to multiple evaluation since we can't rely on _=
_typeof__
>     ++ * everywhere.
>      + */
>     ++#if defined(__GNUC__) /* clang sets this, too */
>     ++#define OFFSETOF_VAR(ptr, member) offsetof(__typeof__(*ptr), membe=
r)
>     ++#else /* !__GNUC__ */
>      +#define OFFSETOF_VAR(ptr, member) \
>      +	((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))
>     ++#endif /* !__GNUC__ */
>      +
>       #endif
>
> 19:  212a596edd ! 19:  fe02b9f839 hashmap: remove type arg from hashmap_=
{get,put,remove}_entry
>     @@ -10,6 +10,7 @@
>          sequential as they are used as: `keyvar->member'
>
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
>
>       diff --git a/attr.c b/attr.c
>       --- a/attr.c
>     @@ -147,8 +148,8 @@
>        *                 printf("first: %ld %s\n", e->key, e->value);
>        *                 while ((e =3D hashmap_get_next_entry(&map, e,
>      @@
>     - struct hashmap_entry *
>     - hashmap_put(struct hashmap *map, struct hashmap_entry *entry);
>     + struct hashmap_entry *hashmap_put(struct hashmap *map,
>     + 				struct hashmap_entry *entry);
>
>      -#define hashmap_put_entry(map, keyvar, type, member) \
>      -	container_of_or_null(hashmap_put(map, &(keyvar)->member), type, m=
ember)
>     @@ -167,8 +168,8 @@
>       /*
>        * Removes a hashmap entry matching the specified key. If the hash=
map contains
>      @@
>     - hashmap_remove(struct hashmap *map, const struct hashmap_entry *ke=
y,
>     - 		const void *keydata);
>     + 					const struct hashmap_entry *key,
>     + 					const void *keydata);
>
>      -#define hashmap_remove_entry(map, keyvar, keydata, type, member) \
>      -	container_of_or_null(hashmap_remove(map, &(keyvar)->member, keyda=
ta), \
>  -:  ---------- > 20:  4ec5200646 hashmap_entry: remove first member req=
uirement from docs
>
>
