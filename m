Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2F53C3F5C
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255322; cv=none; b=QoZv/dy4Qy3xq0vWRbRMCYqO9MuTfKkzFn5V885jjP1KB8oV7MpN5DowWrYJMJ20SI8CGQoGpMcR5APTKHC5nmzOh+iekiJwYPUPQsZH3nXLAKVZFeYchU6/yTumlLrsW8sXRARZkraEHn32WIqr1KhQOu165pYEU3+K3O4zBD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255322; c=relaxed/simple;
	bh=DbRWvZGPHx1Q3h0NFEhzs3RTyI+SsTOaH7WfuGM3cXg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eqEYNlYxXlD8PoJrfJ4e0fRM6d8A3yRVi3jqq7uYExGwxXSew+Q5c9wQFpFEFbxs9/g2OGJE0pbNPo8YTmrlJLlLpOl3vveRbGIxfEjfQ/i+1ZGyTPCD4Lf5hAweQUVfP+ok+6v5HYUSpGt4J2ce0Pj4COG8gT5OJLBBjuSzbhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ou0rdB5c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G8fBlHYw; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ou0rdB5c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G8fBlHYw"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD2A17A0076
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 12:41:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sat, 17 Oct 2026 12:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792255319;
	 x=1792341719; bh=URURPtUYDeXG2LBj+/NuIbn0ZLebAffqXIwC2O2Y59U=; b=
	ou0rdB5cvwPybRLYbBwzLWzN30fhl1cu2leSUHeSxKtLXyfhM0TIELv+bn+8MU1F
	533VRauAMX0vQ1uK1L6sayk8HKaZAkAQDI7SiTTEDPCwtrOH20dpNEWD515NuVoK
	47qAt3ShzOqJtGASaIq+aW+BExl0gl97b8nPJ8TrTlx9GRmQHV0XUYXBvhv9z6R7
	V9L44VbRKvTUj99MD1keeD0wH63ntLI//rCUf+JALVpg/7g0Zc3pr5ZowDRbfMS1
	Jmu54jdPmj+SUzm077LRjKz3CLgr948eNI/XLw36Zs+tROPOVpWfZ7QJhp4Czhdk
	cAZDSMG2lM3bGX1YcoRnkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792255319; x=
	1792341719; bh=URURPtUYDeXG2LBj+/NuIbn0ZLebAffqXIwC2O2Y59U=; b=G
	8fBlHYwmTMPvXu2PjS7RMlsSWfa5duPVMEKlNXIX2k7voUoAfu0ksxlDMhjj6CyX
	x0VH8n9Vq7oWhIPiIIdHeZXYRSf7fs+6iRBsZ9H+WExey1oCA/fVC0UqEca9SRpw
	+/ovru0ZietoQy785mtpB9OwDNe5FaqvCZMxf42s0TKo0vkXZsXuuuWmqB4MP01X
	DZQ7ih424/sxodmT+OjexgRd4xYuMjypOkkD4XvSf5Hfh1zdHJC9XQxcKn8hl4PS
	YhEjRTFADghRy8oiLnwne7NGR/RSN0qbmdpgyh8ZceIHsji/IwsPOYgfyD1t2VMM
	gIbKeOHFd3rSECv+EsrWg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792255319; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:jmAKKXQPLKHbJPUgzS9R+9Fk7zcWp0qXcprbCM1+0PP/i9O
	kRtZRQeK7PToCgfwqu1ns4GlD/jEjjTwlC/ub9mo+zgG8HGKiFGSXDtqBj/Vfe9F
	AZkTr89HN1KjsoO/6r3RW4HgtMIs+G/W69t+yvrSHBeaUlbkGbDEc5Z3WCYjEfgw
	m9xUdk7/cUcWjiBUU09S0CUMOTnmzXBRYchO4kZCuB5hsx4MUIXaRNUPjixX+HeB
	DdkdVcyprX9nipAX0LTlKB4a9lgUIvDLSc+fFbx+ulcfNNmN+4p7YouE6diaWT0/
	206kAe4XwJ01ZeNQENgnRWM6ErrE7ttydftyPQg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:50fl7KSUlCSkAEssOK3CNdy927vn4cf4pKq/XTk7EAw=:DbRWvZGPHx1Q3h0NFEhzs3RTyI+SsTOaH7WfuGM3cXg=;
X-ME-Sender: <xms:V6XTasMzk2a6nOQAf9eXUQErhJHnm8VzGbA5f_m3PMdcH7vRAvXOvA>
    <xme:V6XTap_8ICJLaLTO9GIvRrr0-7qmHLEKSZd7bpN-xu-3ce-WxnLJrA6l24bboyUQ5
    saBw6czxz5D55Pc8Hns34AcuK3TEMioASOC5ImGE2_Stg31WIsEx7w>
X-ME-Received: <xmr:V6XTaoR3gF0kagLEYd8M-qLTztVnogVLoQONcoAPWoY9SdRrkw5eHUyUcv4J0dbCkXupZh028NoxEkzRFBtb4viI3dwyi_5PiQRJ>
X-ME-Proxy-Cause: dmFkZTE5MYyicAiN+mI5mgqEHz3LSuT3TohlGu369vopuPYnWrKuPus+JCvxPQcKWqerQT
    7vaddzR/Bm5QO8Mzz1Gd90lEznDp645HbEwsFHz3aTYWMBcxi7NdUrFYg15ogppfxxdOcT
    1dl1eVtittiYIZqxHwgDUZmJJRF6F4fmoNkQ46N8gly5w1YDzxHM7lrKHsRQ+6yFENGWKm
    2Wp+ga+2ZCsHstgxbQa+mO/bfk8pFZ9EuPvaVSHlgWSh4BQsHJH7S+U1fDx8K+jVIbrHAk
    WGcdOWB/RVbXwrbWxZ3Iq9YGtwBrv8op53ksbXzKRACie524dBgo+Jx5J7DIU6x2QZ2Mcc
    wIlvFiMbeafwPrPX9URhBkM3Uv+rpmBraCUq0tIxydPI60/vOIXAMq+bSqURAZLHD2FMX7
    L0Jj/DMuuksh8KpaE1hMEH/WQAuhCLbcCXVxk5uUaC4QaRPWLZHxNuGBFnoGiErlX97M/z
    oJNPiDRsFGpYlqhgcRYnt2fUIbKl0hpWLkO91hwujkYd/S9chTeR2BClkI8zdc8MYhYOh8
    1lFvAosiy2Fm9DU3MVjLDf3RYhs/7D5SZj1F3ssldwikM1bukZA/W47nnOFyBdHHxtg4/R
    wBbEy+dZ1yr4e5g1Q02vah8fRlbUtmNTT/GEl551qf7DBhcvRGKpHKOV8dPQ
X-ME-Proxy: <xmx:V6XTajmJ47l22UOE73HZ7aaLIk7iT1vFp1G6jppJ9TZGAOMmXFBE9A>
    <xmx:V6XTagTZ9y6Zs1XUopBC_-7i8yl9FlqfOjShP5VZNo1L_GxtFSW4kQ>
    <xmx:V6XTapNMx4KaDsnaeJ16kiZvkpdiPu9s-hCIs2ut7o4KnkMr2YM2lw>
    <xmx:V6XTahXAFlcrYPDQ5KW3PM4JL2KASdJBRtzjtPVGiJ1jWfedUE77JQ>
    <xmx:V6XTalpsh2iKo7ufllJZA4QiiINioazRpozdMK8wKnUS5JcodLWtFmxf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Oct 2026 12:41:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Luca Milanesio <luca.milanesio@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: My summary of the Git Contributors' Summit 2026, was Re: Git
 v3.0 timeline, was Re: What's cooking in git.git (Sep 2026, #08)
In-Reply-To: <BEEE94B1-EEFB-48CA-8B45-EEDB10FE244F@gmail.com> (Luca
	Milanesio's message of "Sat, 17 Oct 2026 10:11:32 +0100")
References: <xmqqwlsei1pv.fsf@gitster.g>
	<76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de>
	<xmqq4ifhgzvx.fsf@gitster.g>
	<5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de>
	<BEEE94B1-EEFB-48CA-8B45-EEDB10FE244F@gmail.com>
Date: Sat, 17 Oct 2026 09:41:57 -0700
Message-ID: <xmqqfqy4b7oq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Luca Milanesio <luca.milanesio@gmail.com> writes:

[Administrivia: PLEASE TRIM YOUR QUOTES.  Most parts of what you
quoted from the long message are irrelevant and did not help giving
context to your comments below].

>> SHA-256 support across the ecosystem had been a blocker. GitHub reported
>> experimental support, with general availability expected around November.
>> GitLab already had public, non-experimental support, and libgit2 supports
>> it, too. JGit remains a gap; Google was not planning to fund that work.
>
> It looks like the above statement needs amending, see:
> https://gus26.gerritforge.com/schedule.html
>
> Google will present their plans for SHA-256 at the forthcoming Gerrit User Summit
> and jj Mini-Summit at the Google Campus in Sunnyvale CA.
>
> The talk is at 2:00 PM PDT: "SHA-256 in JGit: Why, What, and When (Xing Huang - Google)”
>
> Anyone joining from the Git community?

You forgot to mention that the talk is scheduled for Tuesday,
November 10th.

The home page at https://gus26.gerritforge.com/ has a registration
link "Register - it's free".  I have registered, as I expect to be
within walking distance of the venue on that day.
