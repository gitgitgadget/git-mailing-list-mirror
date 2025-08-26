Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E142F619C
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206767; cv=none; b=L2gCh910g4rWO3NBgusKnHfZabGlSg1CBkL9NWRaZTKwISQ0569+t08Z+8u78KtgQf8RX12nmNbntO2+D+ML3h7VMdX1BLEk6EvesHVLe6i/gsqLctNOrZ0Sd3KmYQFtiWaUaHmWCuVGaLNj1vFbasRVrU8s0Ifc96HNAdtdQdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206767; c=relaxed/simple;
	bh=UVQFAoy9esO0/4czOxhWSr8k8Ul8aDF6Z6eDEG08SMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRjW1C3FWrwyvztWZRqLUkPisi9IA92Hpam2hZ3pFKkseg/fhXsdmSpyQTiA8LuqUAro5KuG44fbp0Xdshmk6+WafLg20Y4/RqxzvYs5VdFjHB5QoxH87Ojfgm4shmdaWUP5x6zzEuG993cUSd2mZA3rcpnZ3Z+AjjuAFTK57Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hhyi4kt+; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hhyi4kt+"
Received: (qmail 116711 invoked by uid 109); 26 Aug 2025 11:12:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=UVQFAoy9esO0/4czOxhWSr8k8Ul8aDF6Z6eDEG08SMA=; b=hhyi4kt+8Xn2pPwxMsQMHwmEwyC1cuFwgBjUL24nSHJi59WAn3ciPRPgOow7q3HPUUZ5ZEuMxQ4OuJsHvgyTY3Ki+rG2WBmQH+D1FthTLC89WHWjSKu8CKH3152aRid1T+rfAqPto82AD5+wx20aHnt0hghYP6yijP7OFh0umuOg3wKjymbirK59D2Fc0iPpP/8K3aj2Qzm1G4Rusp7pew9ZlhCH77SDIP+7j93dfGrQcJLKbJvlhfmBp0K9uNX3hAEvK4Icgk0yf7Grmjg4Lm851kpWZVnL8YU/1fyWsTJjLk3Hc3+EZVsR2MhmK44xR+hTHvX2+eCGq5E6YaDeRw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Aug 2025 11:12:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 172334 invoked by uid 111); 26 Aug 2025 11:12:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Aug 2025 07:12:34 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 26 Aug 2025 07:12:34 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: Wing Huang via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Wing Huang <huangsen365@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] rename default branch from 'master' to 'main' in refs
 and test scripts
Message-ID: <20250826111234.GA1925107@coredump.intra.peff.net>
References: <pull.1961.git.1756183921623.gitgitgadget@gmail.com>
 <0a574b62-273e-4519-855f-66c554cd93c7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a574b62-273e-4519-855f-66c554cd93c7@gmail.com>

On Tue, Aug 26, 2025 at 10:58:55AM +0100, Phillip Wood wrote:

> >       * remote.c: Update fallback branch name for remote operations
> 
> I think we want to keep the fallback to "master" but check for "main" first.
> Otherwise we'll stop finding the default branch where the remote is still
> using master.

I'm not sure we need to change anything there. Modern Git will generally
report the name of the branch pointed to by HEAD back to the client
(using either a symref capability in protocol v0 or the symref extension
to the ls-refs list in v2). So the fallback would be needed only for
very old servers, in which case "master" is probably a better guess.

IIRC, there are cases where v0 does not report the HEAD value when it
points to an unborn branch (and while I'd expect most Git servers to
always support v2 these days, sometimes the protocol upgrade fails due
to things like ssh blocking the GIT_PROTOCOL variable). But I don't
think that would affect the fallback code:

> > @@ -2379,7 +2379,7 @@ struct ref *guess_remote_head(const struct ref *head,
> >   			return copy_ref(r);
> >   		/* Fall back to the hard-coded historical default */
> > -		r = find_ref_by_name(refs, "refs/heads/master");
> > +		r = find_ref_by_name(refs, "refs/heads/main");
> >   		if (r && oideq(&r->old_oid, &head->old_oid))
> >   			return copy_ref(r);

since it is only about looking for the matching branch name, and not the
unborn case.

If we truly have an unborn HEAD on a very old server (with no protocol
support), I think we just end up without checking anything out, which
means HEAD would default to whatever the local client default is.

-Peff
