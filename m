Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD52290DB3
	for <git@vger.kernel.org>; Fri,  9 May 2025 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789735; cv=none; b=F1XjV8u6VTl+6gyZkzanmwVC94kA1S5R8t9OER+/ecYj5m5TKuh8AMaGx0gT+b1gV/JrsfcTd2uH6YwKyou8/6Pf6JDIL8RYl9t5mysMa6EaK80JoAmrQV6YD2WoniAd97nLu8uShdmQQGRCfAHXGrIov9zxAGiAeWK1IVDqPLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789735; c=relaxed/simple;
	bh=mV7P2BeMPWUsOjey9BbLSnRpZX0IXTSGdlJDh06k50k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Px3i8hVkfblK10rAuxZS2kx5oFOzwTYQHWZpX1Bb31JYsLNKKbra8Fvs5MUTzV7/9r3Sfvhe5iE6yvZawF9gO1MVA738EK2cW5kbp3xyZZu+7sX+sC/TKNZvwfuKf9/llwpPQqA1KEmN43Q/xc05sAWfWu1SyxepinVTEYsHymU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IvOUWfzI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zwjhKcY+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IvOUWfzI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zwjhKcY+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IvOUWfzI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zwjhKcY+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IvOUWfzI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zwjhKcY+"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C67D51F394;
	Fri,  9 May 2025 11:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746789731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNzKkREHAJ4Ul2GrzJXQ62hH3fs3KNiyuupyKB54HKQ=;
	b=IvOUWfzIE1m2BSkTHwsm5b36x8Zzr1eBbge6JNefe1MbxTXo6nq8YirFcgLIMXmseYxt9T
	pcmLyJAmQPOnvKQ4QEi5CAsP9EVgOVq0XNYGLhFGXnPshfy3cVw8Mp9aWMJpBEWNcOsQOV
	8NlUtjY4G5+VES5Uolhr+qngj/uhMBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746789731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNzKkREHAJ4Ul2GrzJXQ62hH3fs3KNiyuupyKB54HKQ=;
	b=zwjhKcY+H/Q1fG+VWTz+hmRr86PaKHd1DuAKAWs4Pa1m/VvYmhC6DuP3esowLyacjljiTJ
	j9SVrBlpFKMAv8AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746789731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNzKkREHAJ4Ul2GrzJXQ62hH3fs3KNiyuupyKB54HKQ=;
	b=IvOUWfzIE1m2BSkTHwsm5b36x8Zzr1eBbge6JNefe1MbxTXo6nq8YirFcgLIMXmseYxt9T
	pcmLyJAmQPOnvKQ4QEi5CAsP9EVgOVq0XNYGLhFGXnPshfy3cVw8Mp9aWMJpBEWNcOsQOV
	8NlUtjY4G5+VES5Uolhr+qngj/uhMBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746789731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNzKkREHAJ4Ul2GrzJXQ62hH3fs3KNiyuupyKB54HKQ=;
	b=zwjhKcY+H/Q1fG+VWTz+hmRr86PaKHd1DuAKAWs4Pa1m/VvYmhC6DuP3esowLyacjljiTJ
	j9SVrBlpFKMAv8AQ==
Date: Fri, 9 May 2025 13:22:10 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Akash S <akashs@commvault.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Adithya Urugudige <aurugudige@commvault.com>,
	Abhishek Dalmia <adalmia@commvault.com>
Subject: Re: Incremental Backup of repositories using Git
Message-ID: <aB3lYsiJQ5n7awXE@kitsune.suse.cz>
References: <PH7PR19MB70252D42F5D04FFC0331AB63C08E2@PH7PR19MB7025.namprd19.prod.outlook.com>
 <aB3jYNAJAbKjSWAS@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aB3jYNAJAbKjSWAS@kitsune.suse.cz>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Score: -4.30

On Fri, May 09, 2025 at 01:13:36PM +0200, Michal Suchánek wrote:
> On Mon, May 05, 2025 at 02:35:43PM +0000, Akash S wrote:
> > Hi,
> > 
> > Currently we are backing up repositories using the "git clone -bare" command and save it to disk. If we want to restore, we just run git push -mirror from the repo that was saved during the backup.
> > 
> > Currently we are running full backups (run git clone -bare) everyday, which is taking a lot of disk space and time.
> > 
> > Are there any possible ways to backup only the incremental changes of a repository? And somehow construct the whole repository when we want to do a restore from the incremental backups?
> 
> Hello,
> 
> first, to make it easier to update the backup the clone should be done
> with --bare --mirror.
> 
> If your clone ends up having multiple packs and loose objects you
> can reduce its size with
> 
> git --git-dir=/path/to/clone repack -adk
> 
> This should give you a repository with a single pack and no loose
> objects.
> 
> The -k (or --cruft) option is required, using only -ad seems to corrupt
> repositories quite reliably.
> 
> To speed up the clone next time around you can make a copy of the
> previous backup and fetch from the remote repository but because
> there is no safe way I am aware of to eliminate no longer referenced
> objects you will accumulate cruft this way.
> 
> This is now a complete backup, and should be made readonly to not get
> corrupted with further operations.
> 
> The inrementeal backups are somewhat speculative, I have not tested this
> at all.
> 
> You can create a shared clone of the full backup, update the origin URL

Also with the --mirror option, it's not transferred.

> of the shared clone to the remote repository to backup, and do a fetch
> -p (which now should do the right thing because the initial clone was
> set up as mirror).
> 
> To repack you need to use the --local option in addition.
> 
> With this you should have a valid repository for each backup with the
> incremental backups sharing most objects with the full backup.
> 
> These can be inspected with git commands, exported over gitweb, or
> whatever.
> 
> Thanks
> 
> Michal
> 
