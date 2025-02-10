Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8F324FBE2
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207553; cv=none; b=m0KS0kgF1WyCApYnVELeWf81J5IXx3FN8CVPoV5E7lE594Zqm0U4M8GW/MDVPGh3XSa7qy7gakyvxjoBCApDglKbqupag9/XDaT944OIXSKu1A5ZvWeiUdc4pwuWL1jCRgGX7m0/3qBaztlGkFcHApSIr6xpmxKXrPTERrdsB0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207553; c=relaxed/simple;
	bh=sszYyZJjCZv1kcJxBFT6NyWt6yHL36tL1lig1W+sDRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HQ+LCt+L9MHZycBwPBdY8bkX1HpmUVYjhB/5oab8N+6zVHxpS9gfahaGgw54ALIZVPXYbAnhxjQuCAtdjqx7/Ix+7LvW9nayZThBKytVVf3n1kTVk+XpPfpTuiwFwG/MF6a5C/Fb5re+lfwUzBCctGyRf46G6AEU/o5B/tPbfMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=r2qUkXET; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FgD1WO0+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="r2qUkXET";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FgD1WO0+"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C1C4113808BF;
	Mon, 10 Feb 2025 12:12:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 10 Feb 2025 12:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739207550; x=1739293950; bh=m9iGcK/vvp
	ei56ck+dFmaz9FaYjKNXEOs7fw+AnRzoA=; b=r2qUkXETevvG9SGQ4tCbIBO4uG
	WHBMGeq+xGZdxdNiu8IXjN6Io/nrVTQ5kfdi41kLxxG+YZCW4thuM3p2dpH4sfO6
	sbHA5+FTyZAYMyH7QKSqz+11xVltBEtg6aPTqxiU2Uu4V97NupK0INen55ouaZ1/
	Pa8fJPgoSn/fUJwJvWWezVEm4ELr1f1dqmIkcOh0cK+w9m4XtucweM2guO6yssCr
	dTtZnsWyMxPF5dLtFzJ7xHz9qK43gA+cVliEvfLN9aSgJpnSBvI4OnUU+COawRJC
	zPEZRkPFnYL8DRbFPAaeVxzoCyQisOatqcDNs9IkvYvnCtkCKpdpG1ACNBEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739207550; x=1739293950; bh=m9iGcK/vvpei56ck+dFmaz9FaYjKNXEOs7f
	w+AnRzoA=; b=FgD1WO0+kZ+xxMdhZRTA5WCPQSPJ3W7/JBFdCg+mPnt5xbBgjzm
	NAxTvGD/HUm7832zCU5YJXmqNm+idzRFUxBAbQPct8y1Jes0i0xGTjnV8h3bkg+w
	cY9gFHlcwCFntXfyi+957fyopDQKH2u8HUXOYrsyMt3eQWM3Po5oGxbTO2b61zMq
	CJ+3bXwHim6VyIgfSOxW4c6Q8BJY6MAeb1ZMZ//YdXnDE/i66irIFF2zd32RIo85
	CG9Z9FP8tmUU/cgwX6zlzVs18sAGqoxpwhBZp1413pSk3fKwehoVJB0DGvw9gUBz
	ZXvDBAOIwgUllD3bjtPW+kR+pxDVtF+NBDg==
X-ME-Sender: <xms:fjOqZ1KAy6nSQH2eZcbA-Rvd700z_QIa1MOOHnKJDLBQREa0M_ri5g>
    <xme:fjOqZxJrfdBxu3zgT8PxHhp_mZgm116t7umlf5n0y9fC1BWtk17mK2D7LZpUJYYsU
    K6loS1Oxp30sREPbw>
X-ME-Received: <xmr:fjOqZ9sakbun6AUzMJcgzbxwYpc4ol4szK-2ZQ9KDxYwItbxPEWm_vdUqTaLJejORgxkvE4Qtz6VFX0nanhkkHmp7HvHWejrw__X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkih
    hnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehs
    hhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhntggrihekie
    esghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhi
    lhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fjOqZ2adsCvdNnyDX0WTRe6n0pIb0CG0v2mxWJzSCiimRFqce3hibg>
    <xmx:fjOqZ8Zs6BGPqYwxrlZI673pVHZngwO8e7Vuh5zOFVAha-XUL1RZvg>
    <xmx:fjOqZ6DQHu3jt3Bvi310V47o87NOg_hYChyYexn5EmFlxn7dO9rVXg>
    <xmx:fjOqZ6YlrCvr2A0M4pGytTWziGM0gP9vvD015soxhpXjYcCFeF9MLA>
    <xmx:fjOqZyNw-ETdm70YvCmkMVq0Vr4yxnc6gEnhxvLpyWjMLqYvwXRe2Efq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 12:12:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  shejialuo@gmail.com,  johncai86@gmail.com,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [Outreachy][PATCH] builtin/update-server-info: remove
 the_repository global variable
In-Reply-To: <20250210142820.3588250-1-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Mon, 10 Feb 2025 19:58:10 +0530")
References: <20250210142820.3588250-1-usmanakinyemi202@gmail.com>
Date: Mon, 10 Feb 2025 09:12:28 -0800
Message-ID: <xmqqikphbu6b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> Remove the_repository global variable in favor of the repository
> argument that gets passed in "builtin/upload-server-info.c".

update? upload?

I somehow thought that dumb HTTP walker support was on the chopping
list for Git 3.0 but apparently it isn't, so updating this remote
corner of the system I thought nobody cared about is a good thing.

I personally feel that from here ...

> The RUN_SETUP macro is used in "git.c" when the 'update-server-info'
> command is wired to the 'cmd_update_server_info()' function."
> This means we can be sure that the `run_builtin()` function inside
> "git.c" will always pass a valid `repo` variable to `cmd_update_server_info()`
> when the `update-server-info` command is run inside a Git repository.
>
> When the command is run outside a Git repository without the `-h`
> option, the command will fail (`die`) inside the `run_builtin()` function
> when the `setup_git_directory()` is called. So, the `cmd_update_server_info()`
> would not be called at all.

... to here are way too verbose and unnecessary.

> When `-h` is passed to the command outside a
> Git repository, the `run_builtin()` will call the `cmd_update_server_info()`
> function with `repo` set as NULL.

"set as NULL" -> "set to NULL"?

   ... and then early in the function, "parse_options()" call will give
   the options help and exit, without having to consult much of the
   configuration file.  So it is safe to omit reading the config
   when `repo` argument the caller gave us is NULL.

and that would be sufficient.  All the rest of the proposed commit
log message can also be removed, I think.

Thanks.
