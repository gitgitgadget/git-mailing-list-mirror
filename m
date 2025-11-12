Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D0522688C
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974971; cv=none; b=ky0tQ1qGknvDhoty6AMdf3d+MKU/9B6jPoPm71yEHiflkMZpRXqULe4kAbZMvJYgLi9MbNLiJSyi0r+DPAZP/N7OJbW9tSG2CN1UBcEVSB3R4UA91TVQwgO1kc8zHJ2ZCE92jGED4IMLnKq/O4dwptOeDhTmalA3J8fEbq4kLfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974971; c=relaxed/simple;
	bh=GvCS+y2uEWtUKYO5+7rttgZShHEFteuREny+QTsZXWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bgtqECWvO06XidVgyzr4iUu2W+mX/uaoqlyMf1DBui556xMhZf+7J3dk/BXkVE3cyONYe+Ql4zJTTqlm57PfdUHfnRmvACmJlHrUg2UuT+l2Gk3tRw8jlF0fLl6HdvnFDy6TU7vrc81hHArzQo/HP93L5KeQ8b/7dNhs0p75h7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E3eaM6Ie; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mlVCIxch; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E3eaM6Ie";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mlVCIxch"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0059F1D00189;
	Wed, 12 Nov 2025 14:16:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 12 Nov 2025 14:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762974967; x=1763061367; bh=q4GY5rkmrz
	6rf7V0faXepn2uNegt4AjCuJWMmJXPqZU=; b=E3eaM6IelbHrC1B4yQU/jrCIyG
	mOaDoHFJ11sT8c7a2jrqKjnq2GlqyPZSZqaJG1mmbDLGbWPlggFtHJ+t6zsjwdex
	9EDoPmKt+GVy3b0zGeyQgKmxdfK2MO/ozKvQBzK9iLgmZtCp2GOksSVv9OAEp8Pt
	liwYVKjSmLsdOZj+p8bj/yZme1+6inX9F8Dk4Sw20JeskaDmcTbOD7siTu+ZN/si
	zd9T8mN3uBulLSJckWvwTP9QbfpgdgqrvdpadV6udZyQFQbB/eJetyCZvp3Uw5je
	m6sWeHzfEu3SceqXwoYS9Dlld9gL7jW2Xa5y5Igth4inkGFCZWM3k+9iKnMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762974967; x=1763061367; bh=q4GY5rkmrz6rf7V0faXepn2uNegt4AjCuJW
	MmJXPqZU=; b=mlVCIxchaFgKcs8AyZCr49jJP43VFGo9/84Z1i056YZIev4fk6t
	HNcZO5vbcW/593gvzv/pkfq/k+Zkz+eD2GT4uUKTKCsz7s+CjxrhLUEPFnR2QFaM
	1VsxzcJPChGlwPweHjehsrmflGUd5Rsgv7t5+D7p7LNGquGtXiSPT0rfm6YTH7c1
	f4YBZ9UX8W8TYMtMkGAwGl2/H5kVdBjnpvjHX5Vwf4rsUNuxGlwBvNlzEiXhoMq2
	QWhr5aDorSrPRJDkj6CnHnErvRyevNQiy9X/xBzwySKOFk1VzalIzx0jM1ENPPTw
	naiUp2cs2Y0MNAxHianRwZpza3SFqcOZ1ZA==
X-ME-Sender: <xms:99wUaXBSSLWQ1ealAji9PesAZxyoUsHrvSDOMadFZ_pBSgeCiuApCg>
    <xme:99wUafy96UdNH1v90rTRb_uO5NhGrUFFMsz_KbRiaV3-IMyBxaGmagft1HuGp0sTJ
    va1nakLbhrri0fh0Yie6lBG84jlymMnYPntXeUAQtGurrvAENyi9zY>
X-ME-Received: <xmr:99wUaU0oyjYqFCRXBK7mYFdNTftQEKCyjkOyjRqT9tjlXvTp-sIGi12bVnAAQnrtAw9LuuSsE8hpNwS4l59YEtuuxTzoTsswYNei>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdegkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:99wUafzE82-9AitJS4-78F9G1xuEBzAWMSunWWYb1lf9Ky_nHe7SmQ>
    <xmx:99wUabEbyhUdvohxxOwp2WxSgjUoCNmETw50TNrnUSebD_YMJeVcIg>
    <xmx:99wUaSYwaDOm1W13OEMUgTVbMcieYpRieOlNYpVj0ka0DsUeoREoXw>
    <xmx:99wUadD_gEmFHXZ8L31z-qxhQwK7AN5kyfy5Az7gFC3AEX3NiNv5pQ>
    <xmx:99wUaelP3L2QjHE1Ng45VWQIGJv7BzhBiaRj6_wPihlBzofXDxlMivGX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 14:16:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v6] doc: add an explanation of Git's data model
In-Reply-To: <2474339d-67bc-4a68-9f26-fe7edd172ec4@app.fastmail.com> (Julia
	Evans's message of "Tue, 11 Nov 2025 10:24:38 -0500")
References: <xmqqo6pde90w.fsf@gitster.g>
	<D50AB3E0-E41C-49CD-9407-AB60331A6A43@gmail.com>
	<xmqqa50v4x8n.fsf@gitster.g>
	<150f3442-93a6-4469-9c25-5bca24accc80@app.fastmail.com>
	<xmqqfrakyj0w.fsf@gitster.g>
	<2474339d-67bc-4a68-9f26-fe7edd172ec4@app.fastmail.com>
Date: Wed, 12 Nov 2025 11:16:06 -0800
Message-ID: <xmqqa50rqcy1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>> Maybe its just me, but I find it a quite roundabout thing to say
>> that a ref refers to an object name (or "ID" if you like), simply
>> because name or ID *is* a way to refer to the thing that is assigned
>> that name, so you are making a ref to refer to something ("name")
>> that refers to what it ("ref") originally wanted to refer to
>> ("object").
> ...
> One idea I just had is "a branch is a label for a commit ID", which
> I think avoids the issue with "name" from earlier.
>
>> That is what I find the most strange in the construction "A branch
>> refers to ID" at the conceptual level.  I am much less unhappy with
>> "A branch records an ID", but stopping at that may make readers ask
>> the obvious question "what goal does that design aim to achieve?"
>> (whose answer is of course "to refer to the object that is assigned
>> that ID").
>>
>> "A branch refers to a commit object by recording its object name",
>> "A branch records the ID of a commit it refers to", "A branch
>> records the ID of the commit at the tip of its history".  Any of the
>> phrasing that does not make "ID" the object/target of the verb
>> "refer to" would work to avoid that strange construction.

Sorry, but I am having a hard time to come up with something that I
can give to help somebody who rejects "record", saying that it is a
new verb, and in the same message introduces "label" as a better
alternative, as we haven't seen "label" used in this context,
either.

Besides, a label, a name, or an ID are all that are used to refer to
something (in this context, "a commit object"), so I find the newly
proposed one just as roundabout as "a branch refers to ID" in the
same way.  The use of *ID* is a low-level implementation detail to
make the ref work as a label for, or make the ref refer to, an
object, so "is a label for ID" is just as bad as "refers to ID".

If we do not hesitate using a new word and introduce "label", "a
branch works as a label for a commit object" may probably work,
probably.

Thanks.
