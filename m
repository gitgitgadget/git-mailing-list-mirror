Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554403BD638
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448571; cv=none; b=q/cXHsqyrsHqHmi/nSpWITkTWnj1Qrlq2Jz8kdFVaRqy7sufFqvy0LrlUnvqv24EjFznLSm3tSWhXySLMXtExzY9L/jsv9Eyl0SqusGoDpCmAvrD5058kWhOZ7QYxa0e6ZJkQrz5/u01FmKZbpGK/T2DSTIIRmySs3YMvLoIqY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448571; c=relaxed/simple;
	bh=f3ARSM2NCHCkWIzCm8oBPbiDq64tcR/hDvM4zbMZRs8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=GPu9x1tUlnn8MESsW03CHAiU/lQbv6dkd23WONWmHX6TMYZ+DVH7ELi1Vi8nOsOUmWojaj64lQDfKaIfvphXuOlN+2zhbqYYFpWJVdotX5ISlKD44oCVPuY+PTraylRDIIa8hfXYfOz2bcBG76++aMpmjM/PT1LMQhwEYZgcQA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kKSy4zfg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qpVwbV3o; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kKSy4zfg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qpVwbV3o"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 7565FEC0038
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 04:36:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 08 Oct 2026 04:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791448569;
	 x=1791534969; bh=eq1uCQGG42RRVyt44jRa0pD3kRpfoacMjozCgynjwfM=; b=
	kKSy4zfgmXUDGH8Pcjci10kYRtMV1PlN9EeEG7Pd2LLxbt911V8gF3FI1cxlomHG
	hFP6V+DG7P3dqqXAUvaIxDoC0etmXB6qc2jG4QZ9y3XsE7z0Xwzl4pHOngrCso3q
	oufn/OJAtZCJFz0DTW7pmNFofuZqM95Z5wU2qDENF3Zv++V2gFyCPgJwDHR1crqL
	PJ3QA8UQYrqe0+Z9Tmqi5oxFLti/CvSFNTC05OT6X8fjdF8BgoqXROEkGLMpQkt2
	87AItOUpvfwyqAJzK71pMqyR1Bxrzw3gpgmLgyxZ3u4PbqcbXOoNwedwN084YPZg
	Y2uKjEc2KHq/jc430/wL1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791448569; x=
	1791534969; bh=eq1uCQGG42RRVyt44jRa0pD3kRpfoacMjozCgynjwfM=; b=q
	pVwbV3osLF4oaTUzPNmOzD12Ji/oxW07Ul9oiDL/pAT5TI1ZcCr7/xJ2xJKXLvO1
	pewqODhYdj+N2C2VL08GXPqFVEyFoX029v5EI/nzVcOneFEj4usQX9gN1xgXWyWo
	9ClwDjTKRYACBE10mEceyHPPb02VBxp02iL0pPL6V8/UsCzdmGYhZhJeCee+nQX0
	UKCplGBIY5V3RS80ro7j7y6uEAp/aUfHsbzWHbus8RlCRPGqaF3MoHhWxI4LcGNn
	fmB8Hkx/T0YmwCVpQluX0UkuQdomccjvm1lJb2gWC7RbnZ+h+nNEq8u8OQR91NDS
	Lq5jsxPSYT39CuBvdDTMQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791448569; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CZItWBqQLRw97cw9T8E+F+MWeheAfRrp9C0+v8W8HM5GNaD
	stRqwgEIwUZFa+0lMqXFDlrB3FUknpq3Ef69nvKfs9AnXQZVc+R/8Pay2B0K3WiA
	u5XRwN34XR1BKMVlvg8uB8KuFdhZZBLLZ/1ZYkcDmytKH0jBqvATzptD5YZ+iaMf
	+1ksQHgxxd5/YuApHkyZU+OOKJnGJ95kRx7ISZ8dL35Fu9DykEXSv+i97WMPizpD
	MEwd1BtzcGKas9Ue04rmCELB8M569BDre5lYy92Nv0LEX7AtWDeSzG853Z7mrEs4
	Q0bGoZGOJuyEeBQWUZP/zAoRoqCnlsJtt/CT8lQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tUBMMSzYFIV8Axq5/yznClGgIOU8W0EOejVj76i6Vww=:f3ARSM2NCHCkWIzCm8oBPbiDq64tcR/hDvM4zbMZRs8=;
X-ME-Sender: <xms:-VXHat1rRrh54z_bIi3B8kuf20mzOjDMhbdZW2SJAMmh1a77Gd0aAw>
    <xme:-VXHaqEaNKnW8dq1hW3QD013Z_LAVI9FPAXE0jzGX4IyuEGxkdjT-qt_JtsA5BLke
    6kXRu9jBtXtyHNMsMwuY9NoBVrlXLB-ZDW1aQ1rqJvOQbjunpDACLA>
X-ME-Received: <xmr:-VXHarjy0Dl7VrVMytiB3PYWkaSg1ocPi75KkFeDA1GeSo9qo-USrg>
X-ME-Proxy-Cause: dmFkZTFBvpV0N/F2kiSdqDaiGrDb3nQhMfI38R5x2mFwHbmKcsI0ufXpl9u5i34sZv2+F2
    iyiETa9OGlrER4+ZlYep0MmEaGVgj+fbrRV6dMIwbjR6bepCrUCR5EB8Sf3AbdPOmMJrhv
    gEVgmnWL1+oct19ynvxplAnJBkcKgIBOdAKkyJP4fITcHa7N0iOfdANuICDGVjH3EIboJD
    iZhERV9eZFuGV1wmurZOwFlvi65XTJk0OaFAIuLpjokbUmOX/9n0SLbqWr1TSZCYWJHRgM
    kug3KO2O8BfenDpLS/DmixtrHoI5lXrcJ5svmNO+nQLj2PpOldc+jtDj7Tt/TISq4qI3Nb
    CJRlINrygrpgqXeB3LZUXG5KK6N7tzdvqPrh9aR0MkD5QesEniaDc3Db7N22Bmp2/e9S99
    E5aLpkCuifXnXgZaHAHIzK8HHxynaOJNo33ozXt+1iBxOPMuREoM8sJfhQ5oIKJRMtFyhp
    dTBZzbUF8w/4fyRvPpKvo0r8sVyrqcODTiw57sCT8uomVHjd62uA7bz9pGtExR79cpaBHF
    w5iNRamF+2pnV4266YS6w5RhKyio/mn8QOEbcZLeWGL3tFOI/iQx7wHu5Y7V7Db4DZrUcJ
    CW0t8S0NoRc2QHkFcKlPhezj7vbBfdMzeN6nSnPXL8+kIVujqrsAKpTjebng
X-ME-Proxy: <xmx:-VXHal_xgtHRCbF0bh9RT5NGc-4rxMdI2AzfZLTVJw2NAuwJmXK6ng>
    <xmx:-VXHaiqd9qikcBw2OtIlC5ioLcdVwAZgrDG57PK1Rgb6Xs9MSosHZA>
    <xmx:-VXHak-ShG5PyFTtpG3Uvs8Zx1gzc948bR36RZWTt_bnGDCgz9M4ig>
    <xmx:-VXHamX4TWhNlp6ml5eDcN7RHPWTTrfaw_43zmFav6ntunFyKw1_qg>
    <xmx:-VXHaqkcQIpICTMjEVqJ99kZ-GqBmJOWKvoV4V1wEH4zqjs2S1gXQL7l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 04:36:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0ca6a09f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 08:36:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/13] odb/source-files: move alternates into the
 backend
Date: Thu, 08 Oct 2026 10:35:50 +0200
Message-Id: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0K6dsxQKqIr72FYtDDIqFDS1kZDu
 LsF1y5f8v5/s/DkmLw4Z7NwFNmzHRPIXSaaXo83Am4TC4myxJNUMD082NbAYCOBfgZyow7kQWk
 02pAy2BUirSdHHb+352v9Y/8yd2rCercaPftg3WdLx3z1tkqOKP9WYg4IlS6LAx5NVTXqksw9D
 6JeluULn5574c0AAAA=
X-Change-ID: 20260924-pks-odb-move-alternates-4a0babe4b0f3
In-Reply-To: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Hi,

Originally, when designing pluggable object databases the goal was that
the object database can have multiple sources, and every source attached
to it could use a different backend. This would have allowed for quite a
lot of flexibility, as you could trivially mix and match different kinds
of object storages in whatever way you like.

But while well-intentioned, this design led to a bunch of conceptual
problems:

  - We're now trying to read objects in source order, whereas we
    previously tried to read objects via packfiles before trying to read
    them via loose objects. This led to a performance regression when
    using alternates or when using a quarantine directory.

  - Some data structures are supposed to only ever exist once, like for
    example bitmaps and commit graphs. At the same time, those data
    structures also span across the union of all objects, so they may
    cross sources.

  - It is unclear how we can extend GIT_OBJECT_DIRECTORY or
    GIT_ALTERNATE_OBJECT_DIRECTORIES to become backend-agnostic in a
    backwards-compatible way. In general, introducing an object storage
    extension into the current status quo where alternates may have to
    be extended to become generic was proving to be painful.

  - Some mechanisms of alternates assume way too much about how exactly
    their backends work. Alternate refs for example assume that the
    alternate is backed by a filesystem path, and that this filesystem
    path may also allow us to read references. This is not a given
    though, as backends may not even have local data at all.

In short, there are a bunch of conceptual mismatches when we have
alternates and pluggable object databases coexist. So while the original
idea was nice, it does not result in a system that is easy to reason
about.

This patch series corrects course by moving alternates into the "files"
backend itself so that they become another implementation detail. It's
unfortunately on the bigger side, and I'm sorry about that, but I
couldn't really find a way to split it up further in a sensible way.

Note that the above problems aren't fixed by this series yet, but it is
the prerequisite to fix them in subsequent patch series.

The series is built on top of c46c1e3772 (Start Git 2.98 cycle,
2026-09-30). See the first version of this patch series for the conflict
resolution that's required for this merge base.

Changes in v2:
  - Adapt the first commit message to better motivate the refactoring.
  - Link to v1: https://patch.msgid.link/20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (13):
      commit-graph: require resolved packfile paths for `stdin_packs`
      commit-graph: stop depending on `struct odb_source`
      odb/source-files: introduce `struct odb_files_dir`
      odb: refactor `odb_for_each_alternate()` to yield dirs
      odb: refactor `odb_find_source()` to yield dirs
      odb/source-files: add the ability to have multiple object dirs
      tmp-objdir: absorb logic to set and restore primary sources
      tmp-objdir: manage quarantine as an object directory
      tmp-objdir: replace primary source at creation time
      odb/source: make `will_destroy` an implementation detail
      odb/source-files: extract reading alternates
      odb/source-files: move alternates into the backend
      odb/source: drop `read_alternates` callback

 builtin/commit-graph.c      |  41 ++--
 builtin/commit.c            |   2 +-
 builtin/count-objects.c     |   6 +-
 builtin/fast-import.c       |  20 +-
 builtin/fetch.c             |   4 +-
 builtin/fsck.c              |   6 +-
 builtin/gc.c                |  15 +-
 builtin/index-pack.c        |   4 +-
 builtin/merge.c             |   2 +-
 builtin/multi-pack-index.c  |  48 ++---
 builtin/pack-objects.c      |  66 +++---
 builtin/prune.c             |   2 +-
 builtin/repack.c            |   4 +-
 builtin/submodule--helper.c |   7 +-
 bundle.c                    |   2 +-
 commit-graph.c              | 150 +++++++-------
 commit-graph.h              |  31 ++-
 diagnose.c                  |   8 +-
 fetch-pack.c                |   2 +-
 http-walker.c               |   4 +-
 http.c                      |  12 +-
 log-tree.c                  |   3 +-
 loose.c                     |  18 +-
 midx.c                      |  43 ++--
 object-file.c               |   8 +-
 odb.c                       | 439 +++++-----------------------------------
 odb.h                       |  62 +-----
 odb/source-files.c          | 482 ++++++++++++++++++++++++++++++++++++--------
 odb/source-files.h          |  65 +++++-
 odb/source-inmemory.c       |   7 -
 odb/source-loose.c          |   9 +-
 odb/source-loose.h          |   3 +
 odb/source-packed.c         |   7 -
 odb/source.c                |   5 +-
 odb/source.h                |  57 +-----
 odb/streaming.c             |   8 +-
 odb/transaction.c           |   2 +-
 pack-bitmap.c               |   8 +-
 packfile.c                  |  28 ++-
 packfile.h                  |  21 +-
 path.c                      |   2 +-
 prune-packed.c              |   2 +-
 repack-geometry.c           |   2 +-
 repack-midx.c               |   6 +-
 repack.c                    |   6 +-
 repository.c                |   4 +-
 setup.c                     |   2 +-
 t/helper/test-read-graph.c  |   5 +-
 t/helper/test-read-midx.c   |   8 +-
 t/t4216-log-bloom.sh        |   4 +-
 tmp-objdir.c                |  67 ++++--
 tmp-objdir.h                |  18 +-
 52 files changed, 883 insertions(+), 954 deletions(-)

Range-diff versus v1:

 1:  985b068271 !  1:  43a288604d commit-graph: require resolved packfile paths for `stdin_packs`
    @@ Commit message
         for a set of packfiles via the "--stdin-packs" option. Those users are
         expected to pass in relative paths, and those eventually get resolved in
         `fill_oids_from_packs()`. This ties the logic in "commit-graph.c" to the
    -    specific object database source.
    +    specific object database source, as the subsystem now needs to assume
    +    where a specific packfile is located relative to the source itself.
     
         Refactor the logic to instead require the caller to pass in resolved
    -    packfiles to untangle that dependency.
    +    packfiles to untangle that dependency. This also makes the next change
    +    easier to implement, where we'll get rid of passing the source to the
    +    commit-graph subsystem.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 2:  537c2895a9 =  2:  f455f1986c commit-graph: stop depending on `struct odb_source`
 3:  ce5ade106a =  3:  062f8b02d6 odb/source-files: introduce `struct odb_files_dir`
 4:  4336f3d53d =  4:  68e73bbdc6 odb: refactor `odb_for_each_alternate()` to yield dirs
 5:  77c5749db8 =  5:  078d51c82d odb: refactor `odb_find_source()` to yield dirs
 6:  3d59418c91 =  6:  b203565c43 odb/source-files: add the ability to have multiple object dirs
 7:  38b3658234 =  7:  c53ba11900 tmp-objdir: absorb logic to set and restore primary sources
 8:  928edd062b =  8:  92c0a38193 tmp-objdir: manage quarantine as an object directory
 9:  f51db68dea =  9:  e1fc5be9a7 tmp-objdir: replace primary source at creation time
10:  a71a69e2c3 = 10:  98605aa991 odb/source: make `will_destroy` an implementation detail
11:  fd434eaa74 = 11:  2ce6282162 odb/source-files: extract reading alternates
12:  a4a8e53216 = 12:  bc2a33d360 odb/source-files: move alternates into the backend
13:  39a3e9e1dd = 13:  41834f9155 odb/source: drop `read_alternates` callback

---
base-commit: 2f92b2890ddaf3d7ea29470c02418271c1a4cd79
change-id: 20260924-pks-odb-move-alternates-4a0babe4b0f3

