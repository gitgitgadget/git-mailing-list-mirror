Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FA272633
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758907927; cv=none; b=rmxTKRZzfpHSZSukjUV7r/XRq+2Ote+NGt8x4lYjMk7ZmfRuf0teQQsMmQ4uYUZYKm24WPomiM4pJnHPv8yol1LSgm+xkrLzAlxpb05hS25cKtb9LuM21es2SPjCLzlANLO5ZegA89gmBaXGopbGQGuIkZn5qb6zr4THpJ93bPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758907927; c=relaxed/simple;
	bh=qrHaodH2a4XAbPWDMesoi/+G9YmHUG69Z4FjJryC7Bo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pgdPmUHKjy8QUAmuArcIM7WMs0Spns4Zn9JCZqs/cd/MhAl73hff0cNcpxZnD2fT7MXZMfTJJiR7Q+VgEX5kNAdqXY2+kSUcBcTxPMOZYAEHOw9TC6G7FgeJzWarJ4EIrYu4qaH80Hlo6+1KmwVk0D1cl8OD7BmmIVPQzATXjAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=RPEsjKrY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aUWdyfAz; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="RPEsjKrY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aUWdyfAz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id ED161EC003B;
	Fri, 26 Sep 2025 13:32:03 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Fri, 26 Sep 2025 13:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1758907923;
	 x=1758994323; bh=6EZSv1f08cLM9L8pYSqpRxgpXNrxLhgaqMnTIMBxF2Q=; b=
	RPEsjKrYpSf40o+OBW3mSdsvo1C+YSVYQiQ1k/rO2zWX4D6ZC7hpwL2rmMvsygcf
	mHU173Lmp4orJF+ofGUjBFU6J7JHPaujOSQrGIY2a1Mpr4bFxiwF05mfMrJIjIvX
	Ctnp38Fe79EfAcG19q09httikt/PxAf8B5IKwNpHP+O63FR5qbzShu5x6w6zE9kt
	TtKcmhCv7lKpSyifSsySVNvCrsQ1OUakQ07mUpaTKst+L2WVufJ707Lmq+iHEB5A
	CDmLST0hPklw0pu3q5BCT0DzK3fTgmydtX8DEJBfxL7xBKJyyf8kLWKqSfxPGZEC
	SpyZNyUw6oRJmAlZTKKstg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1758907923; x=
	1758994323; bh=6EZSv1f08cLM9L8pYSqpRxgpXNrxLhgaqMnTIMBxF2Q=; b=a
	UWdyfAzYRXP5Bxj9guQnSI9+vECf9/1AjwFJ4NAUu0sKYbMzQnyr2kmlUZHwFFEt
	WGAen3AK1E0HRKextvssdxxgVdI9HveDQVQ4CvxZ+ZzLJZ/HxzmjwBtCp2T17Zbt
	zVuDD/DA2pzvyqngy6SbrTj1mRpDoOcbBmnmBSmMBxL9ILoVw4kmmBLG1vg9KUxj
	ZZL5/ECcjEGPcWjFClIiFVHKkoBS4sO/DutTRh9YbPyFCY+2BWwQrpgppM9eU9aa
	tzon89fHuYPt4oMf/WpECzgV3WPyv30cKyjDq60FAblaBaLROgkJ6byPXoDZ5WBn
	13HRyj+mCz1hZzMdE62AA==
X-ME-Sender: <xms:E87WaH81FihgDB56BmfKbSgebyc2ElSeEjsdSJKjg7TMPfnwdmQUDQ>
    <xme:E87WaOi0J1TkRS_CbamVqEwkYxOKKjvO44dg2qw6lXxAIE6VxEhH76-wKzR07vl1_
    zpGfam1ELrSJsO2iZnMzQic5O00IvkBFWWOPPozQRFXfRCM_iE581g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeileelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfluhhlihgr
    ucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpe
    eftdegvdeffeeglefhkedukeejgfduudeviedvgfdtueevveetfeetvdfhieegkeenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhdpuggvfhgruhhlth
    drrghsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    jhhulhhirgesjhhvnhhsrdgtrgdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:E87WaOi6_1LeScH6vA8NgUAW-LrF_P2sc2WdENpLaJX6PwNCx2iXwA>
    <xmx:E87WaAgvUBwujyOkQ46dzEhQYziMVNILDTZnWrYQFexyfy7dbVSEaQ>
    <xmx:E87WaGLz2pinWHuHWFKgFqhUo12NdLnVtpwNp8_fZ5-vmmsxiEATjA>
    <xmx:E87WaHEGOConLeTAI-t85T7ZMfo113pUjDpayLshkIzCtW1nsPZ8jg>
    <xmx:E87WaG3OWTGTZ6cUXa3lzuUxYNcowCm-BorKzzLMzWX9qGjFBAm2RNtF>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9313B78026F; Fri, 26 Sep 2025 13:32:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALMQnK0r4jnk
Date: Fri, 26 Sep 2025 13:31:32 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <442a4f25-7d7b-4f34-9e2c-ce396277e7be@app.fastmail.com>
In-Reply-To: <xmqqwm5lcjvy.fsf@gitster.g>
References: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
 <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
 <be6453d010bdc9d2b49988d6841dd7e7f9bdf1f8.1758649472.git.gitgitgadget@gmail.com>
 <xmqqqzvvk4bj.fsf@gitster.g>
 <2365a7b9-3d22-4406-876d-65822822655f@app.fastmail.com>
 <xmqqzfaidyil.fsf@gitster.g>
 <1422594f-b0a8-4a7a-bf78-940693757224@app.fastmail.com>
 <xmqq348admuo.fsf@gitster.g> <xmqqwm5lcjvy.fsf@gitster.g>
Subject: Re: [PATCH v3 4/4] doc: git-push: clarify "what to push"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Sep 26, 2025, at 11:29 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> But I'm not sure it's true in this case: we just said above that
>>> "The default is `push.default=simple`, which will push to a branch with
>>> the same name as the current branch."
>>
>> So I think this simplified statement is what causes confusion.  It
>> says push.default=simple will push to such and such place, but that
>> is not true....
>
> After sleeping on this, I do think that at the crux of confusing
> wording in the current draft is the lack of stress on "simple" being
> a narrower special case of more general "upstream" for various
> push.default modes.  In either of these modes, unless told otherwise
> with the configuration file or the command line arguments, "git
> push" pushes to update the upstream of the current branch.  There
> is, as you said, an additional safety measure in the "simple" mode,
> that rejects a configuration to have a branch whose name is
> different in the remote repository as the upstream branch.
>
> In other words, the push.default=simple mode does not tell Git to
> push to a branch with the same name.  Rather, as a variant of the
> push.default=upstream mode, it tells Git to follow the same "push to
> the upstream branch" rule, which requires you to configure your
> upstream.  But the mode gives additional limit on the name of the
> branch that can be set to upstream.

I like the idea of explaining it as "push.default=simple uses the
configured upstream branch, with the restriction that the upstream
branch must have the same name".

But as I learned from you earlier in this thread: https://lore.kernel.org/git/pull.1964.v2.git.1757703309.gitgitgadget@gmail.com/T/#m896f4a32ca462d69637b56f9bdfaa61e55e6b952
push.default=simple will sometimes push the current branch
to the remote branch with the same name even if there's no configured
upstream branch.

So it seems more accurate to say that push.default.simple will push
to the branch with the same name, with the restriction that you might
have to set an upstream, because the branch must always have the
same name, but whether or not you have to set an upstream depends
on the situation.

Personally that behaviour seems unintuitive to me: I always
thought that push.default=simple _did_ require you to set an
upstream branch and after spending many hours thinking about I still
can't really describe in a way that feels satisfactory to me why
it sometimes doesn't and under what conditions that happens. 

One idea I had was to change Git's behaviour so that push.default=simple
_does_ require you to set an upstream branch, and then we could
document that behaviour. That's how it used to work when
push.default=simple was originally created and it's not clear to me if the
change to make push.default=simple _not_ always require you to
set an upstream was intentional or not. I did a git bisect to find out when
this changed, and it was in https://github.com/git/git/commit/ed2b18292bfeedc98c9e2b6bd8a35d8001dab2fc 
commit ed2b18292bfeed

I tried to write a patch to require setting an upstream branch, though my
commit message has some mistakes and I'm not at all sure of my
understanding of the code.
https://github.com/jvns/git/commit/3553479892b11c50de939707e7f00aa7c7cb2f9d

> We should make our text clear enough that anybody who read about the
> push.default=simple configuration easily understand the above.  We
> would need to find a good division between what to put in the main
> text and what to leave out to the "see ... for more detauls" part to
> guide those who read about "git push" command to the same
> realization without bombarding them with descriptions of full range
> of possible values of push.default.
>
> Peeking our earlier exchange to help me formulate my thinking a
> bit...
>
>> +To decide which branches, tags, or other refs to push, Git uses
>> +(in order of precedence):
>> +
>> +1. The `<refspec>` argument(s) (for example `main` in `git push origin main`)
>> +   or the `--all`, `--mirror`, or `--tags` options
>> +2. The `remote.*.push` configuration for the repository being pushed to
>> +3. The `push.default` configuration. The default is `push.default=simple`,
>> +   which will push to a branch with the same name as the current branch.
>> +   See the CONFIGURATION section below for more on `push.default`.
>> +
>> +As a safety measure, `git push` may fail if you haven't set an upstream
>> +for the current branch, depending on what `push.default` is set to.
>> +See the UPSTREAM BRANCHES section below for more on how to set and
>> +use upstreams.
>
> ... here is my attempt.
>
>     3. The `push.default` configuration. The default is `simple`,
>        which is a variant of `upstream`.  In either mode, "git push"
>        updates the configured upstream branch (see the UPSTREAM
>        BRANCHES section for more on how to set and use upstreams).
>        The 'simple' mode has an additional limitation that the name
>        of your configured upstream must be the same as your branch.
>
> (iow, I rolled the "As a safety measure" paragraph into 3. itself).
