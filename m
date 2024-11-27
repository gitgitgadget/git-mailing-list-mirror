Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E7120100B
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724931; cv=none; b=CucidcdefGRMehlZip4JhWzpbGV868OdIt9BIEzWK0JDau8nTP9nx1ygbRCBKLRa5YD+EB9ZA7VlVTmTGlxl08EFgn9Vh3WJ01u+mAf+jKTc5AKX2EcOfqBIH46++5mq8qwSWPxowtNg5Mt21kuljMlrirjwGr+SUuB9rQ9u8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724931; c=relaxed/simple;
	bh=Y2sDI4LuJL5MbS+SSa2+4rRgysE8Yc1hFwi5EoYRvus=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=HRedNJy8l2YOMTQ7vzRnQlTxMk1b/VtqM29nT7xzCfAOChAWlhqQAKAIa/5Hg2UWaoQev5jMap/nIShGzJIAppvJYJPsN5C6NVAJehhXAWgy3Ip2llsTdezP0RvsBbgD2KsF0Ep5YAkpGGLfzPkB2xFCRYT+XptrdMRz4enCbC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzvP4tqN; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzvP4tqN"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d071f70b51so2324582a12.3
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 08:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732724927; x=1733329727; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0J2YGKJAvo1qcmz/tR6kxH9v7b22BByj29LspquWSdY=;
        b=bzvP4tqN0JFBGrXRJHzXmJvsVflbSQEwLLb2aZZmrsrvrX5XDakiaZHJehzh/n+H9t
         sAqW1G7HCjO6lMn0nLHzaTFu+7hcOtXG6DU4ZI/17yDgE07GKaxH2FpqWQ+63OA2lmq6
         OHdzg6QQ/LfOt1Z83g2YWIdf8X6JWqTHnnJdAobZMJVqj5ScHLJtKjM+LMve+CF6QuOW
         fmWbQ8x/zmV8ho3+NCBIEoqSS3qVBYb79JmROz9s+mMOKaDyL8WIRyCdxyS8wlFu10UK
         G4EkhWGa272XKstnJ6G3U8DX3o+UhgIgJfts8WoTPNejCVy6GNj4pyxfYs9yLwCQe0JW
         lBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724927; x=1733329727;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0J2YGKJAvo1qcmz/tR6kxH9v7b22BByj29LspquWSdY=;
        b=QzFHi415cgWxhZmTPLXol3CTucXeH4yD21TQzeqRRR1iRdFHLLGtwZDk0ikESAtITi
         VpbMRV04YO21ZfJ0N/MKVvBXWdpzf9Tll5syB8ncCQ2g4l2nTk5FChEu1wObcRRl0YUq
         k3MwFEYqaVGVry0Q78NXGWKhb/iNA6ekG+Y2QSX/8hVSrzk67pTsQ8xlZAy2EHICORDn
         U1cuFXUp8WI6UQy0bchyAb6T11q3JhldGtcNs2siEJ/0aMfle/oM8/c4YjK24Ah2Kzs4
         STZcKvEcpdAwZ/Ry3dZD5+eP7I9MxMQdW2urc8RNLO46SoO7UdCbtJ/ZgNlBbQnZ2GXY
         mAZA==
X-Gm-Message-State: AOJu0Yyqxh2AeJTmd27zCc8wefdlqNXKHTRp3zkU71lhEkm4KYhC/SJg
	+h4JLnsQ1o1KKfUO+OFfhEWs1aWGRdGxGjezGduLw/9lLQ9U0CLRgF+YrWdt
X-Gm-Gg: ASbGncsxcYEGbp1y1RLCNa3nHh4HrNeeyOlGNmOGMaHPDqlGfozY6fLAa4jfox5z2dc
	zsM6XPg7T+f+VNemPVS1JiKBUF4manbVW63QJKIXMr59zMPae8HCA18xox3dmRcqUIgPPb+VRi+
	cAx9uRecHN7LTIkWpJV4TfdGHVEV94clvIfYaEFDKu1mZ9qz8eIJh42J0u0qjRh6+3Ove/dQz3f
	G4qsy7wc3QaBL+raTesMnB5yCjDgASGtS9KLS71nENrDrfvhUJek32/MhQeEw==
X-Google-Smtp-Source: AGHT+IEpseEWiSAhzOkhtDnhQrBuJYWVH5kjCnNQFJ2U00GjURx17if4g94Firwj6oLB875DXTfguw==
X-Received: by 2002:a05:6402:50c9:b0:5c9:59e6:e908 with SMTP id 4fb4d7f45d1cf-5d080b8c981mr3194177a12.6.1732724926869;
        Wed, 27 Nov 2024 08:28:46 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:5640:4a6:5555:68ae])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54e15c169sm420042366b.67.2024.11.27.08.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:28:46 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/8] Change midx.c and midx-write.c to not use global
 variables
Date: Wed, 27 Nov 2024 17:28:25 +0100
Message-Id: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKpIR2cC/62P3W6EIBBGX8VwXQw/Kmg2Td+j6QXioGRFtkDtN
 hvfvaw26T7AcsU3k8w53w1FCBYi6oobCrDaaP2SA38pkJ7UMgK2Q86IEVbR/DAXFQ5glE4+YGe
 HK9ZYLcPx/Q42QR4kjxef8AAXyCu/4HH2vZpxTCrvlZRVKzWrW2JQBl3yPXvdJd4/jhzg8yu7p
 GOIHMSodpeuOGm/Qiip4JQzzmtSjjaVZxXSZM8llfJtdMrOpfbu9X69VzEreeds6oqeU9M3nGi
 C7qTJxlzjZ2+/0h31V7R+RtGVYoJFQ41UTAsh6n+1Hb+yR2T7FCTLSGCmIYKKCox+RG7b9gv24
 rJS8QEAAA==
X-Change-ID: 20241111-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-a88498c2590f
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, me@ttaylorr.com, 
 shejialuo@gmail.com, gitster@pobox.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12083;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=Y2sDI4LuJL5MbS+SSa2+4rRgysE8Yc1hFwi5EoYRvus=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnR0i2N5serxTgKgden5aYhkik4VFThQjgxz0cl
 1bHA0TQXGWJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ0dItgAKCRA+1Z8kjkaM
 f2chC/wK/8YzT3d66ROBozJkIn909mOVm0shc0RXBhbS/xlU51+5ucFWU4KFts+Dyp1AyN1sRx6
 kfZXmk1SpsomReSQLvYTs9hBJ3PFqbvW22hVgOyStzwPCrONu9SspvhQoQ+zJjMB3pnLRNq9Xy1
 rBgArNB4uAZmislF5U5nUAdDJJ9V6hgRTyyQy2kNpxf22aDC74yXi+88r96j9Q9Lw51iAAImofm
 qSa4vTz9LrwMMaSvZm4XMwp0Axym1h4qlyIJ3Y3KyGX5VsyVvaEqFN2Vq+I/czyXG132eCGhgY3
 EUCQhVpik1Njaj7Fp/0R6S4OjLdtuqNxJakVWebwTnzu+RS5q6oum5xPsvmjDjFgEv/uTx9NIhD
 RebI7nWiRpWUlKItfo9qHKxCDY1CxyyHmgzxzaf7A+aeuIgYc6MgjsOjjRrNnA2JdsIJeVBrGEF
 UVro0ghB37/HB1cLvU/UPBfogQwrFWrnNetZa9/d+DV+fBaoandDgvqlBa9ORZSjyEBbs=
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
2024-11-11) with those patches merged in.

Since v3 this series also depends on
'kn/pass-repo-to-builtin-sub-sub-commands', which was split out from
this series.

[1]: https://lore.kernel.org/git/cover.1729504640.git.karthik.188@gmail.com/

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v3:
- Split out the first commit into a separate series [1].
- Improved some of the commit messages to be more descriptive.
- Merged the 8th and 9th commits together, since they were similar.
- v2: https://lore.kernel.org/r/20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com

Changes in v2:
- Split commit modifying static functions in `midx-write.c` to multiple
commits, which makes it easier to review.
- Remove usage of `the_repository` in `test-parse-options.c` and use
NULL instead.
- Fix the commit messages to be imperative.
- Fix error in commit sign off.
- v1: https://lore.kernel.org/r/20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com

[1]: https://lore.kernel.org/git/xmqq34jdyey3.fsf@gitster.g/T/#t

---
Karthik Nayak (8):
      midx-write: pass down repository to static functions
      midx-write: use `revs->repo` inside `read_refs_snapshot`
      write-midx: add repository field to `write_midx_context`
      midx-write: pass down repository to `write_midx_file[_only]`
      midx: cleanup internal usage of `the_repository` and `the_hash_algo`
      midx: pass `repository` to `load_multi_pack_index`
      midx: pass down `hash_algo` to functions using global variables
      midx: inline the `MIDX_MIN_SIZE` definition

 builtin/multi-pack-index.c |   6 +--
 builtin/repack.c           |   2 +-
 midx-write.c               | 130 +++++++++++++++++++++++----------------------
 midx.c                     |  88 ++++++++++++++++--------------
 midx.h                     |  24 +++++----
 pack-bitmap.c              |   6 +--
 pack-revindex.c            |   2 +-
 t/helper/test-read-midx.c  |   8 +--
 8 files changed, 140 insertions(+), 126 deletions(-)
---

Range-diff versus v2:

 1:  6c00e25c86 <  -:  ---------- packfile: add repository to struct `packed_git`
 2:  70fc8a79af <  -:  ---------- packfile: use `repository` from `packed_git` directly
 3:  167a1f3a11 <  -:  ---------- packfile: pass `repository` to static function in the file
 4:  b7cfe78217 <  -:  ---------- packfile: pass down repository to `odb_pack_name`
 5:  5566f5554c <  -:  ---------- packfile: pass down repository to `has_object[_kept]_pack`
 6:  1b26e45a9b <  -:  ---------- packfile: pass down repository to `for_each_packed_object`
 7:  1bdc34f4d8 <  -:  ---------- config: make `delta_base_cache_limit` a non-global variable
 8:  7b6baa89ac <  -:  ---------- config: make `packed_git_(limit|window_size)` non-global variables
 9:  a3667d87ec <  -:  ---------- midx: add repository to `multi_pack_index` struct
10:  91a35c4876 <  -:  ---------- builtin: pass repository to sub commands
11:  a916fe708f !  1:  d7c1056ebd midx-write: pass down repository to static functions
    @@ Commit message
         access to this struct, pass down the required information from
         non-static functions `write_midx_file` and `write_midx_file_only`.
     
    +    This requires that the function `hash_to_hex` is also replaced with
    +    `hash_to_hex_algop` since the former internally accesses the
    +    `the_hash_algo` global variable.
    +
         This ensures that the usage of global variables is limited to these
    -    non-static functions, which will be cleaned up in a follow up commits.
    +    non-static functions, which will be cleaned up in a follow up commit.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
12:  a2fa59eca5 !  2:  11cd6c6bec midx-write: use `revs->repo` inside `read_refs_snapshot`
    @@ Metadata
      ## Commit message ##
         midx-write: use `revs->repo` inside `read_refs_snapshot`
     
    -    The `read_refs_snapshot` uses the `parse_oid_hex` function which
    -    internally uses global variables. Let's instead use
    -    `parse_oid_hex_algop` and provide the hash algo via `revs->repo`.
    +    The function `read_refs_snapshot()` uses `parse_oid_hex()`, which relies
    +    on the global `the_hash_algo` variable. Let's instead use
    +    `parse_oid_hex_algop()` and provide the hash algo via `revs->repo`.
     
    -    Also, while here, fix a missing newline after the functions definition.
    +    Also, while here, fix a missing newline after the function's definition.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
13:  bc6ff987c5 =  3:  d74bf1fa51 write-midx: add repository field to `write_midx_context`
14:  27affa11fb =  4:  630bffe661 midx-write: pass down repository to `write_midx_file[_only]`
15:  02484793f6 =  5:  32d001bdd6 midx: cleanup internal usage of `the_repository` and `the_hash_algo`
16:  790215da01 =  6:  392a96de6a midx: pass `repository` to `load_multi_pack_index`
17:  8eac01e7ac !  7:  35bdc6d6b1 midx: pass down `hash_algo` to `get_midx_filename[_ext]`
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    midx: pass down `hash_algo` to `get_midx_filename[_ext]`
    +    midx: pass down `hash_algo` to functions using global variables
     
    -    The function `get_midx_filename_ext` uses `hash_to_hex` which internally
    -    uses the global variable `the_repository`. To remove this dependency,
    -    pass down the `hash_algo` to both `get_midx_filename` and
    -    `get_midx_filename_ext`. This adds `the_repository` variable usage to
    -    `midx-write.c`, which will be resolved in a future commit.
    +    The functions `get_split_midx_filename_ext()`, `get_midx_filename()` and
    +    `get_midx_filename_ext()` use `hash_to_hex()` which internally uses the
    +    `the_hash_algo` global variable.
    +
    +    Remove this dependency on global variables by passing down the
    +    `hash_algo` through to the functions mentioned and instead calling
    +    `hash_to_hex_algop()` along with the obtained `hash_algo`.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ midx-write.c: static int link_midx_to_chain(struct multi_pack_index *m)
      
     -		get_midx_filename_ext(&from, m->object_dir, hash,
     -				      midx_exts[i].non_split);
    +-		get_split_midx_filename_ext(&to, m->object_dir, hash,
     +		get_midx_filename_ext(m->repo->hash_algo, &from, m->object_dir,
     +				      hash, midx_exts[i].non_split);
    - 		get_split_midx_filename_ext(&to, m->object_dir, hash,
    ++		get_split_midx_filename_ext(m->repo->hash_algo, &to,
    ++					    m->object_dir, hash,
      					    midx_exts[i].split);
      
    + 		if (link(from.buf, to.buf) < 0 && errno != ENOENT) {
     @@ midx-write.c: static int link_midx_to_chain(struct multi_pack_index *m)
      	return ret;
      }
    @@ midx-write.c: static int write_midx_internal(struct repository *r, const char *o
      	if (safe_create_leading_directories(midx_name.buf))
      		die_errno(_("unable to create leading directories of %s"),
      			  midx_name.buf);
    +@@ midx-write.c: static int write_midx_internal(struct repository *r, const char *object_dir,
    + 		if (link_midx_to_chain(ctx.base_midx) < 0)
    + 			return -1;
    + 
    +-		get_split_midx_filename_ext(&final_midx_name, object_dir,
    +-					    midx_hash, MIDX_EXT_MIDX);
    ++		get_split_midx_filename_ext(r->hash_algo, &final_midx_name,
    ++					    object_dir, midx_hash, MIDX_EXT_MIDX);
    + 
    + 		if (rename_tempfile(&incr, final_midx_name.buf) < 0) {
    + 			error_errno(_("unable to rename new multi-pack-index layer"));
     @@ midx-write.c: static int write_midx_internal(struct repository *r, const char *object_dir,
      	if (commit_lock_file(&lk) < 0)
      		die_errno(_("could not write multi-pack-index"));
    @@ midx.c: const unsigned char *get_midx_checksum(struct multi_pack_index *m)
      }
      
      static int midx_read_oid_fanout(const unsigned char *chunk_start,
    +@@ midx.c: void get_midx_chain_filename(struct strbuf *buf, const char *object_dir)
    + 	strbuf_addstr(buf, "/multi-pack-index-chain");
    + }
    + 
    +-void get_split_midx_filename_ext(struct strbuf *buf, const char *object_dir,
    ++void get_split_midx_filename_ext(const struct git_hash_algo *hash_algo,
    ++				 struct strbuf *buf, const char *object_dir,
    + 				 const unsigned char *hash, const char *ext)
    + {
    + 	get_midx_chain_dirname(buf, object_dir);
    +-	strbuf_addf(buf, "/multi-pack-index-%s.%s", hash_to_hex(hash), ext);
    ++	strbuf_addf(buf, "/multi-pack-index-%s.%s",
    ++		    hash_to_hex_algop(hash, hash_algo), ext);
    + }
    + 
    + static int open_multi_pack_index_chain(const struct git_hash_algo *hash_algo,
    +@@ midx.c: static struct multi_pack_index *load_midx_chain_fd_st(struct repository *r,
    + 		valid = 0;
    + 
    + 		strbuf_reset(&buf);
    +-		get_split_midx_filename_ext(&buf, object_dir, layer.hash,
    +-					    MIDX_EXT_MIDX);
    ++		get_split_midx_filename_ext(r->hash_algo, &buf, object_dir,
    ++					    layer.hash, MIDX_EXT_MIDX);
    + 		m = load_multi_pack_index_one(r, object_dir, buf.buf, local);
    + 
    + 		if (m) {
     @@ midx.c: struct multi_pack_index *load_multi_pack_index(struct repository *r,
      	struct strbuf midx_name = STRBUF_INIT;
      	struct multi_pack_index *m;
    @@ midx.h: struct multi_pack_index {
      			   const unsigned char *hash, const char *ext);
      void get_midx_chain_dirname(struct strbuf *buf, const char *object_dir);
      void get_midx_chain_filename(struct strbuf *buf, const char *object_dir);
    +-void get_split_midx_filename_ext(struct strbuf *buf, const char *object_dir,
    ++void get_split_midx_filename_ext(const struct git_hash_algo *hash_algo,
    ++				 struct strbuf *buf, const char *object_dir,
    + 				 const unsigned char *hash, const char *ext);
    + 
    + struct multi_pack_index *load_multi_pack_index(struct repository *r,
     
      ## pack-bitmap.c ##
     @@ pack-bitmap.c: static int load_bitmap_entries_v1(struct bitmap_index *index)
18:  3357d47ec0 <  -:  ---------- midx: pass down `hash_algo` to `get_split_midx_filename_ext`
19:  6a1ae9d11c !  8:  128f4f08b0 midx: inline the `MIDX_MIN_SIZE` definition
    @@ Commit message
         midx: inline the `MIDX_MIN_SIZE` definition
     
         The `MIDX_MIN_SIZE` definition is used to check the midx_size in
    -    `local_multi_pack_index_one`. This definitions relies on the
    +    `local_multi_pack_index_one`. This definition relies on the
         `the_hash_algo` global variable. Inline this and remove the global
         variable usage.
     


--- 

base-commit: b31fb630c0fc6869a33ed717163e8a1210460d94
change-id: 20241111-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-a88498c2590f

Thanks
- Karthik

