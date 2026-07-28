Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9014A200110
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199406; cv=none; b=ZJhpX1pSX7iSI1RuauB+SrjIdZ3nzmMNi8MpyIfKGCsCA0p8mxtN+s+TuVcHDPjcxBP74FJ+KbcQYujwUAXokeLiwWzX+Lzqb0NEO+YO75u7lAnNBFGHvsLki/ILesNEjtmllTAFOaNtUD70V2dn+Tjqd1AnSVurNNPLMDWjzF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199406; c=relaxed/simple;
	bh=lSv1zrycz1EqLOx7bWkzRYcaqAM9ac/11cWYAcJPuBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KVdVRr6jAN46TtdHXA5ufR5YboNMsnQ4F+mZzQsQ96d8pjazm3BJZkEltdWFBKftXyXZWgzOO1t5ssBVvOIBpdElneqlMQnGZrvqLJUmwoCT5HYYpllmBHMvzsK+9iECtD4VbpStnjMRBrhk2xPrCgNbDO0iLq1ynbujhLYRSJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=r4+LNcCH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=frEd3SOE; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="r4+LNcCH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="frEd3SOE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A1203140005D;
	Mon, 27 Jul 2026 20:43:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 27 Jul 2026 20:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785199403; x=1785285803; bh=z1ViCTTZJp
	6OUrxQQNeSi0dLZRnpBFV0i9gdP4SF8NU=; b=r4+LNcCHlnd5lbd7AZRgHyC3Tp
	YJa9qr7ceKV1R13Y6A+q3/KakDwOpWEt6XrQcp0SLD5kddG4feP65GJZ/ElGXcem
	WPO80RtbR5Lbt2R8ZsgckhhE5WyYK/3F5eL2xZSK4arm1eHPYgBm88sR9YO0YcuI
	tVXpRI87LX3ILDJ5MvUTa06qcM6ZkPgJzx+t2sxYS0HOgfR0U9ilrvaysqFOH2Dg
	Fwxv2Beeo3eoA0f9StLB5aPBfABFcdWg9Tjv6b64CqWeyqqGdK3f7VdENYJusx4p
	Z+ksGWPrigWS0GXwFjo/zeTjfARiZ6Ns5uwj17WbLhuOXAe871Zam2iCHtJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785199403; x=1785285803; bh=z1ViCTTZJp6OUrxQQNeSi0dLZRnpBFV0i9g
	dP4SF8NU=; b=frEd3SOEFbPM/LzQIyuw0g+d/ac6kku6QxFEpy+5RP8cR1Hvv0L
	WxmPy+fciqzL61uazMW+RuWqYC1MwstzgEfhR2IuIoWcBRWoc5QZrF0zxz1c3IBM
	HWNUIUm9IT6aEXr8InIi7VY7sIQU9RRDvaRK4XqOTDWcgiSao8IHAaUGRZSS9tHd
	cxsA96gnWNkGzu+NQb0O4wHURiViDyHoadcweauOM1TC1rfb/A060gZVXIq+L08h
	U+NSCG8ds3aFTGIrxumotr9wdebNtjN0x/VhllsVM9uSWD9KK/Ppj1NluSn+518q
	Zf3Spke84n5CeviIew04Xu6dX8NFdVQI9Bw==
X-ME-Sender: <xms:K_tnamet_WjKuV2IKxsTkcOqonuVS8gTjn3jpd5GRDNodoG6ZWgPHA>
    <xme:K_tnanpWk3zVTmevl3M6VdhphEhsW3sQj1__unlslygKokh-ax55_FboXYNrRPfSo
    3SaNy2I8zFi3oBPxisb0EfMRLOnP7oyIDKPbAYjuLwxC2SL5p2Dxg>
X-ME-Received: <xmr:K_tnak52YyOqvHHgRbsru4ZxZdW9HdQi_bR0D8NIZq8Qz0Iph-30MOSv3qqiFFwadPUsIyIZiYm8EvdJ96qwcoYbynXCjF1c4g>
X-ME-Proxy-Cause: dmFkZTEtYnXsu/UbDGw+IsZ19z+gP425KgzCaztkDnY+WK6yP5jszKCtjuzN7ruevONmjR
    ZCF9cH7nRIPHx6pCEqvsTjDa+2hgAKKqOK6TK/DEEyHv7Hob6Y+vEtLMxXatY2Cw1kM3Tj
    ZB/plgftlOP+u3RnNU58UgKcKmYTvYk5MB3VHArkz0ViGSu5jQmF5LNbQcQwBzZRahfUt8
    ZEB6+EWgsCaNFVZPNiEeFoKWa2dfRFV/BlML/fuyic2GGYuGmtCT/x8v+QmpTuDhSB1kfA
    DPtY2OEZYLE7XLYH2uiW9kgs1LV2aMce2hoZJFfBb/SDm7g0CZ4G6fBODV0cMkxQsy3GVG
    zO0Wj0QxecjZRxRFjBcmD6LcPi/XE2p5g+pwgJ5UeH/PybtB8+IjuTqZuPyqBft5cJgpuC
    OBvMLCM702rVPucO4+aZvPopVLgR3fV3jvyOuBfsnBtVgyokR5rbBQBDG2HfRFIwWRG/+r
    oEEWSAGpXQ8i/FKeq8uLCp1mqCAxviHpuiQjBpJZY59JQBBDj5+F1P0wGFY/4g5CDlBb93
    W7eaauXvNX83l9qiBQ/bZmza77ecmfgfFn7LrW+9TVxfTCcfPbm9nKLXL84CdGvBtRLCiS
    /37gGmAgIILahf2bLsGMuML7QGdgjxtt8NDxGvCqttthkX+BRE3u4AzOcy7A
X-ME-Proxy: <xmx:K_tnatr2VQrqVvlwQDCq0HSHl7I1gkXgvWX3wxzETqIWC4vpdBkYxA>
    <xmx:K_tnamhyu6kxaPPftRKRQPfwWycBRORaAZSJ1SXVLOg6hZBX7Axyjw>
    <xmx:K_tnanKnCmBJUKkFszVGeI999kKa6JpqF3eOAbgSSSy60q91lD-3dw>
    <xmx:K_tnamDB5B10PMIu9HdqlYXpI74spUOhbsduBpjFB3NOwXSfauu6ZQ>
    <xmx:K_tnagYR35dVzC93EvoXRis1OxZ1FoLZpORK4IqBuPmyaqx4-O6eh4E7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 20:43:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff-lib: skip paths outside prefix in oneway_diff()
In-Reply-To: <20260727093912.GA591426@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 27 Jul 2026 05:39:12 -0400")
References: <20260726084550.GC2366012@coredump.intra.peff.net>
	<20260726084705.GB3529698@coredump.intra.peff.net>
	<20260727093912.GA591426@coredump.intra.peff.net>
Date: Mon, 27 Jul 2026 17:43:21 -0700
Message-ID: <xmqq4ihkgd06.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> --- a/diff-lib.c
>> +++ b/diff-lib.c
>> @@ -528,6 +528,11 @@ static int oneway_diff(const struct cache_entry * const *src,
>>  	if (tree == o->df_conflict_entry)
>>  		tree = NULL;
>>  
>> +	if (revs->diffopt.prefix &&
>> +	    strncmp((idx ? idx : tree)->name, revs->diffopt.prefix,
>> +		    revs->diffopt.prefix_length))
>> +		return 0;
>> +
>
> BTW, Coverity complains here that "tree" could be NULL (because we set
> it that way in the lines above due to a D/F conflict).
>
> I _think_ it is fine. We only look at "tree" if idx is NULL, and I think
> idx is only NULL when we have a deletion. So that implies either:
>
>   1. unpack_trees() passed us both entries as NULL, which doesn't make
>      sense. There was no entry to delete!
>
>   2. We set tree to NULL due to a D/F conflict. But a conflict with
>      what? There is nothing at the path in the index to conflict.
>
> So AFAICT this is OK and it's just a false positive from Coverity
> (though an understandable one; the semantics of the relationship between
> "idx" and "tree" are not represented in the code).

Yeah, I agree with all of the above.

> Possibly adding:
>
>   if (!idx && !tree)
> 	BUG("oneway diff with no endpoints");
>
> would help static analysis, but I don't know if that makes things more
> or less clear to a human.

We could help humans that the BUG is not expected to fire and only
to help static analysis by a crafted message, perhaps?

   if (!idx && !tree)
 	BUG("Hey, Coverity, this does not happen");

?
