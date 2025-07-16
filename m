Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F1327146F
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 07:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651170; cv=none; b=D5bFHMSXaE2hkIR8JhiMwil5zueuNSVTsFRSw6tfskqFuPPNJkAEMqppbsCt34I7n1o3suGBNynzLgK+1pyKFZaERsHgT6Lxzr4UqD2lq30ms2MEaa05/D9q3qiy36+fgEJqV5LavQckmv+UpyaChWP1GQydLoEUH3f02xlgg1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651170; c=relaxed/simple;
	bh=QF/Wq1Hz3otvJGnJVb7yjutBCdLvE/AuvTK5TRPk0hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgYLLqWw1Kp9Gd2kWGaWkUDrBqohW38OQYOODUaqt6Pl7CpIQsmnQypnVQQVbWXod9skXtfDB+e3UtV64tvW+A4jApcy76/zxhotGo/MPcwTmT3hihBt4dfeJx/RUBlU4LJpfxHe+1C3J24DPEk5WP05rnaqU1dWcCKDcJ4dZ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dHwOW5fG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r6AluM+k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dHwOW5fG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r6AluM+k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dHwOW5fG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r6AluM+k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dHwOW5fG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r6AluM+k"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 563482124D;
	Wed, 16 Jul 2025 07:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752651150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKi9lY7zSClOL7bDfYUxDGnrms8oWan0hSc6ip5nKTc=;
	b=dHwOW5fGORW29CrOae+0crV3FX5HakIwIuqvOgiGEPetvkWgDPimqnXhXj3Yf3oBKvw+xm
	7qVS2CIb3iEPajQHtr+V0uGCOJmQooAHvwQZaO6OkctqdLCfXA3bygMkzK+CQeDc+ierUT
	5ocIS5xMmy+CMVZdEryTUGyPdsxYg64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752651150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKi9lY7zSClOL7bDfYUxDGnrms8oWan0hSc6ip5nKTc=;
	b=r6AluM+kFGKAor7G6hkFRY9vti/KNorenxi1NUOX8eXlWWPFzRevkMM5ANxuubm3Y/TdG3
	20T1F9cbhUVVzmBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752651150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKi9lY7zSClOL7bDfYUxDGnrms8oWan0hSc6ip5nKTc=;
	b=dHwOW5fGORW29CrOae+0crV3FX5HakIwIuqvOgiGEPetvkWgDPimqnXhXj3Yf3oBKvw+xm
	7qVS2CIb3iEPajQHtr+V0uGCOJmQooAHvwQZaO6OkctqdLCfXA3bygMkzK+CQeDc+ierUT
	5ocIS5xMmy+CMVZdEryTUGyPdsxYg64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752651150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKi9lY7zSClOL7bDfYUxDGnrms8oWan0hSc6ip5nKTc=;
	b=r6AluM+kFGKAor7G6hkFRY9vti/KNorenxi1NUOX8eXlWWPFzRevkMM5ANxuubm3Y/TdG3
	20T1F9cbhUVVzmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 369F813306;
	Wed, 16 Jul 2025 07:32:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aKr6C45Vd2iZAQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 16 Jul 2025 07:32:30 +0000
From: Takashi Iwai <tiwai@suse.de>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 2/2] git-gui: Add support of SHA256 repo
Date: Wed, 16 Jul 2025 09:32:25 +0200
Message-ID: <20250716073227.11486-3-tiwai@suse.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716073227.11486-1-tiwai@suse.de>
References: <20250716073227.11486-1-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

This patch adds the basic support of SHA256 Git repositories.
Most of changes are idiomatic replacement of the hard-coded hash ID
length, but there are subtle things:

* The hash length is determined on startup, and stored in $hashlength
  global variable (either 40 or 64).
* The hard-coded "40" are replaced with $hashlength;
  for regexp patterns, the ugly string map is used.
* Some code have the fixed numbers like 39 and 45, and those are
  replaced with the $hashlength and the offset correction.
* $nullid and $nullid2 are generated for the hash length.

A caveat is that repository picker dialog is performed before
evaluating the repo type, hence $hashlength isn't set there yet.
So the code dealing with the hard-coded "40" are handled differently;
namely, the regexp range is expanded, and the null id is generated
from the HEAD id length locally.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v2->v3:
* add more texts to patch descriptions
* fix $nullid and $nullid2, too
* fix abbrev id check in blame
* don't refer to $hashlength in repo picker code

 git-gui/git-gui.sh                   | 17 ++++++++++++++---
 git-gui/lib/blame.tcl                | 12 ++++++++----
 git-gui/lib/choose_repository.tcl    |  7 ++++---
 git-gui/lib/commit.tcl               |  3 ++-
 git-gui/lib/remote_branch_delete.tcl |  4 +++-
 5 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 413a8a9abc1f..c437980927fd 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1298,6 +1298,17 @@ if {[catch {
 	set picked 1
 }
 
+# Use object format as hash algorightm (either "sha1" or "sha256")
+set hashalgorithm [exec git rev-parse --show-object-format]
+if {$hashalgorithm eq "sha1"} {
+	set hashlength 40
+} elseif {$hashalgorithm eq "sha256"} {
+	set hashlength 64
+} else {
+	puts stderr "Unknown hash algorithm: $hashalgorithm"
+	exit 1
+}
+
 # we expand the _gitdir when it's just a single dot (i.e. when we're being
 # run from the .git dir itself) lest the routines to find the worktree
 # get confused
@@ -1391,8 +1402,8 @@ set is_conflict_diff 0
 set last_revert {}
 set last_revert_enc {}
 
-set nullid "0000000000000000000000000000000000000000"
-set nullid2 "0000000000000000000000000000000000000001"
+set nullid [string repeat 0 $hashlength]
+set nullid2 "[string repeat 0 [expr $hashlength - 1]]1"
 
 ######################################################################
 ##
@@ -3202,7 +3213,7 @@ blame {
 	if {$head eq {}} {
 		load_current_branch
 	} else {
-		if {[regexp {^[0-9a-f]{1,39}$} $head]} {
+		if {[regexp [string map "@@ [expr $hashlength - 1]" {^[0-9a-f]{1,@@}$}] $head]} {
 			if {[catch {
 					set head [git rev-parse --verify $head]
 				} err]} {
diff --git a/git-gui/lib/blame.tcl b/git-gui/lib/blame.tcl
index d6fd8bea91ff..5507681da7ba 100644
--- a/git-gui/lib/blame.tcl
+++ b/git-gui/lib/blame.tcl
@@ -426,6 +426,7 @@ method _kill {} {
 
 method _load {jump} {
 	variable group_colors
+	global hashlength
 
 	_hide_tooltip $this
 
@@ -436,7 +437,7 @@ method _load {jump} {
 			$i conf -state normal
 			$i delete 0.0 end
 			foreach g [$i tag names] {
-				if {[regexp {^g[0-9a-f]{40}$} $g]} {
+				if {[regexp [string map "@@ $hashlength" {^g[0-9a-f]{@@}$}] $g]} {
 					$i tag delete $g
 				}
 			}
@@ -500,6 +501,8 @@ method _load {jump} {
 }
 
 method _history_menu {} {
+	global hashlength
+
 	set m $w.backmenu
 	if {[winfo exists $m]} {
 		$m delete 0 end
@@ -513,7 +516,7 @@ method _history_menu {} {
 		set c [lindex $e 0]
 		set f [lindex $e 1]
 
-		if {[regexp {^[0-9a-f]{40}$} $c]} {
+		if {[regexp [string map "@@ $hashlength" {^[0-9a-f]{@@}$}] $c]} {
 			set t [string range $c 0 8]...
 		} elseif {$c eq {}} {
 			set t {Working Directory}
@@ -627,6 +630,7 @@ method _exec_blame {cur_w cur_d options cur_s} {
 method _read_blame {fd cur_w cur_d} {
 	upvar #0 $cur_d line_data
 	variable group_colors
+	global hashlength nullid
 
 	if {$fd ne $current_fd} {
 		catch {close $fd}
@@ -635,7 +639,7 @@ method _read_blame {fd cur_w cur_d} {
 
 	$cur_w conf -state normal
 	while {[gets $fd line] >= 0} {
-		if {[regexp {^([a-z0-9]{40}) (\d+) (\d+) (\d+)$} $line line \
+		if {[regexp [string map "@@ $hashlength" {^([a-z0-9]{@@}) (\d+) (\d+) (\d+)$}] $line line \
 			cmit original_line final_line line_count]} {
 			set r_commit     $cmit
 			set r_orig_line  $original_line
@@ -648,7 +652,7 @@ method _read_blame {fd cur_w cur_d} {
 			set oln  $r_orig_line
 			set cmit $r_commit
 
-			if {[regexp {^0{40}$} $cmit]} {
+			if {$cmit eq $nullid} {
 				set commit_abbr work
 				set commit_type curr_commit
 			} elseif {$cmit eq $commit} {
diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
index 5b361cc424a6..877ca4888f7a 100644
--- a/git-gui/lib/choose_repository.tcl
+++ b/git-gui/lib/choose_repository.tcl
@@ -879,7 +879,7 @@ method _do_clone_full_end {ok} {
 		if {[file exists [gitdir FETCH_HEAD]]} {
 			set fd [safe_open_file [gitdir FETCH_HEAD] r]
 			while {[gets $fd line] >= 0} {
-				if {[regexp "^(.{40})\t\t" $line line HEAD]} {
+				if {[regexp "^(.{40,64})\t\t" $line line HEAD]} {
 					break
 				}
 			}
@@ -987,8 +987,9 @@ method _readtree_wait {fd} {
 
 	# -- Run the post-checkout hook.
 	#
-	set fd_ph [githook_read post-checkout [string repeat 0 40] \
-		[git rev-parse HEAD] 1]
+	set head_id [git rev-parse HEAD]
+	set fd_ph [githook_read post-checkout \
+		[string repeat 0 [string length $head_id]] $head_id 1]
 	if {$fd_ph ne {}} {
 		global pch_error
 		set pch_error {}
diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index 60d66172a100..7c800a4bc37a 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -348,6 +348,7 @@ proc commit_committree {fd_wt curHEAD msg_p} {
 	global file_states selected_paths rescan_active
 	global repo_config
 	global env
+	global hashlength
 
 	gets $fd_wt tree_id
 	if {[catch {close $fd_wt} err]} {
@@ -367,7 +368,7 @@ proc commit_committree {fd_wt curHEAD msg_p} {
 		close $fd_ot
 
 		if {[string equal -length 5 {tree } $old_tree]
-			&& [string length $old_tree] == 45} {
+			&& [string length $old_tree] == [expr {$hashlength + 5}]} {
 			set old_tree [string range $old_tree 5 end]
 		} else {
 			error [mc "Commit %s appears to be corrupt" $PARENT]
diff --git a/git-gui/lib/remote_branch_delete.tcl b/git-gui/lib/remote_branch_delete.tcl
index c8c99b17a8da..781980d66cc8 100644
--- a/git-gui/lib/remote_branch_delete.tcl
+++ b/git-gui/lib/remote_branch_delete.tcl
@@ -323,6 +323,8 @@ method _load {cache uri} {
 }
 
 method _read {cache fd} {
+	global hashlength
+
 	if {$fd ne $active_ls} {
 		catch {close $fd}
 		return
@@ -330,7 +332,7 @@ method _read {cache fd} {
 
 	while {[gets $fd line] >= 0} {
 		if {[string match {*^{}} $line]} continue
-		if {[regexp {^([0-9a-f]{40})	(.*)$} $line _junk obj ref]} {
+		if {[regexp [string map "@@ $hashlength" {^([0-9a-f]{@@})	(.*)$}] $line _junk obj ref]} {
 			if {[regsub ^refs/heads/ $ref {} abr]} {
 				lappend head_list $abr
 				lappend head_cache($cache) $abr
-- 
2.50.1

