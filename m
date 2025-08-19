Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E331311C1D
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591620; cv=none; b=tl5IcD+6gGhU6S1uq83rNffGUlo9aoEm3dyfB914LSquQIt3V5o3KdkL0+7gejz5VOmq1UnoaeXZv0Ct3aOWYJuInmK7n2lzVjsYGShHYYI/wCex7xklIUTbGIu8BmulbOin5oAJ6mTsWW7soVdxeAaIgIWW8DK1Ixsm8eL6CgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591620; c=relaxed/simple;
	bh=Hy2YswTsJ1AVRrfrxc903H6/aa66N6SSrmF03IjzJto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jpbg2xYaBYFnUTPmw4o1+ecYREXToK4b6ccWwTEcARQJioEah3oCA04joEQHLZ6Fc96i/hUhhwREW+P0+3efbP9qcDHjcMz67R8vsv+QV6ggKPe1VOueHX3t1WUhqfbCYH6HnFpSwhb2+6z41+JVyEze6ViPWlmMJldN2POhXPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XQucKBw5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FvrpbCZ+; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XQucKBw5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FvrpbCZ+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 541351D0025D
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 04:20:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 19 Aug 2025 04:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755591618;
	 x=1755678018; bh=IFnrTMW2tPQQomEjflIVRuSDkNJcedHK9eEIdKxrvz4=; b=
	XQucKBw58i4kiDt+z/RB8obhLQ9SeseuLqwrJU9BOVuwy4xpX3getuanm7rdWE36
	DrHNzjvVyaYoqcdM9BMezS8zevi8uML9u4bH/nbNSdZuHAxagDd3ZXvTPyBF5dft
	NmbvCJMlOsjg4vfzi1dHPTuXKMZcGQHJSdv27OLsx+HNA+r72VANyJCabHuiHn+B
	olVdqf+OuWAViUK6Tl6Sp3knEyrm++CRbxGDxELXXlysKrKJGS9P9T91Wcgp27Hd
	Bo/7O/7dQhTDMJBVBvwOwbZwJe/cYRqNxBr3WkOVEUWWA0i5mxXbINXl+ylZvLgy
	EePh/TjNNcxpZ/n8lZTtCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755591618; x=
	1755678018; bh=IFnrTMW2tPQQomEjflIVRuSDkNJcedHK9eEIdKxrvz4=; b=F
	vrpbCZ+QTVEq8U2znY0tezIIMuZPwL/LxQv3+c38/15LEYBBLj4Hm3LFDlHedPA6
	TMo3gVk9qYU5xXQF7N/gaEJtZAO6SYrzhVVtFZkGahzEqBT8Yl5Y1RgOuSRTkStj
	gwZiX83wPXMHp9GUSrnE20cVy02xexP1NhZE3+BB9Rxvl6U8ljU+bE8jvID/dGbv
	g3wp2jcROfG7r5dH87eTPRB1F+jM9ZBf9yBYObW4LBXMCHcxcdqebZv9j9vfwfwp
	eUn2WBUMy6T6xvv8fT8Z5n1xCRPjyiSfbQrlpc6IYOpddcJHR9sZ2aeM8B0il7af
	0BnmmIuksneuTOotsmoww==
X-ME-Sender: <xms:wjOkaMhcdEp5CZBkax9RP2Hkblbv-23T1rghJKrNI_2n4clNRzC9ow>
    <xme:wjOkaHCcabNshMaXBJh1bSSJiqnT_nQ7cofmeZlNF_uqJstRvTnCFgs_N5qpIpikz
    sLHJtDinFGeKgXakQ>
X-ME-Received: <xmr:wjOkaNe8OQaLGToddtX_T61l4Uf8GH8SJO5WNn5SrdJhDb6wvhOOZUp8PRwB9ECzyGaWsd43DzeTvY782qjpfCLSc_g_wrMHT7Kq635l_39f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:wjOkaPeGl69AWYodQA75wkCx9GkZEDn7rtOeCSQfOE6jdTKH6m92nQ>
    <xmx:wjOkaBhOJUaju0tVmIpxt3JLsqQfS0ppZujHDaAhu4DQLJfnqgqOAw>
    <xmx:wjOkaLTZKj89X_8O7FLzLXy8uT0Ey_LnXZAEfyTWgVGJnod2Qah6-A>
    <xmx:wjOkaCwJWgc3E2YW6nkdKhKqOzkTEjSNOI-2BXesXL9w7G4PIVk9Kw>
    <xmx:wjOkaKZXnl7LRgTAf46qElQqpxt_lPUtKr2QISoU4jOSNr5QhSelPTad>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 04:20:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 67eeb15e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 08:20:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 10:19:43 +0200
Subject: [PATCH 14/16] packfile: remove `get_packed_git()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-packfiles-store-v1-14-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

We have two different functions to retrieve packfiles for a packfile
store:

  - `get_packed_git()` returns the list of packfiles directly.

  - `get_all_packs()` does more work and also prepares packfiles that
    are being indexed by a multi-pack-index.

The distinction is not immediately obvious. Furthermore, to make the
situation even worse, `get_packed_git()` would return the same result as
`get_all_packs()` once the latter has been called once as they both
refer to the same list.

As it turns out, the distinction isn't necessary. We only have a couple
of callers of `get_packed_git()`, and all of those callers are prepared
to call `get_all_packs()` instead:

  - "builtin/gc.c": We explicitly check how many packfiles aren't
    contained in the multi-pack-index, so loading extra packfiles that
    are indexed by it won't change the result.

  - "builtin/grep.c": We only care `get_packed_git()` to prepare eagerly
    load packfiles. In the preceding commit we have started to expose
    `packfile_store_prepare()`, which is a more direct way of achieving
    the same result.

  - "object-name.c": `find_abbrev_len_for_pack()` and `unique_in_pack()`
    exit early in case the multi-pack index is set, so both callsites of
    `get_packed_git()` know to handle packs loaded via the MIDX already.

Convert all of these sites to use `get_all_packs()` instead and remove
`get_packed_git()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c   | 2 +-
 builtin/grep.c | 2 +-
 object-name.c  | 4 ++--
 packfile.c     | 6 ------
 packfile.h     | 1 -
 5 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 1d30d1af2c..565afda51f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1422,7 +1422,7 @@ static int incremental_repack_auto_condition(struct gc_config *cfg UNUSED)
 	if (incremental_repack_auto_limit < 0)
 		return 1;
 
-	for (p = get_packed_git(the_repository);
+	for (p = get_all_packs(the_repository);
 	     count < incremental_repack_auto_limit && p;
 	     p = p->next) {
 		if (!p->multi_pack_index)
diff --git a/builtin/grep.c b/builtin/grep.c
index 5df6537333..8f0e21bd70 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1214,7 +1214,7 @@ int cmd_grep(int argc,
 		if (recurse_submodules)
 			repo_read_gitmodules(the_repository, 1);
 		if (startup_info->have_repository)
-			(void)get_packed_git(the_repository);
+			packfile_store_prepare(the_repository->objects->packfiles);
 
 		start_threads(&opt);
 	} else {
diff --git a/object-name.c b/object-name.c
index 44b0d416ac..c87995cc1e 100644
--- a/object-name.c
+++ b/object-name.c
@@ -213,7 +213,7 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 			unique_in_midx(m, ds);
 	}
 
-	for (p = get_packed_git(ds->repo); p && !ds->ambiguous;
+	for (p = get_all_packs(ds->repo); p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
 }
@@ -806,7 +806,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 			find_abbrev_len_for_midx(m, mad);
 	}
 
-	for (p = get_packed_git(mad->repo); p; p = p->next)
+	for (p = get_all_packs(mad->repo); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
 
diff --git a/packfile.c b/packfile.c
index bc32c45fe6..f1526e361c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1029,12 +1029,6 @@ void packfile_store_reprepare(struct packfile_store *store)
 	packfile_store_prepare(store);
 }
 
-struct packed_git *get_packed_git(struct repository *r)
-{
-	packfile_store_prepare(r->objects->packfiles);
-	return r->objects->packfiles->packs;
-}
-
 struct packed_git *get_all_packs(struct repository *r)
 {
 	packfile_store_prepare(r->objects->packfiles);
diff --git a/packfile.h b/packfile.h
index 1522da96f8..dff0237092 100644
--- a/packfile.h
+++ b/packfile.h
@@ -212,7 +212,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
 struct packed_git *get_all_packs(struct repository *r);
 

-- 
2.51.0.261.g7ce5a0a67e.dirty

