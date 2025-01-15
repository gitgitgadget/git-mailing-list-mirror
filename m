Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD7C15855C
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736961568; cv=none; b=bRsgXu7onDkCbZKKIm9vJXFhZMGObWZTniNcNa4JqbdpOHiLLde7LNd/AvNQhnbKY/RPvidk2IEH1jnp2eXfWhgsDNykDk5raIiKz6qRDFC7pqLKVci7L2vpExPzXJHlvjCv0ESQHAQMQVajN+BjadAb8BI0WDuMskIPTd7GDRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736961568; c=relaxed/simple;
	bh=Ek9+JKkKb4sLNEXc6dWCYLw5txNA4xrCK/Du/hoT9Es=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZLDkyUIW5NDzHf77PFoQmW/0eDG53j7Ys1s9WPw2gIg1reHWWrRqPntzYqwiw93+t3GGX88lboxXnxRhYrhyhp04eOE6bRaRTk0BrNTwVTjg0M2MRM0Iznk/VOnM/kdIwLN1rb/itagHk1EsB8ytJOkugOol844250qVRK3+ymo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VyFEFEWY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pjef4tF3; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VyFEFEWY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pjef4tF3"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id AF8D411401A4;
	Wed, 15 Jan 2025 12:19:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 15 Jan 2025 12:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736961565; x=1737047965; bh=7uWvzWxhmq
	91AjhyGzYRbP5SY06F8IjQjSlNpC9O/Rk=; b=VyFEFEWYpdwLax8GmodRRnNMSg
	AGi5Jdt2Ju1yWl2M6h+sl7vCZovTH5dRRK2oDyGD0w9hML/jyFfdDAP5Kg50xmv8
	hcut9ymcyQuT3fUt2r62UfjSZog4wdk4NuQM2X28q+4nF6OeETHazM82+o9kf7nS
	T51ZMY/MtPZWqp6+si4l9bkNkoZQFS5kpWSLOT2qSoi2e4LyAVJunnCRc2vueStd
	1BP0yrFfNmsFKPLhYFJXuCSQVuc686yGBkEA5zC7Mg3ZzASQhc0iqCjMqBcNXVt8
	TZsf77UOvGkvlpz3PvCKo7pN8XBWn8CRzlj2zGr11s1HVg3pCj1C7Gm19WSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736961565; x=1737047965; bh=7uWvzWxhmq91AjhyGzYRbP5SY06F8IjQjSl
	NpC9O/Rk=; b=pjef4tF3ealD9shAeDjulHRkhUn1LmI/F/WSXexn8jJ4qJTEZ25
	s6Y+318DIkx3JY+971gv5jG/H82ViuaJ6jcJ5pDL3a+eTuYBU7QDZ0GOGCM76/uw
	5jKEXn/FO3xkbhgOPBc04zaKrczmq9FvkMiIyHPQVhI1WJoLu5Wr+JghTvM4XKIB
	fBQ/MQwU+D65t5Or+0QRDh4TIFjBUU/YGQjdls9s3QXugsDOYJoehVDU5YiUBynW
	7azcTKOtqWCMDpq3I6XWefUYlDyzcBQ1sn9kVIi/27mVdLCk7XPeQgp4iD5cvlz2
	VuiDf9ySeby5vvH4S1aZ9oQQDJGJBY7A8BA==
X-ME-Sender: <xms:He6HZ4Ge4PwG7z3le0afFj-hA3P11yIZdHD47KhNNdbxJYJTPwUKew>
    <xme:He6HZxV_7b555s76o8SpyLRoUYdfVz4_kZ-zn0WAKmTvC6xfJoWCd8tXxLOQaPQY3
    OdZkfmq-HjdAeKBzg>
X-ME-Received: <xmr:He6HZyJSCACcXECGricHhcfwXxXNNN1ztC8n_v7rkht5UEPogJzq2_--_eUcdcU8Uu8PU1CBuqVQQAo4L3fxcRD7iY6kJPONvyi4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgtvghp
    lhestggvphhlrdgvuhdprhgtphhtthhopehjohhnrghsrdhkohhnrhgrugesuhhnihdqmh
    huvghnshhtvghrrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:He6HZ6HwkPWYnR0J2ucuoblgOpXx3J5RY0a2OT6W1CFDlRyA6sKXqw>
    <xmx:He6HZ-XelnVH_xKpnIZLTJN9sRv1f24S32HCW7Xyzbf1Ft9n2Soqmg>
    <xmx:He6HZ9NBgS-21TYhn1SfO6p6lmQjgIPSpbwDsEJGr1g-PK4TFjfv6Q>
    <xmx:He6HZ10qTnY_Mxol7zW7e3jrPUwK7gBF9XynQE4GRTC3Ay1IE7c5fQ>
    <xmx:He6HZwdQEJlDwC3SqJLQOw-Htxnpj8JjVXLQCqZNzrlZ3_Z-XYxEwcIJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 12:19:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: =?utf-8?Q?Mat=C4=9Bj?= Cepl <mcepl@cepl.eu>,  "Jonas Konrad"
 <jonas.konrad@uni-muenster.de>,  git@vger.kernel.org
Subject: Re: Git branch outputs usage message on stderr
In-Reply-To: <c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 15 Jan 2025 17:55:19 +0100")
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
	<D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu> <xmqqed1414gt.fsf@gitster.g>
	<c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
Date: Wed, 15 Jan 2025 09:19:23 -0800
Message-ID: <xmqq34hkyoys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Wed, Jan 15, 2025, at 16:28, Junio C Hamano wrote:
>> Somebody may want to go over "git help --all" and for each of them
>> try "git $cmd -h >/dev/null" to find those that give the help output
>> to their standard error stream.
>
>     #!/bin/sh
>
>     for cmd in $(git --list-cmds=builtins); do
>         git $cmd -h >/dev/null
>     done 2>&1 | grep '^usage: ' \
>         | perl -pe 's/^usage:\s*(\(EXPERIMENTAL!\)\s*)?//; s/^(git\s+[a-zA-Z0-9-]+).*/\1/'
>
> Gives ...

Being consistent is a good idea, and I wanted to first gauge which
way we should unify.  It seems that those who spit their help text
into their standard error stream are indeed in minority?

Thanks.


