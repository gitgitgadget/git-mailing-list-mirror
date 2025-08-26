Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A522DAFDF
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756241820; cv=none; b=KMujDzyFhhUirAVD+iWN+2DeIemVm84Ees2s4wswr5EnTOuu7LtKJDn45eItfTqwjW3bDMg0t8u5amfe+pZNsWkOPEuRkZpYJsqDRPluntJ6BbnkL/aAX13LYWjOA5tncrl+a5oAFVHULFilpnmvc3OIi1D7eIPmUmmcyYZCOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756241820; c=relaxed/simple;
	bh=LZqy/nTN55JcmpbELEpI1iVhUm6zb52NjHr7jHy5sKU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=O5Ngf0N8fUsM0UD1BOJUmc5CGWR+G8jThMZox2ROuXZMop6TZMZuchHJauEIETP4uA1vvYziDiTw0l1z0GFH57CheFd3N5UONKwI8eaFk2LB+R6m24QwlwW7okzIUudiI7dRy4Mq3KMqJp27zQ8jXJ9WMZqyZBfvym9HkagFIxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=Js7mFPNR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LelZMuEk; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="Js7mFPNR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LelZMuEk"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E8AD77A01EE;
	Tue, 26 Aug 2025 16:56:56 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 26 Aug 2025 16:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756241816;
	 x=1756328216; bh=bHFr/7aa7F+UPwxNIOCCUI9SnuFk0MpEXRoqEN7qbCw=; b=
	Js7mFPNRBTS0GLAB44DskauI41beQwKcgO0jx2WRaSf6efYx0ZTs3DfoFZgK+5i/
	mnpYPMlS/3wmB7DK+95+gACaVKHug0p5WAClXrE8er6dKKDAZ6oHx3b8jy1gzQgC
	mo4+CugUQHkFCjcCePwr3dRCulqISFwsj8epRppSufdHhw9pK1UQY+vXTxUJOAzD
	rsBEI9UPuzgtnFCtXc9ko0LiVBxZGCqbXhnVjDX2pF+PSYiDolTAG9pmwV+XdAbk
	5SNe9Gkvqd6dwmeAt/f949ytqULePRDcdwyTzpxqo8IL6KXIdgPm4Wdgv+Z27Y/L
	5D7CaIpLkowXpLeHQIqJow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756241816; x=
	1756328216; bh=bHFr/7aa7F+UPwxNIOCCUI9SnuFk0MpEXRoqEN7qbCw=; b=L
	elZMuEkzefsiq0j4v/hWC46BnwYAsSih3aV0NU1o6ZAmRPTqTHnu+cvVrtLCZltz
	NL+iMqDMLfEAJiKcLKgQ7xKPLeYqYkF3muANdOibvvt2mr9jWboWOcWXc8JDcsA7
	T2o1JUhh9EXDk91Pa6FL2eV8cMzoU1hfjI8aK2n9bJ20Lew5GNn6m0deJAUlhEHQ
	O1REKPQYfqWFJN90G+0p3AYeuxzr0vN+WopLVB8fsHxz2Svnk737gurPqq3m+UJ5
	0iboWRPF4Tbi5UK2lIZC6jI85K3liaurlaDI1lEmrMfeGoAD08jdZNDAUWqVZX4K
	SQZj177RTh6p/T9Qkqy0A==
X-ME-Sender: <xms:mB-uaLesRjZMzkAzakseIdUrDQKvQ4L0naDeyvafToma4u5IuZrKNg>
    <xme:mB-uaBMQ7s3-dRt_oF8xIwVvYXB2ofSl8pneSFbbVRX-Tz_EnU2V1_SnZGtdjxpvD
    lbvBl84lwYyhWJnfwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeivdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdfluhhlihgrucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhn
    shdrtggrqeenucggtffrrghtthgvrhhnpefgveekudeviedvveeuhefhvdetgefgffdufe
    eguddtkeegtdeltdevhfdtuddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehjuhhlihgrsehjvhhnshdrtggrpdhnsggprhgtphhtthhope
    efpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mB-uaAG2gPRy3LwMKhflnzGffTwpYlZm3004k-esbtFBGRT231SqBg>
    <xmx:mB-uaAPgn8_fNlvqMW_rxOUvitujBNpMK99I8OYxFNWEjT77xupotw>
    <xmx:mB-uaHGUqjEjGU6vXbinO3v-GTofsg6AGuMtVV8plNBwpuQ9dEKiog>
    <xmx:mB-uaPPD_aoc1YZxNnkjXKqtFr0K29aFoEbKHgRwKgp8fQTnOT8q2w>
    <xmx:mB-uaAmRvIeYlR-XAl2JKhVRbCj7rcR9ugs_Jml-RoY6LWZnp34CvTAI>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8398D7840CD; Tue, 26 Aug 2025 16:56:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aye-6GR96UBw
Date: Tue, 26 Aug 2025 16:56:36 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <de40e0ed-ca12-41b0-acd0-3c594078cc14@app.fastmail.com>
In-Reply-To: <xmqqqzwxkjje.fsf@gitster.g>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
 <a6125a0128937392af283033e63d2b04776caf2c.1756148933.git.gitgitgadget@gmail.com>
 <xmqqqzwxkjje.fsf@gitster.g>
Subject: Re: [PATCH 1/5] doc: git-checkout: clarify intro
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks for the comments!

> Avoid bullet points here.  End your sentence with a full stop.

Ok, will change.

> "Restore a different
> version of files" (or "files from a different version") perhaps?
> The point being you can grab multiple with a single operation, but
> they all have to come from a single source.

I like that, will change.

>> +Here's a description of all of the modes:
>
> I am not sure if we want/need this line, though.

Will remove.

> I do not think you are dealing with a conflict here, rather
> ambiguity.  "You can use double-dash `--` to disambiguate between
> branches and paths".

Will change.

>> +* `git checkout <branch> --` will force Git to treat the parameter as a
>> +  branch name or commit
>> +* `git checkout -- <pathspec>` will force Git to treat the parameter as
>> +  a set of file(s)
>
> We do not have to teach the full pathspec syntax here, but I wonder
> if we should do something to avoid leading a new reader into
> thinking they have to list files.  "...as a set of files and/or
> directories", perhaps?

I like that, will change.

>>> +1. **Switch branches**, with `git checkout <branch>`
>
> Does everybody really understand what it means to "switch branches"
> without further explanation?

My thought was that we explain what "switch branches" in
immediately afterwards in more depth. ("git checkout [<branch>]:
Switch to <branch>. This will update the files in the working tree...)

> Also "<branch>" -> "(<branch> | <commit>)", perhaps, as working on
> the unnamed branch (aka detached HEAD) behaves very much the same
> way as working on a named branch.

I feel mixed about this one.

One way to look at it is that `git checkout` has two modes: one
where you update `HEAD` and one where you don't. I think
from a "git internals" point of view this makes a lot of sense, but
my impression is that most "regular" Git users think of "switching
to detached HEAD state" as being a very different operation from
"switching branches", not as basically equivalent except for one
small detail.

Another way to look at it is that the "git checkout <branch> | <commit>"'s
main role is to switch branches, and that "git checkout <commit>" is
sort of an edge case and that we can leave its explanation to a few
lines later on. That's the stance I've taken here, but I'm open to hearing
other points of view.
