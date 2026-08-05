Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33786480DCD
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946265; cv=none; b=NKl8V+WOAljjuJia/2nUfKMAZESRxQLOC3+pxj0nUWH8M6oEuqzW/VxJsAAREgc37dxt/9Rf1RqQ2vED4sbX1s4D4cY/W+D4A9bfJWfbC1/9t4QlxW2vYWOuKdvLFysgmFvC+cPzVxIErQbEaK86EdJ9z0CxQ7JPicdosU4SNOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946265; c=relaxed/simple;
	bh=QdtxpTsoD7EyTxTHQoFgMVMzU7MREj/GJV8pGvOGCh0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=enR6zJG9J1EPypfrdlODyr6WT+41nBIAu22fFayV+pj9Ub4cZBzslAilpL/gVwfJKzG5uuMyQvjfoVHlX+OzqR9bGP5ku9hv5MERj4OsNCfcXtUYlPbpBtYvjp5HWJVzqDXb1tmChjdEIcksJuJoSFzPfOZ9uGaYfH7XEn6hHaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HprQLYWp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jp7WOUFw; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HprQLYWp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jp7WOUFw"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 64D211D0015C;
	Wed,  5 Aug 2026 12:11:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 05 Aug 2026 12:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785946263;
	 x=1786032663; bh=oSxD9gabPsAl8LCKvf/22JFooJNUbrnQt2XwIZAS0rg=; b=
	HprQLYWpZpXA0vfZNKcxDLCUFQI0PMWbjvUJXVc4b4VTqHPJrxzd/Qdw7T21TWNI
	l3Lih/lyOlSG3sIxECkC4eHRjFswVWPW+GeFZz1hS7dHYynrJkmqznhy6lsBKyhc
	x+TDtVcyQ2EjH02wnKZqOcumnRHG4UcOq53t44TYmlTyJCOpDLC9n+dgR7ZIfzS5
	9iQk7HEX/o68AiXm31MD7FNwfMom1Vchm9w3LSlXO+PNiQQ3Lvs+PhYwZZfRwCBu
	vLCGO9d4tKrb8LVvq2zWKaa/C02FQQpTQEfV5lLRsJNfHLipzBSzTGRA2IseEWjs
	hX61Y3Fb19ZQ5Byi7qDtXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785946263; x=
	1786032663; bh=oSxD9gabPsAl8LCKvf/22JFooJNUbrnQt2XwIZAS0rg=; b=J
	p7WOUFweMgNQNLvIIJc7YJBifT6Qvi01XmijdIjSzoU9WOQoHTPhyZE7hwaST0hG
	vxoYPkA57e4TWRaCu+2iQpUBM+/SH4kw1tpyRPiduXk12SkJBRqCW9EK44Fj3sKi
	xwpq0EzPLRcirXxMB8fnyV3XL0S3acRh5PnTs6lXnDVExOJSFoYKoS8wcRulHjMp
	QM4hOH6S7OxKc9/Y4eXc1DpYhVGYLTMkrZFein3BIqVumRIhZ8pBc3oz92MpKH/8
	J5B22klLBlL+rXlD1jn4KReHrxFVMy5Detpuue/KsoKgenUt6h58eoLg/0XSlATI
	+ZAy6Tw2EzDoXXL0VSU3A==
X-ME-Sender: <xms:l2BzaqIqaV44PfUje7dx7aHznRDlPVSU2OZX_2YgevkXuyGw4dr2Ng>
    <xme:l2BzapJzm9tzISBvHWeaxkrVF5xZRVP8_SC1HyrEg3Ec5lLaqt_FsKXleg4O7K1jO
    h9OB9D-nedrZtjg-9q2FEwRZYejFi8SRx6QbBSmDl3bTcCKLdFF>
X-ME-Received: <xmr:l2Bzavtuh783yV97_qRgkMEKP0-Ey-avQMymp27rFI7ZPRu_T7WOVR6o7TGrj3V0Mh6ZSaRxwbzzjJSQdpvxPizwNQEI6VbsAQ>
X-ME-Proxy-Cause: dmFkZTEz1ClQxVJh2KvLp+8Kc6Bb94RzB6GoXr7BdXrewfROOIht238LJ3FybWBlfGfXKN
    n4uToD9Qsv7ejPJtDGsiYIcUs5RDxLfluejXmJ/FWDd1WKNUr6lbPLYhl6BP4xV74q0zoH
    zttb70WFq4E23V4mXExhWXHM+RnJFokM0HX3RXS661fsnlSMKJXENLXXkpLIMRtbdHUpsl
    CsD00s2HilmUZpTP/nyvCZw6wBxP44VjTAWrZEpA5DyDGE/7su+rdmScZ6+6HCzaUfYQXC
    M4SrrpCZfDEGFRNd3G5x0U5/7RZ4Bl3LAXv9Q3CpAIx2EWIisG1jeaE+oH8x0nMfbqGGON
    W0swqnhqyoeyIwSmiKgVBFES4KhemSwOnWAJXJbUKee11+7JUMMjzvt2IUkjpIhQlqB7Wu
    QKx//Szrcvb0Rd9Ze+O0z2YBz66Iqx2VOWLz4ejRjlHjQ66X4wt/homsVyZGJR5h7A3jIv
    yx2BXXBzs6ykEh8cSMAk02IsujQ01ZPbCkz3pey/doT90ELzY1ewWvtc92qJarE6EoI9fx
    70vwW4nqOGZ3ci33bwBtuMY4qLybv+x9OugkRRxu87rDWbOhUkKDAP4s3kY8SVjujiHYMe
    Y3wlriSeKKwxn19YlAcCCB2hyeD/wTmzOiyzv5fRMBb8GW/OU7qC3qi7iYsQ
X-ME-Proxy: <xmx:l2BzauTQ4wxW3vhUvMlefvgrBwgFyZXTbrYW0KyQBmqu-VHbjt3HhA>
    <xmx:l2BzatP-HSKzt6QYkrKTzOXPO47hG_uayqVRdNxWtNKI1D9rJm6AxQ>
    <xmx:l2BzarZf0azr2kRJz_Ili5Y9sMsIo_46Xfc1EXb490H4QXZqepaH0Q>
    <xmx:l2BzavxX1kgWS4L6ZJcdYkpMn93c-cyOsI4cwSxkpwhuxEYCIq8Myg>
    <xmx:l2BzavP8USJ3rr6zdoUTBxqx9zuOUL-sZLgd7CVUBhBL_5hk71raFgUW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 12:11:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: shrimech <eddinen77@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] add: remove interactive mode
In-Reply-To: <CAC2QwmL2HSzJEb5hPbukNdqBzvMd=6ObiDrty+6T9tZ0otmogg@mail.gmail.com>
	(Michael Montalbo's message of "Wed, 5 Aug 2026 00:15:34 -0700")
References: <20260805054611.128396-1-eddinen77@gmail.com>
	<CAC2QwmL2HSzJEb5hPbukNdqBzvMd=6ObiDrty+6T9tZ0otmogg@mail.gmail.com>
Date: Wed, 05 Aug 2026 09:11:01 -0700
Message-ID: <xmqqh5l8sg2y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Michael Montalbo <mmontalbo@gmail.com> writes:

> On Tue, Aug 4, 2026 at 10:50 PM shrimech <eddinen77@gmail.com> wrote:
>>
>> Remove the --interactive (-i) option from git add and drop
>> its associated interactive-mode documentation.
>>
>> The patch mode (--patch/-p) remains available for interactively
>> selecting hunks to stage.
>>
>> Signed-off-by: shrimech <eddinen77@gmail.com>
>
> I don't think this commit message is meaningful according to
> Documentation/SubmittingPatches[1]:
>
>     The body should provide a meaningful commit message, which:
>
>     . explains the problem the change tries to solve, i.e. what is wrong
>       with the current code without the change.
>
>     . justifies the way the change solves the problem, i.e. why the
>       result with the change is better.
>
>     . alternate solutions considered but discarded, if any.
>
>     . records the resolution of design or viability concerns raised by the
>       community during the review, if any, ensuring the historical record
>       explains why the chosen approach was accepted over alternatives.
>
> [1] https://git-scm.com/docs/SubmittingPatches

More importantly, a breaking change that will negatively affect
existing users' workflows needs to be accompanied by a much better
justification than a typical opt-in addition.

I could send a patch to remove 'git add' altogether, claiming that
"the diff feature remains available so 'git diff' will still work",
and yet that is not a sane justification for removing 'git add'.
Justifying the removal of '-i' based on the availability of '-p' is
just as bogus as that.

Of course, none of "I have not heard of this feature", "I have not
used this feature", "I no longer use this feature", and "I do not
like this feature" is good enough.  "I have not met anyone who uses
this feature" used to be viable twenty years ago, but not anymore.

Thanks.
