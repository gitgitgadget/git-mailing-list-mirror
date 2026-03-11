Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B42C1593
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773254726; cv=none; b=T04tDijvx4ONFImTwTg2tU0UpySJAdGd9TgHKXVTod43sA3lrHtx1drUBurCJaskJn51KLBSdx0Jfv84kx/4nvlXO/is4c4rlTa8eGKxqTuBtEOWGrgdGb2f5LQ7iwFh2XGr3tVl/X6qBeCWCSt65L/XsiZs1NaBiicWyR2p8bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773254726; c=relaxed/simple;
	bh=nxUqVfLreYZXHzVCBJtVCPPbqRjscoZnNs9CCpwL0qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMEDuvYn4toxlkTIZ+Hji56ToAmV+1s5yS51HIiUrliVNq9UvO+DgPQr+D4ALq415W1WD49X9fAnvT3tHFgaSkUmsQXsi2+dsUlmD8Hm1edtNtjev90nBYrOTjZkhIufoTZ3k1/LD5ThGVS70AZV93mHIWQtLjevU+NdQkh3DR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=O/6Ak2iz; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="O/6Ak2iz"
Received: (qmail 79421 invoked by uid 106); 11 Mar 2026 18:45:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=nxUqVfLreYZXHzVCBJtVCPPbqRjscoZnNs9CCpwL0qw=; b=O/6Ak2izrJTv60r1cAdyJRpmPoo7aIn+BWYQBRkjesCqWHVMb9wEM4qqbpZI5vcZ08OrDEiJlGj2ocKlG1/gIkmF+VbPPAbyl7iAcaGb1GiX3xHkGeJ1xwQxyds1mv4Hj+WvCM6+YH98xxrbeiGQTlSh3nx8nzQVwnDbfpMsLMT3E3ufe759RLPSyquwrp/P5gRmjH7r7LWWKxWuuqldI40HBBLxeuBzCGCgp9ZcTSo/N735ffi3Wt2iKnGgH7rHpw7ugzxxTWhaPZ7ChHbDmlE/oNyt2+YZPSdQQIk6PJ/WDrTyhLo3fclTi34Zg17MffjoPCaeM4vxMWKWW0gPmA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Mar 2026 18:45:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 493953 invoked by uid 111); 11 Mar 2026 18:45:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Mar 2026 14:45:24 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 11 Mar 2026 14:45:22 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Burak Kaan =?utf-8?Q?Kara=C3=A7ay?= <bkkaracay@gmail.com>,
	git@vger.kernel.org, christian.couder@gmail.com,
	karthik.188@gmail.com, jltobler@gmail.com, ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com, ps@pks.im
Subject: Re: [PATCH 0/4] wean start_command() off the_repository
Message-ID: <20260311184522.GB1911377@coredump.intra.peff.net>
References: <20260311151923.4178655-1-bkkaracay@gmail.com>
 <041604ef-0bdb-4c40-a9e1-60c38ae664cb@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <041604ef-0bdb-4c40-a9e1-60c38ae664cb@web.de>

On Wed, Mar 11, 2026 at 07:18:10PM +0100, René Scharfe wrote:

> On 3/11/26 4:19 PM, Burak Kaan Karaçay wrote:
> > 
> > start_command() relies on the_repository due to the 'close_object_store'
> > flag in 'struct child_process'. Introduce repo_start_command() to allow
> > working with arbitrary repositories. Turn start_command() into a macro
> > that wraps repo_start_command() and migrate the existing callers with a
> > cocci script.
> 
> Good idea to expose this hidden dependency.  It's different from the
> other repo_* functions, though, in that most callers can safely pass
> NULL as repo because they don't set close_object_store.
> 
> Only gc, pull and auto-maintenance set close_object_store.  If we
> changed them to set a pointer to the object store they want to have
> closed instead of a binary flag then we could leave the other callers
> unchanged.

FWIW, I was about to write the exact same suggestion.

-Peff
