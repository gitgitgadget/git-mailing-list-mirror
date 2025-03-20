Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84F51E98F3
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485319; cv=none; b=pgamEBNQRq/6EmFOsq35WVemzWbAswadtDUUMb24GECJqrVb4xGasfkjf5bM5CyZ22cHuhyW7bbUNjOlPXmnMEC0FfqlgTFhaXFgpAyL2+zp6pkrXTObDulsO2TnC2kk70Rw1rrmNa9ExMFS2BRHKdJSc7SlU39f+260PBw1PgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485319; c=relaxed/simple;
	bh=IaERstxGSkLYUt5gqkIff0TVINw9Q02o1F2PgGJ7tnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssocRc2agWW7QpCtRxScrmMzzWbxnsQst1Xc7HK9V91l/tu7JfGx7xChjkcXVf0Ja/hP3mJV0O3wKliOKzww7N7RbkZaX6np1u8XLTVDZYZ5bfVQj1eSPP3VIapWRPWARUv1woGYu3tgfFxWzriFPUOfACG3E3b6xzmUZUFKHLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cRXuYScD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FfYdHd5y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cRXuYScD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FfYdHd5y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cRXuYScD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FfYdHd5y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cRXuYScD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FfYdHd5y"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D245F1F7A8;
	Thu, 20 Mar 2025 15:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742485302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ld2FgKO93WN/5Sf2dsRXR7m9h1BdLEsMEY31IbXo3/M=;
	b=cRXuYScDwTRQCfbS/fT0rwlc2oHj8I/yEVVYBP5pwYu4frq6j1pVbBN5tqJ/9a3V+KVFYt
	BnyzDWiZsSu/hHvmrSN6qc5QAKYEVrsTQ67DacvxdDPS+e1v2Um6yn2B5+5LHaS32UzqHx
	csfW1Y/RKzGXY3Lfzbn+2wXJolInezs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742485302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ld2FgKO93WN/5Sf2dsRXR7m9h1BdLEsMEY31IbXo3/M=;
	b=FfYdHd5y4ZJYIkXf3D0uVGrTs8HIRYEKIBpqU3CylKYuGNIHqvo8knEEMgPuCTq57th6Gs
	VPk49hdd3WN6bUBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cRXuYScD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FfYdHd5y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742485302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ld2FgKO93WN/5Sf2dsRXR7m9h1BdLEsMEY31IbXo3/M=;
	b=cRXuYScDwTRQCfbS/fT0rwlc2oHj8I/yEVVYBP5pwYu4frq6j1pVbBN5tqJ/9a3V+KVFYt
	BnyzDWiZsSu/hHvmrSN6qc5QAKYEVrsTQ67DacvxdDPS+e1v2Um6yn2B5+5LHaS32UzqHx
	csfW1Y/RKzGXY3Lfzbn+2wXJolInezs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742485302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ld2FgKO93WN/5Sf2dsRXR7m9h1BdLEsMEY31IbXo3/M=;
	b=FfYdHd5y4ZJYIkXf3D0uVGrTs8HIRYEKIBpqU3CylKYuGNIHqvo8knEEMgPuCTq57th6Gs
	VPk49hdd3WN6bUBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94F4F13757;
	Thu, 20 Mar 2025 15:41:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4F8LIzY33GcueAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 20 Mar 2025 15:41:42 +0000
From: Takashi Iwai <tiwai@suse.de>
To: git@vger.kernel.org
Cc: Denton Liu <liu.denton@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Eric Huber <echuber2@illinois.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avi Halachmi <avihpit@yahoo.com>,
	Christoph Sommer <sommer@cms-labs.org>,
	Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 2/2] gitk: Add auto-select length preference for SHA256
Date: Thu, 20 Mar 2025 16:41:34 +0100
Message-ID: <20250320154136.23262-3-tiwai@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320154136.23262-1-tiwai@suse.de>
References: <20250320154136.23262-1-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D245F1F7A8
X-Spam-Score: -1.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmail.com,kdbg.org,illinois.edu,gmx.de,yahoo.com,cms-labs.org,ozlabs.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de,yahoo.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

This implements the missing preference setup of the auto select length
for SHA256. The variable set via the preference menu is switched
depending on the hash algorithm.

The default auto-select length is set to 64 for SHA256, and
saved/restored as "autosellensha256" in the config.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 gitk-git/gitk | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1e85cfef2ee3..b364d9e7dc93 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7488,6 +7488,16 @@ proc make_idmark {id} {
     $canv raise $t
 }
 
+proc get_autosellen {} {
+    global hashalgorithm autosellen autosellensha256
+
+    if {$hashalgorithm == "SHA256"} {
+        return $autosellensha256
+    } else {
+        return $autosellen
+    }
+}
+
 proc selectline {l isnew {desired_loc {}} {switch_to_patch 0}} {
     global canv ctext commitinfo selectedline
     global canvy0 linespc parents children curview
@@ -7496,7 +7506,7 @@ proc selectline {l isnew {desired_loc {}} {switch_to_patch 0}} {
     global mergemax numcommits pending_select
     global cmitmode showneartags allcommits
     global targetrow targetid lastscrollrows
-    global autocopy autoselect autosellen jump_to_here
+    global autocopy autoselect jump_to_here
     global vinlinediff
 
     unset -nocomplain pending_select
@@ -7563,11 +7573,11 @@ proc selectline {l isnew {desired_loc {}} {switch_to_patch 0}} {
     $sha1entry delete 0 end
     $sha1entry insert 0 $id
     if {$autoselect && [haveselectionclipboard]} {
-        $sha1entry selection range 0 $autosellen
+        $sha1entry selection range 0 [get_autosellen]
     }
     if {$autocopy} {
         clipboard clear
-        clipboard append [string range $id 0 [expr $autosellen - 1]]
+        clipboard append [string range $id 0 [expr [get_autosellen] - 1]]
     }
     rhighlight_sel $id
 
@@ -9629,13 +9639,14 @@ proc mktaggo {} {
 }
 
 proc copyreference {} {
-    global rowmenuid autosellen
+    global rowmenuid
     global hashlength
 
     set format "%h (\"%s\", %ad)"
     set cmd [list git show -s --pretty=format:$format --date=short]
-    if {$autosellen < $hashlength} {
-        lappend cmd --abbrev=$autosellen
+    set alen [get_autosellen]
+    if {$alen < $hashlength} {
+        lappend cmd --abbrev=$alen
     }
     set reference [eval exec $cmd $rowmenuid]
 
@@ -11741,8 +11752,9 @@ proc create_prefs_page {w} {
 proc prefspage_general {notebook} {
     global NS maxwidth maxgraphpct showneartags showlocalchanges
     global tabstop wrapcomment wrapdefault limitdiffs
-    global autocopy autoselect autosellen extdifftool perfile_attrs
+    global autocopy autoselect extdifftool perfile_attrs
     global hideremotes want_ttk have_ttk maxrefs web_browser
+    global hashalgorithm hashlength
 
     set page [create_prefs_page $notebook.general]
 
@@ -11771,7 +11783,13 @@ proc prefspage_general {notebook} {
             -variable autoselect
         grid x $page.autoselect -sticky w
     }
-    spinbox $page.autosellen -from 1 -to 40 -width 4 -textvariable autosellen
+
+    if {$hashalgorithm == "SHA256"} {
+        set autolenvar "autosellensha256"
+    } else {
+        set autolenvar "autosellen"
+    }
+    spinbox $page.autosellen -from 1 -to $hashlength -width 4 -textvariable $autolenvar
     ${NS}::label $page.autosellenl -text [mc "Length of commit ID to copy"]
     grid x $page.autosellenl $page.autosellen -sticky w
 
@@ -11908,7 +11926,7 @@ proc doprefs {} {
     global maxwidth maxgraphpct use_ttk NS
     global oldprefs prefstop showneartags showlocalchanges
     global uicolor bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
-    global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
+    global tabstop limitdiffs autoselect extdifftool perfile_attrs
     global hideremotes want_ttk have_ttk wrapcomment wrapdefault
 
     set top .gitkprefs
@@ -12606,6 +12624,7 @@ set datetimeformat "%Y-%m-%d %H:%M:%S"
 set autocopy 0
 set autoselect 1
 set autosellen 40
+set autosellensha256 64
 set perfile_attrs 0
 set want_ttk 1
 
@@ -12702,7 +12721,7 @@ config_check_tmp_exists 50
 set config_variables {
     mainfont textfont uifont tabstop findmergefiles maxgraphpct maxwidth
     cmitmode wrapcomment wrapdefault autocopy autoselect autosellen
-    showneartags maxrefs visiblerefs
+    autosellensha256 showneartags maxrefs visiblerefs
     hideremotes showlocalchanges datetimeformat limitdiffs uicolor want_ttk
     bgcolor fgcolor uifgcolor uifgdisabledcolor colors diffcolors mergecolors
     markbgcolor diffcontext selectbgcolor foundbgcolor currentsearchhitbgcolor
-- 
2.49.0

