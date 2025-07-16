Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5C127146F
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651160; cv=none; b=V4UrK7lZKwYCif+g4oWbe6c/agOsLnTspAe4TuubBpt7utkToLwN/O1LZ53epwfw3tzWmSCszf36QU1J2ye/lFdCLOP5LOJiLSybBzBBgykyMjGwTI83V0FVk1JsjOolIUkVnoaviaV0/0Keligno8xf/GDDauaWRC3Sk5RNRjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651160; c=relaxed/simple;
	bh=Nmeb6clYNiP3YN/yAXTGIWb1r24rQloQHPkPDjUUAAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZvFRbXM+IjeQ/Kg1gR5wNrKZOInu4ptVvineHRgqpIquw5yP/XkX137TyhgJwts45YBJPNSjuLBVL/J3aLKw3FWqdz4tJZ/cnb7SzKEgVBtpjpGaZ5/RoAwYmJsmyXRTaglG6WPsUIn12/L+9bqU35yFYQk/msDAnnMD61yyKLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lQmHUM4g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VSIf74FZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lQmHUM4g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VSIf74FZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lQmHUM4g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VSIf74FZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lQmHUM4g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VSIf74FZ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08EE1211FD;
	Wed, 16 Jul 2025 07:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752651150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=flw33y7tiT7u27vfZKAsIWn/JTNeLOL8dNOlhjKss3M=;
	b=lQmHUM4gyw0rBau9Oks9O4TmcXnb0/xGu0iyBmN0+2Omf+7FyY6OC0J6BWvMlGKr6L3Qdo
	QTOHbLj6zftZ24uI3XC/eiC/5FQZqtd6Fd7pe8ggNX50vQVK3Ld5u9oJI+7j+r0vqFSwbw
	tPnCenSN4PXRKq7AKQSK0QUtDe9SfGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752651150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=flw33y7tiT7u27vfZKAsIWn/JTNeLOL8dNOlhjKss3M=;
	b=VSIf74FZYCyGcU7uiBVxH2Ga6DZ83a7n0qraYpTpHhLOOvnZyzF0E+73uqVxq3r95zMNlu
	IzwqszSYW+OjPzDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752651150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=flw33y7tiT7u27vfZKAsIWn/JTNeLOL8dNOlhjKss3M=;
	b=lQmHUM4gyw0rBau9Oks9O4TmcXnb0/xGu0iyBmN0+2Omf+7FyY6OC0J6BWvMlGKr6L3Qdo
	QTOHbLj6zftZ24uI3XC/eiC/5FQZqtd6Fd7pe8ggNX50vQVK3Ld5u9oJI+7j+r0vqFSwbw
	tPnCenSN4PXRKq7AKQSK0QUtDe9SfGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752651150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=flw33y7tiT7u27vfZKAsIWn/JTNeLOL8dNOlhjKss3M=;
	b=VSIf74FZYCyGcU7uiBVxH2Ga6DZ83a7n0qraYpTpHhLOOvnZyzF0E+73uqVxq3r95zMNlu
	IzwqszSYW+OjPzDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D435F13306;
	Wed, 16 Jul 2025 07:32:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gJiIMo1Vd2iZAQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 16 Jul 2025 07:32:29 +0000
From: Takashi Iwai <tiwai@suse.de>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 0/2] git-gui: Add support of SHA256 repo
Date: Wed, 16 Jul 2025 09:32:23 +0200
Message-ID: <20250716073227.11486-1-tiwai@suse.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.08 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	BAYES_HAM(-0.28)[74.23%];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -0.08

Here is the v3 patch for git-gui to support SHA256 repos.
I put a preliminary patch to clean up $null_sha1 in addition to the
correction / update of v2 patch.


Takashi

===

Takashi Iwai (2):
  git-gui: Replace null_sha1 with nullid
  git-gui: Add support of SHA256 repo

 git-gui/git-gui.sh                   | 22 ++++++++++++++++------
 git-gui/lib/blame.tcl                | 12 ++++++++----
 git-gui/lib/checkout_op.tcl          |  4 ++--
 git-gui/lib/choose_repository.tcl    |  7 ++++---
 git-gui/lib/commit.tcl               |  3 ++-
 git-gui/lib/remote_branch_delete.tcl |  4 +++-
 6 files changed, 35 insertions(+), 17 deletions(-)

-- 
2.50.1

