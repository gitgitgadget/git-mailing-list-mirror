Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BA81DE3B1
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485305; cv=none; b=t8uL8W36nuo2hW0chOQVuq5BtMKBmmRfkeQfSfvR8+ErRTPpTiKvaVG+5gyFE/dKNE2O3+8JdsfHcl4LURIc13k4BVKKIcYtCv2YanMy1FE8D2tJMtBzNpAH8Ob6QUzTH+Wseub6NDpVGi1yMr5R7O8Ons8mmogDtj8xBRybC40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485305; c=relaxed/simple;
	bh=Zx+OKC1NnDdiVLtlUYo9qR3TOxB7bxCtsrAK0SxF2js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YOc+5RbLh8bJHxpl+fi5tG4cjJ+Ehzs3AF8riorC0pIaN0bUg61hBHgLnx3jlu1sarHuc4ngmDbm1Mobf3Qx4XE+84ZuODERL/rfsM1DlgyzaC8BxsKSGzEHlEnN72Ooj/UmVGkzGwJHSt75KfSUWwSUu2zFuBhox76jkSXNV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rkX3oGPP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AXvKX8Ig; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rkX3oGPP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AXvKX8Ig; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rkX3oGPP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AXvKX8Ig";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rkX3oGPP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AXvKX8Ig"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B1651F793;
	Thu, 20 Mar 2025 15:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742485302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WhpXixu0Cqs1BnDx5iYBCSimUh4n2C/ORlUqC2LZCvo=;
	b=rkX3oGPPpQ/KmgM5cnyOTwoH4BpH2NtxWFNo3gSNK3oUk+Ksl3OyxBmvNSfY3wqs/orBeP
	Afz4dQ7cVgO6qBveTZvHPIgJECiDoFSd9hGCYCJuufoz87Fnxq9zBmxohFIMVwg9gml5N2
	W+i9ryhCbVvMUkTXDKxGcZjv9NEFPmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742485302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WhpXixu0Cqs1BnDx5iYBCSimUh4n2C/ORlUqC2LZCvo=;
	b=AXvKX8IgyYt30bhJ0RGzAmvB+sb9uXm/angcQbAQoKxfiYOrEykxy2AybxdVzLJzhQNt3j
	2OWkZMAqsokOJUAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742485302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WhpXixu0Cqs1BnDx5iYBCSimUh4n2C/ORlUqC2LZCvo=;
	b=rkX3oGPPpQ/KmgM5cnyOTwoH4BpH2NtxWFNo3gSNK3oUk+Ksl3OyxBmvNSfY3wqs/orBeP
	Afz4dQ7cVgO6qBveTZvHPIgJECiDoFSd9hGCYCJuufoz87Fnxq9zBmxohFIMVwg9gml5N2
	W+i9ryhCbVvMUkTXDKxGcZjv9NEFPmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742485302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WhpXixu0Cqs1BnDx5iYBCSimUh4n2C/ORlUqC2LZCvo=;
	b=AXvKX8IgyYt30bhJ0RGzAmvB+sb9uXm/angcQbAQoKxfiYOrEykxy2AybxdVzLJzhQNt3j
	2OWkZMAqsokOJUAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 082B213757;
	Thu, 20 Mar 2025 15:41:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uY3RADY33GcueAAAD6G6ig
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
Subject: [PATCH 0/2] gitk: Support of SHA256 repos
Date: Thu, 20 Mar 2025 16:41:32 +0100
Message-ID: <20250320154136.23262-1-tiwai@suse.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
	FREEMAIL_CC(0.00)[gmail.com,kdbg.org,illinois.edu,gmx.de,yahoo.com,cms-labs.org,ozlabs.org];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de,yahoo.com]
X-Spam-Score: -1.30
X-Spam-Flag: NO

Hi,

I recently stumbled on the problem of gitk with sha256 repo (while
testing the new openSUSE package git workflow that enforces SHA256);
gitk aborts immediately with a message "Can't parse git log output:
{commit xxx..}".

After skimming over the net, I found the patch [*] posted in 4 years
ago to add the support for sha256, but nothing happened since then,
unfortunately.

So here is the revived patch for gitk to add sha256 support, with
cleanups and corrections, in addition to the enhancement patch for the
missing auto-select length config for sha256.

Only lightly tested on a few sha256 repos.


Takashi

[*] https://patchwork.kernel.org/project/git/patch/pull.979.git.1623687519832.gitgitgadget@gmail.com

===

Rostislav Krasny (1):
  gitk: Add a basic support of SHA256 repositories into Gitk

Takashi Iwai (1):
  gitk: Add auto-select length preference for SHA256

 gitk-git/gitk | 96 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 71 insertions(+), 25 deletions(-)

-- 
2.49.0

