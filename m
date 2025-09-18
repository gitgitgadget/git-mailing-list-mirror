Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B607D22FE02
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 23:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239794; cv=none; b=GKEkxbPIGI1BNtqM1qafGU8xCV28w5F+dZzX2w8hgXezqV7njmaodDg7FrTPoTPrDc7T4VS218R8NbC6PZCSKnVF96yDPza1kirGN85kDNoW0/XNAaDTpO9Rmjy8Tn1402jsm4OJyiEisvs5wxPMP4v+sIP7V1187LmKnVwo6QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239794; c=relaxed/simple;
	bh=IoRPbl9Ic6QRhafLhjk1xQ8bg/7E5wrrlpacmOxrAaU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=KS4lgymNb5v5JE6K1gPu8y/QtPkv79fvp/Bt/OohmE4VE7Qa0NVqchojCJ9reZagZFLBZs1G4Vt8Orj9g4zPQpDl6hndHHnxVMERQo5qXmDLqSfgWyaTb7Kuuudxh/MIFw5Ka+LS9/YOJ0GMFfbuUkdSGLkjbiTHhbTAc6FUXls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAHe4rjU; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAHe4rjU"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8117aef2476so155996885a.1
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 16:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758239791; x=1758844591; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbN5aVH+Gccj6CfmKISH8y8O2OinRWldmZflC+8jytw=;
        b=TAHe4rjUkrIPDd805j3Umelt2lVZ/lqZxxnW3O5aabMa3XJCV0X+8HceicCP0h5lLn
         P+Fk6NzNSDQzS5cPxzsmeLtUwSdpvvOfU0rcjTXZi96sXNgu41aPpqK9+9vxvM0VBA40
         OSDDzYtQvgOd/sLMKzD0RZQrfGH7ALj6ke0G7WrsRD5bFfTa5g4dn3rrQTRPMPYgToaA
         D+YsCO9Qb93E63QOCky3sPkCGH+DzP251QRRhnFqw/8c8B8xr0ha9TdzyfadjUpoLm0h
         b2Vo7WE6mG+TgDWmEbFjlfzPEiwkQ3n6dHoEawICJDGr2AKTD7szns76SqiMGTFHBmR/
         ehuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239791; x=1758844591;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbN5aVH+Gccj6CfmKISH8y8O2OinRWldmZflC+8jytw=;
        b=c0DyrBHMKyjXJDHtP0DME8RiTE7W27kA7L9rO7doaI+DnzmJ7MnU8p7wZuH9HnER2T
         SsGNoez4rzhqQhMGi6ZszU0cWZFVibb26okzzUBRBS8V60ktxoi0Hy8DCCR4O0wrI5Nl
         dRQJ2C9S1S4lnVKxnbkUa89xnP1CJlKCdQOBoI1ANSxU+akzp3Qm5EnA85BdO6402FDI
         n4Jz6aaLC7CiC6Vhm7MQD19xDRU4Lzt7J8WeIUq/RB8nL7Mr5C96N1+LfIsBDUCpZSkg
         au1o4dWvAxRpR4vwVE8lMAlaOvUk/Z5ryWT+XjSHJQLEbcUNXNqtiDm7buNOh3YG5ucB
         J2gw==
X-Gm-Message-State: AOJu0YyQ7pEVDT3s0oVgivRmJ+icOkJPzUML97cGs626FrjmMppy4Qap
	zl8IZNsW3/r48VzidQPDTxjluTHcUXEb6ZpUQ7z8OEeCr0GMlK8EFXg7fyaPMQ==
X-Gm-Gg: ASbGncuuHt6cGhSaw0QUEuoBDTPYl+FOiZAB/X2KkzH6VCASGNIiSPXTpVq7pQUKJCt
	Ljiqmkv1Ha18nMp9mNy43213wM30yYed8PRDtNOE2vG6XbY+gWkTbgYwkj8zofyulBd3AxHLIql
	ALj7k69V+rAkJgS/OnSQhjhRtn9tir8W9KkpWcMbIpjLJHvSV8IAoBS5b6pAsdCtx6bAl7qJ/KU
	cvJf9CGpvlTQr7D5PbNzQsmYGpsj9aIywtwLTL6V7Cocz9mm0W92szAG2LLT+2qS9i5GOpo0XUM
	5/uikIy63AWzepk7e2ts9hvt3WLh7oF1Og4S0FjMbGV50yWyPZ5GGbg7xCkmfwVGlLlDn/u06TO
	BebiGrr16SGl0WHzGmOz3Pf3HkDuzdc4pStUCt+3Htg8=
X-Google-Smtp-Source: AGHT+IEr6WmTyIjNFSYaDeduN/0cCx+pHBuj95QAX0vbtUVXSmEBHAIFrY0LJaTMx5uA/hxSONH5hA==
X-Received: by 2002:a05:620a:7002:b0:827:fc22:55f3 with SMTP id af79cd13be357-83baff0c146mr149266985a.85.1758239790963;
        Thu, 18 Sep 2025 16:56:30 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.249])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83634a4f965sm243451585a.71.2025.09.18.16.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:56:30 -0700 (PDT)
Message-Id: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Sep 2025 23:56:19 +0000
Subject: [PATCH v2 00/10] Use rust types in xdiff.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

Changes since v1, to address review feedback.

 * Only include the clean up patches; The remaining patches will be split
   into a separate series.
 * Commit message clarifications.
 * Minor style cleanups.
 * Performance impacts included in commit message of patch 8.


Relevant part of the original cover letter follows:
===================================================

This patch series involves ZERO Rust code and toolchains, which avoids the
debate about Rust's portability and timeline. Instead, it shows how Git can
immediately benefit from Rust's design choices without using it at all. The
rationale for using Rust types on the C and Rust side is addressed in the
commit that creates compat/rust_types.h.

This patch series has 2 parts:

 * Patches 1-9: Clean up xdiff, this can be merged without part 2.
 * Patches 10-17: Define Rust types in compat/rust_types.h and then start
   refactoring xdiff with Rust types. This depends on part 1.

The cleanup in this patch series makes the structs xrecord_t and xdfile_t
Rust FFI friendly. My opinion is that part 1 should be merged soon, while
part 2 can be discussed further.

Before:

typedef struct s_xrecord {
	struct s_xrecord *next;
	char const *ptr;
	long size;
	unsigned long ha;
} xrecord_t;

typedef struct s_xdfile {
	chastore_t rcha;
	long nrec;
	unsigned int hbits;
	xrecord_t **rhash;
	long dstart, dend;
	xrecord_t **recs;
	char *rchg;
	long *rindex;
	long nreff;
	unsigned long *ha;
} xdfile_t;


After cleanup:

typedef struct s_xrecord {
	char const *ptr;
	long size;
	unsigned long ha;
} xrecord_t;

typedef struct s_xdfile {
	xrecord_t *recs;
	long nrec;
	long dstart, dend;
	char *rchg;
	long *rindex;
	long nreff;
} xdfile_t;


===

Ezekiel Newren (10):
  xdiff: delete static forward declarations in xprepare
  xdiff: delete local variables and initialize/free xdfile_t directly
  xdiff: delete unnecessary fields from xrecord_t and xdfile_t
  xdiff: delete xdl_get_rec() in xemit
  xdiff: delete struct diffdata_t
  xdiff: delete redundant array xdfile_t.ha
  xdiff: delete fields ha, line, size in xdlclass_t in favor of an
    xrecord_t
  xdiff: delete chastore from xdfile_t
  xdiff: delete rchg aliasing
  xdiff: treat xdfile_t.rchg like an enum

 xdiff/xdiff.h      |   4 +
 xdiff/xdiffi.c     | 101 ++++++++---------
 xdiff/xdiffi.h     |  11 +-
 xdiff/xemit.c      |  38 +++----
 xdiff/xhistogram.c |  10 +-
 xdiff/xmerge.c     |  56 +++++-----
 xdiff/xpatience.c  |  18 ++--
 xdiff/xprepare.c   | 262 +++++++++++++++++----------------------------
 xdiff/xtypes.h     |   7 +-
 xdiff/xutils.c     |  12 +--
 10 files changed, 212 insertions(+), 307 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2048%2Fezekielnewren%2Fuse_rust_types_in_xdiff-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2048/ezekielnewren/use_rust_types_in_xdiff-v2
Pull-Request: https://github.com/git/git/pull/2048

Range-diff vs v1:

  1:  9cf9d09c07 !  1:  784cffcef5 xdiff: delete static forward declarations in xprepare
     @@ Commit message
          Move xdl_prepare_env() later in the file to avoid the need
          for static forward declarations.
      
     +    Best-viewed-with: --color-moved
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff/xprepare.c ##
  2:  15832ad271 !  2:  b79157e64f xdiff: delete local variables and initialize/free xdfile_t directly
     @@ Metadata
       ## Commit message ##
          xdiff: delete local variables and initialize/free xdfile_t directly
      
     -    xdl_prepare_ctx() uses local variables and assigns them to the
     -    corresponding xdfile_t fields if there are no errors. Delete them and
     -    use the fields of xdfile_t directly.
     +    These local variables are essentially a hand-rolled additional
     +    implementation of xdl_free_ctx() inlined into xdl_prepare_ctx(). Modify
     +    the code to use the existing xdl_free_ctx() function so there aren't
     +    two ways to free such variables.
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
     @@ xdiff/xprepare.c: static int xdl_classify_record(unsigned int pass, xdlclassifie
       
      +static void xdl_free_ctx(xdfile_t *xdf)
      +{
     -+
      +	xdl_free(xdf->rhash);
      +	xdl_free(xdf->rindex);
      +	xdl_free(xdf->rchg - 1);
  3:  7d5e387916 !  3:  2e8de5be03 xdiff: delete unnecessary fields from xrecord_t and xdfile_t
     @@ Commit message
          xrecord_t.next, xdfile_t.hbits, xdfile_t.rhash are initialized,
          but never used for anything by the code. Remove them.
      
     +    Best-viewed-with: --color-words
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff/xprepare.c ##
     @@ xdiff/xprepare.c: static int xdl_classify_record(unsigned int pass, xdlclassifie
       	return 0;
       }
       
     -@@ xdiff/xprepare.c: static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
     + 
       static void xdl_free_ctx(xdfile_t *xdf)
       {
     - 
      -	xdl_free(xdf->rhash);
       	xdl_free(xdf->rindex);
       	xdl_free(xdf->rchg - 1);
  4:  ab17d8c23f !  4:  ddfee67e06 xdiff: delete xdl_get_rec() in xemit
     @@ xdiff/xemit.c
       #include "xinclude.h"
       
      -static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
     - 
     +-
      -	*rec = xdf->recs[ri]->ptr;
      -
      -	return xdf->recs[ri]->size;
     @@ xdiff/xemit.c
      +{
      +	xrecord_t *rec = xdf->recs[ri];
       
     -+	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
     ++	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0) {
       		return -1;
     --	}
     + 	}
       
     - 	return 0;
     - }
      @@ xdiff/xemit.c: static long def_ff(const char *rec, long len, char *buf, long sz)
       static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
       			   char *buf, long sz)
  5:  6cf371ec13 =  5:  807ce3e5aa xdiff: delete struct diffdata_t
  6:  bff4568602 !  6:  0bacb1191d xdiff: delete redundant array xdfile_t.ha
     @@ Commit message
          When 0 <= i < xdfile_t.nreff the following is true:
          xdfile_t.ha[i] == xdfile_t.recs[xdfile_t.rindex[i]]
      
     +    This makes the code about 5% slower. The fields rindex and ha are
     +    specific to the classic diff (myers and minimal). I plan on creating a
     +    struct for classic diff, but there'a alot of cleanup that needs to be
     +    done before that can happen and leaving ha in would make those cleanups
     +    harder to follow.
     +
     +    A subsequent commit will delete the chastore cha from xdfile_t. That
     +    later commit will investigate deleting ha and cha independently and
     +    together.
     +
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff/xdiffi.c ##
     @@ xdiff/xdiffi.c: int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
      
       ## xdiff/xprepare.c ##
      @@ xdiff/xprepare.c: static void xdl_free_ctx(xdfile_t *xdf)
     - 
     + {
       	xdl_free(xdf->rindex);
       	xdl_free(xdf->rchg - 1);
      -	xdl_free(xdf->ha);
  7:  db3d4e9a89 !  7:  e1e94107c9 xdiff: delete fields ha, line, size in xdlclass_t in favor of an xrecord_t
     @@ Metadata
       ## Commit message ##
          xdiff: delete fields ha, line, size in xdlclass_t in favor of an xrecord_t
      
     +    The fields from xdlclass_t are aliases of xrecord_t:
     +    xdlclass_t.line -> xrecord_t.ptr
     +    xdlclass_t.size -> xrecord_t.size
     +    xdlclass_t.ha   -> xrecord_t.ha
     +
     +    Remove aliasing from xdlclass_t, to reduce future refactoring mistakes.
     +
     +    Best-viewed-with: --color-words
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff/xprepare.c ##
  8:  e7d1933d1c !  8:  fae26d2a04 xdiff: delete chastore from xdfile_t, view with --color-words
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    xdiff: delete chastore from xdfile_t, view with --color-words
     +    xdiff: delete chastore from xdfile_t
      
     -    The chastore_t type is very unfriendly to Rust FFI. It's also redundant
     -    since 'recs' is a vector type that grows every time an xrecord_t is
     -    added.
     +    xdfile_t currently uses chastore_t which is an arena allocator. I
     +    think that xrecord_t used to be a linked list and recs didn't exist
     +    originally. When recs was added I think they forgot to remove
     +    xdfile_t.next, but was overlooked. This dual data structure setup
     +    makes the code somewhat confusing.
      
     +    Additionally the C type chastore_t isn't FFI friendly, and provides
     +    little to no performance benefit over using realloc to grow an array.
     +
     +    Performance impact of deleting fields from xdfile_t:
     +    Deleting ha is about 5% slower.
     +    Deleting cha is about 5% faster.
     +
     +    Delete ha, but keep cha
     +      time hyperfine --warmup 3 -L exe build_v2.51.0/git,build_delete_ha/git '{exe} log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null'
     +      Benchmark 1: build_v2.51.0/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null
     +        Time (mean ± σ):      1.269 s ±  0.017 s    [User: 1.135 s, System: 0.128 s]
     +        Range (min … max):    1.249 s …  1.286 s    10 runs
     +
     +      Benchmark 2: build_delete_ha/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null
     +        Time (mean ± σ):      1.339 s ±  0.017 s    [User: 1.234 s, System: 0.099 s]
     +        Range (min … max):    1.320 s …  1.358 s    10 runs
     +
     +      Summary
     +        build_v2.51.0/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null ran
     +          1.06 ± 0.02 times faster than build_delete_ha/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null
     +
     +    Delete cha, but keep ha
     +      time hyperfine --warmup 3 -L exe build_v2.51.0/git,build_delete_chastore/git '{exe} log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null'
     +      Benchmark 1: build_v2.51.0/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null
     +        Time (mean ± σ):      1.290 s ±  0.001 s    [User: 1.154 s, System: 0.130 s]
     +        Range (min … max):    1.288 s …  1.292 s    10 runs
     +
     +      Benchmark 2: build_delete_chastore/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null
     +        Time (mean ± σ):      1.232 s ±  0.017 s    [User: 1.105 s, System: 0.121 s]
     +        Range (min … max):    1.205 s …  1.249 s    10 runs
     +
     +      Summary
     +        build_delete_chastore/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null ran
     +          1.05 ± 0.01 times faster than build_v2.51.0/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null
     +
     +    Delete ha AND chastore
     +      time hyperfine --warmup 3 -L exe build_v2.51.0/git,build_delete_ha_and_chastore/git '{exe} log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null'
     +      Benchmark 1: build_v2.51.0/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null
     +        Time (mean ± σ):      1.291 s ±  0.002 s    [User: 1.156 s, System: 0.129 s]
     +        Range (min … max):    1.287 s …  1.295 s    10 runs
     +
     +      Benchmark 2: build_delete_ha_and_chastore/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null
     +        Time (mean ± σ):      1.306 s ±  0.001 s    [User: 1.195 s, System: 0.105 s]
     +        Range (min … max):    1.305 s …  1.308 s    10 runs
     +
     +      Summary
     +        build_v2.51.0/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null ran
     +          1.01 ± 0.00 times faster than build_delete_ha_and_chastore/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null
     +
     +    Best-viewed-with: --color-words
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff/xdiffi.c ##
     @@ xdiff/xemit.c
      -	xrecord_t *rec = xdf->recs[ri];
      +	xrecord_t *rec = &xdf->recs[ri];
       
     - 	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
     + 	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0) {
       		return -1;
      @@ xdiff/xemit.c: static long def_ff(const char *rec, long len, char *buf, long sz)
       static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
  -:  ---------- >  9:  fd54135560 xdiff: delete rchg aliasing
  9:  d1657f5101 ! 10:  9a5ac3c488 xdiff: treat xdfile_t.rchg like an enum
     @@ Commit message
          make the code easier to follow. Perhaps 'rchg' should be renamed to
          'changed'?
      
     +    A few of the code changes might appear to change behavior, such as:
     +        -    while (xdf->rchg[g->start - 1])
     +        +    while (xdf->rchg[g->start - 1] == YES)
     +    because it appears the value of MAYBE is being ignored.  However, MAYBE
     +    is only ever assigned as a value to a temporary array (dis1 & dis2) and
     +    then as a last step use that temporary array to decide if it wants to
     +    change xdfile_t.rchg[i] to YES or leave it as NO.  As such, rchg will
     +    never have a value of MAYBE and thus there is no behavioral change.
     +
     +    Best-viewed-with: --color-words
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff/xdiff.h ##
     @@ xdiff/xdiffi.c: static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
       			g->start--;
       
       		return 0;
     -@@ xdiff/xdiffi.c: int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
     - 
     - int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
     - 	xdchange_t *cscr = NULL, *xch;
     --	char *rchg1 = xe->xdf1.rchg, *rchg2 = xe->xdf2.rchg;
     - 	long i1, i2, l1, l2;
     - 
     - 	/*
     - 	 * Trivial. Collects "groups" of changes and creates an edit script.
     - 	 */
     - 	for (i1 = xe->xdf1.nrec, i2 = xe->xdf2.nrec; i1 >= 0 || i2 >= 0; i1--, i2--)
     --		if (rchg1[i1 - 1] || rchg2[i2 - 1]) {
     --			for (l1 = i1; rchg1[i1 - 1]; i1--);
     --			for (l2 = i2; rchg2[i2 - 1]; i2--);
     -+		if (xe->xdf1.rchg[i1 - 1] || xe->xdf2.rchg[i2 - 1]) {
     -+			for (l1 = i1; xe->xdf1.rchg[i1 - 1]; i1--);
     -+			for (l2 = i2; xe->xdf2.rchg[i2 - 1]; i2--);
     - 
     - 			if (!(xch = xdl_add_change(cscr, i1, i2, l1 - i1, l2 - i2))) {
     - 				xdl_free_script(cscr);
      
       ## xdiff/xhistogram.c ##
      @@ xdiff/xhistogram.c: redo:
 10:  2a7d5b05c1 <  -:  ---------- compat/rust_types.h: define rust primitive types
 11:  ec54380ed3 <  -:  ---------- xdiff: include compat/rust_types.h
 12:  182f93b60b <  -:  ---------- xdiff: make xrecord_t.ptr a u8 instead of char
 13:  f7aaef8f36 <  -:  ---------- xdiff: make xrecord_t.size a usize instead of long
 14:  af96763036 <  -:  ---------- xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
 15:  0a180f69ff <  -:  ---------- xdiff: make xdfile_t.nrec a usize instead of long
 16:  f4eda35e24 <  -:  ---------- xdiff: make xdfile_t.nreff a usize instead of long
 17:  00401e775a <  -:  ---------- xdiff: change the types of dstart, dend, rchg, and rindex in xdfile_t

-- 
gitgitgadget
