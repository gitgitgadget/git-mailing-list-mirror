Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB38B3B9D95
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 07:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002673; cv=none; b=PgdIbz0+dxiPFGeMgH9uHHtvz8NhDYQIWx5HLFEMs+rvtQR71zd3Om01SuOkzJPtEEI8cP4uPotJLKiUOLrqg/pwfKKYMfk+MgZkuy4Z7tixQ7FNa942Bq2ENH2EYTSHMqyP/6e4kJ+0jIq6vLiwZ/CAGlyo0ouii8YFLr/sOWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002673; c=relaxed/simple;
	bh=B5iFBlegSM2Uec1vo7fjCPlYJG7Zljhg1AqLvhiao4I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=g1WgzBSeGlwPjeuB0k+00RveHQnVYWNJJBA9aaTOseTBz56TqVMYIxE+HnCIgsUKTFOPOhdBaBlxTuq9EyXF2jmOnXZsVBESJGDumvEyoH5Br0CArKnl29Lq2L5SWsdtBUuSvbbA49s6/mvl2G0iem2eWVYyjU1SW1hS0/+avq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gLi+Sm94; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gAArq0ol; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gLi+Sm94";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gAArq0ol"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D5C797A0127;
	Thu,  6 Aug 2026 03:51:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 06 Aug 2026 03:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786002670;
	 x=1786089070; bh=pq2eBQTfZ3zgDX+SDlEn8b7twjqbFboINuGn0zxPoBQ=; b=
	gLi+Sm94CmIhv8WCmWp5BqjR+cNDXccwiLg7L7a1Nf7g4amQxEG3el6hBU/JN44+
	lmjZ7mKPp/L/o4GLyXYVKRKZG02YnYQVg/UbPNafFrKZQs2Tm82tiax62+qVBDLh
	3nMkPFoOtS9yg4b2aXtvqkuQn+YR5rmahnfP/nBDKtVcYS/7JyQ/xqH69WrpAxd4
	tIJKrSKpppmC/G/IPWJUX+yGlIUtn+bhkvEA0MVl6yE7NhQzn1AWhWr7zP0LUG9p
	dyhb7BMPneibp9QmAdYU7frFpZ1N1OQhJzaL9ylZ+JQy4doRHhw01EvkEGoYZAI5
	9SltW+tc1r1Yyq46Pua9rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786002670; x=
	1786089070; bh=pq2eBQTfZ3zgDX+SDlEn8b7twjqbFboINuGn0zxPoBQ=; b=g
	AArq0olafMBr3+sDeQpD+SpvBIoOqwsXNcWL+trg6oqb9idMQ53uwg3xBopKG/yC
	NLRFRTvoWAkLLYz4mALEKYY2My6zhzygGf7SW4kwuBJwS4AXvTeeQm2UGwZQfKRd
	iZH83B94R8kOjY75Ijv/8FoAkNc4gEwP2r4hMnVjyKvlanFiP2nT2/Ut7x5p6DaF
	gdZXrQre5J71L1zcN6Bd2ZLrls+qa19g97qloy/nzOOQoF/45yyk2VUwBxX2IHLM
	I2nKc3SyL5+dRXQkEwFTi8LjYL0RKPfpf7HWw1x9RjDOUOtSmoy9bpqRWRPoSQHi
	9tWarU619UmjhhjSZXTyg==
X-ME-Sender: <xms:7jx0aq3rBB21ADEUOq1gSR-YTLX8dH-xmWOR41amHekv44-qfRWzQg>
    <xme:7jx0akGHgHNV7NSlPdQPXO334huQn3lv6hILRxUcCqLDn3T6qmlXf65yVYS-UOwzv
    aio5l-LBHf-SRIiLAGaV3OXdENvO2yV1fSL0npjpXfp_MDDdiD1WoA>
X-ME-Received: <xmr:7jx0an4KFCOet4aecIfjC_NL3A_O8cJbDtaCrWF7ORlaV6B9kPUJ1kqMYnVJzKMv6Njgj4Sl5es3k8bu7b-pP98ujL6spQuVNX3Cn3h_lEw>
X-ME-Proxy-Cause: dmFkZTF8NqsnGG8vhu3dffLhDjE/sz3/1yON+MLseCp7W06eWcBOT6u10xX805ue+XYIky
    dmtI2GVSt3hPNWurk0DUiK9OZSf7rah3tnr4syecE05WCsz/DEIeTXGT/+BMf/Gj90Fkun
    99qNU78dP2rRz/OIBfpItsn2UuCnDMnom9ctbRncU+DFuJmKdfT44GWS+2cUqMZh4TV4LK
    t27X3rXFzghwPdsVHn9UBTxMJRLMCl8Xn+QWdZoD1h3ZWohgijfePwnygYI8ptMoZqnonr
    hHT1Ga0XU1cCVy2tCZaRr/wUFZYoLpBX+FYFxoCmqGdATFDuj0nBS1/XzVGUb5hJ/UKHCM
    n8Lef75OO9HL50Qs+m6A0kGFEt5E6BR/mM5qFLT2uCkiHzVB8H3Jd3y+6tKMtyPEscqSsC
    2unJNNb4GKuM6vofoO/hr7Kbkxxn9Be9Kj6Q3JP05NvPp9FGTyw+cMnaZ6re1bAMOZSfIG
    Jx+vhPwbSbVR8/5891Lmv6xpuJZMZ47g64QQAkoQ9ndIDsHTgKY7y6MqTfuJwXU7WcUjpI
    wbwGUaQQjTTWUqvNNclxRR/Yth1VCSWwjpYOf/Ub/OanEcoOJBreSUUdM29jFcZaTmW877
    oTq6Zfjh3AlDjT/RrM+lE1pTQLQv0KKS5C/lvpWy2rsgtHUU7bxxJ600JRQg
X-ME-Proxy: <xmx:7jx0aqu5Pbp-5QYHpjApksnpHekept6R8tlN87lQHC6GeBTU0SvMTw>
    <xmx:7jx0ao7l_OFgvvzbss7GarbhTqOvoCpNlg55Iei-5jzLh0XXtxPvHQ>
    <xmx:7jx0alWfaYBq7WiVMvXIhKUvApj0E_OrOYalUYzX-dOW96j_BCDvsQ>
    <xmx:7jx0aq9IZrIcngU2eA_1fv63iSB-Tax3_w2Jv1qobzbxDETq9E5OFQ>
    <xmx:7jx0al6aarU620--AaEtmuPTJrLdkfYVFaDrwcRPYRwlPD00G5UitHjh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 03:51:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 594c2e76 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Aug 2026 07:51:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/6] odb: make creation of object database pluggable
Date: Thu, 06 Aug 2026 09:50:58 +0200
Message-Id: <20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNyw6CMBQE0F8hXXtNH5SCK//DuKDtRaoRSItEQ
 /h3CxofC5aTzJwZSUDvMJBdMhKPgwuubWJINwkxddmcEJyNmXDKM6oYhe4SoLUajMeyR2gbsC5
 coMRcSZVnzGQFiePOY+XuC3w4vnK46TOaftbmRu1C3/rH8jywufc+4enaycCAgtDC8kzaQhV6H
 4tbdyXzw8C/Rk7XDR4Na6tcy0JbTtWfIX4NuWqIaBiKKEojWcqqjzFN0xMUMPybUwEAAA==
X-Change-ID: 20260710-pks-odb-create-on-disk-ae8757861c69
In-Reply-To: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

Hi,

when creating a new repository we create a couple of on-disk data
structures for the object database. This includes the "objects/"
directory hierarchy with "objects/info" and "objects/pack", which are
specific to the backend.

This patch series makes the creation of the on-disk data structures
pluggable. While we continue to always create "objects/" regardless of
the backend (it's required for a repository to be recognized as such),
the other subdirectories are now created by the backend. This will allow
other backends to plug in their own logic.

The series starts with a small detour into the loose-object map. This
detour is required so that we can defer initialization of the object
database itself to a later point in time.

The series is based on 9a0c4701dc (The 7th batch, 2026-07-22).

Changes in v4:
  - Drop `APPLY_REPOSITOY_FORMAT_SKIP_ODB_CREATION` in favor of explicit
    calls to `odb_new()`.
  - Remove a useless call to `xstrdup()`.
  - Mark a string as translatable.
  - Link to v3: https://patch.msgid.link/20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im

Changes in v3:
  - Move handling of GIT_OBJECT_DIRECTORY and
    GIT_ALTERNATE_OBJECT_DIRECTORIES into `odb_new()` itself. This
    deduplicates some of the logic and also preps us for a future where
    alternates are handled in the "files" backend itself.
  - Link to v2: https://patch.msgid.link/20260804-pks-odb-create-on-disk-v2-0-ddf8b59bd207@pks.im

Changes in v2:
  - Add a testcase that demonstrates the bug fixed with alternate loose
    object maps.
  - Rename the "inmemory" bakcend to "in-memory".
  - Clarify some commit messages.
  - Link to v1: https://patch.msgid.link/20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (6):
      loose: load loose object map for the correct source
      setup: detangle loading of loose object maps
      setup: handle ODB-related environment variables in `odb_new()`
      setup: defer object database creation
      odb/source: introduce function to map source type to name
      odb: make creation of on-disk structures pluggable

 loose.c                       | 25 ++++++++++----------
 loose.h                       |  1 +
 odb.c                         | 21 +++++++++--------
 odb.h                         | 17 ++++++++++++--
 odb/source-files.c            | 19 +++++++++++++++
 odb/source-files.h            |  4 +++-
 odb/source-inmemory.h         |  4 +++-
 odb/source-loose.c            |  2 ++
 odb/source-loose.h            |  4 +++-
 odb/source-packed.h           |  4 +++-
 odb/source.c                  | 19 +++++++++++++++
 odb/source.h                  | 29 +++++++++++++++++++++++
 repository.c                  |  3 +--
 setup.c                       | 54 +++++++++++++++++++++----------------------
 t/t1016-compatObjectFormat.sh | 18 +++++++++++++++
 t/unit-tests/u-odb-inmemory.c |  2 +-
 16 files changed, 169 insertions(+), 57 deletions(-)

Range-diff versus v3:

1:  e1a585a3f7 = 1:  6dd8d575c6 loose: load loose object map for the correct source
2:  1f1200f7ba = 2:  1e7adada64 setup: detangle loading of loose object maps
3:  af02e520a2 ! 3:  2265f38695 setup: handle ODB-related environment variables in `odb_new()`
    @@ odb.c: int odb_write_object_stream(struct object_database *odb,
     +
      	o->sources = odb_source_new(o, primary_source, true);
      	o->sources_tail = &o->sources->next;
    - 	o->alternate_db = xstrdup_or_null(secondary_sources);
    +-	o->alternate_db = xstrdup_or_null(secondary_sources);
    ++	o->alternate_db = secondary_sources;
      	o->inmemory_objects = &odb_source_inmemory_new(o)->base;
      
     -	free(to_free);
     -
    -+	free(secondary_sources);
     +	free(primary_source);
      	return o;
      }
4:  2c794be101 ! 4:  5274ee6bab setup: defer object database creation
    @@ Commit message
         object database, but it's not usable yet until we eventually call
         `create_object_directory()`.
     
    -    Defer the object database creation so that we handle both steps in the
    -    same function.
    +    Lift the call to `odb_new()` out of `apply_repository_format()` so that
    +    callers have more wiggle room with when exactly they call it, and adapt
    +    them accordingly. The only exception is `init_db()`, where we now defer
    +    creating the object database until we call `create_object_database()`.
    +
    +    With this change, initializing and creating the object database on disk
    +    is now neatly encapsulated in a single function, which will make it
    +    easier for a subsequent commit to move creation of the on-disk data
    +    structures into the `struct odb_source` backends.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    + ## repository.c ##
    +@@ repository.c: int repo_init(struct repository *repo,
    + 		warning("%s", err.buf);
    + 		goto error;
    + 	}
    ++	repo->objects = odb_new(repo, 0);
    + 
    + 	if (worktree)
    + 		repo_set_worktree(repo, worktree);
    +
      ## setup.c ##
     @@ setup.c: int apply_repository_format(struct repository *repo,
      			    enum apply_repository_format_flags flags,
    @@ setup.c: int apply_repository_format(struct repository *repo,
     -	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV)
     -		odb_new_flags |= ODB_NEW_HONOR_ENV;
     -	repo->objects = odb_new(repo, odb_new_flags);
    -+	if (!(flags & APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION)) {
    -+		enum odb_new_flags odb_new_flags = 0;
    -+		if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV)
    -+			odb_new_flags |= ODB_NEW_HONOR_ENV;
    -+		repo->objects = odb_new(repo, odb_new_flags);
    -+	}
    - 
    +-
      	return 0;
      }
    + 
    +@@ setup.c: const char *enter_repo(struct repository *repo, const char *path, unsigned flags
    + 		read_and_verify_repository_format(&fmt, ".", NULL);
    + 		if (apply_repository_format(repo, &fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
    + 			die("%s", err.buf);
    ++		repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
    + 		startup_info->have_repository = 1;
    + 
    + 		clear_repository_format(&fmt);
    +@@ setup.c: const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
    + 			if (apply_repository_format(repo, &discovery.format,
    + 						    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
    + 				die("%s", err.buf);
    ++			repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
    + 
    + 			clear_repository_format(&discovery.format);
    + 			strbuf_release(&err);
     @@ setup.c: static int create_default_files(struct repository *repo,
      	return reinit;
      }
    @@ setup.c: int init_db(struct repository *repo,
      	repository_format_configure(&repo_fmt, hash, ref_storage_format);
     -	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
     +	if (apply_repository_format(repo, &repo_fmt,
    -+				    APPLY_REPOSITORY_FORMAT_HONOR_ENV |
    -+				    APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION, &err) < 0)
    ++				    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
      		die("%s", err.buf);
     -	startup_info->have_repository = 1;
      
    @@ setup.c: int init_db(struct repository *repo,
      
      	if (repo_settings_get_shared_repository(repo)) {
      		char buf[10];
    -
    - ## setup.h ##
    -@@ setup.h: enum apply_repository_format_flags {
    - 	 * relate to the object database.
    - 	 */
    - 	APPLY_REPOSITORY_FORMAT_HONOR_ENV = (1 << 0),
    -+
    -+	/*
    -+	 * Usually, the object database is created after the repository format
    -+	 * was applied. This step is skipped if this flag is set, which leaves
    -+	 * us with a partially-working repository.
    -+	 *
    -+	 * This is useful when initializing a new repository.
    -+	 */
    -+	APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION = (1 << 1),
    - };
    - 
    - /*
5:  7397c760df = 5:  b444a314a6 odb/source: introduce function to map source type to name
6:  7049e41a73 ! 6:  acb48f1072 odb: make creation of on-disk structures pluggable
    @@ setup.c: static int create_default_files(struct repository *repo,
     -
     -	strbuf_release(&path);
     +	if (odb_source_create_on_disk(repo->objects->sources) < 0)
    -+		die("failed creating object database");
    ++		die(_("failed creating object database"));
      }
      
      static void separate_git_dir(const char *git_dir, const char *git_link)

---
base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
change-id: 20260710-pks-odb-create-on-disk-ae8757861c69

