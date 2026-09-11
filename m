Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090BF415F04
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153520; cv=none; b=ZkdLToU5FLBLHJRpUqVt6S4F6qZTe6cZOmjocvj+ATUalNN86IxMvXqTls5F7Rzs6h+WCS3ja2mmq24ZrHwg/+aOsu9nRLR1xtMHFq32jRb9il083Dn80urX/H+VaLj/VQIqXQlCvvfZq9rXHUv/S+Z0kY4NZ4vDaqIY0QF1Bx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153520; c=relaxed/simple;
	bh=VRZEN/6Bil0WopM6hsiCYJcA1iSptbgueWR+jukrJ6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LO6Ku9HrSsUhcW4cUuq2xL7IXVeVjCjE42zin+PTXW3sKTrcYQNZGoj07i8DJsFPoBz5bYL+SsZnefzUJ6QozNp0j3Qj81olfJCe2tc923DIkUjDm0QgTkihijxtHTdzRthVXahRxiqbO0/VP7+ecj+T+qtiTFmoFc/E6qB6KJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RdhBOkKz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WbiEigZn; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RdhBOkKz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WbiEigZn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3BDAC7A0021;
	Fri, 11 Sep 2026 15:05:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 11 Sep 2026 15:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789153511; x=1789239911; bh=qFVqQ75jL4
	khC1VOXZtl/K3bmC5TQLPo+9+yxiC95N0=; b=RdhBOkKznNQfOEchREvbw/iJ4z
	cr7YFmycUYeRTTqc+tflU+Cph2uDcGKkafCmxxafLx76gK8P8hS6rusOi1OJPoK8
	Z4xlQe0cbV7XTMPqMG/tj9NHYu/Uc6WT4xHqSuPYcEnxFNE4UEHfZGMUOWBpK94I
	kLlK9P+z7DM801NlY24uLxae1alWxCSPRY3XUYjFjqWO3mhxLEecGdPe18gIuUDn
	XDh0MxR20BqmxfqWMTCcNuZItqu+PPtx92+uJ075Qu+DO1ZK9IXNa7FFS5Nux/1v
	jNpU2PT4c7OP/40AZi5v7Nmj30UXEUWOuRl0hGhlbVacrVTij3dFN/RtidiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789153511; x=1789239911; bh=qFVqQ75jL4khC1VOXZtl/K3bmC5TQLPo+9+
	yxiC95N0=; b=WbiEigZn5LiJU+VTetLPOkEnT8OSn0PF31aTpeGKwX2UJYj6Rbt
	yMgmVRUmgtOQoWZ5P34+DTNMW0JPQ6zmj7cdVxop61xLDhVLykbz8NA5hKJwb+TR
	g1FPNP7D7Tb8aWIGWebUDZ20dlcRva5W5obn5yFk8SdECqD8xKEyYFT2TIFlnnqk
	eaaCMRpgqvsCibYJ8GaFDsK144QoI3pYTmAb9xUHSaA5XBKWW76Ubl7/WSfgWxFx
	iHwFYH0Vm8+Q8IslYKWlvEWsgcOr7a6f9jTLolHNjM15xkh0c+/Z0CVTwlK5n8i2
	EUZeHt1h66i5F77OhRO0fOyj8J8lPM8JvwQ==
X-ME-Sender: <xms:51Ckaqd96OvdCpj4Tst3a4VtYh4UMfM_srQ64OQpHbtSzZt-w7S2Yw>
    <xme:51CkarNKBF4dag2D1PEP22ZiWY9x9URhyrKXQxAOVcRS1dMzxoD2W3KIFyMeGZxHq
    ei3QZOLUiRL4uFX_Cdlb8nNSFj20iLnNws3eZUY4yU3xKZC7NVZwQ>
X-ME-Received: <xmr:51Ckagiu3mc86yPJ_FUTURNiZ71obAiesQk_nH4iJXnkBGmYFM0-EKWuovhuqXet5PLkzTv7vs3EAcgZA8ht9su4qyE8nkRBUWQG>
X-ME-Proxy-Cause: dmFkZTG4l74NkETFbYRGL0jsf/1YhUw/kgTu22dFt5FMFP9lWp1sJauXv/Ps1vI/QRT9VP
    oRT3wYxt2v7wypESUC4MbutIHcmiMqjFcocykJBQQQrbkWnAJydYIKKUyFFZlfDfLZDSin
    GwcBfvuPneY4PDfQsWzbKUNv4uVfx6NHMx6F6A7Rkkm4IoaifV+glUKXKtGCZxMTNYQBhm
    XoIEFH+JkdaBNuR4mmzUUd0NWweligZRS7lqWVV1FTxRpPapNe8rT/5Cy0J1B21hhE2kfX
    eA0tWScOtGNxHeQLLxzOfvcu23RbTVm7neiP0pD+SFIdsI5055C1OdgRNmgBQnZlQhOzZA
    2KR+8ZXbx9jdggH1IozI00LHt/iAuNFLEVWBiwiNn6PdcVYhaskgD0lAasLu81voL7hh6m
    tcAM/qQmQZ3sQnUrCHfo+DZz9h9hOwgLNDCjbZfQG5lboO9RIKnyxtjFFLzTjDeyaWKYW0
    A7p9J41EJCRBFpP8mKx0JkC0AbZpIpO5n171fjNN2jjBSMwZkslXMK9qfF5dQ9VXhZHxrI
    JzWVTqRPPlW2cKe62QJJEbZQ20eFQ/PZalFbFmLr82G/C/exJVUUKDnizhYF9OQ7gJgRrz
    nCOWDsRR7jRwW/BPY3kUuYMHMjv5TZLghdxJSDv0vnpLsv+y746GRz+10ckA
X-ME-Proxy: <xmx:51Ckam1Xq4J0RvZPLVCRx3jnWW4oQeplGx3n1eOMLnCzRCfkrmWw8g>
    <xmx:51CkaihdPV9tLuiBrNgWoeo2GaQt-IVujz6WkQZ8B3O9wPMWf0uo0g>
    <xmx:51CkaufnSI76eaNufZiaXiPq36sDNteDRCaDrJOSjj741UO0GDRmDw>
    <xmx:51CkatlaQ7izoRMEGbbIqtAupTvHbGQAT4dNDUhdtzY6rihlTwTLiw>
    <xmx:51CkakCuXEf-rUBAJq_W3X3Xy8xgW26H1gDDms8N_GQSA0fGAsA51vbJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 15:05:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] range-diff: add --matched-only to skip one-sided commits
In-Reply-To: <CAHwyqnWVXuDMAonj1jK9687xhjiT4h-0E2qzhjwPXOTKfMhoGQ@mail.gmail.com>
	(Harald Nordgren's message of "Fri, 11 Sep 2026 21:01:24 +0200")
References: <pull.2401.git.git.1789144877632.gitgitgadget@gmail.com>
	<xmqqik4bbt9c.fsf@gitster.g>
	<CAHwyqnWkEaQHsp5GtYGL9qg-FYA0Ngt_+omdh8jmw4KfqfX6Uw@mail.gmail.com>
	<xmqqse3faadj.fsf@gitster.g>
	<CAHwyqnWVXuDMAonj1jK9687xhjiT4h-0E2qzhjwPXOTKfMhoGQ@mail.gmail.com>
Date: Fri, 11 Sep 2026 12:05:09 -0700
Message-ID: <xmqqik4ba9sq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> > Seems like a big change, and deprecated options are a pain in the neck
>> > because we can never actually remove them.
>> >
>> > If we decide to go this way, we might name them "--hide-{left,right}"
>> > and just not introduce a condition that makes them incompatible. Then
>> > "--matched-only" would be pure syntactic sugar and wouldn't even be
>> > 100% necessary to have to achieve this.
>>
>> Or we can just keep the code and fix the documentation.  I think
>> that would be much less impact.
>
> I agree.
>
>
> Harald

I thought I'd try my own version, but it seems that we can simply
remove the misleading sentence and the remainder already is very
easy to read and understand ;-)

`--matched-only`::
	Only emit commits that have a corresponding commit in the other
	range, suppressing any commit that exists on only one side.  Useful
	to skip added or removed commits when reviewing how the commits
	that survived a rebase changed.

