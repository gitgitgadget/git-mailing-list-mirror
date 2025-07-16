Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B38D26B97D
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651160; cv=none; b=PiQR7aKmsJm363IjerwxXvf7MX53vaOa52gg1I8hXaJdK9r2mMgJKQWZrSG25VOR/6Hd/O/dB1mgmu98Mzku+X9y3V9eKesFHUr4arDXPTC3GwBIe0+JpfyqYkbCcs59DzD6UsqObqW3z5JHu0i3M/9IUES8qDAZ20J46uakG9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651160; c=relaxed/simple;
	bh=bbuGcGjYvt/YlkSb7lKAyiB+mmwT6tRcEx09tH46meY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6rdv6ciyUMhhqnq/ckNuxY67RG+Epg4CtxeXhbMkj8nRPLb7TQzneX9EnelzbmSkQvVh3wOedT5Pu3Hk2TevitGXEhBpiOaeFd31wzyg75KfoCL4moiFMqxim21k3cR0OnJjqnOs3W8wtW5pZ1D4WX7QSNkilnitC5Vk29LOK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kW3LC1yw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OvAGvkkp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kW3LC1yw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OvAGvkkp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kW3LC1yw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OvAGvkkp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kW3LC1yw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OvAGvkkp"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 357E21F44E;
	Wed, 16 Jul 2025 07:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752651150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BElez+lriJM4Qz2agU+xorYxFBs7mmqdGd2umTivpIQ=;
	b=kW3LC1ywl3P49fBg1yxfpFEIOVSM+Z0t1o0XRhcFQaRn4saUgJUs3fc6zBXjvF/C77aUoT
	0Rbys648sV0kTIW1JpKFz6ryirdk1Vy4vRhKdFBBchBliIA/LxsV3nQNpYrmmA6BhgkE1n
	5u/gineH/CNSUOE3mWVH28HxQwmB9Xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752651150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BElez+lriJM4Qz2agU+xorYxFBs7mmqdGd2umTivpIQ=;
	b=OvAGvkkp6slwUDxnydhBEuMO5Eq9mG9zmlvjZ/DrLgiCZBXQsVACBIztPpdzu01nAYJCzu
	dd91u3sJX/JxX2Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752651150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BElez+lriJM4Qz2agU+xorYxFBs7mmqdGd2umTivpIQ=;
	b=kW3LC1ywl3P49fBg1yxfpFEIOVSM+Z0t1o0XRhcFQaRn4saUgJUs3fc6zBXjvF/C77aUoT
	0Rbys648sV0kTIW1JpKFz6ryirdk1Vy4vRhKdFBBchBliIA/LxsV3nQNpYrmmA6BhgkE1n
	5u/gineH/CNSUOE3mWVH28HxQwmB9Xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752651150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BElez+lriJM4Qz2agU+xorYxFBs7mmqdGd2umTivpIQ=;
	b=OvAGvkkp6slwUDxnydhBEuMO5Eq9mG9zmlvjZ/DrLgiCZBXQsVACBIztPpdzu01nAYJCzu
	dd91u3sJX/JxX2Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F0FE13A52;
	Wed, 16 Jul 2025 07:32:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AFl3Ao5Vd2iZAQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 16 Jul 2025 07:32:30 +0000
From: Takashi Iwai <tiwai@suse.de>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 1/2] git-gui: Replace null_sha1 with nullid
Date: Wed, 16 Jul 2025 09:32:24 +0200
Message-ID: <20250716073227.11486-2-tiwai@suse.de>
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
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.79

Both $nullid and $null_sha1 point to the same content.
Use only $nullid consistently.

This is a preliminary cleanup for adding the support of SHA256 repo.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v3: new patch

 git-gui/git-gui.sh          | 5 ++---
 git-gui/lib/checkout_op.tcl | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index c77c05edde3b..413a8a9abc1f 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1845,10 +1845,9 @@ proc short_path {path} {
 }
 
 set next_icon_id 0
-set null_sha1 [string repeat 0 40]
 
 proc merge_state {path new_state {head_info {}} {index_info {}}} {
-	global file_states next_icon_id null_sha1
+	global file_states next_icon_id nullid
 
 	set s0 [string index $new_state 0]
 	set s1 [string index $new_state 1]
@@ -1870,7 +1869,7 @@ proc merge_state {path new_state {head_info {}} {index_info {}}} {
 	elseif {$s1 eq {_}} {set s1 _}
 
 	if {$s0 eq {A} && $s1 eq {_} && $head_info eq {}} {
-		set head_info [list 0 $null_sha1]
+		set head_info [list 0 $nullid]
 	} elseif {$s0 ne {_} && [string index $state 0] eq {_}
 		&& $head_info eq {}} {
 		set head_info $index_info
diff --git a/git-gui/lib/checkout_op.tcl b/git-gui/lib/checkout_op.tcl
index 87ed0b48585e..987486a4b602 100644
--- a/git-gui/lib/checkout_op.tcl
+++ b/git-gui/lib/checkout_op.tcl
@@ -151,7 +151,7 @@ method _finish_fetch {ok} {
 }
 
 method _update_ref {} {
-	global null_sha1 current_branch repo_config
+	global nullid current_branch repo_config
 
 	set ref $new_ref
 	set new $new_hash
@@ -177,7 +177,7 @@ method _update_ref {} {
 		}
 
 		set reflog_msg "branch: Created from $new_expr"
-		set cur $null_sha1
+		set cur $nullid
 
 		if {($repo_config(branch.autosetupmerge) eq {true}
 			|| $repo_config(branch.autosetupmerge) eq {always})
-- 
2.50.1

