Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2929A314B7C
	for <git@vger.kernel.org>; Sat, 27 Dec 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766843829; cv=none; b=coP0C5kdrf/pcYXl4bEIBTv13Gl1EMAJmBgPPi4a4vrhOVWJyphWh6XZ77zsm4tn5TIsnLtiJGrOPa3E5I91NxtHoWN6SUvVFejRSLPZYyHpGHyoP0H/cZf4DCR+HNnTI8dT7bfdEnP7gdKL8K4G26UX2xtZ0nhDfHP0coKjpWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766843829; c=relaxed/simple;
	bh=m76NT3L/2C6Nr7wwQcUc74gbVKjnkLP3Y32c2YSG+5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwrycjJ2skfRFie/LDGT6y6Z8WE559NB5AgGaQnTYyvKxNsbgQ8BF5Tsj3KdP/70lu5pr52ediV8P9mL2TZQ9UCiguE5wl0UiCY0dQX3E+2WO+f6bAADjLY4vnCsVP2bu4RVeZpa5fDFXa7DuJZe6cgSJE7/Z7mYb1+ZAOQvIn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iqsSLYpu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qW9nDfvw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iqsSLYpu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qW9nDfvw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iqsSLYpu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qW9nDfvw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iqsSLYpu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qW9nDfvw"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 140235BCC1;
	Sat, 27 Dec 2025 13:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1766843823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLVUWCGamuN9qHUuxHds8zAum8PZvrDQ/C7V0eUlkS0=;
	b=iqsSLYpuzsP58ihc/vJuahObovPgaqyOZLEwTrW2Yu5App1XzVxO7nGju0lJKZzb6ufHXj
	CWYY+B95BZ8cruElwaGoQ3GfG2N5cjSnQy1sAFO87j7+Ayd7TNd3WpSNs1yZfAYyHrOdB9
	SeBUnAalynhGAPxbqv3cPhR2tnrilhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1766843823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLVUWCGamuN9qHUuxHds8zAum8PZvrDQ/C7V0eUlkS0=;
	b=qW9nDfvwbmiX0JhtbyYiMn6UTrOypPbVKpYaZpeSgUE9+yRkUq5PxbnvNkWuQAS+zK1SC9
	YYU7Jgqf34yplMCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1766843823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLVUWCGamuN9qHUuxHds8zAum8PZvrDQ/C7V0eUlkS0=;
	b=iqsSLYpuzsP58ihc/vJuahObovPgaqyOZLEwTrW2Yu5App1XzVxO7nGju0lJKZzb6ufHXj
	CWYY+B95BZ8cruElwaGoQ3GfG2N5cjSnQy1sAFO87j7+Ayd7TNd3WpSNs1yZfAYyHrOdB9
	SeBUnAalynhGAPxbqv3cPhR2tnrilhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1766843823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLVUWCGamuN9qHUuxHds8zAum8PZvrDQ/C7V0eUlkS0=;
	b=qW9nDfvwbmiX0JhtbyYiMn6UTrOypPbVKpYaZpeSgUE9+yRkUq5PxbnvNkWuQAS+zK1SC9
	YYU7Jgqf34yplMCA==
Date: Sat, 27 Dec 2025 14:56:57 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Hadmut Danisch <hadmut@danisch.de>
Cc: git@vger.kernel.org
Subject: Re: Git destroys u+s and g+s directory modes
Message-ID: <aU_lqe2Z47STv68O@kitsune.suse.cz>
References: <eb36360d-f539-4f77-b175-57330ef05eac@danisch.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb36360d-f539-4f77-b175-57330ef05eac@danisch.de>
X-Spamd-Result: default: False [-4.27 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.17)[-0.863];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[kitsune.suse.cz:helo,kitsune.suse.cz:mid];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.27

On Sat, Dec 27, 2025 at 03:37:51AM +0100, Hadmut Danisch wrote:
> Hi,
> 
> (please respond to my e-mail as well, not just to the list, I'm not
> subscribed),
> 
> 
> I do have a problem with git 2.43.0 (ubuntu server 24.04.3) and directory
> modes:
> 
> 
> I do need my git repo (owned by me) to be readable by a system user (running
> a rootless podman container).

When you want it to be readable you do not need any special permission
bits.

You can set the directories and files to be readable by group, and
ensure the container user is part of the group.

You are porbably looking for core.sharedRepository configuration option.

If git is particularly unhappy accessing a readonly repository and the
container is short-lived you can add an overlay over the repository when
creating the container.

HTH

Michal
