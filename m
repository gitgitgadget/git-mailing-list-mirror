Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507DE25CC62
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509457; cv=none; b=W205GlvJP+hw59yfFPb/zlsBnyAgd9DYViN7vmjSaba58Aqz/jvCtv4y1MEjGkBZvOFCVCfQnLs7zLyYq7pDvn4sw8DdYu+/fGv+t1KSVqIsRvARwk9dE75sxrp+CBVMR52Lo2pC94AUEh8L5deoptU91U++cVU65EJ8QUmTzK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509457; c=relaxed/simple;
	bh=arKP/77c0XHsyapZPnPrppypGw94qqWoG2tZI5YpbwQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwX6LGkr6RmxPzN4tGgMMfPhhoAtiqZUxirj1Tyx50rI8s14rQqH2M+pwD8HyDud0lGs4iQp1OuK73BFO0UqSTs40upSTSrY32wKj4J4OUtrYvtGVxE7Jt3YAz9pb5MKEMZozv9NtFHXVxIxkYb31iD27ufmaaglBpPqeUEfXls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q8M+iBhn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oQO+vm8j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FziyTP7T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xAGrM6V6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q8M+iBhn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oQO+vm8j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FziyTP7T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xAGrM6V6"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5FDC91F785;
	Mon, 18 Aug 2025 09:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755509453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4VDFN2hAU/oQa9trpF6CFlzrmeLUq80ySc9K3YxBaaM=;
	b=q8M+iBhnNCWwjy3AlFdSsgZLEGVIJaFzyzTkao6mc9SEmIL5FOaqPsvrVROAhayla8Vx3t
	xwN8UiDcrnO7+mn+3LHWGXh9FK7ZfQEZ2n2j4/xa9+pryQw5UlV+s5QqYPwVfF91VEZn59
	YBdvAOxDV9qeOfvDBBrno7TQoeDrgSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755509453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4VDFN2hAU/oQa9trpF6CFlzrmeLUq80ySc9K3YxBaaM=;
	b=oQO+vm8jf1VLCk1CYpmKWDk6+GFz866LyKcNc3rnFil3MSrykhMlfnvEE5X1M9e7DsFbVT
	rtYzLdgxUqRGDBCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FziyTP7T;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xAGrM6V6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755509452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4VDFN2hAU/oQa9trpF6CFlzrmeLUq80ySc9K3YxBaaM=;
	b=FziyTP7TQtyd/ig7eb1hTyI3AxkMeypBdSt9LiKE2hG3/ifE07tWoKX5xckdSA1uPCQMcd
	t9Siu53FO15yNAivcIArm1frkBUnWgFj+Y0jOufaV0xn95JQXUfBj8BkSeqQwwGOHu5oYD
	jnZ6HREqlFx6nyM7PBWpWCqM4+m81vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755509452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4VDFN2hAU/oQa9trpF6CFlzrmeLUq80ySc9K3YxBaaM=;
	b=xAGrM6V6mAYd1UIXCdiavtxXJmE6oPffFFUgw9i1qCE78/mHHCCma4JQVmu6szob7FEZa4
	EdqYESnQGukK+1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5301F13A55;
	Mon, 18 Aug 2025 09:30:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vgbcE8zyomhUOgAAD6G6ig
	(envelope-from <mls@suse.de>); Mon, 18 Aug 2025 09:30:52 +0000
Date: Mon, 18 Aug 2025 11:30:51 +0200
From: Michael Schroeder <mls@suse.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	gitster@pobox.com
Subject: Re: [PATCH] submodule: truncate the oid when fetchig commits
Message-ID: <aKLyy8nwGQCT-jvB@suse.de>
References: <aJ37eHEGMw6RgmZC@suse.de>
 <aJ5gOPQ9oologqj-@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ5gOPQ9oologqj-@fruit.crustytoothpaste.net>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5FDC91F785
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On Thu, Aug 14, 2025 at 10:16:24PM +0000, brian m. carlson wrote:
> On 2025-08-14 at 15:06:32, Michael Schroeder wrote:
> > If a submodule uses a different hash algorithm than used in
> > the main repository, the recorded submodule commit is padded
> > with zeros. This is usually not a problem as the default is to
> > do submodule clones non-shallow and the commit can be found
> > in the local objects.
> 
> This should not even work at all.  It may currently behave as you
> suggest when the main repository is SHA-256 and the submodule is SHA-1,
> but it will corrupt the data if the submodule is SHA-256 and the main
> repository is SHA-1, since then the data will be truncated.

But it works, and I'm pretty sure people already use it. If you
have a sha1 main repo and a sha256 submodule, git will truncate
the commit when recording the gitlink. The checkout done by
git submodule update will work as it does the normal prefix matching.

If you have a sha256 main repo and a sha submodule, the recorded
commit is padded with zero. The checkout will also work as git
ignores the extra data since commit 52fca06db2 (object-names: support
input of oids in any supported hash, 2023-10-01).

What doesn't work is if a shallow clone is done for the submodule.
In that case the commit is not reachable and git tries a direct
fetch. This fetch can be made to work if the commit was padded with
zeros. If the commit was truncated, we would probably need some
protocol extension to make the server do a prefix match for a
"want" request.

> The proper way for this to work is that the SHA-1 version of the
> repository stores submodules in their SHA-1 states and the SHA-256
> version of the repository stores submodules in their SHA-256 states.

You mean by using "compatObjectFormat"? I couldn't make that work,
but maybe I missed something. Anyway, I think this also will not
work for shallow clones.

Cheers,
  Michael.

-- 
Michael Schroeder          SUSE Software Solutions Germany GmbH
mls@suse.de               GF: Ivo Totev HRB 36809, AG Nuernberg
main(_){while(_=~getchar())putchar(~_-1/(~(_|32)/13*2-11)*13);}
