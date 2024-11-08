Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B17208C4
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086208; cv=none; b=lIRKX7ehyrs59Nktp3u2VOBi/piYihpZ7E0I7ZrJVBd/Zt6hXclpSaczGZtFqM+qjuRWbGXlP9g2Mok5zEDMrmciJwgE3rwQhi0pUjEPmmZKTtSZxJKvR3CPIRV24QPRzspbaYCbS3vIwl0nzlJbq6wnycaaCeZiuuL8FiOVz5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086208; c=relaxed/simple;
	bh=fjQBXJ7bTch5uoEMFdr6ZiwN7mhbCwSD/zngM/th0Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9DxKE2z7bk+f7QbwY9yGdw3HYHD6ENq94A3KO6NflguJlFEJ5XcJeTeEO8PhyN/7ZPM1bpV99Uj5VLDVTfo4UitqxlHa9oa+qOQ9983wFnGvwH1YqUtKgm9V9eRVzWvjMvFjusdvynr+g3NUvmJ3zHc1U7jv6gL2e1t21pw9po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Y2EqeYdj; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Y2EqeYdj"
Received: (qmail 13312 invoked by uid 109); 8 Nov 2024 17:16:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fjQBXJ7bTch5uoEMFdr6ZiwN7mhbCwSD/zngM/th0Fo=; b=Y2EqeYdjCMDFafXxfBiFIqr1wAxUZmZMWclUDPfzMIpe0NokOAVlhWuRmj770b+7pIn7vPV686IbjWvhSdANcmZj9OJENah+vfDzUqNcSfkvWlAF1+iUCnsdtdvnBSirSxLqutOAePqvYEgy813i/lW/fEUS/yzvXYgLGm9+GRxWbs9bKx8nlpi56gml/axuac6pMKJ8msxeP4apkSTNjkup7c3YqzS6FxYRZkhs7iDKb9FqGQrZimZWBtzp55foDeoGxDTa+igEabw2HLUa+Aq7bsREPGauwZutSxWFV7Zsmjd3+g0pHUs7VclkTnmsqySARvxa+11awdDB+q1gRg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Nov 2024 17:16:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29938 invoked by uid 111); 8 Nov 2024 17:16:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Nov 2024 12:16:38 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 8 Nov 2024 12:16:37 -0500
From: Jeff King <peff@peff.net>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] t6300: values containing ')' are broken in ref formats
Message-ID: <20241108171637.GA548990@coredump.intra.peff.net>
References: <20241105190235.13502-1-five231003@gmail.com>
 <xmqqikt1qhwt.fsf@gitster.g>
 <20241106022552.GA816908@coredump.intra.peff.net>
 <xmqq8qtxqcye.fsf@gitster.g>
 <20241106185102.GA880133@coredump.intra.peff.net>
 <xmqqo72rvjqk.fsf@gitster.g>
 <Zy2PV+yywkS64D1p@five231003>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zy2PV+yywkS64D1p@five231003>

On Fri, Nov 08, 2024 at 09:41:03AM +0530, Kousik Sanagavarapu wrote:

> > Then things like
> > 
> >   %(if:equals=%(upstream:lstrip=3))%(refname:short)%(then)...
> 
> So if I understand correctly, we grab the .str and operate on it so that
> we expand the atom within it and then do the comparision.
> 
> This seems nice, but there is a problem.  Since we always look for the
> first occurring ')' in our format string to indicate the end of the atom,
> we end up with
> 
> 	.str = %(upstream:lstrip=3
> 
> (the call chain is
> 
> 	verify_ref_format() -> parse_ref_filter_atom() -> if_atom_parser()
> )
> 
> Since we have now left out a ')', this ')' gets appended to our output
> buf, which would also show up in cur->output when we do the comparision
> in then_atom_handler().  For example, in this case our cur->output would
> be ")master" instead of "master" after we get the value of
> %(refname:short), meaning our comparision always fails.

Yes, though I think the parser _could_ be improved here. This is
different the earlier case of matching "ref-with-)". In that case it is
syntactically ambiguous. For example given:

  %(if:equals=ref-with-))foo

you cannot tell the difference between:

  - matching "ref-with-)", followed by "foo"

  - matching "ref-with-", followed by ")foo"

But if the parenthesis in question is closing a %() item, like:

  %(if:equals=%(refname))foo

then we know that the inner ")" is closing %(refname), since parsing it
as "%(refname" followed by ")foo" would leave an unbalanced pair. But
finding that would require a real recursive descent parser, rather than
a blind strchr() for the closing ")"[1].

In the meantime yeah, you'd have to spell it as:

  %(if:equals=%(refname%29)

which is...deeply unsatisfying.

I have long dreamed of throwing out all of this format code in favor of
a recursive parser which generates an actual tree of nodes, and
implements all of the ref-filter/pretty.c/cat-file format placeholders.
But I think it's a non-trivial task.

-Peff

[1] Incidentally, the "%)" I proposed earlier would also fall afoul of
    this problem. The search for the closing ")" is done blindly without
    regard to possible quoting.
