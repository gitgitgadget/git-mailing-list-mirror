Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611211F405
	for <e@80x24.org>; Thu, 20 Dec 2018 13:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbeLTNsi (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 08:48:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52790 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732995AbeLTNsh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 08:48:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so2115800wml.2
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 05:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K6dBCF2/dU72Ojsnk357RLLC2zLuS942lZ8rEZqX6qg=;
        b=q8qVzTwAIXq9+t3m6F/Cpgv5ryNblTE0FmbYe/QTzH3+cdsWvqTZl8DO71SWaM+hNY
         JwPKO5OzE+y835dupJfGKeR7sUldSu5B8PM1mZ0V13vN3MZErguEsXXCc4d5fm4Yw+Ft
         MkpHMM0O0s97BW30NpaHc30kk5yykF+fJdtpjWEJ1Izcas7UKtf3FluvzqcoHYJL4VPT
         5Q9A+LolZ3oLNJxbbDonjSm72uuiU8WRkNgal9Q+VX31oHlQSRrt+6Ev+/Et37LpxXr4
         GmbpJtVIM/m5IeqeCG9s/L5YXqRsI4bIWuIkBP8FrBMf+5b5/ruHPEj++eqqEne1gduK
         KlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K6dBCF2/dU72Ojsnk357RLLC2zLuS942lZ8rEZqX6qg=;
        b=BPa2DU/RAYjKR16Gu+pTBcMnjrdFWKBqxx4N85/CcGwsI0QFE/E1CF9RlkLDTL56k0
         Pu5GTXh4T2pZkDcgaPbg46kcFxhky1NGhBTS0E6GjuJhNWbaBIyAtNTVWvlS9YY/7cwL
         QknVF+wy4P6zClpFze9L8DKrKCIRDKWnkPOYMBCWN/4jxFLib6FpauAz+cSVgF1M26ZV
         yrTosIMV8SNGu6p0sdwQasU/BojF1guWBTtpUAV62hbT4nLoz63IzPS5Hs0TCEgY09Cn
         OItiEfdR4bbMGTeYoQe+xOss/4d/m38PpX6Gv1ZoM4D649pG0jPWlIvm3mWBZXdnz08c
         /1qQ==
X-Gm-Message-State: AA+aEWZ6s4eGl6qNoeFAJW6KnI3lxbMYPnQjBPdSs9BFw9Xn4mjEmT+l
        NhAPiAGV4Fo6KORd5K8koPyalJPBA8I=
X-Google-Smtp-Source: AFSGD/X88OUq0I1E/2Iyx506L/5VE+EioMAfJOW+dptDs6x4xoE58+R48NID6HgbWTvLm3UIV0sqHA==
X-Received: by 2002:a1c:bd86:: with SMTP id n128mr4308006wmf.22.1545313713486;
        Thu, 20 Dec 2018 05:48:33 -0800 (PST)
Received: from localhost (host174-110-dynamic.249-95-r.retail.telecomitalia.it. [95.249.110.174])
        by smtp.gmail.com with ESMTPSA id j24sm9677034wrd.86.2018.12.20.05.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 05:48:32 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 0/8] introduce no-overlay mode in git checkout
Date:   Thu, 20 Dec 2018 13:48:12 +0000
Message-Id: <20181220134820.21810-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723
In-Reply-To: <20181209200449.16342-1-t.gummerer@gmail.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous round is at <20181209200449.16342-1-t.gummerer@gmail.com>.

Thanks Junio, Duy and Elijah for your comments and suggestions on the
previous round.

This round drops the last three patches from the previous round,
namely introducing a "--cached" and a "--ignore-unmatched" option, and
using the new no-overlay mode in "git stash".  The --ignore-unmatched
option may not be necessary, while using the new mode in 'git stash'
will be done once the stash-in-C topic landed.

Introducing a --cached and --worktree-only (as suggested by Elijah)
option can come in a future step, they are orthogonal to this topic.

Other changes from v1:
- Rebase onto the current master, so we can also move t2028 and t2029
  to the t24xx range.
- Add a comment clarifying why using the CE_WT_REMOVE flag and topath
  in checkout_entry is a bug.
- clarify a comment in checkout.c
- factor out the function to mark a cache entry as CE_MATCHED, and
  have separate such functions for overlay mode and no-overlay mode.
  This should hopefully make the logic a bit easier to follow.
- Adjust the commit message, justifying why we don't remove untracked
  files even in the new no-overlay mode.
- add documentation for the new feature
- document that -p defaults to no overlay mode, and cannot be used
  with overlay mode.
- add a config option checkout.overlayMode, so overlay mode can be
  turned on by default.

Range-diff can be found after the diffstat.

Thomas Gummerer (8):
  move worktree tests to t24*
  entry: factor out unlink_entry function
  entry: support CE_WT_REMOVE flag in checkout_entry
  read-cache: add invalidate parameter to remove_marked_cache_entries
  checkout: clarify comment
  checkout: factor out mark_cache_entry_for_checkout function
  checkout: introduce --{,no-}overlay option
  checkout: introduce checkout.overlayMode config

 Documentation/config/checkout.txt             |   7 +
 Documentation/git-checkout.txt                |  10 ++
 builtin/checkout.c                            | 133 +++++++++++++-----
 cache.h                                       |   7 +-
 entry.c                                       |  26 ++++
 read-cache.c                                  |   8 +-
 split-index.c                                 |   2 +-
 t/t2025-checkout-no-overlay.sh                |  57 ++++++++
 ...-worktree-add.sh => t2400-worktree-add.sh} |   0
 ...ktree-prune.sh => t2401-worktree-prune.sh} |   0
 ...orktree-list.sh => t2402-worktree-list.sh} |   0
 ...orktree-move.sh => t2403-worktree-move.sh} |   0
 ...ree-config.sh => t2404-worktree-config.sh} |   0
 t/t9902-completion.sh                         |   1 +
 unpack-trees.c                                |  21 +--
 15 files changed, 213 insertions(+), 59 deletions(-)
 create mode 100755 t/t2025-checkout-no-overlay.sh
 rename t/{t2025-worktree-add.sh => t2400-worktree-add.sh} (100%)
 rename t/{t2026-worktree-prune.sh => t2401-worktree-prune.sh} (100%)
 rename t/{t2027-worktree-list.sh => t2402-worktree-list.sh} (100%)
 rename t/{t2028-worktree-move.sh => t2403-worktree-move.sh} (100%)
 rename t/{t2029-worktree-config.sh => t2404-worktree-config.sh} (100%)

1:  70bd75b202 ! 1:  fa450cda7c move worktree tests to t24*
    @@ -29,3 +29,13 @@
      similarity index 100%
      rename from t/t2027-worktree-list.sh
      rename to t/t2402-worktree-list.sh
    +
    + diff --git a/t/t2028-worktree-move.sh b/t/t2403-worktree-move.sh
    + similarity index 100%
    + rename from t/t2028-worktree-move.sh
    + rename to t/t2403-worktree-move.sh
    +
    + diff --git a/t/t2029-worktree-config.sh b/t/t2404-worktree-config.sh
    + similarity index 100%
    + rename from t/t2029-worktree-config.sh
    + rename to t/t2404-worktree-config.sh
2:  0fd9be987d = 2:  9ada8d3484 entry: factor out unlink_entry function
3:  4d6112b112 ! 3:  41c0ea4047 entry: support CE_WT_REMOVE flag in checkout_entry
    @@ -22,6 +22,10 @@
      
     +	if (ce->ce_flags & CE_WT_REMOVE) {
     +		if (topath)
    ++			/*
    ++			 * No content and thus no path to create, so we have
    ++			 * no pathname to return.
    ++			 */
     +			BUG("Can't remove entry to a path");
     +		unlink_entry(ce);
     +		return 0;
4:  6e9f68b8f1 ! 4:  afccb0848d read-cache: add invalidate parameter to remove_marked_cache_entries
    @@ -11,6 +11,10 @@
         function will take care of invalidating the path in the cache tree and
         in the untracked cache.
     
    +    Note that the current callsites already do the invalidation properly
    +    in other places, so we're just passing 0 from there to keep the status
    +    quo.
    +
         This will be useful in a subsequent commit.
     
         Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
-:  ---------- > 5:  8a2b5efdad checkout: clarify comment
-:  ---------- > 6:  c405f20471 checkout: factor out mark_cache_entry_for_checkout function
5:  4a7670d34c ! 7:  e5b18bcd02 checkout: introduce --{,no-}overlay option
    @@ -17,8 +17,43 @@
         'git checkout --overlay -p' to avoid confusing users who would expect
         to be able to force overlay mode in 'git checkout -p' this way.
     
    +    Untracked files are not affected by this change, so 'git checkout
    +    --no-overlay HEAD -- untracked' will not remove untracked from the
    +    working tree.  This is so e.g. 'git checkout --no-overlay HEAD -- dir/'
    +    doesn't delete all untracked files in dir/, but rather just resets the
    +    state of files that are known to git.
    +
    +    Suggested-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
    + diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
    + --- a/Documentation/git-checkout.txt
    + +++ b/Documentation/git-checkout.txt
    +@@
    + This means that you can use `git checkout -p` to selectively discard
    + edits from your current working tree. See the ``Interactive Mode''
    + section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
    +++
    ++Note that this option uses the no overlay mode by default (see also
    ++-`--[no-]overlay`), and currently doesn't support overlay mode.
    + 
    + --ignore-other-worktrees::
    + 	`git checkout` refuses when the wanted ref is already checked
    +@@
    + 	Just like linkgit:git-submodule[1], this will detach the
    + 	submodules HEAD.
    + 
    ++--[no-]overlay::
    ++	In the default overlay mode files `git checkout` never
    ++	removes files from the index or the working tree.  When
    ++	specifying --no-overlay, files that appear in the index and
    ++	working tree, but not in <tree-ish> are removed, to make them
    ++	match <tree-ish> exactly.
    ++
    + <branch>::
    + 	Branch to checkout; if it refers to a branch (i.e., a name that,
    + 	when prepended with "refs/heads/", is a valid ref), then that
    +
      diff --git a/builtin/checkout.c b/builtin/checkout.c
      --- a/builtin/checkout.c
      +++ b/builtin/checkout.c
    @@ -70,44 +105,60 @@
      		return error(_("path '%s' does not have our version"), ce->name);
      	else
     @@
    - 		ce->ce_flags &= ~CE_MATCHED;
    - 		if (!opts->ignore_skipworktree && ce_skip_worktree(ce))
    - 			continue;
    --		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
    --			/*
    --			 * "git checkout tree-ish -- path", but this entry
    --			 * is in the original index; it will not be checked
    --			 * out to the working tree and it does not matter
    --			 * if pathspec matched this entry.  We will not do
    --			 * anything to this entry at all.
    --			 */
    --			continue;
    -+		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE)) {
    -+			if (!opts->overlay_mode &&
    -+			    ce_path_match(&the_index, ce, &opts->pathspec, ps_matched)) {
    -+				/*
    -+				 * "git checkout --no-overlay <tree-ish> -- path",
    -+				 * and the path is not in tree-ish, but is in
    -+				 * the current index, which means that it should 
    -+				 * be removed.
    -+				 */
    -+				ce->ce_flags |= CE_MATCHED | CE_REMOVE | CE_WT_REMOVE;
    -+				continue;
    -+			} else {
    -+				/*
    -+				 * "git checkout tree-ish -- path", but this
    -+				 * entry is in the original index; it will not
    -+				 * be checked out to the working tree and it
    -+				 * does not matter if pathspec matched this
    -+				 * entry.  We will not do anything to this entry
    -+				 * at all.
    -+				 */
    -+				continue;
    -+			}
    -+		}
    - 		/*
    - 		 * Either this entry came from the tree-ish we are
    - 		 * checking the paths out of, or we are checking out
    + 	return status;
    + }
    + 
    +-static void mark_ce_for_checkout(struct cache_entry *ce,
    +-				 char *ps_matched,
    +-				 const struct checkout_opts *opts)
    ++static void mark_ce_for_checkout_overlay(struct cache_entry *ce,
    ++					 char *ps_matched,
    ++					 const struct checkout_opts *opts)
    + {
    + 	ce->ce_flags &= ~CE_MATCHED;
    + 	if (!opts->ignore_skipworktree && ce_skip_worktree(ce))
    +@@
    + 		ce->ce_flags |= CE_MATCHED;
    + }
    + 
    ++static void mark_ce_for_checkout_no_overlay(struct cache_entry *ce,
    ++					    char *ps_matched,
    ++					    const struct checkout_opts *opts)
    ++{
    ++	ce->ce_flags &= ~CE_MATCHED;
    ++	if (!opts->ignore_skipworktree && ce_skip_worktree(ce))
    ++		return;
    ++	if (ce_path_match(&the_index, ce, &opts->pathspec, ps_matched)) {
    ++		ce->ce_flags |= CE_MATCHED;
    ++		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
    ++			/*
    ++			 * In overlay mode, but the path is not in
    ++			 * tree-ish, which means we should remove it
    ++			 * from the index and the working tree.
    ++			 */
    ++			ce->ce_flags |= CE_REMOVE | CE_WT_REMOVE;
    ++	}
    ++}
    ++
    + static int checkout_paths(const struct checkout_opts *opts,
    + 			  const char *revision)
    + {
    +@@
    + 	 * to be checked out.
    + 	 */
    + 	for (pos = 0; pos < active_nr; pos++)
    +-		mark_ce_for_checkout(active_cache[pos], ps_matched, opts);
    ++		if (opts->overlay_mode)
    ++			mark_ce_for_checkout_overlay(active_cache[pos],
    ++						     ps_matched,
    ++						     opts);
    ++		else
    ++			mark_ce_for_checkout_no_overlay(active_cache[pos],
    ++							ps_matched,
    ++							opts);
    + 
    + 	if (report_path_error(ps_matched, &opts->pathspec, opts->prefix)) {
    + 		free(ps_matched);
     @@
      			if (opts->force) {
      				warning(_("path '%s' is unmerged"), ce->name);
    @@ -160,7 +211,7 @@
      			    "checkout", "control recursive updating of submodules",
      			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
      		OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
    -+		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
    ++		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
      		OPT_END(),
      	};
      
    @@ -198,7 +249,7 @@
     +	git commit --allow-empty -m "initial"
     +'
     +
    -+test_expect_success 'checkout --no-overlay deletes files not in <tree>' '
    ++test_expect_success 'checkout --no-overlay deletes files not in <tree-ish>' '
     +	>file &&
     +	mkdir dir &&
     +	>dir/file1 &&
    @@ -218,7 +269,7 @@
     +	test_i18ngrep "fatal: -p and --overlay are mutually exclusive" actual
     +'
     +
    -+test_expect_success '--no-overlay --theirs with M/D conflict deletes file' '
    ++test_expect_success '--no-overlay --theirs with D/F conflict deletes file' '
     +	test_commit file1 file1 &&
     +	test_commit file2 file2 &&
     +	git rm --cached file1 &&
6:  695b671675 < -:  ---------- checkout: add --cached option
7:  d0b5a356b2 < -:  ---------- checkout: allow ignoring unmatched pathspec
8:  0a4565acc1 < -:  ---------- stash: use git checkout --no-overlay
-:  ---------- > 8:  de24990d57 checkout: introduce checkout.overlayMode config

-- 
2.20.1.415.g653613c723
