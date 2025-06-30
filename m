Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33003D69
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291140; cv=none; b=bpSBbSwuyzOq3ayWIuH9JZUSwoINk0kbnG1bpvE4LNT8SGMLYVbSqJ1xAilSNUS4ACHIw4SxptC6gSYRQgPeEGaT+/tJlGi6PWR0d3Jtxh1j7H5H9U0o6wTcNaUcWFXmR9wps7flGiaApOLjjjgTREDEL4CV5vdhx3X1amFlDno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291140; c=relaxed/simple;
	bh=RLbFzbfEHoUIg8VUcEAgbIalFKUwfQf1Wzlg49fzAR8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=esd7EvLDu/ekhs/iTSyXh7/rLWHUPLXTPoL+sYhsXDuObUF1wZKJffmnVpRvZmH+31I4zjDlK7aUnnvqfI6wsp3Jil8OpAzUCIGKO09H1SuxvBHdAhAnqllBUHiFHaj5WHBc5rDxkMRt1BpAK8W4X7TeLEEF49zbR+GkHgGThys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YA0GNO3r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZwpJICtL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YA0GNO3r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZwpJICtL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YA0GNO3r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZwpJICtL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YA0GNO3r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZwpJICtL"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC94B21165
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 13:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751291131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=RLbFzbfEHoUIg8VUcEAgbIalFKUwfQf1Wzlg49fzAR8=;
	b=YA0GNO3rodhJayXjw3D+czjGpypf8ojOffOLtBP+EZgVIeepn+WN1G7sC7GF9sF/4XwE83
	jetGWny1HFgO11Vs6uBVhcnQ3Ztg2Om+bFYpRQWlk8MQukUbQXuB5cKsC8cNLwLdLIm01f
	S2UfWBMtTgRuHAlpUjTTe7x1hC27tVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751291131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=RLbFzbfEHoUIg8VUcEAgbIalFKUwfQf1Wzlg49fzAR8=;
	b=ZwpJICtLou4GBhgLbI9A3dRXm9FpZAj/dQe6LNYALyCBjLN85f6Us5wlXu09Oh4EDIhylA
	VFPu1U3OCsUu74Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751291131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=RLbFzbfEHoUIg8VUcEAgbIalFKUwfQf1Wzlg49fzAR8=;
	b=YA0GNO3rodhJayXjw3D+czjGpypf8ojOffOLtBP+EZgVIeepn+WN1G7sC7GF9sF/4XwE83
	jetGWny1HFgO11Vs6uBVhcnQ3Ztg2Om+bFYpRQWlk8MQukUbQXuB5cKsC8cNLwLdLIm01f
	S2UfWBMtTgRuHAlpUjTTe7x1hC27tVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751291131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=RLbFzbfEHoUIg8VUcEAgbIalFKUwfQf1Wzlg49fzAR8=;
	b=ZwpJICtLou4GBhgLbI9A3dRXm9FpZAj/dQe6LNYALyCBjLN85f6Us5wlXu09Oh4EDIhylA
	VFPu1U3OCsUu74Dg==
Date: Mon, 30 Jun 2025 15:45:30 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: git@vger.kernel.org
Subject: Failing to push to a repository erases authentication helper
 credentials
Message-ID: <aGKU-o9eXB1VHuN9@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Level: 


Hello,

I was trying out AGit https://docs.gitea.com/usage/agit with oauth
helper https://github.com/hickford/git-credential-oauth encountering
this bug https://github.com/go-gitea/gitea/issues/34583

When doing so the oauth helper asked for new authentication, then for
some reason I was asked for authentication by some other helper.

After that pushing to repository to which I have permissions asked for
authentication again.

This hints that any failed git operation erases helper credentials.

That does not sound like a desirable behavior.

Could the previous credentials be preserved?

Thanks

Michal
