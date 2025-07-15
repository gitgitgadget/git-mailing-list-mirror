Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC4722F767
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605419; cv=none; b=mN1Ua82wQYp0nwp98faEWzuNQ4CyklGiIbbMsFXaQK/v8CBYqu2VHbN8uPo56J2uU53uZw2/Mz4RkWu8PqwFqNigk6SCxJoAs8bCx0wnWgNqMvT+omyaYEFgQ5ilAVl4c26dHCwTohEnqs3VuhwV5H1KTCyQTxLM8goveFcCsbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605419; c=relaxed/simple;
	bh=b1oldHm0f2Ewm0J0+8BTQhnyggESFcODoUz7oqYqaSg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hko5TEd3+6jL6lTQv5p/dME3G94oi1D6mpkm2/gUqIXIXAnMqxjoDQJiBtUCl7/+W+OMnIwm3er8/wyWxFL7QW06XNjLZBmzkHFL1QCJURt+bYrdzX7hN3GXzaMAkweGqRIHtho2CNYc5+H8gQaZ5SGWOdlFZKNSPYm7553SjCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GY5AnWwa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iuJLP22g; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GY5AnWwa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iuJLP22g"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3E4B37A027B;
	Tue, 15 Jul 2025 14:50:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 15 Jul 2025 14:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752605414; x=1752691814; bh=au2vRnl+d+
	E+H2Pdz2Leo3KJFWo3OLG4YXItCI9lCqw=; b=GY5AnWwaHhXsMhoUMctMqetiGT
	cES7Mh/7eZGEaEFCAFyvK2UUulZOUOd7Wwd8yxN8zUdD0UBNjfvWAJUMvrPRLaLO
	VfOuALgY1GehGjRpEt+PFJJKKoHN0mPYVM8uXFBYdxZyYdUenow+nrb9azxVOUyq
	tfyZdZVao38ikuOFRGaDGJPXRhDv1itAezc0vNcwi6Q5uGYrVBnvD6fNES+8XJzT
	jsObeoIqI1qJvvprXrEQD/7SDfsCpwUvRYd6lAsbG/0oq8aJ9P94+DWaeWBZw9Rt
	ALRYLZFCjN8/vutCEiIQ6cvPVzX8VmLf/bDMOgqAi85VRnM2sdAOj5cD7yEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752605414; x=1752691814; bh=au2vRnl+d+E+H2Pdz2Leo3KJFWo3OLG4YXI
	tCI9lCqw=; b=iuJLP22gCJug295/VYQyn05Ufir+sZFBbR8Y6KNO2qmIebC6WTH
	uGeoE8sRFoXOaZY1wFS0lV5gYPXyrdXU1a6CffdaDctxw0l3aowMKcPt/wDUJhyE
	FwTXQ2Yb9tQq4uEyhVv7Ryf/QIWlQbeyx4aPmMCcK6g38tUQRzknb9HuYWBOU6RS
	z8wY85T8N4EsCw5yapP8NKGub5+mVa8OdZvCcsoJETJQRu0HHhANWUdVuni8LLC3
	4dx7830fHfUwkKGNoR2f3Jym48loEHvxMPIGjUFqIRlTIKTS8GsuHi8BkU87Kx5g
	pFKeABenc4ugAh2vSPUpeDWJIMR7kXB2erw==
X-ME-Sender: <xms:5aJ2aKUTgDL_-FRq4S_albdRZeZLA5oAphdzOj3b6fkpoDm57sVYWw>
    <xme:5aJ2aCEuXWfeY7DjTcVp994_hxDRau1SDS8d3dAbgPXZQaIaFhavp_ptwVqlGMUu4
    R4SdQg7P5nzAwEpHg>
X-ME-Received: <xmr:5aJ2aE10K2R3PfYUm6oqnN7cfD42qpXqoTDIh-HTydzOuh1nFGeMGYxse5BXYhYl4lCVroT2rlim9D9J30o5L1i7Q3nUeqwuOoCZYWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgrrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5aJ2aMNvD-NFEwWd0U9tmjh_4uQ0sPtZ9jzGHdwRLDF0la7kv6Dtvw>
    <xmx:5aJ2aL4hvLGOrDbL3o4umc-kSwUbYFG4vK7uEzNnQFzFtdElX_WgGA>
    <xmx:5aJ2aO1ZzOjte9uqPQSq_kuEc-StUZibu54_0oY1W-lt51RmlcJ-yg>
    <xmx:5aJ2aEx5uhuvODE_K-S6Z6ToAfRsyQ1J0mpprXSBX1460xxknzojtQ>
    <xmx:5qJ2aPnieoZsi0CaOWQ9JX83tsMTYEGObnZy5Y0UnjRi-lm512Aup46r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 14:50:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Ayush Chandekar
 <ayu.chandekar@gmail.com>
Subject: Re: [PATCH 17/19] environment: move compression level into repo
 settings
In-Reply-To: <f6479d6a-32a4-4a49-a75c-589978cb9a57@gmail.com> (Phillip Wood's
	message of "Tue, 15 Jul 2025 16:51:32 +0100")
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
	<20250709-pks-object-file-wo-the-repository-v1-17-62627b55707f@pks.im>
	<32fceddc-c867-4a47-bde8-c873279edbc1@gmail.com>
	<xmqqbjpq1rs0.fsf@gitster.g> <aHY7LYHqVj-ECf_z@pks.im>
	<f6479d6a-32a4-4a49-a75c-589978cb9a57@gmail.com>
Date: Tue, 15 Jul 2025 11:50:11 -0700
Message-ID: <xmqqy0spgufw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Indeed. My objection here was that we were delaying the parsing when
> it wasn't delayed before. Is it feasible to call
> prepare_repo_settings() in repo_config()? That would at least avoid
> the problem that moving config settings into `struct repo_settings`
> changes when the settings are parsed unless the command calls
> prepare_repo_settings() at start up. As far as I remember `git config`
> uses config_with_options() so that would not be adversely affected by
> such a change.

Excellent point.

>> My dream would be that all configuration were to be defined in one
>> central place. The configuration should be typed, there should be
>> verification for each value configured by the user.
>
> Being able to verify config settings when they're set would be a great
> improvement but we're a long way from being able to do that.

Yes, and there always are end-user or third-party defined keys that
are not known to us, and we cannot tell if an unknown variable is
such a end-user defined one or a typo.  I do not know if it is
feasible to aim for that.

>> But I very much feel like this is a pipe dream right now. We already
>> are
>> working on multiple fronts to modernize the code base, and I don't quite
>> feel like opening up _another_ large transformation right now.
>
> I agree with this

Agreed.

> I agree addressing all the shortcomings you've outlined would require
> a lot of refactoring. If we can find a way to avoid introducing
> anymore shortcomings as we migrate away from global variables that
> would be a good start.

;-).
