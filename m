Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2534D13635E
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 22:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839671; cv=none; b=MMGjybLvsIqI6HW7JkIDVnG9uj9jutaNDuv/ULHZjFx/G7kpKXMaI20cPtDZTUZGwJhg4cDg9x0QIDY3UVTUjlQnH7StE5otXOz4+CrQ4I2bWeb+BKwHMsCfQj0hRQNr3SWZ//hjYJh7IogH6oKCC8RqujbYnurSTRGGmK/q55A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839671; c=relaxed/simple;
	bh=nWGwi5Z3G1ao7rOLLlRfl7YiYPjSnvtttghXQs3lwNo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Nr/eLcEzPuC2cciDaPbpZCYwr7kQhNJuIxP5Tylaz/TMJpzk+mNaQMhCWLdV71jI6VD4j03uvWGrD2+ZHi4VPub5HMd2XwSY/n7GKxjyIrgrlE65Te2UdIlKfJm3zeiYsdPZjTTaSBQbiHQoNOFLwXJBncYLbpe6Qtz2KcCLO3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=MfNSAsYg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XkC8oi+T; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="MfNSAsYg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XkC8oi+T"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2DFD27A0075;
	Thu, 25 Sep 2025 18:34:28 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Thu, 25 Sep 2025 18:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758839668;
	 x=1758926068; bh=acirDCFB8xkKzqEM0jJLInajCDaHlWVDyTtq9BFGQ9s=; b=
	MfNSAsYgoZolfKmSV10K7D5YCLwqazjG+d7MpeNQeN0rAGhzKT7v+AW1dgk+nu95
	HMSwJe8iwyDaPb7Icw0Qx5F2Qd0MxCJZSEqXN4yVdNSmxavLO9XgbqWzkVZ8YIjs
	ZkL8Hbr+GVLn7P7y7wB4k3/5tZnYeJAzYTVd89JEcLYZ18rGukw5K8lE78lb/0tr
	7cy6XrMKjJFz7fEJWU3XfUCfYkePnty+vEG1n38wO5sUz72qQhP5fKa/Lb5OkuYm
	NoVu5McoHXPmw1bqCg4Cnymt32dMmLi+Nm3YFWPu64nvXFZYZCYrldOsL3QqG/sj
	sFR+7sPE77a/dRBrKUJaOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758839668; x=
	1758926068; bh=acirDCFB8xkKzqEM0jJLInajCDaHlWVDyTtq9BFGQ9s=; b=X
	kC8oi+T61Cq1NI70ounDI4qFbVtIuz/8klbAGBx2uZBy0sRO/hRh2u9GWWTcr+ri
	jD+WpxbgS2nbm7ZU/69PJCN8/n7pem1QOeQmh4ofg9DrMdV2z7rO07lbxtGhnu+5
	chkSzB+ZvHth8bNFZFrHlmbIZGbNksaFdMdPw009vWOkLX17p/Vxk3jhT4gNFj8t
	qjYek8TMrCp7En/PY6NhWI9ZEiGNeZJPtTZOSuyg42wxMgBKuSrsrdGaLv4b2eg2
	G/s6b+JErV34oSdMNqKUBElqkykgfXcVvGPMpJYIFz8W19Ib/xOIJJGBgtgye9cb
	FEs7P7W2zpLkieTZ8DCkQ==
X-ME-Sender: <xms:c8PVaM5-gnM9MCj2E88d9b6ne94dgDRdIR9_LleXW82Q80euMB72dQ>
    <xme:c8PVaIvl89Gl7CyrxQU5XYOWdRDuOGaj3XsOlRyEaBLpAOZ881Rj1DZ_A8JF_PB4p
    PLYfpZYvarcQ8NE2lP_n1-7Z1x0TxTmbaMcJuMRIpGpqgP3y0E0wNU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfluhhlihgr
    ucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpe
    fgveekudeviedvveeuhefhvdetgefgffdufeeguddtkeegtdeltdevhfdtuddttdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrse
    hjvhhnshdrtggrpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:c8PVaM-h6UnPWh6DOAAsol9S8PHza4nxmbJuuhud70gWyStiue-YNA>
    <xmx:c8PVaGMJT5LpDJuBZxum5vDOy9PYUXN1jHcEcWgHi1tlLtizTxUU1g>
    <xmx:c8PVaCGubwSwyVocmsnwgUblVvt9JHaQiR3pXbgAW9QX9k9Ia7_Tcw>
    <xmx:c8PVaMQjZ2LXd8Va5dm4UGCoP65XzssejH0QOCviRE2dDtGbFcgDEQ>
    <xmx:dMPVaFflztVyFxsIGEhpgCf9cTrN-vxy5JUvwYGX8yuVjQBWMY32dG5k>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B2F7078026F; Thu, 25 Sep 2025 18:34:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALMQnK0r4jnk
Date: Thu, 25 Sep 2025 18:34:07 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <1422594f-b0a8-4a7a-bf78-940693757224@app.fastmail.com>
In-Reply-To: <xmqqzfaidyil.fsf@gitster.g>
References: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
 <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
 <be6453d010bdc9d2b49988d6841dd7e7f9bdf1f8.1758649472.git.gitgitgadget@gmail.com>
 <xmqqqzvvk4bj.fsf@gitster.g>
 <2365a7b9-3d22-4406-876d-65822822655f@app.fastmail.com>
 <xmqqzfaidyil.fsf@gitster.g>
Subject: Re: [PATCH v3 4/4] doc: git-push: clarify "what to push"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Sep 25, 2025, at 5:15 PM, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
>
>>>> +As a safety measure, `git push` may fail if you haven't set an upstream
>>>> +for the current branch, depending on what `push.default` is set to.
>>>> +See the UPSTREAM BRANCHES section below for more on how to set and
>>>> +use upstreams.
>>>
>>> This feels a bit out of place, as the safety measure, as I
>>> understand it, is only relevant in 3. and only when push.default is
>>> set to "simple".  If we are referring the user to the configuration
>>> section, then it may be a better place to say that the "simple"
>>> setting requires you to integrate with the branch with the same name.
>>
>> That makes sense. My goal here is really to communicate that you may need
>> to set an upstream for `git push` to work, since it hasn't been mentioned yet
>> that the upstream branch might be involved in deciding what remote branch
>> to push to, and it comes up pretty often when using the command.
>
> Actually, I think it is a mistake to tell people to use unadorned
> "git push" all the time.  Have them say "git push origin mytopic",
> get them feel sick of doing so all the time, and then tell them they
> do not have to if they set an upstream for the current branch.  IOW,
> "sometimes you need to" is the source of the confusion that comes
> from giving them too much DWIMmery.  You'd by default need to tell
> Git, because you know more about your project than Git does, until
> you tell Git once, after which Git knows what to do.
>
>> Perhaps this instead:
>>
>> "Depending on the value of `push.default`, git push` may fail if the current
>> branch doesn't have a configured upstream branch.
>> See the UPSTREAM BRANCHES section below for more on how to set and
>> use upstreams."
>
> So, rather, something like this
>
>     "git push" needs to know what branch to push to update what
>     branch of which repository.  It is done by giving command line
>     arguments and/or setting configuration variables to the command.
>     See UPSTREAM BRANCHES section for more information.
>
> would be more in line with a preferrable mindset users would have to
> successfully use "git push", I think.

In principle I like the idea of saying that "git push needs to know
what branch to update...", it's a clear statement and it seems logical.

But I'm not sure it's true in this case: we just said above that
"The default is `push.default=simple`, which will push to a branch with
the same name as the current branch." So with push.default=simple,
Git already knows what branch it will update, it's the branch with the
same name.

As I understand it, with push.default=simple, the reason you need to set
the upstream is not to tell Git what branch to update (since Git will not
even let you set the upstream to a branch with a different name), but
instead it's more of a safety check to prevent you from accidentally
pushing a branch that you didn't mean to. Is that wrong?
