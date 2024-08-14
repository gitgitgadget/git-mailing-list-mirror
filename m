Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AE7374F6
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618317; cv=none; b=nLAW72LNFvUOZUyHVBLawgt9gNHmh/+Q5dFFzuSi7jC0j/0KEa5cQ6VeR65LFCQkeJc+YeQijDhCrbCHwj4y2tNRuZS2PFJc3lmZcL9ky+F/qjnckfLsAdPEvFWzbprztwK3yPfuxFYF14N/P2nNPxIpPIjqXeI5IBoVVGgLVYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618317; c=relaxed/simple;
	bh=PUI1rHxC9yxnO9ceNbwtHqBHEfI+xkMM5tM6muxUMM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIdiBQ7TpbdArppZaVyNIPH9pzvP8PLSpba/aLm+nAQk2aOa9o5tExX97bGeg7ShYB5RDdY4ucLuKrhGvugE1h2PXTmWNR0LGETSE+GFU48drl5i4KCuOJjtLmRpmxUDGthn2PUcDG1lqz7QXbBuuhvZx37QHq85lkcYyGLHzcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nh/ZPlUG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dacy9niM; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nh/ZPlUG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dacy9niM"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0244B138FC5F;
	Wed, 14 Aug 2024 02:51:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 14 Aug 2024 02:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618313; x=1723704713; bh=Ww1+sBfLrO
	qz5O5ffyVqBxnmNuTfvt0jIEAjgNx4tO8=; b=Nh/ZPlUGFi2m90Vps2rkr2Tv1J
	Alu80Fpin9iTdJ0BpZ3MzMBtUfeemiQe8cHmnPgMkFipWNb/pXcDIwBMl2xmXNkA
	nP3EvQpxwzgcLR6IBG16U3+zs3j7iFBjpETcU4Ni6eK9WO0MrCe2dPBHC2r2y7W5
	3rcBrZwT8ZeliRL4DHaL6IKu+rfQZr6Mbao4+n7hLytYRhOVfhwv0ku9SjpBPx5h
	50oopsp1f7/qRObzDxS8LQkKQdN/GDgnbzF7ertbLiN9SrL+xGG9iDJ7ZwXb1nzn
	f5oLph0k3trxtxF+XcQl/j6/scy6jnkE2HSEDO8RLHXZsDGFq5sPuL1/ILkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618313; x=1723704713; bh=Ww1+sBfLrOqz5O5ffyVqBxnmNuTf
	vt0jIEAjgNx4tO8=; b=Dacy9niMrf6A1bcrUd11ZnzfZUhDr1LeNWNDzR4M1z5I
	W50yTn5QR0WhIHmxL1q+mkKhvekdBJCpqa9wYt1rsi6YVCZDRp4yAdM7pedUcm46
	L3xt94DWiwIkB1SnxXFmoKc4XkEtiryjV6KdOg+y/q8U/3aKVkgKP9bSyVRMhiYl
	oT0xvhvhR4P+iHQaEleAThpcPDqemjxC7ABnWWZJYNU2ht/s4qdP3cYcLm9LSoQw
	vJRRCoA1MHFGudXK4EpdmwF5y5+Z/+ZaqmQaVC0G9wAIRKlX+sKOU4mos1Kxq8yM
	B8HlRY/CBA6kX7HvGmtfz7vTVgpta4RA+rJvvoe3mA==
X-ME-Sender: <xms:CVS8ZuCAi5Ltz7wLkKjE61WJ7E9IHYpMI2_xmro36MZjJvNhDTPSLg>
    <xme:CVS8Zog7pRH5Gg6wKrxeUcRvvzQBq4F-2Pv-otj6ejqNyrCZeahhKvZghYMqT-b9f
    NwoBbxX_XLnK4oAzg>
X-ME-Received: <xmr:CVS8Zhnhlr9FJcWkMe14zIojdRM143eAs0-lWkoTCwtT5T3cF2oyJHLBvb3IQ41W3f6TkGTSFYUvJEgBMWWp2DmiM9EfvgtOEPM_NqAObfzTow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:CVS8Zsy5aZdG-tzyBv_QbUPOv8Jh3pDMApWt351YyMBjzIwF0IVpvg>
    <xmx:CVS8ZjQoReFtPP36QHdiLLMg4kX3igJbnztJSbKYu8hoFOzOCPnCqg>
    <xmx:CVS8ZnZyZ7U8AdSFSZyI90JEm4g8OIWS3OGxYoLVVy635Q0a_sA3cQ>
    <xmx:CVS8ZsRRR3mtG7_KU2PxHfEwQjyeSHxmzJGSSKYv6F0ScSdotY30SA>
    <xmx:CVS8ZiHeWl3JyfwMzBN2WE7YbGvXpypv51nNIh-7IQr2z4MUafsbz7zq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:51:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b64c8bae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:51:32 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:51:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 00/22] Memory leak fixes (pt.4)
Message-ID: <cover.1723614263.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>

Hi,

this is the fourth version of my fourth set of memory leak fixes. There
are only minor changes compared to v3:

  - Amend a commit message to explain that `release_revisions()` takes
    care of releasing `rev.diffopt` for us.

  - Fix another memory leak in `get_base_commit()`.

  - Remove `NULL` pointer check in `symdiff_release()` and stop
    zero-initializing `struct symdiff`.

Thanks!

Patrick

Patrick Steinhardt (22):
  remote: plug memory leak when aliasing URLs
  git: fix leaking system paths
  object-file: fix memory leak when reading corrupted headers
  object-name: fix leaking symlink paths in object context
  bulk-checkin: fix leaking state TODO
  read-cache: fix leaking hashfile when writing index fails
  submodule-config: fix leaking name entry when traversing submodules
  config: fix leaking comment character config
  builtin/rebase: fix leaking `commit.gpgsign` value
  builtin/notes: fix leaking `struct notes_tree` when merging notes
  builtin/fast-import: plug trivial memory leaks
  builtin/fast-export: fix leaking diff options
  builtin/fast-export: plug leaking tag names
  merge-ort: unconditionally release attributes index
  sequencer: release todo list on error paths
  unpack-trees: clear index when not propagating it
  diff: fix leak when parsing invalid ignore regex option
  builtin/format-patch: fix various trivial memory leaks
  userdiff: fix leaking memory for configured diff drivers
  builtin/log: fix leak when showing converted blob contents
  diff: free state populated via options
  builtin/diff: free symmetric diff members

 builtin/commit.c                      |  7 +-
 builtin/diff.c                        |  6 ++
 builtin/fast-export.c                 | 19 ++++--
 builtin/fast-import.c                 |  8 ++-
 builtin/log.c                         | 14 +++-
 builtin/notes.c                       |  9 ++-
 builtin/rebase.c                      |  1 +
 bulk-checkin.c                        |  2 +
 config.c                              |  3 +-
 csum-file.c                           |  2 +-
 csum-file.h                           | 10 +++
 diff.c                                | 16 ++++-
 environment.c                         |  1 +
 environment.h                         |  1 +
 git.c                                 | 13 +++-
 merge-ort.c                           |  3 +-
 object-file.c                         |  1 +
 object-name.c                         |  1 +
 range-diff.c                          |  6 +-
 read-cache.c                          | 97 ++++++++++++++++-----------
 remote.c                              |  2 +
 sequencer.c                           | 67 ++++++++++++------
 submodule-config.c                    | 18 +++--
 t/t0210-trace2-normal.sh              |  2 +-
 t/t1006-cat-file.sh                   |  1 +
 t/t1050-large.sh                      |  1 +
 t/t1450-fsck.sh                       |  1 +
 t/t1601-index-bogus.sh                |  2 +
 t/t2107-update-index-basic.sh         |  1 +
 t/t3310-notes-merge-manual-resolve.sh |  1 +
 t/t3311-notes-merge-fanout.sh         |  1 +
 t/t3404-rebase-interactive.sh         |  1 +
 t/t3435-rebase-gpg-sign.sh            |  1 +
 t/t3507-cherry-pick-conflict.sh       |  1 +
 t/t3510-cherry-pick-sequence.sh       |  1 +
 t/t3705-add-sparse-checkout.sh        |  1 +
 t/t4013-diff-various.sh               |  1 +
 t/t4014-format-patch.sh               |  1 +
 t/t4018-diff-funcname.sh              |  1 +
 t/t4030-diff-textconv.sh              |  2 +
 t/t4042-diff-textconv-caching.sh      |  2 +
 t/t4048-diff-combined-binary.sh       |  1 +
 t/t4064-diff-oidfind.sh               |  2 +
 t/t4065-diff-anchored.sh              |  1 +
 t/t4068-diff-symmetric-merge-base.sh  |  1 +
 t/t4069-remerge-diff.sh               |  1 +
 t/t4108-apply-threeway.sh             |  1 +
 t/t4209-log-pickaxe.sh                |  2 +
 t/t6421-merge-partial-clone.sh        |  1 +
 t/t6428-merge-conflicts-sparse.sh     |  1 +
 t/t7008-filter-branch-null-sha1.sh    |  1 +
 t/t7030-verify-tag.sh                 |  1 +
 t/t7817-grep-sparse-checkout.sh       |  1 +
 t/t9300-fast-import.sh                |  1 +
 t/t9304-fast-import-marks.sh          |  2 +
 t/t9351-fast-export-anonymize.sh      |  1 +
 unpack-trees.c                        |  2 +
 userdiff.c                            | 38 ++++++++---
 userdiff.h                            |  4 ++
 59 files changed, 286 insertions(+), 105 deletions(-)

Range-diff against v3:
 1:  02f6da020f =  1:  02f6da020f remote: plug memory leak when aliasing URLs
 2:  f36d895948 =  2:  f36d895948 git: fix leaking system paths
 3:  0415ac986d =  3:  0415ac986d object-file: fix memory leak when reading corrupted headers
 4:  e5130e50a9 =  4:  e5130e50a9 object-name: fix leaking symlink paths in object context
 5:  276c828ad1 =  5:  276c828ad1 bulk-checkin: fix leaking state TODO
 6:  ed0608e705 =  6:  ed0608e705 read-cache: fix leaking hashfile when writing index fails
 7:  b7a7f88c7d =  7:  b7a7f88c7d submodule-config: fix leaking name entry when traversing submodules
 8:  9054a459a1 =  8:  9054a459a1 config: fix leaking comment character config
 9:  1d3957a5eb =  9:  1d3957a5eb builtin/rebase: fix leaking `commit.gpgsign` value
10:  0af1bab5a1 = 10:  0af1bab5a1 builtin/notes: fix leaking `struct notes_tree` when merging notes
11:  30d4e9ed43 = 11:  30d4e9ed43 builtin/fast-import: plug trivial memory leaks
12:  9591fb7b5e ! 12:  070813a740 builtin/fast-export: fix leaking diff options
    @@ Commit message
     
         Before calling `handle_commit()` in a loop, we set `diffopt.no_free`
         such that its contents aren't getting freed inside of `handle_commit()`.
    -    We never unset that flag though, which means that it'll ultimately leak
    -    when calling `release_revisions()`.
    +    We never unset that flag though, which means that the structure's
    +    allocated resources will ultimately leak.
     
    -    Fix this by unsetting the flag after the loop.
    +    Fix this by unsetting the flag after the loop such that we release its
    +    resources via `release_revisions()`.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
13:  254bbb7f6f = 13:  b4096e971f builtin/fast-export: plug leaking tag names
14:  334c4ed71a = 14:  bdfdf53313 merge-ort: unconditionally release attributes index
15:  9f08a859fb = 15:  f6c1055805 sequencer: release todo list on error paths
16:  5d4934b1a9 = 16:  9db41181a6 unpack-trees: clear index when not propagating it
17:  e1b6a24fbe = 17:  85f6ffd610 diff: fix leak when parsing invalid ignore regex option
18:  c048b54a2c ! 18:  e00aa1ef06 builtin/format-patch: fix various trivial memory leaks
    @@ Commit message
     
      ## builtin/log.c ##
     @@ builtin/log.c: static struct commit *get_base_commit(const struct format_config *cfg,
    + 				if (die_on_failure) {
    + 					die(_("failed to find exact merge base"));
    + 				} else {
    ++					free_commit_list(merge_base);
    + 					free(rev);
    + 					return NULL;
    + 				}
      			}
      
      			rev[i] = merge_base->item;
19:  39b2921e3e = 19:  cc04751134 userdiff: fix leaking memory for configured diff drivers
20:  50dea1c98a = 20:  0e2d3e523f builtin/log: fix leak when showing converted blob contents
21:  d5cb4ad580 = 21:  9faffa7a62 diff: free state populated via options
22:  31e38ba4e1 ! 22:  ee252e752c builtin/diff: free symmetric diff members
    @@ builtin/diff.c: static void symdiff_prepare(struct rev_info *rev, struct symdiff
      
     +static void symdiff_release(struct symdiff *sdiff)
     +{
    -+	if (!sdiff)
    -+		return;
     +	bitmap_free(sdiff->skip);
     +}
     +
      int cmd_diff(int argc, const char **argv, const char *prefix)
      {
      	int i;
    -@@ builtin/diff.c: int cmd_diff(int argc, const char **argv, const char *prefix)
    - 	struct object_array_entry *blob[2];
    - 	int nongit = 0, no_index = 0;
    - 	int result;
    --	struct symdiff sdiff;
    -+	struct symdiff sdiff = {0};
    - 
    - 	/*
    - 	 * We could get N tree-ish in the rev.pending_objects list.
     @@ builtin/diff.c: int cmd_diff(int argc, const char **argv, const char *prefix)
      		refresh_index_quietly();
      	release_revisions(&rev);
-- 
2.46.0.46.g406f326d27.dirty

