Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB01F4C8E
	for <git@vger.kernel.org>; Tue, 19 May 2026 00:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151501; cv=none; b=LG/ipkXKUlwXoMY+BzFn8vUBeK5kq8Yg/VB/ozmnpAXczrHRZVJRhSHJ6qZ9Cu5WPFC8kgj98i9VH8JvVmH1DUE8MfN2913HIuBklZvVUrxseQOvxS+oPavzRdAV8m2srON3mlu2CcNmJC7sRqUAReg2bWatLKS3SwfsPDWl16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151501; c=relaxed/simple;
	bh=QPmS68YIno53EZYkHJ3eV4g5xsvFIf2OGk0tWfl7FHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZ4NLkF6iuOZBcr6q+37pRs5SSYbjd0+K6/wbW50mePjkG53yeu/T0WOLzVqiIqxobAP3k37k/6IXFs4nqybRoeXC014jfElgtwwzG7irijheEdd8+OiFFm2CnwNsFhQ+SbbfnwLaguxMW83QktvirCzGqmO6njMUL5Vkk+nMpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AnjBqP8o; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AnjBqP8o"
Received: (qmail 15647 invoked by uid 106); 19 May 2026 00:44:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QPmS68YIno53EZYkHJ3eV4g5xsvFIf2OGk0tWfl7FHo=; b=AnjBqP8ocTIojornTZl5fh2A8GhI0I787D9HbfJuDgkn3CZIeRzB5GNljDti4J0fkLsuZyUkJpZ9TP7U8jkT5JziZBD6LIT2TwQit+AlZeh//u6ZfFhjiLzaJDh5vuk5Fsxwt4aX2tI1+6yw0X6izhxJFxjgI7YMKT+k6wP0IUF0wcowdOQcmTzVs3hDFJvCLp4Rmy/cn6GFwOjJdzvLceOvCOMn4qxGoZ6kcppo9BJht7sG5f4FK4oTvH2s/ycIbiF03pQljvQH9++rT5hvQwGcWGgya+X/IjjEmmFzLKvJoXon9zDjw7iELtYyBO/OFgnJqRWUD8x/Gfc6LPPMBA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 May 2026 00:44:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 38262 invoked by uid 111); 19 May 2026 00:45:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2026 20:45:01 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 May 2026 20:44:58 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonatan Holmgren <jonatan@jontes.page>, git@vger.kernel.org,
	rsch@web.de, michael.grossfeld@amd.com
Subject: Re: [PATCH] alias: restore support for simple dotted aliases
Message-ID: <20260519004458.GC1612961@coredump.intra.peff.net>
References: <PH7PR12MB73313034573C59C73F821BBFE52A2@PH7PR12MB7331.namprd12.prod.outlook.com>
 <20260424151053.917066-1-jonatan@jontes.page>
 <xmqqpl3ovuvq.fsf@gitster.g>
 <40408c99-7e2a-4cf6-b9b2-6d0e0da3b2c5@jontes.page>
 <20260425232916.GA29816@coredump.intra.peff.net>
 <4a130a23-fa32-460b-a338-409d85d18166@jontes.page>
 <20260426230125.GA218434@coredump.intra.peff.net>
 <d1170f92-3690-4fa4-8070-75ac9f119174@jontes.page>
 <xmqqbjelp7ab.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbjelp7ab.fsf@gitster.g>

On Tue, May 12, 2026 at 01:43:08PM +0900, Junio C Hamano wrote:

> Jonatan Holmgren <jonatan@jontes.page> writes:
> 
> > Sorry, that wasn't a "hey we should deprecate this" code-wise, I was 
> > asking from a documentation point of view, i.e. was curious how you felt 
> > about what is "advisable". Shouldn't've included that in my email
> 
> After this, the discussion went dark, but I think everything that
> needs saying has been said and we are in agreement that the current
> patch is a good way forward without closing doors for the future too
> tightly ;-)  Let me mark the topic for 'next'.

Yeah, sorry I didn't respond to Jonatan. I think the patch as-is is
fine, and if we want to push people towards the new form in the
documentation, that can be done separately.

-Peff
