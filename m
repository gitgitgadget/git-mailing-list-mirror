Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA562CA8
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736161911; cv=none; b=rGPZgqZtBXml7agowR3kia+RMvmT9OiQuoFOwyv7V/cC8CwVL0OUWXAU2OMkDR4Xm76POZppnmBwMgCvPkHNM6tOtRFWZZiM6Cdl8UdVVwic/w88R9Em4xf9WdQC3T+xFWNSr+32KS5gzbyNEiLbimzpefgSYK7N79snwTPWn34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736161911; c=relaxed/simple;
	bh=lKQzVqhREF5kmeRh1sxiurjdZfygACxjAihcAf+q0XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOcVXvYH3SzyE1hd2jbmsoftxH8vav5tqPfyX7z1njVjRQQFk5th/m0KmCfCh0aWX8Xq/dTFJ5sfMeDttv4TwM/6ajtSlyib7M9VnQmfh3985g9Jnr7us11gy+MTthI+ShUE4kgaF60D2OFjFmxcsW62G0WNY4MJLdhpLQ7nvEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b6M+j1wi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m/V3tvuQ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b6M+j1wi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m/V3tvuQ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5767311400B0;
	Mon,  6 Jan 2025 06:11:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 06 Jan 2025 06:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736161908; x=1736248308; bh=0uk67tvDNn
	KNnDzWS4UI1GyVIcO6nZmXsyETam0WFlM=; b=b6M+j1wiIMAxwe3jP9oPKUTzot
	sXv/NxN1TvSPhO/aotqp7+dsWfySyqI/AitT+lfJmL3B1V0IBzKtImFgpGvySjgg
	HtP8XUvkG0arsq1nxhOOsAyYWT27k5AA1yqA2n5ILJoNHGztsEXLd9zRwPdWGn/J
	BD1ZPPRjeZeidvtdHhW6De5MWHUjTHbV8hVw1+KUlpTA/r3WTGS23CcWRigEGkQy
	KqEiHvtZfoyBlPpDEnXgrW02rTs4KwYSyZ4f2ieUnhZZcGKAfJ0A/VaPH+HU52ir
	VjD426aUK7dCI+Fs6fBy2SUiNpVOFeACSVT7A7YVgNYxMQ0mNW0D+DoZcYog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736161908; x=1736248308; bh=0uk67tvDNnKNnDzWS4UI1GyVIcO6nZmXsyE
	Tam0WFlM=; b=m/V3tvuQhcOj3d6yJutDhdEhfw+mXxD0c7Gv5vtQ/LQuKqheSEc
	x7NELG01Vi4qFYzdwa+roB+RohPOliXx3LU2hJOkR8ytL1A+48MNtqQdIAty+kFC
	dtidFY7th1GV2iL6FrFVxtQN6wWwbm7Cj/gb7mnrd3sNOlaI9ktiTIs1lV6D7XIA
	lcGaFgw6RWphdeQp7nKDMgra5VP+tTNkvN99UWs+Q3BuXXKfIDnkC59tDWnBWRHo
	8lNrmL29QToHWGvFRGDIEasPQFP1xZTIy38bI3alCVm8cC6mUl5ro/cditQAiCRf
	tEFSpBUwEdaIpLFAs2vFJQLoDXcnN5XKAPA==
X-ME-Sender: <xms:dLp7Z8t4XqAix_0zPzj-ELjk6LhGAjR2G5MQEPjLWL4yHYD86soo8Q>
    <xme:dLp7Z5fs2dXB-coILtq3z31eaE_bKWIWI7CruyNT299VNk5145k7XekwzoSF46kR0
    BjMRryqwTJ9c7q2CQ>
X-ME-Received: <xmr:dLp7Z3y-7dwcS7Wfl-7zD9KJJ7jowWQx0k6w41KpeFyaoQUElvj9psrEtCyA4UkmN-2I8QdFKeH0YbKW6x6DZfs0RH5ZrzyhEAuzTOgDdlN4Lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dLp7Z_PukBGb8X8aDa_P6BeSDJ5XK3pnw5f2de2DZJN-H_M2l1TtbQ>
    <xmx:dLp7Z8_Tq-8JkAwptZYaaCBUxUzyGkp8CaLGP1Kuo1ZowSF990I0fA>
    <xmx:dLp7Z3XFL7LIYsrOTLyj8OzFYGzVzizB1Jnvluj6PBE4DVcrz7Kh-g>
    <xmx:dLp7Z1fCN7pfFh1WNoOGEtwB3Oyz8tXgITttSIQIVFWSpJZnH8irLg>
    <xmx:dLp7Z7aEXb6WTlBrwj6b1Dct2ZZ6xQSLYyEqqKNiGgQIEdWy1ZiZe_Xi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 06:11:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ab4201a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 11:11:44 +0000 (UTC)
Date: Mon, 6 Jan 2025 12:11:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] object-file: retry linking file into place when
 occluding file vanishes
Message-ID: <Z3u6bzyaDyzjV65X@pks.im>
References: <20250103-b4-pks-object-file-racy-collision-check-v1-0-6ef9e2da1f87@pks.im>
 <20250103-b4-pks-object-file-racy-collision-check-v1-2-6ef9e2da1f87@pks.im>
 <20250103194058.GE3208749@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103194058.GE3208749@coredump.intra.peff.net>

On Fri, Jan 03, 2025 at 02:40:58PM -0500, Jeff King wrote:
> On Fri, Jan 03, 2025 at 09:19:55AM +0100, Patrick Steinhardt wrote:
> 
> > In a preceding commit, we have adapted `check_collision()` to ignore
> 
> If it's in next and we are building on top, I think we can mention it by
> name: 0ad3d65652 (object-file: fix race in object collision check,
> 2024-12-30).

Okay, good to know. I wasn't sure whether the patches might get rewound
when `next` gets rewound.

> > the case where either of the colliding files vanishes. This should be
> > safe in general when we assume that the contents of these two files were
> > the same. But the check is all about detecting collisions, so that
> > assumption may be too optimistic.
> 
> I found this a little vague about what "too optimistic" means. ;)
> Maybe something like:
> 
>   Prior to 0ad3d65652, callers could expect that a successful return
>   from finalize_object_file() means that either the file was moved into
>   place, or the identical bytes were already present. If neither of
>   those happens, we'd return an error.
> 
>   Since that commit, if the destination file disappears between our
>   link() call and the collision check, we'd return success without
>   actually checking the contents, and without retrying the link. This
>   solves the common case that the files were indeed the same, but it
>   means that we may corrupt the repository if they weren't (this implies
>   a hash collision, but the whole point of this function is protecting
>   against hash collisions).
> 
>   We can't be pessimistic and assume they're different; that hurts the
>   common case that 0ad3d65652 was trying to fix. But after seeing that
>   the destination file went away, we can retry linking again...

Well, as usual your commit messages are something to aspire to :)
Thanks.

> > Furthermore, stop treating `ENOENT` specially for the source file. It
> > shouldn't happen that the source vanishes as we're using a fresh
> > temporary file for it, so if it does vanish it indicates an actual
> > error.
> 
> OK. I think this is worth doing, but I'd probably have put it into its
> own commit.

Fair enough, can do.

> > @@ -2034,8 +2037,10 @@ int finalize_object_file(const char *tmpfile, const char *filename)
> >  int finalize_object_file_flags(const char *tmpfile, const char *filename,
> >  			       enum finalize_object_file_flags flags)
> >  {
> > -	struct stat st;
> > -	int ret = 0;
> > +	int ret;
> > +
> > +retry:
> > +	ret = 0;
> >  
> >  	if (object_creation_mode == OBJECT_CREATION_USES_RENAMES)
> >  		goto try_rename;
> > @@ -2056,6 +2061,8 @@ int finalize_object_file_flags(const char *tmpfile, const char *filename,
> >  	 * left to unlink.
> >  	 */
> >  	if (ret && ret != EEXIST) {
> > +		struct stat st;
> > +
> 
> OK, we move the stat struct here where it's needed. I think that's
> somewhat orthogonal to your patch, but reduced scoping does help make
> the goto's less confusing.
> 
> I suspect there's a way to write this as a loop that would be more
> structured, but it would be a bigger refactor. Bonus points if it also
> get rid of the try_rename goto, too. ;)
> 
> I'm OK punting on that, though.

Yeah, I'll punt on it for now. I don't love the resulting structure, but
it's also not that uncommon in our codebase.

> > @@ -2071,9 +2078,13 @@ int finalize_object_file_flags(const char *tmpfile, const char *filename,
> >  			errno = saved_errno;
> >  			return error_errno(_("unable to write file %s"), filename);
> >  		}
> > -		if (!(flags & FOF_SKIP_COLLISION_CHECK) &&
> > -		    check_collision(tmpfile, filename))
> > +		if (!(flags & FOF_SKIP_COLLISION_CHECK)) {
> > +			ret = check_collision(tmpfile, filename);
> > +			if (ret == CHECK_COLLISION_DEST_VANISHED)
> > +				goto retry;
> > +			else if (ret)
> >  				return -1;
> > +		}
> >  		unlink_or_warn(tmpfile);
> >  	}
> 
> I share Junio's uneasiness with looping forever based on external input
> from the filesystem (even though you _should_ eventually win the race,
> that's not guaranteed, and of course a weird filesystem might confuse
> us). Could we put a stop-gap in it like:

Fair enough. I was also wondering about whether or not I should have a
retry counter when writing it but couldn't think about a (sane) scenario
where it would be needed. But yeah, filesystems can be weird, and it's
not a lot of code either, so I'll add it.

Patrick
