Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B712210FB
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710083744; cv=none; b=Bm3N6qioYa8m3U98kJ+NcO9PGtuW6DxWG0Bp44MmGi7Wa2d9lnLiL0DFhFknDJKkON5VXewFLqKZ9UJ5m4cToeURpioi9Ni02S8SbHoCr3wRJ0oBU2Yo4WKp+8Exaa/mcan3f6mj0GhAp5YejSISB9LEJK4b9mni7uZL8gz7Uow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710083744; c=relaxed/simple;
	bh=uVE3NKWv6jLfwaMP0jlOuyYxAuYsSeR6fmpOK8uz35E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pDKhSSiFb/bkLN/IT0QY4Q0yXXkhr6vEJf+lVOa549kXwfw4GmvfNu5EnU8PBQJGnZ1BF79dUerjbZmOjePtKT/1/70BvR8r9JWSYGq7o2ncDnyx1jEefSma8dannveV4NXUo2HTC9rcKH/NxXAQor+okBmIxFrUcoq8Ue7QgTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xte5lbzD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LiMZjNxw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xte5lbzD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LiMZjNxw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xte5lbzD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LiMZjNxw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xte5lbzD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LiMZjNxw"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 88BC520DBB
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 15:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710083734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=uVE3NKWv6jLfwaMP0jlOuyYxAuYsSeR6fmpOK8uz35E=;
	b=Xte5lbzDB0sdEOPgsIh9oLqbdZr0J0qae0ls7hmX39ne1SQk5HoxrBbRUoNrxQbbyginII
	iln6DW8pR3a0PDpt0nT0j80tfjVvDikx1nAsgiJT79H9eodAM/PwkIP/u3zZJxFNbyZmcT
	FYwHHZlYZX/IJv8qVW5ZGpAyoNIsU3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710083734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=uVE3NKWv6jLfwaMP0jlOuyYxAuYsSeR6fmpOK8uz35E=;
	b=LiMZjNxw5eRd4eSgIXcf7n86BaKpB7jJdrJWTuw2aU86CRRH2nLp3iUi+/j6hdMmiAV9N3
	WK8PiGmEYVzY6qDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710083734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=uVE3NKWv6jLfwaMP0jlOuyYxAuYsSeR6fmpOK8uz35E=;
	b=Xte5lbzDB0sdEOPgsIh9oLqbdZr0J0qae0ls7hmX39ne1SQk5HoxrBbRUoNrxQbbyginII
	iln6DW8pR3a0PDpt0nT0j80tfjVvDikx1nAsgiJT79H9eodAM/PwkIP/u3zZJxFNbyZmcT
	FYwHHZlYZX/IJv8qVW5ZGpAyoNIsU3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710083734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=uVE3NKWv6jLfwaMP0jlOuyYxAuYsSeR6fmpOK8uz35E=;
	b=LiMZjNxw5eRd4eSgIXcf7n86BaKpB7jJdrJWTuw2aU86CRRH2nLp3iUi+/j6hdMmiAV9N3
	WK8PiGmEYVzY6qDw==
Date: Sun, 10 Mar 2024 16:15:33 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: git@vger.kernel.org
Subject: unintelligible error fatal: empty ident name (for <>) not allowed
Message-ID: <20240310151533.GF23839@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.82
X-Spamd-Result: default: False [0.82 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.999];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_SPAM_SHORT(2.25)[0.749];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.33)[75.83%]
X-Spam-Flag: NO

git version 2.44.0

git am -3
../linux-6.8~rc1/debian/patches/rk3588/dw-hdmi-rockchip-avoid-tmds-spam.patch
Applying: dw-hdmi-rockchip: avoid spamming 'use tmds mode' in dmesg
fatal: empty ident name (for <>) not allowed


What's wrong with that patch, specifically?

Can you tell?

I cannot, at all.

Already applied 70 other patches so it's not git configuration.

Thanks

Michal
