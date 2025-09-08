Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AA947F4A
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365905; cv=none; b=a2/aozPxkFVDzIZhAzy+MDsS7Mq2MPKnn9RpAZfAiMxI66k15b2uM+7aZ7Ma/bD3AikSggro5F4O5HVGQVpGciqAgPnkj2dHYI/zI5CqVUKUgBtfZia19Sl7asi0UEGfO8ST/Rt039H25dSCrvX6Oad6AA+5XOE+IRn7pjWXlYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365905; c=relaxed/simple;
	bh=VjZui5ITOT/k7Y+xb40iY5WBxfatmeAAYe+m+cHg890=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6AV0TNgYbRB2Ajr/zWpWZsheEEjT+YTbClj8tXqMzpPlKRVdR1gpvoCBTaG7p80H+9pPrb/6/D7QUsrDB+bipdaBs6D1tjQrJ0+n+vrevb0nzhP3gFR7R6Kbkp/vA4quxy42Ap1IixrUWtTn1F/SdTOrDaYZOh7yS/fiwJZWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Bm6C/1Oi; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Bm6C/1Oi"
Received: (qmail 23543 invoked by uid 109); 8 Sep 2025 21:11:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VjZui5ITOT/k7Y+xb40iY5WBxfatmeAAYe+m+cHg890=; b=Bm6C/1OiHkr+uTo1jwvzF5YI+KDPMCSjxsQN1sjcgI6cxE0Qvktnwhy9ePAOc308fXU1+QOytaIygfxmIq40qlMGgiL0eR5rIQSKuv/LrA/h6gjfLTjiJSnuMzkGUiXuE9BwvWDvUWrz7iXP5WffKYqBZ1Ql07IPlucUf1+/bQ2j/L8uPhG4enM3y3x/k7YOrG29o7Ab2tPxhXXgW5Vrjaq0TQRP4vyOjDDfF5lo8Gc0oE6EMS0EcLhoZP8JqWpR2jIat9hcbmbk7R2gEzgLIzzJVhGg14QqX/bcc2zg85HIm4qBcKA8aRRi2Pzld/zwhBCsNccMuXjYB4xep+uPmA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Sep 2025 21:11:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 39131 invoked by uid 111); 8 Sep 2025 21:11:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Sep 2025 17:11:41 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Sep 2025 17:11:41 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/8] git: allow alias-shadowing deprecated builtins
Message-ID: <20250908211141.GB1327610@coredump.intra.peff.net>
References: <cover.1756480827.git.code@khaugsbakk.name>
 <cover.1757345711.git.code@khaugsbakk.name>
 <eec01cbac16596c5e117843ae86956e1f66ec097.1757345711.git.code@khaugsbakk.name>
 <xmqqcy80wu0y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcy80wu0y.fsf@gitster.g>

On Mon, Sep 08, 2025 at 01:47:57PM -0700, Junio C Hamano wrote:

> kristofferhaugsbakk@fastmail.com writes:
> 
> > +static int is_deprecated_command(const char *cmd)
> > +{
> > +	return !strcmp(cmd, "whatchanged") ||
> > +	       !strcmp(cmd, "pack-redundant");
> > +}
> 
> This is somewhat a shame as you introduced the DEPRECATED bit to
> annotate entries in "struct cmd_struct commands[]" array.  Shouldn't
> this be moved to git.c and taught to consult that array instead?

Hmm, I did not see the original patch, as it does not seem to have hit
the list (or maybe vger is just slow today).

But yeah, if we have a bit in the cmd_struct array, that might be a
nicer spot to match. It may or may not be trivial. When I posted my
"something like this" patch I first tried to do it that way, but there
are a lot of ordering constraints and the parts where we resolved the
cmd_struct were not the right spots. OTOH, it would probably not be that
hard to just do:

  static int is_deprecated_command(const char *cmd)
  {
	struct cmd_struct *builtin = get_builtin(cmd);
	return builtin && (builtin->flags & DEPRECATED);

  }

In theory we could also have a deprecated non-builtin (i.e., implemented
as an external program). And then we really would have to match by name.
But I kind of doubt that will happen in practice (and it would still be
possible to add a string match later if it did).

-Peff
