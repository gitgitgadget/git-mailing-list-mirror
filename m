Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF36F30E84D
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763369593; cv=none; b=kEfGMvrdrbj5jbjG52WAvQ7UjQ5VsGPfTiVbyBI79+PXUKnGGntGNv6rbppUhkbEr2XPlPAGCfMfLlR3gJSgKrszwNOCbo0eGWL6eLOeMSof3fglNi0kikQ9DLPOCofqHSPhl8J3gdrhKZOoPeumYZxxNfaMmBo5F4bDxthMgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763369593; c=relaxed/simple;
	bh=wt0/YGYiPkFbWrlPqwGvIcWq7WlolIrI1J13uvGyWy4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TnDh6oK4HxmHjHPFMZcgNEbO2Dd2/5H+cXBO/D2WhqGUO2sSJhqUzIlr0Vwz80bUE9sQ7bZP28vGkBclvcMbXCLEEOQS3ZESOXZ/6sd/NYxgSu5YusuK7v0BPeMh8QfA3UfRUej4wN0uJTu/FwUqToWeV5lDXJVzl0l3Lhn2zzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=egBMrcxu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jGCnFh5r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="egBMrcxu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jGCnFh5r"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D922F1F445;
	Mon, 17 Nov 2025 08:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763369588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wt0/YGYiPkFbWrlPqwGvIcWq7WlolIrI1J13uvGyWy4=;
	b=egBMrcxuPPxxheh1Aswvt20IuPtdYZXBUIrQ0havVyoNYD8JizOvCczmg5cmY04/rrfW3A
	EsJDsBKS6LrQG/CQ/ycGSjyCvPEUGoJ+lO/r9lVF0oK3FJ4nmI6qoKZG2Jf2MPzgCv2LWX
	m4jGHP7LZF29sU/P7BdkVqPDXm/9FQc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763369587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wt0/YGYiPkFbWrlPqwGvIcWq7WlolIrI1J13uvGyWy4=;
	b=jGCnFh5r6gWjJveLZOA4fq/rSCZzT4wpLWKooL5w3kzStor8Y321GTw3ft143TCtTa/yec
	zkVIsKazCXOe77B1spwNtACUyC9zWQcIt1ki8W5uwSoViPlNW41NXF9ElXrb+9K2dIXC+f
	cJEEfRmeQm4PIsIoJG6GpT7ZUBly5wY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B409B3EA61;
	Mon, 17 Nov 2025 08:53:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mUzaKnPiGml3bgAAD6G6ig
	(envelope-from <mwilck@suse.com>); Mon, 17 Nov 2025 08:53:07 +0000
Message-ID: <8263691a45d0a425d24a796c547315932e8c4001.camel@suse.com>
Subject: Re: [PATCH v2 1/2] object-file: disallow adding submodules of
 different hash algo
From: Martin Wilck <mwilck@suse.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, Adrian
 Schroeter <adrian@suse.com>
Date: Mon, 17 Nov 2025 09:53:07 +0100
In-Reply-To: <20251115005818.2271557-1-sandals@crustytoothpaste.net>
References: <20251112235434.1499699-1-sandals@crustytoothpaste.net>
	 <20251115005818.2271557-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Sat, 2025-11-15 at 00:58 +0000, brian m. carlson wrote:
>=20
> Note that we cannot check this in git fsck because the malformed
> submodule is stored in the tree as an object ID which is either
> truncated (when a SHA-256 submodule is added to a SHA-1 repository)
> or
> padded with zeros (when a SHA-1 submodule is added to a SHA-256
> repository).=C2=A0 We cannot detect even the latter case because someone
> could have an actual submodule that actually ends in 24 zeros, which
> would be a false positive.

Perhaps a warning could still be printed in this case? After all, the
probability for a false positive is about 1:16 million.

Thanks
Martin
