Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A1B52120D
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271925; cv=none; b=CnRs0uhsPjfZZbEtDcUXB1HIqboXLBhkTnYQ7DrbuAwc4EAWk4cn4TDEhHgwxAo9HQqc6bmBm61Acex4LB/Njngfxp99f8T0fav+oP5gHU+0ormK3l7ngoGa560MgLIs+SLETPwquoeoP2T1bv2zKbXiifGQJ6LyrsjHiW60xBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271925; c=relaxed/simple;
	bh=I+hcPZhnZULvnXayQ9LyY06IT0B6Ndt6V4ObMBNKlkc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TIkyhc7Ox4aTa+T2gepH+jLq1RlMJaT+KygP0U+fIO5tvZCbXbRRlZ+r/X6Y/KKaYvEV5lmaonzZdgbeGCpeOAvPaZ2audOBi7gve5uJ4/sasIejSmBaHjaR3dIPgPaBCl6hBOKRFIdwmUK3HSc+6VRfUnLz4Ppk76pTMGU014U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Hje3KJS8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F1BAibYS; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hje3KJS8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F1BAibYS"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EF9D81400127;
	Thu, 24 Sep 2026 13:45:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 24 Sep 2026 13:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790271922; x=1790358322; bh=jELrKO+9cP
	eUFVR9b3WvoN8MDNmZiydh8Bn3ZMV5MVo=; b=Hje3KJS8UpJKrmqgHSLVJsPWMo
	LiSMFjCBi71M+uGQXDil/4GGRdW5oxcvLlGIBd8GyyZtftzdOaidkk5gC/lEA4KI
	yiR1h02lpYVFFb0U3dPgU9F2cjnPTEzfLbly16ckrvgCGzGDlSFbeBZJCUEbC+Ga
	yyRV4eu5piUWx8ERsvKzhR1BTZaRp5wESGISpSz5voeESca+4Z5Fy7+Qpoj2ZY/L
	UcYQ5HuEWYX6N5cXoqwYteCj610yOHOiW6J5fZXr0XIus4+cCwHFz2JDHqOQ3ecr
	SoqDG0IaNUjad058sVeXdmmjgCLTEdhsuoa7wDgUG8yFI95yTuJTM/59Sf9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790271922; x=1790358322; bh=jELrKO+9cPeUFVR9b3WvoN8MDNmZiydh8Bn
	3ZMV5MVo=; b=F1BAibYSgD2HhWOCk2/Pet9Qvqe4Cj3RsNorf2KXxX9+tLiGgUF
	dZm/QjSD9yWZR6WXpvdGhKNhkPpXBSXuU8ZEZAWnI8pYfzFWUi6FUf0rAnCZlbdW
	DA4JK6siDCiA9eyExsVZ80iFonGlMmn7WRepoS6tnw94dPEgsJnuYgivA+6esfM5
	krFlmNeRvQ1rNcupgndu8Z5CRXQuj6qQD8gYsZshs9EQziGRFQ0Hf8EOK7WLGmLU
	0hQvd4lUPr7zYuRWvbhRQqHtQ6XayH3Lukwr/Ne07GqBSxdtOvhS/kZrnG+ZFgdk
	N2jux9pTzXaN9dm3slDUvfJbYfecQHYbPgg==
X-ME-Sender: <xms:smG1ajm4tPtQqr-bc2P5qh1yWK5iOyyUC9wBRMdnOCRlpzyKsYIrDw>
    <xme:smG1avQAxRQo7khUK8m0B63D4xs9mLdZGVkIyDZZ84zAv9ARjJ_4y5x9V_s-6SZvP
    2cSqM5DqUUTRtFzh4EMkUWgU2Qxjbb6Vravrz_XYzbpC_eKGy0Miw>
X-ME-Received: <xmr:smG1aqEPmjOUecUc_gw7Lb2YHj3ee1t4uujN8pEtg-87df6kNc3SAooF2LWF21R_t7jzlvCmu6PQfhOEACqR8eOkzkfBHyZPm0vS>
X-ME-Proxy-Cause: dmFkZTGqzIiYjBAz4AUggdCrWQERdsVrxjbQnsOn8YdJE5h7B7omooiXpR/53ivPWIVfLb
    /SgydiVmfLCsEL4UIZFRNpG+eNK2neK05bikaRQ6kOGu2plQIE+Z/Y8EXSR1hi4MyJlH5g
    qN0fFNuhn+joKwuL4C1nEm9sCprvnqZ8zfgGcGGfLvUjQTFyN5bJCjQG8FEoGRRGB9zQVD
    tW0xKz1xxkJDWc5oSRhmaMnsP1ChZXOCVdhbW6aiZLeOIPvqnHJ++QML3sDLD1nHXcV7zt
    iMF6BC+5sSXiKhzO8btZbG8Pe3bQbuuhcf+/OLGYK8wvSsGyjNvPBnFAflEMBPOrW30Dq0
    RmCVFmz/4cVnWKvKV5GB7waRobVoyxaqpBHS4iuDFqIpk+rcsOFCM9uJ1NP3n1R0w9nzxS
    lWjR/1pE7R7BCPscmLCxWQPzBed2rwI5B4b5KMMOkIyQtxM5+IILuB9tKWoNQrk8eD0SUB
    YCwdn/J1X5hJ85jsXz9D5QZlq2/pEY4jYZ+yphETJhD2oh8Nax/abTX2iYcasNQs1ueOvk
    h2knLRJzgPFsswXQ1SPm9vgM2tts9Q59k8F4UvoSawPsI/h+xMNgQtKk2a+PdIlCNVtxD9
    xoXhN8J7AvaSAI9izCwx9w/HzSShyD7XYvVPFfVlhYUCEO5kNSSD22aWLIiA
X-ME-Proxy: <xmx:smG1asEchc-kqDu8uLzGIdqxI2E5kOMM4PopWEQCWg4FkSgCuV6KFQ>
    <xmx:smG1agTDnmI6MdYDlCjoTGQIXCG_Xsr4Yc4j6beq7QjpJ7eMAR61-Q>
    <xmx:smG1alIXh-5iIPbSDssiCrp4-nsVKU3lcHXsXJAUt35ZRmlowu4UGA>
    <xmx:smG1ajae3oimpv8q7w0-5TfB795Gm7nS6iBiAHLWZrrb9bfhYxS52Q>
    <xmx:smG1apQAJfLkJaTDGsOL9mxRbxJ6t_mODKB1XT3kXQ3YoajL6OOFSnHr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 13:45:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Pushkar Singh
 <pushkarkumarsingh1970@gmail.com>,  git@vger.kernel.org,
  r.norouzi@proton.me
Subject: Re: [PATCH v2] reflog: fix default expiry periods
In-Reply-To: <20260924154659.GA736248@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 24 Sep 2026 11:46:59 -0400")
References: <20260922165433.591551-2-pushkarkumarsingh1970@gmail.com>
	<20260923102140.25475-2-pushkarkumarsingh1970@gmail.com>
	<xmqqpky3ahvo.fsf@gitster.g> <arUvtE67n5_MFM4C@pks.im>
	<20260924154659.GA736248@coredump.intra.peff.net>
Date: Thu, 24 Sep 2026 10:45:21 -0700
Message-ID: <xmqqecei35n2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Sep 24, 2026 at 04:12:04PM +0200, Patrick Steinhardt wrote:
>
>> > >  #define REFLOG_EXPIRE_OPTIONS_INIT(now) { \
>> > > -	.default_expire_total = now - 30 * 24 * 3600, \
>> > > -	.default_expire_unreachable = now - 90 * 24 * 3600, \
>> > > +	.default_expire_total = now - 90 * 24 * 3600, \
>> > > +	.default_expire_unreachable = now - 30 * 24 * 3600, \
>> > >  }
>> > 
>> > and the fix is very straight-forward.
>> 
>> Is this something that we want to fast-track for Git 2.56?
>
> The breakage was in v2.50.0, so it is not a new regression. OTOH it
> seems quite obvious and low-risk. I'd be OK either way.

Yeah, I didn't know the breakage was that old.  Perhaps not many
people are paying attention to reflog expiration?

