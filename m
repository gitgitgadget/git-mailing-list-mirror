Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C12A1DD0EF
	for <git@vger.kernel.org>; Thu,  1 May 2025 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135520; cv=none; b=dfU1jx+LRzgXXd6t3h6MT2Y4maQG+nMn8oktj3bsAP77G1zeGjwyUyCtpk8aKZAe3Vf7JyBWPi2yN5fAAc6u4YunO+Gb3QNRrGzUsN1AU855kxE5Fa9D4egWR0c0PlFNeFbgaVQMjXYeAiV1ij21PD+/8jsJLcyhrrZJ13qSZxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135520; c=relaxed/simple;
	bh=ZFhLahlOEElbnA7xrHX+GOaNjhAyw0xrw7WmyNq/S78=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R5U3FFHY+qc1JMXNo3um5xs0R/ybgPwI5IgpXAhWe5D8Z/B2nhqv/5ZAXSQOHyzNiBIZCfldEl/kF4SU66dM5Jv1adh0Tpd4E/LMffMP49KfNax4Yi0Cwzc4gBRmv/il365BzN6g7w3A4Xg63ELzEa3yBNuyyhvZYJXREym9XKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BAIC/i06; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TCRk54De; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BAIC/i06";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TCRk54De"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 655191140213;
	Thu,  1 May 2025 17:38:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 01 May 2025 17:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746135518;
	 x=1746221918; bh=t4hpKihOBIPsfXgElIomqBDU7cCh24H+W0pT8+HbgRU=; b=
	BAIC/i0627SnJeY5kBS0lvL5uT9E9GrtmDHUFvTt1OTFDb6kNiX8LBURh3g07VLM
	6oRaMEURfwgXsknR9mUHcAzwcpJDtyrRAW3/B/rQVuvrXDU5l5aTudKYyd+8oNoN
	NopdXEG+MRaaRRPZc23UUOzuTTqdLl2ibKw6UeF4+1kRahpwvb2mhMZ2IDuHYX74
	v2ifVU/kBVNIosTenDJukAwTHDYKDGwKdi2WqxyFZTIWlpEqsmiH6vES4P0LJ+eJ
	i2iGFhGgHJ3GDKj02VaYha+dBSx3kTp7RMv4zjXrQgZZy6/gMl7/4RKm+NiKSwOw
	AKbi5N6RAzDtyJ1ovsjZ0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746135518; x=
	1746221918; bh=t4hpKihOBIPsfXgElIomqBDU7cCh24H+W0pT8+HbgRU=; b=T
	CRk54DegcLkjPucJWmFiqSFnTKu+7eowRY9hGIUvrPuppMotSM49epwuMyibRrj6
	1NP5Zy/12dk9SJ5zoia1mDa3mGe0Ws2Wp6lmWekhq/3DyZrfl1wgSpVlpSU4+JM2
	AGjpdURaSIo8EvvjusWy5LN1pfbxU2dBN3Rc5yHmJjibuZGRelODpZ1E3XvSajVg
	7MVl9bYgzzCcz3N9vjyT6no8s/UrzMPZoilfWGaxLVXDmoKtpHPS1W0uR8nKlVTj
	+8AtOduk5hsyBUNtLdAjtmWnu+KI+8BVGVrF/diJ4aIJZg7xJ8UhKQckFs5jjUTX
	zesld0IEng0osdVlgx06w==
X-ME-Sender: <xms:3ukTaIUYjIKbj0rYJzmzGXuyMVq6cZKXoMgblBh626ZxF172e84PGA>
    <xme:3ukTaMkKQKxfIFAooJEqlj8NiEtOSKgte7B35A1nkv0maEvjJH_nf0hRZCJZShqkm
    XuIawyCoulukkN5wg>
X-ME-Received: <xmr:3ukTaMaFoRchzV6a6hoLAgG10TOdngxTY5y12fdYegpHRZ1dwIcxSKsMCIuxImd7iGbgRTS2RO0BMZkjE8SEmEpd739-oGOtuZD6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3ukTaHVFYXmDB9ZhVSdOBT3J2NUx9a8PAPMxOZo3ac62ZCVuYZMXYw>
    <xmx:3ukTaCl18cycBO5b0kbfS-XAiW27eJYTsESE8Q1xTZRzXv2910j00Q>
    <xmx:3ukTaMdUxEKil_bAHF96bFN4Lu_x_06UtSGJCFrLwZB7LVv9UMCOQw>
    <xmx:3ukTaEF01P1S3lgWr3wPRtK6vuAplZ_piqFGabNDxTUwEmsZQSXScw>
    <xmx:3ukTaMRrEDxjhu_G1Yeh7WUupRh_obmJyCljmh5Zw-IPAyalgWcVYJn3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 17:38:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: response to "git branch -f foo origin/foo"
In-Reply-To: <CALnO6CBR2J8YdGgVLHxxpciAHBe5WjwAb3dRr=aUKU8fzRvzYQ@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 1 May 2025 14:25:02 -0400")
References: <xmqq4iy8cagi.fsf@gitster.g>
	<CALnO6CBR2J8YdGgVLHxxpciAHBe5WjwAb3dRr=aUKU8fzRvzYQ@mail.gmail.com>
Date: Thu, 01 May 2025 14:38:36 -0700
Message-ID: <xmqqo6wcvwo3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Mon, Apr 28, 2025 at 4:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> When 'X' is a new branch I am creating to automatically (as the
>> default for branch.autoSetupMerge is true these days) track the
>> corresponding branch at the upstream, this output ...
>>
>>     $ git branch [-f] X origin/X
>>     branch 'X' set up to track 'origin/X'.
>>
>> ... from the command, with or without -f, makes perfect sense.
>>
>> It also makes sense if we reset the tip of 'X' to a slightly older
>> commit on the branch, i.e. after doing the above, running
>>
>>     $ git branch -f X origin/X~4
>
> But why not use `git reset --hard origin/X~4` here? (Answering myself:
> presumably because this version works whatever the current branch is.)

Exactly.  After you work on another branch (perhaps your primary
branch) to incorporate the work that was done near the tip of
origin/X, you may want to reset X to lose those now-redundant
commits, but you do not want to switch to X just for that.  After
all, you are "done" with X at that point and want to continue
working on your current branch.

>>  - We should give another message when "git branch -f X" resets the
>>    commit an existing branch X points at.  Unlike "what was X
>>    tracking?" that is forever lost (hence the previous suggestion),
>>    what X used to point at can be found out as X@{1}, so it is not
>>    necessary to give the exact commit, but the fact that the branch
>>    existed already may be significant (especially if you habitually
>>    use "branch -f X" whether X exists or not).  Taking inspirations
>>    from "git checkout -B X origin/X" that says "Switched to and
>>    reset branch 'X'", perhaps "Reset branch 'X'" may be a good place
>>    to stop.
>
> Didn't I see you recently suggest someone drop the habit of
> unnecessary -r in rm? [1] :) This seems similar to me: don't use
> unnecessary -f as a habit.

Even if you do not have that habit, think in what situation you
would use "branch -f X".  You do so when you think you _know_ X
exists already, i.e. you know you are resetting an existing branch,
and not creating a new branch.

But it is possible that the one you wanted to overwrite was Y and
not X---it would give you an extra clue to realize you screwed up if
we gave two different messages (or perhaps "-f" that resets stay
silent, but if "-f" created, give a "created" in a message, or
something).
