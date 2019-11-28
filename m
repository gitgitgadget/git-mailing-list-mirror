Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE817C432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 08:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DB52176D
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 08:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWuBEdKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfK1Ial (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:30:41 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:38273 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfK1Ial (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 03:30:41 -0500
Received: by mail-wm1-f41.google.com with SMTP id z19so10727229wmk.3
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 00:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wPuvY90vPel58v/2M3+LygF0frfMjPDS5nAEf1pxg+Y=;
        b=WWuBEdKTylUoIYLFzMyxeCGQ3tWI+yEvwRwEWfDPPqAbJKUXfoR6Gg/R9w/0MUq3g+
         ONHRyFEbOm3wyJjlt7kuTnmc/yZhHOeLcrIONR0sU6S5P1Nd9MASRK/HB8sgmj5ebMIo
         HkGuHyp3LR6PxIzDTB97XXHv7wsTGcPqpwYdKMi2FEW4nzjMxLGIbJw8CtQbOPoJ6zro
         LxBR6c3vu6bN3BFPKlPQsA31pE53nH4gibqjKjtTcZfGLVyblb+kGj2RZfNhRHyCNKB1
         cG6LHz7kVVnsLRH2Pxl3zDt4dR0xNizUfYNmUyFAu+0jAbt1MAtgCwVZdy1lzl+GDyi7
         wN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wPuvY90vPel58v/2M3+LygF0frfMjPDS5nAEf1pxg+Y=;
        b=JNJeG7ViECuieOqTp54v9puCxJWQUS7dLlQbyJIen0yT5+WTdHTjJ3pbRZdWJF0Jzr
         rd5ZfyBfsXCP5RX4lFom7hx0hJLVLyMCtUI3dKfujZZbmWRkpmo022pKfzv7V+/Rwks4
         ZLDophgxcLDY8/8gG/5V2Buwrn0EddHQrz8pU0KdryRLtDG/Hed7F9W+zN42uWzxd2vo
         UdFEwzpsCo2TUoxRBQn34BqtL7Qk4AGirjoT7QwC/Zl92DOxCG6f+8oi211u3B+V+Hfh
         NGRCwAZNiRk3LrGSnIPUJeAzY7sptkpkGuaudgIR4Ddl5xV7hJ0YIxPOrhDg0OXVc98O
         Mehg==
X-Gm-Message-State: APjAAAWbe+t27WBnmz6P63I0IEKFsqXx37hWuP05ZB6oL7Pg/Z19o/9Y
        83wU5H9W58vVPz34sO2Eg2OiJu9U
X-Google-Smtp-Source: APXvYqy/vhUrjr0gvuuDEYKdXA3zMq8yCj9p/Z/sZT8nnXOh2ot1R4LnfGLBtXqVOJFCXLw66iARZg==
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr8804410wmj.127.1574929834960;
        Thu, 28 Nov 2019 00:30:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7sm9452672wma.46.2019.11.28.00.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 00:30:34 -0800 (PST)
Message-Id: <pull.436.v6.git.1574929833.gitgitgadget@gmail.com>
In-Reply-To: <pull.436.v5.git.1574627876.gitgitgadget@gmail.com>
References: <pull.436.v5.git.1574627876.gitgitgadget@gmail.com>
From:   "Jonathan Gilbert via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Nov 2019 08:30:30 +0000
Subject: [PATCH v6 0/3] git-gui: revert untracked files by deleting them
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

This is the seventh revision of this change, which differs from the sixth
version in the following ways (all related to the second commit updating the
status bar):

 * The do_gitk and do_git_gui helper functions in git-gui.sh have been
   updated to use status bar operations to show their "Starting" messages.
   This eliminates the need for global variable starting_gitk_msg, and
   corrects an issue where do_git_gui would say it was starting gitk rather
   than git-gui by generalizing the localized message so the tool name can
   be injected. The time to the message being removed is reduced to 3.5
   seconds.
   
   
 * In blame.tcl, the comment on status_operation is made clearer.
   
   
 * In blame.tcl, when the status operation $cur_s string changes and there's
   already an existing status bar operation, its text is updated to match.
   
   
 * The choose_repository.tcl file has been updated to work with the new
   status bar model. There were some unnecessary complications that have
   been sorted out: The o_cons field is no longer overloaded in meaning, and
   the lifetimes of different status bar widgets is explicitly documented
   (one gets created and then destroyed during _do_clone2, and another
   separate one is greated during do_clone_checkout).
   
   
 * In choose_repository.tcl, there is a sequence of functions involved
   performing the checkout on the clone: _do_clone_checkout => 
   _readtree_wait => _postcheckout_wait => _do_clone_submodules => 
   _do_validate_submodule_cloning. The functions have been re-ordered in the
   source code to match the sequence in which they execute to improve
   clarity.
   
   
 * The two_line constructor in status_bar.tcl now also initializes 
   completed_operation_count.
   
   
 * The start method on the status_bar class now no longer requires units to
   be supplied. If they are omitted, a blank string is used. It is assumed
   that the caller will not be calling update or update_meter in this
   circumstance (though nothing should break if they do, it just won't show
   any units).
   
   

git remote add logiclrd https://github.com/logiclrd/git.git
git fetch logiclrd git-gui-revert-untracked revision6
git diff d0d6593b42..3388407871

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
 lib/status_bar.tcl        | 229 +++++++++++++++--
 8 files changed, 889 insertions(+), 227 deletions(-)
 create mode 100644 lib/chord.tcl


base-commit: b524f6b399c77b40c8bf2b6217585fde4731472a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-436%2Flogiclrd%2Fgit-gui-revert-untracked-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-436/logiclrd/git-gui-revert-untracked-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/436

Range-diff vs v5:

 1:  da1704c56e = 1:  da1704c56e git-gui: consolidate naming conventions
 2:  aa05a78d28 ! 2:  ab3d8e54c3 git-gui: update status bar to track operations
     @@ -12,6 +12,17 @@
       diff --git a/git-gui.sh b/git-gui.sh
       --- a/git-gui.sh
       +++ b/git-gui.sh
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
      @@
       	}
       }
     @@ -25,6 +36,47 @@
       	}
       }
       
     +@@
     + ##
     + ## ui commands
     + 
     +-set starting_gitk_msg [mc "Starting gitk... please wait..."]
     +-
     + proc do_gitk {revs {is_submodule false}} {
     + 	global current_diff_path file_states current_diff_side ui_index
     + 	global _gitdir _gitworktree
     +@@
     + 		set env(GIT_WORK_TREE) $_gitworktree
     + 		cd $pwd
     + 
     +-		ui_status $::starting_gitk_msg
     +-		after 10000 {
     +-			ui_ready $starting_gitk_msg
     +-		}
     ++		set status_operation [$::main_status \
     ++			start \
     ++			[mc "Starting %s... please wait..." "gitk"]]
     ++
     ++		after 3500 [list $status_operation stop]
     + 	}
     + }
     + 
     +@@
     + 		set env(GIT_WORK_TREE) $_gitworktree
     + 		cd $pwd
     + 
     +-		ui_status $::starting_gitk_msg
     +-		after 10000 {
     +-			ui_ready $starting_gitk_msg
     +-		}
     ++		set status_operation [$::main_status \
     ++			start \
     ++			[mc "Starting %s... please wait..." "git-gui"]]
     ++
     ++		after 3500 [list $status_operation stop]
     + 	}
     + }
     + 
      @@
       	do_explore
       }
     @@ -43,7 +95,7 @@
       field finder     ; # find mini-dialog frame
       field gotoline   ; # line goto mini-dialog frame
       field status     ; # status mega-widget instance
     -+field status_operation ; # status operation
     ++field status_operation ; # operation displayed by status mega-widget
       field old_height ; # last known height of $w.file_pane
       
       
     @@ -66,6 +118,8 @@
      +		set status_operation [$status start \
      +			$cur_s \
      +			[mc "lines annotated"]]
     ++	} else {
     ++		$status_operation show $cur_s
      +	}
      +
       	lappend options -- $path
     @@ -162,6 +216,255 @@
       }
       
      
     + diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
     + --- a/lib/choose_repository.tcl
     + +++ b/lib/choose_repository.tcl
     +@@
     + field w_next      ; # Next button
     + field w_quit      ; # Quit button
     + field o_cons      ; # Console object (if active)
     ++
     ++# Status mega-widget instance during _do_clone2 (used by _copy_files and
     ++# _link_files). Widget is destroyed before _do_clone2 calls
     ++# _do_clone_checkout
     ++field o_status
     ++
     ++# Operation displayed by status mega-widget during _do_clone_checkout =>
     ++# _readtree_wait => _postcheckout_wait => _do_clone_submodules =>
     ++# _do_validate_submodule_cloning. The status mega-widget is a difference
     ++# instance than that stored in $o_status in earlier operations.
     ++field o_status_op
     ++
     + field w_types     ; # List of type buttons in clone
     + field w_recentlist ; # Listbox containing recent repositories
     + field w_localpath  ; # Entry widget bound to local_path
     +@@
     + 
     + 	switch -exact -- $clone_type {
     + 	hardlink {
     +-		set o_cons [status_bar::two_line $w_body]
     ++		set o_status [status_bar::two_line $w_body]
     + 		pack $w_body -fill x -padx 10 -pady 10
     + 
     +-		$o_cons start \
     ++		set status_op [$o_status start \
     + 			[mc "Counting objects"] \
     +-			[mc "buckets"]
     ++			[mc "buckets"]]
     + 		update
     + 
     + 		if {[file exists [file join $objdir info alternates]]} {
     +@@
     + 			} err]} {
     + 				catch {cd $pwd}
     + 				_clone_failed $this [mc "Unable to copy objects/info/alternates: %s" $err]
     ++				$status_op stop
     + 				return
     + 			}
     + 		}
     +@@
     + 			-directory [file join $objdir] ??]
     + 		set bcnt [expr {[llength $buckets] + 2}]
     + 		set bcur 1
     +-		$o_cons update $bcur $bcnt
     ++		$status_op update $bcur $bcnt
     + 		update
     + 
     + 		file mkdir [file join .git objects pack]
     +@@
     + 			-directory [file join $objdir pack] *] {
     + 			lappend tolink [file join pack $i]
     + 		}
     +-		$o_cons update [incr bcur] $bcnt
     ++		$status_op update [incr bcur] $bcnt
     + 		update
     + 
     + 		foreach i $buckets {
     +@@
     + 				-directory [file join $objdir $i] *] {
     + 				lappend tolink [file join $i $j]
     + 			}
     +-			$o_cons update [incr bcur] $bcnt
     ++			$status_op update [incr bcur] $bcnt
     + 			update
     + 		}
     +-		$o_cons stop
     ++		$status_op stop
     + 
     + 		if {$tolink eq {}} {
     + 			info_popup [strcat \
     +@@
     + 		if {!$i} return
     + 
     + 		destroy $w_body
     ++
     ++		set o_status {}
     + 	}
     + 	full {
     + 		set o_cons [console::embed \
     +@@
     + }
     + 
     + method _copy_files {objdir tocopy} {
     +-	$o_cons start \
     ++	set status_op [$o_status start \
     + 		[mc "Copying objects"] \
     +-		[mc "KiB"]
     ++		[mc "KiB"]]
     + 	set tot 0
     + 	set cmp 0
     + 	foreach p $tocopy {
     +@@
     + 
     + 				while {![eof $f_in]} {
     + 					incr cmp [fcopy $f_in $f_cp -size 16384]
     +-					$o_cons update \
     ++					$status_op update \
     + 						[expr {$cmp / 1024}] \
     + 						[expr {$tot / 1024}]
     + 					update
     +@@
     + 				close $f_cp
     + 			} err]} {
     + 			_clone_failed $this [mc "Unable to copy object: %s" $err]
     ++			$status_op stop
     + 			return 0
     + 		}
     + 	}
     ++	$status_op stop
     + 	return 1
     + }
     + 
     + method _link_files {objdir tolink} {
     + 	set total [llength $tolink]
     +-	$o_cons start \
     ++	set status_op [$o_status start \
     + 		[mc "Linking objects"] \
     +-		[mc "objects"]
     ++		[mc "objects"]]
     + 	for {set i 0} {$i < $total} {} {
     + 		set p [lindex $tolink $i]
     + 		if {[catch {
     +@@
     + 					[file join $objdir $p]
     + 			} err]} {
     + 			_clone_failed $this [mc "Unable to hardlink object: %s" $err]
     ++			$status_op stop
     + 			return 0
     + 		}
     + 
     + 		incr i
     + 		if {$i % 5 == 0} {
     +-			$o_cons update $i $total
     ++			$status_op update $i $total
     + 			update
     + 		}
     + 	}
     ++	$status_op stop
     + 	return 1
     + }
     + 
     +@@
     + 		return
     + 	}
     + 
     +-	set o_cons [status_bar::two_line $w_body]
     ++	set status [status_bar::two_line $w_body]
     + 	pack $w_body -fill x -padx 10 -pady 10
     +-	$o_cons start \
     ++
     ++	# We start the status operation here.
     ++	#
     ++	# This function calls _readtree_wait as a callback.
     ++	#
     ++	# _readtree_wait in turn either calls _do_clone_submodules directly,
     ++	# or calls _postcheckout_wait as a callback which then calls
     ++	# _do_clone_submodules.
     ++	#
     ++	# _do_clone_submodules calls _do_validate_submodule_cloning.
     ++	#
     ++	# _do_validate_submodule_cloning stops the status operation.
     ++	#
     ++	# There are no other calls into this chain from other code.
     ++
     ++	set o_status_op [$status start \
     + 		[mc "Creating working directory"] \
     +-		[mc "files"]
     ++		[mc "files"]]
     + 
     + 	set readtree_err {}
     + 	set fd [git_read --stderr read-tree \
     +@@
     + 	fileevent $fd readable [cb _readtree_wait $fd]
     + }
     + 
     +-method _do_validate_submodule_cloning {ok} {
     +-	if {$ok} {
     +-		$o_cons done $ok
     +-		set done 1
     +-	} else {
     +-		_clone_failed $this [mc "Cannot clone submodules."]
     +-	}
     +-}
     +-
     +-method _do_clone_submodules {} {
     +-	if {$recursive eq {true}} {
     +-		destroy $w_body
     +-		set o_cons [console::embed \
     +-			$w_body \
     +-			[mc "Cloning submodules"]]
     +-		pack $w_body -fill both -expand 1 -padx 10
     +-		$o_cons exec \
     +-			[list git submodule update --init --recursive] \
     +-			[cb _do_validate_submodule_cloning]
     +-	} else {
     +-		set done 1
     +-	}
     +-}
     +-
     + method _readtree_wait {fd} {
     + 	set buf [read $fd]
     +-	$o_cons update_meter $buf
     ++	$o_status_op update_meter $buf
     + 	append readtree_err $buf
     + 
     + 	fconfigure $fd -blocking 1
     +@@
     + 	fconfigure $fd_ph -blocking 0
     + }
     + 
     ++method _do_clone_submodules {} {
     ++	if {$recursive eq {true}} {
     ++		$o_status_op stop
     ++		set o_status_op {}
     ++
     ++		destroy $w_body
     ++
     ++		set o_cons [console::embed \
     ++			$w_body \
     ++			[mc "Cloning submodules"]]
     ++		pack $w_body -fill both -expand 1 -padx 10
     ++		$o_cons exec \
     ++			[list git submodule update --init --recursive] \
     ++			[cb _do_validate_submodule_cloning]
     ++	} else {
     ++		set done 1
     ++	}
     ++}
     ++
     ++method _do_validate_submodule_cloning {ok} {
     ++	if {$ok} {
     ++		$o_cons done $ok
     ++		set done 1
     ++	} else {
     ++		_clone_failed $this [mc "Cannot clone submodules."]
     ++	}
     ++}
     ++
     + ######################################################################
     + ##
     + ## Open Existing Repository
     +
       diff --git a/lib/index.tcl b/lib/index.tcl
       --- a/lib/index.tcl
       +++ b/lib/index.tcl
     @@ -413,6 +716,7 @@
      +
      +	set baseline_text ""
      +	set operations [list]
     ++	set completed_operation_count 0
      +
       	${NS}::frame $w
       	${NS}::label $w_l \
     @@ -442,7 +746,7 @@
      +	$this refresh
      +}
      +
     -+method start {msg uds} {
     ++method start {msg {uds {}}} {
      +	set baseline_text ""
      +
      +	if {!$allow_multiple && [llength $operations]} {
 3:  d0d6593b42 ! 3:  3388407871 git-gui: revert untracked files by deleting them
     @@ -26,21 +26,6 @@
      
          Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
      
     - diff --git a/git-gui.sh b/git-gui.sh
     - --- a/git-gui.sh
     - +++ b/git-gui.sh
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
     -
       diff --git a/lib/chord.tcl b/lib/chord.tcl
       new file mode 100644
       --- /dev/null

-- 
gitgitgadget
