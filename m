Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219F33438A7
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345929; cv=none; b=R2TzXdv5s9Cjej+t7okq10WXbiF7pEDaXAdDmgxvBYwHzriCIFm12eg/n2rncBOZU7egP2rgMOlOOaa65RDjAW4xK7BfISSgNkDfADBjHuwhrNZZ52/edXzZ7R6o2NHs7neg0IJ2e6+VrnO7CiTx48wY2KPYTmO0DdYgFrj2T3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345929; c=relaxed/simple;
	bh=WUf5W1270UZWme2KXVMENnLsHJXpEpcCCkaACVbKv+4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+XKEUUG0Zr1UQY474+C9L2W/H/f/66lEv+p4a7jU6SakgrshQMJzf2vQvfTnbJF8sRY9ZbRRWkrpXRv1M1gXwLOK+RC7BekSi6aPERe9RrG9d2WZSAUFg8+HwYSRa/cOdMqhLj/fNrEsgYXW2zmEFXmrGr7W7JqHWtAiMPyLTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mIsHjuxv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l2GxRDTL; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mIsHjuxv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l2GxRDTL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0FF917A015D;
	Wed, 29 Jul 2026 13:25:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 29 Jul 2026 13:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785345925; x=
	1785432325; bh=MUMK+aK8Q207Us9j4G6kmXwzcu29Pjf6CI6k3JRPXxs=; b=m
	IsHjuxvJPEl7lRukTNjtusQtxRrBKMiRnp1jPvb7BY3usmAGUODhK41X67b1b+Kd
	GcsklO0QZvj6/0ix+QFy9bAyIWq2T7Bit1IY7n/EcPpaddQAi3sqUb0QybJAKXf7
	CecGVZNeIM52scsvPZsa4yN7W7zsbNgzTIFevKWyeim1pmCM4AYMnL32NrZ7pqqb
	IeAe3jHZxtjkx0vgS7mFza6EeKL8gZ+npcM2+3kWHV7sgeOv07TEd+wANuzJwjjb
	zfAZ2qunT2sBzpfLLV4Fwb5djvylswV5MywZP/hzEj0SDe6KqaOghP2JzoMwU4x5
	1Jq0BfhDk754nY7XMhGXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785345925; x=1785432325; bh=MUMK+aK8Q207Us9j4G6kmXwzcu29
	Pjf6CI6k3JRPXxs=; b=l2GxRDTLwfc1F55VTf73uifKZlwCAUnV4mAPOUux5PWl
	xoNxRwWv0gr6ViQOb8w4vkRej/L2bg9n9bp9c3Vhgt83KoU0WSSrWd6lxNqVqobG
	1sUwYGexBYDLVBLAYjsAcUIb3FOtN4Q200+5SNUYJP1Ag5A9kLfUETQ4h9CJsgcm
	GjYpZvXv38IJVZpAnDMXjaNfiR9xl+PtI1qrEbgnzXIb0hRlVyg4dtEwxlkPY4Wn
	4wICMzJEAnjptqJXFDvRUVU+beWGrCUcdIrtqum6JvpROzDvxiLkeKefX+mDi+6x
	N46+Oqmbj2mTH87uMAKmUnUzR5t2S4+BOb/vepWpUw==
X-ME-Sender: <xms:hTdqahnUTe0UkP-HpUCjwb_luciPJRKuxrBr4PPf6LYWAByOXLNYmA>
    <xme:hTdqai1kUQTUn81EaizFos7NC_OfPgEGNKqfVk8kK5wW7rYdx5F4cR5qhYfIM3ykL
    TNp1atcu0vT-0sd__zcldKqy4nFFjfnSVVmYSYQ0BwTMCR90SYa1ZM>
X-ME-Received: <xmr:hTdqalQLbYrpOm2Im3ylDNpEia7hzG_ZUzRGtG16qJHEleWIWkb-uLvQhB_4tvsAPhZy9HIzxgeXQhquOl8Tv6sjWlGLgl-b_w>
X-ME-Proxy-Cause: dmFkZTFT8eh+q27HvXD+Wx8OA1uTo60JFz9BF05YiM7iMz2oCc2RRskRsTqpLdtGOSox/z
    lqJ2nFcftm39MSsHTROB/6kSWbPHByu/HsgTk6STeF8LRxffBvW6D8yTkXnpy5eQzOdCaD
    AtBzelXbM5dLaxqF6bp8h8dTB7nFFJ9jpv/5gyoYh0pfSp2iY1s0zSK6jEe6E5CfuiRi6S
    TJ0V8QPtZ1aqSpdAy67ps0A9vEp+1DsVkrAN6tPXbQi/yX7GHAJRUVUKIjLgsK+GA74z+Q
    qWx6bEIVpr7KlqcMAlXoT86O8mlRjkl0aIGQ1uxjxSIgni+EBMzRoDSZO7/RORu6wy/Inn
    zrS/VyRLiZ5msHzcfJlYXOf6ICwRbQhp1TZZ+I/I4/argLfmfsOy4MHQrpOtRXSvN7jPdU
    zRkrEiGdpyMlYcKdDIU5tAiGSTlCfoY95cC2114Hk7DBxf+Wqr5GG657FUB4+o3ji07FHG
    ek+BS+s38dmoIayT39ZOTmosDJZ8Z7H5pq91rbl++9jmTuyDtbknMZBO8qmht4icgYSZ6x
    rydpHlM0kYqX39Z8XEg3fbJp0IzGwmdosrlyPvC1iGMwUpN5NEZhVyD6j//alWMIlOGqyQ
    Kj8BqLYyR48lYMb47d2srJZXAqlomqMYg1vYKYeAGXX13eUpHPEWfHn9Jh8A
X-ME-Proxy: <xmx:hTdqasuT5VkUAs8h7sc_Yb0Wh7gfZJbtakJu6atnarKeE7l5YXOzlQ>
    <xmx:hTdqaibNcrzMpUQ5-v4uoMpsrn63DnZKtQyPnRvxFuZmFoPcI21Nsw>
    <xmx:hTdqapto0RGSCnbIpImLADga4gBCiM1Tw0arsHJOd4kM7YsL9yA1qg>
    <xmx:hTdqasF-nW5D1r0ECNzVnBdxsbgtrAtcqQT3I-9nQ-wznZnaoDDbsA>
    <xmx:hTdqas_iQ2SEj4I6B4j60Rtzj3mAQlsH_iVoWIpda4usquH8HBdDYL1i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 13:25:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 0/4] git add --resolved
Date: Wed, 29 Jul 2026 10:25:20 -0700
Message-ID: <20260729172524.4022621-1-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-609-g9a17695db7
In-Reply-To: <20260728215219.753678-1-gitster@pobox.com>
References: <20260728215219.753678-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When you are the maintainer of a project and make many merges day
in, day out, a lot of your time is spent resolving conflicts and
adding the results to the index.  It is not unusual to have local
changes in your working tree that are unrelated to any particular
merge [*].  In such cases, 'git add -u', which adds all changes in
the working tree to the index, does not help much.

Here is a new option for 'git add' that lets you add paths with
resolved conflicts to the index, while keeping unrelated local
changes out.

The first three patches perform preliminary refactorings.

 - [1/4] is a totally unrelated code cleanup that almost disappears
   when viewed with 'git show -w', but it was an eyesore to have so
   many lines with broken indentation while working in the vicinity.

 - [2/4] consolidates a helper function to determine whether a line
   is a conflict marker (replacing two slightly different
   definitions).

 - [3/4] introduces a helper that makes registering path removals
   from the index as easy as adding them, complete with automatic
   '--dry-run' and '--verbose' support.

The fourth patch implements the new feature.  Relative to v1, the
detection of the use of the '-A' option was fixed and the Meson build
file was updated to include the new test script, both thanks to
Michael Montalbo.  In addition, the has_conflict_markers() helper
has been tightened to bail early on a binary file.

 1/4: read-cache: reindent
 2/4: merge-ll: consolidate conflict marker scanning logic
 3/4: read-cache: add remove_file_from_index_with_flags()
 4/4: add: introduce '--resolved' option

[Footnote]

 * This is not limited to my own workflow. An earlier message on
   this topic worth mentioning is:

   https://lore.kernel.org/git/CA+55aFxP8j7YbYaRXt-8Y0n8cHafB=FPKMy8gKFYH5QsKX4S=Q@mail.gmail.com/

 Documentation/git-add.adoc |  10 +++-
 builtin/add.c              |  92 ++++++++++++++++++++++++++++---
 diff.c                     |  25 +--------
 merge-ll.c                 |  56 +++++++++++++++++++
 merge-ll.h                 |   2 +
 read-cache-ll.h            |   3 ++
 read-cache.c               |  89 +++++++++++++++++-------------
 rerere.c                   |  38 +++----------
 t/meson.build              |   1 +
 t/t2207-add-resolved.sh    | 108 +++++++++++++++++++++++++++++++++++++
 10 files changed, 323 insertions(+), 101 deletions(-)
 create mode 100755 t/t2207-add-resolved.sh

Range-diff against v1:
4:  c503fbb785 = 1:  e46fe3e887 read-cache: reindent
1:  03ea86d803 = 2:  b5490819bd merge-ll: consolidate conflict marker scanning logic
2:  e94e3c1390 = 3:  e1f4aba480 read-cache: add remove_file_from_index_with_flags()
3:  73679d6b69 ! 4:  b1308a0ca1 add: introduce '--resolved' option
    @@ builtin/add.c: int cmd_add(int argc,
     -	if (addremove && take_worktree_changes)
     -		die(_("options '%s' and '%s' cannot be used together"), "-A", "-u");
     +	die_for_incompatible_opt3(take_worktree_changes, "-u/--update",
    -+				  0 <= addremove_explicit, "-A/--all",
    ++				  0 < addremove_explicit, "-A/--all",
     +				  add_resolved, "--resolved");
      
      	if (!show_only && ignore_missing)
    @@ merge-ll.c: int is_conflict_marker_line(const char *line, unsigned long len, int
     +			has_markers = 1;
     +			break;
     +		}
    ++		if (buffer_is_binary(sb.buf,
    ++				     ULONG_MAX <= sb.len ? ULONG_MAX : sb.len))
    ++			break;
     +	}
     +	fclose(f);
     +	strbuf_release(&sb);
    @@ merge-ll.h: enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
      
      #endif
     
    + ## t/meson.build ##
    +@@ t/meson.build: integration_tests = [
    +   't2204-add-ignored.sh',
    +   't2205-add-worktree-config.sh',
    +   't2206-add-submodule-ignored.sh',
    ++  't2207-add-resolved.sh',
    +   't2300-cd-to-toplevel.sh',
    +   't2400-worktree-add.sh',
    +   't2401-worktree-prune.sh',
    +
      ## t/t2207-add-resolved.sh (new) ##
     @@
     +#!/bin/sh
-- 
2.55.0-609-g9a17695db7

