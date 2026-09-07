Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEAC3F1058
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769551; cv=none; b=Y6/rF/QV1R5t3ZH9KeiGdFdLQUQ0S5CzYyv2ZZBV/CVN3ufltZQ5fX1pRmYZFGEhoO6mjcSczGM6znsKgo0D8qw16uC8SLZtHqYW8e6gYQiNXQa2j7BPbvLTqUZeSodIyoMexoqppGzy8L2CYuPpWQCu8KV1++O/DaWJtkFIqu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769551; c=relaxed/simple;
	bh=g94Z3LzNQ+cRtOXjh1Nv8zdBx8NkB/yZCQQ3w0bzl3U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=RDOlFCUFxlky+W3HY5WYle1O+KsCu2maP7cZkDeRa+meQOpbPuuqgCqE+JW6GsG5BHUvyZu42F6yFmXVBBmR4paE/+OVmiAkGR//Dag+2tJo5MyreZuHY5Mz3lA2AuyOX0W7sAEZYHvdgJUghercS3CNNliM42M4ozSFDdGl1JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=akfGYtPk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lxjfn+B9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="akfGYtPk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lxjfn+B9"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1967DEC023E;
	Mon,  7 Sep 2026 04:25:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 07 Sep 2026 04:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788769549;
	 x=1788855949; bh=RVipXTA2hlPJ5yI7/4VNI7IF0kfgnXkWEGpGisZeYCU=; b=
	akfGYtPkxDJFBtDNW7ruGr21O1HlgnurZ/cdBqFlieTX+SvMPPkFc4J1mboVOzYv
	cRI0+IP5EaBzlgZHIq3r+LvkSy1GTvEzZ/2r96kH7iRRhAdhmjraUre1cprOuEsH
	nRMB+iAloAB9z+jKhpnbmwxoq6RgqLUD7j36Eksa//zvgkqi/qoRRtYNVQgGOvSJ
	wm43s3Vh6IZTh5VexqZlNpbrx/Nubw0Epo7+OLk6vBfFRtRKMRNMU/AytlnClpVg
	yFRCzvGuySn+Fer2HjhqYh9WeyIDfYk32x8n9ULL6faUxLn6++DzzR9jqVCE5RAf
	32NEnPn3Uwb17pzBVb68TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788769549; x=
	1788855949; bh=RVipXTA2hlPJ5yI7/4VNI7IF0kfgnXkWEGpGisZeYCU=; b=L
	xjfn+B9fqzmyYG5UDBqdNqC8XALSD/3jMduwImFEEy24lVZwqIG5RjgdZZ36jCFA
	6q/mkoNkYpM/NkAHrknVdZTS+kpdYqBU061xNc0A+r5jiHLmhFLrsbk+mpKV2cSM
	rZTdMN8iAe3ztH/TpmyrYP9uYZdWb73uayYUFz7bRPgJEEUwRILAk6XN0EDgVNAb
	8wbZU63cSlscJfVwfUrz3EXe6Q0yOa9mJdn4IrqH1WoCiXSmzAzv70GY56khP/OL
	fqwTCy9H2yE7Xgno33c85iVEbAdSCV4Op7rPl++kv0xfBI/naS2W+zhOlBzisBpr
	vqV/YJnIgXP64mYuZoAmQ==
X-ME-Sender: <xms:DHWearGWXl1XDgxKaYseDIodTBN9kgDPYXfjReiRXzpmCRldXsCeXw>
    <xme:DHWeavXvA4kt5L58AAwk1e5MJtRsNMXzD6vMhQTyvh3YoHPdIaF3zL-0pR9OhskWx
    bP4IW8ZZ538CgypsCUPtpNDvruwQc7CI2aTT7PTRgc8CFIjSTgkWA>
X-ME-Received: <xmr:DHWeaiJXCfrWamXbpXGxyy-xc4exwaYn27lGUG2jNwN6jygD65Y9Rg>
X-ME-Proxy-Cause: dmFkZTGzcWT8dtzQHyqT5SvNRlTtE0vbvHA+5aBWBzSeuElvNkPsV/ritNr0znc/Q5zKfs
    GgPzRxggOd3sazpYt98bu+lr/8hSmO+6cWoh3km/JGm2g5HQw+JlY7wR4syFSV2D62hwM6
    ElX6kWctlk9gaoU5oRk4M0npMGCeoOueCvsoe1WJP5UoJe2dKutifH7Mcwo/ExmL1lNUGl
    4aX4W4jgCDAfKW/qdoIBbc/aOHRq6WbQsHCK0Y1alrb0HPY7XRqMqWAQ0Co1rJBqguUHh3
    k/41igK4JmoSqgHe7YlnYXlGRKYt5tibXG7+twGK4l4TEArQdmZWioayudoeb7jBoFc7XX
    F8lXmAJFZBEJT4epe+wCBlb23+rtmtle+hYnvJXQQ4q0lQax83pLqyboyRyysNrQ1nsGlz
    v8iXqYNuP30e7qxitAClzTjVherj0OzvD3kpvWQ11KISK09RZkz7DZgi05POzqt5n+wOPP
    HnO841d1hilwJhzOxkKezdEXuimA5rhWTn4BKgXXExJIiCn3AnKuHtDTBTc9cAAKnOekFN
    t26h4BxqAIbWEON2sAv8U9z+eP6oebtNMuPe9BrBhdkZ7Au1j/pTwFY7outnk6XDOhb4I2
    F+0ipXxqPfQR7/DRPUtSmY3lpNkOBUhVZNP2sHB75MKgbVm2xsFAuQyvt9Vw
X-ME-Proxy: <xmx:DHWean-zuoLeo6Q0NMOZweL69AO1wywIE21APBDls5wpK1x9-GdDIQ>
    <xmx:DHWeatK8F69hhWXo8Syp1ZkKmE3J55r0j5PBm_nW3N4_lct9W5avgw>
    <xmx:DHWeaklf7lyq_v9pK0V-anWWs2hF5EFRE4Xh1nFnqeZKhSpFfiLUDA>
    <xmx:DHWeapM7UWiNv1ikrNYCdTI9cZqebFuy89Tr1FgVSZQbl6p4rkIMAQ>
    <xmx:DXWeasIqsvoLRNTPbBSPctsE7eEDeWieeUy7wzvfux9fRARcz00K4XGF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 04:25:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 330969c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 08:25:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/9] odb: write alternates at creation time
Date: Mon, 07 Sep 2026 10:25:37 +0200
Message-Id: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOSw7CMAwFr4KyxihOWkRZcQ/EwkkNmE+LklBAq
 HcnLQixZTnS84yfKnIQjmo5earAnURpmwx2OlF+T82OQerMymgz1wu0cDlGaGsHtyCJgU6JQ0O
 JI1ACH5hSFkCSM8O80KhrdlVBWmXfJfBW7mNrvXlzvLoD+zQEhsVeYmrDY3ymw2H36Zryj26Ho
 KFCLNE6qkpvV/l2Jmc1RDvzo7X4j9ZkLbGvjV0YR+i/2r7vX2hA10BIAQAA
X-Change-ID: 20260813-pks-odb-write-alternates-at-creation-time-64010deb94a0
In-Reply-To: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Hi,

writing alternates into the object database currently happens via
`odb_source_write_alternate()`. But while that creates the ability to
create alternates at arbitrary points of a source's lifetime, we don't
use that functionality in the first place. Instead, we only ever write
alternates when creating a new repository.

This design is suboptimal due to a couple of reasons:

  - It requires us to have a `write_alternates()` callback, which is
    overblown as we never even write alternates to an object database
    after it has been created.

  - We're about to make alternates an implementation detail of the
    object database's backend in a future patch series, so alternate
    implementations may not even support them.

  - The backend has more flexibility with how exactly alternates are
    configured when it itself is in full control over their setup at the
    time where it creates the object database itself.

This patch series thus refactors how we handle alternates so that we
don't write them ad-hoc anymore. Instead, the series introduces a new
option for `odb_source_create_on_disk()` that makes it handle those
alternates at creation time.

This is part of the bigger goal of moving handling of alternates into
the "files" backend.

This series is built on top of 2c3adbb2c4 (The 18th batch, 2026-08-24)
with ps/odb-eagerly-load-alternates at 0076dc9f81 (odb: drop
`alternates_db` field, 2026-08-17) merged into it.

Changes in v3:
  - Refactor `init_db()` to not create the reference and object database
    at all anymore. Instead, it's now called `create_repository()` and
    it is responsible for creating the initial repository skeleton,
    only. This allows us to get rid of the flags and overall makes the
    logic more straight-forward by moving the command-specific logic
    into the respective commands.
  - A couple of typo fixes.
  - Link to v2: https://patch.msgid.link/20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im

Changes in v2:
  - Use a lockfile to write "info/alternates" during creation time.
  - Remove useless "strvec.h" include by reordering declarations a bit.
  - Link to v1: https://patch.msgid.link/20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (9):
      setup: split up concerns of `init_db()`
      builtin/clone: defer setup of the object database
      builtin/clone: move around `setup_reference()`
      builtin/clone: refactor handling of "--reference{,-if-able}"
      builtin/clone: move setup of alternates for shared local clones
      builtin/clone: move setup of alternates for non-shared local clones
      odb/source: support writing alternates when creating the database
      builtin/clone: write alternates via `odb_create_on_disk()`
      odb/source: remove the ability to write alternates

 builtin/clone.c            | 111 +++++++++++++++++++++++---------------
 builtin/init-db.c          |  32 ++++++++---
 odb.c                      |   9 ----
 odb.h                      |   7 ---
 odb/source-files.c         | 130 ++++++++++++++++++++++++++-------------------
 odb/source-inmemory.c      |   7 ---
 odb/source-loose.c         |   7 ---
 odb/source-packed.c        |   7 ---
 odb/source.h               |  43 +++++----------
 setup.c                    |  61 ++++++++-------------
 setup.h                    |  22 ++++----
 t/t5604-clone-reference.sh |  25 +++++++++
 12 files changed, 239 insertions(+), 222 deletions(-)

Range-diff versus v2:

 1:  1a1580185a <  -:  ---------- builtin/clone: defer setup of the object database
 -:  ---------- >  1:  512e7d1ef2 setup: split up concerns of `init_db()`
 -:  ---------- >  2:  a8808bcacf builtin/clone: defer setup of the object database
 2:  7d0d4832ed =  3:  0193fb3ada builtin/clone: move around `setup_reference()`
 3:  d547e62b5b !  4:  3c53ad13f2 builtin/clone: refactor handling of "--reference{,-if-able}"
    @@ Commit message
         In subsequent commits we're about to consolidate the complete setup of
         alternates into this function, and furthermore we'll refactor the setup
         of the object database to handle doing this for us instead of writing
    -    the alterantes into it one by one.
    +    the alternates into it one by one.
     
         Prepare for this refactoring by collecting the alternates into a strvec.
         Rename the function to `collect_alternates()` to clarify its scope.
 4:  ceb90593c8 =  5:  4fbcab0026 builtin/clone: move setup of alternates for shared local clones
 5:  d9587585f3 !  6:  b658ca0799 builtin/clone: move setup of alternates for non-shared local clones
    @@ Commit message
         purpose.
     
         Add two tests, the first one of which exercises this bug to avoid future
    -    regressions. The second patch ensures that we properly handle relative
    +    regressions. The second test ensures that we properly handle relative
         alternates for a referenced worktree.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
 6:  7575379b17 =  7:  bec8115803 odb/source: support writing alternates when creating the database
 7:  c07fd20d85 !  8:  3deaa7ef64 builtin/clone: write alternates via `odb_create_on_disk()`
    @@ builtin/clone.c: int cmd_clone(int argc,
      	transport = transport_get(remote, path ? path : remote->url.v[0]);
      	transport_set_verbosity(transport, option_verbosity, option_progress);
     
    + ## builtin/init-db.c ##
    +@@ builtin/init-db.c: int cmd_init_db(int argc,
    + 			  template_dir, hash_algo, ref_storage_format,
    + 			  init_shared_repository, &reinit);
    + 	create_reference_database(the_repository, initial_branch, quiet);
    +-	create_object_database(the_repository);
    ++	create_object_database(the_repository, NULL);
    + 
    + 	if (!quiet) {
    + 		int len = strlen(git_dir);
    +
      ## setup.c ##
     @@ setup.c: static int create_default_files(struct repository *repo,
      	return reinit;
    @@ setup.c: static int create_default_files(struct repository *repo,
      
      	/*
      	 * Create the "objects" directory in the common directory. This is done
    -@@ setup.c: int init_db(struct repository *repo,
    - 	if (!(flags & INIT_DB_SKIP_REFDB))
    - 		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
    - 	if (!(flags & INIT_DB_SKIP_ODB))
    --		create_object_database(repo);
    -+		create_object_database(repo, NULL);
    - 
    - 	startup_info->have_repository = 1;
    - 
     
      ## setup.h ##
     @@ setup.h: void initialize_repository_version(struct repository *repo,
 8:  a8b9f51897 =  9:  d751b886b3 odb/source: remove the ability to write alternates

---
base-commit: afa255aeb620346d56a2c01fb5ae9163513c56d7
change-id: 20260813-pks-odb-write-alternates-at-creation-time-64010deb94a0

