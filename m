Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360DE41CB5A
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828114; cv=none; b=nC+Zmh0nsY8nGtFAWFYvavtCQt5U/LQ9YffjJrinjsIGAQVcHT+jG8kCJeC4cGgrvLZ3gf/DlyAs++ylR0cLCPiIzXfqiodGTBlJsLOV7NUn2EXqRnsmdfXjwgNKChLt0K7G2Sv4UuujmN0mA5lq2+fti4y1OO0hFlspjWp1Ni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828114; c=relaxed/simple;
	bh=EIskeG5RkDwJH3O87bkHaTDuhDu7k+p3RlvOgteEav4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7vTfafDF1mIriXGzRZSAbiqSPD08zwjdG2h/q6s8ViJ6kdrj1/JTc7WOs9XDFeKCE7NxabY+hYe6aAKGtHfQkDSBdMoodt7PevA7LqvmOfA6vB0AJUrzd+0FhEH4GybP9KABApwVhh9yzlcFekDatg1cS8WziITiYwRs+JFhGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l5se3hKG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d9MRSZXN; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l5se3hKG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d9MRSZXN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9DAB01D00187;
	Tue,  4 Aug 2026 03:21:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 04 Aug 2026 03:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785828112; x=1785914512; bh=RpQ+M7y9hz
	TwLk9JWplxLokDup+vQ6lI7NYYhy5IcAU=; b=l5se3hKGylLXEK6MDYAsK5CdDH
	VoKPmBK6py8ZYT52XOkQ6XEqcJWmxky4VgrWg6Apkx4H30xMLmzQU790byrLDqFi
	czlN23MmtLmXCt6jhJ3i/3da/434ufNMXRsJa7iYiPITbtb4q4dTlnZlAplRCvev
	9oEs/d20mKiSOS2R90s1dxIkKm3l2DyXUntq7Ybk1onG/lxWE6BWoYoygrZuxIcw
	xQfWOqcNw+ybekhrGMYO0XlNfAttUgMr7EkXW/jDNPaFHIZk/gAw0IVN2+zXkE4b
	dpX8P5R60p/6TFlZMz8OqRfpXQWCjiFoo3UzgT1OtwVQdhCXhNS+Z+R/YBUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785828112; x=1785914512; bh=RpQ+M7y9hzTwLk9JWplxLokDup+vQ6lI7NY
	Yhy5IcAU=; b=d9MRSZXNSMhmn/ssaL+St+Yn7DIeog56h4plNixnuzpcvng1Tuu
	LrwnsrBPuVVOgObJAdkffUv52FS92Lgk2aK775Nj/tb5gGNPb3AMWIn7o2xCxdpI
	LxNUN6opMQGRMbxMV8nfjO+iu11A+4TDTZs4BM4rJXUPlgbNQjT0IIaPHOljQ+Cc
	+vt3hfPwrgzZjITb9aJiEeEbg8YyhHFWJPMhk3NIz2aFTUnIIWmzHeIniTxjxkf+
	Pf5IF7b2jhFnx/dD7F0UCk9x/oSOP7hFuIG2d/MB+pJ97CGT6/AqZn9wNgxzmKX8
	lhJkLvvjwEghpzOa71plCmpF31PB3Wh5ORA==
X-ME-Sender: <xms:EJNxavr0c9hMhdlLVjXWKWTYGEBKCSROJXHors1Tyom8GSnZr3Ntgg>
    <xme:EJNxavqJg9JndvtEOGJrarJIYcHejNv0J9j0WwRKLkYTSKn3p8GwsGNPMP0jV3TdP
    ihbJI3vCjcuoZCpsEsuEYyFxotzuTegv2d0xdeu7uhDAQ3hBkOhFVI>
X-ME-Received: <xmr:EJNxap1RuQJWN3G5E3oF5QqKY6_myPjMwDyLvi59W8H1IrXt1lO_xM_CPK8vzaW8gp9QoZZDrRWPYUrNTueiScSe-cOZnYX8xdL9YY7->
X-ME-Proxy-Cause: dmFkZTEW21OsGZxUpWZhdkXtbm/1B/RJ4l8Q+GteNB83+vGg16KxWvo9EDlkFLPwh4XmVg
    tonzBCmSlMcq9Zv5kkMsAOrl3v08zRX5F5Kf/PjQV7dQl7CLH9DoiWJINC1zs+NzgfwbPb
    o/vBuEQsSqrZT13qzTRXc554btVvCS/6lfjTQKMetN17r0fR9TYxOWWeyrliUtKDxD9PGp
    NrcEbQBCL7dK6pSjPXks7iNDoYJDpbaOkZ3ZDai5LJtC1i8/s7ATR2oU3ZQZ+La75i1u0F
    hpyPnpq/uoBEpgm0v46vVCf+YWFQ4IBX0XlK2EWgOqGNi6VR3S767OqMXno5X3836ebyc2
    4bWFeK6G4j5c3OurNyLTgePWCbSmOLMaQtiVAr1T/oy+y0MTbH3D5pnOd/D32wuXQvQKSi
    ywz9SKiXyMOfJpjubdx/ciiDVXDqnkKf3lHgrX3Thvi0cMoDBuW6ungnT3SKaxnwkRe3Gw
    esVMZFWI0WmU+9AvMjEbgT0ovGG+8ar/anIUkLnIOrX+Y75vHm4iCmW289Sp0HbkLIqQMm
    m+Ujb2bnvsNowwKUOHpQYtkWIEhDx/tHYaog1sLTL60pGEE56CLOea3Zu0OAtANTbaHuZI
    65C8i6iU8W6vQ6bEJdXk6fFGhbFOgJJXfOgLCRMC90G9dgjvs7uBsY4x+B+g
X-ME-Proxy: <xmx:EJNxauAW0TJzdLYJRC2UJGivimvAhr0-WSg7VZHvF5qPAT2JOqFTLA>
    <xmx:EJNxahd72r0dKS0BBQtoUDP1V84_by5FQmOQ5KLzia5MeBaFQ3qYTA>
    <xmx:EJNxajj-aClzYRtod3PHGN4L825Ns21TAvdR2IYv1uXvmMELJRTkOg>
    <xmx:EJNxappAT72MWw6LGd3cL1y3GJqENrE5MOYCHae0807jLPs5Mf3KOg>
    <xmx:EJNxajAIWddBRHuZTYYYYPbCLJbzs-x7-cM8hUfu8GR2P0jlEFubLX-e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 03:21:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 296c2443 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 07:21:50 +0000 (UTC)
Date: Tue, 4 Aug 2026 09:21:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] setup: defer object database creation
Message-ID: <anGTC81J4q76fUr1@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
 <20260724-pks-odb-create-on-disk-v1-3-3b3d265d979b@pks.im>
 <xmqq5x246x35.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5x246x35.fsf@gitster.g>

On Fri, Jul 24, 2026 at 11:50:38AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/setup.c b/setup.c
> > index 825572f5f1..a7b1b9eaef 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -2885,7 +2902,9 @@ int init_db(struct repository *repo,
> >  
> >  	if (!(flags & INIT_DB_SKIP_REFDB))
> >  		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
> > -	create_object_directory(repo);
> > +	create_object_database(repo);
> > +
> > +	startup_info->have_repository = 1;
> 
> Instead we call create_object_database() rather late, after we
> finish creating leading directories and default files and processing
> the configuration.  I guess this is a prelude to specifying "no, we
> are not doing the files backend but are using this new thing" in the
> global configuration?

Yes, exactly. Many of the refactorings I'm doing in "setup.c" ultimately
have the goal to detangle the setup and configuration of repository
extensions. It's been painful back when I introduced the "refStorage"
extension, and it's still painful now with the planned "objectStorage"
extension. So this time around I decided to detangle the logic before
introducing the extension to make the infra easier to understand going
forward.

Patrick
