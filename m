Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BB42D2384
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996909; cv=none; b=Zb8/L0SWcAf1gM6vtmk2e0SsYMecan5M7HpqS6H1UgkxNP4Oiv5zA6J7D4SQ9aqmSkRIHovRUit3CAATkvLupvcHmmYnOUUOLP6xQuQ93ThxU1zFA2Cp788jLATwvIbvGotepfAXzR5cByjx7W5myTb1inZw55wvzIlP2eKYrC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996909; c=relaxed/simple;
	bh=f2xDGygvmfM+Ne/oZtt0aycCDkJUnzG9Z0/YcQsbX38=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=FXxHFq2IZeomwk8IdszyNfvaPa7tZc7SlJm/t25QvnUsI3/4FsUTfaAE6lv2rPT/ldS/heyfuU+qo2n/149IKjGiJJ5Fan9Dh0QKjDn/+t+rSlYVHM00RhJIy77UHnqDy6xKPPVEK6Dy+LQ1m+9/pEQ+m1ve2ybgAjgXQZhRVfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qvVD8O4k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R/kAuzJK; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qvVD8O4k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R/kAuzJK"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id BEF1B1D00120;
	Thu,  9 Oct 2025 04:01:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 09 Oct 2025 04:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759996904;
	 x=1760083304; bh=2BdS9e3lm8WiGYgVuBKZBv78W+v4iAexHPUBygO1zzQ=; b=
	qvVD8O4kyGF/GmtAgjXqr4f5v3WQci96+SS47iruItYrY1L2Q697OIoFMUh7alFD
	Zh+fj6ptQBebdrntMWqS0tvWhT8jNAPCWk0rtk5Mfr1b+G8z9HJ5PxvU2JtvFcrn
	/2+a/juNbsu/n6ynSWYbT/tCbBuh6kRLfpQbw0rB7XxezuGHEug1jjEYTwWxC91C
	IVyIPYPMEPxYCfnrEwCwmql1ODFX80oZJsQYSChMI9hJcakdFqw2gHaWPYmMs2Fb
	CVzjPGwgWYkbTgRIqwdm5pxl4nqbDP+eeqgaxDqi5SggGaoVTdAV02rCXvN/BOoX
	eLt4LytHHQXU7kIAZYONRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759996904; x=
	1760083304; bh=2BdS9e3lm8WiGYgVuBKZBv78W+v4iAexHPUBygO1zzQ=; b=R
	/kAuzJKDKzGcMzelm6b4RmQBhefJq3IgRuAdX/ZRlWI6sY5586a8Esu+U6WQo/8n
	A8w6HWlD8x0Js3PhXeqghNj5OeDdWloDODk8LF+TMd+i+XkQpUX0lHFqO/rx0gxE
	n81sQzKkDsI09+DpbpajJxI9EoC/8MfJMT76sp8sDPqqlIwFhfXdNUhR296hnmBL
	PnPwpMhyviIxCmd2PlPQciSdpNp2lZIkL8gxBRkIc3OaiKTCAAbGdH8Yw3+UTCbi
	qrwa5WtpRng9dnjQfMdNTeeexZdrdHX83AH0jl6xeopovL9eRQ2kg9T3qkas/6D7
	A+TaQ7JxC5BHXVy6Ntidg==
X-ME-Sender: <xms:6GvnaD5221ZeSiysk7E-ONU2gyPLqOwo60WleAx-wlnEf22auEZt1A>
    <xme:6GvnaO6raMUxCpwdMdT3HwN65BAQ4j_azPqiY284COohTk7QBDwTCKxtXistDdpYU
    wca5eR2PJgHE5YffRWnOYNENhjNHQD7FrE82bSp3MQzIqyuZUb6FA>
X-ME-Received: <xmr:6GvnaIH-uS_2B8kv_GnvNEZZStLpGaa3S-dn4hxgCWLjaQvxxF74IS43uVCQ5y14i-5WpV9DDfalWjmWsvT5zRnvXQuDl6Xo0Luq8Eyk7Uk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgjghfvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepteeuueehhffhiedtueehtddtieekfedtud
    ehtdehfefhgeffveeggedthfehuedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6GvnaPSLnxFgYFDtYIWT0jwf5opah_S_k2o2p11h8JWXOWXK5JmAgQ>
    <xmx:6GvnaJtMYl_rvJACtPe_0LmMGBX7GDY6nPCtELx0dNNFsyE8la-_2Q>
    <xmx:6GvnaGzLKZRdBILfcD1EGtwtCtH_yDZIxFIoRgrtPRsYH-Gp0Rfg8Q>
    <xmx:6GvnaL5Xs6351TmQ-DKoamdawdJEVg9J4vRkAEdUYFs_1Fuk88VmEg>
    <xmx:6GvnaJAztCZvOh7FpeX2jd5sOKYe9OhPyK7wZlbHKQbQtGf-bAtEic4T>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 04:01:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 105204aa (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 9 Oct 2025 08:01:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/6] packfile: remove `packfile_store_get_packs()`
Date: Thu, 09 Oct 2025 10:01:34 +0200
Message-Id: <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN5r52gC/4XNQQ6CMBCF4auQWTumjFLAlfcwLGoZYAJS0pJGQ
 7i7lQu4/F8m32wQ2AsHuGUbeI4SxM0p6JSBHczcM0qbGkhRoWrSuIwBF2PHTiYOaN0c2a/Y84p
 mmvBKF91pJm7rJyRj8dzJ+/AfTepBwur853gX8996yLlS5R855qgSXxGVuihNVd/T/Vle0Oz7/
 gUAHb1JxwAAAA==
X-Change-ID: 20250926-pks-packfiles-convert-get-all-4236f6e2ed9b
In-Reply-To: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
References: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

Hi,

this patch series follows up on the discussion at [1]. Originally, these
patches were part of the series that introduced the packfile store, but
we decided to split them out into a separate series.

In any case, the goal of this series is to remove the confusing
difference between `packfiles_store_get_{,all_}packs()`. It's not really
obvious to the caller what the difference is. But even worse, the result
of these functions depends on whether or not `get_all_packs()` was ever
executed before `get_packs()`.

The series is built on top of 821f583da6 (The thirteenth batcn,
2025-09-29) with tb/incremental-midx-part-3.1 at c886af90f8 (SQUASH???
play well with other topics by preemptively including "repository.h",
2025-09-29) merged into it. This is done to fix some minor conflicts
with that patch series.

Changes in v2:
  - Some commit message improvements.
  - Adapt `packfile_store_for_each_pack()` to `repo_for_each_pack()`. On
    the one hand this provides easier ergonomics. On the other hand this
    will eventually allow us to handle object databases of a different
    type more easily.
  - Link to v1: https://lore.kernel.org/r/20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im

Thanks!

Patrick

[1]: <aK5hpwcCgjkgQB1N@nand.local>

---
Patrick Steinhardt (6):
      object-name: convert to use `packfile_store_get_all_packs()`
      builtin/gc: convert to use `packfile_store_get_all_packs()`
      builtin/grep: simplify how we preload packs
      packfile: drop `packfile_store_get_packs()`
      packfile: introduce macro to iterate through packs
      packfile: rename `packfile_store_get_all_packs()`

 builtin/cat-file.c          |  3 +--
 builtin/count-objects.c     |  3 +--
 builtin/fast-import.c       |  4 ++--
 builtin/fsck.c              | 15 ++++++---------
 builtin/gc.c                | 16 +++++++---------
 builtin/grep.c              |  2 +-
 builtin/pack-objects.c      | 26 +++++++++-----------------
 builtin/pack-redundant.c    | 14 ++++----------
 connected.c                 |  3 +--
 http-backend.c              |  5 ++---
 http.c                      |  3 +--
 object-name.c               |  8 +++++---
 pack-bitmap.c               |  6 +++---
 pack-objects.c              |  5 ++---
 packfile.c                  | 10 ++--------
 packfile.h                  | 10 ++++++----
 repack-cruft.c              |  3 +--
 repack-geometry.c           |  3 +--
 repack.c                    |  3 +--
 server-info.c               |  3 +--
 t/helper/test-find-pack.c   |  3 ++-
 t/helper/test-pack-mtimes.c |  2 +-
 22 files changed, 60 insertions(+), 90 deletions(-)

Range-diff versus v1:

1:  c52009c363 = 1:  04550dbdcf object-name: convert to use `packfile_store_get_all_packs()`
2:  20389a8027 ! 2:  2677bc631f builtin/gc: convert to use `packfile_store_get_all_packs()`
    @@ Commit message
         The auto-condition for this task checks how many packfiles there are
         that aren't indexed by any multi-pack index. If there is a sufficient
         number then we execute the above command to combine those into a single
    -    pack and add them to the MIDX.
    +    pack and add that pack to the MIDX.
     
         As we don't care about MIDX'd packs we use `packfile_store_get_packs()`,
         which knows to not load any packs that are indexed by a MIDX. But as
         explained in the preceding commit, we want to get rid of that function.
     
    -    We already handle packfiles that have an MIDX alright by the very nature
    -    of this function, as we explicitly count non-MIDX'd packs. As such, we
    -    can trivially switch over to use `packfile_store_get_all_packs()`
    -    instead.
    +    We already handle packfiles that have a MIDX by the very nature of this
    +    function, as we explicitly count non-MIDX'd packs. As such, we can
    +    trivially switch over to use `packfile_store_get_all_packs()` instead.
     
         Do so.
     
3:  1357bdce48 ! 3:  7bee72fd98 builtin/grep: simplify how we preload packs
    @@ Commit message
         such packfile. This pointer is ignored though, as all we really care
         about is that `packfile_store_prepare()` was called.
     
    -    Historyically, that function was file-local to "packfile.c", but that
    +    Historically, that function was file-local to "packfile.c", but that
         changed with 4188332569 (packfile: move `get_multi_pack_index()` into
         "midx.c", 2025-09-02). We can thus simplify the code by calling that
         function directly.
4:  f2275c97ae = 4:  e709bd4ac9 packfile: drop `packfile_store_get_packs()`
5:  6e57bdd081 ! 5:  2000ef6983 packfile: introduce macro to iterate through packs
    @@ Commit message
         packs of a given `struct packfile_store`. This pattern is somewhat
         verbose and repetitive, which makes it somewhat cumbersome.
     
    -    Introduce a new macro `packfile_store_for_each_pack()` that removes some
    -    of the boilerplate.
    +    Introduce a new macro `repo_for_each_pack()` that removes some of the
    +    boilerplate.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/cat-file.c ##
     @@ builtin/cat-file.c: static void batch_each_object(struct batch_options *opt,
    - 		struct packfile_store *packs = the_repository->objects->packfiles;
    + 
    + 	if (bitmap && !for_each_bitmapped_object(bitmap, &opt->objects_filter,
    + 						 batch_one_object_bitmapped, &payload)) {
    +-		struct packfile_store *packs = the_repository->objects->packfiles;
      		struct packed_git *pack;
      
     -		for (pack = packfile_store_get_all_packs(packs); pack; pack = pack->next) {
    -+		packfile_store_for_each_pack(packs, pack) {
    ++		repo_for_each_pack(the_repository, pack) {
      			if (bitmap_index_contains_pack(bitmap, pack) ||
      			    open_pack_index(pack))
      				continue;
     
      ## builtin/count-objects.c ##
    +@@ builtin/count-objects.c: int cmd_count_objects(int argc,
    + 				      count_loose, count_cruft, NULL, NULL);
    + 
    + 	if (verbose) {
    +-		struct packfile_store *packs = the_repository->objects->packfiles;
    + 		struct packed_git *p;
    + 		unsigned long num_pack = 0;
    + 		off_t size_pack = 0;
     @@ builtin/count-objects.c: int cmd_count_objects(int argc,
      		struct strbuf pack_buf = STRBUF_INIT;
      		struct strbuf garbage_buf = STRBUF_INIT;
      
     -		for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
    -+		packfile_store_for_each_pack(packs, p) {
    ++		repo_for_each_pack(the_repository, p) {
      			if (!p->pack_local)
      				continue;
      			if (open_pack_index(p))
     
      ## builtin/fsck.c ##
    -@@ builtin/fsck.c: static int check_pack_rev_indexes(struct repository *r, int show_progress)
    +@@ builtin/fsck.c: static int mark_packed_for_connectivity(const struct object_id *oid,
    + 
    + static int check_pack_rev_indexes(struct repository *r, int show_progress)
      {
    - 	struct packfile_store *packs = r->objects->packfiles;
    +-	struct packfile_store *packs = r->objects->packfiles;
      	struct progress *progress = NULL;
     +	struct packed_git *p;
      	uint32_t pack_count = 0;
    @@ builtin/fsck.c: static int check_pack_rev_indexes(struct repository *r, int show
      
      	if (show_progress) {
     -		for (struct packed_git *p = packfile_store_get_all_packs(packs); p; p = p->next)
    -+		packfile_store_for_each_pack(packs, p)
    ++		repo_for_each_pack(r, p)
      			pack_count++;
      		progress = start_delayed_progress(the_repository,
      						  "Verifying reverse pack-indexes", pack_count);
    @@ builtin/fsck.c: static int check_pack_rev_indexes(struct repository *r, int show
      	}
      
     -	for (struct packed_git *p = packfile_store_get_all_packs(packs); p; p = p->next) {
    -+	packfile_store_for_each_pack(packs, p) {
    ++	repo_for_each_pack(r, p) {
      		int load_error = load_pack_revindex_from_disk(p);
      
      		if (load_error < 0) {
    +@@ builtin/fsck.c: int cmd_fsck(int argc,
    + 		for_each_packed_object(the_repository,
    + 				       mark_packed_for_connectivity, NULL, 0);
    + 	} else {
    +-		struct packfile_store *packs = the_repository->objects->packfiles;
    +-
    + 		odb_prepare_alternates(the_repository->objects);
    + 		for (source = the_repository->objects->sources; source; source = source->next)
    + 			fsck_source(source);
     @@ builtin/fsck.c: int cmd_fsck(int argc,
      			struct progress *progress = NULL;
      
      			if (show_progress) {
     -				for (p = packfile_store_get_all_packs(packs); p;
     -				     p = p->next) {
    -+				packfile_store_for_each_pack(packs, p) {
    ++				repo_for_each_pack(the_repository, p) {
      					if (open_pack_index(p))
      						continue;
      					total += p->num_objects;
    @@ builtin/fsck.c: int cmd_fsck(int argc,
     -			for (p = packfile_store_get_all_packs(packs); p;
     -			     p = p->next) {
     +
    -+			packfile_store_for_each_pack(packs, p) {
    ++			repo_for_each_pack(the_repository, p) {
      				/* verify gives error messages itself */
      				if (verify_pack(the_repository,
      						p, fsck_obj_buffer,
     
      ## builtin/gc.c ##
    -@@ builtin/gc.c: static struct packed_git *find_base_packs(struct string_list *packs,
    - 	struct packfile_store *packfiles = the_repository->objects->packfiles;
    +@@ builtin/gc.c: static int too_many_loose_objects(struct gc_config *cfg)
    + static struct packed_git *find_base_packs(struct string_list *packs,
    + 					  unsigned long limit)
    + {
    +-	struct packfile_store *packfiles = the_repository->objects->packfiles;
      	struct packed_git *p, *base = NULL;
      
     -	for (p = packfile_store_get_all_packs(packfiles); p; p = p->next) {
    -+	packfile_store_for_each_pack(packfiles, p) {
    ++	repo_for_each_pack(the_repository, p) {
      		if (!p->pack_local || p->is_cruft)
      			continue;
      		if (limit) {
    -@@ builtin/gc.c: static int too_many_packs(struct gc_config *cfg)
    +@@ builtin/gc.c: static struct packed_git *find_base_packs(struct string_list *packs,
    + 
    + static int too_many_packs(struct gc_config *cfg)
      {
    - 	struct packfile_store *packs = the_repository->objects->packfiles;
    +-	struct packfile_store *packs = the_repository->objects->packfiles;
      	struct packed_git *p;
     -	int cnt;
     +	int cnt = 0;
    @@ builtin/gc.c: static int too_many_packs(struct gc_config *cfg)
      		return 0;
      
     -	for (cnt = 0, p = packfile_store_get_all_packs(packs); p; p = p->next) {
    -+	packfile_store_for_each_pack(packs, p) {
    ++	repo_for_each_pack(the_repository, p) {
      		if (!p->pack_local)
      			continue;
      		if (p->pack_keep)
    @@ builtin/gc.c: static int incremental_repack_auto_condition(struct gc_config *cfg
     -	for (p = packfile_store_get_all_packs(the_repository->objects->packfiles);
     -	     count < incremental_repack_auto_limit && p;
     -	     p = p->next) {
    -+	packfile_store_for_each_pack(the_repository->objects->packfiles, p) {
    ++	repo_for_each_pack(the_repository, p) {
     +		if (count >= incremental_repack_auto_limit)
     +			break;
      		if (!p->multi_pack_index)
    @@ builtin/gc.c: static off_t get_auto_pack_size(void)
      
      	odb_reprepare(r->objects);
     -	for (p = packfile_store_get_all_packs(r->objects->packfiles); p; p = p->next) {
    -+	packfile_store_for_each_pack(r->objects->packfiles, p) {
    ++	repo_for_each_pack(r, p) {
      		if (p->pack_size > max_size) {
      			second_largest_size = max_size;
      			max_size = p->pack_size;
     
      ## builtin/pack-objects.c ##
    +@@ builtin/pack-objects.c: static int pack_mtime_cmp(const void *_a, const void *_b)
    + 
    + static void read_packs_list_from_stdin(struct rev_info *revs)
    + {
    +-	struct packfile_store *packs = the_repository->objects->packfiles;
    + 	struct strbuf buf = STRBUF_INIT;
    + 	struct string_list include_packs = STRING_LIST_INIT_DUP;
    + 	struct string_list exclude_packs = STRING_LIST_INIT_DUP;
    + 	struct string_list_item *item = NULL;
    +-
    + 	struct packed_git *p;
    + 
    + 	while (strbuf_getline(&buf, stdin) != EOF) {
     @@ builtin/pack-objects.c: static void read_packs_list_from_stdin(struct rev_info *revs)
      	string_list_sort(&exclude_packs);
      	string_list_remove_duplicates(&exclude_packs, 0);
      
     -	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
    -+	packfile_store_for_each_pack(packs, p) {
    ++	repo_for_each_pack(the_repository, p) {
      		const char *pack_name = pack_basename(p);
      
      		if ((item = string_list_lookup(&include_packs, pack_name)))
    +@@ builtin/pack-objects.c: static void enumerate_cruft_objects(void)
    + 
    + static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs)
    + {
    +-	struct packfile_store *packs = the_repository->objects->packfiles;
    + 	struct packed_git *p;
    + 	struct rev_info revs;
    + 	int ret;
     @@ builtin/pack-objects.c: static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
      	 * Re-mark only the fresh packs as kept so that objects in
      	 * unknown packs do not halt the reachability traversal early.
      	 */
     -	for (p = packfile_store_get_all_packs(packs); p; p = p->next)
    -+	packfile_store_for_each_pack(packs, p)
    ++	repo_for_each_pack(the_repository, p)
      		p->pack_keep_in_core = 0;
      	mark_pack_kept_in_core(fresh_packs, 1);
      
    +@@ builtin/pack-objects.c: static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
    + 
    + static void read_cruft_objects(void)
    + {
    +-	struct packfile_store *packs = the_repository->objects->packfiles;
    + 	struct strbuf buf = STRBUF_INIT;
    + 	struct string_list discard_packs = STRING_LIST_INIT_DUP;
    + 	struct string_list fresh_packs = STRING_LIST_INIT_DUP;
     @@ builtin/pack-objects.c: static void read_cruft_objects(void)
      	string_list_sort(&discard_packs);
      	string_list_sort(&fresh_packs);
      
     -	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
    -+	packfile_store_for_each_pack(packs, p) {
    ++	repo_for_each_pack(the_repository, p) {
      		const char *pack_name = pack_basename(p);
      		struct string_list_item *item;
      
    -@@ builtin/pack-objects.c: static void loosen_unused_packed_objects(void)
    +@@ builtin/pack-objects.c: static int loosened_object_can_be_discarded(const struct object_id *oid,
    + 
    + static void loosen_unused_packed_objects(void)
    + {
    +-	struct packfile_store *packs = the_repository->objects->packfiles;
    + 	struct packed_git *p;
    + 	uint32_t i;
      	uint32_t loosened_objects_nr = 0;
      	struct object_id oid;
      
     -	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
    -+	packfile_store_for_each_pack(packs, p) {
    ++	repo_for_each_pack(the_repository, p) {
      		if (!p->pack_local || p->pack_keep || p->pack_keep_in_core)
      			continue;
      
    -@@ builtin/pack-objects.c: static void add_extra_kept_packs(const struct string_list *names)
    +@@ builtin/pack-objects.c: static void get_object_list(struct rev_info *revs, struct strvec *argv)
    + 
    + static void add_extra_kept_packs(const struct string_list *names)
    + {
    +-	struct packfile_store *packs = the_repository->objects->packfiles;
    + 	struct packed_git *p;
    + 
      	if (!names->nr)
      		return;
      
     -	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
    -+	packfile_store_for_each_pack(packs, p) {
    ++	repo_for_each_pack(the_repository, p) {
      		const char *name = basename(p->pack_name);
      		int i;
      
     @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
    - 		struct packfile_store *packs = the_repository->objects->packfiles;
    + 
    + 	add_extra_kept_packs(&keep_pack_list);
    + 	if (ignore_packed_keep_on_disk) {
    +-		struct packfile_store *packs = the_repository->objects->packfiles;
      		struct packed_git *p;
      
     -		for (p = packfile_store_get_all_packs(packs); p; p = p->next)
    -+		packfile_store_for_each_pack(packs, p)
    ++		repo_for_each_pack(the_repository, p)
      			if (p->pack_local && p->pack_keep)
      				break;
      		if (!p) /* no keep-able packs found */
     @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
    - 		struct packfile_store *packs = the_repository->objects->packfiles;
    + 		 * want to unset "local" based on looking at packs, as
    + 		 * it also covers non-local objects
    + 		 */
    +-		struct packfile_store *packs = the_repository->objects->packfiles;
      		struct packed_git *p;
      
     -		for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
    -+		packfile_store_for_each_pack(packs, p) {
    ++		repo_for_each_pack(the_repository, p) {
      			if (!p->pack_local) {
      				have_non_local_packs = 1;
      				break;
     
      ## builtin/pack-redundant.c ##
     @@ builtin/pack-redundant.c: static struct pack_list * add_pack(struct packed_git *p)
    + 
      static struct pack_list * add_pack_file(const char *filename)
      {
    - 	struct packfile_store *packs = the_repository->objects->packfiles;
    +-	struct packfile_store *packs = the_repository->objects->packfiles;
     -	struct packed_git *p = packfile_store_get_all_packs(packs);
     +	struct packed_git *p;
      
    @@ builtin/pack-redundant.c: static struct pack_list * add_pack(struct packed_git *
      		die("Bad pack filename: %s", filename);
      
     -	while (p) {
    -+	packfile_store_for_each_pack(packs, p)
    ++	repo_for_each_pack(the_repository, p)
      		if (strstr(p->pack_name, filename))
      			return add_pack(p);
     -		p = p->next;
    @@ builtin/pack-redundant.c: static struct pack_list * add_pack(struct packed_git *
      
      static void load_all(void)
      {
    - 	struct packfile_store *packs = the_repository->objects->packfiles;
    +-	struct packfile_store *packs = the_repository->objects->packfiles;
     -	struct packed_git *p = packfile_store_get_all_packs(packs);
     +	struct packed_git *p;
      
     -	while (p) {
    -+	packfile_store_for_each_pack(packs, p)
    ++	repo_for_each_pack(the_repository, p)
      		add_pack(p);
     -		p = p->next;
     -	}
    @@ builtin/pack-redundant.c: static struct pack_list * add_pack(struct packed_git *
     
      ## connected.c ##
     @@ connected.c: int check_connected(oid_iterate_fn fn, void *cb_data,
    - 			struct packfile_store *packs = the_repository->objects->packfiles;
    + 		 */
    + 		odb_reprepare(the_repository->objects);
    + 		do {
    +-			struct packfile_store *packs = the_repository->objects->packfiles;
      			struct packed_git *p;
      
     -			for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
    -+			packfile_store_for_each_pack(packs, p) {
    ++			repo_for_each_pack(the_repository, p) {
      				if (!p->pack_promisor)
      					continue;
      				if (find_pack_entry_one(oid, p))
     
      ## http-backend.c ##
    -@@ http-backend.c: static void get_info_packs(struct strbuf *hdr, char *arg UNUSED)
    +@@ http-backend.c: static void get_head(struct strbuf *hdr, char *arg UNUSED)
    + static void get_info_packs(struct strbuf *hdr, char *arg UNUSED)
    + {
    + 	size_t objdirlen = strlen(repo_get_object_directory(the_repository));
    +-	struct packfile_store *packs = the_repository->objects->packfiles;
    + 	struct strbuf buf = STRBUF_INIT;
    + 	struct packed_git *p;
      	size_t cnt = 0;
      
      	select_getanyfile(hdr);
     -	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
    -+	packfile_store_for_each_pack(packs, p) {
    ++	repo_for_each_pack(the_repository, p) {
      		if (p->pack_local)
      			cnt++;
      	}
      
      	strbuf_grow(&buf, cnt * 53 + 2);
     -	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
    -+	packfile_store_for_each_pack(packs, p) {
    ++	repo_for_each_pack(the_repository, p) {
      		if (p->pack_local)
      			strbuf_addf(&buf, "P %s\n", p->pack_name + objdirlen + 6);
      	}
     
      ## http.c ##
    +@@ http.c: static char *fetch_pack_index(unsigned char *hash, const char *base_url)
    + static int fetch_and_setup_pack_index(struct packed_git **packs_head,
    + 	unsigned char *sha1, const char *base_url)
    + {
    +-	struct packfile_store *packs = the_repository->objects->packfiles;
    + 	struct packed_git *new_pack, *p;
    + 	char *tmp_idx = NULL;
    + 	int ret;
     @@ http.c: static int fetch_and_setup_pack_index(struct packed_git **packs_head,
      	 * If we already have the pack locally, no need to fetch its index or
      	 * even add it to list; we already have all of its objects.
      	 */
     -	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
    -+	packfile_store_for_each_pack(packs, p) {
    ++	repo_for_each_pack(the_repository, p) {
      		if (hasheq(p->hash, sha1, the_repository->hash_algo))
      			return 0;
      	}
    @@ object-name.c: static void find_short_packed_object(struct disambiguate_state *d
      
     -	for (p = packfile_store_get_all_packs(ds->repo->objects->packfiles); p && !ds->ambiguous;
     -	     p = p->next)
    -+	packfile_store_for_each_pack(ds->repo->objects->packfiles, p) {
    ++	repo_for_each_pack(ds->repo, p) {
     +		if (ds->ambiguous)
     +			break;
      		unique_in_pack(p, ds);
    @@ object-name.c: static void find_abbrev_len_packed(struct min_abbrev_data *mad)
      	}
      
     -	for (p = packfile_store_get_all_packs(mad->repo->objects->packfiles); p; p = p->next)
    -+	packfile_store_for_each_pack(mad->repo->objects->packfiles, p)
    ++	repo_for_each_pack(mad->repo, p)
      		find_abbrev_len_for_pack(p, mad);
      }
      
    @@ pack-bitmap.c: static int open_pack_bitmap(struct repository *r,
      	int ret = -1;
      
     -	for (p = packfile_store_get_all_packs(r->objects->packfiles); p; p = p->next) {
    -+	packfile_store_for_each_pack(r->objects->packfiles, p) {
    ++	repo_for_each_pack(r, p) {
      		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
      			ret = 0;
      			/*
    @@ pack-bitmap.c: int verify_bitmap_files(struct repository *r)
      
     -	for (struct packed_git *p = packfile_store_get_all_packs(r->objects->packfiles);
     -	     p; p = p->next) {
    -+	packfile_store_for_each_pack(r->objects->packfiles, p) {
    ++	repo_for_each_pack(r, p) {
      		char *pack_bitmap_name = pack_bitmap_filename(p);
      		res |= verify_bitmap_file(r->hash_algo, pack_bitmap_name);
      		free(pack_bitmap_name);
     
      ## pack-objects.c ##
    +@@ pack-objects.c: struct object_entry *packlist_find(struct packing_data *pdata,
    + 
    + static void prepare_in_pack_by_idx(struct packing_data *pdata)
    + {
    +-	struct packfile_store *packs = pdata->repo->objects->packfiles;
    + 	struct packed_git **mapping, *p;
    + 	int cnt = 0, nr = 1U << OE_IN_PACK_BITS;
    + 
     @@ pack-objects.c: static void prepare_in_pack_by_idx(struct packing_data *pdata)
      	 * (i.e. in_pack_idx also zero) should return NULL.
      	 */
      	mapping[cnt++] = NULL;
     -	for (p = packfile_store_get_all_packs(packs); p; p = p->next, cnt++) {
    -+	packfile_store_for_each_pack(packs, p) {
    ++	repo_for_each_pack(pdata->repo, p) {
      		if (cnt == nr) {
      			free(mapping);
      			return;
    @@ packfile.c: struct packed_git **kept_pack_cache(struct repository *r, unsigned f
      		 * the non-kept version.
      		 */
     -		for (p = packfile_store_get_all_packs(r->objects->packfiles); p; p = p->next) {
    -+		packfile_store_for_each_pack(r->objects->packfiles, p) {
    ++		repo_for_each_pack(r, p) {
      			if ((p->pack_keep && (flags & ON_DISK_KEEP_PACKS)) ||
      			    (p->pack_keep_in_core && (flags & IN_CORE_KEEP_PACKS))) {
      				ALLOC_GROW(packs, nr + 1, alloc);
    @@ packfile.c: int for_each_packed_object(struct repository *repo, each_packed_obje
      	int pack_errors = 0;
      
     -	for (p = packfile_store_get_all_packs(repo->objects->packfiles); p; p = p->next) {
    -+	packfile_store_for_each_pack(repo->objects->packfiles, p) {
    ++	repo_for_each_pack(repo, p) {
      		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
      			continue;
      		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
    @@ packfile.h: void packfile_store_reprepare(struct packfile_store *store);
      			     struct packed_git *pack);
      
     +/*
    -+ * Load and iterate through all packs of the given packfile store.
    ++ * Load and iterate through all packs of the given repository. This helper
    ++ * function will yield packfiles from all object sources connected to the
    ++ * repository.
     + */
    -+#define packfile_store_for_each_pack(store, p) \
    -+	for (p = packfile_store_get_all_packs(store); p; p = p->next)
    ++#define repo_for_each_pack(repo, p) \
    ++	for (p = packfile_store_get_all_packs(repo->objects->packfiles); p; p = p->next)
     +
      /*
       * Get all packs managed by the given store, including packfiles that are
       * referenced by multi-pack indices.
     
      ## repack-cruft.c ##
    -@@ repack-cruft.c: static void combine_small_cruft_packs(FILE *in, off_t combine_cruft_below_size,
    +@@
    + static void combine_small_cruft_packs(FILE *in, off_t combine_cruft_below_size,
    + 				      struct existing_packs *existing)
    + {
    +-	struct packfile_store *packs = existing->repo->objects->packfiles;
    + 	struct packed_git *p;
      	struct strbuf buf = STRBUF_INIT;
      	size_t i;
      
     -	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
    -+	packfile_store_for_each_pack(packs, p) {
    ++	repo_for_each_pack(existing->repo, p) {
      		if (!(p->is_cruft && p->pack_local))
      			continue;
      
     
      ## repack-geometry.c ##
     @@ repack-geometry.c: void pack_geometry_init(struct pack_geometry *geometry,
    + 			struct existing_packs *existing,
    + 			const struct pack_objects_args *args)
    + {
    +-	struct packfile_store *packs = existing->repo->objects->packfiles;
      	struct packed_git *p;
      	struct strbuf buf = STRBUF_INIT;
      
     -	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
    -+	packfile_store_for_each_pack(packs, p) {
    ++	repo_for_each_pack(existing->repo, p) {
      		if (args->local && !p->pack_local)
      			/*
      			 * When asked to only repack local packfiles we skip
     
      ## repack.c ##
    -@@ repack.c: void existing_packs_collect(struct existing_packs *existing,
    +@@ repack.c: int finish_pack_objects_cmd(const struct git_hash_algo *algop,
    + void existing_packs_collect(struct existing_packs *existing,
    + 			    const struct string_list *extra_keep)
    + {
    +-	struct packfile_store *packs = existing->repo->objects->packfiles;
      	struct packed_git *p;
      	struct strbuf buf = STRBUF_INIT;
      
     -	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
    -+	packfile_store_for_each_pack(packs, p) {
    ++	repo_for_each_pack(existing->repo, p) {
      		size_t i;
      		const char *base;
      
     
      ## server-info.c ##
    -@@ server-info.c: static void init_pack_info(struct repository *r, const char *infofile, int force
    +@@ server-info.c: static int compare_info(const void *a_, const void *b_)
    + 
    + static void init_pack_info(struct repository *r, const char *infofile, int force)
    + {
    +-	struct packfile_store *packs = r->objects->packfiles;
    + 	struct packed_git *p;
    + 	int stale;
      	int i;
      	size_t alloc = 0;
      
     -	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
    -+	packfile_store_for_each_pack(packs, p) {
    ++	repo_for_each_pack(r, p) {
      		/* we ignore things on alternate path since they are
      		 * not available to the pullers in general.
      		 */
    @@ t/helper/test-find-pack.c: int cmd__find_pack(int argc, const char **argv)
      		die("cannot parse %s as an object name", argv[0]);
      
     -	for (p = packfile_store_get_all_packs(the_repository->objects->packfiles); p; p = p->next)
    -+	packfile_store_for_each_pack(the_repository->objects->packfiles, p) {
    ++	repo_for_each_pack(the_repository, p) {
      		if (find_pack_entry_one(&oid, p)) {
      			printf("%s\n", p->pack_name);
      			actual_count++;
    @@ t/helper/test-pack-mtimes.c: int cmd__pack_mtimes(int argc, const char **argv)
      		usage(pack_mtimes_usage);
      
     -	for (p = packfile_store_get_all_packs(the_repository->objects->packfiles); p; p = p->next) {
    -+	packfile_store_for_each_pack(the_repository->objects->packfiles, p) {
    ++	repo_for_each_pack(the_repository, p) {
      		strbuf_addstr(&buf, basename(p->pack_name));
      		strbuf_strip_suffix(&buf, ".pack");
      		strbuf_addstr(&buf, ".mtimes");
6:  ceceb9cc71 ! 6:  a688fef987 packfile: rename `packfile_store_get_all_packs()`
    @@ packfile.c: void packfile_store_reprepare(struct packfile_store *store)
     
      ## packfile.h ##
     @@ packfile.h: void packfile_store_add_pack(struct packfile_store *store,
    -  * Load and iterate through all packs of the given packfile store.
    +  * repository.
       */
    - #define packfile_store_for_each_pack(store, p) \
    --	for (p = packfile_store_get_all_packs(store); p; p = p->next)
    -+	for (p = packfile_store_get_packs(store); p; p = p->next)
    + #define repo_for_each_pack(repo, p) \
    +-	for (p = packfile_store_get_all_packs(repo->objects->packfiles); p; p = p->next)
    ++	for (p = packfile_store_get_packs(repo->objects->packfiles); p; p = p->next)
      
      /*
       * Get all packs managed by the given store, including packfiles that are

---
base-commit: a0cb7ee3bf6c8398ab18e7b0dfabec106312b2f8
change-id: 20250926-pks-packfiles-convert-get-all-4236f6e2ed9b

