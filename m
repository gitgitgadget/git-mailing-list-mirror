Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 133851F453
	for <e@80x24.org>; Wed, 24 Apr 2019 15:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfDXPOn (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 11:14:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40010 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730510AbfDXPOn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 11:14:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id w20so11049155qka.7
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dq+eRemhk83SfDy34UMb3sjFRTZE3p2x9M95llTD8HM=;
        b=r5sjjYM39l47g+0/sUH7p1FAUzOCj2dcxRTtazyYcm+wPSeClkgaSMuxA+6Dd/iLSr
         XWpMXHHat7L0X/+ii6y1kODYYj/wFhQqmtGaPr9VERa8yuEwRahF3PArBlZWgw1VWCqi
         qA35322FtVCiVhuZln3pfiOnNlsEs89y5ODf3bJvStpAOUN0PJU5aMY371DRaMQ3Zg7p
         DMtzYYME3MGMc6lfxbOP37f4G7KJ9bVk7ntx0ZOgz/hR6MUbeFQNrrOX1CLskVy9pW9y
         aKTUpYmif126tZmaEOnWY70qvAJgEs2JOaX+G43V+DqeVs/wJKazLSji7o/iFTdOyAdP
         V0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dq+eRemhk83SfDy34UMb3sjFRTZE3p2x9M95llTD8HM=;
        b=g/JaLb9x+QWfeRIiBWnv/KfT3t9vJrE+f0uhP0tNpGHg3TPa+AG15pE7Gqh2JQGoA9
         z2XPoBMbZUGDvG0uH+NJsQMIJMfXIW0+IHk/9KH3uTweXpNmNvksFgrgNI0gdH0papr/
         coboEhFDAFqLno4JavNJrtzX5TOasMOAIGFTi/jRii9IosVnpW4KPr1ESfslY/ChBCHA
         XX9VYF4t9XtxeXYReBIqBv58DNFEQHyV7/Uo+PQrIqDDW/thfXAHWdjuw24x2Jsaq3i9
         xA+asBX9cEu45qTSnplw/sLcuWm54si8Zw1depPSRSsmmLqq7gqZUzP3eBQJYcamekrW
         /eQQ==
X-Gm-Message-State: APjAAAU/kgK7ApUvjOl5uflgfIM/YJcSwGjlO3GLte5ndY11XOFXWnww
        ip4j9PqI51QeADGzxqDwVIzvjgJf
X-Google-Smtp-Source: APXvYqyE0Y5mCGiJfYtSdw2eTpLzFwShVWb1z5wNWtiKA5XGC75O9d4q8/DgAo+aWJkuZF0u4SjLYQ==
X-Received: by 2002:a05:620a:14b2:: with SMTP id x18mr17987423qkj.19.1556118881748;
        Wed, 24 Apr 2019 08:14:41 -0700 (PDT)
Received: from stolee-gitdev.corp.microsoft.com ([2001:4898:8010:2:9efc:3578:ef3e:58d5])
        by smtp.gmail.com with ESMTPSA id j129sm9671005qkd.51.2019.04.24.08.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 08:14:40 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, avarab@gmail.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 00/11] Create 'expire' and 'repack' verbs for git-multi-pack-index
Date:   Wed, 24 Apr 2019 11:14:17 -0400
Message-Id: <20190424151428.170316-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.21.0.1096.g1c91fdc207
In-Reply-To: <pull.92.v4.git.gitgitgadget@gmail.com>
References: <pull.92.v4.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The multi-pack-index provides a fast way to find an object among a large list
of pack-files. It stores a single pack-reference for each object id, so
duplicate objects are ignored. Among a list of pack-files storing the same
object, the most-recently modified one is used.

Create new subcommands for the multi-pack-index builtin.

* 'git multi-pack-index expire': If we have a pack-file indexed by the
  multi-pack-index, but all objects in that pack are duplicated in
  more-recently modified packs, then delete that pack (and any others like it).
  Delete the reference to that pack in the multi-pack-index.

* 'git multi-pack-index repack --batch-size=<size>': Starting from the oldest
  pack-files covered by the multi-pack-index, find those whose "expected size"
  is below the batch size until we have a collection of packs whose expected
  sizes add up to the batch size. We compute the expected size by multiplying
  the number of referenced objects by the pack-size and dividing by the total
  number of objects in the pack. If the batch-size is zero, then select all
  packs. Create a new pack containing all objects that the multi-pack-index
  references to those packs.

This allows us to create a new pattern for repacking objects: run 'repack'.
After enough time has passed that all Git commands that started before the last
'repack' are finished, run 'expire' again. This approach has some advantages
over the existing "repack everything" model:

1. Incremental. We can repack a small batch of objects at a time, instead of
repacking all reachable objects. We can also limit ourselves to the objects
that do not appear in newer pack-files.

2. Highly Available. By adding a new pack-file (and not deleting the old
pack-files) we do not interrupt concurrent Git commands, and do not suffer
performance degradation. By expiring only pack-files that have no referenced
objects, we know that Git commands that are doing normal object lookups* will
not be interrupted.

* Note: if someone concurrently runs a Git command that uses get_all_packs(),
* then that command could try to read the pack-files and pack-indexes that we
* are deleting during an expire command. Such commands are usually related to
* object maintenance (i.e. fsck, gc, pack-objects) or are related to
* less-often-used features (i.e. fast-import, http-backend, server-info).

We **are using** this approach in VFS for Git to do background maintenance of
the "shared object cache" which is a Git alternate directory filled with
packfiles containing commits and trees. We currently download pack-files on an
hourly basis to keep up-to-date with the central server. The cache servers
supply packs on an hourly and daily basis, so most of the hourly packs become
useless after a new daily pack is downloaded. The 'expire' command would clear
out most of those packs, but many will still remain with fewer than 100 objects
remaining. The 'repack' command (with a batch size of 1-3gb, probably) can
condense the remaining packs in commands that run for 1-3 min at a time. Since
the daily packs range from 100-250mb, we will also combine and condense those
packs.

Updates in V5:

* Fixed the error in PATCH 7 due to a missing line that existed in PATCH 8. Thanks, Josh Steadmon!

* The 'repack' subcommand now computes the "expected size" of a pack instead of
  relying on the total size of the pack. This is actually really important to
  the way VFS for Git uses prefetch packs, and some packs are not being
  repacked because the pack size is larger than the batch size, but really
  there are only a few referenced objects.

* The 'repack' subcommand now allows a batch size of zero to mean "create one
  pack containing all objects in the multi-pack-index". A new commit adds a
  test that hits the boundary cases here, but follows the 'expire' subcommand
  so we can show that cycle of repack-then-expire to safely replace the packs.

Junio: It appears that there are some conflicts with the trace2 changes in
master. These are not new to the updates in this version. I saw how you
resolved these conflicts and replaying that resolution should work for you.

Thanks,
-Stolee

Derrick Stolee (11):
  repack: refactor pack deletion for future use
  Docs: rearrange subcommands for multi-pack-index
  multi-pack-index: prepare for 'expire' subcommand
  midx: simplify computation of pack name lengths
  midx: refactor permutation logic and pack sorting
  multi-pack-index: implement 'expire' subcommand
  multi-pack-index: prepare 'repack' subcommand
  midx: implement midx_repack()
  multi-pack-index: test expire while adding packs
  midx: add test that 'expire' respects .keep files
  t5319-multi-pack-index.sh: test batch size zero

 Documentation/git-multi-pack-index.txt |  32 +-
 builtin/multi-pack-index.c             |  14 +-
 builtin/repack.c                       |  14 +-
 midx.c                                 | 440 +++++++++++++++++++------
 midx.h                                 |   2 +
 packfile.c                             |  28 ++
 packfile.h                             |   7 +
 t/t5319-multi-pack-index.sh            | 184 +++++++++++
 8 files changed, 602 insertions(+), 119 deletions(-)


base-commit: 26aa9fc81d4c7f6c3b456a29da0b7ec72e5c6595
-- 
2.21.0.1096.g1c91fdc207

Range diff against v4:

 1:  62b393b816 =  1:  62b393b816 repack: refactor pack deletion for future use
 2:  7886785904 =  2:  7886785904 Docs: rearrange subcommands for multi-pack-index
 3:  628ca46036 =  3:  628ca46036 multi-pack-index: prepare for 'expire' subcommand
 4:  d55c1d7ee7 =  4:  d55c1d7ee7 midx: simplify computation of pack name lengths
 5:  3950743b96 =  5:  3950743b96 midx: refactor permutation logic and pack sorting
 6:  6691d97902 =  6:  6691d97902 multi-pack-index: implement 'expire' subcommand
 7:  f5a8ff21dd !  7:  e66e383231 multi-pack-index: prepare 'repack' subcommand
    @@ -42,14 +42,20 @@
      
     +repack::
     +	Create a new pack-file containing objects in small pack-files
    -+	referenced by the multi-pack-index. Select the pack-files by
    -+	examining packs from oldest-to-newest, adding a pack if its
    -+	size is below the batch size. Stop adding packs when the sum
    -+	of sizes of the added packs is above the batch size. If the
    -+	total size does not reach the batch size, then do nothing.
    -+	Rewrite the multi-pack-index to reference the new pack-file.
    -+	A later run of 'git multi-pack-index expire' will delete the
    -+	pack-files that were part of this batch.
    ++	referenced by the multi-pack-index. If the size given by the
    ++	`--batch-size=<size>` argument is zero, then create a pack
    ++	containing all objects referenced by the multi-pack-index. For
    ++	a non-zero batch size, Select the pack-files by examining packs
    ++	from oldest-to-newest, computing the "expected size" by counting
    ++	the number of objects in the pack referenced by the
    ++	multi-pack-index, then divide by the total number of objects in
    ++	the pack and multiply by the pack size. We select packs with
    ++	expected size below the batch size until the set of packs have
    ++	total expected size at least the batch size. If the total size
    ++	does not reach the batch size, then do nothing. If a new pack-
    ++	file is created, rewrite the multi-pack-index to reference the
    ++	new pack-file. A later run of 'git multi-pack-index expire' will
    ++	delete the pack-files that were part of this batch.
     +
      
      EXAMPLES
    @@ -130,6 +136,16 @@
      diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
      --- a/t/t5319-multi-pack-index.sh
      +++ b/t/t5319-multi-pack-index.sh
    +@@
    + 		git pack-objects --revs .git/objects/pack/pack-E <<-EOF &&
    + 		refs/heads/E
    + 		EOF
    +-		git multi-pack-index write
    ++		git multi-pack-index write &&
    ++		cp -r .git/objects/pack .git/objects/pack-backup
    + 	)
    + '
    + 
     @@
      	)
      '
 8:  ba1a1c7bbb !  8:  8e2a1140a5 midx: implement midx_repack()
    @@ -2,20 +2,35 @@
     
         midx: implement midx_repack()
     
    -    To repack using a multi-pack-index, first sort all pack-files by
    +    To repack with a non-zero batch-size, first sort all pack-files by
         their modified time. Second, walk those pack-files from oldest
    -    to newest, adding the packs to a list if they are smaller than the
    -    given pack-size. Finally, collect the objects from the multi-pack-
    -    index that are in those packs and send them to 'git pack-objects'.
    +    to newest, compute their expected size, and add the packs to a list
    +    if they are smaller than the given batch-size. Stop when the total
    +    expected size is at least the batch size.
    +
    +    If the batch size is zero, select all packs in the multi-pack-index.
    +
    +    Finally, collect the objects from the multi-pack-index that are in
    +    the selected packs and send them to 'git pack-objects'. Write a new
    +    multi-pack-index that includes the new pack.
    +
    +    Using a batch size of zero is very similar to a standard 'git repack'
    +    command, except that we do not delete the old packs and instead rely
    +    on the new multi-pack-index to prevent new processes from reading the
    +    old packs. This does not disrupt other Git processes that are currently
    +    reading the old packs based on the old multi-pack-index.
     
         While first designing a 'git multi-pack-index repack' operation, I
    -    started by collecting the batches based on the size of the objects
    -    instead of the size of the pack-files. This allows repacking a
    -    large pack-file that has very few referencd objects. However, this
    +    started by collecting the batches based on the actual size of the
    +    objects instead of the size of the pack-files. This allows repacking
    +    a large pack-file that has very few referencd objects. However, this
         came at a significant cost of parsing pack-files instead of simply
         reading the multi-pack-index and getting the file information for
    -    the pack-files. This object-size idea could be a direction for
    -    future expansion in this area.
    +    the pack-files. The "expected size" version provides similar
    +    behavior, but could skip a pack-file if the average object size is
    +    much larger than the actual size of the referenced objects, or
    +    can create a large pack if the actual size of the referenced objects
    +    is larger than the expected size.
     
         Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     
    @@ -35,69 +50,111 @@
      }
      
     -int midx_repack(const char *object_dir, size_t batch_size)
    -+struct time_and_id {
    ++struct repack_info {
     +	timestamp_t mtime;
    ++	uint32_t referenced_objects;
     +	uint32_t pack_int_id;
     +};
     +
     +static int compare_by_mtime(const void *a_, const void *b_)
      {
    -+	const struct time_and_id *a, *b;
    ++	const struct repack_info *a, *b;
     +
    -+	a = (const struct time_and_id *)a_;
    -+	b = (const struct time_and_id *)b_;
    ++	a = (const struct repack_info *)a_;
    ++	b = (const struct repack_info *)b_;
     +
     +	if (a->mtime < b->mtime)
     +		return -1;
     +	if (a->mtime > b->mtime)
     +		return 1;
    - 	return 0;
    - }
    ++	return 0;
    ++}
     +
    -+int midx_repack(const char *object_dir, size_t batch_size)
    ++static int fill_included_packs_all(struct multi_pack_index *m,
    ++				   unsigned char *include_pack)
     +{
    -+	int result = 0;
    -+	uint32_t i, packs_to_repack;
    -+	size_t total_size;
    -+	struct time_and_id *pack_ti;
    -+	unsigned char *include_pack;
    -+	struct child_process cmd = CHILD_PROCESS_INIT;
    -+	struct strbuf base_name = STRBUF_INIT;
    -+	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
    ++	uint32_t i;
     +
    -+	if (!m)
    -+		return 0;
    ++	for (i = 0; i < m->num_packs; i++)
    ++		include_pack[i] = 1;
     +
    -+	include_pack = xcalloc(m->num_packs, sizeof(unsigned char));
    -+	pack_ti = xcalloc(m->num_packs, sizeof(struct time_and_id));
    ++	return m->num_packs < 2;
    ++}
    ++
    ++static int fill_included_packs_batch(struct multi_pack_index *m,
    ++				     unsigned char *include_pack,
    ++				     size_t batch_size)
    ++{
    ++	uint32_t i, packs_to_repack;
    ++	size_t total_size;
    ++	struct repack_info *pack_info = xcalloc(m->num_packs, sizeof(struct repack_info));
     +
     +	for (i = 0; i < m->num_packs; i++) {
    -+		pack_ti[i].pack_int_id = i;
    ++		pack_info[i].pack_int_id = i;
     +
     +		if (prepare_midx_pack(m, i))
     +			continue;
     +
    -+		pack_ti[i].mtime = m->packs[i]->mtime;
    ++		pack_info[i].mtime = m->packs[i]->mtime;
    ++	}
    ++
    ++	for (i = 0; batch_size && i < m->num_objects; i++) {
    ++		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
    ++		pack_info[pack_int_id].referenced_objects++;
     +	}
    -+	QSORT(pack_ti, m->num_packs, compare_by_mtime);
    ++
    ++	QSORT(pack_info, m->num_packs, compare_by_mtime);
     +
     +	total_size = 0;
     +	packs_to_repack = 0;
     +	for (i = 0; total_size < batch_size && i < m->num_packs; i++) {
    -+		int pack_int_id = pack_ti[i].pack_int_id;
    ++		int pack_int_id = pack_info[i].pack_int_id;
     +		struct packed_git *p = m->packs[pack_int_id];
    ++		size_t expected_size;
     +
     +		if (!p)
     +			continue;
    -+		if (p->pack_size >= batch_size)
    ++		if (open_pack_index(p) || !p->num_objects)
    ++			continue;
    ++
    ++		expected_size = (size_t)(p->pack_size
    ++					 * pack_info[i].referenced_objects);
    ++		expected_size /= p->num_objects;
    ++
    ++		if (expected_size >= batch_size)
     +			continue;
     +
     +		packs_to_repack++;
    -+		total_size += p->pack_size;
    ++		total_size += expected_size;
     +		include_pack[pack_int_id] = 1;
     +	}
     +
    ++	free(pack_info);
    ++
     +	if (total_size < batch_size || packs_to_repack < 2)
    ++		return 1;
    ++
    + 	return 0;
    ++}	
    ++
    ++int midx_repack(const char *object_dir, size_t batch_size)
    ++{
    ++	int result = 0;
    ++	uint32_t i;
    ++	unsigned char *include_pack;
    ++	struct child_process cmd = CHILD_PROCESS_INIT;
    ++	struct strbuf base_name = STRBUF_INIT;
    ++	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
    ++
    ++	if (!m)
    ++		return 0;
    ++
    ++	include_pack = xcalloc(m->num_packs, sizeof(unsigned char));
    ++
    ++	if (batch_size) {
    ++		if (fill_included_packs_batch(m, include_pack, batch_size))
    ++			goto cleanup;
    ++	} else if (fill_included_packs_all(m, include_pack))
     +		goto cleanup;
     +
     +	argv_array_push(&cmd.args, "pack-objects");
    @@ -142,23 +199,12 @@
     +	if (m)
     +		close_midx(m);
     +	free(include_pack);
    -+	free(pack_ti);
     +	return result;
    -+}
    + }
     
      diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
      --- a/t/t5319-multi-pack-index.sh
      +++ b/t/t5319-multi-pack-index.sh
    -@@
    - 		git pack-objects --revs .git/objects/pack/pack-E <<-EOF &&
    - 		refs/heads/E
    - 		EOF
    --		git multi-pack-index write
    -+		git multi-pack-index write &&
    -+		cp -r .git/objects/pack .git/objects/pack-backup
    - 	)
    - '
    - 
     @@
      	)
      '
 9:  b1c6892417 =  9:  f1e4669bf6 multi-pack-index: test expire while adding packs
10:  481b08890f = 10:  b1e9df9980 midx: add test that 'expire' respects .keep files
 -:  ---------- > 11:  f6217e9fae t5319-multi-pack-index.sh: test batch size zero
