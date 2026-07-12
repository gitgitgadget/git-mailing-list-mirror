Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DA2449985
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783883088; cv=none; b=RayNbETnVJYQCwLlBnW/Mykix+V4WRhWuBJL8Q5BB2032PJdCltEMJwHkBIPDJtLZKZrNPZPcksT9QPsuYROkaE/YrmVdopBKNOjPJp9rNCpSkzA07LM2Z2wG7pkvmGvxk6i+tNr4DfbW68ese3T/vNpJSsAak/fzjX/8RPa5nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783883088; c=relaxed/simple;
	bh=CHLkcjkT+xFX7Fw0dLgU+J2fbY0OzvLTOdslxIb5yn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vw3sDlqf0X+grJqjRkY+UQj/vtAhUaQZUxFv0x/Oz/lF+RGrZ41GC0HMSqjOknxutXWoRlDr/bv//GChTPoeJMqcIfknzSU/XcSKcFdynWFMzZ8cJwZAFkgMK7Wfudd/x3X1rbZSPB8Af8KdTCnxCKCv4c181qFgMJ2Xsd5tHUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K5c/zMY3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lrg3oe1i; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K5c/zMY3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lrg3oe1i"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 815001400022;
	Sun, 12 Jul 2026 15:04:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 12 Jul 2026 15:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783883085; x=1783969485; bh=z8ZNkQX+Oa
	BP/APor65xNfWv/Uz8V+phkV92QsKHlwk=; b=K5c/zMY3E6MqF3Z+YeLmpm26D3
	XWFUwL3g4igUHWX48eR1CJ8nKXb4ktExrZ96izrt8ydsNTjq1j6MldqAAwBOr9fq
	AjgKtJyUlBe50wHxq3+hJUcf6Z3XsNhFEO4JfZC5NztxXcsoGw+MRDu8TYM0WvP7
	gT+3Qv25Km5LHraQRSmrVP3SIYS1Uy25RxcvOpXg5cjrvcvGO3lQml6tbZBkZgO8
	5SLX3WPSQVGKiCXLMZjJEA8Odm2TfT1QJds5DMn4XkoGE493pwYM0bMGm6Tc6NPC
	jX3xitG4KCWUBFtCxc75corADptgIJCZqa0zATx6e/u4pv9jkIo3u0hDc0iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783883085; x=1783969485; bh=z8ZNkQX+OaBP/APor65xNfWv/Uz8V+phkV9
	2QsKHlwk=; b=lrg3oe1iD6NCHVeCBJa25W+jkPHYOY1uG2KWtwEByMhD2x3FN9w
	2U9wNI8MKLOyruxqJy7iZ9p87ZLSdGBFp/4/jtkJmIIv39ESnankba6HgHZ87x3c
	XZfY4/1mhvdcH/6MqkbyEMAFfcAIz3XUqOaq9CQcDc1GgLuZZw7lY5siFGTzv7o7
	h+P8qzGuytBlCnFbGlkizgayTnAGKQ0x1whFbjXS5z3ChUhwSnKmlTmS1qXWFQAx
	l7cpKZwXALXDrSceDSeBfoZmpBmk03LRH7C8QVnNBrMMuokPgF84nm8j7JJQIylk
	gsGWR+wQ0NYMw331BRIC+xk6cmeThlVD25g==
X-ME-Sender: <xms:TeVTak4o-AWS6tvmigjEmHg0BgGQwDX1PGStEdEihr_7E8xxxkKznA>
    <xme:TeVTatU0mfzg-Lq3R-z2NBmucP50rfqYTm6IxaeTIXVQr73TGKu7dXcTZoTiCfLEY
    5dTarNrgcsRNeqZm875lz3wTJkmDH4xbGjywrllIeB8v178qCglfQ>
X-ME-Received: <xmr:TeVTag3ljNE5kPLNwNFNsecArYazQGXBnQ3A2ixurRADxKZhmfqVFiO6BMccJd-yOaWEVPgVtU4bsARkwG6q1rnHinQoOme7D6oFJEE>
X-ME-Proxy-Cause: dmFkZTEIBpYoI5YkCq99SJSsJoV8XnzbLtDAStK8cz5qpgSBFXtNPwYtNe8Kuw+GUuR1Wj
    QG3AG3g7lYic0l2eyiZJYsrJeXTazq2QliLZmRrZM2AtHYF8cOSAN4SMJy6PWGUOLXnryo
    pib3h8P+yaiBbEg/KO5EnJMV2jm4xiaY/6OmBNhgamu9wfktBNbvCjljwcZLOtvWULge4t
    8jEqgrTqcvRO+/qnFZ3zw4cOMFFWc7ntBJp+RuWLFfFcdKoWd2UfmAIjAgtpM+N55njtCv
    pfX5W6haT+foyuzgfLeICsrbiXBDPVYtAVIAvkfYuYCDelJNPB1cieZuRQ+Co2GBOI/ZYh
    vSWLe4hufc5VyV9COeafvylerSzi9hCaPnnOPhbQWYNG75ibNbMo/xdluWnk9RiDkT/dA4
    Gy8XhU75BmWWl0qaDvWZShFKaD3Gi9PFcWZVguq+NsJH/KmiZYU4lH9Nm2ohVPhx2M1kiV
    mnH1hbbJtMlgcWKgYlVmT9gds7Zy9trZ8FImSgPNrfECJokTOHRxa5KM+rkrrrVvxqPCiI
    iRJgBzz8BE8epsFyS0ieA8gcdfJyXUsShn4VbuRoebF5QLSZHdJYR77XXQciTcf8YAX/Vt
    zjW8h7MYA42EIxRsGEjDpDZv8XYdxA8XdAsvYxH0Bd6FDpc2WAX18ECTOXBA
X-ME-Proxy: <xmx:TeVTai24jSVplYsgLAjRpyhsnYU96b9G9q4qdY_o80SIw3fsE3EW3Q>
    <xmx:TeVTar9UrYqTjSdGi9fQlcpXmC83ezYRB5wjjJwJcfD4S2uDaiV8sg>
    <xmx:TeVTan0wlpLE1bItt9MwquNmtMnlR1fxjfGNPOdCvnN6A0VL2kXLsw>
    <xmx:TeVTag_9keAXgrElNyLsAoOlJOFxi-Ni0jQ57DLGjZCThEG68tcmTQ>
    <xmx:TeVTamhAfMJWJqqJKn9MXgrJXmo0DF5kZHihD_gGZq1mx0NZTXstv84U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 15:04:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Matt Hunter" <m@lfurio.us>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 4/6] MyFirstContribution: clarify that 'seen' does not
 mean acceptance
In-Reply-To: <DJWSKKVJM03B.1DTV8F9FXG9IF@lfurio.us> (Matt Hunter's message of
	"Sun, 12 Jul 2026 14:08:02 -0400")
References: <20260711192650.2417665-1-gitster@pobox.com>
	<20260711192650.2417665-5-gitster@pobox.com>
	<DJWSKKVJM03B.1DTV8F9FXG9IF@lfurio.us>
Importance: high
Date: Sun, 12 Jul 2026 12:04:43 -0700
Message-ID: <xmqqqzl82fn8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matt Hunter" <m@lfurio.us> writes:

> On Sat Jul 11, 2026 at 3:26 PM EDT, Junio C Hamano wrote:
>> +
>> +Plenty of early testers use `next` and
>>  may report issues. Eventually, changes in `next` will make it to `master`,
>>  which is typically considered stable. Finally, when a new release is cut,
>>  `maint` is used to base bugfixes onto. As mentioned at the beginning of this
>
> It feels odd not to reflow this paragraph, where the first line now just
> stops halfway across the width of the paragraph.  Though, the diff-churn
> may not be worth it in your eyes.

Yes, I did not want to force patch readers to review three extra
lines just to spot a non-existent difference caused by an
unnecessary reflow.  Unlike SubmittingPatches, the target audience
for MyFirstContribution is less familiar with our source files than
experienced contributors are, so they will not be reading this in
its source form anyway.  Therefore, I thought leaving an unusually
short line there was a reasonable trade-off until the entire
paragraph needs to be rewritten.

However, when the next person who wants to modify this source file
reads it, it will indeed be distracting to them.  So, perhaps I
should reflow the remainder of the paragraph.

Thanks.
