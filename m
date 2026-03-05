Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC0D3009C8
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772746060; cv=none; b=CKK4bTAxhZQa7mB853LYmviLBruea1bOfSv0nuSpXXNTOUk9hmzB0kNbHJlexRbNayshcslmEtZPqOW5dux211mboRfJ2j1z7lQyyJTQssP2qVgg72g8+ZjrjYKsIY5MaaPDv2HlkvBAomNpgm8hp94W1C4gXkvDe5rV0G0eQ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772746060; c=relaxed/simple;
	bh=cpWQNKlRlskZJhW/+n4iPPfrUGQhbZmfxUNzGMCO5AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuyq4WtxrL0JjRZleu8MgpMwzq3V5tidDzu+o61Uooc+vMzF5FSod5s5cNku8bVWq+cJ7tJqVG6gkYGz4zE6cf5EgVCoYPn4uNByY1GP/7yi2VvSYw0fGHzXiwl9Ln/TKmf/zDNWb93hJEOEDaoiPT1W5Wu3maTMzutnoz2V+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6as6vrp; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6as6vrp"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4638e238094so4826726b6e.3
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 13:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772746058; x=1773350858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sBiksY2hiF7l8LwJyoOhgkyYRXzzNpET0pS9b1kLMwo=;
        b=a6as6vrpNdlwZbB4q18amkBwJ+au4f9H5zisMZ9H/p0/yCjY/urx7guQes6rB5pr8E
         e3dDc0bAqEMsuJcnwV1K0hmsKiXlYlFrtXBU0Wzg21Ap8ahYdvQHj2vGLj+LmOk9ivfb
         pDQ7fAzEz6x/CBYnfSqYGQpr3J2ASfWwco5HmjodjlXavUXa9LqQ/we0YMETsHHL9PbZ
         9o7baaLSwqmdNxaaJapzzVW3cMCchfNaI55b+Vi2/RRvcA9PJJ6+afbyCPV5NHpb0ucC
         f3t9BpUwlptjZUPEWoSxRYlKa+P/z1EOFA6eUYmTxJFN2UDB+lUMnzcqE4MIu6my6peR
         57Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772746058; x=1773350858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBiksY2hiF7l8LwJyoOhgkyYRXzzNpET0pS9b1kLMwo=;
        b=pAScLmmZm7yV5489YR0C4Y5gWIqIyhZmi7f5D+qcmcSrjIEuGo8coaFCe2nIzGPtaV
         5lDCDaqrRoCUQMzUUqn2DzlT3pwlpg9ReP9hJZTZagTu6Ku6YrkfG9XSu9cFxsbKkDb6
         Km+9JiB7f7WEHZHT+bcHdXMzGHssyQxTLSe76o5n4XNkCXbTFyzYRzv1hIQ9uNG+M8ix
         /6wkZUSxdGTV3LJzXxOQh6JGhTRW6XxNXFGZCWGEEEwnmb1klfMBjd7uH+xRUsR/4f+P
         imIx69MU06osenFcuj6ZrwhH7CjlyXPd8rfFULjRilFsb3qP+Auklxkyer8rw5lG8ME8
         h2gg==
X-Gm-Message-State: AOJu0Yxf1KQbhrKHgOgKMLejp6aQW+BTDAGuBG17laxG77wRH42DBIuW
	Cn0fPvX8d4XbUJSBkyWHMjo61QcucJdm331OsToJYG2foD/ASddpwa+m6g6WGQ==
X-Gm-Gg: ATEYQzydAZK6H5Pl2D+0AniVLA+GQS2jP1dKdlnY715IpHJ0PNPvvYzwfrxE7Egutml
	9GNeZYwwmZ7IHY6b8XRp/xm7ZDPZovOzTqUyBsYzaFgVXBrG+jswxfM3UlOz9gGdDtwByKVTx/X
	hahfItl/8vvAy3ffcZbTVpwmn1Z138UOPQy0OAbPtC4MCdwqyRuXfCrLT4FCu+G166ZniZ62iaI
	VJp4X53wM/T4QtoWX8gxOysXPklOif8mRn/7dfDa8AsS0NA3NE8Jymbf4Xnjqi33G0o753vsNUm
	U/izZnXHDyITYsbeDA793/jmN7/YUzDFaaNRD5sTJcm4ROHbx6XlgwExv51f8VCv09bQJlAQ+tr
	txn1NrP9NfbaEmbdN9NehvWCjjI62XWqzCtWXglonYHLhl9+WgbZBn9QuLb2qzTFmgIgsj9kYrs
	fstbWQqYyqBHTDe0eYYXW3w8QLk6U=
X-Received: by 2002:a05:6808:e88:b0:45f:131b:db4e with SMTP id 5614622812f47-4651ab6e770mr3987771b6e.5.1772746057843;
        Thu, 05 Mar 2026 13:27:37 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb35290fsm14202718b6e.4.2026.03.05.13.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 13:27:37 -0800 (PST)
Date: Thu, 5 Mar 2026 15:27:34 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH] Documentation: extend guidance for submitting patches
Message-ID: <aan0FUBE1LwrFc4y@denethor>
References: <20260305193836.973122-1-jltobler@gmail.com>
 <xmqqikba2evz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikba2evz.fsf@gitster.g>

On 26/03/05 12:35PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > Before submitting patches on the mailing list, it is often a good idea
> > to check for previous related discussions or if similar work is already
> > in progress. This enables better coordination amongst contributors and
> > could avoid duplicating work.
> >
> > Additionally, it is often recommended to give reviewers some time to
> > reply to a patch series before sending new versions. This helps collect
> > broader feedback and reduces unnecessary churn from rapid rerolls.
> >
> > Document this guidance in "Documentation/SubmittingPatches" accordingly.
> >
> > Signed-off-by: Justin Tobler <jltobler@gmail.com>
> > ---
> >  Documentation/SubmittingPatches | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> 
> What's written in these two new paragraphs are all agreeable, but is
> the first addition in the right place with correct mark-up?
> 
> This whole section is a sequence of bullet points that shows "a
> typical life cycle of a patch series".  The first bullet point
> starts with "You come up with an itch." and the second one is "You
> send the patches", whose end part is what we see in the pre-context
> of the patch, ending with "help you find out who they are."
> 
> If the new paragraph is meant as yet another paragraph to elaborate
> on that second bullet point, wouldn't we need that "a line with only
> a single '+' on it" before it, instead of a blank line, and the last
> line of the first new paragraph should not be such a "single '+'"
> line but a plain vanilla blank line?

Ah yes apologies. The first addition to start with a line prefixed with
'+' intead of a blank line. I do believe it does already end with a
blank line though. I'll correct in the next version.

Thanks,
-Justin
