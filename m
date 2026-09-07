Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1461C35C6BF
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761743; cv=none; b=HLasp6sCwbK4QTGj1GGQHps3Zz8w06sloRymPyfxtuLH3kBmKxHdlA6VXVFJKAslYZvhM62O3EszWFNbTVUW0mfFvvb84qEYRwLQ2mq/PvRMfWehNQTqn3ljvCjtryaB/dYma6c+5vsyXh4SVm/0sQdiS62cps+TsyAlJMr+5GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761743; c=relaxed/simple;
	bh=auOUu+h3awn0GW16Tq9v/Dz1tA0IIH7tutPbmfcrSf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0nW/qpgNmQJs+dZ7UvZyELJ9yp4r0GJlWjdr9KVlhLSFjRSDSN/3pkQkLVf6SPV1XwQqpzXG0Z8NtwbeZX9OImjkQVJOANPmJ/tM6mQXS5lxPr7l6b1BrugWCgWkOeuc1fON54eF/4dnr7CWjnwtc2OAhbAgPmlSObZKJ78nGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LwyRwx+B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CHV7qV1T; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LwyRwx+B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CHV7qV1T"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3F04F140020C;
	Mon,  7 Sep 2026 02:15:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 07 Sep 2026 02:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788761741; x=1788848141; bh=kN7Otlha5v
	c70B7kavnwHXrTxH79SiC9CXPn24wD0mE=; b=LwyRwx+B1lAWdOi/mrOC0UpRIL
	UYCt10RBKrd9PnfU804eyATuJVSP1gqc8diNkNEVhsUzmLxd2zCPQOE2KtZS2xFX
	wYV4wdjwfAfJqJFjyuOaulNeFtcL8TmCdJOXyfdOIfFkgwofvGP5kidnpLg7zOWk
	7PZQa4uY7mYOZ6vv6kmuH/haqr86poq6Q/AGX5o78Z51rzwK62uGFakXNTWRN8+u
	aN7RrC6dJu2mGl/4/TuJGj/svYELUHcp1v7PiG6ezZa8WrT4vebZweYL5uYP/6Ce
	iEjyOzuCQpUU7nYgnU1MLpGMdYglu4n9cN63LbOWcwgo1xWDP7AKAOIMXZFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788761741; x=1788848141; bh=kN7Otlha5vc70B7kavnwHXrTxH79SiC9CXP
	n24wD0mE=; b=CHV7qV1TyRMwECDPhWfXg6lmTAGwnQQF+NXS9JxLfT9ibSQVfYU
	W7Z/zblzCuJR0YP78AjSPrCeeUF3qiKBA954G8lAicNtnbjua2F2cZm7JQNQhLOs
	55vhN/fGtLWGprwMH/4Z4/GFlEHdJvNMZgSct0QaJkPyZi9A///2VOyj8nSPw6sk
	GYwFJ0NmdGMv8vqcgXwvIyyvl3/wwL4WlXzXBKSNUst9LSxUHMFa3qe7zIKnCzSb
	7oc6591B0EZicDPUTqdRzZMSCM/7AGEb5SGm5sYxlfDM1clY1Ltrys+lqx02YO1p
	GY/wIfRGKuqiByN580ehyHTJR0diSoG9fRw==
X-ME-Sender: <xms:jVaeanJiQBnIIVBkO9ZsMI1mpXmYYnL8rWTACmoIFjjxTXKOQWVmUQ>
    <xme:jVaeasqAlbsizn-QZ9ABAqCGMpqYi9IQqwQMz6rtubZBAZ21unxMBH3ltLClmW1Qs
    8cGjJ6pyUlQKfnyIhSvxbS0gcNPlSJ1GsIN5avef6YPzUdmNKMFeQ>
X-ME-Received: <xmr:jVaeavwOq0s4nVuMgLp37oIExxuN-RoUvmvctowgJ2Q0HUq8bR6mPQ>
X-ME-Proxy-Cause: dmFkZTEGllaSDLCC1uBvvVUiXC8/Q8MEgtqRPqBapBQOvvYSIsdcJAJcCgwKYLxkSshMoI
    rVQSTLDIkKx8lygs69JXzV0tbZQgk3ptCPNZPlJ7RPbhL4CJuUMmeJX1ZFw5QLgjOOtvHJ
    LzGReNIBz5hCHKqh1PPu+Hfq679LkA5T0g2Ohk0HSzDqKZmj6QO0ZOSJIs7pecFBXQ3oNV
    RtrYsJJmv1cdhzLpFulGqlRAeTcchxvvMs3nKahETuCHp0uIQZIsljPnixWFO9tMgEmbhe
    t/g2SwnIQqNhcD/nBezzFje9B6fGnFt+s7gyQgza2jAyWQik+YIpDiU7Bh5o3qAWr1vibm
    78iTT/BUyE64pVHSh2EDt6itTdVolLpeVIUm7hDoqeAkDc6ddIcI8CMcq+xRuDK10uKDxz
    zDkhi4xqowZfs66HAjUfcH7zqkmEzOEie2CHx+uBegO1Q46kqqA88KE10hxmWBU7CcGFdm
    /CGXscRjXR1wlWHBzzvjnEGzWoWjZkBke8Iapkyg2DJ3ewZ4tls8vNvUb1yX6K1YCVIkKZ
    I3J5R4EHmfvnFevcb1dXrr49IkSDmSq+gHLR8Jrt1UFF6mAQ2BWlMvUrCtF4kFYODkkvF4
    F42gHd/7KmSnwpvl5B1y7Vp84fQ/x+4GR5sBXdTnlN42JZAI50mOXv1RP1tQ
X-ME-Proxy: <xmx:jVaeagMjmEMUu20w2ausb3nhiPokpOsaXCyYfjZfLt2gkVEDgNQRGg>
    <xmx:jVaeak7iOK6JDbCt9C1Wr_UYg0IXb4fsDmftvQW_YFKTtovreKUw3A>
    <xmx:jVaeapmw44Q_sI79oj-0KN0s10mBn-hFv22P4PsGSosVNoprOjUOCQ>
    <xmx:jVaeatQBa-kSrOQE0ENK70Uyu_nnLUsJJLrcFRrA1-pr7O1p1_oAbw>
    <xmx:jVaeavS0u5ak0WkY5ldRS4yyD-Js___nhTBWmSIE4VWerpp8PbyvcMpx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 02:15:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f848508 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 06:15:39 +0000 (UTC)
Date: Mon, 7 Sep 2026 08:15:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Thomas Bachem <mail@thomasbachem.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/2] builtin/maintenance: improve heuristic for
 "rerere gc"
Message-ID: <ap5WiLQDzqdSyzvI@pks.im>
References: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im>
 <20260904-b4-pks-maintenance-rerere-gc-heuristic-v2-0-b1691121fe1c@pks.im>
 <xmqqfqzp6pir.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfqzp6pir.fsf@gitster.g>

On Fri, Sep 04, 2026 at 07:48:44AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > as reported and discussed in [1]. Thanks!
> 
> Can you, and everybody else, refrain from forcing all readers to
> visit a different message to understand what it is?  It does not
> help that [1] is a full description of both problem and solution
> that is not designed to be a summary to begin with, and to add
> insult to injury, it is AI slop wall of text that mistakenly thinks
> that more is better.
> 
> Perhaps you could have distilled the essense down to several lines?
> 
>     Since Git 2.54, background maintenance triggers after a commit
>     runs "git rerere gc", which acquires the MERGE_RR.lock.  During
>     rebase, a subsequent sequencer commit also tries to acquire this
>     lock within milliseconds.  Due to use of LOCK_DIE_ON_ERROR,
>     whichever arrives second aborts, causing rebase failures.
> 
> I'll leave it as an exercise to readers to summarize the solution
> part that this series (not the original one) proposes to make.

Fair, will adapt going forward.

Patrick
