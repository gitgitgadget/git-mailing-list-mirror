Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA422874E0
	for <git@vger.kernel.org>; Thu,  8 May 2025 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746730072; cv=none; b=oxeI1hImUKqnDQbAU8sTrVeG4CkQtidlEj6zPHc4ZLG5RrFoTI1MhpXdC1euX1Hd9Snvr2865fg/ad2XGiopHAmVraGW0n8C9nDKbMdHAgu7rKJxd0qaGC1LzP4euV4DhirQ6symEBPmi85OiQicj85Z+SWVrXxWDsC0FGWfF9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746730072; c=relaxed/simple;
	bh=H8qlJrYOD2rxF5avx+jZmDp1oc+J0SDyDY12WCbpmQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyGxEnOjXN8Ktsdu4oW9GlhWFdS8vbB9qafD0Y0vzFyBLasCn7U+k3ykDxXm+dyyIW/JRrs3bSOXfcDsjijH2Rrywi66zxLnhe/R93PyCbM0qW0V1ZPf7iR3+/jYFHe7kTIWp9E/bwm6JEXfUcuEGYNgRuuPqSAsL18RH6N86qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YwjQReze; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=npTbfbDF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YwjQReze; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=npTbfbDF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YwjQReze";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="npTbfbDF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YwjQReze";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="npTbfbDF"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D8B5A210EF;
	Thu,  8 May 2025 18:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746730068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eDTGv6XeKTy4R2A/YZoYgtkUPH6vO547cWDllquqa5U=;
	b=YwjQRezeiQYTA2jmxdE6A80gu7yhMwhRQVC+R7hDRanyj8ODDrRGC+WMDIHz4UOqQ6Xuwb
	nd4soLyA9qIz+thoGzPQkmnUvsTrXDtE3v/siuX4PvpxOA2Y6m1iBXhfV4wEYaA9TumoLu
	iCHZ5T/0zzqKSWoeG8jmV+jbOparDPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746730068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eDTGv6XeKTy4R2A/YZoYgtkUPH6vO547cWDllquqa5U=;
	b=npTbfbDFeg20fLXtNL8EvIVv5XP7Qsfd8bWr9gTIAB/tsIG+Tb4eCnHWGydL5sFrE1IomF
	6zdDIqIHlWroLaBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746730068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eDTGv6XeKTy4R2A/YZoYgtkUPH6vO547cWDllquqa5U=;
	b=YwjQRezeiQYTA2jmxdE6A80gu7yhMwhRQVC+R7hDRanyj8ODDrRGC+WMDIHz4UOqQ6Xuwb
	nd4soLyA9qIz+thoGzPQkmnUvsTrXDtE3v/siuX4PvpxOA2Y6m1iBXhfV4wEYaA9TumoLu
	iCHZ5T/0zzqKSWoeG8jmV+jbOparDPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746730068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eDTGv6XeKTy4R2A/YZoYgtkUPH6vO547cWDllquqa5U=;
	b=npTbfbDFeg20fLXtNL8EvIVv5XP7Qsfd8bWr9gTIAB/tsIG+Tb4eCnHWGydL5sFrE1IomF
	6zdDIqIHlWroLaBw==
Date: Thu, 8 May 2025 20:47:47 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Akash S <akashs@commvault.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Adithya Urugudige <aurugudige@commvault.com>,
	Abhishek Dalmia <adalmia@commvault.com>
Subject: Re: Incremental Backup of repositories using Git
Message-ID: <aBz8U35YX7UH-PTW@kitsune.suse.cz>
References: <PH7PR19MB70252D42F5D04FFC0331AB63C08E2@PH7PR19MB7025.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR19MB70252D42F5D04FFC0331AB63C08E2@PH7PR19MB7025.namprd19.prod.outlook.com>
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

Hello,

On Mon, May 05, 2025 at 02:35:43PM +0000, Akash S wrote:
> Hi,
> 
> Currently we are backing up repositories using the "git clone -bare" command and save it to disk. If we want to restore, we just run git push -mirror from the repo that was saved during the backup.
> 
> Currently we are running full backups (run git clone -bare) everyday, which is taking a lot of disk space and time.
> 
> Are there any possible ways to backup only the incremental changes of a repository? And somehow construct the whole repository when we want to do a restore from the incremental backups?

If you have one of those filesystems that support deduplication on
filesystem level you could make each snapshot as a full repository with
all objects unpacked, and the filesystem would deduplicate the objects
for you.

The downside is that you have no way to do multiple full backups this
way, and you would have to use something else for that (such as those
bundles, or plain archiving the repository as files in a tar archive or
such.

Thanks

Michal
