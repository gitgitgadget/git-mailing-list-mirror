Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B68D3B6356
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197489; cv=none; b=Xc3nCQeuNzf/HoC7aw/rfVgrV25hr2t8qK5oWACqoBKX+50fJjBJt3GuC7hzJIVySkUkasmRh2as3fU+h4XqVyv2o9WaryxtbxPHoewWpKxCFKo3k223idoOTm55iyExNYAApc/zYdcstADv5IJ7gO2XNCMTKdzyMmZqq1eQKXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197489; c=relaxed/simple;
	bh=wCCOywJKaiZMyAo/gw1lVn4qVAGsvfqjV2Cl+lwfZpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TtSKXkZNgAbWVLonjsTrMQZPqyNynWp91/uJngVVKx9KbXIcePKA7/QBugt0XUUNLzPvc865Xho3xIRbuKIny82ObcadvJ8jxfniYatJYaCsP80jCHi1mzBGwt6yyy3b4W9JkkEJ1tRbkVAkxa1Kf2FtCsl1GseqJLoKPXqm/uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBYfwJkF; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBYfwJkF"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a985e8fcddso1901275a12.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 14:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790197485; x=1790802285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AmUkDGw7dqfPKAKYgWUdH/cd+y+97Ps37Rdr+vwnDDo=;
        b=UBYfwJkF3thtoE25U/pllVBkEblsXGBBJYO5WsrewqpyGCAv4TvwGYzdczzqRK6Lza
         zWCVKEgKYRF331MXd2e74iJn3O0WBFNo0Rs0NAGuzbFWn3KWIOVt7UfdhbEcIV9WTEVc
         PKJTqJVs7OKHjf89LG0/Pgcf/UlMrddd07ucfbRXK1/h7LYlbLCIizHMiEXMWMQ/HO3u
         lyInnq7eQOew0+LLrLNh9lJMHQ8l3ckZYur7pqUiLHuPTOWTbh6FdZ2rB1GETXufDMNj
         hdkcEpHiihXIzTxaVscwojtndfn0O6Shaz12NlRx2WLPDjyNdKwl35aTTjDavKPT3Gdi
         0bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197485; x=1790802285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AmUkDGw7dqfPKAKYgWUdH/cd+y+97Ps37Rdr+vwnDDo=;
        b=bap4A7/xrjB6XBXzs421HdRFJILWFvjscT4/wEyl/qwZITxKDu6SBSkKQUpZvfXW49
         TNqA4uW7P72fLLYCorWy6vAfqqKLRufapJwkdDbErcd0u0xFWWAO2s+xM6k6AmDEjx6f
         0c4CyaWzzIfpm0ecHJEm7oMNg2ELNGW2nNDsz5QmgdSELkCmHxa7ObnciAxKLExuZn1W
         tF5d1ZxhHpRoN1V9YvoRQcqw7iGQyZUTpeLsFQRyG4mFEXPvlRtQsnsugxYIHSni3a1h
         FRfiK+Odvg8QeTGvgu5M7DXERVSKQ3BkpPNzW6qKrhlgo6eeeyt41v07VuWiv47kIlq7
         7iSg==
X-Gm-Message-State: AFuF++l3KUW4i1Mi0S5TigBUbRmw2hNrltCovGaYWKBHGBVLWUXIKxqr
	t9LS1tBcrqAe2mIjixSWnvqoQTO8ZWGd0NVRSfRAANF5PspcOQpR1OmEMrpi0yNk
X-Gm-Gg: AYBFou0ijRgjnX/sgkVYWOZDAZaRmoZesTKDPL38fL9BqzdjNE83Iz0JYZNYZd+Os0M
	l/YPTZhevSkTfi2o3L2yVYt9/SXWFczJck4RacQxwUkLMvvLE+6BbP8iDud3s7v34b+e+0I5fhp
	pTcUbszQIdYxqiwvUhyB3LqghP4GBTGxe6JxqpACXWQ293gAjKNgB+SUTVFjfocojeHeA5eguzM
	CXHqQXGuIIlg1/j6OFOvk5Jsd2wyoy0JgYoyhqkLp0LortsMDafZSoEB7jsRBKP/yCW5uBz0Ic+
	yEdpRn6WMOLMakUpdSdDGnPhCdPjz/ngujMBP96BO8ndFb/fz410GYPZFJaHvgeegy8xXyxZ95H
	c+eAkXFCZzvmTAWU/J2k8DOktzFYukRbh9zmemi1beB0uUhRhNzZXcAFUhE5MjoFnpw/423zsNC
	YjdBmLXaKSy6VHYd/vwi055DX+kD+ucZPW7ej/OsIubA3hEEpy6//P70TpK7pDg9FJUg0iel8Kp
	s1uVGw1RG1LfRMMcin+gPXw37bJIUAMg2sad1dAfQX8IPfv9KO02SiCMgyijPP91vjN07hviwai
	YTc2x6eMrp9QdvvmFHNTiNJe47o6FGix/0i8nD1sHje5usD5
X-Received: by 2002:a17:907:f497:b0:c25:8fdf:5d with SMTP id a640c23a62f3a-c2ac2395ae9mr30220066b.13.1790197484844;
        Wed, 23 Sep 2026 14:04:44 -0700 (PDT)
Received: from localhost.localdomain ([91.236.84.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae60e4c8sm189325366b.26.2026.09.23.14.04.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 14:04:44 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phil Hord <phil.hord@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Subject: [PATCH v5 0/3] refs: report old OIDs for batched deletions
Date: Wed, 23 Sep 2026 23:04:39 +0200
Message-Id: <cover.1790196627.git.maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790113781.git.maciej.ciemborowicz@gmail.com>
References: <cover.1790113781.git.maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for catching the broken intermediate commits. This version updates
every refs_delete_refs() call site in 1/3, using NULL for the optional data
that is not supplied until the later patches. Each patch now builds on its
predecessor. The final tree is identical to v4.

This follows up on the reference-transaction bug report at [1].

The reference-transaction hook receives zero as both the old and new OID
when branch, tag, fetch, and remote delete refs through refs_delete_refs().
Those callers already know the values that they selected for deletion.

Teach refs_delete_refs() to accept a parallel array of expected old OIDs and
pass them into the transaction. Besides making hook records useful, this
restores conditional deletion for branch and tag and adds it to pruning
without additional ref reads. Non-atomic batches preserve best-effort
behavior, while atomic fetches remain all-or-nothing.

Changes since v4:

 * Update all refs_delete_refs() call sites in 1/3 for the new signature.
 * Verify that 1/3, 1/3--2/3, and the complete series each build with
   DEVELOPER=1.

The focused reference-transaction tests pass with SHA-1 and SHA-256 using
both the files and reftable backends. The full test suite passed on the
identical final tree in v4.

[1] https://lore.kernel.org/git/CACQ=SRGTTdQ+dHXhN6F52dBv5KxZBRfk_Em2fvmEmGJDoB6oTg@mail.gmail.com/

Maciej Ciemborowicz (3):
  refs: allow callers to supply old OIDs for batch deletion
  branch, tag: retain old OIDs in batched deletions
  fetch, remote: retain old OIDs when pruning refs

 bisect.c                         |   2 +-
 builtin/branch.c                 |   7 +-
 builtin/fetch.c                  |  30 ++++--
 builtin/remote.c                 |  47 +++++++--
 builtin/tag.c                    |  28 ++++--
 refs.c                           |  67 ++++++++++---
 refs.h                           |  31 ++++--
 t/helper/test-ref-store.c        |   2 +-
 t/t1416-ref-transaction-hooks.sh | 160 +++++++++++++++++++++++++++++++
 9 files changed, 324 insertions(+), 50 deletions(-)

Range-diff against v4:
1:  f4a9d065c ! 1:  9b76cc2c4 refs: allow callers to supply old OIDs for batch deletion
    @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int ki
      	if (!(flags & DELETE_BRANCH_DRY_RUN) &&
     -	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
     +	    refs_delete_refs(get_main_ref_store(the_repository), NULL,
    -+			     &refs_to_delete, NULL, REF_NO_DEREF))
    ++			     &refs_to_delete, NULL, NULL, REF_NO_DEREF))
      		ret = 1;
      
      	for_each_string_list_item(item, &refs_to_delete) {
    @@ builtin/fetch.c: static int prune_refs(struct display_state *display_state,
      			result = refs_delete_refs(get_main_ref_store(the_repository),
      						  "fetch: prune", &refnames,
     -						  0);
    -+						  NULL, 0);
    ++						  NULL, NULL, 0);
      		}
      	}
      
    @@ builtin/remote.c: static int prune_remote(const char *remote, int dry_run)
      		result |= refs_delete_refs(get_main_ref_store(the_repository),
     -					   "remote: prune", &refs_to_prune, 0);
     +					   "remote: prune", &refs_to_prune,
    -+					   NULL, 0);
    ++					   NULL, NULL, 0);
      
      	for_each_string_list_item(item, &states.stale) {
      		const char *refname = item->util;
    @@ builtin/tag.c: static int delete_tags(const char **argv)
      	result = for_each_tag_name(argv, collect_tags, (void *)&refs_to_delete);
     -	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
     +	if (refs_delete_refs(get_main_ref_store(the_repository), NULL,
    -+			     &refs_to_delete, NULL, REF_NO_DEREF))
    ++			     &refs_to_delete, NULL, NULL, REF_NO_DEREF))
      		result = 1;
      
      	for_each_string_list_item(item, &refs_to_delete) {
2:  918c97d2b ! 2:  6a8401c44 branch, tag: retain old OIDs in batched deletions
    @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int ki
      
      	if (!(flags & DELETE_BRANCH_DRY_RUN) &&
      	    refs_delete_refs(get_main_ref_store(the_repository), NULL,
    --			     &refs_to_delete, NULL, REF_NO_DEREF))
    +-			     &refs_to_delete, NULL, NULL, REF_NO_DEREF))
     +			     &refs_to_delete, &old_oids, NULL, REF_NO_DEREF))
      		ret = 1;
      
    @@ builtin/tag.c: static int for_each_tag_name(const char **argv, each_tag_name_fn
     -	result = for_each_tag_name(argv, collect_tags, (void *)&refs_to_delete);
     +	result = for_each_tag_name(argv, collect_tags, &data);
      	if (refs_delete_refs(get_main_ref_store(the_repository), NULL,
    --			     &refs_to_delete, NULL, REF_NO_DEREF))
    +-			     &refs_to_delete, NULL, NULL, REF_NO_DEREF))
     +			     &data.refs, &data.old_oids, NULL, REF_NO_DEREF))
      		result = 1;
      
3:  6f34853c7 ! 3:  541da44c3 fetch, remote: retain old OIDs when pruning refs
    @@ builtin/fetch.c: static int prune_refs(struct display_state *display_state,
     +			}
      			result = refs_delete_refs(get_main_ref_store(the_repository),
      						  "fetch: prune", &refnames,
    --						  NULL, 0);
    +-						  NULL, NULL, 0);
     +						  &old_oids, &failed_refs, 0);
     +			if (result && !failed_refs.nr)
     +				goto cleanup;
    @@ builtin/remote.c: static int prune_remote(const char *remote, int dry_run)
     +	if (!dry_run) {
      		result |= refs_delete_refs(get_main_ref_store(the_repository),
      					   "remote: prune", &refs_to_prune,
    --					   NULL, 0);
    +-					   NULL, NULL, 0);
     +					   &old_oids, &failed_refs, 0);
     +		if (result && !failed_refs.nr)
     +			goto cleanup;
-- 
2.39.3 (Apple Git-146)
