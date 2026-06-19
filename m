Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DF92E8DEF
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 01:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781832990; cv=none; b=dqrulSMy4yXVXXR77dD7/YvbWZ/aEaSJlkJOvzzVcZHWknl/XLQCzStwXX59Ggn9bbCvTh2JDEqLnWu1dYIl+W9+rgx9NsPLYAXMmrHbRd+IhAQZfyDBo9gtWXRhAlr63R9F55WrG8qQGfRuvaV5PoqAqJdvWTJZ/rrnjZq9fZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781832990; c=relaxed/simple;
	bh=noBZithqtQUMKw6iQ5z0oM0rwF0IxUy3x83+LU7L6Wo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l+nur/3ejzQEfGTdIxjOaRwSSe5CkHyGOm4dTaohCAgVCcIVdIGtwRBOLxBWpmicKdEcUfh6yjkgwpEA672EcmJU1gktfGvv8ketWuHg9Zu4Sw+y8RAmfLUsSYSkKvcY+CJIixN84wO0pvlG23Qt6OFtGCIE7jcDJ+FGcjvwJX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Innh4oWS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HnYHZwyv; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Innh4oWS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HnYHZwyv"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 6AF6F1D00120;
	Thu, 18 Jun 2026 21:36:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 18 Jun 2026 21:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781832987; x=1781919387; bh=bOLRIWTTQ6
	CUOfMlxsAvqZ2tMaomzSUni1nnw3ldpdI=; b=Innh4oWSL2nbgJnfJJap5KPHod
	9BLh6shGlsR0MFS6q1+YF7c7vsAWpB31SLuYzsO8RUFBzsCP1lTzlhTmkyUAQfWm
	uBOinNHTqDQuXvhtziIfc+a+leiJmQ0JhotquYvF1w/mhZP3JHqethg0DdJNAmf0
	PnAV5bp07q+ZyBYee6mF6D6yqCCuHDzSqJNzUIdrasnlAymu4qrD/DqifgWoeLnf
	juOhDXSbg48dLEuu8QIvydHDVpXMEqR/dPWPXUv+yutwOXiiGJMZeYoDQovoGImh
	b+Ry3eo86UxFo1d5b/raLgjhLWe1lw7Rk/RuDbyHHAj+lZAd+fVKLXpTJmcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781832987; x=1781919387; bh=bOLRIWTTQ6CUOfMlxsAvqZ2tMaomzSUni1n
	nw3ldpdI=; b=HnYHZwyv7JwGvg/PoQA+bT0owyt0jDP7ZXKuV1JOr2LxuX77gHi
	Vy7yLD3Yx0JubXVEfb3UVLpg9vL0m/qsJTBR3UkP7d+MZoSLSUJ2vffh6iAGnlUd
	I4Qv3gqgCNVNfvU+YPAFMVZY1zJXy44GxLNHLsLA/GqDqa64WBTSswD0HXKjGNfM
	y/elxHTvl2FU7A6m9FuYJagMFH2TDR89HX9/qVoU6zDXHofXzK4b95rIXZ8rj35q
	78EwoLSRcdfY6yLrqIiZ8ntDlkct0MgTnOjCuNwtK7G1jQhY5gQBrPWhFua8H2qR
	3+UfgtsaAGTFug2mTYKaDQhVtYPnNK+AHag==
X-ME-Sender: <xms:G500avwQEAguihyZ6ZzPumCY-Pffm8AfE_maBm7GwVSL3RJ3D51e7Q>
    <xme:G500auKJlik5l_GHXYtvdOE6220bO4Thv6i01uulkpK-3ThxURMKTV-MPZUSlwLy2
    OToIVG7T_lww8EeV0I4sMbaoJGhoEm15FsE12Zqvx348WeT4P6gQfo>
X-ME-Received: <xmr:G500ahpUZLDv1oFuLHVzx6c0FStLF5ouxH6okv2dovPZ0GENeuEBnjmejKTJPQwfbX7H_6fp9soMaknTyAu1xHl6MDzXjojdtoUN>
X-ME-Proxy-Cause: dmFkZTGcet64pKGQis45HCGgT/FfgPza6fIcwJJnCOojpza52fdN0g33vot6p0uTwqK0UK
    ftZZrNwLwuK6ReUHfDUUgFNb15bgRMHbvtibp+BblWq9JUjgPoxllqXSChi9lvU6eSb9Sf
    MSRwJ8Zd1eAFkiJS37MU57rZNwuwbyu2J+R2i+j+mafKLQIzjXZ59yQuhCZMROJTfv+HLB
    m3lUlYlvyl2LkJHeswFA1V2vRIyOtAuU2+T+57W0qIrIOoRZBKD2O6qMFj55g5CPm+PuQe
    Pi8lMbPtJTK7zoE3LzpTzh2pck44jYAa2Na7oUdNr1HbqWN50SnfwvgAEX3a9QKBj/oLdT
    pjEA6U5U/jVPERiztGVREYGvXIiHOjoILjzqjd5u3OnvfjvrPb6kA6SnclvvnIeXJ5MgcF
    qpuKkFaAvrvYiqA5aLRTSZuK9egOHBTaxHfCMtEAf1dsZlQ3poxLi8V0eA9dN9H3pEugWQ
    supmUS01Qs8zMHkpN6LUQ48FK4hZDhZS9/5pFD5NQ1xERpB/vwbqorriR/RQq5wDBOlbMJ
    3FEiVMp7X/naIHieKgzBy3/4avpdzV67xhhZB8G0mpf6Zmk1ZORkQwX4+DTc3tYLStYu0u
    Zye4xokEnunfR3gl9/Hnns3Dx0i9fP4NYkmBZD0QatOVBpva4ZtIBiHmpKvA
X-ME-Proxy: <xmx:G500alJV4NdYk2N5jzsUhHMlif6IMt3LRclDPBnhpXbOREgbLKdjcQ>
    <xmx:G500auS82W-V_seTqUviHCVzrCwDpXbwxeFm-1V3HJoShH2Y4RlKag>
    <xmx:G500asuelh3v6ZOhP7nOds4RaciTbCeUs3MRhF-Ia_2prtvHqPrhhQ>
    <xmx:G500anZGKa82dGHndPOssO_NQW586I7IykR8EN58ei2HUP1UNL-uug>
    <xmx:G500agbSLQIyLhI8qnvvuP1x2hCMJRqqES-LOtjbA3oR8H-CRDoQsYtt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 21:36:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Harald Nordgren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] rebase: mention --abort alongside --continue
In-Reply-To: <CAHwyqnV8je6gCTExr=CFCdYskN1dVaEDVSKDLUo5A4Ukv=qhiA@mail.gmail.com>
	(Harald Nordgren's message of "Thu, 18 Jun 2026 20:49:17 +0200")
References: <pull.2330.git.git.1781551170529.gitgitgadget@gmail.com>
	<89d72342-5aa1-4dcf-951b-d0c791f91738@gmail.com>
	<xmqqpl1q2xw5.fsf@gitster.g>
	<bd7dc183-6597-4fd0-ae64-682d46480cd4@gmail.com>
	<xmqqo6h9z7e6.fsf@gitster.g>
	<CAHwyqnV8je6gCTExr=CFCdYskN1dVaEDVSKDLUo5A4Ukv=qhiA@mail.gmail.com>
Date: Thu, 18 Jun 2026 18:36:25 -0700
Message-ID: <xmqqa4srnwfa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Just an example when working on a different topic:
>
> I rebased with -x to run all the tests, but ran a test that didn't
> exist yet on the first commit and ended up in a bad state. Here it
> should clearly show the 'git rebase --abort', so I can start over,
> it's not something to fix:
>
> ```
> $ git rebase --keep-base -x 'make -s' -x 'cd t && prove -j8
> t3454-history-squash.sh t3453-history-fixup.sh t3452-history-split.sh
> t3451-history-reword.sh t3450-history.sh'
> Executing: make -s
> GIT_VERSION=2.55.0.rc1.20.g1e31474ef6
> Executing: cd t && prove -j8 t3454-history-squash.sh
> t3453-history-fixup.sh t3452-history-split.sh t3451-history-reword.sh
> t3450-history.sh
> Cannot detect source of 't3454-history-squash.sh'! at
> /System/Library/Perl/5.34/TAP/Parser/IteratorFactory.pm line 256.
> ...
> warning: execution failed: cd t && prove -j8 t3454-history-squash.sh
> t3453-history-fixup.sh t3452-history-split.sh t3451-history-reword.sh
> t3450-history.sh
> You can fix the problem, and then run
>
>   git rebase --continue

Hmph, you do not have to "fix" as you know some of the test scripts
did not exist at this stage.  So the solution to the issue seems to
be just to say "git rebase --continue", instead of starting over by
aborting.  It is especially true if the test scripts are introduced
in the middle of this rebase session somewhere later in the series,
no?

Of course if you gave a totally broken script to "-x" option, you'd
need to be able to abort it, but is that the use case we should be
giving one extra line of output for users in all other situations?
I dunno.
