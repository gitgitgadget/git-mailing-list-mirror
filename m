Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D3307492
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783803247; cv=none; b=ltkFXiW7Z2a9ZUouVRPeOD7Oz+BLq+XCiyndSGRCgFobt7qv2TyS7FF4mqLnNaPrqgv/qb9yzSjRAPqpm7np6Fp+1UAqmB3Z0kBJFGkm3qBPIxQOOa3fmRPI5Lfqeyv9J68bV0NHkgS/xi2bSdgt88UCpm7PzogXxlSkwv7xIYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783803247; c=relaxed/simple;
	bh=g+IaiKM3k1g/+iQmrZlN5figmC6PwFA+VjDFMOIJVbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NSOkaIt2Q3r0thp0gcOsdZokA9Vim6+bBSAzhh+88CScd1eDvCf31ReQ0SXVGNVP7kjMJet1KPjrhQIDLR9Ae0FN/NJXsg2tDsRmA5oVRdLOaPVFLYIOm9Po5QDQlKT/amT+zZUKLvHhhkslHHUGjrEGuw0I1up8z4hS7bpwuQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IM9MfRP1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H5xI/ilA; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IM9MfRP1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H5xI/ilA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 97B4B1400052;
	Sat, 11 Jul 2026 16:54:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 11 Jul 2026 16:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783803244; x=1783889644; bh=3G2Ga1JkwL
	h0FF7YmUOcOlSE3K6zvZQsXssI3Vqo9mc=; b=IM9MfRP1T7AXRyyZ0DWwe4bN2M
	4RtPpi7htf23VJER8/jlDpBk2ukCE9TaWyknngcPWO8v83afHtHvc3XYKvswcUiX
	H57zENCSliVg0nQWKntV8B4kvuz0mW4NiJRD93S6lYli8/N9IKR2eU6ibryRlpIf
	rfKdPKW4HZ1HeEQqUDctFEWhpY7mEuAURIGI7l9D7nW4AZZLNNC/VFVd4TdKrGcW
	snIILldMutf7KBNXQkKheWEYuNesqQTJdFeevQLhZc2THiuwGTZ46NESAxMOqbNk
	JAwdiak0acwzPqaVH1icwcyGLXYDLnLvypccekFVwvnsuOuR6L9BpF17heNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783803244; x=1783889644; bh=3G2Ga1JkwLh0FF7YmUOcOlSE3K6zvZQsXss
	I3Vqo9mc=; b=H5xI/ilAak1WS4gYGCLJltaA7jpf26IaPrrJO7IiMBP+2VbpBxC
	l2MM5DgoNF13YQ/kdYpaXqVRRh1vr6goa+4YULEjp5xavjWG6cUqoTz1q++vovJx
	Fit+ynZRCYud3nD4CW84bppqtgQB8U9jKxLMPHWQUOiYGCusmnksIRMOoWe7jsWo
	6f6I3rjA3JYHdyhmf1O2uKQw0psSN/HGd2tVkj85BBMD9rvJyx61yHYdb+H2siDD
	hb/mtyFp0u8etw4upp02F1Q28XIk27l7RNcU1bSGLCeo3OBZ6ZHS8Qkh5iG11OTe
	SDSok0q+r+rDNlv9xDWHESJ6DeuXEiiYYEw==
X-ME-Sender: <xms:bK1SalE1Fr1JD8EBe3_tw4uEk5QVpGs6F9m0Q0JIlCtMrWVL_HOhgQ>
    <xme:bK1SahU6Nj69yzmgCYlBX8erwqV60-SpfRQ3lE9ZsQl14u2Iom4dCzrNAMR69OKF8
    xqaSjOf0BhCa_w4j_Olvk_VnAJekqDvBasqHxwplHN0riDve5nreQ>
X-ME-Received: <xmr:bK1SasKmi2Q2mt5GS71hb9_p_Bw4uKrsKiBPW2Jy279wmB3oHykb3ErsNvI8m9YNZvUHERyfLHgYcFP0LjExon1d0H6O2S6cnkMxoRY>
X-ME-Proxy-Cause: dmFkZTEaq+1GZw6Hp45sQcPmpj2vhjv+hpBjhYI9Xsd1Q45eEnlNGM7CYDh15eq8zptsug
    MiWPT7cmQtJUVs9EL4jv0AMYu0X3FgwrtFolHxmORHtK5D6RrgW9BYXV6jpyZUMzJLG8hc
    4zzIoDJbUsC/2jObTGEfb+3KGHxvcX7bMP67oOdecJDYI3iiwJEPJx3QfLVCI3xUgmOWNj
    7+SShF+TvZzh5LBKNAS963ocimVzOMEKs5BNsSbZH9ryW1y3ho2Kx9XFtqLVcTqvGuxKUu
    9lCbreOtSk91YoarGM05dSVqOWCiQZ52nrN3+NOBz2zF7IPYNlVRbaBKgYcYXTGXs50nWw
    vgrBQ+W1pT6ioP7BwwP0PvjtAnmuoD+dta/4IpkACumOA259AO8AB7AXn0HAXh8oNAAePW
    o2Q/IRiZWDAmdrMQTswEfTsqLiHzouDBehQCcO0B+3Bpn/YWMbpZag0sORd/DVOQAfyeIU
    qdMj9xBPrWRlF0qV1/TZopH9YvlCCb+luMSz25JrZWxd9sdjGZ9FM6fwbBCKyc8On/jTtH
    eG0grqGJT3R3rhLaqr849Ww6rTNsU3tvJGlEOdcFq0ZmuLKt1DjYmVa1ktWtqMwgl2L4Qi
    e7ZVsOniho7va74pNVEelUth9fbLW9sr029pSAghhj1HL4ovjqB+aJ42WOoA
X-ME-Proxy: <xmx:bK1Sap9aQBenPCwMHW6DyxbKJo57NYc61bzQR4X-kovwn1W2q_Bnhg>
    <xmx:bK1SanKlptHTJT6b2GtJIH-egwR5syiRjJxAQYBaqROCnjnDHYkyEw>
    <xmx:bK1SamkrR6xVeKUDY9ZO6Hj8czAWluMzRXEOJ7VxMuAbUoRMIpfRZQ>
    <xmx:bK1SajPlBOZCLTninSEhJSjf0z5j2Vj39jh6wnL0L5Mho2mBZfuo6Q>
    <xmx:bK1SasG60wb9RkJsVlO1y02gVyi9h9aHJyZb34qgKmOKeLU-nD65b_DW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 16:54:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Omri Sarig <omri.sarig13@gmail.com>,  git@vger.kernel.org
Subject: Re: Understanding why Git defaults to show author date and not
 committer date
In-Reply-To: <20260711080331.GB1470749@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 11 Jul 2026 04:03:31 -0400")
References: <CAP9es6tyaGwfTguz5zgBmE5xN7MLDN3-rxRfo_JJBf79RCNzgg@mail.gmail.com>
	<20260711080331.GB1470749@coredump.intra.peff.net>
Date: Sat, 11 Jul 2026 13:54:02 -0700
Message-ID: <xmqq4ii5b639.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Fri, Jul 10, 2026 at 05:08:11PM +0200, Omri Sarig wrote:
>
>> I understand the distinction between the 2 formats, and I can see the utility of
>> both. I'm curious about the decision to show the author date and not the
>> committer date as default one in Git commands.
>> Are there some workflows where the author date is more relevant, or is that
>> mostly a legacy decision?
>> 
>> I'd be interested in hearing about workflows where the author date is the more
>> useful one, as I use the committer date almost always.
>
> In a workflow based on mailing patches, the committer date is usually
> much less interesting. It is "when the maintainer happened to pick up
> your patch", as opposed to when you wrote it. Likewise, we show the
> author's name by default, not the committer's.

True.  In mailing list workflow, the author date recorded is usually
the date that the patch was sent to the mailing list, which may be
later than when you wrote it, but is much more relevant as that is
closer to the time when anybody other than the author have seen the
patch for the first time.
