Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F293859FE
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772219485; cv=none; b=pnKIiYEdqE/MCPf8f5mr1Sin+OkjKqzbpNTd6afCLESxxHE4eeAWkyH/2MHVJPW37P2co9WG953ZFDap6pzVmkTyASgGiSJbYj6WaZkwIFs6K8vJI0A1qcPN3CEhv3eHnUuJ0I11jIF45VoLptSFc7DTvWdmCLdBidoH4gtTqVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772219485; c=relaxed/simple;
	bh=DuGtIGgFmGUS43NOSwyOousLLXCcYBXyVNvn9e9Futw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MWK1lDZIDe483bCzh/30+yejfuNQr99ZvFeyj+YhsaxUidPSJUjK3O1AGY6sed/dNoWdwDd1faBNG4P60r4/wDApZOIm8zhgufcEyQKk1qtTDa67lLHf40Vcr5R4zTook3YyFV8L4ojI5Sz97gmfYerfMPmjG2XVO4b5nuHzJtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XLPKGFqm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fLnpDxAO; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XLPKGFqm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fLnpDxAO"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DFE607A0201;
	Fri, 27 Feb 2026 14:11:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 27 Feb 2026 14:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772219482; x=1772305882; bh=kMjtNfL8Wz
	+u1v4+aE0/cKNMH6TLfSVa1g5+XNdTcvI=; b=XLPKGFqm0AvWF7ku6wCnXjS5pa
	Z+qO18BPIOVVE7KdcWubnSFkfOup3C1UQLjSzPUgHpAYOZV4QlrpnByqbhfUlJkM
	XFe1b+b22bfpSkWZ23eYu0J7wlIaK/24EUNjbxUeKA+C9sqaubTdeg57TcqxcsIZ
	E/af4BIXzy17MIpn07s3RoAWjI8ipQ5BID7EhDmSbENyNYCvZFEoU3e+Cuh152z+
	e5shNiwsraJCp/Do+xAaM0HHqDq0GSsYVWHbdbM5K1JiCcD/pofVBNcppBWeZLMq
	isuDbE5/0gsm44vf5BvHV/jLRaxFBqin2YDt8StbrQ78cw816lSlZEK6EIdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772219482; x=1772305882; bh=kMjtNfL8Wz+u1v4+aE0/cKNMH6TLfSVa1g5
	+XNdTcvI=; b=fLnpDxAOtZZ8kA/N8wWuYFG4Ex5gBHtitfUTw1e0Nv6HVG4aTBr
	05Cdr2crencSu25JiotuH3kmiZXEkQHg5FswV/4OYsazTcf5bTLRI2oP3LHAUmid
	OmOWRz967Z79C/pzwelXDV4+fHDOt8OoamxPaKkWTf5oJBpasxhDexYYn/z+IIwx
	3k6xxzAOjX+YsCgtBMLT2WuVU2jTjA32GpkOKMj+cwEsHMnkFK2/FAXujaasrXHl
	4ntbTWVX7505hFfVb4+RkKJY1pO3kXbCiskoVZm5QcZd+koNQs1pvq/Obc1+U/j8
	UbmxQ4Z5qB1u1HMdY65ljb+671jbuYjusug==
X-ME-Sender: <xms:WuyhaW2cNiIqM8TauS843Q2SZRJmix3q4euXemlgzSUwPGSfL0RaFA>
    <xme:WuyhaYKDr-ossiJ5p7_v_k6FRsYvwiycd8k5xlPVudHV3vfOexIf05IUYLpluSRLH
    Y2dGkka7LoDm2eBWuiv-IzXE8mCuO7PmMS6mF9USSXqpNjnDdlUDA>
X-ME-Received: <xmr:WuyhaVGIRijnGlyLneoWQj7vDJExW7l5bSRqU7JD-9i1Fsp3yonjilIoMOyKnmY344J65zRLBO6hW77wPL9MOlXo1HhhOYb8rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtd
    dtheesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegrhihu
    rdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrh
    hthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhutggrshhs
    vghikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:WuyhaUXuFeLQZ3L4-NfXxzHiA1Pk6K9UURTDziK3-1ymMsqNLT4zrw>
    <xmx:Wuyhadz_Qp3BtpN6XWFqL0KUgOxQgE938aZ6ovPWL1mZYVhSU0mQPg>
    <xmx:WuyhaZSW7q4csnA3Gg0tvloHoYatDGcVHO7zskWlql5dPPLxcpS1fw>
    <xmx:WuyhaZhlEoI3nebqKYjxEwj1xn5gV80LZFz7FFBoghzKA7PFeZAOSw>
    <xmx:WuyhaRU6EHSExNnwx8xPtGn36x9FN9uiCkX9t1xzZ0M2vp64uyfgLiKN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 14:11:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Siddharth Asthana <siddharthasthana31@gmail.com>,
  lucasseikioshiro@gmail.com
Subject: Re: [PATCH GSoC] repo: Remove unnecessary variable shadow
In-Reply-To: <CA+rGoLeppg4Xaoqg6+SZ=ET=ze6rXUbmjLm5UvmitmRGm9u6ag@mail.gmail.com>
	(JAYATHEERTH K.'s message of "Fri, 27 Feb 2026 22:37:45 +0530")
References: <20260223135248.127935-1-jayatheerthkulkarni2005@gmail.com>
	<CA+rGoLeppg4Xaoqg6+SZ=ET=ze6rXUbmjLm5UvmitmRGm9u6ag@mail.gmail.com>
Date: Fri, 27 Feb 2026 11:11:21 -0800
Message-ID: <xmqq1pi6q9wm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:

> I got a review on this patch,
> if no one has an issue I wanted to remind it for the next cycle.

Thanks.

An easier way to ping is to resubmit exactly the same patch, with
reviewed-by: or acked-by: trailer crediting the reviewer.  We have
2000+ messages in 4 weeks, so "I got a review on this patch" without
a pointer is much less useful to verify what feedback came to the
thread from whom.  FYI here are from the headers of the message I am
responding to.

    References: <20260223135248.127935-1-jayatheerthkulkarni2005@gmail.com>
    Message-ID: <CA+rGoLeppg4Xaoqg6+SZ=ET=ze6rXUbmjLm5UvmitmRGm9u6ag@mail.gmail.com>

The reference points at the patch itself, and just like Git commits
do not have pointers to their children, the original patch message
has no links to reviews on it X-<.

I'll commit this with the following change now.

Thanks.

1:  006c49ee01 ! 1:  a66c8c7f91 repo: Remove unnecessary variable shadow
    @@ Metadata
     Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
      ## Commit message ##
    -    repo: Remove unnecessary variable shadow
    +    repo: remove unnecessary variable shadow
     
         Avoid redeclaring `entry` inside the conditional block, removing
         unnecessary variable shadowing and improving code clarity without
         changing behavior.
     
         Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
    +    Acked-by: Justin Tobler <jltobler@gmail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## builtin/repo.c ##


