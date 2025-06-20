Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC3318E20
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750437423; cv=none; b=BwI/M/Qz3swdE8VlDS13gOiS2IrQNg+2xtc1CGzuU6cOQPD/Q9tY3jSYgmmbgVSLq0n9akwaUJkZYtLdM7/OQdddA8YXpyRleuRCmlU6xljG+kagdbcoGCsbZoNABR2UHF0G8KWcFnU1WI5FS7onU4bCfooqG0du/3MxaGkSLZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750437423; c=relaxed/simple;
	bh=VMJioewo0ACxpNpNcbOHKEVLGEzH8LlYuy9omaF45MM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IWl+nyZ76WvGam12gFBRHvIZTC6UHt20p3UcbCAyWTXJfp17mD+fSAukBOl2667wNFdd7H/CMHsGDLBvqBOToe0FXCwsgV/Zim4Gvx6W+jXmxcbFaB2n7hy1ftFcnN2TOvts+FvrPw3XhQYvoCP7yJ8Ppf8t1LkTzBtmI3k6D8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qTwcj8/n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RgLSqR+y; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qTwcj8/n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RgLSqR+y"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 520DA1140123;
	Fri, 20 Jun 2025 12:37:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 20 Jun 2025 12:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750437420; x=1750523820; bh=TZMJbyKE99
	yxH9mrMgaL7cZUAnDY5Zs5FV9ITns2sCA=; b=qTwcj8/nSy22/riR6Xo5Ncaubu
	c9u85qM4iXDt33fFmO6ELBYk/znnOPQN3EqnUOGgZUOAZTTzsQuV13EYWIC9z85m
	ZmaER7HUHSnMp/2U1GJxsjse7/JJnX9L459JyJPXwvblM7+u1EmA6BZ4mpGKCLVj
	EFgw0jY48hsdBjxz8xhO0a3N1oQpzn7KPYALHR+/llA1Fy20joC97Tc7H1eyIwH2
	P1jzU1TGOk14iaM+OLt9LPuLVS0SxCkrh7tY5pQIJXTTzGRY2XRMG2uUDSwZCL87
	FgKANEasRs5pAK9KJcrm2pkIVSfqFnPC2bFYaawyw3HqfkFrt/oUesmKdMXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750437420; x=1750523820; bh=TZMJbyKE99yxH9mrMgaL7cZUAnDY5Zs5FV9
	ITns2sCA=; b=RgLSqR+yJuyNvS7UtK+y3ONL/WLwGtGheGBwH346m9XP/pVKnqP
	jGNnuOkY/nkGxIUmv8vvsverwCtfKQchyRv1DVuq1RVjRMS05lkqEPlaAeOywYfc
	/u2SP4rMPzoj5Xegr6Z9nNk2a3sWsJbHBWlNhq/TkEnakYFdl9rZYXvCrWvL+4r6
	u/5d8B9kqIFT7P3TXp84UlPjgpoFX9h65XZLUk/lgdaBqe8boAzghIvN+FVI7AxD
	GA39vj9pcxLbCTbCZmmIkAse1kTT/7xAvWoD6K0mDglM6fuHx1hCNeLb5NAZG5Ee
	Gy4wNo23tyNMCqhvk1WRkU798nv8bndUzTg==
X-ME-Sender: <xms:LI5VaCpACUp_olLgvmUbWkkA3E0qbCPiAoBQGd_ss-DPWmHPLWFc6A>
    <xme:LI5VaAoqRLDFw1Ul-IZiQwo7OIUMWSG9dN4FHAbYmyXTbwg55go5FIzvZIepYPIL0
    KUVx68FpCY9nCucJA>
X-ME-Received: <xmr:LI5VaHM6Y69nGrIhPRrIICYABOLSOYP_3rpZHy5s_u380MYscL9uwbgxWZSqQ1asNf1C_zYEiK3Q2EhRrXex1w2RfRSVN1SOw3Pb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LI5VaB6hqrSqJkMsBZ4tAlkvhLKQPyIRsOiGZz7Zqj_g6UTz0H8apQ>
    <xmx:LI5VaB5SUwFQ1nbtKcCztv3z8iFlxXUshcHMmno89pQvAMND_p1uxA>
    <xmx:LI5VaBiHz6TiIsFiHakuiWvwrjxq6BtVJvTIrxVQWmmYQUpMkFhYrA>
    <xmx:LI5VaL6meWzVkhaG9EBr1QO1ByY_m_3A7fIzVdnM6YZjKnTHzDfKgw>
    <xmx:LI5VaEc5f1ORXZmuS-oRJaXSZcOnidP7_VgGxsN9SI_OakDQQ2ttiZLM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 12:36:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: .clang-format: how useful, how often used, and how well
 maintained?
In-Reply-To: <CAP8UFD27tQ3uhQW5zkPfFZSF=3FGEmi-rBYu3A_zZ8oNbUiNag@mail.gmail.com>
	(Christian Couder's message of "Fri, 20 Jun 2025 16:08:32 +0200")
References: <xmqqmsa3adpw.fsf@gitster.g>
	<CAP8UFD0YEgh4Oy8MDpT0DfZJgo++NHf3mF6VsYxAG1CjhrKGLQ@mail.gmail.com>
	<xmqqfrfv8dr3.fsf@gitster.g>
	<CAP8UFD27tQ3uhQW5zkPfFZSF=3FGEmi-rBYu3A_zZ8oNbUiNag@mail.gmail.com>
Date: Fri, 20 Jun 2025 09:36:58 -0700
Message-ID: <xmqqy0tm2wut.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> It's up to each one to decide if they prefer post-commit or pre-commit
> hooks or other ways to trigger the style check. So yeah, we could both
> suggest using hooks and add a format-patch option to make it easier
> for those who don't want a hook.

The thing is, I have no idea what the "option" to format-patch you
talk about should look like.  This topic is about improving Git
codebase by helping Git developers, and I do not want to add a
project-specific option to the tool that is meant for the general
public.

>> Or just write that command invocation into "MyFirstContribution" etc.?
>
> Yeah, we could do that too.

I think that is a good first step.  Give an example that shows that
the tool can give suboptimal suggestions as well as good ones, to
stress the point that the output from the tool should not be taken
blindly, but should still be looked at.

>> What I called "once the code is written" is something I would refuse
>> to accept as a "style fix" patch, but they are still improvements
>> and it would be great if contributors followed these style checker's
>> suggestion _before_ sending the patch to the list.
>
> If we encourage a style checker to make suggestions that are often in
> bikeshedding territory, then I think we take the risks of:

I do not think I am advocating to encourage a style checker to make
bikeshedding suggestions at all.  We are not discussing any change
to .clang-format file in this discussion (a side thread we discussed
about concluding a year-old experiment, which would result in a small
change to the file, though).

>   - annoying some users who disagree with some suggestions,

That I do not think we care too much.  This is not about "users".

>   - having bikeshedding discussions on the list (like this one) about
> things that are just not worth it,

But now we have a good thing to point at.  "You want to bikeshed?
Let's see what clang-format with our recommended setting says."  And
the discussion should end there.

>   - the style checker being actually wrong (because of the context for example).

If you are worried about "bikeshedding territory", there is no
additional risks for the tool to be actually wrong.  Whether you
blindly take its stylistic changes or not, you'd need to be careful
about tool changing the meanings of the code it is touching.

> In my opinion the possible small gains are not worth taking those
> risks.

So, from my point of view, I am not sure if there is _any_ risks,
but again I do not know who you think is advocating for more
bikeshedding via the style checker.

> In other words from a style checker I'd rather have fewer
> suggestions that are more likely to be right, than more suggestions
> that are more likely to be dubious.

No question about that, but I see no logical linkage between what
you said above and this goal, sorry.

> I agree that in the example above the suggested change might be good.

> But if there is ...

Don't move the goalpost.  It is not the case we are discussing.

> So my opinion is that a style checker that doesn't take into account
> the length of the lines around where it makes suggestions is likely to
> make a number of wrong line wrapping suggestions.

Your example is not even about "around", but the exact line that is
being changed, isn't it?  Even if the line being changed were the
only overly long line, and all lines around it were below the length
that is comfortably read with minimal horizontal eye movement, we
still want to wrap it down, don't we?
