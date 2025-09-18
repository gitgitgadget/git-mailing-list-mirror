Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A2734BA47
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758220281; cv=none; b=HvTt6yZgJS4vjtfU75EpRoa8wRMho2q7QcPMkRRXDcobdxDjd2V1hzZJchVLxhyuH9qaS+FvwJ35e+CpnJKkMR4Fm2fMSkUL8UqrGmlnr4OJ1hXHVVIkBzNJAGlfHDgoTAPe2fgcTB0Shrz2DRMYvg8xzwpAwNE2gtSZ7n5r0KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758220281; c=relaxed/simple;
	bh=KU/pE1Lrg2nD1uqA+ZTmnd1l2oHsTa2Zh0mgTzFuI/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sz9q7vqR5l/R5JDbGAr8Qr+75IiU3wLVNIJxUYIrXkbWuBgknf9w59pGxVhwFHvTxyyVq4/vEwaVjfEaubOX06oKQDl0y5wShnrooUTdYtJF7lUnrkTg1gqo+w/XTk0pgKdYn7nnr31mxGnFbMGpVUE8xKpffQ/gOPmGWUBbFJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZR+bJvwE; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZR+bJvwE"
Received: (qmail 121624 invoked by uid 109); 18 Sep 2025 18:31:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=KU/pE1Lrg2nD1uqA+ZTmnd1l2oHsTa2Zh0mgTzFuI/o=; b=ZR+bJvwEE1ns5FyUuhIrd6oB4ZK6tev26dr0Fk538VTGfbe+LlLu91ltzQnq8FLKzdKRBcJh6LUu1QxdSNYrDDevZSAgFI0nRmty2hBoYJkw3adbUASuK0inQBvDWpTZ35birvU5QlN30mn+QbUmcfgBL0OOKLAnH3pjqw9hfmuWVOJ8zIqczop1S4oaXLIHptaTJHeGTBMQQwoGYjMqbwKSB+aT7+sRL+guJpENrAbqCRDvt3Hlp9CLreTjJkX5MLfkV4S6NY1wdu18O7p1D0bxGyMZ1Uub7sVljyVT/dk51+yX0dgo9J9fljQgqI8diKgWvU1gnirqjPod/4HF4A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Sep 2025 18:31:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 194676 invoked by uid 111); 18 Sep 2025 18:31:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Sep 2025 14:31:18 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 18 Sep 2025 14:31:17 -0400
From: Jeff King <peff@peff.net>
To: kristofferhaugsbakk@fastmail.com
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v6 0/9] you-still-use-that??: improve breaking changes
 troubleshooting
Message-ID: <20250918183117.GB1184978@coredump.intra.peff.net>
References: <cover.1757879060.git.code@khaugsbakk.name>
 <cover.1758139856.short.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1758139856.short.code@khaugsbakk.name>

On Wed, Sep 17, 2025 at 10:24:10PM +0200, kristofferhaugsbakk@fastmail.com wrote:

> § Changes in v6
> 
> Use Peff’s patch to get rid of “the extra output”.[1]  Update commit
> messages to not mention that.
> 
> Also use another fix from Peff (patch 1); don’t list git-whatchanged(1)
> as a builtin when `WITH_BREAKING_CHANGES`.

Thanks, I looked over the patches that touch the things we've been
discussing, and it all looks good to me.

I am a little troubled that even after your patch 1, the test suite will
get confused by a stray git-whatchanged binary left over from an earlier
build. That may become an irritation later, when the breaking change
becomes the norm. But maybe it won't be too bad. At that point the
matching entry in .gitignore should be dropped, so at least "git clean"
will find it. In the meantime, building with and without the
breaking-changes flag can cause confusion, but presumably people aren't
swapping between them too often? And I don't have a clever idea of how
to do better, short of having the breaking-changes flag explicitly
delete git-whatchanged from the build directory. Which feels a little
gross.

So I'd say to call it good for now, and if it comes back to bite us
later, it is not harder to address then than it would be now.

-Peff
