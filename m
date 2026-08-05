Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE9F48424A
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946494; cv=none; b=r2t3B34p2AqxAx4R8voU07qggG8SuaU3SnsnzuUOAO73+rtuajf6o/wcsAhBN/3rpt0uMSEa5GEKzIc7nBaUX/c8mhEJZbo7YjJumilzo2hbA38xbfBPpcCFr5RnvoQzCaRcBGz1zBIiJpJHH4kHdDUUJs2rVLZLCDQ0nV1eSuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946494; c=relaxed/simple;
	bh=SE2soW3z2cPnvHBp1YGi7ZyMuK3MqkJHuClKxGio9ho=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cCQzLbEw7OeGtKFWzIrMxY6VzHs5ZZCdLP+oIsm8VUlFCqqdFrhyIvRpZk7XIVxK/zRMlRhRI3k4yRRil7Lx1+ftv7zSvguplJZmO2+pd51cifP66EABhXY2P4rKwokdmpXnFjK5SD6fJvBX3YYHwuwcSRh7PQMKVmzdue52cZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uc43ue8E; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uc43ue8E"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-48a0ca07c38so761922b6e.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785946481; x=1786551281; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OUYCXjlu+9cyT/WmdfzYhuKlp/i90EgvkcKHbvcSgvg=;
        b=Uc43ue8EyJoZfTG79X4iR0VVcoPEkf4FxGljHnaTYnPDmnAP6QAFYAHf3CkXnjG1Ip
         VYgWXIBSvglkVgoJtIMj5D0eWQfF6QA47hl6YaWCi9/vTHNpHZCjpoPjdcadsqUyXHay
         O66NkyTt06wWMJbo4vTv//76dYubPcOSJSoO8dOvpm/SQqfn6TubCD9NKdatLvgV0o9A
         jLhD5ZbbQxeZzGuw9cgkltOhVdC8ZLs5y/qTeMmja78jwsf2S4g+z9JiAUfMAKQ08gX6
         uj70Vh48wSbhRxHQnLn6xNiQOeoxXgvwkN6jbHOheaSFyi2SHniezVQ0mGRu6n9CiYVa
         bdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946481; x=1786551281;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OUYCXjlu+9cyT/WmdfzYhuKlp/i90EgvkcKHbvcSgvg=;
        b=ZLceLqGb9dJS+FZNr59at7RqDBRi/pTUpnE0KdOEM0zFGGV7AwcsDhVXtiXZrb5tPw
         RIrBJHe9IIpkVDsmWK2yDtMuVkfRHRAMIm50+FsuX+aTiL+nT5b/Rw4oQqKBUs8yKAH3
         NzhKGc9LNzgTLWP8Rwk9In/ZSKgZ0SCmOEQ77aFXipgJ0F+oefPNyRwe+1CWsxlC2zCj
         Zx0MdkCGCr7j7PQx7NK8yG1LCGyFIlryqSx77zuryV3QXVY/dQI5BN88SORP/77jbSNd
         H86E4/h5ntdy2hWmiMoOaOaOQCtCVGmcX3BJH3sTlzufSN0BHn0gH3q3UHpYJvJDe9i6
         T8fg==
X-Gm-Message-State: AOJu0Yy4KnuS8EuF1/HZcIjafOWTNX6zqJiy+bZkbsGO+qo9rjFNHDeW
	NWZ2+VjpY+kWO/nNKBmUlRozn2R8b8ZaN9IvYmt6tn9GWTdwuPRFpVbXhwjM1A==
X-Gm-Gg: AR+sD11ZwvRXi7uBmJyacnXWFQQ2yo91s0ooVSvDO7Ystwt4P5HkyQhlzTbkqXhxvnp
	qD/6UPaQHDjOZ8RkvMa5vHpsUYdC5tywlYxXuZklCPt06CTkK+J3Im3SA0bE6s5tZblndrUomy1
	RIvxMfEIyJuT89jsCsIU5dRgdMKzoNMBNKpyXmp4bW9EA/FNYepFCbaL/ruJxgV4m3wH7+boHq1
	rkbw3oOYEXmrKupBzD1LeV3l8ajUsb5hfoFv/c1F8U4J3I2k/z5sv9amTScm9qUu3nKE5L1FTNx
	nwLcPdICuyv+fJvpasrAxqE4wm07yh9ldk1TfbFpfADUStdTyHB72BAYvW2GXl4Q8RTD59M6y4r
	G4YcQO/Eeo3My+pA4c+5lfJ1BnKHFT5fkJNeeJKx4ynC/hX/VWVIEqPjIf82dm5VKc8B0A+y8qz
	GqOLqPzU5E+KH8lKkyhNcR4mN/fGgUkxfOmkWg9iNDvbRjQs7FBj4vbSvwW8Uzti/mXw==
X-Received: by 2002:a05:6808:3448:b0:49b:c387:36b6 with SMTP id 5614622812f47-4afadf347f5mr4221674b6e.13.1785946481346;
        Wed, 05 Aug 2026 09:14:41 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.142.251])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae4b5750sm2336943b6e.7.2026.08.05.09.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 09:14:40 -0700 (PDT)
Message-Id: <pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 16:14:27 +0000
Subject: [PATCH v2 00/12] Next size_t stop: pack-objects/delta
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

This patch series continues the effort to stop using unsigned long where
size_t should have been used in the first place. This makes a difference on
64-bit Windows, where unsigned long is 32-bit.

With these fixes, the pack-objects machinery works as intended on 64-bit
Windows (and any other 64-bit platform where unsigned long isn't 64-bit).

Changes since v1:

 * The return value of sizeof_delta_index() is now included in the unsigned
   long -> size_t work.
 * To assign correct values to the now-widened max_delta_cache_size, a new
   pair of helpers are introduced and used: git_parse_size_t() and
   git_config_size_t()
 * There are now two references regarding the provenance of the
   deflateBound() formula in the corresponding commit message.

Johannes Schindelin (12):
  diff-delta: widen `struct delta_index`' size fields to `size_t`
  delta: widen `create_delta_index()` parameter to `size_t`
  pack-objects: widen delta-cache accounting to `size_t`
  pack-objects: widen `free_unpacked()` return to `size_t`
  pack-objects: widen `mem_usage` and `try_delta()`'s out-param to
    `size_t`
  delta: widen `create_delta()` and `diff_delta()` to `size_t`
  packfile, git-zlib: widen `use_pack()` and zstream avail fields to
    `size_t`
  archive-zip: widen `zlib_deflate_raw()`'s maxsize local to `size_t`
  diff: widen `deflate_it()`'s bound local from int to `size_t`
  http-push: widen `start_put()`'s size local from `ssize_t` to `size_t`
  t/helper/test-pack-deltas: widen `do_compress()`'s maxsize local to
    `size_t`
  git-zlib: widen `git_deflate_bound()` to `size_t`

 archive-zip.c               |  2 +-
 builtin/fast-import.c       |  6 ++++--
 builtin/pack-objects.c      | 32 +++++++++++++++++---------------
 config.c                    |  9 +++++++++
 config.h                    |  3 +++
 delta.h                     | 14 +++++++-------
 diff-delta.c                | 14 +++++++-------
 diff.c                      |  6 ++++--
 git-zlib.c                  | 16 ++++++++++++++--
 git-zlib.h                  |  6 +++---
 http-push.c                 |  2 +-
 pack-check.c                |  4 ++--
 packfile.c                  |  4 ++--
 packfile.h                  |  3 ++-
 parse.c                     |  9 +++++++++
 parse.h                     |  1 +
 t/helper/test-delta.c       |  2 +-
 t/helper/test-pack-deltas.c |  7 ++++---
 18 files changed, 91 insertions(+), 49 deletions(-)


base-commit: f85a7e662054a7b0d9070e432508831afa214b47
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2175%2Fdscho%2Fsize-t%2Fpack-objects-delta-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2175/dscho/size-t/pack-objects-delta-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2175

Range-diff vs v1:

  1:  69c2c21f05 !  1:  0012c1007b diff-delta: widen `struct delta_index`' size fields to `size_t`
     @@ Commit message
          bits on Windows because the public API around it still truncates.
          Splitting it out keeps the API-change commit focused on caller updates.
      
     +    Since the `memsize` attribute is returned by the `sizeof_delta_index()`
     +    function verbatim, that function's return type is adjusted, too.
     +
          Assisted-by: Opus 4.7
     +    Helped-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     + ## delta.h ##
     +@@ delta.h: void free_delta_index(struct delta_index *index);
     +  *
     +  * Given pointer must be what create_delta_index() returned, or NULL.
     +  */
     +-unsigned long sizeof_delta_index(struct delta_index *index);
     ++size_t sizeof_delta_index(struct delta_index *index);
     + 
     + /*
     +  * create_delta: create a delta from given index for the given buffer
     +
       ## diff-delta.c ##
      @@ diff-delta.c: struct unpacked_index_entry {
       };
     @@ diff-delta.c: struct delta_index * create_delta_index(const void *buf, unsigned
       
       	if (!buf || !bufsize)
       		return NULL;
     +@@ diff-delta.c: void free_delta_index(struct delta_index *index)
     + 	free(index);
     + }
     + 
     +-unsigned long sizeof_delta_index(struct delta_index *index)
     ++size_t sizeof_delta_index(struct delta_index *index)
     + {
     + 	if (index)
     + 		return index->memsize;
  2:  d92a5d4dec =  2:  75500c5abb delta: widen `create_delta_index()` parameter to `size_t`
  3:  4ef2886549 !  3:  5b54041baf pack-objects: widen delta-cache accounting to `size_t`
     @@ Commit message
          shims, which becomes possible once 1create_delta()` and `diff_delta()`
          are widened in a later commit.
      
     +    Note: since `max_delta_cache_size` changes data type to `size_t`, a pair
     +    of new helpers is introduced to parse config values of that type, too.
     +
          Assisted-by: Opus 4.7
     +    Helped-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/pack-objects.c ##
     @@ builtin/pack-objects.c: struct unpacked {
       {
       	if (max_delta_cache_size && delta_cache_size + delta_size > max_delta_cache_size)
       		return 0;
     +@@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v,
     + 		return 0;
     + 	}
     + 	if (!strcmp(k, "pack.deltacachesize")) {
     +-		max_delta_cache_size = git_config_int(k, v, ctx->kvi);
     ++		max_delta_cache_size = git_config_size_t(k, v, ctx->kvi);
     + 		return 0;
     + 	}
     + 	if (!strcmp(k, "pack.deltacachelimit")) {
     +
     + ## config.c ##
     +@@ config.c: ssize_t git_config_ssize_t(const char *name, const char *value,
     + 	return ret;
     + }
     + 
     ++size_t git_config_size_t(const char *name, const char *value,
     ++			 const struct key_value_info *kvi)
     ++{
     ++	size_t ret;
     ++	if (!git_parse_size_t(value, &ret))
     ++		die_bad_number(name, value, kvi);
     ++	return ret;
     ++}
     ++
     + double git_config_double(const char *name, const char *value,
     + 			 const struct key_value_info *kvi)
     + {
     +
     + ## config.h ##
     +@@ config.h: unsigned long git_config_ulong(const char *, const char *,
     + ssize_t git_config_ssize_t(const char *, const char *,
     + 			   const struct key_value_info *);
     + 
     ++size_t git_config_size_t(const char *, const char *,
     ++			 const struct key_value_info *);
     ++
     + /**
     +  * Identically to `git_config_double`, but for double-precision floating point
     +  * values.
     +
     + ## parse.c ##
     +@@ parse.c: int git_parse_ssize_t(const char *value, ssize_t *ret)
     + 	return 1;
     + }
     + 
     ++int git_parse_size_t(const char *value, size_t *ret)
     ++{
     ++	uintmax_t tmp;
     ++	if (!git_parse_unsigned(value, &tmp, maximum_signed_value_of_type(size_t)))
     ++		return 0;
     ++	*ret = tmp;
     ++	return 1;
     ++}
     ++
     + int git_parse_double(const char *value, double *ret)
     + {
     + 	char *end;
     +
     + ## parse.h ##
     +@@
     + int git_parse_signed(const char *value, intmax_t *ret, intmax_t max);
     + int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max);
     + int git_parse_ssize_t(const char *, ssize_t *);
     ++int git_parse_size_t(const char *, size_t *);
     + int git_parse_ulong(const char *, unsigned long *);
     + int git_parse_uint(const char *value, unsigned int *ret);
     + int git_parse_int(const char *value, int *ret);
  4:  07d01200a4 =  4:  9850de1a91 pack-objects: widen `free_unpacked()` return to `size_t`
  5:  7dca160102 =  5:  c301958284 pack-objects: widen `mem_usage` and `try_delta()`'s out-param to `size_t`
  6:  e1ae83ba03 !  6:  cfbf6c9567 delta: widen `create_delta()` and `diff_delta()` to `size_t`
     @@ builtin/pack-objects.c: static int try_delta(struct unpacked *trg, struct unpack
       	void *delta_buf;
      
       ## delta.h ##
     -@@ delta.h: unsigned long sizeof_delta_index(struct delta_index *index);
     +@@ delta.h: size_t sizeof_delta_index(struct delta_index *index);
        */
       void *
       create_delta(const struct delta_index *index,
     @@ delta.h: create_delta(const struct delta_index *index,
       	if (index) {
      
       ## diff-delta.c ##
     -@@ diff-delta.c: unsigned long sizeof_delta_index(struct delta_index *index)
     +@@ diff-delta.c: size_t sizeof_delta_index(struct delta_index *index)
       
       void *
       create_delta(const struct delta_index *index,
  7:  8353bc03c1 =  7:  ca928b4579 packfile, git-zlib: widen `use_pack()` and zstream avail fields to `size_t`
  8:  acffd232ac =  8:  9f379ee7aa archive-zip: widen `zlib_deflate_raw()`'s maxsize local to `size_t`
  9:  b89d28c8aa =  9:  ff103a0ee1 diff: widen `deflate_it()`'s bound local from int to `size_t`
 10:  2d4d19c5fb = 10:  c701d2f9b2 http-push: widen `start_put()`'s size local from `ssize_t` to `size_t`
 11:  617960d9ca = 11:  e6175d2d87 t/helper/test-pack-deltas: widen `do_compress()`'s maxsize local to `size_t`
 12:  ab911cf556 ! 12:  762e716afe git-zlib: widen `git_deflate_bound()` to `size_t`
     @@ Commit message
      
          For inputs above zlib's `uLong` range (i.e. >4 GiB on platforms where
          `uLong` is 32-bit, notably 64-bit Windows), defer to zlib's stored-block
     -    formula (the same fallback it would itself use for an unknown stream
     -    state) plus the worst-case wrapper overhead. The existing path through
     +    formula (the same fallback it would itself use, see
     +    https://github.com/madler/zlib/blob/v1.3.2/deflate.c#L832-L928 keeping
     +    in mind that for large sizes, the `storelen` would be relevant, also
     +    compare with https://github.com/madler/zlib/issues/549 for a fuller
     +    story) plus the worst-case wrapper overhead. The existing path through
          `deflateBound()` is unchanged for inputs that fit.
      
          Assisted-by: Opus 4.7

-- 
gitgitgadget
