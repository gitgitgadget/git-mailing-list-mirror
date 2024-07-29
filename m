Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734BA1E4A2
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266218; cv=none; b=enn50Tic4VO/5KiWGM0kwq7J2lgJZKi1qeJ9V3+o2+ncdu5iEskO5YOw/gWWcEoLYox1ezsk/Bh8D5cFEVzS9b7y1vhhPxTJAqgtYGj4hlwrLWW7sqqOMBFGRyGr0eiUNUqTn0W0BbUeJ4lWRcsF/2jT+ndDe/903k81caWaAoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266218; c=relaxed/simple;
	bh=SKTjK8Mkil2X1Wzw6QgT+QKz4gGiQaI64PRGl4Z6o+0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mpWQcgQhOa+pwDOFiazMjUfuwrJ1uXpw8UotEUdb7q7NsiEmuKFg0sXWbxKrqw/DC2KzfQouNdD0FukJcOQT+7IVxqfn+cxp0INDlVlxmNgLAbhwuioNMsuoA1O/6si5i/Z99aVF6sNc09o6EL+1rigKexfIZxo4z5Hu4QWUykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hwkGi0OS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=toxMJePl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hwkGi0OS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=toxMJePl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hwkGi0OS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="toxMJePl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hwkGi0OS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="toxMJePl"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C74511F7A7
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 15:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722266211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=by7DFWQ/ik8GEV5U172WH4B+w/wWzbUKnSSvc9VdVmE=;
	b=hwkGi0OSnWTSmzUOkQFr7JdNH4ewN8zH2M8ICR+j0JwxTNT3g6AY4F0mGyWtma4W+c6ErQ
	qqd8DLXxz1U0dHBH9Ih6ISl0J3Idh3PY4X5pnbyVPq9j9hL5gNrTlv59E+RmXm+7Ve+j0t
	eeq32ReBGSaARMkawBwKEo98L8Jhi8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722266211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=by7DFWQ/ik8GEV5U172WH4B+w/wWzbUKnSSvc9VdVmE=;
	b=toxMJePlct3f21BHCWLWeGlfvqomdgaHpCwVxLBNKMtLSMQJD4IxherQCovP8zO6gSJ26h
	YOf9o1D0RM++0eDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722266211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=by7DFWQ/ik8GEV5U172WH4B+w/wWzbUKnSSvc9VdVmE=;
	b=hwkGi0OSnWTSmzUOkQFr7JdNH4ewN8zH2M8ICR+j0JwxTNT3g6AY4F0mGyWtma4W+c6ErQ
	qqd8DLXxz1U0dHBH9Ih6ISl0J3Idh3PY4X5pnbyVPq9j9hL5gNrTlv59E+RmXm+7Ve+j0t
	eeq32ReBGSaARMkawBwKEo98L8Jhi8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722266211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=by7DFWQ/ik8GEV5U172WH4B+w/wWzbUKnSSvc9VdVmE=;
	b=toxMJePlct3f21BHCWLWeGlfvqomdgaHpCwVxLBNKMtLSMQJD4IxherQCovP8zO6gSJ26h
	YOf9o1D0RM++0eDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B059F1368A
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 15:16:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pFKUKWOyp2aIdwAAD6G6ig
	(envelope-from <ddiss@suse.de>)
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 15:16:51 +0000
From: David Disseldorp <ddiss@suse.de>
To: git@vger.kernel.org
Subject: [PATCH v2 0/1] notes: fix editor invocation regression
Date: Mon, 29 Jul 2024 17:13:59 +0200
Message-ID: <20240729151639.19192-1-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.40 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[git@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: 0.40

The following patch attempts to restore previous editor invocation
behavior for empty notes, which was inadvertantly changed via 90bc19b3ae
(notes.c: introduce '--separator=<paragraph-break>' option, 2023-05-27).
A new regression test is included, which passes prior to 90bc19b3ae and
after this fix.

Please cc me in any replies as I'm not subscribed.

Cheers, David

--

The following changes since commit ad57f148c6b5f8735b62238dda8f571c582e0e54:

  Git 2.46-rc2 (2024-07-23 16:54:35 -0700)

are available in the Git repository at:

  https://github.com/ddiss/git.git notes_empty_editor_add_v2

for you to fetch changes up to 63019aa2c7bbee5989944a990ca2c0229cef8ae2:

  notes: do not trigger editor when adding an empty note (2024-07-29 13:22:26 +0200)

----------------------------------------------------------------
David Disseldorp (1):
      notes: do not trigger editor when adding an empty note

 builtin/notes.c  | 22 ++++++++++------------
 t/t3301-notes.sh |  5 +++++
 2 files changed, 15 insertions(+), 12 deletions(-)
