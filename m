Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96E1749A
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 21:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739915140; cv=none; b=sYcAiZjX4pOesPsnUx/ecLCF3q0+iPbFx5hNlLQbSzHnfesAeeE/q7x9T7p34jbU/IX0mFC++JXza86XMrseaNXmK3C3tba2j0OPwSvgBEUjZEqifwxQItLG9ufUaat1PKQdeGtCIpiKOBFAxMllM7/j3ECQCbANtAhSSo+Sw7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739915140; c=relaxed/simple;
	bh=xURPeLqeWmcBdQndokN8XrEqTXUgLnHg5F6pYToOg6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mpOnG6pRKLjgAK7BcOLEAn1C/7xDkVKJcbM+p7uo2FsQvefwFv8cGqttYwJnFzsC2/TRF5u7W8Lf7xHNgosfkKEyz9sxcl/b2vWq01gFUiTODjDub5oKk1jprmRu/AzSCufZzgEdAlZng5FJFn6liblPoasZIbb3QSrx/v6hpQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lUrjb7A3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j3/Iya3+; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lUrjb7A3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j3/Iya3+"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A8AB22540135;
	Tue, 18 Feb 2025 16:45:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 18 Feb 2025 16:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739915136; x=1740001536; bh=Y2Kify0uaF
	dbdaRvh5OrTbavDoFstgktU/Fc1YTX7G4=; b=lUrjb7A3p1M5oCtc4qjKVrkgyc
	FblB7EOxKByGp8qIe8+NAY279dP2vdUefD3qmD7xVTFIWmpJtLYjRvUa+A0c2o3p
	7v1MTLqY0zPVVWWcrg3i2loB8EeCwJSO9OJ5oFAuACeLe+at9h5luCTco/q6AjHo
	wLoCxpUuXMI4ZySfq90Jykuk0p3OBB5GexBiHZnzSjyK3+FVRoZcu3inXzTWlHOc
	2fv+hCCqGxql1P0YBIih33LPDEYxh5DUhRUqLv95vXoQmQksN/Ms8z6QVTMrXZh5
	DqLbPFK9PpiQGVZPZvvEWS3id1TjcxT/hPTlvLZNwqsOr9ql671hQMpCxGfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739915136; x=1740001536; bh=Y2Kify0uaFdbdaRvh5OrTbavDoFstgktU/F
	c1YTX7G4=; b=j3/Iya3+MKErLbCccCV48lkt6pcrcDLehXvGnAoSRudYrLOqbD+
	keNiwdFt9jjTlx2QIbXG14cGfJE07GzHJEv0rU5c2rkhTNJsPRhjIOwlSZqYBIpB
	XVQUveYtbSABmYQZWoQU+T5k0axgFE1PjtHDloTpnIDL7QO3ti24FFld+s7yQPcd
	q58nzyJ8n3sZ6Skr1hgN00Mr2MOn4cAqg4LPlIg3AbAuHvDrvuT+FJgTcBcCi6PD
	rPikwaFMSFYK+DnyANa9nTGuJUjiQ5IUYbQRCmpmOwm4H0II4jVFBW9wGZJ0p8Gf
	vxY0T12ryG04TFBzgZzqF2m+h3qBa7K3RTg==
X-ME-Sender: <xms:f_-0Z9nXDPgssMr2lDyA47fIPNrLdNuo5xRaJHMKTvf1Q4SP4zWj_g>
    <xme:f_-0Z435ZpmtRoHtQMqCuswYQyihCml4_DmRYENpAvs2PrIUwaGRKVEBY3uuOymb6
    lA004H-Zlz_RuRInw>
X-ME-Received: <xmr:f_-0ZzpHaSDiJ2Dqp7kbiluC_m-4Zv2vuyGaCcFXxJU1kZ7nyy5o6xfoAfvTK3_DexkLktA3Oz0p4RKit34Pu8HHp6am2XDpr6I8p7c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivdeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhnrd
    hgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehplhhuvhgrnhhordgtohhmpdhrtg
    hpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdr
    tghomhdprhgtphhtthhopegurghnsegurghnihgvlhihlhhirdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gP-0Z9nbLJ0t3-Wt4uiyhSISwl3GyFyPutSNYtUGOvJvrJcru-21gg>
    <xmx:gP-0Z71V7k8UVHTyhVdi11mzEohaPz_TGWYVYKdHxC1fTWc-mv7mPg>
    <xmx:gP-0Z8vrpJo4GL9Lm0J2wUHNYBdSlaq1ip1L8jYICNfwLQP1feogUQ>
    <xmx:gP-0Z_VY0t-HqgwoE_FQBBngMFZoIutH-ivAeRVk2m5DXSWbou0g1A>
    <xmx:gP-0ZwkBZqf33RbEApqfSkbp7FlZkOaTv1Ecw14IwNx4RGpX7orZlxiT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 16:45:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Antonin Godard" <antonin.godard@bootlin.com>
Cc: <git@vger.kernel.org>,  "Emma Brooks" <me@pluvano.com>,  "Patrick
 Steinhardt" <ps@pks.im>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,
  "Daniel Li" <dan@danielyli.com>
Subject: Re: [PATCH RFC] builtin/log: include From in git show --format=email
In-Reply-To: <D7UQ9PQOTOLT.26JEMSNOV4WP6@bootlin.com> (Antonin Godard's
	message of "Mon, 17 Feb 2025 13:42:47 +0100")
References: <20250214-git-show-from-email-v1-1-df6469635454@bootlin.com>
	<xmqqh64wl0wl.fsf@gitster.g> <D7UQ9PQOTOLT.26JEMSNOV4WP6@bootlin.com>
Date: Tue, 18 Feb 2025 13:45:34 -0800
Message-ID: <xmqqh64rj5a9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Antonin Godard" <antonin.godard@bootlin.com> writes:

> This is what the documentation seems to imply, but builtin/log.c uses these
> configuration variables in git_log_config(), for example. In the same file,
> cmd_show() uses git_log_config().

"imply"?  The documentation says so because the command was designed
to work like so when the feature was added in mid 2022.

    34bc1b10 (format-patch: allow forcing the use of in-body From: header, 2022-08-29)
    d5fc07df (format-patch: learn format.forceInBodyFrom configuration variable, 2022-08-29)

Please refrain from using words that imply value-judgement from your
analysis and stick to the facts; I'll try to do so in my messages,
too.

As the log family of commands happen to share much of the
implementation, their code paths pass the log-config structure which
is a mixed bag.  It does not necessarily mean all commands in the
family use all the members in the structure.

> With this reasoning in mind, I thought "git show --format=email" should also
> benefit from the format.from and format.forceInBodyFrom variables, to correctly
> display the output.

"correctly"?  

Changing the behaviour retroactively would mean that those who have
been relying on the fact that in-body header configuration meant for
"git format-patch" does not affect "git log" would suddenly start to
see their output differently.  So I'd worry how bad the downside
would be.

Having said all that.

In hindsight, or if we pretend we were in 2005 and starting the
project again from scratch, if we did not have any "format.*"
configuration variables and instead all of these were "log.*", I'd
agree with everything you said in the message I am responding to.
In such a hypothetical world, we may not even have added a separate
"format-patch" command, but used "git log" with an option to spit
out its output into an individual file for every commit.

