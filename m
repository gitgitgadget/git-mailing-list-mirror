Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C522749EA
	for <git@vger.kernel.org>; Fri,  9 May 2025 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781726; cv=none; b=lOBREefBUHdCilaI1hm6RBQO95bPvnNSDSqDM25EV987uoTgazWwzPiaI/ygoNJM0FddzjqAkblsfbT4poDOakJDdcRhFKCNFEk9MenCcLUKtbASdCvbQe1I8/bYsdb6Uq6D1nyNOEsCVUrgjUpMpa2/Mvugq2BedFADiYMVrMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781726; c=relaxed/simple;
	bh=eSa6JRjQGgxch1BC3b70mcKO4inkSJH55Z+FbL2hMp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nifk/zVZ/SjTfucHkPTD2uFCikWtbgIcOjJ6npS4SO7A91P58uNP/+9l3M2UCJRXjXp12vdWgoMv2CymDEZyr/nabHwysw4h4m8EQqUvYB1+lthyHxQVCYR4dK6BRNBEMNPaOoqjFSw4qq6I9HCUDLMfat9gaEkHDAha7J5XXXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D5tRB9Ft; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2A6sId3J; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D5tRB9Ft; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2A6sId3J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D5tRB9Ft";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2A6sId3J";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D5tRB9Ft";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2A6sId3J"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C53DA21166;
	Fri,  9 May 2025 09:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746781722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wfdC1tlCV9DWTq5+/P5+vinukLnx4MeLFFel2wEFAE=;
	b=D5tRB9Ft/6v6RpZU7exGswDrgNIS9NHgTuckhgBcGbdfzXHb5BKuLgFppkWYYbP0m34LZM
	83UsK9XcGQiv3VTluwaPY+tuMmHpOT42/nOTuYvIsWMkyKOUhNKPHiyMmJkQpIo81Dji/1
	+FFiJat9HpaBqrmhsG6GPJ/pPDbwF58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746781722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wfdC1tlCV9DWTq5+/P5+vinukLnx4MeLFFel2wEFAE=;
	b=2A6sId3J7jH2o67fbiiq/Vv2OWsgiT26BHFGIrAWnE5Ixvse6thX1G7kNIViBUSoAusr2u
	/c44aHeP4ZKeDABw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746781722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wfdC1tlCV9DWTq5+/P5+vinukLnx4MeLFFel2wEFAE=;
	b=D5tRB9Ft/6v6RpZU7exGswDrgNIS9NHgTuckhgBcGbdfzXHb5BKuLgFppkWYYbP0m34LZM
	83UsK9XcGQiv3VTluwaPY+tuMmHpOT42/nOTuYvIsWMkyKOUhNKPHiyMmJkQpIo81Dji/1
	+FFiJat9HpaBqrmhsG6GPJ/pPDbwF58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746781722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wfdC1tlCV9DWTq5+/P5+vinukLnx4MeLFFel2wEFAE=;
	b=2A6sId3J7jH2o67fbiiq/Vv2OWsgiT26BHFGIrAWnE5Ixvse6thX1G7kNIViBUSoAusr2u
	/c44aHeP4ZKeDABw==
Date: Fri, 9 May 2025 11:08:41 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jeff King <peff@peff.net>
Cc: Akash S <akashs@commvault.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Adithya Urugudige <aurugudige@commvault.com>,
	Abhishek Dalmia <adalmia@commvault.com>
Subject: Re: Incremental Backup of repositories using Git
Message-ID: <aB3GGe09Mf7mVExx@kitsune.suse.cz>
References: <PH7PR19MB70252D42F5D04FFC0331AB63C08E2@PH7PR19MB7025.namprd19.prod.outlook.com>
 <aBz8U35YX7UH-PTW@kitsune.suse.cz>
 <20250508194731.GA13108@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250508194731.GA13108@coredump.intra.peff.net>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -4.30

On Thu, May 08, 2025 at 03:47:31PM -0400, Jeff King wrote:
> On Thu, May 08, 2025 at 08:47:47PM +0200, Michal Suchánek wrote:
> 
> > If you have one of those filesystems that support deduplication on
> > filesystem level you could make each snapshot as a full repository with
> > all objects unpacked, and the filesystem would deduplicate the objects
> > for you.
> > 
> > The downside is that you have no way to do multiple full backups this
> > way, and you would have to use something else for that (such as those
> > bundles, or plain archiving the repository as files in a tar archive or
> > such.
> 
> This is tempting, but I suspect that storing the objects unpacked will
> become unfeasibly large, because you are missing out on delta
> compression in the packfiles. You can compare the on-disk and
> uncompressed sizes of objects in a repo like this:
> 
>   git cat-file --batch-all-objects --unordered \
>                --batch-check='%(objectsize:disk) %(objectsize)' |
>   perl -alne '
>     $disk += $F[0];
>     $true += $F[1];
>     END {
>       print "$true / $disk = ", int($true / $disk);
>     }
>   '
> 
> It's not entirely fair because the "true" size is missing out on zlib
> compression that loose objects would get. But that's at best going to be
> about 4:1 (and in practice worse, since trees are full of sha1 hashes
> that don't compress very well).
> 
> In my copy of linux.git, that yields ~135G versus ~2.4G, for a factor of
> 56. Even if we grant 4:1 compression from zlib, that's still inflating
> your on-disk repository by a factor of 14.

So with this estimate you recoup that size inflation after 14
incremental backups.

Since no other working incremantal backup strategy was proposed so far
this is the best one ;-)

Thanks

Michal
