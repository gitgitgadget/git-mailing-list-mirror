Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C030CD95
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756399780; cv=none; b=EEY84KE+L2hI8LgJtsseVx5ukgodbOlxUtltn+4+SbOu4k8a9t7enzX5AX7SdUixSNax8rsLXMkpddlK5BMbBlU5TT+eUbYwgtP0xEo6o56BJY1DCagtbD6YxLVRyaPGd/IaI7wHKHSLQpXOFve2peeDOFk1Yrd0L4aZOaLRBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756399780; c=relaxed/simple;
	bh=Zf7R4nWZyY3k2H3peYQXRpVq9v6MD7w+mCm44YlplMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o8bGVBJB8qGZc9ZTO3TmlSWy85D7yZRzaaIdM96PL8w2PpOkZiJUpKPrTY7kitgnjddC74z4QGLIfFhEFe3UhjK2vDnUtxcImV5NsUordRNNq9bspQW9t+SxDQIFJHkeXitEdFzP48+x1V2UFFFYOSvVJk9szIHC39SSaIGODVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hxbjSAhD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mjddqb3S; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hxbjSAhD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mjddqb3S"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 78F457A01CF;
	Thu, 28 Aug 2025 12:49:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 28 Aug 2025 12:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756399777; x=1756486177; bh=5d2thy7ENT
	z/WsP0fHaX1+BmYOWfbK95j+piKJB4aE8=; b=hxbjSAhDI46O+Ycr8IU7AaOl0f
	kdT7Esps5ClYkPwbdPgXP0Y1KAXyGsTjwiLE1QUGrBfi9vL1wWe3t5jM0mv94Mzd
	cl/s+hYO7sZ86qAxbORriApWrcxtJ4uRDIVznV+koiNhB4DMSx5J/tdinnjqP6Y1
	HbXBXf26k6UwTf5H90rUGZHk01rtt9XF8csvd9kqDqW7h6RNh7/H0wEzdQZH9NzJ
	ipz4KyJFVJ7gyTdfbeXCAHNrmJauKzWzK3PBOA6IlAVrV3lVh5z6kuBPv9iYYBZW
	m/jvtlo8n7rf7OzbgMUdOY0KA4XfFUPSKNDr3ZY65XzzfnPFsqiHXEEQft7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756399777; x=1756486177; bh=5d2thy7ENTz/WsP0fHaX1+BmYOWfbK95j+p
	iKJB4aE8=; b=Mjddqb3S8YtD65MRH/2v7rEAlssCSOM9pKcw13b6wMyAt7uvqsW
	cuDKtqFD6/LgsJLTLgtwcod5kShSZv8Ij+tSlEjY5q5NZcEb4PnSVlrbA1e0JCxx
	UX+R+K4YvAzySdwZhIpnXAF/Xm/EjdM2j9bXTJLqecng2UFpd6XbWJ23FotmLkhJ
	QdHmgb/2n8zgBcPWnDQelHKHCuoWcp3TgbWe7pAevVshU7f4OKSRSlRjaRxowNUX
	s8Be8vVh6qqrSLVf54FpUOdcD8CNwLyiAOy/l/rfb1vdApWvo/noV6JwmeD6a3HL
	UfkLBs3j5iJgXQRRG9YhFsuslHSHDnFNmsg==
X-ME-Sender: <xms:oYiwaBjutGY6MMkDzd4ieLDQnX5nPrWfD_GYxFkFVkGrng7BqsLolg>
    <xme:oYiwaBiDJTpFDUzHNs5QKfMoZkeHjjAz1hCq_FCdlmahYTGLy1jUZh33enp8tTW3Y
    wwv-TQS6gswxfM1iA>
X-ME-Received: <xmr:oYiwaHiLgaUAdB4oIM_rZX32DgLR-pXh8nsTE7Ql_MFWRziTSZgTvOOj8HPrmkXXp9lRhez6fqUGxFH3GhvtuKv-UOOCRQUmXbbPxgk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfefgffffheeltdekledvhfegvdduvdfhhefgieekvdfghfdtiefgheelvdel
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    hohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohephhhu
    rghnghhsvghnfeeiheesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:oYiwaBLvK7MClATCavOe1JyfiY4S7A0YJ0RZCtUN-GHMvLs947w15A>
    <xmx:oYiwaGFQE8dFY7fgtRb5cCaJoR0S7GOIxwcnkd0umNC4PSLi1Wnjww>
    <xmx:oYiwaFSnFausAr6jUjOuqbcamXVeXG6-KAAPw1oWxdP-zBRey5mIRA>
    <xmx:oYiwaCf4bl0KAO6gqVmGNiaQoWweQolk4_Fh2bwdYT3r9Zjjr-zofA>
    <xmx:oYiwaIkge1C-vDsxqthW1X1ik-fskGLk4qpdddTW3-aH55H5Flg5trMA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 12:49:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Wing Huang <huangsen365@gmail.com>
Subject: Re: [PATCH 1/6] t0018: switch default branch name to main
In-Reply-To: <b6b60e6b-c06d-4dc6-8722-b53736f8b059@gmail.com> (Phillip Wood's
	message of "Thu, 28 Aug 2025 15:00:08 +0100")
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
	<7c20f7693f4518ef79be0a2277515bb00d912213.1756308283.git.phillip.wood@dunelm.org.uk>
	<xmqq5xe81y0i.fsf@gitster.g>
	<b6b60e6b-c06d-4dc6-8722-b53736f8b059@gmail.com>
Date: Thu, 28 Aug 2025 09:49:35 -0700
Message-ID: <xmqqbjnzwfvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> These tests use "trunk" as the default branch name but the exact
>>> name of the branch is incidental to testing if the advice message
>>> includes it. ...
>> Would't we be better prepared for a future where advice messages may
>> start including the current branch name, though, if we made sure we
>> are on the branch whose name is known?
>
> The advice message does include the current branch name, that's why
> the test needs to be updated when we change that name from "trunk" to
> "main". The sentence above is trying to say that it does not matter
> what that name is, we just need to check it appears in the advice
> message.

That makes 100% sense.

> I could see an argument for the tests not depending on git's
> default branch name if it changed frequently but realistically we're
> unlikely to change in again in the near future.

A test that automatically adjusts to the then-current default so
that we do not have to worry about what it is is much better than a
test that needs constant maintenance every 10 years.  A test that
uses one fixed name is slightly worse than auto-adjusting one, but
is still far better as it is maintenance-free.

Hardwiring a name the test uses does have one distinct advantage,
i.e., it serves as a documentation that the test vector depends on
the branch name, making it clear where the thing that the test
expects comes from.

> If we did use a different name in the tests it is just as likely
> to cause objections and need to be changed as git's default name
> so I'm not sure it gains us much.

I do not quite understand.  Do you mean in 20 years some animal
rights activists object that 'trunk' is offensive to elephants and
we will be forced to change?  As I do not see the difference between
'main' and 'trunk' about how likely either of them get such
complaint against, I can live with hardwiring the branch name used
in the test 'main', but then 'trunk' would equally work well, so
unless there are other things the patch changes, I do not quite see
much point in this patch.


[Footnote]

By the way, I do appreciate the "let's switch the default as
promised at the major version boundary", the primary theme of this
topic.  I think we have done enough prep work to ensure that the
result would work without disruption with existing projects by
ensuring that (1) existing user repositories can keep working, as
this is only about the initial branch name, (2) existing project
repositories cloned anew will keep working as before, as we follow
what the upstream does.

One thing that is missing is probably a way to remotely create a
symref (or repoint one).  As it would break existing users if an
upstream suddenly switches its 'master' to 'main', the second best
thing to do is to ensure that they always point at the same commit,
and the natural way to do so is to

    $ git symbolic-ref refs/heads/main refs/heads/master

but we cannot do so remotely.  I've been doing the third best thing
since late November 2021, which is to push to both at the same time,
which is ugly but https://git.kernel.org/pub/scm/git/git.git/ and
other mirrors may tell you that both are available.

All other mirrors do not have CI attached to them, and they have
been running with both 'main' and 'master' pointing at the same
commit for quite some time, but https://github.com/git/git/ does not
have 'main'; I attempted back when I arranged to do the "push to
both" back in November 2021, but it caused two CI jobs on 'master'
and 'main' run on the identical sources simultanously, wasting
resources, every time the topics graduated, so I stopped doing so.

Perhaps tweaking the .github/workflows/main.yml file a bit and
explicitly excluding either one of these two identical branches
would be what it takes, but it would probably be a multi-step
process, to (1) tell it to ignore the 'main' branch, (2) start
pushing to 'main' in addition to 'master', and then finally (3) flip
the CI config to tell it to ignore the 'master' branch instead.
