Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0F1F2364
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267825; cv=none; b=o051MQX46hWyCNfQqAljiKesA1N6/TKTj64GJOweKzpu4oUBAycRWEc02YF+mnrjZUK7XCK3lbYzB3FXdXSOwi60r8S6plPZBjh052Q/Brx/XSpeao1sxucb9quUqEg3f6wSQ3Jnf/t6Qmba14nqEXViDE5kamGgiPUjPY94DrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267825; c=relaxed/simple;
	bh=1NEM51MT8P32MIebkNha5r9xDJashEZKFbw3E4jmHRE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uqMm/a9dtd+5Xec7KJGIM/24afrz0DJVwfdCCb2sMdoPZ2ytPuLAxXTjr6bPA/d4XfVjYch81kZH8fI4oamW8e+0i+B6Ty02CDGr+QvBQewupNNHmYlB/Fq/LEh5v05XhjdBYHmQKdFsIXA+x7u5GtLX1w/45nGC3qC009gRcg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uQhJpU4r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=al/m/qBU; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uQhJpU4r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="al/m/qBU"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A458825401C7;
	Tue,  7 Jan 2025 11:37:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 07 Jan 2025 11:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736267821; x=1736354221; bh=AfAkZVH1nX
	wOtuIVffPJRQCYBAgIGw9iYZBsQVnbV8Y=; b=uQhJpU4rUK3Wkp/0E05Us43Oto
	qjw16lhvkJ86UJyDeT3MKYYixmkt7gyKAr1PGGyCSuqpmXkaihA5qZ5ozwcWTW+1
	GkSvj501UgI9pD7JMtXP8J4UHekOBBDjVgQaRCWeMUVoSY561Zir3ulCfzFVXnqB
	9XUbrrC/uYfmece1LIYf/75qVEhb09porQmVSrwBQwUWywN6SE1NIFaXqvgELENC
	SsMLo3aS4FtVulfBwUepya2rmmxnG1rGXQZO/ppDJxSBgrF400XNrcCut8z0ugxg
	K9bhlLGP3n8b4CrMhd5GmGuus35ZK9kYKHRKYGrxvUhR7SyVGHbN9rvoxqyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736267821; x=1736354221; bh=AfAkZVH1nXwOtuIVffPJRQCYBAgIGw9iYZB
	sQVnbV8Y=; b=al/m/qBUYiQTaM7cf16rpqxsKnwQtZxVEg7OjeCsV9TzbuhR/y2
	AqqgQSEmUxWk1GtuqNWrxBsR4IIP963i8M9NLnzZr6chX04s3pKpePMBByDJT2z1
	kc1yRapU0PLyHNy+T8EEVwop7HT4hYTeeRvjC103EaPnoLIY3GMmKWzvPSBlrpaV
	Ja/O5yLLLLVdkpsitOcZazQWY6k01nkMG3gu9lUVE/y24wtk87Hflpex6gszXCNZ
	gvy/Pz4s4f+AtpjCubM/16CHwj7V8CtVt3mMOBZ8sMjftJMylLd+iNgWdUd0SpKE
	Q7PJUVKMeBC4yr2PB68kv9o/BNZ2CvTQ0ag==
X-ME-Sender: <xms:LVh9ZyDfXu5bftm6tODt6u0r1mnWoB_DJpErb53zjZmo5cIwpjpDQw>
    <xme:LVh9Z8jcUXQtMQrt02AuRGy3yRXVAvDhQ08d9dXXmcdD69gdYKfJaEKZ5T2XBwBbg
    SsaxG0uuTRlObwUcw>
X-ME-Received: <xmr:LVh9Z1kJ9wJMkchSiFppGJGZ4I_lNGOF6YwYzbXMtvLdX04ReT0vEF0clke8HFT8TnOfnsJGawERIPUaOOdOaymiSilbrhDXY-eh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:LVh9ZwxdhEZ6gAApVKsx_So6813qihYDesjTnsFRHHvLBjf-NDQRYg>
    <xmx:LVh9Z3QqSF21Q40ZwfwB3jYBAU2Ia_lMV6ykn5Q3JU-kGjxjnA1ECQ>
    <xmx:LVh9Z7bntMnUzxNzmKefVVXyB2v9yirlDe5C6dq5E8QA2iK0dcVcuA>
    <xmx:LVh9ZwS-mUwUfcfd_gmP7zyScg4guoDhVuzWFnOZkWlQJCSLzjHshw>
    <xmx:LVh9Z1OJW6QJ7hiolyu1Gr2AwsucwBL12wvoMUvSMsod5a12uH9iEKqC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 11:37:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 0/5] remote: announce removal of "branches/" and
 "remotes/"
In-Reply-To: <Z30ik6NlYVMnNMpB@pks.im> (Patrick Steinhardt's message of "Tue,
	7 Jan 2025 13:48:19 +0100")
References: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
	<20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
	<xmqqbjwk0x0e.fsf@gitster.g> <Z30ik6NlYVMnNMpB@pks.im>
Date: Tue, 07 Jan 2025 08:36:59 -0800
Message-ID: <xmqqcygyvavo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> Specifically the ".git/branches/name" mechanism was never removed as
>> it had one distinct advantage over all other mechanisms for users
>> who have to juggle tons of remotes that change either their URLs or
>> branch names or both not so infrequently.  Instead of having to edit
>> files in .git/remotes/*, being able to say
>> 
>> 	$ ls .git/branches/*partialname*
>> 	$ echo "$URL#$branch" >.git/branches/foo
>> 	$ rm .git/brnaches/foo
>> 
>> was powerful.  Offhand I do not know if "git remote" command
>> improved the usability aspect of newer mechanisms good enough
>> to allow us to start using the verb "replace" here.
>
> I would claim the fact that nobody nowadays knows about either of the
> old mechanisms is a good indicator that git-remote(1) has indeed
> completely replaced them. I'm happy to slightly reword it though, even
> if it doesn't ultimately end up in any of the commits anyway :)

We can claim whatever, but scripts written in ancient days may still
know about them and they do not care what we claim.  And that is the
primary thing that makes me worried.

As suggested elsewhere, I think it is prudent to add some checks
when remote.c notices that we used the values that were read via
these old mechanims and complain loudly.

Thanks.
