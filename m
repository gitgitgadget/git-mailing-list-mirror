Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C721531C8
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759335613; cv=none; b=kecK6EItYCgDiwLVkH5Fm/x+Tfy3TxVA76dJpdA3Kkf+aWYk5CUVUr8TL+4EBKYM4r75s0Kk/m6/SAvzxv9+pMJl9mcWPGXQ8Bp8vnw+X6YLBswRH6b3kmNoJ/hW1ZYWxobEHWF17Z+tFAOSQO2aKB/jlfXhEK2zyU5VxKXzXzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759335613; c=relaxed/simple;
	bh=eOq1MF8xojVc8jqNaS/qbX4sg2okijk3wHxtcov+Qd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeRwErHmZMPrxBD8MgHqNZisSEzDS0XayZlTq8z6FXXnPdAZ+JUEslLhCYCLPLe2s0KcAD/dH+3nyveW31h90BO3kCbnKpPYbXGynO1jc5+4f+/5oYdW+4i9gHsVuP+Fw+n6NNKR0JfMVhnXqfUHx6FJqbr1CfdciVaLuHcBBZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1f1QF9bz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nueR+9+k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1f1QF9bz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nueR+9+k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1f1QF9bz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nueR+9+k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1f1QF9bz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nueR+9+k"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE2573374D;
	Wed,  1 Oct 2025 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759335606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M1XJps49h7+ZqgwZcT6HCbqdkDbnP/z+StF2UPrq4oo=;
	b=1f1QF9bz2fufNmao07qxBpdjvnj7gpy1NGC0qzz80ln/fDkS4vonRsNhChajsu9L+ouVSP
	NFkbfrCjmETayPNrJU0w4RkX4lKRo8V3A54nKAty6cwwX5RQkJ3fyz1Hj4exEdk6g0wtgs
	pJbNMU0VxZnbTw1s9OwOuijzWpUP+ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759335606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M1XJps49h7+ZqgwZcT6HCbqdkDbnP/z+StF2UPrq4oo=;
	b=nueR+9+km0uQJKvhGbJH8ZNGctMWMotHB/RRktUQmg/nTg6Gk3ItMyCB4HcfA0v2uG0Jxm
	VRSTNqAXTEuV8pCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759335606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M1XJps49h7+ZqgwZcT6HCbqdkDbnP/z+StF2UPrq4oo=;
	b=1f1QF9bz2fufNmao07qxBpdjvnj7gpy1NGC0qzz80ln/fDkS4vonRsNhChajsu9L+ouVSP
	NFkbfrCjmETayPNrJU0w4RkX4lKRo8V3A54nKAty6cwwX5RQkJ3fyz1Hj4exEdk6g0wtgs
	pJbNMU0VxZnbTw1s9OwOuijzWpUP+ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759335606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M1XJps49h7+ZqgwZcT6HCbqdkDbnP/z+StF2UPrq4oo=;
	b=nueR+9+km0uQJKvhGbJH8ZNGctMWMotHB/RRktUQmg/nTg6Gk3ItMyCB4HcfA0v2uG0Jxm
	VRSTNqAXTEuV8pCw==
Date: Wed, 1 Oct 2025 18:20:05 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Taylor Blau <me@ttaylorr.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aN1UtbJRIhgvMmaF@kitsune.suse.cz>
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
 <aN1QUDzYli0GsGy9@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aN1QUDzYli0GsGy9@nand.local>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Score: -3.30

Hello,

On Wed, Oct 01, 2025 at 12:01:20PM -0400, Taylor Blau wrote:
> On Tue, Sep 30, 2025 at 11:07:42PM +0000, brian m. carlson wrote:
> > Almost all of the functionality that we had wanted in Git 3.0 has been
> > implemented.  The two major things we may want to consider as blockers
> > for Git 3.0 are the following:
> >
> > * The SHA-256 interoperability work is not done yet.  My estimate of
> >   this work is 200–400 patches, of which about 100 are done.  If the
> >   original schedule is maintained, this would require writing up to 75
> >   patches and sending in 100 patches per cycle, which is unrealistic
> >   without additional contributors.

From my very limited point of view as a user the interop is the major
planned feature currently missing in git, and I do not see much point
without it. Then again I do not know how useful it will be in practice.

> I need to polish up the notes from the Contributor's Summit and share
> them with the list, but my general feeling at the end of the discussion
> on the SHA-256 interoperability work was that it wasn't clear whether or
> not it should be a blocker for Git 3.0.
> 
> If post-3.0 repositories are using SHA-256, then either their post-Git
> 3.0 clients will also use SHA-256, or the pre-3.0 clients (without
> interop support) will be unable to interact with them. I don't think
> there would be any reason to have a interop-capable client use a SHA-256
> repository in SHA-1 mode.

Flipping the default to sha256 would clearly break some things. I can
use sha256 repositories in gitea today (no interop whatsoever) but
github rejects them.

Then again cloning a repository uses the correct hash which means if I
create the repository on the forge and clone it there is no problem
whatsoever regardless of hash used. Whill that break as well?

Thanks

Michal
