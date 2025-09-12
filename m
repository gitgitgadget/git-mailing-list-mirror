Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3807B31353D
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687220; cv=none; b=pUx+Uxi5ZSWjnRs2ty4UEjTK5wJXjE0SkbtkkNkkSFYNEk9+C+8LlfMFrF42s/vxtzZ6ldJe6B87vgZT5X16Bu/8VoJZsXs4z9dB2vHanp3x+1ie1w/XTy85tPorKl4aejSrveI+LcbclB+MGH78mWDkW8ngiSjZ5h9SBFhnjWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687220; c=relaxed/simple;
	bh=PjdFDYYBcJ5YHQHE9MJT8op1cxT3UCjuzmjSON8Q6V8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=K1BlL/aPFWyVk1CSo0vDka0LFLDAHMsIa5Utqi8gzB1MAJUy3Z69LFFnTeCFP2wFrUo52CMp5XZAyEH7ykoZp5nkB7u76beu2HRENbFymKNhnyAcYgbpdOmYk/nVore71pDcRJEYkRnYmjLoH2rvP4HlZU/XJLHhYHIAl4k/Prs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QvuL7gDt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OVSho15D; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QvuL7gDt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OVSho15D"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 397881D002ED;
	Fri, 12 Sep 2025 10:26:57 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 12 Sep 2025 10:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757687217;
	 x=1757773617; bh=1hy35P4B/8YITa4xAwC8Wh/skbbQB+Ms48irGMEu96g=; b=
	QvuL7gDtg+xYONHLNkec2Ojg8tPVL5qNgDDvl0hdrQ91/skDiPKR5qt/U7/ULx/a
	5YMMPh9m1mgR6EPneYkdG6OiFFt6HeM+gPx+xx58Tzgx7El+ejJEJfk+WPTkklbg
	syIR7fHkj7GkYG+vf1HX6Eqr8CEY7QsCHhiFjWIBwLZaBdvyj9s1Ay+ALmgqK5So
	SFaFxcGg7/x74fAkwfqspRJPFk0gR12GMzuPGp7K3b13M+cg2cQs7yHxgUNJbwMG
	3Bj+o6/a9dMAcZEpiFaVBR3wQppkqra8rqz2bQeFoWMUMM+02bd24VZUWU4lpY6P
	A1UrQTOvQ1TheXyIxoUPLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757687217; x=
	1757773617; bh=1hy35P4B/8YITa4xAwC8Wh/skbbQB+Ms48irGMEu96g=; b=O
	VSho15DHohLplosKtBFSRvYwEPuNnqmFyEBGVjUYpCYxUszShoQto6JMkqeyHhCC
	wEK79bl6cB+kzNzEjFKYAEjUYnecfNxJ0330AJvEX2yzDj1ysrJCn4jkQaS1NZ8e
	ysJtYUF6KxPWTEBAxVsysPjsARvZP2dXV1frzkuDi9ZF5LJkFDHKi/8H194dQdsS
	X9Y5MWskAQhW92pTEX+6K649lOhU7LU3quLo32ObieTXlm+H/iZ84KjeukBbQLJS
	KcwrB+CObIUz5I99L0pLAq3Snr20ufzMxpIhi79aPfc6rmvFrSeSHPZB0E/yrMC7
	/5RL0Y0692g4wqsbC4ZXA==
X-ME-Sender: <xms:sC3EaO63m5tLJqEEi4bIIhakgJa6HZq4vAslegRLZRyfrw3pBNwvyRA>
    <xme:sC3EaH5A62NifnXaMWscQrgKxCAbTyx9FbM6zX6s_4mT7CUSF6PTDnZcSHoLYY0ol
    UxxUKK0ObSddrdLlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvledvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpefhvedvfefhjedu
    gfduffeuueelhfelhfdufeehueelveeuteevtdffueefjefhffenucffohhmrghinhepgh
    hithdqshgtmhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgih
    htghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhulhhirgesjhhvnhhs
    rdgtrgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sC3EaHCAuI-VI4MskMdqBSPkQsoTztt4JOoIcdyLfQ49KpgKxT_zcg>
    <xmx:sC3EaG-FdCk8bJj4io88AzZ12QU1gPz4kMYK4Bk0x9w1LzZb-obDIQ>
    <xmx:sC3EaCLYaOnwSeqoEY_gWkmMHR-rtsZACVdcaonO2GMtUaJd_2zSdQ>
    <xmx:sC3EaPilFdf0J5Ta2Ydy0Hk7xQNJECQJ3JgrekZRJurjwcj0F7Vujg>
    <xmx:sS3EaC9Ggn8tY3kgssLIR35D42QiY6-bhFwVDuIC7Bz81zfCQm9oXjYb>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BFA5D1EA0068; Fri, 12 Sep 2025 10:26:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AA3O5JZkN_G7
Date: Fri, 12 Sep 2025 16:26:36 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Julia Evans" <julia@jvns.ca>, "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Josh Soref" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <35faaf30-6326-4784-80ff-723c20ed6b13@app.fastmail.com>
In-Reply-To: <236a79f4-e9a2-4335-bbff-79ae0cc67e9b@app.fastmail.com>
References: <pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
 <1629C205-700F-4A8A-84BE-302D172416F8@gmail.com>
 <236a79f4-e9a2-4335-bbff-79ae0cc67e9b@app.fastmail.com>
Subject: Re: [PATCH v4 0/7] doc: git-checkout: clarify DESCRIPTION section
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025, at 16:05, Julia Evans wrote:
>> OTOH, I=E2=80=99ll take a look at the docs after this series lands an=
d see if
>> it feels like something is missing. It may be just fine to have
>> pathspecs in the synopses and add a sentence somewhere after the gent=
le
>> introduction =E2=80=9CFor more ways to specify paths, see=E2=80=A6=E2=
=80=9D
>
> Sorry for not mentioning that. My idea was to just leave <pathspec> in=
 the
> synopsis, and then folks can look it up in the glossary if they're cur=
ious.
>
> In the web documentation (https://git-scm.com/docs/git-checkout), the =
word
> "pathspec" is underlined, and hovering over it will show the definitio=
n, which
> I think will help with discoverability. Of course in the terminal vers=
ion of the
> man pages it's harder to build in affordances like that.
>
> Do you think that the concept of a "pathspec" is especially useful/pow=
erful
> in the case of `git checkout`? If we're thinking more globally, i wond=
er if we
> could find a Git command where more complex pathspecs are especiallly
> useful and then include some examples of using a complex pathspec ther=
e.
>
> If we include a compelling example and then a "see X for more about...=
" (here or
> somewhere else) I think it would be much more likely to motivate users=
 to follow
> the breadcrumbs to learn more.

I think pathspecs are great for git-grep(1).

    # Docs but ignore release notes
    git grep loop -- Documentation/ ':^Documentation/RelNotes'
    # Just the git(1) manuals (more or less)
    git grep loop -- 'Documentation/git-*adoc'

And also for narrowing a git-diff(1), like ignoring `pom.xml` changes in
a Java project.

(But I never got into the habit of using them with git-checkout(1))

But once you learn about them you indeed can find uses for them in a lot
of corners.  I used them today and yesterday to selectively git-clean(1)
and git-rm(1).

There should be a gitpathspecs(7).  Not just a glossary entry.
