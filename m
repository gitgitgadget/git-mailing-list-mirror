Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA58114D430
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908973; cv=none; b=uGSz3lGfaoqjw8xGvS5OdY3K1iw9ka1chofF4dvYnxE2pS75JdtKuWFY4OnjSMN6o0+ywFhUINokmHOk+ny3dHm3ZIVhzbzXUdPtPVI8DWburR8ImdQWHoiSVOJtf/DgBsBvVhOKh06lSthh4wVVgHI9Gn6vVXte0GGSKdYUw28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908973; c=relaxed/simple;
	bh=jcnbWUrB4AM/5vAGRQN3kZrNsC9J3liRbeVnmGuedDs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KDwnJAgsodw+FSYH7phzS/3AeAXjt54STGyMtwAQjatJDpaGsz9eZ09ZWvPKAadg8tNy5MjmMB1LHgzg9bl3/6mb7Aqp4cmh929fjrURfkGz3MZWY2i6i/NWSdIgiX4metkuVx3FizlibjHFUaSsKozKyT613L5YCT/X5EhefNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wYt3UEfq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iKJG7+Y5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wYt3UEfq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iKJG7+Y5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wYt3UEfq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iKJG7+Y5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wYt3UEfq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iKJG7+Y5"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8ACDD2118F
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 19:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732908968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=aKsykHn7D+w5RXOqFXfwesaa3Yzc7zFVuJOoz4ONSkU=;
	b=wYt3UEfq6OPGV/58mEPzp2376BQTCMW88Gtcou/K2DBICwuZsBUAUnekOOjmYJtKuHCmrK
	oZD+QEXuB3YFIuLCYeIsu8KF+TFIkt3eFzoaInyFeGJQ/NJan6s+paCdH/09PWq6eqGdkZ
	nDDR0hF+oujbjJ76t3s68VvyCCko3RY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732908968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=aKsykHn7D+w5RXOqFXfwesaa3Yzc7zFVuJOoz4ONSkU=;
	b=iKJG7+Y5dck6puG9Bq6Ed+JtqmcJWYvubpno1y0EG9YUrk7G92mlDifk2gKvvMLyFPGnJ5
	KvgL5A+KFW3pp1CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732908968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=aKsykHn7D+w5RXOqFXfwesaa3Yzc7zFVuJOoz4ONSkU=;
	b=wYt3UEfq6OPGV/58mEPzp2376BQTCMW88Gtcou/K2DBICwuZsBUAUnekOOjmYJtKuHCmrK
	oZD+QEXuB3YFIuLCYeIsu8KF+TFIkt3eFzoaInyFeGJQ/NJan6s+paCdH/09PWq6eqGdkZ
	nDDR0hF+oujbjJ76t3s68VvyCCko3RY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732908968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=aKsykHn7D+w5RXOqFXfwesaa3Yzc7zFVuJOoz4ONSkU=;
	b=iKJG7+Y5dck6puG9Bq6Ed+JtqmcJWYvubpno1y0EG9YUrk7G92mlDifk2gKvvMLyFPGnJ5
	KvgL5A+KFW3pp1CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FAC5137CF
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 19:36:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Rq1KDagXSmc6EAAAD6G6ig
	(envelope-from <krisman@suse.de>)
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 19:36:08 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: git@vger.kernel.org
Subject: [BUG] Inconsistent output of git-show
Date: Fri, 29 Nov 2024 14:36:07 -0500
Message-ID: <87jzclal3s.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[git@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

1.  git show --oneline --no-patch
7af08b57bcb9 (HEAD, origin/master, linus/master) Merge tag 'trace-v6.13-2' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace

2.  git show --oneline --no-patch | cat
7af08b57bcb9 Merge tag 'trace-v6.13-2' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace

(--oneline doesn't matter here. Just making the output concise)

The branch information in parenthesis vanished just because of the shell
redirection.  That makes quickly writing shell one-liners very annoying.
Sure, I can go figure a proper git invocation to get me that
information. But we're all hardwired to use basic shell commands, and
sometimes all I need is a quick grep and not learn a program-specific
way of filtering.

So, could we make the output consistent regardless of redirection,
i.e. What You See Is What You Pipe?  Whoever requires a specific format
for a script should be the ones using --format.

I've got v2.47.0 and I admit to not have tested later versions.

Thanks,

-- 
Gabriel Krisman Bertazi
