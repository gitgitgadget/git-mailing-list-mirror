Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537493A1E77
	for <git@vger.kernel.org>; Fri, 26 Dec 2025 02:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766714952; cv=none; b=lIcTRQGOL7vmGWz/j3g3yJ3k9+g+vbNeX4wl/qIOGccsB68RDe33EFA1Tzkmn251GR/BO+LIro76zecVEHoxLF58L11PaxXIXkLWxGoeLpMnq8Y0Ex1rhlIS4cL4fnHYpNcp2mXBCMOzr+b9BlngJc/gObz9QHMoafdRnzLfGcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766714952; c=relaxed/simple;
	bh=c/AUNUS+iTAHwXKjlFcFv6xrJxWiAjiNC/uhTFibUFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ItMSFtLzLINHCBPzFvvzGfUBbKbDNvUQpS2zvmeGK9zHHUWcdeuJ+K52KVvKN/NOI0srbSSpQKPYXQ2/2YxftJRneMKOR3AdjP4zDlb7n08oJkPwMvBkJyZ7DAayGAlquEUOBez1GyM58mQussAZ0MU2xJS+boD9v85Ytv/QFeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DDXgvDq3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cbvxIIXu; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DDXgvDq3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cbvxIIXu"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 814D67A00B3;
	Thu, 25 Dec 2025 21:09:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 25 Dec 2025 21:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766714948; x=1766801348; bh=P7G6lmwqOU
	oXD5yPP7660LQI70TZnKjjC8yNkyuxuck=; b=DDXgvDq3D/+13spJ8e8cJpSkbq
	54hKIBKxDdcGEhme72bQGxgDlgsAyWNanWqwRO1gKrtE6jvIQJz1W2AdRUCSDU3s
	LsDmzEWBrVloL2js8QDqSjyZNKwGloboqLjYGdcFY1357taPS1zQq7Ukbq+vwuyj
	jI0cR8J6u3+b5SiJdETlvGPCCmWM7TMSJ9lZCAc1yjBbh0OhFsiIK54Nby++9MfM
	NKQV+exA/Lsxlj1QiropsKwyISx+CjN6jPtnaij/eYSVo9O3Sgn1zJTyZwPB0Hqp
	Ep5QY8MXfVRh/9KBzWSI7OA3mXrwGfsUODdyEGvd/oS4iE0RPQ6MQW2EmzNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766714948; x=1766801348; bh=P7G6lmwqOUoXD5yPP7660LQI70TZnKjjC8y
	Nkyuxuck=; b=cbvxIIXu2d4H/w/3zq8YP5bmE+fVC+sdtcW5G7d/eOPnI1RGuhz
	Cgvc1qeDEQC3DyUdYLDOAaVRPlrk2JC9rtnL50gLebyaCTbMwYmJTuOrvoCjAy9q
	7SyUAI/HFZmOn7nw71VtXvpW+ecCMKClYBmYVzXYhLhYyQuZFOSx2cSxy/6ZrhW3
	diwo3ppdRqp34jHD2SsYI+VBx6gNFmeUJdJX1x+IBIfZsBUQ9zwZXSGLSiSTeUZa
	XrNN6bQxE2LSOXY7jUfp4ByyPDifpbB+O2aaiPJ7be4h/JPzv1XlGqN+24cBBjCD
	ZkN46S4+dNz4SaNdtfjsK6zPiR/eCyX9P/w==
X-ME-Sender: <xms:RO5Nac1KXfj6d7LN8XZPrUF45DPxWNT55WkEtbjUutJR5rOHr7TbeA>
    <xme:RO5Naej-uv2gHjfBIujmxtrAHBo3z3K8RpP-ArTQwy3YeOFrc07XXJ45y-hJawqC2
    nIy7YniBD0UraCw7RbA8pIWsF2x7lzXsnsTxbmECsjrnWHAh1IbOw>
X-ME-Received: <xmr:RO5NaSQBAWx5MpN-H1nUbkilEvG8d7KPYP2cUeJnb0RTSuDuhI0utO1HCgutS6zqo2n96hF-G6DNeRTjMA1jebEsbxcTSthvrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeijedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RO5NafhXbhFRd6-2F_PTyhzpHKEr_jvNY3e-xWJrS59kSelzTn2Z_Q>
    <xmx:RO5NaS7ABSIBKFXVfF44YBINpiXFf2PATewWN-tLsO7Q_mEs4lQq3w>
    <xmx:RO5NacCoFcCmWE0iY3ajhx5zAyBuxyNEGyiq7jqfxM5qRbDDRYNiYw>
    <xmx:RO5NaZZjqL0rcnQ_jbFPgVbCVgJfYanhIqiFSMA6d_0i_lrPPIUBVw>
    <xmx:RO5NaShbHQiErxTlOVX8tCFDzSEWX7CHN5oxJe8JCKd_oaNAS-y64_Lg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Dec 2025 21:09:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Sergey Organov <sorganov@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Why git branch --show-current ignores -v?
In-Reply-To: <87h5tev918.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
	25 Dec 2025 19:08:35 +0300")
References: <87h5tev918.fsf@osv.gnss.ru>
Date: Fri, 26 Dec 2025 11:09:06 +0900
Message-ID: <xmqq8qeqm1tp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sergey Organov <sorganov@gmail.com> writes:

> It looks useful and natural for "git branch --show-current -v[v]" to
> verbosely describe current branch, similar to what --list does. Is there
> sound reason why -v is not supported by --show-current?

The "--show-current" feature was invented merely for those who
somehow found it ugly to use "git symbolic-ref HEAD" when a user
wants to learn what the current branch was.  If I have to guess,
nobody thought about it as a way to get the same output as "--list"
but restricted to the single current branch.  Hence nobody felt the
need to support any option that the "--list" operation supported,
including "-v".  IOW, nobody shared your "It looks useful" so far,
especially among the people who knew where the "--show-current"
option came from.

I do not think anybody terribly objects if somebody teaches "-v" to
make "git branch --show-current" more verbose, and other "--list"
operations in general, but I suspect that the exact contents in the
verbose output may have to be different from that of "--list".  For
one thing, as "--show-current" limits its output to the current
branch, the two-place indent "git branch --list" gives its output is
not there, and "-v" would probably not want to add it.

