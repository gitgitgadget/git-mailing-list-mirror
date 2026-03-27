Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6A82899
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627114; cv=none; b=iKUytO44P8iGuUX5pgGebP1lOh2ARD1icdLBvEnPUexRGnisVVRakoH1VwJ5l/EirNO9V2IHV8qu0aTxP1He5WrqrvqqrhkQAoeuxZzZcFejU7A1JBif/YwQ+OhU4oqEOBtnhmkgJ2nOAQYJJk8d/EZNnOJZMI+GNp3G04Ci4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627114; c=relaxed/simple;
	bh=9xCjp6o7kQuGRG3YxXuMPZ7xKvsca035GVDK3X+rcp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JY1dni7/e7WR3wLAjXTtD04OtuPY1A3WOpFrDkRBF3cKFSi6mOtcFYtBolIFM+aCf90ULiAcxj+QFMjJL0YStEyywH7Ic7sNzCJB0BXGnE9MbmYusFAJGj9uax467j95hchdfuGWym2gdKtUmlodHm40yxllwLJxIYf3WO5TYVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A4nbIMPq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ovNAliQR; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A4nbIMPq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ovNAliQR"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8633D7A016E;
	Fri, 27 Mar 2026 11:58:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 27 Mar 2026 11:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774627112; x=1774713512; bh=hPGi/A3vql
	5dQNo+liA1lY/qxN//ZTv7+CnwD1gvth0=; b=A4nbIMPqoqpQrOduISw/m4CaG1
	A0PXqnl78c0gDc7bDPCcsUcFvnXAFMHGXaWJ9lXxZ7pHLEt1p6j5awfjDm1r2CEx
	t/WDJwrFE/KyF7afS4Dd3bRHysBZuZR1AK1/DT3xhGIo8MdgQyrw89VEnx0T7ISF
	Yq+BCwU7xodfzXv0lIAgszf/L6wwqNM/tkspijtJGwHzuDN+FUWpfblZgxxK/Drs
	mpfmuUELmvIyFLdasHGKsUJYEMoPBB7QEWSA9DDjp7NeVRqI95fd4TkLlWorfImX
	/LgcpFtQUKbGUuqbyVQissE0oDpOSVssZPEA0ebX7HzgQ5ix1NsG08Z2e0WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774627112; x=1774713512; bh=hPGi/A3vql5dQNo+liA1lY/qxN//ZTv7+Cn
	wD1gvth0=; b=ovNAliQRQSAQxDmxWqaZ2MhpYu6J3+1BwInGcs8Z3r5A4WtXY/Q
	Hj2W2siM8SXAb0ibQ7vM3sXCBs5rAXnO4WVcXA0uzv37RPGpU46ejWhmGNDZiHmU
	bCyPy1XhjgPWWChbqiq56c4Vb1QjNHiAVED7C5IIzreEg0CtUoB9EM6AmGt5Tjqr
	0JiwhwCCPprmP5Y78FX6pa+yClYEHVCH5CfOtQqaaApeCt6Q6Dw+dtUrIw1ufgWs
	F9bSlATpLL477XyJjvGK5sOTkDOzdEps64D4JdMQWLEjBJY25q8vibWRMYt+FhVV
	PJbmTiZz+M/6qDuuDq6YVfCWeH82W8yFpEw==
X-ME-Sender: <xms:KKnGaU4s52L00lFxr0QdhpLZr3_fzSk4ejqbF0wdMLuOZvOl0TtC3Q>
    <xme:KKnGaZkylUFEVJJ5T0U7j_D_u6dgJeoSIo7FcySOtSYQoGGPtrozanznIAkKcyvIf
    5o-9BWD1kI5pQ1LNoILv-9JdoTBbxeYqpfDpkwcvchaKzBM5ILzhw>
X-ME-Received: <xmr:KKnGadRby5Nhy1lLP7HENu4r2JR8wCld8nLqBS35zZ3NLQXpv7ERIVFgdgPjdDsK9J_dk_AAXij6HPq8F3u99VBWQ-weBlJ98g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprh
    gtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhhuvghnthhinhdrsggvrhhnvght
    segslhhuvgifihhnrdgthhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:KKnGaQEBdAXxuTgreaXIbyEloGtztDHKmSYxX1TSpRO7U60V1AuUUA>
    <xmx:KKnGaaEirbylSAXL2R4DgZW1kaEQoPnzlpB0K07CzW5DPh1SZeBLAw>
    <xmx:KKnGaWSDcPxRQgQS0wASU_JRbW6ETlDGigQXzKXQnWCAmnqDgmwdzg>
    <xmx:KKnGaTJALHgcWNzOdCNUTl9mE4gFLfWt2BIdHWgbRuFUWvkvzKG_Lg>
    <xmx:KKnGaYZWd79VcMHwwzxFlZx473jZ7hGLPXMQEJKeobauEJZzipJ0WvL0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 11:58:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Quentin Bernet via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Quentin Bernet
 <quentin.bernet@bluewin.ch>
Subject: Re: [PATCH] docs: fix git stash grammar
In-Reply-To: <acXIl2cuBv0ifiK6@exploit> (Mirko Faina's message of "Fri, 27 Mar
	2026 01:04:51 +0100")
References: <pull.2255.git.git.1774529148151.gitgitgadget@gmail.com>
	<CALnO6CD-5NBUoooMD+pQAxeyXCjkZ3Za6LJrLrJN57Nrz03xBw@mail.gmail.com>
	<acXIl2cuBv0ifiK6@exploit>
Date: Fri, 27 Mar 2026 08:58:30 -0700
Message-ID: <xmqqqzp5mfh5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> On Thu, Mar 26, 2026 at 12:17:46PM -0400, D. Ben Knoble wrote:
>> Now, _is_ the grammar bracketed wrong? "git help stash" says
>> 
>>            For quickly making a snapshot, you can omit "push". In this mode,
>>            non-option arguments are not allowed to prevent a misspelled
>>            subcommand from making an unwanted stash entry. The two exceptions
>>            to this are stash -p which acts as alias for stash push -p and
>>            pathspec elements, which are allowed after a double hyphen -- for
>>            disambiguation.
>> 
>> So _if_ you want to provide options (other than "-p"), the "push" is
>> required. I think the existing brackets indicate that.
>
> When it says "In this mode, non-option arguments are not allowed"
> wouldn't -m be allowed as it is an option and not a non-option? In fact
> if we do try to run "git stash -m something" it does correctly stash
> while if we do something like "git stash pathspec" it does give back
> "fatal: subcommand wasn't specified; 'push' can't be assumed due to
> unexpected token 'pathspec'".
>
> If that is the case then there is an issue with the way the usage
> tooltip shows the optionality of "push".

Yup, you're right.  The current SYNOPSIS suggests that you can omit
and say "git stash" and it does the "push" thing, but when you want
to give any "push" related options, the command name "push" becomes
mandatory before them.

If the log message said something like

    The "[optionality]" bracket is misplaced on the command line for
    "git stash push" in the synopsis section.  It is not like you
    can omit "push" only when you do not give any options and
    arguments.

we wouldn't be having this long thread, I suspect.
