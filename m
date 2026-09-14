Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D6C4968E0
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789415615; cv=none; b=UnyyKV211rVmOIyVx9c84YSK0ViVJ0dpRfWFvufM7r/NPAvwzvrmKGh7iryDI8BPPWkhD15dQQKeNHU6HD63beNXS1DKEV9ydxcnNgh1C2fm1nAC6NJUeuQiceyJqa7PdRuAXY1mIfa7MrBvrIcUwz/J3y5Sx9q9UHQ6Je6VihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789415615; c=relaxed/simple;
	bh=BjpiJWZGnixWosgqrErsvG4F1XSRTUzt9RhCq6SWe8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dBlLKSDIRodl0McDOzIQyvtVnH00mvv9hqgYhJS9bw6CcHEib1y7mr9k41ebSZkEGaJuQ0VX1U9dOfLldbOwQYObCybbp5cX7+W7Wi9D9RNsqVs18TATqECglYLk9SzCcshTcpLGx08KokSOHC2JFfVYYLvcJONKaLiub12Xy6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d8Tnm/V9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V2wrVBjw; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d8Tnm/V9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V2wrVBjw"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D98687A0097;
	Mon, 14 Sep 2026 15:53:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 14 Sep 2026 15:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789415610; x=1789502010; bh=DJnlw6WybC
	0anBhk8oSh02m0CdcaJOkmw8+Hzu8x4sc=; b=d8Tnm/V9Fg7jr8dEgoPHPYUqqK
	3CXkbk8UNC2g9MUCi2qypNTPifNDLnCxiaSvfUV2XZuRA3y9M3oteY8NkyHGiX0T
	fFWYl9VA1OxPZQFPp3vPbLUjr6MfpBN8PjX+LsFclXhkPf7XFYP0W2gUl+diFLmg
	rL6KcZMvRyNRaCkepCgkW+gFZBh9ukS5Tq8bZg5HTRaPZeIun6tMoRvqQzoX4Jlv
	ZS2XvD8LKzwX1kef0Yd1+gGlvvWLBge0VRKf+rayvFEdrjqOIgT3MSApYqI+6WhB
	qIrGvt+OtY4qpe8Yf8iVcjdZzelL0bNtaDUiLg6EF/IPcY+91XIv6ikmCYNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789415610; x=1789502010; bh=DJnlw6WybC0anBhk8oSh02m0CdcaJOkmw8+
	Hzu8x4sc=; b=V2wrVBjwVD5cIxmspIMHOwjKctIEkL7wE9KB8DtbNUaOPIBbq2m
	OO2Y8JMxqY48cAKsZupXylCy69W75+jK4mIDkll8jdVxyvuC9pPNBl/jUK+6W/1s
	iYpvmHgzT4r5z9pR8b5yYcX4fqihLevT/QlGFmFHCD1+SYhVD92D+8DBkjSJkGVE
	5wkyknpJba3dGlt+zzt/hLqH46ldbIsHT5+70zTWzGJd6cx0gi/HYI9Svp+c5Opk
	+9mNIWTxs+0RiKZw33e/g/sjajZYVph6Ut1VozeFyxjyJFm2sYeji5VsTIym0q+U
	jNrgyMs+wMnJYLMQ5IxfTPOTcXJyOooUIQA==
X-ME-Sender: <xms:ulCoajeUoVQ71SjyCIvGEcfp9fOmZO3gKnJGE4w29-DbQY7MunTKHg>
    <xme:ulCoas7GGoBg6prjmLMV2ltiMoOZ7UH7M7Rd7v2oT3rGsXDjtngP9RwnTVo8ArTpc
    aZ2impd6mKD7fRMTdPOEQFTLkbu5sYN243zOmpbZX8sTd0g88SxJU4>
X-ME-Received: <xmr:ulCoamUUr8x7nc4_GlKENF3OcMd1w2ha_dLi-abDuud4nsTUZUppzp7ErSNAWJ2kt9fRmeKuYbbf3MoRpQIiS5ZIPWHs4or0Nglu>
X-ME-Proxy-Cause: dmFkZTGWoxP91FiVvpaBXA2T0cR2oMjI1Zm0r3NZPd220w+QngXpDK30KYLnnTObjf8RXB
    TaGTZJbAdC3vzW/FFDwGJmC3G1rCfu2zyqCX/6EaEL4CLPXYgleBmR0Tb+2LfyBkyPXEEl
    YKOuQtqGCOk3ZZGcmdYhR0E4h47EMr8DSqqkOca5jyXeCqCAXYpi1Gc6YtXfAycIlMendn
    RsN50vWEQ+PFBNuIaE6cqTWYdRkxPpyTsusYllsEyu2AJzBN6woUuFqpMQTUqXddNLlBFU
    9TPzTjiftnDbphtFtsaP6JVzMVdm6quv+v126ivq/27QvT+oWT0hvISPx0nBVnBWJQXyLU
    lxVVelw+5PU29DndqBjJjlUQaJ9TQwVz81b2gjEroWwxeBsVfJwbUf60CazTCA6mLylKRO
    Oy9nq1p+mcojSVpBiy46xx+wgzzX2h6wT/qiSPwlhHYLNepCyJWOpQa9Fah4eC4Q/H1Nr2
    hl31NbTlsb6zCmRyrJlbMssfVebF26FLYrnjgaa4hDs4Wn01jW1lpMBjNOXKNe7CeBPxWU
    4ZqBTzoOx4+Oil0toY1EWE1503dS+kBl+NgqJqjSMrMAZE/2sGRPs0HHB0b66NWw4+z9n3
    21Jn6+zb9I2OoVVqmqblVeyb/9rwTaCblJ/og1eEck4jpUIYEAIkLgJI45Yg
X-ME-Proxy: <xmx:ulCoar7c57mSN2SxQeqPo7HHoObQrmnmX3tAn0GqrNGpFpX7KxIW2A>
    <xmx:ulCoahqAqSGO493Z2c8hVTEPXdjC7RBW8QJf_nBPNi9Z6mCvN-3htA>
    <xmx:ulCoaukFa9EkOVOKWMOefZJecFQ0aIulQHyh42km_NdI1pmCur49ig>
    <xmx:ulCoatNQteAqcUN4WfA26Ep3ZSPbjFa3MUwV9Wtbd7GwOveRH_0ZSA>
    <xmx:ulCoasYdQbjr233Dq5BUqVbtGzyayZKbsLqo-wfwxcbtUojGSZzlnlsV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 15:53:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Vsevolod Myalitsin <ub4nal@mail.ru>,  ben.knoble@gmail.com,
  git@vger.kernel.org,  gitster@pobox.net
Subject: Re: [PATCH v4 2/3] advice: introduce advice scoping mechanism
In-Reply-To: <20260914170034.GE32247@peff.net> (Jeff King's message of "Mon,
	14 Sep 2026 13:00:34 -0400")
References: <xmqqcxuketuz.fsf@gitster.g>
	<20260912081246.133514-1-ub4nal@mail.ru> <xmqq8q55863e.fsf@gitster.g>
	<20260914170034.GE32247@peff.net>
Date: Mon, 14 Sep 2026 12:53:28 -0700
Message-ID: <xmqqqziv4nk7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Sun, Sep 13, 2026 at 09:32:37AM -0700, Junio C Hamano wrote:
>
>> > I think that since advice.* was originally assumed to be disabled
>> > globally (as Jeff mentions, he expected it to be set in the user
>> > config), adding "--global" to the hint is a good solution.  It makes
>> > the hint actually cut-and-paste ready while still matching the
>> > original intent.
>> 
>> The original intent was more like "the users are intelligent enough
>> to be able to decide which scope they want to use", I think.  I
>> agree that even with "--global" they can still cut-and-paste and
>> tweak if they wanted to, so I am OK with that move, but my point was
>> it probably is not even needed to mark each ones for which scope
>> they are suggested to be set (iow, we can just change the message to
>> always say "--global" without changing anything else).
>
> Yeah, I was hinting that I think suggesting --global for all advice
> would be fine. It's possible some particular advice would be better set
> within a repo, but I kind of doubt it. And if we do find one, I think it
> would be the exception, and then we could introduce a hint flag for that
> one bit of advice in the other direction. :)

Yup, I love the simplicity of that approach.
