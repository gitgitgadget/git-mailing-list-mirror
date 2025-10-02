Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5292B151991
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421428; cv=none; b=QmGgzKzBb8qD5SqKUs25Gi56QruYM0tli56wJYNgpb5p+yTuuLFYJowH2VyM1anjLL5z4ZkTSCkoFDlwItpGMnxEfRzUIzDH75Ufqy94AZzMiKFPr7AO6GxB0JJYUdx8YX0IOA2OBI18BmDv1zn0qkFBbjcELNXf3rYv3WtglZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421428; c=relaxed/simple;
	bh=RXv4o/K0iEhuH4orO9fk5wd/8vFl+TD6jSZ0p06uVbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t05jDuFGM/9gI9dC+QHkY0UtJe87b9rwCyEmluApyTMzVcJiysASJdjOh5dZQTGYw/sUsZSViTwcFDBF7zR5XWu8G7J8BUm6va8VUoOgMuoPmB+OQrwSAPwxNMotoBrHXvXyZhhlPXvwgeT1xmNFnOlM1R8tThEjvZ3sGR8vpOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hbFA2mWP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EH3SJZpQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NgljCt7i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9R464gMJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hbFA2mWP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EH3SJZpQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NgljCt7i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9R464gMJ"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E95CF337BB;
	Thu,  2 Oct 2025 16:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759421424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fn92dDHIy+rc25GDw+2q7E8/KPk7EraeIazM9b40oTM=;
	b=hbFA2mWP32kYfiO+1/tas2//F4+RxjcNdcovu+KqnYL2e0xGWU8A1lUfMFiJ0W3UG3Ovl5
	Wz32j8zZV54BR89N9j00+4jhbJS1T8MkKerbw4Q1jwA6Eehc5i1NxLi4WlwRJc8RCn++Gj
	HA0qPWO7uB6cX+A7R76BBaxPIz/Ovh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759421424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fn92dDHIy+rc25GDw+2q7E8/KPk7EraeIazM9b40oTM=;
	b=EH3SJZpQmQcRlbUakHb07FRvKz3FfYDkIEvUACXETqLSgZ1RiwO5NvNOB+u6/Y3sxPpEc8
	05OvINfd0jebBBCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759421423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fn92dDHIy+rc25GDw+2q7E8/KPk7EraeIazM9b40oTM=;
	b=NgljCt7irc0FGEZJ3oAQAc9jvxD2lEnXlCT5QLIvegTFrEPJo7IHeu2duYHW3dUplJrzUk
	+4r1gWldqZJu+488WRfZf+qoda1AOsHnZ9WU+0AitQw4d42h+Qw2ya+FT+geDKSsGp5Eyr
	aQ1SYiocBhm9wOebCFYXJI7KbYKl+7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759421423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fn92dDHIy+rc25GDw+2q7E8/KPk7EraeIazM9b40oTM=;
	b=9R464gMJc+K/Sf+MHfGEqk8HRNkTOEZCB9sfrJ3YxBFRtkrFkHuVR5oZIt0guQTx7OsLEL
	9G5OMCd44vtQQzBQ==
Date: Thu, 2 Oct 2025 18:10:22 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	Luca Milanesio <luca.milanesio@gmail.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aN6j7giOosGreKUW@kitsune.suse.cz>
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
 <E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com>
 <aN1RFvz7uGPnepxe@nand.local>
 <aN5-n_ArhQqaQZgt@pks.im>
 <xmqqfrc1xqsp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrc1xqsp.fsf@gitster.g>
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[pks.im,ttaylorr.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kitsune.suse.cz:mid,kitsune.suse.cz:helo]
X-Spam-Flag: NO
X-Spam-Score: -1.80

On Thu, Oct 02, 2025 at 08:32:38AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Once we have roadmaps, we should set a strict deadline that takes them
> > into account. Any hosting provider or implementation of Git that doesn't
> > provide a roadmap will not be taken into account in our planning.
> 
> Works fine as long as we assume everybody that matters will
> eventually want to move away from SHA-1.
> 
>  - If a stakeholder gives a roadmap that has no SHA-256 in their
>    future, in other words, if they are content to serve only the
>    SHA-1 projects, what's the impact to them?  We are not dropping
>    the support for SHA-1 in the sense that if you clone from an
>    existing SHA-1 repository you'll get an SHA-1 repository and you
>    can push and fetch between them just fine, so presumably that is
>    fine as well.
> 
>  - If a stakeholder gives a roadmap with SHA-256 so far into the
>    future that we cannot wait, what's the impact to them?  Their
>    customers that want SHA-256 earlier than they can supply could
>    move to other hosting or implementation, but not really.  Both

I suppose that's already the case to some extent. git does support
sha256, some forges do as well, and some people want it to the point
that they install such forge, and create the sha256 repositories
although it is not the default.

There is some tradeoff here. When it's nice to have but not required
people will use it when convenient. When it's really required people
will use even an obscure implementation to get the requested feature.

>    hosting providers and Git implementations have components that
>    are move than Git that are hard to migrate, like issue trackers,
>    CI services, workflow tools, etc., that make their customers
>    captive audience [*].
> 
>  - If a stakeholder has a roadmap with SHA-256 in line with our
>    timeframe, do we still need to assess the impact to them, or as
>    long as we and they work hard to stick to the plan, we all will
>    be happy?
> 
> > We should of course actively reach out to the projects that we're aware
> > of so that they have a chance to provide such a roadmap in the first
> > place.
> 
> 
> [Footnote]
> 
>  * Issue trackers and review logs that are federated, possibly using
>    Git database for storage and transfer, may allow projects and
>    users to freely roam across hosting sites, but there is no strong
>    incentive for the hosting sites to fund such an effort X-<.

Many forges provide migration options for importing data from other
forges for which there is incentive, with various level of completeness
and reliability. Another thing that contributes to lock-in is network
effect of popular forges.

Thanks

Michal
