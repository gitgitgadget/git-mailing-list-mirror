Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D25339FCAD
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775742031; cv=none; b=SPDuq+iZxQvWGeJgbFLZ1v1EDDCU0nfL/ffFQRnF1AFJFsml6/RokBmAfaGwy0BNzysHRW5gxwJeEj4zGBihuVqR7EXWYz8YEgyd75KbDJrEKz+6T8wgDL5kQJGh28An6OONu4meQUBVtm0oUKOfQFs/tTRS8nWRs33000oXmdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775742031; c=relaxed/simple;
	bh=oRqg8j+BZ+6VtKQ+tWN35O1+jn7QUf9+ICs+e+hTT/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tv675Hsp9UqOM9M9FMm79qwqkHK8QgLPr2aCQZwbD6EeyfBVhQxWqjdwVW4TO9fdzclx4SfHzAR0af686HJX+HUY4wuUvVv4mIgWx/+flat3WLuL137lT8XFGdSB2eeJ2r/qgRUpHhK0xrBqcmdRgpaWhZgW8dTYDZtwM7RTnfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fa1pgT8o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GeOBnTrt; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fa1pgT8o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GeOBnTrt"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F12E1400272;
	Thu,  9 Apr 2026 09:40:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 09 Apr 2026 09:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775742024; x=1775828424; bh=SblcP3p6fg
	SJz1yqgq+EgFFySWIi/PofrSdofZM+4iM=; b=fa1pgT8oINyNF6oPFx0xw/VEtJ
	n7CB3xTwD1gfvnBhSemH/3dBBhkdwrGmq9Y7HhdkywTUxtpUFGcEHHo75t/zKHdE
	To0uta/b7rEhJkZWGi4lUDwBZFEaA3lsSTPhaYhwlXP/VQbtqMvWyTQ679MiYYUJ
	0f3sPtO+25uyjEWDVdDPNfwcOSzBwKx8LBJiWOjgiEb6oVVur3frbur1iaWApINa
	AWQfWRTsHPhOOldTC7W4x3bvgHEs22/EglJOFZskUhvn7KjYrXyv7Oo3sk57d9t1
	VaDEobZZB8vidWWpUHtzl3hqDPB4FCWWBTwgoP0S/sUW98VICdApb/vxsqfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775742024; x=1775828424; bh=SblcP3p6fgSJz1yqgq+EgFFySWIi/PofrSd
	ofZM+4iM=; b=GeOBnTrtOKLi0OsPMWM6OOnUGch+RiHJfYovjJ4vRTaypAeEEyE
	sbtuXK//2rnbsVltqpxOx+sYGiICN9AZAyn1L34Hm3E8tnewEDBTNrSpRe95lB9c
	fLiV1YUa4WReNCnAVdQJi/dA63WnS18crFmkOPvAoZ8ku9XOMb7BUtjIh3mb3Fsl
	w+wW3gmFpxWBDrUuHSTjnPYp4hZRxckPa7SvjCrDQZdoaYXG0519RraihGPiojyH
	zLyKqnNSuyDnoKCgrTHp6z54eZuFpPWP89hJ7vkk7vWOSq1XlJqpEBbSZ8DdWYw4
	vdxbdARV3ve8YrmmSEmwUY2iRtDXph/Z2Lg==
X-ME-Sender: <xms:R6zXaVhfmtm7WWSHHYJPTRiy8g4Bqd2REIPRAkXF21bv8QG4KSc2_Q>
    <xme:R6zXaQ6PsKj0oTPa-EcTCmAdibXH7yEWFsZ4F2QRT3CUnh5Fzy1Y4KFIn5auWEzLf
    _dsfGwUxV2MAo3TlalXdiCZ6ecZWm4iZ8hLR8uJ9jYCzI0exPv0>
X-ME-Received: <xmr:R6zXadYPrhvJTGFmm3_6r8fSrMZxyVOSI3bzfiE7qIHo1CuHKA7r20HJlJdKAZgtrM2ssNDV58sg68onobD20MZ2Dv3xY2pZMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvieeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprg
    gurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoheprhhs
    sggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:R6zXaV4sQN7ylPnXm--327WgYP1TsUR1qlE0VLRNQbKJBQTB19XTGQ>
    <xmx:R6zXaQAV7eianPJ3vtRyEhxl_duzrRKOYTq0u8IA6lV7GwIw5LfaKw>
    <xmx:R6zXabdKzI0uBazG6HNPGIRWtDw0-6EC8yqbpSduZUo_0pWq-L1ztg>
    <xmx:R6zXafKBCdQCEMQV5atDFFiQncXlo9HMvO4O7a7LBSY874URjH5tDg>
    <xmx:SKzXaV1KHJP-5FRIBdBfByQID9uzhZpWy2tfIUeX8j2dJEDh08j1bq5R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 09:40:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,  rsbecker@nexbridge.com,
  git@vger.kernel.org
Subject: Re: [PATCH] run_processes_parallel(): fix order of sigpipe handling
In-Reply-To: <20260408234236.GA2980392@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 8 Apr 2026 19:42:36 -0400")
References: <00f501dcc6e7$8ef295c0$acd7c140$@nexbridge.com>
	<20260408052031.GB1324339@coredump.intra.peff.net>
	<xmqqpl491mfd.fsf@gitster.g> <87y0ix1kq4.fsf@collabora.com>
	<20260408172055.GA2293804@coredump.intra.peff.net>
	<xmqqcy09z62e.fsf@gitster.g> <xmqqmrzdxjel.fsf@gitster.g>
	<20260408234236.GA2980392@coredump.intra.peff.net>
Date: Thu, 09 Apr 2026 06:40:22 -0700
Message-ID: <xmqqo6jsw8u1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> Currently neither subprocess is marked with the clean-on-exit bit.
>> but if somebody is careless and flips the bit for these
>> subprocesses, start_command() will call mark_child_for_cleanup() and
>> causes sigchain_push_common() to set up cleanup_children_on_signal()
>> to be called, which would lead to a very similar bug.
>
> Hmm, good catch. This is a bit worrisome, as we've added some
> clean_on_exit calls recently, and might do so again.
>
>> I wonder if swapping the order of start_command() and sigchain_push()
>> in these two code paths have downsides, or is it making the code worse
>> just to futureproof it against a future that is unlikely to come?
>
> I don't think it's really making the code worse. It's putting the
> SIGPIPE handling closer to where we're actually doing the writes. But I
> don't like that it is a subtle thing that people writing new code have
> to worry about. And I wouldn't be surprised if there are other cases
> where we disable SIGPIPE, and then call start_command() in a much lower
> level of the call chain, which would make reordering harder.

OK.  Such a change is easy, compared to anything we try to do better
;-).

> I wonder if we can do better.
>
> The root of the issue is that sigchain_push_common() is not really
> expressing what we want. We are trying to install a handler to do
> cleanup _if_ we are about to exit. And that is always going to be true
> for SIGTERM, etc, where we might install handlers but never expect them
> to rescue us from exiting. But for SIGPIPE, our desired action is really
> dependent on whether the signal is being ignored in general.

Hmph, I actually was hoping that we do not have to go in the route
that each specific signal differently, but I guess it is unavoidable
as they come with their own semantics (somewhat similar to the way
how their default disposition has to be different).

> That's a total rewrite of our signal handling, though. There might be
> details I haven't considered.
>
> All of that is out-of-scope for -rc2, though. ;)

Of course.
