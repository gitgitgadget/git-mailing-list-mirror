Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26C40E8CE
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665779; cv=none; b=uMxWvMdJI0hZyFxd7WTi2fvXzZMJYy/V1qKFWrrG2JjcE39e4fSx1GjU7zZ+swoZGwJYuSq1vIBv2Lvtp15ezVtCEFheKRn2i3P8/rT2IrgORYHvPWuUImXAoNtP0IBiKfHxyQ8giEDi+24tSKvf107NwnBOJp7IeN43opbACAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665779; c=relaxed/simple;
	bh=6ny+swZzFtWNRB1Ju22qbZcwOwzkslvLkKyWOaWqyII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHxRJa4fmRGOrxZVBuzZBoe3c7xd2xzk8cE8cGRuy1Rr54iXViDwDHhA+8ZWr58jdPkdJi5dPSQlaCyg6ghpFZaEJFMJ3ck59kImDXr/vRViKk1SbxCbYGKrdclDzFChOh7nWQSg9jTnpqmA7B5+umFdqPen8DttctJICAppFuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UNLL7I6M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jDav1P/F; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UNLL7I6M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jDav1P/F"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0801C1400123;
	Fri,  5 Jun 2026 09:22:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 05 Jun 2026 09:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780665776; x=1780752176; bh=PFnVROGiCh
	yPtUMlrci3KaRpk31pB3e7YyEtJEGrrgw=; b=UNLL7I6Mp1Oun/3PHybqUF+Kb/
	9zOrB/6gZ+aaDpLdH3UeTEyMRzsKO1kN0hBmmt3D2iYdfZszBwb6OmX6evqbTWgT
	In7gl3Rvfffctz9l/eIeWIdJB1T8Q9Wm3xavl5mEwpgFJLFcCSaR4JJYBUQp9plA
	OqnJYB3Y9ECp7b+/697gwsj1jSI/8SKlm9N1Zqt/y/+WhMUskPzYQhpE8/hJvemx
	lV1BGqm7dUzp8qxQM74RPQ08I/KRUmDcs8jAJhHVWCs9Zv6Mr7bBLvw0mYQWo2m5
	t5Nwkgr6zRd8I9D507o8G6+ohL3aXJrn9EC0iPQsngOCo6W6Tz6zy0twvxhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780665776; x=1780752176; bh=PFnVROGiChyPtUMlrci3KaRpk31pB3e7YyE
	tJEGrrgw=; b=jDav1P/F+DarjMR8+fQs4H60eRDHn2tValenvl9kMKLVMEkfULy
	9LbOE+3qoo0DuhXYPCJ0ZBUHHUC7QQPta/IMQ6i8giJNlnQzMIxJse1btelv++PF
	PFPvvf1V3yrb7+54Yr2+u8Q0cEXEzHwgyzAf1MB98Zx2L49enJqc8IsXjvKfLjZQ
	xNInLDmvT+swC6GLjsPOGHYWYc8EeLciojsPcpI7A9SszcEhp9cn7WAGxZ3sP4aN
	BFZCIq4qEakh2O9BsLO/xddzanq9isvBLHSx81jVAxPW917I3UKhpS1dgQ+J8yJt
	pZFyHHgyzFsID4B4tU6tAtYALjbE0oM4KAg==
X-ME-Sender: <xms:r80iaqYT7BbhdPyf77X18sc4ptc87aNacDle2bZH0QDzoQnwTH0NUw>
    <xme:r80iamvxINF81CmUKMEyzzdJ9olvd7DmDZkihotSEHuKAs4j5JM0OOCezx80_jLrS
    Y_Uyz_Q7A3lCCg__4zfVByxcsy8sI9djUu3yMKhs_gLCLWfB1sXsQ>
X-ME-Received: <xmr:r80iasO7BmPK1oeWBYXnaDFjb6wivCgee6dL6RgAvzm18G9488Jmh1t-YOTFSf-Zeq4R0DVUWA2hTrD4qWEonxEVAAAxRH2akZT3BlgkuQ>
X-ME-Proxy-Cause: dmFkZTFFNjOXlazWk/NgnwXQHT9D5G9x65Cq7N59eSkmeW2bSpltvJfZllz8GFBwKV/g0N
    tGQdzL5Y2Iuc0zu3jnj1S5nNcsAC4AByCycwuj/EXumxXaLsJmjx+Scea91ekGq/HcSrRO
    i4EShjM/cW4/nd9rT3ziYpV878PXZbKHIevz5AKB3VTJmQno4XHrRsbTLPNEJ/Ta5zgzwj
    M8CJBphCSh9FzWWQtLkcZdUWgIhahRVx62PIaO4R2M+QGuyt8w7GD/nQACfr1+iZXBwO1z
    logBTcG75c3W5DuXvzsCALJP3YjkfQH4ZGS9zdpw0D5BZnGXODwthQHcnQZnH1u0EZrXS3
    iPcZkgdANozk1nnZXUYynx4/cUmdpl/ne34D/CdHYrPVhUFTK2jPMauQnmZ/qIabbjZ53X
    H69de6Zs46S6yI7781b2XhhPVdks+Z8uHJKkiMO34ElYu+QQZ8EBsG0KWqRMi5OHGAuNd3
    enTOnQraVB745wxwbKpep1jCWpMsgAdmDRVukG1i47BlGV7cIjPkdxlM0drMXJR3Ihhyex
    0d2uT1FdYGhR5XjY/nQQq4qF57/+aen3FFDlj9/c2xwnkOvkim/z5C6Jv+1Vk4VMeqgMhL
    xuuNpLip+PXPu2lZLzFltpDqETk+n24N4Pb2xlxNUfSVcn9uVj7xjo7oGDRQ
X-ME-Proxy: <xmx:r80iat5Cg_cx6OJoNWH05S1Tz3iLfd6i45KESjxTYB0iKzT-SzZDFg>
    <xmx:r80iaiRjp4e95wzwF5Q67lhBCn0mpwufkya7l_ctbWQt-CRsjS0lKw>
    <xmx:r80iaqCSVcGMMPAHoiJddZ8cowB0lyIk9xVt-nu5_h6pQYo6QOLUDg>
    <xmx:r80iaiEK7wlSDjlONQmYVC2yyaIOJ84kwu2KVpNy9KfJx9-JfsGLZg>
    <xmx:sM0iatvrqC8O9YNJsWz6DqtscWtF5PCDNkT9J4JW9dTF8bv1bsPIAhOG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 09:22:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d2eb6d61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Jun 2026 13:22:52 +0000 (UTC)
Date: Fri, 5 Jun 2026 15:22:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Dominik Loidolt <dominik.loidolt@univie.ac.at>
Cc: gitster@pobox.com, git@vger.kernel.org, asedeno@mit.edu,
	asedeno@google.com, avarab@gmail.com
Subject: Re: [PATCH v2] compat/posix.h: enable UNUSED warning messages for
 Clang
Message-ID: <aiLNqQgiQPlviB5X@pks.im>
References: <20260503151210.36036-1-dominik.loidolt@univie.ac.at>
 <20260605094647.94805-1-dominik.loidolt@univie.ac.at>
 <aiKnqlI7WdcskDAs@pks.im>
 <aiK4BR86cuq5bmCe@four.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiK4BR86cuq5bmCe@four.local>

On Fri, Jun 05, 2026 at 01:50:29PM +0200, Dominik Loidolt wrote:
> Thanks for the review!
> 
> I noticed that the version-check style now differs between GCC and the newly
> introduced Clang checks, would it make sense to make them consistent? Like:
> 
> diff --git a/compat/posix.h b/compat/posix.h
> index faaae1b655..e20f8ec61e 100644
> --- a/compat/posix.h
> +++ b/compat/posix.h
> @@ -17,7 +17,8 @@
>  */
>  #if defined(__GNUC__) && defined(__GNUC_MINOR__)
>  # define GIT_GNUC_PREREQ(maj, min) \
> -	((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))
> +	((__GNUC__ > (maj)) || \
> +	(__GNUC__ == (maj) && (__GNUC_MINOR__ >= (min))))
>  #else
>   #define GIT_GNUC_PREREQ(maj, min) 0
>  #endif
> 
> I think the current GCC bit-shift check is harder to read.
> If you agree, I could send a 2-patch v3 series, which would also clean up the
> comment style nit.

I was wondering about that, too. The question that I have is whether
there's any particular reason why the check was written that way. So in
the best case we'd do some digging into the history to figure out why
this looks the way it looks like.

Patrick
