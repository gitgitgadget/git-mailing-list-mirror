Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0622133B95D
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968242; cv=none; b=mKBDXtjEA2Zy5xKtiuOLmQTeKpl8DLs8nxfuN/Tbwtix6CzzA2wTiG7E7lXPgYpldR/mrjkiwcXd1XM0j7uHMFVFLeONP2M9olWZoVpdhuencdvHCbMYksRnjjiKaBZUV9t0wvRoEuPEm0Pp4/5PGuAf3rrLjwuUpeqpZqc9D1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968242; c=relaxed/simple;
	bh=lc6tKtTHBF1WOgDuC5TzU1KLYkD/od0Jy4Qi6mwEl/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T1dw/1YXBMFala09HmxKjFQj0YTn/WSOIuUCHNN9irV5J+CFPzHt3ntkO9VoD2tEYkr9+mU7C7Pqev2nRiSaTC+r20iU/sApwglKfYwB5p90EkOJRkT01CkkU2it9z0/JlSlIwgQUJS21ATBTYCph/j9tD0fc66q1ZM9/68ze64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xv0v8obb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hdUNdi2h; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xv0v8obb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hdUNdi2h"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2BDD41D001B8;
	Tue, 24 Feb 2026 16:24:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 16:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771968240; x=1772054640; bh=mGE3Fu3p7U
	eBf/ErsW6No4Am8I0d8SWDA2AbrQzXMDY=; b=Xv0v8obbrT1Op4qGSRzHTF08JK
	qzPnIdomR1fPH/v7FtJW3WbbuDxVpVFMv0nOmyU1P77yl7SvJSV/cCjhx0hcXULy
	cWbwOSvqmS81/bu4foApP1dO5ONjWCjpAqcLiItNwwbHUxrWR7fTGrkB+B8myPwt
	oNUfpUtbk8JFsS2ciY2NlJzdmsLtmC8pHyIcKl0639QseVgKn9o2APj4umaVLB4l
	UEqVuJHdvf3qKrsa5HRe2hgnz4HHwnKnzvmV7LUNNx64ROXeC+4+PhOZ7bi1UJIl
	F+82MYpxxXS7UeHlBS6uUBBeVbeqhNkRl+jtcAscFjD43C0RtMD1y21PYCOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771968240; x=1772054640; bh=mGE3Fu3p7UeBf/ErsW6No4Am8I0d8SWDA2A
	brQzXMDY=; b=hdUNdi2hPaHVdXVSfa06IQQMuycTwZOpSlYplz6mZwKfo7JuvOa
	XkKsMZ91cDDm9y/Xmg9Q6rjkJRn6b506ehrEFmgE1q4SGtuE6z0cET+qukf7a0mr
	YuIuWBW9bnhnkEcskN7ebtBbarvin3rOKXM64Ys9z6Wie4qLnC3zdzjvJaVPqEU9
	84BhpsdCNRRZERT0vBnxuIsZ+vqekYs66ocg35rRuK+GPVqtNXePT1+4rOP/h8hT
	DMwLDmSjA6O0mu18RiHoP5IdvHwgWQ9jb4M9o2Ot2Arb+YNkpNA5GegPxH0NkVxH
	FlA2EHLkNdutyXtiHEx64h6f18k3JKf9BuA==
X-ME-Sender: <xms:7xaeaftcxcKdSCTZdjEW84ulGxhZoUsfk8hW0AEH__eD_FqAP2zLZg>
    <xme:7xaeafgTXy_4K66_FwJ2hkYyU_SRk_Pen9UcUIR4g4JquNvd942lJ0Q8BeXETWCDq
    bLtEaDFsVBITCl9H5kyT8xmL_ztRXB3CGR6c5SFBKLCoxHq1GVJWg>
X-ME-Received: <xmr:7xaeaY8OmaNdUwQZjhpivGsx0orco6uN81phugTqIfpY82sAoLM7uYjqOYiOSuFQ0kqC_RuYL9_cN2j5FUE9P7_6zQqOK6y45A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeduvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeevveeluefffefhueefvdevheejue
    fgkedtfeeuveegheejtdfgudefjefhtdfgieenucffohhmrghinhepphhusghlihgtqdhi
    nhgsohigrdhorhhgpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvrghluh
    hsohhuthhrihhksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhopehsih
    guughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtphhtthhopehl
    uhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7xaeaavK_A0gdJddeswCfE3RDRzMKANPO-taCh9vWLzsub0BosAPCQ>
    <xmx:7xaeaUp7mlpzLBhXyICuKS3QM6-X3NMdaWQhBnJ5nJh5TQxwTgRVBA>
    <xmx:7xaeaWr4ehO4z5PZKJw4baJ4KhKdF-VrcF29RHM7x45ZYTOyk5fgbQ>
    <xmx:7xaeabZRBjf5XMQlNDtdi3vexIoxWZgRBg8JredisccvisIvDxxKJw>
    <xmx:8BaeaXQ6lx2PE8aqDYx5bwcjs550NyMpKVPG7noinoGek0jsCvTH8KB0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 16:23:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: SoutrikDas <valusoutrik@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,  jltobler@gmail.com,
  ayu.chandekar@gmail.com,  siddharthasthana31@gmail.com,
  lucasseikioshiro@gmail.com
Subject: Re: [RFC RFC PATCH] builtin/repo.c: change info default behavior to
 show all fields
In-Reply-To: <20260224204047.8452-1-valusoutrik@gmail.com> (SoutrikDas's
	message of "Wed, 25 Feb 2026 02:10:47 +0530")
References: <20260224204047.8452-1-valusoutrik@gmail.com>
Date: Tue, 24 Feb 2026 13:23:58 -0800
Message-ID: <xmqq5x7lg7ip.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

SoutrikDas <valusoutrik@gmail.com> writes:

>> After this review, I'm starting to think that leaving it empty by default
>> would be better. Specially after the review by Phillip Wood [2], who
>> has a good argument for it:
>> 
>> """
>>   As this is a plumbing command I think it would be clearer if the caller 
>>   was required to specify the output format and the information that they 
>>   require with an "--all" option for "show me everything" as Junio 
>>   suggested. If we were to set defaults for the format and keys now we 
>>   would be stuck with them forever.
>> """
>
> I don't really have much experience writing scripts, but ... if one is 
> scripting to get a certain value, would they not specify that ? like 
> why would they excecute a "git repo info" without any fields?
>
> Also ... mayeb this does not make much sense, but the
> 'git repo info --all' has only 4 fields now, so showing all 4, should be okay ?
> Or maybe not.
>
>
> [1] : https://public-inbox.org/git/20250610152117.14826-1-lucasseikioshiro@gmail.com/t/#m04cb1fc694f334cc861f6ab146f50b45ae277874
> [2] : https://lore.kernel.org/git/af27af92-73d5-4f0a-84f4-9c91de6ab6e6@gmail.com/
> ---
> Previously, git repo info would print nothing,
> when invoked without arguements. Change the default
> behaviour to display all available fields, to make
> it a little more user friendly.

The number of things do not matter.  "user friendly" does not
matter.

They do not matter plumbing commands intended to be used in scripts.
What matters more is being predictable.

The silly example you saw in the discussion thread can be solved
even if by default we showed everything.  The UI can count the
checkboxes it is going to turn into command's arguments (i.e., "I
want to ask you about these pieces of information"), and if that is
empty, just can refrain from invoking the command.  But that is
arguably _more_ work on the script.  A simpler rule "we give only
what you ask, always, no exceptions that depends on the number of
things you ask (like when you ask for zero things)" would end up
being easier to use.

And it is more predictable.  If you ask for two things, you get two
things.  If you ask for one thing, you get one thing.  If you ask
for zero things?  You get none.

So...?
