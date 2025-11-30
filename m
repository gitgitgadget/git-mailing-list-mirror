Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6679379F2
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764510574; cv=none; b=gcXMqd/XcST8WoLRkcU+f85AAVGJWmNtMVkRQ3GCvELqq4AoSAfkz/EVpLG0VeIQ04ustLTIua0b7hXjE7HproIMZYwBeHA9Somj7oRlwV7nG86fJsoVWbzdPiM996e6J/1WO8d1AMm5HKNoNI8qmzmLyLRqylsEpeqBHR9AA9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764510574; c=relaxed/simple;
	bh=pyw6cfIBHDsavWXG3tSRVqGJDFMVYNnGTELTVqrUHDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFsW+i7Uq8n8PX4TptYshPVc00sM2/RgO2//71hTgQV0yk6XFEarPyVT3gWxhsbrt+kTckRyxZX5y/aOIrNpkLwTuPZe/+u1Dl5DXc5J+TfbvSkDxuIub5UDKcP5rpLJ4iBSn+J7ptKAVJeU00vPldVnFu3ijH844vaXLFC/XiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gNzLyggI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gNzLyggI"
Received: (qmail 171236 invoked by uid 109); 30 Nov 2025 13:49:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pyw6cfIBHDsavWXG3tSRVqGJDFMVYNnGTELTVqrUHDM=; b=gNzLyggIZc4b0Pkh68z/5BLsr+jykeHThsynhs3UxyUFNIy5GadXn2Y3RPP1Iz7hJ8F19FBJkoipo05vupClXiXWoDjOgVXlEOl8QGeXo6Jj+byRn3CtVRM0gM/bw+bznLlhzbMGkX8IhKZPgPRuzU0U3WTcjyTCCuwPee9UAZhaxMQtHpQFY9CdJiW1fHVVH7Ml4XdnivCc2Pws1XiepNSYXfaR1f+PXwfwYGbJ8UHkW2A4hoFz2I0pdYosjTagO+1lJeMKUyr5XA7Sdd56pvYkZ3n2ohp/eRg323uobltpsH4miW4+I5CyB7+Ngn3sW1O7qh3jOngBV9JR4cDUxg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 30 Nov 2025 13:49:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 255205 invoked by uid 111); 30 Nov 2025 13:49:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 30 Nov 2025 08:49:31 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 30 Nov 2025 08:49:30 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Ran Ari-Gur <ran.arigur+git@samsara.com>, git@vger.kernel.org,
	"raa.lkml@gmail.com" <raa.lkml@gmail.com>
Subject: Re: [BUG] `git clone '-c KEY=VALUE'` no longer works
Message-ID: <20251130134930.GB199421@coredump.intra.peff.net>
References: <CAN1UxBvk_GJjLWd0XexRxp8FFhYozGCNcodai0eqnjrhjKEh7Q@mail.gmail.com>
 <CALnO6CBJppT3ELyu54rJvP+uqcMomJS9Nr_JTgfssn8iqG7MWA@mail.gmail.com>
 <xmqq8qfvw2lh.fsf@gitster.g>
 <20251124235530.GC2051672@coredump.intra.peff.net>
 <xmqqo6oqucka.fsf@gitster.g>
 <xmqq8qftrcqb.fsf@gitster.g>
 <20251126150215.GB4143292@coredump.intra.peff.net>
 <xmqqtsygoh96.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtsygoh96.fsf@gitster.g>

On Wed, Nov 26, 2025 at 09:06:45AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > That doesn't trigger via "git -c", because we use the "new" form these
> > days (so it started rejecting the extra whitespace in 2021). And you'd
> > only see it if you hand-crafted the variable, or an old version of Git
> > set parameters that were then parsed by a newer one.
> >
> > So whether that is a case we care about is up for debate. But if we are
> > going to accommodate backwards compatibility, we have to decide where to
> > draw the line.
> 
> I was hoping we already drew the line above the "clone" thing ;-)

OK. :) I am OK with that, but I wanted to make sure we were doing it
consciously.

> > And I think the latter would still fail with your patch. Again, that
> > might not matter to us, if all we care about is making:
> >
> >   git clone '-c foo.bar=baz' ...
> >
> > work as before. But I'm still skeptical that is worthwhile (especially
> > given that nobody noticed the same change to "git -c" a few years ago).
> 
> True.
> 
> I do not think I can convince myself to care about this deeply
> enough.

That's about where I'm at, though I'm a little worried by Dscho's
mention that apparently git-lfs has the same problem. So maybe it's more
widespread than I am giving it credit for?

If we draw the line at "-c foo=bar" as a single argument (which is what
it sounds like git-lfs is doing, too) then your simple "trim" patch
would be enough.

I dunno. I certainly do not want to get into a deprecation period and
all of that mess. Maybe the breakage in v2.52.0 would be enough for
callers to notice and fix their invocations, and we could just quietly
remove the hack later? But then, I am not sure what makes "later" any
better than "now".

-Peff
