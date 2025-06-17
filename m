Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7D5C2D1
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 06:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750140252; cv=none; b=X8KrWeSDh+5a6fX3smC4KPoBUbV4vHIpLMP8Rit5GQt2QN+/5nL8vpr2YY8eQXRSpOv4LG+Y6UsvEWIRGqk5DrzKJTzyY/j29ekxdEKHz3ci/c5LxHjTtnrRjL2ik9ImeWsjsAfmEqRcn326sFncNPG1ScFdvXahyMJGgZ6o6cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750140252; c=relaxed/simple;
	bh=X5i5ac43TlnnK2y31HnTPOXN55+F+k/jyptjEOgAu2I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ARUd+6yBFczcToo7nZxVedfvuhBCY9m36/AcR/e6kR3mvRidOzlqsy98CbtliFISKVOxtCVsxyS0YxdNLJoqVO6YskjypGZFqC6P7gy0hZIzs+W8Ru89yH/MxraH44B/x4SqLJWOjneKOCwqvcA5N/ePRtXCKvr7p4jHakZfzMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E9IVdf8Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hRFixBnP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E9IVdf8Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hRFixBnP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E9IVdf8Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hRFixBnP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E9IVdf8Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hRFixBnP"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D51241F388;
	Tue, 17 Jun 2025 06:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750140247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0IdYg0fSsd7WjF54y3NChB1MNY2krf+Vz6g6fOD+yGM=;
	b=E9IVdf8Z1l+oQY+5xK2IORPQEvqfp0vmSPN2XQ0JQw5BkD8F1NQ3pv3RyR0l2N6JkwBaP8
	62lTFRzu8DQc06kxsjDCXsioRNC0ade5NjZEOK/2+Ho906cJjjMpHJhM+tXyJeh665bclx
	29ixw+tAMtZWL/JrUCyDyjNCwzN/XQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750140247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0IdYg0fSsd7WjF54y3NChB1MNY2krf+Vz6g6fOD+yGM=;
	b=hRFixBnPT5izTTUn5sBBmLewHCnu9t0ynTscN95q4g6UKvKKgJ2N1TcldPUKLl0MNlkSHl
	sJSv345cc0wpdKDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750140247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0IdYg0fSsd7WjF54y3NChB1MNY2krf+Vz6g6fOD+yGM=;
	b=E9IVdf8Z1l+oQY+5xK2IORPQEvqfp0vmSPN2XQ0JQw5BkD8F1NQ3pv3RyR0l2N6JkwBaP8
	62lTFRzu8DQc06kxsjDCXsioRNC0ade5NjZEOK/2+Ho906cJjjMpHJhM+tXyJeh665bclx
	29ixw+tAMtZWL/JrUCyDyjNCwzN/XQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750140247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0IdYg0fSsd7WjF54y3NChB1MNY2krf+Vz6g6fOD+yGM=;
	b=hRFixBnPT5izTTUn5sBBmLewHCnu9t0ynTscN95q4g6UKvKKgJ2N1TcldPUKLl0MNlkSHl
	sJSv345cc0wpdKDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B670C13A69;
	Tue, 17 Jun 2025 06:04:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XAALK1cFUWimSgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 17 Jun 2025 06:04:07 +0000
From: Takashi Iwai <tiwai@suse.de>
To: git@vger.kernel.org
Subject: [PATCH] git-gui: Add support of SHA256 repo
Date: Tue, 17 Jun 2025 08:03:59 +0200
Message-ID: <20250617060406.10159-1-tiwai@suse.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

This patch adds the basic support of SHA256 Git repositories.
The needed changes were mostly about adjusting the fixed ID length of
SHA1 (40) to be variable depending on the repo type.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 git-gui/git-gui.sh                   | 13 ++++++++++++-
 git-gui/lib/blame.tcl                | 12 ++++++++----
 git-gui/lib/choose_repository.tcl    |  8 ++++++--
 git-gui/lib/remote_branch_delete.tcl |  4 +++-
 4 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 28572c889c0e..206981190535 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1275,6 +1275,17 @@ if {[catch {
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
@@ -1822,7 +1833,7 @@ proc short_path {path} {
 }
 
 set next_icon_id 0
-set null_sha1 [string repeat 0 40]
+set null_sha1 [string repeat 0 $hashlength]
 
 proc merge_state {path new_state {head_info {}} {index_info {}}} {
 	global file_states next_icon_id null_sha1
diff --git a/git-gui/lib/blame.tcl b/git-gui/lib/blame.tcl
index 8441e109be32..1f0b8ea28504 100644
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
+	global hashlength
 
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
+			if {[regexp [string map "@@ $hashlength" {^0{@@}$}] $cmit]} {
 				set commit_abbr work
 				set commit_type curr_commit
 			} elseif {$cmit eq $commit} {
diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
index d23abedcb36f..6078b1c7e2c4 100644
--- a/git-gui/lib/choose_repository.tcl
+++ b/git-gui/lib/choose_repository.tcl
@@ -870,6 +870,8 @@ method _do_clone_HEAD {ok} {
 }
 
 method _do_clone_full_end {ok} {
+	global hashlength
+
 	$o_cons done $ok
 
 	if {$ok} {
@@ -879,7 +881,7 @@ method _do_clone_full_end {ok} {
 		if {[file exists [gitdir FETCH_HEAD]]} {
 			set fd [open [gitdir FETCH_HEAD] r]
 			while {[gets $fd line] >= 0} {
-				if {[regexp "^(.{40})\t\t" $line line HEAD]} {
+				if {[regexp [string map "@@ $hashlength" "^(.{@@})\t\t"] $line line HEAD]} {
 					break
 				}
 			}
@@ -965,6 +967,8 @@ method _do_clone_checkout {HEAD} {
 }
 
 method _readtree_wait {fd} {
+	global hashlength
+
 	set buf [read $fd]
 	$o_status_op update_meter $buf
 	append readtree_err $buf
@@ -986,7 +990,7 @@ method _readtree_wait {fd} {
 
 	# -- Run the post-checkout hook.
 	#
-	set fd_ph [githook_read post-checkout [string repeat 0 40] \
+	set fd_ph [githook_read post-checkout [string repeat 0 $hashlength] \
 		[git rev-parse HEAD] 1]
 	if {$fd_ph ne {}} {
 		global pch_error
diff --git a/git-gui/lib/remote_branch_delete.tcl b/git-gui/lib/remote_branch_delete.tcl
index 5ba9fcadd17f..8ea672479306 100644
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
2.49.0

