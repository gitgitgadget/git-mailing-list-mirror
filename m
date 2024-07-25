Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D05B198A2C
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918772; cv=none; b=KmVhVCFW7J1pK/izXmE52JsXgVZayEzW8AxYR1UO5/Jce38qM1yf69++QpYT8aZJK/6OCLj8pfIwJZfN1THG+9IWoXlq89q/KlJ7Tw7khUKg8NJpbDbOFMS0R1qTHgig5C6tsdn3bLDSYrYSznRrw9wNFsDDKdOBqiBrMKg+4tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918772; c=relaxed/simple;
	bh=e3RVkt37UA/feVHJ9wraVMV9OOMAq52Hz0gbeDkWtS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMQDJVY3n+6m3V26vrjAHX9DctB4Cibbwpq273Drcef3KJ/BBOJNTPAxU7H6O0Wed4ib/qfzD/zns86EnU9iZTB115+GpqarDNTf8bsI0Serp9wuayNz5YsNN8UMQWEjsNhCGM1x+4YQjvXvzrXTkZsO0TO9rwavZ6ZjPxOwEj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TqVSFCXc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LEgmlPkQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TqVSFCXc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LEgmlPkQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TqVSFCXc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LEgmlPkQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TqVSFCXc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LEgmlPkQ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CB06C1F811;
	Thu, 25 Jul 2024 14:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721918767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIOZcQhIyIv/I/jgx2nBKmsiAuqpHEO18iX31W2beLo=;
	b=TqVSFCXc+kgOms3cRb36pCBBep0/Hz+o8kua2Y9TdsUiaycexoajGgAMYrwz0+dcKZHfK9
	756Na0kQwgQagEqowCOLqJ+4bzG73Y8xnAm3VfvxaPfP7UVsIV24EYzP3FbPhZWT57ceZG
	J4CqgE2dR3iKflP8e17u2mkPWH6OZyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721918767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIOZcQhIyIv/I/jgx2nBKmsiAuqpHEO18iX31W2beLo=;
	b=LEgmlPkQpq9Xo2dImP6Un1HUzlU955bmfGUDolWT3+ts8f9QR/tHgV99Xjb+nouLD6Awo3
	impJwwc7/3aKy4DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721918767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIOZcQhIyIv/I/jgx2nBKmsiAuqpHEO18iX31W2beLo=;
	b=TqVSFCXc+kgOms3cRb36pCBBep0/Hz+o8kua2Y9TdsUiaycexoajGgAMYrwz0+dcKZHfK9
	756Na0kQwgQagEqowCOLqJ+4bzG73Y8xnAm3VfvxaPfP7UVsIV24EYzP3FbPhZWT57ceZG
	J4CqgE2dR3iKflP8e17u2mkPWH6OZyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721918767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIOZcQhIyIv/I/jgx2nBKmsiAuqpHEO18iX31W2beLo=;
	b=LEgmlPkQpq9Xo2dImP6Un1HUzlU955bmfGUDolWT3+ts8f9QR/tHgV99Xjb+nouLD6Awo3
	impJwwc7/3aKy4DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A96851368A;
	Thu, 25 Jul 2024 14:46:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gMjzJy9lomYiHAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 25 Jul 2024 14:46:07 +0000
From: David Disseldorp <ddiss@suse.de>
To: git@vger.kernel.org
Cc: Teng Long <dyroneteng@gmail.com>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH 2/2] notes: revert note_data.given behavior with empty notes add
Date: Thu, 25 Jul 2024 16:41:07 +0200
Message-ID: <20240725144548.3434-3-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725144548.3434-1-ddiss@suse.de>
References: <20240725144548.3434-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.60 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.de];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.60

Prior to 90bc19b3ae, note_data.given was set alongside an -m, -C or -F
parameter for add / append. Following 90bc19b3ae, note_data.given is
only set if the notes data buffer length is non-zero, which results in
GIT_EDITOR invocation if e.g. a zero length blob object is provided.

Revert to pre-90bc19b3ae note_data.given behavior, to fix
non-interactive callers.

Fixes: 90bc19b3ae ("notes.c: introduce '--separator=<paragraph-break>' option")
Link: https://github.com/ddiss/icyci/issues/12
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 builtin/notes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index d9c356e354..3ccb3eb602 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -282,6 +282,7 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
 	d->messages[d->msg_nr - 1] = msg;
 	msg->stripspace = STRIPSPACE;
+	d->given = 1;
 	return 0;
 }
 
@@ -302,6 +303,7 @@ static int parse_file_arg(const struct option *opt, const char *arg, int unset)
 	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
 	d->messages[d->msg_nr - 1] = msg;
 	msg->stripspace = STRIPSPACE;
+	d->given = 1;
 	return 0;
 }
 
@@ -335,6 +337,7 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
 	d->messages[d->msg_nr - 1] = msg;
 	msg->stripspace = NO_STRIPSPACE;
+	d->given = 1;
 	return 0;
 }
 
@@ -515,7 +518,6 @@ static int add(int argc, const char **argv, const char *prefix)
 
 	if (d.msg_nr)
 		concat_messages(&d);
-	d.given = !!d.buf.len;
 
 	object_ref = argc > 1 ? argv[1] : "HEAD";
 
@@ -692,7 +694,6 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 
 	if (d.msg_nr)
 		concat_messages(&d);
-	d.given = !!d.buf.len;
 
 	if (d.given && edit)
 		fprintf(stderr, _("The -m/-F/-c/-C options have been deprecated "
-- 
2.43.0

