Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F159DC43215
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 02:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7ADD2075A
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 02:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7WjxZEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfLAC2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 21:28:38 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:36920 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfLAC2i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 21:28:38 -0500
Received: by mail-wm1-f43.google.com with SMTP id f129so19048686wmf.2
        for <git@vger.kernel.org>; Sat, 30 Nov 2019 18:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hjPpbYybr1QuTnc40h7s89rXusA0wBSuhQSBIGEnIBU=;
        b=f7WjxZEQvSVZXM9o9HdrdJhAceg5RytC2BrdelriDsNSuCb4Isp++Jak4prakC9gF9
         LAxDrABCGH61AXvnx1j9NGRK+i+kYpKyxmLR11T4MEtYH9qGWIWWjH0Up7dlEgWo9AQd
         kFL2VQi4oPmSDgJczkMhRybYp1olZ4H/mCIPZWEZe2aiLAtxS2uKsn9y+OE3raY38Par
         Rkw4YH8xdx1FcxrM9kNeFUMY434cRvX6cq+6eLkY9NXX8BP3gVupfjgn1WFBzjjjgi7x
         SO6kE1lY13o3Rcl3UMue9mJpDmHaP7qkhYWfsKDQTLvBBnGyl6ckz0RwEQIjDzTvywwh
         V82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hjPpbYybr1QuTnc40h7s89rXusA0wBSuhQSBIGEnIBU=;
        b=E62cgIZ3e/83JFybDpD2SPs+uhVju5pz7QDUzg/BRgKrft9MrIEt/U7EkF18Qdwvf4
         KFxTyQeNHYFMRioBZRO9pRFCz65Uoqm926fYnkMufozKmrr8PdL51QF4cAAM8jAgZrWy
         Kxq3x9stWJfWi/VUrLCR0NX3YLjwQT05hg2iqKqoRfaOtfl1ApLwE6CVkln25BZ6Rdbh
         Tf9102rKB+TbTTaY8bxUb1/tnZxoL480a+gcA+/Xly73bwKSjA6HHaVlGCoxaPgfJquu
         LRbTvCI7pb31OXbuj3MiTo3IeKGs6jXGmelcK9yoxnVHvWi+C6hJUmKtgAayiyEZR2dv
         es8w==
X-Gm-Message-State: APjAAAV/f/xBsr6l4kCal30OtUlGWr3DyTyM+w2UhQKwljobJfK2Jrs8
        hUjjM+YI601ka5eIn6cm5wnbNAM0
X-Google-Smtp-Source: APXvYqzvAGBHBhkKjV8QNc9fXSE9xDq6rOiJD8LgJCFoi38kLFes5fK6PrEVa6rM3qnLpVHPwnPTpw==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr20855231wma.72.1575167314701;
        Sat, 30 Nov 2019 18:28:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8sm11309691wro.47.2019.11.30.18.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Nov 2019 18:28:34 -0800 (PST)
Message-Id: <pull.436.v7.git.1575167313.gitgitgadget@gmail.com>
In-Reply-To: <pull.436.v6.git.1574929833.gitgitgadget@gmail.com>
References: <pull.436.v6.git.1574929833.gitgitgadget@gmail.com>
From:   "Jonathan Gilbert via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 01 Dec 2019 02:28:30 +0000
Subject: [PATCH v7 0/3] git-gui: revert untracked files by deleting them
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My development environment sometimes makes automatic changes that I don't
want to keep. In some cases, this involves new files being added that I
don't want to commit or keep (but I also don't want to outright .gitignore 
forever). I have typically had to explicitly delete those files externally
to Git Gui, which is a context switch to a manual operation, and I want to
be able to just select those newly-created untracked files in the UI and
"revert" them into oblivion.

This change updates the revert_helper proc to check for untracked files as
well as changes, and then changes to be reverted and untracked files are
handled by independent blocks of code. The user is prompted independently
for untracked files, since the underlying action is fundamentally different
(rm -f). If after deleting untracked files, the directory containing them
becomes empty, then the directory is removed as well. A new proc 
delete_files takes care of actually deleting the files, using the Tcler's
Wiki recommended approach for keeping the UI responsive.

Since the checkout_index and delete_files calls are both asynchronous and
could potentially complete in any order, a "chord" is used to coordinate
unlocking the index and returning the UI to a usable state only after both
operations are complete.

Since the checkout_index and delete_files calls are both asynchronous and
overlap, they clash in wanting to update the status bar. To address this,
the status bar is reworked so that when an operation wants to display
ongoing updates/progress, it explicitly starts an "operation", which is
tracked by its own object, and the status bar handles multiple concurrent
operations by merging their progress and concatenating their text. This is
captured in a separate commit, since it touches a variety of files.

The _close_updateindex proc contains error handling (added in d4e890e5) that
has the potential to interact badly with unlock_index running at the
completion of an async operation. I have refactored the procedure into
separate procs _close_updateindex and rescan_on_error. Call sites that
exercised the combined functionality also unlocked the index, so a combined
proc close_and_unlock_index calls _close_updateindex and then either 
rescan_on_error or unlock_index as appropriate. Call sites have been updated
appropriately.

The revert_helper proc, with its overlapping operations, is an example of a
call site that does not combine the close and unlock/rescan operations. The 
checkout_index proc has been reworked to only call _close_updateindex, and
to call a functor supplied by the caller to captures any errors that occur. 
revert_helper uses this to supply a lambda function that stashes the error
within the chord's body namespace, so that it can then separately call 
rescan_on_error when the chord is completed (or unlock_index, if no error
was captured), which might be substantially after checkout_index encounters
its error. If it turns out that a rescan is called for, it is done once the
deletion is complete.

This is the eighth revision of this change, which differs from the seventh
version in the following ways (most of which are in the second of the three
commits, to do with the status bar rework):

 * The bump of the Tcl/Tk dependency from 8.4 to 8.6 now takes place in the
   third commit, where it is needed and whose commit message actually calls
   it out.
   
   
 * The show method in status_bar_operation has been renamed to restart, and
   the meter is cleared. Also, the supplied message is set as the prefix for
   future update calls.
   
   
 * The call site for $status_operation show in blame.tcl has been
   corresponding changed to $status_operation restart.
   
   
 * A typo has been corrected in a comment. :-)
   
   

git remote add logiclrd https://github.com/logiclrd/git.git
git fetch logiclrd git-gui-revert-untracked revision7
# Compare the second commit from the past submission with the one
# from this submission:
# - revision7~ == ab3d8e54c3d
# - git-gui-revert-untracked~ == 8fe9dfc30771
git diff ab3d8e54c3d..8fe9dfc30771

Jonathan Gilbert (3):
  git-gui: consolidate naming conventions
  git-gui: update status bar to track operations
  git-gui: revert untracked files by deleting them

 git-gui.sh                |  31 ++-
 lib/blame.tcl             |  24 +-
 lib/checkout_op.tcl       |  15 +-
 lib/choose_repository.tcl | 120 ++++++---
 lib/chord.tcl             | 160 ++++++++++++
 lib/index.tcl             | 523 ++++++++++++++++++++++++++++----------
 lib/merge.tcl             |  14 +-
 lib/status_bar.tcl        | 231 +++++++++++++++--
 8 files changed, 891 insertions(+), 227 deletions(-)
 create mode 100644 lib/chord.tcl


base-commit: b524f6b399c77b40c8bf2b6217585fde4731472a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-436%2Flogiclrd%2Fgit-gui-revert-untracked-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-436/logiclrd/git-gui-revert-untracked-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/436

Range-diff vs v6:

 1:  da1704c56e = 1:  da1704c56e git-gui: consolidate naming conventions
 2:  ab3d8e54c3 ! 2:  8fe9dfc307 git-gui: update status bar to track operations
     @@ -12,17 +12,6 @@
       diff --git a/git-gui.sh b/git-gui.sh
       --- a/git-gui.sh
       +++ b/git-gui.sh
     -@@
     - ##
     - ## Tcl/Tk sanity check
     - 
     --if {[catch {package require Tcl 8.4} err]
     -- || [catch {package require Tk  8.4} err]
     -+if {[catch {package require Tcl 8.6} err]
     -+ || [catch {package require Tk  8.6} err]
     - } {
     - 	catch {wm withdraw .}
     - 	tk_messageBox \
      @@
       	}
       }
     @@ -119,7 +108,7 @@
      +			$cur_s \
      +			[mc "lines annotated"]]
      +	} else {
     -+		$status_operation show $cur_s
     ++		$status_operation restart $cur_s
      +	}
      +
       	lappend options -- $path
     @@ -231,7 +220,7 @@
      +
      +# Operation displayed by status mega-widget during _do_clone_checkout =>
      +# _readtree_wait => _postcheckout_wait => _do_clone_submodules =>
     -+# _do_validate_submodule_cloning. The status mega-widget is a difference
     ++# _do_validate_submodule_cloning. The status mega-widget is a different
      +# instance than that stored in $o_status in earlier operations.
      +field o_status_op
      +
     @@ -930,10 +919,12 @@
      -	if {$test eq {} || $status eq $test} {
      -		set status $msg
      -	}
     -+method show {msg} {
     ++method restart {msg} {
      +	if {!$is_active} { return }
      +
      +	set status $msg
     ++	set prefix $msg
     ++	set meter {}
      +	$status_bar refresh
       }
       
 3:  3388407871 ! 3:  5f8120f359 git-gui: revert untracked files by deleting them
     @@ -26,6 +26,21 @@
      
          Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
      
     + diff --git a/git-gui.sh b/git-gui.sh
     + --- a/git-gui.sh
     + +++ b/git-gui.sh
     +@@
     + ##
     + ## Tcl/Tk sanity check
     + 
     +-if {[catch {package require Tcl 8.4} err]
     +- || [catch {package require Tk  8.4} err]
     ++if {[catch {package require Tcl 8.6} err]
     ++ || [catch {package require Tk  8.6} err]
     + } {
     + 	catch {wm withdraw .}
     + 	tk_messageBox \
     +
       diff --git a/lib/chord.tcl b/lib/chord.tcl
       new file mode 100644
       --- /dev/null

-- 
gitgitgadget
