Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F634C13D
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735930950; cv=none; b=E5oJiw5aC6Q+msgMWR4d2iQ9WRNR7Tg/gXPEsQJ3AhxuVvEbHuNH3U/Kf8tqGdmpxkm5oh27iHG3AV7WAbwkY2USx1bbPZBVAQcaYgBxBSRPOprDm4GoME6qjdcplXjCf25Y2B3ogJbFIlFDEZAkSDThdjnaAoT8P9vxi5p2lZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735930950; c=relaxed/simple;
	bh=GMNQYvUOefv3eWj6axI/RgXB1DZ+vR1RW0AtxAhZ6aI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iJFXFQdgwZMjbYxzFvuWCtLR27bnj6ud+an4s0XmvOs2CqQ6DWejm0FwDlUjm//BfYYcu7EHHbA/cVR7PneS+se8wnpR55An75J9spCYDqdSq79gJQgcTe+cTGfET5rWTm5NOX/Lx2iNnVJzBy2LLkMs5Y54LXccpn8aNecedNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dKSDCkq+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t+bc6SKE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dKSDCkq+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t+bc6SKE"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0FE49114022B;
	Fri,  3 Jan 2025 14:02:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 03 Jan 2025 14:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735930943; x=1736017343; bh=2br7VlvbE3
	auyNQiFJMeP2xWP6F3BlenuSELxJ2kR3U=; b=dKSDCkq+YvO7yowQY/LNMO95AO
	MIeVD58POxsksaZ84gZZ2z+Pji+fr+6VOeaCPtjSmf81UPQYMuzpfMAxrPxqjH/h
	0AaswsyIvORoKmognunE7pTd3hpyxgVKVCPucILg1O++g2lQMalo7u9us2xoEn1b
	pDdqolPoWpD+q6Xr1YElTWj15t0N4w+xmLGJnOitrRvGdvo0/Y3khGHVcNVDo+Yp
	vlEaJZVGfJWGCA2ivgM7kPD9SgzatyRasbcaSAUc/HffXZciw4YL/GAKJdIn1YBz
	7kJIgzXRVhqFWf8j1bN0z6DTfuAAWCbgEei/4Mn4q6oTgkuwC2198tb626Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735930943; x=1736017343; bh=2br7VlvbE3auyNQiFJMeP2xWP6F3BlenuSE
	LxJ2kR3U=; b=t+bc6SKEVnWgJRMDNh0doRa94jYMTvXBAEoP7FCeZF2Y6dxwKV1
	oHHP2Al2qRa69iRKSo2+5rN9o35m9Eg35OKDzKESqj6yRaUGuPAFOAH++R6Ch/EK
	7tc00jidueT0oI0T62KlFH1RMYos8gabr0mOnsy59yyRb0VW4m3c2YLDspz25ul8
	3kO9fmZ1qU5jlt+lUs1Gj2a0eXYHbyPce9dcNkrOgCEqrrPT5a69dzACupqGtx6n
	FmTzdsxk3YN8pX4RZ8C/nx1dXep5G66O8X/qliNN7PYpQRXNeXoaOgWbLowBmbe0
	fclmYiloFZWrTbQGpObgvjJl8rkpkafsuOg==
X-ME-Sender: <xms:PjR4ZyQfhbfuPhutNBCqMTeSjCteoIRZB5bE6kHVNdfWVrQUUAsweg>
    <xme:PjR4Z3y2zvIfHAtZ4jqXg7afoVZCD65RNp1LQROuhauZ9sSFh0CcObnfewvmHK6-m
    KlbpElSDPiIT39s8A>
X-ME-Received: <xmr:PjR4Z_1yp9MN-3VqWE3ZkpT-KunOixkaM5xwYKJ6mdl1yRlcAxtFlSfBfvviELnQ_gQOPIkQfTxGTsSWpo--qyw0z5Os_rkUmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehshhhusg
    hhrghmrdhkrghnohguihgruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhl
    vggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:PjR4Z-Cvujuiog4pQEeAV_cm0LaH4lVcF_kDMeBheE2maKj8RHZLQQ>
    <xmx:PjR4Z7jmQ8dBjFV7vwCX0ax6lI2r0-feVoXTvR_WjMUxp-zvgrt8yQ>
    <xmx:PjR4Z6oouZvZXQ1DsYrnyUxZSyqGeOIpg7KQZxHAyS95H6DrwRNPAA>
    <xmx:PjR4Z-idtAMUNdYpA8a1tgNLHMnEItFKTPgtn7Kt7fDID7aAFyepOA>
    <xmx:PzR4Z2WVyOpgTg3TnlLS1Qnhh_4f2TZCNBF-qOJwl0yj2PSsoE28LlqJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 14:02:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Shubham Kanodia
 <shubham.kanodia10@gmail.com>,
    Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3] maintenance: add prune-remote-refs task
In-Reply-To: <pull.1838.v3.git.1735928035056.gitgitgadget@gmail.com> (Shubham
	Kanodia via GitGitGadget's message of "Fri, 03 Jan 2025 18:13:54
	+0000")
References: <pull.1838.v2.git.1735380461980.gitgitgadget@gmail.com>
	<pull.1838.v3.git.1735928035056.gitgitgadget@gmail.com>
Date: Fri, 03 Jan 2025 11:02:21 -0800
Message-ID: <xmqqbjwnra9u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Shubham Kanodia <shubham.kanodia10@gmail.com>
>
> Remote-tracking refs can accumulate in local repositories even as branches
> are deleted on remotes, impacting git performance negatively. Existing
> alternatives to keep refs pruned have a few issues:
>
>   1. Running `git fetch` with either `--prune` or `fetch.prune=true`
>      set, with the default refspec to copy all their branches into
>      our remote-tracking branches, will prune stale refs, but also
>      pulls in new branches from remote.  That is undesirable if the
>      user wants to only work with a selected few remote branches.
>
>   2. `git remote prune` cleans up refs without adding to the
>      existing list but requires periodic user intervention.
>
> Add a new maintenance task 'prune-remote-refs' that runs 'git remote
> prune' for each configured remote daily.  Leave the task disabled by
> default, as it may be unexpected to see their remote-tracking
> branches to disappear while they are not watching for unsuspecting
> users.

There is no description on how and why the prefetch job has been
modified here.

I haven't formed a strong opinion on the "should we keep going after
the first failure?" question yet, and if this topic is modifying the
way how the prefetch operates, the patch(es) should be CC'ed to the
author of that feature (The author of 28cb5e66 (maintenance: add
prefetch task, 2020-09-25) CC'ed).

If it turns out to be a good idea to do so, I would expect the topic
to consist of at least two patches:

 - [PATCH 1/2] to argue that it is a bug that the prefetch job stops
   at the first failed remote, and change its behaviour to prefetch
   from all remotes and then report a failure if the prefetch failed
   for any remote.  With some additional tests to check the updated
   behaviour.

 - [PATCH 2/2] to argue the need for periodic `remote prune`, and do
   the part of this patch that relates to that new feature.

> +struct remote_cb_data {
> +	struct maintenance_run_opts *maintenance_opts;
> +	struct string_list failed_remotes;
> +};
> +
> +static void report_failed_remotes(struct string_list *failed_remotes,
> +				  const char *action_name)
> +{
> +	if (failed_remotes->nr) {
> +		int i;
> +		struct strbuf msg = STRBUF_INIT;
> +		strbuf_addf(&msg, _("failed to %s the following remotes: "),
> +			    action_name);
> +		for (i = 0; i < failed_remotes->nr; i++) {
> +			if (i)
> +				strbuf_addstr(&msg, ", ");
> +			strbuf_addstr(&msg, failed_remotes->items[i].string);
> +		}
> +		error("%s", msg.buf);
> +		strbuf_release(&msg);
> +	}
> +}

A few comments:

 - The message pretends to be _("localizable"), but the sentence
   logo inserts action_name that is not translated.  If the
   operation failed only for a single remote, "following remotes" is
   grammatically incorrect.

 - Would it be useful to force this message to a single line, with
   multiple remote names concatenated with ","?  Computer output of
   a listing often is more useful without "," if it is meant to be
   consumable for cut-and-paste users.

Overall, I am fairly negative on the report this helper tries to
give the users.  Because we are going to do the operation on all
remotes anyway, wouldn't we have let the underlying operations (like
"git fetch" or "git remore prune") already issue error messages to
the user?  Do we need this extra reporting on top at all?

Thanks.
