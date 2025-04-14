Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67C6433C8
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643604; cv=none; b=Dy2S9VpFcW5D6shKGXuE6rlccykeY5PEfBW/wcfrl0HZ/rZ7Nkbwu1LYJwEXaccDLsruFJ3Yl1rqhTkumugxNN439IkdMOCY4KPXnstOjIU2D6rCGoAOd7rJnXupvQckUVVj/qxE0zSSW9ERxgsf3gsZSvNSXkMJAUAk8Fbaia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643604; c=relaxed/simple;
	bh=HGB5B3zMnfO0u3vJSJTb9Grwp61TbgctYqcfjGX7s0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bAzefKX7yXnxd82ApctdD7GG+5g1c3IZ7VYBnY4HgECvmWz0M99PA+hS9j6+I6Ay9SxVpRgtg5E1vuOvOCLI76x7oQT83C7z7Omt9nzQOZ9RkiPCP0z5gE3aQbPoJE7UQBR0jvH6MonRljqtRbADGUx+A7dumTke1vqvS634kUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pqvkUGSX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DDSumsCA; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pqvkUGSX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DDSumsCA"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id CBA9911402DB;
	Mon, 14 Apr 2025 11:13:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 14 Apr 2025 11:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744643600; x=1744730000; bh=FKxx+4Oqsq
	GUObNVgXFkjeVPxci5ujx3SNABvYs2eS0=; b=pqvkUGSXIyrVcpfVGistXaiAAB
	wu+rNpNcoYhQ2W81NppG5ptbNxQzcLhKS59xZU2urWQjIkz8gJ6zLZHW0knGr962
	of3XcE+qAIAptgydFLfNlwTjLIUMZrRZyEifd2kJUj2MYeKx/HXx5orwOL3h5LLk
	YJqtRyUPnfBjlT+cUXUKNk3iKstgkv7FqCXXNZ64asQZ0h1IYajE99WOwTkZUKh1
	1PVf7cuy8QLPLuJ5yKbjeDtLWZdrgXJ4q0y8C9qFplNYb0o/EBUWXRGczWqHFB1/
	4gFstyTyIAxW+UtNLeu/lJAxWyiqdm6nsTtfthNTr/lxz+hsHu1XUzJc4Xgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744643600; x=1744730000; bh=FKxx+4OqsqGUObNVgXFkjeVPxci5ujx3SNA
	BvYs2eS0=; b=DDSumsCAnqI2mSMCB1pbaigP2Tuiy0YNo5BPWFJRVWiVjYWmDH/
	y3J1TNS8F2brTJoldg6Kt8l88G7fswzS8lpJ1HmiH1HlQeOGID9GJLwBPlfF5Kqt
	fwG2mlvMHapH211tH4ayFtwA0a5jYr0cQ3ogo2evGDwqfBXcmb1tfIer+2HcqGJh
	z3z8bV5mb8AA8NKHQN3mVcxPNbJCploGyo5gt62uLIGLgWlZAZcly1VOeR6QhjXN
	FcJaUZS61M7xBoM/A+Q9o9Pam4F6u0ZU2IOBQBMbkVEmTlpLkRuCMCD2z9t/RbSp
	cl/zn25jFQ5pKlqlxuL/tv26fdwh9UR1JjQ==
X-ME-Sender: <xms:ECb9ZyO1p8gEIwk28xHDcCjE8Zg7mMOV232l_QC5wq-zw5YE68vkWA>
    <xme:ECb9Zw-uX7psUX61yrAd6l_UVlnxlVgZQEmtIz0lGQL83u_oqotzA4O5ywZ6SpW8p
    X6jQ99HXZUkyRsEYw>
X-ME-Received: <xmr:ECb9Z5TuUsDenFrvbooIV-q2JD_m0ifUjtkvdl2VHxOn1Z6IAlv8UHRwndp6vgmNBH-3PdoeZ_YAvyHInIz5nz3bdyWQmG_bq78->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthihthhsohesmh
    hithdrvgguuhdprhgtphhtthhopehnihgtohestghrhihpthhonhgvtghtohhrrdgtohhm
    pdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghkvghmphhi
    nhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgtohhtthesghhithgsuhhtlhgvrh
    drtghomhdprhgtphhtthhopehrvghmohessghuvghniihlihdruggvvhdprhgtphhtthho
    pehphhhilhhiphhmvghtiihgvghrsegslhhuvgifihhnrdgthhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ECb9Zyv5-_KdqANQQ9NUqP3nddl5VJ9CgzNFjfkBQJciCatbfi-J5Q>
    <xmx:ECb9Z6d9DRGbDI3ZQ99SP7OAiCSpYj1jB9gra77PxEu1lzDlntnuiA>
    <xmx:ECb9Z20mfYoNzxgRP1wM5JA5DHDMayXy37UY6BoTtCp-g0MOt2QZzA>
    <xmx:ECb9Z-_b6MzKvxAfmiVJd1_12dSzsSoYNOM8VwFZNd5Knfp0U7vpbg>
    <xmx:ECb9Z81c9-vFQ8120xCD7XZzUFrm1DBO7P3Vrhmv7tslTRTyvldJUpik>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 11:13:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Nico Williams <nico@cryptonector.com>,  Martin von Zweigbergk
 <martinvonz@google.com>,  Git Mailing List <git@vger.kernel.org>,  Edwin
 Kempin <ekempin@google.com>,  Scott Chacon <scott@gitbutler.com>,
  remo@buenzli.dev,  "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
In-Reply-To: <20250412231318.GG13132@mit.edu> (Theodore Ts'o's message of
	"Sat, 12 Apr 2025 19:13:18 -0400")
References: <20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby>
	<20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
	<xmqqv7rdqkla.fsf@gitster.g> <Z/a+AVopz+HLa1eL@ubby>
	<20250410134426.GB13132@mit.edu> <xmqqy0w8ng5r.fsf@gitster.g>
	<20250411154839.GC648081@mit.edu> <xmqqfriemw38.fsf@gitster.g>
	<20250412231318.GG13132@mit.edu>
Date: Mon, 14 Apr 2025 08:13:18 -0700
Message-ID: <xmqq8qo2srn5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Fri, Apr 11, 2025 at 10:44:43AM -0700, Junio C Hamano wrote:
>> 
>> The submitting contributor must make a conscious arrangement to give
>> a "patch set ID" shared among the messages in a single iteration,
>> and everybody who are responding must make sure they do not add the
>> same ID to the messages they throw at the thread in response.  Those
>> who use format-patch and send-email can do that with convention and
>> automation and there is no reason to rely on In-Reply-To: header
>> (which may confuse the automated recipient of manually created
>> follow-up messages).
>
> So it all depends on how the patch set ID is implemented.  Here's one
> way that I had in mind.  The reason why I like like this over the
> Change-ID approach is that the semantics can be very clearly defined,
> and the only thing we rely on is the user saying "this new commit is
> part of patch series which I'm putting together". 
>
> By default when creating a new commit, the field is empty (in which
> case the patch set ID is presumed to be the same as the commit ID), or
> if the user gives a command-line flag say, "git commit --series"
> which indicates that it is part of a patch series in which case the
> patch set ID of the commit is set to the patch set ID of the current
> commit (i.e., eventully, its parent commit).
>
> Whenever the commit is amended or rebased or cherry picked, if the
> patch series ID is NULL, then it is set to the original commit ID.
> Otherwise, the existing patch set ID is preserved.
>
> The patch set ID will be output by git format-patch (perhaps as "Patch
> Series ID: sha has" immediately after the --- line.  And if it is
> present, "git am" will import that patch series ID into git commit
> which creates when it sucks in the e-mail.
>
> The net affect of this is that for new versions of git which implement
> the Patch Set ID, all new commits are treated as patch series of
> length 1, unless a subsequent commit is created using "git commit
> --series".  And the Patch Set ID will be preserved across
> cherry-picks, rebase operations, and git send-email/git apply-message
> operations.
>
> So if someone replies to an existing e-mail thread with a new commit,
> git format-patch will give it a different patch set ID, so we can
> distinguish it from an amended  copy of a patch in the patch series.
>
> It also means that singleton commits, the patch ID effectively acts
> much like the tranditonal Change-ID.  For multi-commit patch series,
> all of the commits will have the same patch set ID.

Yeah, I like that aspect the best---the case for single commit
series falling out as a natural degenerate case of the more general
case to support multi-commit series is a good sign that the design
got something right ;-)

I am still not sure what to think about the lack of explicit the
evolution history of one patch set that share the same patch set ID.

When we have 10 commits that share the same patch set ID, I can
imagine that we can easily tell 3 are from one iteration, and 3 and
4 among the rest are from another two iterations by noticing that
there are three strand of pearls, having 3, 3, and 4 commits on it.
And we can identify the initial round by noticing that one of the
commits have its name as the patch set ID, but I am not sure if we
should be OK by not having anything but the committter timestamp to
tell which one among the other two iterations are earlier, and we
cannot tell anything about these two other iterations if they are
independent rewrites of the original round.

But other than that, I like something with clearly defined semantics
(and the definition coming naturally out of the structure, not out
of some arbitrary convention that forces to bring in some
semantics), and what you outlined above looks reasonably clean and
easy to use.

Thanks.
