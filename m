Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35353F1AAD
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947810; cv=none; b=njBC9T4DsYrJFl6sSUPJ72xUm9Pnx3KwKguNngEHfxsWEKY+JAhu2Md6V1+yY+SsaBvECxbO2rATfT/jZzjjx2S2kKsitx+EhduZfqFSUAx5YnrRTjL5urlalJEB3vzkI2lxb4nkixwRpihN0gwvjXIJBr7MJUwS7+9RlgT3968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947810; c=relaxed/simple;
	bh=Prtwp3nNHQqBGBeY/Hlm5MJNQubM8uHqY02WGuuRRFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y2M551ixrWtA7Ndnph17Gtn/zlOH+gESI+mgcxWAsJsAwzYfonJga1kBxnUscDkGeH7awkGxxh1AjxN5mQopWAdnyzhp1QB0V2tgGJ9/JO1PJOtOkm/cZusDiz1Gi+M+qEyQ1Sm2+fGl4Ex4tyS4hD381C/ZCvUPIznIF9mwhvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XBqV8Slv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F3j0K8xV; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XBqV8Slv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F3j0K8xV"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 22A011D00147;
	Wed,  5 Aug 2026 12:36:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 05 Aug 2026 12:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785947807; x=1786034207; bh=CUaggcpMs+
	UqAxyL2tQpWxeSdXEH5NXORGFrK9fOT48=; b=XBqV8Slv9ByeiLxLGlEam+ICzM
	IpCpuqRDnMpk7sdOxbIPfpFjGNAD5cD3F+L6cH1/wS1YurK3128TNu7z3ttzcfQD
	5PDJUdrsBac6tHe1ZfXIDGSQa8ihI+MTY4Znn7TnsomUCDzIs+wzWKh2lF3ge9te
	b5SQ2bC6B+5yp+nlQgamABZ3wKHOHyJHCjAYcar69PB+3lt0gSEw5P/0S0PUJGUp
	aJx0zGiO0WREzPa8womXIKp/Gad+9/fpLWrnlbmnUVC8dMaU93IQwQ/huEN8wVU0
	oXp0dFqw+ezYkkgpBIb6n1m+/LYg+2EKLZOLS0ZBqijIfVwHdvpivHz2o2Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785947807; x=1786034207; bh=CUaggcpMs+UqAxyL2tQpWxeSdXEH5NXORGF
	rK9fOT48=; b=F3j0K8xVvDXABCjNrJM/BruU3k4zgNCZ0CEj8CsMBeWPI7Zpw2K
	VTT+Vmf66U2dWIOhpvvlCDC4Rkg29HfQXx9o41BW5UOscZ1HpcE/4pEacVUJA8Wn
	Bn8laEeLKcOKxnSr587DqwXcNkLeedKhzFcQ23O0huI6oPYYBGP8tjjlkQcsqbfD
	V7CwCGlme2bGJpqfTklUpytYg7NR6IfpleCCeNmhif0YMUH1uZ6RR+Pl6kJAvYWF
	LzO66VEIySB28xeGqDXpzULLZu3xPMvdA3lORRpZ1Rn2igD2aHh5xdwSIq5s/nhw
	BOLg2fHgsVwykOzr2wKFc5CVZGU2lXuHcXA==
X-ME-Sender: <xms:n2Zzau_5s_Gw8v19yDq9mMDXbP76m3-u_xTETPEl4vA4LJmmj2eryA>
    <xme:n2Zzahwm93bRmkLCo15YIMdTq6rbpWzHl2xUE-7qM7blycYOz-yz7D4eJFFndlF6s
    5tUada42BxUwXJJIzNA_2BM1hb4PK8cMxnjyHy8PI6HBpKxnfEc>
X-ME-Received: <xmr:n2Zzauo5ZnkI_PHSJuU_Wx4Vcwe-YOpGs4BePh95LIeJ4H6hG4JiTCH2qCQcyLAj9YJLw4Y1Az_BKRfhe5vC_uk0bFpjB-B4RA>
X-ME-Proxy-Cause: dmFkZTEA0aJxyoF4bXzKYjI519qDkS9kk1xG/L2y6LdW39Lk78BsjaB3a7W2HNlT81gg/2
    a8tW1fjpU1ECVHb/iPsQ6IZeljEWjpu2vhQO9SjtBol25zzA9WNMFYdktCFdO/Jk6oBi9o
    BgX7QWCmxi2F7JWUh3a/shlE3o3MB55EEIcZ6GehCtBPfniVHAFYpWLnqmoV6jPLhRoI61
    WztMlpI/xNsOzS60z62Jbp8/Fzj8y7AX+QRQ+Mtga9T/sUbp2hogAdbH4PEaTHMUlLeoTJ
    An5NwE5rPCyr1h1n7xI9KSdXg7W8X80pUPzkh3xy9BWdayidfjAImerCYDIELFR6GbejKU
    v139/seJbPjZ1SF2pCi6AO+mPXx6uxfKCBk5Mb/mAEyo1iwHrKVFxeTtkAIbC2A3hn4cVj
    KzV4/g5qDrZORLXraOqAb5WytcMbY+ECvDNiRju+m33iqkP3s+ko7WpDKtkdKmzN/uYMO5
    x1VSvVsVHM0xY6cWWNLnL3BlD2ZSYKWMOzxdajg5Zh8LWbCx4zH7vS0qFZNA1575pdTI/A
    lp4+tsTNgZFPb+sB8PvkjevmkGWyvdRLCfjpLYcQzfEzmNNVADDerZjns7DmvflOGtpoul
    dWHjlwO0rmSxw80DZKMz7H6X4pMCC59i46IUmvwFlurl/k0GvWxWsj46s/QA
X-ME-Proxy: <xmx:n2ZzaipcSbH7JZq174IP8hOpevHnuucmozpSUf29pGsA7nQBHVUrLw>
    <xmx:n2ZzauBiglugveQ3EAYjAZYZgGent3GnQGQ543pcuAACcKQocoEQvg>
    <xmx:n2ZzagtqS0TGx345m_OcGs8o-FMtfwmX2Mhr68navfPdBo2Wx4W9ZQ>
    <xmx:n2ZzatLKAKvDpeTVGUk-n7SbIuNstJcrUkSMgJXO9_T4FlrUyJYXjg>
    <xmx:n2Zzau1CUelyKCa_e7cIX6f6DfdPuMa-HAeP8eGuSf3x-CG8ls_rpuSf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 12:36:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Sixt <j6t@kdbg.org>,  Ben Knoble <ben.knoble@gmail.com>,  Jeff
 King <peff@peff.net>,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  "Randall S. Becker" <randall.becker@nexbridge.ca>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: [PATCH 0/5] Reintroduce writev(3p)
In-Reply-To: <anL0nIk6uzkYR9Oc@pks.im> (Patrick Steinhardt's message of "Wed,
	5 Aug 2026 10:30:20 +0200")
References: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
	<f8050598-392f-44c9-8d66-0454740a7a12@kdbg.org>
	<xmqqo6fso2s8.fsf@gitster.g> <anL0nIk6uzkYR9Oc@pks.im>
Date: Wed, 05 Aug 2026 09:36:45 -0700
Message-ID: <xmqqy0ekr0bm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jul 27, 2026 at 08:44:39AM -0700, Junio C Hamano wrote:
>> Johannes Sixt <j6t@kdbg.org> writes:
>> 
>> I think Patrick's writev(2) follows the pattern our previous compat/
>> routines have taken.  We use real writev(2) where it is available,
>> and in the fake implementations in compat/ we have comments that
>> essentially say "the real function offers X, Y, and Z, but we only
>> want X and Z and do not need Y, so this implementation does not
>> support Y".  It is harder to maintain because the application side
>> may be tempted over time to start depending on Y.  If some platforms
>> cannot easily provide an equivalent of the real function, it is
>> easier for them if the rules explicitly state from the beginning
>> that we do not require and will never require Y, needing only X and
>> Z from either the fake or real implementation.
>> 
>> At that point, we are not describing the real function anymore, so
>> your proposal to give it a specific name is one step away from that,
>> and that step is in the right direction.
>
> Yeah, I was mostly trying to follow the precedent that we currently have
> in our code base, where we assume POSIX functions and paper over any
> gaps that a specific platform has via compatibility wrappers. And I
> think that the compatibility wrapper we have for writev(3p) is close
> enough to the original semantics of it to not really matter much in
> practice.
>
> I overall don't disagree that it would've been nice at times to have a
> higher-level interface that abstracts over such platform specifics
> without assuming POSIX semantics. But I'm not really sure what it buys
> us to rename this to `write_gather()` without rethinking the bigger
> approach we have to I/O. That is, what does it buy us to now diverge
> from the current practice, and where do we want to end up?

As I am not the party who needs to implement a good enough
emulation, and what is hard to do in non POSIX environment that is
needed for writev(2) emulation, I think that is a question for j6t.

A different way to put the same question is "what is Y in the
context of the intended uses of writev(2) in our codebase"?

Thanks.
