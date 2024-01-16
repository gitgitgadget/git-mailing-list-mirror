Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548AF1BF3E
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GrYfU+Hm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GrYfU+Hm"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5B87E1FBA6;
	Tue, 16 Jan 2024 14:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705414724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vFaVfw6Btpv+8uoulQVAwhntHawfyHiOUvB9s1T4xdc=;
	b=GrYfU+Hmzon+kGGFJEnbAatrX/5dpkcCBs9u8LPKHgppntWbL/P/cidMMuEuKItX1Eos3L
	aYVPzuWm9N5rBDEgWNohSsjPn236e8ufk7MlHX230e4cBPR0aXmuqahMf5woWiApenpA4s
	o284b35J6TYM/AgTmsHB7YXZkHCfLZw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705414724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vFaVfw6Btpv+8uoulQVAwhntHawfyHiOUvB9s1T4xdc=;
	b=GrYfU+Hmzon+kGGFJEnbAatrX/5dpkcCBs9u8LPKHgppntWbL/P/cidMMuEuKItX1Eos3L
	aYVPzuWm9N5rBDEgWNohSsjPn236e8ufk7MlHX230e4cBPR0aXmuqahMf5woWiApenpA4s
	o284b35J6TYM/AgTmsHB7YXZkHCfLZw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27C01132FA;
	Tue, 16 Jan 2024 14:18:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hE6LBkSQpmVsbQAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Tue, 16 Jan 2024 14:18:44 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: git@vger.kernel.org
Cc: Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] rebase: Fix documentation about used shell in -x
Date: Tue, 16 Jan 2024 16:18:42 +0200
Message-Id: <20240116141842.193151-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
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
	 BAYES_HAM(-0.00)[39.35%]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

The shell used when using the -x option is the one pointed to by the
SHELL_PATH constant at build time. This erroneous statement in the
documentation sent me on a 10 minute wild goose chase wondering why my
$SHELL was pointing to /bin/bash and my /bin/sh to dash and git was
using dash and not bash.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 25516c45d8b8..08cf52daf39e 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -964,7 +964,7 @@ non-0 status) to give you an opportunity to fix the problem. You can
 continue with `git rebase --continue`.
 
 The "exec" command launches the command in a shell (the one specified
-in `$SHELL`, or the default shell if `$SHELL` is not set), so you can
+by the build-time SHELL_PATH variable, usually /bin/sh), so you can
 use shell features (like "cd", ">", ";" ...). The command is run from
 the root of the working tree.
 
-- 
2.34.1

