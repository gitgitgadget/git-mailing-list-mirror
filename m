Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28A13375CB
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919391; cv=none; b=Qvw2aUije8dvtP7TuGMYqR3Uo7l2fGUEHnMaxYc+Ef/VgDjmWa3Tpz3KfC67mWsgfQaLN+ykFgKPNK2b/u2BspdcC3+9T5yzJvVRiBmxyy3ulOlYuJ9E4oM+PLm13hY++XqCgRCN/dddWgMh1KA0o60bSEmhQrh+bUeVXQ/yT+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919391; c=relaxed/simple;
	bh=0Kw7I9Jy63xCeN8BlnWi3qojHTIOb+0O1tB8c+UFcg4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y0N2UkVjygB9oPSDThicDtctf0kJsXy2Z4kGEb7ZTVJUI8e1VF+6pvVxLeKqKLLBsxfDujUQDcQaXn+riibkL7zt+jC36tGQ6VcK2eSb8xfOojdEreABFp+MSpfLe+DiUQsLIbgcL1fK+wBft2gCaqhBVXUsxPe8TX+AdvUWEEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cw2WF2IP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xLU/+26N; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cw2WF2IP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xLU/+26N"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E06C14000C2;
	Fri,  5 Dec 2025 02:22:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 05 Dec 2025 02:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764919370; x=1765005770; bh=HQlf4OTAow
	3opZc2FY/Fv+GG/M6sJSYP53mY095H3yc=; b=Cw2WF2IPwEXHvcemQNLcJ0k5KP
	tyqgfNPGdd8RGWrNlrxh4Z30V7d4nVFHh0HRHpDy2ZrWy4VTpcvXDEg3iglhBWXU
	tGUaLPEarIopDOhTa6cg03GBy1kRurr4/KAsYzQZKeYwmkczjHMETlVJZhcyvIGc
	wQWvdny3XAzFyMdFuFfEzR0uqvvod+bI0N0WHZGcn0PULhWqflwKVcQLtgwhYv4j
	baKRx83s8qs9o8jeIIWiQ23VYyMaQ2Fp65sxWgpqXwsUjzJ1CnEtoiRvjnE3FFNZ
	zUsNOpRIY+v372Ky3G7EgAjvmyjxU8/dUGkeN8ihuhKJ6FSV0yxEE5xJ7h8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764919370; x=1765005770; bh=HQlf4OTAow3opZc2FY/Fv+GG/M6sJSYP53m
	Y095H3yc=; b=xLU/+26NoZ52dQPiA1BdHBwLhHPhaxjmqLGbP58r4ghhN4+15zR
	gTrEN/ArRsJ8cbR4kBh1llaASzvSvkzc/WZGdjWOjVFkmiP6mMAX004ENyij+9tk
	2QZiaTksSgVsxX/JgSURslN6nSthPsS7mYadGQG8SCuEeTofS9yMqD/y2rZgS3I3
	A8St/kT1cKd7x6LXQcFOniG0OEUDALYy6bdBV3ePRnkFgSU7WZORh7G68G+g8+rw
	7N8ZHxf4lkMOOPSwXn5TGWfsYGkRcARlQkXXGrZ+8AVqiVobf5B3c6RiJnNjiVXk
	MwJURd7l+qemYM7JinI6SN632u9aHcZiKTw==
X-ME-Sender: <xms:SogyaVi1CZ5Fw1VWDNPosLB9WgVgxhc2c2Bb3FwZUIHbRP8xtku8EA>
    <xme:SogyaRAHXuPMx8I4kiSeMHC7Xkrz-13vfC4hpo95_GjoRB-gwGSBQy-pGePHwmQWm
    iYorA_L3PUmaNG9DyYTp-lysg5ixVBWiE-3BoOKxmp1T-xnM3f5hg>
X-ME-Received: <xmr:SogyaaFvCxqu1j0W9G7cFkg6PWqagdZXKWGFksqc5oyfD_hp-PRAVzewRPmbhqYxufGFV_O-XbxV8oDqb2cj9a3K93mb2ILatsaR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffue
    efjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggs
    ghdrohhrghdprhgtphhtthhopehtohgsihgrshdrsghovghstghhsehmihgvlhgvrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SogyaZI7tbzbdEgXQnqdT8M8fssJ8N3tkL13HiH_0Fgo6cW4Spbbbw>
    <xmx:Sogyaem-iGDdwoyh9fqDuLiSjNtT_AWf_AkKxUAwX0q6H59sbBTh1g>
    <xmx:SogyaRTtIFEgBxrhu5FCuLXjBjZCaFLOShFQWT2TiRlQ-xum6_gIgA>
    <xmx:SogyaQL9X45swalccG0gH4oDyJTzjmDnSW2GoZDsZjxNyRfmhzLhQA>
    <xmx:SogyaVWRyjAsZKrW9jODK-kTuYGx1HsruRUJh7EHsWOh-j4EXRXmOwHI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 02:22:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: "tobias.boesch@miele.com" <tobias.boesch@miele.com>,  Git Mailing List
 <git@vger.kernel.org>
Subject: Re: [PATCH] gitk: fix history window panes position
In-Reply-To: <db513191-5f3d-489e-b91a-a788f70b9e8c@kdbg.org> (Johannes Sixt's
	message of "Fri, 5 Dec 2025 07:40:01 +0100")
References: <AM0PR08MB5426BC141388A69BB5087732E1D8A@AM0PR08MB5426.eurprd08.prod.outlook.com>
	<9a9441d5-fb64-4718-8765-852e66458598@kdbg.org>
	<DB8PR08MB5433FCF25C0693952E0E67BEE1A6A@DB8PR08MB5433.eurprd08.prod.outlook.com>
	<9f7af47a-ae39-4931-805d-f6e4549231ac@kdbg.org>
	<xmqq5xal8y5s.fsf@gitster.g>
	<db513191-5f3d-489e-b91a-a788f70b9e8c@kdbg.org>
Date: Fri, 05 Dec 2025 16:22:48 +0900
Message-ID: <xmqqzf7x75pz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Ah! You are absolutely right! Clearly, I wasn't fully taking in what
> git-am was telling me. The problem isn't the encoding. It's the patch
> text itself, in particular, the single SP needed for empty context lines
> is missing.

I do not think that is the case, either.  diff.suppressBlankEmpty is
part of Git for quite some time.  The "empty context lines can be
expressed as a totally empty line" was started at GNU IIRC, but I
think POSIX allows it these days.  And we can take it, as you found
out with your "bla.patch" experiment below.

> I get this error when I apply the mbox containing the complete email:
>
> $ git am -3 --signoff ~/Mail/ambox
> warning: quoted CRLF detected
> Applying: gitk: fix history window panes position
> error: corrupt patch at line 40
> error: could not build fake ancestor
> Patch failed at 0001 gitk: fix history window panes position
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: [...]
>
> But it is OK to copy the email body text to a file (which looks like
> mbox text) and apply that, despite the missing SP:
>
> $ git am -3 --signoff bla.patch
> Applying: gitk: fix history window panes position
> Using index info to reconstruct a base tree...
> A       gitk-git/gitk
> Falling back to patching base and 3-way merge...
>
> Why is that?

So the reason you seek is because you are barking up a wrong tree?

There probably is something wrong in the patch text that has nothing
to do with diff.suppressBlankEmpty that you somehow "fixed" without
knowing when you massaged the e-mail message into the "bla.patch"
text yourself manually, if I have to guess.
