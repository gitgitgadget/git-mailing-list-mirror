Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8378318C31
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 04:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752727038; cv=none; b=izFQ4EeFi9DQZnq6nEXxS78y9ckqyIeuWC4L+Wm7ctiiowiU10NoYMsCNMirHmnDMlk2jZ/tzWk0poKPraBXNCNNEnddpwK68dvImrWfV6pIrB0QFq86U4i0jPER53KoMmxPaPaA52MwY01F56ODHlRJ9ApkgjOQSwMaHMBM5d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752727038; c=relaxed/simple;
	bh=g8hgzTbfsvvqEwrX8Zsle7ZFOjcC77fajCUzeSYEzEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hED+ibTw2yn8dKGmKQI3algz0CIjmDp7oc5e3QHhXnWxII3PRlq5DAKA6Zq2uPaEbUYY8Uc+yA86x2h69b5OI96TWUxfURl6GlVn/QFePulrZxGWGBjDgV7oEWCsTw7QnW1CMi8BhErkq3ETU8+XqHcmiOYl4varL4NCfrqhxCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ESEY/GD7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gOzQiHbj; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ESEY/GD7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gOzQiHbj"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 840CC7A017F;
	Thu, 17 Jul 2025 00:37:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 17 Jul 2025 00:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752727035; x=1752813435; bh=WMwOn3pLMS
	wvAGtn4NGekXhFMluVQJXTILjNyz6InC4=; b=ESEY/GD7Oed9NMRm2h0jlq21Lg
	3XMoAhHBnOz1M8HwgyTkZ6JCh4RGVvzh2nzsSVb8bxP3ArlQkWO2JkotLhurMH7U
	WDcWNMWyJqUiwIHpRCvn2DoDm3bOvO78IIfmNesdXrO8tDQgpiv23S1ac1N/U4wX
	aFzBETBQtb/0sNG+B+qyJRZvDnrcoSi6BJAm+DCvQ8OjNCjvN2pX2bbQZf+9basm
	YbBi6DG/fdH7W0R9AA5j0Oun+RtSHjUeD4bCMGPIca/GRZrQVmdHDzstTPhPQOvL
	JonjE6/GI52py6WZddakIjwuNEv7qi7I55mmLAJY8pdL26+F31BgQkZiho9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752727035; x=1752813435; bh=WMwOn3pLMSwvAGtn4NGekXhFMluVQJXTILj
	Nyz6InC4=; b=gOzQiHbjPxSesdKPdl8kK8MjqT2+ZGI87BFYYRseTYrCbMYDpoI
	15hTKPWg+ZxaZyaX2gI+PsjSWlzGfNL+Hr7esvpdeGvreYgFD0X7Rma1wucMyhdq
	vfdwSQID0JQ37VJKH+7GLquqKftSxlctnk+CiIh2PkKj7szlG95hKALGUqe5FM+D
	7UnHf4/jKKAvL4zuhbhLR068QCQqV+1bD396Uq7f2e1P2K0qQyNhNVdnfSWaSgHb
	7XRF041kgvwYWLfLTIFgM/Xza4AIjJrho4h6JuPwcGYDwsYSV0dcOb/9QRsbNcJb
	yAd+Jcp/f+BHsyONZw4EZB4+fZ/6BD/r0ag==
X-ME-Sender: <xms:-314aNlT7IhlPpCWez8Ita9H72KfTsq_t0x-0qOgjieowROtvj_9Ew>
    <xme:-314aEU8E71kVR3cJNCFS3FqVZvnNaOTPBa343bH8p31aomQ1rrfOQjIcTh_W6szZ
    pUnYcZfA4ER5IIvuw>
X-ME-Received: <xmr:-314aKHRk7SezbCpGB4IlarbmIC7HcvwOmwSx0cbgy0WZG84vPBloK7YiALfqMd-2829yWTLaOC99fRVpY5HPggrjVppXTR7uuX4mvM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehleeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeelgfefteegvedujeethedtjeeuvdeihedtfefftdfhkeeiveehueekheelfffh
    leenucffohhmrghinheprhgvsggrshgvrdhishdpkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhes
    phhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohephihlughhohhmvgdvugdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-314aIekyMScS_c0CZ4WSDS6HBMK9DI6f8_Bu-QFeBHeTnNzBCupHA>
    <xmx:-314aDKxr8_np8bc2WneqJwYU8mquZXr04gHnUfIvHpSOyikfl2DEA>
    <xmx:-314aFGmUlNk1mJhxkvWeR9rj1K64YzrIg2uZvFf7EKTOdi8qAF16w>
    <xmx:-314aODXukNoQXL2Xfcf1j_vu1Blfn9JA1pOoGod07KNS_wi6eIm-w>
    <xmx:-314aGLvi06tfdOaAsoejcMF2_ua1SlHU5HJ5LZtO3fultI9m_8TKxQB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 00:37:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  git@vger.kernel.org,
  j6t@kdbg.org
Subject: Re: [PATCH] pull: add pull.autoStash config option
In-Reply-To: <78DFE806-5DAC-4A90-893B-77F32E393E07@gmail.com> (Lidong Yan's
	message of "Thu, 17 Jul 2025 12:09:48 +0800")
References: <xmqq5xfsdv3w.fsf@gitster.g>
	<20250717030732.75106-1-yldhome2d2@gmail.com>
	<CAPig+cTQ017qGK_Qx04+R_0rCXEOirW+oLEjeaDoCFJiQbnsGw@mail.gmail.com>
	<78DFE806-5DAC-4A90-893B-77F32E393E07@gmail.com>
Date: Wed, 16 Jul 2025 21:37:13 -0700
Message-ID: <xmqqms938mbq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

>>> +pull.autoStash::
>>> +       When true, Git will automatically perform a `git stash` before the
>>> +       operation and then restore the local changes with `git stash pop`
>>> +       after the merge or rebase is complete. This means that you can run
>> 
>> I wonder if you meant "pull" instead of "merge or rebase".
>
> Yes, I think I should also say that pull.autoStash only works if we set pull.rebase.

Is that wise, though?  When pull.rebase is false, shouldn't pull.autostash
pass --autostash to underlying "git merge" instead?

I've written about the interaction among three commands and
autostash in another message several hours ago, so I won't repeat
it.

https://lore.kernel.org/git/xmqq5xfsdv3w.fsf@gitster.g/

