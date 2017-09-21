Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9D14202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 14:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751723AbdIUOfj (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 10:35:39 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37118 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdIUOfi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 10:35:38 -0400
Received: by mail-qk0-f194.google.com with SMTP id r66so3735444qke.4
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jHUy43JpNPTQnn+7oCPoWLoqDcvlUcpnUiO76pz8E4s=;
        b=kKgCSIJzeQF9P6iLIfl7fUD8Kez3B2a7WlbcoGU6Ctsc3IKVKYcZTrAm8JDRK5AUYp
         5wNOyp31xdzIXvp/oDw+8BymME1yKtzpdBENasUXtFypcn2/H0OL2jEkgii0RxfDQzWF
         n5AtYtGaUDPgkXCEkFZJns79IJ7Qb5edccDPw9pJtxLVJijpgQq+9pR9pzV+86WudyAB
         vJHehV0w2oMyjT01sPwLOKp8uWJF+KBDVVa260cRoDm+87aA4I7cIUKC1gUe48kT7BHQ
         IGh6q6pISXXKOKEnLPry0LIOGl4N17rQm9rRkOkNMe5xfCanULP99/t4JdGs6pLod1AN
         gJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jHUy43JpNPTQnn+7oCPoWLoqDcvlUcpnUiO76pz8E4s=;
        b=JGBlr0EeRBv7U1j2DCHXwDS6X/iZU8rlwBEu2BajY8fHuzQmrYVY1QrXWZRP+/05sj
         RvSFG5O0Nxa3iTzj41H1bIeF/1WmYiiAkxfcMlcMd3ngh2ShOJvJ/uGPL0SBoONBc6G2
         rJT3DQHoUY0L/QKBymPblMOXhWdph68DoEN8BYrLvwXH2VtT9yNpcW+uT9QwmGIvt+fK
         w7as+OZD7soF+0HuC1MF05tRHfs7pnylt2LtqmlRSocl1RNbztfXLtb5aM1SdF710j5i
         xk7DQnLnUwTVk2aM7Rtz8u+GOtFacOOp8mxwr20/zi2ESveY8H39O27YhTaZkbsYZkV0
         c8ug==
X-Gm-Message-State: AHPjjUhum88oFfx0Plk1sajjeKgLcCUJrzSqEIFCv8PH2xfD8NPsjPHY
        Iy0EbP6W5Lfz57+JxOSkLus=
X-Google-Smtp-Source: AOwi7QBaT9U9KVU+73ofOJjOF881mZroahgdvg1SiRZG3qGvv0lzhAEx20AlP/gO1GiW7gE46hxwlw==
X-Received: by 10.55.16.207 with SMTP id 76mr3168226qkq.120.1506004536979;
        Thu, 21 Sep 2017 07:35:36 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id w5sm1018821qkd.47.2017.09.21.07.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Sep 2017 07:35:35 -0700 (PDT)
Subject: Re: [PATCH v7 04/12] fsmonitor: teach git to optionally utilize a
 file system monitor to speed up detecting new or changed files.
From:   Ben Peart <peartben@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <benpeart@microsoft.com>, David.Turner@twosigma.com,
        avarab@gmail.com, christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
 <20170919192744.19224-5-benpeart@microsoft.com>
 <xmqqr2v2p0gn.fsf@gitster.mtv.corp.google.com>
 <3311de8b-f9df-07e0-6c5d-7f491e9bcaa8@gmail.com>
 <xmqq377gn74p.fsf@gitster.mtv.corp.google.com>
 <a4ab4766-0367-ff18-a3a9-e48ed49ccd80@gmail.com>
Message-ID: <f50825a4-fa15-9f28-a079-853e78ee8e2e@gmail.com>
Date:   Thu, 21 Sep 2017 10:35:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <a4ab4766-0367-ff18-a3a9-e48ed49ccd80@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/20/2017 10:24 PM, Ben Peart wrote:
> 
> 
> On 9/20/2017 10:00 PM, Junio C Hamano wrote:
>> Ben Peart <peartben@gmail.com> writes:
>>
>>> Pretty much the same places you would also use CE_MATCH_IGNORE_VALID
>>> and CE_MATCH_IGNORE_SKIP_WORKTREE which serve the same role for those
>>> features.  That is generally when you are about to overwrite data so
>>> want to be *really* sure you have what you think you have.
>>
>> Now that makes me worried gravely.
>>
>> IGNORE_VALID is ignored in these places because we have been burned
>> by end-users lying to us.  IGNORE_SKIP_WORKTREE must be ignored
>> because we know that the working tree state does not match the
>> "reality" the index wants to have.  The fact that the code treats
>> the status reported and kept up to date by fsmonitor the same way as
>> these two implies that it is merely advisory and cannot be trusted?
>> Is that the reason why we tell the codepath with IGNORE_FSMONITOR to
>> ignore the state fsmonitor reported and check the state ourselves?
>>
> 
> Sorry for causing unnecessary worry.  The fsmonitor data can be trusted 
> (as much as you can trust that Watchman or your file system monitor is 
> not buggy).  I wasn't 100% sure *why* these places passed the various 
> IGNORE_VALID and IGNORE_SKIP_WORKTREE flags.  When I looked at them, 
> that lack of trust seemed to be the reason.
> 
> Adding IGNORE_FSMONITOR in those same places was simply an abundance of 
> caution on my part.  The only down side of passing the flag for 
> fsmonitor is that we will end up calling lstat() on a file where we 
> technically didn't need too.  That seemed safer than potentially missing 
> a change if I had misunderstood the code.
> 
> I'd much rather return correct results (and fall back to the old 
> performance) than potentially be incorrect.  I followed that same 
> principal in the entire design of fsmonitor - if anything doesn't look 
> right, fall back to the old code path just in case...
> 

I spent some time with git blame/show trying to figure out the *why* for 
all the places CE_MATCH_IGNORE_* are passed without gaining a lot of 
additional understanding.  Based on your description above of why these 
exist, I believe there are very few places we actually need to pass 
CE_MATCH_IGNORE_FSMONITOR and that I was being overly cautious.

Here is a patch that removes the unnecessary CE_MATCH_IGNORE_FSMONITOR 
instances.  While the test suite passes with this change, I'm not 100% 
confident that we actually have test cases that would have detected all 
the places that we needed the CE_MATCH_IGNORE_* flags.

If this seems like a reasonable additional optimization to make, I can 
roll it into the next iteration of the patch series as I have some 
spelling, documentation changes and other tweaks as a result of all the 
feedback.


 From 6ff7ed0467fd736dca73efe62391bb3ee9b4e771 Mon Sep 17 00:00:00 2001
From: Ben Peart <benpeart@microsoft.com>
Date: Thu, 21 Sep 2017 09:09:42 -0400
Subject: [PATCH] fsmonitor: remove unnecessary uses of
  CE_MATCH_IGNORE_FSMONITOR

With a better understanding of *why* the CE_MATCH_IGNORE_* flags are
used, it is now more clear they are not required in most cases where
CE_MATCH_IGNORE_FSMONITOR was being passed out of an abundance of
caution.

Since the fsmonitor data can be trusted and is kept in sync with the
working directory, the only remaining valid uses are those locations
where we don't want to trigger an unneeded refresh_fsmonitor() call.

One is where preload_index() is doing a fast precompute of state for
the bulk of the index entries but is not required for correctness as
refresh_cache_ent() will ensure any "missed" by preload_index() are
up-to-date if/when they are needed.

The second is in is_staging_gitmodules_ok() where we don't want to
trigger a complete refresh just to check the .gitignore file.

The net result of this change will be that there are more cases where
we will be able to use the cached index state and avoid unnecessary
lstat() calls.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
  apply.c        | 2 +-
  entry.c        | 2 +-
  read-cache.c   | 4 ++--
  unpack-trees.c | 6 +++---
  4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/apply.c b/apply.c
index 9061cc5f15..71cbbd141c 100644
--- a/apply.c
+++ b/apply.c
@@ -3399,7 +3399,7 @@ static int verify_index_match(const struct 
cache_entry *ce, struct stat *st)
  			return -1;
  		return 0;
  	}
-	return ce_match_stat(ce, st, 
CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE|CE_MATCH_IGNORE_FSMONITOR);
+	return ce_match_stat(ce, st, 
CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
  }

  #define SUBMODULE_PATCH_WITHOUT_INDEX 1
diff --git a/entry.c b/entry.c
index 5e6794f9fc..3a7b667373 100644
--- a/entry.c
+++ b/entry.c
@@ -404,7 +404,7 @@ int checkout_entry(struct cache_entry *ce,

  	if (!check_path(path.buf, path.len, &st, state->base_dir_len)) {
  		const struct submodule *sub;
-		unsigned changed = ce_match_stat(ce, &st, 
CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE|CE_MATCH_IGNORE_FSMONITOR);
+		unsigned changed = ce_match_stat(ce, &st, 
CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
  		/*
  		 * Needs to be checked before !changed returns early,
  		 * as the possibly empty directory was not changed
diff --git a/read-cache.c b/read-cache.c
index 53093dbebf..05c0a33fdd 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -641,7 +641,7 @@ int add_to_index(struct index_state *istate, const 
char *path, struct stat *st,
  	int size, namelen, was_same;
  	mode_t st_mode = st->st_mode;
  	struct cache_entry *ce, *alias;
-	unsigned ce_option = 
CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE|CE_MATCH_RACY_IS_DIRTY|CE_MATCH_IGNORE_FSMONITOR;
+	unsigned ce_option = 
CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE|CE_MATCH_RACY_IS_DIRTY;
  	int verbose = flags & (ADD_CACHE_VERBOSE | ADD_CACHE_PRETEND);
  	int pretend = flags & ADD_CACHE_PRETEND;
  	int intent_only = flags & ADD_CACHE_INTENT;
@@ -1356,7 +1356,7 @@ int refresh_index(struct index_state *istate, 
unsigned int flags,
  	int first = 1;
  	int in_porcelain = (flags & REFRESH_IN_PORCELAIN);
  	unsigned int options = (CE_MATCH_REFRESH |
-				(really ? CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_FSMONITOR : 0) |
+				(really ? CE_MATCH_IGNORE_VALID : 0) |
  				(not_new ? CE_MATCH_IGNORE_MISSING : 0));
  	const char *modified_fmt;
  	const char *deleted_fmt;
diff --git a/unpack-trees.c b/unpack-trees.c
index f724a61ac0..1f5d371636 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1456,7 +1456,7 @@ static int verify_uptodate_1(const struct 
cache_entry *ce,
  		return 0;

  	if (!lstat(ce->name, &st)) {
-		int flags = 
CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE|CE_MATCH_IGNORE_FSMONITOR;
+		int flags = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE;
  		unsigned changed = ie_match_stat(o->src_index, ce, &st, flags);

  		if (submodule_from_ce(ce)) {
@@ -1612,7 +1612,7 @@ static int icase_exists(struct 
unpack_trees_options *o, const char *name, int le
  	const struct cache_entry *src;

  	src = index_file_exists(o->src_index, name, len, 1);
-	return src && !ie_match_stat(o->src_index, src, st, 
CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE|CE_MATCH_IGNORE_FSMONITOR);
+	return src && !ie_match_stat(o->src_index, src, st, 
CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
  }

  static int check_ok_to_remove(const char *name, int len, int dtype,
@@ -2136,7 +2136,7 @@ int oneway_merge(const struct cache_entry * const 
*src,
  		if (o->reset && o->update && !ce_uptodate(old) && 
!ce_skip_worktree(old)) {
  			struct stat st;
  			if (lstat(old->name, &st) ||
-			    ie_match_stat(o->src_index, old, &st, 
CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE|CE_MATCH_IGNORE_FSMONITOR))
+			    ie_match_stat(o->src_index, old, &st, 
CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
  				update |= CE_UPDATE;
  		}
  		add_entry(o, old, update, 0);
-- 
2.14.1.548.g237ef02b2b.dirty



>> Oh, wait...
>>
>>
>>> The other place I used it was in preload_index(). In that case, I
>>> didn't want to trigger the call to refresh_fsmonitor() as
>>> preload_index() is about trying to do a fast precompute of state for
>>> the bulk of the index entries but is not required for correctness as
>>> refresh_cache_ent() will ensure any "missed" by preload_index() are
>>> up-to-date if/when that is needed.
>>
>> That is a very valid design decision.  So IGNORE_FSMONITOR is,
>> unlike IGNORE_VALID and IGNORE_SKIP_WORKTREE, to tell us "do not
>> bother asking fsmonitor to refresh the state of this entry--it is OK
>> for us to use a slightly stale information"?  That would make sense
>> as an optimization, but that does not mesh well with the previous
>> "we need to be really really sure" usecase.  That one wants "we do
>> not trust fsmonitor, so do not bother asking to refresh; we will do
>> so ourselves", which would not help the "we can use slightly stale
>> one and that is OK" usecase.
>>
>> Puzzled...
>>
