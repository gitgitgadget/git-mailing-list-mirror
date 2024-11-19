Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199F51D1500
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030624; cv=none; b=gtcz1YezMmVY129Fh/x+mN7cSM4JnQ+ig2pWW8CA6CWj2fJHFoAEd4B5mydjH3T0cambi5I8TX8+8J4NDJgzasuNuojuUuKt0KEieAEqNqKYn4hBzf9xXbSqQN9sO4BThfCka65OAIU2VG5xS8uyAZQYmFjJHRoTXRDl3UFCUYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030624; c=relaxed/simple;
	bh=KWCIKXRSfolv+03em18blDRWBnaz/HgAP2jkYBLd9x4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=gM95fGqtYrgO66tO6+nBzlr5oRFG32NVeZTabYsUes9dEL14a2WD6ebY3bWi+o/EF578ccsVPBPfHHY/6kLevA6g+UxUnuHfigSh0dQIK91TwbsMn95XNvbnZOjRx16W+r/HyDLhEn6cKvzMKy7JMdBPa/+jiTmQDyN2iG/y7+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYWNBqR6; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYWNBqR6"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso48160691fa.2
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 07:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732030619; x=1732635419; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rsL1ceG7UgYS3XzDPtSsT4yHXDJ8j6OmQf9BnZ55Wc=;
        b=KYWNBqR6Ipl/tbQH0bzPVlEzzdtQca3VYHMSnxBNPt1yFqPsDm64ov4eu+ZpSnVj7d
         rS5hSGosEE7gUenq/C99achEQujbEEyQGrZL2YibeB0Y/yxPf0bfCYyzAKUkbAiJMI47
         5ojZ2PrxsksjTb6rvunLzsASpc8G/8uJH5QE7xNX+LAMpCnMRCktEDkN9Vi/jjOHNuLR
         NXzDL17MZbVy12WTb2AF6VsR5m9DNPx2SLM9HO26khVvnmAahSqlKe/a3piYZdk8wyan
         OZo4CyrK23nqAkuSeIurNbFO2m2a3iLCTTelKA0Ua8b25tIE3PUlhWkEHVgoyOk52MRo
         t73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030619; x=1732635419;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1rsL1ceG7UgYS3XzDPtSsT4yHXDJ8j6OmQf9BnZ55Wc=;
        b=C69EJPkabn0DLITXv3Q5u+9IGCFAdtY1nCNros7M4IWY4cZanDCYA6tUoQlZ0JsRRX
         kwozAEUw1xKAWNj5U4Ug2fGuLKF1hjZpxfDNvf5n03Rx+LtbZ8+nnEtB24eNsC4ovdKx
         Qrw4If9Q9qy+SdMXea6PpYbIaPllTBOmUlN3hIKk6HwhoVt3zV6WAMCGtIAgNUACNj6Y
         qlNOcqOj+M6SkoTZtQEEjfv/NeASQIpQhxZgyIrJletnj3DDaVoqPeJiQt7WQ1/u8xCM
         ZAxCrYbMq1KFL2jSm7qg+js+ima5UJiqZmqUK6NNELvvDEKju5HPjYB8zqtymn0SRehu
         YRJQ==
X-Gm-Message-State: AOJu0Yzeg8+Xoy7dBc7eUxzjRJ9Yd1VgM1Y6RsmNuk2JpFSJqKyfpAGp
	7TvZkm8vWQwUAnfRe3+BD02Tb38AxDENBR/mHYCRVE3ZyHws+Nyy
X-Google-Smtp-Source: AGHT+IEEsMXNO1ZIbUghg/AhvF1oGT5Ukj2b2osXU9JYAkakgSpsOsu/oRVbxiFKbKGGDlB40PM6uw==
X-Received: by 2002:a2e:bd86:0:b0:2fb:8c9a:fe3f with SMTP id 38308e7fff4ca-2ff60672961mr118791671fa.22.1732030618732;
        Tue, 19 Nov 2024 07:36:58 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df4e7bfsm661900566b.42.2024.11.19.07.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:36:58 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 00/10] Change midx.c and midx-write.c to not use global
 variables
Date: Tue, 19 Nov 2024 16:36:39 +0100
Message-Id: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAImwPGcC/62PXW6DMBCEr4L83EX+gdhBUZV7VHkwxsAqGKe2Q
 1NF3L0OVOoFuk87s9LON08SbUAbSVM8SbALRvRzFvytIGbU82ABu6wJp7xieUDICoLttUk+gMP
 uAQb03O3rV8Bks5E8zD5BZ282n/wMw+RbPUFMOt+1UtVRGV4faU9y0C3/w8cG8XHZdbCf98ySd
 pM4G6PeWJriZPxiQ8mkYIILUdNywFRedUgjXkum1HlwGqfSePf++t7qmJG8c5iaohWsbw+CGkp
 eSSPGXON7a7+wLeq3aP0fRRcGFOSB9UpzI6Ws/9DIZV3XHxiQaBZ+AQAA
X-Change-ID: 20241111-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-a88498c2590f
In-Reply-To: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, shejialuo@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=21371;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=KWCIKXRSfolv+03em18blDRWBnaz/HgAP2jkYBLd9x4=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnPLCXOs7QB1FNA0YT2TqhzVGF1/YFDBMuRNvwK
 3jvSw5RYueJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzywlwAKCRA+1Z8kjkaM
 f/h6C/wLNe+F3maOpIfaqhcatxSjC3D+oi5LknLvZAXABjUd3lwP+VGBT42Jb8M7ZpMp2ibJ6jD
 iI8GIN8gzLpJmoNWIOXIYBqz+zL36C8cL9xZBU8FrDd6WYVznC/9gZyLyzP620hw7kO8U65LadC
 WFOBnOCzz1NVdsbzLrZ50AYht6DvTC+x5tGll/mplEmL/7ArbaMTyP7/aTsbo42hE6RqOcWeZ6o
 9z2MAfDJRebigmxmvkWdBTm/fb8ct97gsZGbUr8WZoiPQrc07Uu8gcvw0olhkp71t5isN8DHmyx
 SPl3D5DKmX8abX+M3wVg3D3t6k/JtbSC3Lf1ZyVGnVgh0siwHvw10yS94nkVdDD1GAGtnoe34vo
 5Z3CBK4b4hZ27Jzvu2q2G6ZugEYGWZCT38z4U+ZMa116js+qt/YjduVVDOrkS0fS9oddau033Xl
 NiGpD2SNun69vIfTANaeDSMinvsQR4aAYaclf1gQoDWvD4K1HmdRWDjOLBT8cCsxr8s2w=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the earlier patch series on cleaning up packfile.c and
removing usage of global variables [1], we change the midx.c and
midx-write.c files to no longer use global variables.

This is done by the following:
  - Usage of repository variable already available in existing structs.
  - Passing down repository variable from other subsystems.
  - Modifying all subcommands to obtain repository variable from the
  command in `builtins/` and passing down the variable from there.

The biggest change is in the first commit, wherein we modify all
subcommands to add the repository variable. Since the subcommand
definition are not often changed, it shouldn't cause too many conflicts
with in flight topics.

Since the `packfile.c` cleanup is still in flight, this series is based
on top of master: b31fb630c0 (Merge https://github.com/j6t/git-gui,
2024-11-11) with those patches merged in. This applies cleanly on top 
of next, but conflicts with `bf/set-head-symref` in seen, the conflict
is mostly straight forward. I'll merge the topic in if it is merged into
next soon.

[1]: https://lore.kernel.org/git/cover.1729504640.git.karthik.188@gmail.com/

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v2:
- Split commit modifying static functions in `midx-write.c` to multiple
commits, which makes it easier to review.
- Remove usage of `the_repository` in `test-parse-options.c` and use
NULL instead.
- Fix the commit messages to be imperative.
- Fix error in commit sign off.
- Link to v1: https://lore.kernel.org/r/20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com

---
Karthik Nayak (10):
      builtin: pass repository to sub commands
      midx-write: pass down repository to static functions
      midx-write: use `revs->repo` inside `read_refs_snapshot`
      write-midx: add repository field to `write_midx_context`
      midx-write: pass down repository to `write_midx_file[_only]`
      midx: cleanup internal usage of `the_repository` and `the_hash_algo`
      midx: pass `repository` to `load_multi_pack_index`
      midx: pass down `hash_algo` to `get_midx_filename[_ext]`
      midx: pass down `hash_algo` to `get_split_midx_filename_ext`
      midx: inline the `MIDX_MIN_SIZE` definition

 builtin/bisect.c              |  32 +++++++----
 builtin/bundle.c              |  16 ++++--
 builtin/commit-graph.c        |  10 ++--
 builtin/config.c              |  25 +++++---
 builtin/gc.c                  |  21 ++++---
 builtin/hook.c                |   7 ++-
 builtin/multi-pack-index.c    |  20 ++++---
 builtin/notes.c               |  36 +++++++-----
 builtin/reflog.c              |  17 ++++--
 builtin/refs.c                |  10 ++--
 builtin/remote.c              |  34 +++++++----
 builtin/repack.c              |   2 +-
 builtin/sparse-checkout.c     |  25 +++++---
 builtin/stash.c               |  39 ++++++++-----
 builtin/submodule--helper.c   |  46 +++++++++------
 builtin/worktree.c            |  28 +++++----
 midx-write.c                  | 130 ++++++++++++++++++++++--------------------
 midx.c                        |  88 +++++++++++++++-------------
 midx.h                        |  24 ++++----
 pack-bitmap.c                 |   6 +-
 pack-revindex.c               |   2 +-
 parse-options.h               |   4 +-
 t/helper/test-parse-options.c |   8 ++-
 t/helper/test-read-midx.c     |   8 +--
 24 files changed, 378 insertions(+), 260 deletions(-)
---

Range-diff versus v1:

 1:  277db8a45a <  -:  ---------- packfile: add repository to struct `packed_git`
 2:  10ff177a40 <  -:  ---------- packfile: use `repository` from `packed_git` directly
 3:  c531a865d7 <  -:  ---------- packfile: pass `repository` to static function in the file
 4:  36cda6c7e9 <  -:  ---------- packfile: pass down repository to `odb_pack_name`
 5:  dbe2d93cbe <  -:  ---------- packfile: pass down repository to `has_object[_kept]_pack`
 6:  5b030a81c4 <  -:  ---------- packfile: pass down repository to `for_each_packed_object`
 7:  b4d6dda97c <  -:  ---------- config: make `delta_base_cache_limit` a non-global variable
 8:  bf13b948d4 <  -:  ---------- config: make `packed_git_(limit|window_size)` non-global variables
 9:  3ec55c737b <  -:  ---------- midx: add repository to `multi_pack_index` struct
10:  4df5b4fb30 !  1:  a423d7785c builtin: pass repository to sub commands
    @@ Commit message
         builtin: pass repository to sub commands
     
         In 9b1cb5070f (builtin: add a repository parameter for builtin
    -    functions, 2024-09-13) we passed down the repository to all builtin
    -    commands. This allowed us to pass down the repository to lower layers
    +    functions, 2024-09-13) the repository was passed down to all builtin
    +    commands. This allowed the repository to be passed down to lower layers
         without depending on the global `the_repository` variable.
     
    -    To continue this work, we also pass down the repository parameter from
    -    the command to sub-commands. In the upcoming commit, we'll utilize this
    -    to remove global variable usage in `midx-write.c`.
    +    Continue this work by also passing down the repository parameter from
    +    the command to sub-commands. In the upcoming commit, utilize this to
    +    remove global variable usage in `midx-write.c`.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ parse-options.h: typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_
       * `type`::
     
      ## t/helper/test-parse-options.c ##
    -@@
    -+#define USE_THE_REPOSITORY_VARIABLE
    -+
    - #include "test-tool.h"
    - #include "parse-options.h"
    - #include "strbuf.h"
    - #include "string-list.h"
    - #include "trace2.h"
    -+#include "repository.h"
    - 
    - static int boolean = 0;
    - static int integer = 0;
     @@ t/helper/test-parse-options.c: int cmd__parse_options_flags(int argc, const char **argv)
      	return parse_options_flags__cmd(argc, argv, test_flags);
      }
    @@ t/helper/test-parse-options.c: static int parse_subcommand__cmd(int argc, const
      	printf("opt: %d\n", opt);
      
     -	return fn(argc, argv, NULL);
    -+	return fn(argc, argv, NULL, the_repository);
    ++	return fn(argc, argv, NULL, NULL);
      }
      
      int cmd__parse_subcommand(int argc, const char **argv)
11:  3cfab22dc1 !  2:  3f39af60b4 midx-write: add repository field to `write_midx_context`
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    midx-write: add repository field to `write_midx_context`
    +    midx-write: pass down repository to static functions
     
    -    The struct `write_midx_context` is used to pass context for creating
    -    MIDX files. Adding the repository field here ensures that most functions
    -    within `midx-write.c` have access to the field and can use that instead
    -    of the global `repository` variable. This involves passing the
    -    `repository` field to `write_midx_internal`. To do this, we add
    -    `the_repository` usage to two non-static functions, which we'll remove
    -    in upcoming commits.
    +    In 'midx-write.c' there are a lot of static functions which use global
    +    variables `the_repository` or `the_hash_algo`. In a follow up commit,
    +    the repository variable will be added to `write_midx_context`, which
    +    some of the functions can use. But for functions which do not have
    +    access to this struct, pass down the required information from
    +    non-static functions `write_midx_file` and `write_midx_file_only`.
     
    -    With this, modify the static functions in `midx-write.c` to not use
    -    global variables. This means, either we use existing alternatives (like
    -    `repository` struct), or we pass down required fields from other
    -    functions.
    +    This ensures that the usage of global variables is limited to these
    +    non-static functions, which will be cleaned up in a follow up commits.
     
    -    Signed-off-by: default avatarKarthik Nayak <karthik.188@gmail.com>
    +    Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## midx-write.c ##
     @@ midx-write.c: extern void clear_incremental_midx_files_ext(const char *object_dir,
    @@ midx-write.c: extern void clear_incremental_midx_files_ext(const char *object_di
      	hashwrite_u8(f, num_chunks);
      	hashwrite_u8(f, 0); /* unused */
      	hashwrite_be32(f, num_packs);
    -@@ midx-write.c: struct write_midx_context {
    - 	uint32_t num_multi_pack_indexes_before;
    - 
    - 	struct string_list *to_include;
    -+
    -+	struct repository *repo;
    - };
    - 
    - static int should_include_pack(const struct write_midx_context *ctx,
    -@@ midx-write.c: static void add_pack_to_midx(const char *full_path, size_t full_path_len,
    - 			return;
    - 
    - 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
    --		p = add_packed_git(the_repository, full_path, full_path_len, 0);
    -+		p = add_packed_git(ctx->repo, full_path, full_path_len, 0);
    - 		if (!p) {
    - 			warning(_("failed to add packfile '%s'"),
    - 				full_path);
    -@@ midx-write.c: static int write_midx_oid_lookup(struct hashfile *f,
    - 				 void *data)
    - {
    - 	struct write_midx_context *ctx = data;
    --	unsigned char hash_len = the_hash_algo->rawsz;
    -+	unsigned char hash_len = ctx->repo->hash_algo->rawsz;
    - 	struct pack_midx_entry *list = ctx->entries;
    - 	uint32_t i;
    - 
    -@@ midx-write.c: static uint32_t *midx_pack_order(struct write_midx_context *ctx)
    - 	uint32_t *pack_order, base_objects = 0;
    - 	uint32_t i;
    - 
    --	trace2_region_enter("midx", "midx_pack_order", the_repository);
    -+	trace2_region_enter("midx", "midx_pack_order", ctx->repo);
    - 
    - 	if (ctx->incremental && ctx->base_midx)
    - 		base_objects = ctx->base_midx->num_objects +
    -@@ midx-write.c: static uint32_t *midx_pack_order(struct write_midx_context *ctx)
    - 	}
    - 	free(data);
    - 
    --	trace2_region_leave("midx", "midx_pack_order", the_repository);
    -+	trace2_region_leave("midx", "midx_pack_order", ctx->repo);
    - 
    - 	return pack_order;
    - }
    -@@ midx-write.c: static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
    - 	struct strbuf buf = STRBUF_INIT;
    - 	char *tmp_file;
    - 
    --	trace2_region_enter("midx", "write_midx_reverse_index", the_repository);
    -+	trace2_region_enter("midx", "write_midx_reverse_index", ctx->repo);
    - 
    --	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex(midx_hash));
    -+	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex_algop(midx_hash,
    -+								    ctx->repo->hash_algo));
    - 
    - 	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
    - 					midx_hash, WRITE_REV);
    -@@ midx-write.c: static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
    - 	strbuf_release(&buf);
    - 	free(tmp_file);
    - 
    --	trace2_region_leave("midx", "write_midx_reverse_index", the_repository);
    -+	trace2_region_leave("midx", "write_midx_reverse_index", ctx->repo);
    - }
    - 
    - static void prepare_midx_packing_data(struct packing_data *pdata,
    -@@ midx-write.c: static void prepare_midx_packing_data(struct packing_data *pdata,
    - {
    - 	uint32_t i;
    - 
    --	trace2_region_enter("midx", "prepare_midx_packing_data", the_repository);
    -+	trace2_region_enter("midx", "prepare_midx_packing_data", ctx->repo);
    - 
    - 	memset(pdata, 0, sizeof(struct packing_data));
    --	prepare_packing_data(the_repository, pdata);
    -+	prepare_packing_data(ctx->repo, pdata);
    - 
    - 	for (i = 0; i < ctx->entries_nr; i++) {
    - 		uint32_t pos = ctx->pack_order[i];
    -@@ midx-write.c: static void prepare_midx_packing_data(struct packing_data *pdata,
    - 			       ctx->info[ctx->pack_perm[from->pack_int_id]].p);
    - 	}
    - 
    --	trace2_region_leave("midx", "prepare_midx_packing_data", the_repository);
    -+	trace2_region_leave("midx", "prepare_midx_packing_data", ctx->repo);
    - }
    - 
    - static int add_ref_to_pending(const char *refname, const char *referent UNUSED,
     @@ midx-write.c: static int add_ref_to_pending(const char *refname, const char *referent UNUSED,
      		return 0;
      	}
    @@ midx-write.c: static int add_ref_to_pending(const char *refname, const char *ref
      		oid = &peeled;
      
      	object = parse_object_or_die(oid, refname);
    -@@ midx-write.c: static int read_refs_snapshot(const char *refs_snapshot,
    - 			hex = &buf.buf[1];
    - 		}
    - 
    --		if (parse_oid_hex(hex, &oid, &end) < 0)
    -+		if (parse_oid_hex_algop(hex, &oid, &end, revs->repo->hash_algo) < 0)
    - 			die(_("could not parse line: %s"), buf.buf);
    - 		if (*end)
    - 			die(_("malformed line: %s"), buf.buf);
    -@@ midx-write.c: static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
    - 	struct rev_info revs;
    - 	struct bitmap_commit_cb cb = {0};
    - 
    --	trace2_region_enter("midx", "find_commits_for_midx_bitmap",
    --			    the_repository);
    -+	trace2_region_enter("midx", "find_commits_for_midx_bitmap", ctx->repo);
    - 
    - 	cb.ctx = ctx;
    - 
    --	repo_init_revisions(the_repository, &revs, NULL);
    -+	repo_init_revisions(ctx->repo, &revs, NULL);
    - 	if (refs_snapshot) {
    - 		read_refs_snapshot(refs_snapshot, &revs);
    - 	} else {
    - 		setup_revisions(0, NULL, &revs, NULL);
    --		refs_for_each_ref(get_main_ref_store(the_repository),
    -+		refs_for_each_ref(get_main_ref_store(ctx->repo),
    - 				  add_ref_to_pending, &revs);
    - 	}
    - 
     @@ midx-write.c: static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
    - 
    - 	release_revisions(&revs);
    - 
    --	trace2_region_leave("midx", "find_commits_for_midx_bitmap",
    --			    the_repository);
    -+	trace2_region_leave("midx", "find_commits_for_midx_bitmap", ctx->repo);
    - 
      	return cb.commits;
      }
      
    @@ midx-write.c: static int write_midx_bitmap(const char *midx_name,
      
      	return ret;
      }
    -@@ midx-write.c: static int fill_packs_from_midx(struct write_midx_context *ctx,
    - 			 */
    - 			if (flags & MIDX_WRITE_REV_INDEX ||
    - 			    preferred_pack_name) {
    --				if (prepare_midx_pack(the_repository, m,
    -+				if (prepare_midx_pack(ctx->repo, m,
    - 						      m->num_packs_in_base + i)) {
    - 					error(_("could not load pack"));
    - 					return 1;
     @@ midx-write.c: static void clear_midx_files(const char *object_dir,
      	strbuf_release(&buf);
      }
    @@ midx-write.c: static int write_midx_internal(const char *object_dir,
     -	trace2_region_enter("midx", "write_midx_internal", the_repository);
     +	trace2_region_enter("midx", "write_midx_internal", r);
     +
    -+	ctx.repo = r;
      
      	ctx.incremental = !!(flags & MIDX_WRITE_INCREMENTAL);
      	if (ctx.incremental && (flags & MIDX_WRITE_BITMAP))
    @@ midx-write.c: static int write_midx_internal(const char *object_dir,
      	}
      
      	if (ctx.m || ctx.base_midx)
    --		close_object_store(the_repository->objects);
    -+		close_object_store(ctx.repo->objects);
    - 
    - 	if (commit_lock_file(&lk) < 0)
    - 		die_errno(_("could not write multi-pack-index"));
     @@ midx-write.c: static int write_midx_internal(const char *object_dir,
      	}
      	strbuf_release(&midx_name);
 -:  ---------- >  3:  774eea311a midx-write: use `revs->repo` inside `read_refs_snapshot`
 -:  ---------- >  4:  9ddfbdc0f8 write-midx: add repository field to `write_midx_context`
12:  5cdc724a0c !  5:  d25ea08541 midx-write: pass down repository to `write_midx_file[_only]`
    @@ Metadata
      ## Commit message ##
         midx-write: pass down repository to `write_midx_file[_only]`
     
    -    In the previous commit, we passed the repository field to all
    -    subcommands in the `builtin/` directory. We utilize this to pass the
    +    In a previous commit, we passed the repository field to all
    +    subcommands in the `builtin/` directory. Utilize this to pass the
         repository field down to the `write_midx_file[_only]` functions to
         remove the usage of `the_repository` global variables.
     
    -    With this, we remove all usage of global variables in `midx-write.c` and
    -    so we can remove the `USE_THE_REPOSITORY_VARIABLE` guard from the file.
    +    With this, all usage of global variables in `midx-write.c` is removed,
    +    hence, remove the `USE_THE_REPOSITORY_VARIABLE` guard from the file.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
13:  c6964becef !  6:  ca123e8c73 midx: cleanup internal usage of `the_repository` and `the_hash_algo`
    @@ Commit message
     
         In the `midx.c` file, there are multiple usages of `the_repository` and
         `the_hash_algo` within static functions of the file. Some of the usages
    -    can be simply swapped out with the available `repository` struct
    -    available. While some of them can be swapped out by passing the
    -    repository to the required functions.
    +    can be simply swapped out with the available `repository` struct. While
    +    some of them can be swapped out by passing the repository to the
    +    required functions.
     
         This leaves out only some other usages of `the_repository` and
         `the_hash_algo` in the file in non-static functions, which we'll tackle
14:  adcb6f0c6c !  7:  7e941aa0ba midx: pass `repository` to `load_multi_pack_index`
    @@ Commit message
         midx: pass `repository` to `load_multi_pack_index`
     
         The `load_multi_pack_index` function in midx uses `the_repository`
    -    variable to access the `repository` struct. Let's modify the function
    -    and its callee's to send the `repository` field.
    +    variable to access the `repository` struct. Modify the function and its
    +    callee's to send the `repository` field.
     
         This moves usage of `the_repository` to the `test-read-midx.c` file.
    -    While that is not optimal, it is okay, since we'll slowly move the usage
    -    of `the_repository` up the layers and eventually remove it entirely.
    +    While that is not optimal, it is okay, since the upcoming commits will
    +    slowly move the usage of `the_repository` up the layers and remove it
    +    eventually.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
15:  cea8e6c252 !  8:  3e6dd4e146 midx: pass down `hash_algo` to `get_midx_filename[_ext]`
    @@ Commit message
         midx: pass down `hash_algo` to `get_midx_filename[_ext]`
     
         The function `get_midx_filename_ext` uses `hash_to_hex` which internally
    -    uses the global variable `the_repository`. To remove this dependency, we
    +    uses the global variable `the_repository`. To remove this dependency,
         pass down the `hash_algo` to both `get_midx_filename` and
    -    `get_midx_filename_ext`. While we add `the_repository` usage to
    -    `midx-write.c` for this reason, we'll resolve this in a future commit.
    +    `get_midx_filename_ext`. This adds `the_repository` variable usage to
    +    `midx-write.c`, which will be resolved in a future commit.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
16:  66dd34c862 !  9:  704a5a4392 midx: pass down `hash_algo` to `get_split_midx_filename_ext`
    @@ Commit message
         midx: pass down `hash_algo` to `get_split_midx_filename_ext`
     
         Similar to the previous commit, pass down `hash_algo` to
    -    `get_split_midx_filename_ext` so we can use `hash_to_hex_algop` and not
    -    rely on the `the_repository` global variable.
    +    `get_split_midx_filename_ext` and use `hash_to_hex_algop`.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
17:  1f0602aec6 ! 10:  0a4a68bcff midx: inline the `MIDX_MIN_SIZE` definition
    @@ Commit message
     
         The `MIDX_MIN_SIZE` definition is used to check the midx_size in
         `local_multi_pack_index_one`. This definitions relies on the
    -    `the_hash_algo` global variable. Let's inline this and remove the global
    +    `the_hash_algo` global variable. Inline this and remove the global
         variable usage.
     
    -    With this, we can remove `USE_THE_REPOSITORY_VARIABLE` usage from
    -    `midx.c`.
    +    With this, remove `USE_THE_REPOSITORY_VARIABLE` usage from `midx.c`.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     


--- 

base-commit: b31fb630c0fc6869a33ed717163e8a1210460d94
change-id: 20241111-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-a88498c2590f

Thanks
- Karthik

