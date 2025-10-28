Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854502882BB
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683471; cv=none; b=c5o+qnQLic8cUI+5fmn4149XmJU4AixhDiAXwpcqIZgNOXFlzSySCScCfgoDhhAqNZwjzLEvjAawTOv//v0i78RoO6Dp8qOrKIAmhFnyl1JUlPDEcknz79z9A6QwMIpg2RJGKkILOK1J2OjjrNM34jQLA76h4UDPAoiCO1q5rLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683471; c=relaxed/simple;
	bh=3STA8nyuV/uVWI2bi2x/dMttMIOx3psYgspsUJj6u8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LcV8PgH9lBNgCciB5olGFYcn5gLACqjyOODW2LVsC/CtHVMuoSfaJ+boHmbmTJgQSHThgc/PGYFJJipsNO8syesVqGCQ2plzQPgbO0VT6vvexwoUUIEUIw4kfM/pVRcZjlydjrWjD7OE38sDcUMNvXTNpmcxf/svXk4cSv5/fMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gxjP2Y+l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cvMxFw6i; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gxjP2Y+l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cvMxFw6i"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 923681D00114;
	Tue, 28 Oct 2025 16:31:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 28 Oct 2025 16:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761683468; x=1761769868; bh=8VDyGObemf
	lniOtuSCsh838Ae2fB8xHYtMC3B5R4d+c=; b=gxjP2Y+lM3ex/8lvj0MLZEQCbw
	sIhSM+AVaOaIbM/MwT2DZDh9uXQSfqVFcy0wNemomYJ4rN0jG2H5YZNYj63xHnHL
	yA8Hy6ZCQ0w/5eEytb/3XN28zp3dM3y1YE+HHXnPzkSCrAwPE9jiP7hqbRhiLAZU
	dfQ5uxLB6xaoRTFKbfCS2rRDp1E1jfYCM8kkETpcAQodRVhBsIlfksB331PGm+Dy
	5B9CEKc2NpXTc+pDccFBU1ShG9eLGLCXrq+gaE8upyUd0wTa+19oSYoMJlZ7ibq+
	oD8uDrv5g7uOEP4O4brfYAyCk2hTpl1DHPpk6YsKBMvJTIG422lcpjqzOhdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761683468; x=1761769868; bh=8VDyGObemflniOtuSCsh838Ae2fB8xHYtMC
	3B5R4d+c=; b=cvMxFw6i3mWRVgx3aPq6g1Jupr2pRXjSNuUp33OF3At4AYezrhI
	3WpLDtNzjO+BbAqVJPGwS7R9IMzGpkutkY6pwdF8FjfORx1ZXOw6Ae/mW1eGpVhF
	rjuSsR+kV7GwcRrmBJGKirynNYMOC5Vz7WznB45s73IIjVLcDrVmgX6zUhSwIeWV
	C5jh8xd06e7wALRW7aGdRm4sknLIUGQb5mKUbOm1rVt8Tc7QSbHxmY+XsAtcNlbu
	eQ3QfBx4Hc0Sc5YAUjK1fRZ1RQ1Hjozlg3DsgpABstcE5FHxPUwyDzvtNAqPkIRb
	b6XpdYViVv2WtaJt+u83JmLXm5ZMUXnkZXw==
X-ME-Sender: <xms:CygBaZ1uTc6Y7FXbjONfeM2Hf9UHcPC2htFW8U6BZmjOl-fddiLLJA>
    <xme:CygBaSUr44Xw9OxEHRoHQbI9pQHXyh6Dka_hVWgCWcuS6J8baNgmua_rj3y1rxPKR
    vz2EnAwKKgEyATa-4ncv6C12LaOHwvqULOP4o0fiilESx8KiaKbdQ>
X-ME-Received: <xmr:CygBacJ43OEPDN54EScNMIj-YnP1QXfYZFwt6Y-X5mrzaPLsy8F92VGsxocwdmcI2XyfN-AhTiIVNjSRT-Yqv5G3IcKSfSp1sQJJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedukeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgs
    lhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:CygBac0k5Vw9uPQ5pqDwr08jcZXIbPkydLp8atbFzvcdehqeVQydjQ>
    <xmx:CygBaa6tUWdT1BXZu3Re5ssjI14JMOEzBCvHtZk0M3jD8rlhBhIkig>
    <xmx:CygBad-mhrJ6NwwSDmWO8EAY4W25FJJniDgsrOIvHJ1iVkiF7-kleg>
    <xmx:CygBaZXCr6ibLysY2yLIncC1m_0az7U9I_GctqNNb-CuOsAbiIEMow>
    <xmx:DCgBaeIH1GrYZPF0t_ov6tEVavw5Qu6tOXrHKhuYi9RYpI2qq8lAM3T6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 16:31:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v4] doc: add an explanation of Git's data model
In-Reply-To: <5b078fae-6fe9-4fde-ba84-1070761c168b@app.fastmail.com> (Julia
	Evans's message of "Tue, 28 Oct 2025 16:10:52 -0400")
References: <pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
	<pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com>
	<xmqqikg0f1tk.fsf@gitster.g>
	<5b078fae-6fe9-4fde-ba84-1070761c168b@app.fastmail.com>
Date: Tue, 28 Oct 2025 13:31:06 -0700
Message-ID: <xmqqldkubwfp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> Agreed, I really like this idea. Came up with the following, which I'll put at
> the bottom of the "References" section if I don't come up with a better idea.
> (I don't feel strongly about where exactly it should go):
>
> NOTE: Objects will only be deleted if they aren't "reachable" from any reference.
> An object is "reachable" if we can find it by following tags to whatever
> they tag, commits to their parents or trees, and trees to the trees or
> blobs that they contain.
> For example, if you amend a commit, with `git commit --amend`,
> the old commit will usually not be reachable, so it may be deleted eventually.

Other reachability anchors exist, like the index and reflog entries,
but we have to stop at somewhere.  I am fine if we do not mention
them explicitly for the sake of simplicity.

>>> +Here's how each type of object is structured:
>>> +
>>> +[[commit]]
>>> +commit::
>>> +    A commit contains the full directory structure of every file
>>> +    in that version of the repository and each file's contents.
>>
>> What you are describing here is more of the property of a tree; a
>> commit is a bit richer.
>>
>>     A commit records a snapshot of the every file in the project at
>>     one point in time, records who contributed to create such a
>>     snapshot and why, and how that particular snapshot relates to
>>     other snapshots in the history.
>
> I don't understand the goal of explaining a commit in detail in
> paragraph form when we already explain everything in a commit right
> below this.
>
> My goal of this intro sentence is just to emphasize what I think is the
> least obvious point in that list, which is that commits contain every file. 
>
> Happy to change it to something shorter like
> "A commit records a snapshot of the every file in the project" if you
> prefer that wording.

Not really.  Somebody who is skimming, who reads just the headline
without reading enumeration, would not be able to tell differenes
between a tree and a commit.  Your enumeration lists _what_ is
recorded, the headline I gave you above explains _what_ they are
recorded _for_.

> I think the current phrasing is okay. I also didn't respond to some of the
> phrasing suggestions above if I didn't understand the goal of them.
> Hope that's okay.

If you do not understand, please ask ;-)
