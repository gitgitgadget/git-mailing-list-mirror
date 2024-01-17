Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AF112B6F
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481700; cv=none; b=fe7w0n2tI5fRkYnrxgaShZd3W1xxs3vYhARfoDOINRMFo+16wOOZ8tEmrwvi9wlBZ2xSYmnWeyrDrOAL6Paqch5UcW+W8m2S753MewrzqNg70UFxRqlv7GtDJuAlU18kLh1BfSOdjgoGJbISRqn0PzaWrAWngDlRj4xdJCWVCqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481700; c=relaxed/simple;
	bh=tCc2D06pc7yYvQNlp/jJVWjO+bZfpfl1n6gQDpufCm8=;
	h=Received:DKIM-Signature:DKIM-Signature:Received:Received:From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Level:X-Spam-Score:
	 X-Spam-Flag; b=tZaSCLzRFjl0+ySi3uhlz7Pgg34KaM73Wn9+xP45jsLKnzfSyfUVjxcjcdKuCSABexsGEXGDkRYubT+22w6McJD5cjBWfE2eivE/+YCdqGgzbiqHqdeldMciIxhmoR8nE5u4zxdcTW2hM5xX6r4M2mV7I5SJTXNjtAJrYb4HNEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NOKETyk5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NOKETyk5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NOKETyk5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NOKETyk5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 91BF022236;
	Wed, 17 Jan 2024 08:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705481693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tCc2D06pc7yYvQNlp/jJVWjO+bZfpfl1n6gQDpufCm8=;
	b=NOKETyk59la/yF+9Yo037yNMwJc7W4KWAh1RwSSxdFAFd49UVcDugYINaQAtqUI68m/qsb
	yq5tLg/002xR2upPnG6+hwluw/OSYlIRioMriTCx7V2et8ZUBHofCeYK3TowzGeyhkv+Sm
	G5Epy08dJ5s/zTcicf3U3bm0zGXKNLM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705481693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tCc2D06pc7yYvQNlp/jJVWjO+bZfpfl1n6gQDpufCm8=;
	b=NOKETyk59la/yF+9Yo037yNMwJc7W4KWAh1RwSSxdFAFd49UVcDugYINaQAtqUI68m/qsb
	yq5tLg/002xR2upPnG6+hwluw/OSYlIRioMriTCx7V2et8ZUBHofCeYK3TowzGeyhkv+Sm
	G5Epy08dJ5s/zTcicf3U3bm0zGXKNLM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 631CF13751;
	Wed, 17 Jan 2024 08:54:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QrnPFd2Vp2UVEAAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Wed, 17 Jan 2024 08:54:53 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: git@vger.kernel.org
Cc: Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2] rebase: Fix documentation about used shell in -x
Date: Wed, 17 Jan 2024 10:53:47 +0200
Message-Id: <20240117085347.948960-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.88 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[53.47%]
X-Spam-Level: ****
X-Spam-Score: 4.88
X-Spam-Flag: NO

The shell used when using the -x option is erroneously documented to be
the one pointed to by the $SHELL environmental variable. This was true
when rebase was implemented as a shell script but this is no longer
true.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 Documentation/git-rebase.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 25516c45d8b8..2cd55aedc0f9 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -963,10 +963,9 @@ The interactive rebase will stop when a command fails (i.e. exits with
 non-0 status) to give you an opportunity to fix the problem. You can
 continue with `git rebase --continue`.

-The "exec" command launches the command in a shell (the one specified
-in `$SHELL`, or the default shell if `$SHELL` is not set), so you can
-use shell features (like "cd", ">", ";" ...). The command is run from
-the root of the working tree.
+The "exec" command launches the command in a shell (the default one, usually
+/bin/sh), so you can use shell features (like "cd", ">", ";" ...). The command
+is run from the root of the working tree.

 ----------------------------------
 $ git rebase -i --exec "make test"
--
2.34.1

