Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B871B1E834E
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239674; cv=none; b=bP7nMkckqIAPWTMU1gVJGwktqd8hpIYrAw7CEdpRGmc55QymlnPxaYXXSUD8d8ZcXO5gHXl7HCN9a4EMbKqHDRRjpGQJto+Ixr9PQlYXIrlBwJ8hYP2kCi+4jUp1AQgx91hLdsVgxboG1muFaC0CNTMaY9IQVHz571IK490NCWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239674; c=relaxed/simple;
	bh=j10v/WZTrVFD+e0d/SDKWWQbCTsoQABK45Rjhhw2bDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tlIJXOfW1UJbGYWkAgx83g6WQDt3BwrUP2Qg9xU0Zm6we8LNM5+g9h91cuJ3VLG6T2Q5Z1zmym6cAVst9xYDh5rEshfCLy2A7WOq4RFKqmhTe6a8BryiwM9AMDhzbRO7029YUrO8q0fH6ValOfKAHgC7SUvr0QkQy0Eg55UKYN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oBajVjir; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=buX3Tott; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oBajVjir";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="buX3Tott"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8A10C7A0129;
	Mon, 16 Feb 2026 06:01:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 16 Feb 2026 06:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771239671; x=1771326071; bh=mvVoAfsl0f
	PH10eVrv15iegi8jPy/gTioUts4a/KGUc=; b=oBajVjir29MXminUbmxW9gotMD
	+Luxf2MHhwqeRl7DOuAK/8uoo1ndbU9FbpBbvpwGCiEs3dZjka5ZLC0EKnKclgMc
	MbIEDC+8XNOhkWdPueYRFIFa+FR/9AHVwt2hgwwsdVjZsojQi1q8Bdm3fTu6WTuT
	8Ei1XVr9+gq8iBlrqoIEHZbIgPrSoxF5WG7vfGtNJkgUlADQBruqkStBMzLtl7RS
	iQyRpvfXzE7gVIPw8enAy7s5f6gPEvuDXFg2onOM7wA+sWqcY/8OYebKpfo4eVSI
	gjGxuwMnj3Qe+FhD0PXupIJbeHd9ZHaZZGprurac7yM1DNhFZpsDauVgRB4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771239671; x=1771326071; bh=mvVoAfsl0fPH10eVrv15iegi8jPy/gTioUt
	s4a/KGUc=; b=buX3TottFscofTh3rphcamD48Wjj8VF9wcZ4D4w9ZFCrgudp1xK
	GhsWbbG2MKPZYTxPPVKDi/eN8wd92UOnCtgYfnYEBN7z7jTVLqu3Lt0qW51I87uy
	JC+3Kv5DFhcrBBxmsYmSp6cqy2zp0U2AyiRLKsKO5N+5tJ7FXSNlpW1XuzOBJZdc
	eijnUPpmcVicrGdClY06IRXmd+C/ZMIc8nibekfi7EVj8PI5VSspxiCMVR2M3v86
	CTON0+Zy5JRpQR5F8F2zv0dNnoXg/omtMz/im8iGXdiySTbXJd1g4K5Jnnrp7x6X
	mCWn/bRjYSDwQ1zQ7Qn5EaR4O9NucBTY0tA==
X-ME-Sender: <xms:9_iSaWa2GiGpP6CUkYCxTsLV6gFmsYG88lJ86rTdYwUfm9Pi_XA88A>
    <xme:9_iSaQ1FGWRDXJXzFGyULElDCk9s-OxDg9w4Ih3pzoWODIQhXBEA7qaEFpqkDOI63
    Rl429lr0ny2ZFldDGMdL8yc-GdQZ_-fLvHp3QFI96wS0QlUw3aI8mw>
X-ME-Received: <xmr:9_iSaeUcRnWkk1svD9gr5hcP2YpLwkx9MXSevEXwOZ5lS97gNjU1SmxnUT_XAT0SAkdbKxX_m_-ZRvdlqCsO3EZX3kQMJoxZHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeijedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9_iSaSWPtg5T0aGkmGK-DVY0mh_ca2e5tuqcSD6SteK-ER5W8mHOyA>
    <xmx:9_iSaVes077OpBK-9SLPoch7vQsYvJf6uMWaA0zd4O95hPovoXZ22A>
    <xmx:9_iSaTUMvMmkyLY2gihFOY2CcHYrbhkgBazQNDnCpID6xJyFd4HeSA>
    <xmx:9_iSaWfat3zLjByqw7UxnUqAg5_J1GDJ9svG1c3OaKuVplo_b0cEpA>
    <xmx:9_iSaeAq-TkmFghOk8lHUVRDM3VI_mkpryW15I4n4-fwb1gUcMhr9OXp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 06:01:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] format-patch: fix from header in cover letter
In-Reply-To: <aZAMr6XOwKkTa55q@exploit> (Mirko Faina's message of "Sat, 14 Feb
	2026 06:49:23 +0100")
References: <aZAMr6XOwKkTa55q@exploit>
Date: Mon, 16 Feb 2026 03:01:09 -0800
Message-ID: <xmqqv7fxdkay.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> Subject: Re: [PATCH] format-patch: fix from header in cover letter

Thanks.  That reads well.

> From: Mroik <mroik@delayed.space>

The ident used here matches what is used on the signed-off-by line,
which is good.  We tend to prefer people to use their real names,
though (and I suspect that your name probably has some multi-word
structure, not a single-word).

> Fixes "From" header for the cover letter when `--from` is passed

The usual way to compose a log message of this project is to

 - Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to somebody editing the codebase to "make it so",
   instead of saying "This commit does X".

in this order.  I am guessing that the problem you are fixing, which
is not said explicitly in what you wrote, is that even when you run
"git format-patch --from='Me <me@my.address>'", the option is not
used for cover letter?  If that is the case, perhaps I'd write
something along this line:

    "git format-patch" takes "--from=<user ident>" command line
    option, and the given ident is used for patch e-mails, but for
    the cover letter e-mail, the option is ignored and the committer
    ident of the current user is used.

    Teach the make_cover_letter() function to honor the option,
    instead of always using the current committer identity.

if I were making this change.

> Signed-off-by: Mroik <mroik@delayed.space>

Again, the ident used here matches what is used on the in-body From:
line, which is good.

> ---
>  builtin/log.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This can be tested easily without flakes, so we should add some test
in one of the t/t*-format-patch*.sh files to help people notice when
they breaks this fix by mistake in the future.

> diff --git a/builtin/log.c b/builtin/log.c
> index d43ca693bf..df41b43fce 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1345,7 +1345,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
>  	if (!cmit_fmt_is_mail(rev->commit_format))
>  		die(_("cover letter needs email format"));
>  
> -	committer = git_committer_info(0);
> +	committer = cfg->from ? cfg->from : git_committer_info(0);

This is a correct and minimal change, but if I were making this
change, I'd probably rename the "committer" variable.  Before the
"--from" option came into play, the function has always assumed that
it should make the cover letter message from the current user, using
their committer ident, which meant that the "From:" address and the
committer ident were synonymous from this function's point of view.

But now we are telling the function that its assumption is no longer
good, and teaching it to honor the "From:" address given in the cfg.
And the way this local variable is used is to point at a string that
is the ident used for the "From:" address, which is not necessarily
the same as committer ident in this new world order.  So it is not
reader-friendly to keep using "committer" as the name of the
variable.  Simply call it "from", perhaps?

>  	if (use_separate_file &&
>  	    open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))

Thanks.
