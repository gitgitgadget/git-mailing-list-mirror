Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80028F92E
	for <git@vger.kernel.org>; Fri,  9 May 2025 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789221; cv=none; b=lucvs9Jn8Zt1IhQMm2rAG+18oyPmY+DPUwnJp2PErVNa1qVxOI/cK/vMDpbH/IA/GbPW16xO1j4JvjkrDrNGtrMVLlC4RN+biDkFcYcMxAfU8VLbw3Jk3OmXk02+jnQCIFDy5A98b8pUb1HSDQoYB0r8EbnbPXsUrc3C9uO5M+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789221; c=relaxed/simple;
	bh=mwbm5x7uIEIruIAu5gFLJRoYHm0qXd7bjD6TQdKuaa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ll5FBZITrtgOi7s0QU8twOoLKEXLMnxm/V1MV7Q396z2BHaZ0R1JT3BF/Q38B8uAow4hw478jTGDsJPyERATw/KiZdrnRQh/aLsZWbBsxx9a4MxYqx8BGapRkRXo34Nqw+0lDp4i5QoCtdTOOJXbKz3a6s5Nsz2nVPBKhXv468A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BxTlil01; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8nSuBTQq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BxTlil01; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8nSuBTQq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BxTlil01";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8nSuBTQq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BxTlil01";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8nSuBTQq"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F13D1F456;
	Fri,  9 May 2025 11:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746789217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mPf+j7u+97QFredtAa0Uq0fFk+ziw5sRCy/pHtSqjwg=;
	b=BxTlil01kz1jK+XnU+C/+f/AYUczoWvw51vr14tBU+cwAR04RvRTCGrcDR5YeMZlERU+wa
	z2rDp4LOPliIt6Yr2JPVgX+M7BDyJ7w9Bn0AjTUCI6ltwybGUmaAusLDMoVCfjIKIS3coE
	BY0ym6/OMEtzYESJsA+aN2VpQPvJcFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746789217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mPf+j7u+97QFredtAa0Uq0fFk+ziw5sRCy/pHtSqjwg=;
	b=8nSuBTQqsc3R0TznXn7cjFil2iHZ4+izJB0WapBm4eEP6n2VZLH2PELm4s8AWbIKN6Wpcf
	bLO72FWdReTAS7AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746789217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mPf+j7u+97QFredtAa0Uq0fFk+ziw5sRCy/pHtSqjwg=;
	b=BxTlil01kz1jK+XnU+C/+f/AYUczoWvw51vr14tBU+cwAR04RvRTCGrcDR5YeMZlERU+wa
	z2rDp4LOPliIt6Yr2JPVgX+M7BDyJ7w9Bn0AjTUCI6ltwybGUmaAusLDMoVCfjIKIS3coE
	BY0ym6/OMEtzYESJsA+aN2VpQPvJcFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746789217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mPf+j7u+97QFredtAa0Uq0fFk+ziw5sRCy/pHtSqjwg=;
	b=8nSuBTQqsc3R0TznXn7cjFil2iHZ4+izJB0WapBm4eEP6n2VZLH2PELm4s8AWbIKN6Wpcf
	bLO72FWdReTAS7AA==
Date: Fri, 9 May 2025 13:13:36 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Akash S <akashs@commvault.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Adithya Urugudige <aurugudige@commvault.com>,
	Abhishek Dalmia <adalmia@commvault.com>
Subject: Re: Incremental Backup of repositories using Git
Message-ID: <aB3jYNAJAbKjSWAS@kitsune.suse.cz>
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
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
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

On Mon, May 05, 2025 at 02:35:43PM +0000, Akash S wrote:
> Hi,
> 
> Currently we are backing up repositories using the "git clone -bare" command and save it to disk. If we want to restore, we just run git push -mirror from the repo that was saved during the backup.
> 
> Currently we are running full backups (run git clone -bare) everyday, which is taking a lot of disk space and time.
> 
> Are there any possible ways to backup only the incremental changes of a repository? And somehow construct the whole repository when we want to do a restore from the incremental backups?

Hello,

first, to make it easier to update the backup the clone should be done
with --bare --mirror.

If your clone ends up having multiple packs and loose objects you
can reduce its size with

git --git-dir=/path/to/clone repack -adk

This should give you a repository with a single pack and no loose
objects.

The -k (or --cruft) option is required, using only -ad seems to corrupt
repositories quite reliably.

To speed up the clone next time around you can make a copy of the
previous backup and fetch from the remote repository but because
there is no safe way I am aware of to eliminate no longer referenced
objects you will accumulate cruft this way.

This is now a complete backup, and should be made readonly to not get
corrupted with further operations.

The inrementeal backups are somewhat speculative, I have not tested this
at all.

You can create a shared clone of the full backup, update the origin URL
of the shared clone to the remote repository to backup, and do a fetch
-p (which now should do the right thing because the initial clone was
set up as mirror).

To repack you need to use the --local option in addition.

With this you should have a valid repository for each backup with the
incremental backups sharing most objects with the full backup.

These can be inspected with git commands, exported over gitweb, or
whatever.

Thanks

Michal
