Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF25370AE6
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273882; cv=none; b=c28eHEN4uhGrOuiH1R+deaSonJpUbFfgDXZZcEuiXFaZZN7uAYflKBqy5Q4EFKurNmN45QKrH4dVodZuSGG0CrLEfEtlPIEdi8EiNbrpCccMvqxjlCRE8VEZHxwIj6LeD0WIA/x8zrDDcwaw32rBpMlHsgpe5wM9LC6CEzBuW48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273882; c=relaxed/simple;
	bh=athsazGjUx1Trf13e2RoQ8WEaaGywq4IlrI1j4hBuzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lk4FWrCbZV7ynron+S1bMNbCOhqr70YscRNJa6H1f6JQA4IDozfU2UY5szQ1dZTJzle5YngUf5kJb88TmI67tPPtwqD2aHz61T3EyUZ2Gr8vkMiyMbDPICZrsFqH2atgxzD0u1B5DtEIoDNhHHILgR5XKDa8/3Xg7JbQX0Dzf6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=u6mkh4+q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gAjDbbKk; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="u6mkh4+q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gAjDbbKk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6D8BC14000F1;
	Thu, 24 Sep 2026 14:17:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 24 Sep 2026 14:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790273879; x=1790360279; bh=7bu5kMAljc
	yZbyHKjDqQpnwIHyiQQGY46KitzEyebAQ=; b=u6mkh4+qdok7mpfFYJo/7W2QSe
	mKlS4xk+fAXpFamJuJM5YLWJ3GPuhPPEAnE4P5mZyDkPVDEk9VLmkx52x3RsdJzq
	D4dJNoXWyBSemOsMCevlFT77h1zXrw5n37PKQcEHwFZ7iTI5beWm96+noMTjpNG1
	koJ/lY2t96F4v9fl9Gzy5pCPlzsXK29WJuwN1+OrFl6ameNP5H7SK/aEzKVUu3+h
	8D8OkNQRFZoddfn6+WXTMCw8w1rB4sPeRoJnSVfix3kegePNwSYPTAVHSdeIqD2x
	q3CiIb0YhHzhAIILXMPMKEdkk3W2MNN7o67jQxTBKyC21rYB/yIaLAV6hq4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790273879; x=1790360279; bh=7bu5kMAljcyZbyHKjDqQpnwIHyiQQGY46Ki
	tzEyebAQ=; b=gAjDbbKkAmnTZ3htpLcFQfeRANCJu1TaQuT05GqWcJDSdeYF5+x
	y8CN3uGBiQLAropCZXzljFFAFjOggeiC2E7oFAVsSXQIPaJpAWYpybJCrP4FVTO9
	btpWl3ylhF3iU5CyXHyZxeEL4KGgJ84llfq25oPrpCdRDyAVJoeStH0Csg/cHNkM
	qdZpQ6JUaxxfAmI71VXp9t6Je/M0mV8iNCE78L56U+GqI0XC03HiYcVStSol8Qj2
	t9RbwHrIYXwkjIdiE3NHbOFASV6He3o5kXayT59nahBe0eCrt07K3kXbFicIWLIC
	xHr4dnq7g87Cip5dc9mR2Bwwbl97vgHJjfQ==
X-ME-Sender: <xms:V2m1anxQQ-lVk2zv3gtVNXz8qURy9pM0sWac228U_K75zx0f02Ed6g>
    <xme:V2m1amKTdaGzArVnqum1ucKaCuHqOPLcMaiy1xkMVBQ1AFLMnzu00P5__i74TiMz2
    Uk2xTVuCw-E3DjdxaRDNG3TlfC5lhmZ6MS4vw9--O_FJTBflZDqMw>
X-ME-Received: <xmr:V2m1appf5N5Tfjwrw_VgXdT1jTIiQLy1Lz8jmZGo9e8xrlpEzCXrzek5oa4O90iqKGWzVx5zbUIe2u4TyUSyKVzDbn7ZbrnktNNS>
X-ME-Proxy-Cause: dmFkZTFfxx/ggXNQyuF5FP1wxBewWEnBrEkPSsV4lCXrCpo6X1qar3K3K9egehYPcLOiOX
    11jhuDZaHMTl8hzrOR9ePhxd/iuDe/bjI7FVln39yx690tKdl/HcU9msfink1nh8ZM0ds9
    O1xLJwca5GU9lgsN7+or6kAG33YjaMOIh23+u37uR2iCVy8b7PykKP6wH0fP4jOgxfQaba
    qdmoGu22iiEpy8Hsfv/QrZQJp586dPkjs4C6jm0SKoqAZ/jNoc8WRoSyZ/nx8k3v4f1jiT
    SUpn3lC8d4MJUZAorwxH4dwADKRf+nIoun2mIskq5r0V7EG/JjarMAuDugF17nRBYgVYBW
    fP4IuzrpSeWBlzt+cTnpWc0RxMeMEsPp/tnUKq8aDtsADhETnHKatpfanupyMfTi850eoZ
    q193IjlEz5/sqK+GoFkMmKOv5AvtKTuGhIgQzV2Xsx2s7YWXIIpAu7wF5cdIRJ1sMNCu4m
    QPF7dm05KtwYLlziga/804FL045z4FWGn7lbKtPW6d7z5yhRFiMzPT+P3IA4QfGh7ztwE6
    of4R6m3Fihiyo3ri0OKwuRptblz952NRuBY6fzhEJDDE1VpkSAJfY9aUBTse6NFClVNJN0
    cH3w8gkS+JtKLWDasDVdknMt0WibbzqLe436s9QphoeMfsNvAk6dFtnJGxvA
X-ME-Proxy: <xmx:V2m1atI6ukjBwOa9evsbdWBXa5pBjKhuX0qhJv_Cb7FstowIjru_zA>
    <xmx:V2m1amR00dJeqNPkGa48NKbAoEZZWr89ctEcHjuM23UtgR2_c8FfMA>
    <xmx:V2m1akvA7PnjqFBQCjHlSqH81s4UYjTbSvhkZzax3F_RkIyi6TPYCg>
    <xmx:V2m1avaJ7sPgUkGYr6NdjH6E0sAbet8zFMF2hBPnLkyAS-TYEx82mw>
    <xmx:V2m1apoH1sdNLtGC8Nefnzbg6t3yCK4MpFzVER4i-U22wXf71LSqiT_W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 14:17:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Jeff King" <peff@peff.net>,  "Julia Evans" <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] doc: add more AsciiDoc cross-references
In-Reply-To: <31577b6f-79b6-456f-9ecd-d1a3df6209e2@app.fastmail.com> (Julia
	Evans's message of "Thu, 24 Sep 2026 13:22:49 -0400")
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
	<xmqq4ifhdon2.fsf@gitster.g>
	<665e8f8d-7bde-449b-a390-10875135cba2@app.fastmail.com>
	<20260923214038.GA49087@coredump.intra.peff.net>
	<63520573-c8a7-41bd-aaeb-bfc2b5e43856@app.fastmail.com>
	<xmqqse2y371a.fsf@gitster.g>
	<31577b6f-79b6-456f-9ecd-d1a3df6209e2@app.fastmail.com>
Date: Thu, 24 Sep 2026 11:17:57 -0700
Message-ID: <xmqq4ife344q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>> To see if I understand correctly, let me rephrase the second
>> paragraph a bit (not as an attempt to offer an improvement; by
>> restating the above differently while expressing what I take to be
>> the same thing, we will see whether I misunderstood what you wrote
>> if my version ends up saying what you did not intend), as I found it
>> somewhat puzzling.
>>
>>     The short form <<EXAMPLES>> uses EXAMPLES as both the link
>>     target (which is not shown to the end user except in the
>>     browser's location bar when the link is visited) and the
>>     clickable text.  In different parts of the document, however,
>>     the text in HTML may need to be rendered as "EXAMPLES" or
>>     [EXAMPLES], which can be achieved by using the
>>     <<EXAMPLES,"EXAMPLES">> or <<EXAMPLES,[EXAMPLES]>> form.  For
>>     consistency, always use the longer form, even when there are no
>>     such typesetting constraints.
>
> I meant something different, let me try again (with Peff's corrections as well):
>
>     The reason for using the more verbose <<EXAMPLES,EXAMPLES>>
>     (instead of <<EXAMPLES>>) is that in some cases, <<EXAMPLES>> is
>     rendered as `the section called "EXAMPLES"` or `[EXAMPLES]`.
>     <<EXAMPLES,EXAMPLES>> is rendered as just `EXAMPLES`, which gives us
>     more control over the output.
>
> ("in some cases" is code for "I still don't fully understand
> exactly when each one happens and why")

I see.  I think I understand now.

In your example, "leaving it vanilla without any extra adornment" is
the control you want to gain by using the two-argument form, while in
the version that shows my (mis)understanding, it is "you can mark up
the string that is shown in any way you want".

Either way, the shorthand form forces you to leave the rendering to
the toolchain, but the two-argument form gives you more control over
how the text is rendered.

Thanks.
