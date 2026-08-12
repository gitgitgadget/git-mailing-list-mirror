Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E595B412C15
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786574128; cv=none; b=aJ1VT19DvIXsm9WZCiZ0unXpBm/eAFSa5wtxa8kn9VuNcHk3Hth8op4gQFlOzjt6aYxsmMT77k/zfdcMy+nDTKgY4FSMTlj5b6bvGCHRK6wJPlKikUwtFWAndgDLKt6HdoUuALLXnYGydHBHdPG3D1npby9rUrecstNQR2YLjDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786574128; c=relaxed/simple;
	bh=PAPlruMP9aDYhFVpFLtPjKZ/PwmM3/Qr2EFMdu0Z290=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZVWDXlBBvgtiM7Q2QhlJIrPBbI+L1B4bAA3RLh+OBPp2bnR3Mb1VDHt961gwKHGpP2I6LloDDnCAF3RvtolShrigZYjBMbde2NLaJwWuNrKNs70LFQxUsWtq0WmqaeB6Aauw4VDvgaDk6cmfM8LFiGIhk7mqofDJWVuspZwW+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cbGVpZtV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iz5miEPL; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cbGVpZtV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iz5miEPL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 35F9A1D001A8;
	Wed, 12 Aug 2026 18:35:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 12 Aug 2026 18:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786574125; x=1786660525; bh=MSSNnN0IVR
	mQCIDM9qYdVAQ4OOGPFpIZ8iN2kbZV8SQ=; b=cbGVpZtVEwC4Jq2sDUQFpOphD3
	GMA+LOxdhQxpjuThskyKm3Dwqt9fP+UC2fr7TH6g8XmbFu9yLld4haBylWPXrAxh
	yMWMXdflmFKyZLkCDGyphOHMnV3MgNJ3VNz03MiYl/pWV+Zkpuzric2Q9+CPOlUn
	FVcntCp5M5fzb/sRoixQVXkuqocC4PtpHepIN6pEnz9Yy+dNTDivG09h97ecvim8
	OYiaVF8g2VX7izk9/7/ZZr3jnYU7u1oEZw/7ygv2z7f9123wztPoEp3+yXzr3Kzl
	5jTlit8zkJ4WkZXq0AW3ENLLhPIWygY9JGN1x38aSCjC1UwLMCatq12vXG5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786574125; x=1786660525; bh=MSSNnN0IVRmQCIDM9qYdVAQ4OOGPFpIZ8iN
	2kbZV8SQ=; b=Iz5miEPLwlcgAQkOvC5axJ2IGfZD+DVFtuU1QeKricIdAr1+Mv6
	/xRSoM1YWqoM/FpjAvPlEzd5aAU8GcrDwzBCybrQXOBihYR0bnC4dtdOg45k9nAx
	rXlXeObVR79/Y/d1HwZfwU5zzrcmE3NH0H4iu7Fs4ti/glNfM9ewCt7bMleVYM4I
	F4/4btVczRq1dwUBDykWrxVxuQifUkkKOtcFg7jaJmoBth3EuDMsx1n3XLulsl9c
	7IsY7KSlu8Tz2W/ECYHHJUmM3qjoNIetvZsKEK5w47E+zB8/hlTb0aQBnrU89ko4
	uoY7Lgkc8ibvOBpf6qDU3DTMpbQZOf/mTuQ==
X-ME-Sender: <xms:LPV8atikyeaARnC6h_j8_SkisCQvE1g4Hlqw1ybg6ew-oDpiPpF-jQ>
    <xme:LPV8apAARBgbOeEv78poYCLCq84v-dn_uWwUKE_8mLkwzfgKaOnqFOGkZpHicmmcu
    YTv8HKYMavBqUrADZ5prhGCqKAR6egreku9q2oTgFRyXRdtnO9fWqE>
X-ME-Received: <xmr:LPV8aiGrH0BUJu-hYXOuTUoyPrHTyu37q0aIyfhmMS9okU8PnelsfMJRJ5E9Pku6kPydQKaZrXzEHt8d6AcdtgVtcOX53yRfMw>
X-ME-Proxy-Cause: dmFkZTG23VWlKIzduh0g0BWZeTVWQyZ4/LfJcAlIyYV9SZLZ8GmGDEkTs9P7i4Z9odvTJx
    xF9AsOrCiXbLNFMdiV6jMjXF+X7T/nlFJx8QFepw85skB2492AT0Or4LDwakiioqh+pVcq
    mv1Ew5lGID3nfyD7oRCeWS6hN+6+Z2MsGc3ICHtxcx1oDTpT7zO5vIWpwNlJ6teeamzx5v
    r5LUPtpGrqL1zH9r6joPT0SnJgMCxNUXOmllcAu5hXv5Rx2MoMe+CIzkt5KrW4XusgP5Vd
    Mj27Bku9ULeOOaPUONz7dIzHun2Wsxrg0eJk27HgrCm18nlG9gpPxNehbWna6pVrWAueg1
    1ZYhj9IZy1LuJFlQ5FnuYwCVPUtR/aImvhUY8Hy9l/CmkossAv5kTkWwYhcHTTyFtq7UJ7
    X+zt73Nqrg79Gv0hd63t2PZvlu2TfavdV0nlk4JCPZaeipdhet8+3V4yncfLiaT9SDYtU/
    /gT9l9pNYHMaPaygrmpiTmKbdx+5zXd+GnS2d6JMF5VmjGjkG0EK7nCbAtfCGSSwdkZ3Z+
    GH0/HwEQFBOmT9Qd1HWKmymkdHXizjGPRik0GvBTsJX3eAZsy/ypDB1ksKOOt3JQKxR3Y/
    MoxQOyHxPhivYWwZo7fq49U/Au2UL95O+lZKX+T3vAlhT/O3lYHlG11eR5hQ
X-ME-Proxy: <xmx:LPV8ahKRx_qN1M4YBMaKyvggSyuSSzJOeStHpOJMigyMaoESVEbUlQ>
    <xmx:LPV8amkmKBl-t35gM8B0hEHt41W6MD5nlEi3_tBJRKXMl0AFdHbVwQ>
    <xmx:LPV8apT-_I1Px0GFMjw6outDrSqYd0hJcwa60HzoOb9OxmxQpJFBsw>
    <xmx:LPV8aoJwzFEspBUPUdUrbw4pATL4vLWt7SBRWwPJ1-r-Di9S3ncL8Q>
    <xmx:LfV8aqTCRroHuHIPIxxWP1MkWfTkk0Lilsb0WwHmkgOyT5w0gBm1zAyP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 18:35:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: Can we do better than "git checkout/add -p"
In-Reply-To: <20260812214403.GD152730@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 12 Aug 2026 17:44:03 -0400")
References: <xmqq8q6ih924.fsf@gitster.g>
	<21db84ba-3894-23e9-9f17-ceeafb1990c2@gmx.de>
	<20260812214403.GD152730@coredump.intra.peff.net>
Date: Wed, 12 Aug 2026 15:35:23 -0700
Message-ID: <xmqqo6f7ufv8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I see I am quoted in one of them as "it's a little weird for add -p to
> change the working tree", but I want to make clear that I _don't_ oppose
> a feature like this. I think it would be super useful. We may find a way
> to avoid that "weird" property (e.g., by putting the "combined"
> stash/add mode under a different command's "-p"), or we may just accept
> it.

I guess our messages crossed ;-)  I do agree that it would be very
nice to have a feature like this.
